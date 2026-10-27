Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A32606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c47MLzqb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53B5B10E3D0;
	Tue, 27 Oct 2026 11:02:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A2F510F3D4
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:02:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49CB060207;
 Tue, 27 Oct 2026 11:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FD81F01825;
 Tue, 27 Oct 2026 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793098936;
 bh=NeX946K4TovpHq6cvKf+kSZW7DusOcdomhCYwOiNghs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c47MLzqbd+R2j+VqREUhJgalqhlDMO/699bEQCQG/CbWtd4YFxVUn3sXtT9w1ulDz
 FStIWSJmalijxLBskQS99YlYQaayrfpH9cRhX0VN35/18t2HwlrvuzrcGomfoZREBU
 DGP6dlCm6nMYCoS2IJLGnPjhYPg5YlnnBVd4wIsrFUE2PKGgSCPnxQtrs+DHjQB48x
 Ngutq9wPSMjI0bDHc+TR4nEO4WdVpA1xOFoeZLQH9ZSRlt9r2t/lu0WF+p9kdj1iiy
 JNtvnOS/ltAaIWCrokao2QvRYSeZVy83jT6p6U2f7YFJf7Coaw/cUGmNV1Dl6huNfL
 dTHkOGBluGaHg==
Date: Tue, 27 Oct 2026 12:02:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, 
 "H . Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: display: panel: Add the HiBy LG35583
Message-ID: <20261027-silent-tough-tortoise-815dca@quoll>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-5-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025191640.13592-5-olivier@mgcrea.io>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 08:16:39PM +0100, Olivier Louvignes wrote:
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: hiby,lg35583
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Panel power supply
> +
> +  vccio-supply:
> +    description: I/O power supply
> +
> +  reset-gpios: true
> +  backlight: true
> +  port: true

Drop all these three, already provided by panel-common.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

