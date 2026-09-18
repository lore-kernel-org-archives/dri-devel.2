Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5ABC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB6C10F438;
	Fri, 18 Sep 2026 17:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMMuEWXH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UlYYx+Pf";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAB110E963
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:05:41 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGoiGB1101622
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=; b=WMMuEWXHWJBv/taD
 f9QZUlE46GdUzuTjYYf/C3doWA0kR+Y5MgruXgzoDKrnaUUWblDlcnoq62X0pGZb
 /qbl9/Nh08g2JIywKdvQgqoIFODG95dmBYMwKhKE8pfH/9GV1s9uiIZ/ny0o1Ct9
 AxCx/8lN1sOSKnfJuvaS1JUg9GiNW/atd+A2FpRM9LBALe3ZTIKYfBJ7XUzkVsAm
 /0Sfv53h7nA91Txh3LNTG0XJ02vyxwLdjN4jnrj+2hSOYEPJdtabTGR3PdaWxCxi
 qwYwhp2WIMT4a5wkgjtCyWIgf1y9m/+GKe3lh+g7l4PT8AQ6cRmW8HyvIVAcaiX9
 oOwVlA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gry2btv2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:05:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so12720415ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789751139; x=1790355939;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=;
 b=UlYYx+PfQvjR7wEgnBUhDVwG60aCxDURHK7L+2d8EQOHa9ZbqEpo4eYN8p/6LOUppm
 LNigZRMltf5aXyUPmIsIqE1vDwrn/uJe09gg5Nx0MAL86c3FM5mSSTRPStLuYUj8FjIe
 1FIPpgkd43DfAs1ovYzeilHBWPliXQr2/5Ivv+PIzEC1CrxmJF4+dtoJFcu1RCuerIuO
 mjHWNvkzjvvLzpShWMICk9d+61tYjIn8ZTjrYDx4NF57Ul6Kp9emF6vnBrj7jYTEBttR
 lg1nd/ouRyQ0aoe88P/nJ+GQtOqW5qJ8bJmG3jR8nPd8Ovxk3zbnC6Y5dAtnfV03PCdP
 UDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789751139; x=1790355939;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=;
 b=m7GElqLRpd35bFunZ1OoYzw1uUW2+2tDqxkSk73dni9i3xJ/XkVfDGd2Cs/a/gdwlE
 W7MPr4Qp/EbqJXUuAWTA5rVrgbOACTZPP6rbrVy4lyL01aEC7qaJWu6ojijtMSeM84qd
 RNQh4W6gFOgFpzNSem+RGe4BJ65h9W+FB89TZfu5xfZGiwM9k7bqvzNv+hcvx4R3RyxM
 awUl6wOwRFCSpSwWhYPqa5x/F2GIT5zfaR4bZ00owKPF/D2yWUHntLki4Hr6QWyg+9+O
 tUzXOOF5/sqAdfo4oBulW2tRRYDFIB4QL7O5ucIZLg4BrDID79CbuYzFw9XYpMQ9fMTq
 okIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByCYLsdn9yCxbmfPWrN9D93ChV884P5d6L2eyvZIHRcmA/nm8g/2ZWTfEomWmd8CWK3fCN/kCPTLfY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7omHjMivdFF9ln3cc7/U94kRC3rNI+2bJ2aMtaCsE9cqtIfas
 lUKR7of4Bp7Iop62zgDZtmZNAe5M+3TYcnMzf9V5m/9Ak6wXGlZwv+HYOmdNmWpQxG9UV7f2D+s
 Dol+/OSPcS5xKCwcMVbbzWL8h8fq1mntHX4fj/vMnkV3pf64mWEABNZiZiLTTUWiNli5UN/8=
X-Gm-Gg: AYBFou20MryOl+Z/eKpmK5l7Q12boGAMi1BNOynoH4ITDo1x6nSlM08h5UxVvoLMziu
 be1H297wuX+tghlxU4juFBEWq5OMdOksc0IWMuRFItS2Qgx6xu9Sa5EacmVHQu4CN4SF7KtcesQ
 QOSjVvNXihL0jZxVaRPQZ0HUuzgVqo1bVcba7QKK1nKEUiuk1g4iMb+3nELz7oMUHoLy2C89T2A
 K7ZLvM8XzXrbHSqyE7rz4X7maQ2hKadr5VQSW+hdAXa0Yac4FaSrLJ6UuCTalSvXyDA52FTmOKk
 ZNajzmdi/czdgp8ssjKOsnRgejfxOkrpgz6Ch69uPDKm1BoFfhMdn4gGAET3ZycbRf6KaN6fbNm
 PmHBLfg==
