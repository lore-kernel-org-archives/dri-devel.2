Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC8AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969A310E74D;
	Mon,  6 Jul 2026 05:41:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JF4f+f6Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D4A10E74D
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:41:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEB9843CF8;
 Mon,  6 Jul 2026 05:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E88A1F000E9;
 Mon,  6 Jul 2026 05:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783316508;
 bh=hIkyDxUVUiDJPIYT4xwysLTJGOxjTqF6F0Bk4KqKNAM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JF4f+f6YccWNVCbTOqlp03kngRzFcELlGqYxvbxfss17xCNefhFjN0Va9ieQE+aTq
 Gr3IP2kYYlFeWy1LFsyxF2FqvwGlvepxoMNzCdSgEVqCsdnmRuzICdpyHXj2aARhMt
 zmvZ+RT7yqKEWxEtfRGYrtzMA6yinZp9ovR+l8wVXzCo5qqLsl0qBjz5JaLLOcfVYj
 rzEeWPAXvzqSRYNyREHbchdqJWoKQ4jwzSAG2w6Fd6ZjwkSBXExxqi6whKq8aOWpNA
 3Pj9IqakFuy1V+wz3XPn0QgR5sx7Z4O1G+lWF9mEEqCQT19es+WQFyDyej9+iFhiFv
 Pk1JH76hmDNUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] amdgpu: add support for memory cgroups
To: "Dave Airlie" <airlied@gmail.com>
Cc: tj@kernel.org, dri-devel@lists.freedesktop.org, hannes@cmpxchg.org,
 mkoutny@suse.com
In-Reply-To: <20260706052330.1110909-9-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
 <20260706052330.1110909-9-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 05:41:48 +0000
Message-Id: <20260706054148.8E88A1F000E9@smtp.kernel.org>
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
- [High] Evicted VRAM BOs bypass memory cgroup (memcg) accounting because T=
TM_PL_FLAG_MEMCG is explicitly cleared during eviction.
--

commit 05e0eb5ded826da3ea51ec14b35acb22f46c4aaa
Author: Dave Airlie <airlied@redhat.com>

amdgpu: add support for memory cgroups

This adds support for adding a obj cgroup to a buffer object,
and passing in the placement flags to make sure it's accounted
properly.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 8062b3d611574..1c8123c564ac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -155,11 +155,14 @@ static void amdgpu_evict_flags(struct ttm_buffer_ob=
ject *bo,
>  			amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_GTT |
>  							AMDGPU_GEM_DOMAIN_CPU);
>  		}
> +		for (int i =3D 0; i < abo->placement.num_placement; i++)
> +			abo->placements[i].flags &=3D ~TTM_PL_FLAG_MEMCG;

[Severity: High]
Does clearing TTM_PL_FLAG_MEMCG here allow an application to bypass memcg
limits?

If a container continually allocates VRAM BOs, older BOs will be evicted to
system memory. Because the TTM_PL_FLAG_MEMCG flag is explicitly removed from
the placement flags in amdgpu_evict_flags(), it appears that the system mem=
ory
pages allocated during this eviction will not be charged to the application=
's
memcg, potentially allowing unbounded host memory consumption.

>  		break;
>  	case TTM_PL_TT:
>  	case AMDGPU_PL_PREEMPT:
>  	default:
>  		amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
> +		abo->placements[0].flags &=3D ~TTM_PL_FLAG_MEMCG;

[Severity: High]
Does this similarly drop memcg accounting when evicting other memory types =
to
the CPU domain?

>  		break;
>  	}
>  	*placement =3D abo->placement;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706052330.1110=
909-1-airlied@gmail.com?part=3D8
