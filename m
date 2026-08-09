Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE35CC5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 09:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB06910E12B;
	Sun,  9 Aug 2026 09:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dEF6s7YI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5695410E12B
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 09:19:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9034600B1;
 Sun,  9 Aug 2026 09:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2971F00A3A;
 Sun,  9 Aug 2026 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786267188;
 bh=1GUgyTiJyvq4zZVmFSoazK5CqyxD0DeiMolCvFee+PE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dEF6s7YI30Re1g1F433CrtbIKm5dd8lUrrJvLNIyq0Ox8LwUjC401AJbT3CNHuG/Z
 DkVUuwOHDQL3uyUK10piuHlPMBB3fKan0G/z/eczopqkrFTsgJ8Aq/ksT4QiPcWvG5
 9MpRtgVieEJHA9Z2u2pTHr5U++zTAVFbL8YqT2N1HiTNGXMO22lJy/88IOaaLXbCZo
 DdQFPYQrbC8czExp7qRuu/8628pO2fteKMJkFGXTqkgSawwuzkjVgsdiT5gEijAwiT
 4AOLjM776O/oG5H0DtZ5hlLP5u9bmTu2hWv//Rt1vYEXp7xMy1tiCGkoOry7EXS9bB
 OS86Tsv3AdUQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260809084735.9743-5-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
 <20260809084735.9743-5-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 09:19:47 +0000
Message-Id: <20260809091948.4F2971F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The added NULL check for the `banks` parameter is dead code and int=
roduces unnecessary branching because the parameter is structurally guarant=
eed to never be NULL.
- [Low] The `lock` member referenced in `remove_aca_handle()` does not exis=
t in `struct aca_handle_manager`, resulting in a compilation failure.

Pre-existing issues:
- [High] Concurrent traversal and modification of `mgr->list` without holdi=
ng `mgr->lock` on the reader side causes a severe data race.
--

--- Patch [4]: [PATCH v4 4/6] drm/amdgpu/aca: Add missing NULL check for ba=
nks parameter in aca_banks_add_bank ---
commit 613bad660f79f7955828e89d88180e64def84678
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

drm/amdgpu/aca: Add missing NULL check for banks parameter in aca_banks_add=
_bank
   =20
aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_aca.c
> index c35f6be2ef774..dcddeb3816285 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
> @@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, =
struct aca_bank *bank)
>  {
>  	struct aca_bank_node *node;
> =20
> -	if (!bank)
> +	if (!banks || !bank)

[Severity: Low]
Is this NULL check for banks necessary?

The parameter banks in aca_banks_add_bank() is always the address of a local
stack variable (&banks or &de_banks) in all of its calling paths (e.g., from
aca_banks_update() and aca_banks_generate_cper()), which means it can never
be NULL. Does this introduce unnecessary dead code and branching?

>  		return -EINVAL;
> =20
>  	node =3D kvzalloc_obj(*node);

[ ... ]


There are also a couple of other issues in this area related to the aca
handle list:

[Severity: Low]
Can this code compile successfully?

The lock member referenced in remove_aca_handle() does not exist in
struct aca_handle_manager:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h:
struct aca_handle_manager {
	struct list_head list;
	int nr_handles;
};

Attempting to reference mgr->lock here:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:remove_aca_handle() {
    ...
	mutex_lock(&mgr->lock);
	list_del_init(&handle->node);
	mgr->nr_handles--;
	mutex_unlock(&mgr->lock);
    ...
}

appears to result in a compilation failure since lock is not defined in the
struct.


[Severity: High]
This isn't a bug introduced by this patch, but there is an explicit attempt
to fix it here. Could this concurrent traversal cause a data race?

While the writer side in remove_aca_handle() attempts to use mgr->lock:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:remove_aca_handle() {
    ...
	mutex_lock(&mgr->lock);
	list_del_init(&handle->node);
	mgr->nr_handles--;
	mutex_unlock(&mgr->lock);
    ...
}

The reader side traverses mgr->list without holding any lock or using RCU
primitives:

drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c:aca_dispatch_bank() {
    ...
	if (list_empty(&mgr->list))
		return 0;

	list_for_each_entry(handle, &mgr->list, node) {
		if (!aca_bank_is_valid(handle, bank, type))
			continue;
    ...
}

If a background RAS query or sysfs read (which calls aca_dispatch_bank())
traverses mgr->list while remove_aca_handle() concurrently unlinks and frees
a node during teardown, could this lead to a use-after-free or list
corruption and a kernel panic? The fix appears incomplete because it only
syntactically locks the writer side without adding synchronization to the
reader side.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809084735.9743=
-1-sreekuttan2156239@gmail.com?part=3D4
