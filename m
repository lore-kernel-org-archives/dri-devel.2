Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D11606A329
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H4/wx64k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEA0112602;
	Fri, 30 Oct 2026 01:40:42 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F114F10E67D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:40:36 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b4bd3d98bfso189732a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793324435; x=1793929235;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HmOxxSAaFjRQ16uV6mrLf8vylHogbNzAJ0HDl4YQB3g=;
 b=H4/wx64kEdlJ3ZUR8lxx5kB3AayDpCaIYjubMLbn2V3K08CI20AKI+AT3WCKuX7i/O
 No9VjUmSpuQ7byZqwyH1rEsuaJ8SxogEyasqZVZfYkLJXbfQnPZ/1aWsp/uap0spvWri
 5jJ3Y3IXbBn+6NehrAwjQNrMGruVPLyzDBRZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793324435; x=1793929235;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HmOxxSAaFjRQ16uV6mrLf8vylHogbNzAJ0HDl4YQB3g=;
 b=YBNJy9gEIrAkkjpL+InaHuNMOP9zkucWOIGJjyXxE/Yn4G65KCvY4gVK4Khy0yX/LK
 r9UscF3J8wajAkCQWxGd6IEszRG92nRQuDB6Zj+6u2dHTFl77xuQcMQauHg6RQi4hEFF
 edkkMEDc2vlEWx2Y8fE9l4F+iM/sWUpWLZ3SFgpovorLwf1Kvur0coBfgy6OeX4a4ILX
 ISWsqrBRD7DWfuObaxoOYApLrphxuOQbzYQ51mblkX6s2YfasWkzq+BNRb5iRXSsF18w
 ti20ul4DOuVZIFgeU8wMt7Co+wScYOIft7ba15tELp9/RrF4ytX7yxaCR/Ez+KOUy3rX
 YGKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl6kM1p5NQRNm+mdxSj2qwgDfOthze5W9Nst2jzLmLX+4pao1OOkaufJfy3p2NzQd4yGFaBmFL1Qk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6HjnDlVMHne/jHJaaFTb8kHgLkuqoCNb2x4mVmS3av86Xbs4x
 WmohcMUw73TiIElqfib0uJxcJTF6aBTZXrchdMCkKiGCj9KXLpN1YozntQyLFy8/JYd51nPWezY
 xwp/iOBBZ
X-Gm-Gg: AYBFou1woDjcctfzj8l0kNrDmkA5kTqHAFDhAgSLtJVWEkJz7J4mLZ8CuZS4Ae5A9/p
 XIEZn32CBKM8XdHIHtWPfni27aOmwKyDnoGaU/UajFFmm+YwHzP2t2Wg+v/lgOCR9Rqqs2pagkC
 OpKN1saaPx/ArPO40CJXz4XB2KIC3JFL1klxttME0DnX5NGNkBxJ/9g9JwF5TZ/azmwNrGsPjWu
 EOPFsDsFHnnSx9bF5LzwNg6Sxo0Auc67AcODC4b9MGV2ZnhXKqYAprtKIP5B3fMmacJi5aAubDk
 2TsPNQiVkJIISH7g2rxDgsmAKLPCUfMH8u7TxvzaTrjzKxYv8xt/w2crlA0eUdcechXyk7Ya4nP
 zkl27ctQ8iL1CBaMaQce2BSVjGbSDt5VVZ3LlNQVX/3l40gPrax9bkHnTz+s+50687BfhAnf2Bo
 6gBViKN/qbi1/YugLiRIwMfS+SN1tUcwUgENDjMyqeXbX9CcqBDJ/8ehjhHBED+Wqy9pdJeyidU
 yZN0ED+QOpMgMARzE0zgDH1hXffnoZoJZERImCO3l7M+8qicI1TUCQu/31dmSX91cO9yz5ARdN+
 esHgbAbD19ac3GzCnewrH3J1DcTL5o9vxDjKM5/5QUurtSWod5WVh8LZwbkuRNlAgHbd
X-Received: by 2002:a05:6402:90c:b0:6b4:16fb:b9b3 with SMTP id
 4fb4d7f45d1cf-6b4d5257535mr475970a12.29.1793324435145; 
 Thu, 29 Oct 2026 18:40:35 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com.
 [209.85.128.52]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4d7ae6ef5sm142023a12.8.2026.10.29.18.40.33
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 18:40:34 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so902685e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 18:40:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwkO7WENFijeYHKE7peyjHSt5F7ryetJM0l7oIJ+WLkUKbchtIN3aJWEQpNeu/RjQusgPus0rfPpSU=@lists.freedesktop.org
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4ac150b20famr15395995e9.3.1793324432913; Thu, 29 Oct 2026
 18:40:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-sp11-bl-upstream-1-v2-1-efc84396adf1@gmail.com>
