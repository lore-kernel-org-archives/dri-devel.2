Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C4AC44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F9210E753;
	Thu, 16 Jul 2026 08:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ABZYoOnU";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9804310E12F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 06:33:30 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8485ab7c382so789105b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 23:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784097210; cv=none;
 d=google.com; s=arc-20260327;
 b=XXkUsBb84AkaZLtpkCgHIJ9gRv2ZlcLQ/bf6SMp/kuq8+rYILpBl76iD1RgDZ3ZMJD
 WEZtm49fz0u4dMkJjbBPsI29ONfzW8Jf3vtlpubCQmKqCNRj5ioEX56feTCuDK9i7Y9K
 7ZYUeAemhgtorwYNcBeMAut08maeTqbCNTeNCm5KMCvCqx9dBfzREOY+Q+zRqJgHzNdT
 4eqVI/cjj8XSp6zz4wI8FQhi11rwE+XWpVqx3QP00HdCrf3ji1/59QykPBy5TEdZZIGj
 y9Xq15UPWOjXWvWy+de6cVSmqEr7XPVe1Wf3kPqZaBtdJtgr3VgUxQ7UQsXJlfheHcsE
 oOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gWSeKvpcppphKo4JuhaQYfS686HzGPt1n2IjvkPZLEQ=;
 fh=GBmacVDeFEJjMoVFDdJ4RApqi7WOhPuR6bgG07yIMU8=;
 b=PLeNcZFLX/LQLNM71xYT2NBCtxulxnTH4WZokj2W56PzrRJp4FsHTX/ZB+WYmRKLOZ
 ZPGKutnNXi+6eja2QSgJgyPKzCPSkc2mj1A5CrPQuV/z4Mb0CEU08986zU7Mi08qnuLK
 ExB9s+/fRNoS37P0RJaiw29YkXnHGHFWaFcj6JKEU1jd6oE//iFxwJRBC/PK5jae+aLs
 yv1M8mBpLp1n2Sg/gGtZ25ouMT3EK+WRc39TqP9nQOhbdUa6EA+lm9EgNwpwdj0QT2gk
 pjiZf6qu0Iw+D+Y2ydvrv2CvrwWL0E8T98EbIFhBA6oG583dQQ97qkPfllztAmrHObDL
 SDWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784097210; x=1784702010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gWSeKvpcppphKo4JuhaQYfS686HzGPt1n2IjvkPZLEQ=;
 b=ABZYoOnUz6mGc+t2pBBGBoHNWImitwDxQK2t9HUFQLu5HnNGB7A8GF5SLoX9nJsyWe
 EaKDOyG9gPunTTwaDqGMBs9nUcxJTy9zxDrmzPLhUbL6lkwdYLnuQUxRkZOSd/28Zypn
 3bezo16M9UGwp4C9KFFswKIFQJY+GgNIYKvFYt6tx4IWk3119am96cCDGZA3QgVzK3E4
 MM+U/aFO5G+maarZ1mQsN+8W5pGoeqQGbVZyAizsT/+3EEVTb2TUOKPVqUrQyLd2zIs4
 +4cyAbmpQbyTLQ6h5ouR0RSTcAzo0ZNqnEW5IA4b1zcFLJD2emaWOU8cUOsQjV+OUeri
 YDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784097210; x=1784702010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gWSeKvpcppphKo4JuhaQYfS686HzGPt1n2IjvkPZLEQ=;
 b=d4BnHjq0HnvdMnkB7em78h88WmuuUvCdaSUc5hQAo9B9RVex5dpIUMDZhnoFW63uXP
 FxWmD9yC1pGUcnP1IRxCrjgH35/5IXXUBog53GlHHjyP4miFg549P1fqWo1RA9h1vtPj
 bnabEFMEAh12blwiDgJjrEcLtgrE8ukApf5mqbrZOM8y6RjQkfVmDbQN7pxVv353z63H
 mlQ8FxYxiHdmKT3OY5Kg3lnKITN+G8yOhOoJSX9Sw0UxlV1ENdc2mmJkk+2lWgdj4Da0
 t2y23jv0cE6PTI6Xf4XHQpsdFkvVPBHkkxKa3b3HITk3NKTi29TSuyGdkftokl9DdZu2
 2Zgw==
X-Gm-Message-State: AOJu0Yyv8Vs8Q2yKh7Gl64EsjEF+F6RLtiWDjmnnHJpc1VaUE9BGpoUo
 HPyqzWtE6oG26uABT4+P0aWQp66aSKj7gV0r/FJceAEw+tayOgsTpuQS0iUbQn8W7SBRDMZvODp
 fo6fylNJ39a1o1Qw1QrosKKKOCE7+8ZBPtmXs6BI=
X-Gm-Gg: AfdE7ck/ZoNNe4GDyHXbNSxD5zAQRt+mVSgC3BOZg5ABaDBzAhMQPsPToid6+Oy9niK
 V6TKhko3p70k4VWiQjF43XUMf7sT89hsInl03+3LMMg7wU2vKtJGHhVHdBJunu/jmldteTRbVWm
 udDyi1XQQoSsfJKdRq7oWJgIaLJllDb9fdjYziyqRjiLt7VxAtEIBIbZgc0A4aN0lT0fap4wHmj
 vFy7Ig4g4Ob1+zKiJlnDKDGIQGucT8WJlghZS9RWXghtO76YNehMNaNheicVcJxB2iOqWFldA+M
 2Z8WyJO3hNf3F+7KmraFdAH9geOvjhnMGsGlIf2Lgw==
