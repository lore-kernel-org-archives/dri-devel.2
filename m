Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F8CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A4711A042;
	Thu,  4 Jun 2026 13:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYGFz4HC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eYUcyPgf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C1E511A042
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:04:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548Ufob1132390
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 13:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kygRY4F7eJ1NPjqjo+XnXvVI
 c/zT6FpT96y6RC3eCRo=; b=LYGFz4HC6QJIf95dQ+rkttk6BETSr1NO4PX6j884
 i1GC+e+8AwfzwdeAFnf2A09YFRF5Bgzbwsf55VHhjnBa5/usR53MnALGKwOnRH9L
 1HvclKZU7w8ZrvhbG9z7m+8pwlX4iLH7dtBy3svAUX1e2tpKcZ6i6Fm5fNsyXBbT
 0XPdKKQ1p2KWuDbq3pCNfJhckX9oB2B1JUriTePpqGxX5x9sWAlCU+rLL2LOs++8
 IbWLSW5qiApcqzMWdAaaDaz3+P+OEHAtMIS0HO6E/zMarcZcPAa58BDMpV5yy8AQ
 z2GiLgjfgTA1D52q4ES+HSy34wcFSjKtSxJRkGKObv0sdQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsh1mw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:04:18 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e6fd5f007eso1271906a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780578258; x=1781183058;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kygRY4F7eJ1NPjqjo+XnXvVIc/zT6FpT96y6RC3eCRo=;
 b=eYUcyPgfYvdRnWN2jeJdWb7xRn1YfUVblGSG8EZ4BC9GV4i/dUFAOcdMC2IP7TefJj
 FbI3eJoRz3h3yUVpQStXJJoOfBRCnSrs2MXxGHtUCxDN1P24rBAyLZNZcz7w2A8bB4ot
 WGr0j9WS9SV0qMKGZPNB6fxLd9PZ8ZNSPJkbOpjF121FgMJSSzy4j33BVvs58lVsiWO7
 bC7wDGdkGvRfxCNGXz5qfu5hi6ZJUBsLYkEFnIAMQTTKyYcRGmp4ncT7p8JgfbJinWNl
 f8FC/ONXrWPLaozUsnj16gyzzncEEUfwhYXy3UypKqgju+o2S2B+fkcoN/043oW+PUFG
 qUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780578258; x=1781183058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kygRY4F7eJ1NPjqjo+XnXvVIc/zT6FpT96y6RC3eCRo=;
 b=K3FFhYd64KhfT8OB1U2RdgKX55Sag7LXzVph3RQk2GjY0wIB6Ogb3rzox5x+bPqLai
 XpHL2UNb1ZvQwcf/Bl/AF1XSs16susK4uLkZCGtbZdBS/V98Qk8hDHj/bvuCcERjLIGz
 xz18g3sb3M6DlBfj/GIUqHaKLTVIOU3NAVWim8JkrhYDxNWbpgrINSnRxciUiyIZXAZ6
 8LZ/UPapHAw2/KrVxPOqbWTbJKagLYPY263rJEjEPUvC+6ZooFex3g0oq6qJCRJyvp15
 wdNgDGCZx6+eCPAho91VNMeUyMR5rUfBOrBsDun7NyN4mHqSMNyzjiHQutRmDIf5+MQz
 mfyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dSu7Pt8GvTnJPVRG5/GBa8sPZH50NupQJdwBlyS1C/vFZpwBeufazJCc9O018N2SHLO/D3pxm974=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/3lEQH2krovjYdOzKRP0478BCZyvJa6RxFLE6u2iOgdfRKhU2
 elBCVdI+YNMS+R6+/L827i7XWsXGj/1T0BFsuWNRU8mYyzRg3+E6AUlWjZMDT4ApcqQ7kifihQY
 B29aKPU/wnZCPMqN0rt6OJ3b6pqtCVKwuge/3XAB8Vov0EsW+3cQfX0eq1xNyQ07CleRVyUE=
