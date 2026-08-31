Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E050C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30BC10E2ED;
	Mon, 31 Aug 2026 16:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKxOfY7/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X3YjFBsB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4A3C10E2ED
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:45:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VGPUBJ4073469
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I1StJ6DrwSXUaQmbo7/HQBFEJbOwbWv30eZXjba0z6M=; b=OKxOfY7/41ow87Vu
 DRd7kp/AILhvqgYcARM6FOsCrqy9WaGCtFgIRZb3VvwYxaWwaEiAvQXxXOtFLlgx
 Fi31ZGwNrQrPABjRDa0S3bZWzgqXibTyvRa/2FkEUKmfHo7uU+lhQSOqURwraAcw
 0Rb7tMA8Y+/mPWDh4ybH3I5nuBauYlGboy839ZKtEpibjTGZapEB7+NaQLNGpAOh
 8rXRpsL/MLdOnervZ/B8bsyyv5XfTLxWK/6hCQSPM/zEDJKRG/sqz7u+efG8fhYY
 bAVSimuOrX7qZ5nRhiQz0Bm+RCgrQPY1wEQs/nKfYXzYUCdxty/Af/6VDDvnaKZd
 /HKoCg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdd4dr39k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:45:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93495488976so116868585a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788194736; x=1788799536;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I1StJ6DrwSXUaQmbo7/HQBFEJbOwbWv30eZXjba0z6M=;
 b=X3YjFBsBxqijE7k64SJZSYShnLXl6G0ENw5I42PnO+6sp0e4Uu2kVlZbiP4vO0GriS
 gJEgahNesRUviMvpfMX5vXGoqjWe7TmYMigyPMbo9ELxU09iBwRQZTOQdmtRXo79BwNc
 C5LK/AH6ROqVoliFQqwPgHYcqEbZ/1K9/oJQ23HyYKL04fN/hPpIF807NoNemh0GHPND
 /7idzd0CcFtXD57PcSeH1CT4LJLUuQVf2PvjAlEdWbG1Qx6zJPdrTJTD9vGOZvjIbJZp
 oEt7PuaFfDBgQMRUFf0k9S2cztT/UparRmS3VdTFBes2YOIKVPcDhVd5fgKId4Qdi5NT
 Rs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788194736; x=1788799536;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1StJ6DrwSXUaQmbo7/HQBFEJbOwbWv30eZXjba0z6M=;
 b=gSSxTpJCOTmLUfVyhlbOzne/DLXGA4Qlg3tdT0kmZmo/fJhwVuMKH9cC2KXiMOFcmh
 kfRVHbC5ZurMjDPXBbd2YzxGv5WUBRl2oLkdha2fT3H2bYF7eCMBbnOOmTLrreUUUbEP
 rF6Qf+I0K8KKjr/Lq545p7NoWOwNoju8lbrvuC6Y8b4+/d5IYDFQZQ16PvZ//+3EQzZM
 dWTgCM8R0wEdB0l2H9x0G9P4T/Qj361UjKvxabABZU/kLV9b7gSt4Kdl5OfPG7UQeG3T
 COUTaIXsYrJs7ObpnEj583tBXrPsG6OVCsWVnU+eKz5a2fcPJeCLE/Uv1t54QdlmN/ep
 AE1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOJjSn8WS3Rd4RLm0A/stEbksjJhWMAuiseJ9Mr1vsA6/ocVskyjSc3Y+DisE/Gs67NfAsOy+w3b4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncW754AhjL+cpksE4yYxHCSU44bdY6WfTDRDszctG9qgs+oYbJ
 3WJFOeTM5XWM46gqIBXOfptCEsYab+Y0+QtBxsX2MmQn7V+z/6jpl0TQ/KerrFHIYjCj141QqN6
 2iSS+3WC2lickVSSQvz3kGSPMJYLJhyv6v9eG3HQo9nk1Bessuq05NGhCjd10eLj+BDBmy5U=
