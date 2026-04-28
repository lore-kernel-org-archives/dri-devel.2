Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FFCFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D08310E6D1;
	Tue, 28 Apr 2026 11:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RXJFQtnv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/eBs8Lk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDF810E6D1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:35:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S9rixN2111945
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=A/g1pLI4mNZbrwEdtyTJyNTg
 han7Qo9/UMcQy/830Ak=; b=RXJFQtnv/KelaOTf9xlTgDrRl4vxTD1C+QjtKDFg
 t3bEVbncOvp+pztncf9CvywwaGXy4sp5Hulg3c3+k53tJtQsU7WYEszNKwYCnXKU
 fIJq/e8V0/QDWHWrTlXrxOkl1bNu2Q/LTkq3nGOQjNvBsgBxLvichCTM7x/MEi5E
 hDNS17pgcNpgIri0xLr42lAw/S0ElEkmr9Dug21BqA2Etdz58eiak8Bswjo3kZJR
 Zz3bX0O1Hv6T+jvMLtB8CttFWeQBxFQDsdX6v+XparIxt0wwUP3UBkS1dtBxXATP
 J0fkWPOcVBnHjOiPure7+lvXHRVIqBC8UP/x/ohT7cCwsA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbk9tq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:35:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d812c898cso298887171cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777376138; x=1777980938;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A/g1pLI4mNZbrwEdtyTJyNTghan7Qo9/UMcQy/830Ak=;
 b=P/eBs8LkLhtJyL83A9SpZvvyafjrO2v5TheXqoffmwjD5kerlgXwdV3EhvQf8Lc1hh
 2QXylUsvUe+U00aEPRAUueEIc5+xEcofk+IavR+Rs47v1CeRXlcHVlh3KYiRSu4f9RQJ
 fQT4IPFObJyKN3rRXB7+bMkwzPEty46auGvYz4huZCQ/9wQVjYXiiAcg+bDrg9+YcTJC
 s5mZATbJUcwXTUTvqns/NgMed4lVt6lgtohvcr3IccjvpW6rHk+mnrxdQtbUjHwqrO1p
 IlTFieb3+EQNfUGEwgHjWr3xxsYAM/hTw8Biv8c0hI3TWkdo5OluNpRhxwnothiCktXZ
 BKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376138; x=1777980938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/g1pLI4mNZbrwEdtyTJyNTghan7Qo9/UMcQy/830Ak=;
 b=nNSH9W6nsual4DDpDgGBOlD7qdIv+MNeV3LK295ljfTMzfyZuH4ZO+EWb8wsZt0pCd
 dQEV6HmH33HFFxADcQl9zDB2VjKemoFuGLpR4t0gcV/rVKV/gDYO+p9hCuZHEGr3plzq
 MgaQ6wJdvcgb7QtB+O1by8gqXjIBl7vEMvZnBxeXf6QfdIn5aEmEYU3EsvP0YcCh5sis
 lRvf+jYNhmvrFeKz2ZfZAUrriRlB8al+q1SJiAa/Z9RQ1w0cx4QLoBtkkwFKsAkU36kg
 TkpAGqq8GR2ZZFwbPhV2cCdFYA9wQ4w6TuGW/TTfvGSZ/khKIdrfytrP9RtPa1CZKQ7a
 nusg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SvBMXa/xTcWmF/fnvIO17Pz/xiqL5Guf1IX3P1kn/+S1xFyWQCVbbQagc0JAVxCzRtlUS9E8xQA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAnrS4JErluHEuaOwzxpJlUgOZOdbpWTaAmj8Ur5dycjA9/8/W
 h1dryNKzws58vMJmC8gRlxZl2ofe5iceu3/1n4km9gVgIS2bveaPY2Qh+K7Lrb6JcaE2cczTB9E
 F7K1hjO6KXkOiOOgvc7L5/YJ7s9KF7JgyvABf7qXgueSAAXrzLFc6DcW2Ex2gRH6T9lNs/f0=
