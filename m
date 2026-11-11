Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F66606A895
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY88ne8f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9D310E2D6;
	Wed, 11 Nov 2026 13:04:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE75C10EBED
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:03:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E6C3438B4;
 Wed, 11 Nov 2026 13:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B07C1F00A05;
 Wed, 11 Nov 2026 13:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794402238;
 bh=AWaIRPGVBwDKyVXL8rFvxOr7TIsCYjaMi2R2yUDvOKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bY88ne8fKH+AMIpDjGgLPKo2tQ3gBNt/paxmaTdDQeVQ9jEMzkXYg0fc6aof9e3cj
 +EL8B7FEAS7BYmklA4wBXRvGufXIl+4383D4TJznpHT8v/vh7XnIIHfw52NMLud/Hf
 BY9iJWiDXU1ZIXK8iFaRtcG30l7q0cJpAUA/sFeisFkFs5XsIcB41DFYXWNjHedPui
 DCH57s3lM2cHITACQwufd/q6xziE6/X5QBouCIQkjCkxWYMssR7RMiKKK11PgXzwVW
 11bIbTeGD+XulA/fHEmYWO17PgqnlOTLjZyJgmUDH0YjVD2kWQrrVru4kDW+uIYHhY
 xqbonlRzll3bw==
Date: Wed, 11 Nov 2026 14:03:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michiel van Beers <michielvanbeers@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: backlight: lm3630a: Add led-max-microamp
Message-ID: <20261111-cute-impetuous-otter-0d70c2@quoll>
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
 <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261107-lm3630a-led-max-microamp-v1-1-ec9e441d9b2c@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 01:13:54PM +0100, Michiel van Beers wrote:
> The LM3630A has a full-scale current setting per control bank, from
> 5 mA to 28.25 mA in steps of 750 uA. Boards whose LED strings are rated
> for less than the chip default of 28.25 mA have no way to describe that
> limit.
> 
> Add the common led-max-microamp property to the led@0 and led@1 nodes.
> The property is optional, so existing devicetrees remain valid.
> 
> Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
> ---
>  .../devicetree/bindings/leds/backlight/lm3630a-backlight.yaml    | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index 6393cbf3afdf..a031679d5468 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -77,6 +77,14 @@ patternProperties:
>          minimum: 0
>          maximum: 255
>  

I do not see in this node reference to LEDs common.yaml. You need it for
any common properties.

Best regards,
Krzysztof

