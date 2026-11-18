Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E88606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DTXYN49B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0A710E831;
	Wed, 18 Nov 2026 21:12:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8965F10E831
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795036333; x=1826572333;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wth4zz1xROv/Fl0zF6nwGKAs4YQsEkSPYWH6B5/fvHw=;
 b=DTXYN49B4dpYaIo6ellaYx6O5eogacu7djJOGrzPw+XPtN5KPiPrrmvM
 qWtjcuAlcQF5l0Xe+6PAUCfOYrLUR88nKrsrlx2yN2UQDRapsCZ5pHR4N
 /KE43aq2ijgqJmnHyjPjhYe1PLbEDhVR5B/xZiZPiNPRw/5aqlFZ8cDlr
 GcjaAJMSrDo5XkuKKjTEH4ByTtDZSVQ2UtlDjdxNI32bt32mqLUYZ16Um
 5/1xdPHgXhsIAzrdGhIXInrNzt9uthf5BOJFxAHt+nOJgz1NGaeSV9GCw
 9IVlv3SaAsouhypdrEq4t/o2Fn+0ZBHlVauT3ll+D8SrPmoDBUndw1xFn A==;
X-CSE-ConnectionGUID: Nqa0Z0C8RVypyiCzfsoSbg==
X-CSE-MsgGUID: Pa7nFWM8RVyzuaMa9BdJXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3893283"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3893283"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:12:12 -0800
X-CSE-ConnectionGUID: NMBwDZ7eR1WcRsmtrb88kw==
X-CSE-MsgGUID: A2Nhz6RJQpud1p7/R6REJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10517678"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:12:09 -0800
Date: Wed, 18 Nov 2026 23:12:06 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Julius Werner <jwerner@chromium.org>, Sean Rhodes <sean@starlabs.systems>,
 Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH] drm/sysfb: corebootdrm: Fix Kconfig dependency
Message-ID: <av4UphaS8l0I5GCY@intel.com>
References: <20261118205503.18924-1-ville.syrjala@linux.intel.com>
 <sashiko-outbox-221965@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-221965@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 09:02:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] drm/sysfb: corebootdrm: Fixes trailer cites wrong introducing
>   commit
> --
> 
> commit bff902d09954dd5579fb286ff3723415928aa52a
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> > drm/sysfb: corebootdrm: Fix Kconfig dependency
> >
> > DRM_COREBOOTDRM depends on GOOGLE_FRAMEBUFFER_COREBOOT, which is a
> > transitional stub symbol that can never be enabled. This makes the
> > driver impossible to select. Depend on the real symbol,
> > COREBOOT_FRAMEBUFFER, instead.
> >
> > Fixes: a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot framebuffers")
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> [Severity: Low]
> Should the Fixes: tag point to 44e33a5aaa2d ("firmware: Rename google
> firmware directory to coreboot") instead?
> 
> When a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot
> framebuffers") was added, GOOGLE_FRAMEBUFFER_COREBOOT was the active
> symbol and COREBOOT_FRAMEBUFFER did not exist yet.  44e33a5aaa2d
> ("firmware: Rename google firmware directory to coreboot") renamed it to
> COREBOOT_FRAMEBUFFER and turned GOOGLE_FRAMEBUFFER_COREBOOT into a
> promptless transitional stub without updating DRM_COREBOOTDRM, so citing
> a29a1f0ec8d6 ("drm/sysfb: corebootdrm: Add DRM driver for coreboot
> framebuffers") could cause stable backports onto kernels that do not yet
> have COREBOOT_FRAMEBUFFER.

Mea culpa. Didn't trawl the history hard enough.

Cc: Julius Werner <jwerner@chromium.org>
Cc: Sean Rhodes <sean@starlabs.systems>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>

-- 
Ville Syrjälä
Intel
