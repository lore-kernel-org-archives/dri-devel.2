Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055BEC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F69710F4DE;
	Fri, 17 Jul 2026 10:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRg1oEUb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IB0sQb5w";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898A410F4D8
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:17 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66H6cNrr1066038
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=; b=MRg1oEUb4Ni+i2BO
 85OR+1wFl0TJaLyWh6kTHFHLaUjOj02Cx1mtmUilXdPxNcb0DnnWBJ4skh/mCkA1
 b9KmpzUt8yVzFY74+PuBChac/gqyBCLx4yJSJuUtjQRhswQiicgCzK7dF0qiqqfQ
 ZTDxKD4gxoGhuD7/cErPwg0+vk0CNPQrRZwg0/gWe3f1970scNms3dAHTOvc7KTv
 ufs39S7hoqiVvu9aqfM5PZtTG2D/LXlUwgVqL+nYmT/VPOdL9aSNkMxEspzoN5H6
 I7VeS0QMmRCoU3UZxipET5FLKH06WNTwwJX4p8qPvCkSqGNLywbVhAM++An3KYPh
 qeuKDw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffbquhjg4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c9e97b626so15640881cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784282656; x=1784887456;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=;
 b=IB0sQb5wV9RBDKBgb5/H6fMzq/EZyJZXsP1BKqvPONsGCD1lxlxYQbuXVdm4oJIOb7
 cWcwFgVfnCqBhVyAqy8mwPdL6DV/ZeSWBxDP0xu5sKKQ7hBnowxo4OrU2uYJ6HMd80VE
 YsE2NUlwuqLeRgb/w7y99gi5YQzr1yPtzk7GJpVNZBpD37jEtOB902oXSJ1XUxNkXK4z
 BUS7z94zosn5eAcpps3FRJOPp4p1z4qGa3KKWr6CflaB0wcq/DVy61sK5pCNPMd1d3tG
 TXPSh6Dghu0WGkUJVqq/lBcQ+me3oCQwptjvCiv8DwwFzy6LzjfB4ie9j2NvFH33BSdU
 bmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784282656; x=1784887456;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anIBn74AomYL3LvVUUMgs2E/qq+99IUZOlzTnnvEbFM=;
 b=KWwBftF0lVGcz9mmZ5llhyHwNdm3rC4Nx6M42uFyC6ZpuwuI0ODAM9xbgmwG4WbUuT
 LhnAwGapta9Vxv6Dius/jF90dbekWUtW8ScOhhh3xf4GaDHXmW8AJALoG+9yRTi9eNlZ
 7ndoI+/y5MtlcezOnEuOACNpCFjVvkqyuJXut9Jq+RjXct9Srb7nESVji74HoK5glTT2
 jZ1mb/Fy5kdzd34UUowa+/2VAKtV3D8vWNMkfqW0dz8FrN39qaffHvKpG+Z2ZGyENNTN
 J60mA2JP/P4ARY7a5RNH5oOUQdF6D/TrFGcRiAMdoqkCz6cvB6nVO5UqshBE7Jaos206
 K/rw==
X-Forwarded-Encrypted: i=1;
 AHgh+RptGPvGGkIcJaB2IGnmVDgrak7R4Uq36JVjYK36R+41rOhbW5UNMKDkqR/5n64c84xRoYSj7ZDTZ4o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjnZ202UT2EUfi+Xu8fa5shKvojFKbweIzA2EtRGOwvB/Ex56u
 FRBaNCUdSKQIp2dtT+LIlUVz+EV39EsIbiwu6ZFUjMC3kRZVe//L/8oivM6Ept40KwbSqRndZ4N
 4kFek5v6g9Nk1tbpl5xbfB3PwmAbi/4B/GIBQrfkFs4096fad3cqtrSVsevkO1TOPQ2bBOyA=
