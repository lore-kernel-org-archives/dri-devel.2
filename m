Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E72EC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8475810EFEC;
	Wed, 23 Sep 2026 12:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCOGI/Nf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cWn7Kznp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD3E10EFDC
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:11:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NBbTqr3413818
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8A0MKVbKWmnlKbzQw920PSpP
 eoOO0tpdgW2Ug9tAy0I=; b=SCOGI/NfAWRAzhh7yBTj8bqPb5Iyp90UuKn+E4DO
 6Fwcdm1hrjLMfKkZb9S5sRywkXQpkV5FzrE7gpGfK8U2FxZ5AGTn7FOcPQI+q1vZ
 3EOpN/KXOlzGso2YnsPnrk2cE2Oc6ptH7Ok3wcT8M0e2doxQ4niTbsAXP+gVkL0D
 L+6gueUd9RDWgJwOkLsL85fjblNDciYggzKkTLY76kiPoWTFgiVTXwRcDRJpYSDB
 csPZ5Nt8SCgXjVAn06+3O6eiydCq1+xgqLDBxfJ7uAOuv6+xUb4XdPOs95GeGADh
 ZIln7ZkzAW8FgFSFSySNrKi/aRbIg2L/38ZLMmGQWOM1QQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv78n1vsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:11:16 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7989d8ef4a6so252438137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790165476; x=1790770276;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8A0MKVbKWmnlKbzQw920PSpPeoOO0tpdgW2Ug9tAy0I=;
 b=cWn7KznpF1A8mxPcuLB9QzSIG85bSIJsTOOLHDbAWffIfqMaX7pNNJ51KVb/efaCQJ
 k/lerJ7KpyRqKr6mlP4YZkQRwnRsq02tY6q1A4vZe3UL29WDSplp0vS8f+yGi6jbqCYU
 GqnXBdppLA9qwv9WZNgHealPOwhplxExRi1U7KUFkFIy4pfVDKADGz3N2suy0OVPXKzZ
 I0kpMKX4n7UyGHt+AZb5Openhdynbn0Uk0GQYtxVYQz2vs6XqiyAjf67p/XjyQbCdHg4
 OXNoJzP+NygpaHrg2yzL5PRLnn/MR+Kc6If2aE83+NV4/CDvZU0lkCKafyHtRIqE1ZRI
 CGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165476; x=1790770276;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8A0MKVbKWmnlKbzQw920PSpPeoOO0tpdgW2Ug9tAy0I=;
 b=gfnNm5+fnv3+q37HC4bPBDCYbp/xfC+xYnSLmjx9H5dYxwvNEchkaLto96srPpAJnG
 8WXgVCRQT8v7WeNt5uZh6sIywMaF7PU8kbHIicPeoX4e8w9hpPdTAcUpghiCOA0PEmrq
 gIrimZYBEPC/s61nQwyIgRsxSw5JBSUSkIhsjZKekLQ/nDzSpXfcgdL1XCM4gYDW4wBD
 gi4aZOHjVw5z0V2gNn6sIqW+vnKXj76zMD56pKTuGP50j7iU3vRQpncZKhqmf4+mA4mG
 eTHt4776CIWKZ4muCwj/GhywA4qcgUKb3czKAv5SBpeEdMLhyAwJi+opagg2EUvumlhj
 4VfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgGfVk9FEEaN4n7cXhoHYbxHxUtFyGk3nR5iEfBsjHulXg271aAhS4iBgB4+jwlomRh5CyJVdHG/g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkMYBP2FOEEhbk/LiViXWQs0863uSxXT1hi/9SJv6Sl8W4gyVd
 gGMwtB1Ly4VGjTurOoj5G+ZjNl1e5nqLDFWqUSnKA68KymmSGBJppDK7Tchko80/Al2Gw1cD0lh
 8XpnBZrEjjSTy+3bQg29F60c2iL8t766KSXkmxMSqk1gLMU6iBJz42PhZ0dLUruBNw+sZKzg=
