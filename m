Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DF1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:53:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D8B10E60E;
	Wed,  8 Jul 2026 15:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="povksdEE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BPhOkk3H";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE2D410E60E
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:53:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668C3I262607231
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 15:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=; b=povksdEEU32r3U2F
 208oi4s1n1bP0yeqPcIppmU/CFq/z0p08+vUOGb1+bJfQopePrfbWPCi5pKmapfu
 xY5ZMZL+fhM+mHK636+iv6T2bySKiKVPwxvAafADP1rm0E9YF71ZlCObddX9+b7h
 eJ2ZLa89O4/eY1XXhqiLtPo3zpQQUrhecZ1u9YWOyFZncUKFGmH4wNDPyVYOcFWx
 C4TRD1jkgEth0B8iasVRKmeX2uUWUJw3TedN9oHHXd/jfF9gRTq6QBCYw9Rvfbya
 yN2GRoHefAatw7UHrkAFHJQ5+aqvsBJYfxPgWtc66NTUjrf/uYyO0qdv7XZbyuUl
 8jB6Eg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be5bj61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 15:53:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f0ed4fe79aso19369436d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525996; cv=none;
 d=google.com; s=arc-20260327;
 b=ppm7KHUU+rgkx410sTQPuaK23ihqT3B6UqRrL/A6X4LA0+479tNEZLcIbl+mzsB+y5
 iaSUAHSOIXv2OCMeXBalZQwCwsk2qK2+UNJclhwkMDcOhaAVOl9uatG0ClY1Wq4AfTrw
 6syOS+Q5iqv1uOmbmIj7zZ5ngI4O1nJRniNSbanB9KAROESmbA4EuCnI817elHByQTu5
 2xWXBrg55kqFIpKHTlt8PWJbQgdezK9F4dXMyTy8d9n/1F69Rt5GYvrUl/K1OVM9IIy9
 4rv7pe7gUZ3kePPE6dzcWwgcBAbWk5EKfVAGj1hjd2el6uPyvvh1KZVSE+tZh9FXZUu8
 eHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
 fh=jMs88zjjLsNicwXody80TKcNcTj8RHYubzJKPaJHnCU=;
 b=g5867pKGBPbjSCa4sF4yk8BZG0Qew2wvkHwk494UCBWqs2hv3KdrdpO1vsxJAk9IuG
 Qfsi0SNV0S36ERB6iS6NDDKD3SznqOygC5n31Mcye7lxF7iKKnFKc2X/uPQHSloMMFin
 pYo53dL73EcV7uojZQJH0FKjJybYG+J2Ipcev2nMhQYXHRdZ0wKmkuGzYgS35p1VnNxp
 9x6+MyRUMVj+ay/VchBWbyzS2U3h79nf5pAgLEBOgGw3ttITxar4h/QvCknKE7GyPbX3
 MQ5tyDJUv8RP/npKZTX1PNNRKp2tcKFuTtOqO7GtrVgj5iXZq6SyVM9l0DSuQzMGC8cf
 A1kw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783525996; x=1784130796;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
 b=BPhOkk3HuHR3YXgtTbnLXA2UtwPYd7BixrcShQhoD0H6h6+W9Tk4bijdMY8zCcoYGc
 wbfEpBec+mKiIqPYa2KKbo/tNdlzsU4SXKuQaAiyelI1zwsqRKASTafVHdnCSbPrpSZx
 ffzbacrcIF+L8sukKUNoqv6mwJTQyQganSvEVVYPL4FF9ASUk7nwmCbh5i0WCxq5/02O
 vGj5BddV/Hw7SU2GbnX1UHQHw16uFHSPi4BO7oohUD30xNJKRaeOlxK3g0QaCrmUR4B8
 BKy6ihxp0IKGldIwfFaY/NoQ6GJfFm4+IQGPgoq/vkX3Hxz4QIY+d69E7UGCU6LHUdNu
 7uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525996; x=1784130796;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
 b=AzcJZH1Rp5VDT5rQ4uboT5AskBwn/h9WQxqA9KqHRM7k4ZF7pA2kqIp5oXlR3dJ9lg
 Hq9NUjy6WOCFyCWJErzNhOAOntKg2O/sQgPw7fLTeGHF06UTUjzoeac4C86mWlVLG+60
 nFRT5aRdQs/TA0zCl779rt/fvYaypT450M8zRbnhBgNfad8R7xHuSN7fJv3VYX+uoKv2
 00Xs+NDiCxzoeJ0dJglYfc59KI+qdUGF590Gkuv+V2Mw6XyCLISr3eVD4zwaDb2O+o/9
 QvcTOujfddJMGOBUCqBQTlFL0tAnE7ARq8KUg5mZpYQ4kyKEYqx3v71WSDrBwCPOY4IS
 3d2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq9JXIypjlZu7Bc86c/+2+CvBylNLOhTwR6t+g0gRhQdZMMIkfRky5IHm5pB3+cTPn0G8wkI4kgFs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzoz27aplgoT8Y7XHZYI1kweISmoN/FesgFCNnU39XEBTn105uz
 syUlc5HZJSkZeqgcBFNABFLN22d75Ym3Q2BPSyJ2GHpUnSZt84bMGd9Ca0iuZJGwF1MUDnm5hEA
 +5osFTKVrCrkc643oL09f7yZ7rd7BHG5xA+ayCt32YORHGlNBM6vX3dTl1QPTphIBZHde0B7Unt
 9UclCrWrVGDw48WmTuO6JkwJe7+3faERoKB4kSfGIx9HmBVw==
