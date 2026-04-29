Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD5FFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B9F10E072;
	Wed, 29 Apr 2026 11:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rG/J2cDn";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16DE10EF65
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:40:35 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2aaed195901so54274265ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 03:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777459235; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/JKnthgNyiKKbKjfw5hA8ThZCXbsRy131E0vqpxq8J6RXn3cEHXJU3QV4YhRMKURF
 Zgeja68Y3Lys/OltO1EPefay7Mvi37qGBJD4vGzY09IZcYBz6MedLJT38gl2n5+NJ0Q2
 SvT/CGqMWEDhl7gokghrVQ7ow/hG8hyrKM03t4cT4JNAXQlQXJ7m22OZQVpmZfgzJunU
 uBbee9S58wLQ0EWOfgOf4PMq3gNvPARHH6DsGkAX/elzMS+mPHBYydpO1QdQcQ4dkO6g
 1+tQiLBumZ4wVXNYDwAObqRySGgvlj1N581bflLLvt0C0RfJc1Jksm5Lnqm/Mj91ujNR
 QNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fuysltsgFk0WIKWoVBX9JLiSUYJAJCsTpkzdgV9Xocc=;
 fh=HmRy+wRX6dZhfP6ZIzqij2iUV5krEVkOrXLCBg0EbM4=;
 b=PLM06uxI1Hkt/VE/MwpdiZt+te6OluF9wT5UdJ0391loXlnQQnu6KOYVtNLwQV15CE
 4qzB6qZmBhsNxyfhcavRLx+HPt1diq8jXvYeOLP1+rqT73gnEuPPGKUEkdwV7YtPMZis
 XTTjY9e62/gab5L5O7ut1pzwB+FDzig1R+pI+ZiP8OzRc+4qEoiVANDNFCh4Vu3acFf1
 +4WUg1kgGtHfU/WC4s0j7SQ3uqbmOzlVcCwScW2CjDBsThXRpUOEUQQA16xTOaGeNWAR
 waSKe7jqLp4NndvbdOpWLWh/M47j7gGcQcqae0QJ1xsQ482pOuHkkkS+Bprrtn7qzweG
 u74w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777459235; x=1778064035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuysltsgFk0WIKWoVBX9JLiSUYJAJCsTpkzdgV9Xocc=;
 b=rG/J2cDn6UWGaWbm8xCguUslVdkLFad2L3uh2OIHqCM7u3YkkaPylgj8GO42UsGysC
 HR+X1Y2r58yWv0C5EU0sT+p4D9iqpvaEGdQ9WiuCodQhMewcEMox+HpTUGb9rCIiIOB1
 1A+Ye1jAlMNKANdao715tHtaDsgpELHgx6+w9U0EuwrhM1f6I/STYP8Wme1ywd88x8wF
 8bj3hllKvq7K9uhFMI2kNOSEfVf3ACW+zXBB1yFKvtqE9kmL8tQaesnGZ6hncSmoHyd/
 zjjpjYD2SPx60+5rPg+CQd+sn/nbXZwx0wiZK2qZ6X5cGMtDiOiIuZ855uz9GoHRtFSu
 FPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777459235; x=1778064035;
 h=content-transfer-encoding:cc:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuysltsgFk0WIKWoVBX9JLiSUYJAJCsTpkzdgV9Xocc=;
 b=GQlflUbksuBNJRYS6Ws9oQlEEP4A9FaXb8eF6rq8w1ypMqVCzX4akWVVWmK/4fYAZE
 4OaxhX0CO+tz/gJef0zkokhdl44UjCz9vx4VeFrHs1P6hqy+UMKGT89n1dpDHYcgdQHj
 PQqblx4rHT9SNfso+dqZ5SFokFlL85/181sGLDrm7USfQO2iVL3sqgxd65E7lLpdD0fB
 ABY1IkplGhFdo16hU6nWLMfyp0vt2cy/i5s2o0TPclzF2TWfQVQGksOzhQQ9xl3W+dMv
 4KW6D/i+fB4nBUlQV2g11FydPujegswS1Hdhk4EhdHVk9KkGwGNdUFn86XtW8fVoF70J
 CafA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VEqfiwpvkmnmoZOPY8Fjoyq6fho0IlK6KJRE6d/qu3wjOqFpWED09TxoE//40+e07upc1+6Kj0QI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6YfJE7Foecnh2QweuWMsUsercmMqtgjyRBlOhGZ7TXrkFA9h7
 P68xcceAHdOqihFY3cnXq57EKYVEegLu+FNWkayzRnA7jpdy5U6P7odMWj2bpuk/RoqxJGAxk0l
 IQKin9IafVJZqKzGgMmCcet25tbfyjGs=