X-Gm-Gg: AYBFou2dwCZOv5XsdzBrgWQI5kTCq/ewyfo5hSC+EwqEVN4sBNFuAhrr93ahvTIlFO3
 s2rx2rgVRy1YTGl2yv1ntlxzC5HdsN0e5H2mMSzNGedOGgkYSQCTgUoVyDo+o4bftXvMJn//8oc
 yztKBbIvHN4MEduETyBXp5gKgb5HAbLeXxu55LZ8Sl2LRNXGSvXuwsfYPl+8PeI1WEC/j38j/tr
 SxLeQYO+6TOksJQRIIEh/RnyhGhRZwfy3W9G8LY1xEJs07luoQ76TivAj+ULYwBOEQFw0HvESeU
 L9O50WbCGkpeLfJXFdeTOLLJCQ8k8nezAEmrszQuh3+zo/ak2rnaQveBg0lRA1FADJcDSCNKxPD
 m2WdYf7fZi+HUl5PSdARpo8JViO3Pe+z8/MWIp6zii3tae2mS/FAi9NuoP5yibMh/7vQy0KUAID
 Za3SxGGUF0525k
X-Received: by 2002:a05:6102:2c82:b0:7a7:198a:c2c6 with SMTP id
 ada2fe7eead31-7ac1ea99e8fmr1676862137.36.1790165475655; 
 Wed, 23 Sep 2026 05:11:15 -0700 (PDT)
X-Received: by 2002:a05:6102:2c82:b0:7a7:198a:c2c6 with SMTP id
 ada2fe7eead31-7ac1ea99e8fmr1676817137.36.1790165475048; 
 Wed, 23 Sep 2026 05:11:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d8590237sm555422e87.69.2026.09.23.05.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:11:12 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:11:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/15] drm/msm/a6xx: Honor perfmode_bw threshold on A8x
Message-ID: <yfpkgdcf3c366giiec6p4bjoutwepvtkjf3yushbgzeqe4uygw@pnddu3mbsmlb>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <20260923-hawi-gpu-v1-1-0c3c79a1a470@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-hawi-gpu-v1-1-0c3c79a1a470@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX7O8TWJAfY+en
 op+Dn3tRYr1tVZ7J5f+pU0bfUT170i9HSefOrKlVwDOepLA8OBzUZYKXXIw5dJLubkdG/zLfOA3
 jTEBxEGL5cuJPRhV4xRp1u6GmmJjGws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX0hzeSadi4a5k
 90mX122aR5ez+TpxahHvd8DFeXzjOH2jmO7qqv40Jq7EM1Db7eVjrhVdHe2D/vkKmUEspw8BDOw
 Uw/lkUh7/DJ3roSwU02W1KpEUBnAMatVzBl844/TAtwc87BDgbDhI6818WdicKTFwfLDmKdaSme
 siKESVLRWq1QooYh8G9zM305f2w8OfYIgXqDdEkYusKlleqUGx7nRO1j+NrlBDC8CerIGNzPUFL
 quzsC3MPQoT+RUGLr9mAcHcIvc8oq+49KVJalY7n01VLbDjnXocbFtwpsVkM19lWju0OMrPayvC
 upJJ1Yf4myQXxGTMRPTbLU86dR1Y4ApWvuH9np9gINXAN2zEpkv8VQV26Z7wEi9gBx0O47vSbwI
 aVsDXeY+m6q6dULeN8wPDX+EtasvBo6du2O6j8T70QBIyd8Jg/+ePGxD4++qhoS+WRj0IHbXD9F
 5xBbue/9XOXzXKlhVCA==
X-Proofpoint-ORIG-GUID: 4831Gi_r9iiSp3I-qVu_84rDHKlrdev5
X-Authority-Analysis: v=2.4 cv=aNFlOr9m c=1 sm=1 tr=0 ts=6ab3c1e4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=YJv5aonfaXPMDC4gfg4A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: 4831Gi_r9iiSp3I-qVu_84rDHKlrdev5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048
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

On Wed, Sep 23, 2026 at 03:55:41PM +0530, Akhil P Oommen wrote:
> Instead of voting ACV for all bw corners for A8x GPU, restrict it to BW
> votes above the perfmode_bw threshold, similar to the A7x GPUs.
> 
> Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 8 ++++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h | 5 +++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
