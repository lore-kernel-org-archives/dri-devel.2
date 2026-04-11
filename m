Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B50F3ED5D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 18:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B29810E22E;
	Sat, 11 Apr 2026 18:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ng3Rfe2R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wo9HZ3jy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2433E10E22E
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:59:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B7uDbj3335431
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yMXwJeOoyMRoxOqiohaIY1c1
 Mu6lsh+DPObO7YT8FI4=; b=ng3Rfe2R9gVk+AzSX8qVwdlPap4D5Q8oPHAFZKzQ
 YIiVOFuVLgcu5SIG41FS7z16jnGyXeeafXzQ9Xgx+cHVbNpb3OG7jHRDTdD5+Fqb
 6qTW0p4o/XnLdDMtbQH53gVB+9NhUBaQm+w2Fw71+fl58yOARFcpN1ybEncP6XdV
 Hjm9NMpfP55A7HmGuDCcnTmOzjyCdnUR1I6cCxeqEa1KovVjns4pJHOL34FJbXey
 z4CkIVqfDb8D6mbsjCkbC62pMUHO70yhIG8DACN3aCMtnInumCsaxcjHoNEB6mJ+
 8ngbrEp1F/dC+nR0a5mjqSrcYdtijiJZQLAMS6zZvTdkVg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfjbp8wrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 18:59:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89ffce20deaso8041466d6.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775933975; x=1776538775;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yMXwJeOoyMRoxOqiohaIY1c1Mu6lsh+DPObO7YT8FI4=;
 b=Wo9HZ3jyrfrbn2qal3cz1Ge23bOzZCyfHs8ncuQRtympeEU610uKW/HrRzIockmr5O
 MV5O9zs1WnsmhCcieqFFE2Lji0IJIwA2n6vwMIExf/LV4zZvSd2s4kiHMfGoQt9we4a/
 ZnY2AErwyytX7QN5sm0ZHvHlqTBBnr9bieXAwCMu3ZKW8Kr2LGThTO9QUShE8jG0fFUw
 2BmNsIWEdR83CZehhVie/xTjoCi5wXkA/gllzBlKXoENT3+S7RFbrBxNrjcR9MaVJ7Zi
 x/G5p0GBkvPsQv9yZNUkjwATnoC0a7NZ6k8dXNTh+K5Aqp1bS/v2qiMkHTmYrPgGCYPm
 6lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775933975; x=1776538775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMXwJeOoyMRoxOqiohaIY1c1Mu6lsh+DPObO7YT8FI4=;
 b=NVU/TP9/wPGS9q3qZ8dadOhtHSEXYp3vBiYPGxHSaj5V5L7mWxHITEXi9AikJUYm+h
 GpZD0gN3gT9ffx5Lx6mgZK4X30xcsrsjbbwZc3swX2wbbCeDWifSLU8feHYY+4NJU7Hh
 dX5C8dIKCfMqoZqxPfiQezpQpqD0xLz+4/5vcVdaEncm/zDo42nWpQeEo1MB8keJNzPT
 q0svNWwBFPUOio4Uy0+8fwOnwgNuShHdBUMmSLrEUlVBZmk67qLYMrbUnbQfZDQlYWaV
 FqT5JDdFUjy+OV4uJEU+SqZWv/DH2/taz2sHAinbuJPIoZJyJfLgnNPwm2wEUo1ju7YP
 IQ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3hpao90JNRxvfZPTTVrtmjqwrO3b6Z3MSK7SOId7n3HIdIu3lx0Kok41im4LoKilihxYn6CCKeBQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUwNIkVFDSAWJuR0l7XRaM/4FMF2q3O3siQVtXeE1/qTDcRnRo
 YVs67RJd3Z++IyYPbCduaoskrAx2w9TuqlwuKCCpFPmp28TbMSy2Vp7QG9gK2YkCd2Veul6X0bF
 vGaEhc7t0wMWzgH2PnGggJpDO0wrboTC8CGKzCaKWABUCSpie65ujgAdgVAtSE0u0S3wJMqU=
