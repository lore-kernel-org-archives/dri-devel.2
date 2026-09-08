Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ABFC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBAD10EBDE;
	Tue,  8 Sep 2026 13:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYj0hJom";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WUkJn8Gs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63ABD10EBF3
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:19:09 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Ckvto3844377
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 13:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7+HRkriuVzWqqqsg8EA57IGDloRqI/G0+65px0QRHcc=; b=kYj0hJomTc8vS9pd
 acc79svyiqXIqmKuKOKq7HqPOsiLMxuEGgRC+qr/OJvzAik0ajJGDVZdNXQ+W91G
 wlk3EmOsxqCG+vRvsrjMxvDrMEqULUo3r9/TVGVhu/HtAPalh9e9OJQCZWIqpgJG
 4h//LoPWuLO1ASAgcvqNuqGltixZIF3uxHQoxqkganVxixLI3zRjNAek8ljOXRmp
 awqgiOqwWBXqTA9Diz7hvHiFU8rHBasLhmkKQ5r80IkTTrRuTWSjj7mO91T2F+UY
 lrYH9RcDUuquAh8AIXD191FgI0WCJf7SYpfYHH9ULa0c3NNonFysNduJAY7o+lIg
 ZHD1HA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjg8xrqs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 13:19:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93771aa0379so889080385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788873548; x=1789478348;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7+HRkriuVzWqqqsg8EA57IGDloRqI/G0+65px0QRHcc=;
 b=WUkJn8Gs1gNgfMDfoSe7VVm5UMLEbBNn/6bvc/n/xViv1LMLIjZhrkD+tqGSFgDgJk
 5Pm0hgHK6R8hGJBP5oC4naTMoTNham+vzvCU46Y/3fEHVO+xq8/TfcyzBxqy7ISG2Y+q
 1TC6Z/mM9xJ9UxuiQnpzZvx8ewmW49zi5v13sffAcl/hg5oEiePKDQ4j+MzKWW/2lJ4K
 3NUklEKgRbZ3d0MJGbLJyAlrFAJyk8wvQQCig+dO3jT+2YeCV7YNm7r5F6p3+ii5Z3EL
 QB3X8gF3dAtfMQTFzQ+47Bg8DkqlIDJwMtcfDluHLoAcUunkBJ2jZkBUJht7a+wou94v
 T3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873548; x=1789478348;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7+HRkriuVzWqqqsg8EA57IGDloRqI/G0+65px0QRHcc=;
 b=KpzIIWQ1rfU0+B4Gxc3rgRO1o+fA0j4k9YukRMbbf00PDgfFeRszBYA4wOMi7vw6pI
 IGX65xtnmhcrwKLfylmGmVHIgh+5aVaBHIg12iS17jJmXcRoSoORdeX/XZvtrg5ETsnK
 JoXxrFOyNiUffHFiQkGc1kzDSQFUCJi4U9pYeaCSzEEQUuNaRmKtZtiets5SSrpEdjn4
 xLHNwOFyYXLL6XopsfFPI73EGeD31dF8nnREn9bgtwZPosl9izy1jjNKhvPeMby5K1wU
 bC4QNhSK4AB5WlTz0803SQQvEDskZzvEyQ9aohNEzrhZFy7OT37geelbemu8Zpb88Fqn
 +4FQ==
X-Gm-Message-State: AFuF++lnAHvu5AWuzJKzVBsQPJ7LbbhnwWFtFAyAgXlNN9EhKJyQMeL3
 vwElcDQ2XixmHe0S9MWEO9m3xpHlf9uJ0XCCNF9Wd+Z1PG/Hf+EmTkZKSp5Si2L6C02ihHzax6T
 27LAKttX+jitLvOpJ8qjxyrui3c2v2fveiqU7/rGG1Fktmy3OXVj9i7Df4cFM67Tuq/cH9E8=
X-Gm-Gg: AYBFou3mfQEdP86AaB8BOEs2a4zBabZgtpC4qiMuXOjwF0dBQH1ZHFzedBH7Y0AHwPe
 qfrwAEJ9HTgJDIsRxNs2U/Q13RIW7b+IlJ/ovZwn4je8P2IVMPtSoP/J3e/XydgDE9b5vW/cJCw
 b5S3cb/ZCRanIlIb+O8vw4b07Gyt9i7s63vNd5gvnGf0bxOtA1lQuOpH91LWgrrYzlB/hZ+cR9H
 DroTdueRBZcL4XAzIEizcU4U9bNjyXW9tDEo+CP9kXntYOfZrxyzoxdx8f1PjvAg/Z89qWhR0EO
 soyJ6xKzdBu1To9TXgFHD8PLdSAw3MTLcO8wacrFUqzw7lZaUDh4+69ePEx7221gc0J0KjNpzgv
 S3D/6fFYhsRnw0SmTTf2HdFzWAs2v
