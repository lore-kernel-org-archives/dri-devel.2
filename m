Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3105F54AA0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CB210E661;
	Tue, 24 Mar 2026 13:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZeYBgeAC";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63B210E661
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 13:15:13 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12a6b260693so358325c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 06:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358113; cv=none;
 d=google.com; s=arc-20240605;
 b=WwRq4cj3UQ3kCWgiQ+RQP90stcBZPD8xI5JtSRaR4rW62Py06nUxABJH1n13evu2wI
 igHexIgTbhJ+EQfAt1XQ0iPIB9iwcjZ7aP182xZ0QNcPhtjDgLlM8/ZpZrJmsoMC/KYa
 MmeOzXvO7//bettVTG3d3rvwBtV0sJ//DJ7TNFnhPuVIMsoK89Pb5IRWeaGkSpzd5Ful
 0s1qPDNzYIG3Nqw/4JV1Cu5Jw+DmyDFzlSysrRAMMBAQO4T6SIyMD+t1FFS4JdzJG0uD
 nkQ5KNa3ZNr0Ye4Vc30IeetgB3NKl0Hkeat0dZxGZsdIzZRaVCqJbQVAcvTZ6+JyoWeC
 Bhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pCtaHiT/GmfWC1YHLBLPv7dyjhI0hf8EFCS+TphIl1U=;
 fh=m1/zOflXvcwOasHo3J57WhbPZw9AGSAT1ZlPh/L9SrQ=;
 b=bexI6bEXqo2A/v8tJ80RuuXF2GcDRINq1n6gZpPO90u1JKAWxxMleMbcsCXGQjjKcy
 SU7RfJKmUOG4m4Py3wx6Ou8enDlBJXuR2Ae1qwrZiv2Y1EJVeUq56cBioWixq9kfcMSo
 OLQuhwxmTTY8W1YBKOv+pNQ5uEEIaR01Y7B2w567UFywN2A6zyhyCpYb+SnvnV+S+Hcd
 qTvVfitKO7n+32dYL/kSyaDV755HMllewexFJJKD5qRlSJgwkH9tX/4UvfBsHQgbKgyX
 eMjiSk+QrQ0o6I/Ig5Tm9QCKLtFoCbUX4qeOT5DCd7O5iQ/fZePJdR8Y0YIOidcacPrs
 sFaA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358113; x=1774962913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCtaHiT/GmfWC1YHLBLPv7dyjhI0hf8EFCS+TphIl1U=;
 b=ZeYBgeACxnZTpygUmeFX9UGLDHvsWaI0rF7DLfXiAufx61Z9aL83KD20js6bMN+rLJ
 2fkiqWSjwiicIRIDgmUHvzH0pRTDTahhwVoNgIfolT+X8BF6XhNnU06VI+YWap4ArK20
 Jqv20GxEoy/Vq2vyZE+1Ut7SDdF2b9QI7vBO+0OrE7PtEL2KS27pQd4uQYKOu8YpQShv
 2esc+5REgpRqy7imGSf99JucQhz9qp8TVZeEX7tAGrzvXApqsEywnAi14bfTeU0COVF3
 5siQ/ezr6+pC0S9IwSU+vumdqfXVdvzyWgmOruqKwm6R/J5l1dJBnHaWJd52xtZqlAFx
 Y3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358113; x=1774962913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pCtaHiT/GmfWC1YHLBLPv7dyjhI0hf8EFCS+TphIl1U=;
 b=N1UhH9tmU4vRDbNbuhNvG+96vSodupTx1AvjilnGS1ifhytT1q8w+CoVl5syr87c9z
 wLHAzaeDdJVeLaQ+qFJe+Z9BbuU8V3MI98nbPo93iB0WDhziutevvDP9xJqqD/8PCu1F
 rWUDwb31Bgn/GiHdPO2Jcj6+ePfGC9+acoTmn1p8C4y3emzYbLXZhEqmQCzCWujvUG8K
 sptDQOxjXy1NdE/vH97IvmNJA/jVtyETw3MIqNIOOkeROZBdgIO5iG24nAubH3quoibA
 RXuChxCxWY0LshZMPxJvT7O1Wlog40+X8as6q5RZMnLXWKfLCbedwd2HDeQ+b1S8bxMf
 7UTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgHVCgeWwE5P1T12cMPvoohBKQDlgQ7KyVWI3KY34JfTl2fTo4AUiQx/uChQwlHMe9ux20u87QdXI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwClQqB/V8HTRer2qEonAKsDi/DinKAbwmMKv4qCoB8xew2UHAY
 qyLzaSsKWkKblNM9igupJkb2WzdvEvLpqBXSQ9tYO5RWJJx3bjbXd7HZJw/ltv8VBQxWLoWCFLF
 TBxoPng9xsCYvu+JDwsVBDB2b16DUPXU=
