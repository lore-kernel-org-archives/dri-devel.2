Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BE606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=duOWRnJ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF6710EFF4;
	Mon, 26 Oct 2026 16:11:00 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143D710EFF4
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:10:55 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso1436394e87.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031053; x=1793635853;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LRYiObfFeB4WPOp5iFNMLIAZZFa6drRLpmas4AXgTgk=;
 b=duOWRnJ0TToMm4JEQbK9N3YPy5WG5zpUfSvU7E0OL2nlV2PoDdapnXKEsn9kBtuMU7
 JobBUwFV3Gw2/r7MgSHFURrMg8fJ/o707Me3PqVjowxsvnKWv4IKGJVPvUimAuUss+hu
 /8u7VUGOcJ6+np4u7CTqWR1qfLSCJ36A593Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031053; x=1793635853;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LRYiObfFeB4WPOp5iFNMLIAZZFa6drRLpmas4AXgTgk=;
 b=urrZsVFVmuRi/WmJ8HtCw/4Mq6wyJLqhEfB7LiqEYGntvnTksDTaFwohRj5UL5ihWs
 zjtqLFJcuV7/MS6xnKDnGIICgTmpOnkPgzNKttD1e9IS9PWKEuZEhpKeVhC+H/3lHC2a
 NwzoEeo/G0eA87Mw2JHasL6zIkoHIAZhZJYE/+lneff9zt/t9xwCRtx8jAM92SKyIX+u
 hhaPUS3dy5o9iCuKlRFBym8MiLOiUJ6iwBB9KnuwFuiprPQ/8ow6geZkcCk6a2+yWKd0
 L2mj/BBDtJ7jFC6V31izui+Ags3u8wGlCNOGVCV6fZ1JIzQIhJb9eTrxHK+PxfTnLnOF
 ht5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBznJs7puguoJ/NiszTZTsOb8xFz360iXuHb+bPJD617ef8syXIM2Ky/6he5aivM4xLe+QlSbsg9KJY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIiga2AunYXhBsuVIRuGa0AGDQnR8reyHSXHytsPT39oxySoTGP
 oaS6HZd/NWwWacutybr4U8YUDZ9pK45g7fyn5t5XPqWPFe//9Od49kyVvzLMe98hpS7cE2cSrtJ
 qgtDDww==
X-Gm-Gg: AYBFou1WGTshswQe5F/sd17Ky4aM91eIBfDaGoTP/gWAEa4LbA1rBHO6hIre5fdwMm1
 UjXOygMMaWAevZEit/Jo/NuF8LOcdH8DE9iPs1FXhmodwkostnDzxuV12Bj/iKKDbamHhhMfz7O
 7/haB2SmTV74Bdxi4nMmNs0wxRpGHXJryYNP18wVHZP5emFcc8eUcOesYB3nInRaDP5EhuZvDch
 fuzFJKDPzA+lVsSrXCTcwAUKA9fLGZACbnhON1Gabqb7tVHLPhNaQuqVZEl2RnvBgLxZKrzaJUJ
 KjB6gN2BAMPKpJV2w68DClPcGvI/x9GtTEE5F49otG+HlM8DukStAc55ZsNVs8iemdDfaiahW47
 arg94AE+gV3olqe4z57bYsXMvw3pbveKAFYmGQ0tJnhyjnf2+uKmFnQmGb/L0g6mXFyATkW7wgq
 WLvh3RP5HihP7Jcbas6d9igaq0PuMW+RT8kt278zcN/9p7ro4pmyYddL6GiHTTrCNthhfZSphfg
 qQo2aYeagogZ3+mEJnfJrkgUyjkxGrvGEgyYwu730hUBbAc02BVeHiGWcoXl3d8bNVxmJtPDTSR
 ZhPmalDB0cU+zD2neP2SBVo=
X-Received: by 2002:a05:6512:3984:b0:5b6:1a7c:59dc with SMTP id
 2adb3069b0e04-5bfb71e29b4mr2223837e87.54.1793031052930; 
 Mon, 26 Oct 2026 09:10:52 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a75a84sm1729949e87.35.2026.10.26.09.10.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 09:10:50 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3ab3b29a298so21982011fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:10:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBze4VuJqSyncRavyzrUdf+IAge1gKC49I+Avk1WKmKWXQ/PCrmouK1aeRr4F4gLMH9gfP9xzfSckd4=@lists.freedesktop.org
X-Received: by 2002:a05:651c:a32c:b0:3ab:690f:82ab with SMTP id
 38308e7fff4ca-3ac6fd6d952mr16112171fa.28.1793031047006; Mon, 26 Oct 2026
 09:10:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024-sp11-bl-upstream-1-v1-1-d39bfaf9afbc@gmail.com>
In-Reply-To: <20261024-sp11-bl-upstream-1-v1-1-d39bfaf9afbc@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Oct 2026 09:10:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+003jZ_LLQK6HEtuKs9Y39z=4=2SaN_=Y0uSXgVXFOA@mail.gmail.com>
X-Gm-Features: AclHuK8VJDZ71e8SV7IfzgVPRQ8znFYiO6UYRUmBFyp4fXJJtzRNheKbSl34Kx8
Message-ID: <CAD=FV=X+003jZ_LLQK6HEtuKs9Y39z=4=2SaN_=Y0uSXgVXFOA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: disable the backlight before powering off
 panel
