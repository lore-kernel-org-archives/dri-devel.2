Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDC2C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEE910E471;
	Thu, 13 Aug 2026 18:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lDesQEHL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D71510E471
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7771600AF;
 Thu, 13 Aug 2026 18:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169B31F000E9;
 Thu, 13 Aug 2026 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786647026;
 bh=e0Na16jGADEhaJ4SgRHNY2d4Rmy7Hd9FO1PcDP9l8YQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lDesQEHLa38im6X4qsvqHEJI05wLfoThOamta95Fw2VN7lplu/GcIQbjj2O8gCG/Q
 wZBrIcX1tkzl3KcnqhisIAtS6i2HWQDCCNAM/lYmgo3go0eL9BRPxSF2qocqJcNXNe
 ud+RpoJFG2snlPhyAOKHDTuig1gu5IHq82KaBat8jCTucx0eBXQX2M2MzUCN3H1k+r
 hpzUPDFIFzqULCoddI8JJ6eWEKiPsJc+cZnYKONhkkWTJn4OF9Kh31lVQ9otpvM8Bg
 9H68c4jwKh5aI1ppzxVxyRn/QhOHSyR/aWYWlabIZWdQti6+s9yw7v4eyL7BIdShTY
 zGsJP1jpKnkAg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 20:50:22 +0200
Message-Id: <DKO1IF9KBS56.2MOSFDEDAYV0A@kernel.org>
Subject: Re: [PATCH v3 00/17] drm/panthor: Fix the unplug logic
Cc: "Steven Price" <steven.price@arm.com>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <sashiko-bot@kernel.org>, "Danilo Krummrich" <dakr@redhat.com>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813132320.1682f9bd@fedora-21.home>
In-Reply-To: <20260813132320.1682f9bd@fedora-21.home>
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

On Thu Aug 13, 2026 at 1:23 PM CEST, Boris Brezillon wrote:
> Just a note I forgot to add to my cover letter. I've already spent way
> more time than I wanted on this, not just because Sashiko keeps finding
> new issues at each of my attempt, but also because the whole idea of
> pretending a device on a platform bus is unplugged and can't harm us is
> doomed. This is not an hot-pluggable bus, and the device is still there,
> so, unless we can be absolutely sure it's inactive (which a RESET can
> provide, but RESETs are fallible) we just have two options:

I probably need a bit more context about which exact problem(s) you are try=
ing
to solve.

> 1. prevent the device from going away until we managed to properly
>    shutdown the GPU

I'm not exactly sure what you mean with "device going away". If you mean
"prevent the device from being unbound from the driver" this is essentially=
 what
you do by waiting for the completion of some HW teardown operation in remov=
e().

In general, the implementation of remove() should ensure that on the one ha=
nd
the device it torn down (or reset), so it does not mess with system resourc=
es
anymore (e.g. attempt to do any DMA transfers) and behaves correctly on a
subsequent probe of this or another driver.

And on the other hand, the driver must release all device assoicated resour=
ces,
such as DMA mappings, IRQs, I/O memory mappings, etc. and it should also en=
sure
that no more driver code is reachable from any asynchronous paths, such as
workqueues, IOCTLs, timers, etc.

The latter obviously also depends on the subsystem and whether the lifetime=
 of
userspace structurs and their associated driver private data is cleanly
decoupled (e.g. struct drm_file and ->driver_priv).

Since you also mention hot-unplug; those rules are universial regardless of
whether remove is triggered by a hot-unplug event or because the driver is
unbound for a different reason. The DRM API is a bit misleading about this,
because with drm_dev_unregister() there is no way to prevent DRM IOCTLs fro=
m
running after remove(), which wrongly suggests that this is not a potential
issue.

Not summarizing this because I think you are not aware already, but it may
provide a good entry point for you to point out where exactly things are ge=
tting
tricky.

> 2. make sure all resources the HW might have its hands on at the time
>    the failure of RESET in the unplug path happened are leaked

I'm not sure what you mean by this. But it suggests that the problem you tr=
y to
deal with is a misbehaving device that fails to reset?

Also, what do you mean with leaking the device resources?
