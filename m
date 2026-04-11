Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C1F3ED51
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 14:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5560410E228;
	Sat, 11 Apr 2026 14:07:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qHr3q0pD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A37310E228
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:07:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6AF9060145;
 Sat, 11 Apr 2026 14:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD8C4CEF7;
 Sat, 11 Apr 2026 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775916476;
 bh=0bYMjjn0En5DfzpuYHB1tqDP4Q+5+XNcpFkkSwY7mac=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qHr3q0pDgM/vByJ013WSTSXsR5+zPzNWkmTisI6+2NuBTexXCXbQZCpzDC1Fp7eM5
 zQ/z/Mqxv3ivuVAIVcNlqv0rcSMqaCMfQcBtHN4V8FpJuiodxXD7w/JVg4ZeHkCleM
 QyVZoD6KjWGUb1/0exv0Q4/+fkwTz063t/9mnRPH5kQG3ypgI0Qwj1IuYqYdklxLOU
 FzAnosySlXnA7avv8qv0Piw5+FyumIDLps5Z5AseRD7j0jnkw9C50pBkNkKhljyHAJ
 hmC77Os4cntqjudXJO7zdNytsmTKTG9NQhJpkKaIhQZ/ptiF96KY+iV1lbv0NhfHTo
 mR2sV7zVc7KAA==
Date: Sat, 11 Apr 2026 16:07:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Swamil Jain <s-jain1@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devarsht@ti.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, praneeth@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v3] dt-bindings: display: ti, am65x-dss: Fix AM62L DSS
 reg and clock constraints
Message-ID: <20260411-resilient-tireless-centipede-cd6fef@quoll>
References: <20260410105955.843868-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410105955.843868-1-s-jain1@ti.com>
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

On Fri, Apr 10, 2026 at 04:29:55PM +0530, Swamil Jain wrote:
>    clocks:
> +    minItems: 2
>      items:
>        - description: fck DSS functional clock
>        - description: vp1 Video Port 1 pixel clock
>        - description: vp2 Video Port 2 pixel clock
>  
>    clock-names:
> +    minItems: 2
>      items:
>        - const: fck
>        - const: vp1
> @@ -179,6 +195,20 @@ allOf:
>          ports:
>            properties:
>              port@1: false
> +        clock-names:
> +          maxItems: 2
> +        clocks:
> +          maxItems: 2
> +        reg:
> +          maxItems: 5

Also constrain for reg-names,

> +    else:
> +      properties:
> +        clock-names:
> +          minItems: 3
> +        clocks:
> +          minItems: 3
> +        reg:
> +          minItems: 8

Same here, please.

And if you are sending new version: they should be listed in the same
order as in top-level properties, so reg, reg-names, clocks and
clock-names. (juging by the diff)

Best regards,
Krzysztof

