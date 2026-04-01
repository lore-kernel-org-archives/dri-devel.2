Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF6F107637E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7BB89321;
	Wed,  1 Apr 2026 13:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BA64gExm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC3D89321;
 Wed,  1 Apr 2026 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775051903; x=1806587903;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=s3yvmYWTk3Znd4vEvVUg8aHhDmWCu9lQIx5d8GRKL4Y=;
 b=BA64gExmdS9K43osJxsXBBzG6yQRtMqxpH6uKDpJHLPlAp7CxpMNnQIa
 GO8CsTYxXaH8R/pJ2HP/IwsuryQy7bxRQyjre4T+QF9rxjsdIcrH9Ds0h
 vwbVubhWzfmmxMbzsnammEbknyUxHjbVrHK3iW0lxehCag3tFaJNFMm5I
 S3KlYgMu74dXEGm8UIDKp0IxqM+GseJuwrqlZdpGJDTL04uJJLgjgqDBa
 NwvAUb8tAf2qHNhdSUjUNiX80oR4iORfFqdxbItcY/KU8k7Js2K3I1L6O
 feft7VfC7i6CgfxiDyZSOULYXJ3+nJJ8zk63EZzzvq9WaTKf5gUGgqoJ6 g==;
X-CSE-ConnectionGUID: 97BiUIAUTqyf5t3W6pCr5w==
X-CSE-MsgGUID: Ar2crSPORn2GG0TtRFwErg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75262807"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="75262807"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 06:57:28 -0700
X-CSE-ConnectionGUID: S80wAtacRF2cUgUJFBkWeA==
X-CSE-MsgGUID: c7nLL/8MRneEYJkCbhYPVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="249714045"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.199])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 06:57:22 -0700
Date: Wed, 1 Apr 2026 16:57:19 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <ac0kP-SWXrBwrN5C@intel.com>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Wed, Apr 01, 2026 at 09:40:15AM +0100, Daniel Stone wrote:
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

BTW DSC is not free. The compressor does actual work, which takes
energy. DSC may be a win power wise if you can then reduce the link
frequency (+ some internal voltages/etc.). But if you can't reduce
anything then all you really end up doing is burning more power
compressing things needlessly. But it's all very hardware specific
of course. So having explicit userspace control for this stuff doesn't 
seem like the best idea, apart from maybe a "no DSC at all" knob for
the people who can't tolerate any kind of compression artifacts.


I've been musing about userspace being able to provide some kind of
relative quality weights for each output. The driver could then use
those to figure out how to balance the final bpc and compression
between the outputs. Something like this would let userspace express
its preference while still allowing the driver to decide how to
actually get there. 

Simple 'desired bpc' seem somewhat insufficient because I would
imagine userspace just sets that to max for everything at the start,
so the driver might not be able to tell which outputs can be degraded
harder than others.

I suppose a desired+min bpc might work, but would potentially force
userspace to tweak the parameters in some semi random fashion and
try again if the end result isn't appealing. And exactly what to
tweak is really hard for userspace to figure out since it has no
idea of the possibly complex internal/tbt/mst topologies, power
costs, etc.

> If your laptop is plugged into your big display at home to write code,
> applying DSC to cram the highest possible resolution + refresh in
> would make sense. But if dithering only results in a marginal power
> saving, and your laptop is charging anyway - why bother degrading
> visual acuity?
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

-- 
Ville Syrjälä
Intel
