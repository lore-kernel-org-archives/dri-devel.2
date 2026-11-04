Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9755606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mnpXecqY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284EF10E231;
	Wed,  4 Nov 2026 10:22:24 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E0D10E231
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=BvEDid5g6QRjHn3Z1Wkrnwm5AtJ8RllZNkH2qZNru5c=; b=mnpXecqYVSy9/XQTnCwe/QAZAT
 oO5u9hSGJdyjtMfzeKLmcnySDE7Pfz7vhog/jVLohqgjCNPJB/gaqxJYvQqOah+IGy7rTskfqua9Z
 Z71031F7JJC5OpNCUvjRL8w3G8oBL5t8D32sJMZx8fk6wMt83Nubl7nAPZX27fkdWACnPS5NWTCPt
 C/Lq3OYdR04M2QtVUCc7LoOJboS0YKoelxMlb23u8m6CFaYZT+DtJU3eVSqFbCP83H0lUMHQuCdqU
 T1Bu3zDGMij+udBlOhcK79QncRyN+sKcZ3uZ/iHhrpUccsz8pfP38qBskRoD1lolhDyy0DYiI1KQJ
 HDXRPhDg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 01/15] accel/rocket: request the core clocks by name
Date: Wed, 04 Nov 2026 11:21:46 +0100
Message-ID: <2231008.VsPgYW4pTa@diego>
In-Reply-To: <3188623.WAvfycf1tz@diego>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-2-gahing@gahingwoo.com> <3188623.WAvfycf1tz@diego>
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Dienstag, 3. November 2026, 23:42:19 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Heiko St=C3=BCbner:
> Am Sonntag, 1. November 2026, 09:22:53 Mitteleurop=C3=A4ische Normalzeit =
schrieb Jiaxing Hu:
> > From: Igor Paunovic <royalnet026@gmail.com>
> >=20
> > rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
> > setting the .id members. The rocket_core array is allocated with
> > devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
> > .rdev, .dev and .index, so all four clk_bulk_data entries are requested
> > with a NULL con_id (unlike core->resets, whose ids are set a few lines
> > above).
> >=20
> > clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
> > of_parse_clkspec() only consults "clock-names" when a name was passed, =
so
> > the index stays 0 for all four entries. Every entry therefore ends up
> > holding a handle to the *first* clock of the DT "clocks" property, i.e.
> > ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
> > four different clocks.
> >=20
> > The consequence is that rocket_device_runtime_resume() prepares and ena=
bles
> > the AXI clock four times, while hclk, pclk and - most importantly - the=
 NPU
> > compute clock ("npu", SCMI_CLK_NPU on RK3588) are never prepared or ena=
bled
> > by this driver at all. The NPU still works only because the Rockchip
> > power-domain driver sets GENPD_FLAG_PM_CLK and its attach_dev() callback
> > walks the device node with of_clk_get() and adds every clock to the pm_=
clk
> > list, so genpd happens to keep the remaining clocks running. The bug is
> > therefore latent today, but it means the driver holds no reference to t=
he
> > clock that actually feeds the NPU, which stands in the way of any future
> > frequency scaling (OPP/devfreq) work.
> >=20
> > Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
> > /sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
> > handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other=
 two
> > cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
> > "fdab0000.npu" consumer at all - their only consumers are the
> > "npu@fdab0000" handles created by the power-domain driver via of_clk_ge=
t().
> >=20
> > Set the ids explicitly, in the order mandated by the binding
> > (Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
> > aclk, hclk, npu, pclk. After the change the driver holds one handle per
> > distinct clock and clk_bulk_prepare_enable() covers all four.
> >=20
> > Note that this is a user-visible tightening for out-of-tree DTs: the old
> > NULL-id requests resolved by index and succeeded no matter what
> > "clock-names" contained, while the named requests fail probe with -ENOE=
NT
> > when one of the four names is missing. That is the right outcome for
> > in-tree users - the binding requires exactly these four clock-names and
> > rk3588-base.dtsi carries them on all three cores - but a DT that relied=
 on
> > the permissive lookup goes from silently running on the wrong clock han=
dles
> > to not probing at all, so record the change here where git log will find
> > it.
> >=20
> > Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU=
")
> > Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> > Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> > Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS,=
 NanoPC-T6 Plus
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
> > Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> nit: the commit description could be way shorter, for that small change.

note-to-self: also part of the DVFS series




