Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C16CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB4010F414;
	Fri, 15 May 2026 07:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RoYIE3d1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C3210F414
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:03:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1810860581;
 Fri, 15 May 2026 07:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E6CC2BCB0;
 Fri, 15 May 2026 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778828594;
 bh=UFt1H7tojIcyi2oC15rpkmT6R6HC5/FNUsSIF/Zi1J4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RoYIE3d18NM5bJCnRjqcHMyUcICYz9g4b2qzfHDjKjsLG2NaqBdm/6uE1oD/XZgoF
 14+tsjB/Wia9FkSFusxW0lRQEkXa5m8Cc7NNtU1sDtBEn7QaDGgMbgEYAVB0NEeSwj
 rwQj1NbvIeDv5yiovPNvJd/b2xK1/hq54Zb8rz5GXsX7phXFqwEcAQtYirqBaUn1Ro
 pl64DRyaRU+W+hn0U3tZQn5Z+znD+zKwBkAy5mNILA1PWsrzK8PIDLIGOqvbddTmz4
 LLY0kz6yf3SuHK7B6+rFr0/dFkNdPnr7LbfZ5nQXSTMTcISlVmW6+9uf3LwrWPXYuC
 FOYqihvAmu8Uw==
Date: Fri, 15 May 2026 09:03:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, 
 davem@davemloft.net, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jikos@kernel.org, bentiss@kernel.org, luzmaximilian@gmail.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, Douglas Anderson <dianders@chromium.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: arm: qcom: Add Microsoft Surface Pro
 12in
Message-ID: <20260515-fabulous-married-pogona-ebccd9@quoll>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
 <e54aa6c1e190b0e26d58504c5ea1b05fd09d64d3.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e54aa6c1e190b0e26d58504c5ea1b05fd09d64d3.1778822464.git.harrison.vanderbyl@gmail.com>
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

On Fri, May 15, 2026 at 03:41:46PM +1000, Harrison Vanderbyl wrote:
> Document the compatible string for the Microsoft Surface Pro
> 12-inch, 1st Edition with Snapdragon, based on the Qualcomm X1P42100
> SoC.
> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index b4943123d2e4..aaa9a129908a 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1168,6 +1168,10 @@ properties:
>            - const: microsoft,denali
>            - const: qcom,x1e80100
>  
> +      - items:
> +          - const: microsoft,surface-pro-12in

Why isn't this part of the other enum with all devices?

Best regards,
Krzysztof