To: jimmie.lin@gmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Linus Walleij <linusw@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dale Whinham <daleyo@gmail.com>, linux-arm-msm@vger.kernel.org, 
 aarch64-laptops@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Sat, Oct 24, 2026 at 5:24=E2=80=AFPM Haipeng Lin via B4 Relay
<devnull+jimmie.lin.gmail.com@kernel.org> wrote:
>
> From: Haipeng Lin <jimmie.lin@gmail.com>
>
> If the display pipeline takes longer than the runtime-PM autosuspend
> delay (1 s) to bind after the panel probes, panel-edp's runtime suspend
> powers the panel off while the backlight is still on: pwm-backlight
> inherits the enable state left by the firmware at probe and keeps the
> enable GPIO high. The panel supply is thus cut without first disabling
> the backlight, leaving BL_EN asserted across a panel power cycle.
>
> On the Surface Pro 11 LCD (LGD0779), leaving BL_EN high across this
> power cycle appears to leave the backlight controller in an incorrect
> state: brightness is pinned near maximum with a greatly reduced
> dimming range. Subsequent brightness changes update the PWM duty, but
> do not restore it to normal. Cycling the backlight off and on at
> unchanged brightness restores the full range.
>
> The first drm_panel_enable() does not recover from this because
> pwm-backlight still considers itself enabled and leaves BL_EN high.
>
> Disable the attached backlight in panel_edp_suspend() before marking
> AUX unpowered and cutting panel power. This ensures that the first
> modeset enables the backlight after panel power and video are ready.
> When DRM has already disabled the backlight, it remains off.
>
> Verified on the Surface Pro 11 LCD by delaying display pipeline bind
> past the autosuspend timeout. BL_EN now drops before panel power is
> cut, and brightness control works at the first modeset.
>
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probe=
d by EDID")
> Link: https://github.com/dwhinham/archiso-aarch64-sp11/issues/41
> Assisted-by: claude-fable:5
> Signed-off-by: Haipeng Lin <jimmie.lin@gmail.com>
> ---
> Can reproduce on an installed system on Surface Pro 11 LCD (X1P-64-100,
> LGD0779 LCD) by booting with modprobe.blacklist=3Dphy_qcom_qmp_combo then
> loading that module manually after ~20s. This delays DPU component bind
> past the panel's runtime autosuspend timeout.
>
> A/B tested against the same v7.2 tree:
>
> - Unpatched: panel VDD off 3.5s..20.5s while BL_EN stays high.
> after the first modeset brightness is pinned near max brightness with
> a "collapsed" dimming range. sysfs brightness writes still reprogram
> the PMIC LPG. One bl_power off/on cycle at unchanged brightness
> restores the full range.
>
> - Patched: BL_EN drops ~300us before the VDD cut and rises again after
> panel power+link at the first modeset. full brightness range works.
>
> Tracing and functional testing on the SP11 shows unchanged sequencing
> for fast boots, DPMS off/on, and system suspend/resume.
>
> Two cases would benefit from testing on other hardware:
> 1. AUX-controlled backlights
> The disable is placed before drm_dp_dpcd_set_powered(false) and
> regulator_disable() so the panel remains accessible if disabling its
> backlight requires AUX writes. But I have not tested this since my
> LCD is GPIO/PWM based.
>
> 2. Panels with shared/always-on supplies and no panel enable GPIO
> These panels may continue displaying the firmware framebuffer during
> the pre-first-modeset runtime suspend. This change will turn off their
> attached backlight during that interval, potentially making the boot
> display go dark earlier. This matches the driver's powered-off state,
> but I have not tested that configuration.
>
> Testing on other panel-edp systems particularly with pwm-backlight,
> would be appreciated.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 94bc54c3833a..87f9c13380be 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -21,6 +21,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>
> +#include <linux/backlight.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -413,6 +414,18 @@ static int panel_edp_suspend(struct device *dev)
>  {
>         struct panel_edp *p =3D dev_get_drvdata(dev);
>
> +       /*
> +        * eDP panel power sequencing requires the backlight to be off
> +        * whenever the panel is powered off. Before the first modeset th=
e
> +        * backlight driver may still hold the enable state inherited fro=
m
> +        * the firmware, and some panels' backlight controllers come up i=
n a
> +        * wrong dimming mode if their enable line stays high across a pa=
nel
> +        * power cycle. Sync the backlight off here so that the backlight
> +        * enable from drm_panel_enable() performs a true power-on in the
> +        * correct order.
> +        */
> +       backlight_disable(p->base.backlight);

The above doesn't look right to me. In general, the backlight should
be owned by the core DRM panel code. Jamming this in here looks like a
hack. We'll also be double-disabling the backlight in most cases since
the core drm_panel code will be disabling it _and_ we'll be disabling
it.

I guess the problem here is that the PWM backlight code tries to
preserve the backlight to handle panel drivers that support a seamless
handoff from the bootloader to the kernel. Since some panel drivers
handle that and others (like panel-edp) don't, it's hard for the core
to magically do the right thing.

I think the right answer is to disable the backlight at probe time for
panel-edp. This is a one-time thing and just to handle the bootloader
handoff, so having the workaround run once at bootup is better.

-Doug
