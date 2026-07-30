Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAE8C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8657710EE46;
	Thu, 30 Jul 2026 08:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zJ7tE98G";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B9910EE45
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:43:58 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-6689f36ae56so2249921d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:43:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785401038; cv=none;
 d=google.com; s=arc-20260327;
 b=So/mtvXhNpC3lZlOCZSHhdCINrzLtA3Z4Pypc53iN7j4fp635MjyrptE8fMz99bwt0
 FYIyLUe7B7zjZRqwPPqMYYWc1zJ2mMTsj92ZWQfHFXLfxaIHX3bMV0N1hQUOhYqYlTE3
 WH7gZ7xLbOxRTZZvFl4bY/eVQ0nusfnAJeORQl1+Mo6V+Ow4qzVaZO4OQwfpLPqJOBHY
 JMAFnL4fmOSE9YOSdKWUFXqecp2q6y7vI82e+6Dd5HmJhQH6AKdeG0VqnGqCPkSqslND
 UO29TW6u+jEcKeoyXR0TX7WjlY+x2x23dnrywBvF45R6I8u/rIaxteRa8uukWhuBxb+O
 hqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yaKFxfR0fzpkcksdwy+w8qcnKI4eQ3ef3ipK09UpHVA=;
 fh=Bvh/Tk66eirg+aZPWOHfomzV9JcXDPStWGZ7E+u1AiU=;
 b=YV+5JNGi2dE+DVGKshOSjeMsW8gBeASz3nU6LD1jqr0XFrWyqMVP9ZESFxAa5KOmRg
 jj4UnGjbh1531AKSaN7qy6Y7Tr/DjAOY0Zb1VLsw1hC4fwGrPkWb8D/Ff7v3otPX+1aN
 6LvNHHa2a1Oh8DnAxrA1hUUFawtObtojjdnSKtyLuRZXaTGkmFSN4LTnQ4qIxf52m/k8
 nk0xDKrEGFcCsbFhEp22y0m6fcLSkRaNaCxFSUx/FQrWn2t0KsFVCNYkb8/3uN2WxmJG
 ETpx4gr1hnjuBQ1vMkdWdDnPhSz8wSHZnKsgMikMmVrDwvlVi0tObk57u2WnP/q7tcFb
 F/7w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785401038; x=1786005838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yaKFxfR0fzpkcksdwy+w8qcnKI4eQ3ef3ipK09UpHVA=;
 b=zJ7tE98Gyy/ynKDZFbTUn9BrV/hIWZ7uwhKGqs1P1n1jQOVRAq7gxuBAKhMNWSqRmp
 /H0uLNKiyD02QCdFbHTNemiZ7A7/hDYY7AtV9Mv4bx3oGTKVjVWKyVnpsFkLK5VRNcwx
 Pjr4qaFnt3bK011H/OTRfmeaG+CQ9eMoYlUQy9sG5mViCeLiIkemXIzlBGpJP2MmVtcd
 8KGremQ6/fjrFWQ2eZAykAYM32/j1jdxaA4IAsbKQjK3jQVn4pK5IJnulOnbwTkpfBIN
 PJgA2jSSf5Yac3Ui7NzXaJ3wEvE3ylRh9kV40ESC15M+AguqFFV05lvBNTPL1XjBWllL
 CBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785401038; x=1786005838;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yaKFxfR0fzpkcksdwy+w8qcnKI4eQ3ef3ipK09UpHVA=;
 b=MUE38+fa/1O3u/Nd+C+W1+/47+MVTneORqwx2gw5RbXUvueBayBsJXzc/yPBRMk5Q8
 ETX6PdwL3nwvDUETzgbl/1weGK/1of5nmqPLJfjOf5x3siE3GUdbKGWETFrotMcoobmU
 GhVjunZhCL0VPU/fJDyizjFH1deCRjGvjd5ciXAkrtHDohDGzYmKyfVlJM2A0riHvPaU
 OavRRFcXZqhSlZkZ/nc9vC1xOH2W77UR+M2zFp6n6H8cMqe+a3gqe2KfabAO2zdqsnza
 sS/7/nsNG7otXWrHJ2ZK3Rfa74aiTKgslSdBNqToNCOdmrlVhkqcgOqMk+EXZUJ4io3P
 6IVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKTbAvzcMFKvKTU8QSjZfWvjKIIfBf+T2IEpfXgg8qSsdknj/9VwUakcdtdi1lxbxKOvB5n5dMugQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzpHQx64/EGSuaPCkOKeXinxvqLTU3PCREGBIow7XugSKbNOE7
 5HPwyIaVtw0ox02ET7D7PnsEwHX88wCWud+0sMAYZN/vGZENAtUOR0VnBwhwMGq3SXBcgVlt0Dm
 WP/qiv/le1+XRHnup5VrBDLKLHFRXIlCgvE9RdXYsAQ==
