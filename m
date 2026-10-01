Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4ACA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D2210E349;
	Thu,  1 Oct 2026 10:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GECWB/UC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UrCa7zQS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66D710E349
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 10:34:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6916xfmP2337471
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 10:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z0Hrk/F1kX5aUJEX6L7wOMR0DiZp1hATNa02ihfJkOY=; b=GECWB/UCqQ8lxgG3
 tCCkWugho/7HcI7hYQzEArTCVP9S5A6Bqg4Q1kzy/55PuDk1EJyJ2apyJ1s450c+
 IT/xVdD5jgvgIozRlSy1z3Ja1EQONC6inz63nJmPA14Ojz2Bi9Pm4ofDUrpyuAKm
 zwOCDuO2ug82JvJfa6wIqyiJibhlcedkLdm4qUpfC3LQjZ29JZgAdAAuxw9CHMlR
 zagM/eaB/hL3rysI2fnwJ09InhS7GO891e2afJuaVHZRM5DjKCX68mB9gpA6m+Rz
 5sjQEZW19Cv6u02ZJrXrCYBvJl41yJJkiV4AG1wp2N4/huF5xzqJ70peSjzqFwl+
 7Gqk3A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n24dm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 10:34:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a082c014aso188304685a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790850864; x=1791455664;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z0Hrk/F1kX5aUJEX6L7wOMR0DiZp1hATNa02ihfJkOY=;
 b=UrCa7zQSyWsgy1MLarozW4h5Tp/6sC9+nqtB4Z3nynWOd1Qb9baRLJpe6AetC/MNCP
 j59a96/DETh3jWdCfH6tBHuasCr5+FAgZtD/7a+FdaVIGznASQiRigaMnn3xr4gMf9ar
 ShHUGJlrui6YpTKKmcA0ipjCeuIsV4FlS0EzLbbmc+6FKbcrIfAtQrMhc4lEP/KqeGdM
 /bab0Kr4VWXWVRu2JoZSsIVLM9nedLPlJ3T0VzVgZf3kLffZ2gEdyOVyprn67Lw1N9XR
 q8U+qBCTyqLShtRm7tIcLJVm9umy+RqFoV+Ppv0JuHmgSTcxYJ97ErDj6NvGiOW2KCWe
 mEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790850864; x=1791455664;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z0Hrk/F1kX5aUJEX6L7wOMR0DiZp1hATNa02ihfJkOY=;
 b=RQkn4C5kPviVHlgsm7EMdMaMBFryMXHGop/5gPG7WQb3a6p2DPj7wVUhMStDD3dLBb
 FnjvlBkfG53IVYTHJsiZeLp4g8cq1Tl5f7eMTYNQuJAIiBG1lp2UEK88JIU9CUZi8cw+
 QAige8ST3NBT0IdricJOqeVAvsjUC56v74dYXXh0rvu24zUBJPBIqNGGMhpjjALql2ta
 Fgqxb8pFIK2GvyelLcQjsRTTBMU6JUVDaL31dkhwQpaXkF27JEoDDY0EWhb2UVPUKSPd
 lr5D/GFJEDuLPOwKlnFkdxJo1KZh0O/SG4tdcSdKw58E/bSCD7rAmuv5gv4qNmrDX7K9
 cBsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtWsJX+uEvNH/u58+SuxJXHXbo2jNlHCC2EGeFJhy8g6LHP/+6GLisNP2+F8S8DWnnu4kAOiDitCw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4HkLzV4JUAam/bsmECsWb6t5Tbft8d4PLLAGpysupTFizMSIB
 PIxiaWYyE0ycmRtnKfvL5OWLCWFbShB3Fq3f7Pr5lVx0FfnT44pg2EmC+byT2G5pFiKNeJFRlRo
 lmhVH9jS3umMGI+GfwAIYoXcvOGulljg9FCaK7peR5kSDjZeLKlZkFLhVNvR0E6KrxR+whJ3ts3
 Jgl5s=
X-Gm-Gg: AYBFou3sEz8DFZEhyAPQHLv9Dkdwl5Lc092baKI+RXkK4ObhJ1o4zFUSvHiO2ZSSZue
 OHoczKuQZeaP7Mq58Y6iI579yAdlmOIShxPyxxe7GLf95E9DzTJtjj3jImZrsVPFQjjkRg5NNS2
 liOQXZW3AKfAqBt0cKqH8onFNetBphk20FuR5timBEPftYqfmmn49w/zymbPl8rhDZfGVI/CLyB
 V+2JUyX0wY4PTAKWNohQU/nf/ZRYx4Ff3KSohEJjiwHXcmVSfUQhYSAsjvr5fevhv48DIdKaJDX
 T70dkmIJ5cJuMbLrjo3DGqWv/vsnOJiUnFLqSoftvVXM4z1GxXORND2ERL0w4jt0W6pfxvAlIkb
 9JCO79FRn2v4IDNT7Pm2ZkCjv2z3BT8eMlUImYFs7vU1AaI8CqSF4SFPLex1RIJK5PyIsSz55BU
 TKQ5L4xDHFpePl
