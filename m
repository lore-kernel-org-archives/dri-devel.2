Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA71C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C927910EEAF;
	Wed,  9 Sep 2026 04:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fx3drFGD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A2810EEAF;
 Wed,  9 Sep 2026 04:54:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BEA80601FD;
 Wed,  9 Sep 2026 04:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B27C1F00A3A;
 Wed,  9 Sep 2026 04:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788929688;
 bh=3NjFOyOT3Sm4WXMQVZjQD+tsdVnzfE3aJGbwrXu6x6k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fx3drFGD9vMUJkYd3GZwcLirfm/vRpgdnou53Af6WQlvX/Ku1s9id2aNn53saIePU
 bsRZRdjC6irugXbO6EniUxlrkkEyDetMhm+PrFr4aaecaNAX/Y95wl2ggt9m4VuoTZ
 ZXb0oxz+wB25+e5xzuEkAFzGaLs7a59M4UY9brmI3FIwIaaejezZmKiCFf18jjSenY
 Coq/YbUqckpboSqIP1n7px1DihBIyB8+YJy+EZ75aDUWbuS+si/opdMqgxsgXkIiWJ
 IENLMfslQxKRIhQ3XWbcOkgrLDJdCXBOpc5qsSSop8w3tuoLlnH9lHkXJ96/A8v1ZS
 RLoXAmTcMSm3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] drm: Add drm_user_fence helper
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260909044454.399340-3-srinivasan.shanmugam@amd.com>
References: <20260909044454.399340-1-srinivasan.shanmugam@amd.com>
 <20260909044454.399340-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:54:47 +0000
Message-Id: <20260909045448.4B27C1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure on NOMMU architectures due to unconditional use of mm=
put_async()
--

commit dc8e122093c744c8bd5d72581571fdb0ccb6856c
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm: Add drm_user_fence helper

Introduce a common DRM user fence helper providing the kref-managed,
MM-borrowing dma-fence-callback-to-workqueue pattern used by drivers
that must access userspace memory from a kthread context when a GPU
fence signals.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> new file mode 100644
> index 0000000000000..f7882208a8b73
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_user_fence.c
[ ... ]
> +static void drm_user_fence_do_work(struct drm_work_fence *wfence)
> +{
> +	struct drm_user_fence *ufence =3D
> +		container_of(wfence, struct drm_user_fence, base);
> +	struct mm_struct *mm =3D NULL;
> +
> +	if (mmget_not_zero(ufence->mm)) {
> +		mm =3D ufence->mm;
> +		kthread_use_mm(mm);
> +	}
> +
> +	ufence->ops->writeback(ufence, !!mm);
> +
> +	if (mm) {
> +		kthread_unuse_mm(mm);
> +		mmput_async(mm);	/* requires CONFIG_MMU =E2=80=94 GPU requires MMU */

[Severity: Low]
Does this cause a build failure on architectures where CONFIG_MMU is disabl=
ed?

Although the comment notes that GPUs require an MMU, the DRM core and this
file are compiled unconditionally as part of CONFIG_DRM. Calling mmput_asyn=
c()
here without an #ifdef CONFIG_MMU guard or similar protection could result =
in=20
an implicit function declaration or linker error on NOMMU builds.

> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909044454.3993=
40-1-srinivasan.shanmugam@amd.com?part=3D2