X-Received: by 2002:a05:620a:17a4:b0:939:6de6:9517 with SMTP id
 af79cd13be357-9398049f91emr3268240785a.46.1788873547560; 
 Tue, 08 Sep 2026 06:19:07 -0700 (PDT)
X-Received: by 2002:a05:620a:17a4:b0:939:6de6:9517 with SMTP id
 af79cd13be357-9398049f91emr3268232985a.46.1788873546917; 
 Tue, 08 Sep 2026 06:19:06 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm335727855e9.3.2026.09.08.06.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 06:19:05 -0700 (PDT)
Message-ID: <771390d1-b7c9-4c13-8849-c71a922825f8@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 10/12] drm/msm/hdmi_phy_eliza: Add
 support for Synopsys-based HDMI phy on Eliza
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 robh@kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, vkoul@kernel.org,
 conor+dt@kernel.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-10-67843277de17@oss.qualcomm.com>
 <20260828141923.8E5F81F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828141923.8E5F81F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J7GaKgnS c=1 sm=1 tr=0 ts=6aa00b4c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rwc4GHvP-eKwHY9TLAEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: IdwSxDHEV22ER6LystIzPayZHAHy5sAe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE0MiBTYWx0ZWRfX3QT7TxbwMRc3
 fzkKthxWGuriqT0zMzXlMpEFN4e3qGpZKbUVOGD2Q0UPThmTDZ2llBPzsJLEK0W3mPx2s4rglz0
 0ZFRGkR+2HBYctV05MKDm8eeEiDf0W20U/N1PuHeN62UKAoamRhiGqovAgMNhophsk/RqGTgVTt
 CDCZKFxG7sBOx9DJ/bdVLgctvlXJswu31QkGU0+X44A9Ubhs40STCEf7RPBhnvBOTOBA9B1DmgG
 qE9MjsEvelb3mYG9Y3GKp77b3lFWsRuJCMgNab4XguEedxpHnyOGvFxm0d0JTr+HF9g0/9Wet6n
 +lDHXT6zwHL6SiQZXPbVXhcorfehe4xYbtNociaQbbgB0bjZnBUqVlnCrc3NNP0shJ5AfXFDYsr
 5ich3Jt36GqaB/FmseBHb3EfB9AbbcJqYf1ygNaM+J+3hF+rfzyQsCD2KQgMrzN0dy6/EVbO0xI
 EMg6rptDdfHm38w4XaQ==
X-Proofpoint-GUID: IdwSxDHEV22ER6LystIzPayZHAHy5sAe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE0MiBTYWx0ZWRfX3Fn/piBye6VX
 /M978F5CD3MlMTSBWFmocRaF+/YPnZ9YoafXi+LAUDQEUJrTPaHjgIYpB+ypO85OR0V51yryR2g
 VHktRQwTkn0OyDiGixqYQ1sYXNKqM9s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_02,2026-09-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609080142
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

On 28/08/2026 16:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> - [High] Silent truncation of 64-bit integers passed to `gcd()` on 32-bit architectures leads to incorrect clock calculations.
> - [High] 32-bit integer overflow during PHY bit rate calculation causes incorrect hardware configuration for high-bandwidth displays.
> - [High] Deterministic division by zero during CCF clock registration due to uninitialized configuration.
> - [High] Severe CPU soft lockup risk due to excessive 3-second busy-wait loop using `readl_poll_timeout_atomic`.
> - [High] Premature integer division causes precision loss yielding incorrect hardware PLL parameters.
> - [Medium] Data race on PLL configuration state by bypassing Common Clock Framework (CCF) synchronization.
> - [Low] 64-bit division using '/' and standard division macros causes build failure on 32-bit platforms.
> - [Low] Unsupported floating-point literals used in integer calculations.
> - [Low] Use of `mdelay(8)` wastes CPU resources in a sleepable context.
> - [Low] Fragile design conflates the presence of PHY regulators with the name format of device tree memory resources.
> --
> 
> commit 9c53defce3c459b1740fbff4f2434baad5c70aee
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Subject: drm/msm/hdmi_phy_eliza: Add support for Synopsys-based HDMI phy on Eliza
> 
> Add driver for HDMI phy block from Synopsys used on Eliza SoC. Adjust core
> parts for handling HDMI phy initialization sequence.
> 
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
>> @@ -168,13 +171,17 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
>>  	if (!phy->cfg)
>>  		return -ENODEV;
>>  
>> -	phy->mmio = msm_ioremap(pdev, "hdmi_phy");
>> +	if (phy->cfg->num_regs)
>> +		phy->mmio = msm_ioremap(pdev, "hdmi_phy");
>> +	else
>> +		phy->mmio = msm_ioremap(pdev, NULL);
> 
> [Severity: Low]
> Does this use a fragile heuristic? This logic overloads the presence of
> power regulators (num_regs) to guess the format of device tree memory
> resources. These two hardware properties are orthogonal, which could break
> if future device tree bindings diverge.

