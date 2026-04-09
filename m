Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61410F31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAAF10E7F9;
	Thu,  9 Apr 2026 14:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="frO4aQnh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjrdFlru";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E7510E3AD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:11:48 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CZNg8779509
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 14:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RXM4/dGQCOY9WohzO9Vwfur2
 lRNX5z3S6aMHTL5x5+M=; b=frO4aQnh/4WwuUGFpPPff35zIDVr0S/j30OdaeM4
 Gp9F3m6sWRsMa6gE2PaTtPUdw4Akbmf0Fisdu/vCeNk8rNvdht7Tt30DS+lTR5+l
 bC35HQEQEfCS9/XXAwEJznE83Ac+u0L9rlcNtwjhqLclguQ4jRLnf0U2wGET/ya3
 G30dsponJasJJHOnz+oZJNMWF8mimcCiAQJwvGQYt04c9H36xuE4ybBb7/VlyFeU
 c3uAYx42txjataVz6z8br9FLGd7x77M8LqMeqPWo3iYRvF4RtBc4dadxN3rSWRzs
 P98ldQ+RXEpqXjefr40uN92DU/PB76v8QyykwlMCRKcHGQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec8hrfd9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:11:47 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6055b9cfa08so317835137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775743906; x=1776348706;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RXM4/dGQCOY9WohzO9Vwfur2lRNX5z3S6aMHTL5x5+M=;
 b=GjrdFlrul9FUsSUpo4S0CnYlSo3xyuBqWVJhE08P9O3zgA5AELM/COY9MKjDWU5H1d
 W5AWEMsnWdfJqDSDj6AdDSsOxneVfrr8Zl73pnJTdiKhEjXoLRguWek1ocnzsQbGHKif
 qe/axbBrZTKa3wvSoYSsJQcgwVZgdGWZ7LcNPRHhHsQg96MHU2D+/QIZMuUpL3l1bSJK
 Xx4YlAhzcjjPT/ksx6mT9A0qmhKP5auwr/pqP3SkoIT076IWIxZx+k6WBs8EOHY904CY
 1ZL8gw0sFgGcwXlPv4Etbt6eCKzAOATvKxSga3I+sa1vvoflkcAecas6UhYU7Gq0CRX8
 3Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775743906; x=1776348706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXM4/dGQCOY9WohzO9Vwfur2lRNX5z3S6aMHTL5x5+M=;
 b=Cnk/jUKBGZumGOkggmIsvQh9Us/Wdo4x26+Y2hV19eff+DfYpmOjBKzC7V0LIEO1ff
 nfrrW+j4xxRWSAHSZBOvNBus54aHV960DcH16TSB+rDUQF+IGdLbLb0IUu+2cdYMTnmJ
 ODC86yO+IMnBfd+lGNimMpg8JsXdtgDJIo5GwEgRUXDquBLgU6gpY+Bt81/aj+WBZV77
 O5n2ShjZlWJ/LKD/kerkKV7rqsLuTVMXKHDXgHiCMTRe2d+SnwQp+8grBXzuoJEMcVv1
 cge7xI9qbGvvwxH/NJD4oJLSIewY1ki4ckZqDp54vItEEhb2yBnnfNdrJf+C+aAwLdk/
 QcaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS0f77OcU7YlNRPkD3iy0yNzrqSJ2yreAKKQnCdLtDkegwq1KvAu5/rdrij36rK9HBVExLkdFwED0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGpdTGgWcaubuDUcWl/cQV29Xx+pyxg7r/KEOus/4iZdQhZzsR
 igVxbDh1YeUKIXdiviOXVLwiGEjQf2QpD++hxZ1xRNzlb0z3UuILNqU+vz9fyEHProFBkXAxV0Y
 TaOvxORtQHhpx759bivRMYY7vIfSjXn+WXkrBmH/vL3vrkldSEZr8RlRLffsxFzOPiIdxQW8=
X-Gm-Gg: AeBDiev6sLOzEQiDVUOx9XcK/SIflrqM0RJEgHmo8U1FeArcf51giU/Ht+d/TiEtfd+
 pwRABCH2aUlm6bqViUodEpUjXK+bA9RFgtO7/TrlgxYJcXDTLw0ATjeZCA330A/qUkR3HQo3DK2
 8RpXSp2Grhu2M1NpCVPZ3dVuOVYRDUyebrGg9ED4OW7DPqK+cFa2zRL+9WETDcVg4XsbTlXo+EX
 uVrZ2D689bEM2DAwXtx+tqCGh7AFhwRAVzheSWLdN7MbIZsTC/4Y///aW0tST1r2IZb37Ypqc9J
 n6BiG+/X7nfsF0lMs0R7rLo1BLb19pkaVHDLvUMivpzUeni4X9ktiB1sz7Gh99k9Pfz1UW+1s9n
 QVTpkPnEO6506OT9DC27ZsVmcnSjZEqKnA4gLRNBYXKgHJv8U0vGx9cKDrxEUoI3hBbP/VFpJW9
 2b29R1hQmYCTtMLsXXxd4upHMDN70pSlO0WGg=
