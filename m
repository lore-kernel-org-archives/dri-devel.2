Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2810854DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB2610E768;
	Wed, 18 Mar 2026 09:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WjkhwcqQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ffnrLeNE";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791C710E032
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:44:35 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62I8uE3B2293882
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=amemIOjZKM5K9aUMgTO6U4C2
 ChZss2oJUtADn1/2Za4=; b=WjkhwcqQfil3EhW7e6TDRmvMImyTB0My97fqECVw
 dZiLZ13+Iw6MIcCe84hu4IfdyBIVuBxmBJBjuXcrJMlHKnZQLttXfWXi77xSkXkF
 +49dmKWVHW7UuxQGNzB5GDqjxQIaDhXgcaenkB6Q0toJb/+W6HrxSHOSr3MGaT8I
 S/yyt4X7fFaZ2YxSMvWHLL08DcJd0EgW1Yp93P1/NQSswBNWme0f7+FJv6WKlxiV
 SDLLiHqcgiw3etjzg9SXC0A20K1Pb/ff3itZ3OxK+vhfnKrVOuD8Unyyalqr2BeD
 P7ZU17/qjopd3jmtCFIxlS0e87wBxH91zAUpc6zzxCUTqA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cya83urqc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:44:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509177a915aso59701061cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773827074; x=1774431874;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=amemIOjZKM5K9aUMgTO6U4C2ChZss2oJUtADn1/2Za4=;
 b=ffnrLeNEXL2rwwvYvifpj0TyGgXL0y7cBzzAxNWMQq9oG750GfN7EZKELIYD18z1QM
 qo0sqwPqGUE4EIYwaN+wTukXo9WeDDoXR9eJuwOVgO0zFULwlp1b+yENp3p08jOhtBMW
 KMAVmqsKrH0OPWNdgq+etobOMtjwS1XEw5Bap6/5IvIQ9raIaKTXg+e7U/0LcAaspuSv
 NNBT2zU10sWhR/3gBYQxEwMpc5La+7LLUjNOV72BpNyACsCVjj85qKcQmhCVXu6Qkf1Y
 WaO6bAt9dsS4WPqgbdIAG9kgDbBEQWtE7DsKKYbnfEpE7ea7VuHaz+pVGcOTtXApPezg
 w7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773827074; x=1774431874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amemIOjZKM5K9aUMgTO6U4C2ChZss2oJUtADn1/2Za4=;
 b=qvh+9XgPuuNbZb0GPcWS8+8GrCW0spPcl2Y+7ETxZpEllc/4wpZnzC4bStmdYkr+2c
 pWxENjMlJHrNUdcikTn72/1hFolmB3WxlOgQWBzgMz1rWyKULSOYUnQp86We097N1eqU
 O2c0dryKqgDZQnaeDXdi3UIzu1UfjGnVZThTzvTf7YqgVcMW6uBcSgUZsLj8A2QqL16B
 IZSX1x0h/AuRRAaW6WqjMWxSFODB05aLKf/NHLViueqLt9fMiBVAV1HvaUCe7rslWHng
 PjECiMlsHkOqu9XzziBazzNCdjVhP4uQ3n/QUlbtSyhcjSN5R5Yf2+sw4WGVHdtm+pXl
 kwvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJEkuqtMcnhD3/0RPzwbEgglUmsoJLXzJmzyUCjaTQZOakbElGrmSJ+g9x8h60vcqxErKEysyECRg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyImGsh68joiJgWTyOFT22/7RL8u7/3RJ+Q/fcXmaLj+0amdaLt
 JVJoTXnpZJanERVyiv3h8bCqSkReFc9JeLrEC+5mw4Ebw+z17ulqrTycbgkVm95XfBMKtMt1koQ
 8d8PU2KkvcyZ3ZU1KxFZVxFF3x2KFdhKNheSMowHqyUhgnEDj65aNeIC5DtnjPYOOafoqva4=
