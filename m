Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF02AC4451B
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 17:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58B110E366;
	Sat, 18 Jul 2026 17:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQzWVyoK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g609jgBO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A11C10E366
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:21:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IGP2dw1130178
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UVKN3gjb8JCRV0Htlzk37E2U2/BGELValmkZ+BpUkoU=; b=JQzWVyoKNWr7/CdY
 EoWdvERzkOkFAXj4c1oP11acOzt3Tvgnc0DpCsrvRrl4pmDfNHnSje1QFtIr/9zJ
 lPebJwrfblbFXQrVdhB9OFF+PWptxHR5X7gUIQEyXknpTjNWT70WE/euSOlK4j7b
 PocW4MDpW5lBki8/eAHI478nDsAD2gYCwSxvXmajuHG5zitmEvUVJZr9jN/Xetn2
 gp01fX2fADntQFzUdLFb46ccdC9SWYMJJpGQPXe2BGghYfcR1ZnT1d/4CxsE2O28
 jui1s1ALoT9EnYvM41/cfholOFvEUU4lf9w92gCKBraDAKYDQ5VdigOXhri/BLZl
 E2RvpA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04r2y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 17:21:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so3251673a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784395279; x=1785000079;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UVKN3gjb8JCRV0Htlzk37E2U2/BGELValmkZ+BpUkoU=;
 b=g609jgBOB5JMohN9G9OzDJ1vYUazlTEHNaYFmrJbsOc6OMGNgowM5oDxYxwX5klgm4
 WXdCPeneCN1RiM67cgp6x1tYEeteQN2U16OfRHl6PYi4u7kmTDDSJLD2swPgymdt7L2y
 9NSBN6j0k0lqhTu//My/5rXIlr7+6w6S4q+jo9pQgH3jnX2mQ+qk2Z4kQuOebT3iVZCv
 VPe3lK7H0CnhU1MfRRBdkXaGPxLbaNJeW5mh6bDCnp84dr5oxUpIz2OfgYJLvxTnSr5N
 da4zgHub199wTF6VOIiiAaK0onlFXhkjXoH8m4b2rSkx4uD98J4yplEixdzkjME86Mo9
 QrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784395279; x=1785000079;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UVKN3gjb8JCRV0Htlzk37E2U2/BGELValmkZ+BpUkoU=;
 b=TDCMwocV7MVGEyEswbF1Q38oK0m30utc7zCdcfY3oP2XO/MtGcLwrVmyLe4fwgrd3l
 1yIvd3opCN5HKALG0gle6zLzB2YagYXuviN1eMasOpVnBDj0WP4mAaCxaT6+FLkBowW3
 POrxN9vXzUYszuURDmuMKdaIxnFZKtBvzjq9W0k0oqY7ZOHdCuRrMA9gJBDp31GMVEuU
 ZvY2foOV+RdywtUkT0o7GseFTTSsiqACLVROH3vQEAMSnLgeQT8H2HI68ridz4Mow16v
 wL8kM4FxzJxlWn2+LLO0PoeRVQdNmiXhRArR9BKlVP0jCqrLBFM4U+SuU5fGpipAxliT
 0KZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFfdKFlwo6dcs0xvnk8Z/W3JFr0HsARvylY9ctRGSITl9YN0hyAR6lbqDDB6Ar13MiHGL+MtmO1nI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdCXFjanx6ZGqAQrNNp2oPBI1Fzz5EdNFax2vwYz4EFA9L7m/T
 eU8zLuB7Z5r8+uZfwH63m005mfIuOsYSarkoJ3IFx6OKsMRMZg4D0PvUO1gKKi3bIQ1CZyMgi0D
 afa5kCmDcCqrwMBCstZ5HG8FBXp1kU2Jzw3tSLZWuSKK04qg32D3WpR+XpfvmYcDkAT4tAqh8rG
 SgC8WVDdOY
X-Gm-Gg: AfdE7ck6RXsB4S8MEZyigQmyobVUvzLcuYpQG3sHIxrtlvle83ci3uPPLt9fTaMtv97
 mmsP5NLIEWeJOGKh4gWNyhRbXvE3LhlCuHHMNb5D+X9YU2M7A5Y9bZ96Hu/CFGHR34U8DIKd4z0
 3JwcTGDDK76C3p4PoMTTHQ3sCOoRa3AzYB+wv8+UwOrwxB+hIxCLMfBJZujxZWiXVVSMJ5Q0XTU
 e2UH/Lvtmj8VTXpp5VObwZ6jmidQCSDcbof3YrmniJWythy3LAIVriqpkkhwCO86xPxvkxfXuCF
 kXZJ6cy8Qry9ImCXRXt/mcS0mkCh7S7KpLEbxywFsnVbKi3JYszu1110HoLwTpdFObDIfP/5uZj
 L62vMnA==
X-Received: by 2002:a17:90b:3b44:b0:38e:1fba:fd79 with SMTP id
 98e67ed59e1d1-38e4b5753bamr7566344a91.36.1784395279407; 
 Sat, 18 Jul 2026 10:21:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3b44:b0:38e:1fba:fd79 with SMTP id
 98e67ed59e1d1-38e4b5753bamr7566304a91.36.1784395278949; 
 Sat, 18 Jul 2026 10:21:18 -0700 (PDT)
