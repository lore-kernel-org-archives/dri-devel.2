Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D46606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aK/0J3vZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB97D10E7A5;
	Mon, 23 Nov 2026 09:08:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 233A810E7A5;
 Mon, 23 Nov 2026 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795424915; x=1826960915;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=iadGTTZpgIj0sYqSUfXwnmqzZltFtxbp5DiO51+/m38=;
 b=aK/0J3vZaUCuN4Eil1jth1Rqits0I+XYtVCUqhXk1ODdpqiZh+oCIRYl
 Pmw5wT0BTC+FW7QP0izv22DMa7hg04XMov0oHIOElOOV0rg5HrTQ9Z8xw
 WtxQCB1REvpuiPHde5sVQwPkmU1IGMNz2h9jqDhYEhwhNMTplTKyJWTKG
 9ae2PyGBCZzNTcOUwh1t6gQ+W5Ida9Azhxf9zH+wxpByNw8oiIWjRLYAZ
 VNwHDM1DS88nolRzVGunvoLwftHRNPqTkQ/9rNX4vXMaO1hFWnhCASW8e
 k3MwcWMlivOL9T/OW+LhGWlyTZ6oQvV5uOEFv6ftM1sWk+96RytVaUWQT w==;
X-CSE-ConnectionGUID: xVq6PTMVSFqLMSDDwWP76g==
X-CSE-MsgGUID: IhzH2Tq3Tva4JDK5+WI99g==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4213116"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4213116"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:08:34 -0800
X-CSE-ConnectionGUID: M4L018usSfS0xTfajJhMQg==
X-CSE-MsgGUID: nuGMrwQAS0CwcWgbWLh5oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11123681"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.170])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 01:08:29 -0800
Date: Mon, 23 Nov 2026 11:08:26 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
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
Message-ID: <awQCiqG9rwxY_kAI@intel.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
 <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
 <awPvoLCDeq1YFLE_@houat> <awPzsMWZ7e0i6i54@intel.com>
 <awP0nasqAc4pAeMR@houat>
 <xlv14id8rl10.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xlv14id8rl10.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 23, 2026 at 09:48:11AM +0100, Javier Martinez Canillas wrote:
> Maxime Ripard <mripard@kernel.org> writes:
> 
> > On Mon, Nov 23, 2026 at 10:05:04AM +0200, Ville Syrjälä wrote:
> >> On Mon, Nov 23, 2026 at 08:50:29AM +0100, Maxime Ripard wrote:
> >> > On Fri, Nov 20, 2026 at 11:19:13AM -0600, Mario Limonciello wrote:
> >> > > 
> >> > > 
> >> > > On 11/20/26 10:41, Ville Syrjälä wrote:
> >> > > > On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:
> 
> [...]
> 
> >> > > > > +config DRM_LUMINANCE
> >> > > > > +	bool "DRM connector luminance support"
> >> > > > > +	help
> >> > > > > +	  Expose relative luminance as an atomic DRM connector property. Values
> >> > > > > +	  are driver-defined levels rather than absolute luminance in cd/m^2.
> >> > > > > +	  Drivers provide connector helper callbacks to program their hardware;
> >> > > > > +	  the DRM core does not depend on a particular backend.
> >> > > > > +
> >> > > > > +	  Drivers migrated to this interface will use it instead of registering
> >> > > > > +	  a legacy backlight class device. Leave this disabled to preserve the
> >> > > > > +	  de-facto userspace ABI in /sys/class/backlight.
> >> > > > 
> >> > > > I don't think this will fly if it breaks the backlight class interface.
> >> > > > No one can actually enable this outside of some niche embedded use
> >> > > > cases where backwards compatibility is not an issue. I think what
> >> > > > you need is a generic backlight class implementation on top of this.
> >> > > > 
> >> > > 
> >> > > The idea with this was:
> >> > > 1) to get the series landed
> >> > > 2) let compositors merge solutions around it.
> >> > > 3) Then add backwards compatibility to kernel so we can flip the Kconfig
> >> > > default.
> >> > 
> >> > I said this a few times already, but we keep having those discussions
> >> > while the backlight sysfs handling is far from being the main point. You
> >> > should *really* consider adding support for the luminance property for
> >> > something that isn't tied to that interface (like DDC/CI for HDMI), and
> >> > treat the sysfs API as a sysfs series.
> >> > 
> >> > It looks like people just have conflicting opinions on this particular
> >> > part that isn't going to solve itself easily. You should not treat this
> >> > sysfs discussion as a blocker for the infrastructure work.
> >> 
> >> You want to be sure backwards compatibility with the backlight
> >> class is a solvable problem before you land *anything*. Otherwise
> >> you might just paint yourself into a corner with no way out.
> >
> > I disagree. The luminance property is more useful than *just* for
> > backlights but is also useful for HDMI, DP, and MIPI-DSI that would all
> > use it.
> >
> > If that's the corner we paint ourselves into, it's still a pretty nice
> > corner.
> >
> 
> I agree with Maxime. Drivers can choose to not expose the luminance property
> until the sysfs backward compatiblity is sorted. But this shouldn't block the
> core infrastructure to land, given that's useful for other drivers/use cases.

If by infrastructure you mean just essentially defining the property,
then sure you could add that. But you can only hook it up for external
displays. For anything internal you actually need a working backlight
to see anything so the backlight class interface must stay.

Oh, and what's the actual plan to make this usable for external
displays? The property will have to be added onto the connector when
it's registered, but the display you hook up later may not even
support DDC/CI. How is userspace to know that the property is a dud?

-- 
Ville Syrjälä
Intel