X-Gm-Gg: AeBDiesa/PbcKbKrAyqeH1swoL/kZ2uAHZA1Y77jdvdZe4bNsVT+i+Ss1m/6uRzXKf6
 sSImb8ePYjckEdeBXkyI4GUDtiauMcaNHHv8vYkDrqaQ6vyBorngAkO1AneQW1ewHY/cPhf3kGL
 8fa6vE3jmTkHYgDzsIVaUXlLVs1pdKQAXB6Pora3KEh4bq9yE2YrKfZ8z9b21rUkntGgDjLvIxi
 Z02UR7aSxSeajTLPpNBki29BdvRl36bRdDGPZIz66VNn8HukmzDpis66Cpm3WIhCDEjWRH35drW
 wv13BkhHub4JFfNQY/JoYRyxTqyFErNNRV2aRmLV7sRYPjH6p29QecklbngSVOBfDzBC07SV1KC
 F6hDmP9Bw0IePoU8nhnV4DNV0vxRGm/4BkkeO5EMEbQZhGwFAJyVJnbuxCW5IWpzVQ5tmyhs8Mo
 pt4iND/8EBLNqhI1zIHYafMSFyF1qMnYOv/2U=
X-Received: by 2002:a05:622a:7508:b0:50d:a8f5:d521 with SMTP id
 d75a77b69052e-50dd5ca7688mr75567211cf.57.1775933975596; 
 Sat, 11 Apr 2026 11:59:35 -0700 (PDT)
X-Received: by 2002:a05:622a:7508:b0:50d:a8f5:d521 with SMTP id
 d75a77b69052e-50dd5ca7688mr75567111cf.57.1775933975205; 
 Sat, 11 Apr 2026 11:59:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e492702f7sm14351681fa.9.2026.04.11.11.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 11:59:34 -0700 (PDT)
Date: Sat, 11 Apr 2026 21:59:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 19/39] drm/msm/dp: Add support to enable MST in
 mainlink control
Message-ID: <rovdbbjvreo4mreknmkxexiqemb32v22zbclshf7c55etrjd7d@iwtzfdmh2uyv>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-19-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-msm-dp-mst-v4-19-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PuijqQM3 c=1 sm=1 tr=0 ts=69da9a18 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=HaRW5ahlYzQ4Xp6BNlIA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EAcAPC67jxgPyiZlkm7YDqvOvubtjjEo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE2OSBTYWx0ZWRfX/ij68YSY1zpE
 5e2UaODSeDw7dhc0gG7QA/AmzXdVTyMNrSv5BVHy0BwoszYzspBPp3q2BsRShCEJiO8t3RtqNv2
 KsR2f73ICIXjBIgGDev3+3RMF6TohRmLEL8iutWPIyh/jA5qngWULcCls66qbkTW/V/M/BoCnMw
 Qoj/GYMk34O+8EujQP8Evs+fD1q3A2dZLwu7IFnhQPYnth0zCPpEiPS08oFwLcgRYnllJ43A/N9
 1hJNuNDwsg46mlrjw8AYarqOdhkTmdJB31yP+eGEkP5iB3jCLbi5uT1WnXDFpe3fTokxoZEPk6s
 UvwcPkvR4aZLtZegqQo1IDgWlDTqaWq1yUOg5+1P5chKliLkt73nl/XkrWTO+8j5pNK02BZybD7
 aGHN4q1i1buHGDqb/mN/fC/T/J/EEvCe9JYLpNJwM2c0pKOm9UHhTLMnlVktlTIP1nTqOVngWmY
 rQXckgq2Bk2pvT4fatQ==
X-Proofpoint-GUID: EAcAPC67jxgPyiZlkm7YDqvOvubtjjEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110169
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

On Fri, Apr 10, 2026 at 05:33:54PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Add support to program the MST enable bit in the mainlink control
> register when an MST session is active or being disabled.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 17 +++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_reg.h  |  4 ++++
>  2 files changed, 21 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