X-Gm-Gg: AfdE7cmmb2f6QP63tF4hAgP8tEmokluMjtNwYtl6HXWGqex0JO3jtOZeVijDYF0mnqo
 +B1fRO5VxkWEY9+5g04BPJLe32K1dR1tu6aSmN89zXTKG64XiBY1r6pCg5QsuT5XTMf7X2M55uF
 YcObZeoJdgPBfSQ8nqLDr+26B8sVTYS7p6T2t1hhJpVKmuDhq8DJPVLhsbvtD7cU1vpTtM
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id
 6a1803df08f44-8fec361ce5fmr26793616d6.42.1783525996031; 
 Wed, 08 Jul 2026 08:53:16 -0700 (PDT)
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id
 6a1803df08f44-8fec361ce5fmr26792106d6.42.1783525993919; Wed, 08 Jul 2026
 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:53:01 +0200
X-Gm-Features: AVVi8Cfl9mmuZ0-N0YzXyQTku0PxVhLh9qj1SZFF_tsUR-VGJVPz8z3CnsVKBnw
Message-ID: <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4e726d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=l53Gh-upYCO10StVhpkA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfXz13eUv13y8TW
 6l9J8tW070rlmv9C9fDCofD9ZnBSZcFVRzMlK5NEv9dcXUdy6K2qOFMRb4DMI4Yqi1Fcl0dgyNG
 bXlpFuOB3aWqR9t6kE6yHofcNCS0/ZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfX+SUBtsh5Tyo0
 FrQPSJV0EpflQ+iNotYF7E3Nv5gq2mYjXGHVp9QNi14qwQE10DrpJB0YFF2lgjKT++IgV8DV8+9
 zi+2Iq8Yj4xwuZ8FUiwspwim56heNX5QbJ1Yf6Of3lTpzDNwqGcfm0MxlwD2d/tBo4+nG2r4JaH
 PXy/C1OniLGs9iZGbvUkqITmGbvVLqYbf11AeEPOiNsTtqXf17ACLS/CjQ5YSksr+7LpH7wEQXv
 7CQTvEUOOzUhH9+odDT8uPzXSsehIy4zu7NOY6VLKuJOp+HhV2P8nDPtftK92TA7aGQJGd5AK3n
 AYmCAjRnrSo+zzvJ5MvpDt3+qzxZLZh1RAp4u7G1LtKcQ9k70esL6d9NiEG8kLvyEsSKS+Lli4u
 BgWlOv9E4253eDEC0SvtlgIf4nfOMeI4N1O/FTFjcLispi71H2kBZofVlWPoCx891hxYGk0sEjB
 v1enWxFj8wSYTpZdtZg==
X-Proofpoint-ORIG-GUID: hePcpRhWLYX-drdfVDqAiH1MPSNXietD
X-Proofpoint-GUID: hePcpRhWLYX-drdfVDqAiH1MPSNXietD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080156
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

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nodes=
.
>
> Back the regulator enable state with the corresponding power domains.
>
> This is done for off-chip consumers: the corresponding voltage rails are
> routed out so they are used for powering different peripherals using
> these voltages as supplies.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/boot/dts/st/ste-dbx5x0.dtsi |   2 +
>  drivers/regulator/Kconfig            |  11 ++
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/db8500-regulator.c | 221 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 235 insertions(+)
>
> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index a6fef302c994..fd6a075e4c93 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
>                                 // DB8500_REGULATOR_VAPE
>                                 db8500_vape_reg: db8500_vape {
>                                         regulator-always-on;
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VAPE>;

Hmm, isn't this the other way around? The power-domains node should
have a regulator supply?

We may even consider to skip to model the regulator altogether and
make the power domain operate directly on the prcmu instead.

>                                 };
>
>                                 // DB8500_REGULATOR_VARM
> @@ -693,6 +694,7 @@ db8500_vsmps1_reg: db8500_vsmps1 {
>
>                                 // DB8500_REGULATOR_VSMPS2
>                                 db8500_vsmps2_reg: db8500_vsmps2 {
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VSMPS2>;

Ditto.

>                                 };
>
>                                 // DB8500_REGULATOR_VSMPS3
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index acc698c17bd2..8db63d8d3fa4 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -397,6 +397,17 @@ config REGULATOR_DA9210
>           converter 12A DC-DC Buck controlled through an I2C
>           interface.
>

[...]

Kind regards
Uffe
