Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B8AC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBCFF10EA6A;
	Sun, 13 Sep 2026 23:31:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6Z0H9Hc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KVLxORrG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A7C10EA61
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DJxvYV2527548
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=DNWkY13/F7vQQirOcn7RyLrj
 8L/7ZC6/5Neaz+9VVak=; b=h6Z0H9HcHEhQBaja6fkvXBbrNNPS9rFg+FpgaM6/
 faehEqp0/cj9WrrcglZi+FVs6s3GYk0m6/+uh1ySJ07HvMB9MEqfit0uNbrdX2Hj
 FbpF6MJp6HX2y24ZL5YMGg3eCdleotfk3u/QpjwLSqfKthfQG5Cc5a4V00a/APr5
 xFe7nQLUoPu6uX+UH21axp829CT3l3M5Jgs4LFdDd5wDqRSc4ozYOz4qxaAplHAr
 EPGPTpEnRSk2ynvKstsuPuhFxntWtXu+P+89BLO1YYZfaijKFL5XD1Mt02aOHfbJ
 6usUxLdxxWYJaRBX9IvzbRjiuNZplDAoZ/CLJbOPe5xw8w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dcasa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:31:05 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c851df59edso972490e0c.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789342265; x=1789947065;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DNWkY13/F7vQQirOcn7RyLrj8L/7ZC6/5Neaz+9VVak=;
 b=KVLxORrG3Zg8UkK5ZPtWh6gbgnfAqu0t9h1eX1LETla3M0KQhMfw+5qBXxBY/wSouE
 DcytFtRCJyiGC/bI9yWrJlsgsbDvDmY5Ni/jvyzeZECCxCfz2xedDEanjqY0mZX8p0jf
 yBnrYITQIbeGBpom6mE0bmeYB0pmITk1cVi//Ryi4lO6sR+wp0zs6NdXbd/JkcuodRSd
 cGilW1uLhDH+2DqSb/Co82rB9gi/+6eDQL8dVt9bXIx3ZVlCxwgbpPa15UhG1B7xX/AQ
 ou9KO38yCOVOgqgF9cZSHbrKWW9SgW3dvrBxJ+2AyFY1Uz+jZ/7xL0HtcvS/DTVVIXDi
 cJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789342265; x=1789947065;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DNWkY13/F7vQQirOcn7RyLrj8L/7ZC6/5Neaz+9VVak=;
 b=GUTUwvi1vHEP7s0T5eN84aOwmrOMMFOcDpgCcyCjqYU0uO6how6oCDNnlQA4rsrDXR
 NO6OUIDMAO6d0Z9HrV6ElUEcK5JM1ZQGuQ942tfOoO66u5NO1VmQbqdYXblrjK4KOyYv
 A9o3C79WDyo0Kh+mPJH/4WIywv7bBsB6Gi0rMtbOWfccgfIkwRjGgkED6G0sMw+iFXhp
 W2xZ++3dqTdzQ3wvwW4p7rln0BWQWAK6rVO9gYP6Y5GBo9ohkRN0OfBJZXrT+clSJWZ1
 PLoZYBXXWh6iXVe1JYLxGhPUeYg4SZ3BA3Qhy/lzvuLvhv6hrZFkfCrSl8A4K2efPxNP
 hHfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByNt6kw5LH+1EeI+qhmkWoUCDQquS6wMZIf5XEuMKifjiAK640R5qEzJq7MFwj1f/m7NjhmIqKtYZg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n0umcBK814/HNncWhfupuTuHWTORR9aTymdDnG+DmwUuaLcvvW
 jnf3r+osaak+duTrDvZb+NXvemIS+VZkOz4MaYEPupvP6ZKgqqqz0ZokMxlf6oI/IEHhrjaL1ln
 M7kqCZvwUb0mQcXIUmiwWFvD1Hse9rBC3eUVBacBl2X3H0WyYC4/I1Z72hgLXR9hhOpvXi14=
