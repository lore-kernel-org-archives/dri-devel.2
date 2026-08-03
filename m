Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3769FC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EF210E0B1;
	Mon,  3 Aug 2026 20:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b5+g8a3p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366E110E0B1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 20:54:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D263F43E02;
 Mon,  3 Aug 2026 20:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937591F000E9;
 Mon,  3 Aug 2026 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785790468;
 bh=cAICv9Y3OiRkODMPephn+FNJ7giL9q2NHL4/K0cdySo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=b5+g8a3pgXZdcnVmp568x58Ne0p6KUyuwI+CO9HFchejoac9WP747WJLGny3v2ubQ
 un/M+93X4m9qDZBekn+JWjr5qukpgI84qfzXEq/rGWz5NUtfW3cljAGw0Ynergdqzx
 dGMcClv6OSGacnww5Z4uwLfRvADsNDQZtedrM/PgpJ8WLvgvDwsBggt/kkP1+7qdhY
 W//sy9NVnMjUwpSmatMEKuQLOCH+ZYOqoYzN2nBR/6sAvyRjh8ysEkPZ4f/bG62G2q
 /lEDodIwZC8whYvAg4Mc/OR2eheDDCD5PnYbHEsLGT/zLD5cWByIEh/34sSQMiZW5s
 2FLYO+li4csaA==
Date: Mon, 3 Aug 2026 15:54:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, krzk@kernel.org, jingoohan1@gmail.com,
 pavel@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 lee@kernel.org, manuelebner@mailbox.org, devicetree@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 danielt@kernel.org
Subject: Re: [PATCH v2] dt-bindings: fix typos and brackets
Message-ID: <178579016893.432136.13741968373464663974.robh@kernel.org>
References: <20260722101246.3113818-2-manuelebnerli@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722101246.3113818-2-manuelebnerli@mailbox.org>
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


On Wed, 22 Jul 2026 12:12:47 +0200, Manuel Ebner wrote:
> Add missing '(', ')', '}'
> Remove needless '(', ')', '{', '}'
> 'lover voltage' -> 'lower voltage'
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> [v2]
>  rebased
> 
> [v1]
>  https://lore.kernel.org/all/20260713134751.498891-2-manuelebner@mailbox.org/
> 
> I changed to my new address, manuelebner +LI @mailbox.org to
> reduce the mail to my main address.
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml           | 2 +-
>  .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 2 +-
>  .../bindings/clock/renesas,rcar-usb2-clock-sel.yaml           | 4 ++--
>  .../devicetree/bindings/memory-controllers/renesas,dbsc.yaml  | 2 +-
>  .../devicetree/bindings/memory-controllers/ti-aemif.txt       | 4 ++--
>  Documentation/devicetree/bindings/mips/brcm/soc.txt           | 2 +-
>  Documentation/devicetree/bindings/phy/phy-miphy365x.txt       | 2 +-
>  Documentation/devicetree/bindings/powerpc/ibm,vas.txt         | 2 +-
>  Documentation/devicetree/bindings/regulator/max8907.txt       | 1 -
>  .../bindings/regulator/mediatek,mt6358-regulator.yaml         | 2 +-
>  .../devicetree/bindings/regulator/pbias-regulator.txt         | 1 +
>  .../devicetree/bindings/regulator/rohm,bd71837-regulator.yaml | 4 ++--
>  .../devicetree/bindings/regulator/rohm,bd71847-regulator.yaml | 4 ++--
>  .../devicetree/bindings/sound/mikroe,mikroe-proto.txt         | 1 -
>  Documentation/devicetree/bindings/usb/iproc-udc.txt           | 1 +
>  15 files changed, 17 insertions(+), 17 deletions(-)
> 

I applied, but dropped the .txt changes. The only fixes for .txt 
bindings are converting them to schema.

Thanks,
Rob
