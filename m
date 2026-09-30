Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3219ECA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8811C10F19A;
	Wed, 30 Sep 2026 05:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oHRT/aAY";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA2810F19A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 05:29:28 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 27513C24;
 Wed, 30 Sep 2026 07:27:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1790746055;
 bh=bb/h/G1KkoN/bGMe9foM1wamD1apmUQT9PDmReJcscw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oHRT/aAYwkWLSfPeJrODtyMplN4MehCOvHaktDFV3qtB7or8dg3khp+6AxKrWYONp
 ATJGbNDPUdhNiEvFGaYqZVUXHURLOTsbCcQ87SQHCCVpDiHsp6gx3B/5wBhqOw58zN
 4VKbWPhq33rnMcxSBbtlQo683jA5SFZQWiC1k1i8=
Date: Wed, 30 Sep 2026 08:29:25 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Quchaosheng <quchaosheng000406@163.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Tony Lindgren <tony@atomide.com>, David Airlie <airlied@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti, tpd12s015: Convert to
 DT schema
Message-ID: <20260930052925.GA931211@killaraus.ideasonboard.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
 <179028680032.1886779.12172352669683602550.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179028680032.1886779.12172352669683602550.robh@kernel.org>
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

On Thu, Sep 24, 2026 at 04:53:20PM -0500, Rob Herring (Arm) wrote:
> On Wed, 16 Sep 2026 20:32:09 +0800, Quchaosheng wrote:
> > Convert the TPD12S015 HDMI level shifter binding to DT schema.
> > 
> > The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> > and ESD protection circuitry. Document the two ports it exposes between
> > the HDMI transmitter and the connector.
> > 
> > The tpd12s016 is software compatible with the tpd12s015 and is listed as a
> > fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
> > of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
> > using the tpd12s016 must list both compatibles.
> > 
> > The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
> > driver obtains through devm_gpiod_get_index(). omap5-igep0050.dts lists the
> > DDC SCL and SDA lines as two further entries, so allow up to five entries
> > and keep the property description focused on the ones the driver uses.
> > 
> > Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> > ---
> > v3:
> >  - gpios: allow up to five entries. v2 claimed that no in-tree board passes
> >    more than three, but omap5-igep0050.dts passes five: the three control/HPD
> >    lines plus the DDC SCL and SDA lines. The three-entry limit added in v2
> >    therefore broke dtbs_check for that board.
> > 
> > v2:
> >  - Reword the description: the TPD12S016 can only be used as a fallback of
> >    "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.
> > 
> >  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
> >  .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
> >  2 files changed, 93 insertions(+), 44 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> > 
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

I don't think the binding is correct. The two additional GPIOs seem to
be a mistake in the DT source. There's no rationale in this patch to
explain why they're needed.

-- 
Regards,

Laurent Pinchart
