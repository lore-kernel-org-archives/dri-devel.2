Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9EFCD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 16:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BFB10E807;
	Sat,  6 Jun 2026 16:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mu1cwARw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8991710E807
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 16:09:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3907601DB;
 Sat,  6 Jun 2026 16:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444461F00893;
 Sat,  6 Jun 2026 16:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780762188;
 bh=UU4+L6VOGvFZSnzT4xzp2r5otq47WoVM74TB0ENW6m0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Mu1cwARwiU5oKaS2Kg0B86cRrJerm5xroO01PGsDsECvYrObYhFOR3C6TZtQvdLGY
 uLS1SZTVl/FxesEw2mb8YSqoj+ZPQSboWUC8iGOZwr4o3U9JBeQmmCw/Vix7KQ2WSf
 JYLNCCUf0WW/zvFCriL9TZYwqdCGdfXPdcUL/Fbh0mOS2tJ+8fb+r7M2NVCMoPOxZ4
 l8uRkuRaHL0inQMyz1H9viM7mk1LDzg5/ijS+5QWLzgIfAeCgGdvOM3IFd2gLzdSTi
 Nm8nnycaUPLcvrhaXjSJOMZfp230oB9YEnZlvpusuMdmKj4Bt33WmVpPAqqEVn1V8S
 OpmDJasUuuV5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau/acr: fix missing nvkm_done() in error path
 of nvkm_acr_oneinit()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606155606.77593-1-vulab@iscas.ac.cn>
References: <20260606155606.77593-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 16:09:47 +0000
Message-Id: <20260606160948.444461F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Incomplete fix of memory mapping reference leak. The patch adds =
one `nvkm_done(acr->wpr)` before returning `-EINVAL`, but `nvkm_kmap(acr->w=
pr)` was called twice on this code path.
- [Medium] The commit message demonstrates a misunderstanding of the contro=
l flow, stating that the function returns `-EINVAL` only when a mismatch is=
 detected.
- [Medium] The return values of `acr->func->wpr_build()` and `acr->func->wp=
r_patch()` are ignored, allowing initialization to proceed with corrupted f=
irmware data.
- [Medium] The WPR comparison loop can read out of bounds of the `acr->wpr`=
 memory object and the firmware data blob.
--

commit 018071a64ea846382bbfa2aefceef09269c67376
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/nouveau/acr: fix missing nvkm_done() in error path of nvkm_acr_oneinit()

This commit attempts to fix a memory mapping reference leak in
nvkm_acr_oneinit() by adding a missing nvkm_done() call in the error
path during WPR comparison.

>     However, when a mismatch is detected during the loop within the
>     conditional block, the function returns -EINVAL at line 318 without
>     calling nvkm_done(). This results in a leak of the kmap reference(s)
>     acquired earlier.

[Severity: Medium]
This isn't a bug introduced by this patch, but the commit message states the
function returns -EINVAL when a mismatch is detected.

Looking at nvkm_acr_oneinit(), the return statement is unconditional for the
entire block and happens regardless of whether a mismatch is detected:

	if (acr->wpr_fw && acr->wpr_comp) {
		nvkm_kmap(acr->wpr);
		for (i =3D 0; i < acr->wpr_fw->size; i +=3D 4) {
			...
			if (fw !=3D us) {
				nvkm_warn(...);
			}
		}
		nvkm_done(acr->wpr);
		return -EINVAL;
	}

Is this unconditional return intended?

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/acr/base.c
> index 4c7745cd6ae52..7fd967a2554f9 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> @@ -315,6 +315,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
>  					  i, us, fw);
>  			}
>  		}

[Severity: Medium]
This is a pre-existing issue, but could this loop read out-of-bounds of the
acr->wpr memory object and the firmware data blob?

If the user provides a firmware file larger than the dynamically calculated
wpr_size, there doesn't appear to be a check to ensure
acr->wpr_fw->size <=3D wpr_size before reading nvkm_ro32(acr->wpr, i).

Also, if acr->wpr_fw->size is not a multiple of 4, will the loop increment
cause the final iteration to read out-of-bounds?

[Severity: Medium]
This is a pre-existing issue, but does ignoring the return values from
wpr_build() and wpr_patch() earlier in this function allow initialization
to proceed with corrupted firmware data?

	if (!acr->wpr_fw || acr->wpr_comp)
		acr->func->wpr_build(acr, rtos);
	acr->func->wpr_patch(acr, (s64)acr->wpr_start - acr->wpr_prev);

If either function fails, could the system continue initializing with an
incomplete or corrupted WPR image?

> +		nvkm_done(acr->wpr);
>  		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but does this error path still leak a mapping
reference?

In nvkm_acr_oneinit(), nvkm_kmap(acr->wpr) is called unconditionally before
the wpr_build() call:

	nvkm_kmap(acr->wpr);
	if (acr->wpr_fw && !acr->wpr_comp)
		nvkm_wobj(acr->wpr, 0, acr->wpr_fw->data, acr->wpr_fw->size);

It is then called a second time within this wpr_comp block.

Since the reference count is incremented twice, does it need to be
decremented twice by nvkm_done() before returning -EINVAL here?

>  	}
>  	nvkm_done(acr->wpr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606155606.7759=
3-1-vulab@iscas.ac.cn?part=3D1
