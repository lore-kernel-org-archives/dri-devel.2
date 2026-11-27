Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2E606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4bHd4QE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0463B10E50E;
	Fri, 27 Nov 2026 09:17:29 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD9910E50E
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:17:22 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1a3c08d6928so11736153c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:17:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795771042; cv=none;
 d=google.com; s=arc-20260327;
 b=nOpuQfkFG8Lac5msIpkd5Mf5D+rZWcYObmaQD7XRoEYOyXUoldwfPlM0OaZrGYT47c
 UuO+972gCsjjndyLhWX3Xby+TU5d7N4sXr9PcZu8Da4UXsKZQ1Q7jxTo98X2mkSUJhDq
 f2kzOxzVyFisLjYjHhyUzwVQypR0ElxHeFDNeDATnuoslcUuxgEVcKAoc5AEpVwXFxwh
 wY8ReBgTax4pkpqCA5ZGWEIFKP5aS7UHItMbKAM0CzVyKPBAonkX16Xio45Z4bLOC9Kj
 ow761Stfr86yvmf2l9fb65PRaf0TT2tsN9YYqvpuQMaOe8PiTovHMJH4H5AmS0qcyZlb
 AHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dDmS8NtuQmnyXQ7IeezSes44I1C6AREbPMXt5vLaR3Q=;
 fh=exB+b+U49Nh03ErjZeB8Rmi6wnNPj2FyWwZ+qRqPm3s=;
 b=V4aGR2k8evxUcBoe+d9HJTneYiRmqP1jo1YKARtiqe019g1wxg6TcHB1MzqkyPyK4K
 lsOCroEAPckmCjqr8pwieLCUefjzCGuwrSO98oHDsHpDeabAeddszdEa8BKqTH9iA/Gz
 xFM2fwEi0YBji7P+//dS4NZGZVgwpYmnB3NIJi81TXKdsNs1mgEdCOeoFecZZZWi3kvB
 0F1LnhJAbbbFd/vF4e5x0V8flwp093yyNKk4gno8g5L28cuwwiqJLTobRUfdyQJpEhWJ
 YOA4qbENOiNM2thSep9I5EDlnxRMGkd8N4hv7U/SIPBuofAgYRwC9fylNeB/7YtVoaRg
 pxUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795771042; x=1796375842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dDmS8NtuQmnyXQ7IeezSes44I1C6AREbPMXt5vLaR3Q=;
 b=I4bHd4QEveDdI+yMqAK2he8O+k0q1ApkcjDv115Yarhrcl/oe6uiQDIZPmS4JeFUAd
 ePexqn7iBvZRPGT+qstS8u3exk6c5mF9nmIRcfsAgye5HM8LvnzOuGNWDG0xNRBlcK9I
 m4sFpi5G+0rfhfoNgw+5szbczWakHX9V+e1hLDQODULvGYnAIXzHEGuQ3mZVeC4ncPW1
 aMAnCpoYqM2RBr6RxPvG7xRvSXRIQtdcNE9r/blqj8iZvL7xTJZjLlRU06ZWfnPV4N9a
 QFUlV7HjcQmQx3Yu57CnMHjJMmyx5fFn1qFqvNnKNJONu6KdY+PvSvZeCZbxv9pT4+n+
 9hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771042; x=1796375842;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dDmS8NtuQmnyXQ7IeezSes44I1C6AREbPMXt5vLaR3Q=;
 b=g2eCZroJkW3ZQiHpaskbMxqC1xsvpM9U4foj5QuwGMmTQd/pTTgWD5DvKejUFwihNY
 cTRzhaoNnHPDk2jt4ACWDl0lS/OmJkDwfAltErd/zYV1Q12+jTzADFT3Ev0JJ6Xqihfk
 Nphyrjxwa+f4XQJ+nzvBWUuV6piRs4MDzJaXjjw/Yv7G4N9/rsxDZxKZftukx/XQ2GaN
 jpO1GChN7B0uj42Xvwio5AKREcitWdKAO1mg+j5noNCpE4BIsOSxrHEEn3UobJcpMGS8
 pCqehFAzUbZbowLn2TlHPCEoGc0Na03L5fJxd7LFxeWXEzgipu3LIUcS/ibh86J3ZPz0
 PbXA==
