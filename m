Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4B1C982D3
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1456D10EB4B;
	Thu, 17 Sep 2026 08:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lDrCaYvk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D483210EB4B
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:12:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A014643CEB;
 Thu, 17 Sep 2026 08:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1651F000FF;
 Thu, 17 Sep 2026 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789632728;
 bh=NSTRHR/rrHtZcDQWeuQqQHPMcDnerGUSIEKdxd7ZRjI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lDrCaYvk+RDoeQwFfRiuikgEhkgxPBbY+9EtZvD2oQ1JxgoXZDeev9hK8+c8fzpbF
 hSSTPag8TnonwJuAgoZAEkn4mhoYRjZw4BfHE8iIWh4BslX+uTHhxGvbMWcJlIzhIY
 2VX0RAapm6yQBibVy3MjYiohmC1hUOc4ZUl+u8h0ps47g0zIevr0FeQY8YkV9H6foF
 D/O7SHpkiaabAlfCwBxvffuXdGUKEQZ9YYgk9WgmxMi+OnmId3Bhl10TIBYeJzXMeq
 2qJ7wDcSugQFkQvY8iqsRmZ7UOImmv3g4q55pOg1iFhQEMcZhqE3HQ/JLCeXZr/TTC
 I/VuuVmvyadpg==
Date: Thu, 17 Sep 2026 10:12:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 04/20] dt-bindings: mfd: db8500-prcmu: Relax EPOD
 regulators
Message-ID: <20260917-archetypal-hospitable-auk-39afc6@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-4-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-4-9d0c17e1f816@kernel.org>
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

On Mon, Sep 14, 2026 at 01:54:32PM +0200, Linus Walleij wrote:
> Allow the VAPE and VSMPS2 compatibility regulators to carry power-domains.
> 
> Stop requiring the EPOD regulator child nodes that are being replaced
> by generic power domains.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml      | 24 ++++++----------------
>  1 file changed, 6 insertions(+), 18 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

