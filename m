Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A038D106FD62
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 00:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD25310E04E;
	Fri, 13 Mar 2026 00:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9ofmUeH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Os4LoVjB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FC010EAC9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:48:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62CL5Q2n1758836
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bVVvC3z9iWF1NoMxk2yYgr/D
 MqbMXcwjDRsqtMtqWB0=; b=O9ofmUeHlTLxPt1VrAPhCetnxcrk18ZDB2BWcBo5
 PxtQw8hgcsbx6jP+twwG0gVwrRdUAglNel/ujdp58Nchy0VoD4KfToJAusYdfdHh
 0z1sW9CjF35YXhnEn8vxZImCsW4E8lAe8wv7MxKdxMTZXlAKMFZO02qdZz7JR5Wk
 ZP1uB3u8lq8nyl3NxXQVykLiUUbGhEmYiAt+7DxFHtxe64yoS1cYbHqWJi3rcFlN
 8eHlGqAj9aHUQuIRXgIF9Xix2MequAM6729/+4ZyoYgdbAqGXrS/StsLlrKLGx5X
 AEF8He9pQyohcroJsWzoHTV45nV8uyj9AM37InDe6hEy8g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh53kwnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 00:48:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so896592585a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 17:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773362933; x=1773967733;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bVVvC3z9iWF1NoMxk2yYgr/DMqbMXcwjDRsqtMtqWB0=;
 b=Os4LoVjBp1fDTH2e07qpuQDU8dwc+GU0Rb4fM+u33xKmtgdpIt/eZczqN8Ba+z5Qoj
 Uzfd0jDj8UJv/zXwC+Ajl1CTfDyYahJGSZQq3/l4cMqO9trcK2UNfdr67cEeVyz1T3ut
 5XxLLZJuqonQsLVBQ8tvvuGpA5YbGb8ktcxZlVkJ1X1B0bfk0A8/3pSZU/uD/OuRvyCD
 MKuIU3tllGafCrM7pHXf+eufAVM/EsUuKIKhWh4eDmfUyCilgjtSf0G/kbDxF7birDrW
 xxjG5GubZNBp0JfbPZDy4L3foL6jRIkW+YgpuEgLaU/a2A5Kptz8kVXmS3kyPVqqrbiL
 3/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773362933; x=1773967733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVVvC3z9iWF1NoMxk2yYgr/DMqbMXcwjDRsqtMtqWB0=;
 b=s2ZPIN0guS0D9r27yKF98IlinLTaHHquaamnzMT7plQeF+Vz0KOSbWnlwg6KCNIfIi
 vxicxob7CDMB+yeXNtCtN2UNnj27zs058mxhc8zuyR3BC2cDhcFnZDkcofDz783ESwxY
 oZmZ6oxbTWcj5rH7UETKxpfOxiUJn9HQ7SB2P10MfytiV5wgdPT8jGkVngaMQrI1tdXl
 /FPa05HV8Fa/1n2BRYB2Nvk8nqGF/oF2jgQ0abVQGUatltezgvpU9cOK9v3TU08o2IfX
 z53Y+rd+2JCby84hZaCv8wHzqo8DK6LR94uEBQCz4WMbBDCU5J7/ziTEsaWfXCW65emc
 1oVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnHfrzPA54DdqiigDgYb6D6w+NuQVwDBCRmgrtNRbUwdREAWFgGMznIq+lJ8zF4ZFsQntVW++XoWs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyplAZiW3TN8l/nSRwhgODz92Hs9eFELXOrbwDS7+QhjiEJarWb
 CyHM1E5T7yo+4t65C7sPLwRTYepbvfMCObYxaoenKwJ10ujqEbAq/7qpM5bDyMRXCFofUJxMc7y
 odPmsIaz+FIrT8R6l7EoZ5j0w7OwUau42N2B7qSFw/yOxAZuYuz7DA+IV5KDzlOjML4eTHxM=
X-Gm-Gg: ATEYQzwhvuU80W38VQVPvkJF3bNKMpjFcHwFEdM+WN9a2konod30s/64h8IdrNknHlD
 UGH1/ZFhmIV8x5GnQSgLsa7JYuEUyYWhHH9D36pU7xNlXP2wk9NGsYsToyMKIgxl+xOONbKRxB0
 vY4FNBJNZXl51JaC8FRZIMmCJMpJ1r2RpRvNuO0dmVfAbXtitxgte4DEyYPjPBuKiQkYIHr7ws4
 nGIX5lMpE++8N1uO7B/D6Q6yKPpcuYTITvLAhLXma1Q9ltuU6CQLHy/RphK7VZrnZq3zjfoRAvu
 TaOfdT8EZoz0ncAPs0uOpIGAjk64NoKduEtRfKyfYewFuqyYu/jW2x47bdZg5+3Xb7cGYWt+LZ2
 69ZWdXUp68Cbcn09LiuhKLRW4wuikWNLZl7OliuIoIooXh4G036yh2VgCCIZcImu95CdehaFo8F
 BwtWmpYPWvdTPwmGOf2HPYioLD1fg/c3oBp8E=
