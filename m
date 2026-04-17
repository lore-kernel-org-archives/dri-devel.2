Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3B6F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12DF210E04D;
	Fri, 17 Apr 2026 14:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="COOkZbfC";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA15110E04D;
 Fri, 17 Apr 2026 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776437739; x=1807973739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Lt1s6MYo4dZoxVlnmZQBO6VYRLv5Ltmp9VewtpWxrUM=;
 b=COOkZbfChJaFeq5cCZ7QOmTxT6Jrvo+fO2eqTVmmzWuX9Phu3QmSk16A
 56FZgzjqF8vQxaP3omsqbES8+ErZfHhwRsCdAxB0iKKrjOhTECOsBwBDU
 YjRjBxh6RzeUQHpwnL9dEhAVJK54bYnUoxzilvvSCPZEgqjN0RFzMGkqK
 5dVxDAxylaOwQmNMIQqGJKS6hiH0xErO0j432cq3jQw7A9vTv6mSaiMrw
 0slQzTWHD935xNaxxdor2gTuQmVlSebCn5mTQzv7sXFk6RnsEbbW/zNQH
 fLrgBG25z9AcCxCYS/R2X64v3rB6XIMMZr1Rsft8Tqf6scgzwwmSJddAE g==;
X-CSE-ConnectionGUID: 1EKmajCKRnav3O6nsSvKgg==
X-CSE-MsgGUID: PVRneuMySKG4PPLaplVzXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81051407"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="81051407"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:55:39 -0700
X-CSE-ConnectionGUID: ZlCdnTEARoGlJE4m2uGGiQ==
X-CSE-MsgGUID: 4UgMn1ErTkaWx9ScpFKoOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="254530712"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.245.176])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:55:33 -0700
Date: Fri, 17 Apr 2026 17:55:30 +0300
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
Message-ID: <aeJJ4lKAZDwBuW_U@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com>
 <63a3d617-6603-438c-b22b-62acedb951e1@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63a3d617-6603-438c-b22b-62acedb951e1@mailbox.org>
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

On Fri, Apr 17, 2026 at 04:17:45PM +0200, Michel Dänzer wrote:
> On 4/17/26 12:57, Ville Syrjälä wrote:
> > On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel Dänzer wrote:
> >> On 4/16/26 15:16, Julian Orth wrote:
> >>> On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
> >>> <nicolas.frattaroli@collabora.com> wrote:
> >>>> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
> >>>>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
> >>>>> <nicolas.frattaroli@collabora.com> wrote:
> >>>>>>
> >>>>>> This series addresses a shortcoming whereby a hot plug event is sent
> >>>>>> without it being passed the actual connector that caused it. This takes
> >>>>>> into consideration both the polling path and the HPD (Hot Plug Detect)
> >>>>>> path. It also adds support for the vkms driver (using ConfigFS) for
> >>>>>> propagating the connector ID when changing the connector's status.
> >>>>>>
> >>>>>> The motivation is that user-space applications such as Weston would
> >>>>>> previously receive non-connector-specific hotplug events, and then have
> >>>>>> to figure out themselves which connector needs to have a modeset
> >>>>>> executed on. This notably did not work when the hotplug events came in
> >>>>>> too fast, resulting in Weston missing an on-off-on transition of a
> >>>>>> connector, seeing that its state was unchanged from "on" so can't be the
> >>>>>> one that was hotplugged, and skipping reinitialising it as it looks
> >>>>>> through the other connectors that could've caused it.
> >>>>>
> >>>>> Have you considered adding a u64 serial number as a DRM connector
> >>>>> property that is incremented every time the connector changes in some
> >>>>> way? Userspace could then check this serial number to see if the
> >>>>> connector has changed since the last time it queried the serial
> >>>>> number.
> >>>>
> >>>> The connector internally already has an epoch_counter member which
> >>>> could be used for this. However, for the particular thing this
> >>>> series fixes, I don't think exposing it through the uAPI is necessary
> >>>> or desirable. Sending hotplug events specific to the connector does
> >>>> not need any additional handling on the userspace side as long as it
> >>>> already listens to the per-connector hotplug events in order to
> >>>> avoid the pitfall described in the cover letter.
> >>>
> >>> I currently do not handle per-connector hotplug events. Instead,
> >>> whenever I get a UDEV change event for a device, I re-fetch the entire
> >>> kernel state for the device. That is
> >>>
> >>> - DRM_IOCTL_MODE_GETRESOURCES
> >>> - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> >>> - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> >>> - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> >>> - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> >>>
> >>> Once I have the new state, I compare it against the desired compositor
> >>> state and perform a modeset if necessary.
> >>
> >> mutter is doing something similar as well.
> >>
> >>
> >> Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
> >>
> >> The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again.
> > 
> > GPU reset should relight the display on its own really. That's what
> > i915 does, albeit somewhat badly at the moment.
> > 
> >> A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)
> > 
> > There's nothing preventing the kernel from doing extra atomic
> > commits whenever it wants.
> 
> I made that same argument at first.
> 
> Then it occurred to me the kernel-internal atomic modeset commit could cause spurious EBUSY failures for user-space atomic commits overlapping with it.

