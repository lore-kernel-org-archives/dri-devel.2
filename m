Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99572CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 16:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E851E10F1F7;
	Thu,  7 May 2026 16:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rdl4r/T5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eBnYbP2r";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9734110E29B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:30:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BxaMd2734190
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 16:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=BsZKRUYByxu4l1012X9BuJO08mB3a5+PDVH3rrgpa+o=; b=Rd
 l4r/T54zzKLtFWtx02KlaRHA9qZF1yUfdhzU+NuMwe6VW1/5jZZc76xlX1I1myVA
 GUYR+93AvmVW5Pxb+1fOdiC3JhCz6RokwhUeg6HSJZ917Z4tu1v/dFgwezjzNIPq
 SO+gu5QTIT6C66TfsNpBHzBWtyC3qaESGyJMxBnlk3bojwsBTJ2KDeUPouy9YEeA
 do9fDE5TEp/TyK1sA7NCAosMHzzp6+o9LAhKfqudrN0dWiAiG9o5JeOOaY1/PEgC
 vOYWar+0RuxSNFAiHuq2pLVbQZXmt9PNdXXQG4ME/kVmTA2XC4MdbbXsblj+x8W3
 1AKlD9dz2xrjmq/mdj/A==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqs5qn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 16:30:57 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-6949742b3ebso2203958eaf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778171456; cv=none;
 d=google.com; s=arc-20240605;
 b=AVpGH2RPgNQUesvmh+JwcnguRpjzx3Dq/hxBKs62t4PDBQIEGtc/y4NB7YoW9+0ETH
 gg5aZrowcl543yjZAT11dilT4AVo8c5T+Ap1RgfYdMn/kzwy/3vJ/k3EgaR1lLj3PHL9
 ab03rTOTJ/nol4Wk74pO4hEomLXSkUzGk56d7TiqPor5P+nCJwUxCwkxOJ8+NVncB2W9
 s846DRGo+bcuT1xAEn56Sg0Y4UGZDY6gH7+4cW3+TmGTkze5iIJ27gDNR3HTR0Nidsj9
 L1ZHSZj+Kiicb6ejdsur9j+mXhaaV3wuYMDnJ1FOow285NDI2oeDQwjMqjLOcFXO61Zx
 gKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=BsZKRUYByxu4l1012X9BuJO08mB3a5+PDVH3rrgpa+o=;
 fh=k5eKRQ19TrXMEAA42S41TT3DTnuY1S/1cEtn4qD/m3A=;
 b=h9mamxleURa85XW6XOpzgwDPEFPmTDkVY0NhA0FCsgKHouzOArvsjRMQMbmIXMOTW3
 Ad0LtnpJfz4b6ju9/Tan1eLmUOydAXecFiw2dZWekkad+NP7hOQV4i/PYK7Lv9/oNKpi
 9CfXVSTkg++DzIMnwGU54SmrP8uf4JC3LCZm3o4ifj3IlyN5TEvWB/2tpXIStzfIv6CS
 XnsHA64b3QxanaGfGEAjpBbHeK7cpmBJO3N+V++JC1OBqNLjhAhxomkFTUwHfYsa+ThM
 E5zxwZp9FVbPEQQhgT1WSS66wOp9KhurpX/iRYX0C4kG/1ZNi8vM6ur3jeAbRFloHYlJ
 LMRA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778171456; x=1778776256;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BsZKRUYByxu4l1012X9BuJO08mB3a5+PDVH3rrgpa+o=;
 b=eBnYbP2rSEX7uKD91Q6Hcc3l66xMljTbItAvHzA1ETwJn3k+MMT498XS/XXo326A44
 uOIcLF7l53JTgUBwce1Msk+PULKIb76GQ5Mi7nBH2ezp+r8rUn8mzi1N5b8/icTF0Sa4
 6y56e0GAXnlN43/Pew0QgiYB3PcY3OFSpXWICYLOrTNIpKE/aCaB2ErZQwXmGJV4RfOS
 uVX/qEbayF7RXvTf+X9NVcRv/xYKLC83vbPdD/nGnrTGNdqmrSDoF7kHZhe0WmCq+apu
 DMByjGBj8ILXIOYl80pNm6fd0HDoTBq5G8A+fPX/PDDhbYRr0I8ydRCdno7PB4GWXqxI
 c04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778171456; x=1778776256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BsZKRUYByxu4l1012X9BuJO08mB3a5+PDVH3rrgpa+o=;
 b=hKUKuVReyN1JLjstYIItlBztt8tJJVsV6Db2/WKXOjVAR+xMkjqpgkinCLuI2CVEtp
 kMxjHxfjJRa7YhTK97biQGxtBvQbL65B8NyX+ghPlotzLHyTBra/F0+2Q8jG2mw4W4dZ
 x0aoOve05V+emQjWfqhHZ6HllXMXLPm4+Ill8m95/W+JEmnIjKE4FwaTmMGCqpUvIHgx
 XRxTSz9FubYFgp3HUgMwjjgQkqTXNgW8LV9CfXhHAfSriBuHUNlPC3PBEWbC+OFmBdN4
 P7gUYdUOIBTlqdccl7jIvBiXr0zhYWnI58VK1z/H3vonLzfCX+ZlAgm9KVCz71NmN5de
 FU6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Sh06d9s8wamqjqX4LVyojxCffCIq8CYs0Ja9gSsuO1kXK9Cqt3gTzowT9O1H7sxa+Ykq7wKCuiLs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZpN68+7S2iVT6uMYRZh1cFURquviC6p+EJkLPqE5qk1YhDm6S
 FVwGXgJ2V0+NPfZl5yklYwNGija1kNpVDKKKKRSod9TcLBcQDCX9mNZIXoHQRqb91oW605bbdCc
 HviZHxBAcGAY0dZxSnKSF4CpG6YwNOi59p3uRyd6SsOU2CrZ1RfVWlIbB7KXt7b1NucVzP5ZEUD
 0+6AAHuGqAs98rXgDsF33i8BDVTgjN+BS2ZPxA1ImGxWXCYg==
