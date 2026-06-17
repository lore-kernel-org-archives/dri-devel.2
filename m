Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D013CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4950892F2;
	Wed, 17 Jun 2026 09:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OHpaezra";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2472F892F2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781688658; x=1813224658;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=1RcY6TkgIvu+YD8Qh498wsy0au7SHA5xij2Kv5o3xsA=;
 b=OHpaezra1V6O8WS6/zUybd088IlEVhAnXJB5sSSS+eIq6s7zUyWGKAST
 92UcqMIX8tYAwnbJSxG20FFxs7ZhPgpNMJqom7ap52Ahm+VGWaUX/k9oC
 0O0cw3Qt0Hd29CICiLEpb3VC6wV0rQtjE06GC2gRckoYLxgoqHg46ja5Y
 1vfp4l5lby6t65m1jcXXp/hpaZr9hG3yVO9TvFzPNoeC5+6Hu9KgZTKq4
 tjOFlB/pVz4LLFMeYvNaJ/mSHSev4zOZamGGBqwjO9XzWcfQhIuEovLnX
 DlVWAvW5ye/XczvmJewUAueIBc4QdScKfUSb5zIJwBioof5SvLXZe2tGx A==;
X-CSE-ConnectionGUID: exLWScbkT0qmt5sEs0hAQg==
X-CSE-MsgGUID: s5KBC3cyRtuNIEFQtYPjbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82584005"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82584005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:30:58 -0700
X-CSE-ConnectionGUID: 2H/0qSkVS8C0Z3mAFE149A==
X-CSE-MsgGUID: R74gdu36R/2dCpE7Av0q9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="247125422"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.80])
 ([10.102.88.80])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:30:58 -0700
Message-ID: <152b33a6-13f6-4c38-a0f0-a3d851249833@linux.intel.com>
Date: Wed, 17 Jun 2026 11:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Drop IRQF_ONESHOT to allow IPC IRQ threading
 on PREEMPT_RT
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
References: <20260617092031.3016582-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260617092031.3016582-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 17-Jun-26 11:20 AM, Karol Wachowski wrote:
> The IPC RX hardirq handler matches consumers under a spinlock and
> allocates rx_msg buffers. On PREEMPT_RT these spinlocks become sleeping
> locks and the allocation may sleep, neither of which is allowed in true
> hardirq context, resulting in "sleeping function called from invalid
> context" splats.
> 
> IRQF_ONESHOT makes genirq keep the primary handler in hardirq even when
> forced threading is enabled, so on PREEMPT_RT the handler cannot be
> threaded. Drop the flag so the primary handler is threaded on PREEMPT_RT
> and the IPC RX path runs in a context where sleeping is allowed. On the
> MSI interrupt chip (IRQCHIP_ONESHOT_SAFE) the flag was stripped anyway,
> so non-RT behaviour is unchanged.
> 
> Fixes: 85c9cc2d25f8 ("accel/ivpu: Use threaded IRQ for IPC callback processing")
> Cc: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Cc: Karol Wachowski <karol.wachowski@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 6b34c52b1fba..95120957f42a 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -623,7 +623,7 @@ static int ivpu_irq_init(struct ivpu_device *vdev)
>   	vdev->irq = pci_irq_vector(pdev, 0);
>   
>   	ret = devm_request_threaded_irq(vdev->drm.dev, vdev->irq, ivpu_hw_irq_handler,
> -					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN | IRQF_ONESHOT,
> +					ivpu_ipc_irq_thread_handler, IRQF_NO_AUTOEN,
>   					DRIVER_NAME, vdev);
>   	if (ret)
>   		ivpu_err(vdev, "Failed to request an IRQ %d\n", ret);

Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
