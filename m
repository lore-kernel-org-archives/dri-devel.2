Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD7CD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A5C10FE22;
	Wed,  3 Jun 2026 13:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwfdrQC8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juX1OoBc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D17110FE22
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:26:43 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653CX5aX1946507
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 13:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FBhsg7FwzuMrC2Y5faSGRrZu
 R8DY6M4ytXCJ9V4SUKo=; b=gwfdrQC8QGxcPEM1JdkngF2f7SVaf4tWQ4Ar3/Z2
 6Ayhs4s0EPnkY365ytZbRhJr5pZ2Ia0SCCTCAjv8Dbl8NTmB4HeesLWg5ze+/sWx
 TbJcRPE3fn3biZkvNM1w3nSUGg1ZJKlJVM1FYegh6rsP/G/2hwrATp873oFuKgfj
 RvZupct1n2aWYUOfGIbS+nTL/f9ub4gaaiJm67n2bX/LW77XFx5QZNmy1ZIFRr71
 uH5X6GoBc3xC/fiJxNk3Hi9qxlRKkJtAjnpLvT/a0udBzmyrHG9DmQLaQSP/yiJF
 3et4YpPyFT+THy+MgCOz4wiuWpJyvsI6UXbRlDQhUCOuDQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejabgjned-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 13:26:42 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-59bd734ecbcso2501392e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780493202; x=1781098002;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FBhsg7FwzuMrC2Y5faSGRrZuR8DY6M4ytXCJ9V4SUKo=;
 b=juX1OoBcqKuE+bCgabzuWN0ArkUkQTdyvk4euNLQOr0uucNhH/vjEoWdtDIFYrAxwv
 6ggrJQyVvqa8WweS+ZRmOWbjRuuzyHjqVvp/gxlDYDEx1BjpwBhrN7P48a9P+1sc83Yq
 LWIyytTrU3yl8n1rd9Sk5haUG7xwkKYhn3W2IOveRC0MZp59eQZrnjdD8lH6X+vvrf/X
 aaN8h+bOis2adgUD3W6tzcsrci4ReGE1DWh8kPM2jtmZBUn5Ku9aNZqcnO71/QPMa5Ky
 2iokfglwXfQQnx9qx0Gp8x/TxifKZvCmzeeiPApLOGQXJWmn/Y0aQLAQm+HUXroWp+vG
 H6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780493202; x=1781098002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBhsg7FwzuMrC2Y5faSGRrZuR8DY6M4ytXCJ9V4SUKo=;
 b=O29jRICG82bjwYV3s71dbKkgnYi9L2lXkyUg4gOX7SkJKf5WJwMZOiWgaWgZPNFURR
 tNANN087+f6BaJuh5v/8W8OodPACpAnEIiKTeZZP+kdatvu0WQiYtmieE/sld/JgVfc9
 GhwCOlId0zv5jvYjXsdwQ1yfpqTeO9G7pP7DN9JIKDy/evM0qetHgHsQ6j6QzPiduN8o
 EvLo2Nu+FRH5Rr+FcjnAf69x4m1lcVFN/+A3cNSWcWzQxuO1oOmQ86zHzBTSgCmCszow
 JFgIb0N4eW5Z7hJrA8lzcH/yywcw7web5/Ux9pEFUitif6+/M/eJvD/1YwICtXSizq/W
 zAkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FOo5tDkClA+ye35c9Vf1FUfegP0qUvOhX4OegzKwj6NubALoInjsFpe2GX8tkDiJe7DJW4TFcVPo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywet1T4ThXwrZ9DRSS/7wMSFcYYB0FaEO6vswgMDqjAP3KyPi/p
 N97qZNYZMj3wgQVVVEamvAvqdJI9BOusRbLVIryk8QoMz+xEhqWGC84nReNqirfyVOKWUtuX+YX
 oChojzDUUd/AIMV4OyiDf8L5unIugD7KDfCWOvJqfOGZC8U6iVCYZR/Xn7ac/D9fKPCaPjDM=
X-Gm-Gg: Acq92OEis1/Tlq7gBwzdVLh1GE+t2ruMnKZ3WyeLVv0+ZHm92pN79RhxXx91rbh1Ion
 Vl9s61Gtj6pvHoDjbID7tqsfzmupKw+XrhtzRHHgP5IXm72C5CJOFD1TilmV/NHDv8Qi8mS8i1F
 6uL44Gwkx0avibwvN9UH04eUbB2CUyF1EiuBsDc9IsdtHcYAEof5sZFLOtN0FpD8JQ27YxqzgWS
 aKxjoU7OjPVrsshHSUCYJkphsea3jbTCsJwGg0SbOOtXRVy0jUGHLZjbt8nvBdjtGKg/s69vQqJ
 J/n6M/W9vYwHbi/hK2WAsTAJ0sbH8O1O+HAPOj3fpluNf4W15ObIGVTzPlibj3RpR2BvcwpoQRl
 6oiCMCVqXFjKPTXTBZwImPPwUw/T1EX8UHoypCNTZcYsO8aYJQJohPM8uLE94u3cDsHjmoS2LPs
 8Ydq6Q/vRb4dsKWSIBGdIvULKNnnRLO6jd+81hmwrcmYgoTA==
X-Received: by 2002:a05:6122:1da9:b0:5a4:ac74:f5ba with SMTP id
 71dfb90a1353d-5a6e86256ecmr1670760e0c.11.1780493201645; 
 Wed, 03 Jun 2026 06:26:41 -0700 (PDT)
X-Received: by 2002:a05:6122:1da9:b0:5a4:ac74:f5ba with SMTP id
 71dfb90a1353d-5a6e86256ecmr1670719e0c.11.1780493201199; 
 Wed, 03 Jun 2026 06:26:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b97b04esm665779e87.40.2026.06.03.06.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 06:26:39 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:26:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>, srini@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 robin.clark@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 06/15] accel/qda: Create compute context bank devices on
 QDA compute bus
