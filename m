Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E59B10F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD9910ED83;
	Fri, 27 Mar 2026 19:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ggNdGbRp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JV4Rk3a9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445B110ED83
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:42:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2rFk4031035
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qbhnR2aHPiZPhzlyeNXiBA5tvmfsHM3QRYGntWNCKiw=; b=ggNdGbRplv4IKHb+
 MMrfRDPPRfobV6tjaUGjD8IeAqyxMnSceY4FsiRhzdLteOICvIcaBrkGRVKasXxK
 9UF9E95aFfm1D9kZHEUdGSA+rA9hPsrzQGawfIQg6ZmxADR4uiTNuoz5QG/ZQRfR
 JHVY/BIn40cSMCYMrzqrHXK1VOYdx/iOXXw2FB8QVZnGaDNJwEcb41lhRquXrPC+
 MoB7Mo40DTLPYguGvaZLaLVDKGOyu/PzOY7FvYN1sGY0VH97n3tKMUruD/HM2llV
 JIGdjoZlRCY5VghhyQq9pomkEA1RvVX/3eyXm7hzUK/5aYmJKjdELymTSSWAa6uf
 QVS40A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5v6b0xjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:42:09 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b34223670so54347471cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640529; x=1775245329;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qbhnR2aHPiZPhzlyeNXiBA5tvmfsHM3QRYGntWNCKiw=;
 b=JV4Rk3a9HfbDY2iQBT2c58cAAjBCD53uKzXAb+/nKppMG5vC1FkIsE1VNoECzPPGQX
 TKlx8V5fT5ho0abVk+tjvDS1rprbMeMceLrLt937LsjlKXSYrb7Sp0cSbHW1YE1+TPsD
 JxjAy6HwBCwnBsumyUcS+k9CVUz0We0kY46nwDeXnSQQ3MMXFjQBFC8Qm5O3xUdxNZbD
 gCTkd5/18Hfh1z1Yd7GA6O4ku+BSn4guMn703Z1ly6hLl6Wdd2VeFn2u56dkIayfxTQs
 8dCsKuT5HNg49dAZog+VJjIJOcQc5olbxUXhPjc+/CHE7YMZzZ+DwYEui4Ao+UeSabFW
 59ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640529; x=1775245329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qbhnR2aHPiZPhzlyeNXiBA5tvmfsHM3QRYGntWNCKiw=;
 b=IysAb1AA3dixY9TTZQHjeimS1Wat6uKRR3fizY1U8TisZVmGupsdGpd0pfCIt7JS1g
 vAHOKdOMlDWlGOxhcA5XCWBQ1G7XKf6oVBXyOgQIDQHJKIch6tgedJLpoTLyCZPcD03S
 PDzcbH7vF30bX3hSxKwzcgznC4u1ypKMh/z/xfO+e3qaCxcfmytRj6sXLov+wiKmXpqb
 eEscZNsFIGmlVgYVMrMtMq5vCEHzPh3YZxRzggcZWYubAsNSC1Ri+CYVvbHxIINvmwMw
 a4h1cGad3Fx4jmvs4HUu7eXb6TIRIu+ZDQPSBbEeSU8lFuswmcdncDW6gkou9zKaTd5g
 uCRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8jkeuhdARZaeIAqp1Tk1NweuEtnUJb1LfGDNRJE+Z9RI4+MxEI+4yWTTWsIfcf6A/lQeMAE/V0T0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyscC1WnZrUHApZ6uWLDY4YPghLuxVXA9bVXrB56ZQ+JO4JZJU0
 BaSD0iCYMsX1Lfov3aDJc7t+j6QtmoUKYP/q30CQN5W8JzWPdGDrcqS/3FhIIX7wtXEFrezHn9i
 o1kXwHOgl0obk/q2qaEfvU7yjEEHooFd+0BCIZor4nO6XYfbgK8YT71iCkQgIh+FJmQ1xj3A=
X-Gm-Gg: ATEYQzyvvL+HergThvhpo9K2euwftcMYjnbyRV6IbWCFTlc8aGa95uJOisFWAEuFwmy
 zCuQ8EyWOg2EAMKAjwQ47XDqCYioYLd/La9buoJE8ursXgk0ONosJV4lDbodcSKnziQlwvJj+2u
 iwtfiFAgD3asoWkfBbnvRt3j5VOtTfy/JWFBmp2CuLpfLCw9ro3McQ50vh2y1g44RzOq9KXqZ5H
 y4aM6KujSp9x3MnDdf08QF7VGV2U/4aC50Xbl+kvRO8p5ZHTKFBBde5xscCp6nOqaxObYGeI5QH
 eXkjR6zjGKCeNwpRJdmiPzLxHBX7NAd19NVa23Y4gtIlwUlLu40lXwTWNCxQcwfG0bD94sxO3Ar
 bbTqo7ZT+Lhnsw6aaaNe69qKA24Re/OGwGGSYHKV/6QqAVm0vTM9w80ALVSx5A2Ogp/VGCd05dm
 q6cmsECWn5mraI8rkynxS9F2v3MNG1b+c5oc8=
