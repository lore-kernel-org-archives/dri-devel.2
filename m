Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA33CA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 12:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F2910E023;
	Sun, 11 Oct 2026 12:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aY0QTbpu";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50A610E023
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 12:26:06 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so620692a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 05:26:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791721566; cv=none;
 d=google.com; s=arc-20260327;
 b=lqKJkbxvu9rRn2YwdFRsBARFgAb0bzT67KF5njDH9wsgzofB1dNsZSoezYTHcvWy3S
 qswnAwyGEhGjzCbRpaU4YcVbLBHBY0sG/DetSwK/+2EhtkEFf0FDSxOj9oBRQlfhzA8m
 DxoP94MoZMgbn60nbOe3+SS+x4z+/X8sPrKxNKsj4f+JUg1SAN43sRY+8P3erqFl34+v
 eaZtvnqMPagQbXhM7JYy4hIGb+L3YAy9pcli/aQdJWHRiGkebrPolh+w02Q9Rh77irZ7
 du7DNMAnJOYBVZ+FC19JrKWrxueWBq+6UeVwlgdkR7xSj5je8/THg/jQInh1NhbGO/pK
 JwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TMQJrEs50uHxmH5jNYUVoTh6YrurDltIENM9WcFXON4=;
 fh=sUwKhUZH7LhXS/mlpicuEcqb9UMcfAN1SOSCRIM5hMI=;
 b=Y6mGHC5REQD97wurOk/LBl6fGUVIV5mYEQUxxBkIG4yMkJqHvLYJR7mynRXPkNPQ9E
 LEhTcHO4lTHGG36JLVsfu8XO5wDKaAwt2+145S+50Ep52FKw9NaOIIClk2Tjj/CBVJ3J
 3ja1T/ZFVpmZpDPKAsht3zWvUp0KRWOr8f9t5Ypgz3LtvH+zc48Sf9x4Vcq3/7NQsPYl
 e1oIZepB+om91YRsn82g87nUe4iiBMJl5hs7ZppdB0Mhzi4uEl0i7sz8koc0Gc5AugSD
 DAZdcdTLEgwGAALSolosv7mpRoo5zKFJlCAzxiAcPBThT/Xl8KoGPxgP5q0FMp7DxYQR
 ki8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791721566; x=1792326366; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TMQJrEs50uHxmH5jNYUVoTh6YrurDltIENM9WcFXON4=;
 b=aY0QTbpu4BPLgzzRJNWLOZONHhKsJQHUrpEqLrNSMemLKBQ+o4/SChho9vsHwA3dMf
 hRVVDkIfWBTHlZhe4EH++oxURWTLn8LlOCQUnKvbES2ml1I9vYDxfY7k4+Pm2vC6Wqa4
 R8hDO5kJZ0+kVIQiyjaVrOCUutOaRRs7huDlH6jSiGQyRsfYiXaTbtrTvaEegOWp0Pkf
 qWQQ9pzT2vZp5tOnni2aFPZx4Ic6bN/r3CxBvBW6jpwP0MY7xABoloMwo6QB7cW8OCVb
 QfI4yQkgLUx3uAUXT4xIb7eOHIGikfYZ3dqWhAdIinXzw2La334qs10nhCnj9Y1RO7Wf
 +11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791721566; x=1792326366;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TMQJrEs50uHxmH5jNYUVoTh6YrurDltIENM9WcFXON4=;
 b=ORAgx8x9W763k+4ziAfg5pLIDX2HE2xQ3sM/UzgwmFS7G720XWyzw7WZye6ZD13Kk4
 Mbzw9irPbBquu4YHPPWCncVQLPY5xgmRFeoDM25S/XPtCCCr5dqNO1Bc/pVsf12W8RYr
 ok+qL/1fRcYNy4rNp18yxUiDokFnv259Am8aNLXoqnoBg6Asgk2Qugon+Z0J+TExF/BI
 CjZqi5Jh53C4J154crkLgPGD+/nXBVnsGN5HyHLE8pSxMxz4t9/TgP/1eregHhg4xr+O
 NrzbqesaJhBGJE693ie4UsBaJQsRotN3DiUBY/3xQQ+s8Fra/kLbhQ+GPslr/2c6587Z
 RCiQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4zrw5wjUKuc0iFV0MmVk1ESTlfvBojuleXfehi47PQCJkHTWWu1yoxFav4J7V9XhsnFje2txClbM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLe4oFrms6X/gUJ0RUiG7i1RCDqOTYUd7ocNljjT+z0HVBro93W
 9El+wdX/sde+E6qZPi6i/vyHLzPLPhiZXSsY/i1PoikV3g9Zjy+K2Mn6nq0Jz5icHUKT27N6/1c
 NuPs47L2FD01aJyA282TaTmiKqd0k+/A=
