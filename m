Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E6ECD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F349E10ED70;
	Wed,  6 May 2026 12:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="bpzqFq8Z";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321F010ED70
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 12:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778071430; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lwcAHOQ9qKgB6gd/9on1FXLK0UkDSvYUDqw8dWjksSDlhrGY71mr6dLuvD+Juxe7xZVjqeJdePgX0oelI7eQUHqqowgB8a6OMxv6o1UV6i0eChNz60qd+WnKM+eJoBrwIjImFw07Yt0V27nCcqSlbOo6ShtG+Fo4J4K4qq2kCS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778071430;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4WOETdo7BhC8/fmfwEMHN4WnoE6JbrZL+S0o9p8CuQg=; 
 b=QQtT0Z2HOlpHk1d9Psdmk2ZCNNPApPHJlD8+9lgEYkTjwIU+QWETNPS0/0co+QVLUGW99oqJLrb2APT0E4slFtgSK84HyYQSTdb7+WUFt9JJi0L0l9LJFfnCCLxwnWo5UvjBeYpz5WfQatVYER/N+9ert4DqpakFi/YFAGl6j+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778071430; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=4WOETdo7BhC8/fmfwEMHN4WnoE6JbrZL+S0o9p8CuQg=;
 b=bpzqFq8ZonERTui7D7EsOZ4TgLTnWPmS5jc1gVcCh9oknNoPr4foc8lVt6qDxno8
 NEFNeYkeNwiwAWclb9gxJan+sWCuuXr5s7umaNf7RGIRgmWvVTXIMxOC8jV1DLLjjvM
 Nm1YHD+K9808tVd7G2lSqrJ4FTNe1uXI84ums7Cw=
Received: by mx.zohomail.com with SMTPS id 1778071429188905.6876124875138;
 Wed, 6 May 2026 05:43:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>, Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Florent Tomasin <florent.tomasin@arm.com>
Subject: Re: [PATCH 4/8] drm/panthor: Add support for protected memory
 allocation in panthor
Date: Wed, 06 May 2026 14:43:42 +0200
Message-ID: <SurytM7FTOazQNVXXqCU7g@collabora.com>
In-Reply-To: <20260506-energetic-azure-pig-2b6ec4@houat>
References: <20260505140516.1372388-1-ketil.johnsen@arm.com>
 <20260505140516.1372388-5-ketil.johnsen@arm.com>
 <20260506-energetic-azure-pig-2b6ec4@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

On Wednesday, 6 May 2026 12:08:24 Central European Summer Time Maxime Ripard wrote:
> Hi,
> 
> On Tue, May 05, 2026 at 04:05:10PM +0200, Ketil Johnsen wrote:
> > From: Florent Tomasin <florent.tomasin@arm.com>
> > 
> > This patch allows Panthor to allocate buffer objects from a
> > protected heap. The Panthor driver should be seen as a consumer
> > of the heap and not an exporter.
> > 
> > Protected memory buffers needed by the Panthor driver:
> > - On CSF FW load, the Panthor driver must allocate a protected
> >   buffer object to hold data to use by the FW when in protected
> >   mode. This protected buffer object is owned by the device
> >   and does not belong to a process.
> > - On CSG creation, the Panthor driver must allocate a protected
> >   suspend buffer object for the FW to store data when suspending
> >   the CSG while in protected mode. The kernel owns this allocation
> >   and does not allow user space mapping. The format of the data
> >   in this buffer is only known by the FW and does not need to be
> >   shared with other entities.
> > 
> > The driver will retrieve the protected heap using the name of the
> > heap provided to the driver as module parameter.
> 
> I know it's what dma_heap_find asks for, but I wonder if it wouldn't be
> better in the device tree and lookup through the device node? heaps are
> going to have a node anyway, right?
> 
> This would allow you to have a default that works and not mess to much
> with the kernel parameters that aren't always easy to change for
> end-users.

Hopefully the kernel parameters aren't easy to change for end-users on
systems that deploy this. :) The use-case is copy protection for embedded
devices running on locked-down systems. Though admittedly the mechanism
works even on "tampered"-with systems, as long as the underlying hardware
implements the access restrictions properly.

I'm a bit hesitant about making this DT myself. It would solve the problem
that panthor could probe before the heap provider and needs to handle
deferral by itself, but it does mean that we'd be putting software
configuration into the device tree. Having the secure heap be a node with
no address would allow the tee (or whatever else) to still dynamically
allocate it wherever, and let us handle the dependency relationship
between dma heap and GPU, but then we require that tee heap driver
implementations play nice with this scheme, and bring OF into the
dma_heap APIs.

I'm not against making the dma heap a phandle property for the GPU
node and then extending the dma-heap API to get a heap by name or
by index from a user device's standardised phandle property/names
property, but that's potentially a very large can of worms to open.

> 
> Maxime
> 

Kind regards,
Nicolas Frattaroli


