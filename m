Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C2D606A325
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THAIw131
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B5C10E16D;
	Sat, 21 Nov 2026 10:27:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DBB10E850
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 10:27:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68E9C6025F;
 Sat, 21 Nov 2026 10:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B41F000C0;
 Sat, 21 Nov 2026 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795256840;
 bh=w4biS262h0zqd2DW2+xTp/yTJKOFKJuy+vEVoZ/SGAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=THAIw131aUJxZ4jdL0vLlrgjtLomDPAxSjHbBH7hf95SDCoa3IR6es9PsVLf7fiv6
 +BRAFQGtHZRmSO0RSlpm+Oa3Za+oJNDi+VCVfW7726/95z5JGTjLsRw0N/TEEM2SdR
 NoP3eA5IPT3RWNfSV/hI49tnbarOb58MEuxBn5+kPgtn+UumTaOGLjzYWb5/38yXnQ
 DEN6LlMoHeRxJ4y0a1HD3lGIP2tPttWnndWCFZcq1X0L9a2R4Cxr55pv6wedY5spo1
 /0BY0cSJUjwezxvrH622lqBLg6LxNbH6Jn2dhWpbAGqKkUMrZoG7amPsrrAxiJn6Py
 1afIwyargcnvw==
Date: Sat, 21 Nov 2026 11:27:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdur Rofik <rofikcoga@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: input: touchscreen: add Silicon
 Works SW42902
Message-ID: <20261121-wild-corgi-from-neptune-6b19d5@quoll>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
 <20261120155450.7719-6-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120155450.7719-6-rofikcoga@gmail.com>
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

On Fri, Nov 20, 2026 at 04:54:44PM +0100, Abdur Rofik wrote:
> Document the Silicon Works SW42902 I2C touchscreen controller, including
> its interrupt, reset GPIO, power supplies, and panel touch properties.
> 
> Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
> ---
>  .../input/touchscreen/lg,sw42902.yaml         | 72 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> new file mode 100644
> index 0000000000000..2d6d9b1500faf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silicon Works SW42902 Touchscreen Controller
> +
> +maintainers:
> +  - Abdur Rofik <rofikcoga@gmail.com>
> +
> +description: |
> +  The SW42902 is an I2C capacitive touchscreen controller used on the
> +  LG V60 (timelm).
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: lg,sw42902

Silicon Works or LG? Confusing.

Best regards,
Krzysztof