X-Gm-Gg: AfdE7cm8ooLScQkawxBc2ionSbHMYflI2E0zovG2rPspCuBnhg4fVe9h98RFb0DGWJb
 LQngDwyetLa00/G6rz0ik/VBiREQAMMInxOg0Ki0UCUxaiGeSc0TySr7JiJraOi5vLRqitGhT25
 1ypWQ5bAeZwp+BfcOCp+7WhP46koaDweR9CqNPA0DUYBhgAZRYfhjfhblSNX85weS+e0v8uewn/
 SIqMIf+ohus16JpIMZcY0z1bpd0+T3giMuz7ahWnXq03ycAn93B358WO5sTv1f+TFQLzRRSv3ym
 q3jIIOBaypMm7fhvH0Ke1ECdu3K+hj5TANBYWDAB6KsVx8jrtbVZn+VEInlvfVSQRQJASuMFMlJ
 zjSRn9rexYMDt+p9TFHSTp3K2
X-Received: by 2002:a05:622a:1c15:b0:517:5e32:f3ac with SMTP id
 d75a77b69052e-521382dd29cmr12698221cf.0.1784282655980; 
 Fri, 17 Jul 2026 03:04:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1c15:b0:517:5e32:f3ac with SMTP id
 d75a77b69052e-521382dd29cmr12697701cf.0.1784282655380; 
 Fri, 17 Jul 2026 03:04:15 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c17127358e1sm51516866b.25.2026.07.17.03.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 03:04:14 -0700 (PDT)
Message-ID: <2c6b3958-696b-46d9-ab70-87081610524d@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 12:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] arm64: dts: qcom: eliza: Add GPU nodes
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
 <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-7-c9f1354dbd29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ysKsRZT-1uqYym3PcIBYIoEbHCgpRfm2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfX4frKElL3k/61
 7NgXuFtF/7QEM7MPhCh1K60R4Hdu0an8UeMx0Q9gZzguN3BWhX/QfcABWatODZJE7qtJyfaRazo
 zMUvZD0N1hQn/UkI37/RH8jg9/RYgOpTFnagtINNIQbhPVGhBY/hf2z7Npf5+fVy/zDCYTc5q+4
 7qULLDF5nuIxrYZl2F/gJpD+v42qiS8V9yVHAjxN/dhxms3Wu3OkS+1vu517Fciw1QqIEtkR4kl
 kSRqHyni4tQrzTUgq5UiyilpOaTwf4TKVoAjGK4YF+Cr8TwilV1X/5yxa5U8nJMaCIxaBLoWY5f
 0qv/MJUcA6uZ0rnfNGkgOl0WNcy32DvlJ0Fup7J4Iuv4cDfbmASkpkWxE7RN212P059M95DAKRF
 jMtqXbmH3hi/f4cbqi4VcwfUX+ioxwdsH3jUcu9+NVYxx3qqG59uJTMZCCN+MjXLGG/EetA8poO
 5jvJWBkE2JKWmzoY5yg==
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a59fe20 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=LzKdWfoJb4QxxMUDPeAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: ysKsRZT-1uqYym3PcIBYIoEbHCgpRfm2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwMCBTYWx0ZWRfXy7sCE1amT602
 ps4SGenJetEdd1ac40hM937yLsi49mZ2cdVrbCXeJv3Kdc5a5IthkAx7HSqj30tzbDA5/xQ8nN0
 qGAjIWMTLHkmzoSfsfFQzRvkSnKWxs8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170100
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
> Adreno 722 found in Eliza chipset belongs to the A7x GEN1 family. It is
> derived from A730 and shares the same IP-level configurations: HWCG
> registers, protected registers, GBIF CX registers and gmu_cgc_mode.
> Major differences include lower cache/core counts, 1MB GMEM, no
> Concurrent Binning & LPAC support. Some of the peripheral blocks like
> RSCC are from A740 that resulted in updates to RSC layout.
> 
> Add the necessary devicetree nodes to describe this GPU.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

