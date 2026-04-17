Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2A0F436A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AF6510EA30;
	Fri, 17 Apr 2026 14:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IdfOq4I6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA95310EA30;
 Fri, 17 Apr 2026 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776435387; x=1807971387;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wNDFeew0GBc5wWmr72JilEG0XSxuay+F6DKaqtzLw6A=;
 b=IdfOq4I6j/MLD/UcczUSt4vhAnlm7KT/ubXuI4gXIAj25FKFsc9TwYAR
 Hlt8tjZYYLmc8kPZNDWXWwNbiWHjlZNdTV9T9ZnOzckZAhTGpWRnOzRsh
 1lrljlgIxHshe7rP1FJPKxL6Q56Xs5eNDGnseyEvUtbLpkX93kLFVkh66
 WPJXnSxajWomkbfW76FmIgglUOGryzk6UltI+BgFtBC9cUpK/HTWVkypM
 3tdPi2MqBGWtdi4sQmeKI45bzOuOAd0/7+tBYsYTcCE9Usj9yYx96atxP
 pRBn2pNQkh+BI5EQ+PDSmqd3q/T3QgZ/uRBh3xVYQ4W10RSuYikcFVdbF Q==;
X-CSE-ConnectionGUID: pqaXEdkpTy2SCecdcarSlQ==
X-CSE-MsgGUID: a1oxV5gNTVWFNFYqtT3AZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77327248"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="77327248"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:16:10 -0700
X-CSE-ConnectionGUID: 3uxoeXTAR7iEBL8pgtYtIg==
X-CSE-MsgGUID: 3ZN/0BVZQSCqSzvEzRHBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; d="scan'208";a="236028244"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.245.176])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 07:16:04 -0700
Date: Fri, 17 Apr 2026 17:16:01 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@mailbox.org>,
 Julian Orth <ju.orth@gmail.com>,
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
Message-ID: <aeJAofA04bOuxlGA@intel.com>
References: <20260415-hot-plug-passup-v7-0-9a27ef5e2428@collabora.com>
 <1297f150-b3b4-4a53-ad05-ecb05b8ec420@mailbox.org>
 <aeISNnh6IWGA7P8C@intel.com> <6501274.LvFx2qVVIh@workhorse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6501274.LvFx2qVVIh@workhorse>
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