X-Forwarded-Encrypted: i=1;
 AL+hErG9Nh6hYyH24Uxm41Z+84YJAQggaqt++GSkx5GUPfyzOUGZLi0nr6YK1G/pALwPp2pDRKzFKW6SboA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+O+mCleqLpX2gNMt2XY+KyBrJKu8qzMdL8PR/H8u95mEysQywV
 5Q/bKT79DnZp669YBmetCzymiXN7kY7dhgLnetIoIrkq676Bqz8j6ZRG1i1brEYCOUmqpQW1hEo
 G8J+Z3gDvG/fpAFDX5YhDByXn4xJeHqM=
X-Gm-Gg: AZFdTZdtgc91jTlwVTu8nb1V4kAHN4ZCoXNyLuu7Sz5N9qzoT60B9/sDq/8y8gC0+dO
 bu3/WUKa/xSJi2yTl6wIp0g3PhIyonVrmzKq0GyGXLzomY2CkJ4qITE+3jbxJ3pmbXJwmArwPtj
 d/dQIRviUcVXNju3Y6CNYCPPSTVXNVoNUWIaWAVwDncToeAb5au6jdp2yzn6OAXxFM60jIlg+yE
 H3L70Pfg0PsaMRvEjDmyJZAeqEITIfGRdBTbvdPEdXqdfY+k5R8jKRK37hYbFH+koTYP1R77Et0
 N+Z71HwTRbM56QasbYn5SW65XKVt46s1dlK+vXfSBX7bCw4oQkTC+W72hb0yu89kVMBdaIgGjsN
 0g1k/xpU3a2XkQNiHV/jwSAyW8TNGte8XzXjDJ6wTr96+kcvuMhRvkS1Gc//7wQLaQGaN++4mIh
 hDKGxqZs9i418c/wOpBc8VuLULRlFGq1I=
X-Received: by 2002:a05:7300:ac82:b0:385:4b9:18f2 with SMTP id
 5a478bee46e88-3857093f077mr35542915eec.21.1795771041860; Fri, 27 Nov 2026
 01:17:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-10-clamor95@gmail.com>
 <mxfdX1kqQz209wWYqFOofg@nvidia.com>
In-Reply-To: <mxfdX1kqQz209wWYqFOofg@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:17:09 +0200
X-Gm-Features: Aa3M54qIl8HPODfyZsvmpYkFJItC2sR0jtJsUw_xe1x-dhhaz3Ej4xd6HUaecRM
Message-ID: <CAPVz0n1ZoMfPWKXSbLENDh9f8qxZbdbnvLxbiLxo8fZS-u5Etw@mail.gmail.com>
Subject: Re: [PATCH v8 09/12] drm/tegra: Convert to use atomic versions of
 drm_encoder_helper_funcs
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 07:2=
4 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Switch to using the atomic versions of the enable() and disable()
> > operations.
> >
> > This is required for acquiring the next bridge state without causing
> > crashes, in order to properly set up the encoder.
>
> This is a bit vague. I'd make an explicit reference to RGB needing
> access to the bridge state, which is not possible with the non-atomic
> functions, and then explaining that DSI / HDMI / SOR are converted for
> consistency.
>

