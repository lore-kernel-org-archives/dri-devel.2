Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA4606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RyCBZcAQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0773F112782;
	Thu, 19 Nov 2026 22:40:16 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B051A11277D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:40:09 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119224008euoutp01a66843b0bd49764fc98e8cfbd518b0a6~pk2mSgnNx2887528875euoutp01H
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:40:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261119224008euoutp01a66843b0bd49764fc98e8cfbd518b0a6~pk2mSgnNx2887528875euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795128008;
 bh=v1pid69c6AqxktwlVef27d207kXfneiPxNCly/6nJg4=;
 h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
 b=RyCBZcAQcjWrmEsln/Sd6QNHXGm/Ru9cEDjZh7Jicff+GTnBpaqKwef/z57HjGC5Q
 /HG3852Z5wOtfYGKJEQRK5OuQbbt9C7uUMN1EbFMlPBLurIlCa3tyF9IyhFHeStq/g
 nj/RG89qhIC+yeDFV7Na6+vRzpIGlJh9flzIuegg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261119224007eucas1p18e861340540526071ca53582c2743acb~pk2l12Khe1013610136eucas1p1E;
 Thu, 19 Nov 2026 22:40:07 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261119224006eusmtip14637798dca82db63f5057a98ee8b605f~pk2kxt1Eu1774617746eusmtip1i;
 Thu, 19 Nov 2026 22:40:06 +0000 (GMT)
Message-ID: <e2b7d648-36f9-460e-b4c7-5acd3fe73fe4@samsung.com>
Date: Thu, 19 Nov 2026 23:40:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/bridge: analogix_dp: Power down synchronously on
 bridge disable
From: Marek Szyprowski <m.szyprowski@samsung.com>
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
In-Reply-To: <7f73a078-1041-43b7-8e35-3a2d9c69240f@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119224007eucas1p18e861340540526071ca53582c2743acb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
X-EPHeader: CA
X-CMS-RootMailID: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
 <20261119084923.1156243-1-m.szyprowski@samsung.com>
 <av9AkwQDhB7O4wgl@google.com>
 <7f73a078-1041-43b7-8e35-3a2d9c69240f@samsung.com>
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

On 19.11.2026 23:27, Marek Szyprowski wrote:
> On 19.11.2026 19:31, Brian Norris wrote:
>> On Thu, Nov 19, 2026 at 09:49:21AM +0100, Marek Szyprowski wrote:
>>> The pipe (FIMD -> DP video) clock on Exynos is switched from the
>>> analogix_dp runtime PM callbacks via plat_data->power_on()/power_off(),
>>> which require the encoder to be still attached to a CRTC. The driver
>>> relies on pm_runtime_put_sync() in analogix_dp_bridge_disable() to run
>>> the runtime suspend callback immediately, while the encoder->crtc link
>>> is still valid.
>> This is a bit concerning, as this is somewhat of a misunderstanding of
>> how runtime PM works. (But then, I guess it's not really surprising that
>> people misunderstand runtime PM -- it's highly confusing.)
>>
>> Runtime PM cannot guarantee that something powers off, at least while
>> runtime PM is enabled. It provides hints, but those can be overridden.
>>
>> A primary reason: /sys/.../<this_device>/power/control can be set to
>> 'on', which means the device will always be prevented from
>> runtime-suspending. So I assume that if you 'echo on >
>> .../power/control', you'll still see the same bug.
>>
>> (It's possible that 'power/control' is the only way things break. I've
>> wondered at times whether we should allow for drivers to opt out, and
>> block this interface.)
>
> Sigh... Runtime PM API is highly confusing and imho a bit over-engineered.
>
> Indeed, after calling
>
> echo on >/sys/bus/platform/drivers/exynos-dp/145b0000.dp-controller/power/control
>
> the display is broken again after suspend/resume cycle. It looks that the
> source of this issue is in using runtime PM to control display pipe clocks. After
> moving that to encoder's enable/disable it works fine in all 3 cases: before the
> mentioned commit, after it and with power/control set to "on". This also matches
> the pipe clock handling in other Exynos DRM sub-drivers. Thanks for a
> constructive review.

For the reference, this is the patch implementing this approach:

https://lore.kernel.org/all/20261119223843.3694307-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

