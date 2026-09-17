Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28597C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5104C10E469;
	Thu, 17 Sep 2026 08:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lTSdDuI9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F118610E469
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:09:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9E2843F84;
 Thu, 17 Sep 2026 08:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F383A1F000FF;
 Thu, 17 Sep 2026 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789632571;
 bh=sbes0882iMbhpDutz94uKHFUZV6ExaVjEgbOPnw20JM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lTSdDuI9KbA/YNynTcioXRA66l6F0PDbH0/e9a+5mYdfdy85aJM0vAdPrZwQI1B+N
 No+jizLoau/ThooMkRqmLDZm/Jk4/5GY4z6sDi6PcuI1jOTk0jocBvaUE/A9+8V5j8
 RzLKzTnjN3z9g4rZ+VrcaEpbehMCgIb2c0o709WGjCRfzjy/TtIz+FAGCLG17WhKvf
 OMg0oUfnK+qFnK/3sHCRgIdoTI6Xkxw0jNrv42dp7y6Kwuofym0kkKRm3IivPd6UxI
 HWwIiFBxEp1fu2Z8Dlm7hvL0UTkGQtYpmnob0jJC6JmozrNWWGuLWPl3i5+0MDMPxQ
 +Y6PYW3fD2vTw==
Date: Thu, 17 Sep 2026 10:09:28 +0200
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
Subject: Re: [PATCH v2 02/20] dt-bindings: arm: ux500: Drop NR_DOMAINS
Message-ID: <20260917-arrogant-onyx-weasel-e59f06@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-2-9d0c17e1f816@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-2-9d0c17e1f816@kernel.org>
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

On Mon, Sep 14, 2026 at 01:54:30PM +0200, Linus Walleij wrote:
> Keep the internal Ux500 PM domain count local to the only driver
> that uses it.
> 
> Do not expose this implementation detail through the DT binding header.
> 
> Assisted-by: LLM
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

I would say Suggested-by, because it is not a bug, just preference.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

