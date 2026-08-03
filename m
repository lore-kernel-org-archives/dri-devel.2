Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A987C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 22:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601B010E0C5;
	Mon,  3 Aug 2026 22:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8Ec4Kpp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88FC510E0C5
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 22:17:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B19F60A59;
 Mon,  3 Aug 2026 22:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077141F000E9;
 Mon,  3 Aug 2026 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785795446;
 bh=3WeJos72ttiJG8idgzFWMe7RMdPcnTN0tGN50tPiISI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q8Ec4Kppwy2DajK8Q6p+5cIVr2Fj092lxSRbM4bh2aYT2xBlhsWk2M+8Eo0oRVwwu
 axos48ewmWTJUe2+9y66NM/iDbO8DIksCuVi7GkncoqQXKEhWI2NVIWlf3GjrwLfWn
 4yzAguu0MpNmEsN7N5YySv1ek7CzP7ePA4xe7fbYPMk5IwDr6XQi5GkBtyiBNvTSfP
 VFtTCJDWuThG3cQYOyF+bHf64y/NUhPvNe0IBk+K080MozQ+ezSh/AgjIo650PhITE
 7Hq5n/yefGZvBkxRFUIH++F2Qt7+wRcp23IEij4oL6/Ih/0uXdC2wjre5J8vP34IcD
 wroZ94RwUKxgA==
Date: Mon, 3 Aug 2026 17:17:25 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 simona.toaca@nxp.com, daniel.baluta@nxp.com,
 Kevin Hilman <khilman@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, goledhruva@gmail.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, m-chawdhry@ti.com,
 linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Roger Quadros <rogerq@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: ti: Convert ti, tpd12s015 to DT
 schema
Message-ID: <178579544500.726225.3201826985280204584.robh@kernel.org>
References: <20260730092245.52034-1-egbostina@gmail.com>
 <20260730092245.52034-2-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730092245.52034-2-egbostina@gmail.com>
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


On Thu, 30 Jul 2026 12:22:44 +0300, Eduard Bostina wrote:
> Convert the Texas Instruments TPD12S015 HDMI level shifter and
> ESD protection chip bindings to DT schema.
> 
> During the conversion, the following updates were made:
> - Added the 'ti,tpd12s016' compatible string, which is used in
>   am57xx device trees.
> - The 'gpios' property now allows up to 5 items, as the
>   omap5-igep0050 device tree routes additional control pins
>   beyond the standard 3 documented in the old text file.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
>  2 files changed, 78 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

