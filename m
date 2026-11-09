Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC7606D812
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MX92hfP+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38FE910F240;
	Mon,  9 Nov 2026 12:34:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8452A10F256
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:34:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A1FA1631FB;
 Mon,  9 Nov 2026 12:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900C71F0089F;
 Mon,  9 Nov 2026 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794227655;
 bh=xmIlBDozjkzvMSaRaAhvn1n0LrMtmUjIl/UdI6mSxd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MX92hfP+u9/kEx1sCzTzk1GwJfIsGDdDn/Z18+KCuTtS4D1f7L59KYixVJsTf8YGe
 Xgdbk3ZnRGJVeiRWL+skXE0p88m/KkLgi2h3j92wTLg+U/jeIPZYQUa1RzXGd+Wbkl
 iGKByy7xnfQAJDUAT+1KVZmiY3LYfsLRZ5n10ncHDNyCkWEDM5J55Z8fTxmgLKyAip
 1fYcFwgStjWNHbSY2B5eb90zM8Z2gYPLsuh0SoPZ+aNvgN6atxVw42FUr6nM7vsZ1B
 V55/yxomUz2BYHHUdMFzbRlaBuoaDhmm69tjY5V0zvAe3/R7CkEPrS7MWuIYgafuch
 w+/JuHdH+FpaQ==
Date: Mon, 9 Nov 2026 13:34:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] dt-bindings: display: panel: s6e3ha8: Adjust to
 reflect the DDIC and panel used
Message-ID: <20261109-tall-lyrical-stingray-1caaac@quoll>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-1-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-crosshatch-panel-v3-1-87dd4ec4f7cc@ixit.cz>
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

On Sun, Nov 08, 2026 at 12:32:22PM +0000, David Heidelberg wrote:
> S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
> the Samsung AMB577PX01. Introduce a compatible reflecting that, adjust
> the example, and deprecate the DDIC-only samsung,s6e3ha8 compatible.

Again: why deprecating?

> 
> We're going to introduce another panel with different sequence, so keep
> calling original panel sequence just by the DDIC name is confusing.
> While we at it, we can cleanly fix reversed GPIO polarity.
> 
> Update the polarity to better match newly introduced compatibles with
> fixed logic.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/panel/samsung,s6e3ha8.yaml         | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> index 00ce5a4e1c6be..ca250b1b91712 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> @@ -1,28 +1,35 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2
>  ---
>  $id: http://devicetree.org/schemas/display/panel/samsung,s6e3ha8.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Samsung s6e3ha8 AMOLED DSI panel
>  
> -description: The s6e3ha8 is a 1440x2960 DPI display panel from Samsung Mobile
> -  Displays (SMD).
> +description: |
> +  The s6e3ha8 is a display driver IC used in 1440x2960 AMOLED panels from
> +  Samsung Mobile Displays (SMD).
> +
> +  Known panels:
> +    - AMB577PX01, 5.77", Samsung Galaxy S9 (samsung,s6e3ha8-amb577px01)
>  
>  maintainers:
>    - Dzmitry Sankouski <dsankouski@gmail.com>
>  
>  allOf:
>    - $ref: panel-common.yaml#
>  
>  properties:
>    compatible:
> -    const: samsung,s6e3ha8
> +    oneOf:
> +      - const: samsung,s6e3ha8-amb577px01

So the panel bindings use compatible of format DDIC-panel? Are you sure
you keep it unified with existing approach?

Best regards,
Krzysztof