X-Received: by 2002:a05:6102:418e:b0:5ff:cb2c:a04d with SMTP id
 ada2fe7eead31-605a50982b1mr8825229137.17.1775743906337; 
 Thu, 09 Apr 2026 07:11:46 -0700 (PDT)
X-Received: by 2002:a05:6102:418e:b0:5ff:cb2c:a04d with SMTP id
 ada2fe7eead31-605a50982b1mr8825176137.17.1775743905774; 
 Thu, 09 Apr 2026 07:11:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd1fdd274sm55855971fa.14.2026.04.09.07.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:11:44 -0700 (PDT)
Date: Thu, 9 Apr 2026 17:11:41 +0300
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
Subject: Re: [PATCH v3 26/38] drm/msm/dp: add an API to initialize MST on
 sink side
Message-ID: <h6v7c5ily63uexzumctmtqgtgmmr4znv46s4hchagahj5h4rrz@g6basnvp5k5i>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-26-01faacfcdedd@oss.qualcomm.com>
 <4u5bt5y4suecanvxni2fnljdzrxnkjrg2dgkwzpj4pztvyoef3@nopu6m7w543n>
 <f08a3a89-4a02-44a8-a221-0d2d451d8536@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08a3a89-4a02-44a8-a221-0d2d451d8536@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=PMM/P/qC c=1 sm=1 tr=0 ts=69d7b3a3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=BmWwVh5GUV5RoyxtEogA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PYtl4REy6IMGlJkminhIaFvuj6jyGEqF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyOSBTYWx0ZWRfXz1IQNgBUqf36
 +7EOx+EGMcDHoBj6qlM9Ueoz6yk9GtNj2cOJTq9swpjviW6r3Gu9ueSwZ8qL6GdAQhI/A0V5hQe
 BWLqRwuPuWrWLorYZEFoNI8aguuTWhUdXugDyEMPqd4F0bkTk0yb+YBMncHlohfaFqjNWLxH9MH
 tFGlNYOfKmcjxPDBlDkNTNWg4dVKBAlTODA9P8cu9/hkK4my4ZHuU3WRPUihL5kMrrtV7P9q6tz
 S7dUI2irvfiSnYLLd18ZM3LDuYuhMRK/uf9utXtxuEx5IosQvNI8/AV88fqvxRXJEFnxWGiIQZ6
 4WuwPLwFD7n1ufLlkePHDEfhmjL+eDRyFIzde+C4aI6lBnJz/ZhIsDiYLfRIICj2onhEg8US7n4
 8VijaLaJqm/xHeGbc64nL7WuZ9N2AZa4R9dzlsvytUlJgRizXPBxT64CHyX+6g2CL/nuzpzT5Bq
 2lBA/uJruV7i3c29j8g==
X-Proofpoint-GUID: PYtl4REy6IMGlJkminhIaFvuj6jyGEqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090129
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

On Tue, Apr 07, 2026 at 12:19:49PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 5:26 PM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:12PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > If the DP controller is capable of supporting multiple streams
> > > then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> > > DPCD register to enable MST mode.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 55 ++++++++++++++++++++++++++++++-------
> > >   1 file changed, 45 insertions(+), 10 deletions(-)
> > > 
> > > @@ -315,18 +345,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	if (rc)
> > >   		goto end;
> > > -	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> > > -	drm_edid_connector_update(connector, drm_edid);
> > > +	if (!dp->mst_supported || !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
> > 
> > In several previous patches, the functions initializing MST can
> > return an error, leaving the user with half-initialized MST. Are those
> > errors a safety coding or do they have some real-use usecase? In the
> > latter case, it would be nice to keep SST wokring if enabling MST fails.
> > 
> After plug in, MST will active when mst_active == true (DP_MST_EN
> programming succeeded). Before that point, any return will continue to keep
> the system in SST mode.

Ack

> > > +		drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
> > > +		drm_edid_connector_update(connector, drm_edid);

-- 
With best wishes
Dmitry
