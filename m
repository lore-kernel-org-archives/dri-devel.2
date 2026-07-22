Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE45C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CE410EC59;
	Wed, 22 Jul 2026 06:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L83U3PKm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Paa0ZpjL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1D510EC59
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:46:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M54YOK3474861
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2pVGt7IjXnn3ZfLcIQiSgDsN
 CKR3N4V2SknmN7EXEzE=; b=L83U3PKmLvgX3hsJ3k4qNf22c+2q44xkiEt/+AnD
 slZZhTJTFgQLQh4aCPYmqMJNkzVY3eyScylLAwGjKBbLu/1Gc0OWJ1SaxFUE+BBi
 EzTcy1D4QQPaJY13tI8crOcOBk7vXciwb7Ozgd0WDqnEsJ3RrAeW9pvWgFnEY6et
 Yide1HfRCT6TkCdVgDXJlza1+qqSrZ3UWOgplAh4XrWzmZ9bOD8ipuxvn5MEwOHT
 iDY/uhl0g5VNX5Cl2XYt32gVBq/2XMYB5Sg54djjnS2pDRavRHVX5oKMHEjd6JWb
 SYy4GZMKHe1F4cghI4KP++YmyjSl23sbigJ/czg15Z7GkQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftnfn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:46:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso150861391cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702765; x=1785307565;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2pVGt7IjXnn3ZfLcIQiSgDsNCKR3N4V2SknmN7EXEzE=;
 b=Paa0ZpjL2X8pUVP0eDRyl5m/9fBpFT7Pr5PRVfyMBbDLKM3yGzYvnH+/seN6QYiRHK
 BMY1OKbTwe9njc3AR+dD7a5KU8jjfivsh5us9NbkKkbHEkrrDKSd9H5y0MuGe0uFuQpW
 i2sX2B8Y1rxK9icMmYrRg9ylR7olCrv99ioB2E7gLysvACvisBw7HRYPl7NA+Vz/23iR
 4Y1aulR8jyCl1B5+QeflBW21INlxpUKvQU+d2xnWg1g23+HITLOrVCRt+jfjUg2N+d5d
 woDaJ7/0hHSAsboUEu15Xt6nROhVXuG8LEKuRZdnP7Z09BOOYYrDJJPEzZ/Nim45Dere
 VU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702765; x=1785307565;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2pVGt7IjXnn3ZfLcIQiSgDsNCKR3N4V2SknmN7EXEzE=;
 b=MMYYaxmBBCgClvZG5QAuFiQe2lmbtxr8W6yo/+8wfjFenEbLaRqnKAqPF2Um6z/h1k
 kVB3Vh++Nq2mvWkybC3f62bnZWkq6heNagHulXh6GK6VxGeiC90VYNKPFY5UzWgeeXqU
 Wm5VnENRxg0ZJa0vj6xwcEMnF4DxjfnssXk0fXPmcNwxX6+h6hbBHLb7Hhgh3ojGn7yD
 GIIxoVbWvCfdwoOgh8nqFM+FE+IlbnHy2EEWCFkGkmPfsyur92ZH5TIpBdW3+FeXsQar
 xYe36XZBHLogG0UM6z1iQxmco/W14nzj9/SpCjTro1U2tPxp8tcUNjVg0VBvzYn11DRZ
 k0lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5LIxYFL1S77YaRp5kNvjBSoC6Q0TvhXITj3U4C/3a8jb0r0gGQA4p2ceeFN2tmwMhCvjJwLsLe5g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypPbyboZWXtTBvNfI2rllug2PpqH+gdHkUjZTJmRAAP0Qf7Xu7
 zL2dfzHFCYI78DMwAsMiYPKfD/aPUKJIWXcqIRVteihwp9rN1nRhRIsL7zwGuehm1OCoGMB0huC
 QEhISnLxwwZ7pGR15Pthp/YFZ6w3ZgCV1q90miLV0WKUibUx6Qb/EuKuAtG1/2BgWRac/IfQ=
