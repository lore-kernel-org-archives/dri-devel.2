Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C40ECD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECCA10EE99;
	Mon,  8 Jun 2026 08:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QxafCn2z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DC010EE99
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:02:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 791726001D;
 Mon,  8 Jun 2026 08:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E831F00893;
 Mon,  8 Jun 2026 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780905740;
 bh=FQb6bDWfmdaPHwTtE1rATxeYREPUBuPE+e9MX/QLv7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QxafCn2zVadEMA2cQMxBU+mcAITO4xYSagCccGUk0EAoDIXUdM21Y6TuGrl5HttOo
 LloRY2bu2pPdx3pdHc258nCMAQ6aXX3drcbO3WIKwXMNTOLTWTHdluO84LXO44LWDT
 6zi4dwWEYnSSqwtiaeuCfpGfj728d/DpJ7Z+0MOMrKjxeWd+colgIzSaXndDp/VhQu
 iY6S+i3h7vqjAHVx7cLUgxQc87H8nHIbvlccxkQCPzmciRl/BpI7ymz9PcltbSwQes
 ufaTyThR+rtUiGaQywq/sbHd/O7fHrL4lKSeXaKY2PnQ3MJLIylWmhvyUTVmzIa972
 LhNznRmEGJszQ==
Date: Mon, 8 Jun 2026 10:02:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: display: verisilicon,dc: generalize
 for single-output variants
Message-ID: <20260608-baboon-of-theoretical-stamina-6db63f@quoll>
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-2-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608023237.305036-2-a0987203069@gmail.com>
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

On Mon, Jun 08, 2026 at 10:32:33AM +0800, Joey Lu wrote:
> The existing schema hard-codes the five-clock/three-reset/dual-port
> topology of the DC8200 IP block, preventing reuse for single-output
> variants such as the Verisilicon DCUltraLite used in the Nuvoton MA35D1
> SoC.
> 
> Rework the schema so that variant-specific constraints are expressed via
> allOf/if blocks:
> 
> - Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
>   generic verisilicon,dc fallback remains the driver-binding string.
> - Relax the top-level clocks/resets definitions to minItems ranges so
>   the base schema accepts both variants.
> - Keep ports in the global required list and keep additionalProperties
>   tightened to unevaluatedProperties.
> - Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
>   ahb, pix0, pix1), three-reset (core, axi, ahb).
> - Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
>   one-reset (core).
> - Fix a stray space in the port@0 description.
> - Add a DT example for the Nuvoton MA35D1 DCU Lite using ports/port@0.

Difference in clocks and resets does not need a new new example.

Best regards,
Krzysztof