X-Gm-Gg: ATEYQzx6CxB+sJnGt6qqjsBlq/PnknZsjTJQ7cLPMjgC0SquVjrEveIMw6yxAUX3z5f
 /VLNSlRphePYPKCI8jD4xn2TUcGNYt8fHLYt2Tc3Ydpyl/dz2e6dUbTm8e9f7uQPiVtQ/otuRw/
 f4a0zCSk6uCoMNr+7/k5YFuJAojLamWMTkjWCAKpBDXJFGE9RwL04MoNVL9XQZW/mhgLZtD9D3T
 ZHvFF9uQ9+MMQa9MW3O77UXLvJMYfqeRr88k20qEC0BqnSzaCJrv0VG74yJY75dUIWIoxufQDlz
 i/N7mEghaEUWb2IqdEzmNH5gU8clIyN6PdYzsBj4tHYfTK6E0/uud0YSND2oBS5D8oJssKINr5+
 t19R2l7mbRb0IFMKK5vpuDHXgGkTsigOhl2Z9m/T2JU4jdE/hlvEeY+SdhaiFOk80FCOYTcmgt3
 BVuyWmREPu6xktFlBr5NvgSc4vj8v/FIi///A=
X-Received: by 2002:ac8:7d0b:0:b0:508:ffad:4bf4 with SMTP id
 d75a77b69052e-50997ff8dd0mr76935951cf.5.1773827074003; 
 Wed, 18 Mar 2026 02:44:34 -0700 (PDT)
X-Received: by 2002:ac8:7d0b:0:b0:508:ffad:4bf4 with SMTP id
 d75a77b69052e-50997ff8dd0mr76935831cf.5.1773827073595; 
 Wed, 18 Mar 2026 02:44:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bd51570a8sm4700141fa.6.2026.03.18.02.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 02:44:32 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:44:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>,
 Douglas Anderson <dianders@chromium.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/mipi-dsi: add flag for sending all DSC slices in
 one packet
Message-ID: <ii3y4yjt5kymqqtoki5zsogauurjb2yyxtfn5lygvwxrts5mp3@u7b2z57v4xeg>
References: <20260318-dsi-dsc-slice-per-pkt-v1-0-1bd66b7f9e0c@pm.me>
 <20260318-dsi-dsc-slice-per-pkt-v1-1-1bd66b7f9e0c@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-dsi-dsc-slice-per-pkt-v1-1-1bd66b7f9e0c@pm.me>
X-Proofpoint-ORIG-GUID: A--BAQ3tB-JLvtEh6bYJaIbP2z31GRWQ
X-Proofpoint-GUID: A--BAQ3tB-JLvtEh6bYJaIbP2z31GRWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA4MCBTYWx0ZWRfX2Ou3bnimyEfh
 Lo3zj0ZnmWWa1TtrqamQz++t+v28UqX2b7lhTHYtWKvBE530XMxvxbGWIOLzEknXcVBOhfrV392
 VmAkaGnSrV5BEn5clZbXHR8ai+nXgHVezDP13W6wy44OQcj6KLv0CVsYvxmIASGQyCjm0E4GSU4
 0uLHjiIBYnVXXV8rsPFwUukZuEG3w+4uBXL44xWFbLjwE3BU+zeokQUEvkCQjsKMrzVbmolkAIN
 qatXc3o7csDSK1Xb962YFLWA5xpOqbUkxAK+UU4CBqjBZ4vQ7It7AlcRqugjfjYNDkFbqk2W/x+
 vgXKKu5z43cBrQpaYWUF5cML+mCZ1WiXT4PLOC7QzU9TIGJMJAxFys5deRO6Az06CT9LZPfpRt8
 HSyV5vkVa9loJUb+gK32s/tBjWMpodSk2x0+7INUsDGI3dSrnwdYJZirZFJ9IS8eGHSSn8UshEq
 0ByWep9gcRpygMSM8oQ==
X-Authority-Analysis: v=2.4 cv=Y8n1cxeN c=1 sm=1 tr=0 ts=69ba7402 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=T2ZltfVFVEVyCiQaPD4A:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180080
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

On Wed, Mar 18, 2026 at 07:32:58AM +0000, Alexander Koskovich wrote:
> The MIPI DSI v1.3 spec defines two modes for transporting compressed
> pixel data: one slice per packet or multiple slice widths in a single
> packet (Section 8.8.24 Figure 40).
> 
> Add a MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT flag that panel drivers can
> set to indicate that all DSC slices for a line should be packed into a
> single packet. When unset should default to 1 slice per packet.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  include/drm/drm_mipi_dsi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

However I'd also like to hear an optinion from somebody else with the
higher authority.

-- 
With best wishes
Dmitry
