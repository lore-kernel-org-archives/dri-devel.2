Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E611D35171
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9A710EBF8;
	Wed,  1 Apr 2026 11:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LroaltNi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVFTPz/b";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA2E10EBF8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:26:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317CcIA3103857
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 11:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wRQDTkPOw0QqZKbK/WbPq1sg
 HEfIuzydEfvDEGqlxVE=; b=LroaltNiOWla6/N5KJ08WTt4TT4t7x/J3cEFbtaY
 c/Pcctin+dhI+1sEuTwIsp3qDPyJ8ZCbgwqv32G9T/6zucv2kZu80haF+Q1uhnfn
 g5F91/4X32sJ6juxuexMgs4IfJI5dmWMenL1bk+M4IiC2xsjZuFeuy1TbC/3W70w
 gzs4X3PHJEa4a6yVai0IYH9lKh3LTqLTiTIpmSMSbybTFMvCHoudUbHTavWCTXOu
 kGd83ALylAfC9G0+BMEPFA2lTj6pAQ40NfcQT/KlZaPDy6b+5h0WUc7SaUF+kJNv
 aFTDKEn6v//66po97iFkUxtvjlbacE9hauG2tikw2AwP0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js2428t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 11:26:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50925fed647so81213141cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775042800; x=1775647600;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wRQDTkPOw0QqZKbK/WbPq1sgHEfIuzydEfvDEGqlxVE=;
 b=LVFTPz/bneCUoi6VQ1y7N1Z86C5X1YkRdfJB5hEf/QSK08W1WlRpx779NMX67ezkvJ
 x7qP7hFsS06LT8nHETDqRKDDFoP9JfF16UVhFoLCpjmqm8LMhRUsXV6GVDCfvkn/HOjZ
 XXPwk7065hWa/q7ingflUq9vFICjHukRLwZ7T4wPk0qA70uqH92WCiZ3Zpn6fbwj46dK
 DbD2IER4eVkf134x7lAYh+NwfPheQQi0N4PKXmr7xeLXyV69NAIx8AfDxN7uFmTqaAdY
 FQ57+Xstv2ZO6i56PwBAT6lLP6xzYCT5HxrrAzLV/SL2MvhhdNEoOU6Pl3ryAakkmCFa
 Atzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775042800; x=1775647600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wRQDTkPOw0QqZKbK/WbPq1sgHEfIuzydEfvDEGqlxVE=;
 b=O7WF3kLc4I2Uvs/cQXs0EIHpBCUOhPPARcjiZ0G+5kPmq0jc1c0h8c9fY9P+WyAlqI
 BIldAI9iIS+6jHDAvw2k5LKOH0JH69xAFe6rfwG1ZOKWR8DFFxxmog9uvgAiR/77zBYl
 pxyRtJOEj9chzyx3i3/vEmD0vTEQ2xTKvs79YH9RIs0TdmH61zSEsyj9pqtSlV1ddUZW
 HR/pQC+DERj7TrEj1Li6wAmNRFX3XoybhM8wn/WmAe6fhKDUoBV8uggoMjzQrUcDQdTt
 ENPk7+C/1GaZ3ORAB40H9KzDB0W7Zu0vX3O/vrREwxiynMLayOVyVmPGMITlyijYMKI4
 3mVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs9DLR6XYJLfMEyovTFZSgB6Gauvb7QMQk4g/sJ/SA7Rxo5kmW6E+oBplkLNMENF5ZQbR+L4Eo3xM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPitHkZ9SVMMcbPVwfMx1ffC5T/fm0PKuyvVx3EwpL7r+f22vc
 PsR+DrhNKLA5a36JdCrgkLdsAE1zeo7b6MoewK0DsFrS54tK1xkzJ0kD+1veuzZW8iXtS+ROJHp
 SWoWg2viuHFnqaauakUOF7CZuxdArmUJHREYv/+PgryODFvfjYybTOGYcUEwcg3jg/uhFaWs=
