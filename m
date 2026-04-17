Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85610F4368A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98FB10E29A;
	Fri, 17 Apr 2026 10:58:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FsMcJhFr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16E910E29A;
 Fri, 17 Apr 2026 10:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776423487; x=1807959487;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CwKibyJzVRDoAIal+h4Z67Sw/g/2BPRlilO0CkcylXE=;
 b=FsMcJhFrW9Q4mcZRPSGSuocHWJCVn+Bk/InH1KNkwhHUWE0iv1ulHkZU
 R1viGHDZs12hXtr6DawO/fYAy6EXaBR+H/bkr65j02vYDZoLJwqKVr2az
 TYHPnLx1tsNyboObP1l1sxngWn6sfUFXYm8DnOpZzdDgjCzwht7AuxFMX
 z5T9Lz5+jCB2VBr2SZLI2JNitCASN5xU4KvHVJBpzKrLVDaSuRsGm1FCQ
 QXfc3A2E0y0qUACbJTwK34xk7faGJHlWgbUS/TQ0jQXtWtV4WaUKAWHEW
 2gvHgwVVTZeGbLz3RmO2wyZAv+AUGqMVe++hsYpSFLfUik4KD6BKjOdKQ Q==;
X-CSE-ConnectionGUID: Lwczr35qT3meYxbQhFOsbA==
X-CSE-MsgGUID: l9ONWZNpRJ+cPqGY9j0Qng==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77312686"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77312686"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:58:06 -0700
X-CSE-ConnectionGUID: HlHsWSjbQQqm6l4HYki6eg==
X-CSE-MsgGUID: cIpGX+cTSl6YE4Owot/H0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="232755769"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.245.176])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 03:58:01 -0700
Date: Fri, 17 Apr 2026 13:57:58 +0300
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
Message-ID: <aeISNnh6IWGA7P8C@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <CAHijbEXcrhB=ipaa4-DPD8atQYCkokGfueLafwkeQpxCBkc0bw@mail.gmail.com>
 <7472926.DvuYhMxLoT@workhorse>
 <CAHijbEViae+=Fcnh3v0ODxwTPUaRgU1H4OVGM3VFPSLMPzJzOA@mail.gmail.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
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

On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel Dänzer wrote:
> On 4/16/26 15:16, Julian Orth wrote:
> > On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
> >>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
> >>> <nicolas.frattaroli@collabora.com> wrote:
> >>>>
> >>>> This series addresses a shortcoming whereby a hot plug event is sent
> >>>> without it being passed the actual connector that caused it. This takes
> >>>> into consideration both the polling path and the HPD (Hot Plug Detect)
> >>>> path. It also adds support for the vkms driver (using ConfigFS) for
> >>>> propagating the connector ID when changing the connector's status.
> >>>>
> >>>> The motivation is that user-space applications such as Weston would
> >>>> previously receive non-connector-specific hotplug events, and then have
> >>>> to figure out themselves which connector needs to have a modeset
> >>>> executed on. This notably did not work when the hotplug events came in
> >>>> too fast, resulting in Weston missing an on-off-on transition of a
> >>>> connector, seeing that its state was unchanged from "on" so can't be the
> >>>> one that was hotplugged, and skipping reinitialising it as it looks
> >>>> through the other connectors that could've caused it.
> >>>
> >>> Have you considered adding a u64 serial number as a DRM connector
> >>> property that is incremented every time the connector changes in some
> >>> way? Userspace could then check this serial number to see if the
> >>> connector has changed since the last time it queried the serial
> >>> number.
> >>
> >> The connector internally already has an epoch_counter member which
> >> could be used for this. However, for the particular thing this
> >> series fixes, I don't think exposing it through the uAPI is necessary
> >> or desirable. Sending hotplug events specific to the connector does
> >> not need any additional handling on the userspace side as long as it
> >> already listens to the per-connector hotplug events in order to
> >> avoid the pitfall described in the cover letter.
> > 
> > I currently do not handle per-connector hotplug events. Instead,
> > whenever I get a UDEV change event for a device, I re-fetch the entire
> > kernel state for the device. That is
> > 
> > - DRM_IOCTL_MODE_GETRESOURCES
> > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> > 
> > Once I have the new state, I compare it against the desired compositor
> > state and perform a modeset if necessary.
> 
> mutter is doing something similar as well.
> 
> 
> Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
> 
> The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again.

GPU reset should relight the display on its own really. That's what
i915 does, albeit somewhat badly at the moment.

> A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)

There's nothing preventing the kernel from doing extra atomic
commits whenever it wants. But if you want to punt the thing to
userspace then the kernel must set the link-status property to
bad, and then fire the hotplug uevent.

> If this "modeset required after hotplug event" rule is confirmed, it means that after a hotplug event without connector ID, the compositor must do a modeset for all connectors.

Only for connectors where things changed, or the link-status shows bad.

> 
> 
> P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#note_2984697 even argued that two modesets are required after a hotplug event, one which turns things off and another one which turns them on again. I don't agree with that though, a single modeset should suffice.

The actual argument is that you should not defer the hotplug
handling when things get disconnected, mainly because of crap type-c
firmware.

I think the userspace behaviour there was that you get a disconnected,
defer processing it, and then you get a reconnect, and then decide that
nothing actually changed and a modeset is not needed after all. That is
not correct IMO. Clearly a ->disconnect->reconnect should count as a
change in the connector's state, and a full modeset is thus required.
The kernel can of course then decide that the full modeset is not
actually required and skip the modeset part during the commit. But
userspace cannot make that determination.

I suppose what we could maybe do there to force userspace's hand is set
the link-status to bad already when the thing gets disconnected, and keep
it like that until a full disable+re-enable cycle has been done. Then
userspace could not think that the ->disconnect->reconnect is a NOP
(which I still think is incorrect behaviour).

-- 
Ville Syrjälä
Intel
