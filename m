Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE83AC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9E1310E4D0;
	Mon,  7 Sep 2026 13:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nH1jhzRb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZ9sNyuv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFB610E84B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:36:11 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687Amu6I3349019
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Nuvly24FDGwG7YRRA/F0rHJ3
 9EVW+7Vo3RK8fyPQ74U=; b=nH1jhzRbtI+Me0pUZo4bAJgTrabfxd4do6hTkdzn
 CNSg6oZ+w3dOACONJ5DLmhE51DKP2wUIjEhZNlHpm1NSCs+5J9UWQuun6gbwcNGC
 SMkjg3E9wSo02jH2lDjrPygg9IHsAjtO2aegPRXTqej/GG6ACyJOm2+jGLm+fu7N
 e513f2BElebzGgcJjS7T7MtvplFbO0lwUtvx1dgGx8lTmf79yfGd9lOFngpWz9ZF
 9sZBtbPwehxNQxBWDoFT9CF34x6kmDLRQrAUKw50RfyKztLG3dSswH5o7c7pkFr3
 cuP9ITJbDDhVeuHXQ7GnPJ451ERS7kkkYsOIR0ESsIdLKQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtfx0yxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:36:10 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78a686d205cso1552688137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788788169; x=1789392969;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nuvly24FDGwG7YRRA/F0rHJ39EVW+7Vo3RK8fyPQ74U=;
 b=cZ9sNyuvhSC6daA6Pz5WKCSgQiw8ughUK52b1lAt8FXffMYhgEJLzH7HnRp+tj40lw
 biosX8zeQy9I7KFK1ySExXgz8Tk2iuHBVKMNssa1k03XrCFrCWyg6EG02msLA8zL57qX
 OdvwTcs/fiZ5kx5H6Cd3PShQWtunR+zA+cLWR2xuycV/WpWoFHsSheghIn026nbqlbco
 eFtzEpl/0oLEBfzSzwFIu4ZjgwGYKXRFN+Fly5s2igt8523lldydS0UrPt2VOpzueFc5
 XL3a/fsz374gxhF/1mJqZuz2UCL/AAkOMIJSA4Lee1lH3X89LRcJOl2Y/XlexJc1Az9G
 u5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788169; x=1789392969;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nuvly24FDGwG7YRRA/F0rHJ39EVW+7Vo3RK8fyPQ74U=;
 b=SVWZgzChiTVlkPVq7HMomk+qm85J1AECCevWnq0WTA+iYSXbhUqBmFjFGjIwYFsafK
 c03Q7z5xrSZEOCFy5p8rSgrwmL6A7ALIrFE+/eCTVDoXF4FYVRVouLKwEG9OTReWMqDK
 JGFbPxBLPe2c23DHtUrdptblDlp/dnXdRYw52SxIDmGMgSUHoL+zy82oCmg5/jRJOR9o
 gChlAVVayV3OwMO/bqZJoxeYIoLmETUhgLR9iAy/1eLtjFNNixEMzYU5x9G/AcRZNVNV
 fCb4HXaWlaaCJC7XIYw6YKrFAa9b5+asf8ieLbdKpLo2CyHkwb1gi6OljnHZgW2OTmVE
 75Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBUwMfSD7ghwRCCCYUVg3V38XPQ7KJpe7qHGgMl521jyLMRp9LKDaZpL+Or1yNdZ4dfKuTFBQh6WE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kV32f8t5B5jLw7W51SYEif+GM8AUwR9PBVHGPMSARyZE7f/c/e
 qIQGcNV6zFc0rOyMfQCa3NsuSbJ2cgM5ryJ00y8y1r1NcgjRxWx8bswa+rvtJWYFG40Z4Cjxm9M
 EFt/yfQtqELMpVoI7h7j2POnd7KyhLL+8RzZ/T3PgIAuLCxUrQOLuGzPrxB/TBDt3FDH8qwc=
X-Gm-Gg: AYBFou3FKf09oEadIgOA6wHS15DyS2qny4HpxUvpFwnOTvM+61m6I5XTpp0JAHDgm7a
 W1xGqp3fc01R9mWCHvqMjIbWiheaR92W6hgkIXjLYduU+FifUwEBnRt0thTDWroaK+p72FXC+Cz
 LVyEqkg8h5k3K95rNYeFvd9/1U5UcQpiEysEZUtRxqu1eQIhxkAmghIN9T77l6WFJFMXEY7USBZ
 bwywH2sWRc0ipXZG4a51yVoWy8DlFdtjJ0hWim+YazyVzoDnsY10QrqLXOD93q66W9LgwPaTrfr
 4rg/Zf7BMw9vCEEAHCUAdbARFoHsqFcriKzLKnayLyaVmQyC7cmedTmhwFpM0N17XTpN7ITaQpJ
 7tnyagZYcq1xN
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id
 ada2fe7eead31-78a4a8b86c6mr9600150137.6.1788788169548; 
 Mon, 07 Sep 2026 06:36:09 -0700 (PDT)
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id
 ada2fe7eead31-78a4a8b86c6mr9600123137.6.1788788169077; 
 Mon, 07 Sep 2026 06:36:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be1c1sm28060777f8f.32.2026.09.07.06.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:36:07 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:36:05 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/7] drm/msm: Properly handle msm_ioremap() without name
Message-ID: <d256qsfz2rs5rdbfvmrxi5m5oitu4266ybhfx44gd7biuaykxm@tfhjzjxqh644>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-5-b097cf1eac77@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-5-b097cf1eac77@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Weg8rUhX c=1 sm=1 tr=0 ts=6a9ebdca cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=YrmjDuPctlhI2Ist5Y4A:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: VAfJL-VmcAgtlT5QTi_sPOOJ2wi-3crN
X-Proofpoint-ORIG-GUID: VAfJL-VmcAgtlT5QTi_sPOOJ2wi-3crN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE1MCBTYWx0ZWRfX1eXu4Dv+0iTO
 segqMOH1OKHAuB52Kg9954hKC2OzYqoMKKs7HcFhEnk8TVog5XpZRLqogS9XorVCULYI2hulnl1
 3ZNjYrlfXDyb9ePrfXxz7ngZCD+fH+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE1MCBTYWx0ZWRfXxqY7lB9XlBVc
 fdUUcyp78J0xi7Ex2vgJ0kWFnXlfTM3ZPPkXaTOjmV8dk7+cDjYoerashW1Ur/9eC9RFaOJOCo0
 UzkF6+8q1PCRjofK5iK0eDM2M59hf5aAHszuCWuQnMbPwJ1M37mxxo+lHRnvvk9B9krlY80YD1a
 st3y35rnhjQcq5QUbHwsy5SFNnpVJHpbRH3T1RuhB0SrH2X9VIKaJBqYO00kgtgWENmJaZ7hbjx
 8oCqASaGgOXziEDOLOAPSTdP9LoOtYrSVl8POY9o0qpxaHUBmPrGqcifj48xz5zCfK38dK3Huvd
 b7j1Zo8GhpklMKIp4wIwyABkvjjNB6xtUnJ0M8NUik1VT+VrlV9RkcSUteV4t0+Dbx9eD9YnitQ
 gDGhLsaK5MNNgYZk1SYcRZYVIA52WDscH2UAvvaGOOlWAiIk/K/rOGgNSn5KREyhobtxNsOUSzm
 zd861b+BvzYDikSh+4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070150
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

On 26-09-07 15:00:19, Krzysztof Kozlowski wrote:
> msm_ioremap() accepts being called without name of the region to map and
> in such case maps by index 0.  However error paths still use the name in
> error message.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
