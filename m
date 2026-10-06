Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8083CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087B910F1E0;
	Tue,  6 Oct 2026 06:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fS1kbC7d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YtkWhe67";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 363B110E29E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eDWS3269523
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OmidZS1P/7FLoMQ0OZhRCGR3Pz3LVuqOUkRF13HzzhU=; b=fS1kbC7dRzXWNave
 r0ZWbaKGtoGe2tVK0v7ljOcXNrRno/Sf5ZbBrnOm03LkUz9GBHjyZoT416th79GV
 2lF323f08PVkTKBULVQ8RJw1lVbpePXgVNyzaLko3JLKf7dY7KDxNZtA2dSfP75n
 21cNlzuy1q27FZ0q9vfXrFHEO6pvsBLLMXGJk3+yuVEsEEqbfFj6NtTbvszSxLGK
 Wq3MNLdAOzUTG/vCd8F3KUqt3Lhk9UJ1QWNtLd1+UTPbQOKaFpZzpQRJXFUa7nkG
 xsa1SM+zk58IHLxu0kf728LcFEgUggYxx+V4LnDkuemNgnFIYRwzJ3fdV13HT+na
 HRylPA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkujqyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:06 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5decf4b8cf8so642201e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269705; x=1791874505;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OmidZS1P/7FLoMQ0OZhRCGR3Pz3LVuqOUkRF13HzzhU=;
 b=YtkWhe67L63B6v/cGiBxAd6jfUO70pWYrJZQ9r3hJdQbvDXTgkkqU32WMX2l0ELx7g
 GKGGcC1exn9/Ak2sXezvnyGmxW5Jg4jYNjIsi18V/6BbaQq21nsaI1Erli9amD8oYkhJ
 xdCyVx5u7F20h/Q0NoMiP9q/xbGqg1EveCPMhc6eXXb/gX9I+9H2OaWMyGb3zimvlViy
 nXJbBGYRoB8c+tv7REgzixNeDQFXJ15mxHvZ6t80gZzFWooB3PKoRnsaUnmLvHL5AA8k
 eoKfJ46hvdnxvlMHO0arbrtAUB6oq1jJlbghZoUK6RMAtW3Uy5zqLHX9QNNvnlu2HA5d
 jvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269705; x=1791874505;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OmidZS1P/7FLoMQ0OZhRCGR3Pz3LVuqOUkRF13HzzhU=;
 b=fXdzUYstd2dL0QdeiZs4y+rcQujurOZuBJT/4crY7ZNPf783Jfnjq2cX/1NrK0oyz3
 I2A8pRXWykop2FCbcDadrHLxnhrMHmYWK7SHoTqcIppPR8Q4orfvEwAnkrqHx92YFTso
 0uwR7gyuaCh0lMOymBbB247qmbrMWw6uiIvIhVkNYZw8NCdJKrujOPxccBx0sPWpAmj2
 qYP7IqQpiamBYDGfZIa0QNaWlfMgzSHh+l9Q5+RfrtPZ2FMJkDYQCc5H3tCzeaAVi7d/
 NcFBmAmQFGAHA/dDnrK7CrCcolusXyycgFAFXsugltM5pw0uVdX9fXoZmkNASMAh+zln
 73Ug==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/GOMxmhtBozft+bwYumXbGIANQsTyzTUS0DqaJYzSWOX8LQT3w2N1QMoE2a28OfBMkunwRBvge6E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIFb+u8ganJ+WvKBo3TbCriAZOuVnlvViVE4l4qG6x8KXA5oCgc
 XUQUM/DWj+QO/3w3vYU25G2hBMqCyfUYR1qFalASv/LrVO94Jod3Vd+6+BfRtIenCo/FCBZwADq
 r0zQddQ5VRL4b74d9ildbZnzapw8YWw/oE9NXRlYyCoHCbH6VfXHhaKrzV3JvLjteot4hgo13G4
 qzqtdFsg==