Noted

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/dsi.c  | 20 +++++++++++++++-----
> >  drivers/gpu/drm/tegra/hdmi.c | 20 +++++++++++++++-----
> >  drivers/gpu/drm/tegra/rgb.c  | 23 +++++++++++++++++------
> >  drivers/gpu/drm/tegra/sor.c  | 18 +++++++++++++-----
> >  4 files changed, 60 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> > index 6d6adc485e51e..cd61070072beb 100644
> > --- a/drivers/gpu/drm/tegra/dsi.c
> > +++ b/drivers/gpu/drm/tegra/dsi.c
> > @@ -855,7 +855,8 @@ static void tegra_dsi_unprepare(struct tegra_dsi *d=
si)
> >               dev_err(dsi->dev, "failed to suspend: %d\n", err);
> >  }
> >
> > -static void tegra_dsi_encoder_disable(struct drm_encoder *encoder)
> > +static void tegra_dsi_encoder_disable(struct drm_encoder *encoder,
> > +                                   struct drm_atomic_commit *comm_stat=
e)
> >  {
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > @@ -919,16 +920,25 @@ static int tegra_dsi_prepare(struct tegra_dsi *ds=
i)
> >       return 0;
> >  }
> >
> > -static void tegra_dsi_encoder_enable(struct drm_encoder *encoder)
> > +static void tegra_dsi_encoder_enable(struct drm_encoder *encoder,
> > +                                  struct drm_atomic_commit *comm_state=
)
> >  {
> > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted=
_mode;
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > +     struct drm_connector_state *conn_state;
> >       struct tegra_dsi *dsi =3D to_dsi(output);
> > +     struct drm_crtc_state *crtc_state;
> > +     struct drm_connector *connector;
> >       struct tegra_dsi_state *state;
> > +     struct drm_display_mode *mode;
> >       u32 value;
> >       int err;
> >
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_state=
, encoder);
> > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, con=
nector);
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_sta=
te->crtc);
> > +     mode =3D &crtc_state->adjusted_mode;
> > +
> >       err =3D tegra_dsi_prepare(dsi);
> >       if (err < 0) {
> >               dev_err(dsi->dev, "failed to prepare: %d\n", err);
>
> The function also uses encoder->crtc and tegra_dsi_get_state. Should
> these be changed to conn_state->crtc and to_dsi_state(conn_state)?
>
> Similarly for HDMI / SOR.
>

I must have missed that. Good catch

> > @@ -1059,8 +1069,8 @@ static const struct drm_encoder_funcs tegra_dsi_e=
ncoder_funcs =3D {
> >  };
> >
> >  static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helper_=
funcs =3D {
> > -     .disable =3D tegra_dsi_encoder_disable,
> > -     .enable =3D tegra_dsi_encoder_enable,
> > +     .atomic_disable =3D tegra_dsi_encoder_disable,
> > +     .atomic_enable =3D tegra_dsi_encoder_enable,
> >       .atomic_check =3D tegra_dsi_encoder_atomic_check,
> >  };
> >
> > diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.=
c
> > index e8c4347f09e69..a78279810dd82 100644
> > --- a/drivers/gpu/drm/tegra/hdmi.c
> > +++ b/drivers/gpu/drm/tegra/hdmi.c
> > @@ -1166,7 +1166,8 @@ tegra_hdmi_connector_helper_funcs =3D {
> >       .mode_valid =3D tegra_hdmi_connector_mode_valid,
> >  };
> >
> > -static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder)
> > +static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder,
> > +                                    struct drm_atomic_commit *comm_sta=
te)
> >  {
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > @@ -1209,18 +1210,27 @@ static void tegra_hdmi_encoder_disable(struct d=
rm_encoder *encoder)
> >               dev_err(hdmi->dev, "failed to suspend: %d\n", err);
> >  }
> >
> > -static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
> > +static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder,
> > +                                   struct drm_atomic_commit *comm_stat=
e)
> >  {
> > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted=
_mode;
> >       unsigned int h_sync_width, h_front_porch, h_back_porch, i, rekey;
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> >       struct tegra_hdmi *hdmi =3D to_hdmi(output);
> > +     struct drm_connector_state *conn_state;
> > +     struct drm_crtc_state *crtc_state;
> >       unsigned int pulse_start, div82;
> > +     struct drm_connector *connector;
> > +     struct drm_display_mode *mode;
> >       int retries =3D 1000;
> >       u32 value;
> >       int err;
> >
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_state=
, encoder);
> > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, con=
nector);
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_sta=
te->crtc);
> > +     mode =3D &crtc_state->adjusted_mode;
> > +
> >       err =3D host1x_client_resume(&hdmi->client);
> >       if (err < 0) {
> >               dev_err(hdmi->dev, "failed to resume: %d\n", err);
> > @@ -1460,8 +1470,8 @@ tegra_hdmi_encoder_atomic_check(struct drm_encode=
r *encoder,
> >  }
> >
> >  static const struct drm_encoder_helper_funcs tegra_hdmi_encoder_helper=
_funcs =3D {
> > -     .disable =3D tegra_hdmi_encoder_disable,
> > -     .enable =3D tegra_hdmi_encoder_enable,
> > +     .atomic_disable =3D tegra_hdmi_encoder_disable,
> > +     .atomic_enable =3D tegra_hdmi_encoder_enable,
> >       .atomic_check =3D tegra_hdmi_encoder_atomic_check,
> >  };
> >
> > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> > index 227a178f761bd..d48d498068ac8 100644
> > --- a/drivers/gpu/drm/tegra/rgb.c
> > +++ b/drivers/gpu/drm/tegra/rgb.c
> > @@ -90,7 +90,8 @@ static void tegra_dc_write_regs(struct tegra_dc *dc,
> >               tegra_dc_writel(dc, table[i].value, table[i].offset);
> >  }
> >
> > -static void tegra_rgb_encoder_disable(struct drm_encoder *encoder)
> > +static void tegra_rgb_encoder_disable(struct drm_encoder *encoder,
> > +                                   struct drm_atomic_commit *state)
> >  {
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_rgb *rgb =3D to_rgb(output);
> > @@ -99,12 +100,22 @@ static void tegra_rgb_encoder_disable(struct drm_e=
ncoder *encoder)
> >       tegra_dc_commit(rgb->dc);
> >  }
> >
> > -static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
> > +static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
> > +                                  struct drm_atomic_commit *state)
> >  {
> > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted=
_mode;
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_rgb *rgb =3D to_rgb(output);
> > -     u32 value;
> > +     struct drm_connector_state *conn_state;
> > +     struct drm_crtc_state *crtc_state;
> > +     struct drm_connector *connector;
> > +     struct drm_display_mode *mode;
> > +     u32 bus_flags, value;
> > +
> > +     /* Get mode flags */
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(state, enc=
oder);
> > +     conn_state =3D drm_atomic_get_new_connector_state(state, connecto=
r);
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->c=
rtc);
> > +     mode =3D &crtc_state->adjusted_mode;
> >
> >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
> >
> > @@ -201,8 +212,8 @@ static const struct drm_encoder_funcs tegra_rgb_enc=
oder_funcs =3D {
> >  };
> >
> >  static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_=
funcs =3D {
> > -     .disable =3D tegra_rgb_encoder_disable,
> > -     .enable =3D tegra_rgb_encoder_enable,
> > +     .atomic_disable =3D tegra_rgb_encoder_disable,
> > +     .atomic_enable =3D tegra_rgb_encoder_enable,
> >       .atomic_check =3D tegra_rgb_encoder_atomic_check,
> >  };
> >
> > diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> > index ebac9068b670f..45a9ea94c4355 100644
> > --- a/drivers/gpu/drm/tegra/sor.c
> > +++ b/drivers/gpu/drm/tegra/sor.c
> > @@ -2203,7 +2203,8 @@ static void tegra_sor_hdmi_scdc_start(struct tegr=
a_sor *sor)
> >       }
> >  }
> >
> > -static void tegra_sor_hdmi_disable(struct drm_encoder *encoder)
> > +static void tegra_sor_hdmi_disable(struct drm_encoder *encoder,
> > +                                struct drm_atomic_commit *comm_state)
> >  {
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > @@ -2244,13 +2245,17 @@ static void tegra_sor_hdmi_disable(struct drm_e=
ncoder *encoder)
> >       host1x_client_suspend(&sor->client);
> >  }
> >
> > -static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
> > +static void tegra_sor_hdmi_enable(struct drm_encoder *encoder,
> > +                               struct drm_atomic_commit *comm_state)
> >  {
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       unsigned int h_ref_to_sync =3D 1, pulse_start, max_ac;
> >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> >       struct tegra_sor_hdmi_settings *settings;
> > +     struct drm_connector_state *conn_state;
> >       struct tegra_sor *sor =3D to_sor(output);
> > +     struct drm_crtc_state *crtc_state;
> > +     struct drm_connector *connector;
> >       struct tegra_sor_state *state;
> >       struct drm_display_mode *mode;
> >       unsigned long rate, pclk;
> > @@ -2259,7 +2264,10 @@ static void tegra_sor_hdmi_enable(struct drm_enc=
oder *encoder)
> >       int err;
> >
> >       state =3D to_sor_state(output->connector.state);
> > -     mode =3D &encoder->crtc->state->adjusted_mode;
> > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_state=
, encoder);
> > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, con=
nector);
> > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_sta=
te->crtc);
> > +     mode =3D &crtc_state->adjusted_mode;
> >       pclk =3D mode->clock * 1000;
> >
> >       err =3D host1x_client_resume(&sor->client);
> > @@ -2657,8 +2665,8 @@ static void tegra_sor_hdmi_enable(struct drm_enco=
der *encoder)
> >  }
> >
> >  static const struct drm_encoder_helper_funcs tegra_sor_hdmi_helpers =
=3D {
> > -     .disable =3D tegra_sor_hdmi_disable,
> > -     .enable =3D tegra_sor_hdmi_enable,
> > +     .atomic_disable =3D tegra_sor_hdmi_disable,
> > +     .atomic_enable =3D tegra_sor_hdmi_enable,
> >       .atomic_check =3D tegra_sor_encoder_atomic_check,
> >  };
> >
> > --
> > 2.53.0
> >
> >
>
>
>
>
