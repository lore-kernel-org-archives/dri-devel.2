Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3BCC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B89310E31F;
	Mon,  6 Jul 2026 08:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RoQsyK5f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VocFpbuV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20A010E31F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 08:48:46 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66683wIJ4156855
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 08:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=; b=RoQsyK5f7fV1iWo4
 SyCXOG5Wkn8sUyU2MNNAjdt+XvirxwPpqH+Vl7KXVFEVxe6G13eUl2I8KVybA5Fs
 bSvo8oIfzknqPfNdnifuLyviUJ6qvjS7+XgDfmJkkkad+KCKBhPrhToiobXU1tIl
 YFdVQfN0zAjEXkvCYS/RJwZyzBnhTM0JKyMah2Xfn8xtenWxWKQbuFKggz6rMm1c
 f7N4t3sUjBejdx8EkRRKelOmwe/39PgIO+IfwWCzvdTvih77/oAKY2UL4gfGdrid
 viv5xUbpgVRpsw0bW5UH4/K4NFST7TWUs7qPFG3KyW7Gj3qOHq9VQRRK1bEMR40S
 50O6Og==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h986bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:48:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21be5bb4so20865381cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 01:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783327725; x=1783932525;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=;
 b=VocFpbuVJB4J4tEH/dyKJq/Bxnf2NUWMSWWdxq86RJZ0VUpSAj9+ADfskd8dnjtoYx
 Vy3le4CpsAfd5Tx4lIIvLjZh5itCmcXB7JW22m+/I64memAFEtPydalBg5xlS+YxvntG
 481QGhrWmjqQpQ3Ivtc7TU3DFurUA+NILGmjpFymgbs204/113fk5RsZgREwVnaG0xcQ
 JT48mqQzh3hNz/PtR+D/57r8fpx2QH8dj00Rw0kMK3LAJzJshCZXGNh7AISUEg9VvmpB
 nlFHvQdWKyWdohfhtn6HmH4P+2jIct/z7Oy1plEHDnA2QHCdE1qaQedGNkdHSUF3Z1h4
 4ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783327725; x=1783932525;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UyCrsVtN/vgWmUocyd2gtWqkOjFDvVdxEkewtddvF+I=;
 b=O3qox9bg4kH6lrDxUK8TBKm5eRc5e29k3kPEMFXJUq2mMndQUZ0XulNxca4CEvFwrW
 Bph0Djtp18sv4DKeHsJkplntUW9Hz6t4wxqeVmmcFDMeTp+SkLUd1y2cHnznq5TQR+t+
 +6NTxFKnmpgnpLI0ItxvmdrW46pGMww06XIQiUovnHzN0j8kxHCmlJF2p3GAgpVPLC4B
 XP0znnL6FG2JzRv1XzOZSckxDqO2Io2C/Za2eBaZxd0fmO1N4gXuQCR1rtW7215iDtLh
 ECPX5QDeTQuN20ZubJ9YKK4KX2kBv+vNdT2bD9FJT0Z8L2UD2FtL5afxsPyCrMr/YVFu
 ucDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTzj8tQbrltVtCagzyzhGh302sads5GF3tIfVg6TcdL844a9JdEnXAoP1rrwP57Kj0avdxd0Ub/j4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxd2YUJKY2xao/KlykJ9+wzSiebHBS5vzQGtscY2ir9Qd6OiJ8
 3G+O8wXgOf2X1AnpRNQRHOzF4d7RhrZwpKtlZoJ2jQNJfrI9z+LMjtoWKi93yyC1wogfnJYqEqa
 cj/1Y5LplBqdhsvikpJK+8N0idASzJX+dH8ePXxGtzLknLhcgi1mmxAY0pVcho957yYO4pro=
X-Gm-Gg: AfdE7cn6Bey9JpAaIr2ShqmeROTU68mW3GVkJsTGmPYwrzwzxGEFbYju0kBz6tV/vBE
 y3ou949xf3xCcDMCyINt2MtNfeE6sx3c9KxWAhfPOfpbf8wIYx86kj4figKCjX3R0WmdbN+luYb
 kUkstuAsZTWoS9Hd4zrjwMYS5O5pNIxVgKX2vUD1s5XKvGE/z3T9Y3kdPc1pKhhaEi3Hd7P6d7c
 50miztJ6hIYtqYtxFZ1yra03m0+/KrD4QRofwlor8LC8A8EuyTV91NezOKA8mhh1seo/P2Hbq0V
 mH+ucthFXRecZuygStafL4i59+apgTmiBkhQsxfPKWYk6xs4Y2Qvpuam0sK8XxHxgb7e7aaKU5n
 iI0CGUzXzrsAa8yxutMZH5253WTCN/PdoKNM=
X-Received: by 2002:ac8:58cd:0:b0:51c:223:3c57 with SMTP id
 d75a77b69052e-51c4bf30d44mr87210691cf.10.1783327724789; 
 Mon, 06 Jul 2026 01:48:44 -0700 (PDT)
X-Received: by 2002:ac8:58cd:0:b0:51c:223:3c57 with SMTP id
 d75a77b69052e-51c4bf30d44mr87210471cf.10.1783327724419; 
 Mon, 06 Jul 2026 01:48:44 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c2d37sm691730366b.42.2026.07.06.01.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 01:48:43 -0700 (PDT)
Message-ID: <3208407d-05ea-4b1f-bb65-91afbcbc858e@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in
 a730_hwcg
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-1-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iHxEkxHrtwxQHbcNVORkSAqWtzzyILt7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX1zgOA01YJlZB
 qoBkRbdplIwlTOvdzNbrhJWwaCe3SDuhJBsXIwdRrKed2FhwozY4oPcehs9QApIYlwCKC8hjLXu
 XeEbiNZK0f7VFhO9m5SNGNAxLIfG22E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4OCBTYWx0ZWRfX6gQjNXnXuPem
 CfsMCwqYrh5v5BaVVb5Uw+EK7rjk4xr+WGYbNdfxRRngE1mH0SFcEfDSo6wkDeYF4fwvYcnD7Hz
 rMJqYEjPXwSVCmUnTZUJ7UUK/kaNELmpJrDlc3u2BCmX21yQ8goUuI2i+vbiLjkZHE37u0P9AN0
 wYGIZNtXPjkLJBukcxwWqBEM3f+G8IZ2QalvixMjIqVqrDxJOp9Bh/AncW6Oro2/8w/T3P0YDUh
 GPudgpqzWc/Y1P62pUslezdJo/n7zLVKocSB8WAGREYAiNCtWim9T6ggDf2fuZIHyTT7hQSmbRx
 7VYiA+2GBZjNUUMttQLLlKIAz4K9EnEOwmCYLEoCLEsTubhLnhwAjxAhmfuvA2OSWT/NJ3iEVHR
 zRmdPop5GNnT5TOf8chQKsy9K9j3J2XfwWQWAhY8wAI0vru8AGTbYX7fur4JwQ6cwpX338paFiQ
 1gumx/y8DJyO+uwHixg==
X-Proofpoint-GUID: iHxEkxHrtwxQHbcNVORkSAqWtzzyILt7
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b6bed cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KnFAnPMC3uCYYmJdzeAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060088
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

On 7/5/26 10:14 AM, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> The RBBM_CLOCK_CNTL3_TP0 entry in a730_hwcg has bits[19:16] set to 2
> (clock gating enabled for that TP0 stage). As per the latest
> recommendation, clear this nibble to disable clock gating for this
> particular stage.
> 
> Fixes: 9588d2f860a4 ("drm/msm/a6xx: Add A730 support")
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
