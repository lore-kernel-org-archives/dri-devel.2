Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76FDC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3B610E20B;
	Mon, 27 Jul 2026 16:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sn85PcyF";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A8710E47B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 16:20:03 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so296944a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169203; cv=none;
 d=google.com; s=arc-20260327;
 b=UKat1HZymsSLo55K91XansICnEHs9Mon/mw1wev4m7wJyAii59l+jeXYAALwYeKBNB
 kJzkKjweBVPMAIHtJoNULL8nNe/d+Wc6fBwW6CcudJL+XqG85EabTiZyF64EwJJP9VlA
 dj2FGNg+eghHTX9Q19nGyPIyUYpi2IgO83E7duI20nofkXrkprMEmqfM5PU/tsC/bO7i
 BST8zPZ3mwTRVFRIqjtvrjrUU/NhUyY9QVhzx6Ww85PM/3ZsmfHw7jaFjDv+H0yK7uBz
 7V9G6i0VQSQyNK1cAwDVo97c+n/Mn0OuB7CVLJY+Bk3C7fl718H06MmE49n7MhVcD5+S
 IQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 fh=oSrrB//bFwtFkPiKNpcPyuYww+0i1weDL30DE2nz7a0=;
 b=VO4/YWEWyeEKYBayyTL0PzGZSTNzorhZU+Nh4WTdSosJ1yar7u6ia7sWRD5VaWpxTp
 to526BDEeKZ0Q/Ldo5xAyx9A+SZGRPnfGfZu1dZ0XPmd4V3PxiAjpPSq5LTRGhU4PX2+
 GzcdIZosauvHL7/ABG3gxFht+typvMK1a7Qk/XsxHiRwzYJHqmCkx/nh6WJlY8ADmrdu
 dbr51KzdVpRUwYTvhC+SKSpcnURaj81BtVL5KOLr34CAX1nlaI7mzzd+7MKPX2TeZdrS
 qYlL8+PUnB1t9HPLXKBpZ7wvhuWdY1/RYvRJ67fYyMoe1v+hTg2853lVnOmmpunUc5zL
 zY1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169203; x=1785774003; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 b=sn85PcyF6LVTB69GRwF4ymmSwtG+6CrJaFwiP5mu6yIEDiWSGADjDxvtswUlyEzEnR
 VuOTvI8SoPlD7WIfNW5nSMP/QwGM7Tkz6m/+2fkmWB+jxI2tfWb6zpyK3l61J1GSGqZt
 CicBl+0tjzrUjdPacX+5Hn09ZcPa4e6+ix7gbXPrVNHqviCrFD3016X0lRYhxnYJ8VS5
 kBRU6BTNUATMYFpY4BU805yH6Bb8OxAhdNPOZR49eoqgNZb+NEwUqEojzya+vB9nLvye
 d/ohP2Xs0xBWHNs8CXi++vVHx3lRcrcDO8wsgIDEHyU4kxZndJYBPAUaglhq3Pjk87dj
 +fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169203; x=1785774003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ksM5PQny+NdDsJAGpJTSCPU1EsruCSQEucz5vSK3KE=;
 b=ieq/UwO3AhSPkjbfVP6GrBI79YHN8H6bRmaukV6qzbax9BC2VFpMgn/UIDXQKNnXlY
 Aab7aU1E95IQDdzzQIELD2+UaCCXQV0cwNRMduTwk6V8bRi4l4G74RyttPXwfvT4yhmM
 C/whwlL4/1RkdAhuUcgXefPH8Qh8nop5e4IZQbW6AYT1a5DoG5/PlnFxJCOO41c6pQ3d
 XdB3OtyXL2Uzb85TXv2berfEJx1mnq24jjt4S33kkrXA8fZduiopVXNzXTcHFqlx3up+
 s313xMZK4iPoA77sThEI2EKtP+RnZKHuH/Ab0uCELWr6onLo7I9OD+12qEOTH6QHNYW1
 el6A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq89jvAEu2Ju9diCQwpRy5djRFv0DAsOZilcKisvGeGZodlxRgrR726+Pwe0+XK+vwq33ag9exUgRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu+ti7+tBxEhYH1lDRK1/geErQZPXQRiBFrutRt3C4THFFEz1P
 Z4VrUlCop026ZegejO4uUVGVezekE7lE6Un0+nqwLLuza/6EeRr0H9qCzwzEzl+9nCBb6NinWkO
 wNNiAQepDxT4MEBseQybFFXZhHJL6F54=
