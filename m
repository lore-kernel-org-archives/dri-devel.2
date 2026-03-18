Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414AF10775ED
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6871F10E011;
	Wed, 18 Mar 2026 17:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E3pLZICd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QysHht6U";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C58F10E011
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:17:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62IFgsVM2986243
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VkAI+SqRR5EwHc2K4Pa/6PdC
 emEOi0RfCNii4UmGZ90=; b=E3pLZICdUK1fxxET9kYCRr7Ba9xurU7Jt2riDZzV
 eP0TNfAYdKX4Xb+PYzpbqgk146E4iKhdANe0Wa9QI3RWqGRki3brK0TCrtQkaC7t
 EIvW0eqImLyoQ4L3f0hr/uvRxJUtnnEdxIvIxOSp7HAgnbyB2pr38dc1E6OTuhu9
 whtCc2LLFPnLmU8I0zWxaMWRxSIWNCIcaXMnaoYlMMwDoN3ME0RnxeZc2b56Ndbi
 CyE0bsaOr9WCjKP2uXTxT57W092OUZ0xXG3eIUohUy3ubNq79aqga4ooQ6RAS+GF
 drVOpm3R+LXBsxbh8QEDY6abN11J8ly4Tntl6M75LmDH0g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyj4ekkmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 17:17:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-509177a915aso1367631cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773854260; x=1774459060;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VkAI+SqRR5EwHc2K4Pa/6PdCemEOi0RfCNii4UmGZ90=;
 b=QysHht6UuYDSCT2a8jLrU5hFoDqSlQv7oU8OResdTuLICU/y1ucaC9uKW2dh+HPD2n
 fBS9od0SryHz3KDc0wDGSb+oT/HwMj1ymV8K3qDNppnkWFMNwWRmooPRJDFa837Z9Uhj
 SIDHepgRIvc7JWtRFockjpW4mq/xpmDjspjXz0k8GE61//4yE6IVyIT7QAM7Ap6KX/mh
 2qJ7zzI6h81MMUb5a3YfzKHH5VU4TSAFJNIg42PAKkzSWPiqR/D4xWoTBn0j6myBqAji
 dNb+4mZhqQN2s+dEIqRMgpG/ycYneWQ5uoXgeTysthV0oHc9AcwXaSVDUkY4Rh/AbKJS
 F8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773854260; x=1774459060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkAI+SqRR5EwHc2K4Pa/6PdCemEOi0RfCNii4UmGZ90=;
 b=PZ3fJ9KAaSJ5ZxBCyl2hUgBU7dZeldzMuPSLBEcLMAmZUMCyJaKetykm8BVyJ6erCQ
 R3tadjA9qdnjNg4v1YWzvSaQ/Ixgb1lpZ70WzO0ftxvLQLKYXxIH9RgoZLqVMp365zXj
 bYCvOnNjrTN3Huqq2yqOA7dQ5DisvSy+ttm4MM1pCCIm/aVRZF6maqsGtt86G0MsSu6B
 V8IYMGNdAxbepIFws6HMFcqO9bhBLvaugSPOXXNnOmk9npw2fkYR1L3kzmcOU23knvOY
 8w4qg4/8yO6RvL7+fzlS76gQ+tRqj87StwZ9vQt+mBIjDg6S87EUGZHdhMNSrH2lCmq2
 qmmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIlFAWuBb7oMMPlzJ4P+hSUUXCbkcX4VnOvkSZnmz1VJT9byHIQil9h+Jbjzl5c+o2vHbXCHyNkBE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpKyLpC9t6TT0SZMtBqOM9GtMKlrfRWPLOqN3low2o0vXNB0R8
 7ghqE3HOByNSM/PIiJn6ydqPItVrdo0DIhVePVURZIOGP2zqb+ITny7D0SzLjq31n1Z6q2hEGPK
 jkCqGnt3i4Ymr0dM/JAsi9aTUHM1OIOIR/+BGpZrg0J5DuJlkxW63ydSDhi0WzcgWr8h1R6g=