X-Received: by 2002:ac8:5c82:0:b0:50b:8fed:a947 with SMTP id
 d75a77b69052e-50ba38354dcmr52043861cf.19.1774640528729; 
 Fri, 27 Mar 2026 12:42:08 -0700 (PDT)
X-Received: by 2002:ac8:5c82:0:b0:50b:8fed:a947 with SMTP id
 d75a77b69052e-50ba38354dcmr52043431cf.19.1774640528220; 
 Fri, 27 Mar 2026 12:42:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2a063ef50sm1601052e87.11.2026.03.27.12.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:42:07 -0700 (PDT)
Date: Fri, 27 Mar 2026 21:42:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/9] media: iris: retrieve UBWC platform configuration
Message-ID: <cshlsxb4fj6piuxadtxvxl5rgnl4aljqqrojl5wkp5oew5ynxy@ah3eo4aexe5n>
References: <20260125-iris-ubwc-v4-0-1ff30644ac81@oss.qualcomm.com>
 <20260125-iris-ubwc-v4-3-1ff30644ac81@oss.qualcomm.com>
 <56860faf-3f74-daeb-3d19-a35243172317@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56860faf-3f74-daeb-3d19-a35243172317@oss.qualcomm.com>
X-Proofpoint-GUID: dLI4DPzCJg1Y7LsRNiuhgmq12wtk7_Je
X-Proofpoint-ORIG-GUID: dLI4DPzCJg1Y7LsRNiuhgmq12wtk7_Je
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzNyBTYWx0ZWRfX6zc9FT6Kuoow
 wzfzVdlMs2E4cCmOfdxCmeSTfoFbcPE9/Nakt2l0uHpM2vMH2kVBjg6Bc0O0eiSPoP39PPYzwxg
 HkhTr3vqJiYu0jLi11PP88CyLQCnfXMQxNFPIs3NaCHS5AWhAuh/0Jys0jkzWoyygzbM50DCTJt
 VzPae9ZB8u1oUxT3iAGhzv5UD647kijBuJ26MqmXjaK1I+aGOKBxpfU6iDX7Mtzv0TZND9p+ddl
 jz1XQWkLYoltNHfn+0Hsb57tDJQ3eOybmLpeo2PSInDeOwFPw9XcdmyFDQX98Nlt91p14wb2j2P
 EnM4eHnkYLAfJqmReVKR1Jwai4i9+K1hiDiTQzlW2H9YLOXyv/eWChbXmXnh3f8sCPWoNT0xJ6T
 1ehjCPACZmVUht/vpGtyjJd8ZSDj0EolBp9fAWRJOEJ3HF/8VkPjoS2zrXktFy8qIyVJIvaCShM
 gNwnuimX+mi+MG+IlJg==
X-Authority-Analysis: v=2.4 cv=JLs2csKb c=1 sm=1 tr=0 ts=69c6dd91 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=YMpIk7VpW_7b69MrPvIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270137
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

On Thu, Mar 26, 2026 at 10:36:05AM +0530, Dikshita Agarwal wrote:
> 
> 
> On 1/25/2026 5:00 PM, Dmitry Baryshkov wrote:
> > Specifying UBWC data in each driver doesn't scale and is prone to
> > errors. Request UBWC data from the central database in preparation to
> > using it through the rest of the driver.
> > 
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> > Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/Kconfig      | 1 +
> >  drivers/media/platform/qcom/iris/iris_core.h  | 4 ++++
> >  drivers/media/platform/qcom/iris/iris_probe.c | 5 +++++
> >  3 files changed, 10 insertions(+)
> > 
> > @@ -244,6 +245,10 @@ static int iris_probe(struct platform_device *pdev)
> >  
> >  	core->iris_platform_data = of_device_get_match_data(core->dev);
> >  
> > +	core->ubwc_cfg = qcom_ubwc_config_get_data();
> > +	if (IS_ERR(core->ubwc_cfg))
> > +		return PTR_ERR(core->ubwc_cfg);
> 
> Afterthought: This change assumes that the presence of a UBWC config
> implies Iris UBWC support. However, some platforms (e.g. qcm2290) do have
> UBWC data defined at the SoC level but do not support UBWC in the video
> firmware, which could potentially surface during SYS_INIT if UBWC is
> advertised unconditionally, so this might be worth double‑checking.

No, this change implies that the lack of the UBWC config is an error for
modern platforms (which it is anyway).

-- 
With best wishes
Dmitry
