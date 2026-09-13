Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB063C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B609F10E0E7;
	Sun, 13 Sep 2026 23:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LzPkO/LT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IU9lj5un";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B833F10E0E7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:51:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DNYatv3122897
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WdFMlmauPwxaVbgf2YMHJgMA
 PrT9/NnB7w9Jx4opmZw=; b=LzPkO/LTASUrCu8bMp3vKWoq0UZutRrM5M8jGYJP
 A8NZ1JwKpiYq+CvFymCSgTfoD4TrZXJ//ZeknSxXaGDfgrvmGOEhBH842JdlkS+0
 rTuYHXLq/JKCHi0M/MS2JVdmwcsyBxJfrBnhAGHiZeidDlEMmfFlbZsIloEKN3Xs
 Uxh2fA+uegD4dQdzT8iIMVdQSrfcyLD+5ZAKWSeoaFa8xwUwRBwwivYTTrbc+j7t
 cYJHVL/hHgXyRCII7aymQtsJ/41TG7D083/kVSGIcgu1zOJXP/mbnyBhhTLdHcaG
 ct6l1vUuYDBJ2k3mVKbfLL7DPVliAxuxwWyRCrgr4of5fw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d4bs7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:51:00 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7915a83539fso2541961137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789343459; x=1789948259;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WdFMlmauPwxaVbgf2YMHJgMAPrT9/NnB7w9Jx4opmZw=;
 b=IU9lj5unl8jS8M6pmOzrMY8d+hv98cv2TA0QGh/c+IL0KhKOlmEaQUy/rI3tc1p6rR
 ZmP4J5pXPnK/SyT4DJ1PNL/eeXr7EKjS+vrLfMFEtXj5Ye4Jw3tviR/EIpBgNxoR3Ac+
 xdflDa3EvE7kRdVfVyovFPH/AaWoOUT1NLgSezXnKTL0f0F2iwoAvkTltW9a3ic7lv/j
 OEuLuVg+VlCEQC1MVnkkZeb9wy7OhwB/B0H3ITmgGvAniO2k1P681vl8TpnkxPLZeWc8
 R+STBD/7Po8GaWCzK9Z45wtdzN62Sq9cQPKuCqtqdEfwMBBBMR2uk0TmPw8ONzlDj8f9
 p9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789343459; x=1789948259;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WdFMlmauPwxaVbgf2YMHJgMAPrT9/NnB7w9Jx4opmZw=;
 b=fzJ7pB7pD5vIhnWgtkBTTGTWjrzgQjpb9SiwcGREpIc44eBGnaekAt7zMx28Jv0zQw
 knei/Veph+2UzIIpaGO60B/B+GZ3zgVfnfJDQwt2G/aLiOoUZuxx6EmxWu9qgxMxu4J4
 SIR/6pRXNs31rlgV0dpJd4O3dFbHUhWBD0L76/LaCLFU1PZ8aFN7dlMSqekUHoyeF/ej
 sB2mwSmjIa2hKvs77J9IBIjMBYtsUoGdudd4m6Y0C2JnEXWwOEA7p+C5/Li/ZPuS2Knl
 lGwd4L0qdgqATWPR+8jjwTPiueevuTM5RG84yeAEfHKv0aA7bo8/bWVV2bW4ylhm/4eI
 dZfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSg3+rUWML+S7uzVMcxDRwfwVZLNBf+slJg5wg084tu0mghnXbOPLnwmoNW1duhJA6A6ElGQMxMv4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nn88tWTn0FaUZzlZEi23aWEgR7asawasr3xEV7yQYtJ+fOL2b+
 u94w5E7uzzsXB8p6qZ7BE77OM4dUjbw5sjrgjQj0GmiZAQH87o7VAFXvnwAit6DY6kT6aEAQXgX
 0ki+TZ2WrPNNUKIEJeWjFFhm5f1UuVws6HRWQ79t+6uFZpexd7UL7B8AcPINcJDZnruQZdqk=
