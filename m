Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C1CCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4C10FFC9;
	Fri,  9 Oct 2026 08:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ty7vvkaM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UazZLA6C";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9479B10FFC8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:35:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KKDP2369599
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=s4pQsGddClrCrII1kmbcET5k
 ZqpNT7v4RjJRYWDy9+I=; b=Ty7vvkaMmZ7MDralAPHqHSDYwDUbfCAa43KeasGQ
 rLEYQltkHcCPXhVtDYD+nzS00pGeRHaK//i+cRlWM/bgEkb26UrTd5as5r7vQCE/
 xiXkMKtwZYX/aERJHu2a5P2mf+gQtgQkg3pBUDb2+ZYLPAP9DrJEYqMRjiovwRBi
 /TaZDYy58zPDhfhpkjTMwfLgUoOWKsHmZibpzLdujJlszB6vOI8PfJIBoLbsxs4z
 mkfJx1dnP3fB9Z2AbvX6JpIJd9jxDr9I5t/fmgQmk71oZ6m7GP0QVUHOruxushEK
 l5aO5lEoYt6GGnMe0rpUOIdVQpZNkmjX84Qxd6/ieXnYnw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxwaq5h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:35:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179a2035a4so33869936d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534899; x=1792139699;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s4pQsGddClrCrII1kmbcET5kZqpNT7v4RjJRYWDy9+I=;
 b=UazZLA6CmstGcOAjp3W9QCcExMv3c8ooKE2DMdi6CXqs3gwziPtqwjM/x97SfAsLVY
 dFhrl1z+aPT3FUjlp+9xdAHEDlBFLzHa4SFE2ked7WgFlB83b/+/GWViNcxKvT+BhRpE
 LODo3kw5vm/lK79Ifeh2tlfHtTFNT21eiV9+7TrxAzuAhjgnzPtMvPuAhMf5/szcV3fo
 rsE5IweEc/7W/ajL9IqKFHfYfFx9co54zXBeGATL9bL6NiWwCa5fpaBgcbhXaIPvHdje
 R+2CHnlZU8KHoy/Khhk0qrs1y4xbJRrNRp2wvVU19+T60oaQ61PggrtJ9r1ySArU1Alb
 Fv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534899; x=1792139699;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s4pQsGddClrCrII1kmbcET5kZqpNT7v4RjJRYWDy9+I=;
 b=Cq1t0ea5B8c3C+Frm7GRMmwzD3zWw40bUgPVEhMlmPaZRuCxYl+njrmWjvuDrN0Cgx
 daHhuVXj25l0Tg0GeYTLmyqpO0FPiPC2I+EPqUKMI7G43idsU/NaXmJcuvx/DZoXj6F6
 vnIBT7bwhYe/PgZQWaB05ZDGrgGVq8NZG13LPWnkQgLOALEJVsuOm8awTEafsV5I3Xc6
 Cs9sFROSljTCMjP+QocOg8iJemUylaQnvaIW4IJTcnXrJVd0MCTCnF6706KyUWEJrORP
 BlguPq7PQ5zViVPhU4YU2jS/N5AyBv4TmTMpIvTmNrCjAdxdfOOy7e80ZhSM7xr2iyIM
 bFvw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKKO9L9mNveZsOXaEWrDE3pCazWdhoUp5k5yvjXFA29jr7L8Q9+oc8VffNbPpFYEgGRBZRfOSn4Fw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mD+7ygbUIMvooDnFEmgJ3O7g7eIK3hXxkIXIL9BJ2hcg2AItGd
 7KKoLAbP4xusYyLbfPdgHDYGPmK9oIQy5kKmUInpQ7FGinulVwZC6yY6n5EGbtCLhcYUMeSJrGb
 hAAYPZknHY6f0pPDJH6FDUARfLMpM0QTxTp3DHOERtVRF76JhXugp/vNAxZavTxHM4XHXmY8=
