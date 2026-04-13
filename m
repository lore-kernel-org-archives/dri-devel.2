Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A07DF531C1
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 18:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE80B10E4F4;
	Mon, 13 Apr 2026 18:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Va4+DI7e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tsj2sTD6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A86A10E4F8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:12:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DEJORA3539434
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BedpZMXwITef0qZfNsBgP2xL
 4vUIvRtvUBOZ7w9v5dY=; b=Va4+DI7euOKah4rylJBA1blv7r7Nghgd2cfthrea
 nG2Pdd2quhvGidQKWbbgMcHefCljwVxtPhRksF2D4p5acalYsRuM72kHEkcQIQrA
 SzDDQvva4J0BdqhAjR9s2O9q34BGEGzsCBNg1p9CqPgoNH9wbBXROz6pxoEMLbug
 +3YXLjFAhUZ3lzlE+u5qTiASywuWb584EvNS8pVi5rRSGeh8amlF5r4El/N2+gWa
 RemAspNddcCBb6kLR+pKlpkVmHgeo/f57U9E39UAAZbliNBRMGGqIx9FJzg/8QJJ
 eAvbzdcK1B7XWhUb3tGKg5OIZGmW4o1w0rbfjT09kaqo5A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh258rtue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:12:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d8dac6233so85356211cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776103955; x=1776708755;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BedpZMXwITef0qZfNsBgP2xL4vUIvRtvUBOZ7w9v5dY=;
 b=Tsj2sTD6I/nGjZCI50oHr1gBRAcMGnik91Brad3FikTr3+35XkWbTXTiLd+tzur5KG
 96injhsVrNRZtlP61xRM1baXuE6YhoNwXDZVmjwj2ArlPqno59eFzalplARJ4Z0lL8sh
 qo+3Jw3YKnGLu/7ey2dqVQ+Hiv8bgOToRFfwEcGb533oStz+vEQIkA/C4Rc5donn85yB
 i98u+rVrqxu1mj3bePLDfmJGm6Txd6E0UCHZOVeko2HicWxY7O2b5a60FzBmSir8Y5H0
 JoX/qWdmhRa5xpc7OBC7n1yC3Tfe0Bug9PR/INEQ6AyMVruXsg1k2OE6Pk18BHG/fqSf
 6fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103955; x=1776708755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BedpZMXwITef0qZfNsBgP2xL4vUIvRtvUBOZ7w9v5dY=;
 b=bZp+Bv+JZfXtNjDxhty8VIkR1/Z21qiAtIlBMhRIf8m9BGdhv4Rs4WB9hoTZLWKAE9
 m6GB+25y6wYI8N5OPemV0yU5hbljAQzRSiI4XVcz0Jo+koF6iLICiIXpBUEGSUcpxzaH
 NQbQb95mT+UhbgsSaBheGawxqQky2r7VAt4RuIsFpvQZRKEVPigoFLihIYbZUEjr513n
 /1ZK+zrHGue2kP93JnnqrVcyOOqzIOHoQtT85xBArfz/3zrL+wTvu22ijLm+E3+Exlfd
 ySfQCyVw6H3s/64AcBTO3FmKTIOtTwYQxOKCI92Tb/0tdOPJ+dX9AJNqm+PZz3jMJd5W
 VqZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3x5W0BJ13yrJM5EohFYVpk8NdfuFSfQmwmSiLoobxGbD1z/iT4GToNNGqm4m1Ma3i5J2qCxGoVus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHdf2CXoUJfPdqeHNdY5gICPJvUAOWPShHBS/fg/nw9UIrCHvQ
 n1Pi1j0O7NLSwvKDuxZXWzU08fHLFRMl/4fXKQUOAUAiNOylpBc8jmiWm7NZX1SakB0607a0HKn
 18HiqLKjnJsmddCeQtEq+PawY71Y7SBzXrqbgfkb1NyDjcWv5qM0ThsSxUpqdNHXrE1CckoA=