X-Gm-Gg: ATEYQzwUZNx5NB6+3vE4UjznJWZQ69zvbimxLfn0A0uCOsTWaorHUvgvmyCpznIV5GL
 wIb0bPM545oSlSpe0olPRef4KbNdaeRphLAFMfrRMOt450eIUVp7Ijgn5PlLbxSNhX87HoYF7rT
 Wn4WmxkBndYMbTzkDzC/WWsiLJbq9sKyixx5fKhYwKT8kIxxb0zbIeQzeqiWlK6+w8w7dlVeUme
 gM3QpV7aQnTjANnTIuGPkSfIPwWAPsXoabTzCstYYS0e37Hbud5QKz5zBfREQtwYkOhSb2EP3vc
 ZjbVQOwCEuqmvliAwKbcHWzoHN4uEgorxt1XknrvD1D/y7Kl8LSVa7GSxffaHC3jlD723TMT1CU
 v8ZePU76DLhansCdZQ2v5GGDYQ8fIk75xi5wx34QAjcoELOuBqTuoI71khwdbwnFiPr3/JG6z7P
 E44sX61fhTFgQA1Tix1+Nr1whlq61Ws2v0w8Y=
X-Received: by 2002:a05:622a:4c12:b0:509:5dd4:7192 with SMTP id
 d75a77b69052e-50d3bdef817mr41599861cf.54.1775042799809; 
 Wed, 01 Apr 2026 04:26:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4c12:b0:509:5dd4:7192 with SMTP id
 d75a77b69052e-50d3bdef817mr41599411cf.54.1775042799138; 
 Wed, 01 Apr 2026 04:26:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c836d42e2sm28282001fa.5.2026.04.01.04.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:26:37 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:26:36 +0300
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 15/38] drm/msm/dp: use stream_id to change offsets in
 dp_catalog
Message-ID: <wbnb77ookesmar5fitx6hnfej4pih4gpwfoigfqgnjsnnpzule@ybcvwqbp55b3>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-15-01faacfcdedd@oss.qualcomm.com>
 <vrbxqjfvg6urywwmehoykz463vphfg6c2qiryedulvlrcbvals@55lm4fmgf3in>
 <0037ba69-c104-488c-a388-8d31dcbbc78f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0037ba69-c104-488c-a388-8d31dcbbc78f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 418LqmhnZ-5ZOSg24L80hrwAYDFSzmLm
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cd00f0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=QyJMuQZcD86jedyQ44sA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNSBTYWx0ZWRfX60WCE9M3ZdiC
 WBpZVTFLu3RF9OC1b9/W3BV7akiRZVtcK01TWPD7/AaqeRq1qUt2NW3y/dL0bYmOvSp4luAcdCE
 ewqd7tWUw5I+J9qSjNewh805229JBb/Q7lHbZKFvL6gPb6QRFzUbxFFe3vQF0r47j9hHAmkMovg
 ftNDW/C2LffLaC2XqHyT7SZCZurJvaOnnqKpaorsD5J+Sz/WvuboGxBo0nP+dgbLuiqeFb4jujb
 KvJkRS5kMQ9BttkpinlXdt37jg0t9Xf8+GInc4k1WbYy9kRVCAMnwGl6+WdYdKBCbDm4KkD/zZF
 9H4fEp/V4dvrufPm+ACb6sSzP3TXQ8LOUZXXkhThM086SRlkJzmO49+Cm+jCseskaQ3U7e9Sbg2
 pPNT0PkMv/A2ts15MEJDGZMC5/tGgOATZHU+pReEW91woSedicznOioRl68vYCuicXQUqfTg50/
 kyCsqrjcOyfILjzGeiQ==
X-Proofpoint-GUID: 418LqmhnZ-5ZOSg24L80hrwAYDFSzmLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010105
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

On Wed, Apr 01, 2026 at 02:33:49PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 2:01 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:01PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Use the dp_panel's stream_id to adjust the offsets for stream 1
> > > which will be used for MST in the dp_catalog. Stream 1 share the
> > > same link clk with stream 0 with different reg offset. Also add
> > 
> > Shares what? How do we handle streams 2 and 3?
> > 
> Stream 0 and stream 1 are controlled by *_DPTX0_LCLK, stream 2 uses
> *_MST_2_LCLK, and stream 3 uses *_MST_3_LCLK. Will update commit message.

