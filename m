Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68799CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA41410E21C;
	Thu,  1 Oct 2026 10:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FafYS09y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aD3jF4vO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F4610F61B
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:52:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xRxm1289079
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=seNlxQsU0wllHJnL2cV3aBSv
 wJpkeEtX02XCtF/70CY=; b=FafYS09yqsvT65Yhy3dpAw0dLe2AMzE50o4dWqC0
 bKlv01b6jJ5EUHqvdap6B/wT7rCxVcn9qcevFkPyQfJkzsq8LDHO3ZNv8nHlHQ47
 kD1/EGik/UOcKqKpR4RVaAnGQCXyKv4GbxOfI7dN4x4hqkROIcEIbSI3wruTTeQg
 HBOJ/xDJJVwWT3OGjnVPh+I2+sR12pSurH3PRxVy8Ogfs4QWTJIc/YsK9ZP+ybPe
 cdy2kwZQklyZKfajKHFjJaBsj+vRYA8InJrpd7/rk93pWWbPLHBCl8UAGoYaNDuX
 okGh74rAmv3rBBu6rFc218GDYvmLs6NFH7+rgATcFKSkfg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pjbjgh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:52:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso1165501485a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790851949; x=1791456749;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=seNlxQsU0wllHJnL2cV3aBSvwJpkeEtX02XCtF/70CY=;
 b=aD3jF4vOqCVRud/7DDX87DwST5QylTtstMdaxyQC93AhPiHdeGz/JwhpFnOXjAbERI
 trClxoRE5p0q99s/xfkCuElbHFMgxNA9HktHlHe+VJVBXJUMU1sQJgaO+ZDEa/79dnMT
 cTx75n1VVvGqDQoDzVampCmJrCVsiutjIof2m3HQmNDiib+Npn5JfINxCc0hBIgqN2YC
 C8Wn8vdPPS/ZrnsAJGcZ0c3qhkmBwkAAgerogUkcQb5dfgDflEalTDuOnjSszkxS2vB8
 bTaZ4cA5bEz+98ZewrDPSKtjQWrKNDzHsLG7ae1Vl308ErGHN+D4I69eznIzPNmuMxbG
 HdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790851949; x=1791456749;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=seNlxQsU0wllHJnL2cV3aBSvwJpkeEtX02XCtF/70CY=;
 b=EdWaoKVZeGaqIRAPqjGl9MQiZw8BP4aK+urtCJjsbXf7Ihr/ZUYl/I8kpy20iKpmt+
 M6+G73KDgamN6H4I1dZwk/jwZPLuCiCq1r3B+iU4YYrmvzPvEt8dLpUTp+esT2R12kZ/
 oZgzCcdrIOaipXlbtaIT9owWXMEN0mj5qtJu1u8BKuom7iFWVy3cAkBFcmo05lMJNrMq
 McqEiaY1I3//0BvlCmLrpwIOVH1TdJOWBE3E0gdcY7OtEPX6HQDva6yVuoXn3l075kVd
 Z3QkvKnDoYYeGgoR86HevvmLcPnqeW9tbs85mXj/QUZvHs8jv1EJpjnjZ0aJFuKzTRd4
 GfDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxt6pCEozsp7GVBKwG8QIgisZEp5Z2XaKEi+wtp6XVH2W/PaPPGQTuIDrcXiV76S3/Qjfa+lOn3SBI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgg+3IUXX8y590t/p09qsPZrJQaQ4LyUHob1xcl8pi9qSEiNgm
 vj+kl2c6uZIrjBkRZRF95YVrtnRegz6lAJTk3Pd11/mddt9n9OPS2dJwOne2zp0r55PvJv0CO8t
 xlaBGzunS/44uxpu+7YofsGNgln6tDKCrbNf2bqH3fWxmRSf89ObgD6vM3Un1ckwW8rrBwms=
X-Gm-Gg: AYBFou1G2+7u10oXfCcjOQqqEWlmJg8UosZ/LD2o2o8MpIoLuGE2a021tMdc5KJGzxI
 AFuz+zR0wLK+nG4Og1DeP6D/HdW/mkLz9SAmCUH08+2qRRy3VOFMiZzvMaHHA5bA0BacGdOHR7U
 dvXIqiEujf1jrmwfGbsIftQRaloJMRjlCgFM8CXCq+kOdsUGhFSIAxA2y+Z8pRbP4ExsezC3kAo
 5Etdes8XpJR4tEd7sratJpjQhHyc3BR/WUg2wbx4B0F8z2JfSZD7HzTuJNebbT5ViU5cdX1oFs4
 Yn8QYKR6fvWaQdwaRnyNfN6ZkRkOvYs6hd+iE5rDevENn568SfNr3Y6ty24Zfu/M8zKulLkdNlh
 Dy37v3RQ8xLlT8hF5Ritw674FBodEVZfSM290on5SQ1LCN1QYaRAhhxEcuIpkL8uF2p7ZbI2+4P
 femHH8PILJbgcJ
