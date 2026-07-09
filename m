Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F09C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD5A10E68C;
	Thu,  9 Jul 2026 08:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cx50iv8X";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31F710F450
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:29:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB54A60EEF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E511F00ACA
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783585759;
 bh=YAtIHqm2ZMjAhBbacLCHQR++DR43xD3ram9aYjsmlhY=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=Cx50iv8X0cQmJSVUnfFpWfSZ5KfOX7K+K63BaXt8a6PedSRTewifFWyiyS8wo6IsV
 4zCChQ+17C8Auvsr2sBx2f6bonbX3nxBEIPndgt7ZNHeYwYDaqahn6jRHrDdGn0Yxj
 TzsiOD7HZ+uO21u0paGCSs4fXOtYdm+awwY8emRhgFMXvkGhu7I+BPpwCfdvMrGb/t
 UBBWIRbPepf+qieGlaR5sV4z+F3ojGNBCeBm9PDvqJ6v34r4bDdrr1Mpw3VxtZXhbd
 GdatVEZ3XO+1X8T5EyL2fi8t0UwLy5J8RSOUFEJHyPH3DWmDGxQH9rRSx6vW+gvmii
 HDy4kGUVgVaeA==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39669bcaadfso14474831fa.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 01:29:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrBO05XpP2qQYSn7EVkPfoTNtab0ee4ZqbVgM89nbUOhwlUzqEdS9mDdv66gmdodaXhaJSjQIHqzyU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywx04pr4Z9EpNaC/Hzpp68L9+Yu3xXfgyWtHAez0GLvD+QtzFho
 Usm1uUDdihNNs5dduHVvATfVdF7zeuNVnevoU7al/d/DeL9yJgjoCoxzZnZh904nMO8CHRiIv9C
 moZCSCj0hbWinW+/Mc0T1xk24I5leksy14UHSXFBxsA==
X-Received: by 2002:a05:651c:199e:b0:399:90ae:a406 with SMTP id
 38308e7fff4ca-39c799c9fa9mr12982771fa.27.1783585758335; Thu, 09 Jul 2026
 01:29:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 01:29:16 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Jul 2026 01:29:16 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com>
MIME-Version: 1.0
References: <20260709082040.4070711-1-shengchao.guo@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 01:29:16 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdt+39pbnE3XOwRm6yWJAENU1UeQhw9xaFu2vDqgcXU1Q@mail.gmail.com>
X-Gm-Features: AVVi8CevtjxRrM5Jiux4yHD5WK_K0ewuBLgZ4WNdELr7GiHQbbHlJ0bNIUyMMn4
Message-ID: <CAMRc=Mdt+39pbnE3XOwRm6yWJAENU1UeQhw9xaFu2vDqgcXU1Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: Document Nord FastRPC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 9 Jul 2026 10:20:40 +0200, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> Add compatible for Qualcomm Nord FastRPC which is compatible with
> Kaanapali FastRPC.
>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index 2876fdd7c6e6..24fc0752c11a 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -26,6 +26,7 @@ properties:
>            - enum:
>                - qcom,glymur-fastrpc
>                - qcom,hawi-fastrpc
> +              - qcom,nord-fastrpc
>            - const: qcom,kaanapali-fastrpc
>
>    label:
> --
> 2.43.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
