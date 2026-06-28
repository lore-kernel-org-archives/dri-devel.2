Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9120C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 22:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1421C10E67B;
	Sun, 28 Jun 2026 22:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IVTj4Z6w";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kr7H1yW5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E90E010E67B
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:54:05 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SM9P0o946921
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qaaIg3gvt+W7J5Dpnsp8EdV5
 SRcVyaxwovZUztMqYmM=; b=IVTj4Z6w48vDnABsrjEnb363TqfizJ+SNkX0KG6E
 XLKlk2hyKGozaj8SZ3OT0/Nenbli2kQMw7PIRzIyG2Wybv3CEC3TpRtig0023lvM
 wvTCfKvokAjF8rIxyx1ULFNUmunw2mDYeZuYqP/hNDXkoEV/LvkpJddGPGzWn5wS
 U+LAqFEgwMks/TqoY/12WvTSGaXSJGUiN8HMyMzqllue4V37eDb4BeHCdasWgyyi
 zxdvWOuW/HN1RbGkOm2maJ83M38RCA+66D7NTZ3NUPrQymz70Ue6BVw/4b3TnYuv
 9qPGRYUNyXM5WfZT/I0R50loFRbaf6sk6PGWZxxDyGYnTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7ukur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 22:54:05 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ec235c7c66so19403856d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782687244; x=1783292044;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qaaIg3gvt+W7J5Dpnsp8EdV5SRcVyaxwovZUztMqYmM=;
 b=Kr7H1yW5Uv2g80gw5/4gpTL5OSbc1nb5tJRFVrtzeZj3PDmVRDytZcFCx0vLh/708Z
 O6wVWb74HLBvDO3TVJsyCGfDV02a/Mev8hYfyQUoCaNF1RPDRtBvO/ZXOjdqbvHGRyDq
 eVdtWf+wPCedF9vNR2glpjfnP+QFlAwAdVkCSUH2N3iLQPiNtW721oWZ8nGJWJKn3pkw
 vOp8FEFUnzx8iPgjNVaNnXp6QuotUTs6BfFd+OZF6XiWprn64Q1F1qXIfltn5amPRgYQ
 lL//uac1uIVOq46lONjTf3dhrRqDOTe3Eoiv1ajkxcVk1Jgz8zuGyHk//q4f8bal+X9G
 5f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782687244; x=1783292044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qaaIg3gvt+W7J5Dpnsp8EdV5SRcVyaxwovZUztMqYmM=;
 b=kEzPFmwQAtMzhCUWZ3K85PCtZSFq/KjjRSEziFI1rA9iQ3DX4SjtKv8ko+N+mJ55bI
 0wM/DP4WRFBjFL0pAZLVmefkCvCkDoGF6S94IZRCn2y8irDxeur2GTdgkRDW7I6qHweY
 Iz0SeCUW2Mdzl1vfiKSmGCwRqMAEqLc6yDpbioudCNqvQAEsGMqBqC8Izb5/25zd7EIT
 paJOKPO80y8PreQRiygzC+Ndp1SGaBq2R21BLo/ulVntKFXTjtpfoBmT1IDbnW9nQKMT
 kl/ZQKApERiqNGObmGpkvIIhB41a4+5d3xpVy10htU+O25lUZljHNby3OpjFf3ZVx/To
 ylwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cap/eD3S3QbshGAE0imCF2sDOXhSrWFRfACWYrltRn0YE2VsoN5PFK2cjzYYZ5ArhJc9P22BVSps=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/00fBg1vle76M3NrQg8QJ8ouGAtKfzyedW1SRLRMvCt4YlKfE
 YPDmWiYtkrIsWzMn1wthaiVjGPXK1aiDY3qLWzBFte2NJ4EF3ZnKpmGSmMWun6KPPoUvsoGbtBe
 TZXhqoCVOskYAwXUKTX+WEzvBo2HdoZmExK0/oYWJjvewzhlLDI/U8AlN57ZOE7D2YnmiGXw=
