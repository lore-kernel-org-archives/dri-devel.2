Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5ECC55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7363C10EEF0;
	Thu, 30 Jul 2026 13:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WuBkjEPE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X36nf0OL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF30710E183
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:43:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDfLUc1230485
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=; b=WuBkjEPEQ6+jaMAP
 mb7/eJ2DfGQPN8Y84dNiQ6j+CFSIFrqWAsxwUjY42fZuux0vSgKE4CwYUBxJX4y8
 YW4Lhs5BtJG87JVyfjtLs88SO1AZ9VVRACBDSd1dLjCwmFixdKS+k5Jq8L/SkslP
 dy7pA3v31WKP9bof+R+XetAssoV7ZE4Lakkcg1MI8X0lJ3jGB5a8srg9e6F3+byW
 ZbuW12hYQtj5jkMBvX09jKqK0u8ngTBgksd9BOf1ZQrpL6/nfooMFvXsBvRTHLkC
 ktGGj8VTarBbnRPHMG+yr8jQnddWlMP8CDG+t94qhxht+gDofuOu8d9l73N7yi/E
 UvDZVw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7q3g0d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:43:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51cab6f7517so2618251cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785418984; x=1786023784;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=;
 b=X36nf0OLIEltbPANgWpLbw97dXpig6G91lrpfeZCd/Y+T8IPg8Lqvo0H4XfFLkt3OT
 7LlUOH7rmUN/ioF+iBfWhpKgajOZvZdkQ+HkYj7Ip3Hbfp1yAo1r1MD5sIUhzm2OzgB9
 NJ3TVyXjXcbYFY7f2gVvHJXbLS0zaKvx/sNMlj9VAdRbRiYFXjTF/d/vmj9JkXc/Ovjr
 Bi+9Kgq3R1HK5O2xZuIbpUEQNlDUi25lwKmDzO/kz6ZsaznY0Ey239Gbm6Zb79x37Bus
 hnxvGJ69UjFvMoJ0X++mPa6izUn9yog9bzBBtvDAHnp17e0rA7BTn3oqeBo+N/1W981c
 Wx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418984; x=1786023784;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIHC0dGoCfL4jo/TTDqxxd8bs6eGi4j6fVBGNZoeJSw=;
 b=RQmGTIh5JnstD1o0XAOs3CGsXD2Zm3O5YIHLQdjo+oJC+NiiOsP0zH3UfvUvMc7DF1
 MNfsSzuYThfhZjAdY6aFQnhkZEQF+s587/2FTDWntXslGeOmn0fOMiORImbfDkrpSTRb
 BWfd2WEWxuPFF6ovP+niEl/NQDtUXyDE8yHs6NhRyVuDXxrirNU2WWPnybWMyhdSvHY8
 mlzIv9nBdMhpgXZT0zeDoSlLLueWPwaVHq1pdbwPrlBLLz6yh/Q3nHPoh09bmSzu8eL3
 iwRhnB/IvqRr48FU5LxFqBd3ShYXn1ML90R6FVB8jOg3R/sQZcfBCcYDk0cIMPDRdRNA
 k0Sw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfyRWXIoKdidZBYaOkR97h/he6hCwFz6dUo4tmiAojZkHSISQDMJlDAE8gXg6M1f0ZZdSwUkYUTp8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcBgddEsPW69E1rBYbsabO4LHqhbwNMXV6Pgdtk6Pp58nhuHFG
 b8iNS8PlaI4v5n9uUOGCK4nvH0JwUKuWfUbFscYkthGKIzK2rOz35H9PgYKUIsFobr2GZvu+RO3
 jrWYx1OTR0EhREKBvdEeHNG45h3WLwcW025411a3YgtM1/SsJqnq1eczaXZQwzYwfLWxwOY8=
