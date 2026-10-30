Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC888606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tjw7LyIU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d+fLPePS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F221127EF;
	Fri, 30 Oct 2026 13:10:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80651127F5
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:10:09 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGNRI3130313
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=; b=Tjw7LyIUXUz7kTQZ
 nHbzHNDytvKwXF7h6fO5R0T7IGPnebTHUPziPf71DnEPsGCP2xg9JiDcZ1BPoF90
 ZFknm9PD/jcRLyWOM9Bn7r2tH5j/hZ7yciCwnxuOnWzEWRVCQiWBIuqkuDN6liSm
 XcRVQZHfLXOydwZa0+rGTK4AalyAr4Ru73e7YYqk4ui4CsnextGljDS09InSXzEF
 frM17HOq+y6Fnki1ziT8eLNBb3LcOZaEafigxUN9sUEI7OZYOqkgwm4XsGDdspzz
 2Qh7ecy6OODRietSmf6tl9TMvx8gHcAinVyJJJox+NZEiitxIZTC7HWS9oQ9qPOE
 msN7aA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk3w3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 13:10:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93edac5877bso5412685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793365808; x=1793970608;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=;
 b=d+fLPePSSMuy+lOv5yEWOwZmfdsXbDTxZ7xx27TvaLQZJFPr8EJ9rhD38hLUcHFDNj
 7D4CNaafRZaFtgswFAng4VcC/OPafWfC/00lWvh5fwrUTJs8Vv/3MsN+bXv9VczVBnQY
 gBdVZ4hvSSL5capzAbkmauPuut65DJ6infRCPos8GeRHBa4IOs6wMNHCj+HP1Qvi2NAV
 tmu2o1KK0g/LtnI5P+Z6t+ST+G+Z4WwNPz4m72L8165jF/6v/cH3pVCenwiaci4mKOkf
 1vqtJSvNC32Hp6NRYP+tUcQ/gcHVEpN7CkHFvyoBlz5GlladD6Tz/iedrK41ryE/Efxb
 8l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793365808; x=1793970608;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywCvlXy/LXKFqaxptvjDdPHYZDdYq6KYRB/vMQRsu30=;
 b=yo8p+9N6gLndYp1Rsk76AHlrJ9t6VHK4+F/5mmqpYcpUEEnOt6B4jTPc7lG3kcENR+
 kIgRhDFpCjpaxTDAQ+ONo258FfC0acioMKCCAPJMRo1pdxHlarl5d1+F9gyH8SV8rLk/
 FKlWK1jFT3xBSy3AsvokjfdIyE1c07PBFpAop7atuZLpnVwpiTrHQ2KyrY5E0/o04/4d
 nBHFSHzYK4kjngYqFCzQIjj1kESYm0OommR6GbKC67I0u5asyEo2C5NBVYIUmJ8sf/0S
 wajXRfJ/RGxpinkjdj//IC6mC8S6mG5M/LSRfOCVvU+YmZvNlCXydhVWFtcfnN3wLob2
 XLdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ7Kxv6tPQiuib9eu6wZkUzPYRl3GbxFKdEFLIDjCFdKWcKCeYQ7PnpLZxwhdznbSOQOP2yzHWOQs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJA+5LLabrIC5JQXygrqURXtW+piWC8cNJTZ1Eor/xQcwGyAymt
 +uAoWVYcGfMlvjD8AarJR4n3eojPyBzxgsvocMAC6ahJwkgcJe1lYbzsNp6qsX9EHwBK2/SJvZy
 ypkYn5yVp8ylaMv7TBgNhDz/5OmDgx57R70CO5GDe73gss/Uy/N5wzKnDeUTPK8fPju9adWY=
X-Gm-Gg: AYBFou0+obQxHvQh7FYJi1efXglFVJIWElKRr0J/CIXbQIS1ZhI4o43aqNK16frHW37
 8yyBSeZ8D+/FxzKxF/zmdWlTk89VP9GNEmeAXkaeM+1r8/phGnxguUgJTVt99+6DkwRlahcxf1L
 LJ4KGiDfkj8/6onxsWielZG7H/8oWMbT+p97VsfPDk5AeAMHkuITNi4xkAXRRwa+2eOffS1eDY5
 gcPqjbVOnQpHicDRRHpt3GEsC/y/e0fjeii/w9diPcltE6WnzBmz/1wAglG4eAUmfLFb8zbqi3L
 aYOjFA56ofWdyDSAicEQHEGGen5CiPpFCxpCSuvBvIHV2x7vfFdy+ab5uLMzCm7Ck2185SPpgZX
 gNCw0afGUdwyuzRdTXP4bruNnge7zwolNNNgGhmWvKz+PNdCS7sMdrapP9sGzXSRsir8OZhI=
