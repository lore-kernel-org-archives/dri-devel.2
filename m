Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7136606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sVBPXWWF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3730E10E7AF;
	Fri, 27 Nov 2026 13:47:34 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9353010E7AF
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:47:27 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-385c497bf94so8032734eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:47:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795787247; cv=none;
 d=google.com; s=arc-20260327;
 b=JJTSrkJAz+a/+IQA4jrrozB9OQ30wZG/W2VhEPHV01zyRKHH7W5gLL9t6Hjk9quHkN
 sbd+i2UJUHAVZKHjDZKKvziLRsYhhI192V233LylYQaxY6I06qmO6NWctsdI+/uJDdvD
 WsqmZNBrjeExECsxOymM79GGG/uzt+hryGBEjYeJpHP40A8FoXP/bMF7OBjEyGn1JV5/
 Nj16eZ3qbBPZcxCb3AeyyC/AxXt1cbnImmufXZMPBQLKan46PidchVlduMAPRq2nK5cZ
 EzIL2+etSguNy7o1tmUTjn/t1mPpMrXpRjFTDyRGzIUyqc/4dPlnf9K0cuFa2fR26wYu
 52KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ddtVqoOZQDOONta1BJaQFWf5kTSu9vJTN1sHT88/s58=;
 fh=P5B2VPWYPEbJWevX98AWqa2dLR7AXp6/ixBNd4gPumQ=;
 b=sJzU94mc11oT+4ZFZlvknhHi3aNtD6Zz+DT05pH8vg7XzQCQRSepkR5GOdO03M5fHq
 d7+Npkztaals+5NeqYzxteKAl73FzDHhxFeHTXeODR8Ov9UW8B80rVxEuoWdeg3H8Qss
 vowgkFP9QTQtXtaB2fqzBSkRhtDL7zwsfYM4PyO4zgh2vNTc0jehaikuU/tmlpdzzRpo
 I4/uv8o9jfyi/oFMEOW/6LuBCC3S8x80U561hd2U4gZo9Tx17MoJFJM3dbGSsy5E1P00
 eP98rolt0ajcW31abCUbHcymjqb2lgvDthARtc1mJbZbVel/94BbKzhLYeLU1Jr3Xe87
 b6Jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795787247; x=1796392047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ddtVqoOZQDOONta1BJaQFWf5kTSu9vJTN1sHT88/s58=;
 b=sVBPXWWF1sGMwlbRg3IPWuzUoBR2XwpqjmZlaDioduEypD0GL4/6AXqDh6+bd8OS70
 5XUYOCaXlPWL/WkL7mAwHGL9IX3SrZCMgZNd3pDqPN6g3FGB4pYWFbkpjgoMN4A1HakF
 2CS4814wnWDq1OYiTuq+gLoMSmGSGT8X7CxjTNEsBcvx0ETf9Kqq29dCczSx6AjAFnWS
 EH2D835hjeI371ZriV6qxl9Rftl/yzNRDsn/gc975tqkA2/UTt4Kv6DMGWKc0jfsl0vM
 UuzxBUJKydasGRgeUyxFHNhuUbM6eWtWxvetqjagl611Ovw/9HQN6wMqmyXpCDACaPBi
 v28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787247; x=1796392047;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ddtVqoOZQDOONta1BJaQFWf5kTSu9vJTN1sHT88/s58=;
 b=EKNhs3g3iEWpWysk2LhHr90OG+rt8mMbntxVKs+64uU+uiW05KABp4gn4K1g83NijB
 ETmdbMCdmj0EU2BpNYVDzGobi0iGX0FMz8wkirup/JIEmcjcL4Tx2JEOTUYMznCAST4E
 5+l6Qc9aEQ2D9o1kprIllUAy6+tdFwibgEhcSi7+u5zvKVhoRg5FwUJF3/j42iIC7rcF
 Z717nmtYXfZFtw5qu3mLUWy2Z9PkcPSTTqrXFPyHsRfMKw84U7hOJfQ2XPTKcLfeU5Jy
 vm7/NlhreV0WmDoTtb0ftRyAPx6HVOPnxiE+8Ve1cB3sb2+OKpM7aO5DVlFu5e13eRMV
 6JrA==
X-Forwarded-Encrypted: i=1;
 AL+hErF2IyFSoEBXgTvHtM0JJbU08BI+jl6bk3dZF8d/PuW49vBgLkrCVV/0J8W6L7FemVJzKMEEJfDuJw4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+lw3cwg3u9qlJPyIeQGllrmhxJksVX3OZcMMWrSEJS8w335DR+
 4xOgqM6tV/dvkWpswhuV5gxkNW8c8hj+fUGXvgG4EWf1F7TjTi30WKneVUJHC2pY/V8p/c3MBrq
 ru3DuvZbp5B4pKZ5SYaOvqCKV2W7hgDY=
