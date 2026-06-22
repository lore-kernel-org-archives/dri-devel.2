Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1FBCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0A510E61F;
	Mon, 22 Jun 2026 11:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U+7eGbWw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3360D10E621
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:04:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD07943AA3;
 Mon, 22 Jun 2026 11:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8E31F000E9;
 Mon, 22 Jun 2026 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782126271;
 bh=YSs58y/GFP40wa2ZLv0++iuUUCeFyDMAOw4QyEvLl/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U+7eGbWwC1BuJt9yXHJSoGrPm9GrXLcfa0L2cSuJ5hyI5ocfhj7HDDu665jv+BJH7
 SxWF8HHYc6JlZ1o4UEDCfcyIDKlBHg/GWGKg6O8ncugO0xsbM4m1Fg6FOQDx4sjzXv
 VHBr22BqqsqlLbdmdA9MQEHqEkQR+rhoFtEsH4feXBHwCuRveUma9HmZQtFmBeCDvZ
 keMJlsSMkN31IDeWd+MGAa+rtEgKOIWBGF/vuzbRQJDxRta5QPJcPG/lMDIZ4RNQz9
 UvYg6kGuqfzghtAI5HjxCLCDs5kAvIqwG7git16HOmFNhXDBrB5nb6cj6XUr1cP4pt
 yNTcMcRW/oOVg==
Date: Mon, 22 Jun 2026 13:04:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arpit Saini <arpit.saini@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ayushi.makhija@oss.qualcomm.com,
 rajeevny@qti.qualcomm.com
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: add Ilitek ILI7807S
 panel controller
Message-ID: <20260622-grateful-hypnotic-grasshopper-9de3f4@quoll>
References: <20260618-ili7807s-v2-0-b3f0c109b102@oss.qualcomm.com>
 <20260618-ili7807s-v2-1-b3f0c109b102@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618-ili7807s-v2-1-b3f0c109b102@oss.qualcomm.com>
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

On Thu, Jun 18, 2026 at 03:54:02PM +0530, Arpit Saini wrote:
> ILI7807S is a DSI display controller used to drive MIPI-DSI panels.
> The DLC DLC0697 1080x1920 LCD panel is based on this controller.
> 
> The panel requires a reset GPIO, I/O voltage supply (vddi), positive
> LCD bias supply (avdd) and negative LCD bias supply (avee). The panel
> operates in video burst mode with four data lanes using RGB888 pixel
> format.
> 
> Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
> ---
>  .../bindings/display/panel/ilitek,ili7807s.yaml    | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

