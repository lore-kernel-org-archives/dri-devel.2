Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BC0C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 20:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F0AC10E043;
	Fri, 24 Jul 2026 20:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CcAG9U/A";
	dkim-atps=neutral
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80F010E043
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:07:41 +0000 (UTC)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-664c6304683so735266d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 13:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784923660; x=1785528460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O87kJCBhVSrXeMQLPuEgMpocdJnGzImKIzvyu9Sbd1E=;
 b=mL61oqbDZZCYAnS3ZQ4Rz2ldN5bwE00FaZqpK4sxco4x77s/ggwToF4EhMu5+DQsFB
 44X32sfbn0D2rJwDtxQFiZGoBzhFkstiJ2uCNkTx3U6jZpKkOYA0CFV2AuDnYgfmkFo5
 iOD3R1BRDS3es2S9zmrFLL6+2icNL+JhJGwrIN7xd29qUdxeGER5M0gTAfPf71qIdM1E
 06kD+tbncPBWIjMXnbqI4U25OYKfTCccrp59lxNlRPgi4xDWI9/0te+kgmUjdEdgkKZe
 3TSQXKy6C49zzb46jP2UAcp9ZRMRRD88Rf6ZZweyYNLu8psnhQljEmDRvcCj+95CYAgQ
 bYIA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh4qf+C8/yRmt076QQTLn3nRBNLCg+dEARCWqtk1qsLrMkfSL9R8Fw207JfmhCOueV4+M05uz5EbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsVR1tnrRXYKFBZMAoAXFFUoCQg35Q/JKyt4eF29C2BOejQN8S
 k1DaTV2Way/DCDySbojIMKPs3q/jLb7Jh+kMKgSQl/1t7ygd8Lkwj1oRQ8kBL2rW+t894rxzATn
 5n3OKzwT0/7hwAGeQYfCaoc7QZXWLfcoiAVR0fpyZiAq3hpnaUt7HoJxi1xWHtmB8aWGkFvucnz
 PThw1uqhPS1sAaU+i9Zn7GM7+s54VyTF9tmRs/WkRXokY/OmOo1TQ3K+cVddn5w5XLdFxBaik5M
 +KWR3bHdfTuxfVuS2qn+Q/7Kp1c
X-Gm-Gg: AR+sD12uxcIRKexgTyOt4DAnpr4QqFmdOig0OxjSw9CsnshBGtxmo85SXc05OBNw0Zx
 QgFCLjV+fnNIkboMtzI1WRL44kFYl2AKDPPBjzxmVPOA50nuQgjZw3GZ3OcuRN2CW/TzYIEug31
 JcMlwnPym3jHMvArMHn+VJQao9wOEH+LQpgwA+Tz7PfW/PLhRhfzhWp185OvLzqvReEmIBQzvr0
 CJTuUnToPw6Gyp+hOiVOeR/O3viW5B7SJUYrT4+/C1/eDxHknCb218Apw1uX+PVJ9x0PFB3nec6
 +O6Y9b/Y8KiV3vW0prYAZsLUq4+RgtQ6lYeHp/6oMePFUgF+5Vr2fO+esRHCVmjrYIbAXecYZp1
 /pf1QgUM7dSv9tXUvTejD2pTg7Fm2GP9Kqe2vuwm+myMGWj7vnUGKAHShS1ZVIAD5kl/UV62tmU
 6XYc2KO0YsC1TzPcK6xbTtKhdEuPOJpjeY9lqrkqDj
