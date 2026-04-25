Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19209FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 12:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC3F10E1BC;
	Sat, 25 Apr 2026 12:08:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FK86YGn1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2Vd6pUu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23BD10E1BC
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:08:09 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63PBVeUk2342638
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jE1rlsOcAb8mtjkROW5TnXVB
 qCOL8sz1Ss/Eu8mtnWs=; b=FK86YGn1+rGVLm8Gbkdeuo6FcEXV/ht/9MGJlJKF
 PIew6jehBwcaSjKS6Je0KwgDvPK/4fGqE4I+C+g2spo6TrIlYbWmaYdR064zG3p3
 MGy5RJszKZqFCy5Ss6c5InetVCI8HhT1uaS5WjcydDuJo6BD3rxHy8nLL9XeoJ00
 SwCgTrrMOZH5O+Juaif77uB+HSrLWLsw85/1JGx1/umlhpGJ1/7EinWGsEh/VuYI
 oyna8DFkcdP6qlyQxEzSx0HKkeuQ5IV4YkrDyRtyM0icHnMzvmWPL8kDdbBYQHrR
 /dgpEulIj9BN8juMSHm4PSWRe93+LwunRYvE3rvdoxMY3g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr0v54-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 12:08:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9570d05becaso10411193241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777118888; x=1777723688;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jE1rlsOcAb8mtjkROW5TnXVBqCOL8sz1Ss/Eu8mtnWs=;
 b=H2Vd6pUu2ktUZ2G87OB6k84B/EPfNo4xuUp3C2UWN4xQdjW+HJeA6jYK1NV1C4iRMT
 5Y9yGMtXu1+M+p9Ej73u1bG+iZO0xrU0N1d5IP4TPsQXsje9DycpTyLN0C74rSP7IbjQ
 zN3zLTTCtCnpkrr8O9b7iS99aH0bqrjxg88ROQbU2VzoqrF8w30pZVK+8IQz6S/f9tG1
 2WdP8IoQm/HvofKLQHyociFbz0LqxhjxCAQm++U9EDrfwvm/FRBOnc2UWqHpTjasVn++
 5rmAyZgRowLUqnMo4vSGM3QUQ6pVam0/3drcIyhyOE6vZ1ZwuSSwoGcochFW6mt12Y6z
 vLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777118888; x=1777723688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jE1rlsOcAb8mtjkROW5TnXVBqCOL8sz1Ss/Eu8mtnWs=;
 b=ApRjvvL5w1rBm6DVd2gKc85somyufB1J7g+c86a9ibPe0sIvrIH7anE5F4uhkmkdzk
 S0LjUgvMPReOJ/WC3jE0P9lppB5rike4j//vZiYVvqB9RLbQwX+XxV9aIe7HYw2qfPh6
 eclfxnnvrbjGllSYRj0LogWOSFoO9A7D65t/gu7DkHaMbmsDoLu1wgiN1q/5h1WAsCgh
 fVspokTCbN/qSa4wOUQUB4IE7tj3+o14pP2vEkDqu0Gtcs60etJHRoBN6AvXPK/fSrlc
 0Ss+r6KABca3HEw/awqXWQBMtfZFxuoor4Zcx11fvW+f34wWUYUdGfjB3AM6kKSwpWMS
 BpvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ94FHNLCJA7YBjoTx2M+KfMShQf9DocIunKYaS/v+sQ9jMBZOYMlEemfedBiY/JIeccPinT1G0l+3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxm5+CDyxUn496TSPmTH+BT9HkqWCzKAgwtUshuJ2UZLJimROn
 gL0huSRFJQVtu8P1iJSISsSqVSwA5vIvTvzCr1XAcAO/5ZPAbb3Qu/O8xUTB2Wlh4jgvylnMKqW
 rYr2LhV8IOTXdwZbS0tWg70cYIwnyXqX7xW+bHVRDwh4qOEkzgAMRkEiUmfxbXnmLuc9EwRo=
X-Gm-Gg: AeBDieuHD6uzTepZEMUfhFSGAub0QC0PiRglmqtpgkMph/AH6zCcm2O3wGHRA1PLOm6
 4253S8lvaFRb0GXoCmd6JQ3okky1y5x9x6Bzw9nA45LqDqx847b+Hn8sWMDH6K7vPMBkO6+sJMG
 Hpd6xr+CdCvwgWPraT9hPfBBRh6iy8InnFeXXXwrUGuIlIqdp7OKSx9AByt2xrIcuCJN0/W6V2m
 0mFoV5YTVE2EKFoOic6DpJVNtgpQNhXYGhzQ2ANwircEqP1/2GmC7OVptD1AyEuv52kdTv8uZrW
 iZ+DLWBoPFvrseMA+tpvIj1r60KG0tffCx4p01jY8u3YJPa8JnWX7U3Y40WoAauLR819pbWMnUT
 POudYUO4vXNybU/2PTphMZ/IkrXimEiOpNTYTETXXR6AJjdxzC7Uu7LeZv84hNZqbVBEMzPdQ8a
 4wzET08FxUE9/TL90qbv2oPFosCSHtjrcAtip9zMxqLWZYvA==