X-Gm-Gg: AR+sD100xwjtuFB/1XaIS5yuJGiq3ni14IX1196L9U+SgeJihnWu8cJg3ltUb7dJxVv
 pi47FfmKQldVWgE2c9ykpra1jvQos36Uk8NCMvt3Ori2YPWboVkZaxyDDqaTzKZA6RP85+1nFrl
 2jdqJqWqWdRlA0HHxLx+NXQ7dYX31Tt5WaQCG3oXyfcxUJiuTWBuOeneZWxisp8EOT4lx742imZ
 uxWjaGrDy4SxQsccWNBtqMlAfPTjYGdRmuNFO2z6tRfhnldzWVWvauUnEl7RTrEAkl6tcsJdsYS
 PiwbHOkG+i/VKPV3dqxr9mq+X40pPaqe67t+tLBVMKY55L0Y
X-Received: by 2002:a05:690e:e83:b0:668:15d6:8fd9 with SMTP id
 956f58d0204a3-6692f4a9ed7mr1128538d50.24.1785401037357; Thu, 30 Jul 2026
 01:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-6-c042266b9eeb@linaro.org>
 <20260727082018.2E7221F000E9@smtp.kernel.org>
In-Reply-To: <20260727082018.2E7221F000E9@smtp.kernel.org>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 30 Jul 2026 16:43:45 +0800
X-Gm-Features: AUfX_mzmu9T7jWwyxv5TKXdZNOp5IckU0GRtjEnl3MBaxtLZhEgB4Ber3zbb-JE
Message-ID: <CABymUCN9Dft18JZW9NtP_pu_UxEWWpdr-cLhgAN=_3f4AY8A7Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel: Add driver for Synaptics R63455 DSI
 panel
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

<sashiko-bot@kernel.org> =E4=BA=8E2026=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=
=A8=E4=B8=80 16:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 8 potential issu=
e(s) to consider:
> - [High] A copy-paste error in the BOE panel initialization sequence dupl=
icates command bytes, corrupting the DSI payload.
> - [High] Concurrent non-atomic read-modify-write operations on DSI `mode_=
flags` can corrupt the transmission mode state.
> - [High] Missing IS_ERR() check on the return value of devm_drm_panel_all=
oc() leads to an immediate dereference of an error pointer.
> - [High] The backlight sysfs interface is exposed to userspace before the=
 DSI device is fully configured and attached.
