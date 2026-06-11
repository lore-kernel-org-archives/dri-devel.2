Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E872FCD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A7C10EE1D;
	Thu, 11 Jun 2026 10:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MY6febmp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6112010EE2B
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:39:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13DD043825;
 Thu, 11 Jun 2026 10:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589B21F00893;
 Thu, 11 Jun 2026 10:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781174369;
 bh=hIfuSrctBzrlRdhYCXK7h/WnxikqtQHpoiE+oxwzsr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MY6febmpsry/al3XEKzqKYMuzgxuePM+9nJyS4i9WZ45kZSlL8HrLJM3R4WoBNmQH
 D1T5Wz2sepTzcqeAq0os00hsnuUMpVbIDGOHUMNLlIVsySaiC+DIwob50VAZ8aroOY
 hQr2qRdQRJuH5XBTR7lVe7cS3tF61DfxzC5XohTNBFmDaF0HdDS8Ge6xlQTZm58st1
 X7VCo+uDXqtmVw+OpaRiA3jlmMhuynr5jadc7WldV8IChUIwEHVFjTSHFhmjX9SGtY
 FMJdHGRMLEmM0JeLNEtAIMKdCMtFQZyipnZIIN8zP8nbPxLGFGfvM/cu3auimEVzEF
 koYBtLsp+P6YA==
Date: Thu, 11 Jun 2026 12:39:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Message-ID: <20260611-psychedelic-funky-foxhound-a8e39d@quoll>
References: <20260610164428.180091-1-amit.barzilai22@gmail.com>
 <20260610164428.180091-2-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610164428.180091-2-amit.barzilai22@gmail.com>
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

> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1351
> +
> +  solomon,width:
> +    default: 128
> +
> +  solomon,height:
> +    default: 128

Drop both - deducible from the compatible.

> +
> +  rotation: true

Either drop or reference panel-common (if this is a panel) or at least
reference that property:
$ref: /schemas/display/panel/panel-common.yaml#/properties/rotation

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        oled@0 {
> +            compatible = "solomon,ssd1351";
> +            reg = <0x0>;
> +            reset-gpios = <&gpio2 7>;
> +            dc-gpios = <&gpio2 8>;

Use proper defines for GPIO flags

Best regards,
Krzysztof

