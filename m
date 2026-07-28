Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664D4C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D053F10E346;
	Tue, 28 Jul 2026 11:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hYLBAnqO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4638410E346
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785237739; x=1816773739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CEC0PWc9c8Dk5MrGNLXkXa/+6f3RiIpIJLGkeqttGJQ=;
 b=hYLBAnqO9vgq6W8NFTj0R2/lLO/DerlzY+9DT4FbagmuMUB3i3Udpmmf
 6SyJSUR/F1ipnQdxXkuuteA3srw7eTOKyCrH3c2iw7+reo2JAXNqEsx/R
 ToFIAPFSUYHEr5mPdATkUl/zeenfSoyIs8zeialCZx3l0UxJFXvl2eGrN
 h7QtJ5jGVjolUgH0cwmImMQrr///rlYJD7BIzGiu3s0upVmtdwPjtZOTy
 UnniLxymESIfg8xSAM5kWAjWyuyTXVHDp1GYDM1b31+UWC1V3UoZPLIgu
 XhXRdJEWhoNyxrBL1cLDAGRElGWHc0B3RhsQm9Mi3CUDYDPbodHEqsIBe A==;
X-CSE-ConnectionGUID: /GWaVA5TSBuKv+ZECoHDhQ==
X-CSE-MsgGUID: PdCWBbbySDmg4CdxZhiscA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89488454"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="89488454"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:22:19 -0700
X-CSE-ConnectionGUID: 3FETktcxT6WFbLk1YrodRw==
X-CSE-MsgGUID: BF3nxl86SzOUPs5VoOgAxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="255741093"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 04:22:15 -0700
Date: Tue, 28 Jul 2026 13:22:12 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
 andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com,
 riana.tauro@intel.com, karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v2] drm/drv: Add buffer bounds check in
 drm_dev_wedged_event()
Message-ID: <amiQ5AAHmCG2ra8e@black.igk.intel.com>
References: <20260724063005.703631-2-mallesh.koujalagi@intel.com>
 <93a1cbea41d0cc337b8e38b12ab405757b6854b9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93a1cbea41d0cc337b8e38b12ab405757b6854b9@intel.com>
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

On Tue, Jul 28, 2026 at 01:59:44PM +0300, Jani Nikula wrote:
> On Fri, 24 Jul 2026, Mallesh Koujalagi <mallesh.koujalagi@intel.com> wrote:
> > event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> > scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> > content bytes (token + comma) and requires one additional byte
> > for the NUL terminator within 'size'.
> >
> > Without a bounds check, if the remaining space is insufficient,
> > scnprintf() silently truncates the recovery token mid-name,
> > producing a malformed uevent payload (e.g. "WEDGED=bus-reset,vendor-spe").
> >
> > Add a pre-flight drm_WARN_ON() guard:
> >
> >   len + strlen(recovery) + 1 >= WEDGE_STR_LEN
> 
> The kernel has seq_buf precisely to avoid manually rolling tedious and
> error prone bounds checks everywhere. Please consider converting the
> whole thing to it instead.

+1, much better.

Raag

> > Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> > Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> > ---
> > v2:
> > - Add proper logic to handle recovery string. (Raag)
> > ---
> >  drivers/gpu/drm/drm_drv.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index e51ed959da89..e48b22ca38bd 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -586,6 +586,20 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
> >  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
> >  			break;
> >  
> > +		/*
> > +		 * scnprintf(buf, size, "%s,", recovery) writes strlen(recovery)+1
> > +		 * content bytes (token + comma) and reserves 1 byte for NUL within
> > +		 * 'size'.  It fits without truncation when:
> > +		 *   len + strlen(recovery) + 1 <= WEDGE_STR_LEN - 1  (safe)
> > +		 * so warn and bail when:
> > +		 *   len + strlen(recovery) + 1 >= WEDGE_STR_LEN       (would truncate)
> > +		 * Note: ">= WEDGE_STR_LEN - 1" would be off-by-one — it would
> > +		 * incorrectly reject the exact-fit case where NUL lands on the last
> > +		 * valid byte (index WEDGE_STR_LEN - 1).
> > +		 */
> > +		if (drm_WARN_ON(dev, len + strlen(recovery) + 1 >= WEDGE_STR_LEN))
> > +			break;
> > +
> >  		len += scnprintf(event_string + len, sizeof(event_string) - len, "%s,", recovery);
> >  	}
> 
> -- 
> Jani Nikula, Intel