X-Gm-Gg: AR+sD11U8e2jiwc4ivhILcfMn9cuTnO1ITxl2fAay8LjZuY8mbhFBfcVEatXljmFFsT
 KAN7AiNlG2EDUComGmWaTMMBZxw1M7W+j1dOF0myt3x7HcqSgcsYzs+Uqc8uTEc8G8ibCm77HaL
 0cQsyDUm5uOuZFqsRf7m32zvdvylMyjTTskgOMVw+uS6YhcyAF6qBBfRGKVlMAIz9eNW7aLKblZ
 UxOznnSDvMy6y3EkFlxQ5kjaDTyAvpl851uKQBO/VjRN3gPBWKHYT235hLc8yktFZFzuo2NImnG
 QIFb3LpFgmpRBcNFALfvCcMgHf1Tl6YoVbsHxbNOWLM1fYKdR6LdzwFn4aIjPL657ZlfGnI6D12
 fv7hnL9n0eu+W0jrwvvKIzpHBvSbZgkjK6qv1S7Sej8aZQAQFsqBVIxTwJB9lN1UL8qlfIjhB0j
 ebMRwjN4w99lBxmg==
X-Received: by 2002:ac8:5a12:0:b0:528:2c84:eab0 with SMTP id
 d75a77b69052e-5282c84fcbfmr8325141cf.33.1784702765213; 
 Tue, 21 Jul 2026 23:46:05 -0700 (PDT)
X-Received: by 2002:ac8:5a12:0:b0:528:2c84:eab0 with SMTP id
 d75a77b69052e-5282c84fcbfmr8324961cf.33.1784702764683; 
 Tue, 21 Jul 2026 23:46:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9f4a728sm295475e87.75.2026.07.21.23.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:46:02 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:46:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
Message-ID: <hbnni3gonklcmfmsgsup7lcusvnqcu5jivq7hhzrus2el5c55i@kvm75nfqyntf>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
 <i4tjtsf5rsckfcayo5nuhlger5wqxn3ujeaubm4g2fgrwvhzb2@hf4uhgq3ja5p>
 <ad75cf26-9437-47d0-864d-d71263401615@collabora.com>
 <20260707-illegal-tuna-of-force-1c06e3@houat>
 <737678ab-f082-4a0e-b453-f403ba141437@collabora.com>
 <80374deb-3246-413f-a043-66bcdb438ab1@collabora.com>
 <20260715-fair-opalescent-rhino-c6407b@houat>
 <45113534-94ad-4a0f-8014-c04e9ab67a26@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45113534-94ad-4a0f-8014-c04e9ab67a26@collabora.com>
X-Proofpoint-GUID: fIBvA-E_43WqEZKsoicHQQZ8GlfOydAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXxXmZXatfcE4Z
 cjxpVXend7BbObSr+88KtXdrC6+l34vHLWIeEFhmJmtgk7DI7LJq45Cu4Q1wZ4MYCexrrvgpVNB
 6aX5Tw3vGlzXQYBSkiT7xOlOuzckTfPmJ++IMvC8NhqzPgHbKX33w1TrLGKW9DfrSd7wuhUHUWW
 6JeiIfEZIqp5cd96t+0Fm0qFdAiYkMq0mkzcFT7qo1PHJJcvHfkzHPkZWvoNomyyIjoyMeC2XxA
 OcPy24UFEHJyz/AkIZuSUPJQaooMwFNJBnWOB169kjvHqO6r2lXDhQ9igEWoPDWnYmtXqKtbQsQ
 PX/Vzm333IPDY+cC405yOZvCGKROglGxvA5rnU9YljA6A/W+NYrUANDikmEhXAz43Q7iKyOJCfX
 cbnmd2kegj5bEIjxU/9JqBofh/7PyqSbUVAGGo07EBPWjvjFPMoiEX7Y+BZJO21vbD1AuZgat83
 PCA0u9Dvele3BenpE0Q==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a60672e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=zWnJzIVKQ1Due3HqBpYA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: fIBvA-E_43WqEZKsoicHQQZ8GlfOydAr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXw7Scmo88OQmi
 X9KB5/B+DVH4uzisIIFgZyXCCr/Hya6i/7CzuH57vKZDK53LbOn91uv/4Fc79RIRcqiU/QeTKHb
 Y6uibsLg2sRGMk2J6wpf8TNAr3dQF9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