X-Gm-Gg: AYBFou3wNhMAh05zqs+0Kwd6+WpYuPrys7RS/PGNJYvnS3EG7yTQuYFFLMS1Ff42U7o
 6Jp0036tYJMRRuKc3NKdWthnkSBe8CEQk/IP0Yb7VkRJPeTsnTObEu0VhLKCLPt6qzwDkakh+Sv
 x/k3Qs28bAJEu7mf/E0WWl229OJfM5K83IIezsBX2Lbl+uI+KBUwPuYavG+e5h4dmhUgAz3tee9
 glkoX3l+eIjJQFMoRR8/+YCqZkqXsSpGYsihCujqob7xgCJycOsptUx8RcDMW5+jpDesP5+5Moe
 LxlheSuMJ8qMsOKwvl2ge0PROXGJCQsur4YszfcC+g1nzNBr3BlkscirbzBQBewIfEt2Yvf0wJm
 B2+NyE3LyrmnaP67+T20c5JA0TnkHD2/KVPtNdyz/7071+oI3Nu1HUdg+TvNXOHLlmWOX4HXnAL
 Jw5NpQqp7mLObc
X-Received: by 2002:a05:6102:4493:b0:7c1:c1fa:f3e9 with SMTP id
 ada2fe7eead31-7c87c7eaa99mr64203137.22.1791269705431; 
 Mon, 05 Oct 2026 23:55:05 -0700 (PDT)
X-Received: by 2002:a05:6102:4493:b0:7c1:c1fa:f3e9 with SMTP id
 ada2fe7eead31-7c87c7eaa99mr64195137.22.1791269704876; 
 Mon, 05 Oct 2026 23:55:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: compute the CRTC bandwidth from the state
 being checked
Date: Tue,  6 Oct 2026 09:55:01 +0300
Message-ID: <179126968608.1110179.13039168143439761723.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002130656.50577-1-26rote@gmail.com>
References: <20261002130656.50577-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac49b4a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=Vzt_8YN6H3F5x3tZ7K8A:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: F8lr-iKIc85lXByIxtRYCY0wz9hV9tiu
X-Proofpoint-ORIG-GUID: F8lr-iKIc85lXByIxtRYCY0wz9hV9tiu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX0Vn9bxUhrSRg
 iNkEXyZCTz6sjuPP4fx167Jvjviv45+pRSKobJe9chXKZ+0dgdkSZFo21nbb5yg1IZDibwbdM9m
 0XMpmEx9UzJAYi+0eOW6/yTuI7H2XlM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX9nBZspkKGkNa
 4waLbgP1q7Ddvl1dITi1jK8mraGDLfWRHMBL8UPKDtZCkb6qCHXa0mnaYLMCn1VTa9553ZOh6n/
 hOFxQ9fyUIrhE1WnyHS9Q6TeJVoVf+b0n+gCyhu7WMsZnaE8ZX+5Z4tXOOySlNEnfpRFMl0Lhrq
 OUZhaXuvPBwp6bYN7X4lKDR5BzgjxqNTPFF4aSdYo48DSji6MsgmrHlDv/tEd6U2P3opdOXwVUJ
 PcVHqjqGvh3vS8ifW6dlZDCplp7P7nqiW5SZ5oi9GFtHQcoqHoqu2Zd/azvE2OfdDTNQ5m1ttBi
 QQ3zyf8kftFU0XZ1QVeMrdORXR6XQ4xRkGG3c/5R8ZEIW8yQtQxUB/nAvyZl4UKd2HQ1V8dR/F8
 usji99UXG6P5bP7ZySCt85aZg6n+ufhLMcGwRDm8xji1gdYPTbQtdj046KYZ7RkbNM9WjCZz2i8
 vhwScde0NTxqifyWyWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060027
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

On Fri, 02 Oct 2026 22:06:56 +0900, Joonhoe Kim wrote:
> _dpu_core_perf_calc_bw() is called with the new CRTC state but sums
> plane_fetch_bw over drm_atomic_crtc_for_each_plane(), i.e. the planes
> of the committed state. When the CRTC is re-enabled (DPMS on, system
> resume) the committed state has no planes attached, so the check
> computes bw_ctl = 0 and the display runs without an average bandwidth
> vote on the MDP path until some later commit changes a plane -- which
> may not happen for a long time on a static screen such as a lock
> screen.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: compute the CRTC bandwidth from the state being checked
      https://gitlab.freedesktop.org/lumag/msm/-/commit/480ba24aa340

Best regards,
-- 
With best wishes
Dmitry


