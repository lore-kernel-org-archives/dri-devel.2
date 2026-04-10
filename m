Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1578BF459FC
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:53:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7122910E9AD;
	Fri, 10 Apr 2026 17:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nq41BCPZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D231C10E9AD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775843605;
 bh=8SKxaz/fg5duvBKCI2u+f3xCvRfeM+qAmhyeFF4N1jk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nq41BCPZXCr7y/vgaQ3tOWGsgz3S9/tHDnRhYzgd5cOUfBJDhpbimuWy0JITn5Is3
 ppJelFvKv99e8NsGeG/USyhaJSLLtQ0UnutN5lwEmHBYTvrypC5i8jCTllSEDGxT47
 E2Z23/M/+qfSKA0QteRMdL4ONZe9s3awc7Y9kQPdh8YIQeg4SxNZtHY4u5roA6w7LY
 LtMC5KS8SIG5zeFMei17unsgLKRoc2HJD8tA0a77YvlOPv4KXOeJ3b/J8x6xdKhXFo
 7gAhsocdmCnT66kJF840H7XjgzHComnJLY/GkyKJQo5qyRRw2hfT7B6ALS18ShqMjp
 VI0P/LBel1sSQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 177E817E09AC;
 Fri, 10 Apr 2026 19:53:25 +0200 (CEST)
Date: Fri, 10 Apr 2026 19:53:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/panthor: Store IRQ register base iomem pointer
 in panthor_irq
Message-ID: <20260410195320.71be575c@fedora>
In-Reply-To: <20260410164637.549145-5-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
 <20260410164637.549145-5-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 10 Apr 2026 17:46:33 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

>  static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
>  					      struct panthor_irq *pirq,				\
> -					      int irq, u32 mask)				\
> +					      int irq, u32 mask, u32 irq_baseaddr)		\

Can we pass the void __iomem * directly instead of an offset to apply
to ptdev->iomem?

>  {												\
>  	pirq->ptdev = ptdev;									\
>  	pirq->irq = irq;									\
>  	pirq->mask = mask;									\
> +	pirq->iomem = ptdev->iomem + irq_baseaddr;						\
