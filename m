Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A9FC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5324A10E35E;
	Thu, 17 Sep 2026 04:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIKeuw6w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KuWFPnLn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B36E10E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 04:19:29 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H44AR64038577
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 04:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ErMAmKl2nXolpy0a4Xt8Do1unubhG9EtESy6aINKkEw=; b=HIKeuw6w0oLjrYuo
 a4jfSa+w+VD/bRizDu21fW4iEQ69we+Mmyj9qgSRIJbnKmSxLvqkQi45w4+KwWwa
 fG9lkDflAcNHbUnumUHNn87JQWCrFz97ctWncCZQngPcah7HJBKuHrVHFIR5rcyN
 MyEFJh6rT6YE3bepEEzsGYuY+VHpR+Ke98KOxDGks6s6z9xMsYs2woURroT72kXK
 Zatfrtdn43ZqXww1p2bYHG0fh4LnRF3hFjryOHSIwi6438+bIE4mDPF4e8f3jaaK
 +sdCjBPwdeM1t7FSV6u5kg6dg7sgBH/ZwQsVuTkBtYubcz9LaWFpkA2y3s86FqG9
 JuAhYw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr8uw01k1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 04:19:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so1040700a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789618768; x=1790223568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ErMAmKl2nXolpy0a4Xt8Do1unubhG9EtESy6aINKkEw=;
 b=KuWFPnLn7i3OHvaUNf1Zb47yIFvyWNH6lIqyGX+4ZaVhw8sLYGnPL67WKoiCApJIr5
 4P8fXX6lzHWKqiOn77W+2I2U+0cszSwFb74Djuhhc4IN32Aj0nJrVdaYlS+/bnnRBB+F
 kLCmNYIzm5pHIk8y2K5D9NswCUSlVlKenLGcXFmiNofZdYKeFK4rfUQs2dJbUnsRNvq3
 HqFh8tK+5PygWdgYE5EAzGMK+BpU4NZ+SYF6WFJ9eWG1P5jdyKrHZfA71oM24+GEjeif
 kX54lSTsqiSDm4ETQOdKOVS/R+SA5myggMdZyEJyuBsTFoEF/K+/njoI13FRcZMDstYB
 TBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789618768; x=1790223568;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ErMAmKl2nXolpy0a4Xt8Do1unubhG9EtESy6aINKkEw=;
 b=WBL5kVibheAh7v71popHyvN1KdR+wS7Iv17GvM03ZPiFIvMUYJvzjy4oev3yR7qV/0
 laqVfoiLksc7puMBveBVduMNriK3yb02p1rHh1c4tWYdOMq8gLqHsEd0XulafjCY505a
 rUrYAApO0/66y4oADQRpbuKrXODgq2mTduXiiXwKpTT53YY05jGhJNaPl2KxtU+ctVgN
 78VqkZ7MxmrD3Ap8n5D98Qn4EhdYNtK0Zlt/yI/Hyb7Rbma7i4To2kKuHMCZbUo10Qnr
 cXT84bARKDGvO5qL+yhFMwv748fAy+panCyg3DgahV1DykojSo9UipZB0q/TcEuvzbBu
 tKCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDhHxojew+hayH/H43I+IQeNmbB2WSHVSMCM0Q04GGg7HIYlGpT+UhqboxmXQuxRJ0PMrTL3IIxQY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWZAfSi5VyEDs0ivni0KiW610+kcDoi2yOqWzYdZOhMLg4y8bs
 XMbMj3GZoCLNqseUA69QD/LOje4UzcMB6Cwr7MiyfKSEtx+tbIAjPdTlVYNV1alQ/XwlfLweRc0
 75fpwIBek3u7lpJ8xWgCwlhEXK2JmgJ3d/IEHcSuBPp4uNp7X1RU6v5zYKH0CrEXmW5oIV7U=
X-Gm-Gg: AYBFou0L/4wIGMHN/5iAnZPGtU0RFlr1zRyqTAgV25K4TpA4chGe1jQJwHibwTOdcz2
 4J2/D7C6SQtNYjfbhJIYSPHBmrUhsw6wy7Ht5N6tBA+6xvxnrusAbAqVdWi9k+iXGy8j20efXjk
 IHehwaEyYPWOP58ZvRN8wpihW49aUlvSV0qgD9mXrH9EdZzKrxgxmGfLsZu1iCi5Z738cEW9OnS
 Y+eiEAFQehnPbeyyDB5dnfV/kuadLuxJUKC0kR9aytp2cnQwANdzq8w3iotiu04MSmsB9ed1xOU
 AlMlk9iyG/bTcUYw/yITMZRhz10XOVn5AHjXbE1G9drSkUB+aoKh/JywpstEJ8KfS+4dqt4Hz5d
 ivpt9hoQs828pps2rje4jl26L07Q=
X-Received: by 2002:a17:90b:5386:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39e1e4aa012mr13035145a91.19.1789618767140; 
 Wed, 16 Sep 2026 21:19:27 -0700 (PDT)
X-Received: by 2002:a17:90b:5386:b0:398:dcef:c040 with SMTP id
 98e67ed59e1d1-39e1e4aa012mr13034969a91.19.1789618765940; 
 Wed, 16 Sep 2026 21:19:25 -0700 (PDT)
Received: from [10.217.217.79] ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aca3fbsm12879558eec.20.2026.09.16.21.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 21:19:25 -0700 (PDT)
Message-ID: <af3f7261-e4b0-42fc-818d-80e760cddc2c@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 09:49:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/19] clk: qcom: Add global clock controller driver
 for MSM8952
To: muzafferkadir@mainlining.org, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>,
 Amit Kucheria <amitk@kernel.org>,
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 iommu@lists.linux.dev, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <20260916-msm8952-initial-support-v2-2-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XbUqh3bC8UAwqdwEBKHDr4qp6_esLZWf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA1MyBTYWx0ZWRfXy9NLIxx02lPj
 6X9acj8AXiM0ftosHiTdnBu00BZoO6c4hTuXGAhb7FjqJjpVsYtKcBGQmycJRirF+8aENFxcZGG
 wHQdX1lToBNY8xC6tOo1xw1PfkSBnY7oWINm1DmDtwa8eEIrCJop58o/jTD4URCGtEL8T1ItG47
 3g0DgSUXqU/SiOkTbZ/uQrG89byk8+8jcUS5gAxK1jVjk8vE1oeY9y1yNthWPYqkB7vx9bkvl00
 m3m7eqEE/G9mqimWXBz6wrgBFYVXlC/m/6NFXiFKcxtMVMWEBoIOPORPwtkDwz3d5lEyT/3b1Qx
 G3pdZe3OW869ncz3ZCDt43cY18ZjK7KgQpN/mf8+tASkjc3s1VcVnwhG9MsdMtYC1wOj3Dl4eVq
 oTGZOfDOyGc6OxCdzWu8iJv23mE5iLsuih+8TXFK9SpUNf33JcCkZOc0dA07LwlfYaw3Yfw2dSI
 XLgNzG5slcdfwigMaug==
X-Proofpoint-GUID: XbUqh3bC8UAwqdwEBKHDr4qp6_esLZWf
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA1MyBTYWx0ZWRfX+yP+ZyosX0l5
 lxRb4pVZl29WB5nK7+bSh7hYWfQRaetXEGfnUp49yO6kBEXNXlhVChestNYMV/8EJHvRF4awZN8
 MKljDMrMZJQutsPoN702FwKuwXm/2es=
X-Authority-Analysis: v=2.4 cv=dMUzC+Zb c=1 sm=1 tr=0 ts=6aab6a50 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=Oh2cFVv5AAAA:8 a=OuZLqq7tAAAA:8 a=NOlsw4_dMqN8guHtaiwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=7KeoIwV6GZqOttXkcoxL:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170053
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



On 9/16/2026 7:52 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> This driver provides clocks, resets and power domains needed for various
> components of the MSM8952.
> 
> Some downstreams merge MSM8952 to MSM8917 and MSM8937. But upstreamed
> GCC driver for 8917 series has different pll structure and ported from
> different GCC driver.
> 
> Downstream Reference: [1]
> 
> [1] https://android.googlesource.com/kernel/msm.git/+/refs/tags/android-wear-7.0.0_r0.3/drivers/clk/qcom/clock-gcc-8952.c
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  drivers/clk/qcom/Kconfig       |   10 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/gcc-msm8952.c | 3550 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 3561 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 6ef083f5d9e2..7577d87c05ec 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -778,6 +778,16 @@ config MSM_GCC_8939
>  	  Say Y if you want to use devices such as UART, SPI i2c, USB,
>  	  SD/eMMC, display, graphics, camera etc.
>  
> +config MSM_GCC_8952
> +	tristate "MSM8952 Global Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
> +	select QCOM_GDSC
> +	default ARCH_QCOM
> +	help
> +	  Support for the global clock controller on msm8952 devices.

MSM8952

