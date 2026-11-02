Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA74607993B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNzfbyja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1732F10E695;
	Mon,  2 Nov 2026 15:51:54 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACD610F04A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:51:47 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cd69aa46f21so124588a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 07:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793634707; cv=none;
 d=google.com; s=arc-20260327;
 b=qxAzhOHm1WbVnc98NICVJfK3MvWCF5X3cHfw5P6jZt8spj8+Au8Cyp6/AEpNkcSz2r
 2LwRMERrtTlGVOS+TOlSALAhSKmvDyNGr3QPpV5HSuMLv7r83rmd5n8btQkCAIozxw2z
 n5eEwiAJac7U1Hun7ZCq8sSk/b1eOvHDIAEO6ZrQIcu6Zt7hx2ZcbQaF74fx1G9hUdDN
 8nNUoX0bQRiKkNENKZZI408UfgyvvLDJHlSH+m+MFRnXs7r6U3EunwitvEb16CU1I0Ke
 pMW9B9DD90XzmkAwvIW646rgdVNHON7CLtHvfH4JMEkZdOlT7+GbgrUtFl+MiX9y22aJ
 ZxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 fh=t77KiLLI4We6+w27sagAIcTsMvpYU84E/OMgCEgqOlI=;
 b=TxJZJHjT76hxWYfwYLnLtuZdQ6zwXS7vqJI41y9RnlTYXD4qgCwKse8vV7bzxXCQgv
 FY9zE/xx4iTlRnuY9ELRy0x8FiBEyUCfNSTImOMePZz7hiqNLZ/3D+dYZ+qcUsR6Tg+U
 /1ZA1VI2kbnwrQoemthwVc5jur6EgL3DP+u0pIzjXEoWx39j7UrkKeqZNuLxrjQhn1i7
 AqEWZGH3hSI4q4z9b9ryRDGGosoaEj55bINPoO1VlZbFTESNZscGJpF+l/BuuWpIakUJ
 knoQCn446WhJNVaxl6qJrfETqCMw6uCjA/YoXJKliq5hfim2aNvPylfx/DD+7ZV1ctnD
 ugMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793634707; x=1794239507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 b=hNzfbyjatZkU9Hfgbr6Lq6hfSHRcZvlS1JglBDC1CAO6Ygro6i0L1QT/OcOuEsQSq8
 IOPwMM213+NFNMbxK+bYZM010AK2rWK7FyBMfK14N2rjEwLY3ME1ZQX6VHy//+dQHjlw
 csAWDFHET6n2DQVCnOzp9DqCzct4vYsZXCVuEVHBXDgg60QBoIuKCe+jHAWNlTddDmkP
 5nnS6RPj6mwJ/FgRaLOXcodTTxVuG6trOpg0yTEFTR1vyCT3OFWeZndTF+vvQ7ZIZQx6
 6GWyuyQ1DInH2tONcIK5D1cin9m9t4AT/cqpTNqM9lEn1km0H1bkpcwyZFeNmtes0DYX
 Kmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634707; x=1794239507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 b=icb4866wMJECGl/hyy1OqUj/81iz0dU26BhaAz2ETwGmUyiIy9ZhryUUvZbxM6JyFh
 4c2wxLxIkiRGfOKsZ1d31F0dgzrGIL5s6EJtAD2dRMFwfpVbuBQG/H4vaF6xJyKwTyjT
 1hxypHQkWBpftvVo2+Tho3m+5aeD4IkkfHEdwfcwz+1d4YWXQclydaw8Qz+qil4UAQrB
 KQjbaKj9P3Yj0aJn0baa6HpK60RbH3TbSlNrBPjkAhNsQIMtcS0qum9StWp5tL5h3pIu
 1Yqk01he9MrjLujG+idyYuKzw1EnMTt4X86JPh9WeAC+yAHCl/tUwEaBjOebCRBax3Ov
 cc5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Qk9+cq7OtmWQyLs0huoKSzesAI27JF8urltNMekYJ+I5gRLhTdiMK2FhToT6rryISsMqlfI5dsY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8iwP55TwKFzcJQq/Wd0Y00TgRet1Z6XqI3tCMRT2IZllMn2Qs4
 dff+tSLkSWiRDrseO0cet8gae2QQakvsE23wcJPX8Y5cLH6KFYeic18FWlSGeFL6K5wotv1HyTQ
 nj0CuqjR1eJa5OCluBrHeDbz7fsZJzIg=
X-Gm-Gg: AYBFou1nMN1uSdNu21Dbsuf8Yl2/H8k8jmALljm1SaW6brhhEMnbSlYSmve6uE3cVz9
 juuHE0VLuPYl9PmYXCxGNKS0qku0XhyPFIsQ2bU06Nc2E6WC/jWWxdYj0vSljxAWyGwKoF5Bp7K
 yhAQWwC/of5uetj700+z1Vgu5IfNU/mYShjqqp+En49yhxlyMQyVUfZvOliJ32NPqImuz/wnpM0
 ByqQxw91+aOXESMlKqZenc4ycEy7zOy2ajcRGLXnjy4RSj/fC+7PYkjBeBo8vLlCDQc3EAKYwUW
 4daavrXyt6j1/r2BcWujlbLMlrqjujxOHVpJ9A87hcSkeyOMwEnmhA+pM8VaoQNmxwAGK4W8Obs
 d1EERnBbVX2tjY2d+fm1o99XkABoEa1RBpVkF0QnoJdnMCF9RAxNfk06HYiieNEtW8EViiOjZn4
 ZfSBBi1xxtadK/MuffZmYYX7CQ
