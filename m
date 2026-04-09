Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCA7F31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093C510E7FD;
	Thu,  9 Apr 2026 14:09:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mm52allN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hTlyu7rw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E0910E801
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:09:03 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CxmnP1729915
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L8SeYI2HH+TOcscby5yEMg4uX8MuiyiTC9YAhHh3YQw=; b=Mm52allNlQApo5fc
 xILXK984YiYpKW6k3ExklMpu7uOzIw2gZy7o71m/xUWtTfluJAmyTc6ETuJq6kE2
 VvfzJyavTmw22FXbY+qmiEYulQIhYH3EKAndBrSYR6vmqAuaJjrXdgNyzzoCgc4L
 K/lmNoEM45VD0zP7/WrL0PUEdxvN7scCszTcXPHWReVhmO97watMJ7JFGBp/Hjmm
 0Rh7cSalhtmVnRnLsvEwv8ybSMV53whdzYJLXZQd0DUtw81ZQNx1X09/S4T9dfFU
 n//j6oQn49VEvArSFUe2DzF6uIvQooMunc5CKa7xOChERuUpnmoQCbigdCTSQrqu
 H7FrEg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxg84h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:09:02 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463a075e177so532683b6e.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775743742; x=1776348542;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L8SeYI2HH+TOcscby5yEMg4uX8MuiyiTC9YAhHh3YQw=;
 b=hTlyu7rwMr2YwHQd9jjn0pPiZaudpznh3bOYo7vThhHnvUByr6gxIfQBt2ze7wu1F6
 5Zl0OfEhh5YjlNtpzSN9gDUNvEazPOKBr/iwz6uqEVR8DaS+uLiN3AoNzlHG1vi7gMKl
 /9IYj4olYr1HVCmiFb+7U4cKwB6bXsSTi/Y1Ja8A3FQxfb6BdQwqJrzyo1nBJvzhAljm
 sEQ0jb4RTQmNLJeHnaMDayCj3FAN13CQEsQzXf5vbis25ZI81fb+RO8amKDkKVkdm7Gv
 Zbm/Ne9UEGEFmO/oewAUrfugvYIyIbJoYAosR5mno6aGQjPANTfjTw/MxH8xbgq1hbVp
 w2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775743742; x=1776348542;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8SeYI2HH+TOcscby5yEMg4uX8MuiyiTC9YAhHh3YQw=;
 b=NDGmtB8Fdc6RGxeTIwdIvOWLs8OKTy9Wj64Pz+Y+NSbMkcYjMMUc6wy4Npvuh/PViS
 1B3XBS3JutuMAv7kbXnt8aMZTvzvLEJvo+rybmHpNbKu8XKoQb7EKwJx9xMg6dzQm7T2
 bYp8Tuwl4C3omX/0pX6utsREqQT0Fo6KpAXonlBi1Suo2NxSGrZVNFpRzcT8ctDkyC94
 wAyQUdhq2buWh+OTRm/r9JGsxAwzQF9VLzaa2NRHlgXTqpxh+w+ivHnJMadOAkNqGaHC
 zt1E45aVu70gH8o9MynvBGLxoT0TYpS4V00z64QR3IY/mNZR11PzkiITFc54gpf6MiaE
 gZ+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZuWsQAAlil11Uv4M3ZXnnYo3nGFk60BgoFTKV65vMLRUXYcMEu8FsKA6Uj7iwJVwIX6I6jHUjZvk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YycQe+0dLcXDQir7LxbDWJGGK4DH43phsPzc8Uq6J8iV0BBC063
 iMYlWJxvml5yIvwTHDGEUmZLQKiVDbS2Q9a+MKuUX8fxQ/yT5ap1Kwfn0E589iXXyV/X4KqSdyL
 V78vje7TW2LhpHUPThCkzjEeiaXPdJ4pYtzhoQKK7wydJPJjKKJX9Fc/W4UNmrDVdxGVouPA=