X-Gm-Gg: AeBDiev5/3VbV3S3aoPP2c29mB79Vdi5vbFlP35fjFele3YciNzwWuQnfICX/dcIG1q
 IJ7Dp65Q2/6rvYl0eJVraGBdt4b4m3eC0kYCR4qMC9+dB3lihGyFvTW0OsB2loK4g64iRo9VKAy
 P9jOu3jZYwbsQ5mnMRzQGgbAau+BtGRpKTfxKE+Guff1Mf2ngDPSQgQCfs4nwTPwc+WZi0d6tzN
 vx83YPCXzABFzdWGN+waipmN9BKJVdaaSZVZk/dGsYlGm69gqFLnwqySKome37zYcTBGJF7DRll
 4V3ilGrLNeHYFJejHRWBwKC+EaTu8HcNpCGviMPc/S9OD9jfu5wLa39GhfCDrJ19oTWIlfvc3Qu
 4/0PPq9JLgpBA5a7VNDjOONZXt/jj3xRZ16PZQCO3pyRKmslZ4Su7spMP8TZdal41KepagwvNB0
 U7su+6cojrItamL+wWES6fEmBBTdXf7ezw7somRIMhR/8G3w==
X-Received: by 2002:ac8:7dc5:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-5100e1d08d6mr33550761cf.44.1777376137522; 
 Tue, 28 Apr 2026 04:35:37 -0700 (PDT)
X-Received: by 2002:ac8:7dc5:0:b0:50e:631c:c390 with SMTP id
 d75a77b69052e-5100e1d08d6mr33549631cf.44.1777376136857; 
 Tue, 28 Apr 2026 04:35:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462d8681sm552176e87.36.2026.04.28.04.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:35:35 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:35:34 +0300
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
Subject: Re: [PATCH v2 11/11] drm: of: forbid bridge-only calls to
 drm_of_find_panel_or_bridge()
Message-ID: <fjveutk74w2iwbzibrpeu3bwlikunkpfea3cv6majekjta7o5o@4tucid3myk4h>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-11-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-11-4300744a1c47@bootlin.com>
X-Proofpoint-GUID: sy8MgBG7qfkG3iDyFLWZ4iXvc8ifPK9B
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f09b8a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=ihHiGccrl-12bfV6lMsA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: sy8MgBG7qfkG3iDyFLWZ4iXvc8ifPK9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfX8BBBI8Hm54CC
 IjHFS2VxHfmAejGp11xvpJJT7yE447O08iaoWmzTeXLKs5fgNnaX87J0Oiw7KR1gMAy97YGPZ1c
 iP46fHpXa6TbXNXxidyBM1xddlnwBxllW4E/EkUgVyfggFge8zIPvanCMZNi2qtbTQNPXweCRLS
 WXBnz/YJ4o+jev9UUu0xmTXiXNyj2T+rTldOYKEMmNMkx/9wd2W5TooviihLEg9dvjjkZt8Xs1K
 egkeLO7ej123uolWQ6z063+iVMUDKHrV9oN7BP5O/Q8rVD4HBUFATJlbs3wGZZTBAjvmmYoM+7V
 2Bdq6JT5XSdSQScAr0Ie+D0wL0jeOqTAAWTVoN8tVtDYLKC375Olt3/cPaKL2NmtTClftH8XbWu
 ItEpaxJ72c0A0Ju3Gp3CG+toTF+rxA5YehNUGwh6q3PNineayVwuf6U1ioUrL2riSQWFeON/pkQ
 RbJa6RdB5wC453f5PaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
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

On Tue, Apr 28, 2026 at 11:15:57AM +0200, Luca Ceresoli wrote:
> Up to now drm_of_find_panel_or_bridge() can be called with a bridge pointer
> only, a panel pointer only, or both a bridge and a panel pointers. The
> logic to handle all the three cases is somewhat complex to read however.
> 
> Now all bridge-only callers have been converted to
> of_drm_get_bridge_by_endpoint(), which is simpler and handles bridge
> refcounting. So forbid new bridge-only users by mandating a non-NULL panel
> pointer in the docs and in the sanity checks along with a warning.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_of.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
