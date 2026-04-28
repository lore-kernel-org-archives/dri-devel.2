Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D0DFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 20:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983A710E39D;
	Tue, 28 Apr 2026 20:59:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rBRCGcWd";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5D5910EC2D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 20:59:55 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12dc9b6beceso219573c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777409995; cv=none;
 d=google.com; s=arc-20240605;
 b=ZXUQTxEXDdTSuFeEZZ+b4qzwKgUFWfvNkKsfA2qXFTo8J4pK/aPMEI5lVqn9P0vKrF
 vwo5GrW+sNT2C5HZe4gOBZ/HbY/sZicf6ufhNgSI4fq7q0VrusVjMJ2smSFI93b3z7rY
 B8gb+K5+6k436upnOEKUGpOhErsscd4j4wqiahmj7FAzP85mPOYFrXCTLAA7z9F9inbW
 pv1/7u8fiKT0KPUU9qUNx7rgcPLum+rHO6vbAMNBgLuAO52p3qeb3WPhBrg9AbUM9B+g
 2BU8k8K9V8ftcC7Rm5HjmCf5br2VwkErIwxkiZc8aE6YWbr6pHvZLrjFMy4n1zOs0JaR
 XWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NKs7lWUsTkjimUwdR22nNDBlj2tg5RjqYaiPfax+AYI=;
 fh=Q2E9mI3rkhT3EThC0ZkkfqXnMOhy3TbIxhYZaQ5lNN0=;
 b=DbZaKu8j3goAapdrUG5+rKU8Tt4qZDo7qhMLwxBzOgOQmvt9Nq7fHnYjbEDnTtIhU6
 jUrjDfAbp3kQXDKHvAzPWegV74zT4kCMl9ph+7ltMbGFnYxHNkiPVgZip/6K0hI7egaD
 4DM5nNDwJFs0I+3AZqL5FX/3fWm6+3TZFOdplgifmOvO6kdk5XTjqQnLQhgA+lBiDHrc
 xtLVHsr8LRr2CXkGCZ+0vDyl2kwMLn1Yd1I8HjEtwOx5Q7ZWSAerFe+joEdRv5YzglFA
 MoKqrwoncNEj8mA+FXvIads5w831v3esMJkSknyogMdp1L8JAbgDIBcr5UMk8HwOV63Y
 9brA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777409995; x=1778014795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKs7lWUsTkjimUwdR22nNDBlj2tg5RjqYaiPfax+AYI=;
 b=rBRCGcWdambCEEWRirtkGiO+7PPesYwvAuXAfXOuybvjkRyapOHVRRWScMZz37eTKC
 rw3ffuFy5v5RRxBZsF4gTOU4dmgXbJaXxD3IbbvvsOYQaEEFUuYljk61UkLhvnp39FpK
 3xq6ifavNkHC6fu6Hd3BZE7IZDZPQTcCh+YxWwxuRD1gpqJ1oRoW0PvjkR4u1VLeP56D
 FZ/rY6HoHvHO9sMbNkl/XPNv/aiXpQIzVt9yhTmxXtjNPzvs9lzkRSj6Gz2MCJqnMOKp
 ZN9owH+G1c0lfRrvi3cSSsej3+xGJpUF8VRLR+dWYXzDmvXThdZ7UwL/2DF8Vtg3BGDY
 DTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409995; x=1778014795;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKs7lWUsTkjimUwdR22nNDBlj2tg5RjqYaiPfax+AYI=;
 b=YrPSNxp8bbqDkhVZFYnluaAPNafjZ6ytDJd09OPIQ8bLnCCT+HQi/KSJynPr1Yrt8/
 Sl3ARJFqgTuFtSkD+VzrSY55UzLxy/PLxG+6Sbc4+WIpDpqsTYAuJTYnG73TMZcN+ChV
 nhiClvUq1X6kQE0hiOnsRLopTOlVql4k4Vjq9S16l/bwPJ993MZ06AbODNnXR/uAH7vK
 992he/rj98f8x9LO4lyft21k9ejj7K4/IR2J+F9wZwxvmmwaKejrSLE4KqCskUhjX64h
 oiDV1ZdmR0smfUgiufqUnlznfpxUDA3P0T94l4zUnjbCexGHNkeXxqAsCQzyDRs+Cl54
 Mn7Q==