X-Gm-Gg: ATEYQzwv7nfTgNaEp0U2OD8Y1X3JkkVfrKaJVGtBJtNfODS0YJYCiu67rsmGlU+cBi5
 2fvezJIZN40CujIsBNl02S96CDk78i2tMoYtOseNQA9pdJuSa8Hwq/Z5HifrzvM14h42/TVLrkF
 L0M2tvymfW9ipSqfxvwdl5EvIzbT3MQqdOaPtpDzMFooRq3xPKabYYjV0Q4MrLeJzX45foO8ji8
 7k3OFvF7G3fDgVpoc7xq9AiEW3G7K287Ya+BPGvX+0iCNP4ZHDM8iVFmRBwwtGuccCw3XZt7qq4
 lQPYCr+T+WNy74D7DcImJo6IBNSe/i/PHEg2NkjeemWUpvBL9RDO1YKYteTuCeIem1nfIA==
X-Received: by 2002:a05:7022:699a:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-12a7259635emr3497480c88.0.1774358112746; Tue, 24 Mar 2026
 06:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260317203613.5783-1-litaliano00.contact@gmail.com>
In-Reply-To: <20260317203613.5783-1-litaliano00.contact@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:15:00 -0400
X-Gm-Features: AaiRm53X7rgvEtcilyiO8FPwrUdAloLWgZk36ehAk7kfB3W20OGMNk2sOTJYQFg
Message-ID: <CADnq5_NUSvOABz1sjrhyFVr7ULWoFFJhV0AuhtOnf5ptPJUgpg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: clean up typecasts and constants in
 dcn4_calcs
To: Adriano Vero <litaliano00.contact@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 alexander.deucher@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
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

Applied.  Thanks!

Alex

