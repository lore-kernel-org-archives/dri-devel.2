Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385C8FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8404E10E327;
	Tue, 28 Apr 2026 11:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7IPcpfb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aLEGsLSU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3479B10E327
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:35:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SAhVYx819269
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PffpjeU2jjzDgU5tqSe+zBEf
 KdG5CBffNrOKWE6A8zM=; b=n7IPcpfbxW8Kbc9LBIGAsME04k+zoicwwnz8zyRC
 sf8+5tu7dFguRjsVLTtuk4OLv2kSpFBBH4HSf532tje1UKSzv28xz4ZwFBEwYJZk
 FsyljiOjsw5E+ur704bQ1BTjt7oRcGDXvQtVAuq7ZMaeAm0MZTPsx1U2b67pgROz
 IETJdkjZL2V8YyZKp7iV885fXhUZonAjMgcjsR4urluhVmfmjHiVDk67wkapk7fe
 sMs4iHn9me6CnXoNzu4GBm2NZ1b+u4VGXdcZpNLfaJm47mtObcc7z6qwYIcuLGIp
 V52wJSaDRBXpR6YeAKjCjTeXblE3Zoa3YwwY+sq1e7em5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtud205nx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:34:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50edf01172bso230588171cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777376098; x=1777980898;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PffpjeU2jjzDgU5tqSe+zBEfKdG5CBffNrOKWE6A8zM=;
 b=aLEGsLSUem/9F4L/e6GGqkT09cil+LWfVAKY6QZVi1tQtCaX3WWUJIFC+FaHjpuVj6
 sYvfRRfPhmhkI8xTDMSf/mK9b+O7GGcojachfpjb1jiAbSx6OGmvW7KihtgFCtyUzZJQ
 +jqh+DT1WK7v8K30kqOnht8nf64Nu6F0z3FpN5JdOcI8gccoVnKcyZkBfL4njrMHHoN0
 dH/fG9QqZjPsgRrmSNPjt3bP2x7VtjZY3WXQAo3pcEF19ILR7UMoMza+3KFQJoK1JbDZ
 9AU2a2T9l69uJPt5kH0N7G7ibZ1L6ogsEM0MJYYuah3FW1+ALZq/Gk3OypkI7bx2EWuw
 G2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376098; x=1777980898;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PffpjeU2jjzDgU5tqSe+zBEfKdG5CBffNrOKWE6A8zM=;
 b=qwcAL8Mmz/bLtn3j2HwEGikQDrvUBGVlOoUF7Ep/mdGkuryvz7+mzof1oYZYNV0Awe
 FlCGNQek9BXdc4Yg+ZAWI97QHU52ATPP/vUvVm24T+0W0aKSN81fyUWQg4ZQXUhh39lN
 coxQjcqBrWTk9ZTYviqFXWEMDdBvj/Kj1VG4ycjqkbYwNNbgkc5qi8Zmu6B7znEtYVzb
 dXrNYEu54X0IeXCS5jcLKSrbPQ1xcSYrnvPxWkId1TnYApSAH9fBGyrOfpbuXrRFJBSw
 YhbQaNevpwe4LbNkQKzFgcRhqiktTZI0WTGyo4B+ZOLaCZNALESWJE2+lO938T1o0r4M
 VRlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qbWOYyIfyboj9s+BizPnCePPS8TrrE7FRjfIYZyEXNBn4czqK5DrkI+6dVw15/lpsj06/GI7fgKg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRYbTwnBOCuTPx+znMF6qH1AiACzd5/R2rHvft28aSVZ+r6nPt
 pwlbvGZwxvMRKqMHasET+3A6u6FsApem60chcrZFraC2hSrEbkyKd6quPbkniuDEA9LJox5UBKW
 HzR9i50jiGpVdzYFrZbRvyacPeaM9JgS6HOkKdU0PUWw801GFR8JVSR2hYwy9fwhhSlhHb0s=
X-Gm-Gg: AeBDieve+3WRSrOaMB1Yc99F8yKFg9ylYy8kbqVQ4QBwuNibNHjcy9eWiKnhoWXjr5Y
 LYo5SqDeMPztpoNtzPUBfwC2I7YcrJZ4EV+uUV4S7d7iQ0Q7Vk2wmcXIXHYPGB/YsZ+J7KVjWm7
 Fcmh/wRH9/iDYUAeAncWN57cVHBHjG0c8ZybbfiASHKznguZHCAOKYFKm3Ps4d3TDXSdzSOXR5O
 66+0dgLxouBHaQ2xKxqNLci4l0GKKppn38PMEAhDenZywEO8tHWO/Ar+nE5A0QMzdxpduO5J0rP
 fbFY4Og2SVrYu48L1nbs4n7jfZrrwhA7VFgljaGy6hqt431p9rTZTVFPDOoaqaTpAQnsOGICETq
 gyy9r/v0trTkyrP50XcF2XwX7ogCRZboXsUdorIYc33cAXWv23jRfKTEe2X4AUbJdDaJzxZyy27
 Nz2sNjnUUa3DARLntIBcwpWYxRlODYkn9rHg3DV2ulo9V18g==
X-Received: by 2002:ac8:6f05:0:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-5100e146630mr31518021cf.25.1777376098393; 
 Tue, 28 Apr 2026 04:34:58 -0700 (PDT)
X-Received: by 2002:ac8:6f05:0:b0:50f:bb77:a084 with SMTP id
 d75a77b69052e-5100e146630mr31517541cf.25.1777376097914; 
 Tue, 28 Apr 2026 04:34:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a74640b645sm557987e87.79.2026.04.28.04.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:34:56 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:34:55 +0300
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
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
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
Subject: Re: [PATCH v2 09/11] drm/bridge: lt8713sx: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <jeoq37unyevaxozcryvus7u4frdwayqdxej4hhq72fjpirr3gm@e4yagmhobqdj>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-9-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-9-4300744a1c47@bootlin.com>
X-Authority-Analysis: v=2.4 cv=a/0AM0SF c=1 sm=1 tr=0 ts=69f09b63 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=SbJqdHswXr3mvj6Yul4A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: CGi36amMqZjAhc1Jve3QVGtbkWr5jFVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfXwTa3+tPlhrU0
 935pU5UNPmTnikZspbtZo5XYxlK5oqwWDg2oL9sRlRoWV7jnH1RbrRsW4WvmBoRs8rrOEnXWR7z
 ttgwPmX5jUdaL6y372s83385JUewMLHrWc0C4PkyEmvTMi+jwZ2Xp7Sn+fFfGiQ3E4ouM3CMD1V
 lCzvOi4zkrGGgEoDPa6KN2gCAMp11lZur80cXOtbMsTof4F/eIdb3QkvclIpTtiD+coGLA/RjyL
 q/giuRhrVQbEzPbxG7/qpWgyhRpfGS0SO66eYSW+pwcwgkc5cHnHy8snvbU4PYyFc+YsBxLAZyH
 mvbr8GICCK2Lnrf9h5zynyHU5uWW0yAPz6+GlzIWGC3VVMLfJZ5J6o6WV/sck7yMbuLiAwtKS5I
 HxdmewNyPb1ijligmEiHNzKbP+9cuW438Y0gIvGYpnmIygbO03JNLGKwJEQB2hREjjvxYF0r8sf
 vo/fK0fgv9AjeGxA0MA==
X-Proofpoint-GUID: CGi36amMqZjAhc1Jve3QVGtbkWr5jFVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280105
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

On Tue, Apr 28, 2026 at 11:15:55AM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8713sx.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
