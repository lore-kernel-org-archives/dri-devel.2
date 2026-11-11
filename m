Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE5606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mBKp1ibT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KNSd3KsD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83BB10FCCF;
	Wed, 11 Nov 2026 16:58:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723D410FCCF
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:58:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABFPOQj014772
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iVL4AgBzRjfVaxiNh2wtau5x
 2llOdZbE8OF1pGpYIH8=; b=mBKp1ibT/8X0TXXehUE788rDJONH0PffKgI8OJoN
 LjpA0u/b2doe3unAvmlOxFkhN5D499Yt9/LQwSNudb6vGhvRb55PJwfWvCcFreNr
 RNfaNqGUGfcyb+judh1ANtRkhNdoKa6ZfvdN3aO8fT7/U6JOvlHE4XXoiGgfldD7
 rQQMp4tiSqPr7gwyW95A1fshqy4pTohfezwTVSu/IrvRQCVo7CA9UYXyCiCGkLMO
 2umEQcvFtC1DL8K9mSPkLAWfRfLvIzJwa+h4aZDP2OF64rUWs9vmG/Zz45VKOjW0
 Jk2cfLNaUtUZujvYNVANK3/OgHHewGl25jHT8OnDB4PYVQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymrd4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:58:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944101e6367so4834185a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794416309; x=1795021109;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iVL4AgBzRjfVaxiNh2wtau5x2llOdZbE8OF1pGpYIH8=;
 b=KNSd3KsDHoQgcfTUV3AJyvWampEacivW7Zi+muiXt0GbsuPFgXvuRwUt4eX5Fu9d2e
 GKJI7TYpQKq/fdDofkE52p0X7did6qbNfWnq+qblJfp4EuEfFKQJgMdFY8EAjDOeqMjl
 ZvKhacHduaYBQAT4sNTiLYVoygQ0zUspVlJSkvMi4KX9aFxR9jEHjFC236N3SimojU1t
 lmD9u6+O8E88WmnZWf3LbaI0MUq5oBvoixJqEbevpaUQAK7xrHSawJ6tKQvAbjJ1Lg1T
 miB7l8LrBEZME2TiBmck6gPW3QkhGJkcKV/BgxYHwRWHpByhc+mffLeCvZj5H4Tfcnu+
 Z54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794416309; x=1795021109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVL4AgBzRjfVaxiNh2wtau5x2llOdZbE8OF1pGpYIH8=;
 b=Tts+bOBBQYyMQXbsueeYYzSa/Lnjae68QptIeh56WWEM0WsJUHeFwL5A799apwTwNU
 DceC951WrM8g49DsiNfS18LsXscSHe5DLCZ2XhWv7ttWxtUs90gEXZk0iOLA2N/k1yPM
 96uuV8OmuH3rGmB6zor1irNKsaBYmU8Z5a2sptA61Y3JmcWyU6AsscDdGG6dMWij4P/e
 j64mPBpbBToohF7stgxC6ql0wbjAQlw7/ydlEo5lX6/nPblzZcJEmO+/J9/nMUuWcGUh
 7oC2i8kIuaditEsT8jYKFU4ujQzi8tUyvrh8lMnlQe3HQma6eAqB7dMjdBUELCEuPxdE
 EXYA==
X-Gm-Message-State: APuU4Z+zGfWHIs0xpweRsdmI5rMk6QGZi8zpVV/0S70pwLtnfrF5jNAF
 9KXFsj0mOuBf1e7FMNh8ankVLw2EyozKymWfB8BtZuSPoK7nBYjBsbk3P04dil6wnL70XzXW/VZ
 tuKEp8hDdrFzmOEwv/47mZnvxas4IWAwK6eaVziPivSQnlxxecywl0cLC+J8rzKf6brH3++E=
