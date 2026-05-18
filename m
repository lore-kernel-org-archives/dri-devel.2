Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E64CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A5F10E31A;
	Mon, 18 May 2026 14:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mSRMFyFd";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD8010E31A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:40:17 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67e2498f3a7so5258888a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779115215; cv=none;
 d=google.com; s=arc-20240605;
 b=c84NsSw/mMI62xHUUI2mUl3xb6kcwpJVreZEMsr80Lu1hjAHjcjqyBGsCCFanV0ldR
 5RXM+cCdbzLjMk1tfwovTR+TtMemOSBPTUuvSSLriMNId5eYa90X0Fj9bzyKbziEynXw
 0M/RLH4IStX9CgrYJ5EKMHDhyCXYp35kIqoaNElIx0sSPT2pNA2u4+ofAsLwp9T4prMG
 3GXOvet5Mf+FO9SHVtkpfpOiDGsVPXIl9NJ+utLBy0NMfJCTLw+OrEEZPcE2ik2ih3Z0
 bstFE8srg2ubu5JRn7Lf+4HB4HTMcTxBo5Sx8agFjmO7PYk8ZWkuYK2Rg2cJS+rsYxnj
 LtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 fh=ELuX8qFncJ3eFvZoBLCsOYdsNQGmzp3sE1nM7k0JL34=;
 b=CGickRxz4lZ63Q8QIYd1n6Qr+SCfMykMCCAXgMF4AFPE60c3hR2xQ4FQxagmI1Z0Y6
 L+AW5yjcdC6scMFzDCjUwBNGghHs0Dile6HO35bi6x2/amK4D236YY6VmT0uEnmAmC09
 y7vrD3qftcrtEerDvTLUCqqG+uin42DR9xJ2sjwtAb8C2rN4NlOMAGrE201YKGUPfqrr
 zn6MV/IaQmr2uL6lT4OfaYEWMQwBLWp+ycwjrZsOQRnbmL6HTIWANa+nwToN657+el9+
 2z2tUqxM+UKGFA7/A/a+bhcIuVFiHfXdGiJDSKzg3Af0soAm0pv5UpXTC/nsNxKnd8XD
 nj/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779115215; x=1779720015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 b=mSRMFyFdbo/NKMCkLwwqLJPuI2BpZB6EVfX/9EXYcM/LH2/+rviLs6HtbUX+GAFsSj
 Z52KlrmaLSMDh07zxWRGTMKjt1MsJ8N3QIVcXH/Kb5Gze1fH/+jL6Nbhsh3pLWIxCKhr
 4Re3y5rbn6d7m8iwY1xYBwW/JzT/swq4sC65P4nkuiHXHKDVHt67AwUH60hV76y+WHbH
 8HWHXmP40GA7r9Krwgn88LHQLyRObULfnTrmIeZFnidqoGWWdzvVbFkzFSdRD9GsTUKM
 l8OuoueGvnDdi+qTQ+5CR7iFoxQqvhrPYW9E2+EVPaRCVfFJRGqMXWeQWB4ZP8simEoB
 Ns5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115215; x=1779720015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23OQBj946LsrUWd9smy0+poYAXMVfhuEdwxjZI4yuq0=;
 b=RKJHga1oqfbDSPXFCbxrPaTOowO5cNnvzlYfoWMzi7kSxGxdxeA7Gi9q8Kg0dhdTcw
 /pyGRkpCkd+hZ6CJT5kftu5hyXlxLcvJz6TqLilw2paN7F7O/W759rI3TcU/SP/eoOI+
 1SvkISexJJbSd1D0LWpWY/wN2S5T/SQ3ce/aCpYIALLOG2RcF4ifea6FKSdltKUpF0u0
 Cjo2mf1qGRS+GPuDXVVlrVU3D0kKso8HAwm/PIC9YxLZV/3ubc5pOL64b89XPSbfV3AR
 hgTvbGF0/SgWQzjcfUofwTI7UDyDnV0DiSAMVP75aa7UeMMaIlPAfBGkd1rC/EwkaP9K
 4Mbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EhvUPJaXYmuNan2sqzja0Qwv7zglpuiC6OVQEijiWUhBwUOPFMa5PNYzmficeXTJJBeMW0c/Vg8Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAktv1JbCvOOU4y5EnMM+Ye9ZP+mFqzKyxW+6+SKPYexdPECd2
 pd2VlhHvVcY7lApyLkhxX9SA4zcEY9tzsTr78oQ2mejdfurlHMcX01Sn/Fr70xJreWL/YkmGsH4
 Q01jEJ8RLAit/Grcu4LURBSKJGqQGwRA=
