Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C36A606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TZXuUrwb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A2910E37B;
	Mon, 23 Nov 2026 08:43:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA03489CCE;
 Mon, 23 Nov 2026 08:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795423388; x=1826959388;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=MwNw1jHqiF03UavbZ0MYFr+t71mFbIJ5NSImEXkKNoE=;
 b=TZXuUrwb96CCoeIgjNZUfQGDu/Wkmq7MjarXx9IMBdxhw04KfWknioAQ
 uhod3dqSEByN6Gg4lH+G+oAZg88XXQ0YeJEo8yFEHR9C6oMJGEtsOPk5s
 5DJL0RsmVAfAMQDtrizqXj0jgLWtXSY+ULmNjqLTJE/DjMdwMHbM/B/VW
 0EWGIDxDggDdSsvKuo9yN4hPyUxZ5gPYo6fb87UiaCEiQL0bwVi728iNJ
 YJOZVLZA7t4h4EwJ6b6DpdQM0z3ylY6n0tp/YecHkQZXukuw/Q90rK4GW
 RRBSquYPo5Lxs4B4gsD14ursZ0d1j1SHbBMdXfrU+z9p8Vp/d0QAGoEK6 w==;
X-CSE-ConnectionGUID: DHhlRsd1TzuyOu4TpLcvAw==
X-CSE-MsgGUID: yCZXRreaTSm9AfA9ex+a2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4060413"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4060413"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:42:53 -0800
X-CSE-ConnectionGUID: DxH5gyX0Q0G1X9Kj1NZlUA==
X-CSE-MsgGUID: dvoXU8AVS2+a6pVDrzJXjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11263290"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.170])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:42:47 -0800
Date: Mon, 23 Nov 2026 10:42:44 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <superm1@kernel.org>,
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
Message-ID: <awP8hAy3Gim4eNxz@intel.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
 <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
 <awPvoLCDeq1YFLE_@houat> <awPzsMWZ7e0i6i54@intel.com>
 <awP0nasqAc4pAeMR@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awP0nasqAc4pAeMR@houat>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:10:17AM +0100, Maxime Ripard wrote:
