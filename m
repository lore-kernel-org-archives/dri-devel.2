Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09DCA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10EB10E544;
	Fri,  9 Oct 2026 11:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pd4oh9v+";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A7B10E544
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:03:09 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (dynamic-2a00-1028-8389-0276-8139-a635-2d39-b80f.ipv6.o2.cz
 [IPv6:2a00:1028:8389:276:8139:a635:2d39:b80f])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56EBA2C6;
 Fri,  9 Oct 2026 13:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1791543669;
 bh=EnSS2mkkfJq48cwx3BqnKWo6QpqQbya5F/DfymlLfxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pd4oh9v+KW7FyR3QJdhUb3zdrJpc6YQXkWHqBzUEOc38nBHgL9Q2J1Xed/jlvWqUO
 FMCRnNaPaAm3Ovo+F0lVLVtceEJfJVOAQ9OPV/ZobZHCqBnTh7r6gJB8r+hpyWwvtg
 rMzafBTEi3RUHJgZb9XhifC6BZwcaQ+azyLRheN0=
Date: Fri, 9 Oct 2026 13:03:06 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: display: ti, tpd12s015: convert, and fix
 what the conversion exposed
Message-ID: <20261009110306.GB680229@killaraus.ideasonboard.com>
References: <20261009105601.301891-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009105601.301891-1-quchaosheng000406@163.com>
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

This is the fourth version of this series that you send within 10
minutes, without any version number in the subject line. Please stop
flooding reviewers.

On Fri, Oct 09, 2026 at 06:55:58PM +0800, Quchaosheng wrote:
> From: Chaosheng Qu <quchaosheng000406@163.com>
> 
> v4.  The three things Laurent pointed out on the v3 thread are addressed,
> and the conversion is separated from the two devicetree fixes it turned
> up.
> 
>   [1/3] converts ti,tpd12s015.txt to DT schema.  gpios is back to three
>         entries: the two drivers obtain exactly three through
>         devm_gpiod_get_index(), indices 0 to 2, and neither file mentions
>         scl, sda or ddc.  v3 had raised maxItems to five only to keep
>         dtbs_check quiet for omap5-igep0050.dts, which wrote a defect of
>         the DT source into the binding.  That was backwards.
> 
>   [2/3] drops the two extra entries from omap5-igep0050.dts, which is
>         where the defect belongs.  Nothing reads them: there is no
>         pinctrl group for those lines and no other consumer in the tree.
> 
>   [3/3] drops the unit-address from the tpd12s015 endpoints on
>         am5729-beagleboneai and am57xx-idk.  Those nodes carry a
>         unit-address without a matching reg property.
> 
> Each of the two devicetree patches removes a warning that the bare
> conversion leaves behind, so the three belong together:
> 
>   am5729-beagleboneai:  241 -> 237 dtbs_check warnings
>   omap5-igep0050:       188 -> 186 dtbs_check warnings
> 
> with no new warnings in either file.
> 
> Assisted-by: LLM is on all three, which the v1 posting and v3 were
> missing.
> 
> One thing I raised on the thread and should repeat here: Eduard Bostina
> posted the same conversion on 2026-07-30,
> <20260730092245.52034-1-egbostina@gmail.com>.  If his series is the one to
> carry this, say so and I will drop mine.
> 
> Chaosheng Qu (3):
>   dt-bindings: display: ti,tpd12s015: Convert to DT schema
>   ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi
>     encoder
>   ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
> 
>  .../bindings/display/ti/ti,tpd12s015.txt           |  44 ------
>  .../bindings/display/ti/ti,tpd12s015.yaml          |  90 ++++++++++++
>  arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |   4 +-
>  arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   4 +-
>  arch/arm/boot/dts/ti/omap/omap5-igep0050.dts       |   4 +-
>  5 files changed, 94 insertions(+), 52 deletions(-)

-- 
Regards,

Laurent Pinchart
