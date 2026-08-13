Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B38C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25D710F351;
	Thu, 13 Aug 2026 13:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QZmvv6Ms";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C08E10F351
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:54:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D97F41859;
 Thu, 13 Aug 2026 13:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA18E1F000E9;
 Thu, 13 Aug 2026 13:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786629290;
 bh=f+wXODdV6jFXO19uKyklvTfiJHWUQPf4Mys+WIwJgDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QZmvv6MsI1IrJUfxTjZF8d8IGD+crG6UNUgxsF4g4Npgdqic/Il/EgGzaDPaz1PcS
 POlN2wiip886N6bQZDbap6vCAyxzQS45u/IY/s/0cVktmzxcnzgcACSieO9ybGlM7y
 tXRVsBaRUhRfWH1GmOx5WpuKu8U4nvN3jrE19+MrmiqS3pYHe6ZDrRCBK+0oKxwpLH
 /lVg7a/Pvt9JLWcATeu+MiSHcphSowtBeLd1X/hCNRa4fkuOEceW85fm/MnTceRwwn
 ba7fvGLlvfSSHzCkFKBb9xKwnb3UVaZF2V5seR1oeuCJgJU3Or6QaLGwPE9RhxVU4P
 +mimsatbQUr5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/svm: drain fault handler before freeing svmm
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com>
References: <20260813-nouveau-svm-svmm-uaf-v1-1-2d3112dea734@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:54:50 +0000
Message-Id: <20260813135450.BA18E1F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a NULL pointer dereference and a potential Us=
e-After-Free (UAF) in `nouveau_svmm_fini()` during device teardown by uncon=
ditionally accessing `drm->svm`.

Pre-existing issues:
- [High] Preexisting NULL pointer dereference in `nouveau_svmm_part()` duri=
ng device teardown due to premature freeing of `drm->svm`.
--

--- Patch [1]: [PATCH] drm/nouveau/svm: drain fault handler before freeing =
svmm ---
commit 31089477636a1a0ac80812429a50405db650eb3a
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau/svm: drain fault handler before freeing svmm

This patch drains the SVM fault handler in nouveau_svmm_fini() before
freeing the svmm. It flushes the work on the fault buffer to ensure no
in-flight references to the svmm remain, preventing a potential
use-after-free during client file close.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index dcc92131488ea..01191b126be53 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_svm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -304,6 +304,17 @@ nouveau_svmm_fini(struct nouveau_svmm **psvmm)
>  {
>  	struct nouveau_svmm *svmm =3D *psvmm;
>  	if (svmm) {
> +		struct nouveau_svm *svm =3D svmm->vmm->cli->drm->svm;
> +
> +		/* The fault handler caches svmm pointers looked up under
> +		 * svm->mutex and then dereferences them after dropping it,
> +		 * across blocking faults.  The instance has already been
> +		 * unlinked (nouveau_svmm_part), so no new fault can resolve to
> +		 * this svmm; drain the handler to release any in-flight
> +		 * reference before the svmm is freed.
> +		 */
> +		flush_work(&svm->buffer[0].work);

[Severity: High]
Can `svm` be NULL here during device teardown?

During device removal, `nouveau_drm_device_fini()` is called, which
establishes this teardown order:

nouveau_drm_device_fini() {
    ...
    nouveau_svm_fini(drm); // Frees drm->svm and sets it to NULL
    ...
    mutex_lock(&drm->clients_lock);
    list_for_each_entry_safe(cli, temp_cli, &drm->clients, head) {
        ...
        nouveau_cli_fini(cli); // Cascades to nouveau_svmm_fini()
    }
}

If a client is still open during device removal, will this unconditionally
dereference a NULL `svm` pointer when calling `flush_work()`?

Additionally, because there is no locking to synchronize
`nouveau_svm_fini(drm)` with a concurrent user-initiated file close, could
a file close operation racing with device removal encounter a use-after-free
when accessing `drm->svm` here?

[Severity: High]
This is a pre-existing issue, but does `nouveau_svmm_part()` suffer from
a similar teardown sequence problem?

During `nouveau_drm_device_fini()`, after `drm->svm` is destroyed,
`nouveau_abi16_fini()` deletes channels via `nouveau_channel_del()`.
This eventually calls `nouveau_svmm_part()`:

nouveau_svmm_part() {
    ...
    mutex_lock(&svmm->vmm->cli->drm->svm->mutex);
    ...
}

Will this cause a NULL pointer dereference on `drm->svm->mutex` if the
device is unplugged while a client has an active SVM channel?

>  		mutex_lock(&svmm->mutex);
>  		svmm->vmm =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-nouveau-sv=
m-svmm-uaf-v1-1-2d3112dea734@gmail.com?part=3D1
