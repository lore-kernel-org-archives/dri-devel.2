Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2A606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d03RdPm1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E25910E3D8;
	Tue, 27 Oct 2026 08:23:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FA110E23D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:22:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F22BE4139A;
 Tue, 27 Oct 2026 08:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C91F01825;
 Tue, 27 Oct 2026 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793089378;
 bh=HN3oMF8cJPwybmrjw5tSyGJtcKHnWqq7m1Qy21DYQdw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=d03RdPm1npwDQLuRyWCdS++TzwQ1lL/HCNxMslqwUs+5E9OEGYftuw3F8k1Pq1I7G
 2IebY/MPn7Hz7YQPHi6YN8efmjPWzHXFSpsveHY+lmWUirVue0g68KK91oVpLRXpEI
 amzm7e3GnM37Fw+OJnQQyw0D1KPjm84wjHlAsUly3xw86+Gg6gWBgjP2WIE/Hkuv6d
 em259XGhuLErjEyWiGKrjHhJXikKh26mENioLxLtZZKMdmJzUOzw0Flu7syjBQ0OQ2
 3J/OqTZ0wBFI+e/pSaPg7nwSRkFBGxfV9ZJ5kvug/nDO2/NJtWvihDt3xENC4L+/i2
 E5cAqKPyP75Sw==
Date: Tue, 27 Oct 2026 09:22:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacob Pyke <jacob@pyk.ee>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, teguh@sobir.in, 
 Andrew.liu@moorechip.net
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Retroid Pocket
 IL97680A panels
Message-ID: <20261027-inventive-hidden-ostrich-66dfac@quoll>
References: <20261025133741.100490-1-jacob@pyk.ee>
 <20261025133741.100490-2-jacob@pyk.ee>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025133741.100490-2-jacob@pyk.ee>
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 11:37:40PM +1000, Jacob Pyke wrote:
> From: Teguh Sobirin <teguh@sobir.in>
> 
> Document the Ilitek IL97680A panels in the Retroid Pocket Nova and the
> bottom display of the Retroid Pocket Duo. Both are 1280x960 MIPI DSI
> command-mode panels, with different supply configurations.
> 
> Link: https://github.com/RetroidPocket/linux/commit/9bfe85be2179d03338d09b8900f3b1916999ef15

Please do not reference random 3rd party repositories for no reason.

> Signed-off-by: Teguh Sobirin <teguh@sobir.in>
> Assisted-by: LLM

Drop tag

> Signed-off-by: Jacob Pyke <jacob@pyk.ee>
> ---
>  .../display/panel/ilitek,il97680a.yaml        | 121 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..70a1bdccef75ea3ee6335304ede771ff711991de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,il97680a.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ilitek,il97680a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek IL97680A based DSI panels
> +
> +maintainers:
> +  - Teguh Sobirin <teguh@sobir.in>
> +  - Jacob Pyke <jacob@pyk.ee>
> +
> +description:
> +  The Ilitek IL97680A is a DSI display driver IC driving the 1280x960
> +  command mode panels of the RetroidPocket handhelds.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: retroidpocket,rpnova-panel
> +    then:
> +      required:
> +        - vdd18-supply
> +        - vdd28-supply
> +    else:
> +      properties:
> +        vdd18-supply: false
> +        vdd28-supply: false

Keep the entire allOf just before additionalProperties: block.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - retroidpocket,rpduo-panel-bottom
> +      - retroidpocket,rpnova-panel

I would expect IL97680A fallback compatible.

> +
> +  reg:
> +    maxItems: 1

Best regards,
Krzysztof

