Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA41F5A8AA
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AFDF10EB0D;
	Mon, 20 Apr 2026 18:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f/rAJzCn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C0410EB0D;
 Mon, 20 Apr 2026 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776708838; x=1808244838;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lHXx/cVa1oB0/1hTrftuetaCS35BAJvr0nb0F+PYseQ=;
 b=f/rAJzCnerQNQ53UkzjuM7egDj0M8gW5HzWhAPRnC4jISkNXlsTNn+Gs
 pry/b009mzLD/aw22nOn5IBVdH2rCBQcjYbmSIiwuEYcwfq2YpeUDnv7j
 9wdGFibrbf7F3uBsKSHYmIwLxvcgZhjAzolfeNICWzjTKcMHtaAMQXoh8
 I7HX5wTBcQ8QmpSVJNuNCnZfzCUpK8C39rRxffO38ByLjtNTlMizALM4e
 RRWPwJqoEsQIrJYi5kWF0PVtcPD8fZIdwFlkkohZheATCuDmUUQni3tW+
 pvKr85Rgy7cPdpqIjjhsDnJXDyyJtBIZkc2OoilQS/Dr6Dt6mNU3GBoGP g==;
X-CSE-ConnectionGUID: 3QV0+tewS+aScsz9Bc/mug==
X-CSE-MsgGUID: 3auJv9BvQwOGjpt9LX0jLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77612933"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="77612933"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 11:13:57 -0700
X-CSE-ConnectionGUID: Xu1f+yujSNiSUjB4lzs/7w==
X-CSE-MsgGUID: jg67bexARQuGuNT7pL8myw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="227452646"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.159])
 by fmviesa010-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 11:13:52 -0700
Date: Mon, 20 Apr 2026 21:13:49 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>
Cc: Julian Orth <ju.orth@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Daniel Stone <daniel.stone@collabora.com>,
 Ian Forbes <ian.forbes@broadcom.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org,
 Marius Vlad <marius.vlad@collabora.com>, Imre Deak <imre.deak@intel.com>
Subject: Re: [PATCH RESEND v7 0/2] Pass down hot-plug CONNECTOR ID to
 user-space
Message-ID: <aeZs3TK17iXZ1b6k@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
 <63a3d617-6603-438c-b22b-62acedb951e1@mailbox.org>
 <aeJJ4lKAZDwBuW_U@intel.com>
 <3196f1fc-f241-4295-b5b8-380ee93e95da@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3196f1fc-f241-4295-b5b8-380ee93e95da@mailbox.org>
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

On Fri, Apr 17, 2026 at 06:40:51PM +0200, Michel Dänzer wrote:
> On 4/17/26 16:55, Ville Syrjälä wrote:
> > On Fri, Apr 17, 2026 at 04:17:45PM +0200, Michel Dänzer wrote:
> >> On 4/17/26 12:57, Ville Syrjälä wrote:
> >>> On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel Dänzer wrote:
> >>>> On 4/16/26 15:16, Julian Orth wrote:
> >>>>> On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
> >>>>> <nicolas.frattaroli@collabora.com> wrote:
> >>>>>> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
> >>>>>>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
> >>>>>>> <nicolas.frattaroli@collabora.com> wrote:
> >>>>>>>>
> >>>>>>>> This series addresses a shortcoming whereby a hot plug event is sent
> >>>>>>>> without it being passed the actual connector that caused it. This takes
> >>>>>>>> into consideration both the polling path and the HPD (Hot Plug Detect)
> >>>>>>>> path. It also adds support for the vkms driver (using ConfigFS) for
> >>>>>>>> propagating the connector ID when changing the connector's status.
> >>>>>>>>
> >>>>>>>> The motivation is that user-space applications such as Weston would
> >>>>>>>> previously receive non-connector-specific hotplug events, and then have
> >>>>>>>> to figure out themselves which connector needs to have a modeset
> >>>>>>>> executed on. This notably did not work when the hotplug events came in
> >>>>>>>> too fast, resulting in Weston missing an on-off-on transition of a
> >>>>>>>> connector, seeing that its state was unchanged from "on" so can't be the
> >>>>>>>> one that was hotplugged, and skipping reinitialising it as it looks
> >>>>>>>> through the other connectors that could've caused it.
> >>>>>>>
> >>>>>>> Have you considered adding a u64 serial number as a DRM connector
> >>>>>>> property that is incremented every time the connector changes in some
> >>>>>>> way? Userspace could then check this serial number to see if the
> >>>>>>> connector has changed since the last time it queried the serial
> >>>>>>> number.
> >>>>>>
> >>>>>> The connector internally already has an epoch_counter member which
> >>>>>> could be used for this. However, for the particular thing this
> >>>>>> series fixes, I don't think exposing it through the uAPI is necessary
> >>>>>> or desirable. Sending hotplug events specific to the connector does
> >>>>>> not need any additional handling on the userspace side as long as it
> >>>>>> already listens to the per-connector hotplug events in order to
> >>>>>> avoid the pitfall described in the cover letter.
> >>>>>
> >>>>> I currently do not handle per-connector hotplug events. Instead,
> >>>>> whenever I get a UDEV change event for a device, I re-fetch the entire
> >>>>> kernel state for the device. That is
> >>>>>
> >>>>> - DRM_IOCTL_MODE_GETRESOURCES
> >>>>> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> >>>>> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> >>>>> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> >>>>> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> >>>>>
> >>>>> Once I have the new state, I compare it against the desired compositor
> >>>>> state and perform a modeset if necessary.
> >>>>
> >>>> mutter is doing something similar as well.
> >>>>
> >>>>
> >>>> Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
> >>>>
> >>>> The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again.
> >>>
> >>> GPU reset should relight the display on its own really. That's what
> >>> i915 does, albeit somewhat badly at the moment.
> >>>
> >>>> A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)
> >>>
> >>> There's nothing preventing the kernel from doing extra atomic
> >>> commits whenever it wants.
> >>
> >> I made that same argument at first.
> >>
> >> Then it occurred to me the kernel-internal atomic modeset commit could cause spurious EBUSY failures for user-space atomic commits overlapping with it.
> > 
> > Not so. Everything just gets blocked on the kms mutexes and the -EBUSY 
> > stuff never even comes into play.
> 
> Makes things easier in that case. I followed up accordingly in the other thread.
> 
> 
> >>> But if you want to punt the thing to userspace then the kernel must set the link-status
> >>> property to bad, and then fire the hotplug uevent.
> >>
> >> I later suggested using the link-status property for this as well.
> >>
> >> Checking with others on IRC and reading documentation / code though, I realized my recollection of its semantics was wrong, it actually doesn't look suitable for this. In particular, the expected user space response to link-status bad is to set a *different* mode (since the mode may be relevant for the link failure), not the same one which was already set.
> > 
> > The expected response it to retry with the same mode, at least if
> > that mode is still on the connector's mode list. If the mode got
> > pruned then there's perhaps no point in trying it again.
> 
> On re-reading the link-status documentation in drivers/gpu/drm/drm_connector.c, I agree.
> 
> I'm afraid you're optimistic in terms of user space support for link-status though.
> 
> Neither mutter nor weston even look at it yet.
> 
> KWin reacts to link-status bad with a modeset, not sure it handles the current mode disappearing though. Seems good enough for the scenarios we're discussing here.
> 
> wlroots seems to handle it properly.
> 
> (Any compositors which don't handle it yet need to be fixed, just pointing out it might not make a difference with existing releases of some of them)

I guess someone should start thinking about some kind of KMS conformance
test for compositors. Presumably vkms could provide the kernel part of
that.

-- 
Ville Syrjälä
Intel
