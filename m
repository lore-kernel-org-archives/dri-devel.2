Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A40F531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1760210E4EB;
	Mon, 13 Apr 2026 18:04:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="olBy1O2O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AEcbWYBb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D0010E4EB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:04:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDm6IK1496998
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uG6p1MFp+26v87RPXmsW7BAV
 +LfDZF1OPvLL93JOuM0=; b=olBy1O2OMOlg59z38ME2FspkMia97BPsNpQAcUFA
 IVsJNTWZGxEWFER43A/2wB8v/RLuaowc9ryQia13ZkzfaKtA7SIWJBBFPiKQnssQ
 fhiZosocLqiMn/iQ96JenS3iwW7e7L4mS17msFVvwue8U0NeYaaxysy17K7tzktx
 EqgOZ4qzq98P/okV1scwWMVq7FMjS/w9003qg4uR9mJMDFW/Sp4jBSvd4f9qo4T9
 l8kInOABbVzccqcotJ20RLO8X+yHYRA51pQBNSwZ2dS6OERlC8kahwcWYWSz6HG4
 nhnfJ3mpMh/XOzXkgS1AMBrIRgVwALfs1bWlugv5dFmpcQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1pk8yq5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:04:06 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-46ef241b62aso3516000b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776103445; x=1776708245;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uG6p1MFp+26v87RPXmsW7BAV+LfDZF1OPvLL93JOuM0=;
 b=AEcbWYBbG0GBiJQVoqt+7OUw65+qNzagZvhoHHErsiXeYEyrWiE4BAPfOSTIAyRn97
 LAHYLhnPeSP+hG988uEEteGTPwuDlT231dBuKE+NkaZ0I1K2/0ZDicCtGQiIRnyfGPLH
 ojHw/DIUsmXksCloVcMwy5kECpfNw6Y5tUzxa2rCOHf9kM9NUyT5hAABUQAbViQVO4w4
 2qJx9FgCL/nhgn83YS2dAQJSSXwOANKvliaVOKH9WFzgwIcDf3467JzD7OkQqlseSh6r
 yEc8NVDN/oy26I/qBJfec9UsbYD4i2U6SIW0lDweDaIRtzrljjS2MBxs64gstZesdFAA
 UffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103445; x=1776708245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uG6p1MFp+26v87RPXmsW7BAV+LfDZF1OPvLL93JOuM0=;
 b=jiVp0SLCUyGvxgha80F9AFp4B+Vb6g3qeJwHwAp23lv9MGRdLdgQ6AGr/FDo0ORDYo
 AeEmLPsq+6lxfNlQmQU5FGzvN+Z72SWATF1JiFkPyTAJqUVq7t5DyDiOkD7UmTagtMIm
 YlWPpEBv0j6S5DPmaYVh7cRECCAWAHMpGls2bqRBW8UQVt4IeX7/zsTFDVX26tzqWMHZ
 okfEFN6bwM4LVh5bIgelm2o9OGvwHfi3KgntjTx6oaY3t0Dg7F8JVCNo9RwivZPMl0SC
 1z8j7OatlPuHRXLorJJk3UISQ+9ZNnXcfe+K4j9OyLZ7bD1HPF6h7f/bkHEPemEa7msj
 JLEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/tOLN4+s/ItiZSVIBjJVfNI7LV1aR50XwBOtU3G3gC/Dw2p3LhGUSB62484VO1OCPNAUvtbzf7cVk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfrsuXGIsgRyRl3lZNVSggr76TGlC0XbwYFJVHH00YE4BG5gWX
 mHLNpWOKYMPq9ez+vlMIFkygH2P7og00c/CGsEw+IadO5P51BYTxOupxbffTI38GyNUkI2IVVqm
 CIpNTmPdIlzAtyU60pcrwpsPkVjf5vTE8GF0JBBVVtVE5eMWf060AuynQx7Hs/bc5J2Pyeaw=