X-Gm-Gg: AYBFou1jF/xPg+f0MTXsG2/mnIEWWTAcjyKAyE/4vhhe6tptW9BfPIS4IcivU8d90wk
 PFZK2Dog4yJN5dmTduR27e8XkxxIGss6Mt74qM9DKvwsuinYG2ZwlkOPOrsjWo85mmH9IvFRS8n
 0uWSDKhBazGEsQHbP1cPLkMbmfQd8jHaHLac4e4yVL9KEhvJR6cf4+kutX4X9/MsT6GNpz/CNFg
 w9qeJ+YglpvU5UOAGoddVoNbaAk/cMfTVZ7Cm7q0ZLXR7XfwRuSXQUSEPGsKRkgaIMDC3oqRI0l
 w4XHMbWkxpveQtChAPD7vQooLJNkOqkxCyOF5ayAYKuB+fSDXT3Z2B66eqC56SereiUcs4O93to
 o+okOt9Jpb4ZzCAa0dsKS3WxPuI61ieFoKpqu4/BKpHll9sqCX5tXnIZKL2v+HjDb7FN/PNiqTG
 4lphaCRM0MZykM
X-Received: by 2002:a05:6102:5f07:b0:786:c86c:4f5e with SMTP id
 ada2fe7eead31-79b579afe80mr41621137.3.1789343459141; 
 Sun, 13 Sep 2026 16:50:59 -0700 (PDT)
X-Received: by 2002:a05:6102:5f07:b0:786:c86c:4f5e with SMTP id
 ada2fe7eead31-79b579afe80mr41592137.3.1789343458764; 
 Sun, 13 Sep 2026 16:50:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a0456c06sm2080930e87.28.2026.09.13.16.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:50:56 -0700 (PDT)
Date: Mon, 14 Sep 2026 02:50:53 +0300
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
Subject: Re: [PATCH 06/17] drm/msm/dp: Add support for DP controllers on Nord
Message-ID: <pzcoffvcnailaqogewwys2zf7aizlxwzwz7scpixngc5ootds3@fjxeopzxa53p>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
 <20260911-nord-drv-dt-v1-6-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-6-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDM0MiBTYWx0ZWRfX5BF4lYV/YAzJ
 M70IA7JwlI/VOXqDufoZ1Brg+O5QTT8HyjwdjIbPcHSL9IezQCmkNZdHupT0HuyNd8Ly4k3OC0l
 EHDYyeU6BlPy5IdfEHJ4KizlJc0Aa2s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDM0MiBTYWx0ZWRfX8dlOdWizQy9p
 QzPPqJmXAs46VPKftzatnQuzzjBQcr7yhQSKWJ54QhMMUdLNyiF5AujLemHFUIjyvrT4bUP/G9P
 txXeLexbFdfDJzTahMQDFkOeKa7Oryz62Z8mxHqy4nTByP3gNYwroy7N21TOtXnJJqK1YEO2naS
 x9D/Kr82eQrg/F9C4MKPiMlHRumKhGB7kSWflfacZw/wH4hTQ15whN6C53E3mPV0FS9zCAzYBA0
 ClAaOhpv4M0R4H8NekNl/NBO8ocZctJflWSSfnfXEMRpF9ZEJwmrd99KaRuUqjazVa6aBGb02Og
 91Q7MyevshDP429VhKF9RYX+QGnLHXz9qwJt4Ul+j70E6M5sDjVHGU/tNptFiPWLMKJJiBr09Qr
 lR+dGB9L89L0X0+JDlH8DaMbwZg0b+QhtbWxfWOmwtDTaWd1w/Yu2BWjbieEFviRmadv4Gy2xsW
 JEK+8c5Qax93yAjG3+w==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa736e4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=m5hMcXIjv9hwPX1ZnFIA:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: nzZWplIgSkU9rzFXuQKnd538U3Nm8eAG
X-Proofpoint-GUID: nzZWplIgSkU9rzFXuQKnd538U3Nm8eAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130342
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

On Fri, Sep 11, 2026 at 09:06:37PM +0530, Nabige Aala wrote:
> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> 
> Add the DP controller description and compatible for the Qualcomm Nord
> SoC, which provides two independent DP controllers, both wide-bus
> capable.
> 
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
