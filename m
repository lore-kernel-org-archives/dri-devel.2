Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371B606A333
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=hT1uyxmX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6822D10E821;
	Tue,  3 Nov 2026 13:46:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FFF710E821
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=QeBIzSBgbncOGqlM98hwD+JA9fUoC+6t2mWGJwt78Kw=; b=hT1uyxmXlGd35FvwuJi86gP5fh
 jJrzYSLnWjbn9JrgM1rOrYootc4LL5NwR+NlFuitkSw7wZftZ9ZwVbceHpXJ0pgnmW1XFOVY0ebfQ
 HV9g62vS9L6dqKIRX8jKqMSoGGM565N2LVqlrKtNU7HOV3PDrb+zQTwbBINLiM+UgUtsdlvAmiMYs
 /l45+mUYAT1M5Ouw3p7oDCkLni+r+V3Cmegi7eI/tCgbZO5+9LMt2OVQXn7CpEv4my1az7GreJ5UW
 0jJ/eKX19DRD/5u1dyjZGs9VcfS/rS4ZGNdRg3hTsY94ZlSJR0S+PkmqXA/pVzgcZ+ct0vyRID0d4
 q96ujZmQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Sandy Huang <hjc@rock-chips.com>,
 Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v5 00/18] Add HPD support for Rockchip Analogix DP
Date: Tue, 03 Nov 2026 14:45:41 +0100
Message-ID: <6109289.1B3tZ46Xf9@diego>
In-Reply-To: <20261027132810.1746118-1-damon.ding@rock-chips.com>
References: <20261027132810.1746118-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 27. Oktober 2026, 14:27:52 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Damon Ding:
> Changes in v5:
> - Add four new patches:
>   - Select VIDEOMODE_HELPERS for DRM_OF_DISPLAY_MODE_BRIDGE to fix
>     the undefined references for non-Exynos users.
>   - Unbind the bridge when drm_bridge_connector_init() fails on the
>     Rockchip and Exynos platforms.
>   - Declare DRM_BRIDGE_OP_HPD on the Analogix DP bridge and report
>     the hotplug events via drm_bridge_hpd_notify().
> - Move the next_bridge resolving patch and the forced connected
>   status restriction to the front of the series.
> - Use a pure threaded IRQ handler and hold runtime PM references in
>   the IRQ thread and the detect paths. (Sashiko)
> - Limit the runtime PM holding to the RK3576/RK3588 platforms and
>   exclude the boards with a fixed panel. (Sashiko)
> - Fix the display timings leak in analogix_dp_aux_done_probing().
>   (Sashiko)
> - Change the type of &analogix_dp_device.irq to int to fix the dead
>   dp->irq < 0 check. (Sashiko)
> - Rebase onto the latest drm-misc-next.

Everything still works, so for the new patches also
Tested-by: Heiko Stuebner <heiko@sntech.de>



