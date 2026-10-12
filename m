Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5330CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2FCF10EC7A;
	Mon, 12 Oct 2026 09:45:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1BB10EFB3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:44:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2ABC343ACF;
 Mon, 12 Oct 2026 09:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BF81F0089B;
 Mon, 12 Oct 2026 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791798294;
 bh=z9+4BbO9ibDxBWVau+TMbeg/ZMgTtPx2Di1N+vz6DeE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BVa/HCKLeVdW5UdRtj2DJEeLg6z1EyDf5HeeP6TLrn2MrtVdmAungKcieZ44zcC9X
 SSDVoxBpowXpwC28cT7Dm/O/S/xFSbUHk1hVsWMdQdiRcjC5OVTwyEwSaZ1EuJ0OmP
 JDuV4j+JCgsYz/tXYbevN3zgQqr5ERXT4C1vPCu/g7zgQ4Rr798ZvaF2JEcN0+Jca/
 nF5Ns+vDDtlcSw5t7NygtlpAK1HUvcFtUf765JFx7KH9tty2xVzNdD90/qIsq+DDpQ
 esO8rIGHAxNT/p+iH08Zuto19FZBuXVt6mfOw8xTuXa3Qir+dA8PYOjW9VHdg6WeL2
 9eYa4ruhAkIOg==
Date: Mon, 12 Oct 2026 11:44:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "airlied@gmail.com" <airlied@gmail.com>, 
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jesszhan0024@gmail.com" <jesszhan0024@gmail.com>, 
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, 
 "noralf@tronnes.org" <noralf@tronnes.org>, "robh@kernel.org" <robh@kernel.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add
 UNIHIKER M10 display
Message-ID: <20261012-wondrous-pronghorn-of-potency-aa0cf1@quoll>
References: <20261010232857.26950-1-founder@crepuse.com>
 <20261010232857.26950-2-founder@crepuse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261010232857.26950-2-founder@crepuse.com>
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

On Sat, Oct 10, 2026 at 11:28:59PM +0000, Miotsuki Mizuno wrote:
> The DFRobot UNIHIKER M10 V1.2 has a 240x320 SPI display with an
> ILI9341-compatible command interface. Its initialization sequence can
> be supplied to the existing panel-mipi-dbi driver as firmware.
> 
> Add dfrobot,unihiker-m10-display as the panel-specific compatible,
> with panel-mipi-dbi-spi as the fallback.
> 
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>

Same issues as with all your patches.

Best regards,
Krzysztof