> - [Medium] The macros LE16_BYTE0/1 and BE16_BYTE0/1 use endianness conver=
sion functions before bitwise masking, causing incorrect byte order on Big =
Endian architectures.
> - [Medium] Returning PTR_ERR() on a valid pointer when the GPIO array siz=
e is incorrect leaks a kernel heap address and produces a positive error co=
de.
> - [Medium] The backlight update_status callback blindly sends DCS command=
s without checking the panel's power state.
> - [Low] An early return in the panel disable path on DSI command failure =
skips disabling the backlight.
> --
>
> --- Patch [6]: [PATCH v5 6/6] drm/panel: Add driver for Synaptics R63455 =
DSI panel ---
> commit 89f5e4df3241a9188e302ee5028a24a7b0bc9542
> Author: Jun Nie <jun.nie@linaro.org>
> Subject: drm/panel: Add driver for Synaptics R63455 DSI panel
>
> This commit adds support for the Synaptics R63455 DSI panel used in virtu=
al
> reality devices. It exposes a dual-panel configuration as a single logica=
l
> panel to the DRM framework.
>
> > --- a/drivers/gpu/drm/panel/panel-synaptics-r63455.c
> > +++ b/drivers/gpu/drm/panel/panel-synaptics-r63455.c
> [ ... ]
> > +/*
> > + * Extract the low byte and high byte of the 16bit number converted
> > + * to the cpu endianness.
> > + */
> > +#define LE16_BYTE0(val) (le16_to_cpu(val) & 0xff)
> > +#define LE16_BYTE1(val) ((le16_to_cpu(val) >> 8) & 0xff)
> > +#define BE16_BYTE0(val) (be16_to_cpu(val) & 0xff)
> > +#define BE16_BYTE1(val) ((be16_to_cpu(val) >> 8) & 0xff)
>
> [Severity: Medium]
> Will this generate the correct byte order on Big Endian architectures?
>
> Since be16_to_cpu is a no-op on Big Endian systems, applying the bitwise
> shift and mask afterward will extract the bytes in Little Endian order
> rather than Big Endian. This will cause the panel initialization sequence=
 to
> receive payload bytes in reversed order.
>
> Could we directly shift and mask without the endian conversion macros to
> safely serialize CPU-native integers across all architectures?

From Neil:
No we extract the low byte and high byte of the 16bit number converted
to the cpu endianness,
so it's the right code here.

