Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801E9FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D600D10EB1A;
	Tue, 28 Apr 2026 11:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RM+Eq6m7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fpl9rGkM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BFB10E6D1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S7kWbg440715
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sQLZEedAb88z0FcldXX3/tkr
 8XsiZzoWRGMmS0yjlBs=; b=RM+Eq6m7LyVwq0YUZuHQ2FBEIgoNu2tiFFFHljeF
 KqsPixmYhdlCEE3aiHrjNx2kGP5ch/DO8HY3H5IQyLWd0COR3qpRiD2YkqdTOcFg
 EvZeThsp0jMwDgoua6sPpeKfStnhBlKOL0lBmmlZPjK+i/kKinLW046qFN8mfoKr
 dGGvDQKPVk5DbDEsBeKaX/apdXKjo131DgFSymWZeS0pEl6faCoPM8o3bFJzLdnE
 JmpB6ywQ6haJDg2YXthgkQBs0eQeLkNH5W6a10QvdZYhuamMZr1QHz0ivuqBfzsJ
 UObWZkjZPhKzuKWEoevovO33o7mZDZcK+C2mrQ0inajBgg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtac445u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:32:01 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-953b90636a7so15755415241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777375920; x=1777980720;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sQLZEedAb88z0FcldXX3/tkr8XsiZzoWRGMmS0yjlBs=;
 b=fpl9rGkMuV6XIy5/DocDyT5iqfYnNmmJ7H/M6vVmXr4epqgRruHtXilxvNr6TRM0UT
 rEdu/FU/D/zWaOKhKESmlENAFRSFD7FkhXI3OyFDoq4IjkPbsrFuC7Bhcmkh69+zQNvW
 5V9Hi56yo8vEEUnj5MXsYcmN8Dimnm8vGlQbawcnBbcbQCIQbkq/W6o5anwMw2YWIneq
 8wLOpaGeb3fImBuK507YTQ7Y3dBDDM7JbzOfhOXw8NiRYNhxY6byAD7Ud8CZPXs4TtcK
 6kiRDkYdgMctkx5TVlloI6bT52QE0TalFh8rNdba4P+miBawiYcAChGyq3HKsXxmTweF
 IyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375920; x=1777980720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQLZEedAb88z0FcldXX3/tkr8XsiZzoWRGMmS0yjlBs=;
 b=rccyNjRpz0ck2U5ngfFIykxnuN17qdkrV36uCaycaEkDrYAFK/zjcK+neCn6QwEGKv
 rdIU1pRviQELJ+a7XOKQudRplfZVm+ZFGA9MompyeekSzVObpzaoJD2kCKwdQluJIkrX
 MQIGD0zsDRfN3XxnXcoPRQKN8I+QDHk1pCVBPFYciyl0phOCu8eJQIWvm2T+CoMbjM87
 Lt5DYmFbEWg2PkMxuFWlmTww2V+eMg3KKjlbd8s+u5VxcxX6CgX7NhwPNgFdsAg1qBGf
 LVKviNhJhzwwgC+evRxQn82r8OywtWdBF206H92WdxTO89nzvwVpIezsHKHkjTSTk/pO
 7A+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jDEvVFuWUR6YSI0ecdWY8vNAHHH/7Ij90NwR4EetuuMqU5j+VyiKwiLGPBoy0o3MpSEeyJr+fyRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLcZbErRGtWgAoWpXOT9vfrEfbRem0htp2MW4O8gDu2MZDsAmp
 5BN2IyY1CZPjG72cbKn7n/uvl90W8KknW1bjF9bTROQgDcy0TqvC3i8HRqNizd8Fl8erBDVPaS2
 9e34shyf4wEUnlUzMiwCFDDerPYrB0ONdnAypGiJKxjjvO5eQvG9aZkS1ENPu5glo+fAcXAQ=
X-Gm-Gg: AeBDieutSGq77tyPQhn03hpqT4R20x+ryOVtH7ypcAN54pmLW/KD/GCGysa5w/MM8Q7
 dPXEd/xU3hJwu2+9As7uUoB6xf1YkLVN8J/iueFIJdlP3PrFgy2SSjRzsCeR4C4fk20W8V2jVa5
 ZgJock+rlPJjuzYzAScboF/hSVEiJalBhzAst+5nmW3J+NjCIXgLEn7CKY8p+8yVAM4CjXZ2cYB
 4KGhutvrJLuxtPQFi5Iu92Id0avhJbJ+6YCoXJdpt1XK5ZtcGQ5EcCKTfl0Jt8byMdzJ41LKTJu
 AKzjZ+zx0y1SG98CoHWB4oFxiexIDDhHYpFZyR2ZMrxs0LwD6ZomiCcU4bOGMcV2eP5HSrE0kIV
 1lBS82WfNodKLIjIJOxYMkTIzylOaIPoKTFxZsgj3WoDKEITcDzDNpsVO9f5RcMZrtWy/koVui8
 ijcsiQ3z30layMqEGDjyejggEk+mNXR6IeVWNkJZ/jAMzQjw==
X-Received: by 2002:a05:6102:d90:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-62808d611a0mr987297137.3.1777375920259; 
 Tue, 28 Apr 2026 04:32:00 -0700 (PDT)
X-Received: by 2002:a05:6102:d90:b0:604:f29d:84be with SMTP id
 ada2fe7eead31-62808d611a0mr987259137.3.1777375919640; 
 Tue, 28 Apr 2026 04:31:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f591370sm6515701fa.39.2026.04.28.04.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:31:58 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:31:56 +0300
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
Subject: Re: [PATCH v2 06/11] drm/bridge: lontium-lt9611uxc: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <55zrfwf7cy5p5qyyw4wpevbb6k5fgmyj3o7sg5ztc6iklvaa6n@6al7kqhpdvso>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-6-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-6-4300744a1c47@bootlin.com>
X-Proofpoint-GUID: QVSp3HA64-3ob96p1HDC2gIZ4T1X0XUV
X-Authority-Analysis: v=2.4 cv=D7J37PRj c=1 sm=1 tr=0 ts=69f09ab1 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=8NnIfHsthi2a-_wE1lAA:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: QVSp3HA64-3ob96p1HDC2gIZ4T1X0XUV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfXxyxCPFs/3GV3
 aPDkhXJgZxL2UsaJf9tS5OAYgLkV5rOHZvbYKfTC6XALCIajkUFc5GArEXiV8U1hYnNHind9zLR
 JSWMdqG3q8hOn5tfAiXwhCe5VGNNxu7Sh1CPqcHjxIbInr5f6oGN5qmlyhUFMaFJyV6DGkHwlYl
 M4JzqXEtcP2rQ+tnhseTEla2BHtF2c5p470mlc9B6zPLGxOH8ifgWuYuzYsnUrNgUvluERjyQkj
 zXo0XKuplkFTydQyViaX/xmlyHNy2ijwLHXKCUVQ/jgY6vWc1zebcdnfwyiPeAgq77abu/NoNmO
 3iXUtwWtw5dAH74gVH42es3HJgyvfIh5zmSFHRVono1XCh8eL2MNJcxnzI3N/5h9dCn1JJAATiz
 PEbnohqWJHyO1oFnVc+Z0tBR7NutCcGtWgpjrLqiRran500F+5/AKhQMFnz5wBSegdXrvyG91fM
 eRTMF3G9JWCz/4t7FAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0
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

On Tue, Apr 28, 2026 at 11:15:52AM +0200, Luca Ceresoli wrote:
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
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
