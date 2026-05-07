Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492CBCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA4F10E202;
	Thu,  7 May 2026 09:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaj2kPf7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrzLypE4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B7D10E202
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:10:44 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475wTm21926229
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fiLRyqVWGS0Ix+7Et8ZETjKI
 EZ4pzdPJfw5gz/TlT3w=; b=aaj2kPf7Vt70KA2i3+8H5rqr4GaTBRUxUXfFCAIX
 1wdBO8jPUfsMqMrznswtbQ2P2Sc+PW6u3Lv/QSqcGF6r0+iMf3u3kaQtK6o9hdEQ
 CbqLEGnxg2KU0oLYXWLl4EXauJIGscXmUQ7FkaJ5ATmeVNCi9CPdyPreNdMhujls
 lo2BJ7dWx4/ULLNGvksEnomZ1gSIjLo9AVuTUsGBgxibOK+a9ikaCy7nV2o1vnKy
 +7+q98leDPrDHpE1aow5LsCT1+nLVzy8Pwfnb6CvPbz7NcYllukprl0QwQL2LNMG
 cMQ0cNd/S3qW7IY5fCfePp5fy9uOvRNQhHlP8BRedEPrmQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0n2g8qrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:10:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eaec5f60edso96808285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778145043; x=1778749843;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fiLRyqVWGS0Ix+7Et8ZETjKIEZ4pzdPJfw5gz/TlT3w=;
 b=FrzLypE4+wQYt2a91Zf14JkK+apC1wL6coq7ypLABGOS3dsDAzi6dfDLPvT0RzOohd
 ZVLmRlo8l4AWJfopTiRInJvkmWvKpEyDR9WEeg9e+k0Als6X/8wQcUGZYC4Xc4dclkdQ
 G2RGBD2hbhmVOtthh5iROGfWoE8gUeDgs+3TLsM5vu4AOy6QXnz5gzOXqiaqeekWj3JB
 RrQ3IB+4XWW1pzd0LIm14FE2vov9SwMykkuLr8+A/rtYrLKECdAqzyrQstAB/JNrKCwZ
 gM6wwtiS+pqLXg+jy+gzZ3JrMtttAxz8Ss/Dg7Nb+C42SEgevR330Yn72T9MKjvTSI2G
 GKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778145043; x=1778749843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiLRyqVWGS0Ix+7Et8ZETjKIEZ4pzdPJfw5gz/TlT3w=;
 b=PAoBIwXH8q+e7PCI3E38gvvm59A173VXk3sL+n+yADFoTTv2ECRn0FG3dAGzRqpOMc
 ExE03KB5VsZM+ITexeB8BpCL6/rChSOQcy8bQVsgMpkqkc+OE+RX4KyRXjEBgFa6iOYX
 6VriJSkp7Wni4DkRI+wwlZJ+r7anxOX1F9QUs/MudgvHCIfOrpE1h4GfUA0ghF6WHw7F
 94dFRg1nnvxOXLRqA2wM9f6GJgVv+DP4oBt6q20ZEDpxWQRwk+4fCEF4PjAWQUTrpoF6
 V7AcZzVKE9sIhmpWr/CyOrg8vdyGXpPX6UCs3uSVsWaGaEC0CKkkpaSNkQDeTJ1vtM40
 hiSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8OrZj89GKiy+oOeuJeflgS59PcQbswgVa+hpNasdwe9a6RdMmk0/rrxl4AA857Rkw83dxaX+fSqOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfmtBwkdpAdaesquq0Nyj7+wvUn34KM6sP/ZVAT5FzgViYmjj4
 EydFtLBMuysmLxfM4EnODSEF04LLexEPnT2NKemYX+WAmw/7w3puioSjfGHGAbn2v+ifHvGlDTx
 869wVkrgJeCKpiRdSs3wUaj5kuhi4VM+dQSVpqhVblxf5BSi24meIOPTBZ1g+CjBtha4AbjU=