X-Received: by 2002:a05:6102:6c9:b0:611:3bcb:aee5 with SMTP id
 ada2fe7eead31-616f142e949mr18800609137.0.1777118887710; 
 Sat, 25 Apr 2026 05:08:07 -0700 (PDT)
X-Received: by 2002:a05:6102:6c9:b0:611:3bcb:aee5 with SMTP id
 ada2fe7eead31-616f142e949mr18800598137.0.1777118887278; 
 Sat, 25 Apr 2026 05:08:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f66besm57897581fa.13.2026.04.25.05.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 05:08:06 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:08:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Val Packett <val@packett.cool>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panel: Add atomic versions of panel ops
Message-ID: <fjrm77kea7efb3xpxsqajrki7uzlhvbtwfyjvgnhznt5pisjfj@tfkmlodkjpw6>
References: <20260425001130.233935-1-val@packett.cool>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425001130.233935-1-val@packett.cool>
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69ecaea8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=9kKUQjWlHt89d_PKQGIA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: XT7C64LDO-qDb4oE6WnIFAETTSXXDlLq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEyMSBTYWx0ZWRfX/0HEPTITXBnK
 XCXG5fHpUhMx+iw10RqMFwSsTkf4hNgkTGcO89FwMcCOewAI9hlhRpjRBJNdGFTAvVFU/xn+n39
 X4LOBENksSxg0dAH+/Hmijlrr0FivMAS47DutIctOYWuJhagTHepjPgF2OKqobhniXA2dfs5aV3
 LUUTHwRBp2pL7fehuUUDYMUr/kx/xuB6Krtk0AFmECaOr3kJla0QBojaVVLtNJeK5NjaZX/kr1X
 NBMPfJ7vzLM0x58oRi/gv6NPBW6NOZgHGN8f1XsMENOz9gMB4BMDwRmSDLKHZvI7+MNl5tUPnBp
 t6kpxGDJJVdWa2nmRTV5I+UOz9ybERQnHWH7V6os9Lo7Bk/axP5quHB4k1RCO5MYsLVfwHcv7uC
 5YPoOmKf0GbFEU44Nc0HhgURgE3gcTxT4g1b0Op9boeKY8BjpPd1fkCi+w5uxO2n6SA18mCEPHu
 4uGN0jSIG+z07w9p5wQ==
X-Proofpoint-ORIG-GUID: XT7C64LDO-qDb4oE6WnIFAETTSXXDlLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250121
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