X-Gm-Gg: AR+sD116RNVvp/nIArYFn+0FbaE5HG3RbnNYanTiSKe84mUfihdSEc28MPPUnbrPSGz
 aephqThXsvbxhojNhvOEUy4X5edfIkShA1YvXddf3zAQKFxwnhGhnfcMtJ/OiJbFKB/RuJtpe8M
 ai/+Xns67wLko16Djne2mBs3viEWngX75187dgneDYa4121PEGAohCSIlGBCRcvtzivtBqZqhcJ
 ZJBNRANKdOSXsT/EGulJ6nW9CwJp16bFU/D/DxyOJhPSagGLuMWhZFhDGl5VkOTKFYHuVY0j0ls
 LeaSfVJWjdmw7bIjk/LTsYRglnFSd1YUspWNEMOv2hP9zPc4EH/+heWEFBu/7voW/0prf86UiWs
 Qbb7T4rHKHk+w1wN0vk+yba+raTHP5l8=
X-Received: by 2002:a17:90a:c796:b0:38f:57f0:1f51 with SMTP id
 98e67ed59e1d1-38f57f023e2mr2547790a91.0.1785169203100; Mon, 27 Jul 2026
 09:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260723042548.1225691-1-jirislaby@kernel.org>
 <PH8PR12MB7279B4E7FAA1899E488AB356F9C02@PH8PR12MB7279.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB7279B4E7FAA1899E488AB356F9C02@PH8PR12MB7279.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:19:50 -0400
X-Gm-Features: AUfX_myjQVzTaejoUa5qrWpmqSUuZkXKPZhJudMXjLu_KoDlhAdYzYkpxhIhf-A
Message-ID: <CADnq5_PK84e0Rx94=U+J8a5GHFgyqhQzDTTpiCD10CheKt+Cwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: use proper context for logging
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
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

Bhawan, I assume you already committed this?

Thanks,

Alex

