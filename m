Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF91606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=Nza9K1RN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E124210E5AC;
	Wed,  4 Nov 2026 11:08:05 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E0C10E879
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ybk9PjsAKZvMCgCYSb/Xfuyw4DvYxnCaG7n+1bV4cp0=; b=Nza9K1RNNnmbGtzGs4dx3xHTcf
 +usFhekww9t4ygED3ZXPcYdGBGR9+MpYqihUpejRUCQMesQ9wxOOzfYnGaC+o95mYmKU83XgriN+g
 TuioynnpubfcdxJBjBh+azoeIeAa7nNa+LGPqgO99YyHthQNChyBvW37HrzOak2vS+vLY+Z99MjU4
 aZsgHM4r1caPhZf/b+JOcR4VE0qMAjjAYfx1JXJZJHConsyTvWeExcK94JBEtYfh9ZDNeF3Pj03DN
 CxmlNweHuoNKFDTjawuUazJV0gwWzQmxz8L/3xn+r5BWYygtaN4xnCqb87yJO0mkJXI2dZ7wh8h2o
 D8HGfr/g==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Igor Paunovic <royalnet026@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?B?SMO8c2V5aW4=?= BIYIK <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v2 05/11] accel/rocket: request the core clocks by name
Date: Wed, 04 Nov 2026 12:07:42 +0100
Message-ID: <3117045.BaHzMo0RvP@diego>
In-Reply-To: <20260922080114.44662-6-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-6-royalnet026@gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 22. September 2026, 10:01:08 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Igor Paunovic:
> rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
> setting the .id members. The rocket_core array is allocated with
> devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
> .rdev, .dev and .index, so all four clk_bulk_data entries are requested
> with a NULL con_id (unlike core->resets, whose ids are set a few lines
> above).
>=20
> clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
> of_parse_clkspec() only consults "clock-names" when a name was passed,
> so the index stays 0 for all four entries. Every entry therefore ends up
> holding a handle to the *first* clock of the DT "clocks" property, i.e.
> ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
> four different clocks.
>=20
> The consequence is that rocket_device_runtime_resume() prepares and
> enables the AXI clock four times, while hclk, pclk and - most
> importantly - the NPU compute clock ("npu", SCMI_CLK_NPU on RK3588) are
> never prepared or enabled by this driver at all. The NPU still works
> only because the Rockchip power-domain driver sets GENPD_FLAG_PM_CLK and
> its attach_dev() callback walks the device node with of_clk_get() and
> adds every clock to the pm_clk list, so genpd happens to keep the
> remaining clocks running. The bug is therefore latent today, but it
> means the driver holds no reference to the clock that actually feeds the
> NPU, which stands in the way of any future frequency scaling
> (OPP/devfreq) work.
>=20
> Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
> /sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
> handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other
> two cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
> "fdab0000.npu" consumer at all - their only consumers are the
> "npu@fdab0000" handles created by the power-domain driver via
> of_clk_get().
>=20
> Set the ids explicitly, in the order mandated by the binding
> (Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
> aclk, hclk, npu, pclk. After the change the driver holds one handle per
> distinct clock and clk_bulk_prepare_enable() covers all four.
>=20
> Note that this is a user-visible tightening for out-of-tree DTs: the
> old NULL-id requests resolved by index and succeeded no matter what
> "clock-names" contained, while the named requests fail probe with
> -ENOENT when one of the four names is missing. That is the right
> outcome for in-tree users - the binding requires exactly these four
> clock-names and rk3588-base.dtsi carries them on all three cores - but
> a DT that relied on the permissive lookup goes from silently running on
> the wrong clock handles to not probing at all, so record the change
> here where git log will find it.

same comment as in the RK3576 series, please trim this down a lot.
The change is not that big :-) .


Heiko



