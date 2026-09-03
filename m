Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8C9C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C970810F578;
	Thu,  3 Sep 2026 12:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mgpe7be7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F1910F578
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:29:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DFA060252;
 Thu,  3 Sep 2026 12:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB51F00A3A;
 Thu,  3 Sep 2026 12:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788438577;
 bh=wCXHOPjY6k6UIQDduJFqwM5ycSoiURySLqPJjkIRPw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mgpe7be7S3WPXQ2VNZ2ZLKyQxx9cz3JZIKYqeWpB3IaUfjc+MJJUZ7prmJnWUctRD
 wk4RzXQbRdgIGX7NmilunN8FlQKtB84d/iWs5yYWd9wzatktwIDksrupN5byYEwpfT
 EBUkzX2htz59wop0OsmDI761PnMrTx5LNdJbOLvVIW9HsWnuN7XxM+SIArcuvxUgUd
 2O+0huu/ag3RREggcw0yOJkj/eAr2WngpMYG+YXdob/Lm9RrVLcPfdwDDRJvXvv4FP
 kVVQttiYv3qGGfEy61ze0IgF+YRzo2oqvSZ6/PzGVuyAEbfa9WE9rDddqcuVGTnIyI
 sfv3TVWW+WQoA==
Date: Thu, 3 Sep 2026 14:29:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Stephen Chen <stephen@radxa.com>,
 Junhao Xie <bigfoot@radxa.com>
Subject: Re: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Message-ID: <20260903-petite-charming-echidna-ccfefb@quoll>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
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

On Tue, Sep 01, 2026 at 04:47:55PM +0800, Xilin Wu wrote:
> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
> 
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
> 
> Document the chrontel,ch7218a compatible.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

