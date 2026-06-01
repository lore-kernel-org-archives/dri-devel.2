Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD1CD6E62
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CC81130DE;
	Mon,  1 Jun 2026 10:16:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gfbU4dVM";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E4821130DE
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780308966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
 b=gfbU4dVMY/wH4c/7itvNad/Ic1zKdnn38GuaLQZFUumSCV2pFHlOB7Nw6wjEGSW4ZpK9m3
 viIPYyifpvhzOFK+YlWcEkALX4178HepizE86qMu9JxHsE2QSuluj2gK0fB3xaTjgHtyYT
 K3Xm3lmHoa0WYReKDXDXJmQ2Te+0xnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-8lIzJxSuP8-zuw_SJCVg9A-1; Mon, 01 Jun 2026 06:16:03 -0400
X-MC-Unique: 8lIzJxSuP8-zuw_SJCVg9A-1
X-Mimecast-MFC-AGG-ID: 8lIzJxSuP8-zuw_SJCVg9A_1780308962
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4909ea0ffbeso22693115e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780308962; x=1780913762;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
 b=lxjEiFJX6Ae12xFR/gWHGAcrxVJqLN+tZeKQ9fD6LTnl4PrCF4z7OZdprReHXt6YEQ
 Au82VwaPEH7mLvIy7QF3nV1O/5TeNQfUX+BesLFRUFgmYoBr+UDDTF5PBSxXdIeeWDGY
 pBxqtRHnqlok0t3Gz/tuLR58qPyNPOcqeogQ7Js07SEvg/bOtEaJ/JbFsMVMQJ4nTN0s
 +1EOmwKqlIspO12P2iptOUwQ15MNHAi8tsCuPolfgDYLf75j73DRo2O/LrK8Hq7o08g6
 6lCEs+GVEBF0efdQcF/9ilNiAQwGgm3F/6zfQ5yPRO9ApGewO76GY5APe1lXRlr5cLGT
 lS+g==
X-Gm-Message-State: AOJu0YwzzQzdrdCsgq7qwNY5y8vdHKfElwMHffeDoFEv6K2FFo+6lk3p
 dCOBynhORpBl9NIpuZkSTp4wmFrRtdo2u3DZnQaRqenzpHDI8FndDvbrc3mWwF9C7AysPucCDnm
 yECTMiOUxUaBjUOW00sOOdD2jXimBfibOHuToXARlyAqO/RIpre67SGym0bxwXV9YkLRSQA==
X-Gm-Gg: Acq92OF1drii8tqmLhpfGs2sftXLooOikgZitJOxGeUJSvRlnxn+q15r4R3t4FoyOB4
 p8svZNdIGAl53kM2lq5ccyifjTsLutSoy++KydjEUxT5CUW6XWu4Sdt4BNsCpm3t1C6xNie1WsR
 z+l7/JtzdPIisTbCCWBK3Rohjjr6YEmlK278yv7XMa83V3GhS2fFzayRUMqBn5DCiSum/egi9K0
 PPeUFhW+QSSP1x+LKEFtt/o45IKbKD9rTpPd+EPOlOoVIAlA2czVzp9ipfmXPo0vC+qNvd0PBXM
 ZZNUKxinEBaXy+H4oknVxQF/HYja0U7vgq4AaLA0f8zGBCv2mrOiYmcWYXRcrxVpgVjMhlkY+85
 Y8+aF4nGQVUjZXIK9vVID2E09vpmIEwmwfAjMpxz4uqSPRJOEqsqv6S8ivS9+ywJHQC6kJxPzRp
 xFCOOO4xDKwadUhNU=
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490a29838b6mr211911585e9.24.1780308962214; 
 Mon, 01 Jun 2026 03:16:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490a29838b6mr211910935e9.24.1780308961705; 
 Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef32fabcasm23621879f8f.0.2026.06.01.03.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/10] drm/damage-helper: Do not alter damage clips
 on modeset, but ignore them
In-Reply-To: <20260530185716.65688-2-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-2-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:16:00 +0200
Message-ID: <87y0gylg67.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MVdupdL886IalMX9mu3jCJOGxNGnbYOqHGJpBDo-WIM_1780308962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> User space supplies rectangles for damage clipping in a plane property.
> For full mode sets, drivers still require a full plane update. In this
> case, leave the information as-is and set the ignore_damage_clips flag
> instead. The damage iterator will later ignore any damage information.
>
> Also fixes a bug where ignore_damage_clips was not cleared across plane-
> state duplications.
>
> Leaving the damage information as-is might be helpful to drivers that
> benefit from this information even on full modesets (e.g., for cache
> management). It will also help with consolidating the damage-handling
> logic.
>
> Also add a new unit test that evaluates the ignore_damage_clips flag. It
> sets two damage clips plus the flag and tests if the reported damage
> covers the entire framebuffer.
>
> v4:
> - slightly reword the commit description
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  1 +
>  drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
>  .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index cc70508d4fdb..84d5231ccac1 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -359,6 +359,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>  	state->fence = NULL;
>  	state->commit = NULL;
>  	state->fb_damage_clips = NULL;
> +	state->ignore_damage_clips = false;
>  	state->color_mgmt_changed = false;
>  }

I would split this as a separate patch since is the bug you are fixing for
commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to
ignore damage clips").

>  EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 74a7f4252ecf..945fac8dc27b 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
>  		if (WARN_ON(!crtc_state))
>  			return;
>  
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			drm_property_blob_put(plane_state->fb_damage_clips);
> -			plane_state->fb_damage_clips = NULL;
> -		}
> +		if (drm_atomic_crtc_needs_modeset(crtc_state))
> +			plane_state->ignore_damage_clips = true;
>  	}
>  }

This makes sense to me as well and I agree that re-using the flag for this
is better than making plane_state->fb_damage_clips == NULL the condition.

As mentioned though, I would make it a separate patch. Both changes look
good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

