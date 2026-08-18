Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B691C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 03:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D6210E49A;
	Tue, 18 Aug 2026 03:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O0a7jmqd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xh/sOyDq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E20210E47C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:31:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HLkQV53531760
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=n+O+aZ5N4bg+RGWDpZ5iVQeO
 w+4epR7Fbm6jiS4DyUc=; b=O0a7jmqdUKzE7fEym4TB84zrfkYrhZ8W2ryz4KKn
 6WZzHy4XZjdBMiylU1/rdVO6jztSvn70rfmM/KzR3SPwIBEqSSxmDw+9RdbO3z4O
 CAgY0eyVUQ4TJKRO4SHFerUi4BZAFeiDs3B0aJ2wODFrIei3/gR9KUfqHAn/MFXX
 zf1vIMqWDjgcTciq+QQQQGUyRyrfiBcAjBtND50LLZ7MT15IZInsjE1o18bBzI9m
 Xu4y/Ixmp57ci26+v0iBlsulzb+HJEQ0UMxyFskWd4fRZesqRYUTF8Jp6q8ndW8U
 UJ/q40YgQSl05jujtdO1UZNkGxvPD7I6hr8CWnEVXGIwSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615j85k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 03:31:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso335044185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 20:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787023901; x=1787628701;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n+O+aZ5N4bg+RGWDpZ5iVQeOw+4epR7Fbm6jiS4DyUc=;
 b=Xh/sOyDqlvEOlgfuPjpV462kBM2Kntxy42uXicAlslZWLYbzqI6KFxP5TOTdCdaJbY
 PMfubo3dXK5tNWtRChyRm0xJ90w75Kw6mhwFtwcxLw+CsFL68KXfPw42v0dNAuu9oVTh
 r57Z3kGXLFOm9vW4vkBNgghoTFK5vMkrcw5B+cQhKZKx0zBL5CgliFHfTw/oJmri/QEP
 Pm6nntrtt2VOhfSFWGpHjhDZ3kjsUuVwUN4iuZ3d2D04J6ENqwTYmYA188A52Cwn/WVw
 uRPxGzD7Adu/HbHpfJsshxkppb3GiUGQ+gBLhQlLK/DEiG3W9d8+uC5Y7ewH7YQuIone
 IGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787023901; x=1787628701;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n+O+aZ5N4bg+RGWDpZ5iVQeOw+4epR7Fbm6jiS4DyUc=;
 b=NNuCn/e9Akwy9G0DpX8BN4ci6t+TQIv95AsBsO0tjSn3XKq6ZntL4d3Xey6oJRoXtc
 ltwfXNjGaBZx5cejOzsuUE0UFM9AZvZgWK0DlagN3AdQlrz+SZmDmwWLm0G8T8IvBv0r
 2ws3wGQyTTmIf+J3buTWp+QzbpxCdxSALK2QFPnvcP+GKIz58b8idQkk2eGHKWl3O7JL
 RR9caRSjyck/KuTngR8+wqrnx51Y0w4Dgu9KsPIwEPjliUWiIR5W3AB5b7JDPpGk/LhP
 MFVLQq38ElAPzpBvznOlfp0FqDx5l8yqdWX/KIvz1jKUOIb65JHUZ+N1FX4ATpg/kpa1
 twhA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZfq7mmBj80vHKF/wZ434pO2FWkrJUcLCd/O+WP6IyHcEnglbX7fc5zZs+sTAsViwvWdVG3zkYe8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI8xMSejJyI0H0G7d4yuF0KNwE7V6ERjK4RWFZ7coh1h89wgff
 X4mUo3i7EC3aSu0jlx5QTiNTwC6HH9mFH/yq9ufhwF4APTOzWdkQhskt33bm8MwshVAKubTW/9D
 jFt5Qe3HtNn9QcR7nm4IlAaPd3zGamagCOs1XfyoWL6XYH7qi3dyuztDxydhJkULayOQaGvv+z1
 UOjX7UurV+
