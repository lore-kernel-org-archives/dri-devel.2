Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAB3CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4656D10EFE3;
	Wed, 20 May 2026 10:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0qpEo8i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fDETJSfz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC7310EFE3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:20:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oLoL1177853
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=kGu9iTGWx42JekHQzxcy0M/x
 7MV9NKa3kYQaa8egCrE=; b=X0qpEo8iPd60v6e9nMb4T9d3vvZ2mIYPU+sug4pL
 mqlJf60SlpSafzM1rb9GwxxSTBG0KFu/CmJ6LFLrZ95swt6EKhWMA4zrzxcDalsn
 guqwfNY5XVn1f+H4ElLPGfaJ1ef4WY15XVpnRkxqMFfF+5E2Zy6ebsWJ3pMpwQLh
 oanVfrK5FvQM2Ou2cZT6vETEVMLC0ll6byAMb4dd2PzNATDSZ3bxeo7IUsfD1/Pl
 MLBus55N+vG0sVhwPfRgMXz/YsqjQKdl/V391b1m8foPRnXHDRv8titlsdqYZ6DI
 s4Z9RO664BF8CVRwkYKNNAisBJ2bg5Zw7chaKHGFrPVlzw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6r3p2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 10:20:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51494d74d4bso125746651cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779272457; x=1779877257;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kGu9iTGWx42JekHQzxcy0M/x7MV9NKa3kYQaa8egCrE=;
 b=fDETJSfzVX2WiNQP34rxHju3GPnPY1p7JTpvaBEk2xMEL01JtINLp5IGCe19af0ePl
 1VOUc0f+15waRE6WfI3dkeuOFUJVYMolI3nhAgVaTXEyYJ9tj0IxB0C3ZKZph/wvRwXP
 sQ7uT1f3Ixdu2a6St+2yzRKaXEIt+Gj+KndMFrwvLJSHImXEFuc/BcOI8fEUMnmU0md7
 tDxp3WIgbmQM1AaP3B7sMQjovehI8FhIF0ig+Z6u5BozlYYDyYoiJ0K8ERs8PwAI83oD
 6bnkaZhUgl0XMCUV6qKt8zZ0V4yI9ba3GToI4u2cVm1pJwOvV6MlfL7MWGmDb5QyBa9Z
 ujSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779272457; x=1779877257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kGu9iTGWx42JekHQzxcy0M/x7MV9NKa3kYQaa8egCrE=;
 b=JfQJznmkgFkdd60oyrqhPBBYtAVXlnFhfF+WsXoDv6uvdaPLYOhadnfvJJMyprYPzD
 vKC0+VsSGPrKEUbvy3qFze08KbIgZqV+vFX8Bud1j/a186UJKjhZOjbMdV2mh+IU0Bah
 CRq6rvurq+gpIt4XBQ5AQc0yxTncfAkvKD64sDsSif5p9Ss41tnb60R+VC1aURn/+M5e
 vMjcJ6GMaGSpcUCTRUExkrgF7UUefeE3r85/E5YEMWUBpc+3tF6Y4UuTb/oW5/38gfm/
 IcU+IOVGigK9Cr6/tvPy9RMUWQO2UYfj8wdDXHe35hrAxbKbIL0gjRzRUrdUdGs7zviE
 TGtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8X1t+3Mnta5Xb8R9MV1ILudaTYVyb9/AyaNM//mooQ/c1++OjjsZ/IcVq21YOh/so+5Ht67f4bVOY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfrwA/dOmiwyP6VKA1emIIHiEFkmKcs5RY/hRC6u1KGcHA+ArI
 ONu50r0ukIZ2UT3K+gPhTBjXQzUEIv1hfClctO4PtoCfOraH0MDYleyE1e2qO1Zavcj/eezepXB
 ceDctjSCaeTETq9w1KOeLRpsrDvteQSJnpitkQltnNnS3pLH3WMD2WyaocFY5dYAl00xPiL0=
X-Gm-Gg: Acq92OHZk3ZWlQII5xhG2yWWqAuaLfgl8pCX0mOAuHJeftlzwk2EdcjD3929WiS/QbQ
 uKg/3ImRO8W23896Yi3wuauW4Ek8+E2OSmAXqWWylCu343vtumnYv0twC60kftZRJm6Dcn0Eycx
 qhumCvhpLOcosjXKseD9t1826QXvbh75XjthtnYHF1CENWzzAL1j8UVi6GkRmHQvH8w8Kp/JAUg
 NnctEdqu4SzSTrPQsyUYDqIYODEA8LaJhuAkil9qANFZI+C6LiJUk1jmWlOL6OTFdin+ahnWc1X
 Fc7Uvb9qFctoRi8QcoM7G4D+BHK96zZ5ej/DSNjjHMEusO+1ngVlrWT0D+6eyRvfyRS+bfAegVW
 eijmXZ1rzNT6GE6HxzYLkLNO79kKjMcmvN560bWgyYxePoSc+uGV2c7FYJ2F8rWoTC9y4RL2/0y
 3WtYL7XVXgi4hP9TVmMS6f5bWahgl8WdosooY=
