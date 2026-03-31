Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18819109B469
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8E710E8DB;
	Tue, 31 Mar 2026 13:29:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hO6QZpV6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C9310E8DB
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmQr7lvUi7CleCZhnpY8MZwCa3FGHXyrfWOChqNgJtU=; b=hO6QZpV6SKuYzAhg10JDAo3ldl
 hdjTpoTJFwhbpwHIhTqq5cUfhgpKCNiZS3jtlIbFMsa4fs+g9yMm5cG8Yva/ASCKMe75AkSvNud0w
 3VIppscoITWkwJGK2+SBZTVsygLM8d+piaOiYxzwKVgpRdhwiBuBA3sPN5TC3JljJSvIPElYkI4pK
 /Ecm6hLQD2hpQFLhy9ihtINNJJmA+tc7cc3w9C9wqqkFn/P9Il2L7IN8drPDlGHrZyVcXf5np4nl2
 PIrhIwKtLg07icNQkCzMaXoyUY12mgHTzFAO5Es4X2BZ/2PqowQhOQzCbO036RsR2RBcvGDy3MgqL
 X/OwfbBQ==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7Z9m-009TDQ-QX; Tue, 31 Mar 2026 15:29:23 +0200
Message-ID: <09893e7c-2256-477a-b031-eff48c3b5387@igalia.com>
Date: Tue, 31 Mar 2026 10:29:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/vc4: Use devm_request_irq() for automatic cleanup
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
 <20260330-vc4-misc-fixes-v1-5-92defc940a29@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-5-92defc940a29@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 30/03/2026 14:51, Maíra Canal wrote:
> Switch from request_irq()/free_irq() to the device-managed alternative
> devm_request_irq(), letting device-managed resource cleanup handle IRQ
> teardown automatically.
>
> While here, inline vc4_irq_prepare() into vc4_irq_install() since it's
> the only caller.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_irq.c | 33 ++++++++++++---------------------
>   1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index 63e88f90eef7c0720e32547f4e8b5ed289b2427b..8e5141bb50759e19e03c911f75b78354b240406f 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -47,7 +47,6 @@
>   
>   #include <linux/platform_device.h>
>   
> -#include <drm/drm_drv.h>
>   #include <drm/drm_print.h>
>   
>   #include "vc4_drv.h"
> @@ -242,23 +241,6 @@ vc4_irq(int irq, void *arg)
>   	return status;
>   }
>   
> -static void
> -vc4_irq_prepare(struct drm_device *dev)
> -{
> -	struct vc4_dev *vc4 = to_vc4_dev(dev);
> -
> -	if (!vc4->v3d)
> -		return;
> -
> -	init_waitqueue_head(&vc4->job_wait_queue);
> -	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
> -
> -	/* Clear any pending interrupts someone might have left around
> -	 * for us.
> -	 */
> -	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> -}
> -
>   void
>   vc4_irq_enable(struct drm_device *dev)
>   {
> @@ -307,12 +289,22 @@ int vc4_irq_install(struct drm_device *dev, int irq)
>   	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
>   		return -ENODEV;
>   
> +	if (!vc4->v3d)
> +		return -ENODEV;
> +
>   	if (irq == IRQ_NOTCONNECTED)
>   		return -ENOTCONN;
>   
> -	vc4_irq_prepare(dev);
> +	init_waitqueue_head(&vc4->job_wait_queue);
> +	INIT_WORK(&vc4->overflow_mem_work, vc4_overflow_mem_work);
>   
> -	ret = request_irq(irq, vc4_irq, 0, dev->driver->name, dev);
> +	/* Clear any pending interrupts someone might have left around
> +	 * for us.
> +	 */
> +	V3D_WRITE(V3D_INTCTL, V3D_DRIVER_IRQS);
> +
> +	ret = devm_request_irq(dev->dev, irq, vc4_irq, 0,
> +			       dev_name(dev->dev), dev);
>   	if (ret)
>   		return ret;
>   
> @@ -329,7 +321,6 @@ void vc4_irq_uninstall(struct drm_device *dev)
>   		return;
>   
>   	vc4_irq_disable(dev);
> -	free_irq(vc4->irq, dev);
>   }
>   
>   /** Reinitializes interrupt registers when a GPU reset is performed. */
>