So, we might need some better interface for updating those regs.

> > > additional register defines for stream 1.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c  | 24 ++++++++++---
> > >   drivers/gpu/drm/msm/dp/dp_panel.c | 72 +++++++++++++++++++++++++++------------
> > >   drivers/gpu/drm/msm/dp/dp_reg.h   |  9 +++++
> > >   3 files changed, 79 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > index b851efc132ea03884ce2563990fbc24c9577e724..43a9ce0539906e1f185abf250fdf161e462d9645 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> > > +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> > > @@ -141,6 +141,7 @@
> > >   #define DP_STATE_CTRL_PUSH_IDLE			(0x00000100)
> > >   #define REG_DP_CONFIGURATION_CTRL		(0x00000008)
> > > +#define REG_DP1_CONFIGURATION_CTRL		(0x00000400)

I think the file is (mostly) logically sorted. Please don't insert new
entries in the middle of it, breaking the sort order.

> > >   #define DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK	(0x00000001)
> > >   #define DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN (0x00000002)
> > >   #define DP_CONFIGURATION_CTRL_P_INTERLACED	(0x00000004)
> > > @@ -159,11 +160,15 @@
> > >   #define REG_DP_SOFTWARE_MVID			(0x00000010)
> > >   #define REG_DP_SOFTWARE_NVID			(0x00000018)
> > >   #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
> > > +#define REG_DP1_SOFTWARE_MVID			(0x00000414)
> > > +#define REG_DP1_SOFTWARE_NVID			(0x00000418)
> > > +#define REG_DP1_TOTAL_HOR_VER			(0x0000041C)
> > >   #define REG_DP_START_HOR_VER_FROM_SYNC		(0x00000020)
> > >   #define REG_DP_HSYNC_VSYNC_WIDTH_POLARITY	(0x00000024)
> > >   #define REG_DP_ACTIVE_HOR_VER			(0x00000028)
> > >   #define REG_DP_MISC1_MISC0			(0x0000002C)
> > > +#define REG_DP1_MISC1_MISC0			(0x0000042C)
> > >   #define DP_MISC0_SYNCHRONOUS_CLK		(0x00000001)
> > >   #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
> > >   #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
> > > @@ -230,8 +235,10 @@
> > >   #define MMSS_DP_AUDIO_CTRL_RESET		(0x00000214)
> > >   #define MMSS_DP_SDP_CFG				(0x00000228)
> > > +#define MMSS_DP1_SDP_CFG			(0x000004E0)
> > >   #define GEN0_SDP_EN				(0x00020000)
> > >   #define MMSS_DP_SDP_CFG2			(0x0000022C)
> > > +#define MMSS_DP1_SDP_CFG2			(0x000004E4)
> > >   #define MMSS_DP_AUDIO_TIMESTAMP_0		(0x00000230)
> > >   #define MMSS_DP_AUDIO_TIMESTAMP_1		(0x00000234)
> > >   #define GENERIC0_SDPSIZE_VALID			(0x00010000)
> > > @@ -240,6 +247,7 @@
> > >   #define MMSS_DP_AUDIO_STREAM_1			(0x00000244)
> > >   #define MMSS_DP_SDP_CFG3			(0x0000024c)
> > > +#define MMSS_DP1_SDP_CFG3			(0x000004E8)
> > >   #define UPDATE_SDP				(0x00000001)
> > >   #define MMSS_DP_EXTENSION_0			(0x00000250)
> > > @@ -288,6 +296,7 @@
> > >   #define MMSS_DP_GENERIC1_7			(0x00000344)
> > >   #define MMSS_DP_GENERIC1_8			(0x00000348)
> > >   #define MMSS_DP_GENERIC1_9			(0x0000034C)
> > > +#define MMSS_DP1_GENERIC0_0			(0x00000490)
> > >   #define MMSS_DP_VSCEXT_0			(0x000002D0)
> > >   #define MMSS_DP_VSCEXT_1			(0x000002D4)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