X-Gm-Gg: AZFdTZdKznouHuS/MF8N9njZKEqJzGzLcguDA7vBBxmU5JK2XL9O91ojo91f2GJcpmJ
 ZMeDnWHdbcEr8DUAd6hkkK78F+FhqpbEmxEXHMwrVJAjGrXRUOVdmE8x4j8/LXw+Jxg6N8p1E5Y
 Yxd5n4bau3DwnDN85LJuqEkNdyfbEtxl4GW5PDHg6zp3xPSBFvR+kxdiGRqQyJiLuH8qd2j5seH
 BYZCMJtvLV0NmOlpxTao8sg3Cwg2O9ruWiuKwjooz+Oa9aslz0SwPC7md7rVznnrtRvtEqvEJml
 c+b9dX/B4AgOSVy+kZSrgErN6mhKnWPhlAa3i+t72P/hdJyLy4hoTgMf9SEyn9eWoKZL3KjndI5
 2a4kAcwWhEDsVVv3leHUHPhmgzauPxvOSK66t0nH+ixKHkoUq5WDAFXwclpM8lT4/pmMV/R/zES
 2ErNRI4yymFUuUfRp2AOgAMwjU5SBaeg==
X-Received: by 2002:a05:7300:f0c2:b0:386:688:7f25 with SMTP id
 5a478bee46e88-386068880f5mr24828583eec.18.1795787246637; Fri, 27 Nov 2026
 05:47:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-10-clamor95@gmail.com>
 <mxfdX1kqQz209wWYqFOofg@nvidia.com>
 <CAPVz0n1ZoMfPWKXSbLENDh9f8qxZbdbnvLxbiLxo8fZS-u5Etw@mail.gmail.com>
