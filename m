Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C42BCCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 409C410F51A;
	Fri,  1 May 2026 13:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="EWNOLZEl";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 011C110F51A
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:40:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 018EB1BB2;
 Fri,  1 May 2026 06:39:56 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 675DC3F62B;
 Fri,  1 May 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777642801; bh=unQcCluFJKXcuSYRmpVgmhqZyYy4c/7Ujfxej19oJzg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EWNOLZElCZnFJh30IoKANbMR/FiJfq2oe+6jxPmgDGzmP27x0sx2DQqkiitDSJOxw
 HFKvJZoUM1Q6smTEaBr2NmA4t3x8jKPmP0zZP3DXapWcM9VLweONXUVSf6B1fmz8Bl
 8vfxtSGl6K0INXKyWVFeMD8tXAuH4Q5shWuMfQiw=
Message-ID: <ef00c5da-54d9-4dd2-93b3-74b7f1480585@arm.com>
Date: Fri, 1 May 2026 14:39:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] drm/panthor: Make panthor_fw_{update, toggle}_reqs()
 callable from IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-5-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-5-4b92ae4142d2@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 29/04/2026 10:38, Boris Brezillon wrote:
> If we want some FW events to be processed in the interrupt path, we need
> the helpers manipulating req regs to be IRQ-safe, which implies using
> spin_lock_irqsave instead of spinlock. While at it, use guards instead
> of plain spin_lock/unlock calls.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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