X-Gm-Gg: AeBDievH+ZJ1SaeoE5ZXQoF+kblclqhCI6p0NQ20HSPwTR2yTPAZEYDqeYE8TulaYX6
 Ly1rbqQdjFw+kzu2iIN50kT2haNBuVXhCICC788uJzWT8jkugF8OEQQBICsz8KKRVmXeYOYnXGE
 u39VcMkHpNB5Qpdxvhr6KGy6LHnYNZIDPdLaCtrUznplwRKP9XYJkHBkUTX34G9ZsX7fpJuTLw8
 Q1UGslOXGcW0mb+ye2yoJmjqdrFCyGZ/YajdQ==
X-Received: by 2002:a05:6820:1610:b0:696:1a85:586b with SMTP id
 006d021491bc7-69998d103cemr5072084eaf.35.1778171456066; 
 Thu, 07 May 2026 09:30:56 -0700 (PDT)
X-Received: by 2002:a05:6820:1610:b0:696:1a85:586b with SMTP id
 006d021491bc7-69998d103cemr5072031eaf.35.1778171455539; Thu, 07 May 2026
 09:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-1-42567b7c7af2@oss.qualcomm.com>
 <CACSVV00TsXn=yx2UeGpxvCWRkSdj0=_=3_s01wCaO1RDH8t_vA@mail.gmail.com>
 <f6d9e805-328d-4d9c-8a40-32b47fcedd51@Igalia.com>
In-Reply-To: <f6d9e805-328d-4d9c-8a40-32b47fcedd51@Igalia.com>
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Thu, 7 May 2026 09:30:44 -0700
X-Gm-Features: AVHnY4ILuojm3YrKxuKRouawRWPTWPOauo6Ler8XHGih8TS8VtJV7DK7zmGptjA
Message-ID: <CACSVV00zgV02t0CGaDUJyTGBceBk7MFaOQ7Uc6ynpRkxdBwZhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] drm/msm/dpu: don't mix devm and drmm functions
To: John Harrison <John.Harrison@igalia.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: BRwPu6wKz38qn0ejPpwCpJ2UDyi5Cd6X
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fcbe41 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=V2sgnzSHAAAA:8 a=EUspDBNiAAAA:8
 a=IvufwBvwVn8Rb4eIr-0A:9 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22
 a=Z31ocT7rh6aUJxSkT1EX:22