> +	  Say Y if you want to use devices such as UART, SPI i2c, USB,
> +	  SD/eMMC, display, graphics, camera etc.
> +
>  config MSM_GCC_8960
>  	tristate "APQ8064/MSM8960 Global Clock Controller"
>  	depends on ARM || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index a6c676f68b79..3c3f27dcc68d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -89,6 +89,7 @@ obj-$(CONFIG_MSM_GCC_8909) += gcc-msm8909.o
>  obj-$(CONFIG_MSM_GCC_8916) += gcc-msm8916.o
>  obj-$(CONFIG_MSM_GCC_8917) += gcc-msm8917.o
>  obj-$(CONFIG_MSM_GCC_8939) += gcc-msm8939.o
> +obj-$(CONFIG_MSM_GCC_8952) += gcc-msm8952.o
>  obj-$(CONFIG_MSM_GCC_8953) += gcc-msm8953.o
>  obj-$(CONFIG_MSM_GCC_8960) += gcc-msm8960.o
>  obj-$(CONFIG_MSM_GCC_8974) += gcc-msm8974.o
> diff --git a/drivers/clk/qcom/gcc-msm8952.c b/drivers/clk/qcom/gcc-msm8952.c
> new file mode 100644
> index 000000000000..6b82606dfadb
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-msm8952.c
> @@ -0,0 +1,3550 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Linaro Limited

https://android.googlesource.com/kernel/msm/+/android-msm-shamrock-3.10-nougat-release/drivers/clk/qcom/clock-gcc-8952.c

This is our original copyright.

> + * Copyright 2026 Muzaffer Kadir <muzafferkadir@mainlining.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8952.h>
> +
> +#include "common.h"
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "clk-alpha-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-branch.h"
> +#include "reset.h"
> +#include "gdsc.h"
> +

Add DT_BI_TCXO enum.