X-Gm-Gg: Acq92OEgJWHiyZqMRlfgez7e9F/eo0nCh3lRGeycWHmBQBuevR+aB+S78ctXpUQu6D8
 u/hw2pW9guEerYc7+0pDiYWpXaw82jQF2t2+ysIakH8jHDohzIZ6mkzgIzq/QUYaVRREgDz1AAM
 3r23ibHEswFpE1nknXoil3CEUg/vllSSCBjBqmRXtTN7N0feRstQ1voaNZY8YLttNvKpvS58jLi
 nbfPM4MvTqkc5pT7DMr6G0T9LCjj6CpPDvpSqEGHavb/lCNJEcQVapM92uZXqjiwkyUCbtaFFXk
 AwOZmw==
X-Received: by 2002:a05:6402:1bcd:b0:67e:2498:dc77 with SMTP id
 4fb4d7f45d1cf-683bc2c14b3mr4963249a12.6.1779115215271; Mon, 18 May 2026
 07:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260516092420.3579-2-gilles.risch@gmail.com>
 <20260516185226.3005-1-gilles.risch@gmail.com>
 <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
In-Reply-To: <CADnq5_OZ8c4r-b6EzWCWuPA4BfDWs99ypJx-tS0FBuRZqHzH8w@mail.gmail.com>
From: Gilles Risch <gilles.risch@gmail.com>
Date: Mon, 18 May 2026 16:40:02 +0200
X-Gm-Features: AVHnY4L2NaW4w8sTXjQU5-0-qwZgPRCfD39LXc2zqmS6AjQsLTGx9Dzu4uqk_6c
Message-ID: <CALnjqVm06ZJ0mAE9=mQdPwDrNu0gtPmsQpwzn0NDbXDNugvJxg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11, 1 /
 DCE3.1 systems
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

Am Mo., 18. Mai 2026 um 16:13 Uhr schrieb Alex Deucher <alexdeucher@gmail.c=
om>:
>
> On Sat, May 16, 2026 at 2:52=E2=80=AFPM Gilles Risch <gilles.risch@gmail.=
com> wrote:
> >
> > After suspend/resume the internal eDP display on iMac11,1 (and
> > potentially other DCE3.1 systems) stays dark because
> > atombios_set_edp_panel_power() skips panel power control for
> > anything older than DCE4.
> >
> > Fix this by:
> > - Extending atombios_set_edp_panel_power() to also handle DCE3.1
> >   by changing the !ASIC_IS_DCE4() guard to !ASIC_IS_DCE31().
> >   HPD polling works correctly on DCE3.1 (verified: HPD is asserted
> >   at iteration 0 on iMac11,1).
> > - Issuing ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF for DCE3.1 in addition
> >   to DCE4+.
> >
> > Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).
> >
> > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
> > ---
> >  drivers/gpu/drm/radeon/atombios_encoders.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/d=
rm/radeon/atombios_encoders.c
> > index 4e984973c043..b62fd713efcf 100644
> > --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> > +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> > @@ -1383,7 +1383,7 @@ atombios_set_edp_panel_power(struct drm_connector=
 *connector, int action)
> >         if (connector->connector_type !=3D DRM_MODE_CONNECTOR_eDP)
> >                 goto done;
> >
> > -       if (!ASIC_IS_DCE4(rdev))
> > +       if (!ASIC_IS_DCE31(rdev))
> >                 goto done;
> >
> >         if ((action !=3D ATOM_TRANSMITTER_ACTION_POWER_ON) &&
> > @@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *=
encoder, int mode)
> >                 if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encode=
r)) && connector) {
> >                         /* DP_SET_POWER_D0 is set in radeon_dp_link_tra=
in */
> >                         radeon_dp_link_train(encoder, connector);
> > -                       if (ASIC_IS_DCE4(rdev))
> > +                       if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev))
> >                                 atombios_dig_encoder_setup(encoder, ATO=
M_ENCODER_CMD_DP_VIDEO_ON, 0);
> >                 }
> >                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)=
) {
> > @@ -1724,7 +1724,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *=
encoder, int mode)
> >         case DRM_MODE_DPMS_SUSPEND:
> >         case DRM_MODE_DPMS_OFF:
> >
> > -               if (ASIC_IS_DCE4(rdev)) {
> > +               if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
> >                         if (ENCODER_MODE_IS_DP(atombios_get_encoder_mod=
e(encoder)) && connector)
> >                                 atombios_dig_encoder_setup(encoder, ATO=
M_ENCODER_CMD_DP_VIDEO_OFF, 0);
> >                 }
>
> These changes don't make sense and will break other DCE3.c boards.   I
> had the attached patch from you in one of my old branches, does it fix
> the issue?
>
> Alex

While the initial attached patch resolved the dark screen issue after
a fresh boot, this follow-up patch addresses the same problem
occurring after resuming from suspend. Should I used dmi_match() to
avoid breaking other DCE3.c boards?

Regards,
Gilles
