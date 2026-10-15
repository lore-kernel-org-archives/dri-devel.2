Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD2FCC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF2710EB62;
	Thu, 15 Oct 2026 09:05:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E337B10EB62
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:05:34 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F7Y9M41672215
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6KhkIKXiGFzfMiy8Pf33B+AzaUwHeRu9kWddJRO8RNo=; b=bYM7+4SUef/10euO
 qfESKJxdw4GfDaurbPkcnInLrnnyUK7BSmh98VPX1069ENitHq/kMWsCK3klIoiI
 1Pgp/5/juUwpHaEE2+wzfBkinHkQrP4rEmmTztfL0WrEkuq+PEEJ33NQWytHg3tL
 TKu+4sfoZPvZ/ZzXxKhIXBQ0FC4sUf7CDe1ekeZMPjSlxraVuxn1aYevbVp0NubF
 h4rki04hVozj0bjigBOfwGX/IeFEO5dNcyVc0S0x6vMW7Bhzo9PS1JBdPPWc0hjA
 NKuXP3VOSqEgKLU3bFY6bPlgybiCSVQtHLn0y6p3tSknx8rwePuwFxb7UkzqWA6X
 2ovesQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrhbjkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:05:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-535d44e2c23so8881901cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792055133; x=1792659933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6KhkIKXiGFzfMiy8Pf33B+AzaUwHeRu9kWddJRO8RNo=;
 b=OZoNgBXCH3aYUT1WgMfZOkFfTognRMmko0xcY3MrE0Xg6Spo5MT5yvhKF0xqE2QKwh
 U+lnyncEY19woZrR8+2WKOb9cPSaf1NUh6CRumjN4UWGaU1tTz5dy0nZeEqld8vwRliR
 iEYm+JIf1yNQVOloocAmJirbS/8WIm1jrBNY8FoEPynZNkooBZ4L5eODdjwTDWiJqFAA
 lwswcyALViVzh009NfRAvxxBzCcgVUaRMvfTCVcuZ3vibGnICCJ5v2F5KZs8uBHMFAA/
 6UXZQQph3psvZqR/AnGE3WQABI8Nsiid6SuBF8oZToi4mde9cSWhmWu6a9StkF/h1d/i
 6JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792055133; x=1792659933;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6KhkIKXiGFzfMiy8Pf33B+AzaUwHeRu9kWddJRO8RNo=;
 b=RwgDCTamOJJI47fI4kmHVR7QgUcyKiUf3ZM0GiiS4dnKgvcRmTcJQhJ53BOqEl+n6o
 joWX+VMXeeXxV888GOKPOIw1nfU3ithwDNcJtSR2IfVw9WguSZnChJ99kVcz/eRakZwe
 m72T27sB03zNvtWdqqHRlKbTCfaGMbGK/r7ki7Mwt3bpVhQf4udOzIBgutzuOrum0+Pu
 ID+Q2Y6BiMqK9djjd9VQpxUUxg5bTn/ii9bIpPQJRx0U4IotOi3skQDKFM1mw/DwkzI1
 NNkUlIGQOTpOebKHmi6fYD7q+CD8G62Pf+byje71myK68QlRda7zf9Y16/SPmTmfzmev
 p4Sw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw19LfoigI35oz4jx1TWQpdFcVTjUqDKvCnGzRX59RaediK2bk0PfzW47ox5zVFBwJOFFbraCiOSLc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLZE/EaALXPdrcn/qHhnBi2HrYAjhErrWdG246buR38aSEObFtd
 7H3S3APIcxdj3yko36LYeWS0NOfGazc1GMCGmSZU32CVhSJTeekVaDoeSICFrcoiDzkpfi2VVvP
 lBAVsD8l8kzahJqsE2MRbcaVSwK6KSBFhtGbCjcaQuAulP3/VDLdMe3Sisvj8SDSyqIQB2W0=
