Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760B606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTNuOYoB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBB310E103;
	Sat, 28 Nov 2026 07:54:04 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E4610E103
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 07:53:58 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-386cf1041cdso6420262eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 23:53:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795852438; cv=none;
 d=google.com; s=arc-20260327;
 b=sxmB4juESQbfORShB3r3QIMPnDwmOIQLqhipcMCuTpUPmKqjpIFQsl3I0wPXLj0xy7
 PeCGr5FCd/DT+eQko3F70SQSzj+zd85PbJ8nbmqnrFmomQ7ycqwRQVWfCBDHq35TYH+5
 1Qptmu+hS2FRh46DU1BPK/0Ngu8xuIVUTipFOxNpCKI9xNHFt6VOVXncHN4HhutVpgWY
 qHFQfjgLqYIww0IRFywE34jlw8rr/+llHn7wLNiSsTbSeopjmpklCtpLzEIoDMD+KRZH
 Sao4sD/3CFfKx++240y7jZqzR+IsMXS9+dWLN8FIs8lQL/q8m/Gfcet0I7ewcAjlPZmM
 nwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3E26Yt2ovRK5OMZtgqMHVcJ89/Y9SO5NO/MzyS43R8M=;
 fh=97CN65EGrOUNVBEnu14nKoKsodDaBE07UGMlF3gYlDU=;
 b=XXJ+bGVyA04wIftl6cxJx+JLdNUdl9eY9SIJLQj+DgHdeod0o/x6i6M8CQ9s+5/9VN
 vphV5xL56fOFQeUBAqtddZlL8vAWIGvl9nWcYtsZtvUXhgHYBixGN3UK0jI/OlgkXde1
 zRDKspu2hYdQavn6agVKgPjAunxmVynU9WBPWPKnlr4IYWVPmPvcc2aICI/RPdeus8wT
 GkdWnK0ueHgv0DQHto3ytmdzkQObzLFVQ8mzh+P3D9HIiQoHV7H8x0nl9I+kcDx3rRrN
 O0dIzeTPw4fRLuBfWfdwUaWS1II2vVY2Z50h/FkFtbnUinqMx5HvwmmED9VXJEGSD6hZ
 Qkxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795852438; x=1796457238; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3E26Yt2ovRK5OMZtgqMHVcJ89/Y9SO5NO/MzyS43R8M=;
 b=yTNuOYoBQ7GbxfB/Hpk8+KGNq8vvoEN4zHgVYFdmsSnZlVeWPxPTjkrd2ZGjjsa/dQ
 1OuOeZxCBYEU0xkZ/Cdn6ffDbJug+Xk7vsnMhVozrlloPJL/Ge8sh+av4XrMCoaAreDJ
 mBhYM+RLna3bm3MowsJ2v9rLZHxsR4Q28nsIwC+tnpBSMx90e0Jh5FuYzo0PGc/GOgKc
 OzQKY7gLumjcCMRy8rQn6rqDaFOLXGZKT2JgqklxJj/AJQUH5peiXxNYPaYTs3WPkrvH
 TNGvicn5QJ+HYnJBEcznCSFy1oWEeOEcEP3/HPzlTwLIlipOGKeqGdmStO0HBC30eMwi
 d9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795852438; x=1796457238;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3E26Yt2ovRK5OMZtgqMHVcJ89/Y9SO5NO/MzyS43R8M=;
 b=GZn8BEPakJLOiH2Og9fDoIFYlGURvCDiQrbuhiWYrYu0CeDDVNpLuU/kf1GyQld+pY
 U9+2HlsnvOvqX7a9cdFf/65hvuo0BWuFAf/F4FGfTAPXTtJlwEb653hhRvloXOQ2JwsY
 WidEFDXfYiNzoEQGaEtdAEvhscAC9WTtiD6qBptDk6NQZSDkZu/Rfil4q/Lnkf2up4Y1
 +prxFCo3AYSn9ZBW6Ef/sYrZdSNhfLd6dW8oelyWuLOO+ubM61jP8bMcnfFz0UwzSMNU
 RABjqaMbcNc4N6jUKlF5MAHwZh1bo0pPCnukJ+AHLQM8+a1ufMHwqJZWZ8SVLEUxhOhu
 FQYg==
