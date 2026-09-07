Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB1C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF2710E510;
	Mon,  7 Sep 2026 12:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QRgkmdzr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e+9m8F+o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B9010E510
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:35:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnUoK3777909
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 12:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nRove3eF2CgDkgkhUEbbyBJwjMDlcAT0c8FXFh1iM4g=; b=QRgkmdzrNVdnI69T
 PKrlNWYQxgUMX2mQRQSdOk3967Omd3V8BVHOMkmjs9cTTI80MKneRVXWcXKrq8ye
 mycdtMz3FTmTgrx5fIOmGa+b5je8xkXuI7p4goU02EONZZsAc/H84jrH182RxuTK
 a10JW1sdvgPFW/6f6GCGRtqzepHYf7gTgKAJcE+VRPwtCUV3CsaNlPFOlMvN+/bz
 cw9UY8jgq+YwlJpKBPvsNP1n1P9LHadyCJrKB/wcGrwsLIXyT+2ipcTiYUWZZNgd
 pjVTwhF36h6/ZpOiHAGauosrDSqbt0bIVOyGG+81AY8Yg68Oa7kgpgFdhyZfd6ZM
 FBRXRA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsfyh304-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 12:35:01 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97ca6578487so2718150241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788784501; x=1789389301;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nRove3eF2CgDkgkhUEbbyBJwjMDlcAT0c8FXFh1iM4g=;
 b=e+9m8F+o0bN/VGlkGf76iWeCay50xu74di/lclW3rBuZXRFH+SB2w4Qj0bwGlKumRo
 dust2LfjirP+J8B2XxopIBjfadn9yyFR7JDnt9g8GFM7UkvCXq1G9jyykFf9ue+1t5bO
 CtNVPakL3bMZexzD8BIFTQOjpo6X7yLPLs0bfD8xlraCUNrZFrE/2JtvYdNgH7QudRVx
 dcHbwy9qKyqqnDIq6y0ocm5mj9CzNYxqkI1TvePe0Hx3qsr25QRu8j3iZB2Dpf2ctRk4
 K4SB+bXzjnTB89aww0gAJNSxVqnQsHjIdHqny9gYEAHBTJcWtqZ33F9ObXCWGvmHFFAh
 hzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788784501; x=1789389301;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRove3eF2CgDkgkhUEbbyBJwjMDlcAT0c8FXFh1iM4g=;
 b=hS7ovhG3scEMW6uiOUZppXB01WNskPA9HwVBh/Z/RzUzpxEqnZxRSVfhU8I5kLPe4x
 BjgZf33+RqC6X8SxZmZqhWyQ1ZJUcUW2irgvfRgX/EbevmwO9KEpIOeuJSY5uQpenT0y
 u8sELWpraNGab4s9uo6uKWTy0bIw8lgGGyphuLAANLsS7ni1jyRjPICXANfyOBdrbXPd
 uQhngXsVu007M9B1OsfsP8YNV4IdAmxbx2+Mf96yxecmoeeKMFv2nuh6FPm4jIjru0fu
 OyOrLPF5pVhm2u3uUNDBqtCnSRUnd2ZkrAP8BLZalDCNa0SF5opOcZr+3L/iFEyxcUDf
 DJGg==
X-Forwarded-Encrypted: i=1;
 AKwUvByguUAnFxdgu79N6S3fbG7d8XYHVK4jDseR98BuMcPseA/qbEqk7Bk/Vfa/BouM/YUMtxB2nTn0KS0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXvWSNKTa+WtR3aKM35RI1sdWCitvEV/iIf1O5PadOuz5HYo2Q
 xdWCUvslq6Cv0Fzbj94jmbM9KgMw3H2fpXvdcHPmf9Q9dE08634zjzEeujpKjq4dM2YzvNzqFpW
 03hIwh3wbhJzHW+iavAIpwaUCCsxraOA57jRx2z/BeG1FoubJvUdhqJnrxsKuOZmUcfmsD7E=
X-Gm-Gg: AYBFou141A0gvRWng0asy2oovLu5MTg9AHTQhSlqLFR/EVdPbR8M5ew/1UdkuJ++exD
 /3pbt9BJ4mj3PoSIm6IFNAiywqll8dUcK5wQROAS7Hxvmkixe2SIN8Hf2UKbLvoa5wE0DSxFqn7
 MhD5rXfStRzQTuBl04QKaC2/rXhT3u7/bYUMWKDkMXq994n7eFZGpy4+3IEctwip8281lrl81OC
 00qwoiPW/QlKelh629g9IPcNnVN1+mwwULoIl5tXjkjkkZ3vehDeQXvplRGj1THEtO+ItY5TQpr
 mOhzBQTc1PfNzliLOZv2QaQpzpm4iRl+EoBG8nhYgM2LoHLlB10WJGI1ZQTVJi70f/v44nZrzdU
 BULhthmtDiB/IXMX2FCFHQh7b023Z
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id
 ada2fe7eead31-78a4a9c40c1mr9992793137.10.1788784501177; 
 Mon, 07 Sep 2026 05:35:01 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id
 ada2fe7eead31-78a4a9c40c1mr9992772137.10.1788784500704; 
 Mon, 07 Sep 2026 05:35:00 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm27784233f8f.31.2026.09.07.05.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 05:34:59 -0700 (PDT)
