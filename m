Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08FB606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZwWXSeG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC0110F23F;
	Mon,  9 Nov 2026 12:30:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6928910F24A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABDBA63227;
 Mon,  9 Nov 2026 12:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C375C1F0089F;
 Mon,  9 Nov 2026 12:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794227450;
 bh=jGi2pMPtfaYXbF/EmhxEb446J6+o0fEqR3t7Qd1x19c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=oZwWXSeG5G4rZwtosAWNOxR+zwE/P+4TdYtBuU4HsoqYv3Ei4ABx8IzSJrnlCXCVD
 pS4N9qGMBrA4KbNWuz8xavxeHdUjN82DJSb7D1/EDPddNXSIwlYyu6ErXs+2cODAdb
 Erby2ILCouiEja140JEQQse9xfYpHNHFe0he9sUexSdTMy8S4GpU9ueYMl4Aio0EMD
 CCIjCwCF9EqidbMGauMFpdKueskkpN/CL87/kYRgh7byOhY9WV3b6s7lqcMzW7Qipa
 OpohM5kbvXkAexlu6LKYHTW0/k1dE6heQYYcV74rz68P1z1D4IVm4z6TmzPpCT860D
 jsTD//MUdGsCw==
Date: Mon, 9 Nov 2026 13:30:47 +0100
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
Subject: Re: [PATCH v3 02/10] dt-bindings: display: panel: samsung,s6e3ha8:
 Add AMB630QY01 panel
Message-ID: <20261109-tacky-busy-kelpie-cbd5be@quoll>
References: <20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz>
 <20261108-crosshatch-panel-v3-2-87dd4ec4f7cc@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-crosshatch-panel-v3-2-87dd4ec4f7cc@ixit.cz>
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

On Sun, Nov 08, 2026 at 12:32:23PM +0000, David Heidelberg wrote:
> The Google Pixel 3 XL (crosshatch) uses a Samsung AMB630QY01 6.3"
> 1440x2960 flexible AMOLED panel.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/display/panel/samsung,s6e3ha8.yaml    | 41 ++++++++++++++++++----
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> index ca250b1b91712..dcf347fe5ca83 100644
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> @@ -7,48 +7,75 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Samsung s6e3ha8 AMOLED DSI panel
>  
>  description: |
>    The s6e3ha8 is a display driver IC used in 1440x2960 AMOLED panels from
>    Samsung Mobile Displays (SMD).
>  
>    Known panels:
>      - AMB577PX01, 5.77", Samsung Galaxy S9 (samsung,s6e3ha8-amb577px01)
> +    - AMB630QY01, 6.3", Google Pixel 3 XL (samsung,s6e3ha8-amb630qy01)
>  
>  maintainers:
>    - Dzmitry Sankouski <dsankouski@gmail.com>
>  
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd3-supply
> +  - vci-supply

I see no reason why order of this schema should be re-invented. See
every other binding or example-schema.

Best regards,
Krzysztof