X-Gm-Gg: ATEYQzwcV/ORu092r91TycYHZE9I6nMHz9B8J11Nf9XK4k2Uc6g2uz+0w/CWKJYAk0c
 cKvL9J3WcXOmX/v6zpkNvKQPmAMatklQ20ri8kkJZlULIJcZeu6OfaFUU61WfvLW03l/dWiG7s2
 hRHizmsU5TUFi2uyy0NUMUu3UOsJwZZyHmVVckLSHjprbTcJ0ulEEEps7QOCTRqdsYROQ7Hmdjq
 QL0m4tYVv1tB9gfK0vlS8F1aSaJ4y2lZ/iLuQ5MoEwXInFNBBhf035ZlAEkaXkFxC8TPbuy9CSu
 OLtfuGOq1MwE0sI96N4Yvo39qIK09hscyq8nK9ENfVbBH+xn/S34YPgJYElWV9kI+J5l9N4OLVY
 0SkIDauHELqIsk3Jrnlqmf6m2RbSuScEl7h6XkZrfUCy7SX+NGt4LAq7xfPQ2dRbixtOlbQi+0b
 AduW+xUuXMwwXpFEC71xDdGEp7Km8G0xXZ4Dw=
X-Received: by 2002:a05:622a:44:b0:4f4:bce1:31b6 with SMTP id
 d75a77b69052e-50b247043c6mr5164651cf.19.1773854260004; 
 Wed, 18 Mar 2026 10:17:40 -0700 (PDT)
X-Received: by 2002:a05:622a:44:b0:4f4:bce1:31b6 with SMTP id
 d75a77b69052e-50b247043c6mr5163871cf.19.1773854259047; 
 Wed, 18 Mar 2026 10:17:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd54d538bsm7852561fa.35.2026.03.18.10.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 10:17:37 -0700 (PDT)
Date: Wed, 18 Mar 2026 19:17:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH v2] drm/msm/disp/dpu: add merge3d support for sc7280
Message-ID: <2zgpsqzcktlxu4yrvx235zh2llsdyh4mkreaziv66tkcq24uj2@3hkq4nskyscp>
References: <20260101-4k-v2-1-712ae3c1f816@oss.qualcomm.com>
 <DH1IKLU0YZYU.2SW4WYO7H3H4R@fairphone.com>
 <tbi5mwg4jt5scvr76lpzpvi5zj3kn3entoorsd4dior4g23czd@xtobadslhfrz>
 <DH437ESQRIAF.2336WF7XZBTI@fairphone.com>
 <7tcmh65lhy7t452mwkiv37pxqwh6dbuh6voelaag6kph7tfr65@cskiwvoafbdy>
 <DH5RYL9A77TQ.QE2CS4OFZ1LT@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH5RYL9A77TQ.QE2CS4OFZ1LT@fairphone.com>
X-Authority-Analysis: v=2.4 cv=T4+BjvKQ c=1 sm=1 tr=0 ts=69bade35 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=xNf9USuDAAAA:8
 a=EUspDBNiAAAA:8 a=BcIQnNHhHFwDr4imAaIA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE0NyBTYWx0ZWRfX2I5bQknuqdyp
 p3qObDM/fDuPx/vUji5IZZbeAJp6oo1b35b0eeUcXR+PI1cNl6PsBiy18Q0dUc3LuPxcKq1dfX5
 bM8Y0uW12SImM5l8GuL/mlt9MdIZJHil/jEGtP0jJ1wIKtn69Qhbj3VdzGlI6gl5piJDbgLfBmh
 9fwUNdVHWW1p5zhsN5IqwZvyctleHlZTy78fcdDYTAubYL6+XpaaIlr0JD3pIiVaC5TcYH3+Ghf
 Lfd/DES6dnUSk3xWoNgQqxLpjtDNWB1QOOgs+Z6NVQ1x5UsAoqz9xkNN6v7YvVT80wQyY3eA1Tn
 wsUKQW2c2s2JiaCfSP2RYks7b1yHVZ+KNuG/BjEgLj7pnvaDdPwQ+fb3RKQXQyFnyMQ6Ll0xcR+
 8ABGOHv+UQ5gWZR/NM8h8xvlJw+vBJoMTGagQXXiON4hkxwYoFoQTOiR2SgC5JYxB4iA8RID1uZ
 T1sstYI1qiwEBPDozPQ==
X-Proofpoint-GUID: feLMDBvX89MEfv3N49iL1yJclf2ujXiZ
X-Proofpoint-ORIG-GUID: feLMDBvX89MEfv3N49iL1yJclf2ujXiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180147
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

