Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12E606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmpn2sLP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADDF10E4FD;
	Fri, 27 Nov 2026 09:22:01 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A87510E4F6
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:21:54 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3869f03af6aso6963151eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 01:21:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795771314; cv=none;
 d=google.com; s=arc-20260327;
 b=hsZPowA17hVGJS5BRD/jWTqawp44PmGhfzwLBT4+6iuJsDbegQJDR816SgpBOYJNzx
 KStcM2PkmiiPzkMre0sSZ/TaMLYjPWe3bQhIR37tnWTE5biXu+b0ARFBLNtdiyXmFPd1
 L8wN7y4tprF1YTMJOck5Wz3Hdv1dTTMXHcsv/FvZamnZn/kD2Tbm4e6SaejH1tlEcimH
 Iz86l1xXlANetbuovMVStgqVamv12xmm7i7cPW7yjC8gKsQDqQKV1gYuSsSoGH61uJA6
 jDTFzpDXUE3NI3xW2OxWjSkJka9edoJ1qmeWUd+wgI/hnpTqaLI0Yc9GNw3VPwTQsrER
 5HKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=htV1Nze1V9TPe9ypwx86PJUFfDuF+mF97F+ZRWmyzZw=;
 fh=dDDDhPz/bcyFrsuWoq0zhEra6tDa6tiIDHqkqaalFW0=;
 b=XBZU7Y+M11gJ+vu1n038llcE3qOy093OoD5ZbmNP8wu5oqkf7Y9Vke/kQvsGPukLYz
 Bp3wAikt7QVldooxUt+SywizzvlbmcOCJapARdAZ8tdXsdnzrQ9m99XYlGspXax9SESX
 RzpcnPjqNiQr9p2j05H1AGfcHOZR6RSe0wmjkpJhhxwlJQl34/p4Ma6t2gLZv451uvSE
 DYH2KJd2oH3PXaNlZUkcL9Zi0qITsJ1060mhZUMsCGngIO6yVXiC5XumfnLAj5lX55LD
 ln7+ejJd6ynBZGmGp0eJxZuG/cIsz41eq6yKrFFs8oz1gD2Ha3FAnzHxlfloZm0OkbA1
 nPAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795771314; x=1796376114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=htV1Nze1V9TPe9ypwx86PJUFfDuF+mF97F+ZRWmyzZw=;
 b=qmpn2sLPIW8FB9399FrXROiqEaAhOgjBsxPF+yqVyJVgUMd5nIr9G/5YkceGfGDp0N
 cOo1eVBcoS7fPT1dDXDUpOR/Qx6EGay2eLQMljVR8qg3uSc0HN8pKEzXLWNFB94DWkBb
 I8wUxcz3O1zaFy+zextpp3inia+k8zGMEThfRWljHF99ag8zGVXoOOghuda5tgpMy+s+
 zOpyX0EbkmtqDQbTL+IwtRaw0MWC2/LEX/Rf38aQl4+kW40VUQIoHmdn5i/sgqiCu2wJ
 2iHIwDscjQ+s8NW7k/MTyN+rWSGictJfloV122uN7pGB17cObwN9LItryUu+CnQq5kJu
 x/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771314; x=1796376114;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=htV1Nze1V9TPe9ypwx86PJUFfDuF+mF97F+ZRWmyzZw=;
 b=JH/uCD3MO9kYazESRZ28dDa2XgmpSaFYk5E16xx+9i9YYp8mSjbPdAWOlFt7Cq/cG7
 kyP4OBw3m6by69en4GIDtJX9elppW3Yoc8a4iIe1UmGl0+dXXh3v5wiW8VTcsqSu3elI
 3pgMnjbCKYAw/IGxn8XedOyFjLf7qlByHRkZFSTdy53kVNnag0aFm23GMtkzY6XLD6PG
 3Kad5NEI6TeJrQTBNmRl1u7KRgSqdIqMZxUEmiVnr/5lLavhh2a8P9caDlRyPMPgwO7v
 Pyuz8J5pXnw5sqkCJ4Rd4O7NzvCRp38jEm9zQwsOj9mpHUd1K6SUSUKOpUzft7AxYe9Q
 hnzw==
X-Forwarded-Encrypted: i=1;
 AL+hErFI+ZI5yw8yc/mIo56W8xGzKqnrQbTEYXdv2bZObK1mQIHidroGfVp9NWqWw1hV7Txty0SLZta1UQ4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9H7SslXkCx9d7x/uxIid0YKNGvvczJoOOoj3uZL9WSv/Icuyhg
 DdNY4tBLtA8S64ASnXRMJVLWOEYL3WHvrfFKqUFb18WbIejMNZhSAD/IvAVVbXdBIyGrJvx51DA
 afBbWYFYmbTYbM3Ru+cO+mfnSo7M1QMo=
