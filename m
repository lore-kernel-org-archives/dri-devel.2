Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE52FC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0402E10EBF7;
	Mon, 14 Sep 2026 08:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJZnmSpS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZNB91WUS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B93210EBF7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:13:35 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E5jHwc064030
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VpOzWkUmj0fptxU1puX959kqq/TzTpUukH/T/db+xlE=; b=nJZnmSpSvtT4gSHS
 xm0c6XJ6eE1AmyI2cjT0LUjoiImQJZgXIJNmvUK28lECnEgv8xdNZ4TF+eeLLyb1
 3nj6nMWjyic+0+R74dM41nKTSwAQEn9o0uHWgP5V7vdrAcw6o/25brn/wh9qCOpd
 5la3Yy0A21zaWW4dVgobUo4/xVzrLpSx0C4/fkAh3CybB/NZnhIM/ZC2/j1uhgLQ
 eJ3nqC4NDLckKNvunwPEwAe7xQ9sxyMN46O1e2SVqioGCjksomGU1GeRkQ9eRr00
 NfD6ps3y/ifbl79PyUggx5KytbwsskQb66y8mQD4I2CSHG7eY4Y5zmNehcE/Q5Li
 uyM18w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnqs6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:13:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9375d92d0caso37492085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789373609; x=1789978409;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VpOzWkUmj0fptxU1puX959kqq/TzTpUukH/T/db+xlE=;
 b=ZNB91WUS7LKfYPYOR/wxYo5G9v0mIhl9rugEt2KG7IPrwUwPDkQUP9oUIJmbkaG3ne
 7XsQ8l4G0PXNDdo3Spcv9JrIm6StI0MQ6vBla0/jR1fnSkK0HHS4aPEJBX+grBWM/Lgq
 m3NaKHuVTTopbCYI5jyeUcia3hW3+vUCNy5qu4aKWPq/sJeNwbNQgQ8KCUYQtxM29Z+r
 YQBFoIOLby+ZeOcK+7MvLi2DA/L8+XZMgegVvJYgayTB3LYbcxHpUYAuazhebp9ga0kC
 gz9QkQZKLYPWALHkNACLz03mVQpYlzpNROfe6uy27kJ7G6I4fWM13s+enTxePsAGodIE
 2jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373609; x=1789978409;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpOzWkUmj0fptxU1puX959kqq/TzTpUukH/T/db+xlE=;
 b=bqltYg3zZsFwxYLrSr8p4BYlCDZLxEvqhJyjOI/rDOUDeObgnq3DtnIo/YNIPSbPnz
 IvuoOPoUDAPdrmXitS6WEZeHortHhEcMDhlXbIOkJ9bX5rj8iPIgDSmgofGx1+KeBesJ
 TTtdO0Q0E1ntRxb9FI1Mw2A/MkOhxoYpGBEuGcVUgdSAbbAslxQn32a6YF0IHsvBkPb6
 gqvbRXG2AB+XTzwNQKSxSu4X7oncPgqzilHGojpfR/5uCArbgMEMKby3+Ka74EdpbhPJ
 PO/wImfX6kRIwplyXnojRn4kCWaXk3V8tRgnyog0saMeBCQ8bgehooYZDWvN3AiPPf6M
 xmwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbopY4IzEqaljL1Ecqh0wk2YVyxdmZ/AdSungmsxTWjvm2s8pr2tHNuU3hGB3mFyZbFTCecpyZsDo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kp9O5X4+U7Ry5cRQXal+b0i1rL5hcuBvGchOQW9FNMWoXuPXk3
 V8a77wfGu8AaUFnQWI35ccRATXMM3yAZtGH5jkX1ds7ZEHUIedaE2IfkxQ0u3uwUAgX9Bv5YT/5
 0mpHyG0/dL+rdeUBPqLlcExX8EBIrv3ux1iH4MY4/TXssvVUF+fIU07akZnfkp9mBYFP2pfE=