X-Gm-Gg: Acq92OFfDHmt8sTZstKBNcGDLD6yvqwcKBfK+bsglW3T5yDLCmEn5jcLN8x2knjnOZm
 jSUAfKkPROuOv/WKc5X16yGShKJJiUye0GF88kMO4PdHv0IZrIqrPBYKkwSn2r14Cs6bHWROdnl
 3rDfZ/dx9bNuwUpTdKzXbnxXxT9v6Go6HQhTirmxIUpo0zKrniCZ13MxfcMr7wiq5860cUFmYFs
 A12puhnc8/dwd/OKPhiJjYwwEHuQCLzdCoMsM7cpg/h4/uoWAFY46Ln2xidixIza1aVYB0XNAYP
 azIwEBkUMZ6gs4hkAVXK0Qr4HU6Z9454RkoXpR3f/eCLl/XSQIFcAXjWNQobGcAVgeOJxIzOWUf
 g0cyWFRfKB0Lg+uvwcfr0Me0vzdbOqiIIqYfJam0CSDwhJD3ahAwRUzlbITvDR1wyC9SfFolYlu
 m8mJwrItQBQUAy7grAiaxrvlzXAQs0ygKsBFoYbZRLJlZqhw==
X-Received: by 2002:a9d:5e0c:0:b0:7e6:441:cb4d with SMTP id
 46e09a7af769-7e6f91ca449mr1449319a34.3.1780578257778; 
 Thu, 04 Jun 2026 06:04:17 -0700 (PDT)
X-Received: by 2002:a9d:5e0c:0:b0:7e6:441:cb4d with SMTP id
 46e09a7af769-7e6f91ca449mr1449240a34.3.1780578256962; 
 Thu, 04 Jun 2026 06:04:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b907269sm1197378e87.34.2026.06.04.06.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:04:15 -0700 (PDT)
Date: Thu, 4 Jun 2026 16:04:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] soc: qcom: ubwc: Add Shikra UBWC config
Message-ID: <nkzfcmzslcc4e2kp5fv2i2grb22ncf6ewd5pn57wy5tdth4zrt@ddrquhu4ijcd>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
 <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
X-Proofpoint-GUID: zegoFmc0IvmW2xpAMvp2m0qjU1RyJWHV
X-Proofpoint-ORIG-GUID: zegoFmc0IvmW2xpAMvp2m0qjU1RyJWHV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNyBTYWx0ZWRfXyHY71F/q6xbZ
 6tG4TrQC2wf6sNdgDOeKr/DKNRFwaZoErjoJ+x2Vyf/NbEewdBhjp3CNWZdZXWFGsZEqefpoFrP
 qZVOYnQ1rdQM/i3zyr6HcUAIU9b1phTB6FcmPD/Egrpn/KXzFze099vEpcpNBEKVnKkcoQPdNCr
 eMaVvI1jqdvhKJ3q31ejghClq+E+DeTbClTZyunOvgR3hsrPuYnxSdbPO2Q2q5tVTqdoGng4+NJ
 owBBUhco3ZyHYHZ8i4Qmse+tYGPLr/azkU2OqWr2wo/f0N4vmVp1V55QGIL875azhdUFb9hgnlW
 WxvhMm6oOsXdYVxD0yLVsKzCearyM3cxpOfbxJssalfweeL81O/sJTYEEiJO6pufc/Bp5AhkjVS
 RGkKU/i93sPJIhH27/TzQdBz1THoozxs/htR/vnYJSQNgt0htqk6sqDPJyBASHYk9i1nJOhx/l6
 e9vesRa38m57PnaAWfw==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a2177d2 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=2Uxw_1zm03w2ut2Jle0A:9 a=CjuIK1q_8ugA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040127
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

On Thu, Jun 04, 2026 at 06:00:49PM +0530, Nabige Aala wrote:
> Add UBWC configuration for the Shikra platform. Shikra shares the
> same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
> UBWC settings
> 
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
