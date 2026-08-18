Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A423FC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D20E10EA1A;
	Tue, 18 Aug 2026 07:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z45/d0fb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E16910E204
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 07:35:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7224940A96;
 Tue, 18 Aug 2026 07:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3491F000E9;
 Tue, 18 Aug 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787038519;
 bh=3FjFA8QdIZbyMJMywsq7y6vxV2t4SvR33hKPXAYgD2A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Z45/d0fb+Cw5JyKjPlUV0lbfBycSDceEw9XFHDi0YhhDTCUWOaSJHZ07g1FAZ6YYe
 26o4GrUUwxEJ33d5P3SNRY9JOXOX7hultaXPAFOjMouRQouCCQ/+MZqtwa3pjNmZ2z
 sdIoTeqQyO4+ls0g7jf2Uo3DGr+Tyte5kr7vh2z8Pl5P6BKnE33msGUasGnd9wms4B
 yH5aipF0tB4rm5/Bf3uujsy+ELBoKoQhMkvJ1pjlB+3780z64Top3vYzFO9iYg2TQk
 iAbNDSN1zuCe1fNECaoDy9pEi/Ia8gcqPURlupN6EQ67LrulOTBK7MRKikypAilGxd
 fFCVDoDOgYUpw==
Date: Tue, 18 Aug 2026 09:35:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <20260818-complex-noisy-dog-ceb320@quoll>
References: <20260816-ocp8178-backlight-v3-0-caf95c453c50@dewith.io>
 <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816-ocp8178-backlight-v3-1-caf95c453c50@dewith.io>
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

On Sun, Aug 16, 2026 at 12:57:03PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
> 
> Signed-off-by: Wim de With <wf@dewith.io>
> ---
>  .../bindings/leds/backlight/ocs,ocp8178.yaml       | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 +++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..1cd95aac0d168
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ocs,ocp8178.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Orient Chip OCP8178 backlight
> +
> +maintainers:
> +  - Wim de With <wf@dewith.io>
> +
> +description:
> +  The Orient Chip OCP8178 is a white LED backlight driver controlled by a single
> +  GPIO line with a vendor-specific onewire protocol.
> +
> +allOf:
> +  - $ref: common.yaml#

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

