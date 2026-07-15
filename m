Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4507C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 23:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0505D10E1A5;
	Wed, 15 Jul 2026 23:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="QLrBYXml";
	dkim-atps=neutral
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C9E10E1A5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 23:34:41 +0000 (UTC)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-81e69a2db34so107971987b3.0
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 16:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784158480; x=1784763280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GXieirGK731dKnqo4Q/8RQmfvuOGtB9/de8gOedyZqE=;
 b=JiEWihAK76HbdXJiYvr+lpE3B8bhnLhv2WhLD8NaFOED5nidFZtrkuQfpkMuObdvKn
 eAvPNPYUoVnMBH/Zz3xx6UPihcVyv6UXkwJ6pierB5oWNx606iUjvjmZ1wkkmxPM7GQE
 nt0qJ5xDpYl415Pv8ZaosEbfcPOTVjQLXDTSWt5saaCsSob9QLA3z+43O6kSLQzOzMaJ
 IZUvSU3iO3LJh7+UI9s/HTh69lvc8Vg4y3N1aPrnMRkh4CDI9xtS8xuSNKbWa8agmsrK
 sxwD1BD3UEs1ypfrCqAAdqd+Lds3fE3D5kD+dPdPZLg2gbM3BDIk3y7LO2cXRi9EI57y
 m/uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RokkUYG5qr2NWqEr4Zyf8iiE1HS72BFt3CwdIwvZjVLdkILNak7heCQxHB9rnMKr0LB8zcOy+gbNC0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqmD+RjKqTGAkQZNoc6xRiHjGZH4ZfDyxbwn5xtER6cgD8No2C
 a7PgeYiB5GcBxSVbv9VRgvWzSs5iCpSKt8oKIvsA5T0KEOCTlE1vtCJF9pE3HBNMm/BjpvlqS6F
 DMtZ97lmIpjADabkAH1BF11814RDE2mVFXGI1x9JQbOG2Vn1UHUH0uo3ACGo5wungzJ8ZHDDMrJ
 iQA0Cy2O8NWM1PO4Jw/JaVveyN2fJWhcgDOCl9/klp0FbMuzmXsZJvjIhrmla9P7ffGCMSzISbT
 fqgKpMwA6eIP4jPwMX6NI0v0nuT
X-Gm-Gg: AfdE7clZ4fXrsdFTBr73tbHZ+KMgd5BM/a0ZwnMBnPO1qxW1lmNmx/9OmBxlPR+PRx/
 WrIrMjoFdKou3bFNMZAPaMm5BKoUv/x7tFwwEgi9He10s7QbohsgSWsVvZ+ZFQOQyevZWXyWsJW
 gCRnKowp3O2yT0BwOnShKNTrEZVmfLxDeHn0umYGI96Ghss/+h6Qcs9WV7er9hotuwlVXKRE2id
 5a1DCmzbjeATjHPnXyzBRX+91CXrSr3q7YVeC1DtO0nkv1sg2zLU253/k5NTNVLCHLcWAiiOs9U
 /QeqQfb6cBoNVsDfUg0kxzyhg0vy3LcGr/gcINjjZWJtIWtz7GLogpGsU/83++aKWxQYLsE1CFd
 uMazqUkEe6BIhI7mbzzZKuzz0Y6zXzm7E/LUKjfHYko38lpH4wT+YR3Qm00IfrOwBICensDwJSJ
 C7BjQ7WC0FRse1GPUd4pa0cXUi6S/Pyh+RzJD01SkC
X-Received: by 2002:a05:690c:4b13:b0:81d:6eec:fe22 with SMTP id
 00721157ae682-81ecfa0f945mr37173717b3.44.1784158480106; 
 Wed, 15 Jul 2026 16:34:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-81ed2b15584sm1359207b3.21.2026.07.15.16.34.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 16:34:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517e054fe07so124470341cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 16:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1784158479; x=1784763279;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GXieirGK731dKnqo4Q/8RQmfvuOGtB9/de8gOedyZqE=;
 b=QLrBYXml5KelNfln/9cRNtNOU2UtMBc7yIHhKR6NvZSyL7/O9UBvRcnWu7zAvN4TKp
 NNRXSwsg+2zgrnWlHWsc0huNIozL8fqtTnd8Xm0pmZILSe73DFKouWR7w244TpHoJ3iq
 oGY4ds482V4apTJV7gV+9G9WElJcnJr1+A/nY=