X-Received: by 2002:a17:903:37cf:b0:2e9:6468:2005 with SMTP id
 d9443c01a7336-2eb3648cd80mr155350785ad.2.1793634707021; Mon, 02 Nov 2026
 07:51:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
 <20261101132405.1387745-1-ingyujang25@korea.ac.kr>
In-Reply-To: <20261101132405.1387745-1-ingyujang25@korea.ac.kr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 10:51:35 -0500
X-Gm-Features: AclHuK_dNc-WbpSUdvsrzWpZry_6vBxHfWOCNfPxLRPLLxJ6Y7fVPrrrC1rt0jw
Message-ID: <CADnq5_MU1M1_7gsQFv_+B4r-YNa6yQ0WTCiO1_DAahwmshDWUg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
To: Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 8:31=E2=80=AFAM Ingyu Jang <ingyujang25@korea.ac.kr>=
 wrote:
>
> The smu7_patch_*() helpers called in this function only call the void
> smu7_patch_ppt_v0_with_vdd_leakage() and always return 0, so the error
> checks on their return values can never be true.
>
> Make the helpers and smu7_patch_dependency_tables_with_leakage() return
> void, and remove the dead checks.
>
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

Reviewed and applied.  Thanks!

Alex

> ---
> Changes in v2:
> - Make the smu7_patch_*() helpers and
>   smu7_patch_dependency_tables_with_leakage() return void, as suggested
>   by Alex Deucher.
> - Rebase onto current mainline.
>
> Link to v1: https://lore.kernel.org/all/20260114163807.2525868-1-ingyujan=
g25@korea.ac.kr/
>
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 117 +++++-------------
>  1 file changed, 30 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index bdf1e489369e6..dafe25b1efb65 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2672,8 +2672,8 @@ static void smu7_patch_ppt_v0_with_vdd_leakage(stru=
ct pp_hwmgr *hwmgr,
>  }
>
>
> -static int smu7_patch_vddc(struct pp_hwmgr *hwmgr,
> -                             struct phm_clock_voltage_dependency_table *=
tab)
> +static void smu7_patch_vddc(struct pp_hwmgr *hwmgr,
> +                           struct phm_clock_voltage_dependency_table *ta=
b)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2682,12 +2682,10 @@ static int smu7_patch_vddc(struct pp_hwmgr *hwmgr=
,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                 &data->vddc_leakage);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vddci(struct pp_hwmgr *hwmgr,
> -                              struct phm_clock_voltage_dependency_table =
*tab)
> +static void smu7_patch_vddci(struct pp_hwmgr *hwmgr,
> +                            struct phm_clock_voltage_dependency_table *t=
ab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2696,12 +2694,10 @@ static int smu7_patch_vddci(struct pp_hwmgr *hwmg=
r,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddci_leak=
age);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_vce_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_vce_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2710,13 +2706,11 @@ static int smu7_patch_vce_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
>
> -static int smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_uvd_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_uvd_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2725,12 +2719,10 @@ static int smu7_patch_uvd_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
> -                                        struct phm_phase_shedding_limits=
_table *tab)
> +static void smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
> +                                      struct phm_phase_shedding_limits_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2739,12 +2731,10 @@ static int smu7_patch_vddc_shed_limit(struct pp_h=
wmgr *hwmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].Voltage,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
> -                                  struct phm_samu_clock_voltage_dependen=
cy_table *tab)
> +static void smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
> +                                struct phm_samu_clock_voltage_dependency=
_table *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2753,12 +2743,10 @@ static int smu7_patch_samu_vddc(struct pp_hwmgr *=
hwmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_acp_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_acp_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2767,12 +2755,10 @@ static int smu7_patch_acp_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                         &data->vddc_leakage);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_clock_and_voltage_limits *ta=
b)
> +static void smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
> +                                  struct phm_clock_and_voltage_limits *t=
ab)
>  {
>         uint32_t vddc, vddci;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2787,11 +2773,9 @@ static int smu7_patch_limits_vddc(struct pp_hwmgr =
*hwmgr,
>                                                    &data->vddci_leakage);
>                 tab->vddci =3D vddci;
>         }
> -
> -       return 0;
>  }
>
> -static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_le=
akage_table *tab)
> +static void smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_l=
eakage_table *tab)
>  {
>         uint32_t i;
>         uint32_t vddc;
> @@ -2804,63 +2788,22 @@ static int smu7_patch_cac_vddc(struct pp_hwmgr *h=
wmgr, struct phm_cac_leakage_ta
>                         tab->entries[i].Vddc =3D (uint16_t)vddc;
>                 }
>         }
> -
> -       return 0;
>  }
>
> -static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hw=
mgr)
> +static void smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *h=
wmgr)
>  {
> -       int tmp;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_sclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_mclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency=
_on_mclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_display_clock);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_v=
oltage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_p=
hase_shed_limits_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock=
_voltage_on_ac);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock=
_voltage_on_dc);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_t=
able);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       return 0;
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
> +       smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk=
);
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_displa=
y_clock);
> +       smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dep=
endency_table);
> +       smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dep=
endency_table);
> +       smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_d=
ependency_table);
> +       smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dep=
endency_table);
> +       smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_she=
d_limits_table);
> +       smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage=
_on_ac);
> +       smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage=
_on_dc);
> +       smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
>  }
>
>
> --
> 2.34.1
>