> On Mon, Nov 23, 2026 at 10:05:04AM +0200, Ville Syrjälä wrote:
> > On Mon, Nov 23, 2026 at 08:50:29AM +0100, Maxime Ripard wrote:
> > > On Fri, Nov 20, 2026 at 11:19:13AM -0600, Mario Limonciello wrote:
> > > > 
> > > > 
> > > > On 11/20/26 10:41, Ville Syrjälä wrote:
> > > > > On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:
> > > > > > Panel brightness is a property of a display, and thus of a DRM
> > > > > > connector. Add an atomic per-connector LUMINANCE range property so
> > > > > > compositors can manage relative panel luminance together with the rest
> > > > > > of the display state.
> > > > > > 
> > > > > > Keep the core backend-agnostic. Drivers create the property with their
> > > > > > hardware range and implement connector helper callbacks to set luminance
> > > > > > or disable panel emission. The atomic helpers sequence those callbacks
> > > > > > around pipeline enable and disable, including luminance-only commits.
> > > > > > The panel is left lit when the pipeline enters self refresh, and the
> > > > > > luminance is only reprogrammed when it changes or a modeset enables the
> > > > > > pipeline.
> > > > > > 
> > > > > > The stored property value is independent of display power. A commit made
> > > > > > while the connector is inactive is retained and applied on the next
> > > > > > enable; disabling the pipeline does not overwrite it.
> > > > > > 
> > > > > > LUMINANCE values are relative, driver-defined levels rather than
> > > > > > absolute luminance in cd/m^2. The interface supports emissive panels as
> > > > > > well as panels with a separate backlight.
> > > > > > 
> > > > > > Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
> > > > > > drivers retain their legacy backlight class ABI unless the new interface
> > > > > > is explicitly selected, allowing the DRM UAPI and legacy compatibility
> > > > > > policy to remain separate.
> > > > > > 
> > > > > > Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> > > > > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > ---
> > > > > > v11:
> > > > > >   * Don't call .disable_luminance when the CRTC enters self refresh (Sashiko)
> > > > > >   * Only call .set_luminance when the luminance changes or on a modeset
> > > > > >     that isn't a self refresh exit (Leo Li, Sashiko)
> > > > > >   * Fix the .set_luminance self refresh documentation
> > > > > > v10:
> > > > > >   * Add tag
> > > > > > ---
> > > > > >   drivers/gpu/drm/Kconfig                    | 14 +++++
> > > > > >   drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++++++++++++++++++++++++-
> > > > > >   drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
> > > > > >   drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
> > > > > >   drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
> > > > > >   drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
> > > > > >   include/drm/drm_atomic_helper.h            |  3 +
> > > > > >   include/drm/drm_connector.h                | 16 +++++
> > > > > >   include/drm/drm_modeset_helper_vtables.h   | 28 +++++++++
> > > > > >   9 files changed, 255 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > > > > > index 61111d50b1c65..1bbe2c2d7c76f 100644
> > > > > > --- a/drivers/gpu/drm/Kconfig
> > > > > > +++ b/drivers/gpu/drm/Kconfig
> > > > > > @@ -33,6 +33,20 @@ endmenu
> > > > > >   if DRM
> > > > > > +config DRM_LUMINANCE
> > > > > > +	bool "DRM connector luminance support"
> > > > > > +	help
> > > > > > +	  Expose relative luminance as an atomic DRM connector property. Values
> > > > > > +	  are driver-defined levels rather than absolute luminance in cd/m^2.
> > > > > > +	  Drivers provide connector helper callbacks to program their hardware;
> > > > > > +	  the DRM core does not depend on a particular backend.
> > > > > > +
> > > > > > +	  Drivers migrated to this interface will use it instead of registering
> > > > > > +	  a legacy backlight class device. Leave this disabled to preserve the
> > > > > > +	  de-facto userspace ABI in /sys/class/backlight.
> > > > > 
> > > > > I don't think this will fly if it breaks the backlight class interface.
> > > > > No one can actually enable this outside of some niche embedded use
> > > > > cases where backwards compatibility is not an issue. I think what
> > > > > you need is a generic backlight class implementation on top of this.
> > > > > 
> > > > 
> > > > The idea with this was:
> > > > 1) to get the series landed
> > > > 2) let compositors merge solutions around it.
> > > > 3) Then add backwards compatibility to kernel so we can flip the Kconfig
> > > > default.
> > > 
> > > I said this a few times already, but we keep having those discussions
> > > while the backlight sysfs handling is far from being the main point. You
> > > should *really* consider adding support for the luminance property for
> > > something that isn't tied to that interface (like DDC/CI for HDMI), and
> > > treat the sysfs API as a sysfs series.
> > > 
> > > It looks like people just have conflicting opinions on this particular
> > > part that isn't going to solve itself easily. You should not treat this
> > > sysfs discussion as a blocker for the infrastructure work.
> > 
> > You want to be sure backwards compatibility with the backlight
> > class is a solvable problem before you land *anything*. Otherwise
> > you might just paint yourself into a corner with no way out.
> 
> I disagree. The luminance property is more useful than *just* for
> backlights but is also useful for HDMI, DP, and MIPI-DSI that would all
> use it.

DSI and eDP are all over the place when it comes how backlight
is implemented, so very much would not all use it. Some HDMI and
external DP displays might have DDC/CI support, so I'll give you
those.
 
> If that's the corner we paint ourselves into, it's still a pretty nice
> corner.

Separate APIs for different outputs on different drivers is just
a bad idea. Every userspace implementation will have to support
all of them until the end of the world.

Mobile devices is also where backlight is actually important.
And also where an atomic backlight interface would make the most
sense since it may also be involved in proper HDR support.

For external displays backlight is very much an afterthought
(as witnessed by the fact that almost no one uses ddccontrol),
and I don't think DDC/CI can actually support true atomic
backlight changes.

-- 
Ville Syrjälä
Intel
