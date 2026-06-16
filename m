Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62593CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC8610E60E;
	Tue, 16 Jun 2026 18:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZ4BuJOI";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 008A410E60E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:51:52 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bc5fa5a2aso67123eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781635912; cv=none;
 d=google.com; s=arc-20240605;
 b=b+Kzr4FovTDbuYjoqgYx/8E/k3ywG3asQ0N9GsQmOz6wd2MJxizKOBW5/mxW4y9PRi
 pxefq8VM5txj34aOOFOqyStG7463KwQ09HvVI10UK34FEFO0+U0iRzWpHJug6iRbDI94
 5aqckQTN8oMCu7ETzkaXY8+eNN2WD7VcBTM3CV+/rDbkcvaxRhkzV4pbxDUdf3SR0Ic6
 FA25I70MIrjfj8qBaWbRQQRP/1JOmVQ1L19pT4H0Ki4m/RZbx/BO4oYahcAeHFYZwENB
 Q4z9vQszBSARypeyNEqZBzTd9OGjYesiPOlWNhfJDcs0G/mWEsQt3NuRzpF2c/qkbu1B
 LPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 fh=S3cBxcMxJ8yefvuqzH1VhIpE/b8Ua4ON6POaT1InPDI=;
 b=UxQOjPaEZsCw1HX42kFS116/s/cgUNVf+a/p53Np+G7n5Wyoub8b3DIJ2RfRz1y0pZ
 FTtUJ/NhEtAduVDO/P/7RplY35+zfoeGxPSL5eBC0qASDxu355sHuR/bd8huCMsupZ1L
 q/+iVtb/7QKXe2PZtCYfwLpHnxjgHrSwnlU8zlf2jSFJy0vDN7n6VMim971Ny1vyhyy3
 o1d7m9RjcrfNb0gLV3kB9Iq4ipMRG0RpA6Ok2aHoqYa8SwJztkXnMxlHsIsmmrX8wT3u
 1YZiHMB1gAYaSUkVFAvPZYQUKXrm0yLeOKOYPRjLwYS2bwRujG24/8SCJVIAD6eHF2Z2
 tzcw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781635912; x=1782240712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 b=sZ4BuJOIRfRaU6AZFHTsC/XDxviprJhubhgqmb/DpxXWCzPFV7QGFAWqMqeIZJLhYY
 WhLowUflXYp+5rAxZejAbZeYFv7DEOucKw4YJCh6E9qWNwwkdj63z04q0bh1d8uXxv+k
 L8wPeCFzekwSDee1eZ9WDRI5Oo5Zd+2ksiBSRElbdGmPq33Gd4awv3cfbdgv7B4iq5yZ
 IUZi7vVQIx8m9awpcQbG+d6DgKSDeuewSKU1qiqwWkzzVz/iwP2ra4m6LD9pxYpgCuIW
 mT90pQTkK0HxNwzhiUb1qgGu8gB4d8zhoCu/ORAT1YP1GjtRpW+lFLMQzubSSHbWeDEo
 kb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635912; x=1782240712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lLZGG1vL2Dqwzut/Q/EWnM0Po9IOyB/nN+ycn9QeZq0=;
 b=DIJl5x/MgAWt1o+NBzbj0pRAYEgorYoZP2NYV7q2cA57Jtm0kcAjOPhvYLyKoimp7I
 Zq5/hcWTK2uCgvaHEWdVLTQD/ry0MlNQMeT2s9NUCSwKU3SbqmF5Pd/xxLSMp07NGqGy
 ZR8iXhvJZxZb/jQqxkq6U5E2k50inR/iYhqaGuz7P4ew/M3ATarDmKj5bfbY3kt3uQUw
 VZI2p1LUV5uEXDq6/bydDXHlejxK8iB8eQ28l++p3RcTt3KQIzktg4MvgMYA+8c5uOiU
 k7HdwlNdBxXvkcbullrh2HvUNzg8TEIw08peL5gSD3dO180jRfyPUuS+9qRXO1XcQlhb
 l8tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FuFDv4+ImXbQjV6isMntl+7Ul8rlz7LuA58RYqI4N/pgkA0Xc81N+/MFIbc/wPjXwjJ5TVA/uPiY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHEgYOfG0OgQ7qrskC6Td/ehj0SGxPSMdzlF+yMI2UVA13EYzP
 8P8iHUO0NsMmuMULi8G2Ursx1myA/zaB1HI4BX/cOQnvg18C+94zA77I+PVTyGn7+w3dHwXfhsg
 zpmUlMjcuvYcoY0VwHF9g5ZJLQp9lXeg=