X-Gm-Gg: AZFdTZfV5qF4zCYes1XcnKcSUTg4ZzEmKdwAd4WrX6oXKkROtf/6daWmoqyu5tl6f8a
 KT0r7f2rPCAFN1Hc3rgOOn/bNvKLHUN26VmnLBd+mBOLPZJrrB6hA/7AZ/AlYYiEMqBG4Voy/9w
 x80Eopf+budpkggI/ibUuxoFtOrmv+jlzv9/zVpcHhqWmB9fgUvuX97TFDBEroYZD7ZGPYNGnym
 /W0AlX2IaUeaSElNbzbfbvtAueABGXWS4DgJewakMwlzkgUx4FB6XIczUNMPZWpd2+KsgvVENAv
 Yl4BiYL314pbeawmiohlazMJsv7Cf9waodclPiykll8wy7Z7rDgxUJXssY79xQ+/gCWeE6QJmnT
 Aq/llFbS3sGPlsFtjOlYedKrNkBGJ/ELSfLIJzs8ktgAcjdjYlRTABshQpH0tjAdb4LXRMh9wAP
 UkPmpVOXJ9pQxOlF66u/xnNpALnTDuJQ==
X-Received: by 2002:a05:7301:6782:b0:385:2ea8:aac7 with SMTP id
 5a478bee46e88-3852ea8d7d4mr33082873eec.23.1795771313759; Fri, 27 Nov 2026
 01:21:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-11-clamor95@gmail.com>
 <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
In-Reply-To: <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 11:21:42 +0200
X-Gm-Features: Aa3M54r9PD-vpDJoY894sGmJ09TY6pWekwcQ8wsOPcIm9P2nFgYst_79Ta6LzYI
Message-ID: <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
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

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08:2=
2 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > Parameterize configuration based on bus flags passed from the bridge or
> > panel. The list of supported flags includes now pixel clock polarity,
> > display enable (DE) polarity, and data alignment.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> > index d48d498068ac8..faecd6f94359f 100644
> > --- a/drivers/gpu/drm/tegra/rgb.c
> > +++ b/drivers/gpu/drm/tegra/rgb.c
> > @@ -5,6 +5,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/media-bus-format.h>
> >  #include <linux/of.h>
> >
> >  #include <drm/drm_atomic_helper.h>
> > @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm_enc=
oder *encoder,
> >       struct tegra_output *output =3D encoder_to_output(encoder);
> >       struct tegra_rgb *rgb =3D to_rgb(output);
> >       struct drm_connector_state *conn_state;
> > +     struct drm_bridge_state *bridge_state;
> >       struct drm_crtc_state *crtc_state;
> >       struct drm_connector *connector;
> >       struct drm_display_mode *mode;
> > @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct drm_e=
ncoder *encoder,
> >       crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->c=
rtc);
> >       mode =3D &crtc_state->adjusted_mode;
> >
> > +     /* Get but flags from the bridge state. */
>
> s/but/bus/
>
> > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, output->b=
ridge);
> > +     if (bridge_state)
> > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > +     else
> > +             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > +                         DRM_BUS_FLAG_DE_HIGH |
> > +                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> > +
> >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
> >
> >       value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> >       tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
> >
> > -     /* configure H- and V-sync signal polarities */
> > +     /* configure H- and V-sync and pixel clock signal polarities */
> >       value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(1));
> >
> >       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct drm_e=
ncoder *encoder,
> >       else
> >               value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> >
> > +     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> > +             value &=3D ~BIT(PIN_LSC0);
> > +     else
> > +             value |=3D BIT(PIN_LSC0);
>
> I think this is the wrong way around: SAMPLE_POSEDGE means that the
> pixel data is sampled on a rising edge. That is, it should be driven on
> the low edge so it's ready for sampling in time for the rising edge.
>
> LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly, 1)
> corresponds to a data transition on the falling edge, i.e. sampling on
> the rising edge.
>
> Section 31.9.6 states this a bit more clearly: "an active low pixel
> clock means that the data changes on the falling edge of the clock, to
> be latched on the rising edge".
>

DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE =3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE

Should I replace with DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE?

> > +
> >       tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
> >
> > -     /* XXX: parameterize? */
> > -     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
> > -             DISP_ORDER_RED_BLUE;
> > +     /* configure DE signal polarities */
> > +     value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(3));
> > +
> > +     if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> > +             value |=3D BIT(PIN_LSPI);
> > +     else
> > +             value &=3D ~BIT(PIN_LSPI);
> > +
> > +     tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
> > +
> > +     /* configure DATA order and alignment */
> > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > +
> > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > +             value |=3D DISP_ALIGNMENT_LSB;
> > +     else
> > +             value &=3D ~DISP_ALIGNMENT_LSB;
>
> DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check
> here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/MSB
> bit ordering in a classical way, instead:
>
>   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
>   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
>               R[7:2], G[7:2], B[7:2]};
>
>   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
>   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
>
> I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> panels depending on the layout. So the correct value depends on how the
> panel is wired to the SoC on the board. Hence, I think we should
> describe this with a new property in device tree under rgb/dbi or
> endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> document that this means the above kind of wiring - not all RGB888
> panels use it.
>

Ugh, why is this so confusing...

> > +
> >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTROL);
> >
> >       tegra_dc_commit(rgb->dc);
> > --
> > 2.53.0
> >