Not so. Everything just gets blocked on the kms mutexes and the -EBUSY 
stuff never even comes into play.

> 
> 
> > But if you want to punt the thing to userspace then the kernel must set the link-status
> > property to bad, and then fire the hotplug uevent.
> 
> I later suggested using the link-status property for this as well.
> 
> Checking with others on IRC and reading documentation / code though, I realized my recollection of its semantics was wrong, it actually doesn't look suitable for this. In particular, the expected user space response to link-status bad is to set a *different* mode (since the mode may be relevant for the link failure), not the same one which was already set.

The expected response it to retry with the same mode, at least if
that mode is still on the connector's mode list. If the mode got
pruned then there's perhaps no point in trying it again.

That's if the mode was on the connector's mode list to begin with.
If it was never there then just blindly retrying it again seems
like the correct option to me.

> 
> 
> >> P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#note_2984697 even argued that two modesets are required after a hotplug event, one which turns things off and another one which turns them on again. I don't agree with that though, a single modeset should suffice.
> > 
> > The actual argument is that you should not defer the hotplug
> > handling when things get disconnected, mainly because of crap type-c
> > firmware.
> > 
> > I think the userspace behaviour there was that you get a disconnected,
> > defer processing it, and then you get a reconnect, and then decide that
> > nothing actually changed and a modeset is not needed after all. That is
> > not correct IMO. Clearly a ->disconnect->reconnect should count as a
> > change in the connector's state, and a full modeset is thus required.
> 
> While that makes sense to me in principle, as Julian pointed out, the kernel can't rely on user space seeing the intermittent disconnected state.
> 
> Seems like another argument for a serial number property. That would make the need for a modeset unambiguous.

I guess it could at least optimize the "has this connector changed?"
check for the single uevent without connector IDs case. 

And I suppose it could avoid race conditions with switching drm masters
when the new master can't be sure it's seen all the uevents. Another
thing that would avoid the issues here is if each new master was
required to do one full modeset on everything. But maybe that was never
a rule?

But for the case where the kernel only sends the per-connector uevents
and the drm master sees all of them the serial number would do nothing.
In that case the kernel wouldn't even send the uevent unless the
serial number has changed.

> 
> 
> Note that the referenced issue is about a different scenario though:
> 
> 1. mutter does modeset for DPMS off
> 2. hotplug events during DPMS off (presumably triggered by the monitor scanning its inputs)
> 3. mutter does modeset for DPMS on
> 
> The monitor stays off after step 3. The argument in the comment I referenced is that mutter should repeat step 1 before step 3.

That can't be it. We don't do anything if you try to disable an already  
disabled output. And the analysis of the logs indicated that the disable
(DPMS off) was completely missing.

-- 
Ville Syrjälä
Intel