X-Proofpoint-GUID: BRwPu6wKz38qn0ejPpwCpJ2UDyi5Cd6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2NiBTYWx0ZWRfX9OLxwrfxri1i
 VLCShwhUb/hqMhQWUr/JaKXRg/duKZCs5MCYStkyGaH4o5NAGbY9Me827aoIVD2Xy7WmEk8jj6A
 vJkb/pyH1oCKoZnJalkHTtxoeXIcsCLkxFMT3Q2wvgmRz9JgrObXDIZf1z90VxcQN+OqorVJAEw
 FzfPBR7V9P9p/hRUcSJl4+YKb+mWznFKJTFJkoiztj33HkRRfcInHOUHKy4XgAC5CEeGgqcrExG
 Cxo9071KLe3PCfbuwrFgES7Y8F695jVuwmE/UWnSTixrcr/MQKmFO0FqIag1vKF2Q58/XMp6TWL
 ztZhWsUTV53VIGEc8EmGSet3ayLAEHAPMb19SyXpGAnfB/SFI1w/nSUEIT0Ix9K43JWOcsGCxGC
 Gn6qpo7NnZACIRLV00aKWKf+ql2h9ywdPcPJbCXphIygHO/+hGLK0MsU1iO6LEg9q0MvLjhM3tl
 FfCl7D9zFRgNcDG7MEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070166
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, May 7, 2026 at 9:29=E2=80=AFAM John Harrison <John.Harrison@igalia.=
com> wrote:
>
> Resending because apparently it got sent as HTML and was rejected by the
> mailing lists...
>
> On 5/5/26 14:49, Rob Clark wrote:
> > On Mon, May 4, 2026 at 5:25=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >> Mixing devm and drmm functions will result in a use-after-free on msm
> >> driver teardown if userspace keeps a reference on the drm device:
> >> The WB connector data will be destroyed because of the use of
> >> devm_kzalloc()), while the usersoace still can try interacting with th=
e
> >> WB connector (which uses drmm_ functions).
> >>
> >> Change dpu_writeback_init() to use drmm_.
> >  From [1] it doesn't sound like userspace holding the drm device open
> > is the issue (if that were possible, it seems like it would go badly),
> > but rather the order of managed cleanup?
> >
> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3D3a13c2de442d6bfaef9c102cd109=
2e6cae22b753
> So is this not an actual issue that has been seen in the wild? It is
> just a theoretical issue based on code observation?
>
> If so, then maybe the comment should just be something like:
>
>     dpu_writeback_init() was mixing devm and drmm functions - allocating
>     using devm and then passing to drmm to manage. This creates the
>     potential for a use-after-free bug as drmm and devm have different
>     lifetimes. Fix that by consistently using drmm management.
>

I've not seen this issue myself, but I guess Dmitry has.  That comment
sounds more in-line with what I _think_ is happening..

BR,
-R

>
> John.
>
> >
> >> Fixes: 0b37ac63fc9d ("drm/msm/dpu: use drmm_writeback_connector_init()=
")
> >> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> Closes: https://lore.kernel.org/r/78c764b8-44cf-4db5-88e7-807a85954518=
@wanadoo.fr
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >> ---
> >>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/g=
pu/drm/msm/disp/dpu1/dpu_writeback.c
> >> index 7545c0293efb..6f2370c9dd98 100644
> >> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> >> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> >> @@ -5,6 +5,7 @@
> >>
> >>   #include <drm/drm_edid.h>
> >>   #include <drm/drm_framebuffer.h>
> >> +#include <drm/drm_managed.h>
> >>
> >>   #include "dpu_writeback.h"
> >>
> >> @@ -125,7 +126,7 @@ int dpu_writeback_init(struct drm_device *dev, str=
uct drm_encoder *enc,
> >>          struct dpu_wb_connector *dpu_wb_conn;
> >>          int rc =3D 0;
> >>
> >> -       dpu_wb_conn =3D devm_kzalloc(dev->dev, sizeof(*dpu_wb_conn), G=
FP_KERNEL);
> >> +       dpu_wb_conn =3D drmm_kzalloc(dev, sizeof(*dpu_wb_conn), GFP_KE=
RNEL);
> >>          if (!dpu_wb_conn)
> >>                  return -ENOMEM;
> >>
> >>
> >> --
> >> 2.47.3
> >>
>