X-Gm-Gg: AfdE7cmbaWKtItoxct5zMaY+dt4hKFJwZAnrXzKvFBt8k5bqhZW83X430PTVioEx/d5
 W2dmqmc/9jU2tqOt2tglFanAGKiZIbWHigKhlbQCiXt6zdDhfyAsyqxSCNEgzhiYATQ6BPTJCdD
 M7VJaG1luCrNjTJ79Q+2d/zztMYzzuLmRsZ7XhzaU+LxJ2wZ+r9cJxQBalI6kNhNXL+SpQt4LwS
 2cOuasEezzyr3/SklQxjaKzbNHA1NcUBQTwNVEpd/HUYOCjH8qRmLm5KcPrEJPZYF5gUF2fgqdi
 B8yP4IBm4fKI7Kh9VwW7k1OBEGC3ioeM8x1ZtnRB2J9k/glt25OE4uf43vujlZwuvJ5Wpuw8Qsd
 yGifXzekxeC/g5qHJ7cG3ESBFBw8foqv+PyFD9Pzx9Oq7n992VUgfF1nWQRBmDDnhWOgtaFec7m
 RH2vxSPttaOb/2sf8U5wiccT5x
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id
 af79cd13be357-92e51ee8ae6mr177012585a.30.1782687244478; 
 Sun, 28 Jun 2026 15:54:04 -0700 (PDT)
X-Received: by 2002:a05:620a:414c:b0:92e:51ee:7945 with SMTP id
 af79cd13be357-92e51ee8ae6mr177010785a.30.1782687243961; 
 Sun, 28 Jun 2026 15:54:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad69585b6bsm5327111e87.80.2026.06.28.15.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 15:54:01 -0700 (PDT)
Date: Mon, 29 Jun 2026 01:53:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Aditya Sherawat <asherawa@qti.qualcomm.com>
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: shikra-iqs-evk: Enable A704 GPU
Message-ID: <kz5fw4hqblmumabhooyupyxqmfwadkas57brxs2qxvnbn37v6r@jjrmk5ckqbc7>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
 <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-shikra-gpu-v3-8-9b28a3b167e1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfX346M9FxA48nO
 pKUvWox9KfOAyULnGqG1/D8LSzy6emvvS9E536+dL8uRzYaCXhNxfmjS+0B27epUlVVfT8EkapO
 6DAdbWMiB9sTh7tn49eyF3QGVn3PHS+FIMwmYxGd00qSE+o8QIGe3STcJzD9/X0G+KV/jQlHyG1
 s26Yfn6Fyndt6QiVvFbvQbGmO+df6r4rEk0da2KWeG7DXUQ8i/kaMYcIINdczFBOhzM+/MpqJh5
 8DEXLPAFZJbueX6xcupBYEYQSn3bSvf9BStfmqkCSl+Ud6UFz1AVTi3y3zPQAaYVq5bLtPtPp0u
 7TG8Llkn3tyWiTM1EMF7gds5/Qd92D8/EzcGAoK8jd6hgTvybjnX8qKbHjiSSmXZJnSIz43fGoC
 H6jk/NaXn5gNIEQtUM2ILtNiow7lo1Rv2vLgYEKgFBr+ufE7X6TY9QIF1RMC/Xw32nT320HC2zp
 HfSzvsjkYqiQ4tTlwCg==
X-Proofpoint-GUID: 4U-N_BHZydk0mPTmEfYBt66unLzyuEUU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDIwNyBTYWx0ZWRfXysQ7JG0rPr9G
 bUCoi8st8HZtDsfqpeBWX/dBjMWqbEthj9YFVzZP1XAqIqXVTUTKU7eSOhsn7nT7u6bUQWRHTjK
 aLbTzs9EKOgNWqeSLVJ1Ox1FHH8Crug=
X-Proofpoint-ORIG-GUID: 4U-N_BHZydk0mPTmEfYBt66unLzyuEUU
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a41a60d cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280207
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

On Sun, Jun 28, 2026 at 11:54:01PM +0530, Akhil P Oommen wrote:
> From: Aditya Sherawat <asherawa@qti.qualcomm.com>
> 
> Enable the A704 GPU and configure its zap-shader firmware on the
> Shikra IQS EVK board.
> 
> Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
