Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46948CCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B699B10E3E9;
	Wed, 29 Apr 2026 13:33:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="etTLiPUA";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2057F10E3E9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:33:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7162574
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:33:53 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 504923F62B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777469638; bh=5te7r2BHOvYm4RuayRqfKSycIm9FG1qfCbfy8BvsfgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=etTLiPUAxfCpk3COCGGhVEc2hpvC8ASKV1kKUoCXarBA4EKdLeldGJLzQtuZYUduq
 dcraLAnFzhZ+/Oz3iVYX69IC0VCeFqEIMXXkLG8oCcBbTLzrontRxt8aDmdcoxzsj9
 xF3wT65CHhteA6uVXV0q7gvv9QqHXln4UP+TJiFE=
Date: Wed, 29 Apr 2026 14:33:50 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] drm/panthor: Make
 panthor_fw_{update,toggle}_reqs() callable from IRQ context
Message-ID: <afIIvrGK-t3t9TgF@e142607>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-5-4b92ae4142d2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429-panthor-signal-from-irq-v1-5-4b92ae4142d2@collabora.com>
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

On Wed, Apr 29, 2026 at 11:38:32AM +0200, Boris Brezillon wrote:
> If we want some FW events to be processed in the interrupt path, we need
> the helpers manipulating req regs to be IRQ-safe, which implies using
> spin_lock_irqsave instead of spinlock. While at it, use guards instead
> of plain spin_lock/unlock calls.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index a99a9b6f4825..e56b7fe15bb3 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -432,12 +432,11 @@ struct panthor_fw_global_iface {
>  #define panthor_fw_toggle_reqs(__iface, __in_reg, __out_reg, __mask) \
>  	do { \
>  		u32 __cur_val, __new_val, __out_val; \
> -		spin_lock(&(__iface)->lock); \
> +		guard(spinlock_irqsave)(&(__iface)->lock); \
>  		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
>  		__out_val = READ_ONCE((__iface)->output->__out_reg); \
>  		__new_val = ((__out_val ^ (__mask)) & (__mask)) | (__cur_val & ~(__mask)); \
>  		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -		spin_unlock(&(__iface)->lock); \
>  	} while (0)
>  
>  /**
> @@ -458,21 +457,19 @@ struct panthor_fw_global_iface {
>  #define panthor_fw_update_reqs(__iface, __in_reg, __val, __mask) \
>  	do { \
>  		u32 __cur_val, __new_val; \
> -		spin_lock(&(__iface)->lock); \
> +		guard(spinlock_irqsave)(&(__iface)->lock); \
>  		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
>  		__new_val = (__cur_val & ~(__mask)) | ((__val) & (__mask)); \
>  		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -		spin_unlock(&(__iface)->lock); \
>  	} while (0)
>  
>  #define panthor_fw_update_reqs64(__iface, __in_reg, __val, __mask) \
>  	do { \
>  		u64 __cur_val, __new_val; \
> -		spin_lock(&(__iface)->lock); \
> +		guard(spinlock_irqsave)(&(__iface)->lock); \
>  		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
>  		__new_val = (__cur_val & ~(__mask)) | ((__val) & (__mask)); \
>  		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> -		spin_unlock(&(__iface)->lock); \
>  	} while (0)
>  
>  struct panthor_fw_global_iface *
> 
> -- 
> 2.53.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
