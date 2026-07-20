Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8924C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:51:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB6610E0BA;
	Mon, 20 Jul 2026 06:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h9z2zFJc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C80A10E0BA
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:51:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C065B4127C;
 Mon, 20 Jul 2026 06:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75891F000E9;
 Mon, 20 Jul 2026 06:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784530270;
 bh=mB4VfrE4IPaRs5nWbuzDw2hUqa4EvbcO2Mbi+Mnfh38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=h9z2zFJcev5nFSleKWKEEGP1WC0USJTYp/ds3ksIT9XTrXc876yk9of+EyhDRb6/o
 HTi3k1KLFLHnOFmNtf0XuWleGTtQp1xydZQ0fKUdRSkg6yyy2VEoGxzcD4n+bIbc3a
 HccDZMOxnkwoIovCQXcXApmWfR3GDTN7BI7ffUQ5frKEIhUmxunWthxzGY2zJGk0y3
 K4tJp+nSqoDWqcKydFei7hHb25al8SvoJiDuSuzhl+4Cs3cIQA8oAbtJSrotLMIyBv
 rcHYLWyY89SQ0tngY+/0rJC8tcDHCFdN9YpGhAcOOuG6+FqH2HT/weNY6s6qb9VNCI
 7lXnNPtC0ZAcg==
Date: Mon, 20 Jul 2026 08:51:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
 goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <20260720-brilliant-pastoral-oryx-cbe49f@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>
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

On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---
>  .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
>  .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
>  2 files changed, 42 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