On Wed, Mar 18, 2026 at 09:45:23AM +0100, Luca Weiss wrote:
> On Tue Mar 17, 2026 at 6:45 PM CET, Dmitry Baryshkov wrote:
> > On Mon, Mar 16, 2026 at 10:08:47AM +0100, Luca Weiss wrote:
> >> Hi Dmitry,
> >> 
> >> On Fri Mar 13, 2026 at 6:14 PM CET, Dmitry Baryshkov wrote:
> >> > On Fri, Mar 13, 2026 at 09:33:18AM +0100, Luca Weiss wrote:
> >> >> Hi Mahadevan,
> >> >> 
> >> >> On Thu Jan 1, 2026 at 6:04 AM CET, Mahadevan P wrote:
> >> >> > On SC7280 targets, display modes with a width greater than the
> >> >> > max_mixer_width (2400) are rejected during mode validation when
> >> >> > merge3d is disabled. This limitation exists because, without a
> >> >> > 3D merge block, two layer mixers cannot be combined(non-DSC interface),
> >> >> > preventing large layers from being split across mixers. As a result,
> >> >> > higher resolution modes cannot be supported.
> >> >> >
> >> >> > Enable merge3d support on SC7280 to allow combining streams from
> >> >> > two layer mixers into a single non-DSC interface. This capability
> >> >> > removes the width restriction and enables buffer sizes beyond the
> >> >> > 2400-pixel limit.
> >> >> >
> >> >> > Fixes: 591e34a091d1 ("drm/msm/disp/dpu1: add support for display for SC7280 target")
> >> >> > Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> >> >> 
> >> >> This patch is causing display regression on QCM6490 fairphone-fp5.
> >> >> 
> >> >> With this patch in 7.0-rc3 (or 6.18.16) there's just pink noise on the
> >> >> screen. When reverting this patch everything becomes working again.
> >> >> 
> >> >> See also https://salsa.debian.org/Mobian-team/devices/kernels/qcom-linux/-/issues/41
> >> >> 
> >> >> @Dmitry: Can we revert this for later 7.0-rc, in case it's not fixed
> >> >> quickly?
> >> >
> >> > Could you please provide the resource allocation parts of
> >> > debugfs/dri/0/state for both working and non-working cases?
> >> 
> >> Working (patch reverted)
> >> 
> >> resource mapping:
> >>         pingpong=# # 68 # - - - - - - - - - 
> >>         mixer=# - 68 # - - - - 
> >>         ctl=68 # # # - - - - 
> >>         dspp=# - - - - - - - 
> >>         dsc=68 - - - - - - - 
> >>         cdm=# 
> >>         sspp=# - - - - - - - # # # - - - - - 
> >>         cwb=- - - - 
> >> 
> >> 
> >> Broken (with the patch)
> >> 
> >> resource mapping:
> >>         pingpong=# # 68 68 - - - - - - - - - 
> >>         mixer=# - 68 68 - - - - 
> >>         ctl=68 # # # - - - - 
> >>         dspp=# - - - - - - - 
> >>         dsc=68 - - - - - - - 
> >>         cdm=# 
> >>         sspp=# - - - - - - - # # # - - - - - 
> >>         cwb=- - - - 
> >
> > As we have identified that the issue is what downstream calls
> > DUALPIPE_3DMERGE_DSC topology, could you please also check several
> > things (with the broken kernel):
> >
> > - What is being returned by dpu_encoder_helper_get_3d_blend_mode() (in
> >   the broken config)?
> >
> > - If there is any difference in working and broken configs between
> >   values being passed to (and programmed to the DSC) in
> >   dpu_encoder_prep_dsc() ?
> >
> > - The same question for pclk calculation in dsi_host.c
> 
> Is this helpful?
> 
> Broken:
> [    1.247165] dsi_calc_pclk:649 DBG pclk=111546490, bclk=83659867
> [    1.490559] dpu_encoder_helper_get_3d_blend_mode:309 DBG BLEND_3D_H_ROW_INT
> [    1.491008] dpu_encoder_prep_dsc:2061 DBG dsc_common_mode=0 initial_lines=1
> 
> Working:
> [    0.998043] dsi_calc_pclk:649 DBG pclk=111546490, bclk=83659867
> [    1.233836] dpu_encoder_helper_get_3d_blend_mode:313 DBG BLEND_3D_NONE
> [    1.234277] dpu_encoder_prep_dsc:2061 DBG dsc_common_mode=0 initial_lines=1
> 
> Or do you need some more things? There's a lot of data being passed into
> dpu_encoder_dsc_pipe_cfg() for example so I'm not sure which values are
> relevant for this.

It looks sane up. I will try asking internally. But for now the posted
patch should be good to go.

-- 
With best wishes
Dmitry