On Fri, Apr 17, 2026 at 02:42:36PM +0200, Nicolas Frattaroli wrote:
> On Friday, 17 April 2026 12:57:58 Central European Summer Time Ville Syrjälä wrote:
> > On Fri, Apr 17, 2026 at 09:49:36AM +0200, Michel Dänzer wrote:
> > > On 4/16/26 15:16, Julian Orth wrote:
> > > > On Thu, Apr 16, 2026 at 9:46 AM Nicolas Frattaroli
> > > > <nicolas.frattaroli@collabora.com> wrote:
> > > >> On Wednesday, 15 April 2026 20:57:53 Central European Summer Time Julian Orth wrote:
> > > >>> On Wed, Apr 15, 2026 at 8:19 PM Nicolas Frattaroli
> > > >>> <nicolas.frattaroli@collabora.com> wrote:
> > > >>>>
> > > >>>> This series addresses a shortcoming whereby a hot plug event is sent
> > > >>>> without it being passed the actual connector that caused it. This takes
> > > >>>> into consideration both the polling path and the HPD (Hot Plug Detect)
> > > >>>> path. It also adds support for the vkms driver (using ConfigFS) for
> > > >>>> propagating the connector ID when changing the connector's status.
> > > >>>>
> > > >>>> The motivation is that user-space applications such as Weston would
> > > >>>> previously receive non-connector-specific hotplug events, and then have
> > > >>>> to figure out themselves which connector needs to have a modeset
> > > >>>> executed on. This notably did not work when the hotplug events came in
> > > >>>> too fast, resulting in Weston missing an on-off-on transition of a
> > > >>>> connector, seeing that its state was unchanged from "on" so can't be the
> > > >>>> one that was hotplugged, and skipping reinitialising it as it looks
> > > >>>> through the other connectors that could've caused it.
> > > >>>
> > > >>> Have you considered adding a u64 serial number as a DRM connector
> > > >>> property that is incremented every time the connector changes in some
> > > >>> way? Userspace could then check this serial number to see if the
> > > >>> connector has changed since the last time it queried the serial
> > > >>> number.
> > > >>
> > > >> The connector internally already has an epoch_counter member which
> > > >> could be used for this. However, for the particular thing this
> > > >> series fixes, I don't think exposing it through the uAPI is necessary
> > > >> or desirable. Sending hotplug events specific to the connector does
> > > >> not need any additional handling on the userspace side as long as it
> > > >> already listens to the per-connector hotplug events in order to
> > > >> avoid the pitfall described in the cover letter.
> > > > 
> > > > I currently do not handle per-connector hotplug events. Instead,
> > > > whenever I get a UDEV change event for a device, I re-fetch the entire
> > > > kernel state for the device. That is
> > > > 
> > > > - DRM_IOCTL_MODE_GETRESOURCES
> > > > - DRM_IOCTL_MODE_OBJ_GETPROPERTIES for each connector, crtc, plane
> > > > - DRM_IOCTL_MODE_GETCONNECTOR for each connector
> > > > - DRM_IOCTL_MODE_GETPROPERTY for each connector property
> > > > - DRM_IOCTL_MODE_GETPROPBLOB for the EDID
> > > > 
> > > > Once I have the new state, I compare it against the desired compositor
> > > > state and perform a modeset if necessary.
> > > 
> > > mutter is doing something similar as well.
> > > 
> > > 
> > > Note that some are arguing a modeset is always required after a hotplug event, even if the state hasn't changed.
> > > 
> > > The most convincing argument I've seen is the scenario of a GPU reset, after which a modeset is required to light up the displays again.
> > 
> > GPU reset should relight the display on its own really. That's what
> > i915 does, albeit somewhat badly at the moment.
> > 
> > > A hotplug event seems the only mechanism available for the kernel to request a modeset from the compositor. (The kernel may not be able to reliably do the modeset on its own, e.g. due to interactions with user-space atomic commits)
> > 
> > There's nothing preventing the kernel from doing extra atomic
> > commits whenever it wants. But if you want to punt the thing to
> > userspace then the kernel must set the link-status property to
> > bad, and then fire the hotplug uevent.
> > 
> > > If this "modeset required after hotplug event" rule is confirmed, it means that after a hotplug event without connector ID, the compositor must do a modeset for all connectors.
> > 
> > Only for connectors where things changed, or the link-status shows bad.
> > 
> > > 
> > > 
> > > P.S. https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14420#note_2984697 even argued that two modesets are required after a hotplug event, one which turns things off and another one which turns them on again. I don't agree with that though, a single modeset should suffice.
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
> > The kernel can of course then decide that the full modeset is not
> > actually required and skip the modeset part during the commit. But
> > userspace cannot make that determination.
> 
> So just to loop around to the patches here: is sending per-connector
> hotplug events not acceptable? Your review[1] on v5 indicated you had
> a problem with the implementation, not a fundamental issue with the
> behaviour the patch tried to change.

What I was saying is that we already have the epoch_counter. If
there are gaps in the implementation then those should just be
fixed. We don't want a second implementation of the same
mechanism.

> 
> > I suppose what we could maybe do there to force userspace's hand is set
> > the link-status to bad already when the thing gets disconnected, and keep
> > it like that until a full disable+re-enable cycle has been done. Then
> > userspace could not think that the ->disconnect->reconnect is a NOP
> > (which I still think is incorrect behaviour).
> 
> The documentation of drm_connector_set_link_status_property explicitly
> states:
> 
>     * Note: Drivers cannot rely on userspace to support this property and
>     * issue a modeset. As such, they may choose to handle issues (like
>     * re-training a link) without userspace's intervention.
> 
> which I think conflicts with your suggestion.

In i915 we do the retraining in kernel. IIRC we only really use the bad
link stuff once retraining has failed hard enough that userspace
intervention is needed, ie. when we cannot reduce the link parameters
anymore without userspace selecting a mode with a lower resolution.

I think some more recent drivers may have opted to forego all in kernel
retraining and just punt it all to userspace. I think the link-status
property has existed for long enough that any userspace that doesn't
support it could simply be considered broken.

Actually I know of a single "userspace" that to my knowledge doesn't
implement the link-status stuff, and that is the in kernel fb helper.
That should probably be remedied...

-- 
Ville Syrjälä
Intel