X-Received: by 2002:a05:620a:870e:10b0:940:f21a:eb64 with SMTP id
 af79cd13be357-944216f3e4amr392367285a.5.1793365807954; 
 Fri, 30 Oct 2026 06:10:07 -0700 (PDT)
X-Received: by 2002:a05:620a:870e:10b0:940:f21a:eb64 with SMTP id
 af79cd13be357-944216f3e4amr392359485a.5.1793365807359; 
 Fri, 30 Oct 2026 06:10:07 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc174d0sm65887066b.4.2026.10.30.06.10.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:10:05 -0700 (PDT)
Message-ID: <4f6e1534-5105-4a4a-83e6-4b2b846b67f9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:10:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/14] arm64: dts: qcom: sm8650: move smmu sid 1 to
 new lpac device
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-4-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P4s_qEerc_ZM9a3htMy-5eB2MT8cBdWA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX3GijOthen14n
 njx+cbKRY5Ak8yPmRiQgOwmiy8O33uRmRVSGEBbbPYbYS51jkdWtJ07gwWPgP59eIeGHmmvn9qS
 AQIGB+v0e+HQ03fmpTwDDQZHW+JFnMg=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae49730 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=7uVtGDAPqmP0Npu4MUQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: P4s_qEerc_ZM9a3htMy-5eB2MT8cBdWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX4nm72aji1Tc0
 xivbmme0JcewPu68ZfnKHt9F2N2aSvpXEVVVLQywIuSlM73040c728cp2nHngPLTHwyiSZziZQt
 PrH3f8NQmwbvKrQ1K+i9JlOj7cglt9umnZJMTNIJKAHJMpdYksjmxxFpwOvnl/TPDJIYua10lAw
 tdrXyMquws8ndBF41ZEsnqscoXSZ9TA/7Ypyg4fnYFqIuE/CrhPrYUMeHbRz+CO8r1CyrqGvJEl
 kpevH8v2n50thHQ87iZfW3W4o7OY/ZupDL6YVQmv1P8XVATBq608sK9XCjNxGncoYGcLBGzVWoN
 W/aVtj6hUyThhgj7Lca1faUX6KvP63/sVJ0qBzeAouxG84NdWW+qGsTX9d0Z1R5daAj0YYchPrx
 McB+HS/aGQT3wMPhGn24eH6lGxHiF5eU/m70Lp66irVV3Et2NcV9MlcywSW6VzFYWCkdlxs7QVL
 X36cUoee82c0hKpVM8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300052
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> Previously both SID 0 and 1 where associated with the same domain.
> 
> When LPAC is not used this is needed so firmware can acces memory when
> initializing using the same page table as GFX.
> 
> To use LPAC however we need to move SID 1 to a different device.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 1604bc8cff37..f47d1dbd06da 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4144,8 +4144,7 @@ gpu: gpu@3d00000 {
>  
>  			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
>  
> -			iommus = <&adreno_smmu 0 0x0>,
> -				 <&adreno_smmu 1 0x0>;
> +			iommus = <&adreno_smmu 0 0x0>;
>  
>  			operating-points-v2 = <&gpu_opp_table>;
>  
> @@ -4158,6 +4157,12 @@ gpu: gpu@3d00000 {
>  
>  			status = "disabled";
>  
> +			lpac: lpac {
> +				compatible = "qcom,lpac";

I'm debating what to do with the compatible here.. On one hand they
shouldn't be generic (should be soc hw specific instead, but that
feels a little overkill here) and it may be that we even don't need
one, but the iommu driver needs to know what we need a 1:1 mapping
hmm..

Konrad

> +
> +				iommus = <&adreno_smmu 1 0x0>;
> +			};
> +
>  			gpu_zap_shader: zap-shader {
>  				memory-region = <&gpu_micro_code_mem>;
>  			};
> 
