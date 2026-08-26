Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3DDC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 00:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D5010E10A;
	Wed, 26 Aug 2026 00:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ame2q62P";
	dkim-atps=neutral
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com
 [209.85.210.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0243210E10A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 00:51:12 +0000 (UTC)
Received: by mail-pf1-f225.google.com with SMTP id
 d2e1a72fcca58-848743155bcso238788b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 17:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787705472; x=1788310272;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SjaCIdVU7kETJpx88YkabqKD+cdjiVBYTuWkimnlXeo=;
 b=rkCIFr7ymlX79VtvlOeHL+xF0C0xigvZk7o+6YQLbvp0zftFj02LK6e/tMF/pxssbb
 fnWMzPROmpE1wDezDI6cFj6iB4HyiuVjztE9MvbZXiqtFPcwd0jqhk6N2RINjFGd/PEg
 /rIqdipF3lF3jKqTiykP+Nh8FqGZy1uDWASu/TYkhWyL5kcodrmmXL+xxDJXprhYoH5V
 cpc9CP7Ud6hiCAQR3x4fGg7ZpAERGp8H6Hzztw47WHgdxryTR0SVhNVV1sIk5dLtGBex
 CT05/CVpctOqpj+1R/5QhCqvqTmIhXxykmFQeOsgKGxCNfVWAyPTT7xr2W0aLMwYgknI
 6naQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKt2575/IWeiho23tjRywF6bsq0moz9UIvb5i7D1mPty9WSjpP0EeNrlzqQ93SUB3U/lARWOvq9pQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ne94uBQdTj95YIeHV057HAUOR6IH254rAx2FOgh6ighcw9l6zy
 Bvqi6hmt2W9dsYWdLWS8dpgwOg6iY541PeQF6pz0/1ljYYf2G9r2HBc1dNbEjc9LMySpDQZ12gR
 mWy9hzkuYyPJJeuepJo2elyUYttdbSZ6hZtVxIaRQftSCuJ37wh0D4ZxzkKzkfag1w7HLzyp7XM
 vG5YJA7Wu4LblKYRyoow4luCKqyZ5nudWbXvQx84QL5SLgFibk4rxk9H0LusKV/p5cClEBq5xzU
 040l6K5fHzw8GV01utlmUsSQ1J5
X-Gm-Gg: AR+sD13+fY1OKsXs7jyku6Kb7U8OXRLbsCrL5Wti4TYsyBVPRPI32bIws88KIM3G24g
 ksYXyZrVSQPY2SkUkk0V0M5arSJXkQZwSYyHkYxnK7JMwHE9oYSlq7d9v1WmLS2v0MLeIbmfzX+
 5jRkGlO9/CsZ+aEWutSYmej0FNsg8Keauexr/cFTpx6W4vGZ6fi4oAZSJJjN5N6fL7J9serX6aq
 yKHTAEM6tu3bVvTJOdiVlN3L1AsmM2nE9diGLoK06mq7iaTAIpgRkl72hlSlvjiHolOXeYsQvsW
 1419fVgcmpA76KgQivMdR+pjPtyGDH3jIzfsHLRD2f3effegQB9IKuGNgFTb3Hm3Vh558bBOvGG
 KmyZ4+XlSKrR37pVGgmc7GV/RTVRmIafzo+hRL8aj4jLwjIqXEv4QxXxU+mEewTuXYjl87wV4xU
 gIrRiIdMu9AMNSn0HWardArAPugcRw9UwHi+TSl+rn
X-Received: by 2002:a05:6a00:438c:b0:851:c1d2:c48d with SMTP id
 d2e1a72fcca58-85372fa9890mr5396681b3a.8.1787705472327; 
 Tue, 25 Aug 2026 17:51:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-8538a10d27csm346094b3a.1.2026.08.25.17.51.11
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Aug 2026 17:51:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so391870a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 17:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787705470; x=1788310270;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SjaCIdVU7kETJpx88YkabqKD+cdjiVBYTuWkimnlXeo=;
 b=ame2q62PPzpJwMHnSt4CObgSz/BCVzqe1tl3k7A6yo0mmIln9r5fr2701uEJT9Jh4k
 dYZprRmxiB/nRHzflpzCQbYIVA4L/cgg7LCjyBsGYg1G15duCkvxUet5ODtMO607Ajs8
 scB+EWrskRVZDSrASNcnZ8xB2VLLmWw/IEcOY=
X-Forwarded-Encrypted: i=1;
 AHgh+RqqHHr29d4+dKn2wXXYqvJFMuCctEwLbFLkE/nGIT/K2m7awh8UHHlcEYLgJE15hgu/JObEnLblFaM=@lists.freedesktop.org
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3966d412ab2mr5707687a91.9.1787705470455; 
 Tue, 25 Aug 2026 17:51:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4a8d:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-3966d412ab2mr5707612a91.9.1787705469948; 
 Tue, 25 Aug 2026 17:51:09 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d63bb23sm2948885eec.7.2026.08.25.17.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 17:51:09 -0700 (PDT)
Message-ID: <fb9eda28-ffe5-4ba3-a993-9e1e895084f2@broadcom.com>
Date: Tue, 25 Aug 2026 17:51:17 -0700
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

I take it this is an x86_64 mac? What version of fusion are you using?
Also what is the hwVersion of your VM?

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
> +	if (cursor_max_dim &&
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
