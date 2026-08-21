Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17437C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4584410E2C8;
	Fri, 21 Aug 2026 14:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="f3fc42g4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDF510E0A5;
 Fri, 21 Aug 2026 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787321981; x=1818857981;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=z8iAxAemn/0JgPj6PTSNSzKHXE5ttv1nlKOgH4UXlm8=;
 b=f3fc42g4r67o4M5QcIiohc57+sJwF6jeNaxMqW+tEY1Kl3TR8FXX6wNi
 rnl9Bze2/4MnKIT5JLbsRed7lWxA5rQskgISLX+NsODCD3ehmomhnhG5K
 Yv9elfLJv4yZox9XLp+0N2We+Xx+u+7Y0s5snUyzfM85PfQ/VfuHTEIlv
 rqYIE7qskdkfLcrcPPM8pfTk7vuGiDEwKjmuDvFq0v5ffBGbLcmZUbw8p
 JRIKYxJKtwRwDM47NbAms++KuE5h3xaoI8McHunn0H+IZoK5bPeRCWU8Y
 LwYTlBe3PvP3qP4eJjSmrgOZvw624PE2lGVNItX4+TgOemLRALrfE+mtE g==;
X-CSE-ConnectionGUID: hriM9syATUOY+pHFuKuBUg==
X-CSE-MsgGUID: mDrlPdSoRbyZOW93XcZNwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="99227883"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="99227883"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 07:19:41 -0700
X-CSE-ConnectionGUID: Z41FSKHpRRClrP8NuXTugg==
X-CSE-MsgGUID: JRl2iDgJTUeeglFRpLcyOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="269840184"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.20])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 07:19:37 -0700
Date: Fri, 21 Aug 2026 17:19:33 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Chang =?utf-8?B?Smlvbmco5bi454KvKQ==?= <xspeed1989@gmail.com>,
 intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3
 in bxt_sanitize_cdclk()
Message-ID: <aohedWm6CXXBWf-G@intel.com>
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
 <20260816062344.796615-1-xspeed1989@gmail.com>
 <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
 <c779c8e8fc78c68aea12c2022b2d8c64541ca173@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c779c8e8fc78c68aea12c2022b2d8c64541ca173@intel.com>
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

On Wed, Aug 19, 2026 at 12:33:56PM +0300, Jani Nikula wrote:
> On Tue, 18 Aug 2026, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Sun, 16 Aug 2026, Chang Jiong(常炯) <xspeed1989@gmail.com> wrote:
> >> Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
> >> without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
> >> CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
> >> comparing against the expected value.
> >>
> >> However bxt_cdclk_ctl() does not include the CD2X pipe select field
> >> at all on DISPLAY_VER() >= 30, so on Xe3 (PTL) the normalized
> >> readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
> >> never match the expected value (pipe field 0). The comparison now
> >> fails on every boot and we always take the full CDCLK PLL
> >> disable+re-enable path with the BIOS framebuffer actively scanning
> >> out - exactly what this code was trying to avoid. On a Panther Lake
> >> laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
> >> "CPU pipe A FIFO underrun" during probe and persistent full-screen
> >> scanout corruption for the first KMS client (the SDDM greeter);
> >> the corruption lasts until the next full modeset.
> >>
> >> Only normalize the CD2X pipe select field on platforms where
> >> bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
> >> check.
> >>
> >> Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Chang Jiong(常炯) <xspeed1989@gmail.com>
> >
> > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8569
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8901
> >
> > The first one has a patch from Ville that is identical to this one.
> >
> > I'll try to kick CI to get this tested before merging.
> 
> Okay, the patch is against some stable kernel, not against the current
> development tree. Please rebase on top of the drm-tip branch of the
> drm-tip repository.

I pushed my original fix and closed the other bugs as duplicates.

-- 
Ville Syrjälä
Intel
