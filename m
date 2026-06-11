Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD98CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D2F10E58F;
	Thu, 11 Jun 2026 10:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="RJ01i4F7";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+VOIoa1";
	dkim-atps=neutral
X-Greylist: delayed 826 seconds by postgrey-1.36 at gabe;
 Thu, 11 Jun 2026 10:01:34 UTC
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69A810E58F
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:01:34 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3550C7A0145;
 Thu, 11 Jun 2026 05:47:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 05:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1781171267;
 x=1781257667; bh=UZ2O6D9TYuSc3XK/tGr/NEv5TCWienlMRXuMasKrb3w=; b=
 RJ01i4F7M6T3NtQbcPpC9m1v53MeVxZalQe5mlgdsR5exsjqrJosyf9l3THwbm5b
 6xEpOzIu85GFVOWvgGsrLJcRRRLU2MYRJexMGELllcsc43ubuF6Hp6Jpx/YrkSy5
 ExASw6fgV8XOKbeT/p9OPnuHQAmka8NPpDJyRMA6TWcgCCe0aJ9jXfu/hNhutkY8
 7ikAGGlTJU6F2Xxst+HZ9I3JC1djRv2TKjcQHmCVIZ/t9d1BhbR7h+TBVNVzeWIA
 x7LI+lRblZYVryar1Ki6OT0FzdXJBQVQiVK/2/gtjih0NQqWnBbqnW1lkbLz6KGx
 qfpsInWIruD/+9jZhZrOXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781171267; x=
 1781257667; bh=UZ2O6D9TYuSc3XK/tGr/NEv5TCWienlMRXuMasKrb3w=; b=H
 +VOIoa1uDfmQaRubfyPh39kpBBRvWYAFMxB8FHMOaSGKeUMIkpPU4GT2oB6L+V5D
 l2T++99L5tmIExAy1SKs6NYw4JmmVQb/sGgWb4y6QVG+nWCOpbToUjlbaxCPCtu/
 +jfmffCmYDmp415jL0gahqIGKfoNn/jL7VFd8Pd/6FTzhEop4KgE85OtMb/P0b+b
 M1V+CLgAOE+StLpclJx4CYK52OS4RYdo6kYLivxEGN/Zirdkh3snaqp4wjd8JIFr
 fe+uBec9+BpbzI0qCE/WlH1tYZDbOMGWX035oFLsZUBqMaBviDYR8yzJ/oV9Rcpx
 9skHkH9l0GBNSzlc+PolQ==
X-ME-Sender: <xms:QYQqakDSdxbv_5i1gNbWKEvW2MR_QtsN2ggOm8hn8F4ezi2tfqgU-Q>
 <xme:QYQqaifELtSd_NtVjk_xBz0quXvKdhtlGSRpQef7u7pirneiQuSI0pSGoytXkL5Oy
 vm5E5pPwwGQltqCwTYqAnUyLQTJ9wIuCphgmUa4Ra6k3-x9Jc-J1g>
X-ME-Received: <xmr:QYQqatsq-sSd7xL_15hK3W7ecPt53edqEOjMnmmFukkNSC5Km3GcgnG6VXzPQ-WjlF738SnJVdvaIMC3btQszgx9pmsQ>
X-ME-Proxy-Cause: dmFkZTFSv3JB1Ni2NSAN7aIRmf1apyIuRnKdo8KEYWuccHfmeKPOVWKXC3OfaoSLzL2W7f
 nNOAnnyYfP8hapRVEhYpYVm5/Z2ckitiCKkSFw2fKP4q9G9hkaJy+1G5/Beuv5/YWp5smA
 vKG9SdCje210KdC3G6aLaRj+f5ORP48y9jT0dTAzqjlXpou2INuS5XE2SEJcfFsToQLfbB
 uviAh5Of/P9J2hQ04clNI9hwAbBscNWuVs+bg9B63kxHSfE1VWlAmuQ1asSufXWnRJuvwt
 NbJJv8FjFR+GluH5q6YvALo2YZQMDCabxEj7lE7VfO23Q8qkC3nPtAIObxqK+E+Bt2R7XO
 QcvFh1cYrMCCKveZG2bbon9kAS1WNVor1cidvPWgMmaeIy9VJrF1x9hFDpmQpemJJYBjZn
 F8HQG6l98wlvwkHf1GUWYZ2B5UbRBh6gV85gX/M8+tWhFU8Y+HCOVpj8akvrx7Ewc7M2vf
 95HcXLaaj9xuJiJmUZqAQyXL21czLEniKui4xhb4VK3Lw33MYs92qrXN+r9HNBbPlOHEmW
 8N1e7zbyRjbVDEuvlDimYlurEdu3Icq9lxVIvhxmeH1HX3nFyJldQ7A7zbyhK7Jkpd8Gdn
 a5ySNV0/R+oA6M1f+ZPJaX3prKoFrLF7ZxVZLkwK0cSTQ39DOuxcxz+j75Rg
X-ME-Proxy: <xmx:QYQqahLaji_soT2YGOOZS0-EiJUy8VumU02i_EKHqltp74Khcn1K-w>
 <xmx:QYQqana4FklhvInZfs59k1o8X4kgA6FpPhMtCGdiYcqtum_4QOXQNA>
 <xmx:QYQqavIpV4bNVlgSh1tH6yQmUzIWNn8QXsQlS0GS3Zyqe767rIapnQ>
 <xmx:QYQqaopng1QiEO4BgdkNqYi-_D5Rr3kfL17-P2MBfxgrY7mtJ-kHFw>
 <xmx:Q4Qqan6tOiRdTjReYsb2ShalPTv-QKourkashIn1X3L0K6OVill_mQj1>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 05:47:45 -0400 (EDT)
Date: Thu, 11 Jun 2026 11:47:43 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Frank Binns <frank.binns@imgtec.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: renesas: r8a77965-salvator-x: Enable GPU
 support
Message-ID: <20260611094743.GC69568@ragnatech.se>
References: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
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

Hi Marek,

Thanks for your work.

On 2026-06-11 02:57:29 +0200, Marek Vasut wrote:
> Enable GPU on Salvator-X with R-Car M3-N.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

For the whole series,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Frank Binns <frank.binns@imgtec.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Matt Coster <matt.coster@imgtec.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> index f84c64ed4df7b..af8cfdccd2103 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77965-salvator-x.dts
> @@ -30,3 +30,7 @@ &du {
>  	clock-names = "du.0", "du.1", "du.3",
>  		      "dclkin.0", "dclkin.1", "dclkin.3";
>  };
> +
> +&gpu {
> +	status = "okay";
> +};
> -- 
> 2.53.0
> 

-- 
Kind Regards,
Niklas Söderlund
