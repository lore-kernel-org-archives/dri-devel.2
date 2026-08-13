Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E500C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767DD10F3DE;
	Thu, 13 Aug 2026 16:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsiAbc8U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DIzJmAyi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8F410F3C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:06:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFU5sU3500729
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Z5QCS0LzCMHdHChJ5cMNSJzL
 +k+DFOwJ1h+R1Nhv55U=; b=KsiAbc8Uwz4mH7stLfth8VXzuLzjErnh4VjhhRao
 hqrO1R6cEjgn/O7r4pri85qHNOSc+HxpvwUnE2JsSznAg6ntVzFSrXcilzJvKsWe
 H+hToNJXChGh3TkUVDmEsFSxQDvoe8nZTsKZwTUrUsJMTRwU4MFxIR4YDJ1w27sn
 y1K8LInj75lKHp2T/2SJEjxggf+JiHiBoLej5/tmxhUy2ZXA6ixuCJYJb7FcfYA+
 mRdKcUhBkBHgg95lEROF35MxUUIRZp+RkhgJrdzeMHjlAPdNN2WgCOmddQyD0u8a
 uR3jSaGCvLNLCbrApqcFogUdKhdxPhXWoByN6o3Fr9Yh+w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18182k3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:06:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso1272771cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786637169; x=1787241969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z5QCS0LzCMHdHChJ5cMNSJzL+k+DFOwJ1h+R1Nhv55U=;
 b=DIzJmAyilPDjAFVAKdaYxDpjpmX8VSNsSJZ+d/GekGtBXuHCe9JWm7LBjHaGXQ+D8k
 G0a/GW5e8EcHqzM8swyWE1KshjqcKlkbixHsYDFRH53JWwJG3/RhX/45/vC9ksD8yFAX
 PKCfuQw0Fyc6iyMHTDvosTGHNfg+h5+pJv1JcoYGu1XHT2s5ccoJ/s2A6OXM1DOcVywQ
 CnyexMIQpRUBwqS5Gm3BFeKYH/YNS4fYFgEu0ajkXJ6ni9WJz+1kr6cioAWgQg108gYZ
 AMTr6Ole8Cf4TvntC5yngzQusByNlwU3dD3JxqbjikH+HtqvNbw7QWKWlYTGMctFmueF
 FxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786637169; x=1787241969;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z5QCS0LzCMHdHChJ5cMNSJzL+k+DFOwJ1h+R1Nhv55U=;
 b=W0Tg+xAWV2Fb26ppmNRsVm6makXJeU9IBYQBPrAZpeSp7em8AKLSZlnq6efkzf94np
 P9TCANm7SxdF1vEJoIcMP2rJ4P9/kuIsIU/Dw3FO7vTv8VHbpS6Vd1MT9eg6309ZkveH
 xrU+vOquxxt25sWsDw5kAlOtPrU2Ah0tErARwq4ROS2PL4iedrSAZCEKdUnK4lO+8rYT
 li7dA1Fm1Rupc6w7hQp1JM6mq07TOeZscPCNdyFvlMYZ10voi6KdwNHOqbSiXk/rDNoF
 iMqiOtKH+Ot81S8+GAcJfFuuE8I5Rg3AdLHPDmKJSYbXhwME+r2D98Nx+p+fUlCpDeDV
 CvDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAjL0IHGD4MBPPomoTINVWkRUYt9Ki/R76Fpi3qxpgmMi8vzh5GA6rMo3q7ryXDdUONxYF1v/VJBE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+OJ/+AnSf9P55Mm6Ds7DFz9tAb2QYLCGGlXUfCFEpQHulRE8E
 yQDCzWUZ+Ik8x/497ueiD4yf/khPGjfIHzPJH6zgqPy55IVm4l92L9KxtQKREyVSV7vLlIG0V6e
 apaJbk3WKdmNB5YQKmQ+TkkEu175B8rX0rQXTT5sv3fe2SG4npKBgEpT4en9pXWOXoD2upzg=
