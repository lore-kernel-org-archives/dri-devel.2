Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9F606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UfHoO76O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B419011277C;
	Fri, 30 Oct 2026 12:06:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4638711277C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:06:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6ADBD601EE;
 Fri, 30 Oct 2026 12:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A021F000C1;
 Fri, 30 Oct 2026 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793362005;
 bh=HSANvv2TrngGEWyooavh1NY5PWGGqNMvzMs8zDEDUXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UfHoO76O0HkE7dHvPoage7KakFIZPH4Nzn3uK74/qU1ti/AfCO8flkkd9dDnchbaK
 TZYjb2+EpBhas+GLRTom2JsVRai5X+Rk/PHQXwoFfysQ42iL5f8W0nTehdwRNTX6BU
 MGaNVkJvA8Kn6ggtM9k8n56X84dCPHH81D59iQVi4Hb4DnIV9784s2Yb2NTmKp41YH
 cCSQYY5/Nh7ymje9p/WyXXbrhZkxXAFSYp6YZIVxGJjdsqGLzTKRlc2b119Re51UVI
 BiP7dSpR65Go8gArsTZ8PNHSJNfLj8pAAXNzLPWth2xzf2uZ6dRFzEjKHFjk+Sjci4
 KOoBcPTI6DLug==
Date: Fri, 30 Oct 2026 13:06:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: solomon,ssd132x: Add
 col-offset and dclk properties for the SSD1322
Message-ID: <20261030-dynamic-oarfish-of-dignity-feaef6@quoll>
References: <20261029205751.3513474-1-holofermes@gmail.com>
 <20261029205751.3513474-2-holofermes@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029205751.3513474-2-holofermes@gmail.com>
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 04:57:50PM -0400, Fabio Piparo wrote:
> Add solomon,col-offset, solomon,dclk-div and solomon,dclk-frq for the
> SSD1322, to set where the panel sits in the controller's columns and
> the panel's refresh rate. On the SSD1322 the clock divisor is a power
> of two, from 1 to 1024.
> 
> Assisted-by: LLM
> Signed-off-by: Fabio Piparo <holofermes@gmail.com>
> ---
>  .../bindings/display/solomon,ssd132x.yaml     | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> index dd7939989cf..6c7830af0e5 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
> @@ -16,6 +16,29 @@ properties:
>        - solomon,ssd1325
>        - solomon,ssd1327
>  
> +  solomon,col-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 119
> +    default: 0
> +    description:
> +      Offset of columns that the screen is mapped to, in units of four
> +      pixels.
> +
> +  solomon,dclk-div:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
> +    default: 2
> +    description:
> +      Clock divisor.

Why this cannot be deduced from clock frequency?

> +
> +  solomon,dclk-frq:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Use either existing properties or - if there aren't such - existing unit
suffixes.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

> +    minimum: 0
> +    maximum: 15
> +    default: 9
> +    description:
> +      Clock frequency, higher value means higher frequency.

Why would the frequency be fixed/static?

> +
>  required:
>    - compatible

Best regards,
Krzysztof

