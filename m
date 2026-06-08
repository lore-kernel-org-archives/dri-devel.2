Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34164CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6353410F54D;
	Mon,  8 Jun 2026 14:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hGJeD3xj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD81610F54D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780930295;
 bh=yB6hEdYsDoy24TOUYX7Qc/L4+I+uRH9c2rL6OnPqQug=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hGJeD3xjeBU2Db1cL3n/VH0zrP5ELV+GPTbkiCgVq4uOC8TYiN3GIFMuK6nqYY0Yc
 1A/7Cw3d4sc8JFwmVPMoAdY7VI5bSCrv8iF18+8hFAKbsIgvmAyVXKzgwXMb1x0/UJ
 IEKGNw6gxkD7xj9x051Xy9DAr4aiXHDGeeEoHApPdebPVQPbtOwftKQ/obY+octNPQ
 4v4OQ+vC3HhlMWxJ3pBz8BjRJpK2cWWlDF2DP4101N5ROR2rxTotnh/O7L4aT6lgK0
 4C/wmqYTBg/e7IVRK7fWbtiQX6jeMdoaJsJYRln7tQVPgfeAYjUoFUR0Jxh2mQxuJd
 7zijarkNERguQ==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1704217E04CA;
 Mon,  8 Jun 2026 16:51:35 +0200 (CEST)
Date: Mon, 8 Jun 2026 16:51:28 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/18] drm/panthor: Skip devfreq when no OPP table
 is present
Message-ID: <20260608165128.33732c17@fedora-2.home>
In-Reply-To: <e3c32d54-b85b-4ad8-bd6d-120c4dbfead1@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-9-karunika.choo@arm.com>
 <20260608160822.1038d08e@fedora-2.home>
 <e3c32d54-b85b-4ad8-bd6d-120c4dbfead1@arm.com>
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

On Mon, 8 Jun 2026 15:39:56 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> On 08/06/2026 15:08, Boris Brezillon wrote:
> > On Thu, 28 May 2026 16:05:36 +0100
> > Karunika Choo <karunika.choo@arm.com> wrote:
> >   
> >> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> >> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.  
> > 
> > OOC, is this still handled as clock frequency changes? I'm asking
> > because the recent perfcnt work requires registering clk notifiers to
> > get an approximation of the number of shader/top-level/coregroup clock
> > cycles on a given period of time so we an calculate relative GPU
> > utilization, and so far we've only considered clk notifiers as a way to
> > get informed of these frequency changes.
> > 
> > BTW, this is already problematic for the mediatek GPUEB design, where
> > devfreq stuff is delegated to an MCU, and we don't currently have a way
> > to get notified when this MCU changes the frequencies.
> >   
> 
> I believe we should still support initializing clocks and registering
> notifiers for them. We are just disabling the devfreq subsystem in
> this patch.
> 
> Would mediatek be able to expose a child clock or logical clock from
> ther GPUEB driver to Panthor so that we can get these notifications?

Yep, the clk is exposed and I believe the current clk rate is
properly reflected when clk_get_rate() is called, but the clk framework
only issues notification for rate change requests going through
clk_set_rate(), there's no way for a clk provider to report a rate
change AFAIK.
