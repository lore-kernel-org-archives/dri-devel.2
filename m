Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25257CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7751010E197;
	Mon,  8 Jun 2026 20:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="LluCYvea";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E685D10E197
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780951851; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YUIoCuZWnZ6vXyqf16WXu/4w+iSebNO/5kZ9Bq1ZUIhryZ9Cem4xQpVbAfazmWURliYvuzhevQsCcoFwKo2cLj3EL74fJHzrng+OwzsSfkYjbUHr4hDcR2wwNV88S/l5mgLd15tVgXIO9b6LivT4fKoIQoSqOBS7W4A0tJA492c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780951851;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=orSHiGssWh9CUnwqRkVkOnj/qdpi42FFWxBmEUn5Els=; 
 b=LH+hvVd1w8gndEa1Xj1jm9Aw6EMsknsgfF6qruItEEc07HVFnLD3QvCh8hO8gllGbnDYb+6WK/OcGz6esrPOgFfjD530mYwdhf75IqX1iafZGBt85TSR9bMMMlrz3HvQIkwOO8Wstfbn8muaWBH5Y136hRnxXbNNkrGc39pmiuY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780951851; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=orSHiGssWh9CUnwqRkVkOnj/qdpi42FFWxBmEUn5Els=;
 b=LluCYveaLpx5+v/KArXMSkkmtfn2ScduaRYumjbv43yNXxmokF67PuOYQbPbl/q0
 TuDJE81IrhX6441ZeuTwRKys7iiU8ctqlSnl6LQvKqmOxbgGJ5APxJR2+y1M5WuQMio
 Pfo31PnaONxi/6xzxYU2Kcg1j/y3sFoyILSxyg0A=
Received: by mx.zohomail.com with SMTPS id 1780951848113484.6361367367341;
 Mon, 8 Jun 2026 13:50:48 -0700 (PDT)
Date: Mon, 8 Jun 2026 13:50:47 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, daniel.almeida@collabora.com, acourbot@nvidia.com,
 ecourtney@nvidia.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 boris.brezillon@collabora.com, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
Message-ID: <aicrJxmZNI_o4jCJ@um790>
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org> <aiC41_huOYhvacQD@um790>
 <DJ0BD0O60VAB.10S80F8N6MQPG@kernel.org> <aiINpEVaLW85LM5j@um790>
 <DJ1XEW84UTAU.28B9WK4VR0QLP@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ1XEW84UTAU.28B9WK4VR0QLP@kernel.org>
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

On Sat, Jun 06, 2026 at 01:23:04PM +0200, Danilo Krummrich wrote:
> On Fri Jun 5, 2026 at 1:43 AM CEST, Deborah Brouwer wrote:
> > On Thu, Jun 04, 2026 at 03:53:32PM +0200, Danilo Krummrich wrote:
> >> On Thu Jun 4, 2026 at 1:29 AM CEST, Deborah Brouwer wrote:
> >> > Hi Danilo, could we use separate data arguments in UnregisteredDevice
> >> > vs in the Registration? Basically we want to use the UnregisteredDevice
> >> > to initialize and boot the firmware which we then store as registration
> >> > data.
> >> >
> >> > Could you have a look at this patch, it applies on top of this series:
> >> > https://lore.kernel.org/rust-for-linux/20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com/
> >> 
> >> They already are separate -- UnregisteredDevice::new() takes T::Data and
> >> Registration::new() takes the registration data independently. Your patch
> >> demonstrates this correctly.
> >
> > Ah, true the arguments are different, but the issue for Tyr is we need
> > iomem to initialize and boot the firmware before we have a registered
> > device.
> >
> > Could you replace your Tyr with the changes i'm proposing here:
> 
> I don't see any change in your patch that belongs into this one. What exactly do
> you have in mind?

Since your patch is introducing a new type RegistrationData for
drm::Driver it would be nice to show more realistically how we
would use it in Tyr, specifically:
* replace TyrDrmDeviceData with TyrDrmRegistrationData
* pass no data argument to drm::UnregisteredDevice::new
* pass TyrDrmRegistrationData to drm::Registration::new_with_lt()

But also this has been a good exercise for me to understand how to
use the new type with Tyr, so it's fine if you just want to proceed with
your series as it is and then I will follow up right afterward with the
more substantive changes.

> 
> Please note that this patch is about core infrastructure and should only touch
> drivers for the minimum of mechanic changes required. IOW, your follow-up patch
> already sits perfectly in this context.

Ack.

> 
> > [PATCH v2] drm/tyr: move probe resources into registration data
> > https://lore.kernel.org/rust-for-linux/20260604-use_tyr_reg_data-v2-1-f77a1ffcf08d@collabora.com/
