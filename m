Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB61D35171
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D9210ECA7;
	Wed,  1 Apr 2026 11:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqKpW5tZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAJGYgvm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2EE410EC99
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 11:27:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631AA5eA3363899
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 11:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ipd2vKhrN5XkGoR9YkEuFCKpmd3gdczApniBQosBZq8=; b=aqKpW5tZimAU9hlM
 Kz+U6dYLcsT8oLExCsebqJAD2w8rQ8chMO9sCbUwv9UbOQv5MiMg/oNbZv1nG5XD
 OyxhafDBLr53Na2EdmLa+wTVQZu/O2JZFxk4Yzm30ircHYLfI9mQcs0JxzF2nKaG
 qg7lfp1Nye/MAJdgGcpL8kL6DUxfml9oI2OQUNnHBFQHAOlECf0JNhJuUEniZq4d
 XQybb2dqQHLqdJliAnrOoPWhak+Un6MQ8YrXlJhnMEK0rq5ayhoX31PQRzqk6maa
 xJk3Xmh7/9S0VLKvB5KouXKXXZj3ZPZuBoMRi24RBcmtIpk6J1uHa57sDSSuNifz
 pCOR7A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddk3r7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 11:27:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b220c72bbso247250681cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 04:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775042855; x=1775647655;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ipd2vKhrN5XkGoR9YkEuFCKpmd3gdczApniBQosBZq8=;
 b=IAJGYgvm1rtcpiihL/5Q73YqNkXeHnuTaj5BAm2ULrXdeBhXzNaIAdF+rzrdK9dBhk
 JFDBqbVvLR5MkWCPxnSJSX6U1rpzGzmbwlCCUIcLn0eyG29dZGRIY0JAolQF4yZ6zqMa
 qG9Yhk8f8bxJYkBHuUywPCd5HJ3tn3h5s8KUGNBqajZXmzmvs2SVo0Y//eurHVq47rQu
 IRd6q94Aws0tOa+86O3DBP9C2RNOTLuzD/G//BdKs9myaqp+27K7Fl/+UXKt03fySfvh
 hG9SqB96ddHzhNdz71TNXXVBZ+D3e9+FpvELvQYTYPBRtvEhGGJ92xENHC2inVj5ICsO
 l00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775042855; x=1775647655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ipd2vKhrN5XkGoR9YkEuFCKpmd3gdczApniBQosBZq8=;
 b=jlqyC4TC2vYAI0arS3aerleu/bGzu4LvIL/kMEfYtDEHOAHSPbpvgyx1UuNE0c4LX+
 rihru+AOnNduGvIZGZRBgYRII/W4QI8I5d3nvs1tJMezvHSo0idPIxVZa9fypXXcGCWr
 mEOt3x4ypnLLceRwE/WagLBJ6Zqun7j7kBCOrL9RC464ALMCxe47dSy2h0Gtg3dK67Kg
 cUJjDLDPXWjoPmk1A8WCqvk3AhiAkeqsG6vD4NlJrUkf3NL2e8rcU1b/C64y1cRnW3gu
 Gs1vDJ7fl/3RQmI5Auvo7xWx7EKCq+UZaio+4QoCf5RW9Uki8pcr+Te+mdDQDdml0pcD
 vtRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxPTgT5L8F3SCRRTypqm/avHSobST3cnCLwqLnma9x5xXhCim7OkVyKjlA4QS5lpmwv+ODEBm5GHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5yj86wP/6K7W907pUqJVoBrJjVQp1fd2L3NKHZg2muwW34lmi
 ltAuRM2Pr1xTJmVpcrJ2+DPQd+UWGYFGd89vAX9tRBIq9A+UWkEqL7cVSJnAbhzB12OPXGaCuGF
 zJffFWa2pXEbN1owrvACFLb2eEl8lDcr6KcZRWoQv7U1N5ZszM3o32YZuexND+PcVQTS3nuY=
X-Gm-Gg: ATEYQzwaF+UQOO6KUEmX0r3RFj/fbaYwpvXa8KayNfHsn0RrP7QBWj2PzMjgb9t5n9+
 Q4KPLCNijrgW+towZFgS9SlDwVgk07Su5CNgNPGP0f1Xti1mifB77c6rbamvj1BLaWamK2ioiiB
 1hXFr6XhIjLXCf4ZyQVcWOkcdHUOzyBT7Y1s272cPcg+wCfv0taarpSsTyPT2EN3VR9IpmPw1Ve
 C3yVTp2gwXQP5wZWMIXpXWU7ywCT0LSLLewpoTuTRaOD8Tjjy6e/Pyewz7yik8kkyIKthLJ+inq
 pHcrpP38QXH1E5t0lP3KGAmWmI/wSLEFWUnnhHgAXfkkqJRL0HdZQx2gACB0kS3wVzkWzKyR07S
 skKSA31Rx6kis6eFkq98ZDLs1WzNROkR5qIkaa7Y1XheimCod7FqFQQLKLlzc1Ol5Juy/MZ0bLZ
 BUgycNx1lYTn2B+iyc/ItDcJ09eZvmsQbcRkU=
X-Received: by 2002:ac8:7dd3:0:b0:509:4198:5468 with SMTP id
 d75a77b69052e-50d3bb5cf59mr45856171cf.8.1775042855461; 
 Wed, 01 Apr 2026 04:27:35 -0700 (PDT)
