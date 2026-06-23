Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46823CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 953C010EC9C;
	Tue, 23 Jun 2026 20:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OgC4EauX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D0E10EC98;
 Tue, 23 Jun 2026 20:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D49260008;
 Tue, 23 Jun 2026 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68E341F000E9;
 Tue, 23 Jun 2026 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246370;
 bh=34FF/afQY7rryAyieahHIYlb29AbDzpMLTYiaGi6CT4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OgC4EauXpZBNWLUChjheUpa4V/Iiwcb7qYB6c9bFVNd68X/S6kySvetpAj9rl5BmR
 S+lJIbLLAM8ffuvYh83VirCj/2inuWQ97ElFLQj2BH7Y7dW3WrSQXJI3W+aFRXsW5t
 lIPEOCiBb0+eruG1A0M+q8i2bKsEjgSopF0ZH5dWpIAv6tZ5gbDMfcV1tsj/9NT32O
 kHjUFcSWrUAIqvGNvpYU7Y1GXsgzBseFDBml4R5BXhJj2kn6GUQX/ZJ2TPRWWnuzGl
 DL05H+zXFRx3Tzvb6AjrSvefPdCwf7XvtNNxHp46XgsrwBxpDgUBO280Vm7W+gSHj6
 y5NfZlXkB1hLw==
Date: Tue, 23 Jun 2026 22:26:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-i2c@vger.kernel.org,
 linux-pm@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Drop incorrect usage of
 double '::'
Message-ID: <ajrrrB3EzSuy-JDU@zenone.zhora.eu>
References: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
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

Hi Krzysztof,

On Tue, Jun 23, 2026 at 07:48:43AM +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