>
> [ ... ]
> > +static int r63455_panel_on_boe_vs026c4m_n52_26000(struct drm_panel *pa=
nel)
> > +{
> [ ... ]
> > +     r63455_dsi_write_seq(ctx, dsi_ctx, R63455_GEN_OUTPIN_SET,
> > +                          0xf, 0xe4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0,
> > +                          0xf, 0xb2,
> > +                          0xf, 0xb2, 0x00, 0x64);
>
> [Severity: High]
> Does this sequence intentionally send the 0xf, 0xb2 bytes twice for the B=
OE
> panel initialization?
>
> This looks like it could be a copy-paste error that sends 14 bytes instea=
d
> of the expected 12 bytes. Could this transmit malformed configuration dat=
a
> to the display controller and cause initialization failures?

Yes, the sequence is send twice intentionally. As there are 2 panel control=
lers
as 1 logic panel in DRM high level system.
>
> [ ... ]
> > +static int r63455_set_brightness(struct r63455_ctx *ctx, u16 brightnes=
s,
> > +                               u16 pulse_offset_rows)
> > +{
> [ ... ]
> > +     ctx->dsi[0]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> > +     ctx->dsi[1]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> [Severity: High]
> Are these bitwise operations on mode_flags safe from race conditions?
>
> Since r63455_set_brightness executes under the backlight sysfs lock, it c=
an
> run concurrently with DRM atomic commit handlers like r63455_enable or
> r63455_disable which use independent locks.
>
> Could a concurrent read-modify-write here corrupt the transmission mode s=
tate,
> such as unintentionally dropping the MIPI_DSI_MODE_VIDEO flag?

It's very improbable this happens, panel cmds and backlight are called
at very different times.
>
> [ ... ]
> > +static int r63455_disable(struct drm_panel *panel)
> > +{
> [ ... ]
> > +     r63455_dsi_write_seq(ctx, dsi_ctx, MIPI_DCS_ENTER_SLEEP_MODE);
> > +
> > +     mipi_dsi_msleep(&dsi_ctx, 200);
> > +
> > +     if (dsi_ctx.accum_err)
> > +             return dsi_ctx.accum_err;
> > +
> > +     /* required by hardware to be after MIPI_DCS_ENTER_SLEEP_MODE */
> > +     return backlight_disable(ctx->backlight);
>
> [Severity: Low]
> Does returning early here leave the backlight subsystem in an active stat=
e?
>
> If the DSI ENTER_SLEEP_MODE sequence fails, the driver skips calling
> backlight_disable. While the physical regulators are disabled later in
> r63455_unprepare, could this leave the backlight framework out of sync?

Technically yes, but practically it is an unrecoverable hardware state. So =
it is
a low risk issue and can be ignored.

>
> [ ... ]
> > +static int r63455_bl_update_status(struct backlight_device *bl)
> > +{
> > +     struct mipi_dsi_device *dsi =3D bl_get_data(bl);
> > +     struct r63455_ctx *r63455_ctx =3D mipi_dsi_get_drvdata(dsi);
> > +
> > +     return r63455_set_brightness(r63455_ctx, bl->props.brightness,
> > +                                  bl->props.pulse_offset_rows);
> > +}
>
> [Severity: Medium]
> Does this function need to verify the panel power state before sending DC=
S
> commands?
>
> Userspace can modify the brightness via sysfs while the DRM display is
> disabled. If this occurs, it might trigger MIPI DSI transmissions to a
> powered-off panel or unclocked DSI host.
>
> Could this lead to hardware lockups or DSI timeouts?

Yes, I will add below logic in next version.

+++ b/drivers/gpu/drm/panel/panel-synaptics-r63455.c
@@ -456,6 +456,9 @@ static int r63455_bl_update_status(struct
backlight_device *bl)
        struct mipi_dsi_device *dsi =3D bl_get_data(bl);
        struct r63455_ctx *r63455_ctx =3D mipi_dsi_get_drvdata(dsi);

+       if (!r63455_ctx->panel.enabled)
+               return 0;
+

>
> [ ... ]
> > +static int r63455_panel_add(struct r63455_ctx *ctx)
> > +{
> [ ... ]
> > +     ctx->reset_gpios =3D devm_gpiod_get_array(dev, "reset", GPIOD_OUT=
_LOW);
> > +     if (IS_ERR(ctx->reset_gpios) || ctx->reset_gpios->ndescs !=3D 2)
> > +             return PTR_ERR(ctx->reset_gpios);
>
> [Severity: Medium]
> If the GPIO array has a count other than 2, will this return a positive v=
alue
> derived from a valid heap pointer?
>
> When devm_gpiod_get_array succeeds but returns an unexpected number of
> descriptors, ctx->reset_gpios is a valid pointer rather than an error poi=
nter.
>
> Could we return an explicit error code like -EINVAL here instead of leaki=
ng
> the pointer address through PTR_ERR?

Right, -EINVAL is proper value to return.
>
> [ ... ]
> > +static int r63455_probe(struct mipi_dsi_device *dsi)
> > +{
> [ ... ]
> > +     ctx =3D devm_drm_panel_alloc(&dsi->dev, __typeof(*ctx), panel,
> > +                                &r63455_drm_funcs, DRM_MODE_CONNECTOR_=
DSI);
> > +
> > +     ctx->dsi_init_seq =3D of_device_get_match_data(dev);
>
> [Severity: High]
> Should we check the return value of devm_drm_panel_alloc for an error poi=
nter?
>
> If memory allocation fails during driver probe, devm_drm_panel_alloc retu=
rns
> ERR_PTR(-ENOMEM). Dereferencing ctx on the very next line to assign
> dsi_init_seq will result in a kernel panic.
>
Right, a check shall be added in next version.

> [ ... ]
> > +     ret =3D r63455_panel_add(ctx);
> > +     if (ret) {
> > +             DRM_DEV_ERROR(dev, "failed to add panel %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     for (i =3D 0; i < 2; i++) {
> > +             dsi_dev =3D ctx->dsi[i];
> > +             dsi_dev->lanes =3D 3;
> > +             dsi_dev->format =3D MIPI_DSI_FMT_RGB888;
> > +             dsi_dev->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MO=
DE_LPM |
> > +                     MIPI_DSI_CLOCK_NON_CONTINUOUS;
> > +             ret =3D devm_mipi_dsi_attach(dev, dsi_dev);
>
> [Severity: High]
> Is it safe to register the backlight device before the DSI host is config=
ured
> and attached?
>
> Calling r63455_panel_add exposes the backlight sysfs interface to userspa=
ce.
> However, the lanes, format, mode_flags, and devm_mipi_dsi_attach are not
> set up until the loop that follows.
>
> If a udev rule writes to the brightness node during this window, could it
> trigger DSI transmissions on an unattached device and lock up the host?

It is OK per Neil's answer.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-sm8650-7=
-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org?part=3D6
