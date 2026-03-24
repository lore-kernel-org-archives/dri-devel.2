Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70AF532FA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F8F10E477;
	Tue, 24 Mar 2026 09:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qykw1c8Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA1710E477
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:08:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 65C8D60120;
 Tue, 24 Mar 2026 09:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C56C19424;
 Tue, 24 Mar 2026 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774343281;
 bh=aloDp/7Ws3xGvuTGLdeYo2Gmfmhdjd5m4AaJNfMivvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qykw1c8QhGvr0CMdMWaZbIIVEdZJSQnfdBvKvw8YB0DB08JYSWRbpM3LC10hB8X43
 +GHutMbDbU04IZInw4qZUDCTMN9rZv806jJd1tnVwmMOVb2p0dA2ua1mGcsIk7avLK
 hgQuDNbvRyrPMOsHPb30TMrAFfjXgD9OeCvhqK5GlMwUpgvywag+yKWqpbkmWmkamI
 p+0lX+5ZUt5gnFVz9X+3Yai8o+LCjQBsLAih32mzZHfcHIMwd0gbBCaamD6p1bLfq7
 iuQG3lXgbVVsbdz9OTHxutg2/IO9xg8Ve2YYlwiulBydjExA7pGNvKAZLfHpYCTPKG
 QBCpbDpj25WRQ==
Date: Tue, 24 Mar 2026 10:07:58 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
Message-ID: <20260324-dexterous-snake-of-progress-ea8783@quoll>
References: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
 <20260323-ch13726a-v3-1-e28b6f97fe80@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323-ch13726a-v3-1-e28b6f97fe80@gmail.com>
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

On Mon, Mar 23, 2026 at 12:08:32PM -0500, Aaron Kling wrote:
> The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../display/panel/chipwealth,ch13726a.yaml         | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..5d964900795653401a871994bcf6403cdeaad64f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chip Wealth Technology CH13726A AMOLED driver
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  Chip Wealth Technology CH13726A is a single-chip solution
> +  for AMOLED connected using a MIPI-DSI video interface.

Here you describe the hardware, including what I asked last time -
explain why this is ayntec thor panel, but not chipwealth,ch13726a.

Then also name the file as the compatible. If you do not know the part
(model?) number, then why do you think filename should be called
ch13726a?

Best regards,
Krzysztof

