Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E7C88E64
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCA210E640;
	Sun, 13 Sep 2026 23:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hx+8GYib";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d4ggkDhJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044D310E570
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:47:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNZLxY2963612
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=cmOd/wtJBwDY+aB9upH1uIT8
 B7lNgLS/AKryTS4QZfQ=; b=hx+8GYib+ZSJR2XplPITMr2FMSVazDbcRgI1G5C0
 MZrAOyPg3Ub5sE3XWE/7QYp8XUCb65kofTRdd6UyY7xmGpOQNq+mtAXV406YoN8t
 sRAEub4enFRNX5Eqo0WoHPOUw7QAzSEJMoy6wJgvsmPjOVlq1GH0FsheffvcZO+y
 iMIFhMq/lahMqvzqGo/fdcgtsCxWOb3SAXMXxiHlsOjxJFH5IlMQX4bi79k6ERdu
 LGdxL0N4r3p8g3aUZzl5EWgg0Pv1y9z6UD/9Ta5dJ7HMEd23WlxWPOzcN4s42R5Y
 fc3RuWZIK1QdPn21WPFCWnPKGwipDY0JsOpSq1j6qSQaAw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dcbf0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:47:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e9c9e23d8so2058754241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789343245; x=1789948045;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cmOd/wtJBwDY+aB9upH1uIT8B7lNgLS/AKryTS4QZfQ=;
 b=d4ggkDhJ0CjLT5beo4Ggl4ykmudwsTGTW9wYrUR7aPqipLmGbGeley1XXwP+uPwu1x
 OP5CaKh+zvJiVWVVx+WGFs+TEjjYMERFFRmXkwDJIk2q+SJCMc0TsTbCwR4B1Q+YvwjF
 K9nAufKHKF00eF1Vqyyw5nsq9iMAkjIlVZwh4wYxTqTvFtUJ8HDv7KVNl/rhZB6EGZeJ
 RLKxIt6uHwMZGeb7peris0Y0g+1KWZ3c4u9Eq89RzeZY0Sq3JLzXGLBtLH10WDEie+kP
 6S5MVmdZjcoya6pspu/69WvErkyn4aRXBy2/GsgKk92nvM+dqg+p8Qrxx9TL1RUgGBaE
 5Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789343245; x=1789948045;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cmOd/wtJBwDY+aB9upH1uIT8B7lNgLS/AKryTS4QZfQ=;
 b=LE8fRbuJu39KAIVXxRhMBxfGlk04Cq5/D66DxPw7BhPZM3K+eFRUpA21HEQMIH2/m7
 rnEoY7r7oVmu6qQYIvP9JhWxQPFYghvn1977GA0Xm02fSTXQaJII5nGHy5YQuJ74tYTG
 3e+fjR3ZpdJE/a31QoBvUhnR1/4juqPxVQpLWxSuDfKhwl25VoQ0w350eCiGAVU+KBC9
 fubqdo6adX0vvqHG7gm4OaiXPly3L7Y5os6Lb2LNyycSoWdCJlOHyTznQ0MtdXKrGgoo
 HZV+i2Q70kKfSG6pr15CdcLqg5PqAnfhOOcmtDGebAYsloqbP7MCzv93RQS7cnycq69l
 C2UA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwC2iY/9wH2o6sTlmLWW7xDuzTTAtW5NUgqRUuFcXFQajQKtjGkknv+38FXofTD0CZK0yI633XLYOU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngxvCEpNLi09QzsyMqjiPIR/UdOcHty/JMx8opnAhEi3t3XEkC
 Kz51kTXpt2Bhtk7YdKj5GsWbUAORFfHpsOrCTg7xPlRzLsBJOim4XQad7h9vDaWH1WdoSZCmf/Y
 qvCRr4tcZzIYNLPC1/6xsv67bwF2CKKmhGeHB8sWjj3+gO6sd6WWmyYLsrzddt+L6OA0NA3o=