X-Gm-Gg: AYBFou2a0iAi8Dgb2hGQz/C8geyHu3sF8bX5azXEbT7Gu1QW1/vtH9IEp7tDDwXg/fn
 tvar1/nyhqnKADSwCsnVr60VqTQyvqLcIW6uaocEntk1FJJdBISFWgyPlljwwSnmPqBQ4H2nM26
 zurzmX1NCORlca8R7QtJ005LbduEAxnI7CgilYzSCR27hibPMjKxBYzvHOOGHpRR1177IYh4MaG
 Gh03cwbjvcGs7lSOcBuWjyFJbvdWSOezwoOQg24VkeyuqMngBptMElx2C0Z0sHZkKShHLw3Dmy+
 T4IaK53HOXzjq3moOwnSKAfawpx26TEw/ixxTH1Ders21nNt7mK0GgbfjLK9RtTq+RtOBZV9PPQ
 CJ/Bf2oOhNW2LjyKR2xUUtQ==
X-Received: by 2002:a05:620a:1a07:b0:939:48e9:51a1 with SMTP id
 af79cd13be357-93a2985be2fmr175417685a.2.1789373608730; 
 Mon, 14 Sep 2026 01:13:28 -0700 (PDT)
X-Received: by 2002:a05:620a:1a07:b0:939:48e9:51a1 with SMTP id
 af79cd13be357-93a2985be2fmr175415285a.2.1789373608222; 
 Mon, 14 Sep 2026 01:13:28 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9bc808adfsm3661441a12.4.2026.09.14.01.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:13:27 -0700 (PDT)
Message-ID: <cbc69211-0b2e-43d2-b8d2-647a9cfd2f72@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 10:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add Lenovo ThinkPad T14s Gen 7
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260913201835.250085-4-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExNSBTYWx0ZWRfX2YAKZKI0jWM0
 rsue/fDcxR3co8yzUQ3PVlaV8isLx24cBvjlc5/e/tHVT5CBVbrIiosmDgFfuuZVowa5RLIWo04
 cj4/VjnuRE3A3EJTTGIMRAyjLU83TFbgZedgYiariqjcI7Zcac3yowlh2Z/gzPSmoGv6kJ1RYm6
 i1MvNeAOlbIf4yDLzQysX+5aZo4zUaoTfU8yYybE5PKz57PeviRZvQpRM50RU2UyexFz0+0l39I
 VNJ+n8zjOGM4Wx3l4ywKmL9vYYmUYRyVBqhy1u+0Jn1lH/KxqGDFdOtZz7WdHkEMrfcEqPSi4sa
 co6m+k77JXC0ML+QLserFF7VStdFWTOm0gNVhN9PCBlxTnvFIQJXAnL/2gP/SOavAizWC9RJkGL
 CnnFBsWDCnWcUve43Wrba72upKiRVKgbyB3MdBoRZI1cpq+7DAQ5K+aVnoW4lqSuPrjRXtPwInO
 2joiMgECubAaXyPx4vg==
X-Proofpoint-ORIG-GUID: 3kq_NgtLxl0RLNEKJRzrjuP_ZVyP6M6t
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExNSBTYWx0ZWRfX6eaw9Xurtxob
 nX6Sq0lhjlXoFh/5TlAuT5sCOZBTcHSF/svuCJ20KM9t05ZIJ3Tj/aBt8WC66w0R9h4e5lHStCT
 Y0hPgDOtbCIqq0fPIXHraRJBXGIiGcI=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa7acae cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=2i8abOnZ9zkVdpuz0iAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 3kq_NgtLxl0RLNEKJRzrjuP_ZVyP6M6t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140115
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

On 9/13/26 10:18 PM, Srinivas Kandagatla wrote:
> Introduce a device tree for the Mahua-based Lenovo ThinkPad T14s Gen 7,
> a Snapdragon X2 Elite laptop.  It follows the Qualcomm Glymur reference
> design used by mahua-crd.

[...]

> +	vreg_edp_3p3: regulator-edp-3p3 {

nit: please sort the regulator nodes based on their names

[...]

> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x10000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
> +
> +	sound {

Stray double \n above

[...]

> +		vreg_l18b_e0_1p2: ldo18 {
> +			regulator-name = "vreg_l18b_e0_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-always-on;
> +		};

xxx

[...]

> +&i2c5 {
> +	clock-frequency = <400000>;
> +
> +	status = "okay";
> +
> +	/* eUSB2 redriver for USB Type-A ports on the MultiPort controller */

nit: this comment seems self-explanatory

[...]

> +/* Internal eDP panel */

Likewise, it says so a couple lines below


[...]

> +&remoteproc_soccp {
> +	status = "okay";
> +};

This is always enabled

[...]


> +/* Two internal USB Type-A ports through the MultiPort host controller */

I think the right thing to describe here is what they connect to

lg otherwise

Konrad
