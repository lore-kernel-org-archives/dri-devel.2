Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390D6C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44DD810E0EA;
	Wed, 19 Aug 2026 08:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VERpbohU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E971410E0EA
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:36:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A74D6020E;
 Wed, 19 Aug 2026 08:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C031F00AC4;
 Wed, 19 Aug 2026 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787128581;
 bh=xuxB9q6uTPI8Xy1X+ubySJHSlrNsjy9Efk1Gekb1/k0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VERpbohUyze9kFPzsEJ/SWdBaleppYFCvAP4kGgvkBIhbZ978k4oCSSez2K86taTI
 qp8VtLN2gD3XjIi1M6cZo2VpsIOQFF6NPD5gOUWqAGWQsZLsEnWIY9CIrOrVvxLkI6
 8RF2SbrlKQEXzbd73cAV8ndWUIOM0HlwXsKNwrWTUSKwlB99WwwZNdEBL83dX3mOuB
 d67MXgD9z4b41o+0LPATEbY8oMK6t51kR4UHubu5PBh82aLeBLTR+IqdB45Fi0nLsV
 WpJ7mTBIrM7jyblvWG28v39YHqKA2uBs9zElxDs7F0b1armHIIjuizVPTFkcl/CEEU
 HGayd5BuHt1CQ==
Date: Wed, 19 Aug 2026 10:36:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7836A
 OLED driver
Message-ID: <20260819-rich-artichoke-goat-e23fe0@quoll>
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
 <20260808-ili7836a-v1-1-07a7becc5636@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260808-ili7836a-v1-1-07a7becc5636@gmail.com>
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

On Sat, Aug 08, 2026 at 02:01:14PM -0500, Aaron Kling wrote:
> The Ilitek ILI7836A OLED driver is a single chip solution for MIPI-DSI.
> This is used for the Retroid Pocket Nova panel.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../bindings/display/panel/ilitek,ili7836a.yaml    | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