X-Gm-Gg: AYBFou3/bCYbL74j8hGAnf0xMVCbfOYX3gjiVnbjPUt9fJ1IlzVCq3DbuKh4HYHCzM0
 gKQRUan1crKlWE+y1otqwqmSOYpx3gFQxAQDZuzHH2HWBJ8Q4TeIoyC5jktj4OfbPuXx7sO0nY7
 d825Ml7mLwov2Z8LXNQ/P2B1rd2zAIbFN4gqsb+sRe/bOZOUWznCsP+B26kfbwt4nK7qogcCRkN
 yb4DHyHPu76MUS91u5yBJibWX761oVDYYEKF7nU68oyE9PnaeSRvkNSMiXZkCFLE+0J/1YTwv76
 ozoXGXe6EobKSFDCvK/hrmtFxOF64opoBIu83fLbX+5QBKKa4lx0q+VWc+iZCNCSKN0oxSCDN59
 69ZzpJpQdi2JP84CZP7/RhQcSvqWIhw6AeVuFynQjeNIDvTACKHksjIHGmbz8GaiKDpo1et/aYF
 RUpSdKjT4mOSFy
X-Received: by 2002:a05:6102:32cd:b0:79a:47f7:6cfb with SMTP id
 ada2fe7eead31-79b5c700894mr1550137.12.1789342264417; 
 Sun, 13 Sep 2026 16:31:04 -0700 (PDT)
X-Received: by 2002:a05:6102:32cd:b0:79a:47f7:6cfb with SMTP id
 ada2fe7eead31-79b5c700894mr1537137.12.1789342263937; 
 Sun, 13 Sep 2026 16:31:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456f85sm2019892e87.29.2026.09.13.16.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:31:01 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:30:59 +0300
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
Subject: Re: [PATCH 02/17] dt-bindings: display/msm: dp-controller: Document
 Nord DP
Message-ID: <pxrdizcozxstimw6qortyrhyqdeicgdir5stjqxridexmeehes@wytomwupuxnq>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-2-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-2-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX+2YiYx1lW6YV
 LbKYzXHxsJk7V/OKObid14EKExHIi4mYymTafzJO/tvCqRhKnlmZeozxZrWZmasuZJnP7BsQ1FG
 y3T/FLuE3EGByH8mA7TQzPIcZpw7pdom47sdDa6t+ewY19NIXUf8HYxGbdHR8QJRpiD/gKUvAia
 bV2mEzp23hmTZyNhKASeEwQM74YjIzTzB2t02xDZG9VdzbK5GS9IFafIFeDZqvogzTGaJp/hmHY
 WR0pQrn00F5cDt3A53wMn6pyoqEzOhZKpln8JFm34Ck6h+2DUPs+mIGjlYpcnIvE38o7240QdSQ
 kTpN0aL8plpUrEVyPtyAPqQ+cP+DxvoBsHJ9LrJA/LG8PFMQ5TYh7BH8uqrDJRvmlKxZBzIQz8G
 ICDFnbI/SLjjizvgXuMT49Ml8ZwtIG/A2LjaG16VhI50yj53/4FPkEIl2O8ga6jT0zJK95D1HqQ
 eTwalGDUG/eRmUiksUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNyBTYWx0ZWRfX2wCZlgCT2oX5
 qZ2awjupDwtDFdKG/Y8pO+jWKBaqwwJaom7OMsVhvaygqVxVAHfmBfXqldUVRz//B5vlTnYk887
 3baMC7Ts6rxtVfPXZjtzTPTyHSvZqkg=
X-Proofpoint-GUID: yvCFsqsou01eMYoU-gjop3SkCBaS7ZTu
X-Authority-Analysis: v=2.4 cv=OeUNnRTY c=1 sm=1 tr=0 ts=6aa73239 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=07SeQkCZaLl9qT1boBYA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: yvCFsqsou01eMYoU-gjop3SkCBaS7ZTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0 clxscore=1015
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

On Fri, Sep 11, 2026 at 09:06:33PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the compatible for the DisplayPort controller found on the
> Qualcomm Nord SoC.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
>  1 file changed, 1 insertion(+)

Incomplete bindings. Check the conditions in the second part of the file

> 
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb77..8d980acb1a16 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -19,6 +19,7 @@ properties:
>      oneOf:
>        - enum:
>            - qcom,glymur-dp
> +          - qcom,nord-dp
>            - qcom,sa8775p-dp
>            - qcom,sc7180-dp
>            - qcom,sc7280-dp
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
