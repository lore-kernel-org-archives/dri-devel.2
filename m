Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA1BC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D0FE10EA30;
	Tue, 18 Aug 2026 08:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKKnwwrZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6Y5zk3m";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0F5110EA30
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:10:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I7jBgs1211964
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Lp9Uw1m65gTl1edjgkyrhzRm
 7kPQJ64tvUDBYNGbC0g=; b=QKKnwwrZ+8eXRtDsV0t1WCLVTqRMUcpVVym1xwNL
 uY16v1cJ5eDp3mddq3J4WAmLMqZRCJ7zmck+kAcMln2dHaD+ifY8qqM1Ljh5vsi/
 Fys7Jlg3+p28o93wOPX0dO3ECz0H/6VfkaeoVJyyJBBifFBKhvrZhDlQKldG+w/a
 3AQ1YIalo1Gqps79Qr6KPGcMvSkryc/Vf64UrFM0TafWG7INl6SGeyYJM/Mlr3rO
 6QWUQOpBW9U6++fbx3HBVjk+uDqtTLCV1zt+2PMUsgVXmX38Zm4NO2zE/Dm8JA9D
 0uFrYbGl61dIRVt047eWuPHZ0rZftAfbtd/uvfynhGJeqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4dcn1m4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:10:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-382befb9555so1231759a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787040602; x=1787645402;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lp9Uw1m65gTl1edjgkyrhzRm7kPQJ64tvUDBYNGbC0g=;
 b=i6Y5zk3mW3dT2+wEgl/AUgd+rGP6aJxizRr/1QkLem+qhoRilQDzii7dNcE2U39nD9
 R5mRLGYWjd4WdXH61tTrvok32qxv29px6T9LTj7/x589SAPzHHoG5HmINFop8JMAbxsE
 YqXdymt92umzN+XZpBp6XkW0wM67a8VDyyZt27JuJop/TH4rlBcq5XzWlQXdSk/tUqV8
 gGNypULfotqzr1ATufHnF6utD0gBuNqEdgY3Fq/LDFjTb0kXCL9dgC1EqbyilgykovJu
 eRWWwjPW4YuB8YxHjC5kIa669wU/9v1uDDZ/ymH1AuOfBCmWjE2TIj/aWV5ID9IJwF/v
 zm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040602; x=1787645402;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lp9Uw1m65gTl1edjgkyrhzRm7kPQJ64tvUDBYNGbC0g=;
 b=E9uUelwExQrz++SmWKvcw9wiFKDhCZW4ZIf5gyhorTyHAAWbM370psHQPJRkPH41ut
 9Epw2mHo+m3wN+udXuT2DKyQVegY/PpDf2dsi/7KUPYCO2/dM37d7/McTWqybWFSsuC2
 +7XPptMOfnN/KUfVlIhPCD9mfKCn9a8ppYgZk0OnnUQHLy/AmT/+CZl/8jqcD7kF4ZR8
 BXq/sU6K6k7y54GxezCFFTyztlmXBi1x8xZx4BIBrOd03DdjjNdDSBvfs45/XN3IXdu0
 HJFgJ3OsJdZm+aWFj6xM6/AGZOaYFsFFBpVHxC6l1bRc/e3xmWpQoCVMziHvhtK9h208
 tF7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJBxGsQ0QJrQea650ppyRjJO2eNdhpmaVPHO35I/KcAEe+QVaxT95TAY229PXdxJvTSlFAljuZicI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7mZ1/PrwMpRIDL3NF6/k9j7oyYylzXPQmKeuNjTR41lZcJ5Rc
 p9TPFsXKI1iovSLUSWmQ5hggqVOT6ZiOIwJyCmwFMHv9FsYYJRoJijESxrKIAvpHF7TJnnUy/SV
 79iNFXC8Ezf/CfUCbemtN8om4JCG36hxQGKRaAmRf3Da8Rm4PI2420XqabW6sVdnGp3+AzhE=
X-Gm-Gg: AR+sD11EMnWUnrkefiq/qYUGmKe0sxJnlNyodaevrMCLoOfJAM0x0wGvKCTiNitdCcw
 7OrFbW1RXz0d68nbyxumkxa0AdV4RrXPBnJnE82vX2xxOlC0WjoMkYC5cjSQYqCCE313SqfDP+W
 DwolohT39tR+bJ5aYRy3VabEzKHmvD25YesbEbJSguCAUaHbSCe5isjYCHqQbOauOnG3XP3d7or
 g7gP28LiU2cLPF+HFaBTaMT77I8jp+zLx+66KjVvDiKkVlmh+uyeZDmaa3wNLfMt2ItFoTZ+qPs
 6Xqb2ufYYvB1K9j8XF/U6G63Il9O/oK4tsx42OnS81Rc60CWJ0TsOlFoaN0hq0Phk3WAA8cYAN5
 Mf1EqtFAV/JvOzAeSs6f+NVYGn3x35biAlOgiYlBl1TX23aUQLKKDZTtfp+VnUbw92CSqVTVBFe
 HxPaWQIY/lFOxE6FEwWlNF
