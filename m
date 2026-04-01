Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CAD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439ED10EBA3;
	Wed,  1 Apr 2026 11:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ejd/FGgf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0982710EBA3;
 Wed,  1 Apr 2026 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775041832; x=1806577832;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZzLn06OKa5d3Ij7OX/DPxCeqDUsM186cPcmXwInj9lY=;
 b=Ejd/FGgfWfFsTYkqpFa34Hf4f3d7nQwbS/Rn6MwuolznTwyh13HX0itM
 gXBdp8xNG7NORWsolJQnwTldLcRTRKQPFikhq10C/XLi72LMAb3pK9DJk
 huhaGc8eIDiL0GIRzNOp7RGCJBKSAAEIf6bZA1mgFxZ0gGDbh4nYpHL10
 StkLd2K0Ps9se1M3jsPS8tmztAJ9jBfbIqUdULfsA/V1xU0auu5mVh9jo
 ar2YqnW0AKy+7ShVrvoizo5INkij9JrUNw4HqhYJM9k5JAwecBlYyKPsB
 vSTh15fGFjS3AF1JIs5tWBnAlhDa2MiUMIFf7ntBNcPoo6Wy87eSEMhXC A==;
X-CSE-ConnectionGUID: RUHdzG4nSbG8HnnlJypglw==
X-CSE-MsgGUID: 8kwRXvEXTZatQN7pM2rcig==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86379202"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="86379202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 04:10:31 -0700
X-CSE-ConnectionGUID: RQsWpoCJTIybY1ZqL2ljIw==
X-CSE-MsgGUID: O34kKTEqTJGc1aZ4FOd8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="226628800"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.199])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 04:10:26 -0700
Date: Wed, 1 Apr 2026 14:10:23 +0300
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
Message-ID: <acz9H5RtaGUUx6Cl@intel.com>
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
> 
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

I think the problem here is that no one even tried to make a
real userspace implementation. So it's very hard to judge if this
new property is actually usable in the end, or if it will just end
up as historical baggage that we have to carry around forever.

IMO just having userspace log what the kernel said does not fulfill
the "userspace implementation must be ready before new drm uapi is
merged" requirement. 

-- 
Ville Syrjälä
Intel