X-Gm-Gg: AeBDievCJ2RqtGfREc3dIovuZmZV8XTtAJnqW41szv+YVzkaIVt6nKHEhYEQ9tu2fCI
 8b5j+uk6gXfQPv89qHf2lJZsqMYJxxymmewusNVyZxT0N4Ljxqw+l9V967szeULDB7fR6yr551J
 dkesN5mLfz+53yu7H8aVLGZZ0ljJfAvror/hvUr/vArAC4on7NuITfO4Glpm80OSClSNTLi/nBS
 ETlQJDmXVFS1owxj1lYO5qYHIeJDgX0o4j7H2GdJpp2NVlMSgWK3sRp4RjH6HRL8UpCy2XG4btX
 G2QR/+1xQn405HC38T7v4W/UkgLpu+pSKVsKlxCP+sHR7M2T3mcIiPl6P0u0MEM5OpEUQJ3kHAD
 td9A4tFTmlHXIA3graqxDCJqTmTAO9racXjgK/cQu/ieGu0skaflFx5EUgRwpUkab5a4qSUJO4N
 Da2SRGdKYLFXhOVjonNmSdfo+Pyg1rw/fi1I/dQwVJzd0gfg==
X-Received: by 2002:ac8:5a42:0:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-50dd5a97333mr233249481cf.6.1776103954573; 
 Mon, 13 Apr 2026 11:12:34 -0700 (PDT)
X-Received: by 2002:ac8:5a42:0:b0:50d:7384:a660 with SMTP id
 d75a77b69052e-50dd5a97333mr233248641cf.6.1776103953905; 
 Mon, 13 Apr 2026 11:12:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49541ddfsm28584361fa.27.2026.04.13.11.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 11:12:32 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:12:31 +0300
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
Subject: Re: [PATCH 05/10] drm/bridge: lontium-lt9611uxc: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <3wkifgya3irb6d7xwpjgd5pf5win7py6xqdrkgr2tzsgy22c6x@ajp7napy4f7o>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-5-acd01cd79a1f@bootlin.com>
 <rivgablnl6s7u54gyv77vr5pitlvvgzby7qnu4ryc4tttaqa7t@hztujmxw5njt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rivgablnl6s7u54gyv77vr5pitlvvgzby7qnu4ryc4tttaqa7t@hztujmxw5njt>
X-Proofpoint-GUID: 7umbNjE5JlOIqkbemiRFUWV06hnlNMj4
X-Authority-Analysis: v=2.4 cv=Vo4Txe2n c=1 sm=1 tr=0 ts=69dd3213 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ypQp8mP0imzWzDNcvG8A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7umbNjE5JlOIqkbemiRFUWV06hnlNMj4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3OSBTYWx0ZWRfX0K82O1B6uVFr
 3WdxD8O4Urqoi38K6E70MrEFOvgCcKHcChvVXgJcNjW/o5RtYMHYHJYaBSyL+43gaGu+bshSUsr
 kSnY5AbWLymjEYNwpDhxORai9MmPnZ6P1IILiBT9PA7nH9cxwv22Ew2N5AJJwb5/OXuBYADKImx
 y9DBPN/cFb3VXk0J4HP6na7vDwo1UuP94rRIio7EyJ9aQOKB0IUbSDWYiZqx60VvXbcMuur7ZfL
 KtPf19kAywADAGVPh62vsAZSqyABJmkrCmwOGzOUyo85HZ1f/VYX9BUysfJxRpn/ybqu5sJPT8b
 jgquYScj96KCajR9aY8LMEte3qQq/MwD+8umGJZ4vrTxNH8MWS2vumBUOol2l+/TU9iJdQ0XhXp
 uVO/c8/xBFuTtUpI6LG8YuRXRTC0WOhVRp9TfivaC1+csjy8sDSA8K04ukZqwB+Lsxf7LcYADDN
 GMfDqk17hW3DbCJ7Dmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130179
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

On Mon, Apr 13, 2026 at 09:01:34PM +0300, Dmitry Baryshkov wrote:
> On Mon, Apr 13, 2026 at 03:58:37PM +0200, Luca Ceresoli wrote:
> > This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> > @panel parameter, thus using a reduced feature set of that function.
> > Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> > 
> > Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> > returned bridge, ensure it is put on removal. To achieve this, instead of
> > adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> > pointer which is automatically put when the bridge is eventually freed.
> 
> What if the driver's _probe fails between increasing this refcount and
> actually registering the bridge? There are enough possible cases. I
> think this also applies to other patches in the series (BTW, including
> the msm/hdmi, which I ack'ed).

And after reading the code, I missed that it's handled as a part of
bridge_alloc / __drm_bridge_free(). Please ignore the comment.


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