On Thu, Jul 23, 2026 at 1:10=E2=80=AFPM Lakha, Bhawanpreet
<Bhawanpreet.Lakha@amd.com> wrote:
>
> looks good, thank you
>
> Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>
>
> Bhawan
>
> ________________________________________
> From: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Sent: July 23, 2026 12:25 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jiri Sla=
by (SUSE) <jirislaby@kernel.org>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd=
.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpen=
g.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Koenig, Christian <C=
hristian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <=
simona@ffwll.ch>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.=
org>; dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>
> Subject: [PATCH v2] drm/amd/display: use proper context for logging
>
> The same as the rest of the code, get_ss_info_from_atombios() uses
> calc_pll_cs->ctx->logger for logging. But calc_pll_cs->ctx is
> initialized only later in calc_pll_max_vco_construct(). Therefore, any
> output using DC_LOG_SYNC() leads to a NULL pointer deference in
> get_ss_info_from_atombios().
>
> According to Sashiko, the very same problem exists in
> dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers() too.
>
> To avoid accessing the NULL context, use clk_src->base.ctx->logger
> everywhere. That context in base is initialized earlier in
> dce110_clk_src_construct() and dce112_clk_src_construct(). Before
> get_ss_info_from_atombios() or Sashiko's get_pix_clk_dividers functions
> above are actually called. This is done by redefining DC_LOGGER to
> CTX->logger.
>
> Before:
> dce110_clk_src_construct() did:
>  -> sets clk_src->base.ctx =3D ctx;
>  -> ss_info_from_atombios_create()
>    -> get_ss_info_from_atombios()   <- uses calc_pll_cs->ctx  # BOOM
>  -> calc_pll_max_vco_construct()    <- sets calc_pll_cs->ctx
>
> After:
> dce110_clk_src_construct() does:
>  -> sets clk_src->base.ctx =3D ctx;
>  -> ss_info_from_atombios_create()
>    -> get_ss_info_from_atombios()   <- uses clk_src->base.ctx
>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271175
> Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@=
kernel.org/
> Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> ---
> Cc: dri-devel@lists.freedesktop.org
>
> [v2] Set DC_LOGGER to CTX->logger unconditionally (Bhawanpreet).
> [v1] https://lore.kernel.org/all/20260722063210.1144266-1-jirislaby@kerne=
l.org/
> ---
>  .../drm/amd/display/dc/dce/dce_clock_source.c | 20 +++++++++----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index ecb8493ec523..8e3862f6dac2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -45,9 +45,7 @@
>          clk_src->base.ctx
>
>  #define DC_LOGGER \
> -       calc_pll_cs->ctx->logger
> -#define DC_LOGGER_INIT() \
> -       struct calc_pll_clock_source *calc_pll_cs =3D &clk_src->calc_pll
> +       CTX->logger
>
>  #undef FN
>  #define FN(reg_name, field_name) \
> @@ -287,6 +285,7 @@ static bool calc_pll_dividers_in_range(
>  }
>
>  static uint32_t calculate_pixel_clock_pll_dividers(
> +               struct dce110_clk_src *clk_src,
>                  struct calc_pll_clock_source *calc_pll_cs,
>                  struct pll_settings *pll_settings)
>  {
> @@ -474,7 +473,7 @@ static uint32_t dce110_get_pix_clk_dividers_helper (
>  {
>          uint32_t field =3D 0;
>          uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;
> -       DC_LOGGER_INIT();
> +
>          /* Check if reference clock is external (not pcie/xtalin)
>          * HW Dce80 spec:
>          * 00 - PCIE_REFCLK, 01 - XTALIN,    02 - GENERICA,    03 - GENER=
ICB
> @@ -517,12 +516,14 @@ static uint32_t dce110_get_pix_clk_dividers_helper =
(
>                  /*Calculate Dividers by HDMI object, no SS case or SS ca=
se */
>                  pll_calc_error =3D
>                          calculate_pixel_clock_pll_dividers(
> +                                       clk_src,
>                                          &clk_src->calc_pll_hdmi,
>                                          pll_settings);
>          else
>                  /*Calculate Dividers by default object, no SS case or SS=
 case */
>                  pll_calc_error =3D
>                          calculate_pixel_clock_pll_dividers(
> +                                       clk_src,
>                                          &clk_src->calc_pll,
>                                          pll_settings);
>
> @@ -568,7 +569,6 @@ static uint32_t dce110_get_pix_clk_dividers(
>  {
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
>          uint32_t pll_calc_error =3D MAX_PLL_CALC_ERROR;
> -       DC_LOGGER_INIT();
>
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
> @@ -600,7 +600,6 @@ static uint32_t dce112_get_pix_clk_dividers(
>                  struct pll_settings *pll_settings)
>  {
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
> -       DC_LOGGER_INIT();
>
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
> @@ -1442,8 +1441,6 @@ static uint32_t dcn3_get_pix_clk_dividers(
>          unsigned long long actual_pix_clk_100Hz =3D pix_clk_params ? pix=
_clk_params->requested_pix_clk_100hz : 0;
>          struct dce110_clk_src *clk_src =3D TO_DCE110_CLK_SRC(cs);
>
> -       DC_LOGGER_INIT();
> -
>          if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
>                          || pix_clk_params->requested_pix_clk_100hz =3D=
=3D 0) {
>                  DC_LOG_ERROR(
> @@ -1513,7 +1510,6 @@ static const struct clock_source_funcs dce110_clk_s=
rc_funcs =3D {
>          .get_dp_dto_frequency_100hz =3D get_dp_dto_frequency_100hz
>  };
>
> -
>  static void get_ss_info_from_atombios(
>                  struct dce110_clk_src *clk_src,
>                  enum as_signal_type as_signal,
> @@ -1526,7 +1522,7 @@ static void get_ss_info_from_atombios(
>          struct spread_spectrum_info *ss_info_cur;
>          struct spread_spectrum_data *ss_data_cur;
>          uint32_t i;
> -       DC_LOGGER_INIT();
> +
>          if (ss_entries_num =3D=3D NULL) {
>                  DC_LOG_SYNC(
>                          "Invalid entry !!!\n");
> @@ -1657,6 +1653,7 @@ static void ss_info_from_atombios_create(
>  }
>
>  static bool calc_pll_max_vco_construct(
> +                       struct dce110_clk_src *clk_src,
>                          struct calc_pll_clock_source *calc_pll_cs,
>                          struct calc_pll_clock_source_init_data *init_dat=
a)
>  {
> @@ -1808,6 +1805,7 @@ bool dce110_clk_src_construct(
>          ss_info_from_atombios_create(clk_src);
>
>          if (!calc_pll_max_vco_construct(
> +                       clk_src,
>                          &clk_src->calc_pll,
>                          &calc_pll_cs_init_data)) {
>                  ASSERT_CRITICAL(false);
> @@ -1822,7 +1820,7 @@ bool dce110_clk_src_construct(
>
>
>          if (!calc_pll_max_vco_construct(
> -                       &clk_src->calc_pll_hdmi, &calc_pll_cs_init_data_h=
dmi)) {
> +                       clk_src, &clk_src->calc_pll_hdmi, &calc_pll_cs_in=
it_data_hdmi)) {
>                  ASSERT_CRITICAL(false);
>                  goto unexpected_failure;
>          }
> --
> 2.55.0