X-Gm-Gg: AYBFou1iF2DyBO9oPm6tMTArm7AL/fkRbLFmzYdoM7ZF9ory9SJDV7Gxh7pmfPGkMkZ
 LH+lYDEmi3SYvw7qpqK3LY4lj6NI8eB/EBYa6D3sJGY7iQTiSBO1BFLp3mp4IFKqR/tW3aL41Ss
 u9m4ScuILfKrcmMaettTvYCL4CAEU6hRxC3C+XWIatHnL+XC+7wC4q+5JCOsx/Rp3xZANLWq79g
 gKY2t2GheHfCLkn/XH47fsJgKiwFw+TjvYOxGD65E49KzFi5hSlmXrpBKfsq/tbRWRf7mWpIGvL
 OGS0/BBy8zJkWYqQby0iy6eLKpLNBQU9ifSR5/gG5q4MKQxIIZtNpSa9/DxtSqVyi9BdtH1SvW8
 qGcY2aXQjrkxOSami2ly4FAdrk1WWf++M3J3Rfefa1i0eLbz0Wn52Rs97ZB08ngiWcdlCJ6ka0q
 eQyE8pu6ZozYWr
X-Received: by 2002:a05:6102:918:b0:786:dfa:c5ea with SMTP id
 ada2fe7eead31-79b57cb42f6mr40911137.5.1789343244867; 
 Sun, 13 Sep 2026 16:47:24 -0700 (PDT)
X-Received: by 2002:a05:6102:918:b0:786:dfa:c5ea with SMTP id
 ada2fe7eead31-79b57cb42f6mr40887137.5.1789343244498; 
 Sun, 13 Sep 2026 16:47:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a33263e0sm21888431fa.15.2026.09.13.16.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:47:21 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:47:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 05/17] drm/msm: mdss: Add support for MDSS on Nord
Message-ID: <xmrrgh62hk4kdhfxt4xa5ngn7kc4f3p44dpvf2yfqdhkoxlis6@iftzpwpcc3qk>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-5-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-5-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0MSBTYWx0ZWRfX+sn8fgbiF/C+
 ZoDWrlh69+UH8WMzhpKl69c7AZNK2dsK92OeEZwgruP9uJcciSQ4C6cxWcfoX2W1MB2IY89YRWK
 dees7jnnP+zNazBsSyWqLR21T8vpeD9zbri0eGfacOa4q4VKeAwCDAmrFGqJ7+rjIx5YG+jKtKq
 z8arLkDXCoHyIinP336LvPaBhgyRYb28WiIEw5JZuU5gDdEhhHYAIi3aipeIh2ha2wy+cr/g/53
 H8aPo/SXkV32Tn8O3w2N3M6GPG9v3KAksgcCv+SYbxZa7X7JZkHTuXlV3wjXfI4Ez/caOlTiqHT
 yPpIR5mtN2HCYlmyhBzk53miNZ+OlSn63tTBsDxfxI4fBRScfYSipMlfDuZXk6+bGK6b90VmJK2
 j8i0/EBCtt3N0stslJbVDGPJTs+abeCxej1r+Ur+tPUzIN4uaixEZ37ZB4FK/6VtF70ZJDN8d4o
 1bjUXulSRsm1p5GmdBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0MSBTYWx0ZWRfXypTPv6gpgv3I
 nRvwgdi+i3690Zz/Q2cO/GUGRMA/ecg5mzhiTuvN+Luj2EGsr1btfZMQEd6FcpTcazNaUG39SMp
 GwztIZ7zq4tYJARI2Olf39oAPNP2w7o=
X-Proofpoint-GUID: S7sN4cWfCwQZWcqjvXW_AQIGY9oV4XYY
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa7360d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ReDZFTIDzEE4zWO0opkA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: S7sN4cWfCwQZWcqjvXW_AQIGY9oV4XYY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130341
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

On Fri, Sep 11, 2026 at 09:06:36PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the MDSS compatible for the Qualcomm Nord SoC, reusing the 57 MBps
> register bus bandwidth setting shared with the other recent platforms.

Why?

> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index 9087c4b290db..90bcc8c28dc2 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -531,6 +531,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
>  	{ .compatible = "qcom,milos-mdss", .data = &data_14k },
>  	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
> +	{ .compatible = "qcom,nord-mdss", .data = &data_57k },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
>  	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
>  	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
