Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7EBF8FA98
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A3710E8E6;
	Tue, 21 Apr 2026 15:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0SFiySz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d/vfZO9k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1070510E8F3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:58:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63L9XVBv3164709
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2rlmangFWK+0INg27+5z36YD
 N+j/0s+7d9Y2woRTfSA=; b=T0SFiySzaezo2/7b9AmZz/YWbxYaR8QXZFSTRY9E
 GIJG6FUoGiv7oMrG/MuhO1luUIBzqDS9Di3R8cHZkheeVvtY9tnXtBv5c8xdqnzO
 mQY5VYjrqIGt5qiBU1i/VnnwLNYmhzPWxcl0Ag0LfyOa2DlgIHfJ3ruMbJh2/K79
 iYHNsmis4GWjcHz50PQ1pjBQvjUWhUAvlQ+UD1NQBZVJ/Dm2vTiR4tx45k54ZUDk
 yHUW3E2/4Y8RmVns3vj9kkK9gIjhyoMvvdEsmWPAQ3vUB0GDzHqMOFcmp9mtBVmz
 LvGD7gdvz4gUMMwCImnYk3adl2OhMTbdM3y/L4+aHoDtMQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp6q81am5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 15:58:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4b81c632so100770431cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776787126; x=1777391926;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2rlmangFWK+0INg27+5z36YDN+j/0s+7d9Y2woRTfSA=;
 b=d/vfZO9knZLdUuAXgAcuHxWSIciCh98gSYix/xSwYgUbJwz6Py5Pn6OeEhOmPD3VsJ
 WB2FklqsOGzNHZC4zIwvzJL7fC07/5Ig2ojHXN2E6popCfDaBPY2bCaW2rkBlkMJVLgd
 nZYBvSKB/jbMXCsnK+LSm8wNEtbYAaGtY8I2/A0G3tw2Ndeso/LVJ+GRaUFgMWATB+9v
 0A0pesdDarVaZDvLl0z5p5VbDrhn/fAjZgRfVzqqvii23VQEbGysip0+zqyaCHP8x8OR
 ctB9zJl+QI+gPKmpanXlBJmv8zPR1q0xmXPtsDnkcule0cPqQvTKHjAIvwNJnXi1Zvp+
 55WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776787126; x=1777391926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2rlmangFWK+0INg27+5z36YDN+j/0s+7d9Y2woRTfSA=;
 b=H9pfEeTqWgubVhb+rTBtx4465XtzKMbKBydGoP+E5e/tSqRWHrc17cbyDaWJOyTT5j
 6kyTg65WFxJgUYkkPVc4TTr3Hy7BFCdh7dzfnUh65yx+acN0QODlOhJBA8RDOpQjMmgr
 EnLfpmUIsFG4I0DyxbCHQ/00Ef3P0lp/6E//9y2ngbATTqFxBAjPpvbXX4T3wBWnd+Ma
 CCwLGhmeBjLBfwx4FJrbX3/3O2V6+ngieMMkhIdVOZfqY1H8z7avfIz4o914lTxz1LUu
 vdmRE0hDFvralyVs8STce3e1pTI724jT/r4apDniuDKYS7fZ5/ND2/TcJAnUpGVJjVjJ
 xhQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G3CF5ubNjKN43hSGKMbEDltcbJvxq9RniY1B+N0D3JI6P89oCeGhrv+Nrult7GhNjtJngu48MtsI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSr/AFE1CZ8mrPMheBi1FhuAwjW75IadXk1NNqvGiF1Y/BppSA
 meCzlmZqUNsxRE2It79P7lN+R0XGZZL5wWbEkdQAjl8IaAJbyzf10rkaZUUHtIlP8eIBkxNl90r
 QEHdGmg3x1HHKsFFWsL9kjU82oKn4KumC/kc2bAVH5ve1na05smb3g6IALQnjntx/iaXXfG4=
