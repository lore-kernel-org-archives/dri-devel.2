Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F85CD5BCF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 315FC10E414;
	Mon, 25 May 2026 08:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAtKmecL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNN9/6ex";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6243D10E414
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:51:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6njgN1330183
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=gmzxJUdNmgwbMgi64MvkIm+S
 WsTqXZ/RU/qirTOp0cc=; b=AAtKmecLvPwfse8fV7D2ns0kwnp5xFTRiRI+lf58
 qBNKAY/XUF0FFcMY22cv5vJdnF/1y2nGv6HdFMWmrZNLFDycBu6b+4lhDwZ7iVQt
 M8Jgx1XMfu2TIBojhv2TrHHCfGjz3uSkSP6YYAR0qD28lep/De70zKV0dOJfmJgb
 2W/Wjm1CvXIEetbsKpREllh5BwMKGRklqbO/izz+8pDfyJ5ghOHjaj1HEnmqZ7WB
 6c3dAQUV6M/4nN+2xU2qFjj84HbE8WWds3/1B8YsTrcvRmgdv8YJc97RcNt1uf9J
 VjoRfrHTXQ7+d89IM/Uz8GGny+Z18bTKpMe8rHoOzSimtg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w5bdu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:51:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51494d74d4bso3535671cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779699076; x=1780303876;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gmzxJUdNmgwbMgi64MvkIm+SWsTqXZ/RU/qirTOp0cc=;
 b=eNN9/6ex7wzB2xeNJZxayEyYc8ALXs4MrZxs/mmv8NZUdl8BbOAGc7o+JXHj6QWLts
 Wuip11HAc1XGKP2yMI4pQJQOqfTzubZ4emngPCO7p8QvVExFCIrdtp6T/knTow77YvTq
 9Rga3N7wp7aW7hsyWIIbpVgiRvcKFrF+6asmzXtY5eody5FdybO7/tFPl1aZHJEsNuq6
 d/iZcF6uQ7ylgA6U0BCHLs1QbglWB7f0ECEit6/pk9YCzMqvk486UyD472hh1Yc33j1Z
 2fdIjntzKSMd9Y3l8c0X7VQF9B67V0SGe+uY92YSi3yMEKyZO9KKbx7DGxQAR1O0bHsl
 YItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699076; x=1780303876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmzxJUdNmgwbMgi64MvkIm+SWsTqXZ/RU/qirTOp0cc=;
 b=SlK/KZ7hZyTCzWPeOkB/LVIvQqtXHxlOAwvkNmEyqYAtv5maIW/AuPeaSy5r7rlvn7
 Kr7/BHNWbBqn6T0M7f6OiziJlxOGuT5mvqQ08T4jHjKVjxA9uZoJlKMZ6gTGILu2Gpft
 b4baPOIO9dI5TCn1dAAPSGC/kr/aYtFOnYq0ek+eDyzVatzgcLf12AhHDOgyKPqciWtr
 8vf4xcdRQWo6n2poy4/eRaj1KWS9WJPBEKiGB/jSrYl2AQ1r2j050QrMLEfVKRP5LEDJ
 5drOyBK9Cq+0HfSA4THoZqDkFi364UCg7YsKFTgCU253/FHfyd8I3OBKV6ZxsUojbAct
 pABw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4CN7fJEDl2KbJy+K854PlvQb8QP/o8gm1g9wqVm88fN1RHw0qz2GcxqSHkvbxkFiDvK7JwXIftZg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzISQqQ5k8QZ7O3n9kD1OVOnvxC3q8TVxgi6aXP4fPtMr6Xoa+B
 WeilJV0MvDA7PuN5SB+iP5BqnMDWQqeSFl1UW8Do+asgU199DE/H7ZVrskRnXK7A/VK4F4U30rY
 zIch9tdbGNI5LduPu0sAk+hVFp2DAYwuDXF3nwJl5O6Dj1/h/FQRZCA92X9oReJNU8IRJe0c=
X-Gm-Gg: Acq92OEAlnY35bBKpfPVcfZOKNBpoMXPbNHSs6uRWioPI0TUn3i5ecsNWpuisZSfcSf
 8hbyX2EpVwMMkgXJ0LHkn2TSEjMT1zD4hN8Ws+dH18JmS0s3C2MlHXZtrEVGjiesK6oYj7M1HnB
 /a/CTETcgnTUYMcqrgpckTs9keU4ZB/jGNIGg8XPmQ+/jNOHguA6E7RMGe967rOFKn6vI/4K43z
 b2Rk7DexvB09grd+T450IbZBwuV8Y5hhe2dpi3R6vRW0En09jjlg7B3+0+6E6K2iFntZSzoRaDx
 nJk6mjPpqC/dFuecxSrqMBRPDDx+P957xOso6UohlSiBtDFPxHL3aXr/AN1hjZoWgV9G20RtD5v
 PTrFtJILNulMEbWxcfDb8v6tMyFl/6jAuX/JyCSjuiM/nfjvI+KrarIGVsIwpVGXHt//8JsjScl
 W4ghHyR5hA0g03xgO3/JQEQK07KvNLY+LSpzs=
