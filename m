Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F5606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=XbypoaSb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5D410E140;
	Tue, 24 Nov 2026 20:11:23 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FB210E140
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 20:11:17 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 649BC1FB70;
 Tue, 24 Nov 2026 21:11:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795551075;
 bh=BUOM/pw3EPem2znFd85kknUWld1XRJydYwICtGMnpY8=; h=From:To:Subject;
 b=XbypoaSb3rZ8QDSvopbLldDok1saNhtoQUuNEoy+DZ5zWVbRU/OerIecVBfXjCbeo
 MP/w7okOc3p+Hky5VLK8AWBWB6U7mGvpVEckwVgjJPWsfstqXa5aEQfPCA68F/nMrw
 RwZtd5LZvKYNbLAMkFrDUnGUyWFaXsY97UCOqADhtIl3a0Jw3KdhEDX8ud7lutppcn
 vLs7s//I4BiynvdEeriU7F7nzLUEQE4s4NEvBc3rDgZIKFUy/va+c7KHXhMSQHQkZ3
 Av3eXAx9H7RJrz0IE1WkvB5wKvdsoSHEuoWfLUK32Eno6VcEBNJQ+33PP2Xhd4zR1M
 flv2RIwwqef0Q==
Date: Tue, 24 Nov 2026 21:11:10 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.Li@nxp.com>,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] arm64: dts: freescale: imx93: Add MIPI DSI
 controller node
Message-ID: <20261124201110.GA366860@francesco-nb>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
 <20261111133119.1063210-4-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111133119.1063210-4-frank.obergfell@bytesatwork.ch>
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

Hello Frank (both),

On Wed, Nov 11, 2026 at 02:31:17PM +0100, Frank Obergfell wrote:
> Add dsi node to the i.MX93 for support with mipi dsi panels.
> 
> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>

I am not sure if the other patches of the series are ready to be merged
or not, but this seems a patch we should merge in any case so that we
enable other users of the DSI interface of the imx93.

What do you think? What's the plan for this series?

(yes, I could test and review it to help, I know :-)

Francesco

