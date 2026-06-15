Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007E7CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2844210E4EB;
	Mon, 15 Jun 2026 15:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bA0+khJv";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F221410E4E8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:13:10 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-59b5571d3c6so70488e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 08:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781536390; cv=none;
 d=google.com; s=arc-20240605;
 b=lyAv16kz4CilE1MRb5N3daH6IrQQ+E/WFEW44K4PeyPcIgU7GHv164o8knmTfj9HrE
 hnkiC2XoJ+7SI/1Tek6ts0t9PhrTE/U+dXXSXBq601u0OVswxT9Teu3ZxrJOzUPkmO5H
 akohxofgKvHe4HdxmmWKW/QTB6jusE3Z1jV41j+BTXEIlV1A/L7BON2PrisuGk+OOrbR
 2k0RHbWvF5rXurAI8BqCQ8gqyKdUAc9Rn5+kS1Eh0xACcu/bbyEMlMCqd+XyXWug5036
 fzG46WHA31l3Pe2IUvUETtc5FGN7UGIt75kgEIniHGO7+2AAqUDUHeXprZz6ESpXKiDO
 ySxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 fh=00mYVJznaCzMQJeglZ7nYrozRfr3k/eCinG7Qi6e5lk=;
 b=UaImBwqXGrLGjCz7EoAoIoqr1d3+hfr/5vbsDsC8ucB6ioEWJqd6vo80EiUEmXogQa
 MDyvASXjVEVMYL45W34RHT/VNdNJNdLc0SoECP8Gc0V+/TKNREup5atpO5FEj5L0HmNh
 lUIdDPTlLs0fYPDbEmM7sDNCDZRVRtDeJVShyLI/1kVehP5qnf4XYJfC3XG5TBoNqIN7
 LfNtIdVGosx+nMaFwTgujOEI3ieLg+3ZLts/ovJwjGVUXqR39rcZbkhwE41jChEHpzmj
 PoO8wtXfoSrSTr6XUEZytLwbCR5AHflO3nD5Z9gzRL+XltfFUevBvs2X7jO10BSYlR5B
 AfpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781536390; x=1782141190; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 b=bA0+khJvfxKLGbH12zcMeBwviM9RNP+GF1eGVs5TPwJhhgxJm0+DQv6Bq5W0Nn22oN
 IZ5if9FzH8tJiwYX3Aqw0xwplKnmNcR03d7yPQLEmiagjG9CqKimR2cYG73Do6teHukK
 umiPiJw/p0OKJFSJahMMkY/t5Y2PDtiZ9SQIvjNDcb1kvsL7ISCV1p9Nr8IyWcdQfTNG
 +EFnW8JPk3dnv7gxApiG9e8hpVLRTnnPqPUO8ugGb687jClgzIPq2yw2taTUEuE7jbKL
 Jxg481WP4dWaUHh90Eczg97knt1N9ViNHmKrM1WtrNm/lmvU0lcQVSnPqtHWqftRbklc
 AEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781536390; x=1782141190;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=roATZiTayMkP11ctGTRQ/QSFXQOmjWfML7u319n+/ac=;
 b=F+8I8fqq/6FXKIHYpIY6W8ThlQz9bBTxqhWQ190ReqTyidOAwVpFThzOki99qO6soW
 AzUnuAllULmC9gQi6QgTNYgj9RxYMxpVE9XqdS8774RvPT0VmKnLJkNdNMBNJWqDX+hZ
 rYkxiSDHqtqGvRAVkW3ookpNlaV4Nrs8bukwHNVZuXmbVAIueVUUsYV68mOAEqsMzapL
 T8GxBfxDf+246rbx3qGtub1e08TP1jFMn3Y/upWatXuC8LHstyUrCaq8JHx7sWfswGLb
 2ILLV05qdu583CTMqR6XUKSxfH53QY2rylk7hLgnPzgygDlWXhnm6b1HV3plGCW5jXg4
 IchA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/reEURIV1VfqEiBmGc0R4JQKGZkx6Fuu6TXldlTuPJe8oy9krewS6g6AXJBOAq2M1beQG1B3Vd828=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjlJRXwSsh9bXSeuBSiYK84RTWpBMLMYGawltg2B35ZgDZRkD+
 1tFtUDH6IYYNYPM8zjtE+JR8lrRD+orsyBUJGHB0xvKt8v5BwAtKTa4nZMK1wNdovMQWFpyTs+o
 zHx+UFhPHSulldZlEh96nswfAwjf7Y5g=