X-Received: by 2002:a05:622a:198d:b0:516:9b05:acbd with SMTP id
 d75a77b69052e-5169b05adb8mr130033381cf.16.1779272457478; 
 Wed, 20 May 2026 03:20:57 -0700 (PDT)
X-Received: by 2002:a05:622a:198d:b0:516:9b05:acbd with SMTP id
 d75a77b69052e-5169b05adb8mr130033031cf.16.1779272456990; 
 Wed, 20 May 2026 03:20:56 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c5e5sm4824045e87.3.2026.05.20.03.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 03:20:55 -0700 (PDT)
Date: Wed, 20 May 2026 13:20:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/39] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <q7fz2sr27esg444at45m57auwivfcmffjk7ij665de7vsyxtc2@2ww3plm2hqna>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-5-b20518dea8de@oss.qualcomm.com>
 <omw63f7fbqiuw2t266dq5drk7rz2kohydpvbbhcrbfiehb7lzh@aucqhfaliams>
 <57f574d3-7000-42c8-a5b7-88f1a73efd50@oss.qualcomm.com>
 <etjni6nlx5a6xd4oqb6ow5ihxdl5zcdtcofmo74pbdt7lilnxd@q2zqgiqycjt3>
 <c1eb178a-4cde-4a4a-bfd9-e3b0ce4b52da@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1eb178a-4cde-4a4a-bfd9-e3b0ce4b52da@oss.qualcomm.com>
X-Proofpoint-GUID: u-1uaOhW4s4-chlxEdpPVdiQvA9ELDw4
X-Proofpoint-ORIG-GUID: u-1uaOhW4s4-chlxEdpPVdiQvA9ELDw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5OCBTYWx0ZWRfX3TSXfo7Y/1Dm
 PpOSxqZxifeUQBR9sZhGp18bMPqs7gkvSJ/0NnJv/MljDdBMZfRRqM0n82OHFtkd+oPvF92DgdK
 Ykl74hwe0W70FAg3hVoukcTA3ZxgYsNXhJE4eZMz63EG1yZmXQbPVf+xWz7imyEgQVKia1ijKzp
 cevriEmPfUh6aowN27pcsRdOv6VtSCLgAi9RCIHYTutGgEE9voSL6idFQMuWBEfZhMmkJb2+BUU
 ilTzrEEQt2D4hzKQ2SVynwSaPgy+4OzLePjixkry/+SkgK/GXN95RYJloAu81/6z3xn1rC2PRP2
 q+dhT9jHJj5JDTx/vJY4Qlto47Nqb6yAiQFSm/82tho8srPwGiddXMFcAhGXNlzW7BFoZScOnV2
 NvL1hlb3Ve+uC6wFoJSr8H9Ab+J5Ebzhlhej/zvTaj5YqIUWSaxjCcN/9gnhs7A4znpdwcz+4b0
 L+vfNj+dx2cMSIGEKWw==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0d8b0a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=OFC9lnTRAqHNnf6JCLsA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200098
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

On Wed, May 20, 2026 at 06:16:05PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/20/2026 5:23 PM, Dmitry Baryshkov wrote:
> > On Tue, May 19, 2026 at 03:46:36PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 1:34 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 10, 2026 at 05:33:40PM +0800, Yongxing Mou wrote:
> > > > > The DP_CONFIGURATION_CTRL register contains both link-level and
> > > > > stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> > > > > all of them together. Separates the configuration into link parts and
> > > > > streams part for support MST.
> > > > > 
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c | 43 ++++++++++++++++++++++++++--------------
> > > > >    1 file changed, 28 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > index 476346e3ac19..85315467b5d0 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > @@ -388,26 +388,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
> > > > >    	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
> > > > >    }
> > > > > -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > > > > +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> > > > > +					    struct msm_dp_panel *msm_dp_panel)
> > > > >    {
> > > > >    	u32 config = 0, tbd;
> > > > > +
> > > > > +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> > > > > +
> > > > > +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
> > > > > +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> > > > > +
> > > > > +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> > > > > +					      msm_dp_panel->msm_dp_mode.bpp);
> > > > > +
> > > > > +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> > > > > +
> > > > > +	if (msm_dp_panel->psr_cap.version)
> > > > > +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> > > > > +
> > > > > +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
> > > > > +
> > > > > +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> > > > 
> > > > You have an RMW cycle here. Please document what prevents it from racing
> > > > with the concurrent msm_dp_ctrl_config_ctrl_link().
> > > > 
> > > Here protected by mst_lock in MST case. Will add a comment.
> > 
> > And in SST case?
> > 
> Emm, do you think this comments fine?
> 
>   /*
>    * RMW: in SST, config_ctrl_link and config_ctrl_streams are called
>    * sequentially on the same thread. In MST, caller holds mst_lock.
>    */

LGTM

-- 
With best wishes
Dmitry
