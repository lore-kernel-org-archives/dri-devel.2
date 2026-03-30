Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F225FF494F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C9E510E749;
	Mon, 30 Mar 2026 13:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDoSHNsw";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F78610E749
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:17:01 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so721065366b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 06:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774876619; cv=none;
 d=google.com; s=arc-20240605;
 b=bW/t1RZIgXGTOqgCB++CncQlLzQHioL/6Li3YVgk4zR8+iOi4MxWW5eHlIFutI1RBI
 YnXaJHjeKUIAHSusEhx8gOsNeHlhajNp2yOKlaRtuS1yNbljQc+1K9Nd12A4bddo8WMU
 +uC0I8vwAD31pYD9j20gJ4sLANUUi2dfFUuxvLs+iiFZh5H1H3JHz8FHseovrJ586AAK
 Iz+hp+OiVbwxk44wPcm1jlfi1L9pz3HyZ53tWhHah1L5WKAV7dk8J+iqej+KAZuccuL9
 UlegTYrCsoG3lJFyDfe6zw4nrOKXQx2D4eSdT/B6mVXQhdR8rny/wWo6quFOfpif0u9q
 PXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4kSohZ0qIM3gfjNS010B7woW8lEyiEA79TeyzEn0128=;
 fh=0mx+UyH3LFEtXExcfzwpsJyquziRn0x1lQsMrkct25Y=;
 b=MxoN4JrwiIFwOsk/GWvKIu4Z/4wdsNX8JwFPHSKutbpU3zUWVYc+ImXKoYw3yxfrbO
 jfYjiB8PrQg8O0KAd6mRSWEtmQV9UoUC4W6yF3hLugjEQ0NbVcL9KMGbj/Hvu1yJNhWO
 Wy8lxOgiFDoMWm9eK0lTOq6hEAZleywt8sgOBTxmRWb/GRkB6fffJodGm+JFjEbp770s
 SA6Q1/uBzZk4AiJ90E/r+bFZ0eLyesXANlyzhCsOlQn1kzS+HGTdqXnzk9xADYdcCcY9
 UtKiipNcyoV7+gDFXxmycOxjMkUmpyF9wjdfn4svWGfx2g+oUP1FDqi4/Z9XCVt6xYPF
 Mx+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774876619; x=1775481419; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4kSohZ0qIM3gfjNS010B7woW8lEyiEA79TeyzEn0128=;
 b=KDoSHNswugXxekgAMFRiJJKD6EDSFAfRPTJ9/6lwFxqSUtA4igKJmo7IUci7Mny3yq
 Z+KyU2obVqHjWrhPZ4Ur8xL+rcdspMtQziNxeszgBhbxyQvqaIsXo33ZrGgT+EEyy6hM
 sfm+vtqrzQTYXSr2CI8n2nqn+ditOUPT6bMNva6hMIkx/TYnGqVqeTaKY2TYLqXx07ST
 kvtZsQWTtB50RxTW+HGDOzAPhKDUmQvuAvIMsfoHuDImRBOG6aVt947JpVHbpyYP5OgK
 cjJfzFPS5WCWO1FfQrWGP4muWu7/a5c1pY4LPYS4CWVXtaRd4IFA2KIv20O9e3YJHSW1
 ftFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774876619; x=1775481419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kSohZ0qIM3gfjNS010B7woW8lEyiEA79TeyzEn0128=;
 b=GuAIZ9/mlsTT0PfAwaT8qg/CD91xOktObXA9ijOaaIqTCJehETtC4FEj5WA4k0nrI6
 jrMKDABgwTadV/J2/Sgu30AXwOTlmKBGlk0Mx245ULutOwrqjTcCWu37kTyIH6K43cah
 VZEwFC0dTZCrV74dsAm0IoB7IC56ap0/Jlc3dFfOFZ+a5CUKx7y7A8sVJJHpBoon1j7D
 drGRxnPq2/BWwE++xYXIcT5bsjB3Xtk2pPhQov4lgXmlp5E17M0QQAEYICMUnOb8ziZw
 9GE4+S9J04lVpTgzFlDg2S06cZOHHr3Plot6AkSVwR7VkqEfZqix9MoFvTsCgLRwxREO
 6ylA==
X-Gm-Message-State: AOJu0YzPBYfo5XoBKLDv+OEu9ijf2Ltw7TALdBwUHZUDDJaz/lc/NArl
 MAJPZ+Be+fuGBiVZYn9tR4ATGLXx+p7SGGFgPRkCraCulveqtbB81Zq46nhtdtCiDznlqxICoys
 g4T3FsNCsuCMOhm09jzvyRZLUKhBW4rpfaA==
X-Gm-Gg: ATEYQzycoKv4Lab+81E4hyMZEKg7ce63dQGerpUcdFwLxgNOithCSc5Wq/GhCkuDvgK
 0kkGeJwbeF8ac/0a0QlQunf8/8hFmCblU/LlJyv7ZOzyQa3EISUTK4uzDTj+4s9BHw5qEOQhwTR
 +5nqFfBdL1uPgSjHC40b1BD5GlpKlIwUmSEuDWmfQUEjPFWHSE3ha6MQt+AjJyOGk5NTfbstR+B
 8xx+4muFyKpaiVAIHe/mMW26ROL6+qjnUFDdpoNGy9ZSKe1Nx5XwHlj/dbdNwh1TOwArAScHRm8
 Gu1c0MO98HUYS0Jbia4CzGCDHpdU4nXKwR1JOZxc
