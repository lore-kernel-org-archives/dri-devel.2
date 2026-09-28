Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF80CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CC8510E0D7;
	Mon, 28 Sep 2026 12:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ECHJ3cZw";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC5F10E0D7
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 12:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=JS5dd5f9mWNpybqKgfuEd/QJ8IUXo+CpfbvRDEoiIGk=; b=ECHJ3cZwUWSupvEzyzR1mPXOLK
 VK19JixYTDfT7fybYoFw9vuFW0SbnORD4Y9j8GdDG9U0x9ll+cMggmyyksZSibgyPky0jIZd9+52W
 0htIfPxgQIkqF1zy95076+JaRF1wxQO8It9j4Ch+hEUzB/qGtobQbbooz+Of3zfmBVp9BCNTCcS5f
 oZ/fo1tAlJA8vAJQG+hv1+g2hi8sxj6JDQmpbtgP6RN9UCZa2dRfAR4rfB4nuQ/Itfbs3LLphZKk8
 UjHJNwa39/cTltFE+yjkzF6teFeYb8PsICQ/fTQpmq2Zx1djAdWIYGQsCxAErGU/HHsafXnccJO4L
 ocKRP2tA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v3 00/14] Add HPD support for Rockchip Analogix DP
Date: Mon, 28 Sep 2026 14:02:34 +0200
Message-ID: <3772572.AiC22s8V5E@diego>
In-Reply-To: <20260928081418.3605775-1-damon.ding@rock-chips.com>
References: <20260928081418.3605775-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Damon,

Am Montag, 28. September 2026, 10:14:04 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Damon Ding:
> Rebase after the following two patch series:
> [0] https://lore.kernel.org/all/20260915-drm-bridge-drm_panel-cleanup-v4-=
0-30401d9406f3@bootlin.com/
> [1] https://lore.kernel.org/all/20260916-drm-bridge-every-panel-v3-0-83af=
b4f1a707@bootlin.com/
>=20
> This series improves the HPD (Hotplug Detect) interrupt handling in
> the Analogix DP driver to enable reliable native HPD pin detection on
> Rockchip platforms, and introduces platform-specific HPD detection
> schemes with fine-grained interrupt control.


on my eDP panel with gpio-hotplug via the dp-connector as before, I get
a successful display output even on boot.

=2D plugged in on boot - display works / reported as connected
    - plugged out - correctly reported as disconnected
    - plugged in again - display works / reported as connected

=2D unplugged on boot - correctly reported as disconnected
    - plugged in - display works / reported as connected

Multiple plugin/plugout operations afterwards also worked nicely.

So
Tested-by: Heiko Stuebner <heiko@sntech.de>

Will do reviewing of patches now ;-)


Thanks for working on that
Heiko


