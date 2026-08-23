Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7B6C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B3610E4CC;
	Sun, 23 Aug 2026 09:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bam6Mes4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A6F10E4CC
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:40:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 518D1407C2;
 Sun, 23 Aug 2026 09:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEAA1F000E9;
 Sun, 23 Aug 2026 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787478037;
 bh=JCgwUAjdyJxxpi4eP68HUwX0onCoWiyD1DRDe9OIZCc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bam6Mes4ELYClg11X1VSxjSTXyugwzevtoEG0EsN38KjMR+WtXX8zMa6RDwTBKFVr
 dMro7FxQU5qLlUHnkV7UovcdQFhgF0pjAPaXdpwsMqMnNvi1ipzfN8nJlB5TqVhSrT
 /alBV/jzgyRyOXdNsrElpu6fwq/3S8P81savANJQBeajVUyyXusLilPU3h4VrftCzm
 IMAX9Pab4Qq3bTSPwxfSXuNYsP1phOpC1fHOXyU/34OgUkjpSQhxkXVWwlZmm31t+B
 vBauA2P+NA2NLoxNRvaDQ8I1TL2rVE92FvcNXR1I6rDqNGkFZXwgUXSOcVQ6h3nzFo
 lPAXTw8F+DUig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: return reserve errors from
 amdgpu_gfx_kiq_init()
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
References: <20260823092936.992430-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 09:40:36 +0000
Message-Id: <20260823094037.0DEAA1F000E9@smtp.kernel.org>
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
- [Medium] Memory and resource leak of the KIQ buffer object on the error p=
ath.
--

--- Patch [1]: [PATCH] drm/amdgpu: return reserve errors from amdgpu_gfx_ki=
q_init() ---
commit daee9bc709b5f169cbd5d109e86c30d44267139a
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

drm/amdgpu: return reserve errors from amdgpu_gfx_kiq_init()

This patch updates amdgpu_gfx_kiq_init() to explicitly return the error code
if amdgpu_bo_reserve() fails. It also ensures that amdgpu_bo_unreserve() is
only called on the successful reservation path.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index a6f95ff47d24e..3e10a90071ffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -371,8 +371,11 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>  	memset(hpd, 0, hpd_size);
> =20
>  	r =3D amdgpu_bo_reserve(kiq->eop_obj, true);
> -	if (unlikely(r !=3D 0))
> +	if (unlikely(r !=3D 0)) {
>  		dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r);
> +		amdgpu_bo_kunmap(kiq->eop_obj);
> +		return r;

[Severity: Medium]
Does this code leak the newly created buffer object on this error path?

Looking earlier in amdgpu_gfx_kiq_init(), kiq->eop_obj is allocated with
amdgpu_bo_create_kernel():

	r =3D amdgpu_bo_create_kernel(adev, hpd_size, PAGE_SIZE,
				    AMDGPU_GEM_DOMAIN_GTT, &kiq->eop_obj,
				    &kiq->eop_gpu_addr, (void **)&hpd);

If we return r directly here without calling amdgpu_bo_free_kernel(),=20
it appears the buffer object is leaked.=20

Since returning an error causes sw_init to fail, the IP block's status.sw
flag won't be set, and amdgpu_gfx_kiq_fini() will be bypassed during driver
teardown, leaving no way to clean up this allocation later.

> +	}
>  	amdgpu_bo_kunmap(kiq->eop_obj);
>  	amdgpu_bo_unreserve(kiq->eop_obj);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823092936.9924=
30-1-runyu.xiao@seu.edu.cn?part=3D1
