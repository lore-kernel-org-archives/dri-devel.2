Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E05606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=NfR7dokS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717B210E300;
	Fri, 30 Oct 2026 17:39:41 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B3310E573
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=rZQBVRZiCks/K/9Y1345LKLpm7rARRb46p5oLx1DJf0=; b=NfR7dokScM74IPFgp+YCYVEkyH
 E17lWekv02wo93KiwQhxCLpnf3qg8nW5Zzm0O/mjE84ldTbqIpKSc/FzPcx9JMHJ4gOTLPNSpC1UJ
 nYinkqL4eROOqDYCMpqKlm+Hrcxmfp3r6iJMajWmPfOChJsDQ+OongNNwE5U+ewunv8xwTVqHy+rC
 iMHufZEkUf+CjkHd4Xz1aUPPII+HfxGfiGIs1Es7cge6Uy3+BIgL9C2NbqefLnrPQvgeLVMP+Ll0T
 rcAtYyxJ1i1PH5LcdBa+OCShdGwv9kPMP4GpzpV/WwRXkPpkvEV9luefrRzpDTteyFG4Em1QkLXwT
 6M7z9YHg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yakir Yang <kuankuan.y@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Conor Dooley <conor@kernel.org>, William Qiu <william.qiu@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Byron Stanoszek <gandalf@winds.org>, OOHehir <oo.hehir@gmail.com>
Subject: Re: [PATCH v6 01/18] drm/bridge: inno-hdmi: fix swapped HSYNC and
 VSYNC polarity
Date: Fri, 30 Oct 2026 18:38:51 +0100
Message-ID: <3007313.yaVYbkx8dN@phil>
In-Reply-To: <20261029-jh7110-clean-send-v6-1-759594e43acf@samsung.com>
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075353eucas1p2e700f30e833a17c676488f1427d3e565@eucas1p2.samsung.com>
 <20261029-jh7110-clean-send-v6-1-759594e43acf@samsung.com>
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

Am Donnerstag, 29. Oktober 2026, 08:53:35 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Michal Wilczynski:
> v_HSYNC_POLARITY() and v_VSYNC_POLARITY() write the wrong bits: the
> hardware puts HSYNC in bit 2 and VSYNC in bit 3, the macros do the
> opposite. Most CEA modes drive both syncs with the same polarity so it
> goes unnoticed; it only shows up on modes where the two differ.
>=20
> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> Reported-by: Maud Spierings <maud_spierings@murena.io>
> Closes: https://lore.kernel.org/all/e780ecb8-918f-4816-99c8-b69b10b25a18@=
murena.io/
> Reported-by: Byron Stanoszek <gandalf@winds.org>
> Closes: https://lore.kernel.org/all/b8b046ee-c574-3e16-6079-2fc415633dae@=
winds.org/
> Suggested-by: Dominique Belhachemi <db@domibel.de>
> Tested-by: Maud Spierings <maud_spierings@murena.io>
> Tested-by: Byron Stanoszek <gandalf@winds.org>
> Tested-by: OOHehir <oo.hehir@gmail.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>


RK3036 TRM agrees with this assesment :-)

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


