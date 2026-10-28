Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459A6606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6myWyvK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DED10FCE0;
	Wed, 28 Oct 2026 13:57:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B030910E5EF
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:57:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EED6A60120;
 Wed, 28 Oct 2026 13:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F051F01825;
 Wed, 28 Oct 2026 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793195869;
 bh=rZbRjuKaxzE+F5sQw8Ok2E/S7/8geKcZ1FuuvT9ff5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=R6myWyvKjqCBG1wlYTCnmG1/PVli2YyC3X+j89Acbi9Nir17P/z04FtCb7L5/jIHU
 gAraffTiTCRvlvBHt/ZGTq9M7wV89ELpyaWjy77MqoTaqQng2ZYyE3IlKLR1NUhhQ5
 vsX1I/frvdbTHCl2zz8kJM+jYLlWQStZeJ7LyAxRTND7jWMz/FllTprVWSELkownZ6
 qmenJ3PlbWyhzj/FRx4cEVq6wBHzk8kDvG/3Cd3LhZ7rzH+Z8bj6MrwSo/WqLxBObd
 FkJcl+wByJUZUU5PyxOBmuQ8Fo4pb/Ubn3WwonFYW7rqIZX3jcmjZ6iXRNoCihr1l9
 1+V5TWK3T12og==
Date: Wed, 28 Oct 2026 14:57:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: display: panel: novatek,nt36672e: Add
 bias enable GPIO
Message-ID: <20261028-cerise-tiger-of-fascination-edcbe9@quoll>
References: <20261028095151.1682096-1-vz@kernel.org>
 <20261028095151.1682096-3-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028095151.1682096-3-vz@kernel.org>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 11:51:45AM +0200, Vladimir Zapolskiy wrote:
> The pair of positive and negative bias supplies of an NT36672E panel,
> AVDD and AVEE, also known as VSP and VSN, are either provided by the host,
> or generated on the panel module itself. In the latter case the module
> exposes only a bias enable signal with no need to describe the supplies.
> 
> Make the AVDD and AVEE supplies optional, but require them to be
> described together as the indivisible pair, and add an optional enable
> GPIO for the bias enable signal of the panel module, which excludes
> the bias supplies, if present in the actual device tree node.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
> ---
>  .../display/panel/novatek,nt36672e.yaml       | 32 +++++++++++++++----
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> index 45743376995b..daf2f96b8ed4 100644
> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
> @@ -11,6 +11,13 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> +  - if:
> +      required:
> +        - enable-gpios
> +    then:
> +      properties:
> +        avdd-supply: false
> +        avee-supply: false

Move entire allOf to the end, before unevaluated/additionalProperties
part.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