X-Gm-Gg: AYBFou0XxEwIS3ORiOcHtMaGa+Nt3GJJey5jMOJvwnuxLFhWoab0AavYKdvqOz/iD99
 JrpNDuGirIxnpmn42hXpuGo/D4B7KQV1JaqQd18GUPcNXZN0tKEyPyhHycpFhlLkbEndfore0zw
 kBlFPOFLlxtl6dZQwvHwDy5Q/3MEQ/YJLz7yO4yWiIlkPev4lMzXqcCAjrqruKlTzfOK8Zw9Ndf
 K1X7d+zQmUiMFe3HS/SJMUIv49p9jxP5Tb7HCw4va5tUiqPl57SBRUHVCoMa3mf5Hpd4troddda
 sFcqp3EXD8uGPnRGamD2aD4I27nPOUlJZ4rN0R9tXc031HiIG/p0vA==
X-Received: by 2002:a17:90b:2b48:b0:3aa:412f:b0a7 with SMTP id
 98e67ed59e1d1-3ab3a3687c7mr3848020a91.5.1791721566176; Sun, 11 Oct 2026
 05:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260917185235.23792-1-andersen.theo@gmail.com>
In-Reply-To: <20260917185235.23792-1-andersen.theo@gmail.com>
From: Theo Andersen Carton <andersen.theo@gmail.com>
Date: Sun, 11 Oct 2026 14:25:54 +0200
X-Gm-Features: AclHuK-8yQsEoQZb7XBZEYKYmzxZwaG7_AHzyz8sYrBgwykehmJlXlezwbpfNXM
Message-ID: <CANFnrsrMZoRatJJ_iJ=c9zW4uiZZUhM8KnVq_NF3XNW2_yQ0SA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915/ddi: add DDI A force 4 lanes quirk for Apple
 MacBookPro11, 5
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com
Cc: joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com, 
 simona@ffwll.ch, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Jani,

Gentle ping on v3. Patchwork says CI won't trigger automatically because
my address isn't on the allowlist:

  https://patchwork.freedesktop.org/series/174000/

Could someone with access click retest on rev4? For reference, BAT on the
earlier identical posting (rev3) passed. The shard failures from that run
were on MTL and DG1, which never reach this code since the quirk is gated
on a DMI match for MacBookPro11,5.

The bug with the logs and the VBT dump is still at
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17087

Thanks,
Theo