X-Forwarded-Encrypted: i=1;
 AL+hErH9mTmOo4Yp+Xl1nDPbl6zuZntXTFQcbISMnwCasYLmcVl/xzjw369uStLkl/e+TmVD5YSW1uUnxAY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/tuRK6z3sTM72W9M8LjwcGLMe+a6LI4VB2CZCtpMYe0/wf9dIn
 8cp0JbbKVSFOgy6Rn48poJEoqK+RacOlzBsnh3ILPgW7b7f+9Je1jZD0fsYDcQKjQrdR8zuOzY6
 4NoonOnrOmknChKjdBcd9eKBWdN9BvR8=
X-Gm-Gg: AZFdTZd4xvu/uodmtnub1oZZ5ywLj3qQFCsPL3dItJlXMxoBr7YYs5JbDF1zg2t3690
 KdLo8G6gPMwY6lSgDOKiZpRWONZdpP6kvyJVJDK0eoSYcUwWJIL5ct26quVzbJzM/Urcan7y+Tb
 QNAy7JPDdMaavCBgj4UJ6xrJ+9pEtW8ZybbDDEHBFFvA/saocHNs4CsE6Am2vL5ZyfLF1QoWCkq
 PNPcJ+uu+UXNU7LJ6VYkD/+IwWN2/Pn5sdBp6jAvP/ndcuifIT7RdVM4hr9QOswudIBm9kyOVMd
 nVNP8djnfDSiscxlOgKZmKJXOxjkpVPwgvHMWic12tKt1dJ7UvHbSO+S7+g3sPuxkZIoHVwNauH
 fRtZSkxXPRJpSkti8CTUZ6MWdhwVFCxCKuDKiNhPdzwFy/kf8pg5H+VUBO8rE2auwp99EdFjhqI
 NM08es5PEe3kEtZz3GW86B0p+wCKt+cQ==
X-Received: by 2002:a05:7301:2108:b0:386:b99:8ff9 with SMTP id
 5a478bee46e88-3860b999354mr23606691eec.40.1795852437505; Fri, 27 Nov 2026
 23:53:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <QEeSnm4uTjq24quMQBzlfQ@nvidia.com>
 <CAPVz0n2xxEG5vR4X_dZeyQfN9TVSCBn+2uW1wY7Z+P3N8BhNqQ@mail.gmail.com>
 <TYDAsh0fQ52x0yM4_wAp5A@nvidia.com>
In-Reply-To: <TYDAsh0fQ52x0yM4_wAp5A@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 28 Nov 2026 09:53:45 +0200
X-Gm-Features: Aa3M54q-zu7VNZG7RQnUkD49ZZ4GXHDbs3pfd4VbGKumQK7WmjGiO3UixS-hPEM
Message-ID: <CAPVz0n2no09Dkf_+wBf_f0dejHxCkLtnjB-Tu-PKjn5PMQHuTg@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D1=81=D0=B1, 28 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 03:2=
8 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, November 27, 2026 10:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
14:35 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Friday, November 27, 2026 6:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 08:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wro=
te:
> > > > > > Parameterize configuration based on bus flags passed from the b=
ridge or
> > > > > > panel. The list of supported flags includes now pixel clock pol=
arity,
> > > > > > display enable (DE) polarity, and data alignment.
> > > > > >
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++=
++++----
> > > > > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegr=
a/rgb.c
> > > > > > index d48d498068ac8..faecd6f94359f 100644
> > > > > > --- a/drivers/gpu/drm/tegra/rgb.c
> > > > > > +++ b/drivers/gpu/drm/tegra/rgb.c
> > > > > > @@ -5,6 +5,7 @@
> > > > > >   */
> > > > > >
> > > > > >  #include <linux/clk.h>
> > > > > > +#include <linux/media-bus-format.h>
> > > > > >  #include <linux/of.h>
> > > > > >
> > > > > >  #include <drm/drm_atomic_helper.h>
> > > > > > @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct=
 drm_encoder *encoder,
