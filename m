Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6775BFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF2610E693;
	Mon, 27 Apr 2026 10:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="ungP194k";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CEB10E693
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Yp6hw9YMUgyBOlWT7AEyu22BSsvL8XW4ydyheGX7ebs=; b=ungP194ke67KZU5pOYDrDK4HRt
 39+h5iKodZrPPc3WP3GJYIdwdDcuK7sfhBdP/fYS8mBpBW0L+4x7+27aTH8nwmc6AVV4RkcoT7DQL
 IkYwhSHkJRRfA9FPYpGD4uGLFm0ZI50bARTZK4MxIq/FDHWr40hHzrnqTDe/8VSoZGfJWozga84HQ
 dTJRkKQGn3u1R9MosVaskZDpqpb55lW9AvrkzxjlGm102hV9MJGIFvnl2WC4lDCVylE54QDvn+rPr
 nj/JKQmt/ZRhA5tZmTcyE9H0Dz+Nxzz34vQ/1ZwD8fuDmhEvIsml4+mPFHCnzS4g9jZXFhu0c+gef
 y2SGQNEg==;
From: Heiko Stuebner <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Dennis Gilmore <dennis@ausil.us>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>
Subject: Re: [PATCH v8 0/6] Add support for Orange Pi 5 Pro
Date: Mon, 27 Apr 2026 12:37:57 +0200
Message-ID: <6856027.GXAFRqVoOG@phil>
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
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

Hi Dennis,

Am Samstag, 25. April 2026, 05:10:05 Mitteleurop=C3=A4ische Sommerzeit schr=
ieb Dennis Gilmore:
> This series adds initial support for the Xunlong Orange Pi 5 Pro, based on
> the Rockchip RK3588S SoC. The board features eMMC, SD card, NVMe (PCIe),
> a Motorcomm YT6801 NIC (PCIe), WiFi/BT (BCM43456), dual HDMI output (the
> second via a Lontium LT8711UXD DP-to-HDMI bridge on dp0), and a 40-pin
> expansion header.

more as a general node as the dp-hdmi thing is ongoing, you might want
to just submit the orange-pi5-pro basics first and do a separate series
with the display parts (both driver + dts integration).

That way the core board support can already be applied and get testing.


Heiko


