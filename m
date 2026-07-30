Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612B2C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9697C10EF1A;
	Thu, 30 Jul 2026 13:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iTZIKINY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L/8wC3Av";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D7C10E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:57:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDKGU2094137
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=; b=iTZIKINYXBw5rW1F
 0AQNyPGsB/xxWodIgL7ZH5aZtW6UW+dQXYZlejGZoFK/y8a6YTQTG3elh0ukDGiq
 lZk6EuCJfERrCZesngkrpSNEDsYfHEuQbChd3BhRRYD02fY+Mcpzgf96WKhjhWXq
 O0sfsd7eWQgeDhSAcG/m62MXaeecBTUlV7NmUoq/JPL2cZKFGlaO00LiEny8K5zR
 /2DS7bg0HKCDVL5HbqNROHWzrMnMfCjbJw5xSBj8HSVXD63a3kPfKB2pu9mbO9JA
 oG57cz/v+K8GtfVTBWNVolg05c7yHJ/24RgaxytVSaNW1aOxTV3VGDWjkeOAD/I+
 mTp26g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ky8d7r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:57:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51ca37ce4c3so4705631cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785419868; x=1786024668;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=;
 b=L/8wC3AvNXyww3IMS9AMNo/89BLlQPwsTTPkZslGDUH1bE/5mGd9uYIomfsR0VliyX
 dR9YEDJtE+r7R3F0mA+sJDufz5LjsVazbQXNSvapzzIc1W01qDGeU9WxWpzGAS2UJ8Ck
 irg67qk2+enyaD9NRLhlwY/ynuHFEqMS5ZAVeXG6biAmihYKgl4SvmltkG8aOOvSENAf
 pvyh/2AJXNf1wMAYOORM5OjCEt2xsIWnt7NilU9KvexDtQAHdgQKdTH2BGPfxOic/lpR
 6LQ+pjkmyEJv88OXJpLXLf/b4GkdJNgOvJOMq2PN+bewF/xcaAoWcp1jJOwwVHWCi4rd
 wb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419868; x=1786024668;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dXD32x4UKkxDB6V0sSMv60ZLLDNzi7VhRUUM6/9KUrQ=;
 b=H4vuUFxoj4lIZ/pYs6S5OH2B9kQD+i0xbqEgLxGTRTRvUP/mzuG46mbNcaIRKlq8v2
 Ni7Iw5LHjQiBdm+iH7cvwyJTTkC/DHnkDOYBDhQYzF2W1YE1j9G68CxZQp0CLWOkETmr
 PAcIgakyi0FxqQNA+6QbljLFsB83ALp1nPmi1+1IllRvXYS51lZRLvMK3oqDZ2dPTrqO
 6TIYhd05TX3UCleT1CAKLuz/NRgLXc0YkJE9OdYPynnWNTxgZZi+wo7Lru0U53x8p5UF
 XHvcN22+K2/FLVYWSipIvvYgDSTvB02pdeASaH7An4IJT69yY1ded3mSuTRB6jSWbFMD
 tZ4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZmhWnpuQLBKHUNeQs8jjx6Bh89SorkhLzjftXzb9v6t/KSHdCzE2DBWNPOgP+NE/VaYTBqL6NPYE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ86+I9cuLSZsRdZ87aXNBv2JQQhM1uWTWQOr4NQod4cKE1uNG
 0DpPRry5/jgfZ47m+0J/wSkBor/gUA5weFVZjAxXfpii7H+hCi/TFgV3V/9FM5pLFAZ7pZjZMiX
 PHxA1dPJYBFyOcmFwjrNCmA51jG1Yz1cRz30KBhCQYPsyjAMrs1Q2FTs0JgStjTNYg3RdPCY=
X-Gm-Gg: AR+sD13dNmVBsnzcSjHUvqPE98SjwVQ2nwdRpVhHKXLHE+uMoyynQC9PE6gcK/n8GTM
 SQunNnPsOrKT/ho+U7aeGwYfT5K70bwfyDmgFRanMvl1IfnW3+TSRHmtPjWotZ/Ekw7keE0I8Ej
 ecsgetmVRW4clvCKzpujbrjN4lzEgSICXw9IwlYzbZsuuzUa+QR6WOCFCFGNH3QDbk6Y1S0wsk5
 2pLMjRajRQVJExCPayAe4fjvRb8aXfhfmNxLPwhxePZJJjV+b9OxH19uu5iAXs/kvlUT4GKETmK
 x4gkNn+uVfOeDXcPmhzHRnl7UUJ9dEVQc0gah+EIdgwIGbEG6RTyZ8nQhc7xGM1StgUD+gXBo+k
 HqiGGeHi0NEvUp286Q8bc49/r
X-Received: by 2002:a05:622a:1207:b0:517:5e32:f3ac with SMTP id
 d75a77b69052e-52b4299d6d8mr5430501cf.0.1785419868284; 
 Thu, 30 Jul 2026 06:57:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1207:b0:517:5e32:f3ac with SMTP id
 d75a77b69052e-52b4299d6d8mr5429911cf.0.1785419867788; 
 Thu, 30 Jul 2026 06:57:47 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a07d3831ddsm670344a12.17.2026.07.30.06.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:57:46 -0700 (PDT)
Message-ID: <c77db81f-9fb8-4803-8efb-078b8cf70fab@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/msm: track a context master per device and IOMMU
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfXwklh3ejLoa2o
 4Qat5OStfHLcG/ux7XtvOORu3Rtx1+hgqFSfhLv9CXnPopkII4NDPlgsAbmSO0NxJKTNuUY3NUK
 G362tnMWs7UWKob3WCjoS+E+msvkmCBGzyFJ1OUEB5T7RvuhOVDxzHekxtJQLg+3FqZBKezM0mq
 ZHubhJbsnIHLqUKJHKwbTPJOJSVCLNBWvAbOY+cHlA2eOzdG2XqaaoyjhE6X+MjMD1Vb2lckQAH
 Ls1Zz9XLvkCimiPhw55o5lCNTLnEbdSU6x/+9+aHYJr50TPX40F52NpRo3KElqPX+FDoALpal3m
 nZBxeqzX4Bu1n29gRE/wR0UsNf7vbc7Vjp4o2TQ8XNWNDQMF7TFEyz21sgEQNgPxZ5iFA21v6A2
 3eDRwlLbBL1MWdASQMC8kUSKuw6cN68GG/4xckWotQh8ml1/w+5ONplqJR0yYivT/AZF6WpqKMW
 /ejvo8ITPNYkspYEUcQ==
X-Proofpoint-GUID: WPIh_I58vw4uL9ErG5V9ZU2U_kOHowKS
X-Authority-Analysis: v=2.4 cv=ctOrVV4i c=1 sm=1 tr=0 ts=6a6b585d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=dmEO2URhNf-i2iSvwFAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: WPIh_I58vw4uL9ErG5V9ZU2U_kOHowKS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX8gC2v5xI4MQY
 9iGQROICJsd0n9uKz04/8uxBFHkI5OIqhFdwvvtVU/pAFUG49W/dZjtQjoIAxVUM9aNPBwz9scr
 QwtwmdMZ6e6mkZUCHIQDcPufAc8dSBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300106
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

On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> insert_iommu_master() decided whether to allocate a struct
> msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
> caching the result in dev_iommu_priv, then unconditionally dereferenced
> the master:

[...]

> -			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
> -				 sid);
> +			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
> +				sid);

Is this intentionally part of the patch?

Konrad
