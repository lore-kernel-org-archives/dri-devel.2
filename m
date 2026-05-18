Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7FCCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EE410E283;
	Mon, 18 May 2026 09:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="A2xyQunE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB07310E283
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779094936; x=1810630936;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=aTG40c4Y+EMGK+d4CAZ/N98jpaLAu/y5lJ167xYZW2Y=;
 b=A2xyQunEdy2LD+l4JKtOZ2T4Bx3DktmzYGFV22B+TJ8cDCrZmOBwvCdy
 7/xsBwAi5F+A33WX/x8Il0wLu6k6+1NIE8gLm3R/WIa54zQte++zAtNvz
 tPjSe5X6vPv0PW0JjUB5/pobX+jhZRXwedKJ6Lnalpyemw/Qs+/BCA7qL
 ua8SbKDkGGtcAg4WKY1v03JxKss6u8z4FS0SE/LseCkpcY3l8q38uv+OW
 P25afX+7IgPWNQZ+g/y7bZnqzmHEe4V1bactM3SBITkjZ7PgtHa4uv9cX
 Av7gSypK41GMZoSwTcV1Z4a3oxju8JgfxcbOc1+dRxY8VZ1XZbiclq3+R Q==;
X-CSE-ConnectionGUID: NN+JbmcNRYWKRyzMo8pzIg==
X-CSE-MsgGUID: Ia0jHsTXRTekLdA91lwsSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="80115906"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="80115906"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 02:02:15 -0700
X-CSE-ConnectionGUID: rgiK3bF5SQqLbFzGvOQIYA==
X-CSE-MsgGUID: YVgfR5HuRPGOTbE6/t83LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="239627066"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 02:02:06 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonas Karlman <jonas@kwiboo.se>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>, Andy
 Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>, Christian
 Hewitt <christianshewitt@gmail.com>, Diederik de Haas
 <diederik@cknow-tech.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/22] drm: bridge: dw_hdmi: Use display_info is_hdmi
 and has_audio
In-Reply-To: <20260516183838.2024991-17-jonas@kwiboo.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260516183838.2024991-1-jonas@kwiboo.se>
 <20260516183838.2024991-17-jonas@kwiboo.se>
Date: Mon, 18 May 2026 12:02:03 +0300
Message-ID: <937d97789b78c4ad463c7e17f48f044837402537@intel.com>
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

On Sat, 16 May 2026, Jonas Karlman <jonas@kwiboo.se> wrote:
> -	/*
> -	 * FIXME: This should use connector->display_info.is_hdmi and
> -	 * connector->display_info.has_audio from a path that has read the EDID
> -	 * and called drm_edid_connector_update().
> -	 */
> -	edid = drm_edid_raw(drm_edid);
> -
> -	dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
> -		edid->width_cm, edid->height_cm);
> -
> -	hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
> -	hdmi->sink_has_audio = drm_detect_monitor_audio(edid);

Yay! \o/


>  
>  	return drm_edid;
>  }

-- 
Jani Nikula, Intel
