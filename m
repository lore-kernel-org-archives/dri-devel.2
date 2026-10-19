Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74083CCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A843810E4DF;
	Mon, 19 Oct 2026 07:57:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4AF10E4DF
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:57:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 98B3143BED;
 Mon, 19 Oct 2026 07:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA601F000C4;
 Mon, 19 Oct 2026 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792396639;
 bh=lxCrtttuaTH95qfBBM+pqBIe6QEQV9wb0eaFJI/X8WY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ofg5SDk8rSv+3FegWzG8WSKwQtVDgBD1QY1SF1lrIzVGhzO1Dm2DNIoW2fBKw28pe
 eC7BCPDYpUV7SwX2/xysXKLYRu7/3HphUWwwbr6MHQBOxHBh7aFve/cwYH+sOWA02Q
 IotdR958Tc30SAfylzKkFdHKrMv0Gf1WPqE/pOHFHpE0fyr/CTxiNOXUjeMhWhtV9y
 egNCniwyMEH5dkmdzkqlYSCFc5c8wFZL6eZeSns5qXYLUne02OfoA6DYm2WHiIXpl3
 AMOKE/5DJZOAB0Qa8PZ8u4SqrFuj0m8a9j3+1c/VbkWBC09PnWNxw4pWW6eLvXiVx0
 acatG7F9YGMDg==
Date: Mon, 19 Oct 2026 09:57:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luka Panio <lukapanio@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT8722
Message-ID: <20261019-free-groovy-grebe-7e50d3@quoll>
References: <20261017140827.290666-1-lukapanio@gmail.com>
 <20261017140827.290666-6-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261017140827.290666-6-lukapanio@gmail.com>
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

On Sat, Oct 17, 2026 at 04:07:53PM +0200, Luka Panio wrote:
> The FT8722 is a touch and display driver (TDDI) whose touch controller
> is connected over SPI and runs its firmware from RAM. Document its
> compatible, allow the SPI peripheral properties and add a
> firmware-name property for the firmware to download at power up.
> 
> The "-ts" suffix keeps the compatible distinct from the one of the

Same devices do not have multiple compatibles, so I don't really get the
intention here. What is documented already in the binding? If not touch
then what?

I also do not get why all of the properties are applicable for the
missing 'ts' part.

Best regards,
Krzysztof