X-Gm-Gg: AR+sD10anz/XiDtKNea4k9QAtjAAoZdpNZCTP32hkkph7fQYrccAcbe5yVvGnsJVOaZ
 CbtCqcsH/jb58rlZ4rSNk7GYR1Hs/LIqB4GvYh5KbM5xOP3BmZL1Nf8LX5iKJSGANcdpeaUQeqN
 +9K9SqZuUSUXRqABFSLbr1TTBCEV3IQXfkjAQdqbZLMsRqoamQ+IBwVcmvpVIWk2yQLr2E5ldbz
 cnnK3EZ8xWyQd0qYaVjpDR5pNN0R8fZjHc1mhc9/I609T0jUopnZj7ko1pIyEt0UWhgwC1ceD8S
 gUCu8vTEqB+MaxKAdp28Q6AfXC1t+edY5t1ifV01D6pKjESKvpX7AhnOcEmJU4swy/w2TOa5iwO
 t1L/WBbfC5lmtbvuB+NbzB0kMeQ6tP9VX4G7TzsXlVSxwF996RXCwT0J7TCrWKfePOtkaEdLJ5/
 ewxbB3iZCXm1IU
X-Received: by 2002:a05:622a:4818:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-52d73c0f303mr76159051cf.11.1786637168643; 
 Thu, 13 Aug 2026 09:06:08 -0700 (PDT)
X-Received: by 2002:a05:622a:4818:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-52d73c0f303mr76157761cf.11.1786637167971; 
 Thu, 13 Aug 2026 09:06:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a130cd9086sm359111fa.23.2026.08.13.09.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:06:06 -0700 (PDT)
Date: Thu, 13 Aug 2026 19:06:03 +0300
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8750-mtp: Enable Adreno 830 GPU
Message-ID: <ewc7lex7wi6g7ukq6xijieikuq3saw34b3hezfbr5776zmgxcc@upndudhd2bvb>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
 <20260809-pakala-gpu-v1-5-207ad1fac1c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260809-pakala-gpu-v1-5-207ad1fac1c7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX5qZupisqKHYl
 BdDd6RpqjWIG9FPNhU6y8y9jgof/4D5adO1cby3zSmGnwNJZ89d6tQb8q6CdfgyuB+AUXuSR6OG
 Fa4krRw7qzV6M06iuNhR3DQQ9cx4gHM=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7deb71 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=UQAiW8fk4jwks4S4FoYA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: GgAvlCARnT2k5M8wOGnjE_yE8wQsAS2m
X-Proofpoint-ORIG-GUID: GgAvlCARnT2k5M8wOGnjE_yE8wQsAS2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX4i1RYxA6SPN2
 qR3sOKp3a6vaOHUq1LFfHgl823VNVh8aWaq8zN3aW1P3Fe6SpFSocGD66wPgmTugaofsA4rDwE2
 6JeeMWZJ5aSRK6+jol+/w4u/bwagLzxPNuJXpp0x8uvlsH57czFS7kzlK78hGxnhg6U/kQEifnF
 3ng+ZkYqiRg+AZqdpIMSvbuyQpYsv3Y3glCFs6zitymTKshDgIkBOR1yYxla1iSOJkkRBM53B5Y
 hAH+dgTY7TiwLiEkTY45myB6wfV3tAO2cvzv3TNOgm6DsI1pRI/Axo4ZZL9PwWCBPhXMtusMZoJ
 DiRQYjUdcsGmmhFSs6bztXERFxRM47yrYw7L/I4Ks3HdnRcZzAy9eK3upTANFurUp0H4Z1cP5ku
 paD/4PeTvCxZxBRH4/c5q4eFTOb1fvwWzk1LKHiA10pi0i6MNDHdmUNPxdHlKGI293uAj5kakVM
 7WbqvBS7RzJNiEjcyrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130115
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

On Sun, Aug 09, 2026 at 01:53:12AM +0530, Akhil P Oommen wrote:
> From: Jie Zhang <jie.zhang@oss.qualcomm.com>
> 
> Enable GPU for sm8750-mtp platform and provide path for zap
> shader.
> 
> Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