X-Gm-Gg: AYBFou3WlBjoDWUgTKGuIzHfhDP/mMdoFxKSMzcikhdzCzb1QN4ZmSLypfalHKOgZUv
 GbRneI725901IyvZQeU/U8i58wM26vqss7/iYJrsabYYiR9pfRP2A9u1zg8jOxyopHZ2UdAVuzP
 IJcqonQKoOL5aeDQskR7TguAzuQmSjiVEvgVXaB7HfsmKtgg9ORA6quqPBZhbc3CTg8b279PM2w
 VdCdH2EwKSR1+jH3yzLoiKHnAPon/mOda9r606lGDPoO2Nge/WrMpxPoTdUYRuSaK65y1CePG0i
 WdomzSlnD3BMLIx7vALq/scOcFANfaowleeeNXPlTHEILqcff0kRmLsTUipCl01MDl3KKrFmyRl
 b11OTbgmQY4IU0Q6K119fjQ==
X-Received: by 2002:ac8:7f53:0:b0:533:9739:f400 with SMTP id
 d75a77b69052e-5359fe05967mr342348301cf.5.1792055133129; 
 Thu, 15 Oct 2026 02:05:33 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:533:9739:f400 with SMTP id
 d75a77b69052e-5359fe05967mr342347921cf.5.1792055132437; 
 Thu, 15 Oct 2026 02:05:32 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3f063cec41sm83079566b.16.2026.10.15.02.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 02:05:30 -0700 (PDT)
Message-ID: <31afc73d-590e-4b15-9e70-0f577e02f448@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:05:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: add device tree for SDM845-HDK
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
 <20261015-sdm845-hdk-v4-4-b532b9f4029c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v4-4-b532b9f4029c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zudoQItcqwhBA0LI1Aj2bAXjb8SMRgon
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfX/n+fYUZ4B726
 4JpEPgrFqvzVpQm+mL5NuWNQRsdY6UIvEepC1zp9QoQPoZUVtYRrnuMCvsP3iO17e0i4vi9Ngq6
 qgLF45sTY0yPc6rI8Jj5LJfh8cUnHss=
X-Proofpoint-GUID: zudoQItcqwhBA0LI1Aj2bAXjb8SMRgon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNiBTYWx0ZWRfXzUtzQZwuUHJU
 E81b7emgpHokZadOmRZIviKIV2uYVXTWlUD4weUIL4m9s5eA3GKIMlJQsZJxCSKzqLQfMuc2Ghk
 Hi+qydXogFzS3uUbwiDIRQr3LM8ci3F/D74HlFNBVdnDL9UToXvfI0V9vOJAmUpoR3F93OFcdpk
 1UP6NobZHrMZ2j7bxshEaRDlTbrAJ5H6KnZ4wlNhJUxW99aq7Rvj+5ALiO/16f0FdeJvd9il6OW
 fwe2D9sGEOVeU9Il2GyxO3lP3JcaJlAE0SK2ZrzKHEiPY+QlmLtrWUaHBgRP1WJItKyIIDPSxqM
 oQdbyFOldvCH0thzrl+TPEFeWIURFPxXfRmQCWfXvUAEhp6hvTGbaVGK/+zZ45OFbW0IGWQ9Y8H
 w3FXp/RfEsYdqH5ylybQfxArFTBeuHP28Ix1MfhsFPQ5QYKJRc9UvhFE7U8h6JqAWZS0QB6QTu6
 EULSaltKS8++CY+RNfA==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6ad0975e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=oI7WG5CdvwguPHJV7y0A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150036
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

On 10/15/26 10:39 AM, Dmitry Baryshkov wrote:
> Add device tree for the Qualcomm / Lantronix SDM845 HDK. It is the
> development platform using the modem-less (SDA845) SoC, optional onboard
> DSI panel and a rich set of connectors.

[...]

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&home_pin_a>, <&vol_up_pin_a>;

property-n
property-names

please

[...]

> +&cluster_sleep_0 {
> +	/* default, 0x4100c244, kills the board */
> +	arm,psci-suspend-param = <0x41008244>;
> +};

Really?

[...]

> +&mdss_dsi0 {
> +	status = "okay";

status last, with a \n before it, please

[...]

> +&pmi8998_wled {
> +	status = "disabled";
> +};

Is there a problem with leaving it as-is?


[...]

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, /* SPI (eSE - embedded Secure Element) */
> +			       <81 4>; /* SPI (fingerprint reader) */
> +
> +	lt9611_irq_pin: lt9611-irq-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		bias-disable;
> +	};

Sort by pin #, please

[...]

> +&venus {
> +	status = "okay";

firmware-name, please

otherwise generally lg

Konrad