X-Gm-Gg: AeBDieuMlHYUo3Pu+6sEq2/51CquLEUaqRNtGZweDy5CvC7BsV6ssNSLEPvjfc9LHEv
 TcM7bRrKOSCo+34wboD3O1vBqYwFyh1MtoVyQpQRgFV/T6mZ6+Ur6L48DjR4wV1b8NxNK1dYuZv
 yAUx1tC1/6IWgWlePJR7icuqAAuvwXDWerdKYk/Vp5KltlbTNpT8UA9dgd1BTB/xKNhOzJV5F46
 oGSqriibH+9fnqeKkfrQJLHiINZMChcx5lvsxbpCXQ7afqsn20Heow27I4VRLhWI8r/NS/iAKSO
 UpuSByFud7zpVHErJ1PfYx1Jfmmg2QFYZMUILScZYMSLFbQkg6okepFr2wwozDDtj4SoCcMaKHu
 v2uTPf/shiHJq2Und7LiX/PoxpLn5BV1iGtNEpxb2ncFzK4ZAxnoo62RNhpHGlQeK0DAC63OlUB
 E2tLcM3fDUwANvHytXrviE0HRZ5z/lfSRyFyc=
X-Received: by 2002:a05:6808:c183:b0:45c:925b:5848 with SMTP id
 5614622812f47-4772407f243mr2025443b6e.45.1775743741728; 
 Thu, 09 Apr 2026 07:09:01 -0700 (PDT)
X-Received: by 2002:a05:6808:c183:b0:45c:925b:5848 with SMTP id
 5614622812f47-4772407f243mr2025408b6e.45.1775743741214; 
 Thu, 09 Apr 2026 07:09:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd216075fsm51556931fa.36.2026.04.09.07.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:09:00 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:08:58 +0300
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
Message-ID: <uyc5kikryyuzzo2seyhqa4syi4co3oh6dxmljxzrvxftgd6pis@ktgdjb56erfv>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
 <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
 <46d97aec-9f46-42bd-8725-2c236ffd13ba@oss.qualcomm.com>
 <4cb29e7a-9a75-4f8a-9036-c96e9190b7b0@oss.qualcomm.com>
 <fbca1547-d54d-4bab-89b9-404d97c3c08c@oss.qualcomm.com>
 <4rhd6qlj4jevrnj2zqctqrcbpkvcalk5qmr3ryuk6ewwa7e35p@o7xzhuzfsms2>
 <1e3e0fd7-742b-49cd-b432-da9bd2a0ba7b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e3e0fd7-742b-49cd-b432-da9bd2a0ba7b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: j1Igg1VTv0RB_S8dRPiLpcGJCYWlKsjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyOCBTYWx0ZWRfXwFPTcr3r8+4J
 uAjVCsTfwE6v33nDkcUcF1GZ42oe+ii+Q5qls6BjIn2bMwzosgfENlF7qMhNbv8mH6jeZOhtYE0
 LCCaz+vdVEiGqZ2Qbvf2UF69QuQNIq/kdFKvYZeNLrBtM5Hw5iafxKJTSVOkNvO6JA9ytM830wz
 lMo0JfgdhM1l0lIyaJls0B9jhBB2m7VikejUF1rjhZZ8/u513daGm4SHVPbS6NqKSK7MLkS4F82
 WnZ0FEp6gpdCy2/jYK8ROCTg1G8wLBmssci8d8nFKewxs8j1q0eKZrfc7XKCPHIwlJoDHYXogtm
 vZEBIxXMYOLtIuptQDNaxPil563cUDmk6iik52mpE2NPt0DrOm7sPudAnKuXE3IEROlkR6mxmK6
 PD7vYhvHR5wMNefETX0JcAhmmnUc06pvzW/L4ggqNDw3wvctKKCjsyumOGUhMgkzDJTn+t2qklR
 FbDUSvHKfj3MsZO6D8A==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d7b2fe cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ZGsGAmxQezLH4FZcYqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: j1Igg1VTv0RB_S8dRPiLpcGJCYWlKsjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090128
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

