Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F596D3517B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD5C10EC44;
	Wed,  1 Apr 2026 12:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="MEytsV6W";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2AF10E369;
 Wed,  1 Apr 2026 12:47:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775047612; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NwgxV7ZEU3rTZiYNghBaKYx5J3p9YX1wpd1MRjNlxeEux1mZ51AQGjVAzG4XyIjv+QWnaHLd0W+HE9V7IHDslZyZbDNSQ6JN98uOdU5JJwVsv7imD3hwPA7NNMJIXlia0v2wmpiCfu2yjNU7iLcBnn5kd5hxtv5asUPcrVU/m04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775047612;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NsFt+AILWBuq0W7EGHKX+hyGDBm3/rgVEH4vBuyAXsI=; 
 b=PetM8G3nQbnadjrxg6bqY+PhTXKVSIp5rQZTblbenmBwrPYpCKizmF4Ajarkoc/toQ3SL8hdQrRTfH80aOd0tWhP1AZPJfaUF6/EZuKuZS7vEvb6IXgLxGlXpIqy92cAPdayppXuD30QKEjoOf/YDn3Wf9fd4jZQm1Y++GlIHm4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775047612; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=NsFt+AILWBuq0W7EGHKX+hyGDBm3/rgVEH4vBuyAXsI=;
 b=MEytsV6WCPOWif0BQN26ZZrq50GsIwwfHeNIm7wGUoa6C3YlhwPl+v8kSB0aOey6
 jQ63ZJ4q75l6az3bGVgihRTM8I3noVwSLf6rKCey21aL9UYu7VxUTsbYM2gjaILM0UE
 PKl2q1p4gW8voW5UXndfko/XdyTp/c3JgiHfuqQA=
Received: by mx.zohomail.com with SMTPS id 177504760955815.618442996613794;
 Wed, 1 Apr 2026 05:46:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Date: Wed, 01 Apr 2026 14:46:42 +0200
Message-ID: <6251230.iIbC2pHGDl@workhorse>
In-Reply-To: <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
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

Chiming in here to basically agree with Daniel and underline his point with
some evidence.

On Wednesday, 1 April 2026 10:40:15 Central European Summer Time Daniel Stone wrote:
> Hi Harry,
> 
> On Tue, 31 Mar 2026 at 18:47, Harry Wentland <harry.wentland@amd.com> wrote:
> > On 2026-03-31 08:50, Pekka Paalanen wrote:
> > > People who care about the picture quality down to these levels will
> > > likely want to know and learn about these techniques. They may also
> > > want to explicitly control them.
> > >
> > > In time, when these have been used enough in the wild, compositor
> > > developers will learn what makes a difference and what does not, so
> > > they will adjust their reporting to end users. The most important thing
> > > for the kernel is it offer an unambiguous and stable UAPI for these.
> > >
> > > Policy belongs in userspace.
> >
> > I don't like this as a blanket statement. There is a lot of policy that
> > intersects with HW nuances, whether it comes to power or otherwise.
> > Taking away driver vendor's abilities to optimize will hurt the Linux
> > ecosystem in the long run.
> >
> > IMO this needs to be evaluated on a case by case basis. There are
> > many places where it does make sense to give userspace a greater
> > say on policy, but we don't want to push driver (HW specific) logic
> > up into userspace.
> 
> It's not something that's _just_ specific to a particular
> display-controller manufacturer or a particular IP generation though.
> It very much depends on the usecase.
> 
> If you have a laptop and you're trying to give a presentation,
> applying dithering and/or DSC makes a lot of sense: you don't want
> your battery to die, and the projector's probably going to obliterate
> half the colour anyway, so might as well as go for the most efficient
> thing.
> 
> If your laptop is plugged into your big display at home to write code,
> applying DSC to cram the highest possible resolution + refresh in
> would make sense. But if dithering only results in a marginal power
> saving, and your laptop is charging anyway - why bother degrading
> visual acuity?

This kind of encourages me to say that the meaning of "bpc" here should
either be reduced by all compression (of which I see dithering as a
primitive variant of) or left at the uncompressed bpc for all compression.

I'm leaning towards the latter. 10bpc lossily compressed to 8bpc is likely
a better choice than plain 8bpc for visual clarity, so making them look the
same to userspace would result in some odd choices. At the same time, having
a separate way for userspace to know of any compression techniques applied
on the output would disambiguate that for those compositors that really care,
and would also mean we don't have to make subjective judgement calls for
anyone.

With regards to DSC for example, any vendor's decision to enable it by
default does not necessarily give us a good precedent for what side to
err on. amdgpu flips on DSC when it doesn't have to, and this has rubbed
some people wrong: https://gitlab.freedesktop.org/drm/amd/-/work_items/2043

The goal isn't so much to push driver logic into userspace, but to give
userspace a view into what the driver did, so that it can decide whether
it's happy or wants to try again differently. This means userspace isn't
ossifying on a set of parameters that made sense a decade ago; drivers can
still modify their decisions as they develop and hardware gains new
techniques.

> 
> If you're a media player, then you're in a good position to know what
> would be good to go over the wire, because you know (& are possibly in
> control of) the format over what comes in in the first place.
> 
> But everyone's tradeoffs are different, which is why sometimes the
> best choice is to ultimately leave it up to the user. If you dig into
> any media playback device (STBs running Android TV, Apple TV, Fire TV,
> et al), you'll see that all of them ultimately allow overrides for bpc
> / colour model / subsampling / etc. Those aren't just there for fun,
> but because they are usable to real people, and it's not possible for
> Amlogic or MediaTek or Rockchip or whoever to statically decide that a
> certain configuration is going to be best everywhere.
> 
> Right now we have drivers making magic per-vendor/SKU decisions,
> without even so much as a feedback mechanism to userspace (unless you
> count debugfs, maybe) so it can even figure out what's going on, let
> alone control it. To properly support some of those usecases,
> userspace needs to be able to control what goes out on the wire, but
> as a first step, it just wants to be informed of what the driver even
> did with the properties we gave it.
> 
> The end game of this isn't Weston logging something to stdout, it's to
> surface things to userspace so it can guide the kernel into making a
> good decision for usecases that may not be ones the silicon vendor
> decided was 'probably the best thing' however many years ago.
> 
> Cheers,
> Daniel
> 

Kind regards,
Nicolas Frattaroli