X-Gm-Gg: AYBFou1NKcoXfZHPgyHIIpMAaUNmOIKm1xXUhX9QWQVWLrTG7N+qzuDA2+Ihz0pzFtI
 Obk3qAkdhXD9+05w1D7R07LXIF+zPNkODwr3kSPzblBdNPCBmyIIbUiDmu1fiZXquGKbY4yrKMC
 0XUoRu2UxZ6qBMoh3CsyA9jCOQbdn+WF5np/5VV3fq3inThQhKjf/xIGnUCTkA2g9eyCj2n9l+i
 IAKYWV6OS08QXTOehjexK+OC6HF40amhHgUHgeG4v7ljP7ebnHmtc2Cb7SDb2HVIB3uY0JHcOen
 7XdZkFWguaZV2Mco7+Us4iemd3I49sn2mmE//rfbIQ5bBM/HNLgokxk8i3fxN1WDnoN4IhRleKn
 vIU52fkpQ8Ovd90xc60278/dQ5+pdQ1WGkRzGXQIRE2unE2wV7ROpFwnCTPkRzbYUkL2afvruKo
 sMIKjFk1gNzMRBQjIc0D1TWm3PTJ4gVI3B0BbloErUyKpvAmDXRTSUq3MoLIrzkg==
X-Received: by 2002:a05:620a:4556:b0:947:9133:661b with SMTP id
 af79cd13be357-9493301e750mr1788385a.11.1794416308529; 
 Wed, 11 Nov 2026 08:58:28 -0800 (PST)
X-Received: by 2002:a05:620a:4556:b0:947:9133:661b with SMTP id
 af79cd13be357-9493301e750mr1783385a.11.1794416308035; 
 Wed, 11 Nov 2026 08:58:28 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c160d60de3sm314560e87.49.2026.11.11.08.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:58:25 -0800 (PST)
Date: Wed, 11 Nov 2026 18:58:23 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] drm/msm/dpu: reject undersized gamma LUT blobs
Message-ID: <h346otfneexdgpndvmydknzuxuljywvflaoss3xppblp4k2svo@wcanozcwnysb>
References: <20261013020425.408928-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013020425.408928-1-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-GUID: TUlaxtw6Ke2ylr2vHVMai2-uVnabJpSL
X-Proofpoint-ORIG-GUID: TUlaxtw6Ke2ylr2vHVMai2-uVnabJpSL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX3kxamr87f9zI
 hapxLwsbnQlh/E+PYBwKJCtLBaYK+p1FE5pNHDvD7C7QvpP2k4wfdWuDte5XNvaC4svX+9oe3SF
 FnMD3x0LxvrlvlExOwHzhbQXnete9qasiUcNufRCNABAogOz/3C7nPpYQJksXNyCtgjWgOsCw0j
 IBHtJNRmZYn9B1lE+Q18mg5w01AkbrPEDeAGXG1nP/026ZB6uAQZKxIXvukYeRaRq9nhxibYfwn
 Vp0Hz0Mi6WE6mrIoBS5GmzvyfXidLtZF0ZuYyW7CThkrHzV0cR53owR60iTTXhlirTmfgV9yBLd
 PxTeCzFZlOjKZsekvfYbzWCHyC2fQdY5uU7y+eJcxgwDtcGW/gQ97xhOldbLSbClW5Npp+hrMAI
 LXqvLmpBBZS3z60/0Qw78ZltqKVjBTMlpi8+6Ywtp3bMFex6lOo98GA+GHa9WeqGe/9Kya76z1f
 EctEyqo3zgJoSFM0rwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX4MCFQEYjdlBw
 iqrYT1FMiXnuMAjXsbwyIeopP+pg1uuULwnVHSWJO07aAUU2TANSN9w1SmAY1bVid471cHVVxGW
 0aysI/4+Pqx//TVXU1ycaBW0Bqs+uQw=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af49eb5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=w7uqKdwnDGIzr5GqLesA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110067
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 13, 2026 at 10:04:25AM +0800, Qianhui Xu wrote:
> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> 
> _dpu_crtc_get_gc_lut() packs DPU_GAMMA_LUT_SIZE entries of the
> user-provided LUT unconditionally:
> 
> 	for (i = 0; i < PGC_TBL_LEN; i++) {
> 		val_even = drm_color_lut_extract(lut[i * 2].green, 10);
> 		...
> 
> The DRM core validates the blob against the maximum size and the element
> size (drm_property_replace_blob_from_id() with max_size and
> expected_elem_size), but not against the exact size, so a blob that is
> shorter than DPU_GAMMA_LUT_SIZE * sizeof(struct drm_color_lut) is accepted
> and the loop reads past the end of the blob.
> 
> Reject such blobs in dpu_crtc_atomic_check().  This is reachable from
> userspace on any DPU platform that exposes the GC block (SDM845, SM8650,
> SM8750, ...).
> 
> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