X-Gm-Message-State: AOJu0YyXcdjvn7SoOwMOWzQZkwdPsWqx0soH3/c0RlhZqbfJWqry9WjJ
 XkLHdNZ2WtWpmmc2w2MFeORwv0C1MYjj7Ayu9JMCqjDwrCRqzMi9zAltQJvUuj5FAXffAnDhkDJ
 1noSbZQnT2sVQw7nlTRaEGPNsp/ackSYIug==
X-Gm-Gg: AeBDietNmxSIhBRIiwj00sPJQOomV0eQuFcrEjDjFF/R7Lr6mShhVAaBA0KuTiHD6PU
 iZluk+hLs1RfYP//ugIiQg6IuA7PcPleLwjlma1xCYt8UITVvezZXXomte7kAmV5xcSG/6O3k51
 44zQHYrjSVEF37TBrFsvznn/3IpX9iPO3QpnhFZ5iN9KI2aC+WpC+HKMYYhCHbwPSvVbohlYK2d
 5n9rpgQctUA+2X0Vc1B7NAq2HJG2MdvouBNWy41n6nzCtgSQhcBH2xPVOgt2AVVSeysw7xUEYJg
 mBtbiF/j7j0ZrDyqMHpx25C1OnNB0SZ9/2YkUOfvlVeCBRoA5eG+X1YPUBMnMJqWaFcqvQwMIE3
 n3lq9
X-Received: by 2002:a05:7022:618c:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-12ddd4e40a6mr1174660c88.1.1777409994914; Tue, 28 Apr 2026
 13:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260427214122.784024-1-rdunlap@infradead.org>
In-Reply-To: <20260427214122.784024-1-rdunlap@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 16:59:43 -0400
X-Gm-Features: AVHnY4LBCnRTesV8aV5lM-5B56beSoaiAnl5S5CRI0bzQtScRkQlt2ShdqkzylI
Message-ID: <CADnq5_P7tFYcqW8+CZYuGAVpkW_qU4QMu__3oNsy9G=SeMW4_A@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] drm/amd/display: dmub_cmd.h: correct typos and
 spellos
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
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

Applied the series.

Thanks!

