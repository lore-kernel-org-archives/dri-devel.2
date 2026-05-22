Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D81CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1566710F6B4;
	Fri, 22 May 2026 17:06:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="XssD/oIi";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3CF10F6B4
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:06:05 +0000 (UTC)
Received: from francesco-nb (93-38-247-131.ip73.fastwebnet.it [93.38.247.131])
 by mail11.truemail.it (Postfix) with ESMTPA id 01CCA1F997;
 Fri, 22 May 2026 19:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779469564;
 bh=p2te36NQZDmTtHJmgYuEb9fatJ4Px85Y3bWQ849rbEo=; h=From:To:Subject;
 b=XssD/oIikPaNYnBLeAVFNfI/G5//1wZChmTJ8UnFrEaVs6G/p+UT2sar2fD9kqTAn
 VuqxiaPh8MZs4hicXvh7Eu3kNck8ZYl5NUvrJB+diUiyPPb6newfVWdwyfN6qDTIdr
 mpH0LUp5WLe2WA2C672oldLbKyrWkNFQHL/W0cMVDqJW683sd6FR+5v0iWYn4aa3Bx
 7fHu3ikC749VC0mMvgxyPyF++WAWruUZl3mIPFt3DfQCjz/KGtgKLCvctqeQ7vKlno
 uABWthW1AxSTqnI6ONq8bGdlmSltO1UjxIDaiany7k19CN9zBwlpEN8S6AGxsVb1t4
 20SWXDBCETOCA==
Date: Fri, 22 May 2026 19:05:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add display and
 peripheral overlays
Message-ID: <20260522170330.GA126484@francesco-nb>
References: <20260522161105.277519-13-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
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

On Fri, May 22, 2026 at 05:11:04PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> This series adds device tree overlays, expanding the hardware support for
> the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
> and peripherals available through Toradex carrier boards and the accessory
> ecosystem.

...

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

