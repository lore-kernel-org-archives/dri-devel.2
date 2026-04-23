Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6D2FC0342
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B0F10E343;
	Thu, 23 Apr 2026 15:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BJIgUP1t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E497110E343
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776957874; x=1808493874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kPFzWuMbdFt2nPhBPZwueyc2evZNIfr6vYq45ngvAh8=;
 b=BJIgUP1t+X2oG3w5tkSGoN0JaaMKdF8Qh290vh+aCMrUFeD1zzC7O+vG
 u0M8dreOeFKd54abzU700hs0Y4xd/P0p3oyvI/BpvSOJhNOYeRHKtF9Mq
 8lsnm3if/wnh97Qo4t6VvoUw2eZwMjYD/B3FQRTR/EsJH+/lepd6S+Hh7
 sTKLLB/yBQMYjVsh7PGc1ls12cIpxKC7d2EsrdMSd2+OhiOJlhbywv384
 cmUDgcF20ZX7vpHko8eoCjx8oiRnnWoGRJYR41cjhcrLV91cvpqpXY73G
 GQsB2ps+Hw712BFuJJh0p3RBT2eC6hGhUcZCEOGXw6l5klLcEDpGnoU43 g==;
X-CSE-ConnectionGUID: o/WAVaO5Sr+JasT7zjr4nA==
X-CSE-MsgGUID: UYnNUDqMRheAv+uq4Ng1IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="95489216"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="95489216"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 08:24:33 -0700
X-CSE-ConnectionGUID: 1x2Qcjl2SUSwlxSdUqyFVw==
X-CSE-MsgGUID: B3viLWVOTV2i7BAAGDSaJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="230021107"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.188])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 08:24:27 -0700
Date: Thu, 23 Apr 2026 18:24:24 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, victoria@system76.com,
 sebastian.wick@redhat.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev,
 =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito@redhat.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v4 02/37] drm/blend: Get a rotation name from it's bitfield
Message-ID: <aeo5qPyOFoWd_F29@intel.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
 <20260422-vkms-all-config-v4-2-dbb52e9aadc3@bootlin.com>
 <aej82CO0l9_O1sX2@intel.com>
 <d9a66f6a-e07c-4bc2-bd91-8b9cb2994760@bootlin.com>
 <aen13JEWrKXiqRw4@intel.com>
 <d09a169d-2324-4fac-b08a-750e79bdfb81@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d09a169d-2324-4fac-b08a-750e79bdfb81@bootlin.com>
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

