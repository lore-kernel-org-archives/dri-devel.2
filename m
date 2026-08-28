Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59321C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 01:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AA510E428;
	Fri, 28 Aug 2026 01:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="GkHj+nuf";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D9410E428
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 01:17:24 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so361503a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 18:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787879844; x=1788484644;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HKFBwDyQOTBtP3LF8rbCVIQqdBEXNYZb1kTqyGwOWOk=;
 b=h9atwAdX+tg0Wi6t/t73VuToP2WgPszVBqKi3oFNqW9VcAGwhORR138SeatNRw4tcJ
 Rog8eZQkuG2gbN26d/r6UZlruSiRAydHYd6+S68c+mcRLIf6uFS8pJUEb7zXfjP5Pkfr
 vL/uVClvTq1KVFp1lItfaVwzCI20mf0zlHxTvDB6LOe9gvznx+jj1snfFh8s9V4n2KAC
 bPY+4l5a63PdWENNxnXAAA8w1B+MY3BS/0faCERov77/aNHNjfOSKYodrSzL7xJhP+0N
 4aihsnhv7iQJbMhcKESs1AVmZqYMjB7FFlSb7gklWWTM3x85yEJfg+Hq7ZZ+HdzV/MZx
 pxXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry8HdkXNvgFsFulJhMLQizE72nkGyf6jxwnpZspUbtrYaudtTB8fWAg2/s3L4fHSjpCRGiKv1CWjI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpzTyWjPcYj93GqhT89pFmSNJH8o6r8Hcwqw54ORpb8NX/Aajp
 3ZO93VyV84dSOISsCLn0ftezvqq7oEoytqPNUAYjICPfqLV56MeOZgWaEaovOU3DCbKcDVHapAy
 qiay3ni3yCnXUYPUMT+IJadgcFKdfCFzgEEnfIkqJ/lG0JxK/GTbhZmnqpqlApygx+g9X/WGuOZ
 n8b5fFFJfuBTKlb66RcjsfbDnL3tDxSaoe8fPkcNyDSmaWDIOpl8RVrC8ktKZRDpvPoO/VumdOi
 KsV/kwU5GHGnn0Zu2FdQCdqve/h
X-Gm-Gg: AR+sD10ovAOn4nz7UwZRKyGMabHOGPDJjAD44MvPvygQxR+klTpBcHE/Js2RQjAgrA0
 9LYz4hVMIE8iPquKdXRbmKIad2fNZIdZx7cqZx4QxP6Of4yRSg8++8OG0v4VgSlXY72T+KUiEGk
 ixSzH9LwvgeLf5FVnx6sNDRD7MtLnQC9+mGLRVFpDCkKrzPV/r9c5A9OPrsuUmZgy2+BGH6wrT1
 9/4XAkoRWrbwTk+3BxuDimY4JQT+y8OVcm/NqvpjjiY3Iiqj5lCheUmv3eIsL1+y39i7EqQYh9Z
 fYm/I3Ng2kAVHtw4UzxnLxI3t5L9f7tHrA82gFrqBp5RadkoJ3s0ELf+GPV9M6hoFU5EYhJagKz
 rO6au++RAL0WpFqJjpUrBHIxAlQaB9kZqvW4W2Sq2X5gwwK9jugZG9k3i5LHk/tSBnzv8+L2hZM
 GuWi1/ZkAOHluMKtuQxgknA2+Mvecrpy+0vyIGMlZu
X-Received: by 2002:a17:90a:e185:b0:37f:eafd:3505 with SMTP id
 98e67ed59e1d1-396d0ecbdb9mr6806289a91.6.1787879844103; 
 Thu, 27 Aug 2026 18:17:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-396b0d3785csm1628896a91.2.2026.08.27.18.17.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Aug 2026 18:17:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1cb806660so523833a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 18:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787879842; x=1788484642;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HKFBwDyQOTBtP3LF8rbCVIQqdBEXNYZb1kTqyGwOWOk=;
 b=GkHj+nufam1PwgHYj9TKcVfiEldnA/5blGIop9r+UPFKNfdpl/Rwx/lxpXfmc1zPU3
 jmr6l0V6JFfxbqow8akr+/qUN56YiKF5jcZTbON+TEcxF59zETn//1eSL9vpokbkI9WY
 4h9U8y0OPZFJXzDLs94/AXMrdXw0EotlcYWVM=
