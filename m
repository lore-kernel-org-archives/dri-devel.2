Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CD606A322
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGegiZv5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D9310ECBF;
	Tue, 24 Nov 2026 07:00:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B06B10ECBF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:00:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C3AA60051;
 Tue, 24 Nov 2026 07:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED60E1F000C4;
 Tue, 24 Nov 2026 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795503603;
 bh=VoHveLWNPeBOCpzoJQa7hKH+0T1iDM3QuPlPNaPBhoA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NGegiZv5LDFoZMqOGefFW/AkVByod02tKCRhbKz8ds0jAyRYhZIMIOnJjih5ji0Zr
 CDQ7PaEnx1yCJQUHzqXCXDtp7XtrsMtCbHTNTINWVt8kF0RQFTPoEJa31jWW4DzKbv
 WPq+gIjFiArH9AtccPahpezRqGds1VfHLGlXz6aTCiOjcQkdqaNl4r5s0oJPGULIUO
 d6cEimywuPEPduSwvdOY/f3Mj6079QisY/av+bwOG0ASbZ6Oyj2XbvzqgaRgWhAVNc
 G4ahCezPnSJ6uiBz5Xt71fgqjXl/XfPmPvxtGoewNFwTzx1Fo5RY/jYrv9LnrLcTpv
 1zFY4M1qS27xw==
Date: Tue, 24 Nov 2026 08:00:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: nvidia, tegra20-dc: Move 'rgb' node
 properties
Message-ID: <20261124-steel-eagle-of-focus-b8c4b1@quoll>
References: <20261102142802.2742565-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102142802.2742565-1-robh@kernel.org>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 08:28:01AM -0600, Rob Herring (Arm) wrote:
> Properties are supposed to be defined in the main schema and not in
> conditional schemas. Move the properties for the 'rgb' node to the main
> schema.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../display/tegra/nvidia,tegra20-dc.yaml      | 43 ++++++++++---------
>  1 file changed, 22 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> index 69be95afd562..a42bf7ed37a2 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> @@ -77,8 +77,27 @@ properties:
>      description: A list of phandles of outputs that this display controller can drive.
>  
>    rgb:
> +    description: Each display controller node has a child node that represents the
> +      RGB output associated with the controller.
>      type: object

This needs proper fix in general:
1. "port" child (e.g. arch/arm/boot/dts/nvidia/tegra30-asus-lvds-display.dtsi)
2. additionalProperties: false

The change is correct though as it does only one thing, so:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