In-Reply-To: <20261026-sp11-bl-upstream-1-v2-1-efc84396adf1@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 18:40:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2sZaobJMHCimqB5Kw0fZ_-7=9tHAxT-KrSP8uQiY-vw@mail.gmail.com>
X-Gm-Features: AclHuK-a_bsoEb-o0aETxELr_2WmGe4RidhWC24wa7LjtqTEfpGeuw0FK2upUAE
Message-ID: <CAD=FV=U2sZaobJMHCimqB5Kw0fZ_-7=9tHAxT-KrSP8uQiY-vw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel-edp: disable the backlight at probe
To: jimmie.lin@gmail.com, Neil Armstrong <neil.armstrong@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dale Whinham <daleyo@gmail.com>, 
 linux-arm-msm@vger.kernel.org, aarch64-laptops@lists.linaro.org
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 26, 2026 at 6:14=E2=80=AFPM Haipeng Lin via B4 Relay
<devnull+jimmie.lin.gmail.com@kernel.org> wrote:
>
> From: Haipeng Lin <jimmie.lin@gmail.com>
>
> pwm-backlight can preserve the enabled state left by firmware to
> support a seamless display handoff. However, panel-edp does not support
> such a handoff. When probing a generic eDP panel, it powers the panel
> on to read its EDID. If display pipeline binding takes longer than the
> runtime-PM autosuspend delay, the panel is then powered off while the
> backlight remains enabled.
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
> Disable the backlight at probe, after acquiring it and before enabling
> runtime PM. This clears the firmware's enabled state so the DRM panel
> core turns the backlight on after panel power and video are ready at
> the first modeset.
>
> This also turns off the firmware display at probe on systems where it
> previously remained lit until the first modeset.
>
> Verified on the Surface Pro 11 LCD by delaying display pipeline bind
> past the autosuspend timeout. BL_EN now drops at probe, before panel
> runtime autosuspend, and brightness control works at the first modeset.
>
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probe=
d by EDID")
> Link: https://github.com/dwhinham/archiso-aarch64-sp11/issues/41
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Assisted-by: LLM
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
> After the first modeset brightness is pinned near max brightness with
> a "collapsed" dimming range. sysfs brightness writes still reprogram
> the PMIC LPG. One bl_power off/on cycle at unchanged brightness
> restores the full range.
>
> - Patched v2: patch provides the same full brightness range on boot
> (stalled or not) as the v1 patch. BL_EN drops at panel-edp probe,
> ~1s before VDD cut, rises ~0.5s after panel power at the first modeset.
>
> Tracing and functional testing on the SP11 shows unchanged sequencing
> for fast boots (without artificial delay), DPMS off/on, and system
> suspend/resume.
>
> Panels with shared/always-on supplies and no panel enable GPIO
> may continue displaying the firmware framebuffer during the
> runtime suspend before first modeset. With this change panel-edp
> disables the backlight obtained through the backlight phandle at probe.
> The DRM panel core enables the backlight again at the first modeset.
> I have not tested this configuration.
>
> Testing on other panel-edp systems particularly with pwm-backlight,
> would be appreciated.
> ---
> Changes in v2:
> - Disables the backlight once at probe instead of
>   in panel_edp_suspend() following Doug Anderson's suggestion.
> - Only disable the backlight obtained through the backlight phandle.
>   The driver's AUX backlight setup is untouched.
> - Link to v1: https://lore.kernel.org/r/20261024-sp11-bl-upstream-1-v1-1-=
d39bfaf9afbc@gmail.com
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 94bc54c3833a..d019f4165674 100644
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
> @@ -918,6 +919,16 @@ static int panel_edp_probe(struct device *dev, const=
 struct panel_desc *desc,
>         if (err)
>                 return err;
>
> +       /*
> +        * Backlight drivers may preserve the state left by firmware,
> +        * but panel-edp does not support seamless handoff.
> +        * Runtime PM may power off the panel before the first modeset,
> +        * leaving the backlight on.
> +        * Disable it here so the DRM panel core enables it in the correc=
t
> +        * order at the first modeset.
> +        */
> +       backlight_disable(panel->base.backlight);

While still feeling a little ugly, I can't think of anything better to
do in this case. Thus I'd say:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'd prefer to get a second opinion from someone else in the DRM
community to make sure I'm not missing something, though. Neil,
Maxime, or Linus W maybe?