Message-ID: <e1842799-2603-4f7a-b3db-623483bd4bd8@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 14:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 07/12] drm/msm/hdmi: Split PHY init from
 power up
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com, vkoul@kernel.org,
 conor+dt@kernel.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-7-67843277de17@oss.qualcomm.com>
 <20260828142231.81AD01F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828142231.81AD01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: H2Fpplbeiga7pcWFt8EseMVFK2irOtry
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX/I55R+VZEgij
 jFxUs5z7Mdut7cEi0byGv3/3rWteG4TWYD+NgNeUy2jlffYbos56t7XyB26SmQeLudwMWulPbWS
 Z7rYtw/pAW/nohevke2F4ZvrBz4tJp0uCRgTv3N4siHQt8k+sPVYiMK/ut5EuODN0XdLJvcsTd0
 sWoUg0B6WIVX/jwyfv7v7uoG6CyVCyRmpGiWtmFaBsGjUGG6gadJivNxisArZ6GS0cqnSujTaAO
 ixZKUFwjoIJf0jwdu4Nr81N+gJECUIlJl6ny/IJWm+Zgls97aC6fEzujtI4EYyKYmKCq0cVwvP+
 5XEL9aFZeiFXPqVD4ofiT3G8YAXL6WKQ9E4vhX11YR2Yy9xHb3yZMPtoJnxNxBtBZ4JwQ424wG/
 cHAZX7tZ0sUee85w+0RslN8oO+cTRAzX+qMlxATMYVpGzBPgS11fzc74VGrb3d2vxIPRJzbhRco
 4r63sohPfjEPqrnvMug==
X-Proofpoint-GUID: H2Fpplbeiga7pcWFt8EseMVFK2irOtry
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX6tuMOZxG4GeQ
 4NxvpFqMj5Qnng+YkoBuCo0+3QFwhsA53GKSgtbRl9qTE5dcRdG/8UjUi6GG1U93EaEjC7YLKNV
 XRX406tzQsT9kae/tWFv6agFqF1aEIs=
X-Authority-Analysis: v=2.4 cv=AduB2XXG c=1 sm=1 tr=0 ts=6a9eaf75 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=s3il5d3tusZ4osa2_RUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070139
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

On 28/08/2026 16:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The HDMI pixel clock is disabled before the 20ms vblank delay, breaking the intended shutdown sequence and risking hardware hangs.
> - [Medium] Unconditional clock disable and PHY deinitialization can cause unbalanced clock teardown or CCF warnings.
> 
> Pre-existing issues:
> - [High] Hardware registers are accessed after dropping the runtime PM reference.
> - [High] Missing return value checks for hardware initialization functions, such as `pm_runtime_resume_and_get()` and `msm_hdmi_phy_resource_enable()`.
> --
> 
> commit 821f230494b55344c7aaf6bb73ba3e416ff8cb25
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Subject: drm/msm/hdmi: Split PHY init from power up
> 
> This commit reworks and splits the msm_hdmi_power_on() sequence into
> smaller steps. It separates out runtime PM enablement, introduces a new
> msm_hdmi_phy_init() step, and splits clock preparation and reparenting into
> msm_hdmi_clk_prepare() which runs after PHY initialization.
> 
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> index 9d027f96ae243..ead6ba3b8192a 100644
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> @@ -15,12 +15,18 @@
>>  
>>  static void msm_hdmi_power_on(struct drm_bridge *bridge)
>>  {
>> -	struct drm_device *dev = bridge->dev;
>>  	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
>>  	struct hdmi *hdmi = hdmi_bridge->hdmi;
>> -	int ret;
>>  
>>  	pm_runtime_resume_and_get(&hdmi->pdev->dev);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to ignore the return value of
> pm_runtime_resume_and_get() here?
> 
> If it fails, the power domain is not enabled and the PM usage count is not
> incremented. Proceeding to access hardware registers will cause an SError
> or panic, and the subsequent pm_runtime_put() in the disable path will
> underflow the usage count.

Addressed separately.

> 
>> +}
> 
> [ ... ]
> 
>> @@ -341,6 +359,8 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>>  	msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);
>>  
>>  	msm_hdmi_phy_powerdown(phy);
>> +	msm_hdmi_clk_unprepare(bridge);
>> +	msm_hdmi_phy_deinit(phy);
>>  
>>  	if (hdmi->power_on) {
> 
> [Severity: Medium]
> Can this unconditional clock disable and PHY deinitialization cause
> unbalanced clock teardown or Common Clock Framework warnings?
> 
> If atomic_post_disable() is called to sanitize the hardware during initial
> modeset (where hdmi->power_on is false), msm_hdmi_clk_unprepare() will be
> called without a matching prior enable. This bypasses the state tracking
> guard and triggers a WARN in the CCF.

It's pre-existing approach but I will address it in v2.

> 
> [Severity: High]
> Does this code disable the HDMI pixel clock before the 20ms vblank delay
> inside power_off()?
> 
> Because msm_hdmi_clk_unprepare() is called before power_off(), the
> pipeline is frozen mid-frame before the delay executes. Powering down a
> frozen display controller mid-frame frequently causes system-wide bus hangs
> (AXI bus stalls) on ARM SoCs.

No, this is just pixel clock, not bus clocks.

> 
>>  		power_off(bridge);
> 
> [Severity: High]
> This is a pre-existing issue, but can the code following power_off() access
> hardware registers after the runtime PM reference has been dropped?

Ack


Best regards,
Krzysztof
