Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB59C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 13:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FB810E171;
	Sat,  5 Sep 2026 13:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="FPFaVBrL";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD9110E171
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 13:25:18 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-855d2bfae95so3550454b3a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1788614718; x=1789219518; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UCPQY2s7Li9KbXRAy98AdJWgLwoyUR6+yD7sEQfOnDg=;
 b=FPFaVBrLI1D3FuWAF7r+n8ZklWk5Fkj4yCJ1M3Vqn6NywlFcy1RoG2XG7ihIfdJB3B
 uKAk6BSbWsQJT47/FmpQWyr+GCKb8zbGzbq/6SFvJk1thDIKt87rgl5jQUBhDet7RkH1
 vkcmKdVf7pPCyXRswrXjtbSk1LQl6TYohFHC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788614718; x=1789219518;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UCPQY2s7Li9KbXRAy98AdJWgLwoyUR6+yD7sEQfOnDg=;
 b=lO8XrjQideUQKQvduFrnmtRXgEJX5QIEyLftoZVt/VAFp+EVlDFfciQweCCvp87Zdo
 EF7eEArHLl5ttVF+EQxpgsITPPbg6LAt3ShqP4BbFbswfu7iTEDUvwIBLFU2pLkegVKC
 vtAqU5HSmG8E8SP0nroNyE1kcYmHsg4/kiYnhbUIkdSKKcrWX0P4WRHSx+1GuDCxi4e1
 N2LJCLLDtp327sVi8NIQFFwxPjFPp1K9TpVB2fS75Siioe5yDqAugj9ep6XSV9GPNM/2
 nXkPJDTN2xwrZEZq2HnQSHXTR0OTZDqnvEUttdKgYBKJmtYGpKof8/eVVyH0PkQxEMcR
 rSZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaWIma9ZX69qnjvZ4MsUV5dw7BLE7UcohN2OOb+ZPppjUjKH5KJPA/724GDbnkCqagZOnKiIdpchY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2V3vORfhxF/0MeTqe5sxFIFOsuky4wIC2C5v4OZoVfhLunlKI
 K/YDnZ/sQrKOx5IxDRTbH4116XOyyVusoHRZKfx97cChEHi0SOprxIIPvR9EKWrBX/0=
X-Gm-Gg: AYBFou0h9nzItIt1PqsCzzvoD9hyQX6LAUrWRqA63FPu90VT694vmGrARB1hpXqk19h
 jGC11+r4Q8c2yiK5JJdHv9pRodWrxZ/z+djHlC1ER1FRMhSphZtsnsxj18S6PcxE5xJ3BDEsrO+
 1eeS1Xa7+FmidXG4qsfNN1AXF3jADI6TOFkBWXOvd8WVBhrYENDiisRTvXVwSwB2vPREpvlz016
 TnMohBUaU+JBYyMWu/ljGZ/ZdItIK7QNru0Zs1VHSBRIZGgTkH6wXPqYXY0wFWGuQsZ8lO3oYTn
 +BVIiRDP5IcJMWNnzWYYvKWyuj44meUOgm8JtrhKrEO9s7Q+YovmIwklBHtlx8jXzcII/Vkp8Qk
 UlehQ4Z9VTWAek0V84++KPjZ+B/3+RV8/CrdPKdq9+i9L1FVyplX+Gi/LlrkAk2OI0FNfE4iL+m
 brGrmrGlpZHkDdo3y2TFRwhAgd9jsmWSDNHySyjeQbbUZJrzGITe/XG88WEPtVxYW3
X-Received: by 2002:a05:6a21:a395:b0:3d3:aed2:6f28 with SMTP id
 adf61e73a8af0-3da2168b2c9mr18634503637.28.1788614718057; 
 Sat, 05 Sep 2026 06:25:18 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc465376831sm903641a12.9.2026.09.05.06.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 06:25:17 -0700 (PDT)
Date: Sat, 5 Sep 2026 22:25:02 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Message-ID: <apwUewaRnoTNXHCt@rock-5b-plus>
References: <20260904125936.26234-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
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

