Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D8CC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B0C10E3CD;
	Sun, 13 Sep 2026 23:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLIn0b1p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EFGocWay";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C7810E3CD
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:30:04 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK0BKY3218122
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Nj6aKZsVdCtHBveKqJbFsHIv
 5njnLbiwoSwtuNudUX8=; b=BLIn0b1pzYHzxP2Lv8g7Ru4r+UzUaWwIzfJTe7C5
 Gco5h/Y/50+2s8218SsY6pJwkOj0Tj9Argy9lEkx9KeQY9BB4rzOHhIPt1Dpsbns
 tcMOrz4D9I9ubaNrCCi0sKJmgE0xDEK+yiAkZFiQnwhrOFcvQddF4sWcTKFu80Yy
 w15BITzYT6HFX1S/xuzogHTDpVMaB66o3Zzjiix3Dw4dZM7UBpxRT2qeoIa8LMyu
 gfYUAS+5wwpbLlJFMyl5eUP/n/xnd+xFgIyvNwGJLn44xqT6TTsqpd/A2TlEFfZu
 RjmIqTRv+dtfv/4O8Qiwd+v6KUfuZUQXlRuV7ATNJAj8fw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dmbs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:30:02 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c82c2e9761so611861e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789342202; x=1789947002;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nj6aKZsVdCtHBveKqJbFsHIv5njnLbiwoSwtuNudUX8=;
 b=EFGocWayWI4dIbWLhNFC07Jji+bJxYqh2yPMPOPHvf5VPqv1x1b63vfXQ2mJqsV+yJ
 jmLbF8S8fAOr/rH7sFN20FpvXqF5zOgHbKptxXrSW8+/t8JZZmmUPKexk9XPTKC0SInm
 V2OrItvs8mBDo+6oC/diq0Y+ha5eqjgQ8GbLO8McIqxoAeSXJlIeHQlAxxHDMHyxWQTm
 x6qsbGVn0RPnFdDFr/s+48FobXXGFOIgNc6Xundv7v+xHKrzLbatAGJLFT+zVn2wvomL
 3j9I69SfdjvvyOAaf3l3+vmw7QWNxoTMVl4dCFsy9VA6U06xu1UwgKLikiqCPKYHEuGc
 /zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789342202; x=1789947002;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nj6aKZsVdCtHBveKqJbFsHIv5njnLbiwoSwtuNudUX8=;
 b=WRdfu0mhaNXE9yF/3WjY4Jo4D5xEiqOBVO8nFoZKoKsQVQSwmUu8rkSSxAKn2OjP9M
 JdKxNggsnaRL/vNfzXpoSE+03RNdtaTJter0JQCwbRIj9KqDp0bqx0zA+9VuS6N5E+Ef
 FAW2cCHQZlkAAOR+NanHYrwXX22Q1tCbhMaWuJBLPATY8c2pMpYgxWG/Y70Y4mlbd/0K
 kIRlfIvTd+W1QzwP0tPTBteNp2qvteRLEvRJIjKE2f27MjfXCOY/Y0WpHsWTx92jQzEK
 Z2DdlRrx0MvDSdCAg4G08YnX4l733wJLb8Qg/jvlAy0JCXa17xfXgiHN1W87G50yx7A7
 BhQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuxac7aL1b0/Q41iJuQ41UOnsG3qSN8I4Y0W+rtMs1phKCZRYsh04LWRCy132pmtvVqASPrrxLnF4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nirm2ujWW/WIr8YlrG94BDf/jhMg7Rn0+z+vRd7jVsiQLjGYnY
 o0NvrK4tEcUiq1yccuVdPoRZFNh8fPbNO7q3tCjJ5jGDNeE3G+0zb7mH+CaVZR5nrFZ6mUjZeZB
 rwDkOFibtL0HX9ntbI6ospqZV6G4n0w9BHR3eOBURKufJLmYJyVjUxqKhoXcbroCY0A6RYBc=
