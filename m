Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148E1CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 19:48:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DBF10F556;
	Tue,  2 Jun 2026 19:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="KgBmveCK";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AF3610F557
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Iqo7/zwN9aWfNkgTeE+VK59ALzPS5BsWnY41xGS6ZDM=; b=KgBmveCKIwcHhTi8gtRwgA7q9S
 Zc8Nt2rKQN+vBy2nbYXqSpKmFnGbzR0UXG1Ap7LDihqEBh3BHkVvnaDHnZ6+SAkgU63ENV4H2GMFI
 +52051e5ehSkJ9rXadd94htTuoFJ7EKlBHyJ8uzri+GEHV/3gbix5I1n4D1EwCAtpPrOEqaH29D8u
 9GYGLM7Fwhxej5mA5PBaFl3myaN6mTMDpCIvl1vsK+b81zjG468M+nOSMDGfWmOcrneq1GGV0coL8
 prdQLTqjgl/MBjeuOoKnpPFZmdpGx5cSNxVrIeBzviyK3wGkKW+A8fRks6TJGV4D3k2UhJx4tCNAG
 v0x/p4yQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2 01/12] drm/bridge: synopsys: dw-dp: Support
 unregistering the AUX channel
Date: Tue, 02 Jun 2026 21:48:11 +0200
Message-ID: <8220078.YiXZdWvhHV@phil>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-1-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
 <20260501-synopsys-dw-dp-improvements-v2-1-d7e7f6bac77f@collabora.com>
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

Am Freitag, 1. Mai 2026, 00:20:28 Mitteleurop=C3=A4ische Sommerzeit schrieb=
 Sebastian Reichel:
> From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>=20
> The DisplayPort AUX channel gets initialized and registered during
> dw_dp_bind(), but it is never unregistered, which may lead to resource
> leaks and/or use-after-free.
>=20
> Add the missing dw_dp_unbind() function to allow the users of the
> library to handle the required cleanup, i.e. unregister the AUX adapter.
>=20
> Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller suppor=
t library")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

picked the same one from Cristian's series