X-Received: by 2002:a05:620a:4691:b0:8cd:8f04:50ec with SMTP id
 af79cd13be357-8cdb5a5479cmr238145985a.2.1773362933467; 
 Thu, 12 Mar 2026 17:48:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4691:b0:8cd:8f04:50ec with SMTP id
 af79cd13be357-8cdb5a5479cmr238143185a.2.1773362932953; 
 Thu, 12 Mar 2026 17:48:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a155f33cbesm1227741e87.9.2026.03.12.17.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 17:48:51 -0700 (PDT)
Date: Fri, 13 Mar 2026 02:48:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drm/msm/hdmi: Simplify with dev_of_node()
Message-ID: <6dvv4px4yinuppwcxzkyhzbdfq76c2xh4is4xlx7srogd55qcq@tf23oqxqimz3>
References: <20260311-drm-msm-hdmi-cleanup-v1-0-c5535245f6de@oss.qualcomm.com>
 <20260311-drm-msm-hdmi-cleanup-v1-1-c5535245f6de@oss.qualcomm.com>
 <hg2icue2e4oyr2pu2osjlbbcv5g2q6golwoabe3oy2bxhvhb6r@ku7aqp5jdovb>
 <e1a5bc39-fabd-451c-b480-03ac9bf2720c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1a5bc39-fabd-451c-b480-03ac9bf2720c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZN/aWH7b c=1 sm=1 tr=0 ts=69b35ef6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=5gE0ENHsfxdwuEGK4QIA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAwNSBTYWx0ZWRfX9yd0bLRtZjJy
 qNeYjBIi0vC9+s2OQDOSZWfeL8P+CmbAmj7bYn5+sk39Bu7Udro1AztRkGxgmu147fXb2sW869h
 GaO+YapX8DKFp0oUw3FSNvZ2gCXS/SJ++ZD2BtN9w4f0Z6XjiaFWzjzCHUXXGLpBrhReG63KNqi
 PpjR5xC6fThYvvp27BvCct1l/5HC2h9pObKjI89TR0+tQps6gf5BkngcPvR2XXn9fv10lIlTQJJ
 cUVt34qdX05aRgXEoS3iqDe+ag7tDPD3bN/XMc+y1DRl/x4aVEp3MKqNajJPcYEkZuztgw0wslO
 NXofrSyOssezlb76MPwYa8H6i6Ks7TZie2eUSscX9nxO1ik7eqDnmhnXCxNRvjjlNO/nMK79P5O
 fNgvMYnUOkxIIa1ZiEHw+Eo4jC2nsSbqJwqrzSupcGdeCCR2HKtT7sYwZEGaAqVPP+WpCpA9ONE
 5ZYaJys9XzUB7IqPhGA==
X-Proofpoint-GUID: KS8SkQL6gPQOurWRzS4YVw0qkIfrNC_K
X-Proofpoint-ORIG-GUID: KS8SkQL6gPQOurWRzS4YVw0qkIfrNC_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130005
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

On Thu, Mar 12, 2026 at 05:32:02PM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2026 03:41, Dmitry Baryshkov wrote:
> > On Wed, Mar 11, 2026 at 09:17:25PM +0100, Krzysztof Kozlowski wrote:
> >> Simplify chain of pointer dereferences with dev_of_node() which also
> >> checks if 'dev' argument is non-NULL.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >> ---
> >>  drivers/gpu/drm/msm/hdmi/hdmi.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> >> index 5afac09c0d33..b1db1b597901 100644
> >> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> >> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> >> @@ -91,7 +91,7 @@ static int msm_hdmi_get_phy(struct hdmi *hdmi)
> >>  	struct platform_device *phy_pdev;
> >>  	struct device_node *phy_node;
> >>  
> >> -	phy_node = of_parse_phandle(pdev->dev.of_node, "phys", 0);
> >> +	phy_node = of_parse_phandle(dev_of_node(&pdev->dev), "phys", 0);
> >>  	if (!phy_node) {
> >>  		DRM_DEV_ERROR(&pdev->dev, "cannot find phy device\n");
> >>  		return -ENXIO;
> >> @@ -287,7 +287,7 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
> >>  	spin_lock_init(&hdmi->reg_lock);
> >>  	mutex_init(&hdmi->state_mutex);
> >>  
> >> -	ret = drm_of_find_panel_or_bridge(pdev->dev.of_node, 1, 0, NULL, &hdmi->next_bridge);
> >> +	ret = drm_of_find_panel_or_bridge(dev_of_node(dev), 1, 0, NULL, &hdmi->next_bridge);
> > 
> > dev_of_node(&pdev->dev)?
> 
> Why? dev is already simpler.

... and there is no struct device *dev in msm_hdmi_get_phy().


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