Received: from localhost ([188.253.117.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1bbda9sm18795128eec.19.2026.07.18.10.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 10:21:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Jul 2026 01:21:14 +0800
Message-Id: <DK1VC0BQUHEL.3R0D087PCM7KY@oss.qualcomm.com>
Cc: <Frank.Li@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <imx@lists.linux.dev>
Subject: Re: [PATCH v2 2/8] drm/aspeed: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: <sashiko-reviews@lists.linux.dev>, "Ze Huang" <ze.huang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-2-1133a8fc3785@oss.qualcomm.com>
 <20260716092750.933B81F00A3A@smtp.kernel.org>
In-Reply-To: <20260716092750.933B81F00A3A@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5bb610 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=6pLJlD1J5kOrFlOB4ZIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE4MSBTYWx0ZWRfX7LLSBaC8ia02
 VamMulOJH+6GHNloZaRHU2he7pA2MJOOPKsOVzhbSWVf02DmDhs5HuyzsUuIkKxn4BzIJXTGVvI
 6EOMK7SrxmsWDWehpjUr9tXjnhRu7EhiGX8qjAhEfsx8bFAeIJdqp5wiSnA8UMmLy3smNIYPfPK
 ym/QxBPBtoCugKP/mheBADZMKIzKTCq/o8HGnNxBsetMyGlDNgiFtayV+9uMTTR5e9QMGciRadd
 gSWzAgFxwQ2c7TRrRYes1tDuXOY6RGdmID9C50ZoOLNXa+RHxrIjY/DqoWt5JskQ1GG+yxxKtnq
 yT7qB8m0DffoUPdXlDaLRABspRyeWNZOTD2mCGnejPd0S6CjTkK8m+gyNyueiXy+eBAw8QWYH/N
 Tqg3sW4RTBY1SjBlimZb2RySz0g/3XShfDFqoYNJ8QvL0fNYBfwl9QrbJVo0sBr92f0+YEraZTc
 dAB6ir42b7ylGB51Ung==
X-Proofpoint-ORIG-GUID: VMyJVR5SQ74ob9d3QfKdFBYWDuxv7Yh4
X-Proofpoint-GUID: VMyJVR5SQ74ob9d3QfKdFBYWDuxv7Yh4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE4MSBTYWx0ZWRfX2Ff3aurkAm+I
 yFFk2F1b+klclJ5BZB+skC4RpS0/frwbmDCkGbkV4z01SWt9f/Wy6QtmRTKW6S09+FeHTEUXrRX
 Do7TInNk04fRUsWjMdB+osu0pVCaINo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180181
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

On Thu Jul 16, 2026 at 5:27 PM CST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Low] Missing `inline` keyword on `to_aspeed_gfx` in a header file.
>
> Pre-existing issues:
> - [Critical] Direct dereference of `obj->state` inside atomic helpers lea=
ds to potential use-after-free and NULL pointer dereferences.
> --
>
> --- Patch [2]: [PATCH v2 2/8] drm/aspeed: replace struct drm_simple_displ=
ay_pipe with regular atomic helpers ---
> (Note: The format of this report is altered to a free-form summary due to
> automated recitation restrictions. Code snippets are not quoted directly.=
)
>
> commit d1e92d6b727d3655d12a72430c723784264108f5
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
> Subject: drm/aspeed: replace struct drm_simple_display_pipe with regular =
atomic helpers
>
> This commit replaces the simple display pipe with explicit plane, CRTC, a=
nd
> encoder objects in the aspeed DRM driver. It moves callbacks to their
> respective atomic helpers and shifts page-flip event handling to the CRTC
> atomic flush path.
>
> Issue 1: Missing inline keyword
> File: drivers/gpu/drm/aspeed/aspeed_gfx.h
> Function: to_aspeed_gfx
>
> [Severity: Low]
> Does this function need the inline keyword? The to_aspeed_gfx function is
> defined as static in a header file without being marked inline. Could thi=
s
> cause duplicate unreferenced copies of the function to be emitted in ever=
y
> translation unit that includes the header, potentially leading to binary
> bloat or compiler warnings when compiled with -Werror?

Will do, here and other places in series

>
> Issue 2: Direct state dereference in atomic context
> File: drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> Functions: aspeed_gfx_set_pixel_fmt and aspeed_gfx_crtc_mode_set_nofb
>
> [Severity: Critical]
> This is a pre-existing issue, but is it safe to directly dereference the
> object state pointers here? In aspeed_gfx_set_pixel_fmt, the code directl=
y
> accesses priv->plane.state->fb->format->format. Similarly, in
> aspeed_gfx_crtc_mode_set_nofb, it directly accesses
> priv->crtc.state->adjusted_mode.
>
> Since this is accessed during atomic commits, if a second non-blocking
> commit disables the plane before the first commit reaches its atomic enab=
le
> execution, the plane state could be updated to a new state with a NULL
> framebuffer. When the first commit's worker eventually reads the state,
> could this lead to a NULL pointer dereference and a kernel crash? Would i=
t
> be safer to pass the specific plane and CRTC states down from the atomic
> helpers instead of reading them directly from the objects?

As noted in my reply to patch 5, I'll access the state with atomic helpers
instead.
