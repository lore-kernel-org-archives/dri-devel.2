Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92545CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F05910E5AD;
	Wed, 10 Jun 2026 11:54:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a8m9eQ+P";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB4010E483;
 Wed, 10 Jun 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781092485; x=1812628485;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=IBdSvbniv45jCKX2cc9fNGt2KfPPluvYcMxmenPPBM0=;
 b=a8m9eQ+PQeVhlZTCMjGLPcA2Y9U2Aw912dTp4B+8MOslLy51AuWkbKtU
 MBow95YbLgz+BaMoPWLBeB7YmLCbYg1wbbfOVynoBb84fkXCanK+SIJfr
 XGasThfEMrSvY/sDXk4w7zw+rn29XUHFEpqVtkGYWFBug1XM4P0jjJpHU
 1JShHhInuxRKbxhmAs6R7cnNKx21NcO1R90rPZwEm5xPK+bs77TnyeWkS
 3UvzjdUJQrBQ1FaqMokDLsZllB0zyEBHZ0hGkEHfR6sUN5gGjrTgM7AC+
 alGy5IvFrcbRAhaGiSNLEjkHq+OUHzx4xv4KYo/zD7jm58rrRv6sF3WkE A==;
X-CSE-ConnectionGUID: mZgg+GRvQ5K+oItAoA9a1Q==
X-CSE-MsgGUID: 3S5gGZ3wQ5OTSR2cw7bZfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81789866"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81789866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:54:44 -0700
X-CSE-ConnectionGUID: YLk1Sbj9TlyqNzCagqc0RQ==
X-CSE-MsgGUID: /M4SHBnES7ybbKKuTAV9eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="250439091"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:54:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan
 <andy.yan@rock-chips.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Daniel Stone
 <daniel@fooishbar.org>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v17 21/28] drm/tests: bridge: Add KUnit tests for bridge
 chain format selection
In-Reply-To: <gnicb4WkT1S4aQIC2G_naw@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
 <20260609-color-format-v17-21-35739b5782cc@collabora.com>
 <04ff70850213ae0f75486b1a27a7edb6fb4e71c3@intel.com>
 <gnicb4WkT1S4aQIC2G_naw@collabora.com>
Date: Wed, 10 Jun 2026 14:54:29 +0300
Message-ID: <596f0f063d6ef2ffb4c6640e3df5ed89d95b11dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, 10 Jun 2026, Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> If you don't want __maybe_unused, then sure, I'll move them into a new
> .c file. Though I think the two are roughly equivalent in that I don't
> think anyone is really trying to minimise the size of their KUnit
> binaries.

I think placing arrays in headers is bad practice, and we shouldn't set
that example, kunit or not.

> I'll send a patch to move them to a .c

Thanks.

BR,
Jani.


-- 
Jani Nikula, Intel
