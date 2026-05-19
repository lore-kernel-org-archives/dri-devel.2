Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF9CD5BAC
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC9610ED15;
	Tue, 19 May 2026 13:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gkuhsxzC";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EB810ED0B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:42:26 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2f114d129c0so204218eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198146; cv=none;
 d=google.com; s=arc-20240605;
 b=APRX4+Ea2jce43CKpqdbcLhSgdBDNTpBHI+mNLmYFHBWvPPewS24zQJtPo3m+Tt6gk
 QbrfFp21Eh2+quuS1SROnGrk0rtTeb6dzy6SioaFR+liPSSnvr2POnmyxwD6OsLDCnSR
 u2tB1RCYjurhRB1D7L7h9Mh7/EtNrBSQkGM07c10SwhEGQ20yySDUwidoAN6NerWiYAu
 uRxR4q53HV+9f+cxQUWT2q6zEfqUL9GGIjpqew9Mle+S/MHIL7eAENXa+PlHW9U/RNmu
 TfzJYI9zoV1kC0tKKdwgemGfE9pEfs3us8I+q/dDHQJrErBco9De43rnlXIR0RukEV0j
 HHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 fh=zthxoIEi5cQOevb7i0d9HIcZCmkTuYHbSMRqQCDjzBw=;
 b=gqm1FDoQImZodQ2FNO9MS6c97m98zyZ7vkeDirur0cxe5+wb1zKFjPyLE/IMWmd9ro
 yDf6AGYUDFVPW6EbnmhdwfT9Kx2ohbfCCFW8Mo+096hXWssrJqg5pxqO5qKasNvwy4ss
 1K5+DiHH1j/tUa1ZX0mUmDO0SABnzY2cmDoP2L9/o+UfvVPhKpUF3VHeoMOqAxbuMFhH
 f1eVbVgfg1Ffu3l+WMXtK10WGQypA2cXnagdfoYFLdMMz6U3E0gdiUmKlpEnO1W+zc05
 kZCo588sk+wqrax3G9eBWiNScjZSFqc7xdXo53CIu3C42fPGfJD5GUNQdmTDyHHrO2SP
 92Lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779198146; x=1779802946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 b=gkuhsxzCzSLqk9l8QHWOdFTub3SoVjaEXszz1tn4hElXNYsEyza4vwQ1PCAp16VyKU
 tJen2aGf98ZIh2cjIcRBlzuqxh9dD5NKxJFubxtD9HX+l1w3l6jWPQQAj5T0pGTWbfBp
 xGvEwCbBB4Nvt7m55AbpHRS7PV7Q+t6qPX3hOMh2gWTNFrKsf03jCgeLOPT4Uvb6E/8B
 3olYB4tKNEneN3vWgCYzJF8mMu0B77wQsNyBqWpdLWgUfvQ0tcsfpKLB0uY5AL3jOkvz
 9cbqjFoYB3sE4gvKe18l5vD4C+s+5OSWrV2SZusIFajHRcmsOYRflw9riK3kDVVs7ReJ
 CFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198146; x=1779802946;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=71RQW5pfUHXRnnnRXS0mng2QejjcGmA/JoFbS3GPQiM=;
 b=ZA6Ua1ZvjO/wSSvuup8bVH4RONurhdiArf8mf6DkpTdMwGoR+VWIrtJUOCj7iHrjLB
 0tph1RtLEt5fW5sATKbe9enoZfaJQQBamFnyctcGV4Su4ld1BdR4lYmh8L+gdMl9G75H
 4Or2HbJHuTZY4UlmyLLEZZM3kZLqAnvnnZa44VhH5pb5ZAZt7P7+/nJpTP4F1pTjehuC
 HKnOVHO9JSjPI/PZRnXlB8c0aCXM7jtpVZLfKP74mTyA3b0WOD3L7IvzQ5NupRK5/8qc
 Uv1RWrGRoFOPmdAMDOKtgB1/ou7rg6d4GR2HSWRNCz7ddEKxAOeIAR4vPm0HL3teheiV
 wAKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ddoHaAMl8xXfyFEI8VbMu/S2T9av13rAbVaBXZl7kkY0j1OX+uWEWrhb1LToXzeCDAAvEobGdnkI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAjo7TBRBfhtNXYNRDDVag0d1sxJfiYzPfigAfmGhtaLuke4Mo
 7UOsLT8ijbh84YBY/YShnXam4GEZbsJGsF/48dal7/MwKXfilLMu5Rh+hOwyvtd65TNMbL5gdmj
 uTOEIGufgBNG7A3ncnn/N3RZqlnOhoqk=