Den tors. 17. sep. 2026 kl. 20.52 skrev Theo Andersen Carton
<andersen.theo@gmail.com>:
>
> On dual-GPU Retina MacBooks the internal panel is muxed to the discrete
> GPU at boot, so Apple's firmware never lights up eDP on the Intel side.
> As a result it never sets DDI_A_4_LANES, and intel_ddi_max_lanes() reads
> back a source maximum of two lanes for port A.
>
> intel_dp_max_common_lane_count() then takes min3(source_max = 2,
> sink_max = 4, ...) = 2, giving 2 x 2.7 Gbps x 8/10 = 4.32 Gbps of link
> bandwidth. The panel's native 2880x1800@60 8bpc mode needs 8.1 Gbps, so
> every mode is rejected with MODE_CLOCK_HIGH and the connector comes up
> with no usable modes at all -- the panel stays dark whenever i915 is
> made to drive it, which looks like a hardware limitation but is not.
>
> The lanes are physically there. Reading the panel's DPCD from the AMD
> side, where amdgpu drives it correctly, reports MAX_LANE_COUNT = 0x84,
> i.e. 4 lanes, and amdgpu's own link_settings shows it running the panel
> at 4 lanes / HBR. macOS likewise drives this panel from the iGPU at its
> native resolution, so all four lanes are routed through the gmux to
> DDI A. Only the register bit is unset.
>
> intel_ddi_a_force_4_lanes() already exists for exactly this situation --
> its neighbouring comment notes that "Some BIOS might fail to set this
> bit on port A if eDP wasn't lit up at boot" -- but it only covers
> Broxton and Geminilake. Extend it with a DMI quirk so affected Macs get
> the correct lane count too.
>
> The DMI match is deliberately narrow. Other dual-GPU models in the same
> family are very likely affected identically, but they are untested, so
> widen the match only as reports come in.
>
> Tested on a MacBookPro11,5 (Haswell Crystal Well, Iris Pro 5200 +
> Radeon R9 M370X): with the quirk, DDI A comes up as 4 lanes, link
> training passes at link rate 270000 / lane count 4, and i915 drives the
> internal panel at its native 2880x1800.
>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/17087
> Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
> ---
> Numbering note: neither earlier posting was labelled, so to match the
> numbering already used on the list this is v3. v1 [1] was pasted into a
> mail client by hand, which hard-wrapped the diff and detabbed it, leaving
> it unapplicable. v2 [2] was the same patch resent with git send-email,
> unlabelled.
>
> v3:
> - No functional change since v2.
> - Commit message: the machine is Haswell (Crystal Well), not Broadwell as
>   v1/v2 claimed. The DMI match was always by model, so no code change.
> - Added Closes: tag for the bug report, which carries the failing-case
>   logs, the VBT dump and the EDID.
>
> [1] https://lore.kernel.org/r/CANFnrspHiK7ii28XPdLkOMyhSZcJ9xz6CT-kNX+oiiF+8N-2Fg@mail.gmail.com
> [2] https://lore.kernel.org/lkml/20260912091805.531666-1-andersen.theo@gmail.com/
>  drivers/gpu/drm/i915/display/intel_ddi.c    |  7 +++++
>  drivers/gpu/drm/i915/display/intel_quirks.c | 34 +++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 02a53c9848e1..f746287830b3 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -4976,6 +4976,13 @@ static bool intel_ddi_a_force_4_lanes(struct intel_digital_port *dig_port)
>         if (display->platform.geminilake || display->platform.broxton)
>                 return true;
>
> +       /*
> +        * Machines whose firmware leaves eDP dark on the Intel side never set
> +        * the bit, so trust the quirk rather than the register.
> +        */
> +       if (intel_has_quirk(display, QUIRK_DDI_A_FORCE_4_LANES))
> +               return true;
> +
>         return false;
>  }
>
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 33245f44c0d5..feb28956a013 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -100,6 +100,20 @@ static void quirk_disable_psr2(struct intel_display *display)
>         drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>  }
>
> +/*
> + * Dual-GPU Macs boot with the internal panel muxed to the discrete GPU, so
> + * the firmware never lights up eDP on the Intel side and consequently never
> + * sets DDI_A_4_LANES -- even though all four lanes are wired through the gmux
> + * to DDI A. Without the bit, port A is capped at two lanes, which is not
> + * enough bandwidth for the panel's native mode, leaving the connector with no
> + * usable modes at all.
> + */
> +static void quirk_ddi_a_force_4_lanes(struct intel_display *display)
> +{
> +       intel_set_quirk(display, QUIRK_DDI_A_FORCE_4_LANES);
> +       drm_info(display->drm, "Applying DDI A force 4 lanes quirk\n");
> +}
> +
>  struct intel_quirk {
>         int device;
>         int subsystem_vendor;
> @@ -142,6 +156,13 @@ static int intel_dmi_no_pps_backlight(const struct dmi_system_id *id)
>         return 1;
>  }
>
> +static int intel_dmi_ddi_a_force_4_lanes(const struct dmi_system_id *id)
> +{
> +       DRM_INFO("DDI A is 4 lanes despite firmware on %s\n", id->ident);
> +
> +       return 1;
> +}
> +
>  static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>         {
>                 .dmi_id_list = &(const struct dmi_system_id[]) {
> @@ -188,6 +209,19 @@ static const struct intel_dmi_quirk intel_dmi_quirks[] = {
>                 },
>                 .hook = quirk_no_pps_backlight_power_hook,
>         },
> +       {
> +               .dmi_id_list = &(const struct dmi_system_id[]) {
> +                       {
> +                               .callback = intel_dmi_ddi_a_force_4_lanes,
> +                               .ident = "Apple MacBookPro11,5",
> +                               .matches = {DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +                                           DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,5"),
> +                               },
> +                       },
> +                       { }
> +               },
> +               .hook = quirk_ddi_a_force_4_lanes,
> +       },
>  };
>
>  static struct intel_quirk intel_quirks[] = {
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52faf..d2b8e9183c62 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>         QUIRK_EDP_LIMIT_RATE_HBR2,
>         QUIRK_DISABLE_EDP_PANEL_REPLAY,
>         QUIRK_DISABLE_PSR2,
> +       QUIRK_DDI_A_FORCE_4_LANES,
>  };
>
>  void intel_init_quirks(struct intel_display *display);
>
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> --
> 2.55.0
>
