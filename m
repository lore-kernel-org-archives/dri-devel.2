Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA2606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iwsnPbGF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZXuUSTE+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A1A10EC93;
	Wed, 18 Nov 2026 18:49:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E539F10FF56
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:49:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIHGGVd3944603
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 egxOvCyQRMpJGS3A8wGpHQMhIYneT+BSYHrmgVI9nWw=; b=iwsnPbGFYqKmaNAt
 DiGWZ1M01D/wvg6LFujZOApqG9JB7y/vmCHR531TUjmKMEc5aG+SYlIZMOxWjDRx
 97NiHqE5f0otAXE4iDSEWz5dBMmhDHPOQP4o9dvaMuA180YBbiOjNGuaV5OD/VlK
 Y6OuOvW5tQMCXlvsK+J6vqCDBClAAJITr8i3wSuSEZd96/k66O3PVYVuw30kMmjJ
 qJNucgABrbEfFbzrsdJNHKIRA2LE2fA8ZEGVd/0PF3kH8yMKltVMbGZlqz+pIbG2
 /3HB4bY/NKc3wJazMpV2dZq9mW4cg7DgeEfw4GPzwXW6UKefqXmaeJSEjKNysnz2
 yRmlpA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpc98dh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:49:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b238436265so1021593c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795027741; x=1795632541;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=egxOvCyQRMpJGS3A8wGpHQMhIYneT+BSYHrmgVI9nWw=;
 b=ZXuUSTE+OazPwUR86QUs5n/TIN+SKwMkhyNqfSJASAJrdepatAgnPQkd6l1PtenW8z
 SmvKcABbi3thoimm9NtTr/7lCEa4ee3zUxTrJ4yba6DWfulX18zKsmvp9wGWWWWTOElp
 E+HhP5jZuGiLh75Ho2KyZwuxNqTq3hL0y0Mu/MBUEveZRtArfkcnUlPzh7MenJkXBKZJ
 YH8EfTL0KbZKluV66KK2uW5bXATBvHSWucTB54hDTZGekb0+NRiwFxjiaaISpjrazhKG
 vdQ/+QU10V2QjlmTVOYbpghdrWLjqW2sUHPqIiGfJlRsybtDipjTYY6+2BLe4lHF44LS
 FPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795027741; x=1795632541;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=egxOvCyQRMpJGS3A8wGpHQMhIYneT+BSYHrmgVI9nWw=;
 b=duVesXXHPg+6YKXM0fOsdANqAmn/uLrvSNx4dh4sP3I8Ni4S+d0U3UvwKkOkT/ZCkQ
 V2VrrnfvHZRIuO0ZBllYTo7TQMwrgFhTd5eEQLFnjd2n/ZC0du8KlkcdsXj54jZ55dST
 mRzEbIrea+7Nm+npiAR1HMAZTEThPEPasD8dmtU+7PRVSt/Wk0We3ABywjxnGmEZj12l
 6h0a2ajlayveyFVth098d47n/w8xRp35JTNF/SFs9pSAh7BNxQYcjI/vxAfmf4UQcqL6
 0bQ8EjqLw94h9J7ZtecmCOjimRUi4B5z/YEzydWt6EixuHTwmjVsOYkdI/TeK+iy9M3a
 tNQA==
X-Forwarded-Encrypted: i=1;
 AL+hErFwOODeKeEa8UsTZgSefz55mtzCaXEXv6RXbvMgOnKL4utK/fSgIgvyGASYj8B7lxdXL17tbPzphpM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9N5T3PhgPGZ5RB0tIIlW+C+/x46LYnp+9+uzV7f3CaBUbPw5zE
 oRMponeiAgBn+/tTJh8sRJycKYoX1BnSpb95GMW7XoC3b16TgY9d+bEkP2N1MGKDyk8oUNkopBv
 L5J3lyhnBTZwfxvS9xh5RlMCV3wo33X2xQMr97zluuGgHUeH7KuJU2Q/0/6I8FLujSSAKzTI=
X-Gm-Gg: AYBFou3QkzDg+WhLRc7Dn6Dmwd/W9wUWN6HEs+sa+/K50fJoYB8aNC3P1+yYDN5NYV2
 xdUQbmuTqmRh2VSfbQpSPESk6TJLHV0U59jxXuhA3i320yyRFmM9YEE0v+x178qMSlyTCsPgyLC
 piXE4sAWEQpTtd5eRJJ57dDv1qQDujVpm9Xv6l0cePj18sESpAR+GS/8FqkkfMaEPlAQVB1kjV6
 2+Kmd6x3zYjPqozLOFjvrndwQM9mdiU3loBsQo+GhbCD4zB8qfoQX9lSTuKnS2ZilsPx5/zjS4L
 1jEwwJ5+qC9u2D5gHUwJ2RhzPvS+/8vm0QZi+iqGufy2/9F1VIyeO59TkoyJLfCA4RuDsY4GgTb
 E41S1CQfRWtF9tC8+8Fa7aDBvYkqLthI0Xmlfq25VgeLaP+95y+diZxrbNm1uxJ+XLYmkljMe2w
 ==