X-Received: by 2002:a05:620a:2682:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93cb5a52e38mr429967085a.12.1790850864123; 
 Thu, 01 Oct 2026 03:34:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2682:b0:93b:cb64:25a5 with SMTP id
 af79cd13be357-93cb5a52e38mr429962985a.12.1790850863536; 
 Thu, 01 Oct 2026 03:34:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba4405974fsm456585e87.4.2026.10.01.03.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 03:34:21 -0700 (PDT)
Date: Thu, 1 Oct 2026 13:34:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v7 12/35] drm/msm/dp: add support for sending VCPF
 packets in DP controller
Message-ID: <t3klzrnzq3oicg6djkv6ixwy6oteo6c6zvnpddbqk5pjhsodoh@qz7pcou23no7>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
 <20260929045000.55AE01F000FF@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260929045000.55AE01F000FF@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abe3730 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=A2aZpUCA50j1Os7HS88A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MiBTYWx0ZWRfX7LkQ/hvCn/lS
 gtpHbgIGYuAP1VIiQe1He3vPVtUnx9HFzMXYlqucfEFx1lGznVXEDubU/rRhA6pGt389SyZEZ/t
 RNEsm+yGkow7iMQsZmbX88sitiNUGhw=
X-Proofpoint-GUID: mMvDw7itrvLSRH89StCLnLDftTbzekQn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MiBTYWx0ZWRfX+y9ryhBwPGcQ
 lN53PfNKQaJuWixK/n+jrkVf3DlJIOnJzknfO3BmYQAKqDUUqJWNl0NwrtjFyI66/OJ0Jll2FDY
 LKIOlvn1zq9csypsQ7XsCaSUm2ym6TqlrlqdbI12IetcMGMHTOVNP3b6y44snwdgr8V2fnYWpyd
 8Fa9fZOv2XKPUwpCmBSx0Fj6hgUIM5Pc/CTH7gSLzRIcIsuBnPe0RCjSH7qlmRSAenLacjPYirb
 MTazfG0CQonUz99K5ujtvR0hrSDFrSXRYPiAG2jlhz0c/tJ+Jgg/3rm9hE+Nf/ThBrBjDG5xCXh
 sN2EImNwDMwyy9XiS3zcina7X33Aek/+f5cL84BqMZVj21+CcJyxjcTJuRrhqgRfxCDGM/8Pz0X
 +X+h/I1xeYAkpiXSwrv0242pxXnlK9qtKoo/38NBlytw1WUoeLYKMVVrUxN07I0sS0H7EFLoCNc
 szfj3ann3L8OJi3KE4Q==
X-Proofpoint-ORIG-GUID: mMvDw7itrvLSRH89StCLnLDftTbzekQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010042
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

On Tue, Sep 29, 2026 at 04:49:59AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] drm/msm/dp: bitwise OR of STATUS5 and STATUS7 without masking in ISR
> --
> 
> commit 987123505b6cfcc4664c72feae6b070ad91b79a8
> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> drm/msm/dp: add support for sending VCPF packets in DP controller
> 
> This commit adds support for sending VC Payload Fill (VCPF) sequences in the
> MSM DP controller when stream symbols are absent. It introduces interrupt
> handling for streams 0-3 using the STATUS5 and STATUS7 registers to signal
> VCPF completion.
> 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > index 9a0c9737e6d00..929e0f94f8ddb 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> 
> [ ... ]
> 
> > @@ -2801,6 +2877,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
> >  		ret = IRQ_HANDLED;
> >  	}
> >  
> > +	isr = msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
> > +	if (ctrl->num_pixel_clks > DP_STREAM_2)
> > +		isr |= msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
> > +
> > +	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
> > +		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {
> 
> [Severity: Medium]
> Does this bitwise OR of two different status registers cause false positives?
> 
> The msm_dp_ctrl_get_mst_vcpf_interrupt_*() functions return the unmasked
> register values. Since the values from REG_DP_INTR_STATUS5 and
> REG_DP_INTR_STATUS7 are ORed together here, bits from one register could
> overlap with the VCPF bits checked for the other.
> 
> For example, if an unrelated interrupt sets bit 18 in REG_DP_INTR_STATUS5,
> and it gets ORed into `isr`, the condition will see bit 18 set and assume
> it's DP_INTR_MST_DP2_VCPF_SENT (which is bit 18 of REG_DP_INTR_STATUS7).
> 
> This could cause a spurious completion of ctrl->idle_comp during a VCPF push,
> allowing the driver to proceed while the hardware is still executing the
> pattern.
> 
> Should the return values of msm_dp_ctrl_get_mst_vcpf_interrupt_*() be masked
> against their respective VCPF bits before returning, or should they be checked
> independently instead of ORing them together?

Please respond to this comment.

> 
> > +		complete(&ctrl->idle_comp);
> > +		ret = IRQ_HANDLED;
> > +	}
> > +
> >  	/* DP aux isr */
> >  	isr = msm_dp_ctrl_get_aux_interrupt(ctrl);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com?part=12

-- 
With best wishes
Dmitry
