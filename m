Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06057FB3CF7
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE9210E5F3;
	Mon, 30 Mar 2026 10:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FviTyNg0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OHdAfALn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE95010E5F0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:33:18 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U5xRRg2765461
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2w7omVV5MGhgUuytY9/a+Hrv
 /Zkn5JBJZX3qNOAW4dI=; b=FviTyNg07d3LeINqlYTW6MooVmHX2v0TPesAwWwr
 NKH2RGSEYwoODh5Vd5fb12GmzgoKbG6+pDbe1Bm7sD1STgldoGvqHyAHUwTlIV9Y
 RhwgDlLSrmCmEasOJrIhIATDYOg+6KY+xIc7YTnQxseq9aObPO1p0oA0FwKa/LDv
 Ii8wps687/YtfmztuFzldRFPRfU4FtTXo7TFbiEhQwDh9udI0uGLpK3k3aPioZPo
 GZb+q/+cOD2hZ3pC3+k4Hm2aJIqLxjQRjjA0Z6Jq4RbnQp1nkXaBvbWbpDrhpHY8
 3An8oNm6Icc+KNggH9PpsBRmQoAEffcTDEI0VlBSokKTAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6v9c3p6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:33:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5094741c1c1so107456621cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774866797; x=1775471597;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2w7omVV5MGhgUuytY9/a+Hrv/Zkn5JBJZX3qNOAW4dI=;
 b=OHdAfALnZR5eJLACbdL6DXDLqu/pcyRulVIqozChXpBIX3NoqOz0aEX4vScfAWw+lD
 8Cg52OgA+HAwF3/4upKjjYvaVfMw41wWGKLrc+Kvyh+mOKCPGsQJXD8G8XT6hqATe+Av
 Q1CuP3cgJDr/CR48WnXOm6wdFgoOAZdjv+v+d3BVPvvcjQddgZpbbi7hPqBGiJE6ScQW
 mvIz9zpgqVMweIlMVjOFx2+bVAwRO6zoux+6T6eifI5VZPJDlVmkxvEvSVv1N4l8rHow
 vDHUdwyjp+/+16uV7T+6sspUmufw3twAaiZ4ZDsed22BkR/uy6RpXGcFE1BZDh4eitey
 epnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774866797; x=1775471597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2w7omVV5MGhgUuytY9/a+Hrv/Zkn5JBJZX3qNOAW4dI=;
 b=eJ3dOL7kjk8Ghtt7k3U+HL7psdiRpOLQs6sJ7C2c73QmODeNweBl6To9tg5wxPBzt6
 gE+5l2/ynjY35W3GhaEPRPbZ20bkRxYo5YWKpZ357oUHiAb2g6ZUhzdP/5fqcS4Gh9eK
 xKs3WzgzThwFWDD9HJI1P4YeK26YTlh8r2dGytjSrZLPXP3XtnpwjOsg4jNcNzfSFX+t
 IfbVm1mnYeiFhPJIWjaM6lX//M9pSrfwd0KYsC8p3U13mUUUfiqKYhKceHBL8FzpZNGD
 jLo9DiLNY03qpKoDnQoIw18zeRxfCc3C5Sy/1v33qo25GrtUMrNdfBl3zooRtj1tGlTx
 GmbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+w+BBFQ5BHnFzFijHAl0RWCAzsy0rU9Ev6G05jcQ8xjnE5dqxHi1tdA6YQkctY+ooXhI1Tv/G9s4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzvihi8cGxQTTQqlSHXJiSgLBYXRJ4ky4K49NkGo6sgskNd2UUp
 5y1l6D4So6MAUOEvTeR/pXEWZ1xiT4A0fm3hEgQY5r5/Jd8WAOVC/LNHm/rAHusQdp59SYoJAvS
 AT63WVz4wEvNFOHNrEVEzdQROzkBobIgs7coJeVm0YUYoFJdAyLhRC8Bj2NrjPyHW5b+xiP8=
