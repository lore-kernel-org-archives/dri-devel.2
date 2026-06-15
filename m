Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702EFCD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE5110E704;
	Mon, 15 Jun 2026 20:39:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mntxH7gs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9F010E704
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:39:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 279C141683;
 Mon, 15 Jun 2026 20:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FF31F00AC4;
 Mon, 15 Jun 2026 20:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555960;
 bh=scSenvRwQgNOvKR1Zl0j7oum31fzyXpf5R0kTw0E7Vc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mntxH7gsyaz1hilRV9PsMwIC9sk7uSiWSgfzPRLrRnV4FmbVSRPBIGIpQtL+zwq+8
 iJmEaMOdPx2EiTj5bskPrItujYMOj0cwUW+afLbQ5o9zFOe1RTGc7ieIWWbLlaNKa6
 KyTiSZoBhZXn1oPr0rBxkMarXyZMbyUpZkPUH20QodU/fLV1yddn0tJwjjF4EujDwy
 hfulCd+cv0aNmWnURQcdLPu6LviZ2+qkUlsKGVAgCFk3zM/FngZVxI33HhsRTcIJDz
 /FjZ8TqWDpRuo+/9nkPRZPqOZspAU2HvOqS+9Ughs0RtaYsdAjPHnyPLKBrVLkrRUl
 2iCwgNlUiYm8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/27] drm/xe/display: Always use system memory on
 PREEMPT_RT for DPT.
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-27-dev@lankhorst.se>
References: <20260615201846.307297-27-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:39:19 +0000
Message-Id: <20260615203919.E1FF31F00AC4@smtp.kernel.org>
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
- [Medium] Meaningful code and commit message mismatch: The patch unconditi=
onally removes STOLEN memory for DPT allocations, but the commit title stat=
es it should only apply to PREEMPT_RT.
--

commit 8469a8535d5587b09893e7c1628a8713f1ca3cb9
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/xe/display: Always use system memory on PREEMPT_RT for DPT.

We were using stolen memory because it was unused memory, but
on recent platforms this adds extra latency when waking from
RC6, because memory accesses go through the media IP.

> diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/=
display/xe_fb_pin.c
> --- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
> +++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
> @@ -173,14 +173,6 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object=
 *obj,
>  						   XE_BO_FLAG_PAGETABLE,
>  						   pin_params->alignment, false);
>  	else
> -		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
> -						   dpt_size,  ~0ull,
> -						   ttm_bo_type_kernel,
> -						   XE_BO_FLAG_STOLEN |
> -						   XE_BO_FLAG_GGTT |
> -						   XE_BO_FLAG_PAGETABLE,
> -						   pin_params->alignment, false);
> -	if (IS_ERR(dpt))
>  		dpt =3D xe_bo_create_pin_map_at_novm(xe, tile0,
>  						   dpt_size,  ~0ull,
>  						   ttm_bo_type_kernel,

[Severity: Medium]
The commit title indicates this change should only apply "on PREEMPT_RT", b=
ut
does this code in __xe_pin_fb_vma_dpt() unconditionally remove the stolen
memory fallback for all configurations?

If the intention is to unconditionally allocate new framebuffers in system
memory rather than stolen memory, could the commit title be updated to
accurately reflect that this applies to all configurations and not just
PREEMPT_RT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D26
