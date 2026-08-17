Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEE3C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E699D10E8D2;
	Mon, 17 Aug 2026 19:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XI/JdEaG";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D42589109
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 19:11:25 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so3158815e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786993883; cv=none;
 d=google.com; s=arc-20260327;
 b=pPFn08pRi7O3z9T6VRT+D37Ftc6KjwwHCXliQG0SIwe3FtK034Lu1KJjsQcaa8L2dF
 uRQQn0A1lrQJgzxAZwKSFDnjdgl0VYRaTbjqycr/IHmmrdsMxWKkDOvJRiBi1l/fHahD
 g2FqrOAsW/rDveZECRWYEeqsL8k5s56cQ4kOB2UPDOALKZjX5JUl75zLic8ahrwTmkL6
 WZfI6V9NucPr1jdggFU+VfbJt/EMBgnUUD/lrXXFlnliDLm30ErtI2i3jjVg5G/LP9xD
 L5eF17sJdKHgJhwFr/vive86+/V+n9ILFJ2ckcGfpSl74tRwKi9ZrUKAR5WCCzUojN8s
 6xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
 fh=UXPND32Lujmp8lseZ7cbXav+Sc1GacyzNYXUnzX5DKQ=;
 b=Z42GGpP3QoK58T63UkVqUnVcA7Yc70YZilEG0XLDiCXdSSw6gg3Xe6ZPGPQw7tK/Nj
 +KNMX3CzuHOVtduu86ccDt6zTS9WJYKnCnbNrANgiebos8DxTzmhcaADmbIeOilZmtxm
 VGhs+mErk+d1utPJ7XudgAxc3NiLqbR2xjiFIHOljq77SVkZtSCFu5N+2YvyCBwRogGk
 DZotFbnzYhYitVXoPj+C40pKmfN89DLmt9h62GNMzzeTPTf/gvnGHgdpZPQ5O6luWzWg
 30cDqstaxcnBslGGRVohywsUb9Ts5FTI3Gm/duqIByd9L8ym+qHbIt/tGllkoe0JMuTg
 +FWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786993883; x=1787598683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
 b=XI/JdEaGZgc3TdRhVftoTPzri7ynpadc4QRgYuj5SRHjf9kKvG3eb94tqC3sW9KqSM
 /lxwusCaM9s7OoLG9N/Rk78MtFYxtd92vQweZhJszT2x65FNPlq9NmXrDUEuMFbE/Wgy
 +Ed3ZGYu4mHDSnFG0bYOHbfcgyVToLT0HyXRXExUlriku2PKmW1Iv+S0XdFy0/shlW90
 I+Yw6iWsD2nHYYWpukizIM0YCcK9GS8HBec7HOp0EJu8IYw7wpKnjPRRrAWz7/4FKUD9
 bRyDlaksWBSnneU4OXPyWLAmwqWa5HI2TGC6ORGiKaWFkEswFCvtJx5IH+ECGn1UMx1C
 cp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993883; x=1787598683;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o9Xq57ZK871Bs82fmpBhlH3gJ0wVVRq6jr0byiqzgis=;
 b=GKBq81dOxB0vJ4bdpkxFO7iTFq47T6iZlvjE7SQbmrwcifNjHwlKqmxJ2g7NUhLac6
 AuCiFf2g/F1j4XbVmVHJrKgtRCovGQlydzQ6Uc3ibb0cL3Q/mCU2J83KAdrHE+NdMd9E
 Ab0Z4i9eNHH/Cb+e6tUqUtVFoYu9r/XwLf/igTEJcR2SqxscdkODiK/tUGnjoXuP3TNW
 6+2ZjOo90s7fGr6OkPErOuoyImnvqEtH+3f9nHd2Seie6oCu6Eq+B/Pjhdv2Q9KW+RWH
 ko8OWAe7I3FUJFpywtjy8NixBXgFrXuC5HO1jW66k78XTuyXwgDiStKf2HSA5U2ujxNq
 LnkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5tb6l2b+xS4rKxbzVsxeFamwsXDQZYsK7cALbQEWSO429lcpt9GFb0q7vthh7umA4aGSAr3AYf8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywc9z/kCNwXfJeyedxUV22tgdnzLOvHEv2vKVzbmcclnbORSApD
 6aWaY0j+5WLVHtc06fAkz+E8uSMDPVVNviSY6vwf40eqL3TVc/3iwBn04cdNhCnygr+0H0PDhLs
 gNAY/PKJFPGDSOjywWfTRc/rBscUUl8w=
X-Gm-Gg: AR+sD13/jcUobLfZkJ/yZrDty/LkprkAg9TWMd+Mrwzmkeqf8Lzv2vFgoddkp6hNDDN
 oItNs7sCxpAgHwlacIwq0smtQdKQ9swaGF8GWLlzHJJfusYGZsBA5BzSQJ1jLt0C0Hys/C/1U4d
 2LihpvmZBwytuub+UAoU8Ei9Y6T9Kge01DYRZsrONOpuIvIPNo9781YE7zF0y2C/e3TKV4L0LTg
 Q4ygnY9bZwWyGlVJZbTaEbfmBb/GZyIlWCeOcqbfzdwaA7SRuPHLMyeDrsC9yX4jPbmLDcL9Zpc
 jv61f0ued4iwJafc7Yb6uqvY14iKGnHughdjm2ucGTWY4tKutDbVGGU+84EM2rTX0MLqh+u/hOZ
 2GA3qQmh0V4y/Kb3S6WXImIomId/5DQ==
X-Received: by 2002:a05:6512:2382:b0:5b1:4e5e:559c with SMTP id
 2adb3069b0e04-5b47069e8a9mr442389e87.30.1786993882910; Mon, 17 Aug 2026
 12:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
 <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 17 Aug 2026 14:11:11 -0500
X-Gm-Features: AcwNN1VtAz3TzQxDcDRv29ZIlK7LcvZGlrKziZlK_QH60cI6-b_6Gt0v_fcOAnw
Message-ID: <CALHNRZ8F85rJZ4+v+B_jsETeG9cUJWeWSe9vw77AVHcRMasw=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
To: webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Mark Brown <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 25, 2026 at 1:47=E2=80=AFAM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> Without dma enabled pio mode is used and flash storage such as the one
> on the p3668 module times out and cannot complete any transfers. In some
> cases, these timeouts cause hangs and cbb faults.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index 1d659454a6f9fe..e2ddbc6715d5e8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -923,6 +923,8 @@ spi@3270000 {
>                                  <&bpmp TEGRA194_CLK_QSPI0_PM>;
>                         clock-names =3D "qspi", "qspi_out";
>                         resets =3D <&bpmp TEGRA194_RESET_QSPI0>;
> +                       dmas =3D <&gpcdma 5>, <&gpcdma 5>;
> +                       dma-names =3D "rx", "tx";
>                         status =3D "disabled";
>                 };
>
> @@ -1013,6 +1015,8 @@ spi@3300000 {
>                                  <&bpmp TEGRA194_CLK_QSPI1_PM>;
>                         clock-names =3D "qspi", "qspi_out";
>                         resets =3D <&bpmp TEGRA194_RESET_QSPI1>;
> +                       dmas =3D <&gpcdma 6>, <&gpcdma 6>;
> +                       dma-names =3D "rx", "tx";
>                         status =3D "disabled";
>                 };
>
>
> --
> 2.53.0
>
>

Thierry,

The driver change was picked up some time ago and is part of 7.2. Can
this be picked up for 7.3?

Aaron