X-Forwarded-Encrypted: i=1;
 AHgh+RrO/9tEdmb9C4Inu9Wqmqt3wDf/bGGfFIy2kW5MvMC4Fbyl8tcr9DubnIueG6CuQnhAhgXagk0MtG8=@lists.freedesktop.org
X-Received: by 2002:a05:6a21:6b87:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3d266582c55mr6446021637.8.1787879842201; 
 Thu, 27 Aug 2026 18:17:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b87:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3d266582c55mr6445905637.8.1787879841719; 
 Thu, 27 Aug 2026 18:17:21 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d4b336sm1055689c88.8.2026.08.27.18.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 18:17:21 -0700 (PDT)
Message-ID: <ef11cc4a-fbaa-415a-bda1-2ac491f3b5e2@broadcom.com>
Date: Thu, 27 Aug 2026 18:17:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: fausten <yunfeng.li.nb@gmail.com>, dri-devel@lists.freedesktop.org,
 zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
References: <20260823083211.2654733-1-yunfeng.li.nb@email.com>
 <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260823085916.2707488-1-yunfeng.li.nb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 8/23/26 1:59 AM, fausten wrote:
> The cursor plane code validates cursor dimensions against
> SVGA_REG_CURSOR_MAX_DIMENSION before every cursor update, and
> rejects the update with -EINVAL if the cursor is larger than the
> reported maximum.
> 
> However, some SVGA implementations do not implement this register
> and return 0 for it. In that case every cursor update is rejected,
> and the log is spammed with:
> 
>   [drm] Cursor dimensions (64, 64) exceed device max 0
> 
> The visible symptom is that the hardware cursor never appears at
> all on VMware Fusion guests (SVGA version 2), making the mouse
> pointer invisible even though the input devices work fine.
> 
> Treat a reported maximum of 0 as "not implemented" and skip the
> dimension check in that case, restoring the pre-existing behaviour
> of accepting the cursor.
> 
> Tested on VMware Fusion with an SVGA version 2 device where the
> cursor previously did not show up.
> 
> Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
> Signed-off-by: fausten <yunfeng.li.nb@gmail.com>
> ---
> Changes in v2:
> - Fix author name and email address (v1 was sent with a wrong From).
> 
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> index d1e7df500..fbdd23ecb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
>  	mob_max_size = vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
>  	cursor_max_dim = vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
>  
> -	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
> -	    vps->base.crtc_h > cursor_max_dim)
> +	/* Some SVGA implementations (e.g. VMware Fusion) report 0 here. */

The issue here is not with vmware fusion but the hw version, SVGA_REG_CURSOR_MAX_DIMENSION requires cursor mobs,
which are available only on hw versions 18 and above. Please correct the comment here and below to reflect that.

> +	if (cursor_max_dim &&

Could you instead do cursor_max_dim > 0 here and below.

> +	    (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
> +	     vps->base.crtc_h > cursor_max_dim))
>  		return -EINVAL;
>  
>  	if (vps->cursor.mob) {
> @@ -748,8 +750,10 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
>  		u32 cursor_max_dim =
>  			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
>  
> -		if (new_state->crtc_w > cursor_max_dim ||
> -		    new_state->crtc_h > cursor_max_dim) {
> +		/* Some SVGA implementations (e.g. VMware Fusion) report 0 here. */
> +		if (cursor_max_dim &&
> +		    (new_state->crtc_w > cursor_max_dim ||
> +		    new_state->crtc_h > cursor_max_dim)) {
>  			drm_warn(&vmw->drm,
>  				 "Cursor dimensions (%d, %d) exceed device max %u\n",
>  				 new_state->crtc_w, new_state->crtc_h,


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