X-Received: by 2002:a05:690e:1408:b0:667:a382:baf4 with SMTP id
 956f58d0204a3-668a4cbc54fmr2575057d50.47.1784923660072; 
 Fri, 24 Jul 2026 13:07:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-66890741079sm554159d50.24.2026.07.24.13.07.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Jul 2026 13:07:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e7ee64b25so109251285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784923659; x=1785528459;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O87kJCBhVSrXeMQLPuEgMpocdJnGzImKIzvyu9Sbd1E=;
 b=CcAG9U/AhqrRCDpE1DWbwP3Ydf0aUf5g5y07xSJqzP39s60tneXnIilsymPTzHf4yb
 a4e7VlAitQ1R6pr4CgkeBDSSIhr1hz4zS+nYK+tI3bFgoPQrxS6LAX690KsfXFc60jIg
 h5dC06CMt5BEQja2SMiNB4oz2LrFvKMMeM0q0=
X-Forwarded-Encrypted: i=1;
 AHgh+RpKWQjLnyeERv/gKgQfb7ZXhZN/pkhVDpyRXAT5eaFziQ2chtNaIRpgSLYzpjNclCShy+5PiRtVdj4=@lists.freedesktop.org
X-Received: by 2002:a05:620a:3952:b0:92e:4799:a808 with SMTP id
 af79cd13be357-9310387a352mr1028559885a.40.1784923659335; 
 Fri, 24 Jul 2026 13:07:39 -0700 (PDT)
X-Received: by 2002:a05:620a:3952:b0:92e:4799:a808 with SMTP id
 af79cd13be357-9310387a352mr1028555585a.40.1784923658874; 
 Fri, 24 Jul 2026 13:07:38 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f6a6bd88sm721848685a.39.2026.07.24.13.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 13:07:38 -0700 (PDT)
Message-ID: <68f99546-7ca4-4aa2-ba5c-aa36204c2f8a@broadcom.com>
Date: Fri, 24 Jul 2026 13:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vmwgfx: Remove unused vmw_goal_waiter_add/remove
To: Saswat Jung Khadka <saswatjungkhadka@gmail.com>, zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260721080028.4464-1-saswatjungkhadka@gmail.com>
 <20260723043605.2195-1-saswatjungkhadka@gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260723043605.2195-1-saswatjungkhadka@gmail.com>
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

On 7/22/26 9:36 PM, Saswat Jung Khadka wrote:
> vmw_goal_waiter_add() and vmw_goal_waiter_remove() have had no
> callers since commit db6a94b26354 ("drm/vmwgfx: Implement
> dma_fence_ops properly"), which removed their only call site.
> Their sibling functions vmw_seqno_waiter_add/remove are still
> in active use, confirming these are leftover dead code.
> 
> Signed-off-by: Saswat Jung Khadka <saswatjungkhadka@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h |  2 --
>  drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 12 ------------
>  2 files changed, 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> index 38bea8aba..d84e077ed 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -1026,8 +1026,6 @@ extern int vmw_fallback_wait(struct vmw_private *dev_priv,
>  			     unsigned long timeout);
>  bool vmw_seqno_waiter_add(struct vmw_private *dev_priv);
>  bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv);
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv);
>  bool vmw_generic_waiter_add(struct vmw_private *dev_priv, u32 flag,
>  			    int *waiter_count);
>  bool vmw_generic_waiter_remove(struct vmw_private *dev_priv,
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> index 05773eb39..88c77226c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> @@ -273,18 +273,6 @@ bool vmw_seqno_waiter_remove(struct vmw_private *dev_priv)
>  					&dev_priv->fence_queue_waiters);
>  }
>  
> -bool vmw_goal_waiter_add(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_add(dev_priv, vmw_irqflag_fence_goal(dev_priv),
> -					&dev_priv->goal_queue_waiters);
> -}
> -
> -bool vmw_goal_waiter_remove(struct vmw_private *dev_priv)
> -{
> -	return vmw_generic_waiter_remove(dev_priv, vmw_irqflag_fence_goal(dev_priv),
> -					&dev_priv->goal_queue_waiters);
> -}
> -
>  static void vmw_irq_preinstall(struct drm_device *dev)
>  {
>  	struct vmw_private *dev_priv = vmw_priv(dev);

LGTM!

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