On Mon, Apr 27, 2026 at 5:41=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Fix spelling issues that are reported by codespell:
>
> dmub_cmd.h:332: alighment =3D=3D> alignment
> dmub_cmd.h:2029: sequeunce =3D=3D> sequence
> dmub_cmd.h:3684: optimzations =3D=3D> optimizations
> dmub_cmd.h:4491: isntance =3D=3D> instance
> dmub_cmd.h:4514: optimzations =3D=3D> optimizations
> dmub_cmd.h:4604: isntance =3D=3D> instance
> dmub_cmd.h:4643: isntance =3D=3D> instance
> dmub_cmd.h:4679: isntance =3D=3D> instance
> dmub_cmd.h:4699: isntance =3D=3D> instance
> dmub_cmd.h:4719: isntance =3D=3D> instance
> dmub_cmd.h:4735: isntance =3D=3D> instance
> dmub_cmd.h:4749: isntance =3D=3D> instance
> dmub_cmd.h:4795: isntance =3D=3D> instance
> dmub_cmd.h:4903: isntance =3D=3D> instance
> dmub_cmd.h:4936: isntance =3D=3D> instance
> dmub_cmd.h:5066: re-use =3D=3D> reuse
> dmub_cmd.h:6552: isntance =3D=3D> instance
> dmub_cmd.h:6630: isntance =3D=3D> instance
> dmub_cmd.h:6639: optimzations =3D=3D> optimizations
> dmub_cmd.h:6720: isntance =3D=3D> instance
> dmub_cmd.h:6742: isntance =3D=3D> instance
>
> and fix a few that I found:
>
> dicated         =3D=3D> dictated (7x)
> afftet          =3D=3D> after (is this correct?)
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: fix one more typo; rebase & resend
>
> Questions:
> (a) Is one of "negative" or "pos" incorrect?
>
>         /**
>          * Dark negative gain.
>          */
>         uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 184B
>
> (b) Is one of "min" or "Maximum" incorrect?
>
>         uint16_t min_frame_rate;        /**< Maximum frame rate */
>
> (c) Is one of "max" or "Minimum" incorrect?
>
>         uint16_t max_frame_rate;        /**< Minimum frame rate */
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>
>
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |   58 +++++++-------
>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> --- linux-next-20260427.orig/drivers/gpu/drm/amd/display/dmub/inc/dmub_cm=
d.h
> +++ linux-next-20260427/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -329,7 +329,7 @@ union dmub_addr {
>
>  /* Flattened structure containing SOC BB parameters stored in the VBIOS
>   * It is not practical to store the entire bounding box in VBIOS since t=
he bounding box struct can gain new parameters.
> - * This also prevents alighment issues when new parameters are added to =
the SoC BB.
> + * This also prevents alignment issues when new parameters are added to =
the SoC BB.
>   * The following parameters should be added since these values can't be =
obtained elsewhere:
>   * -dml2_soc_power_management_parameters
>   * -dml2_soc_vmin_clock_limits
> @@ -2001,7 +2001,7 @@ struct dmub_rb_cmd_read_modify_write {
>  };
>
>  /*
> - * Update a register with specified masks and values sequeunce
> + * Update a register with specified masks and values sequence
>   *
>   * 60 payload bytes can hold address + up to 7 sets of mask/value combo,=
 each take 2 dword
>   *
> @@ -3483,7 +3483,7 @@ enum dmub_cmd_psr_type {
>
>         /**
>          * Set PSR level.
> -        * PSR level is a 16-bit value dicated by driver that
> +        * PSR level is a 16-bit value dictated by driver that
>          * will enable/disable different functionality.
>          */
>         DMUB_CMD__PSR_SET_LEVEL                 =3D 4,
> @@ -3640,7 +3640,7 @@ struct dmub_cmd_psr_copy_settings_data {
>          */
>         union dmub_psr_debug_flags debug;
>         /**
> -        * 16-bit value dicated by driver that will enable/disable differ=
ent functionality.
> +        * 16-bit value dictated by driver that will enable/disable diffe=
rent functionality.
>          */
>         uint16_t psr_level;
>         /**
> @@ -3680,7 +3680,7 @@ struct dmub_cmd_psr_copy_settings_data {
>          */
>         uint8_t aux_inst;
>         /**
> -        * Determines if SMU optimzations are enabled/disabled.
> +        * Determines if SMU optimizations are enabled/disabled.
>          */
>         uint8_t smu_optimizations_en;
>         /**
> @@ -3797,7 +3797,7 @@ struct dmub_rb_cmd_psr_copy_settings {
>   */
>  struct dmub_cmd_psr_set_level_data {
>         /**
> -        * 16-bit value dicated by driver that will enable/disable differ=
ent functionality.
> +        * 16-bit value dictated by driver that will enable/disable diffe=
rent functionality.
>          */
>         uint16_t psr_level;
>         /**
> @@ -4175,7 +4175,7 @@ struct dmub_rb_cmd_update_cursor_info {
>   */
>  struct dmub_cmd_psr_set_vtotal_data {
>         /**
> -        * 16-bit value dicated by driver that indicates the vtotal in PS=
R active requirement when screen idle..
> +        * 16-bit value dictated by driver that indicates the vtotal in P=
SR active requirement when screen idle..
>          */
>         uint16_t psr_vtotal_idle;
>         /**
> @@ -4189,7 +4189,7 @@ struct dmub_cmd_psr_set_vtotal_data {
>          */
>         uint8_t panel_inst;
>         /*
> -        * 16-bit value dicated by driver that indicates the vtotal in PS=
R active requirement when doing SU/FFU.
> +        * 16-bit value dictated by driver that indicates the vtotal in P=
SR active requirement when doing SU/FFU.
>          */
>         uint16_t psr_vtotal_su;
>         /**
> @@ -4489,7 +4489,7 @@ struct dmub_cmd_replay_copy_settings_dat
>         uint8_t aux_inst;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4512,7 +4512,7 @@ struct dmub_cmd_replay_copy_settings_dat
>          */
>         uint8_t dpphy_inst;
>         /**
> -        * Determines if SMU optimzations are enabled/disabled.
> +        * Determines if SMU optimizations are enabled/disabled.
>          */
>         uint8_t smu_optimizations_en;
>         /**
> @@ -4602,7 +4602,7 @@ struct dmub_rb_cmd_smart_power_oled_enab
>         uint8_t enable;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4641,7 +4641,7 @@ struct dmub_rb_cmd_replay_enable_data {
>         uint8_t enable;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4689,7 +4689,7 @@ struct dmub_rb_cmd_replay_enable {
>  struct dmub_cmd_replay_set_power_opt_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4709,7 +4709,7 @@ struct dmub_cmd_replay_set_power_opt_dat
>  struct dmub_cmd_replay_set_timing_sync_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4729,7 +4729,7 @@ struct dmub_cmd_replay_set_timing_sync_d
>  struct dmub_cmd_replay_set_pseudo_vtotal {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4745,7 +4745,7 @@ struct dmub_cmd_replay_set_pseudo_vtotal
>  struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4759,7 +4759,7 @@ struct dmub_cmd_replay_disabled_adaptive
>  struct dmub_cmd_replay_set_general_cmd_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4796,7 +4796,7 @@ struct dmub_rb_cmd_replay_set_power_opt
>   */
>  struct dmub_cmd_replay_set_coasting_vtotal_data {
>         /**
> -        * 16-bit value dicated by driver that indicates the coasting vto=
tal.
> +        * 16-bit value dictated by driver that indicates the coasting vt=
otal.
>          */
>         uint16_t coasting_vtotal;
>         /**
> @@ -4805,12 +4805,12 @@ struct dmub_cmd_replay_set_coasting_vtot
>         uint8_t cmd_version;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
>         /**
> -        * 16-bit value dicated by driver that indicates the coasting vto=
tal high byte part.
> +        * 16-bit value dictated by driver that indicates the coasting vt=
otal high byte part.
>          */
>         uint16_t coasting_vtotal_high;
>         /**
> @@ -4913,7 +4913,7 @@ struct dmub_rb_cmd_replay_set_general_cm
>  struct dmub_cmd_replay_frameupdate_timer_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -4946,7 +4946,7 @@ struct dmub_rb_cmd_replay_set_frameupdat
>  union dmub_replay_cmd_set {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -5122,7 +5122,7 @@ struct dmub_hw_lock_inst_flags {
>         uint8_t opp_inst;
>         /**
>          * OTG HW instance for global update lock.
> -        * TODO: Remove, and re-use otg_inst.
> +        * TODO: Remove, and reuse otg_inst.
>          */
>         uint8_t dig_inst;
>         /**
> @@ -6609,7 +6609,7 @@ struct dmub_cmd_pr_enable_data {
>         uint8_t enable;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which replay_state to use
> +        * Panel instance to identify which replay_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -6687,7 +6687,7 @@ struct dmub_cmd_pr_copy_settings_data {
>         uint8_t aux_inst;
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -6696,7 +6696,7 @@ struct dmub_cmd_pr_copy_settings_data {
>          */
>         uint8_t dpphy_inst;
>         /**
> -        * Determines if SMU optimzations are enabled/disabled.
> +        * Determines if SMU optimizations are enabled/disabled.
>          */
>         uint8_t smu_optimizations_en;
>         /**
> @@ -6704,7 +6704,7 @@ struct dmub_cmd_pr_copy_settings_data {
>          */
>         uint32_t line_time_in_ns;
>         /*
> -        * Use FSFT afftet pixel clk
> +        * Use FSFT after pixel clk
>          */
>         uint32_t pix_clk_100hz;
>         /*
> @@ -6777,7 +6777,7 @@ union dmub_pr_runtime_flags {
>  struct dmub_cmd_pr_update_state_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
> @@ -6799,7 +6799,7 @@ struct dmub_cmd_pr_update_state_data {
>  struct dmub_cmd_pr_general_cmd_data {
>         /**
>          * Panel Instance.
> -        * Panel isntance to identify which psr_state to use
> +        * Panel instance to identify which psr_state to use
>          * Currently the support is only for 0 or 1
>          */
>         uint8_t panel_inst;