X-Gm-Gg: AYBFou2ZwA0hxlKmzUNv/AqqeqYdUzppl9YHGv3czX1dxEhPNDHd/udaq+GOJ6giC3b
 7QcD5shqWYfLyS722WWWoPsQj1vY/P3QVNuspuusVRF52VoAh1AocscB4EZ9qLj5vSU0F1phqU6
 ZxlS8TOvuxo57NpR1xzveJUEvDGDqxdA4NQ+RkTFcbZkYkCKvZCdddiyLsO3zXm5wgW/AI5gGZ/
 UxSlyeuoh0FxK76gNMj7hLipfLm8pGP2h1pfqSCrQ9z15aKJfJu7jZ0xoMLqutr7Z+L1lXxnMPm
 hBuyi2Dq0ukpps5ySQp7MmPCxoFYsysLsktVocw2mLB5djwiZOtCiUmU1N0r0F68CxU1JwfPdZm
 9QbgtlYwf9sVFN2gPju+d/qGD8RxxzV9AxFY7/TWhniDG97KCz/ruaHk0jXH7chuI7+thObMouq
 NJ1k2r+Lz/CkgU
X-Received: by 2002:a05:6102:5792:b0:792:2a1e:f9bc with SMTP id
 ada2fe7eead31-79b5963e001mr7185137.6.1789342202023; 
 Sun, 13 Sep 2026 16:30:02 -0700 (PDT)
X-Received: by 2002:a05:6102:5792:b0:792:2a1e:f9bc with SMTP id
 ada2fe7eead31-79b5963e001mr7177137.6.1789342201620; 
 Sun, 13 Sep 2026 16:30:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a33042absm22708231fa.14.2026.09.13.16.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:29:59 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:29:56 +0300
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
Subject: Re: [PATCH 01/17] dt-bindings: phy: qcom,edp-phy: Document Nord eDP
 PHY
Message-ID: <evvgtf6b46zqpolvybz6xfklakgoyv2llnvawrblgz6np7viza@gtmqflkwwmgk>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-1-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-GUID: w0kAhS5tlw4_bDIyArYdoXD07svTt2Eh
X-Proofpoint-ORIG-GUID: w0kAhS5tlw4_bDIyArYdoXD07svTt2Eh
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa731fb cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=07SeQkCZaLl9qT1boBYA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX92dxEuMs5tBe
 1sClg4CupYUh2LR+t6/lJQ/7CiMqvYWVaORUmn4X8HurmwqcB0AHM1X12Wbj9VJSXUJ65SjjzQt
 9zog5QCiuTGDFNm9Egvs9yeUQpW1sPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX0JDuR8TZxwsB
 jVB9kke2AHe9OhGSYENLiDZ6GYPbRRGCjlkgF+5LmNhu0R+Zqr9ylEdux9SvzFFyhRINnrewaaY
 WmFJQJkXeK1qfrervkVaY2ird9Q8ANkTJAn/ftV39Qtgmu7+h3YPx1OntMDla6UDQJBRuQyQSR7
 sj8kSzZx2tNv5NdUpWey244j/nsFB6elLM99wYEnlCNiqMwfTvgyttAtEpg6k/lJ2pfc2I5ZZCW
 2WoN1RPT8+N0jvOvJg/zjy6s5dVEAGBUZQs3H0VKt5ELFPUeeEm9J7wHLuRzQ51BDfXVHWQdFWa
 sKzw2DFOeKRgH9seREk2utR25qGFZzsI1TNSHz7AmC61pCk7UDgk2iprAw4yYX5IqsgvR8qf2oO
 Zp7kQxb9FMryGKLzoYsumRv+L+lfA8bb7pMKFTl3qSb5y1l1OrlleCjAIk6TFTXpt2Z3VF75rbC
 KD88BawdQvIq3I0xdLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130337
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

On Fri, Sep 11, 2026 at 09:06:32PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the compatible for the eDP PHY found on the Qualcomm Nord SoC.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)

Does it use ref clock?

> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> index 0bf8bf4f66ac..91d7a5c8e19a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> @@ -19,6 +19,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,glymur-dp-phy
> +          - qcom,nord-dp-phy
>            - qcom,sa8775p-edp-phy
>            - qcom,sc7280-edp-phy
>            - qcom,sc8180x-edp-phy
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
