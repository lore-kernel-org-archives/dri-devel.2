Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E6CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C4F10E4F8;
	Wed, 20 May 2026 11:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="RYBTev16";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB9B10E4F8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=0pSVK+9EQxqVMM7Yjv49ZmJRac0skbNKar4/N2MFVSo=; b=RYBTev16Cq3YvXNlWCcs0wFF69
 eDsv+adZLd1yT5ULefQtKo+X44tNcAfUl7t5o/+u1cHreJ/abr4bRZAV5wiboCua7jRg8cb4PKW8+
 iV8dK9Iwn/0DzGNqFo9QYDao4UtZXXZN4gEdvRcrawQmjOn4gaeea5dZino47REa62XIqncgRRbG4
 WHmyxcV/KDsnFDUSbfsKoZ3kLMCN6lQS9L3ky99UPpD9mHwBimd7B0+XIZPHeACsIgJ/cfmCa5MJ6
 rVJ/9tdrUlRY+PFZTbKHebAYyizsnFaclzUbWe2lc3+DVt34ghHvhSYC3+iRF3wrpIix+IcQ+vHFc
 9xKGG2CQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Chaoyi Chen <kernel@airkyi.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peter Chen <hzpeterchen@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v15 0/9] Add Type-C DP support for RK3399 EVB IND board
Date: Wed, 20 May 2026 13:03:00 +0200
Message-ID: <4958503.687JKscXgg@phil>
In-Reply-To: <c0bc4796-afe5-40ff-8816-9605a6114d23@rock-chips.com>
References: <20260304094152.92-1-kernel@airkyi.com> <agxo8ic94e81nQRx@kuha>
 <c0bc4796-afe5-40ff-8816-9605a6114d23@rock-chips.com>
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

Hi,

Am Mittwoch, 20. Mai 2026, 03:13:25 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Chaoyi Chen:
> Hello Heikki,
>=20
> On 5/19/2026 9:43 PM, Heikki Krogerus wrote:
> > Hi,
> >=20
> > On Wed, Mar 04, 2026 at 05:41:43PM +0800, Chaoyi Chen wrote:
> >> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >>
> >> This series focuses on adding Type-C DP support for USBDP PHY and DP
> >> driver. The USBDP PHY and DP will perceive the changes in cable status
> >> based on the USB PD and Type-C state machines provided by TCPM. Before
> >> this, the USBDP PHY and DP controller of RK3399 sensed cable state
> >> changes through extcon, and devices such as the RK3399 Gru-Chromebook
> >> rely on them. This series should not break them.
> >=20
> > What's the status with this series?
> > Are these inteded to go via the DRM tree?
> >=20
> > thanks,
> >=20
>=20
> Thank you very much for your continued attention to this series.
> The maintainers seem quite busy... Despite there being no further review
> comments, this series have yet to be merged into the DRM tree.=20
>=20
> And some of my other patches are in the same situation.=20
> Do you happen to know what the next steps should be? Thank you.

=46or this series, I would think it'd be best to split it a bit.

=2D Make patches 1, 2, 5-7 its own series
  * patch 5 _should_ be included here, needs an Ack from the phy-maintainer
    to go through the drm-tree. It does look independent from the other
    phy changes (code changes themself), but needs the function from patch =
2.

=2D Make patches 3+4 its own series, so that phy maintainers notice
  The code-changes themself seem independent of the rest
  * Reference the drm-series and explicity note that the phy-patch in it
    needs an Ack from the phy maintainer to through the drm-tree
    Hopefully helps to get that
  * patch 1 has a Reviewed-by from the type-c side, but needs someone
    knowing drm-bridge internals to agree

=2D Makes patches 8+9 its own series, reference both series from above
  as dependencies.


That would be my take here, to have the right maintainers notice they
should do something.


Heiko


