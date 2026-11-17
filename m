Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C801606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CDA+btKW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9972510E63B;
	Tue, 17 Nov 2026 14:42:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A6C10E53C;
 Tue, 17 Nov 2026 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794926556; x=1826462556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=q4W2BYtbGrF9b+Sza6/X9rpK+8tQ7WvHYOd7Ql0pQuI=;
 b=CDA+btKWxaQTRb/tQxMrPzVlH75jUF5eA8x+tddSWn9OU8Z6SlR2NM0n
 aaqYCQAirc8SyZ0StwKgMndhEy80mAbByIE6YyCCqG4944L6UQzY2M/T4
 +EqjQ6kzQz17G6h7pGp4SJ3MFR8jpqwzmQWmOozOQUAUiPOy5eFT6VwJl
 u9udteOA0xN5KpOJmUwtBP4MAmyuhAQXmIh0y73L7iloaAmLMbg3EnUY8
 d6SUiqP5Fed73ZY/o6Hh+YAQeJ5M3PEt2vlbGjUybNL4LRs4miDebSyGF
 r4KP3zc2W/t2r9XfO/G5+Q5oDmZepDBY2O8A9x7Jv7G4Jl33XRHdVbYk6 Q==;
X-CSE-ConnectionGUID: N128iHX6RBqUz1tuwT6J4w==
X-CSE-MsgGUID: 9aXYgs6/RlSFF78EBURU8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3600739"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3600739"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:42:35 -0800
X-CSE-ConnectionGUID: BX821WPNTgqlq2KMILKrdg==
X-CSE-MsgGUID: atJO8mfxQl62FlzFQ0EonQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9714237"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.236])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 06:42:27 -0800
Date: Tue, 17 Nov 2026 16:42:23 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Erwin Springer <aot.lerwin@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Christopher Snowhill <chris@kode54.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Dmitry Baryshkov <lumag@kernel.org>, freedreno@lists.freedesktop.org,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Jianmin Lv <lvjianmin@loongson.cn>, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
 Liviu Dudau <liviu.dudau@arm.com>,
 =?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Maxime Ripard <mripard@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 nouveau@lists.freedesktop.org, Qianhai Wu <wuqianhai@loongson.cn>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Simon Ser <contact@emersion.fr>, wayland-devel@lists.freedesktop.org,
 Xaver Hugl <xaver.hugl@kde.org>, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH 00/12] drm/atomic: Try to make atomic+async usable, and
 clear up the "async update" helper confusion
Message-ID: <avxnz4Nt1IufM6oM@intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
 <1b7a7d94-e349-4f3c-b973-c365041c15f2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b7a7d94-e349-4f3c-b973-c365041c15f2@gmail.com>
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

On Mon, Nov 16, 2026 at 06:29:38PM +0100, Erwin Springer wrote:
> 
> Am 16.11.2026 um 10:11 schrieb Ville Syrjala:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > The weird uapi semantics of the atomic async flip support make it
> > really hard for drivers to implement. Try to fix that by filtering
> > out the no-op junk from the commit that userspace likes to put there.
> >
> > Also a lot of people are apparently confusing the
> > .atomic_async_{update,check}() hack with async flips. The two
> > are completely orthogonal, so try to clear up that mess by
> > renaming the hack to .atomic_bypass_{update,check}().
> >
> > TODO: atomic+async is in serious need to proper tests, somehow
> >        all that seems to have gotten skipped when the feature
> >        was added :(
> 
> thanks, this fixes the KWin case for me, so my patch is no longer
> needed..
> 
> tested on Raptor Lake-U (Iris Xe) with unmodified KWin 6.8.2 and a
> fullscreen client that requests tearing through wp_tearing_control_v1,
> without my patch. I applied the series to the CachyOS 7.3.4 kernel,
> the only conflicts were the renames in amdgpu and msm.
> 
> Before, none of about 350 frames per run was presented without vsync.
> With the series 3330 of 3336 frames tear over four runs (with and
> without CCS modifiers), and the "async flip not supported" message is
> gone. What is still rejected is the first flip after the modifier or
> format changed, once per run, as intended, and in three of the runs
> one commit that touches the cursor plane, which can't do async flips:
> 
>    [PLANE:146:cursor A] does not support async flips
> No warnings and no flip_done timeouts in the log.
> 
> If you think it fits, feel free to add:
> 
> Reported-by: Erwin Springer <aot.lerwin@gmail.com>
> Tested-by: Erwin Springer <aot.lerwin@gmail.com>

Thanks. There are quite a few unresolved issues left here
though, so we might want you patch as a short term fix.
I'll have to go read it with some actual thought...

-- 
Ville Syrjälä
Intel