X-Gm-Gg: Acq92OHhJW66qWlI4jvc2Lkg06Uxl+Y4PcrO8cRvtfLAb0Ys7XTEPM5rpBPYan2/bKD
 e/P3VUydi66nc9AK9satLptGpS5P9CeWxXocX9T/TrAujjLut3sp9+p1VGarPPMaujr4OxWTMUO
 zjlPLdIie5XklU+axRjUdMlr7dcexo1ewb77E4jkjqP4Is3zq/EdU0ddc0jHGIVmRM+whjuzTl1
 VAD+/hoitOVeDLRph7P6+rGpkahIpSjwA5WQm13iovbKdpuwWlyP9/VqhKz2yePbDWE+9Tdjl/b
 EE4NCQxKCKNPEuXyH2LKIzZTVUJ14qQwNYD7asQSmnQi0oY/KncXYt9ya+OQZ59YdzGUvg==
X-Received: by 2002:a05:6102:c8c:b0:6c1:6ef9:db9d with SMTP id
 ada2fe7eead31-71e88c6e864mr2986309137.3.1781536389962; Mon, 15 Jun 2026
 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260608063638.24-1-ruoyuw560@gmail.com>
In-Reply-To: <20260608063638.24-1-ruoyuw560@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:12:56 -0400
X-Gm-Features: AVVi8Cer4GIFMDQbtQ86Y9cQ14WBjF3jDOlUIN6sx-Gkqu9NK1Mrx2Ch-KpOnV0
Message-ID: <CADnq5_MdEabu0FbbZSvvEMwMwVpogQf_4sXW2R6GQRhq7Xo52A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: avoid double free in r600 DPM cleanup
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jun 8, 2026 at 5:14=E2=80=AFAM Ruoyu Wang <ruoyuw560@gmail.com> wro=
te:
>
> r600_parse_extended_power_table() uses manual kfree() calls for some
> early allocation failures, but the freed pointers are left in the
> dynamic power-management state. If device teardown later calls
> r600_free_extended_power_table(), those stale pointers can be freed
> again.
>
> Use the common extended power table cleanup helper for those early
> failure paths as well, and clear each pointer after freeing it so
> repeated cleanup stays safe.
>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Applied.  Thanks!

> ---
>  drivers/gpu/drm/radeon/r600_dpm.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r=
600_dpm.c
> index 83f1ae31cbdbc..9755e717ca8bb 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c
> @@ -932,7 +932,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.vddci_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -943,8 +943,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.vddc_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddci_depend=
ency_on_mclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -955,9 +954,7 @@ int r600_parse_extended_power_table(struct radeon_dev=
ice *rdev)
>                         ret =3D r600_parse_clk_voltage_dep_table(&rdev->p=
m.dpm.dyn_state.mvdd_dependency_on_mclk,
>                                                                dep_table)=
;
>                         if (ret) {
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_sclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddci_depend=
ency_on_mclk.entries);
> -                               kfree(rdev->pm.dpm.dyn_state.vddc_depende=
ncy_on_mclk.entries);
> +                               r600_free_extended_power_table(rdev);
>                                 return ret;
>                         }
>                 }
> @@ -1296,17 +1293,29 @@ void r600_free_extended_power_table(struct radeon=
_device *rdev)
>         struct radeon_dpm_dynamic_state *dyn_state =3D &rdev->pm.dpm.dyn_=
state;
>
>         kfree(dyn_state->vddc_dependency_on_sclk.entries);
> +       dyn_state->vddc_dependency_on_sclk.entries =3D NULL;
>         kfree(dyn_state->vddci_dependency_on_mclk.entries);
> +       dyn_state->vddci_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->vddc_dependency_on_mclk.entries);
> +       dyn_state->vddc_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->mvdd_dependency_on_mclk.entries);
> +       dyn_state->mvdd_dependency_on_mclk.entries =3D NULL;
>         kfree(dyn_state->cac_leakage_table.entries);
> +       dyn_state->cac_leakage_table.entries =3D NULL;
>         kfree(dyn_state->phase_shedding_limits_table.entries);
> +       dyn_state->phase_shedding_limits_table.entries =3D NULL;
>         kfree(dyn_state->ppm_table);
> +       dyn_state->ppm_table =3D NULL;
>         kfree(dyn_state->cac_tdp_table);
> +       dyn_state->cac_tdp_table =3D NULL;
>         kfree(dyn_state->vce_clock_voltage_dependency_table.entries);
> +       dyn_state->vce_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->uvd_clock_voltage_dependency_table.entries);
> +       dyn_state->uvd_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->samu_clock_voltage_dependency_table.entries);
> +       dyn_state->samu_clock_voltage_dependency_table.entries =3D NULL;
>         kfree(dyn_state->acp_clock_voltage_dependency_table.entries);
> +       dyn_state->acp_clock_voltage_dependency_table.entries =3D NULL;
>  }
>
>  enum radeon_pcie_gen r600_get_pcie_gen_support(struct radeon_device *rde=
v,
> --
> 2.51.0
>
