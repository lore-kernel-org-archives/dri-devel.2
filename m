Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA23CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3368D113096;
	Mon,  1 Jun 2026 09:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="idGddNuX";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55DF7113096
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:35:08 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-4908af8d7f9so36386425e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780306507; x=1780911307;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qzoIJLJjC7gwyV4Qyenrvhg4O6REcPg+RlZKz2lhFlI=;
 b=idGddNuXowEfK52fzKMZoqxA74RcyMxYq3RMyDlHtydm3K4DES1V5aouTq37Tr6TpU
 X3XwapLswCh9+cuIypIg4asM423MX8XqE1RpAdiDUs+UEiC0X4LYAU4wvBdtqwc7R62+
 /SmF6gEhPT1R+D/OXOduamcdqMzgD22LhfaP5rq4urMBtRVbXiEZ+NO/A790FB+IcVHA
 rREEVbuXeKgj5c+x6i0ogzdGxx40nGvnxgsM5R2DCtAIQSerulFakd7EddDXDjUUqCNP
 ZXr57uUHxpDI25PC3VyvLQKWHdnu5UTD5a+NYh0XOYxcfqrGiw6AkcIbSu9Ridi+ujTH
 QD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306507; x=1780911307;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzoIJLJjC7gwyV4Qyenrvhg4O6REcPg+RlZKz2lhFlI=;
 b=M10mDSe+8AM7BX+J3pLsI1EluDsszLcZHZu3eGL+59E/5Ojlss/YMpHPeo+RPh4HNp
 QT/Lnnd31h9H76xILzD7Vh6KFQQ7Wwt+6KNIENgG9zP58+QxGJw+jRXqzNHePeCaZ7Cz
 3ViFb3lzaVh4d5VTwNiMzOrEWTKF/gU+nNjyxUoI+G9L8NPk/WRroTuSzSsgA7SSfPL8
 8jjptQBmATgWv3TbJyBJhUh5SVaB0ODCn/0Kmv2Urkp9AqXtF+msl3jQqfLqcgwIhBnK
 hQ2qbnyKcjDbxZ6X4rlogWzlhfEvGQTtIxKiRmiP4tZuOtTZqYNWVDoUGN6Y90yHn0vX
 Ua6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tUa/0B4g6uhaxVhmkzuOtGpFu8FTRwV+UD/GhYh7f32eGRCyRGvTmfgBTbmhpxSZBFv8ytPms1q8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9vj1UKgFbz05uxr3T6/nsC/j9BfIOGSb3oDfoGA66JvTgvxv5
 bTzdh8AUYjwf1uherNnjo2KmpSiaX86dLn+wdswipsADV0oWJFhn6KAZgS26/XvcO3cXRhxbbry
 TThqqIZCfTkWULOJ7qg==
X-Received: from wmog6.prod.google.com ([2002:a05:600c:3106:b0:488:890d:75d7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:430a:b0:490:482c:4391 with SMTP id
 5b1f17b1804b1-490a2960885mr112155905e9.23.1780306506184; 
 Mon, 01 Jun 2026 02:35:06 -0700 (PDT)
Date: Mon, 1 Jun 2026 09:35:04 +0000
In-Reply-To: <20260529000106.2257996-3-dakr@kernel.org>
Mime-Version: 1.0
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-3-dakr@kernel.org>
Message-ID: <ah1SSN8_dCEA4Osz@google.com>
Subject: Re: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, boris.brezillon@collabora.com, 
 deborah.brouwer@collabora.com, gary@garyguo.net, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset="utf-8"
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

On Fri, May 29, 2026 at 02:00:54AM +0200, Danilo Krummrich wrote:
> Now that IoMem is lifetime-parameterized, use it directly in probe
> rather than wrapping it in Devres and Arc. The I/O memory mapping is
> only used during probe and not stored in driver data, so device-managed
> revocation is unnecessary.
> 
> This removes the Devres access(dev) pattern from issue_soft_reset(),
> GpuInfo::new(), and l2_power_on(), simplifying register access.
> 
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> -pub(crate) type IoMem = kernel::io::mem::IoMem<'static, SZ_2M>;
> +pub(crate) type IoMem<'a> = kernel::io::mem::IoMem<'a, SZ_2M>;

It'd make more sense for me to put 'b or 'bound here.

>          let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
>  
>          let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?.into_devres()?, GFP_KERNEL)?;
> +        let iomem = request.iomap_sized::<SZ_2M>()?;
>  
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
>  
> -        let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
> +        let gpu_info = GpuInfo::new(&iomem);


While this change is fine, I notice that we don't actually keep the
iomem alive past the probe method. I assume we're going to need that,
which leads to the question of whether we can store the iomem in the
places we need it.

As far as I can tell, we can store it in TyrPlatformDriverData but not
in TyrDrmDeviceData, is that right?

I guess it does make sense because the io memory goes away if the
underlying platform device (the bus) goes away, even if the drm device
still exists due to open fds from userspace.

Alice
