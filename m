Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC256606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aasF9R53
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA9310E344;
	Mon, 26 Oct 2026 18:18:28 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE7F10E344
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:18:22 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36a10095f3aso23653eec.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038701; cv=none;
 d=google.com; s=arc-20260327;
 b=ZmQvzE+TlSyqDGkbw42ulFXfi7QHvfBxV+pE+HqSdNvT5Ocsx1NmTH1ZjCaYIS1Tn9
 rqixYQO2f210P7/Nor5m7aur+ACMXMUiOpRhLMJbHAICUGam2Ff3uxGEO6Wt9uCOLC8T
 CilUL3i5wmYRJe8u8S44BWD81C+ww/RBRIukferG/Ef13pIzjPPIPgVRloYBBm/bSMyu
 IhfcSRBSvsar4hfxBtMdkyoW6aJ+P/zVdmxrHD2oEUOu03hHWTKjrDO3ehgJtm4VC8K2
 Nvq78d+OcC9UTTnY4RY08F0LWfFvGfAn0D41f26y+kr4QzV7obcgkL/Jw+coKOuzuLLV
 9x6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 fh=msLGwEhzdxFpcjQc5paXPsZ7tZL31Zydr+NmCzTYQsE=;
 b=gTs0EIA6lfd0wf6zblSRRyXe+oiOpXXgHbBDs6uRQVhwWX5hAB8BDG+iVEEsIq1rsh
 9X0iPvlC5h1IIb+Kw8dVgrlEbSEANEW8qdhbaImqyAjbaknSvPfBbrh0hBuHKlD8SbFq
 2gae2gcAnr4iD+VIO3HeOisALqf8zf8tTzaMSjG8/a5yCW9DThT1OrxagiOg+R2ySpzG
 05WdyCDOt1HShy5GdHsCsJg9SmPK6UuIHlpS4hMSQxYP9la1MEiZDMKdcxY9qTN96ds6
 4lrjAc4YVrNGxgFmyRCuRNCkMFwIbMB15XFplYkYTMsXyaHO1RW5TaK6eDtqzg5s8H4K
 +pQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793038701; x=1793643501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 b=aasF9R532WA4TtV+fFjh1Cfw6zEtP3ruWvGIQ6UHm5AN4ZGsKrPmckUJ0HhGeM8jGs
 8ssfzNgZW61gw0xXD19iiJ93G+5e7r0zidLWUFtERLYxg65A/3PwlYMi/FxbDKpeJD0m
 aECcd9et7pp0oFszpET4gNoyY6lYzHx0bvtyn9JrI79SHNEKJDjWOCxZYKOcAL6OaudU
 YD69lp2YN5ybagynaILb0GfsMHGrHrnIkL4qLdLi1qn1i0Q+blo8KPapuXpr6zgLaBNl
 IXy7EoFMFnD/Qk9wotlev8LSJyEe2f6FDItg2NFRYOt0pXIkrdkJLklBmdDxSz9hcUtn
 VUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038701; x=1793643501;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rUFVEl7fV+HUh8nhoQnb/g9LkM23VhHFCgUj8hV83sM=;
 b=IJRRfqMrhdvCTqsVeemsNDLKE1rO7g7m6hyKzwvL/UAkHDDIE6fyDz5gFq9d/ZphCd
 5z5F6iUiiiA2XnHBJ1N87vdYN3xWEPgEaL7pmWO8UaOnsGUN9/uqFUEcXqPUWTiKG4IX
 OhjrVNcw42GKX08N5H0FA4CmAi0DFFb2CHS80zAiFOwCK7Usyh/woQRprgNVQgDdD83T
 +tkEwmjokV4LDQr03vrZGOsusoTTeJyhsfnsSLyQRqMkgnp5V/33uxgjc0c/gLCV0//G
 C5+B6rgKuqHByQvDWmtxEte8nmaM7ZIRAgNFMIu+AV0o93x1Ag08/Ihz8/fXF434uzug
 xewA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE4ns2IaSjEkGua1ZKiUTlqKsCHfV3WJ7V/QuhExZNW6yP7IaoCAYRZ+Rac9cDHLlPnHHWls32/B0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIQKPIyObzFbNPiWPJKCSKbDgZsET62Xn02oTMR0GNogYuSKioW
 Vm47zftmRepKwqWvrnlsks0PCiwhBoGyWGtLRgCv768pIDDda+B/HMQ7NV2eydj67Hap0Ju8TO4
 GlOwDm/8+27BgGwacfugaa3Q0H8i+Mhs=