X-Gm-Gg: Acq92OHXbtQDdElckJj6IHcQv5ibFEhViMGFY8oHJdOvTLjDXEUXZw53TxpCXw/R6VB
 a7qyqLMG6apkWJtChwVKPj8VKgm4IZcKUBWnw08S/lCSIQtJsHHRzUu7DxGkq2EI/w5qY+RBA3j
 WAXUmE20KFqusUXe0i3gu6h47+ycwcPYXHLV/AB5DnrU/DA1ONiPCHNzbj1orJmrTv/Fhuf+GP9
 menVtMZtel2I1oGw9vm/yxiUxGwlME3yUzce7Uuhf/a1yFLZrUBfg8sngMSgFxghDvMRsw5uXc5
 f9enWMrDDLCYhgWyYC2YPX5dnX2DQ7sF0FGbqi0KUl2DcnDU5sdH4u17yWlJXkmWugIojg==
X-Received: by 2002:a05:7022:327:b0:12c:20b9:80fc with SMTP id
 a92af1059eb24-13504a4d776mr3503772c88.7.1779198145570; Tue, 19 May 2026
 06:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
 <20260518211409.4868-7-gilles.risch@gmail.com>
In-Reply-To: <20260518211409.4868-7-gilles.risch@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 09:42:13 -0400
X-Gm-Features: AVHnY4Ky7Y3vLzKy-VmHgzIOBwHN7Me7gRyd48k7a3HIf7zj18dJ0_fyvAxPfpo
Message-ID: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/radeon: fix eDP resume from suspend on iMac11, 
 1 / DCE3.1 systems
To: Gilles Risch <gilles.risch@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, lkp@intel.com
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

On Tue, May 19, 2026 at 3:44=E2=80=AFAM Gilles Risch <gilles.risch@gmail.co=
m> wrote:
>
> After suspend/resume the internal eDP display on Apple iMac11,1,
> stays dark because atombios_set_edp_panel_power() skips panel
> power control for anything older than DCE4, and
> ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF is required on ths iMac.
>
> Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
>
> Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 4e984973c043..0a699a887ee9 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1384,7 +1384,8 @@ atombios_set_edp_panel_power(struct drm_connector *=
connector, int action)
>                 goto done;
>
>         if (!ASIC_IS_DCE4(rdev))
> -               goto done;
> +           if (!dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
> +                   goto done;

This logic is harder to follow.  I would just add an additional check.  E.g=
.,

         if (!ASIC_IS_DCE4(rdev))
               goto done;

          if (!dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
                  goto done;

Other than that, looks good to me.

>
>         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
>             (action !=3D ATOM_TRANSMITTER_ACTION_POWER_OFF))
> @@ -1707,7 +1708,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)=
) && connector) {
>                         /* DP_SET_POWER_D0 is set in radeon_dp_link_train=
 */
>                         radeon_dp_link_train(encoder, connector);
> -                       if (ASIC_IS_DCE4(rdev))
> +                       if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_N=
AME, "iMac11,1"))
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> @@ -1724,7 +1725,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *en=
coder, int mode)
>         case DRM_MODE_DPMS_SUSPEND:
>         case DRM_MODE_DPMS_OFF:
>
> -               if (ASIC_IS_DCE4(rdev)) {
> +               if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iM=
ac11,1")) {
>                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(=
encoder)) && connector)
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_OFF, 0);
>                 }
> --
> 2.47.3
>
