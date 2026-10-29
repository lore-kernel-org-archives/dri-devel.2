Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C1606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yeAwaSe2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36EE11259A;
	Thu, 29 Oct 2026 22:11:58 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5299711259A
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:11:52 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3646e6de3e8so11885eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311911; cv=none;
 d=google.com; s=arc-20260327;
 b=eddnjpxr9PH1gD1KO2Jc5JhLga6dIUgs1vSLkAtveQBO/QP9nZ56wlajF+qWw6/scj
 lMVcwZMICkovSzYjZIjrUPSjmYFsm4YgTCVbBmsbbebJzb4VjHl/IvlUnTMQogDsXViR
 StGxd+2GorVZY5ubMK6A7AKiXyXukKfHrWyOigh2XCHZV29do1A9vQMdQdcSPYPlufnv
 qMvua7xUDnjeG21udG6BRDUkjk1n4/8m/bTm5c5oYsZFcd28r5HO0xi1qMTzocdvwpxZ
 BjnnR0YQiI8ChDb9P4L00e2WopXTXXQniCrMimgNuoRNTc0U0iI85czPVSdXIj+3H6Ua
 lleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 fh=u+Be1JD+vLhZFMWAJDxaSipVRfGjfs3xyoc3iazLurU=;
 b=T7SQ92AtPu/c+lnuitmrN40KhlGrYPpSHe9U9R60WHDZZzDrXdW1qoes+jOTQY8u7Q
 dP6oYXQBbOe24omX76l+7oVDFR6ZZQoE6azeKKwo/RziWCIzsU6UpR9wL9uk/S55R6gp
 2nuHH4oo0gNOMshRHJXFsZe8CQQJ7laHq7xaOy/5KeBjDEfv7kCXQPF6dT7wVJiIkWpw
 /ngN6EbzmsqdFhioJO/zmAS5RMy/WnEAJC1q5FD26Bq9dox0cmC/YlP3ZKkWjpDrQCPK
 H1SvGzDT9O/Y50i62AlTKREW+dbS1qtVeBRS24xZwXGmxkOWM74MRRDYS8FYRgZL2nCI
 shLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311911; x=1793916711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 b=yeAwaSe2K8LFKzyLew8S1w/zvFuym0AgNBZ7eO1bIAju9itMTh+uRk9/l8Nh3hY88i
 WsfEIDe9j9Bk6DHJaR+R1GnDC47fCoVL/g9XFkCKwizG+IlikrVk+DfBHl/iAwpIzL5k
 bYsQv868+MOr7xsV1YZr/m1rjvovp/qefBaUOBWzyKL7fLBv+HiXvstxDHjOOwqhrKBm
 HUYjqEnPx4kJG9rYdKgRjMgJLHDE2IXaG0GsBYffNPiaCqwDVfBw/lhN3pUEhZq2NGsT
 prLdxB1UvxIRWLtwD0Xid1ddEwwuwHUhC6xTBd+F9KYapiSriqqiMc7NWGLqTyKTuaPd
 VgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311911; x=1793916711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PBEIkypNFy3duETPul/tihmqsCZnLnP2we6NZrIEQZU=;
 b=Uz0FLMOEh1mgYv073fFxv8OoUcy6rO0/ymQfWiK77PrCDW/ISZ5WQW/WQ7XYjM3ELd
 y5ohgna+mo8CxpJl1wTe4oCMV42lWpfR/CAVR8lIuNMyqiHJuBZghZt6YQMIzFyVdwZ7
 w5vQlgctR4YdIYoDyM5zABH0V/58PSW61Jl28K7tixwkM4vMuwa4zvIWzACNs16ZF9CQ
 Xw2yoc6wKfI5/a8YVT2jvSFLML7OvAf3hzEKiD0algaogbsGRAuAIGNJPi/vhI3OIHRP
 fXNX4rwyLfP/vjo9KzYEPzUj00df5z8rb3lP8Yu6oeeMcg+4ZK9+GKW9Dq6MNbkOjSkx
 u1cQ==