X-Gm-Gg: AYBFou3rkk0k/j5BSCw7vWHW8dWCcMyoYM+MfdxUzUe5EHWn3N7jT+NCfmHOoAZDbnY
 hYNAnBZ7OqJYGpZIiHbdiux2HDsOEum6uxvrJaPtoTtAz9Q8ExEhW1FkqkoyoeQtrCsR+PgTUmq
 EwuR26XdDhqGMuBADvm8VY6HOChYUmTmiLNxb9W8Fwx2NlNRf2XPDt7vESDRnXM3qfb3h6Tmlwl
 LVXKAgi0FpYcn/ZbM76fKsVX/XqAqPEbq5TLoUSuM8fKrkknab1Zh7YK5wr2qVqmHdPeQy3UcKH
 /tHQnYB7nM5HtGSNULD0dUVTLxGpapx5I5f9j++Jr0JZFHIlWUJ9yAzLmAX40CGIC5wEE+frIzp
 VKplVYLyvZjnJzG9oCfSgTNgRAuSULTDTRuCEfxGhFF36QxQ9Fu+pdov0nrSPr8whOPMjnQprIV
 j2kLVu1Ug1DjTi5jKb1vszhZU=
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr16191284c88.1.1793038700920; Mon, 26 Oct 2026
 11:18:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 14:18:09 -0400
X-Gm-Features: AclHuK_gGXqjT0cI7KV7tvEEJQhRHXFUqhLnyaELH9XqFgMeuwm1bkZPQKcDe-s
Message-ID: <CADnq5_NLhN4TKH-afTtJdF2d-e0=1kysf=pWiUpXu+bLhJFEeQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU
 is runtime suspended
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Andre Eikmeyer <dev@deq.rocks>, Bjorn Helgaas <bhelgaas@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Kenneth Feng <kenneth.feng@amd.com>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
 "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>
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

On Sun, Oct 25, 2026 at 12:11=E2=80=AFAM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> From: Andre Eikmeyer <dev@deq.rocks>
>
> Plugging or unplugging the charger raises an ACPI AC event. The handler
> sent the new power source to the SMU without a runtime PM reference, so
> with GMUX keeping the GPU off every SMU message spun on skipped register
> reads for seconds. A runtime resume racing with that left the SMU
> firmware unable to start on MacBookPro15,1 and the GPU in runtime PM
> error state. Record the power source only and let the resume apply it.
>
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 808be6c42..b64f0b681 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -30,6 +30,7 @@
>  #include "amd_pcie.h"
>  #include "amdgpu_display.h"
>  #include "hwmgr.h"
> +#include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
>  #include "amdgpu_smu.h"
>
> @@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_dev=
ice *adev,
>
>  void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>  {
> +       int active =3D 0;
> +
>         if (adev->pm.dpm_enabled) {
>                 mutex_lock(&adev->pm.mutex);
> +               active =3D adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX ?
> +                               pm_runtime_get_if_active(adev->dev) : 1;

There's no reason this needs to be GMUX only.  You can drop the
AMDGPU_RUNPM_GMUX check here.

Alex

> +
>                 if (power_supply_is_system_supplied() > 0)
>                         adev->pm.ac_power =3D true;
>                 else
>                         adev->pm.ac_power =3D false;
>
> -               if (adev->powerplay.pp_funcs &&
> -                   adev->powerplay.pp_funcs->notify_ac_dc)
> -                       amdgpu_dpm_notify_ac_dc(adev);
> -
> -               if (is_support_sw_smu(adev))
> -                       smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +               if (active) {
> +                       if (adev->powerplay.pp_funcs &&
> +                           adev->powerplay.pp_funcs->notify_ac_dc)
> +                               amdgpu_dpm_notify_ac_dc(adev);
>
> +                       if (is_support_sw_smu(adev))
> +                               smu_set_ac_dc(adev->powerplay.pp_handle, =
true);
> +               }
>                 mutex_unlock(&adev->pm.mutex);
>         }
>  }
> --
> 2.55.0
>
