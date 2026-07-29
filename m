Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002C9C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B42710EAB6;
	Wed, 29 Jul 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OQsZReJi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7177E10EAB3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:37:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 915B260A61;
 Wed, 29 Jul 2026 06:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE151F000E9;
 Wed, 29 Jul 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785307067;
 bh=gFtOBaYt4v8tf/tSy1jDnMaquKAr/fwb65iurTEaIzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OQsZReJiEfWteyX1tkyFmRzgtB9YoH1UboyulElcsk9u3te6lni5He9Wj5co5d5Ny
 VgsWFvGmkfEH5DPRiOgfEdwrP98R4/yrBbcZ14AD4fgRlpCEJKyy0KnzbM4gYw50YO
 JONbqlYgQPIkf7rZ+DSMpGYxQaBu4wU9r5YzqSE0PWTfsWjt5GsNbN2qvqeSAhPWVj
 foD0XSN2IQ6Z//PYT/THnSg/7yAQp1ijD60EBBq5GPWTjW9Rkj1DtOTYj7O+jgwTj7
 j+BP0BRmvjYSnOZ7xBCu6huuv0aWWI8lCCyVBgxwGrGHRLD6tAOCiVGRrpjs/xxC2j
 2B/S6FZaZyOvw==
Date: Wed, 29 Jul 2026 08:37:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: mohit.dsor@oss.qualcomm.com, Sunyun Yang <syyang@lontium.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mohit Dsor <mdsor@oss.qualcomm.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
Message-ID: <20260729-truthful-cinnamon-giraffe-f250d6@quoll>
References: <20260728-lt9611c-v7-v8-0-bda216bfaf37@oss.qualcomm.com>
 <20260728-lt9611c-v7-v8-1-bda216bfaf37@oss.qualcomm.com>
 <114159dd-0271-4d15-b07d-20fc1e28ee6d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <114159dd-0271-4d15-b07d-20fc1e28ee6d@kernel.org>
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

On Wed, Jul 29, 2026 at 08:18:58AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2026 13:09, mohit.dsor@oss.qualcomm.com wrote:
> > From: Sunyun Yang <syyang@lontium.com>
> > 
> > LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> > mipi dsi and output hdmi, differences in hardware features:
> > - LT9611C: supports 1-port mipi dsi to hdmi 1.4
> > - LT9611EX: supports 2-port mipi dsi to hdmi 1.4
> > - LT9611UXD: supports 2-port mipi dsi to hdmi 1.4/2.0
> > 
> > Signed-off-by: Sunyun Yang <syyang@lontium.com>
> > Signed-off-by: Mohit Dsor <mdsor@oss.qualcomm.com>
> > ---
> 
> NAK. You received review. Sending the same is wasting our time.

Actually you ignored TWO independent reviews, so I will not waste time
on this patchset anymore.

Best regards,
Krzysztof

