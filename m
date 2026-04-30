Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA4CFF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64BC10ED8F;
	Thu, 30 Apr 2026 13:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BcaGs0Wn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8986310ED8F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:53:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D909C6057A;
 Thu, 30 Apr 2026 13:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D4FC2BCB3;
 Thu, 30 Apr 2026 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777557224;
 bh=fWyb1fnAhDmuoMg4sCok6IXhdPjS4ufIlM7IHmfO3cQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=BcaGs0WnxaKXHcEN5c7CFyBz3gN9zxY+w5isfrSHyrkHWZRtHBSQDZ0MTtTCx2DEl
 pelTfHZHQdyr2wijxR5oF4cfb9x7kHzT5cuPWdRL85aJa9J+T/QTBo+JwSsCu06drh
 jALonMAMuEE5mo9+n4E41Gydnk49mRedhQ6yfjzoO5UKu5bJ1H4HeSn5QmDW24iWlV
 FXTMpNkt4qlEobCNgek4pdZEJIGYC8L57RLYZsdABxEYZqA43YCjRGYajBXKZ0+odx
 6m4DxopmDNnGa5lXamWE9k/zG5yjSuHq1RLRo3Sh19qPo01blTQPgkH2kXKQHYI1Bz
 nl9+H5FMuQd7Q==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
References: <20260407-max25014-v8-1-14eac7ed673a@gocontroll.com>
Subject: Re: (subset) [PATCH v8 1/4] dt-bindings: backlight: Add max25014
 support
Message-Id: <177755722019.2606736.10749503716773482329.b4-ty@b4>
Date: Thu, 30 Apr 2026 14:53:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Tue, 07 Apr 2026 16:41:42 +0200, Maud Spierings wrote:
> The Maxim MAX25014 is a 4-channel automotive grade backlight driver IC
> with integrated boost controller.

Applied, thanks!

[1/4] dt-bindings: backlight: Add max25014 support
      commit: 5fcbbedec9dfce78044eee922bf2030e1bd03faa

--
Lee Jones [李琼斯]