X-Gm-Gg: AeBDietCYJhoVdlHVSdWBsK2g4No8HYex/9GsN4LA5kDmjY2OxIIWvvXfFtUg4Lc30m
 NIi9cxa9eWQtHeqh8gZ2BOYOLpCmsRPGijzjfijKSotqb2vNTwZ0FImioGzKlAoAkA+BbMVDfDZ
 hauoAjrGjoGISYd3qMUEJd3UNiw0du2oj+keJOt5ar/ee28xFsAZ99jDJ4KnbLiAIzEzyXb/r8E
 rU5st+4ro9CVRBj2MkSUTyVcCxQNss6KtsurrFnfLVno0HGSWn++5xcGbT04bXUMC5iMlB+B1qQ
 bFwqkPsHEBby72YAMj91XxC08ZUYns9JXOyB+M1B8+qkoKT6oXFdIrJwCFChqpnkknVIDnb8J9x
 mKiynOfYO/DbwVBMIHpPt+qBpIkDXaaDOVdN6XNv6ejK0sMzJh0lDXZRUx4/MFEfyIrmfqDBnZS
 NXUmo9wShyTESGXydj5GOwOePJa/BOIThnYWEfy9fpgevtSA==
X-Received: by 2002:a05:6808:67c5:b0:467:462b:ab0 with SMTP id
 5614622812f47-4789e42be12mr7588991b6e.2.1776103445599; 
 Mon, 13 Apr 2026 11:04:05 -0700 (PDT)
X-Received: by 2002:a05:6808:67c5:b0:467:462b:ab0 with SMTP id
 5614622812f47-4789e42be12mr7588959b6e.2.1776103445107; 
 Mon, 13 Apr 2026 11:04:05 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee865e7sm2765700e87.10.2026.04.13.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:04:03 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:04:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/10] drm: of: forbid bridge-only calls to
 drm_of_find_panel_or_bridge()
Message-ID: <nligqvm3lq6n556onglmb345arxztd4pc6fboo4yrs3bfu27eu@uiyu2xklnexb>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-10-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-10-acd01cd79a1f@bootlin.com>
X-Proofpoint-ORIG-GUID: UM_pd9r8AAF6WuAZjfr4IDvtJr4uKYsK
X-Proofpoint-GUID: UM_pd9r8AAF6WuAZjfr4IDvtJr4uKYsK
X-Authority-Analysis: v=2.4 cv=BoitB4X5 c=1 sm=1 tr=0 ts=69dd3016 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=ihHiGccrl-12bfV6lMsA:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3NyBTYWx0ZWRfXxyCKKmdjViTT
 TxKA+OzLweYy6ICvtDYPsA366JNKsH/PqxionLvA9DOK1OjoVqdH390vbn9T3frmhPxinjmvNfH
 mawI+76NKIy4YO/Tw/Gw4bPbTCdSCRaZLaWLV7gsWfIWOCxKF60xvBWaa8JHqP6mmvZqR+OtAAS
 Xr10Fqt5w1zZzMw+57TPQFb8K3Sq3OL6Cm+M6yPYbxNcDlfPHxnxHCkaAULpZEwPY6b6Ww3SiRv
 k+042ZGUi8do+FgH/uzcPRcF4c6Bt9Sn7wqqT2Ja6358E6qNpVQEY7LQFlUUMCZqD7U1xdfhlKz
 yHj9r35xIu4sqkROWM2VKkQykSwNpSpecPMhmScjiSKOsfPy2U2t9RbhCdvsnpAMMZl9e72eHXF
 rKinBi9muFv3hrpAEgXEeY5wHNlyetA95rhsFuz+cmC8INsNpoiGbp1Xv7jurbrF7MV4442qeNP
 qVeUrsSpyHs9Xpz6frQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130177
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

On Mon, Apr 13, 2026 at 03:58:42PM +0200, Luca Ceresoli wrote:
> Up to now drm_of_find_panel_or_bridge() can be called with a bridge pointer
> only, a panel pointer only, or both a bridge and a panel pointers. The
> logic to handle all the three cases is somewhat complex to read however.
> 
> Now all bridge-only callers have been converted to
> of_drm_get_bridge_by_endpoint(), which is simpler and handles bridge
> refcounting. So forbid new bridge-only users by mandating a non-NULL panel
> pointer in the docs and in the sanity checks along with a warning.

Are there remaining users which still use either the bridge or the
panel? Would it be possible / better to drop the two-arg version?

> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_of.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 

-- 
With best wishes
Dmitry