> +enum {
> +	P_XO,
> +	P_XO_A,
> +	P_GPLL0,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL0_AUX,
> +	P_GPLL3,
> +	P_GPLL4,
> +	P_GPLL6,
> +	P_GPLL6_AUX,
> +	P_GPLL6_OUT_MAIN,
> +	P_DSI0_PHYPLL_BYTE,
> +	P_DSI0_PHYPLL_DSI,
> +};
> +
> +static struct clk_pll gpll0 = {
> +	.l_reg = 0x21004,
> +	.m_reg = 0x21008,
> +	.n_reg = 0x2100c,
> +	.config_reg = 0x21014,
> +	.mode_reg = 0x21000,
> +	.status_reg = 0x2101c,
> +	.status_bit = 17,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpll0",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xo",

Use the index inplace of fw_name to align to the latest clock drivers.

> +		},
> +		.num_parents = 1,
> +		.ops = &clk_pll_ops,
> +	},
> +};
> +
> +static struct clk_regmap gpll0_vote = {
> +	.enable_reg = 0x45000,
> +	.enable_mask = BIT(0),
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gpll0_vote",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpll0.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		/* This clock is required for other ones to function. */
> +		.flags = CLK_IS_CRITICAL,

This will never allow the CPU to remove it's vote and hence low power
modes will be broken.

> +		.ops = &clk_pll_vote_ops,
> +	},
> +};
> +
> +static const struct pll_vco gpll3_p_vco[] = {
> +	{ 700000000, 1400000000, 0 },
> +};
> +
> +static const struct alpha_pll_config gpll3_early_config = {
> +	.l = 63,
> +	.config_ctl_val = 0x4001055b,
> +	.main_output_mask = BIT(0),
> +	.test_ctl_val = 0x0,
> +	.test_ctl_mask = GENMASK(31, 0),
> +	.test_ctl_hi_val = 0x40000600,
> +	.test_ctl_hi_mask = GENMASK(31, 0),
> +	.alpha_en_mask = BIT(24),
> +	.post_div_val = BIT(8),
> +	.post_div_mask = GENMASK(11, 8),
> +};
> +
> +static struct clk_alpha_pll gpll3_early = {
> +	.offset = 0x22000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.vco_table = gpll3_p_vco,
> +	.num_vco = ARRAY_SIZE(gpll3_p_vco),
> +	.flags = SUPPORTS_DYNAMIC_UPDATE,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpll3_early",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xo",

use index in all the code references.

> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll_postdiv gpll3 = {
> +	.offset = 0x22000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpll3",
> +		.parent_hws = (const struct clk_hw*[]){
> +			&gpll3_early.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_pll gpll4 = {
> +	.l_reg = 0x24004,
> +	.m_reg = 0x24008,
> +	.n_reg = 0x2400c,
> +	.config_reg = 0x24018,
> +	.mode_reg = 0x24000,
> +	.status_reg = 0x24000,
> +	.status_bit = 30,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpll4",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xo",
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_pll_ops,
> +	},
> +};
> +
> +static struct clk_regmap gpll4_vote = {
> +	.enable_reg = 0x45000,
> +	.enable_mask = BIT(5),
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gpll4_vote",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpll4.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_pll_vote_ops,
> +	},
> +};
> +
> +static struct clk_pll gpll6 = {
> +	.l_reg = 0x37004,
> +	.m_reg = 0x37008,
> +	.n_reg = 0x3700c,
> +	.config_reg = 0x37014,
> +	.mode_reg = 0x37000,
> +	.status_reg = 0x3701c,
> +	.status_bit = 17,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gpll6",
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xo",
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_pll_ops,
> +	},
> +};
> +
> +static struct clk_regmap gpll6_vote = {
> +	.enable_reg = 0x45000,
> +	.enable_mask = BIT(7),
> +	.hw.init = &(struct clk_init_data){
> +		.name = "gpll6_vote",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpll6.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_pll_vote_ops,
> +	},
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_out_main_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0_OUT_MAIN, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_out_main_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_a_gpll0_map[] = {
> +	{ P_XO_A, 0 },
> +	{ P_GPLL0, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_a_gpll0_parent_data[] = {
> +	{ .fw_name = "xo_a" },
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_gpll3_gpll6a_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 },
> +	{ P_GPLL3, 2 },
> +	{ P_GPLL6_AUX, 3 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_gpll3_gpll6a_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +	{ .hw = &gpll3.clkr.hw },
> +	{ .hw = &gpll6_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 },
> +	{ P_GPLL4, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_gpll4_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +	{ .hw = &gpll4_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_gpll6_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL6, 2 },
> +	{ P_GPLL0, 1 },
> +};
> +
> +static const struct parent_map gcc_xo_gpll6_out_main_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL6_OUT_MAIN, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_gpll6_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll6_vote.hw },
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0a_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0_AUX, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0a_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct clk_parent_data gcc_gpll0_parent_data[] = {
> +	{ .hw = &gpll0_vote.hw },
> +};
> +
> +static const struct parent_map gcc_gpll0_map[] = {
> +	{ P_GPLL0, 1 },
> +};
> +
> +static const struct parent_map gcc_xo_map[] = {
> +	{ P_XO, 0, },
> +};
> +
> +static const struct clk_parent_data gcc_xo_parent_data[] = {
> +	{ .fw_name = "xo" },
> +};
> +
> +static const struct parent_map gcc_xo_dsibyte_map[] = {
> +	{ P_XO, 0 },
> +	{ P_DSI0_PHYPLL_BYTE, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_dsibyte_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .fw_name = "dsi0pllbyte", .name = "dsi0pllbyte" },
> +};
> +
> +static const struct parent_map gcc_xo_dsiphy_map[] = {
> +	{ P_XO, 0 },
> +	{ P_DSI0_PHYPLL_DSI, 1 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_dsiphy_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .fw_name = "dsi0pll", .name = "dsi0pll" },
> +};
> +
> +static const struct parent_map gcc_xo_gpll0_dsiphy_map[] = {
> +	{ P_XO, 0 },
> +	{ P_GPLL0, 1 },
> +	{ P_DSI0_PHYPLL_DSI, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll0_dsiphy_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll0_vote.hw },
> +	{ .fw_name = "dsi0pll", .name = "dsi0pll" },
> +};
> +
> +static const struct clk_parent_data gcc_xo_gpll6_out_main_parent_data[] = {
> +	{ .fw_name = "xo" },
> +	{ .hw = &gpll6_vote.hw },
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_top_ahb_clk_src[] = {
> +	F(40000000, P_GPLL0, 10, 1, 2),
> +	F(61540000, P_GPLL0, 13, 0, 0),
> +	F(80000000, P_GPLL0, 10, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 camss_top_ahb_clk_src = {
> +	.cmd_rcgr = 0x5a000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_top_ahb_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "camss_top_ahb_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_apss_ahb_clk[] = {
> +	F(19200000, P_XO_A, 1, 0, 0),

The below frequencies should be removed as they are not derived from a
GPLL0_AO source.

> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(133330000, P_GPLL0, 6, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 apss_ahb_clk_src = {
> +	.cmd_rcgr = 0x46000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_a_gpll0_map,
> +	.freq_tbl = ftbl_apss_ahb_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "apss_ahb_clk_src",
> +		.parent_data = gcc_xo_a_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_a_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +		/*
> +		 * This clock allows the CPUs to communicate with
> +		 * the rest of the SoC. Without it, the brain will
> +		 * operate without the rest of the body.
> +		 */
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_csi0_1_2_clk[] = {
> +	F(100000000, P_GPLL0, 8, 0,	0),
> +	F(160000000, P_GPLL0, 5, 0,	0),
> +	F(200000000, P_GPLL0, 4, 0,	0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 csi0_clk_src = {
> +	.cmd_rcgr = 0x4e020,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "csi0_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 csi1_clk_src = {
> +	.cmd_rcgr = 0x4f020,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "csi1_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 csi2_clk_src = {
> +	.cmd_rcgr = 0x3c020,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_csi0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "csi2_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_oxili_gfx3d_clk[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(80000000, P_GPLL0, 10, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	F(228570000, P_GPLL0, 3.5, 0, 0),
> +	F(240000000, P_GPLL6_AUX, 4.5, 0, 0),
> +	F(266670000, P_GPLL0, 3, 0, 0),
> +	F(400000000, P_GPLL0, 2, 0, 0),
> +	F(465000000, P_GPLL3, 1, 0, 0),
> +	F(500000000, P_GPLL3, 1, 0, 0),
> +	F(550000000, P_GPLL3, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gfx3d_clk_src = {
> +	.cmd_rcgr = 0x59000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll3_gpll6a_map,
> +	.freq_tbl = ftbl_gcc_oxili_gfx3d_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gfx3d_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll3_gpll6a_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll3_gpll6a_parent_data),
> +		.ops = &clk_rcg2_ops,
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_vfe0_clk[] = {
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(80000000, P_GPLL0, 10, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(133330000, P_GPLL0, 6, 0, 0),
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	F(177780000, P_GPLL0, 4.5, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	F(266670000, P_GPLL0, 3, 0, 0),
> +	F(308570000, P_GPLL6, 3.5, 0, 0),
> +	F(320000000, P_GPLL0, 2.5, 0, 0),
> +	F(360000000, P_GPLL6, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 vfe0_clk_src = {
> +	.cmd_rcgr = 0x58000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_vfe0_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "vfe0_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 vfe1_clk_src = {
> +	.cmd_rcgr = 0x58054,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_vfe0_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "vfe1_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_blsp1_qup1_6_i2c_apps_clk[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x0200c,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup1_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_blsp1_qup1_6_spi_apps_clk[] = {
> +	F(960000, P_XO, 10, 1, 2),
> +	F(4800000, P_XO, 4, 0, 0),
> +	F(9600000, P_XO, 2, 0, 0),
> +	F(16000000, P_GPLL0, 10, 1, 5),
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(25000000, P_GPLL0, 16, 1, 2),
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x02024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup1_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x03000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup2_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x03014,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup2_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x04000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup3_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x04024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup3_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x05000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup4_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x05024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_qup4_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_blsp1_uart1_6_apps_clk[] = {
> +	F(3686400, P_GPLL0, 1, 72, 15625),
> +	F(7372800, P_GPLL0, 1, 144, 15625),
> +	F(14745600, P_GPLL0, 1, 288, 15625),
> +	F(16000000, P_GPLL0, 10, 1, 5),
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(24000000, P_GPLL0, 1, 3, 100),
> +	F(25000000, P_GPLL0, 16, 1, 2),
> +	F(32000000, P_GPLL0, 1, 1, 25),
> +	F(40000000, P_GPLL0, 1, 1, 20),
> +	F(46400000, P_GPLL0, 1, 29, 500),
> +	F(48000000, P_GPLL0, 1, 3, 50),
> +	F(51200000, P_GPLL0, 1, 8, 125),
> +	F(56000000, P_GPLL0, 1, 7, 100),
> +	F(58982400, P_GPLL0, 1, 1152, 15625),
> +	F(60000000, P_GPLL0, 1, 3, 40),
> +	{ }
> +};
> +
> +static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
> +	.cmd_rcgr = 0x02044,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_uart1_6_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_uart1_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
> +	.cmd_rcgr = 0x03034,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_uart1_6_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp1_uart2_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x0c00c,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup1_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x0c024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup1_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x0d000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup2_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x0d014,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup2_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x0f000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup3_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x0f024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup3_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src = {
> +	.cmd_rcgr = 0x18000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_i2c_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup4_i2c_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src = {
> +	.cmd_rcgr = 0x18024,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_qup1_6_spi_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_qup4_spi_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_uart1_apps_clk_src = {
> +	.cmd_rcgr = 0x0c044,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_uart1_6_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_uart1_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 blsp2_uart2_apps_clk_src = {
> +	.cmd_rcgr = 0x0d034,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_blsp1_uart1_6_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "blsp2_uart2_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_cci_clk[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	F(37500000, P_GPLL0_AUX, 1, 3, 64),
> +	{ }
> +};
> +
> +static struct clk_rcg2 cci_clk_src = {
> +	.cmd_rcgr = 0x51000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0a_map,
> +	.freq_tbl = ftbl_gcc_camss_cci_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "cci_clk_src",
> +		.parent_data = gcc_xo_gpll0a_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0a_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_camss_gp0_1_clk_src[] = {
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 camss_gp0_clk_src = {
> +	.cmd_rcgr = 0x54000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_gpll0_map,
> +	.freq_tbl = ftbl_camss_gp0_1_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "camss_gp0_clk_src",
> +		.parent_data = gcc_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 camss_gp1_clk_src = {
> +	.cmd_rcgr = 0x55000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_gpll0_map,
> +	.freq_tbl = ftbl_camss_gp0_1_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "camss_gp1_clk_src",
> +		.parent_data = gcc_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_jpeg0_clk[] = {
> +	F(133330000, P_GPLL0, 6, 0,	0),
> +	F(266670000, P_GPLL0, 3, 0,	0),
> +	F(320000000, P_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 jpeg0_clk_src = {
> +	.cmd_rcgr = 0x57000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_jpeg0_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "jpeg0_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_mclk0_1_2_clk[] = {
> +	F(6150000, P_GPLL0, 1, 1, 130),
> +	F(8000000, P_GPLL0, 1, 1, 100),
> +	F(24000000, P_GPLL6, 1, 1, 45),
> +	F(66670000, P_GPLL0, 12, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 mclk0_clk_src = {
> +	.cmd_rcgr = 0x52000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_mclk0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "mclk0_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 mclk1_clk_src = {
> +	.cmd_rcgr = 0x53000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_mclk0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "mclk1_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 mclk2_clk_src = {
> +	.cmd_rcgr = 0x5c000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_mclk0_1_2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "mclk2_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_csi0_1phytimer_clk[] = {
> +	F(100000000, P_GPLL0, 8, 0,	0),
> +	F(160000000, P_GPLL0, 5, 0,	0),
> +	F(200000000, P_GPLL0, 4, 0,	0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 csi0phytimer_clk_src = {
> +	.cmd_rcgr = 0x4e000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_csi0_1phytimer_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "csi0phytimer_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 csi1phytimer_clk_src = {
> +	.cmd_rcgr = 0x4f000,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_camss_csi0_1phytimer_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "csi1phytimer_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_camss_cpp_clk[] = {
> +	F(133330000, P_GPLL0, 6, 0, 0),
> +	F(180000000, P_GPLL6, 6, 0, 0),
> +	F(266670000, P_GPLL0, 3, 0, 0),
> +	F(308570000, P_GPLL6, 3.5, 0, 0),
> +	F(320000000, P_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 cpp_clk_src = {
> +	.cmd_rcgr = 0x58018,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_camss_cpp_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "cpp_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_crypto_clk[] = {
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(80000000, P_GPLL0, 10, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 crypto_clk_src = {
> +	.cmd_rcgr = 0x16004,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_crypto_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "crypto_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +/*
> + * This is a frequency table for "General Purpose" clocks.
> + * These clocks can be muxed to the SoC pins and may be used by
> + * external devices. They're often used as PWM source.
> + *
> + * Please note that MND divider must be enabled for duty-cycle
> + * control to be possible. (M != N) Also since D register is configured
> + * with a value multiplied by 2, and duty cycle is calculated as
> + *                             (2 * D) % 2^W
> + *                DutyCycle = ----------------
> + *                              2 * (N % 2^W)
> + * (where W = .mnd_width)
> + * N must be half or less than maximum value for the register.
> + * Otherwise duty-cycle control would be limited.
> + * (e.g. for 8-bit NMD N should be less than 128)
> + */
> +static const struct freq_tbl ftbl_gcc_gp1_3_clk[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gp1_clk_src = {
> +	.cmd_rcgr = 0x08004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_map,
> +	.freq_tbl = ftbl_gcc_gp1_3_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gp1_clk_src",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gpll0_vote.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gp2_clk_src = {
> +	.cmd_rcgr = 0x09004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_map,
> +	.freq_tbl = ftbl_gcc_gp1_3_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gp2_clk_src",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gpll0_vote.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gp3_clk_src = {
> +	.cmd_rcgr = 0x0a004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_map,
> +	.freq_tbl = ftbl_gcc_gp1_3_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "gp3_clk_src",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gpll0_vote.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 byte0_clk_src = {
> +	.cmd_rcgr = 0x4d044,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_dsibyte_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "byte0_clk_src",
> +		.parent_data = gcc_xo_dsibyte_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_dsibyte_parent_data),
> +		.ops = &clk_byte2_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_mdss_esc_clk[] = {
> +	F(19200000, P_XO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 esc0_clk_src = {
> +	.cmd_rcgr = 0x4d05c,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_map,
> +	.freq_tbl = ftbl_gcc_mdss_esc_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "esc0_clk_src",
> +		.parent_data = gcc_xo_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_mdss_mdp_clk[] = {
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(80000000, P_GPLL0, 10, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(145450000, P_GPLL0, 5.5, 0, 0),
> +	F(160000000, P_GPLL0, 5, 0, 0),
> +	F(177780000, P_GPLL0, 4.5, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	F(266670000, P_GPLL0, 3, 0, 0),
> +	F(320000000, P_GPLL0, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 mdp_clk_src = {
> +	.cmd_rcgr = 0x4d014,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_dsiphy_map,
> +	.freq_tbl = ftbl_gcc_mdss_mdp_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "mdp_clk_src",
> +		.parent_data = gcc_xo_gpll0_dsiphy_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_dsiphy_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 pclk0_clk_src = {
> +	.cmd_rcgr = 0x4d000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_dsiphy_map,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "pclk0_clk_src",
> +		.parent_data = gcc_xo_dsiphy_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_dsiphy_parent_data),
> +		.ops = &clk_pixel_ops,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_mdss_vsync_clk[] = {
> +	F(19200000, P_XO, 1, 0,	0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 vsync_clk_src = {
> +	.cmd_rcgr = 0x4d02c,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0a_map,
> +	.freq_tbl = ftbl_gcc_mdss_vsync_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "vsync_clk_src",
> +		.parent_data = gcc_xo_gpll0a_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0a_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_pdm2_clk[] = {
> +	F(64000000, P_GPLL0, 12.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 pdm2_clk_src = {
> +	.cmd_rcgr = 0x44010,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_pdm2_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "pdm2_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk[] = {
> +	F(144000, P_XO, 16, 3, 25),
> +	F(400000, P_XO, 12, 1, 4),
> +	F(20000000, P_GPLL0, 10, 1, 4),
> +	F(25000000, P_GPLL0, 16, 1, 2),
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(177770000, P_GPLL0, 4.5, 0, 0),
> +	F(192000000, P_GPLL4, 6, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	F(384000000, P_GPLL4, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 sdcc1_apps_clk_src = {
> +	.cmd_rcgr = 0x42004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll4_map,
> +	.freq_tbl = ftbl_gcc_sdcc1_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "sdcc1_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll4_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll4_parent_data),
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk[] = {
> +	F(144000, P_XO, 16, 3, 25),
> +	F(400000, P_XO, 12, 1, 4),
> +	F(20000000, P_GPLL0, 10, 1, 4),
> +	F(25000000, P_GPLL0, 16, 1, 2),
> +	F(50000000, P_GPLL0, 16, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(177770000, P_GPLL0, 4.5, 0, 0),
> +	F(200000000, P_GPLL0, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 sdcc2_apps_clk_src = {
> +	.cmd_rcgr = 0x43004,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "sdcc2_apps_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc1_ice_core_clk[] = {
> +	F(100000000, P_GPLL0_OUT_MAIN, 8, 0, 0),
> +	F(200000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 sdcc1_ice_core_clk_src = {
> +	.cmd_rcgr = 0x5d000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_out_main_map,
> +	.freq_tbl = ftbl_gcc_sdcc1_ice_core_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "sdcc1_ice_core_clk_src",
> +		.parent_data = gcc_xo_gpll0_out_main_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_out_main_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_ice_core_clk = {
> +	.halt_reg = 0x5d014,
> +	.clkr = {
> +		.enable_reg = 0x5d014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_sdcc1_ice_core_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&sdcc1_ice_core_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb_hs_system_clk[] = {
> +	F(57140000, P_GPLL0, 14, 0, 0),
> +	F(100000000, P_GPLL0, 8, 0, 0),
> +	F(133330000, P_GPLL0, 6, 0, 0),
> +	F(177780000, P_GPLL0, 4.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 usb_hs_system_clk_src = {
> +	.cmd_rcgr = 0x41010,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_map,
> +	.freq_tbl = ftbl_gcc_usb_hs_system_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "usb_hs_system_clk_src",
> +		.parent_data = gcc_xo_gpll0_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb_fs_system_clk[] = {
> +	F(64000000, P_GPLL0_AUX, 12.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 usb_fs_system_clk_src = {
> +	.cmd_rcgr = 0x3f010,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0a_map,
> +	.freq_tbl = ftbl_gcc_usb_fs_system_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "usb_fs_system_clk_src",
> +		.parent_data = gcc_xo_gpll0a_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0a_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb_fs_ic_clk[] = {
> +	F(60000000, P_GPLL6_OUT_MAIN, 9, 1, 2),
> +	{ }
> +};
> +
> +static struct clk_rcg2 usb_fs_ic_clk_src = {
> +	.cmd_rcgr = 0x3f034,
> +	.hid_width = 5,
> +	.mnd_width = 8,
> +	.parent_map = gcc_xo_gpll6_out_main_map,
> +	.freq_tbl = ftbl_gcc_usb_fs_ic_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "usb_fs_ic_clk_src",
> +		.parent_data = gcc_xo_gpll6_out_main_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll6_out_main_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_venus0_vcodec0_clk[] = {
> +	F(133330000, P_GPLL0, 6, 0, 0),
> +	F(180000000, P_GPLL6, 6, 0, 0),
> +	F(228570000, P_GPLL0, 3.5, 0, 0),
> +	F(266670000, P_GPLL0, 3, 0, 0),
> +	F(308570000, P_GPLL6, 3.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 vcodec0_clk_src = {
> +	.cmd_rcgr = 0x4C000,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_gpll0_gpll6_map,
> +	.freq_tbl = ftbl_gcc_venus0_vcodec0_clk,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "vcodec0_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll6_parent_data,
> +		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll6_parent_data),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_ahb_clk = {
> +	.halt_reg = 0x01008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(10),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
> +	.halt_reg = 0x02008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x02008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup1_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup1_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
> +	.halt_reg = 0x02004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x02004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup1_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup1_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
> +	.halt_reg = 0x03010,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x03010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup2_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup2_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
> +	.halt_reg = 0x0300c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0300c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup2_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup2_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
> +	.halt_reg = 0x04020,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x04020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup3_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup3_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
> +	.halt_reg = 0x0401c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0401c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup3_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup3_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
> +	.halt_reg = 0x05020,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x05020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup4_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup4_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
> +	.halt_reg = 0x0501c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0501c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_qup4_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_qup4_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_uart1_apps_clk = {
> +	.halt_reg = 0x0203c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0203c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_uart1_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_uart1_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp1_uart2_apps_clk = {
> +	.halt_reg = 0x0302c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0302c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp1_uart2_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&blsp1_uart2_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_ahb_clk = {
> +	.halt_reg = 0x0b008,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(20),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup1_i2c_apps_clk = {
> +	.halt_reg = 0x0c008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0c008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup1_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup1_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup1_spi_apps_clk = {
> +	.halt_reg = 0x0c004,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0c004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup1_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup1_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_uart1_apps_clk = {
> +	.halt_reg = 0x0c03c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0c03c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_uart1_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_uart1_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup2_i2c_apps_clk = {
> +	.halt_reg = 0x0d010,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0d010,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup2_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup2_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup2_spi_apps_clk = {
> +	.halt_reg = 0x0d00c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0d00c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup2_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup2_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_uart2_apps_clk = {
> +	.halt_reg = 0x0d02c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0d02c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_uart2_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_uart2_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup3_i2c_apps_clk = {
> +	.halt_reg = 0x0f020,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0f020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup3_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup3_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup3_spi_apps_clk = {
> +	.halt_reg = 0x0f01c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x0f01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup3_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup3_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup4_i2c_apps_clk = {
> +	.halt_reg = 0x18020,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x18020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup4_i2c_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup4_i2c_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_blsp2_qup4_spi_apps_clk = {
> +	.halt_reg = 0x1801c,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x1801c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_blsp2_qup4_spi_apps_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&blsp2_qup4_spi_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_boot_rom_ahb_clk = {
> +	.halt_reg = 0x1300c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(7),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_boot_rom_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_cci_ahb_clk = {
> +	.halt_reg = 0x5101c,
> +	.clkr = {
> +		.enable_reg = 0x5101c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_cci_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_cci_clk = {
> +	.halt_reg = 0x51018,
> +	.clkr = {
> +		.enable_reg = 0x51018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_cci_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&cci_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0_ahb_clk = {
> +	.halt_reg = 0x4e040,
> +	.clkr = {
> +		.enable_reg = 0x4e040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0_clk = {
> +	.halt_reg = 0x4e03c,
> +	.clkr = {
> +		.enable_reg = 0x4e03c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0phy_clk = {
> +	.halt_reg = 0x4e048,
> +	.clkr = {
> +		.enable_reg = 0x4e048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0phy_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0pix_clk = {
> +	.halt_reg = 0x4e058,
> +	.clkr = {
> +		.enable_reg = 0x4e058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0pix_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0rdi_clk = {
> +	.halt_reg = 0x4e050,
> +	.clkr = {
> +		.enable_reg = 0x4e050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0rdi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1_ahb_clk = {
> +	.halt_reg = 0x4f040,
> +	.clkr = {
> +		.enable_reg = 0x4f040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1_clk = {
> +	.halt_reg = 0x4f03c,
> +	.clkr = {
> +		.enable_reg = 0x4f03c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1phy_clk = {
> +	.halt_reg = 0x4f048,
> +	.clkr = {
> +		.enable_reg = 0x4f048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1phy_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1pix_clk = {
> +	.halt_reg = 0x4f058,
> +	.clkr = {
> +		.enable_reg = 0x4f058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1pix_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1rdi_clk = {
> +	.halt_reg = 0x4f050,
> +	.clkr = {
> +		.enable_reg = 0x4f050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1rdi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi2_ahb_clk = {
> +	.halt_reg = 0x3c040,
> +	.clkr = {
> +		.enable_reg = 0x3c040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi2_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi2_clk = {
> +	.halt_reg = 0x3c03c,
> +	.clkr = {
> +		.enable_reg = 0x3c03c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi2phy_clk = {
> +	.halt_reg = 0x3c048,
> +	.clkr = {
> +		.enable_reg = 0x3c048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi2phy_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi2pix_clk = {
> +	.halt_reg = 0x3c058,
> +	.clkr = {
> +		.enable_reg = 0x3c058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi2pix_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi2rdi_clk = {
> +	.halt_reg = 0x3c050,
> +	.clkr = {
> +		.enable_reg = 0x3c050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi2rdi_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_mclk2_clk = {
> +	.halt_reg = 0x5c018,
> +	.clkr = {
> +		.enable_reg = 0x5c018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_mclk2_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&mclk2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi_vfe0_clk = {
> +	.halt_reg = 0x58050,
> +	.clkr = {
> +		.enable_reg = 0x58050,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi_vfe0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vfe0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_gp0_clk = {
> +	.halt_reg = 0x54018,
> +	.clkr = {
> +		.enable_reg = 0x54018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_gp0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_gp0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_gp1_clk = {
> +	.halt_reg = 0x55018,
> +	.clkr = {
> +		.enable_reg = 0x55018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_gp1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_gp1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_ispif_ahb_clk = {
> +	.halt_reg = 0x50004,
> +	.clkr = {
> +		.enable_reg = 0x50004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_ispif_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_jpeg0_clk = {
> +	.halt_reg = 0x57020,
> +	.clkr = {
> +		.enable_reg = 0x57020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_jpeg0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&jpeg0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_jpeg_ahb_clk = {
> +	.halt_reg = 0x57024,
> +	.clkr = {
> +		.enable_reg = 0x57024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_jpeg_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_jpeg_axi_clk = {
> +	.halt_reg = 0x57028,
> +	.clkr = {
> +		.enable_reg = 0x57028,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_jpeg_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_mclk0_clk = {
> +	.halt_reg = 0x52018,
> +	.clkr = {
> +		.enable_reg = 0x52018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_mclk0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&mclk0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_mclk1_clk = {
> +	.halt_reg = 0x53018,
> +	.clkr = {
> +		.enable_reg = 0x53018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_mclk1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&mclk1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_micro_ahb_clk = {
> +	.halt_reg = 0x5600c,
> +	.clkr = {
> +		.enable_reg = 0x5600c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_micro_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi0phytimer_clk = {
> +	.halt_reg = 0x4e01c,
> +	.clkr = {
> +		.enable_reg = 0x4e01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi0phytimer_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi0phytimer_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi1phytimer_clk = {
> +	.halt_reg = 0x4f01c,
> +	.clkr = {
> +		.enable_reg = 0x4f01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi1phytimer_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&csi1phytimer_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_ahb_clk = {
> +	.halt_reg = 0x56004,
> +	.clkr = {
> +		.enable_reg = 0x56004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_top_ahb_clk = {
> +	.halt_reg = 0x5a014,
> +	.clkr = {
> +		.enable_reg = 0x5a014,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_top_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_vfe0_ahb_clk = {
> +	.halt_reg = 0x58044,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x58044,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "gcc_camss_vfe0_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +			.flags = CLK_SET_RATE_PARENT,
> +		}
> +	}
> +};
> +
> +static struct clk_branch gcc_camss_vfe0_axi_clk = {
> +	.halt_reg = 0x58048,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x58048,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data) {
> +			.name = "gcc_camss_vfe0_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		}
> +	}
> +};
> +
> +static struct clk_branch gcc_camss_cpp_ahb_clk = {
> +	.halt_reg = 0x58040,
> +	.clkr = {
> +		.enable_reg = 0x58040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_cpp_ahb_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_cpp_clk = {
> +	.halt_reg = 0x5803c,
> +	.clkr = {
> +		.enable_reg = 0x5803c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_cpp_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&cpp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_vfe0_clk = {
> +	.halt_reg = 0x58038,
> +	.clkr = {
> +		.enable_reg = 0x58038,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_vfe0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vfe0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_cpp_axi_clk = {
> +	.halt_reg = 0x58064,
> +	.clkr = {
> +		.enable_reg = 0x58064,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_cpp_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_crypto_ahb_clk = {
> +	.halt_reg = 0x16024,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_crypto_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_crypto_axi_clk = {
> +	.halt_reg = 0x16020,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(1),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_crypto_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_crypto_clk = {
> +	.halt_reg = 0x1601c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(2),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_crypto_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&crypto_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_oxili_gmem_clk = {
> +	.halt_reg = 0x59024,
> +	.clkr = {
> +		.enable_reg = 0x59024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_oxili_gmem_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gfx3d_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp1_clk = {
> +	.halt_reg = 0x08000,
> +	.clkr = {
> +		.enable_reg = 0x08000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gp1_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gp1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp2_clk = {
> +	.halt_reg = 0x09000,
> +	.clkr = {
> +		.enable_reg = 0x09000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gp2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gp2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gp3_clk = {
> +	.halt_reg = 0x0a000,
> +	.clkr = {
> +		.enable_reg = 0x0a000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gp3_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gp3_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_ahb_clk = {
> +	.halt_reg = 0x4d07c,
> +	.clkr = {
> +		.enable_reg = 0x4d07c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_axi_clk = {
> +	.halt_reg = 0x4d080,
> +	.clkr = {
> +		.enable_reg = 0x4d080,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_byte0_clk = {
> +	.halt_reg = 0x4d094,
> +	.clkr = {
> +		.enable_reg = 0x4d094,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_byte0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&byte0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_esc0_clk = {
> +	.halt_reg = 0x4d098,
> +	.clkr = {
> +		.enable_reg = 0x4d098,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_esc0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&esc0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_mdp_clk = {
> +	.halt_reg = 0x4D088,
> +	.clkr = {
> +		.enable_reg = 0x4D088,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_mdp_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&mdp_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_pclk0_clk = {
> +	.halt_reg = 0x4d084,
> +	.clkr = {
> +		.enable_reg = 0x4d084,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_pclk0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&pclk0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdss_vsync_clk = {
> +	.halt_reg = 0x4d090,
> +	.clkr = {
> +		.enable_reg = 0x4d090,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdss_vsync_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vsync_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mss_cfg_ahb_clk = {
> +	.halt_reg = 0x49000,
> +	.clkr = {
> +		.enable_reg = 0x49000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mss_cfg_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
> +	.halt_reg = 0x49004,
> +	.clkr = {
> +		.enable_reg = 0x49004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mss_q6_bimc_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_oxili_ahb_clk = {
> +	.halt_reg = 0x59028,
> +	.clkr = {
> +		.enable_reg = 0x59028,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_oxili_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_oxili_gfx3d_clk = {
> +	.halt_reg = 0x59020,
> +	.clkr = {
> +		.enable_reg = 0x59020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_oxili_gfx3d_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&gfx3d_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_pdm2_clk = {
> +	.halt_reg = 0x4400c,
> +	.clkr = {
> +		.enable_reg = 0x4400c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_pdm2_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&pdm2_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_pdm_ahb_clk = {
> +	.halt_reg = 0x44004,
> +	.clkr = {
> +		.enable_reg = 0x44004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_pdm_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_prng_ahb_clk = {
> +	.halt_reg = 0x13004,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x45004,
> +		.enable_mask = BIT(8),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_prng_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_ahb_clk = {
> +	.halt_reg = 0x4201c,
> +	.clkr = {
> +		.enable_reg = 0x4201c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_sdcc1_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc1_apps_clk = {
> +	.halt_reg = 0x42018,
> +	.clkr = {
> +		.enable_reg = 0x42018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_sdcc1_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&sdcc1_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc2_ahb_clk = {
> +	.halt_reg = 0x4301c,
> +	.clkr = {
> +		.enable_reg = 0x4301c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_sdcc2_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_sdcc2_apps_clk = {
> +	.halt_reg = 0x43018,
> +	.clkr = {
> +		.enable_reg = 0x43018,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_sdcc2_apps_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&sdcc2_apps_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_apss_tcu_clk = {
> +	.halt_reg = 0x12018,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(1),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_apss_tcu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gfx_tcu_clk = {
> +	.halt_reg = 0x12020,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(2),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gfx_tcu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gfx_tbu_clk = {
> +	.halt_reg = 0x12010,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(3),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gfx_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_mdp_tbu_clk = {
> +	.halt_reg = 0x1201c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(4),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_mdp_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus_tbu_clk = {
> +	.halt_reg = 0x12014,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(5),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_csi_vfe1_clk = {
> +	.halt_reg = 0x58074,
> +	.clkr = {
> +		.enable_reg = 0x58074,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_csi_vfe1_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&vfe1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_vfe1_clk = {
> +	.halt_reg = 0x5805c,
> +	.clkr = {
> +		.enable_reg = 0x5805c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_vfe1_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&vfe1_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_vfe1_ahb_clk = {
> +	.halt_reg = 0x58060,
> +	.clkr = {
> +		.enable_reg = 0x58060,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_vfe1_ahb_clk",
> +			.parent_hws = (const struct clk_hw *[]){
> +				&camss_top_ahb_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_camss_vfe1_axi_clk = {
> +	.halt_reg = 0x58068,
> +	.clkr = {
> +		.enable_reg = 0x58068,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_camss_vfe1_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_vfe_tbu_clk = {
> +	.halt_reg = 0x1203c,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(9),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_vfe_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_jpeg_tbu_clk = {
> +	.halt_reg = 0x12034,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(10),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_jpeg_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_smmu_cfg_clk = {
> +	.halt_reg = 0x12038,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(12),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_smmu_cfg_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_gtcu_ahb_clk = {
> +	.halt_reg = 0x12044,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(13),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_gtcu_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_cpp_tbu_clk = {
> +	.halt_reg = 0x12040,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(14),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_cpp_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_vfe1_tbu_clk = {
> +	.halt_reg = 0x12090,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(17),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_vfe1_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_ipa_tbu_clk = {
> +	.halt_reg = 0x120a0,
> +	.halt_check = BRANCH_HALT_VOTED,
> +	.clkr = {
> +		.enable_reg = 0x4500c,
> +		.enable_mask = BIT(16),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_ipa_tbu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_bimc_gfx_clk = {
> +	.halt_reg = 0x59034,
> +	.clkr = {
> +		.enable_reg = 0x59034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_bimc_gfx_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_bimc_gpu_clk = {
> +	.halt_reg = 0x59030,
> +	.clkr = {
> +		.enable_reg = 0x59030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_bimc_gpu_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb2a_phy_sleep_clk = {
> +	.halt_reg = 0x4102c,
> +	.clkr = {
> +		.enable_reg = 0x4102c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb2a_phy_sleep_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_fs_ahb_clk = {
> +	.halt_reg = 0x3f008,
> +	.clkr = {
> +		.enable_reg = 0x3f008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_fs_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_hs_phy_cfg_ahb_clk = {
> +	.halt_reg = 0x41030,
> +	.clkr = {
> +		.enable_reg = 0x41030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_hs_phy_cfg_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_fs_ic_clk = {
> +	.halt_reg = 0x3f030,
> +	.clkr = {
> +		.enable_reg = 0x3f030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_fs_ic_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&usb_fs_ic_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_fs_system_clk = {
> +	.halt_reg = 0x3f004,
> +	.clkr = {
> +		.enable_reg = 0x3f004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_fs_system_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&usb_fs_system_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_hs_ahb_clk = {
> +	.halt_reg = 0x41008,
> +	.clkr = {
> +		.enable_reg = 0x41008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_hs_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_usb_hs_system_clk = {
> +	.halt_reg = 0x41004,
> +	.clkr = {
> +		.enable_reg = 0x41004,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_usb_hs_system_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&usb_hs_system_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus0_ahb_clk = {
> +	.halt_reg = 0x4c020,
> +	.clkr = {
> +		.enable_reg = 0x4c020,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus0_ahb_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus0_axi_clk = {
> +	.halt_reg = 0x4c024,
> +	.clkr = {
> +		.enable_reg = 0x4c024,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus0_axi_clk",
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus0_vcodec0_clk = {
> +	.halt_reg = 0x4c01c,
> +	.clkr = {
> +		.enable_reg = 0x4c01c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus0_vcodec0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vcodec0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus0_core0_vcodec0_clk = {
> +	.halt_reg = 0x4c02c,
> +	.clkr = {
> +		.enable_reg = 0x4c02c,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus0_core0_vcodec0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vcodec0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_venus0_core1_vcodec0_clk = {
> +	.halt_reg = 0x4c034,
> +	.clkr = {
> +		.enable_reg = 0x4c034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_venus0_core1_vcodec0_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&vcodec0_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_oxili_timer_clk = {
> +	.halt_reg = 0x59040,
> +	.clkr = {
> +		.enable_reg = 0x59040,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_oxili_timer_clk",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "xo",
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct gdsc venus_gdsc = {
> +	.gdscr = 0x4c018,
> +	.cxcs = (unsigned int []){ 0x4c024, 0x4c01c },
> +	.cxc_count = 2,
> +	.pd = {
> +		.name = "venus_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc mdss_gdsc = {
> +	.gdscr = 0x4d078,
> +	.cxcs = (unsigned int []){ 0x4d080, 0x4d088 },
> +	.cxc_count = 2,
> +	.pd = {
> +		.name = "mdss_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc jpeg_gdsc = {
> +	.gdscr = 0x5701c,
> +	.cxcs = (unsigned int []){ 0x57020, 0x57028 },
> +	.cxc_count = 2,
> +	.pd = {
> +		.name = "jpeg_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc vfe0_gdsc = {
> +	.gdscr = 0x58034,
> +	.cxcs = (unsigned int []){ 0x58038, 0x58048, 0x5600c, 0x58050 },
> +	.cxc_count = 4,
> +	.pd = {
> +		.name = "vfe0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc vfe1_gdsc = {
> +	.gdscr = 0x5806c,
> +	.cxcs = (unsigned int []){ 0x5805c, 0x58068, 0x5600c, 0x58074 },
> +	.cxc_count = 4,
> +	.pd = {
> +		.name = "vfe1_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc cpp_gdsc = {
> +	.gdscr = 0x58078,
> +	.cxcs = (unsigned int []){ 0x5803c, 0x58064 },
> +	.cxc_count = 2,
> +	.pd = {
> +		.name = "cpp_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc oxili_gx_gdsc = {
> +	.gdscr = 0x5901c,
> +	.cxcs = (unsigned int []){ 0x59000, 0x59024 },
> +	.cxc_count = 2,
> +	.pd = {
> +		.name = "oxili_gx_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc venus_core0_gdsc = {
> +	.gdscr = 0x4c028,
> +	.cxcs = (unsigned int []){ 0x4c02c },
> +	.cxc_count = 1,
> +	.pd = {
> +		.name = "venus_core0_gdsc",
> +	},
> +	.flags = HW_CTRL_TRIGGER,
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct gdsc venus_core1_gdsc = {
> +	.gdscr = 0x4c030,
> +	.cxcs = (unsigned int []){ 0x4c034 },
> +	.cxc_count = 1,
> +	.pd = {
> +		.name = "venus_core1_gdsc",
> +	},
> +	.flags = HW_CTRL_TRIGGER,
> +	.pwrsts = PWRSTS_OFF_ON,
> +};
> +
> +static struct clk_regmap *gcc_msm8952_clocks[] = {
> +	[GPLL0] = &gpll0.clkr,
> +	[GPLL0_VOTE] = &gpll0_vote,
> +	[CAMSS_TOP_AHB_CLK_SRC] = &camss_top_ahb_clk_src.clkr,
> +	[APSS_AHB_CLK_SRC] = &apss_ahb_clk_src.clkr,
> +	[CSI0_CLK_SRC] = &csi0_clk_src.clkr,
> +	[CSI1_CLK_SRC] = &csi1_clk_src.clkr,
> +	[CSI2_CLK_SRC] = &csi2_clk_src.clkr,
> +	[GFX3D_CLK_SRC] = &gfx3d_clk_src.clkr,
> +	[VFE0_CLK_SRC] = &vfe0_clk_src.clkr,
> +	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
> +	[BLSP1_QUP1_SPI_APPS_CLK_SRC] = &blsp1_qup1_spi_apps_clk_src.clkr,
> +	[BLSP1_QUP2_I2C_APPS_CLK_SRC] = &blsp1_qup2_i2c_apps_clk_src.clkr,
> +	[BLSP1_QUP2_SPI_APPS_CLK_SRC] = &blsp1_qup2_spi_apps_clk_src.clkr,
> +	[BLSP1_QUP3_I2C_APPS_CLK_SRC] = &blsp1_qup3_i2c_apps_clk_src.clkr,
> +	[BLSP1_QUP3_SPI_APPS_CLK_SRC] = &blsp1_qup3_spi_apps_clk_src.clkr,
> +	[BLSP1_QUP4_I2C_APPS_CLK_SRC] = &blsp1_qup4_i2c_apps_clk_src.clkr,
> +	[BLSP1_QUP4_SPI_APPS_CLK_SRC] = &blsp1_qup4_spi_apps_clk_src.clkr,
> +	[BLSP1_UART1_APPS_CLK_SRC] = &blsp1_uart1_apps_clk_src.clkr,
> +	[BLSP1_UART2_APPS_CLK_SRC] = &blsp1_uart2_apps_clk_src.clkr,
> +	[CCI_CLK_SRC] = &cci_clk_src.clkr,
> +	[CAMSS_GP0_CLK_SRC] = &camss_gp0_clk_src.clkr,
> +	[CAMSS_GP1_CLK_SRC] = &camss_gp1_clk_src.clkr,
> +	[JPEG0_CLK_SRC] = &jpeg0_clk_src.clkr,
> +	[MCLK0_CLK_SRC] = &mclk0_clk_src.clkr,
> +	[MCLK1_CLK_SRC] = &mclk1_clk_src.clkr,
> +	[CSI0PHYTIMER_CLK_SRC] = &csi0phytimer_clk_src.clkr,
> +	[CSI1PHYTIMER_CLK_SRC] = &csi1phytimer_clk_src.clkr,
> +	[CPP_CLK_SRC] = &cpp_clk_src.clkr,
> +	[CRYPTO_CLK_SRC] = &crypto_clk_src.clkr,
> +	[GP1_CLK_SRC] = &gp1_clk_src.clkr,
> +	[GP2_CLK_SRC] = &gp2_clk_src.clkr,
> +	[GP3_CLK_SRC] = &gp3_clk_src.clkr,
> +	[BYTE0_CLK_SRC] = &byte0_clk_src.clkr,
> +	[ESC0_CLK_SRC] = &esc0_clk_src.clkr,
> +	[MDP_CLK_SRC] = &mdp_clk_src.clkr,
> +	[PCLK0_CLK_SRC] = &pclk0_clk_src.clkr,
> +	[VSYNC_CLK_SRC] = &vsync_clk_src.clkr,
> +	[PDM2_CLK_SRC] = &pdm2_clk_src.clkr,
> +	[SDCC1_APPS_CLK_SRC] = &sdcc1_apps_clk_src.clkr,
> +	[SDCC2_APPS_CLK_SRC] = &sdcc2_apps_clk_src.clkr,
> +	[SDCC1_ICE_CORE_CLK_SRC] = &sdcc1_ice_core_clk_src.clkr,
> +	[USB_HS_SYSTEM_CLK_SRC] = &usb_hs_system_clk_src.clkr,
> +	[VCODEC0_CLK_SRC] = &vcodec0_clk_src.clkr,
> +	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
> +	[GCC_BLSP1_QUP1_I2C_APPS_CLK] = &gcc_blsp1_qup1_i2c_apps_clk.clkr,
> +	[GCC_BLSP1_QUP1_SPI_APPS_CLK] = &gcc_blsp1_qup1_spi_apps_clk.clkr,
> +	[GCC_BLSP1_QUP2_I2C_APPS_CLK] = &gcc_blsp1_qup2_i2c_apps_clk.clkr,
> +	[GCC_BLSP1_QUP2_SPI_APPS_CLK] = &gcc_blsp1_qup2_spi_apps_clk.clkr,
> +	[GCC_BLSP1_QUP3_I2C_APPS_CLK] = &gcc_blsp1_qup3_i2c_apps_clk.clkr,
> +	[GCC_BLSP1_QUP3_SPI_APPS_CLK] = &gcc_blsp1_qup3_spi_apps_clk.clkr,
> +	[GCC_BLSP1_QUP4_I2C_APPS_CLK] = &gcc_blsp1_qup4_i2c_apps_clk.clkr,
> +	[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
> +	[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
> +	[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
> +	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
> +	[GCC_CAMSS_CCI_AHB_CLK] = &gcc_camss_cci_ahb_clk.clkr,
> +	[GCC_CAMSS_CCI_CLK] = &gcc_camss_cci_clk.clkr,
> +	[GCC_CAMSS_CSI0_AHB_CLK] = &gcc_camss_csi0_ahb_clk.clkr,
> +	[GCC_CAMSS_CSI0_CLK] = &gcc_camss_csi0_clk.clkr,
> +	[GCC_CAMSS_CSI0PHY_CLK] = &gcc_camss_csi0phy_clk.clkr,
> +	[GCC_CAMSS_CSI0PIX_CLK] = &gcc_camss_csi0pix_clk.clkr,
> +	[GCC_CAMSS_CSI0RDI_CLK] = &gcc_camss_csi0rdi_clk.clkr,
> +	[GCC_CAMSS_CSI1_AHB_CLK] = &gcc_camss_csi1_ahb_clk.clkr,
> +	[GCC_CAMSS_CSI1_CLK] = &gcc_camss_csi1_clk.clkr,
> +	[GCC_CAMSS_CSI1PHY_CLK] = &gcc_camss_csi1phy_clk.clkr,
> +	[GCC_CAMSS_CSI1PIX_CLK] = &gcc_camss_csi1pix_clk.clkr,
> +	[GCC_CAMSS_CSI1RDI_CLK] = &gcc_camss_csi1rdi_clk.clkr,
> +	[GCC_CAMSS_CSI2_AHB_CLK] = &gcc_camss_csi2_ahb_clk.clkr,
> +	[GCC_CAMSS_CSI2_CLK] = &gcc_camss_csi2_clk.clkr,
> +	[GCC_CAMSS_CSI2PHY_CLK] = &gcc_camss_csi2phy_clk.clkr,
> +	[GCC_CAMSS_CSI2PIX_CLK] = &gcc_camss_csi2pix_clk.clkr,
> +	[GCC_CAMSS_CSI2RDI_CLK] = &gcc_camss_csi2rdi_clk.clkr,
> +	[GCC_CAMSS_CSI_VFE0_CLK] = &gcc_camss_csi_vfe0_clk.clkr,
> +	[GCC_CAMSS_GP0_CLK] = &gcc_camss_gp0_clk.clkr,
> +	[GCC_CAMSS_GP1_CLK] = &gcc_camss_gp1_clk.clkr,
> +	[GCC_CAMSS_ISPIF_AHB_CLK] = &gcc_camss_ispif_ahb_clk.clkr,
> +	[GCC_CAMSS_JPEG0_CLK] = &gcc_camss_jpeg0_clk.clkr,
> +	[GCC_CAMSS_JPEG_AHB_CLK] = &gcc_camss_jpeg_ahb_clk.clkr,
> +	[GCC_CAMSS_JPEG_AXI_CLK] = &gcc_camss_jpeg_axi_clk.clkr,
> +	[GCC_CAMSS_MCLK0_CLK] = &gcc_camss_mclk0_clk.clkr,
> +	[GCC_CAMSS_MCLK1_CLK] = &gcc_camss_mclk1_clk.clkr,
> +	[GCC_CAMSS_MICRO_AHB_CLK] = &gcc_camss_micro_ahb_clk.clkr,
> +	[GCC_CAMSS_CSI0PHYTIMER_CLK] = &gcc_camss_csi0phytimer_clk.clkr,
> +	[GCC_CAMSS_CSI1PHYTIMER_CLK] = &gcc_camss_csi1phytimer_clk.clkr,
> +	[GCC_CAMSS_AHB_CLK] = &gcc_camss_ahb_clk.clkr,
> +	[GCC_CAMSS_TOP_AHB_CLK] = &gcc_camss_top_ahb_clk.clkr,
> +	[GCC_CAMSS_VFE0_AHB_CLK] = &gcc_camss_vfe0_ahb_clk.clkr,
> +	[GCC_CAMSS_VFE0_AXI_CLK] = &gcc_camss_vfe0_axi_clk.clkr,
> +	[GCC_CAMSS_CPP_AHB_CLK] = &gcc_camss_cpp_ahb_clk.clkr,
> +	[GCC_CAMSS_CPP_CLK] = &gcc_camss_cpp_clk.clkr,
> +	[GCC_CAMSS_VFE0_CLK] = &gcc_camss_vfe0_clk.clkr,
> +	[GCC_CRYPTO_AHB_CLK] = &gcc_crypto_ahb_clk.clkr,
> +	[GCC_CRYPTO_AXI_CLK] = &gcc_crypto_axi_clk.clkr,
> +	[GCC_CRYPTO_CLK] = &gcc_crypto_clk.clkr,
> +	[GCC_OXILI_GMEM_CLK] = &gcc_oxili_gmem_clk.clkr,
> +	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
> +	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
> +	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
> +	[GCC_MDSS_AHB_CLK] = &gcc_mdss_ahb_clk.clkr,
> +	[GCC_MDSS_AXI_CLK] = &gcc_mdss_axi_clk.clkr,
> +	[GCC_MDSS_BYTE0_CLK] = &gcc_mdss_byte0_clk.clkr,
> +	[GCC_MDSS_ESC0_CLK] = &gcc_mdss_esc0_clk.clkr,
> +	[GCC_MDSS_MDP_CLK] = &gcc_mdss_mdp_clk.clkr,
> +	[GCC_MDSS_PCLK0_CLK] = &gcc_mdss_pclk0_clk.clkr,
> +	[GCC_MDSS_VSYNC_CLK] = &gcc_mdss_vsync_clk.clkr,
> +	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
> +	[GCC_OXILI_AHB_CLK] = &gcc_oxili_ahb_clk.clkr,
> +	[GCC_OXILI_GFX3D_CLK] = &gcc_oxili_gfx3d_clk.clkr,
> +	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
> +	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
> +	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
> +	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
> +	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
> +	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
> +	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
> +	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
> +	[GCC_GTCU_AHB_CLK] = &gcc_gtcu_ahb_clk.clkr,
> +	[GCC_JPEG_TBU_CLK] = &gcc_jpeg_tbu_clk.clkr,
> +	[GCC_MDP_TBU_CLK] = &gcc_mdp_tbu_clk.clkr,
> +	[GCC_SMMU_CFG_CLK] = &gcc_smmu_cfg_clk.clkr,
> +	[GCC_VENUS_TBU_CLK] = &gcc_venus_tbu_clk.clkr,
> +	[GCC_VFE_TBU_CLK] = &gcc_vfe_tbu_clk.clkr,
> +	[GCC_USB2A_PHY_SLEEP_CLK] = &gcc_usb2a_phy_sleep_clk.clkr,
> +	[GCC_USB_HS_AHB_CLK] = &gcc_usb_hs_ahb_clk.clkr,
> +	[GCC_USB_HS_SYSTEM_CLK] = &gcc_usb_hs_system_clk.clkr,
> +	[GCC_VENUS0_AHB_CLK] = &gcc_venus0_ahb_clk.clkr,
> +	[GCC_VENUS0_AXI_CLK] = &gcc_venus0_axi_clk.clkr,
> +	[GCC_VENUS0_VCODEC0_CLK] = &gcc_venus0_vcodec0_clk.clkr,
> +	[GCC_APSS_TCU_CLK] = &gcc_apss_tcu_clk.clkr,
> +	[GCC_GFX_TCU_CLK] = &gcc_gfx_tcu_clk.clkr,
> +	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
> +	[GCC_BIMC_GPU_CLK] = &gcc_bimc_gpu_clk.clkr,
> +	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
> +	[GPLL3] = &gpll3.clkr,
> +	[GPLL3_EARLY] = &gpll3_early.clkr,
> +	[GPLL4] = &gpll4.clkr,
> +	[GPLL4_VOTE] = &gpll4_vote,
> +	[GPLL6] = &gpll6.clkr,
> +	[GPLL6_VOTE] = &gpll6_vote,
> +	[GCC_GFX_TBU_CLK] = &gcc_gfx_tbu_clk.clkr,
> +	[GCC_CPP_TBU_CLK] = &gcc_cpp_tbu_clk.clkr,
> +	[USB_FS_SYSTEM_CLK_SRC] = &usb_fs_system_clk_src.clkr,
> +	[USB_FS_IC_CLK_SRC] = &usb_fs_ic_clk_src.clkr,
> +	[GCC_USB_FS_AHB_CLK] = &gcc_usb_fs_ahb_clk.clkr,
> +	[GCC_USB_HS_PHY_CFG_AHB_CLK] = &gcc_usb_hs_phy_cfg_ahb_clk.clkr,
> +	[GCC_USB_FS_IC_CLK] = &gcc_usb_fs_ic_clk.clkr,
> +	[GCC_USB_FS_SYSTEM_CLK] = &gcc_usb_fs_system_clk.clkr,
> +	[GCC_VENUS0_CORE0_VCODEC0_CLK] = &gcc_venus0_core0_vcodec0_clk.clkr,
> +	[GCC_VENUS0_CORE1_VCODEC0_CLK] = &gcc_venus0_core1_vcodec0_clk.clkr,
> +	[GCC_OXILI_TIMER_CLK] = &gcc_oxili_timer_clk.clkr,
> +	[BLSP2_QUP1_I2C_APPS_CLK_SRC] = &blsp2_qup1_i2c_apps_clk_src.clkr,
> +	[BLSP2_QUP1_SPI_APPS_CLK_SRC] = &blsp2_qup1_spi_apps_clk_src.clkr,
> +	[BLSP2_QUP2_I2C_APPS_CLK_SRC] = &blsp2_qup2_i2c_apps_clk_src.clkr,
> +	[BLSP2_QUP2_SPI_APPS_CLK_SRC] = &blsp2_qup2_spi_apps_clk_src.clkr,
> +	[BLSP2_QUP3_I2C_APPS_CLK_SRC] = &blsp2_qup3_i2c_apps_clk_src.clkr,
> +	[BLSP2_QUP3_SPI_APPS_CLK_SRC] = &blsp2_qup3_spi_apps_clk_src.clkr,
> +	[BLSP2_QUP4_I2C_APPS_CLK_SRC] = &blsp2_qup4_i2c_apps_clk_src.clkr,
> +	[BLSP2_QUP4_SPI_APPS_CLK_SRC] = &blsp2_qup4_spi_apps_clk_src.clkr,
> +	[BLSP2_UART1_APPS_CLK_SRC]    = &blsp2_uart1_apps_clk_src.clkr,
> +	[BLSP2_UART2_APPS_CLK_SRC]    = &blsp2_uart2_apps_clk_src.clkr,
> +	[GCC_BLSP2_AHB_CLK]           = &gcc_blsp2_ahb_clk.clkr,
> +	[GCC_BLSP2_QUP1_I2C_APPS_CLK] = &gcc_blsp2_qup1_i2c_apps_clk.clkr,
> +	[GCC_BLSP2_QUP1_SPI_APPS_CLK] = &gcc_blsp2_qup1_spi_apps_clk.clkr,
> +	[GCC_BLSP2_QUP2_I2C_APPS_CLK] = &gcc_blsp2_qup2_i2c_apps_clk.clkr,
> +	[GCC_BLSP2_QUP2_SPI_APPS_CLK] = &gcc_blsp2_qup2_spi_apps_clk.clkr,
> +	[GCC_BLSP2_QUP3_I2C_APPS_CLK] = &gcc_blsp2_qup3_i2c_apps_clk.clkr,
> +	[GCC_BLSP2_QUP3_SPI_APPS_CLK] = &gcc_blsp2_qup3_spi_apps_clk.clkr,
> +	[GCC_BLSP2_QUP4_I2C_APPS_CLK] = &gcc_blsp2_qup4_i2c_apps_clk.clkr,
> +	[GCC_BLSP2_QUP4_SPI_APPS_CLK] = &gcc_blsp2_qup4_spi_apps_clk.clkr,
> +	[GCC_BLSP2_UART1_APPS_CLK]    = &gcc_blsp2_uart1_apps_clk.clkr,
> +	[GCC_BLSP2_UART2_APPS_CLK]    = &gcc_blsp2_uart2_apps_clk.clkr,
> +	[VFE1_CLK_SRC]                 = &vfe1_clk_src.clkr,
> +	[GCC_CAMSS_VFE1_CLK]           = &gcc_camss_vfe1_clk.clkr,
> +	[GCC_CAMSS_VFE1_AHB_CLK]       = &gcc_camss_vfe1_ahb_clk.clkr,
> +	[GCC_CAMSS_VFE1_AXI_CLK]       = &gcc_camss_vfe1_axi_clk.clkr,
> +	[GCC_CAMSS_CSI_VFE1_CLK]       = &gcc_camss_csi_vfe1_clk.clkr,
> +	[MCLK2_CLK_SRC]                = &mclk2_clk_src.clkr,
> +	[GCC_CAMSS_MCLK2_CLK]          = &gcc_camss_mclk2_clk.clkr,
> +	[GCC_VFE1_TBU_CLK]             = &gcc_vfe1_tbu_clk.clkr,
> +	[GCC_IPA_TBU_CLK]              = &gcc_ipa_tbu_clk.clkr,
> +	[GCC_CAMSS_CPP_AXI_CLK]        = &gcc_camss_cpp_axi_clk.clkr,
> +};
> +
> +static struct gdsc *gcc_msm8952_gdscs[] = {
> +	[CPP_GDSC] = &cpp_gdsc,
> +	[VENUS_GDSC] = &venus_gdsc,
> +	[MDSS_GDSC] = &mdss_gdsc,
> +	[JPEG_GDSC] = &jpeg_gdsc,
> +	[VFE0_GDSC] = &vfe0_gdsc,
> +	[VFE1_GDSC] = &vfe1_gdsc,
> +	[OXILI_GX_GDSC] = &oxili_gx_gdsc,
> +	[VENUS_CORE0_GDSC] = &venus_core0_gdsc,
> +	[VENUS_CORE1_GDSC] = &venus_core1_gdsc,
> +};
> +
> +static const struct qcom_reset_map gcc_msm8952_resets[] = {
> +	[RST_CAMSS_MICRO_BCR]		= { 0x56008 },
> +	[RST_USB_HS_BCR]		= { 0x41000 },
> +	[RST_QUSB2_PHY_BCR]		= { 0x4103c },
> +	[RST_USB_HS_PHY_CFG_AHB_CBCR]	= { 0x41030 },
> +	[RST_USB2_HS_PHY_ONLY_BCR]	= { 0x41034 },
> +	[RST_USB_FS_BCR]		= { 0x3f000 },
> +	[RST_CAMSS_CSI1PIX_CBCR]	= { 0x4f058 },
> +	[RST_CAMSS_CSI_VFE1_CBCR]	= { 0x58074 },
> +	[RST_CAMSS_VFE1_CBCR]		= { 0x5805c },
> +	[RST_CAMSS_CPP_CBCR]		= { 0x5803c },
> +	[RST_MSS_BCR]			= { 0x71000 },
> +	[RST_MDSS_BCR]			= { 0x4d074 },
> +};
> +
> +static const struct regmap_config gcc_msm8952_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +	.max_register	= 0x80000,
> +	.fast_io	= true,
> +};
> +
> +static const struct qcom_cc_desc gcc_msm8952_desc = {
> +	.config = &gcc_msm8952_regmap_config,
> +	.clks = gcc_msm8952_clocks,
> +	.num_clks = ARRAY_SIZE(gcc_msm8952_clocks),
> +	.resets = gcc_msm8952_resets,
> +	.num_resets = ARRAY_SIZE(gcc_msm8952_resets),
> +	.gdscs = gcc_msm8952_gdscs,
> +	.num_gdscs = ARRAY_SIZE(gcc_msm8952_gdscs),
> +};
> +
> +static const struct of_device_id gcc_msm8952_match_table[] = {
> +	{ .compatible = "qcom,gcc-msm8952" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gcc_msm8952_match_table);
> +
> +static int gcc_msm8952_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gcc_msm8952_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Set Sleep and Wakeup cycles to 0 for GMEM clock */
> +	ret = regmap_update_bits(regmap, gcc_oxili_gmem_clk.clkr.enable_reg, 0xff0, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable GMEM HW Dynamic, Without this write, GMEM can't get enabled */
> +	ret = regmap_write(regmap, 0x7E004, 0x1);
> +	if (ret)
> +		return ret;
> +
> +	clk_alpha_pll_configure(&gpll3_early, regmap, &gpll3_early_config);

Use driver_data to handle the PLL configuration and the above writes.

> +
> +	return qcom_cc_really_probe(&pdev->dev, &gcc_msm8952_desc, regmap);
> +}
> +
> +static struct platform_driver gcc_msm8952_driver = {
> +	.probe		= gcc_msm8952_probe,
> +	.driver		= {
> +		.name	= "gcc-msm8952",
> +		.of_match_table = gcc_msm8952_match_table,
> +	},
> +};
> +
> +static int __init gcc_msm8952_init(void)
> +{
> +	return platform_driver_register(&gcc_msm8952_driver);
> +}
> +core_initcall(gcc_msm8952_init);
> +
> +static void __exit gcc_msm8952_exit(void)
> +{
> +	platform_driver_unregister(&gcc_msm8952_driver);
> +}
> +module_exit(gcc_msm8952_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm GCC MSM8952 Driver");
> +MODULE_LICENSE("GPL");
> 

-- 
Thanks,
Taniya Das