X-Gm-Gg: AYBFou20j45kcGmddGFmPMTyKhzceBcFmrbEN3GHd6V7ZsbGkvd8147Y2bIe1HJ2tP/
 25xdN7Y/g0VgOy1+XD75ErdGgoFA/ds9MiDIm29LdmP5MjV1LRJQozHigJ9JOpWzZFnHbEsnQea
 UrmLDvkFloQsr0nglqqQm6hKS6DbbBpHJhy2bN7b7nZnp2J70wUIkzXShSQkik+I8TaYSqiTJRe
 2LM8D/VqeQvnGTv4LQNsHnPKDV+n5eXdmAh7qBUXT9Z0Bd0a+MnX2SJIjfvTCxohPU0CyJB02Y6
 tEi5ofDQ3mEX48LsTdkWvp2Z6HzW3nmqN7vBbcrjudZON7YHHc1+DKIH1yh4lhjK1bY/NwNVusp
 hflR5/VS5P66rYEy93M9qcZMU4Ycqbpqv8SHRuchQ/gu7M2WOdaN/OsEpDEYCtGpLwk6C5HYBMM
 miHpcOoXbgpaIt
X-Received: by 2002:a05:620a:3181:b0:939:fe55:402a with SMTP id
 af79cd13be357-93eb966845dmr239799585a.31.1791534899029; 
 Fri, 09 Oct 2026 01:34:59 -0700 (PDT)
X-Received: by 2002:a05:620a:3181:b0:939:fe55:402a with SMTP id
 af79cd13be357-93eb966845dmr239798485a.31.1791534898596; 
 Fri, 09 Oct 2026 01:34:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde36004sm446004e87.8.2026.10.09.01.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:34:57 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:34:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort
 over USB
Message-ID: <mh2mmbrs5omoo25u4je22tq32ka52kusz6u3xkeohea4oa5o7p@uww6ugjnutho>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-5-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-kaanapali_dp-v1-5-6faeac3a6d59@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX21Lcw+LTlpJz
 t7l41+fkSSW2RnjV6HxhEZ/PNPqylZTrgRdJCdy07hrpMhVGOP1J58vKN6Rp4NnpAIlXdRp8iT0
 UvvrzY/GeN/6AYvTttSnz2chxtZhYT3msDMRHLRbuC5jTY4yujeEkaCkr+XfPQOMt8iOYeNEjQm
 j1/aA431aTTDgdwhU42pzzYUzE/xPMzHVWh4LC1Q6hiNoPKVDIdUFUtD1XfzUsJ47nsrYFbr/+y
 SDIu5hZT61wPd3B8xlgr64igy67w2aXxnR5CnH9GUXO5aFvlQo6G0p0c2BVA5u4VJDL91SA2w+A
 yApwigR8FCT4DoYMO8BikfoESBgsN3XbdHUTLYOa8tGbL9Guhhnx5s9sctcdbqGh71t8DLjxff2
 DQAo0u90U0SZq1py1tsGdnwjxxKrCnNUtzQvrHYCBnZ3R5h7geXrqMBP3/FQSDaJxyO8IMFKhUw
 aoIy0URxGB0qzQTYpXA==
X-Proofpoint-GUID: mRYtHHTN9EzYjp4OzyjlmaIOoD1bQf05
X-Authority-Analysis: v=2.4 cv=cMB1IVeN c=1 sm=1 tr=0 ts=6ac8a734 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=tbCzt_ceUV_s8fUbo54A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXyXVMxxEuXgHj
 Vl370IkQRoSnnrluF5PtXiR8wbBuLursnemqMqk2eYzbEhXNfHixdBeV69iKd4KvLggTdsZ6k8v
 LgFA3rhmpEEYDSZiD2mMkXcrawLfQGs=
X-Proofpoint-ORIG-GUID: mRYtHHTN9EzYjp4OzyjlmaIOoD1bQf05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090032
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

On Mon, Oct 05, 2026 at 12:54:30PM +0530, Balaji Kalkonda wrote:
> Hook up DisplayPort parts over Type-C USB on MTP.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kaanapali-mtp.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