On Thu, Apr 23, 2026 at 04:22:11PM +0200, Louis Chauvet wrote:
> 
> 
> On 4/23/26 12:35, Ville Syrjälä wrote:
> > On Thu, Apr 23, 2026 at 10:47:38AM +0200, Louis Chauvet wrote:
> >>
> >>
> >> On 4/22/26 18:52, Ville Syrjälä wrote:
> >>> On Wed, Apr 22, 2026 at 06:47:59PM +0200, Louis Chauvet wrote:
> >>>> Having the rotation/reflection name from its value can be useful for
> >>>> debugging purpose. Extract the rotation property table and implement
> >>>> drm_get_rotation_name.
> >>>>
> >>>> Reviewed-by: José Expósito <jose.exposito@redhat.com>
> >>>> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> >>>> ---
> >>>>    drivers/gpu/drm/drm_blend.c | 35 ++++++++++++++++++++++++++---------
> >>>>    include/drm/drm_blend.h     |  2 ++
> >>>>    2 files changed, 28 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> >>>> index 1f3af27d2418..11d8e13caea3 100644
> >>>> --- a/drivers/gpu/drm/drm_blend.c
> >>>> +++ b/drivers/gpu/drm/drm_blend.c
> >>>> @@ -256,6 +256,31 @@ int drm_plane_create_alpha_property(struct drm_plane *plane)
> >>>>    }
> >>>>    EXPORT_SYMBOL(drm_plane_create_alpha_property);
> >>>>    
> >>>> +static const struct drm_prop_enum_list rotation_props[] = {
> >>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
> >>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
> >>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
> >>>> +	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
> >>>> +	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
> >>>> +	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
> >>>> +};
> >>>> +
> >>>> +/**
> >>>> + * drm_get_rotation_name - Return the name of a rotation
> >>>> + * @rotation: The rotation mask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
> >>>> + *
> >>>> + * Returns: the name of the rotation type (unknown) if rotation is not
> >>>> + * a known rotation/reflection
> >>>> + */
> >>>> +const char *drm_get_rotation_name(unsigned int rotation)
> >>>> +{
> >>>> +	if (rotation < ARRAY_SIZE(rotation_props))
> >>>> +		return rotation_props[rotation].name;
> >>>
> >>> The value is a bitmask. This does not work.
> >>>
> >>
> >> That true, the documentation is not clear.
> >>
> >> Take a look at patch 15 [1] for the usage. Is it better if I change the
> >> documentation to:
> >>
> >> drm_get_rotation_name - Returns the name of a rotation/reflection
> >> bitmask (with only one bit set).
> >> @rotation: Bitmask with a single bit set.
> >> Name of the rotation/reflection, or "(unknown)" if invalid.
> >>
> >> [1]:https://lore.kernel.org/all/20260422-vkms-all-config-v4-15-dbb52e9aadc3@bootlin.com/
> > 
> > For that kind of local thing I don't think it should be called
> > drm_get_rotation_name(). Also your docs seem to disagree with the
> > implementation.
> 
> I didn't remembered well, yes, this implementation takes the *index* of 
> the bitmask. So documentation is:
> 
> drm_get_rotation_name - Returns the name of a rotation/reflection
> @rotation: Bit index of the requested rotation (0 = DRM_MODE_ROTATE_0, 1 
> = DRM_MODE_ROTATE_90, ...)
> Returns: Name of the rotation/reflection, or "(unknown)" if invalid.
> 
> > But this does sound like a useful thing to have, eg. in
> > drm_atomic_plane_print_state().
> 
> I agree this can be a common implementation. Do you think the following 
> implementation can be the "common implementation"?
> 
> static const char* drm_get_rotation_name(int rotation_index) {
> 	return rotation_props[rotation_index].name
> }
> 
> void drm_get_rotation_str(int rotation, char *buf, int buflen) {
>      u32 offset = 0;
>      while (offset < ARRAY_SIZE(rotation_props))
>          if (1 << offset && rotation)
>              snprintf(buf,buflen,"%s ",drm_get_rotation_name(offset));
> }
> 
> An other solution can be format macro (inspiration from IGT, I don't 
> know if this is accepted in the kernel):
> 
> #define DRM_ROTATION_FMT "%s %s %s %s %s %s"
> #define DRM_ROTATION_FMT_ARGS(rot) \
> 	rot & 0x1 << 0 ? drm_get_rotation_name(0) : "", \
> 	rot & 0x1 << 1 ? drm_get_rotation_name(1) : "", \
> 	rot & 0x1 << 2 ? drm_get_rotation_name(2) : "", \
> 	rot & 0x1 << 3 ? drm_get_rotation_name(3) : "", \
> 	rot & 0x1 << 4 ? drm_get_rotation_name(4) : "", \
> 	rot & 0x1 << 5 ? drm_get_rotation_name(5) : ""

We do use those in places (eg. DRM_RECT_*). Sadly all ideas about nice
improvements to printk() formats pretty much died with the "can't
break the printf function attribute stuff", so macros might be the best
thing we can do.

I'd be OK with macros. Would just need to decide what the resulting
string should look like. Eg. is " " a good separator or would something
else be nicer to keep the grouping more clear? Or should we maybe put
some brackets/etc. around it?

> 
> > We already have at least one implementation of this in
> > i915/display/intel_display_debugfs.c, although with a bit more
> > terse format (and with somewhat weird "FLIP" terminology) to
> > make it not eat so much screen real estate.
> 
> I think it is better to have a consistent naming and use the enumeration 
> name everywhere, but if you think intel is better, I can switch.

4*"rotation-" + 2*"reflect-" + a bit more for the actual values
can make for a very long string. Too long, I suspect.

-- 
Ville Syrjälä
Intel