On Wed, Jul 15, 2026 at 01:34:19PM +0300, Cristian Ciocaltea wrote:
> On 7/15/26 11:50 AM, Maxime Ripard wrote:
> > On Fri, Jul 10, 2026 at 01:27:37PM +0300, Cristian Ciocaltea wrote:
> >> On 7/8/26 1:11 PM, Cristian Ciocaltea wrote:
> >>> Hi Maxime,
> >>>
> >>> On 7/7/26 7:10 PM, Maxime Ripard wrote:
> >>>> On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
> >>>>> Hi Dmitry,
> >>>>>
> >>>>> Thanks for your quick review!
> >>>>>
> >>>>> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
> >>>>>> On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
> >>>>>>> In preparation for adding HDMI 2.x source capabilities, introduce struct
> >>>>>>> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
> >>>>>>> helper.
> >>>>>>>
> >>>>>>> The existing drmm_connector_hdmi_init() helper currently takes
> >>>>>>> individual capability arguments such as supported_formats and max_bpc.
> >>>>>>> Adding more HDMI-specific arguments to that function would not scale
> >>>>>>> well, so move those values into a dedicated capabilities structure and
> >>>>>>> implement the existing helper as a wrapper around the new caps-based
> >>>>>>> interface.
> >>>>>>
> >>>>>> I think, it was an intention of Maxime: make sure that every driver is
> >>>>>> forced to provide some values here. With the struct-based init it is
> >>>>>> easy to overlook or to ommit a value.
> >>>>>
> >>>>> Agreed that the struct-based init loses the compile-time guarantee that every
> >>>>> argument is explicitly provided - that's a real downside.  
> >>>>>
> >>>>> I'd argue it's recoverable, though: the init helper validates the mandatory
> >>>>> fields, so a driver that omits a required value gets rejected at init time
> >>>>> rather than silently misconfigured.  The "you must provide sane values" property
> >>>>> is expected to be preserved, just enforced at runtime instead of by the
> >>>>> compiler. 
> >>>>
> >>>> Yeah, I don't think we can win with C here. Rust might, but we're
> >>>> probably a long way from that.
> >>>>
> >>>>> The main motivation for the struct is scalability/maintainability as we add HDMI
> >>>>> 2.x capabilities: new fields go into the struct rather than growing the helper's
> >>>>> argument list, so existing callers don't need churny signature updates on every
> >>>>> extension.
> >>>>>
> >>>>> FWIW, in the previous revision we discussed addressing the concern with a
> >>>>> callback instead.  Sadly, I had to discard that approach, as it proved not
> >>>>> flexible enough, e.g. drm_bridge_connector_init() computes caps dynamically, and
> >>>>> would have required either stateful callbacks, or storing redundant/temporary
> >>>>> cap data in driver-private structures just to satisfy the callback.
> >>>>
> >>>> I just realized something reviewing your patch: we don't necessarily
> >>>> need an extra argument or a callback, we can just put these fields into
> >>>> drm_hdmi_connector_funcs directly, and then validate them in init.
> >>>
> >>> If I understand correctly, we should drop the drm_connector_hdmi_caps struct
> >>> introduced by this patch and move all its fields into drm_hdmi_connector_funcs.
> >>>
> >>> In that case, how should we proceed with drmm_connector_hdmi_init()? 
> >>
> >> Actually, this brings us to the callback issue: we cannot compute caps
> >> dynamically, as it only works with static data, since funcs is supposed to be
> >> immutable.
> > 
> > Does it? The core and helpers must consider it immutable but it doesn't
> > have to. drm_bridge_connector for example could totally allocate it and
> > dynamically create it based on the bridge capabilities.
> 
> If we take the VC4 case, is it fine to drop the const from the static
> drm_connector_hdmi_funcs to allow dynamically setting up supported_hdmi_ver and
> max_bpc in vc4_hdmi_connector_init()?
> 
> static struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs = {
> 	.tmds_char_rate_valid	 = vc4_hdmi_connector_clock_valid,
> 	...
> }
> 
> static int vc4_hdmi_connector_init() 
> {
> 	...
>     
> 	if (vc4_hdmi->variant->supports_hdr)
> 		vc4_hdmi_hdmi_connector_funcs.max_bpc = 12;
> 
> 	if (vc4_hdmi->variant->max_pixel_clock >= HDMI_2_0_TMDS_CHAR_RATE_MAX_HZ)
> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_2_0;
> 	else if (vc4_hdmi->variant->max_pixel_clock >= HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ)
> 		vc4_hdmi_hdmi_connector_funcs.supported_hdmi_ver = HDMI_VERSION_1_3;
> 	...
> }

I'm sorry for the late response, I was OoO. Why do we want to put data
into the funcs part? My suggestion would be to put the data into the
drm_connector_hdmi itself.


Setting connector->hdmi.supported_hdmi_ver = HDMI_VERSION_1_4; is more
idiomatic than passing it through the funcs.

> 
> >> Moreover, we would end up with some redundancy, as most of these input fields,
> >> after validation, would be stored (altered or not) directly in
> >> drm_connector/drm_connector_hdmi structs.
> > 
> > I mean, part of the conversion would obviously be to remove the
> > redundant fields.
> 
> Ack.

-- 
With best wishes
Dmitry
