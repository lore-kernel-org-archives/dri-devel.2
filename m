Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512A1C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 719FB10F3D8;
	Fri, 14 Aug 2026 07:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nrvIpRT1";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D89DB10E0E4
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 07:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786694071;
 bh=artBgxFCcQumpnGBlpZW+J9Ltf54xe2af+qgnA8uHbw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nrvIpRT1hJqwctRtlUbTUeO5CMCCl/8OIRfJNm4JoCij4XldzhVuihiTzLXxuyG3e
 +mEs9IBoA43F88LZrdg+NJ4wZADufWOFjw+1a8fiud8X/OSH/LxhfINJdgYgKAmip3
 DkWClpL4MQA6FPnt33ZBVsESi+Lv3j8tB+d1tZchpC72ViowL+o1jdjS5rqmVTgBPe
 nSfLd2ORO8XwgbhsKXWDrJK94PNlnDP8w5Yc9VdQJhZB4wWYwG+mcGsWJNW7+oPTou
 i6WRHo4187qZGf4nGcXz9WxbnWyXAeB+TVJnCtBfuwQzYDYD2qSBuxolegx9psrbt+
 JKtM0wzoEy4MA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D9ACE17E0C90;
 Fri, 14 Aug 2026 09:54:30 +0200 (CEST)
Date: Fri, 14 Aug 2026 09:54:24 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <linux-kernel@vger.kernel.org>
Cc: "Steven Price" <steven.price@arm.com>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <sashiko-bot@kernel.org>, "Danilo
 Krummrich" <dakr@redhat.com>
Subject: Re: [PATCH v3 00/17] drm/panthor: Fix the unplug logic
Message-ID: <20260814095424.458943b5@fedora-21.home>
In-Reply-To: <DKO1IF9KBS56.2MOSFDEDAYV0A@kernel.org>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813132320.1682f9bd@fedora-21.home>
 <DKO1IF9KBS56.2MOSFDEDAYV0A@kernel.org>
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

On Thu, 13 Aug 2026 20:50:22 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Aug 13, 2026 at 1:23 PM CEST, Boris Brezillon wrote:
> > Just a note I forgot to add to my cover letter. I've already spent way
> > more time than I wanted on this, not just because Sashiko keeps finding
> > new issues at each of my attempt, but also because the whole idea of
> > pretending a device on a platform bus is unplugged and can't harm us is
> > doomed. This is not an hot-pluggable bus, and the device is still there,
> > so, unless we can be absolutely sure it's inactive (which a RESET can
> > provide, but RESETs are fallible) we just have two options:  
> 
> I probably need a bit more context about which exact problem(s) you are trying
> to solve.

Sorry. You can find more context in patch 15.

> 
> > 1. prevent the device from going away until we managed to properly
> >    shutdown the GPU  
> 
> I'm not exactly sure what you mean with "device going away". If you mean
> "prevent the device from being unbound from the driver" this is essentially what
> you do by waiting for the completion of some HW teardown operation in remove().
> 
> In general, the implementation of remove() should ensure that on the one hand
> the device it torn down (or reset), so it does not mess with system resources
> anymore (e.g. attempt to do any DMA transfers) and behaves correctly on a
> subsequent probe of this or another driver.

So, that's the ideal situation, were a SOFT_RESET works. But because
SOFT_RESET is a GPU command that has to be acknowledged by the GPU, you
have no guarantee that this reset actually worked.

> 
> And on the other hand, the driver must release all device assoicated resources,
> such as DMA mappings, IRQs, I/O memory mappings, etc. and it should also ensure
> that no more driver code is reachable from any asynchronous paths, such as
> workqueues, IOCTLs, timers, etc.

Yep, we also take care of that in the nominal case (AKA RESET worked,
and we know the HW is off).

> 
> The latter obviously also depends on the subsystem and whether the lifetime of
> userspace structurs and their associated driver private data is cleanly
> decoupled (e.g. struct drm_file and ->driver_priv).
> 
> Since you also mention hot-unplug; those rules are universial regardless of
> whether remove is triggered by a hot-unplug event or because the driver is
> unbound for a different reason.

The API doesn't change, but the implication of such a removal do
change: on an hot-pluggable bus, the device is physically gone, so it
can't do any harm. On a platform bus, the device is there, and it might
remain clocked and powered even after the platform_device has been
unbound, because power domains and clks can be shared across devices,
so even the clk_disable_unprepare() & co we have in the remove path
won't guarantee that the GPU is inactive.

> The DRM API is a bit misleading about this,
> because with drm_dev_unregister() there is no way to prevent DRM IOCTLs from
> running after remove(), which wrongly suggests that this is not a potential
> issue.
> 
> Not summarizing this because I think you are not aware already, but it may
> provide a good entry point for you to point out where exactly things are getting
> tricky.

Things get tricky when we diverge from the nominal case: SOFT_RESET
didn't work, and we're either stuck in an infinite RESET loop waiting
for it to eventually work, or we just take the hit and leak any
resource the HW had access to at the time the RESET command was issued,
because we can't know for sure that the GPU is in such a bad state it
can't access memory anymore. All we know is that it's in a bad enough
state to no longer acknowledge RESET requests.

> 
> > 2. make sure all resources the HW might have its hands on at the time
> >    the failure of RESET in the unplug path happened are leaked  
> 
> I'm not sure what you mean by this. But it suggests that the problem you try to
> deal with is a misbehaving device that fails to reset?

Yes, this.

> 
> Also, what do you mean with leaking the device resources?

I mean leaking all the memory that the GPU had access to (page tables
and memory pointed by those page tables), so that it's never returned
to the system with a risk of UAF.