X-Received: by 2002:a17:907:960b:b0:b98:4186:d2a8 with SMTP id
 a640c23a62f3a-b9b5017581bmr686055666b.12.1774876619270; Mon, 30 Mar 2026
 06:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260113091440.43735-1-avinal.xlvii@gmail.com>
 <20260113091440.43735-3-avinal.xlvii@gmail.com>
In-Reply-To: <20260113091440.43735-3-avinal.xlvii@gmail.com>
From: Avinal Kumar <avinal.xlvii@gmail.com>
Date: Mon, 30 Mar 2026 18:46:46 +0530
X-Gm-Features: AQROBzA1ws1xhxT1FEAnPgPwiFgqO5McFS6gX6h1HzslqpGw98XQUjwEqsVrH7w
Message-ID: <CAJ9xu4wLmihoA75TJvG14+=K6Z2dY-fSrCEKm3raKCaeZmMYvQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Content-Type: multipart/alternative; boundary="000000000000696d7c064e3daa04"
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

--000000000000696d7c064e3daa04
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Neil,

Just checking if anything is remaining here?

Thanks,
Avinal

On Tue, Jan 13, 2026 at 2:45=E2=80=AFPM Avinal Kumar <avinal.xlvii@gmail.co=
m> wrote:

> Changes the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling.
>
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> index 3c3308fc55df..73c5827a15a4 100644
> --- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> +++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> @@ -44,14 +44,24 @@ static inline struct wuxga_nt_panel
> *to_wuxga_nt_panel(struct drm_panel *panel)
>
>  static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
>  {
> -       return mipi_dsi_turn_on_peripheral(wuxga_nt->dsi);
> +       struct mipi_dsi_multi_context dsi_ctx =3D {
> +               .dsi =3D wuxga_nt->dsi
> +       };
> +
> +       mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> +       return dsi_ctx.accum_err;
>  }
>
>  static int wuxga_nt_panel_disable(struct drm_panel *panel)
>  {
>         struct wuxga_nt_panel *wuxga_nt =3D to_wuxga_nt_panel(panel);
>
> -       return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
> +       struct mipi_dsi_multi_context dsi_ctx =3D {
> +               .dsi =3D wuxga_nt->dsi
> +       };
> +
> +       mipi_dsi_shutdown_peripheral_multi(&dsi_ctx);
> +       return dsi_ctx.accum_err;
>  }
>
>  static int wuxga_nt_panel_unprepare(struct drm_panel *panel)
> --
> 2.52.0
>
>

--000000000000696d7c064e3daa04
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Neil,<br><br></div><div>Just checking if anythi=
ng is remaining here?</div><div><br></div><div>Thanks,</div><div>Avinal</di=
v></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jan 13, 2026 at 2:45=E2=80=AFPM Avinal Kuma=
r &lt;<a href=3D"mailto:avinal.xlvii@gmail.com">avinal.xlvii@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Chang=
es the panasonic-vvx10f034n00 panel to multi<br>
style functions for improved error handling.<br>
<br>
Signed-off-by: Avinal Kumar &lt;<a href=3D"mailto:avinal.xlvii@gmail.com" t=
arget=3D"_blank">avinal.xlvii@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../gpu/drm/panel/panel-panasonic-vvx10f034n00.c=C2=A0 =C2=A0| 14 +++=
+++++++++--<br>
=C2=A01 file changed, 12 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers=
/gpu/drm/panel/panel-panasonic-vvx10f034n00.c<br>
index 3c3308fc55df..73c5827a15a4 100644<br>
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c<br>
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c<br>
@@ -44,14 +44,24 @@ static inline struct wuxga_nt_panel *to_wuxga_nt_panel(=
struct drm_panel *panel)<br>
<br>
=C2=A0static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return mipi_dsi_turn_on_peripheral(wuxga_nt-&gt=
;dsi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mipi_dsi_multi_context dsi_ctx =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dsi =3D wuxga_nt-&=
gt;dsi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mipi_dsi_turn_on_peripheral_multi(&amp;dsi_ctx)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dsi_ctx.accum_err;<br>
=C2=A0}<br>
<br>
=C2=A0static int wuxga_nt_panel_disable(struct drm_panel *panel)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct wuxga_nt_panel *wuxga_nt =3D to_wuxga_nt=
_panel(panel);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return mipi_dsi_shutdown_peripheral(wuxga_nt-&g=
t;dsi);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mipi_dsi_multi_context dsi_ctx =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.dsi =3D wuxga_nt-&=
gt;dsi<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mipi_dsi_shutdown_peripheral_multi(&amp;dsi_ctx=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dsi_ctx.accum_err;<br>
=C2=A0}<br>
<br>
=C2=A0static int wuxga_nt_panel_unprepare(struct drm_panel *panel)<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div>

--000000000000696d7c064e3daa04--