X-Gm-Gg: AR+sD12jPyOnuB2Nhaj1tolT/CsmaVzHJsEWrnOc3JNPVeRaMBCBcdRbJYN4KfCIkk3
 fg7e0QCOyb5ZAM/+Ccn57sfN9CN/A5OJ2xXj2/PEpfr2vT+CNREUJ2vR7Uat4m2Z1zFd3ZBD/yI
 707Jj0wDU6lH7yfqpjeUjhuZWJL/p4seocmEiL5aNtNYE/yfHgSqZVSD3GPvRmBxn6I7D84Erk3
 OVfokRwMGORvOmzfhoErKSqTgMfILryivOzynF+vYc8N3uTkoFQilKGNEp3ap2pQp21h/NFQz5A
 8llf5J8XpR3dl7MgXXjD00sK2K2oR+d2XQJR9X85lkJhXJwrqWxnxc6xoEjR54nCxtGJR1dU9fU
 BpvHG6LTN2dVzcmivSl6zkbAp
X-Received: by 2002:a05:622a:a98b:20b0:51b:f9e0:87b0 with SMTP id
 d75a77b69052e-52b42b7f23dmr3221561cf.2.1785418983754; 
 Thu, 30 Jul 2026 06:43:03 -0700 (PDT)
X-Received: by 2002:a05:622a:a98b:20b0:51b:f9e0:87b0 with SMTP id
 d75a77b69052e-52b42b7f23dmr3221211cf.2.1785418983387; 
 Thu, 30 Jul 2026 06:43:03 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8b6dbdesm66080166b.36.2026.07.30.06.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:43:02 -0700 (PDT)
Message-ID: <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:42:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
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
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMyBTYWx0ZWRfXzFrk6TDzwptN
 pproAGBSXp8ModGq+AK+MRpnYWJq5RaamkeQgg2LxJst9Nj/+CpKyPmuXdk+TsPkaQJDB3MRKU6
 IiE5QJWnfEOefAJR8n2toF0tNUOTgEBIjrc45rKF1JTJLCL0kMbYhLOFhfUV8O7Vs/oFENSqVDZ
 D/ly+S0rV8fOGkbLiImq+/sjjOKjH1TCXmFsiQdzcMSTg9HtVs8P7mSu6iZl6gwi/gHD67LB8ah
 cIuDrM3oc6Ec+IwP0vrrFh9PPOmavfBNtBntgzf16nPizExH9k30QQLB4MobSAcNdsnTfWv5a4F
 Dc4qbHa9u4e7LqxdDexaxSDVBePrF1mGe5n/4pofi42FcI6k7GrjwDhv2q4uyJBNbEm4O/vVacM
 tn2VwtqcuDF8sD7P9R/ag4RihphaitckyotkwGN8LJ4ka6dfhauzDmz1pLCNRw3me0fCHYkT7o+
 Eav7xyJtf0SQOtenQHA==
X-Proofpoint-GUID: zObcXoazqn1lPj4V4PDcApW4_Embqq2m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMyBTYWx0ZWRfX4rNasiRBADZV
 wqwJ/+QTX16EgP8XQaRUMDuKvYhWOzo3z4K3zueJxUkMdYvvAAWaPzYwiUXuc/foR3bQdyw9Xh1
 LMSZec1ytleKhZwOkOEgZUL2OnRewp8=
X-Proofpoint-ORIG-GUID: zObcXoazqn1lPj4V4PDcApW4_Embqq2m
X-Authority-Analysis: v=2.4 cv=WuQb99fv c=1 sm=1 tr=0 ts=6a6b54e8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=mSMHI8jCXtBZcuwA1AYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300103
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
> On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
> dma_iommu_mapping for every IOMMU-backed device and attaches its domain
> to the device's IOMMU group. That domain is neither the group's default
> nor its blocking domain, so when msm_iommu_new() later attaches the
> domain the driver manages itself, __iommu_attach_group() refuses it:

[...]

> +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> +#include <asm/dma-iommu.h>
> +#else
> +#define arm_iommu_detach_device(...)	({ })
> +#define arm_iommu_release_mapping(...)	({ })
> +#define to_dma_iommu_mapping(dev)	NULL
> +#endif

I see this is prior art, but should we support this config being off?

Konrad