X-Received: by 2002:a17:90b:35c4:b0:38e:91a8:fb85 with SMTP id
 98e67ed59e1d1-3933b8c4c87mr23466460a91.3.1787040601656; 
 Tue, 18 Aug 2026 01:10:01 -0700 (PDT)
X-Received: by 2002:a17:90b:35c4:b0:38e:91a8:fb85 with SMTP id
 98e67ed59e1d1-3933b8c4c87mr23466407a91.3.1787040601105; 
 Tue, 18 Aug 2026 01:10:01 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39531ff5dadsm7514904a91.13.2026.08.18.01.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:10:00 -0700 (PDT)
Date: Tue, 18 Aug 2026 13:39:51 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Yi Zhang <zhanyi@qti.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
Subject: Re: [PATCH 0/7] Fixes for lt9211c
Message-ID: <aoQTT1x0bxDS9dxw@hu-vishsain-blr.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
 <20260806131715.508557-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806131715.508557-1-p.zabel@pengutronix.de>
X-Proofpoint-ORIG-GUID: QOtkoqc5i1o26fjd639mZ13ORvpqY-Ab
X-Authority-Analysis: v=2.4 cv=Gs5yPE1C c=1 sm=1 tr=0 ts=6a84135a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=SOQmYn6PRUrcGKOgvcAA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: QOtkoqc5i1o26fjd639mZ13ORvpqY-Ab
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1OSBTYWx0ZWRfXwr+vMIMPyPf7
 anfM6otreRrA+/lMEKnA2wmIHl5w9EcRzE+114EARlSHF16BpK1ADZkk+OpV5laXCz/EkGFV2Us
 kqRizlYW90+9v0TxE33m1acZkXuSjShoSRox8+VqB1uskV6IFRq+pL/zsqsQlD6eNT4y43n/EXx
 ztKbbUJoRTmGDKCDa1kfok3lfBd7NP18y8q0lHtT7mXV4XNl7iaHyeROgjyL8e8dzSonoVaP9ii
 F6f/fueRV8VssVDi7Wi+DTBoHW3vsJ97i8Q4qVMrgJJiqdK9A1ViKV0eVHOrNyPLJB+RR/1cJlm
 VvOzNxnmfC7uhGL6tORvOmxjE/xUBmEB4BNsZ3WYLqV4V9UCpZQBK5IhQERCIaKehdUQWuoJ+v0
 dbp/PR8cnB8DjLD0Lb9yaRyh5Y+Ugq0KUMOqOaYibNu2wyXkOvaczJBsncxvGFML7Q3e2XFCyii
 Rip2xeqESRYVrpF4tSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1OSBTYWx0ZWRfXwjikw9/sOD3f
 WnC8v1AlRMvusewx3h3pgUQ5G15ALcuNVct9d9fmaPcmeXoqEn1NrlkpmRT/H8bRaSeKVDIim66
 TzSM+4npcm1XC8TMDYJ3UBfvYsP/c7s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180059
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

On Thu, Aug 06, 2026 at 03:17:08PM +0200, Philipp Zabel wrote:
> With these fixes
> 
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> on RK3576 with a 1080p60 panel @ 148.5 MHz.
> 
> Feel free to squash any of these into v7.
Thank you for the fixes will use most of them in next revison.
> regards
> Philipp
> 
> Oleksij Rempel (1):
>   drm/bridge: lt9211: Enable DSI burst mode for LT9211C
This fix will be included in the next revision. 
> Philipp Zabel (6):
>   drm/bridge: lt9211: drop delayed work
This patch is not working autodetect failed to read format/width/height.
1. Tried ading more delay upto 5s before, autodetect did not help.
2. Tried adding a dummy drm_hook hw_timing_enabled, which is called after enabling the timing engine
with this synchronous approach is working.
In the next revision i will be keeping delayed work apprach with some improvements, by reducing the delay to minimum and wait in autect_rx for correct nonzero format/width/height. Let me know if this is ok, or if any alternative approach i should follow?

>   drm/bridge: lt9211: fix regmap_write error handling
This fix will be included in the next revision.
>   drm/bridge: lt9211: use regmap_write_bits
This fix will be included in the next revision.
>   drm/bridge: lt9211: reuse lt9211_configure_timing in
>     lt9211c_configure_timing
This fix will be included in the next revision.
>   drm/bridge: lt9211: combine equal branches
This fix will be included in the next revision.
>   drm/bridge: lt9211: use devm_drm_bridge_add and drop lt9211_remove
This fix will be included in the next revision.
>  drivers/gpu/drm/bridge/lontium-lt9211.c | 189 ++++++++----------------
>  1 file changed, 61 insertions(+), 128 deletions(-)
> 
> -- 
> 2.47.3
> 