X-Gm-Gg: AeBDietO+SFNnB1XXQMN7SYYIoFsTeB7aum/LM3pXTxyrSRguR9tdX3tk+x/4wE/FNg
 d+T91KIoW18Po659b4I92jVZMohuiw+0j+kh2wSFnQ0JNPiZZ8YwdaU4fiAB34tNq/P4lNdVO/P
 uh+RN41pyzN5Qwqk/n/iIgxcsHZWs1bStjptrhJkX678VLWRr+suXwAUZ58Cc+d7zIK4BdsyJ9t
 jsw32vfzVi7g3bw+42odkqM4HD4ZNgpWm8B+2spXRoFt+38cMzP4Xys1bnuskRdiUFezrr5XThG
 aF9qvBoHiZ1E0hr16IsVLj9Ic9HSn6noYEl86kjm7Sxc+2Dd
X-Received: by 2002:a17:903:283:b0:2b2:b117:1e1b with SMTP id
 d9443c01a7336-2b97c41faacmt69453965ad.17.1777459235313; Wed, 29 Apr 2026
 03:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260319083207.17195-1-phucduc.bui@gmail.com>
In-Reply-To: <20260319083207.17195-1-phucduc.bui@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Wed, 29 Apr 2026 17:40:22 +0700
X-Gm-Features: AVHnY4Kzi4RMJAKx8NXbCdv3hrvj3qC4xvrlROsAZps_yFekvWzD_M8yHPqAL3g
Message-ID: <CAABR9nG6nQaX26Y-ocrp_=hHCVBi0H6wCty-fmvZuPsYLvB9Sg@mail.gmail.com>
Subject: Re: [PATCH v3] drm: shmobile: Fix white screen after resume when LCDC
 is stopped
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, geert@linux-m68k.org, 
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, 
 wsa+renesas@sang-engineering.com, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Apr 2026 11:01:31 +0000
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

Hi all,

Just a gentle ping on this patch.

It has been reviewed and tested, but I haven't seen it being applied yet.
Is there anything I should fix or resend?

Thanks!


On Thu, Mar 19, 2026 at 3:32=E2=80=AFPM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> The LCDC on R8A7740 may show a completely white screen after resuming
> from suspend (s2idle or s2ram).
>
> After resume, both Set A and Set B registers are reset to 0. As the
> Frame End interrupt is not generated while the controller is stopped
> (DO=3D0), the hardware register switching mechanism is not triggered.
> Consequently, Set A remains at 0x00000000 even though a valid Start
> Address is written to Set B, resulting in a white screen.
>
> This is a timing-dependent race condition. In some configurations,
> debug options slow down the resume path enough for a Frame End
> interrupt to occur, which can mask the issue.
>
> Fix this by priming both register sets with the Start Address while the
> controller is stopped, ensuring a valid base address is available
> immediately after resume.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
> Changes:
>  - v3
>    Update commit message, add Tested-by and Reviewed-by tags
>  - v2
>    Fix incorrect use of lcdc_write_mirror() for LDSA2R in
>    the DO=3D0 path; use lcdc_write() to update both register
>    sets as intended.
>
>  .../gpu/drm/renesas/shmobile/shmob_drm_plane.c  | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c b/drivers=
/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> index b61fda52d17a..23c8489dba71 100644
> --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_plane.c
> @@ -70,6 +70,7 @@ static void shmob_drm_primary_plane_setup(struct shmob_=
drm_plane *splane,
>         struct shmob_drm_plane_state *sstate =3D to_shmob_plane_state(sta=
te);
>         struct shmob_drm_device *sdev =3D to_shmob_device(splane->base.de=
v);
>         struct drm_framebuffer *fb =3D state->fb;
> +       u32 ldcnt2r;
>
>         /* TODO: Handle YUV colorspaces. Hardcode REC709 for now. */
>         lcdc_write(sdev, LDDFR, sstate->format->lddfr | LDDFR_CF1);
> @@ -78,11 +79,19 @@ static void shmob_drm_primary_plane_setup(struct shmo=
b_drm_plane *splane,
>         /* Word and long word swap. */
>         lcdc_write(sdev, LDDDSR, sstate->format->ldddsr);
>
> -       lcdc_write_mirror(sdev, LDSA1R, sstate->dma[0]);
> -       if (shmob_drm_format_is_yuv(sstate->format))
> -               lcdc_write_mirror(sdev, LDSA2R, sstate->dma[1]);
> +       ldcnt2r =3D lcdc_read(sdev, LDCNT2R);
> +
> +       if (ldcnt2r & LDCNT2R_DO) {
> +               lcdc_write_mirror(sdev, LDSA1R, sstate->dma[0]);
> +               if (shmob_drm_format_is_yuv(sstate->format))
> +                       lcdc_write_mirror(sdev, LDSA2R, sstate->dma[1]);
>
> -       lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRCNTR_MRS)=
;
> +               lcdc_write(sdev, LDRCNTR, lcdc_read(sdev, LDRCNTR) ^ LDRC=
NTR_MRS);
> +       } else {
> +               lcdc_write(sdev, LDSA1R, sstate->dma[0]);
> +               if (shmob_drm_format_is_yuv(sstate->format))
> +                       lcdc_write(sdev, LDSA2R, sstate->dma[1]);
> +       }
>  }
>
>  static void shmob_drm_overlay_plane_setup(struct shmob_drm_plane *splane=
,
> --
> 2.43.0
>
