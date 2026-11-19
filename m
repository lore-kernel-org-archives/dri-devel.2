Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C1606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=or97LhWs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A124711276B;
	Thu, 19 Nov 2026 22:27:43 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5369911276B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:27:37 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119222735euoutp026f6f3e5e30d54b124225f6099846dd28~pkrpV3Vft2621426214euoutp02l
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:27:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261119222735euoutp026f6f3e5e30d54b124225f6099846dd28~pkrpV3Vft2621426214euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795127255;
 bh=Gw21rCu/43xBoSdthLncYWjsZIEeYs8OLG6vafnDDv4=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=or97LhWsLl7I5ccY+57i4tr6eQg6gBgRvZuzEgO4y6t8GXjQE/YU0TwDkcDEv54ym
 k6BDGH8UwbKQgDmB71g4WwuU8nUOblaHSWck8E5rwkhKmnkiS9lGxkevYKvUC5P4/t
 ZwQaFnM+29u7T5LAUTQy+jg98baFT4pqH0jBtHH4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261119222734eucas1p267f89d0fef9ad13d4d35a02406960b2d~pkroiGVWP0677706777eucas1p20;
 Thu, 19 Nov 2026 22:27:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261119222733eusmtip24a38f8f2fa2ac2b57fd924c5c638754e~pkrnjWM3n1183311833eusmtip2E;
 Thu, 19 Nov 2026 22:27:33 +0000 (GMT)
Message-ID: <7f73a078-1041-43b7-8e35-3a2d9c69240f@samsung.com>
Date: Thu, 19 Nov 2026 23:27:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/bridge: analogix_dp: Power down synchronously on
 bridge disable
To: Brian Norris <briannorris@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Damon Ding
 <damon.ding@rock-chips.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Douglas Anderson <dianders@chromium.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <av9AkwQDhB7O4wgl@google.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119222734eucas1p267f89d0fef9ad13d4d35a02406960b2d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
X-EPHeader: CA
X-CMS-RootMailID: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
 <20261119084923.1156243-1-m.szyprowski@samsung.com>
 <av9AkwQDhB7O4wgl@google.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 19.11.2026 19:31, Brian Norris wrote:
> On Thu, Nov 19, 2026 at 09:49:21AM +0100, Marek Szyprowski wrote:
>> The pipe (FIMD -> DP video) clock on Exynos is switched from the
>> analogix_dp runtime PM callbacks via plat_data->power_on()/power_off(),
>> which require the encoder to be still attached to a CRTC. The driver
>> relies on pm_runtime_put_sync() in analogix_dp_bridge_disable() to run
>> the runtime suspend callback immediately, while the encoder->crtc link
>> is still valid.
> This is a bit concerning, as this is somewhat of a misunderstanding of
> how runtime PM works. (But then, I guess it's not really surprising that
> people misunderstand runtime PM -- it's highly confusing.)
>
> Runtime PM cannot guarantee that something powers off, at least while
> runtime PM is enabled. It provides hints, but those can be overridden.
>
> A primary reason: /sys/.../<this_device>/power/control can be set to
> 'on', which means the device will always be prevented from
> runtime-suspending. So I assume that if you 'echo on >
> .../power/control', you'll still see the same bug.
>
> (It's possible that 'power/control' is the only way things break. I've
> wondered at times whether we should allow for drivers to opt out, and
> block this interface.)


Sigh... Runtime PM API is highly confusing and imho a bit over-engineered.

Indeed, after calling

echo on >/sys/bus/platform/drivers/exynos-dp/145b0000.dp-controller/power/control

the display is broken again after suspend/resume cycle. It looks that the
source of this issue is in using runtime PM to control display pipe clocks. After
moving that to encoder's enable/disable it works fine in all 3 cases: before the
mentioned commit, after it and with power/control set to "on". This also matches
the pipe clock handling in other Exynos DRM sub-drivers. Thanks for a
constructive review.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

