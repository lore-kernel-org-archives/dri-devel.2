Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA9D107527E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8D010E937;
	Thu, 19 Mar 2026 09:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TWiIl/PO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C602B10E937
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:09:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B10B443AB;
 Thu, 19 Mar 2026 09:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE707C2BC87;
 Thu, 19 Mar 2026 09:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773911355;
 bh=5fTdycH5VKTSl4J376j0I5Ed+rPRK+nrNrd6HDt7DFM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TWiIl/POzZoUbobwe0Pie6mk6kRAFA2FwhPIbxOoTtufktkFrweuwu6XM5HD/t7R5
 0g4l7hos+hr95QAIpmt+WNGt47xvosBvKKKT77lv/6bqzoAvAcCwJknuCHA3au6sZh
 yqUa1HkSrW31JDGcSCAeQw5wbXcUu/YRJ+F1jrvmJCKdf3gUg0mNlqiRuFKn4PYnk+
 g1EghhA2XK5TyCepOrFFFk5TVyC/sHxDZDrR6rFZiZoZgzB+Ttlv8bfqRqfACnUuo0
 zrDvFDbOOvmXOXsk01SwP/ZbKY7VzeveQyq8zmQRASNC9tDeOcfKNfMJwUbDqV5kmb
 H292zpKqgAd/Q==
Date: Thu, 19 Mar 2026 10:09:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cristian Cozzolino <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <20260319-amorphous-pastoral-turtle-851af9@quoll>
References: <20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com>
 <20260318-rimob-new-features-v2-1-c1bf8917449e@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260318-rimob-new-features-v2-1-c1bf8917449e@protonmail.com>
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

On Wed, Mar 18, 2026 at 11:28:09PM +0100, Cristian Cozzolino wrote:
> +  avdd-supply:
> +    description: positive boost supply regulator
> +
> +  avee-supply:
> +    description: negative boost supply regulator
> +
> +  vci-supply:
> +    description: regulator that supplies the analog voltage
> +
> +  vddam-supply:
> +    description: power supply for MIPI interface
> +
> +  vddi-supply:
> +    description: regulator that supplies the I/O voltage
> +
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - avdd-supply
> +  - avee-supply
> +  - vci-supply

Only VDDI is required according to datasheet (see page 11 and page 16).
Others are needed only in specific configurations, which I would ignore
for the simplicity of the binding. Drop these three.

Previous discussion point was about this - write bindings based on
datasheet, since it is available.


> +  - vddi-supply
> +  - port
> +
> +additionalProperties: false

Best regards,
Krzysztof

