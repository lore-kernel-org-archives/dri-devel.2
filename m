Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F05C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12A310F7C7;
	Thu, 24 Sep 2026 21:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mkoi/sO0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1484010F7C7
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A0E2600D4;
 Thu, 24 Sep 2026 21:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BEF1F00893;
 Thu, 24 Sep 2026 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790286802;
 bh=Ogr79LQ3rrbCZxJzcpqWXVBpLNfY+VyA7LvCCLZnVQk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Mkoi/sO04MomiAeKafvvlxoZSmU1xCcMWZQisp4s7UKkV2o1rfgcenihrMFiM8viy
 wfCBFiDGLDUuTY8WgjIQJQZsF1W0Lgs2ENuA4fjrHRjsB06q9dffHq75sP8qQFIA/T
 amJ70IgK84+BzkunwTPVSb3gqfGZ+G0G0k9puWnvma52XvaUJW7uKXZVZaKUs0m7gc
 h35AqVpQsTgcvFgMoCAg9tfrJB4lebSTVwEUoDsaG0jgxd+RyuLcDdzHgklMDUMLgN
 qkmITZzyWKtCdRcKjBJ6mxxG2I6gJCPXDGbS7q9dBjo7R1spsSAMO5g6LaTkiX/XUp
 utjUvhvQPzp2Q==
Date: Thu, 24 Sep 2026 16:53:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
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
Subject: Re: [PATCH v3 1/2] dt-bindings: display: ti, tpd12s015: Convert to DT
 schema
Message-ID: <179028680032.1886779.12172352669683602550.robh@kernel.org>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916123210.107841-1-quchaosheng000406@163.com>
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


On Wed, 16 Sep 2026 20:32:09 +0800, Quchaosheng wrote:
> Convert the TPD12S015 HDMI level shifter binding to DT schema.
> 
> The TI TPD12S015 is an HDMI companion chip that combines a level shifter
> and ESD protection circuitry. Document the two ports it exposes between
> the HDMI transmitter and the connector.
> 
> The tpd12s016 is software compatible with the tpd12s015 and is listed as a
> fallback compatible by am57xx-idk-common.dtsi, so accept it as a fallback
> of "ti,tpd12s015". The driver matches on "ti,tpd12s015" only, so a board
> using the tpd12s016 must list both compatibles.
> 
> The gpios property takes the three CT CP HPD, LS OE and HPD GPIOs the
> driver obtains through devm_gpiod_get_index(). omap5-igep0050.dts lists the
> DDC SCL and SDA lines as two further entries, so allow up to five entries
> and keep the property description focused on the ones the driver uses.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v3:
>  - gpios: allow up to five entries. v2 claimed that no in-tree board passes
>    more than three, but omap5-igep0050.dts passes five: the three control/HPD
>    lines plus the DDC SCL and SDA lines. The three-entry limit added in v2
>    therefore broke dtbs_check for that board.
> 
> v2:
>  - Reword the description: the TPD12S016 can only be used as a fallback of
>    "ti,tpd12s015", because the driver matches on "ti,tpd12s015" alone.
> 
>  .../bindings/display/ti/ti,tpd12s015.txt      | 44 ---------
>  .../bindings/display/ti/ti,tpd12s015.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
>  create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