X-Received: by 2002:a17:902:fc50:b0:2dd:c053:e0f6 with SMTP id
 d9443c01a7336-2ddc053e13emr7876735ad.37.1789751138508; 
 Fri, 18 Sep 2026 10:05:38 -0700 (PDT)
X-Received: by 2002:a17:902:fc50:b0:2dd:c053:e0f6 with SMTP id
 d9443c01a7336-2ddc053e13emr7876085ad.37.1789751137947; 
 Fri, 18 Sep 2026 10:05:37 -0700 (PDT)
Received: from localhost ([143.246.51.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75ae73csm11519845ad.57.2026.09.18.10.05.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 10:05:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 01:05:13 +0800
Message-Id: <DLILTJ12IX36.15ABZZEUMTL59@oss.qualcomm.com>
Cc: "Ze Huang" <ze.huang@oss.qualcomm.com>, "Alexey Brodkin"
 <abrodkin@synopsys.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Joel Stanley" <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
 "Hans de Goede" <hansg@kernel.org>, "Alex
 Lanzano" <lanzano.alex@gmail.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Marian Cichy" <m.cichy@pengutronix.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
 <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com>
 <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de> <aqpJKSSKunElnQ3o@houat>
In-Reply-To: <aqpJKSSKunElnQ3o@houat>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfXwv7NYX6aLzNC
 h/B1zEbHOik8c3jKpQZAV1a1YLwk5g0od0i8yiyoAltDo2CCd38RpU+AwDxn8e9iY+YQWD5+Ott
 n0BRDkgoZohDI+AiEbX+XjB2BXx4G+SMaZ9akvP3OHx+/qVzc5um4CaaU8u2HD6FE9pfUNl8P3y
 3o+xFOr8IoFl7nK2IAvQ0FUBLJeAd8j74Sy+cmlNCtx5T9vRYmusqoBZ1dtKyIRgPHUL+SRPHon
 h+oxqNwehUFhL6g7UK45NR5l/B00gKHgqrIvUo9RV0P2n2tO2yANygWIT1PnxiTaV8gmvFGuTJO
 qu0tgmbFUC0NHDNeDQmP0Yc6+Z8stNy2m54KpwLCwwrmVIFPSWfcIUO/zbCJ70tV9ESn65/zW1F
 jtCB7HOnEqXO31cHFcjo72HoKWlWg/32X0T/2Jnl+sIzZd/GZVrlN6uX0+Ejc9cZhOCJWZLXqC7
 8SaIiDxtCzIlobkF79w==
X-Proofpoint-GUID: keEbt3OIOcJhXZF3yuSmIYxX6QVzP4bF
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aad6f63 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=IqZAcGRvIuv5jEvzszIA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX98b+cFtAToWj
 yDoLCv7EXcIhEbvmmIODI39VhwJn6f1lvdDTt6ZsPeL4D6hFTlNiTSJlezBgzZ2qktRoPB0BLJZ
 w34aC2YW94LKeAOAhzQULpP1Dc5fA2s=
X-Proofpoint-ORIG-GUID: keEbt3OIOcJhXZF3yuSmIYxX6QVzP4bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180245
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

On Wed Sep 16, 2026 at 3:46 PM CST, Maxime Ripard wrote:
> On Wed, Sep 16, 2026 at 08:50:21AM +0200, Thomas Zimmermann wrote:
>> > +static const struct drm_plane_funcs imx_lcdc_plane_funcs =3D {
>> > +	.update_plane		=3D drm_atomic_helper_update_plane,
>> > +	.disable_plane		=3D drm_atomic_helper_disable_plane,
>> > +	.destroy		=3D drm_plane_cleanup,
>> > +	.reset			=3D drm_atomic_helper_plane_reset,
>
> Also, this needs to be drm_atomic_helper_plane_create_state
>
>> > +static const struct drm_crtc_funcs imx_lcdc_crtc_funcs =3D {
>> > +	.reset			=3D drm_atomic_helper_crtc_reset,
>
>  and drm_atomic_helper_crtc_create_state
>
> Maxime

Thanks for the reminder. Will do.

Ze
