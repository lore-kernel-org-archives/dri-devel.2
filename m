Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A5CC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322DF10F628;
	Fri, 17 Jul 2026 21:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jsdtuuIS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B05010F628
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:06:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B00B601ED;
 Fri, 17 Jul 2026 21:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E327D1F000E9;
 Fri, 17 Jul 2026 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322409;
 bh=+yJd08pmlDvZZ0sz1d2RxNnDbyVPlyXttpThev3z+hg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jsdtuuISrma4InLNb8SaymnMHu34Vfurwi1gUm3yivOHbVHkALbxlllSLJHRDtmQ7
 EvtJpDOGngl/0mgTxl9q/H3YrL3WE8ZCh0ITyZ+qjX4UNv8AfK0/JfW+pcUVLC3Lw4
 A8yohIzITb+3lDffihu8XQG9O2+aIzSd4Qtf95d2ocuOdgJipAVkWZ62GAzGzf9WOe
 3foR7BG1jSSWgQXTFub9lbNhD+Fw9U64Qg+jUUuYNFt5dNjtopUTIm1uu78aH1O+85
 alZVBD0akvkkrCxpfaN1YtNb+5UQo3Y0a1lZXMN/yt2RKZd18AwGI4uDMATg1cI9Wp
 Iyv+FAkyWzxGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/16] drm/msm: Move nr_cmds initialization
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-6-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:06:48 +0000
Message-Id: <20260717210648.E327D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] MSM VM Lazy Initialization NULL Pointer Dereference
--

--- Patch [5]: [PATCH v6 05/16] drm/msm: Move nr_cmds initialization ---
commit 7351feaad392cc3ab54b31c35b1352065b9a2c8c
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Move nr_cmds initialization

Previously if we entered an error path between these two points, we
could leak the relocs tables due to submit->nr_cmds still being zero.
Userspace could use this to trigger a memory leak.

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 26ea8a28be474..d55897c358371 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c

[ ... ]

> @@ -719,8 +722,6 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void=
 *data,
>  			goto out;
>  	}
> =20
> -	submit->nr_cmds =3D args->nr_cmds;
> -

[Severity: Critical]
This isn't a bug introduced by this patch, but can early validation in
msm_ioctl_gem_submit() trigger a NULL pointer dereference?

Because the MSM driver uses lazy initialization for virtual memory address
spaces, ctx->vm will be NULL if this is the first operation on a newly
created context. Unprivileged userspace applications could trigger this by
opening the DRM device and calling the MSM_GEM_SUBMIT ioctl before any
operation that initializes the VM.

If ctx->vm is not yet initialized, direct access will crash when checking
unusable status:

msm_ioctl_gem_submit() {
    ...
    if (to_msm_vm(ctx->vm)->unusable)
        return UERR(EPIPE, dev, "context is unusable");
    ...
}

Since base is at offset 0 in struct msm_gem_vm, to_msm_vm(NULL) returns
NULL, leading to a dereference of NULL->unusable.

Should this code path be updated to use msm_context_vm() to ensure the VM
is fully created before checking its status?

>  	idr_preload(GFP_KERNEL);
> =20
>  	spin_lock(&queue->idr_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D5