X-Gm-Gg: ATEYQzxi5/498rChAbCwkEgQSqyzPflODutKcNmmdrbZlUaFsi6rpjP60quKD4NhJIi
 /GJBTxrINwyVBCOYP8mbJJqMeWWSpetAHz5N20Nh6nFxZf3fbOOR1OdsN/9Au3R0AOmukzqWGqG
 9gBkxqdL1iIW5uB5BkytVLlyo8ofb2iNYTURT0UNurGhSRqUtt0QhDuCJlsT+hGxvlpibFq39V4
 EL85jZsa0WOocFOyUEKUsLT7oTrLacLi1BDM00ahleL9+v7Tnni6+s6U8zGGQu7TkpMsNa931fd
 YokqM0P+cdre47B3AgaTIHilD3vhnxgWeOhdmhUBC8/CnDRO63dmc2A8VUMDbAe8z8/FA4Y4laU
 wwzdMV04F/dGpL0dts8a0U7vFUQP2yFo5I0ajjQcSjAxT04ZHajaq8GSOSuntH36UOBdsmFKMcl
 adyJ+HyLx2x/jVt/JwKCcwpqP2Dgm+eXQT35M=
X-Received: by 2002:a05:622a:345:b0:509:f36:496d with SMTP id
 d75a77b69052e-50ba395d137mr157807851cf.33.1774866797213; 
 Mon, 30 Mar 2026 03:33:17 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:509:f36:496d with SMTP id
 d75a77b69052e-50ba395d137mr157807491cf.33.1774866796688; 
 Mon, 30 Mar 2026 03:33:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f429fsm1563883e87.2.2026.03.30.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:33:15 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:33:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/38] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <r4dtuhse2v2i33x56fjymlouk4ue4ftj2ff7pt3scsgoknegc2@innzpujxngit>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
 <vvemyg2t3ycjwb3uhwua7ow6yjvo2mnu5tdrqc3ed3iuj5ue3v@bfvgfhcxbgke>
 <e9d15987-7c8a-4ec6-8c65-a882139ba0cb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d15987-7c8a-4ec6-8c65-a882139ba0cb@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MiBTYWx0ZWRfX8SGIicn7OxhT
 qjWHnrZWLi8+TVZiTrkV5GKhXkhD6/R5fH6LyoKPOUebRPsuUGelYGPCaYYX67a0rpn5Mt9QKVo
 pP3yo2dIBtM0pzjGFP+MjijIFLOlBFKEJiUz51ylVszYjBobHm35h8coBYygn6N9M1/3lMtTahb
 b3j6CppZYEMxLoHLC5XXXoj8zbLay0WK3TZ+0X54NDlbf57PUC0yeSM0vfx8iS0J7sl5oYyuYb4
 BAwmb64xki3rzM394MMdm5yO7YQZbnrEADoMoXc9UUiHbnHT7u2AZitdeVSpehdQenAx5voPgMy
 6VHRCC+C/KCcRhyZxl8BjID7hOGOeCNAYqp9zUj+vjIdXwTAwFWu8FcwzwNhVTj92PQ64KP7c7N
 R9j5HnRmHFZ2514zYcUaaa+TUpTbqbUyUP3Tv3CxVS5pRdOhuqQIUqNV8fdI1uQw6rKhdoqz1Vc
 zUtPYvFMFv18EfGMmyQ==
X-Authority-Analysis: v=2.4 cv=EIQLElZC c=1 sm=1 tr=0 ts=69ca516d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=oLyNmjNKlfozL-9H-OIA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: _dhCNrtnjXFSWO2vaxr7uln22JRcZYqA
X-Proofpoint-ORIG-GUID: _dhCNrtnjXFSWO2vaxr7uln22JRcZYqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300082
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

On Mon, Mar 30, 2026 at 05:00:56PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 1:28 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:15:51PM +0800, Yongxing Mou wrote:
> > > The DP_CONFIGURATION_CTRL register contains both link-level and
> > > stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> > > all of them together, which makes it harder to support MST.
> > > 
> > > This patch separates the configuration into two functions:
> > 
> > git grep "This patch" Documentation/process
> > Got it. Will fix it next patch.
> > > - msm_dp_ctrl_config_ctrl_link(): handles link-related fields
> > > - msm_dp_ctrl_config_ctrl_streams(): handles stream-specific fields
> > > 
> > > It also moves the link-related configuration out of
> > > msm_dp_ctrl_configure_source_params().
> > 
> > Why? And it looks like a separate patch...
> > 
> Because the patches following msm_dp_ctrl_configure_source_params() will
> take a panel parameter, and lane_mapping and peripheral_flush seem to be
> more closely related to the link, they have been moved out.

This still looks like a separate patch.

> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c | 49 +++++++++++++++++++++++++---------------
> > >   1 file changed, 31 insertions(+), 18 deletions(-)
> > > 

-- 
With best wishes
Dmitry
