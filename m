Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E526C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE35E10E050;
	Wed,  2 Sep 2026 20:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="hOuvWv1n";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DCE10E050
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:44:24 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso351392a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788381864; x=1788986664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PD094jSE9LfhMHsvJNe0MdQ7eQ98KtiXjUQDqdbLmUE=;
 b=hrMQuetfytb/+P6a+q8ycNNsLLji2KE1nE47VqJpsjQIMq7FLIL3o8HDgFrwhBa1WY
 ew+oH8LRky/FifjtNMePIgy01EAdQp0eAML3FTv6aPQ1UghfBMsjWzcVw7xidEuJEW2R
 dEqoJipqMA1cMhrDzChk3qIMbkfxY2twy3JeX4QlAsmNGb16MusHuLYXZrDFbf358ZM+
 VHwGs8EtpNpB/gVhc11cq6xmkobwgoV1gv3pckXJxkAkpxakH4/BIQVKGXZMYPqsLyXj
 fVPit0XUIzia3UlFp5CY6ZA/YQXR2ci+5wTCTkc+MxC+kwXVo9z+9iajTPFxkdXxQ5kW
 d7ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm4Kfs7m1fq4jLX796wVcldB85uuakG5BerMMDvY8UJsbad2E8v049Vag23sX2xANOh/gUQ9aOfLI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFZFOQ/J4pBtoKcl19smLwfSPI5QO8rmr7WMKZx9jDRv5/pfCS
 mqLn0vb6+MjbMmp7Coi9PqOnQWnO1oH0VG0MoDoXWQsP/G/Xq610conUl5dNBpoI4eSbmR5pz2O
 g9RBIdGlBc+gv0LiG8SiCPwwAQUey2Ng6Pmc7i7MX5HSGIZxaE0G3Z9hOSAh8i7Eak09RBVHGPQ
 4ds9lxsj7BOuCk2me/ng446M3hpR6BUgYxcj4xkTL4LsoH2xJ5Jr6o4Gb6tpqmO/WoMLPiQ3P/t
 0KZXCUj/GBtjujHu0IPj+GzLV03
X-Gm-Gg: AYBFou0YZdiNdKsFUvHzC3ogqK4lOQqvQwIDGTd4irNEwMRrlbUPhtYYRJZKoQS38mP
 Ix0tocDFQRoFnrN6sCb3IodOqijZLr+tkmI/6a/P+VHoaJu1rJ/5B8/+/sPEAtSkfTlixNAhIn5
 VXtFLHflpgoRDiHrMvm9IKa6EDCpgVjkHabK2yGP0GSVDkNZKOGij+BNY+w2ZFg5LCTg3g1YDoT
 UPR6x9CfPH47cNdS+vU2L20P+bTFtmyvKne/yxN8jKtBNgzvYvhhf6OA55z2ODqjeX0RFPhr0Wk
 7lY70A9y78RbEbkyuxKtJcIwoVtuGzN3H/MAb4mcWILsjWtcMPVINjK7qnLFtmbNHE0PJrGyZh1
 t491A2Inf/lWpbXeSQprnXMPQnY6HwE6szw1KaK3QUIVsokUFFZAuPy55I1JfoWXvne+uuLUMFh
 NYztcXbuOhzQkYCtRk39DpIEJPEKf9fatXYAjk66nQ
X-Received: by 2002:a17:90b:1dcd:b0:398:9bd3:d6d1 with SMTP id
 98e67ed59e1d1-39b083af6fdmr1462943a91.11.1788381864196; 
 Wed, 02 Sep 2026 13:44:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39ae62a44d6sm430127a91.1.2026.09.02.13.44.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Sep 2026 13:44:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso325389a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1788381862; x=1788986662;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PD094jSE9LfhMHsvJNe0MdQ7eQ98KtiXjUQDqdbLmUE=;
 b=hOuvWv1nQ3yi2zyofVoql/jfBsRQhorE3h1m9D+dB26qub3jdkgpMS0O3EocrjA5US
 csxcsQ+hJOCz/kJCEehoSxt75OTRHeyq+zwrts13M74wQeojiHj/dj18IEIcIWxukb6L
 /7sI4hgRKzjfIzUoCUYEGd78K4Z7K3z5mLhQk=
X-Forwarded-Encrypted: i=1;
 AKwUvBx0IAQ4E4gaum/rLaYQ8Wd73GHJ/W5rXM4RBmCw89F6lvnQwoZ1RIRQd1JcHUWNcq5c79cxeoyaulQ=@lists.freedesktop.org
X-Received: by 2002:a17:90a:d446:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-39b07f2f50amr1792411a91.7.1788381862373; 
 Wed, 02 Sep 2026 13:44:22 -0700 (PDT)
X-Received: by 2002:a17:90a:d446:b0:395:c3f7:2895 with SMTP id
 98e67ed59e1d1-39b07f2f50amr1792375a91.7.1788381861863; 
 Wed, 02 Sep 2026 13:44:21 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3325534cd65sm635205eec.6.2026.09.02.13.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 13:44:21 -0700 (PDT)
Message-ID: <e84774ae-b49d-4df5-923d-ae2cde480aaf@broadcom.com>
Date: Wed, 2 Sep 2026 13:44:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION
 as unset
To: fausten <yunfeng.li.nb@gmail.com>, dri-devel@lists.freedesktop.org,
 zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
References: <ef11cc4a-fbaa-415a-bda1-2ac491f3b5e2@broadcom.com>
 <20260830151619.2452307-1-yunfeng.li.nb@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260830151619.2452307-1-yunfeng.li.nb@gmail.com>
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

On 8/30/26 8:16 AM, fausten wrote:
> The cursor plane code validates cursor dimensions against
> SVGA_REG_CURSOR_MAX_DIMENSION before every cursor update, and
> rejects the update with -EINVAL if the cursor is larger than the
> reported maximum.
> 
> However, this register is only available on hardware versions 18
> and above, which introduced cursor MOBs. Older hardware (e.g. a
> VMware Fusion guest with SVGA version 2) returns 0 for it.
> In that case every cursor update is rejected,
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
> Signed-off-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> ---
> Changes in v3:
> - Use an explicit cursor_max_dim > 0 comparison (Maaz).
> - Fix the comments: the register requires cursor MOBs which exist
>   only on hw version 18 and above; it is not Fusion-specific
>   (Maaz).
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> index d1e7df500..3d4660684 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
>  	mob_max_size = vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
>  	cursor_max_dim = vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
>  
> -	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
> -	    vps->base.crtc_h > cursor_max_dim)
> +	/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
> +	if (cursor_max_dim > 0 &&
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
> +		/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
> +		if (cursor_max_dim > 0 &&
> +		    (new_state->crtc_w > cursor_max_dim ||
> +		     new_state->crtc_h > cursor_max_dim)) {
>  			drm_warn(&vmw->drm,
>  				 "Cursor dimensions (%d, %d) exceed device max %u\n",
>  				 new_state->crtc_w, new_state->crtc_h,

This patch bricked my testing VM, investigating..


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
