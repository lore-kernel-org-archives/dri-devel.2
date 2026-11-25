Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6230606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xw47pLSz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278DC10E0CC;
	Wed, 25 Nov 2026 10:47:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F3D10E0CC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795603619; x=1827139619;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ppic9Wb5AnDH/xDYDG9AIfElTtzrxzInMPOwz110ry0=;
 b=Xw47pLSznYFnWLyZYtjoKZXnsXY/tftQGFWjf3g0Hqu33Nzczo9wpiGf
 7HUa8SL7KiyvDxR3iigNhBaqE0PPyQpCX2I/FJReao+0d3QBGjkZvudYz
 ZrY3laIdV5TEaKBJt7M2d20n7XXaJKYUxyVatPTEIwMPFl77DGMNEYlNH
 kN+1Uf2gRq0LgL4cxaidljS/Z9HRki3Doof+P5qkTWHY4Xch6Ra2SCtWa
 jNYNFK923XRaZFdHuiCbLOn3Kz4THnsKyBmq3g4us6irhO/yxAes/lT2y
 EjmuEZTEWAMk6ymCVVSJvSR4JOy/B6jOEub2a2gKZjdEyn/oKJ7tvfls0 A==;
X-CSE-ConnectionGUID: hM7L779PQBWDxE+EqRFlNw==
X-CSE-MsgGUID: Sy4b3vRRRw6bbG386kwr1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4363129"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4363129"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:46:59 -0800
X-CSE-ConnectionGUID: CUWN79kcRii0wl9orE4MtA==
X-CSE-MsgGUID: vEmYBW59SGmHfGjRYmng+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="12052559"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.40])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 02:46:56 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com, Hefei <3066883572@qq.com>
Subject: Re: [PATCH v6 0/6] Add VIEWE 7" JD9365TX MIPI-DSI panel support
In-Reply-To: <tencent_C93E80ACC0BEB9083D9EE87E575073C67D09@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_C93E80ACC0BEB9083D9EE87E575073C67D09@qq.com>
Date: Wed, 25 Nov 2026 12:46:54 +0200
Message-ID: <2c928c89d9ae84be62cefc2b6ba638282ca0efa1@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026, Hefei <3066883572@qq.com> wrote:
> Hi,
>
> This series adds support for the VIEWE 7KF82 7" 720x1280 in-cell MIPI-DSI
> panel based on Jadard JD9365TX (2-lane video mode), plus the companion
> I2C touchscreen and I2C backlight MCU used on the same FPC.

You really need to figure out and fix your git format-patch/send-email
setup to thread your series properly. The patches should be in-reply-to
the cover letter. Now they've been sent separately. The in-reply-to in
the patches point at non-existent messages.

BR,
Jani.

>
> This is a different programming model from the existing JD9365DA driver
> (panel-jadard-jd9365da-h3.c): page select uses 0xDE (not 0xE0), bring-up
> uses 0xDF unlock, and lane config is via 0xCC rather than 0x80.
>
> Tested on Raspberry Pi 4 and Raspberry Pi 5 with a downstream dtoverlay
> (not included here):
>   https://github.com/raspberrypi/linux/pull/7633
>
> Changes in v6:
> - Run checkpatch / checkpatch --strict; add MAINTAINERS entries
> - panel: drm_of_get_panel_orientation(); mipi_dsi_dcs_write_seq_multi()
> - touch: usleep_range for short delays
> - backlight: expand Kconfig help text
>
> Please prefer this v6 over earlier revisions.
>
> Thanks,
> Hefei
>
> Hefei (6):
>   dt-bindings: display: add VIEWE 7KF82 JD9365TX panel
>   dt-bindings: input: add Jadard JD9365TX touchscreen
>   dt-bindings: backlight: add VIEWE 7KF82 I2C backlight
>   drm/panel: add VIEWE JD9365TX 7 inch DSI panel
>   Input: add Jadard JD9365TX in-cell touchscreen driver
>   backlight: add VIEWE 7KF82 I2C backlight driver

-- 
Jani Nikula, Intel
