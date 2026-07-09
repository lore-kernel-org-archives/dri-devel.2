Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E62C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 22:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6E810E0F4;
	Thu,  9 Jul 2026 22:55:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="myUyJBos";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8879B10E0F4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 22:55:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C02461831;
 Thu,  9 Jul 2026 22:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0491E1F000E9;
 Thu,  9 Jul 2026 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783637740;
 bh=0gQ9Vv6xOBnCZao354URlbX6bRRxJ7CL7r2ZKhCSWc8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=myUyJBosiysoAGH3oAfYf16PEH2cEEqK7Y4EOWySMeApYldcQ7L3tzOVW5m45o5gw
 rLv6klMh/L+K+Bb/yXj9hAmFg/IeGfyZmoJB1itlbOqlg0nu9hKjqK3c/Ka8I2y/S2
 fWNE0Z7T4jqdURWIVxhftgpg246iX9obFwY+9OED78MLCjb2SPyLUcCF2H28Fs5tQw
 MOvYzCv3wG9V9/z1Nj+UNItiO3aC6eWy/b/uh/KgDnyqv3WwYEB7P9wifIP74R7puB
 0wFnGJpEe99li4bk3Hmgadb9Ivo6iBVlNbMDCNLpz5Ow1LFSCAwSCA5Jv/rZvAYRFq
 fDxpriqvcrk+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix __rcu fence pointer accesses
To: "Alex Hung" <alex.hung@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709223312.475563-1-alex.hung@amd.com>
References: <20260709223312.475563-1-alex.hung@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:55:39 +0000
Message-Id: <20260709225540.0491E1F000E9@smtp.kernel.org>
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
- [Low] Misuse of rcu_access_pointer() on a non-RCU annotated pointer (f->o=
ps), which actively triggers a Sparse warning.
--

--- Patch [1]: [PATCH 1/2] drm/amdgpu: Fix __rcu fence pointer accesses ---
commit 5448af797b4d872eec1209aac5ec209c3c2b6b4a
Author: Alex Hung <alex.hung@amd.com>

drm/amdgpu: Fix __rcu fence pointer accesses

This commit uses rcu_access_pointer() to resolve sparse warnings when
comparing fence pointers in the KFD code. It wraps f->ops and an
eviction fence pointer to address 'incompatible types in comparison
expression' warnings.

Closes: https://lore.kernel.org/oe-kbuild-all/202607091659.SHEscT0c-lkp@int=
el.com/

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> index 31b8fa52b42fa..3419bad5c23a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
> @@ -92,7 +92,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(stru=
ct dma_fence *f)
>  		return NULL;
> =20
>  	fence =3D container_of(f, struct amdgpu_amdkfd_fence, base);
> -	if (f->ops =3D=3D &amdkfd_fence_ops)
> +	if (rcu_access_pointer(f->ops) =3D=3D &amdkfd_fence_ops)

[Severity: Low]
Is f->ops actually an __rcu-annotated pointer?=20

Looking at struct dma_fence, the ops field is a standard
const struct dma_fence_ops * without the __rcu annotation.

Does wrapping a non-RCU pointer in rcu_access_pointer() trigger the exact
Sparse warning ("different address spaces") this commit aims to fix, since
the macro expects an __rcu pointer?

>  		return fence;
> =20
>  	return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709223312.4755=
63-1-alex.hung@amd.com?part=3D1
