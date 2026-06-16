Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33F7CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E8010EC44;
	Tue, 16 Jun 2026 15:38:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mn1GiiuA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D10010EC44
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 15:38:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2E99416B9;
 Tue, 16 Jun 2026 15:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7680E1F00A3A;
 Tue, 16 Jun 2026 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781624332;
 bh=S99sZTsHTwNIk3dRi2HDnxpPkS1Nm2x4jKGleLKKhWo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mn1GiiuAcoWpxnJxefDNxde1vIf2X6kl2ciLvy8ULjbJyqfPo7KNltV/VBpSj1fZd
 QEzIPrB5PY7TADYaTAawllNFEbN0k5GDpwPgjz+B6MAySMhKt6lblA0A4Gv9w1xKJj
 M4Q3tOIhiDDtu+H+Hb8p2LWrFIvnVMK4KrlC9KTjGEYj7Anm2arKI4X/TdtKMfZF5F
 ej7PKIm6G7f5+47H8D8lXBR0aiTrUn0BALvIHeuJbwTIfIs8hGPm1hkObwKgBZ5vJ7
 t2sK+ntvOdZQ4ApkOoNn/Cn3rtXfjd5IgG3uTRMG9W/KXkHu3pwLKTbj6kRxeWzaKT
 LPmu7S3R+hvOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: fix fence reference leak in
 amdgpu_gfx_run_cleaner_shader_job
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260616153506.1713376-1-vulab@iscas.ac.cn>
References: <20260616153506.1713376-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:38:51 +0000
Message-Id: <20260616153852.7680E1F00A3A@smtp.kernel.org>
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
- [High] The patch introduces an unconditional `goto err;` after `dma_fence=
_wait()`, making `dma_fence_put(f)` unreachable dead code and causing a gua=
ranteed fence reference leak.
--

commit c63d121e1a1065f00f4d8966f1c7bd3d065b39ef
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/amdgpu: fix fence reference leak in amdgpu_gfx_run_cleaner_shader_job

This commit intends to fix a potential fence reference leak in the error
handling path of amdgpu_gfx_run_cleaner_shader_job() by ensuring the
fence is properly released if dma_fence_wait() fails.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index ff5a55f5f3c9e..9a79a80078c3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c

[ ... ]

> @@ -1729,16 +1729,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(stru=
ct amdgpu_ring *ring)
>  	f =3D amdgpu_job_submit(job);
> =20
>  	r =3D dma_fence_wait(f, false);
> -	if (r)
> -		goto err;
> +	goto err;
> =20
>  	dma_fence_put(f);

[Severity: High]
Does this unconditional goto make dma_fence_put() unreachable?=20

Since the 'if (r)' condition was removed, execution will always jump to the
err label, bypassing the dma_fence_put(f) call entirely.=20

This appears to introduce a guaranteed fence reference leak on every
invocation of amdgpu_gfx_run_cleaner_shader_job(), rather than fixing
the potential error path leak described in the commit message.

> =20
> +err:
>  	/* Clean up the scheduler entity */
>  	drm_sched_entity_destroy(&entity);
> -	return 0;
> -
> -err:
>  	return r;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616153506.1713=
376-1-vulab@iscas.ac.cn?part=3D1