In-Reply-To: <CAPVz0n1ZoMfPWKXSbLENDh9f8qxZbdbnvLxbiLxo8fZS-u5Etw@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 15:47:15 +0200
X-Gm-Features: Aa3M54rOwXt4RRvrVhin6s6sWmOMRKHUvBDVMPxAeq5_EzajOawjB-8Sauy4qVM
Message-ID: <CAPVz0n1Q85nGx3Aa1Vc8sxsX7cVdMqzk_G5R+5XMaMrLotQC-w@mail.gmail.com>
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

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11:1=
7 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 07=
:24 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Switch to using the atomic versions of the enable() and disable()
> > > operations.
> > >
> > > This is required for acquiring the next bridge state without causing
> > > crashes, in order to properly set up the encoder.
> >
> > This is a bit vague. I'd make an explicit reference to RGB needing
> > access to the bridge state, which is not possible with the non-atomic
> > functions, and then explaining that DSI / HDMI / SOR are converted for
> > consistency.
> >
>
> Noted
>
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dsi.c  | 20 +++++++++++++++-----
> > >  drivers/gpu/drm/tegra/hdmi.c | 20 +++++++++++++++-----
> > >  drivers/gpu/drm/tegra/rgb.c  | 23 +++++++++++++++++------
> > >  drivers/gpu/drm/tegra/sor.c  | 18 +++++++++++++-----
> > >  4 files changed, 60 insertions(+), 21 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.=
c
> > > index 6d6adc485e51e..cd61070072beb 100644
> > > --- a/drivers/gpu/drm/tegra/dsi.c
> > > +++ b/drivers/gpu/drm/tegra/dsi.c
> > > @@ -855,7 +855,8 @@ static void tegra_dsi_unprepare(struct tegra_dsi =
*dsi)
> > >               dev_err(dsi->dev, "failed to suspend: %d\n", err);
> > >  }
> > >
> > > -static void tegra_dsi_encoder_disable(struct drm_encoder *encoder)
> > > +static void tegra_dsi_encoder_disable(struct drm_encoder *encoder,
> > > +                                   struct drm_atomic_commit *comm_st=
ate)
> > >  {
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > > @@ -919,16 +920,25 @@ static int tegra_dsi_prepare(struct tegra_dsi *=
dsi)
> > >       return 0;
> > >  }
> > >
> > > -static void tegra_dsi_encoder_enable(struct drm_encoder *encoder)
> > > +static void tegra_dsi_encoder_enable(struct drm_encoder *encoder,
> > > +                                  struct drm_atomic_commit *comm_sta=
te)
> > >  {
> > > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjust=
ed_mode;
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > > +     struct drm_connector_state *conn_state;
> > >       struct tegra_dsi *dsi =3D to_dsi(output);
> > > +     struct drm_crtc_state *crtc_state;
> > > +     struct drm_connector *connector;
> > >       struct tegra_dsi_state *state;
> > > +     struct drm_display_mode *mode;
> > >       u32 value;
> > >       int err;
> > >
> > > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_sta=
te, encoder);
> > > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, c=
onnector);
> > > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_s=
tate->crtc);
> > > +     mode =3D &crtc_state->adjusted_mode;
> > > +
> > >       err =3D tegra_dsi_prepare(dsi);
> > >       if (err < 0) {
> > >               dev_err(dsi->dev, "failed to prepare: %d\n", err);
> >
> > The function also uses encoder->crtc and tegra_dsi_get_state. Should
> > these be changed to conn_state->crtc and to_dsi_state(conn_state)?
> >
> > Similarly for HDMI / SOR.
> >
>
> I must have missed that. Good catch
>

encoder->crtc into conn_state->crtc is pretty straight forward, but
tegra_dsi_get_state() is more obscure to me, how should I approach it?

> > > @@ -1059,8 +1069,8 @@ static const struct drm_encoder_funcs tegra_dsi=
_encoder_funcs =3D {
> > >  };
> > >
> > >  static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helpe=
r_funcs =3D {
> > > -     .disable =3D tegra_dsi_encoder_disable,
> > > -     .enable =3D tegra_dsi_encoder_enable,
> > > +     .atomic_disable =3D tegra_dsi_encoder_disable,
> > > +     .atomic_enable =3D tegra_dsi_encoder_enable,
> > >       .atomic_check =3D tegra_dsi_encoder_atomic_check,
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdm=
i.c
> > > index e8c4347f09e69..a78279810dd82 100644
> > > --- a/drivers/gpu/drm/tegra/hdmi.c
> > > +++ b/drivers/gpu/drm/tegra/hdmi.c
> > > @@ -1166,7 +1166,8 @@ tegra_hdmi_connector_helper_funcs =3D {
> > >       .mode_valid =3D tegra_hdmi_connector_mode_valid,
> > >  };
> > >
> > > -static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder)
> > > +static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder,
> > > +                                    struct drm_atomic_commit *comm_s=
tate)
> > >  {
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > > @@ -1209,18 +1210,27 @@ static void tegra_hdmi_encoder_disable(struct=
 drm_encoder *encoder)
> > >               dev_err(hdmi->dev, "failed to suspend: %d\n", err);
> > >  }
> > >
> > > -static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
> > > +static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder,
> > > +                                   struct drm_atomic_commit *comm_st=
ate)
> > >  {
> > > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjust=
ed_mode;
> > >       unsigned int h_sync_width, h_front_porch, h_back_porch, i, reke=
y;
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > >       struct tegra_hdmi *hdmi =3D to_hdmi(output);
> > > +     struct drm_connector_state *conn_state;
> > > +     struct drm_crtc_state *crtc_state;
> > >       unsigned int pulse_start, div82;
> > > +     struct drm_connector *connector;
> > > +     struct drm_display_mode *mode;
> > >       int retries =3D 1000;
> > >       u32 value;
> > >       int err;
> > >
> > > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_sta=
te, encoder);
> > > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, c=
onnector);
> > > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_s=
tate->crtc);
> > > +     mode =3D &crtc_state->adjusted_mode;
> > > +
> > >       err =3D host1x_client_resume(&hdmi->client);
> > >       if (err < 0) {
> > >               dev_err(hdmi->dev, "failed to resume: %d\n", err);
> > > @@ -1460,8 +1470,8 @@ tegra_hdmi_encoder_atomic_check(struct drm_enco=
der *encoder,
> > >  }
> > >
> > >  static const struct drm_encoder_helper_funcs tegra_hdmi_encoder_help=
er_funcs =3D {
> > > -     .disable =3D tegra_hdmi_encoder_disable,
> > > -     .enable =3D tegra_hdmi_encoder_enable,
> > > +     .atomic_disable =3D tegra_hdmi_encoder_disable,
> > > +     .atomic_enable =3D tegra_hdmi_encoder_enable,
> > >       .atomic_check =3D tegra_hdmi_encoder_atomic_check,
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.=
c
> > > index 227a178f761bd..d48d498068ac8 100644
> > > --- a/drivers/gpu/drm/tegra/rgb.c
> > > +++ b/drivers/gpu/drm/tegra/rgb.c
> > > @@ -90,7 +90,8 @@ static void tegra_dc_write_regs(struct tegra_dc *dc=
,
> > >               tegra_dc_writel(dc, table[i].value, table[i].offset);
> > >  }
> > >
> > > -static void tegra_rgb_encoder_disable(struct drm_encoder *encoder)
> > > +static void tegra_rgb_encoder_disable(struct drm_encoder *encoder,
> > > +                                   struct drm_atomic_commit *state)
> > >  {
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > > @@ -99,12 +100,22 @@ static void tegra_rgb_encoder_disable(struct drm=
_encoder *encoder)
> > >       tegra_dc_commit(rgb->dc);
> > >  }
> > >
> > > -static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
> > > +static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
> > > +                                  struct drm_atomic_commit *state)
> > >  {
> > > -     struct drm_display_mode *mode =3D &encoder->crtc->state->adjust=
ed_mode;
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > > -     u32 value;
> > > +     struct drm_connector_state *conn_state;
> > > +     struct drm_crtc_state *crtc_state;
> > > +     struct drm_connector *connector;
> > > +     struct drm_display_mode *mode;
> > > +     u32 bus_flags, value;
> > > +
> > > +     /* Get mode flags */
> > > +     connector =3D drm_atomic_get_new_connector_for_encoder(state, e=
ncoder);
> > > +     conn_state =3D drm_atomic_get_new_connector_state(state, connec=
tor);
> > > +     crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state-=
>crtc);
> > > +     mode =3D &crtc_state->adjusted_mode;
> > >
> > >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable)=
);
> > >
> > > @@ -201,8 +212,8 @@ static const struct drm_encoder_funcs tegra_rgb_e=
ncoder_funcs =3D {
> > >  };
> > >
> > >  static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helpe=
r_funcs =3D {
> > > -     .disable =3D tegra_rgb_encoder_disable,
> > > -     .enable =3D tegra_rgb_encoder_enable,
> > > +     .atomic_disable =3D tegra_rgb_encoder_disable,
> > > +     .atomic_enable =3D tegra_rgb_encoder_enable,
> > >       .atomic_check =3D tegra_rgb_encoder_atomic_check,
> > >  };
> > >
> > > diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.=
c
> > > index ebac9068b670f..45a9ea94c4355 100644
> > > --- a/drivers/gpu/drm/tegra/sor.c
> > > +++ b/drivers/gpu/drm/tegra/sor.c
> > > @@ -2203,7 +2203,8 @@ static void tegra_sor_hdmi_scdc_start(struct te=
gra_sor *sor)
> > >       }
> > >  }
> > >
> > > -static void tegra_sor_hdmi_disable(struct drm_encoder *encoder)
> > > +static void tegra_sor_hdmi_disable(struct drm_encoder *encoder,
> > > +                                struct drm_atomic_commit *comm_state=
)
> > >  {
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > > @@ -2244,13 +2245,17 @@ static void tegra_sor_hdmi_disable(struct drm=
_encoder *encoder)
> > >       host1x_client_suspend(&sor->client);
> > >  }
> > >
> > > -static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
> > > +static void tegra_sor_hdmi_enable(struct drm_encoder *encoder,
> > > +                               struct drm_atomic_commit *comm_state)
> > >  {
> > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > >       unsigned int h_ref_to_sync =3D 1, pulse_start, max_ac;
> > >       struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> > >       struct tegra_sor_hdmi_settings *settings;
> > > +     struct drm_connector_state *conn_state;
> > >       struct tegra_sor *sor =3D to_sor(output);
> > > +     struct drm_crtc_state *crtc_state;
> > > +     struct drm_connector *connector;
> > >       struct tegra_sor_state *state;
> > >       struct drm_display_mode *mode;
> > >       unsigned long rate, pclk;
> > > @@ -2259,7 +2264,10 @@ static void tegra_sor_hdmi_enable(struct drm_e=
ncoder *encoder)
> > >       int err;
> > >
> > >       state =3D to_sor_state(output->connector.state);
> > > -     mode =3D &encoder->crtc->state->adjusted_mode;
> > > +     connector =3D drm_atomic_get_new_connector_for_encoder(comm_sta=
te, encoder);
> > > +     conn_state =3D drm_atomic_get_new_connector_state(comm_state, c=
onnector);
> > > +     crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_s=
tate->crtc);
> > > +     mode =3D &crtc_state->adjusted_mode;
> > >       pclk =3D mode->clock * 1000;
> > >
> > >       err =3D host1x_client_resume(&sor->client);
> > > @@ -2657,8 +2665,8 @@ static void tegra_sor_hdmi_enable(struct drm_en=
coder *encoder)
> > >  }
> > >
> > >  static const struct drm_encoder_helper_funcs tegra_sor_hdmi_helpers =
=3D {
> > > -     .disable =3D tegra_sor_hdmi_disable,
> > > -     .enable =3D tegra_sor_hdmi_enable,
> > > +     .atomic_disable =3D tegra_sor_hdmi_disable,
> > > +     .atomic_enable =3D tegra_sor_hdmi_enable,
> > >       .atomic_check =3D tegra_sor_encoder_atomic_check,
> > >  };
> > >
> > > --
> > > 2.53.0
> > >
> > >
> >
> >
> >
> >
