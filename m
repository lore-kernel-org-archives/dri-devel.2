Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E9FCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7605210F37E;
	Mon,  8 Jun 2026 13:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="T2YN/dfP";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31EC10F37C
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780924009;
 bh=chH11IDpgw/ukFe4MO+yw9xWfeKtf/GwnIze3xKZn/I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=T2YN/dfPCWiyuuBR5tx/edONViYdUQ07F8knJfs5jFO7rVz90ZrOxIFT/Pf6dBi9o
 XLt0Yt3gtrjbTsV8W1KWaOR78FJcheaAVZcPffrHDt4YsFOpfYqGegK6CsLoXyFMXt
 BlN8WclDQ+f5CYjKyfC9VCqHAwtBM5pbk/haltW5j9RzrFHXYj/o/vMbmQsvgHcD/k
 UZyuQjVwCKuOsZEFFpICFz6XNkYsi8TXaaRJIVc79mp19ElC2zKEG8NBV4xbqyju56
 FfNHuEXVnV6r9GwmheEaGRite9kfzMIYBuy6lxyX6dDTjssghvL6asQeP7+9jqhdEG
 G2kiF4wS2YXTA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B162517E023C;
 Mon,  8 Jun 2026 15:06:48 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:06:44 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/18] drm/panthor: Ignore -EOPNOTSUPP for
 shader-present nvmem lookup
Message-ID: <20260608150644.0e41f4d1@fedora-2.home>
In-Reply-To: <20260528150546.3168527-2-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-2-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Thu, 28 May 2026 16:05:29 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> When CONFIG_NVMEM is disabled, reading the optional "shader-present"
> nvmem cell can return -EOPNOTSUPP.
> 
> Treat this the same as the cell being absent so panthor can continue
> probing on platforms that do not provide shader-present fuses through
> nvmem.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7c..4c96573b649a 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>  					      &contents);
>  	if (!ret)
>  		ptdev->gpu_info.shader_present = contents;
> -	else if (ret == -ENOENT)
> +	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
>  		return 0;
>  	else
>  		return dev_err_probe(ptdev->base.dev, ret,