X-Gm-Gg: AeBDietSSlqWtwAzBEF3gSFiAYYXcux6/0VjmnyRy8Y+2tKBS+sKBHW0gpXwBwKVOZE
 HI1OuGuWhgsytJ/1ARuSAZPKu7xP2uB91eh/vzEbY7GZIt5F+EVvrSM9eFLpJT9P3iAb7SbwN2N
 suwANjdLVqc6vSQKIgaU8j1DXJk/HsV9x5IdAS0j+hKnwf2dhWgZhaEoNoPWWkIsrVik1ztRNz3
 UUubuTobna3Buymgob9IVuI9AKlPvsAfy6jSWFnEN9Q8aLZMOlGPr59HaKr0zlghLgMkye/nQ+j
 raVeoIZGkEl5o3l4ojea4hNVjLhHPT39Ryq6NGQ4jXkP/miPbnCoZwrVToC1cbh6TLPv2sjIR9Y
 DQ/jl1zNGAr9cbKyDQ7j94jA2IyNFBGaoBeeEdR6lVB3p9W3ADWy7uYJD/tmQeKfEPkQg47TIIy
 NXRAbufB4+ZzxvA/DPvx5o5xfnHadbWHbQYJJ98S14VhvHCA==
X-Received: by 2002:ac8:5a0f:0:b0:50f:ba8d:8b62 with SMTP id
 d75a77b69052e-50fba8d8caamr24329681cf.0.1776787125526; 
 Tue, 21 Apr 2026 08:58:45 -0700 (PDT)
X-Received: by 2002:ac8:5a0f:0:b0:50f:ba8d:8b62 with SMTP id
 d75a77b69052e-50fba8d8caamr24328851cf.0.1776787124912; 
 Tue, 21 Apr 2026 08:58:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187e12c8sm3767238e87.49.2026.04.21.08.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 08:58:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:58:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Simon Ser <contact@emersion.fr>,
 Harry Wentland <harry.wentland@amd.com>, Melissa Wen <mwen@igalia.com>,
 Sebastian Wick <sebastian.wick@redhat.com>, Alex Hung <alex.hung@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v2 20/20] drm/bridge_connector: Convert to
 atomic_create_state
Message-ID: <b7heherpjabs3xbgzxvaznyvfk5ok45uqrjotgr5esy2ctuvff@t5o25d65j37h>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
 <20260320-drm-mode-config-init-v2-20-c63f1134e76c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-drm-mode-config-init-v2-20-c63f1134e76c@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1NyBTYWx0ZWRfX8WCOL4qHALbG
 tNbbRO0jDmb1cRka378h3gIHWoCSeVwQz5S4lVdq4dozj0logyW515yUjJ9IPTutdQauJ9EIaq3
 +kDqtDbUrIIjyz2tNJ3GtmNLJOyHEMHBrLGwL0FILaCkCUSrFBa9/98OaEv/lHeICii/zw5Nm2D
 rXfe+lxlupDIKI7r1s6Mqf5UosYBUWTgfw3cB2IKyrtd7N7t6pjSn2BpiLzrxY+ZQtYDpVvGPrz
 w6ugUJEvm4fxntFxXMXC819E63ZEB7KTUW54Q+TITW2VcSjvECJ1XLFmC+T4RKT1mXZOWpTwm4S
 GcvDAEhTKJOiNTG3NXozgrt9YJBz3ejAr1/hIBMqzFWKJ7LcFhn6Co1Bibh/U98evkVJIA8qvZj
 h3HzrsU+FG2CvaNWjzeTWUL6B1kFTamnpf2dbspu5aVnW9f7zdubA1/WYEjrrDoUsu9hRmxwEXa
 EtSiW9TJ57zILkN0ZHQ==
X-Proofpoint-ORIG-GUID: dhQ_d55LuxVQYv1froyFtcRBLfna7hWC
X-Authority-Analysis: v=2.4 cv=eOYjSnp1 c=1 sm=1 tr=0 ts=69e79eb6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P1BnusSwAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CGuZyk7pIeUWItkfYpsA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: dhQ_d55LuxVQYv1froyFtcRBLfna7hWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210157
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

On Fri, Mar 20, 2026 at 05:27:27PM +0100, Maxime Ripard wrote:
> The connector created by drm_bridge_connector only initializes a
> pristine state in reset, which is equivalent to that atomic_create_state
> would expect. Let's convert to it.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