Ack

> 
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c
> [ ... ]
>> +static int hdmi_eliza_pll_calculator(struct hdmi_pll_eliza *pll,
>> +				     unsigned long rate,
>> +				     unsigned long parent_rate,
>> +				     struct hdmi_eliza_phy_pll_reg_cfg *cfg)
>> +{
> [ ... ]
>> +	s64 precision3 = 1e3;
>> +	s64 precision6 = 1e6;
> 
> [Severity: Low]
> Are these floating-point literals supported? Scientific notation defaults
> to double literals, which relies on compiler implicit conversion to integers.
> The kernel strictly prohibits floating-point types.

Yeah, that's not really a kernel style but downstream pattern which I
did not clean up.


> 
> [ ... ]
>> +	/* expon = floor(log2(4.999999e9/base_rate)) */
>> +	utemp = 4.999999e9;
> 
> [Severity: Low]
> Are these floating-point literals supported? This is another instance where
> scientific notation will evaluate as a double literal.
> 
>> +
>> +	expon = fls64(utemp / base_rate) - 1;
> 
> [Severity: Low]
> Can this cause a build failure on 32-bit platforms? The direct 64-bit
> division operator triggers a dependency on __udivdi3, which is unresolved
> on 32-bit architectures. do_div or div64_u64 should be used instead.
> 
> [ ... ]
>> +	/* multiplier = 2*(floor(bit_rate) * 2**expon / ref_clk_int) -16) */
>> +	multiplier = DIV_ROUND_UP(vco_freq, ref_clk_int);
> 
> [Severity: Low]
> Could this also trigger a 32-bit build failure? DIV_ROUND_UP performs a
> native division, and since vco_freq is a 64-bit value, this requires a 64-bit
> division routine that is unavailable on 32-bit builds.

I got build warnings on this and remaining 32-bit, so I'll be fixing these.

> 
> [ ... ]
>> +	if (aux2 == 0) {
>> +		cfg->remainder = 0;
>> +		cfg->denominator = 1;
>> +	} else {
>> +		cfg->remainder = DIV_ROUND_UP(aux2, gcd(aux1, aux2));
>> +		cfg->denominator = DIV_ROUND_UP(aux1, gcd(aux1, aux2));
> 
> [Severity: High]
> Does this truncate 64-bit values on 32-bit architectures? The gcd function
> takes unsigned long parameters, which are 32-bit on 32-bit kernels. Since
> aux1 and aux2 can hold values requiring up to 36 bits, they will be silently
> truncated when passed into gcd, feeding incorrect fractions into the PLL
> configuration.
> 
> [ ... ]
>> +	/* stemp = (REF_CLK_MHZ/2**ref_ana_mpll_div) */
>> +	stemp = (REF_CLK_HZ / 1000000) * precision3;
> 
> [Severity: High]
> Does this premature division cause a loss of precision? REF_CLK_HZ is
> divided by 1,000,000 first, which drops the remainder before scaling. With
> REF_CLK_HZ at 38,400,000, the result truncates to 38 instead of preserving
> the 0.4 MHz. The error is then squared later, propagating significant drift
> into the PLL analog parameters.
> 
> [ ... ]
>> +	cfg->cp_int_holder = DIV_ROUND_CLOSEST(stemp3, precision6);
> 
> [Severity: Low]
> Can this result in a build failure on 32-bit architectures? 
> DIV_ROUND_CLOSEST triggers native division on s64 variables, which will fail
> to link without __divdi3.
> 
> [ ... ]
>> +static int hdmi_eliza_pll_prepare(struct clk_hw *hw)
>> +{
> [ ... ]
>> +	/*
>> +	 * This Synopsys PLL does not have a PLL lock-like register, thus there
>> +	 * is no way to tell when the PLL actually locked.
>> +	 * Returning now, would lead to stuck pclk or iface RCG clocks at off
>> +	 * (disp_cc_mdss_hdmi_pclk_clk status stuck at 'off'),
>> +	 * thus obviously the professional solution is to delay.
>> +	 * 8 ms was figured out during tests, not based on any datasheet.
>> +	 */
>> +	mdelay(8);
>> +
>> +	return 0;
>> +}
> 
> [Severity: Low]
> Is mdelay strictly necessary here? Busy-waiting the CPU for 8 milliseconds
> wastes resources in a context where sleeping is fully permitted. The prepare
> callback can safely yield the CPU using msleep or usleep_range.

msleep should be fine

> 
> [ ... ]
>> +static u64 hdmi_eliza_pll_vco_freq(u64 ref_clk_hz, u32 multiplier, u32 frac_quot,
>> +				   u32 frac_rem, u32 frac_den)
>> +{
>> +	u64 num;
>> +	u64 den;
>> +
>> +	num = 32ULL * 65536ULL * frac_den +
>> +		(u64)multiplier * 65536ULL * frac_den +
>> +		2ULL * ((u64)frac_quot * frac_den + frac_rem);
>> +
>> +	den = 2ULL * 65536ULL * frac_den;
>> +
>> +	return mul_u64_u64_div_u64(ref_clk_hz, num, den);
>> +}
>> +
>> +static unsigned long hdmi_eliza_pll_recalc_rate(struct clk_hw *hw,
>> +					       unsigned long parent_rate)
>> +{
>> +	struct hdmi_pll_eliza *pll = hw_clk_to_pll(hw);
>> +	u64 rate;
>> +
>> +	rate = hdmi_eliza_pll_vco_freq(REF_CLK_HZ, pll->cfg.multiplier,
>> +				       pll->cfg.quotient, pll->cfg.remainder,
>> +				       pll->cfg.denominator);
> [ ... ]
>> +int msm_hdmi_pll_eliza_init(struct platform_device *pdev)
>> +{
> [ ... ]
>> +	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> [ ... ]
>> +	ret = devm_clk_hw_register(dev, &pll->clk_hw);
> 
> [Severity: High]
> Can this lead to a division by zero during probe? 

Ack

> 
> When devm_clk_hw_register is called, the Common Clock Framework immediately
> invokes recalc_rate. Because the pll structure is zero-allocated,
> pll->cfg.denominator is zero. This zero is passed into
> hdmi_eliza_pll_vco_freq, which results in den evaluating to 0 and
> triggering a kernel panic in mul_u64_u64_div_u64.
> 
> [ ... ]
>> +static void hdmi_eliza_phy_tx_lane_config(struct hdmi_phy *phy,
>> +					  unsigned long pixclock)
>> +{
>> +	const unsigned int bpp = 24;
> [ ... ]
>> +	if (pixclock * bpp >= HDMI_PHY_MAX_BIT_RATE)
>> +		hdmi_phy_update_bits(phy, REG_HDMI_ELIZA_PHY_TX_COMMON_CONTROL_0, BIT(2), 0);
>> +	else
> 
> [Severity: High]
> Will this calculation overflow 32-bit bounds before the comparison? 
> 
> The pixclock parameter is typed as unsigned long, which is 32-bit on 32-bit
> kernels. For high bandwidth displays, multiplying a high pixclock by 24 will
> exceed the 32-bit integer maximum of 4.29 billion. This overflow will result
> in a smaller wrapped value, breaking the conditional check and incorrectly
> programming the PHY for high-resolution displays.
> 
> [ ... ]
>> +static int hdmi_eliza_phy_ready_poll(struct hdmi_phy *phy, u32 reg, u32 mask, u32 val)
>> +{
>> +	u32 state;
>> +	const u32 sleep_us = 2000;
>> +	const u32 timeout_us = 3000000;
>> +
>> +	if (readl_poll_timeout_atomic((phy->mmio + reg), state,
>> +				      ((state & mask) == val),
>> +				      sleep_us, timeout_us)) {
> 
> [Severity: High]
> Does this present a severe CPU soft lockup risk? 
> 

Ack, sleeping should be allowed, so readl_poll_timeout


> The readl_poll_timeout_atomic macro disables preemption and spins using a
> udelay. Looping a 2000 microsecond delay for up to 3,000,000 microseconds
> (3 seconds) violates scheduling rules and is very likely to trigger watchdog
> lockups if the hardware fails to respond.
> 
> [ ... ]
>> +static void hdmi_eliza_phy_init(struct hdmi_phy *phy,
>> +				   unsigned long pixclock)
>> +{
> [ ... ]
>> +	hdmi_eliza_pll_configure_pll(phy->pll, 396000000, 19200000);
> 
> [Severity: Medium]
> Does this bypass the Common Clock Framework synchronization? 
> 
> Directly invoking hdmi_eliza_pll_configure_pll here forcefully mutates the
> shared pll->cfg state locklessly. CCF invariants generally mandate that 
> clock state modifications are protected by prepare_lock. Concurrently
> reading the clock state from sysfs or debugfs could hit a data race.

Ack, but then programming guide will be violated.


Best regards,
Krzysztof