On Wed, Mar 18, 2026 at 4:39=E2=80=AFAM Adriano Vero
<litaliano00.contact@gmail.com> wrote:
>
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> ---
>  .../src/dml2_core/dml2_core_dcn4_calcs.c      | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2=
_core/dml2_core_dcn4_calcs.c
> index ca5ac3c0d..b7fe4fc92 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> @@ -202,7 +202,7 @@ static unsigned int dml_round_to_multiple(unsigned in=
t num, unsigned int multipl
>                 return (num - remainder);
>  }
>
> -static unsigned int dml_get_num_active_pipes(int unsigned num_planes, co=
nst struct core_display_cfg_support_info *cfg_support_info)
> +static unsigned int dml_get_num_active_pipes(unsigned int num_planes, co=
nst struct core_display_cfg_support_info *cfg_support_info)
>  {
>         unsigned int num_active_pipes =3D 0;
>
> @@ -546,9 +546,9 @@ static bool dml_is_vertical_rotation(enum dml2_rotati=
on_angle Scan)
>         return is_vert;
>  }
>
> -static int unsigned dml_get_gfx_version(enum dml2_swizzle_mode sw_mode)
> +static unsigned int dml_get_gfx_version(enum dml2_swizzle_mode sw_mode)
>  {
> -       int unsigned version =3D 0;
> +       unsigned int version =3D 0;
>
>         if (sw_mode =3D=3D dml2_sw_linear ||
>                 sw_mode =3D=3D dml2_sw_256b_2d ||
> @@ -1761,7 +1761,7 @@ static unsigned int CalculateVMAndRowBytes(struct d=
ml2_core_shared_calculate_vm_
>                 *p->PixelPTEBytesPerRow =3D (unsigned int)((double)*p->dp=
te_row_width_ub / (double)*p->PixelPTEReqWidth * *p->PTERequestSize);
>
>                 // VBA_DELTA, VBA doesn't have programming value for pte =
row height linear.
> -               *p->dpte_row_height_linear =3D (unsigned int)1 << (unsign=
ed int)math_floor2(math_log((float)(p->PTEBufferSizeInRequests * PixelPTERe=
qWidth_linear / p->Pitch), 2.0), 1);
> +               *p->dpte_row_height_linear =3D 1U << (unsigned int)math_f=
loor2(math_log((float)(p->PTEBufferSizeInRequests * PixelPTEReqWidth_linear=
 / p->Pitch), 2.0), 1);
>                 if (*p->dpte_row_height_linear > 128)
>                         *p->dpte_row_height_linear =3D 128;
>
> @@ -3377,7 +3377,7 @@ static void calculate_cursor_req_attributes(
>         DML_LOG_VERBOSE("DML::%s: cursor_bytes_per_line =3D %d\n", __func=
__, *cursor_bytes_per_line);
>         DML_LOG_VERBOSE("DML::%s: cursor_bytes_per_chunk =3D %d\n", __fun=
c__, *cursor_bytes_per_chunk);
>         DML_LOG_VERBOSE("DML::%s: cursor_bytes =3D %d\n", __func__, *curs=
or_bytes);
> -       DML_LOG_VERBOSE("DML::%s: cursor_pitch =3D %d\n", __func__, curso=
r_bpp =3D=3D 2 ? 256 : (unsigned int)1 << (unsigned int)math_ceil2(math_log=
((float)cursor_width, 2), 1));
> +       DML_LOG_VERBOSE("DML::%s: cursor_pitch =3D %d\n", __func__, curso=
r_bpp =3D=3D 2 ? 256 : 1U << (unsigned int)math_ceil2(math_log((float)curso=
r_width, 2), 1));
>  #endif
>  }
>
> @@ -12205,15 +12205,15 @@ static void rq_dlg_get_wm_regs(const struct dml=
2_display_cfg *display_cfg, const
>  {
>         double refclk_freq_in_mhz =3D (display_cfg->overrides.hw.dlg_ref_=
clk_mhz > 0) ? (double)display_cfg->overrides.hw.dlg_ref_clk_mhz : mode_lib=
->soc.dchub_refclk_mhz;
>
> -       wm_regs->fclk_pstate =3D (int unsigned)(mode_lib->mp.Watermark.FC=
LKChangeWatermark * refclk_freq_in_mhz);
> -       wm_regs->sr_enter =3D (int unsigned)(mode_lib->mp.Watermark.Stutt=
erEnterPlusExitWatermark * refclk_freq_in_mhz);
> -       wm_regs->sr_exit =3D (int unsigned)(mode_lib->mp.Watermark.Stutte=
rExitWatermark * refclk_freq_in_mhz);
> -       wm_regs->sr_enter_z8 =3D (int unsigned)(mode_lib->mp.Watermark.Z8=
StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
> -       wm_regs->sr_exit_z8 =3D (int unsigned)(mode_lib->mp.Watermark.Z8S=
tutterExitWatermark * refclk_freq_in_mhz);
> -       wm_regs->temp_read_or_ppt =3D (int unsigned)(mode_lib->mp.Waterma=
rk.temp_read_or_ppt_watermark_us * refclk_freq_in_mhz);
> -       wm_regs->uclk_pstate =3D (int unsigned)(mode_lib->mp.Watermark.DR=
AMClockChangeWatermark * refclk_freq_in_mhz);
> -       wm_regs->urgent =3D (int unsigned)(mode_lib->mp.Watermark.UrgentW=
atermark * refclk_freq_in_mhz);
> -       wm_regs->usr =3D (int unsigned)(mode_lib->mp.Watermark.USRRetrain=
ingWatermark * refclk_freq_in_mhz);
> +       wm_regs->fclk_pstate =3D (unsigned int)(mode_lib->mp.Watermark.FC=
LKChangeWatermark * refclk_freq_in_mhz);
> +       wm_regs->sr_enter =3D (unsigned int)(mode_lib->mp.Watermark.Stutt=
erEnterPlusExitWatermark * refclk_freq_in_mhz);
> +       wm_regs->sr_exit =3D (unsigned int)(mode_lib->mp.Watermark.Stutte=
rExitWatermark * refclk_freq_in_mhz);
> +       wm_regs->sr_enter_z8 =3D (unsigned int)(mode_lib->mp.Watermark.Z8=
StutterEnterPlusExitWatermark * refclk_freq_in_mhz);
> +       wm_regs->sr_exit_z8 =3D (unsigned int)(mode_lib->mp.Watermark.Z8S=
tutterExitWatermark * refclk_freq_in_mhz);
> +       wm_regs->temp_read_or_ppt =3D (unsigned int)(mode_lib->mp.Waterma=
rk.temp_read_or_ppt_watermark_us * refclk_freq_in_mhz);
> +       wm_regs->uclk_pstate =3D (unsigned int)(mode_lib->mp.Watermark.DR=
AMClockChangeWatermark * refclk_freq_in_mhz);
> +       wm_regs->urgent =3D (unsigned int)(mode_lib->mp.Watermark.UrgentW=
atermark * refclk_freq_in_mhz);
> +       wm_regs->usr =3D (unsigned int)(mode_lib->mp.Watermark.USRRetrain=
ingWatermark * refclk_freq_in_mhz);
>         wm_regs->refcyc_per_trip_to_mem =3D (unsigned int)(mode_lib->mp.U=
rgentLatency * refclk_freq_in_mhz);
>         wm_regs->refcyc_per_meta_trip_to_mem =3D (unsigned int)(mode_lib-=
>mp.MetaTripToMemory * refclk_freq_in_mhz);
>         wm_regs->frac_urg_bw_flip =3D (unsigned int)(mode_lib->mp.Fractio=
nOfUrgentBandwidthImmediateFlip * 1000);
> @@ -12670,7 +12670,7 @@ static void rq_dlg_get_dlg_reg(
>                         disp_dlg_regs->refcyc_per_vm_req_flip =3D (unsign=
ed int)(math_pow(2, 23) - 1);
>
>
> -               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < (unsigned =
int)8);
> +               DML_ASSERT(disp_dlg_regs->dst_y_after_scaler < 8U);
>                 DML_ASSERT(disp_dlg_regs->refcyc_x_after_scaler < (unsign=
ed int)math_pow(2, 13));
>
>                 if (disp_dlg_regs->dst_y_per_pte_row_nom_l >=3D (unsigned=
 int)math_pow(2, 17)) {
> @@ -13226,7 +13226,7 @@ void dml2_core_calcs_get_informative(const struct=
 dml2_core_internal_display_mod
>
>         out->informative.misc.cstate_max_cap_mode =3D dml_get_cstate_max_=
cap_mode(mode_lib);
>
> -       out->min_clocks.dcn4x.dpprefclk_khz =3D (int unsigned)dml_get_glo=
bal_dppclk_khz(mode_lib);
> +       out->min_clocks.dcn4x.dpprefclk_khz =3D (unsigned int)dml_get_glo=
bal_dppclk_khz(mode_lib);
>
>         out->informative.qos.max_active_fclk_change_latency_supported =3D=
 dml_get_fclk_change_latency(mode_lib);
>
> --
> 2.47.3
>