On Fri, Apr 24, 2026 at 08:49:50PM -0300, Val Packett wrote:
> Modern DSI panels support various modes (resolutions and refresh rates),
> which usually requires sending mode-specific DCS commands to configure the
> DDIC during operations like prepare(). However existing drm_panel_funcs
> only take the panel itself as an argument, so there's no way to access
> relevant state (such as the mode being set) inside of these functions.
> 
> To allow panel drivers access to the state, introduce new atomic_*
> versions of the prepare/enable/disable/unprepare ops, and make the
> corresponding drm_panel_* functions call them if available, falling back
> to the original ops otherwise. To avoid the need to modify all consumers
> at once, the original single-argument drm_panel_* functions are redefined
> as aliases to the new ones, passing NULLs for the new extra arguments.
> 
> The atomic ops pass the CRTC as well as the atomic state because getting
> the mode being set is part of per-CRTC state.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> 
> As discussed in my recent RFC [1] and an older thread I was pointed to
> there [2], the right way to expose the mode to panel drivers is to expose
> the entire atomic state and let them find the mode there. (Turns out,
> the drm_crtc must also be passed along with the state as it's necessary
> for drm_atomic_get_new_crtc_state).
> 
> Hopefully this first "real" attempt is close enough! :)
> 
> I have tested this with the WIP nt37701 driver from the linked RFC,
> only slightly updated to receive the new args and not directly the mode.
> 
> [1]: https://lore.kernel.org/all/20260412113851.355944-1-val@packett.cool/
> [2]: https://lore.kernel.org/dri-devel/nfc6ih43gjpi5u67fpkkxgwwygv53grdldq7tfp5iiukrkiy2u@53fsrtezzkyt/
> 
> Thanks,
> ~val
> 
> ---
>  drivers/gpu/drm/drm_panel.c |  88 +++++++++++++++--------
>  include/drm/drm_panel.h     | 137 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 193 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index d1e6598ea3bc..48fce5e89bca 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -102,16 +102,20 @@ void drm_panel_remove(struct drm_panel *panel)
>  EXPORT_SYMBOL(drm_panel_remove);
>  
>  /**
> - * drm_panel_prepare - power on a panel
> + * drm_panel_atomic_prepare - power on a panel
>   * @panel: DRM panel
> + * @crtc: the CRTC used to drive the panel, may be NULL

What does NULL mean here? How would panel's atomic helpers behave if
they receive NULL?

If you want to see a nicer way to migrate to atomic funcs, see
5ade071ba13e ("drm: Add atomic variants for bridge enable/disable").

So, you can't replace drm_panel_foo() with a stub calling
drm_atomic_panel_foo().

> + * @state: current atomic commit state, may be NULL
>   *
>   * Calling this function will enable power and deassert any reset signals to
>   * the panel. After this has completed it is possible to communicate with any
>   * integrated circuitry via a command bus. This function cannot fail (as it is
>   * called from the pre_enable call chain). There will always be a call to
> - * drm_panel_disable() afterwards.
> + * drm_panel_atomic_disable() afterwards.
>   */
> -void drm_panel_prepare(struct drm_panel *panel)
> +void drm_panel_atomic_prepare(struct drm_panel *panel,
> +			      struct drm_crtc *crtc,

Thinking about it... We can have several panels being driven by the same
CRTC. Likewise there can be a lot going on between the CRTC and the
panel. After looking at the code actually calling drm_panel functions,
the only thing that we can easily pass here is the encoder. But then,
there also might be bridges between encoder and the panel. Encoders
don't have state per se.

If the panel needs to identify something, it should be getting the
connector. It might be a more cumbersome, but it sounds like a more
logical option here.

Maxime suggested passing drm_connector_state here instead of the
complete state + connector. I don't have a strong preference here, but I
think that the latter might be slighly more idiomatic nowadays.


> +			      struct drm_atomic_state *state)
>  {
>  	struct drm_panel_follower *follower;
>  	int ret;

[...]

> @@ -330,11 +384,86 @@ void drm_panel_put(struct drm_panel *panel);
>  void drm_panel_add(struct drm_panel *panel);
>  void drm_panel_remove(struct drm_panel *panel);
>  
> -void drm_panel_prepare(struct drm_panel *panel);
> -void drm_panel_unprepare(struct drm_panel *panel);
> +void drm_panel_atomic_prepare(struct drm_panel *panel,
> +			      struct drm_crtc *crtc,
> +			      struct drm_atomic_state *state);
>  
> -void drm_panel_enable(struct drm_panel *panel);
> -void drm_panel_disable(struct drm_panel *panel);
> +/**
> + * drm_panel_prepare - power on a panel
> + * @panel: DRM panel
> + *
> + * Calling this function will enable power and deassert any reset signals to
> + * the panel. After this has completed it is possible to communicate with any
> + * integrated circuitry via a command bus. This function cannot fail (as it is
> + * called from the pre_enable call chain). There will always be a call to
> + * drm_panel_disable() afterwards.
> + *
> + * If atomic commit state is available, call drm_panel_atomic_prepare instead.
> + */
> +static inline void drm_panel_prepare(struct drm_panel *panel)
> +{
> +	drm_panel_atomic_prepare(panel, NULL, NULL);
> +}
> +
> +void drm_panel_atomic_unprepare(struct drm_panel *panel,
> +				struct drm_crtc *crtc,
> +				struct drm_atomic_state *state);
> +
> +/**
> + * drm_panel_unprepare - power off a panel
> + * @panel: DRM panel
> + *
> + * Calling this function will completely power off a panel (assert the panel's
> + * reset, turn off power supplies, ...). After this function has completed, it
> + * is usually no longer possible to communicate with the panel until another
> + * call to drm_panel_prepare().
> + *
> + * If atomic commit state is available, call drm_panel_atomic_unprepare instead.
> + */
> +static inline void drm_panel_unprepare(struct drm_panel *panel)
> +{
> +	drm_panel_atomic_unprepare(panel, NULL, NULL);
> +}
> +
> +void drm_panel_atomic_enable(struct drm_panel *panel,
> +			     struct drm_crtc *crtc,
> +			     struct drm_atomic_state *state);
> +
> +/**
> + * drm_panel_enable - enable a panel
> + * @panel: DRM panel
> + *
> + * Calling this function will cause the panel display drivers to be turned on
> + * and the backlight to be enabled. Content will be visible on screen after
> + * this call completes. This function cannot fail (as it is called from the
> + * enable call chain). There will always be a call to drm_panel_disable()
> + * afterwards.
> + *
> + * If atomic commit state is available, call drm_panel_atomic_enable instead.
> + */
> +static inline void drm_panel_enable(struct drm_panel *panel)
> +{
> +	drm_panel_atomic_enable(panel, NULL, NULL);
> +}
> +
> +void drm_panel_atomic_disable(struct drm_panel *panel,
> +			      struct drm_crtc *crtc,
> +			      struct drm_atomic_state *state);
> +
> +/**
> + * drm_panel_disable - disable a panel
> + * @panel: DRM panel
> + *
> + * This will typically turn off the panel's backlight or disable the display
> + * drivers. For smart panels it should still be possible to communicate with
> + * the integrated circuitry via any command bus after this call.
> + *
> + * If atomic commit state is available, call drm_panel_atomic_disable instead.
> + */
> +static inline void drm_panel_disable(struct drm_panel *panel)
> +{
> +	drm_panel_atomic_disable(panel, NULL, NULL);
> +}
>  
>  int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
>  
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
