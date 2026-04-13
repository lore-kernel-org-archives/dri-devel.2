Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE90F531C4
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300A510E511;
	Mon, 13 Apr 2026 18:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QuU4gMya";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F3310E50D;
 Mon, 13 Apr 2026 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776105934; x=1807641934;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=IJgA2Jxj1ewy8Fefwuu7JHOczR6vtdnyBKngXgZ+7V4=;
 b=QuU4gMyarmQtEpqgaPbChKbYhJD7AwmPm8wtAKn8xe82h7JvhNPW/m0D
 CXaU2kjrabswLnXmfIl4mY5NMoWicocIqhgasr6iDuJ5n7q2IF+mOBm/Y
 Rsq3tKPD1aJ2ht6jVZ0CH/Kd3Ezni1lWEOmXywreAoMyBOF/nm3s0NHmx
 oikAETXPybReR/LtmQvQFnAIkrmP4Qz369RgKmseqY99ilifrPpbYe3EP
 Q13ElEbxqrBLM7/escI3B6GpPGgKZcG28rcOBU25l5YTh6ajGjiDUMmiU
 4QkiR1QFfIbEUUj4Fhc9LxXSZY3iyIFKBw4ZWzPDq750xc8LK++EF72mw A==;
X-CSE-ConnectionGUID: 2e5ahwGPSeqXTkhzeprw4Q==
X-CSE-MsgGUID: D0A5NJjgS+exrd/KrbKmqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77016442"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="77016442"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 11:45:32 -0700
X-CSE-ConnectionGUID: cL1tUNhMT3inlQpZ4Ig2pg==
X-CSE-MsgGUID: WcpCzJ05QPmiPMAPYrziEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; d="scan'208";a="225565560"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.97])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2026 11:45:22 -0700
Date: Mon, 13 Apr 2026 21:45:19 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, kernel@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Werner Sembach <wse@tuxedocomputers.com>,
 Andri Yngvason <andri@yngvason.is>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH v13 00/27] Add new general DRM property "color format"
Message-ID: <ad05v935wrjn-A5R@intel.com>
References: <20260413-color-format-v13-0-ab37d4dfba48@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413-color-format-v13-0-ab37d4dfba48@collabora.com>
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

On Mon, Apr 13, 2026 at 12:07:14PM +0200, Nicolas Frattaroli wrote:
> Hello,
> 
> this is a follow-up to
> https://lore.kernel.org/all/20250911130739.4936-1-marius.vlad@collabora.com/
> which in of itself is a follow-up to
> https://lore.kernel.org/dri-devel/20240115160554.720247-1-andri@yngvason.is/ where
> a new DRM connector property has been added allowing users to
> force a particular color format.

Looks like we're still missing the wayland folks in the cc. But I was
told that everyone should just cc wayland-devel@lists.freedesktop.org
on all relevant uapi stuff. So please add that on the next version.

The i915 rework is now merged so you should even get a buildable
series next time.

I'll go read the i915 parts now...

-- 
Ville Syrjälä
Intel