X-Received: by 2002:ac8:7dd3:0:b0:509:4198:5468 with SMTP id
 d75a77b69052e-50d3bb5cf59mr45855761cf.8.1775042854995; 
 Wed, 01 Apr 2026 04:27:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2c65556d3sm7736e87.64.2026.04.01.04.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 04:27:33 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:27:32 +0300
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
Subject: Re: [PATCH v3 17/38] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <4rhd6qlj4jevrnj2zqctqrcbpkvcalk5qmr3ryuk6ewwa7e35p@o7xzhuzfsms2>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
 <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
 <46d97aec-9f46-42bd-8725-2c236ffd13ba@oss.qualcomm.com>
 <4cb29e7a-9a75-4f8a-9036-c96e9190b7b0@oss.qualcomm.com>
 <fbca1547-d54d-4bab-89b9-404d97c3c08c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbca1547-d54d-4bab-89b9-404d97c3c08c@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69cd0128 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=2NND0KS8ewDzaUtktxMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: pPYiRJNqH3Dey-KuKnWWz5deqwvanUF5
X-Proofpoint-ORIG-GUID: pPYiRJNqH3Dey-KuKnWWz5deqwvanUF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEwNSBTYWx0ZWRfX9DBO/oLttZZu
 StQZCtqIEwehFnRdrG+lYbSC0fsauXdLVyjoS70gPmAmgjZNowoDSit6rBIOMksSOdRqd30IGe4
 qCz6hyhyQIIFAX2Aab9FfPAiuUN0UglUJ9jYZlk5e6wiSBk7/BZRPPvRuysczzoJoslv7ZfwqYk
 Amc18NpCm3YF/D6ddcvHzXB/LAieSYAlWqCRD0gsAEqU7sakH2IctWQ2xgxjn0iN6vMcnSznAsv
 7lIWtN9NNyKww026vXA2J3a8EbjINpMf5GSSUl47+Je+Qdxxii4ga6WUF8gAI6UYgfX+V7KhdUM
 B8kF9VafraM/2pgk7R3hMSSvnTaALhEBre5MNctrzxiYq7fMjiiQQX7fXWq11nwt1XGp0vrcy/o
 h/iyBawhKenoEppuRBfsjiXLvjyTnPSTc/Sa8UgsGd2LspnU0ecPYeCPrX2Vm15N1KYtXXITlE9
 XZZlL9EZ2stdtvaIznA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010105
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

On Wed, Apr 01, 2026 at 02:55:32PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/1/2026 2:47 PM, Dmitry Baryshkov wrote:
> > On 01/04/2026 09:44, Yongxing Mou wrote:
> > > 
> > > 
> > > On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
> > > > On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Whenever virtual channel slot allocation changes, the DP
> > > > > source must send the action control trigger sequence to notify
> > > > > the sink about the same. This would be applicable during the
> > > > > start and stop of the pixel stream. Add the infrastructure
> > > > > to be able to send ACT packets for the DP controller when
> > > > > operating in MST mode.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39
> > > > > +++++++++++++++++++++++++ + +++++++++--
> > > > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
> > > > >   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
> > > > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > > > >   drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
> > > > >   5 files changed, 44 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > b/drivers/gpu/drm/msm/ dp/dp_ctrl.c
> > > > > index 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a
> > > > > 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
> > > > >       bool core_clks_on;
> > > > >       bool link_clks_on;
> > > > >       bool stream_clks_on[DP_STREAM_MAX];
> > > > > +    bool mst_active;
> > > > >   };
> > > > >   static inline u32 msm_dp_read_ahb(const struct
> > > > > msm_dp_ctrl_private *ctrl, u32 offset)
> > > > > @@ -227,6 +228,32 @@ static int
> > > > > msm_dp_aux_link_configure(struct drm_dp_aux *aux,
> > > > >       return 0;
> > > > >   }
> > > > > +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
> > > > > +{
> > > > > +    struct msm_dp_ctrl_private *ctrl;
> > > > > +    bool act_complete;
> > > > > +
> > > > > +    ctrl = container_of(msm_dp_ctrl, struct
> > > > > msm_dp_ctrl_private, msm_dp_ctrl);
> > > > > +
> > > > > +    if (!ctrl->mst_active)
> > > > > +        return;
> > > > > +
> > > > > +    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
> > > > > +    /* make sure ACT signal is performed */
> > > > > +    wmb();
> > > > > +
> > > > > +    msleep(20); /* needs 1 frame time */
> > > > > +
> > > > > +    act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
> > > > > +
> > > > > +    if (!act_complete)
> > > > > +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
> > > > > SUCCESS\n");
> > > > > +    else
> > > > > +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
> > > > > failed\n");
> > > > 
> > > > Shouldn't it return an error if the register dind't latch? Also,
> > > > shouldn't we set mst_active only if the write went through?
> > > > 
> > > In some cases, MST still works correctly even when the ACT trigger
> > > fails; here refer to the downstream implementation.
> > 
> > I don't think it is a good idea. It would be better to signal this to
> > the user and rollback the MST configuration (as in the case of any other
> > error).
> > 
> > I will change my mind if you point out i915, amdgpu or nouveau drivers
> > ignoring the ACT issues.
> > 
> Sure. Until I can find more convincing evidence, I will make the changes as
> requested.

Or you can point out the relevant part of the standard.

-- 
With best wishes
Dmitry