> > > > > >       struct tegra_output *output =3D encoder_to_output(encoder=
);
> > > > > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > > > > >       struct drm_connector_state *conn_state;
> > > > > > +     struct drm_bridge_state *bridge_state;
> > > > > >       struct drm_crtc_state *crtc_state;
> > > > > >       struct drm_connector *connector;
> > > > > >       struct drm_display_mode *mode;
> > > > > > @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(stru=
ct drm_encoder *encoder,
> > > > > >       crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_=
state->crtc);
> > > > > >       mode =3D &crtc_state->adjusted_mode;
> > > > > >
> > > > > > +     /* Get but flags from the bridge state. */
> > > > >
> > > > > s/but/bus/
> > > > >
> > > > > > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, o=
utput->bridge);
> > > > > > +     if (bridge_state)
> > > > > > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > > > > > +     else
> > > > > > +             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE=
 |
> > > > > > +                         DRM_BUS_FLAG_DE_HIGH |
> > > > > > +                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> > > > > > +
> > > > > >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_e=
nable));
> > > > > >
> > > > > >       value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> > > > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIO=
NS);
> > > > > >
> > > > > > -     /* configure H- and V-sync signal polarities */
> > > > > > +     /* configure H- and V-sync and pixel clock signal polarit=
ies */
> > > > > >       value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLAR=
ITY(1));
> > > > > >
> > > > > >       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > > > > > @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(stru=
ct drm_encoder *encoder,
> > > > > >       else
> > > > > >               value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> > > > > >
> > > > > > +     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> > > > > > +             value &=3D ~BIT(PIN_LSC0);
> > > > > > +     else
> > > > > > +             value |=3D BIT(PIN_LSC0);
> > > > >
> > > > > I think this is the wrong way around: SAMPLE_POSEDGE means that t=
he
> > > > > pixel data is sampled on a rising edge. That is, it should be dri=
ven on
> > > > > the low edge so it's ready for sampling in time for the rising ed=
ge.
> > > > >
> > > > > LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly=
, 1)
> > > > > corresponds to a data transition on the falling edge, i.e. sampli=
ng on
> > > > > the rising edge.
> > > > >
> > > > > Section 31.9.6 states this a bit more clearly: "an active low pix=
el
> > > > > clock means that the data changes on the falling edge of the cloc=
k, to
> > > > > be latched on the rising edge".
> > > > >
> > > >
> > > > DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE =3D DRM_BUS_FLAG_PIXDATA_DRIVE_=
NEGEDGE
> > > >
> > > > Should I replace with DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE?
> > >
> > > No -- with the current code, let's say
> > > DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE is set. I.e. the panel tells us t=
hat
> > > it will be sampling pixel data on the positive (rising) edge.
> > >
> > > LSC0_OUTPUT_POLARITY will be set to 0. The TRM documents the value 0 =
as
> > > "active high", and "means that rising edge coincides with data
> > > transition". That is, the display controller will change the output p=
in
> > > state to color data on the rising edge. So the SoC pins will change
> > > state at the rising edge, and the panel will sample at the rising edg=
e.
> > >
> > > But the pins will take some time to take their new values, so this mi=
ght
> > > not work or could be unreliable depending on all kinds of timing
> > > factors. So if the panel is sampling as the rising edge, the SoC shou=
ld
> > > be driving the pins at the falling edge, that way there is time for t=
he
> > > pins to settle before the panel samples them.
> > >
> > > So the value written to LSC0_OUTPUT_POLARITY should be the opposite o=
f
> > > what it's now. If that breaks the panel, either it's reporting the
> > > incorrect DRM_BUS_FLAG_PIXDATA_SAMPLE_* value or something else is
> > > incorrect.
> > >
> >
> > This may/will cause regressions across multiple panels and devices.
>
> Looking at the panels we have, if we retain the previous behavior when
> neither PIXDATA_SAMPLE_POSEDGE nor PIXDATA_SAMPLE_NEGEDGE is set, then
> we'll retain the same programming as we've had before.
>
> Actually, from what I can tell, the change in this patch will change the
> programmed polarity compared to before the patch for the panels/bridges
> on the Colibri/Apalis/TF700T boards, which do specify SAMPLE_POSEDGE.
>
> So if we flip the logic around, and default to SAMPLE_POSEDGE if neither
> is specified, we should retain previous programming for existing panels.
>

so default to

+             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+                         DRM_BUS_FLAG_DE_HIGH |
+                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;

and this remains same?

+     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
+             value &=3D ~BIT(PIN_LSC0);
+     else
+             value |=3D BIT(PIN_LSC0);
