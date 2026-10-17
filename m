Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7ACCF2C4
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1C710E02F;
	Sat, 17 Oct 2026 16:37:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 003C510E02F
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 16:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50C6E4004A;
 Sat, 17 Oct 2026 16:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA291F000C5;
 Sat, 17 Oct 2026 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792255054;
 bh=5YQWSI4ybuP3+qZ2WIH2lJW4okdIiZktG/jNbRw5lxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ajgpPwRDVpSR9qx+gRAnR4zdOE14k/fr+tSCNxvDM9/65ngZPp1Ifrc7Ip9953irt
 Dr7Evyr7Ze7W+5VoACIzLie7isRpU6TtSFfFpVcvc+m2G8p1sau9lo9HZzh1h5i0Ip
 5difS6URCxy1Y9xpyryb4Rc2msfm9AYTzYzx7GfMAPMHI01c2ttXn9XJKxdtZhceoF
 1wmwj/SY01hBxkRr8Rl5iTuHIIit6IwmzaWT7SoOoTo3h29TsEgZ4Iu+JyS8AfCU9S
 W/ogJWye0OPYbC+FiuDh8ELsqPoeH8gT8IXip6qiat3mN8x0M3ZZ3PJAEx+gY8mKCC
 YBFouicgvrr4Q==
Date: Sat, 17 Oct 2026 18:37:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH 3/9] dt-bindings: regulator: add Qualcomm LCDB regulator
Message-ID: <20261017-daffodil-buzzard-of-amplitude-9e817f@quoll>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
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

On Thu, Oct 15, 2026 at 11:58:40AM +0300, Dmitry Baryshkov wrote:
> Several Qualcomm PMICs have an LCDB block providing the positive and
> negative bias rails for LCD panels. It is not supported by Linux, so
> boards using it either model the rails as dummy fixed regulators and
> depend on the state left by the bootloader.
> 
> Describe the LCDB regulator present on the PM8150L. Use it as a fallback
> compatible for LCDB blocks on PMI632 and PM6150L. PM660L has a different
> version of LCDB block, so it's not being covered.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/regulator/qcom,pm8150l-lcdb.yaml      | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