On Fri, Sep 04, 2026 at 02:59:36PM +0200, Igor Paunovic wrote:
> rocket_remove() decrements rdev->num_cores for each core it removes,
> while find_core_for_dev() searches slots 0 to num_cores - 1. Unbinding
> the cores in the order they were bound therefore loses the last one: by
> the time it is removed the search range has already shrunk past its
> slot, so find_core_for_dev() returns -1 and rocket_remove() gives up
> without doing anything.
> 
> num_cores never reaches zero, rocket_device_fini() never runs, and the
> file-scoped rdev keeps pointing at a device that is going away. Binding
> the cores again starts from that stale count, because rocket_probe()
> takes rdev->num_cores as the slot to fill. On an RK3588, which describes
> three cores, the second round lands on slots 1, 2 and 3 while rdev->cores
> was allocated with room for three:
> 
>   rocket fdab0000.npu: Rockchip NPU core 1 version: 1179210309
>   rocket fdac0000.npu: Rockchip NPU core 2 version: 1179210309
>   rocket fdad0000.npu: Rockchip NPU core 3 version: 1179210309
> 
> The write to rdev->cores[3] is past the end of the array.
> 
> Nothing in tree reads the core array often enough to notice, so the
> overrun is silent today. It turned up while testing a devfreq series on
> top of this, where a worker walks every core a few times a second, and
> UBSAN caught the first bool it read out of the overrun entry:
> 
>   UBSAN: invalid-load in drivers/accel/rocket/rocket_devfreq.c:47:10
>   load of value 5 is not a valid value for type '_Bool'
>   Workqueue: devfreq_wq devfreq_monitor
> 
> Record how many slots were allocated and search all of them. Every core
> is then found on removal, num_cores reaches zero, the device is torn down
> and a later bind starts from a clean rdev.
> 
> This does not make unbinding a single core out of several work. probe
> still takes num_cores as the slot to fill, so rebinding one core while
> its siblings stay bound would write over a slot that is already in use,
> and rocket_open() still reaches for cores[0] whether or not anything is
> there. Both of those want more thought than a fix should carry.
> 
> Found by unbinding and rebinding all three cores on an Orange Pi 5 Plus.
> With this applied, 25 unbind/rebind rounds and 5 module unload/reload
> rounds run clean there: the cores land in slots 0, 1 and 2 every time,
> whichever order they are bound in, and the shared supply goes back to a
> single user after each round.
> 
> Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> Assisted-by: LLM sparse checkpatch
> ---
>  drivers/accel/rocket/rocket_device.c | 2 ++
>  drivers/accel/rocket/rocket_device.h | 1 +
>  drivers/accel/rocket/rocket_drv.c    | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
> index 46e6ee1e72c5f..efd004194c1af 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -31,6 +31,8 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  		if (of_device_is_available(core_node))
>  			num_cores++;
>  
> +	rdev->max_cores = num_cores;
> +
>  	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
> index ce662abc01d3d..c62d567010696 100644
> --- a/drivers/accel/rocket/rocket_device.h
> +++ b/drivers/accel/rocket/rocket_device.h
> @@ -19,6 +19,7 @@ struct rocket_device {
>  
>  	struct rocket_core *cores;
>  	unsigned int num_cores;
> +	unsigned int max_cores;

Hi Igor,

I've tested this patch in Radxa Rock 5 B+ and it works. The test is that unbinding all
cores in sequence 0,1,2 and rebind all. It seems that there is other issue about num_core.
For example, sched_to_core() finds core for sched with num_core and it could make same
error like find_core_for_dev().

Tested-by: Sidong Yang <sidong.yang@furiosa.ai> # RK3588, 3 cores

Thanks,
Sidong

>  };
>  
>  struct rocket_device *rocket_device_init(struct platform_device *pdev,
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> index 8bbbce594883e..2bcfe4ab3c68f 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -223,7 +223,7 @@ static int find_core_for_dev(struct device *dev)
>  {
>  	struct rocket_device *rdev = dev_get_drvdata(dev);
>  
> -	for (unsigned int core = 0; core < rdev->num_cores; core++) {
> +	for (unsigned int core = 0; core < rdev->max_cores; core++) {
>  		if (dev == rdev->cores[core].dev)
>  			return core;
>  	}
> -- 
> 2.43.0
> 