X-Received: by 2002:a05:620a:1d05:b0:93a:3d67:391f with SMTP id
 af79cd13be357-93ca95da7demr801489185a.7.1790851949377; 
 Thu, 01 Oct 2026 03:52:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1d05:b0:93a:3d67:391f with SMTP id
 af79cd13be357-93ca95da7demr801485185a.7.1790851948771; 
 Thu, 01 Oct 2026 03:52:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a7be8b7333sm4165741fa.23.2026.10.01.03.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:52:27 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:52:25 +0300
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
Subject: Re: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
Message-ID: <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abe3b6e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=B9W9OPTfjs53PBBgks0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Y0q8KJB3Te4GM70myPccs9UgjRjUqFjc
X-Proofpoint-ORIG-GUID: Y0q8KJB3Te4GM70myPccs9UgjRjUqFjc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX7MEHTvyeZvbU
 FAcUzfmz7hCvPNNpz6vW2Woeu0r8SS/12cTO5ZzNE8INFO9JNBkTjztsc9iVuB0RjydwL4wfvuD
 vxgmHskm+Z720mBnXyWhNvFx3iLb1+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXwxSlyLWdDLOv
 +MIMrd+1sB3f1xJyfsmW/RA8jXHt9UInzTHtOPsFJUrqyjL1msmc48vjP+cUrvoLgghAHjq9Zhr
 IZ39GottY3R+nHp0oaups4OnBQ/Yt67xRstUogPwZUTCqf7xGt2lZXHPVfOUjZv1vdrW3fGLTvc
 E1lm/+4jogU5BllFjNtBWgd96P5gAOcJ9zP42Cf8COvXWDkk0Hp/2LtKfHoK1qcDEzfw5LHPUgi
 o86KuxgGBIZY/lBFKoCvanosjSCotGlIscHhrLVfIOXXCrczv89AKV1j9xeG3V7uAnQ1/TG3f86
 72warJ+wfXPolzb2u2tvsdNOjSlzRXq6Mw1R8R8G1AGFg/bk3Kd0o0I9dZckU6IUvLKXKJO7Fl/
 M90hKSV6g/0W6xwUfpNdvoqkUJ9dszDNpuoQpo+E99Xh2QsvRA1XVtTQSCEW7VWibS/ORoVdw7W
 PO/vKK9HkWeoogwmwFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
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

On Tue, Sep 29, 2026 at 12:25:37PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
> support for calculating the rate governor, slot allocation, and slot
> reservation in the DP controller.
> 
> Each MST stream can reserve its slots by calling
> msm_dp_display_set_stream_info() from its bridge callbacks.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
>  drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
>  drivers/gpu/drm/msm/dp/dp_display.h |   2 +
>  4 files changed, 206 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 929e0f94f8dd..02732bd4efa1 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -83,6 +83,7 @@
>  #define MR_LINK_PRBS7 0x100
>  #define MR_LINK_CUSTOM80 0x200
>  #define MR_LINK_TRAINING4  0x40
> +#define DP_MAX_TIME_SLOTS 64
>  
>  enum {
>  	DP_TRAINING_NONE,
> @@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
>  	u8 tu_size_minus1;
>  };
>  
> +struct msm_dp_mst_ch_slot_info {
> +	u32 start_slot;
> +	u32 tot_slots;
> +	u32 pbn;
> +};

How other drivers handle slot programming? Is it something to be shared
between the drivers? If so, maybe it would be better to update MST
helpers. Or, asking differently, why do we store it this way? I don't
see where msm_dp_display_set_stream_info() will be called from, but
isn't it a part of the calculated state? if so, all the slot allocation
should be stored in the state structures rather than storing them
directly in the private structure.

> +
>  struct msm_dp_ctrl_private {
>  	struct msm_dp_ctrl msm_dp_ctrl;
>  	struct drm_device *drm_dev;
> @@ -153,6 +160,8 @@ struct msm_dp_ctrl_private {
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
>  	bool mst_active;
> +
> +	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)

-- 
With best wishes
Dmitry