X-Received: by 2002:a05:701b:21d3:10b0:1b4:fa58:9d3 with SMTP id
 a92af1059eb24-1b543cebc62mr3198339c88.24.1795027740397; 
 Wed, 18 Nov 2026 10:49:00 -0800 (PST)
X-Received: by 2002:a05:701b:21d3:10b0:1b4:fa58:9d3 with SMTP id
 a92af1059eb24-1b543cebc62mr3198301c88.24.1795027739680; 
 Wed, 18 Nov 2026 10:48:59 -0800 (PST)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447f4e19sm11782234c88.13.2026.11.18.10.48.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 10:48:59 -0800 (PST)
Message-ID: <f38edf93-6df8-4771-8e89-c1d150ce3f71@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 00:18:50 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: qcom: nord: Describe the GPU CX SMMU
 aperture
To: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-adreno-scm-fallback-v1-0-e99cdbf3121d@oss.qualcomm.com>
 <20261118-adreno-scm-fallback-v1-5-e99cdbf3121d@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <20261118-adreno-scm-fallback-v1-5-e99cdbf3121d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afdf31d cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2DaYFnQSzUVrrlYHPwYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX7OHFkQfAQpkR
 wz//fikEhZHNlgSDofhMUdFcTKtffX0RzpZQ1EfF/hWH/g1rQCrqZdVNebKfYK/7o6AJC5yxozy
 9WAM7HkIUHSvwTb+qLJWagiGu2iyh0ZZ67Gj1uAEjQ5td0N656dD5sbJDq+hqgcJqGTa9eTgTZq
 epQ/qluhP/0qA7U27alOsjMuO5D1BjX/wuDVCimI879p6PLwHUTfK9i8dIS5G36y9Z7cnNGtfnc
 akGdaG32PB93Tx5EMHc4m8Wb9/UZkF8bpSswWbei3Sv84Dce7+s60+675txwa5A41CCOydGZTmx
 1357rruipCVXYVkbMEIZHve9cbil1GhYYzX11PvjTD+90ubLDdLA1UPhiVjYSwIvcynKcPTlelA
 LUacp5xyGmvggMUTaSRcgi3mStibPEZbUbUDM6bhiPbRH3LgtzHsfdM4URFCqCLHYo+YnN8fhL2
 gq0FSOurNN6b471jDdA==
X-Proofpoint-ORIG-GUID: VY8tWlZ-yqAwWwsjdTIHJx3VfOVRrgB8
X-Proofpoint-GUID: VY8tWlZ-yqAwWwsjdTIHJx3VfOVRrgB8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX8nOMFbKzEGob
 zZKlX3TPbjYq4cQNkykiTWK8PoSs/EMe6gXn8IPqowQm2DfRcDXgwvqGv9DOm14bhh3Pu2yq4Ll
 iEo+KGou3JTS71cftkNoAfgvTYiZCD8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180074
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/2026 6:38 PM, Puranam V G Tejaswi wrote:
> Add the CX SMMU aperture register region to the A753 GPU node.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

-Akhil

> ---
>  arch/arm64/boot/dts/qcom/nord.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qcom/nord.dtsi
> index 3e29c43ca9ad..cb5ee6b68779 100644
> --- a/arch/arm64/boot/dts/qcom/nord.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord.dtsi
> @@ -1717,10 +1717,12 @@ gpu_0: gpu@3d00000 {
>  			compatible = "qcom,adreno-43051701", "qcom,adreno";
>  			reg = <0x0 0x03d00000 0x0 0x40000>,
>  			      <0x0 0x03d9e000 0x0 0x2000>,
> -			      <0x0 0x03d61000 0x0 0x800>;
> +			      <0x0 0x03d61000 0x0 0x800>,
> +			      <0x0 0x03d60000 0x0 0x1000>;
>  			reg-names = "kgsl_3d0_reg_memory",
>  				    "cx_mem",
> -				    "cx_dbgc";
> +				    "cx_dbgc",
> +				    "aperture";
>  
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
>  
> 