X-Gm-Gg: AeBDieu46eBkVTiK9N7gI9dDzYshsAMNLH3Qt9OJPcQ+7LIKuivglUeHjqAgbLHRhEv
 eMFGbYlIbZ3aKW4cxUAIZJGkzv9dpy5ClbcMW7B9anyNqvZ2QdT6M4eH6vTkkCZja427xMcmfeC
 H6s9X/jyRknP3jxqLbUP9pMS1qG6alipOmzqm2+ULajn4W0r9jO0D0jh7v3QimvXyrZDHcQPO3X
 8V7ucHZa/TJwAlcgL1uLMB47/fFCjdXGElIO8vCpWvZRsfMa18mFvR+7UerZoYjWq+TbNlPTL2c
 ywqpQqawVzYqdSluRWQwLZe/i6PUiSNpEMnkipSxGeoNSt5vHKMte0XRkU4rbV1M+TUT67A6xkK
 RRsGZtaZxDpEVAnq39ZgqPhkvlGs17Q0OgqqE4A+hW3UWZZmGKkArWBiqbxbqJmiFRsqOk1LlA9
 UyEjNs/DBaGQjXW20GTorhyBY7Y4MKfSGFd1nc77CHg9OCtvIOS/DXZydg
X-Received: by 2002:a05:620a:2848:b0:8d0:82e:7423 with SMTP id
 af79cd13be357-904d69d8e00mr989745185a.44.1778145043102; 
 Thu, 07 May 2026 02:10:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2848:b0:8d0:82e:7423 with SMTP id
 af79cd13be357-904d69d8e00mr989741085a.44.1778145042666; 
 Thu, 07 May 2026 02:10:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86e65fdf6sm3822632e87.78.2026.05.07.02.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:10:40 -0700 (PDT)
Date: Thu, 7 May 2026 12:10:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, jonathanh@nvidia.com,
 thierry.reding@kernel.org, digetx@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
Message-ID: <mplk3qvyslzazuolwlcgy6fb6ta7ts63x3dq5wwybyejaxpyh3@fctfzjkyxi55>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Wv4b99fv c=1 sm=1 tr=0 ts=69fc5714 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=RJIkCpciCD5dGSa3Y80A:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 2Oh0SfYRsACXEkUzNqCRbpV__WjQVyB_
X-Proofpoint-GUID: 2Oh0SfYRsACXEkUzNqCRbpV__WjQVyB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA5MCBTYWx0ZWRfXyB4BrM5E0thB
 iQOBNOMX0iwq13Mbjw9b/0faCnrN3ueuZdWljmVUDkrPz7VMpFKwZInoPvCuZPXD0Ky5aDZtiEF
 V8nZq808mnG2mA6RZS0vpkE9xVOOfs6gXh3iqLwcyhctFJ7QcrdFxh+SI5+Pmxsd8L73W9MOdJd
 EPdxO3aZacHfZug/Dqx5h9dOYkQ3IzmwQUSnIlJ0ro419TI+0DFvD5js48Y74w2PKWSqFgsQYQ4
 UXzplGQp38epK4V6eTYFcsGG/PplRU7fvHUShRx9Mdkhq+dCR6bFXQ+GEhY6F22ON41ATbV26gm
 KCcEe/7YXA6AxJn5hJOtXS72IXyfkx21MC8TOnaahNTPeLrXYPVrheMtGPZ4lXqQR60KOOBdHzG
 gojZGQ5MOsh4n6w+K9CRd+okywL0UqMFZqetHIqdI7dNIm6jXIxBPqbo3ELIx040X/C7/63N3mN
 ycc3pSAFHRBV+E+cAyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070090
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

On Thu, May 07, 2026 at 11:52:29AM +0530, Sibi Sankar wrote:
> The QCOM SCMI vendor protocol provides a generic way of exposing a number of
> Qualcomm SoC specific features (like memory bus scaling) through a mixture of
> pre-determined algorithm strings and param_id pairs hosted on the SCMI
> controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
> mechanism to control the various caches and ram is hosted on the CPU Control
> Processor (CPUCP) and the method to tweak and start the governor is exposed
> through the QCOM SCMI Generic Extension Protocol.


Could you please clarify, does this apply to the common commercial
Glymur and Hamoa laptops?

-- 
With best wishes
Dmitry