X-Gm-Message-State: AFq9FYKVcqgTwPZSKK7JRPJIoF1pcsEjSS/D0nq7+zmbKxxrbzy4jHZw
 pc1DZXDrGBE14fXnUItPMGu9X0IgAbUCft+UJ+K0KpMTgi6r2DnbaxbBlO5tIqRvsqB3ESnuaYK
 P++bT224H3+lsFJrH4SjOVA0AtjQsIr8=
X-Gm-Gg: AYBFou1dDn27aPjCMXtu6VSKcnO1KiL07kinanX4yIARIzCqFgivRz7b5FkXt6K4L1O
 6LWo8x6yc+F9A2yI3bWslHMBvf9La/9XInhjiJTcMXsykgTmO3u1EUM0Lox6NO2VYJi0aRbFaHk
 PztdampHDNYR0iIULwdQOEWF0/AHuZYd24VI7AWu72+OsPGGO9pDDgKYcZw5yp06t657K2YXewL
 fBLyYe/TfktnOlgy8LSjE9IKCHlDyfJ1E6VkbPIPTccW8BYHS8+5/cLoUoFzYaUEBl7vjLqYceL
 VaNFh0N/DheL89oW+bLNOxsDx7uNPlS8FFVCUUz6bDphPrCl2aJrzVBP1Yt3qw10X2WXYq1TZup
 knMuY2IeFmLbF6IJgVO7ev0uGNNw56as3/PJX4y65bo1YBjB084YAayJ1y+VUcl24qPtkdxV3eH
 kcrlRGDRet0oJzspgYml8imDI=
X-Received: by 2002:a05:701b:418d:10b0:190:e602:c769 with SMTP id
 a92af1059eb24-1ac59143aeamr818406c88.1.1793311911532; Thu, 29 Oct 2026
 15:11:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027193559.28474-1-amade@asmblr.net>
In-Reply-To: <20261027193559.28474-1-amade@asmblr.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:11:38 -0400
X-Gm-Features: AclHuK85g9fztoaVrlp_rJWPJHWRSqCOuLati5XqcOXZS0zoPwKNpaJFJhjLezI
Message-ID: <CADnq5_NOVHSLnxwmY5gsq4vMxbJP6QQPnPiAJt_uwkDtegpYkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Prevent debugfs nullptr dereference
To: =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amade@asmblr.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied the series.

Thanks!

Alex

On Wed, Oct 28, 2026 at 9:06=E2=80=AFAM Amadeusz S=C5=82awi=C5=84ski <amade=
@asmblr.net> wrote:
>
> Running
> cat /sys/kernel/debug/dri/0/psp_spirom_dump
> with amdgpu card that doesn't support it leads to nullptr dereference.
> Add checks to prevent that.
>
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amade@asmblr.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 82a2684dbd2e..627c74f16914 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -5381,6 +5381,9 @@ static int psp_read_spirom_debugfs_open(struct inod=
e *inode, struct file *filp)
>         struct spirom_bo *bo_triplet;
>         int ret;
>
> +       if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
> +               return -EOPNOTSUPP;
> +
>         /* serialize the open() file calling */
>         if (!mutex_trylock(&adev->psp.mutex))
>                 return -EBUSY;
> @@ -5473,6 +5476,9 @@ void amdgpu_psp_debugfs_init(struct amdgpu_device *=
adev)
>  #if defined(CONFIG_DEBUG_FS)
>         struct drm_minor *minor =3D adev_to_drm(adev)->primary;
>
> +       if (!adev->psp.funcs || !adev->psp.funcs->dump_spirom)
> +               return;
> +
>         debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_=
root,
>                                  adev, &psp_dump_spirom_debugfs_ops, AMD_=
VBIOS_FILE_MAX_SIZE_B * 2);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index a4ec60f6c317..975d12359358 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -574,7 +574,7 @@ struct amdgpu_psp_funcs {
>         (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
>  #define psp_dump_spirom(psp, fw_pri_mc_addr) \
> -       ((psp)->funcs->dump_spirom ? \
> +       (((psp)->funcs && (psp)->funcs->dump_spirom) ? \
>         (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>
>  #define psp_vbflash_status(psp) \
>
> base-commit: 83f32c773255720a661aa45d83e36278135f23f5
> --
> 2.56.0
>