X-Gm-Gg: AR+sD12zZpqvp9mW/e7yVt2swPHKfK/cAZFc74EtnhCSsbSUjVQN3d1gJUtoroxLGnw
 HoiXQOJmuL6Q6iqtuIs7dy4WvCchg+s164/2Lb5g+qs3PEVvoXbIYGVZ/fiaisEagTiZGwAw4dZ
 HH5CjE/HCOzaFzrtc2qqZXvgz3khawLuN7BVmbQA7Ua7zoWmBkPF0jV0fNZxlT9hYPjI65EJl4v
 AhRuas1YvZqyD0TU5Jkhs2zORsDjEJ4N6DpJwHRlJfM3/CR4RYQu1WaQPSiBUWb+zl0Sut0Uc1D
 VtOV4eRmgomES5KmomyXVbBSvR0pBYXGE7qGPBf07W0HG5U7kfq1isNFJAN8gU2U1vLWHzaBZ/T
 GmxramsI6EeLgsMdZPPxdog==
X-Received: by 2002:a05:620a:224a:10b0:939:3fce:1a60 with SMTP id
 af79cd13be357-9393fce1addmr285340185a.0.1788194736063; 
 Mon, 31 Aug 2026 09:45:36 -0700 (PDT)
X-Received: by 2002:a05:620a:224a:10b0:939:3fce:1a60 with SMTP id
 af79cd13be357-9393fce1addmr285333785a.0.1788194735549; 
 Mon, 31 Aug 2026 09:45:35 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2564e31462sm432886366b.60.2026.08.31.09.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 09:45:34 -0700 (PDT)
Message-ID: <65f0a137-851f-46a1-a915-bbb2ecfd7f93@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 18:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 09/12] drm/msm/hdmi: Add HDMI for Eliza
 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b9qCJNGx c=1 sm=1 tr=0 ts=6a95afb0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Rd23p8nNYRV-PgpY908A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0NCBTYWx0ZWRfXyrqABKmu0e3b
 JHFFEcdrdytn5LSA8hqArTBKyvdwSMX/44eQzi+1hNEhJ9vCHDG0l86oWI0PdsTHsdP0OG/x1Tk
 xS+W9etPnBGaxMVV7slqNufqgWA4ZHoxNX/17iw6bQ2eiZYNRXNuN1b9V17HdimZRu7j3bYjI56
 3tOkFnEcZduT+4d5AXtgeoIvx9ELNxBwZqzhTpCtshXghSO7TQN5DH2+nntLC0YQq2OmsQycPBS
 urWJSR4IJl82hRnOwvPdQJ0O7iavg4FYa8r3GxU3MPFiCol7rrFWcATpmy4O4wKrGD1MzlsIeC1
 kM1frnMPoUq0tz9trJ4J1td7W/uN8G0rOikrRi9mdAUczLXG1N7A0dtIHPsvlE/c/h1evuXNp64
 9olTXQeTCeJIP1rRLHGKWguLe6rp3hKUfAQd4VzoPv9sOVT15s5pnjuWKVX+XHbzWzjCnc9HZhI
 DUssZc9w4t79oVCMbwg==
X-Proofpoint-GUID: N8mUMYjsjDNbe5rLbPY4SyGp6eTP65dg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0NCBTYWx0ZWRfXxAr3G/CpAPII
 oLN8VLo3uv5SmlYNPd8plFF+qKys+n71iC8alHIdgrngR9VMaLE4qe1C8zlIrhO213VjqEZYqeE
 4/CKhbnFAQcLU5UsV5iJyyAVnOO3Klo=
X-Proofpoint-ORIG-GUID: N8mUMYjsjDNbe5rLbPY4SyGp6eTP65dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310144
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

On 8/28/26 4:05 PM, Krzysztof Kozlowski wrote:
> Qualcomm Eliza SoC with DPU v12.4 comes with HDMI on INTF_11 with
> additional INTR registers.  The device clocks look different comparing
> to last variant of HDMI from MSM8998.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

[...]

> +	hdmi->pixel_src_clk = devm_clk_get_optional(dev, "pixel_src");
> +	if (IS_ERR(hdmi->pixel_src_clk)) {
> +		ret = dev_err_probe(dev, PTR_ERR(hdmi->pixel_src_clk),
> +				    "failed to get pixel src clock\n");
> +		goto err_put_bridge;
> +	}

Why do we need to toggle the source clock directly? Is the clock
driver broken?

Konrad
