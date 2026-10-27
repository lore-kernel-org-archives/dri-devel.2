Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFF606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bvRE8z8J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BEEA10E27B;
	Tue, 27 Oct 2026 02:16:16 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84F510E05F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 02:16:09 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e47347279so1466851f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 19:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793067368; x=1793672168; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=213hVxaY8zz7NJ3gzXzSYUeeO0Hb0kJ1MH6CZUy6aio=;
 b=bvRE8z8JdFeO0qKr8ktC/A2Nk10bzaVEmThAY27UWQFk6MuvuajSOvVg4WgBx0OTPB
 HQ6VJhSc3APTyl/LGLOF+UU5z7h5GyIjPibKR5cdqxMN32xbGUgeaaZI0nOIHXJoIl/m
 3/Ooec7CvyardFoU/y/9uH/5js/K1HAM81Zm5tXt36XgIlM7xdNsfn2zCHpOjScc38bI
 U4DrXulN6+n9R0gAhJngM3UF/tDBjDp1P/hY8OxBX/+W7frLM9fcZTyDTwiWE54E8OrV
 Gufxwe2BhIc3Io4FHt9dnbGGh2WKqC1VAR/JY9FOe9zKQfVFWyEiCHKLfZq0ZTXRK1bH
 7dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793067368; x=1793672168;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=213hVxaY8zz7NJ3gzXzSYUeeO0Hb0kJ1MH6CZUy6aio=;
 b=JEjbuOTx7w9L1hYFxe6pJSoFcvSlFGpwpR2qrwwt37qh47kSZdGEgjV4R09k4W1UUt
 +3w7MtJJqYFHzERoTIV/LroX5RbvCRI6DcJTq4xPEHeDzE9Re5Mq1pEIsfJUjTrMgVn6
 lwiW5/a8sXiBWw2PSkWB7evXx+cZj0rTbWUJGBqR2QQVLTJSti7afrojOn+QpOXS9EV5
 zsBo+xrLEo1avpXPTdMHWHFwq0viJFfyJ5ZEVh+aoUVJZZB4MxTKZKQj7iGa0Fl/nBTM
 6CoaZIloWQVf3zk8x1m2qCArb0cS4ParT4nb4MFEsau5r2DXMWYsihC4ihfJwMxPvDIz
 xjMg==
X-Gm-Message-State: AFq9FYI5UC2gWflZp4Xm1Q811UceaWSDrEzxxcJi6R+bb1uW9N+2OTLU
 zAleesTXRJyy9bbUkzBELfhVBBQkxsc3NbNdT9jxmsCEGPW7NfZeTxsY
X-Gm-Gg: AYBFou1HtYuBbP9ndl7Rzd2K+vIo3QMslo4D0zixfSLERR/eW+krWh8XNIHTFBezjCY
 H67mcfOKWyhQyj7hiifUYpgxUlffvySOoHzhA3ppDPs60jL5kVJEaaOkYgMdF9f+LPp14lXXHfK
 QRjp6X6XG4ZOjDZ1wH9sAsSwyURurAtBWxbMEGa4wVULSCh9X6gYmk65UPBr09Uxt7rZnDgcPQu
 mP8sqPQtBO+i4vUix6GEN/wmcvz3QlkHR/WlRasH+gGOveKr08VmeqOlZZBgmWbNkEkgnF2uh2v
 oMiYpinmoxHYhb/foi17xWMqZJHM7TuzArJ7kwqaWMMYio7hE9vmvzxqCO5louKr6ybNoCpgyEX
 MW3hZLwE5tmti1vl6uHlkhv+tSnYw4n6XCvjxj8rL1g0YJ90f3bWHfzk/8N1LHVS9i85MTLtj+7
 zEUT8/+rxSc+wvls3PpJoMntFD9a78rMTQhs0/EgV7OYbNxh4Ok+8hW9dD2XuIaQiHU2nzDgqKb
 205OP9b91Gxow1w/ZJw9IwSV3nHMGiLR4nutaYN9RA2dT+eeWII5OOJnyDeiFBt3YnPSLj2FXen
 ZhZP8Rt6jUGsMBMKByZI0Me4UlDoU3PizXRx+xwYXEzDLHpBvyyasJ4fbwTOv3Z8V2DaD36kH41
 DvhF9vfsVkGPZpoGrKVy8IOC92Wt43JWpBjrVR09E
X-Received: by 2002:a5d:6406:0:b0:48e:202:6718 with SMTP id
 ffacd0b85a97d-48e3eb8bbe9mr13317253f8f.25.1793067367758; 
 Mon, 26 Oct 2026 19:16:07 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-095-117-118-122.95.117.pool.telefonica.de. [95.117.118.122])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm19591505f8f.14.2026.10.26.19.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 19:16:07 -0700 (PDT)
Date: Tue, 27 Oct 2026 03:15:34 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
 sumit.semwal@linaro.org, jgg@nvidia.com, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, 
 treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 23/26] treewide: Rename dma_buf_attach() to
 dma_buf_sgt_attach()
Message-ID: <auAIO0y09SXk34CN@gmail.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-24-apopple@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026053623.202642-24-apopple@nvidia.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 04:36:14PM +0100, Alistair Popple wrote:

Testing the series on a Jetson Nano exposed this path. A 3 MiB system-heap
buffer was imported into Tegra DRM and scanned out over HDMI. With
CONFIG_DMABUF_DEBUG=y the PRIME import succeeded, but scanout immediately
produced display SMMU faults starting at 0x300000.

Tracing the fault led here:

> @@ -475,7 +475,7 @@ static struct tegra_bo *tegra_bo_import(struct drm_device *drm,
>  	 * domain, map it first to the DRM device to get an sgt.
>  	 */
>  	if (tegra->domain) {
> -		attach = dma_buf_attach(buf, drm->dev);
> +		attach = dma_buf_sgt_attach(buf, drm->dev);

tegra_bo_import() passes the attachment SGT to iommu_map_sgtable(), which
uses sg_phys() and sg->length. The SGT mapping contract only guarantees the
DMA address and length fields. The debug wrapper clears the page-side fields,
so iommu_map_sgtable() maps zero bytes. 

Tegra only treats negative returns as errors and keeps the reserved
IOVA, which scanout then faults on.

This page-side use predates the series, so the fault is not itself a v2
regression. Is dma_buf_sgt_attach() valid for this call site, or does Tegra
need a page/physical mapping type first?

Karl