On Thu, Apr 09, 2026 at 07:33:12PM +0800, Yongxing Mou wrote:
> 
> 
> On 4/1/2026 7:27 PM, Dmitry Baryshkov wrote:
> > On Wed, Apr 01, 2026 at 02:55:32PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/1/2026 2:47 PM, Dmitry Baryshkov wrote:
> > > > On 01/04/2026 09:44, Yongxing Mou wrote:
> > > > > 
> > > > > 
> > > > > On 8/26/2025 5:10 AM, Dmitry Baryshkov wrote:
> > > > > > On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
> > > > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > 
> > > > > > > Whenever virtual channel slot allocation changes, the DP
> > > > > > > source must send the action control trigger sequence to notify
> > > > > > > the sink about the same. This would be applicable during the
> > > > > > > start and stop of the pixel stream. Add the infrastructure
> > > > > > > to be able to send ACT packets for the DP controller when
> > > > > > > operating in MST mode.
> > > > > > > 
> > > > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39
> > > > > > > +++++++++++++++++++++++++ + +++++++++--
> > > > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
> > > > > > >    drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
> > > > > > >    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > > > > > >    drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
> > > > > > >    5 files changed, 44 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > > > b/drivers/gpu/drm/msm/ dp/dp_ctrl.c
> > > > > > > index 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a
> > > > > > > 100644
> > > > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > > > @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
> > > > > > >        bool core_clks_on;
> > > > > > >        bool link_clks_on;
> > > > > > >        bool stream_clks_on[DP_STREAM_MAX];
> > > > > > > +    bool mst_active;
> > > > > > >    };
> > > > > > >    static inline u32 msm_dp_read_ahb(const struct
> > > > > > > msm_dp_ctrl_private *ctrl, u32 offset)
> > > > > > > @@ -227,6 +228,32 @@ static int
> > > > > > > msm_dp_aux_link_configure(struct drm_dp_aux *aux,
> > > > > > >        return 0;
> > > > > > >    }
> > > > > > > +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
> > > > > > > +{
> > > > > > > +    struct msm_dp_ctrl_private *ctrl;
> > > > > > > +    bool act_complete;
> > > > > > > +
> > > > > > > +    ctrl = container_of(msm_dp_ctrl, struct
> > > > > > > msm_dp_ctrl_private, msm_dp_ctrl);
> > > > > > > +
> > > > > > > +    if (!ctrl->mst_active)
> > > > > > > +        return;
> > > > > > > +
> > > > > > > +    msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
> > > > > > > +    /* make sure ACT signal is performed */
> > > > > > > +    wmb();
> > > > > > > +
> > > > > > > +    msleep(20); /* needs 1 frame time */
> > > > > > > +
> > > > > > > +    act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
> > > > > > > +
> > > > > > > +    if (!act_complete)
> > > > > > > +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
> > > > > > > SUCCESS\n");
> > > > > > > +    else
> > > > > > > +        drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete
> > > > > > > failed\n");
> > > > > > 
> > > > > > Shouldn't it return an error if the register dind't latch? Also,
> > > > > > shouldn't we set mst_active only if the write went through?
> > > > > > 
> > > > > In some cases, MST still works correctly even when the ACT trigger
> > > > > fails; here refer to the downstream implementation.
> > > > 
> > > > I don't think it is a good idea. It would be better to signal this to
> > > > the user and rollback the MST configuration (as in the case of any other
> > > > error).
> > > > 
> > > > I will change my mind if you point out i915, amdgpu or nouveau drivers
> > > > ignoring the ACT issues.
> > > > 
> > > Sure. Until I can find more convincing evidence, I will make the changes as
> > > requested.
> > 
> > Or you can point out the relevant part of the standard.
> > 
> Emm ,the DP HPG only specifies that an MST_ACT needs to be issued, and does
> not require validating its contents. This appears to be a Qualcomm‑specific
> hardware register, not a generic one.

It's more about 'how the standard describes ACT'. If it MUST be issued,
then you can't proceed with MST in case our Qc-specific register write
fails.

-- 
With best wishes
Dmitry