Message-ID: <4ok65ttxij2yn4qyvbizgobfxsfikqmsaynz5c6lfbp2d3o2kt@iuqdma64k4w5>
References: <20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com>
 <20260519-qda-series-v1-6-b2d984c297f8@oss.qualcomm.com>
 <f527lflctqyqjrotd2qerlx4oikg6st6u2seqsjw6u5krkqrab@uhw33gnkp5c7>
 <37ae68ba-6639-4bd2-9483-5aa0156fd772@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ae68ba-6639-4bd2-9483-5aa0156fd772@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=R6sz39RX c=1 sm=1 tr=0 ts=6a202b92 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=niLhY7D_osK6bJDgftoA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: MexM5X59zx2XnTwUoVebPT6IjNe_HmvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyOSBTYWx0ZWRfX15ij0YB36XNv
 LSYSbdpWc+EQA06l6zqqUEGtcXWJOpigiGWfORohSoPirdDSgpTRmmdmn+QZZup1ZCIMN5ggCk5
 +hlsRkkUXRbW7dPRyKpi2iqSzkKp5DiK4/yeYbPdDk/gwK8zlbmi0jW4qLV94Fj628j3DR/rSHK
 +Tn8E84G6yiQE0nfSqci3HTDQbNIb0ttr7FYmNTayEv9Bu3ZTMTXU2hEYrVko4cIog5B2esUamZ
 OvIOaTRkRumdSx0/AsqD5LUUDur4j11wj9uRD7zNfXxAf7832Ognn5V6D2jq9DPHLzuSJlQbqkh
 mAaJNF1MosSLsID9p/VeugISte4FiBmbQ+94Uv+G4YcNi/gv5xifcFkvUK8gHBxESWkdM4JFt2b
 u1aV/b4OYtV42pSLm41U4Ysbt+3Wah42RCaFvlVF2fDfMQ0dccOTYGU3Co+oPBGIYwmuwwLMs0M
 MPrk9iLE72QJmy1GgeA==
X-Proofpoint-ORIG-GUID: MexM5X59zx2XnTwUoVebPT6IjNe_HmvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030129
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

On Wed, Jun 03, 2026 at 11:09:31AM +0530, Ekansh Gupta wrote:
> On 20-05-2026 19:53, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 11:45:56AM +0530, Ekansh Gupta via B4 Relay wrote:
> >> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >>
> >> Introduce the CB (compute context bank) device management layer for the
> >> QDA driver. Each DSP domain node in the device tree may contain child
> >> nodes with compatible "qcom,fastrpc-compute-cb", each representing one
> >> IOMMU context bank. The driver enumerates those child nodes during
> >> RPMsg probe and creates a corresponding device on the qda-compute-cb
> >> bus for each one.
> >>
> >> The CB devices are created via create_qda_cb_device(), which registers
> >> them on the qda-compute-cb bus so that the IOMMU subsystem assigns each
> >> device its own IOMMU domain, enabling per-session address space
> >> isolation for DSP buffer mapping.
> >>
> >> The new qda_cb.c file provides two functions:
> >>
> >>   qda_create_cb_device()
> >>     Reads the "reg" property from the DT child node to obtain the
> >>     stream ID, constructs a unique device name of the form
> >>     "qda-cb-<dsp>-<sid>", and registers the device on the compute bus.
> >>     A qda_cb_dev entry is allocated and appended to qdev->cb_devs so
> >>     that the list can be walked during teardown.
> >>
> >>   qda_destroy_cb_device()
> >>     Removes the device from its IOMMU group before calling
> >>     device_unregister(), ensuring the IOMMU domain is released cleanly.
> >>
> >> CB devices are populated before the DRM device is registered and
> >> destroyed before it is unplugged, so no DRM operation can race with
> >> CB teardown. On probe failure after population, qda_cb_unpopulate()
> >> is called to clean up any CBs that were successfully created before
> >> the error.
> >>
> >> Assisted-by: Claude:claude-4-6-sonnet
> >> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> >> ---
> >>  drivers/accel/qda/Makefile    |  1 +
> >>  drivers/accel/qda/qda_cb.c    | 99 +++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/accel/qda/qda_cb.h    | 32 ++++++++++++++
> >>  drivers/accel/qda/qda_drv.c   |  1 +
> >>  drivers/accel/qda/qda_drv.h   |  3 ++
> >>  drivers/accel/qda/qda_rpmsg.c | 12 +++++-
> >>  6 files changed, 147 insertions(+), 1 deletion(-)
> >> @@ -59,9 +61,17 @@ static int qda_rpmsg_probe(struct rpmsg_device *rpdev)
> >>  	}
> >>  	qdev->dsp_name = label;
> >>  
> >> +	ret = qda_cb_populate(qdev, rpdev->dev.of_node);
> >> +	if (ret) {
> >> +		dev_err(qdev->dev, "Failed to populate child devices: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >>  	ret = qda_register_device(qdev);
> >> -	if (ret)
> >> +	if (ret) {
> >> +		qda_cb_unpopulate(qdev);
> >>  		return ret;
> > 
> > Unwinding registration?
> did I miss something here? The intention to free up the CB devices in
> case the device registration fails.>

Don't you need to unwind anything else?

> >> +	}
> >>  
> >>  	drm_info(&qdev->drm_dev, "QDA RPMsg probe complete for %s\n", qdev->dsp_name);
> >>  	return 0;
> >>
> >> -- 
> >> 2.34.1
> >>
> >>
> > 
> 

-- 
With best wishes
Dmitry