X-Gm-Gg: Acq92OFkVwEPBZHlRGicmezoIfXjUmpZqml9+74MdErDLKP3JZP8X6MNXEk1CYnIFJ1
 ltGBctEf5qmQiAOQxKZjqLQhPhBgWNFAX8SJtFqKuGfQTtNXJI8AA7b8ySQLaD2h390ZhXmDMYg
 m6YWhA7+VDTOr74BEEqcbbZxVaJNUVRCLYmV0pMFjkV9AoqQCO5O3rTndJTJ3mOmPeILOWNaNU5
 0IF7UwG38pI5qSocPI4JUd9rolg/SBP5crAE+oFR+Y1Mvw/EiZLEPzu9q+A14cP9om/x4c4P5UW
 9IeWrPnQSce42uHEj/lo6zuM9TMSLHIeJIiozpsGySn1HmWPYWEPPUHkgc4TpAkh0u7NstLrxZy
 2mOV0
X-Received: by 2002:a05:7022:110:b0:136:d029:451 with SMTP id
 a92af1059eb24-1398f6ab309mr34977c88.4.1781635912245; Tue, 16 Jun 2026
 11:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <e0689a10-9cd6-4d74-a276-99f8f01c83fa@web.de>
 <e2023393-da68-4775-9f55-16363191328a@web.de>
 <CADnq5_P6aSFKefO+f3aofhfNh7kELEQWxid4EWgwAUr2saEh8Q@mail.gmail.com>
 <1ed4140f-83b6-4393-a67d-ed321b72ecb2@web.de>
In-Reply-To: <1ed4140f-83b6-4393-a67d-ed321b72ecb2@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 14:51:40 -0400
X-Gm-Features: AVVi8CefSVV3ctlIm4JKXFEe2ToHhWyUVnA3pqitzvirCD1F3rsg-SVQpZJKAs4
Message-ID: <CADnq5_PSRrvhUvzkZQGiA=U7kyyowXjO+GC_bPP95jg_OzpOUA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Simplify data output in
 psr_capability_show()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Kees Cook <kees@kernel.org>,
 Leo Li <sunpeng.li@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Rong Zhang <i@rong.moe>,
 Simona Vetter <simona@ffwll.ch>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Tom Chung <chiahsuan.chung@amd.com>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 16, 2026 at 3:19=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> Move the specification for a line break from a seq_puts() call
> >> to a seq_printf() call.
> >>
> >> The source code was transformed by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> index 4b09a740f205..6e6f391b640e 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> >> @@ -1076,9 +1076,9 @@ static int psr_capability_show(struct seq_file *=
m, void *data)
> >>         seq_printf(m, "Sink support: %s", str_yes_no(link->dpcd_caps.p=
sr_info.psr_version !=3D 0));
> >>         if (link->dpcd_caps.psr_info.psr_version)
> >>                 seq_printf(m, " [0x%02x]", link->dpcd_caps.psr_info.ps=
r_version);
> >> -       seq_puts(m, "\n");
> >
> > Why not just convert this to seq_putc() and drop the rest?  It seems
> > more logical from a code structure perspective.
>
> I obviously propose to omit a function call at this source code place
> because an intended line break output can be achieved also with the subse=
quent function call.
>
> Do you insist to preserve a similar statement here?

I think the code reads more cleanly that way, but it's not a big deal
either way.

Alex

>
>
> >>
> >> -       seq_printf(m, "Driver support: %s", str_yes_no(link->psr_setti=
ngs.psr_feature_enabled));
> >> +       seq_printf(m, "\nDriver support: %s",
> >> +                  str_yes_no(link->psr_settings.psr_feature_enabled))=
;
> >>         if (link->psr_settings.psr_version)
> >>                 seq_printf(m, " [0x%02x]", link->psr_settings.psr_vers=
ion);
> >>         seq_puts(m, "\n");
>
> Regards,
> Markus
