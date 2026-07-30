Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED61C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D3E410EEF8;
	Thu, 30 Jul 2026 11:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="IJ9KA5ka";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E912C10E148
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=uoqq1t7wo5rd6IE4QW2AeY1PA9dd7LzEhkBVOmAfXAQ=; b=IJ9KA5kaKVbh9kAGoIuAs0737n
 9KwbWbh80SbvMTcZZeuiWrY0drRB52Sgl//jlu2Sq+NI5ELjBO21p78aAq+1Pr58IU/KB8Q6eOtFj
 yxp2ra/AEeBbAiPZBvSb2KdgPQN5fSN26n08OXX+KjgKyLb0cG/YJqxuSyBCCBWrYRhBrrqwJJLEA
 deYS0ROJtc6Yma+esHRqKQUuV2qbTQgATAUCFgM94YQJik1RQjeu3LtA9HexaCd3xfkyl9myj0WtQ
 9ggGAkSFC8czPcuutPi0cb9P1Tn//427Bip3RojIlPsQwJxR58QPCRsXmlFK3dklWgzegwMUiHbTy
 WTCwYcUA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: hjc@rock-chips.com, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v10 00/11] Add eDP support for RK3576
Date: Thu, 30 Jul 2026 13:56:17 +0200
Message-ID: <2154821.UkFFEUeh36@diego>
In-Reply-To: <20260601065100.1103873-1-damon.ding@rock-chips.com>
References: <20260601065100.1103873-1-damon.ding@rock-chips.com>
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

Am Montag, 1. Juni 2026, 08:50:49 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Damon Ding:
> Patch 1-5 are to add missing clock "hclk" for RK3588 eDP nodes.
> Patch 6 is to use automatic cleanup to fix OF node reference leak
>         reported by Sashiko.
> Patch 7-8 are to add the RK3576 eDP node.
> Patch 9-11 are to support the RK3576 Analogix DP controller.

Not sure what happened, but I don't see an applied mail about the DTS
patches (3+4+8) in my own mail archive, nor on lore.

Nevertheless I did apply them to my dts64 branch [0]  on july the 24th as
[03/11] ede2ee37f0a445cacbf24760f53befa10f64994a
[04/11] 09820811c549ee2c408defe36b210b13c7a85fcf
[08/11] a41687b89005f50909e59130a4c0b08e82996739


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/log/?h=3Dv7.3-armsoc/dts64