X-Received: by 2002:a05:690e:4883:20b0:668:7e4:b078 with SMTP id
 956f58d0204a3-66807e4be6dmr2370313d50.5.1784096804761; Tue, 14 Jul 2026
 23:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260714202850.40999-1-royalnet026@gmail.com>
 <20260714204026.84B601F000E9@smtp.kernel.org>
In-Reply-To: <20260714204026.84B601F000E9@smtp.kernel.org>
From: Royal Net <royalnet026@gmail.com>
Date: Wed, 15 Jul 2026 08:26:32 +0200
X-Gm-Features: AUfX_mx_GykK3yZd7csrMrPNJbBaiwMkpZUk534rlKvfi9UnpbROgKKA1H36E9M
Message-ID: <CAEWPSH5KVBDE6s+7EYsyGEJ5BNv2Y6dtXXcKOfS=9xxjw6MtPA@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

> [Severity: High] This is a pre-existing issue, but by adding this
> error path, the patch exposes it further. Does returning an error
> here without cancelling hdmi->hpd_work risk a use-after-free?

Thanks for taking a look.

The window you describe does exist, but it is not introduced or
widened by this patch: hdmi->hpd_work is initialized and the HPD
interrupt requested early in dw_hdmi_qp_rockchip_bind(), and the
function already has several error returns after the interrupt is
live -- encoder init, dw_hdmi_qp_bind() and drm_bridge_connector_init()
-- none of which cancel the delayed work. This patch adds one more
return immediately after the last of those, following the function's
existing error-handling pattern.
Since the cancellation gap is common to all of bind()'s error paths,
I think the right fix is a separate patch addressing all of them at
once (e.g. switching to devm_delayed_work_autocancel() or a devres
action) rather than special-casing the new return. I'm happy to send
that as a follow-up.

Igor


On Tue, Jul 14, 2026 at 10:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Returning an error from `dw_hdmi_qp_rockchip_bind()` without can=
celling `hdmi->hpd_work` leads to a Use-After-Free when the delayed work or=
 HPD interrupt fires.
> --
>
> --- Patch [1]: [PATCH] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspa=
ce connector property ---
> commit 77d2f0e8bc60d50755aec22dee119ad08bb92b3c
> Author: Igor Paunovic <royalnet026@gmail.com>
>
> drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace connector property
>
> This commit creates and attaches the standard HDMI colorspace property
> after the bridge connector is initialised. This allows userspace to reque=
st
> BT.2020 colorimetry and enables wide-gamut/HDR output on RK3588.
>
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/g=
pu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> [ ... ]
> > @@ -695,6 +695,20 @@ static int dw_hdmi_qp_rockchip_bind(struct device =
*dev, struct device *master,
> >               return dev_err_probe(hdmi->dev, PTR_ERR(connector),
> >                                    "Failed to init bridge connector\n")=
;
> >
> > +     /*
> > +      * Attach the HDMI Colorspace property. The HDMI connector framew=
ork
> > +      * already consumes conn_state->colorspace for the AVI infoframe
> > +      * (drm_hdmi_avi_infoframe_colorimetry()), and HDR_OUTPUT_METADAT=
A and
> > +      * max bpc are attached by drmm_connector_hdmi_init(), but withou=
t the
> > +      * Colorspace property userspace cannot request BT.2020 signallin=
g,
> > +      * which keeps wide-gamut/HDR output unavailable. Passing 0 selec=
ts
> > +      * the full HDMI colorspace set defined by the core.
> > +      */
> > +     ret =3D drm_mode_create_hdmi_colorspace_property(connector, 0);
> > +     if (ret)
> > +             return ret;
>
> [Severity: High]
> This is a pre-existing issue, but by adding this error path, the patch
> exposes it further. Does returning an error here without cancelling
> hdmi->hpd_work risk a use-after-free?
>
> If a hardware HPD interrupt fires right before the devres cleanup
> unregisters the IRQ, hdmi->hpd_work can get queued. The DRM master
> teardown then frees hdmi (which was allocated via drmm_kzalloc),
> leaving the delayed work to execute later with a dangling pointer:
>
> drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c:dw_hdmi_qp_rk3588_hpd_work=
() {
>         struct rockchip_hdmi_qp *hdmi =3D container_of(work,
>                                                      struct rockchip_hdmi=
_qp,
>                                                      hpd_work.work);
>         struct drm_device *drm =3D hdmi->encoder.encoder.dev;
>         ...
> }
>
> Could we ensure that the delayed work is properly cancelled before
> returning errors from dw_hdmi_qp_rockchip_bind()?
>
> > +     drm_connector_attach_colorspace_property(connector);
> >
> >       return 0;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714202850.40=
999-1-royalnet026@gmail.com?part=3D1
