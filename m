Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FE3C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 079E910F3D4;
	Thu, 16 Jul 2026 20:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zco0BAv7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF5E10F3D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:44:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C02141759;
 Thu, 16 Jul 2026 20:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19C81F000E9;
 Thu, 16 Jul 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234641;
 bh=ndiUnTv+f5gzNuW74iwaWREcbUrCZddvl6t+J/D2k5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zco0BAv7DEDZe/+tNjWKWcuitAbYkU1Skvu3LNjUkaD8HJVt+7Sh6T712y4OB1jwT
 tj+H9/MQU6ZnkHt4TOSkSv0kh0XlzlkRSb46MvG0/S/BfNGKTm8TOMHF7fe7zU4QyG
 a1YvISgEOIg/OmXHxBlGbEDfzxVyf1YcKOneBKRNrz0M1KevXaGd57YZ77p2dVd7vf
 AcVkm59gJHAPNO7YTiWwsRzqSjbZYv7VMTxp/PpFUGJSIuNA1wlNPzqVcldjLkqCdH
 SNdVQEMR+XAoLgBhJDMC7jQQVtg4e+gyOOhO3q3tPzxo77tm4GInYeGxRTe7hMdFRk
 IqfdNIX3BtTFg==
Date: Thu, 16 Jul 2026 15:44:01 -0500
From: Rob Herring <robh@kernel.org>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: vga-connector: Allow
 hardcoding EDID
Message-ID: <20260716204401.GA1209579-robh@kernel.org>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
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

On Mon, Jul 06, 2026 at 12:35:39AM +0300, Laurent Pinchart wrote:
> Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
> data over an I2C bus. The bus is also used to detect the presence of a
> connected monitor by trying to read the EDID data.
> 
> Some devices where the VGA display is integrated in the device and
> always connected do not connect the DDC pins. Some development boards,
> such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.
> 
> To support those, add the ability to provide hardcoded EDID data in the
> device tree. This is mutually exclusive with specifying a DDC bus, and
> can only be done when the VGA display is guaranteed to be always
> connected.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/display/connector/vga-connector.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

There's already 2 (.txt) bindings with the same property, so no issue 
with adding it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