X-Received: by 2002:a05:622a:8d11:b0:50f:c133:2dc6 with SMTP id
 d75a77b69052e-516c55d2762mr178735751cf.19.1779699075740; 
 Mon, 25 May 2026 01:51:15 -0700 (PDT)
X-Received: by 2002:a05:622a:8d11:b0:50f:c133:2dc6 with SMTP id
 d75a77b69052e-516c55d2762mr178735661cf.19.1779699075310; 
 Mon, 25 May 2026 01:51:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a4d8sm21522551fa.25.2026.05.25.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:51:14 -0700 (PDT)
Date: Mon, 25 May 2026 11:51:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v6 00/10] drm/msm/dp: Drop the HPD state machine
Message-ID: <kqtiqyb56yauft4ajzeu4tkfx36eby2hz57qzl5jtkz54qke7s@fwpoa6a5zwax>
References: <20260524-hpd-refactor-v6-0-cf3ab488dd7b@oss.qualcomm.com>
 <ab26ea90-5f28-4582-8f82-3925471d917f@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab26ea90-5f28-4582-8f82-3925471d917f@packett.cool>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a140d84 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4TE31p-vCBvcHHLj6PsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4OSBTYWx0ZWRfXzncYaP7bCIeb
 /9ZbTMuCtiGicXpW4FFNY4SWOaroq8csG6sVgfdwN3BwEPCHpssw2+tAjQEn8sJNpqRtYR19Pp8
 ISXJC6t9Ni5EFTDOwnq6qOMjODvDaLJxlICAfKYDr/TJtA3qomVFmYogbeNYKUOzMIhty7BRh6L
 ZEGRFo6rXBGuH+zZh7EaI+vgkdsYb5BKQSzY3eRwpStCCKPtrdj7ag4ZrifUgcMsG2Z+fjMuSW4
 nUlfy+Eh1KpvBpV1nzVqsemSbf368c47T1FU5WkAItlUt/LEMQERaT2LIcKp9g5BMY97L02KOg+
 RyhKU3KUdKhbfkQ0DLKJH4A3Lif/zGkeCJsASX53CeTKD/Q9ogLJQuvb4M71XcAEKqeVzmzbB9H
 WjvVBgeYyEVFb5NZvD9O4i+TEEFcrMfFXI/aLcLwjLC8NvBS1YcfmZr4iG9oLid/v2DbKHAb2Vb
 2ke7w8Rtu7UHldv+FGA==
X-Proofpoint-ORIG-GUID: JkuJw6c3-YAVAygyqR7GrNmK2cFnUkUR
X-Proofpoint-GUID: JkuJw6c3-YAVAygyqR7GrNmK2cFnUkUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250089
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

On Sun, May 24, 2026 at 06:32:18PM -0300, Val Packett wrote:
> 
> On 5/24/26 7:33 AM, Dmitry Baryshkov wrote:
> > Currently, all HPD interrupt handling must go through the HPD state
> > machine.
> > 
> > This has caused many issues where the DRM framework assumes that DP is
> > in one state while the state machine is stuck in another state.
> > 
> > As discussed here [1], this series:
> > 
> > - Removes the state machine
> > - Moves link training to atomic_enable()
> > - Changes the detect() behavior to return true if a display is physically
> >    plugged in (as opposed to if the DP link is ready).
> > - Remove event queue and move internal HPD handling to hpd_notify()
> > 
> > To correctly detect the displays which are plugged on boot on the boards
> > which use dp-connector devices, this series depends on [2]. USB-C and
> > eDP panels are handled natively.
> > 
> > [1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738
> > [2] https://lore.kernel.org/all/20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com/
> > 
> > ---
> > Changes in v6:
> > - Corrected mismatch between Jessica's From and SoB emails
> > - Corrected documentation and fixed style comments for
> >    msm_dp_bridge_detect() (Bjorn, Konrad)
> > - Changed msm_dp_bridge_atomic_enable() to bail out earlier in case of
> >    link training failure (Konrad)
> > - Corrected commit message for the link training commit to stop
> >    mentioning event-related changes (Konrad)
> > - Added kerneldoc to msm_dp_display_host_phy_init(), describing return
> >    value (Konrad)
> > - Switched to guard() instead of raw mutex_lock() (Konrad)
> > - Link to v5: https://lore.kernel.org/r/20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com
> 
> Looks like v5 is already in linux-next.. merged in:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=4d28d7f4c69895437aeb0337d5e8d3dc2a5395cf

To be replaced by v6 in the next linux-next buildup. There were comments
(and r-b's) by Konrad, so it was worth replacing the series rather than
forcing v5 through to msm-next and then drm-next and then landing
changes on top of it.

-- 
With best wishes
Dmitry