X-Forwarded-Encrypted: i=1;
 AHgh+RoAh9XmLXGJtzGVOYf1dd7uU2VdUeEaFRlZ0k592Uqygv91r2Op5ip3leGTXTDIs++E32uO5j+4cY4=@lists.freedesktop.org
X-Received: by 2002:ac8:5d50:0:b0:51c:bc76:dae0 with SMTP id
 d75a77b69052e-51e4f0bb49dmr50595701cf.57.1784158479411; 
 Wed, 15 Jul 2026 16:34:39 -0700 (PDT)
X-Received: by 2002:ac8:5d50:0:b0:51c:bc76:dae0 with SMTP id
 d75a77b69052e-51e4f0bb49dmr50595521cf.57.1784158478967; 
 Wed, 15 Jul 2026 16:34:38 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-904116650b7sm183978416d6.8.2026.07.15.16.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 16:34:38 -0700 (PDT)
Message-ID: <2df4713f-bf61-40de-a43f-5079e3b5d5fa@broadcom.com>
Date: Wed, 15 Jul 2026 16:39:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: uninstall the IRQ before freeing the command
 buffer manager on unload
To: Fan Wu <fanwu01@zju.edu.cn>, Zack Rusin <zack.rusin@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20260714094511.2960308-1-fanwu01@zju.edu.cn>
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

On 7/14/26 2:45 AM, Fan Wu wrote:
> vmw_driver_unload() frees the command buffer manager before uninstalling
> the device IRQ. vmw_release_device_late() -> vmw_cmdbuf_man_destroy()
> frees the manager, while the threaded handler vmw_thread_fn(), released
> only later by vmw_irq_uninstall() -> free_irq(), dereferences
> dev_priv->cman without a NULL guard and is the sole producer of
> schedule_work(&man->work), whose worker vmw_cmdbuf_work_func() recovers
> the manager via container_of(). dev_priv->cman is never NULLed on the
> unload path, so a handler woken in the window between kfree(man) and
> free_irq() runs against freed memory and can re-arm man->work after the
> manager's cancel_work_sync() has already returned.
> 
> Reorder the unload path to drain pending fences, then uninstall the IRQ,
> and only then free the manager: free_irq() guarantees the threaded
> handler has exited before kfree(man). vmw_fence_fifo_down() is called
> explicitly before the IRQ uninstall so its dma_fence waits are signalled
> by the still-live threaded handler (vmw_fences_update() in
> vmw_thread_fn()); uninstalling the IRQ first could force pending fence
> waits to time out at VMW_FENCE_WAIT_TIMEOUT. vmw_release_device_late()
> is left unchanged because it is shared with the hibernation path; its
> existing call to vmw_fence_fifo_down() runs against an empty fence list
> after the explicit drain above.
> 
> Fixes: ef369904aaf7 ("drm/vmwgfx: Move irq bottom half processing to threads")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 599052d07ae88af2f5775f968fe1e7046a3efe4e..dbe02fe8d8571587733d6f002436bf18dac1887a 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1181,10 +1181,11 @@
>  	vmw_devcaps_destroy(dev_priv);
>  	vmw_vram_manager_fini(dev_priv);
>  	ttm_device_fini(&dev_priv->bdev);
> -	vmw_release_device_late(dev_priv);
> -	vmw_fence_manager_takedown(dev_priv->fman);
> +	vmw_fence_fifo_down(dev_priv->fman);
>  	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
>  		vmw_irq_uninstall(&dev_priv->drm);
> +	vmw_release_device_late(dev_priv);
> +	vmw_fence_manager_takedown(dev_priv->fman);
> 
>  	ttm_object_device_release(&dev_priv->tdev);
> 
> --
> 2.39.5
> 

With this patch we would miss any command buffer processing done on the svga
device in the window between irq_uninstall and vmw_cmdbuf_man_destroy(), so it's
better to leave the takedown order as is.
If you want to address the case where a thread_fn awoken by an earlier irq is
scheduled before irq_uinstall but after vmw_cmdbuf_man_destroy(), then just add checks
to vmw_thread_fn(), though I'm not sure if that case is even possible since the
command buffer contexts should already be taken down at that point.


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
