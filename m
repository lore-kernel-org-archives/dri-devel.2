Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA9CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6301010E04A;
	Tue, 13 Oct 2026 09:36:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFBD10E04A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:36:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A45C04087C;
 Tue, 13 Oct 2026 09:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D991F00898;
 Tue, 13 Oct 2026 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791884212;
 bh=I13S9NHzPBYqCmO9iZd06Lej7+82C/tFnkGCX+GzMsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ihHQIh0uvs/YMXqAqc47VvtzXg9IoEtUc0pLV0lEJUJCZZFj44IxUyqA2mDEH0+em
 3ii/2NVVohA3q4McFk+Mu+K5rMhO9NEtNsR0BX8rZ+1RvCaYqXSAPklo68HNgQp/2d
 e3xXJ/RCnjzOX0bqJ6bRPgUTRS4OztMfXGn1uvsFUmWNJFyt6O2S6PNVfEwJ5x/WxH
 SMeKHeZP3vyLCpjvvREvQxpqSELMM5GK5aJ/2KgzohMDpXjZmAHfvL0p+Opkpg5mQR
 SPV1UR3LPykn0YVtsSOg3vESrt8A9COHQvJknkIMcQhAWYD7KaI/bE7+KYEhZrVx1M
 pB+7n8P+SUoZQ==
Date: Tue, 13 Oct 2026 11:36:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Luca Weiss <luca@lucaweiss.eu>
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add Samsung Galaxy Book2 Go
Message-ID: <20261013-naughty-orange-cheetah-db85ba@quoll>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-2-7188e7ea7a15@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-book2go-v1-2-7188e7ea7a15@fairphone.com>
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

On Mon, Oct 12, 2026 at 08:11:04PM +0200, Luca Weiss wrote:
> From: Luca Weiss <luca@lucaweiss.eu>
> 
> The Samsung Galaxy Book2 Go is a laptop with a Snapdragon 7c+ Gen 3 SoC
> (SC7280).
> 
> It appears to exist in three variants:
> 
>   NP340XNAA-EXP:
>     4GB RAM + 128GB UFS, WiFi-only (NP340XNA-KA1UK)
> 
>   NP345XNAA-EXP:
>     4GB RAM + 128GB UFS, 5G (NP345XNA-KA1UK)
>     8GB RAM + 256GB UFS, 5G (NP345XNA-KA2UK)
> 
> The internal code name is Hermes2-14.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index ff8a35df7862..5048e878b7ca 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -887,6 +887,11 @@ properties:
>            - const: google,zombie-sku514
>            - const: qcom,sc7280

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