X-Gm-Gg: AR+sD11SFfguydeobJ1e/satm9rI8HX/YtHMbQQEDizIEhOwID0Q9yT1dedXQNvEuOy
 53CQgTPD1/BL9I24lUuuetlaMud0ASRuKGR0g26TcusF9eSF2z8RmTWfIAMZCukLhAYcfn2LGc7
 AHnaSbK7vWdT2RvlxbbS20rrdNeLprQzSuInld1Regl2HRVTOJ3YzpWb0Nr+v5BesZwsnhlNZH4
 7YCWOJ+0cc+RBKty4X3qVkyNtdWVFiTAGZHoR7CrbIvvJiLyyOOdY7ULGbx2/34Jf2RZzClyIuu
 T8EeDKVztlU3iA0csbKLREBnLLOJuCIhvUo7Z9yhrZjEM5siKJAC+7Io8kMWjh+alpjs+pyS8TL
 29Qi4LgetINj/7+66UC4hf1D0ixkNSWSk5MZmEdI1ADAWsbB71F7+mowCBwb4Nwajspb16JfEXq
 9N3ec6J+xDMpMg
X-Received: by 2002:a05:620a:bd3:b0:92e:8a84:7041 with SMTP id
 af79cd13be357-93704adf65emr502915785a.8.1787023900852; 
 Mon, 17 Aug 2026 20:31:40 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:92e:8a84:7041 with SMTP id
 af79cd13be357-93704adf65emr502912485a.8.1787023900401; 
 Mon, 17 Aug 2026 20:31:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b46d00b5ffsm848954e87.67.2026.08.17.20.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 20:31:39 -0700 (PDT)
Date: Tue, 18 Aug 2026 06:31:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
Message-ID: <5hksiunlpcuv6b6eu2tx5furtzhsmutlts25vi2t62totceedg@r6fagkhlflic>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
X-Proofpoint-GUID: qUrbvgY460ZhazBVqmkf1T3-ZSwx2wBK
X-Proofpoint-ORIG-GUID: qUrbvgY460ZhazBVqmkf1T3-ZSwx2wBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX7D400d+JVesE
 r542WAnqdkFJU2Oj/uoYBC6gC+J08xHXU691XO1BO9xKzXkYsCF2DnF2+1R/YXozsvNIqQMvWTv
 freNpIJo9yjKIIYjI0b5HVnkCImuHOeuuQQuEm601DY38pcibsqiBzVFf91obNJ0WvnLFmXzxMa
 qemLggHydwD/cRckrz3/PMSEMMUOGNBA9I7O8I/WvQs1MxaA9RfbfcfNIDGinaTd+aR+y6kO5bG
 6DNwXNB4vclt+xqziKo/7RAV2ZKA+mS76vYjFNNOxZLSca5SEYRixFcR+JM7BBMIKB/33i862iK
 rsxW8j1zBHn8MpMa2B+AMLUdBrZea9viFWdjdITGcgFzVmUPJiSJQWp9B1IfgXghqZjq76xdtYk
 ojy9yVnS6Cwqn+bFUgRG1ps0FppiaqSVWp5kyyZLXPlwTy7/P4ksvK/GCUzHYMBQKajUQQO58eH
 UacWBS7yvksn8x+8ogQ==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83d21d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=FzwJ3IxCXKmGzkSqTIsA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX4/D1vhhPql9o
 khVjGbJ8GUyatAO8lJgmnRXVrhdwKn69DeC4DJ/CJdYwfdVjaSAOhLS6FfoZSYHAG7RKDOKKWqQ
 UiPNGKs2eQcJ5xreir69jZXGsiDaKTU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180024
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

On Thu, Aug 13, 2026 at 03:44:53PM +0800, Yongxing Mou wrote:
> 
> 
> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
> > On 7/20/26 10:43 AM, Yongxing Mou wrote:
> > > Kaanapali (SM8750) and Glymur use two display power domains.
> > > CORE_GDSC powers the main display hardware while INT2_GDSC
> > > powers a subset of SSPP blocks.
> > 
> > Can they operate independently? Does INT2_GDSC need to be
> > powered on after CORE_GDSC?
> > 
> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should
> generally track the same state, except that INT2_GDSC may be powered down
> when SSPP1 (VIG2/VIG3/DMA5) is unused.
>    - CORE off, INT2 off
>     - CORE on,  INT2 off
>     - CORE on,  INT2 on

What will happen if CORE is off, but INT2 is on?

> > If so, perhaps changing the clock driver to make CORE a parent
> > of INT2 could be the simpler solution
> > 
> > Konrad
> That would still need DT and binding changes -- DPU has to reference
> INT2_GDSC directly to gate it independently, so it can't be hidden in the
> clock driver. The two GDSCs have independent GDSCR registers with no
> HW-enforced sequencing, so they appear to be peers rather than parent/child.

-- 
With best wishes
Dmitry
