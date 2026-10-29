Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062B606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lpg6Kq1B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0653511248F;
	Thu, 29 Oct 2026 17:24:54 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8A611248C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 17:24:47 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2d01548ac96so5332315ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793294686; cv=none;
 d=google.com; s=arc-20260327;
 b=OojVkGOL1JthsLy6FCTgaaDpg5A/oZatfOursv6PEwc3MUSCwkOcLTBmvoNEi9frwR
 vRRWsefuAHEnI15T69x8SZ5BY+LYDkMHxUGmZ36wUWzu7wYKYCkL6TfudDVEcfc6xIk2
 pkZOxSQBKqQ2FFiI6CBx5Lk62FMzVsbvChiRuh3Vs6V5u1TESx2BaJlSWit2ZQnTx04n
 RS1ruDNbB5cX1uvPUYWYU4squdk4wr/HGi3BaXp0VnP/WgUguaaIqUZ3czSYhuCs5xov
 Be3u37KxfvUT5eKrOPoHqTEiMnRoVPh9WV4dhzE/pl3PjB+dBtJfMivz3BKH/etBT/tH
 Bw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4A4AcHiztzOnu/TxoJMI7gFBVfETl6VApiXh5L1B9JQ=;
 fh=PLfUOu3zTeqG0FO+oiyKqzvOCK9wfWrrnRxBtnx356M=;
 b=cRTJWupf+i5K8rkTW2DSL5XgI0mIV2+tb2o6+x3Kzir6TgSYv7WB3/mUFB7IrAv1Ks
 sKFGh8kf56+YeWPh+MvQ4LejmF5btthTkLY3KjKf96kApvNS8yRPQr1aEZ7eQqzudJHz
 mpDS2kSz925VlWk0Z3gpWFLBwMwHvoQJg2HoCrnokP05AJ4vnkNVGtcuGaVhRaGXKO+7
 fxo8egOKTJCfhxJPqK9gdaJz3MRQx7YfxRPNlfD4kZHMMD/RhWfZfWD4ZLrp8CduU380
 mMaWEWqpWatUBXa6c3TKewkcnjXtHnGld5QPG7zG+1md42ltIwNhXINZgM4ngIP+Y8iG
 jfew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793294686; x=1793899486; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4A4AcHiztzOnu/TxoJMI7gFBVfETl6VApiXh5L1B9JQ=;
 b=Lpg6Kq1B554kLP8cfEOVht5q/Ha/at/nPm9gs9bmSKz+3BvEMJ8/oeoDM/OCRGK9Rk
 m3bwgNfEbJrZSwTxiDrVytTMJrSNfcz6BJM9LDlhCuJXIomuI+gyxBzqizCQ74YjPfaW
 VZDCtQs0XT7Ha0J7mPblZ2lZZNuICSiz7QQYHitVSiqUPuX0rFZ/wJP6/peJGLHmHAek
 o0tRI+aHmVR5jI7wC5kTE7csl7LCpL3UmuBT0Qmc4gS76YYHIpViaW8oQXqE+Ou6LdaL
 Rle5Npg7O3o9sgv0QOH9k/uSYSP09vk/RC4e+ENuJe2LTWesX+nwdzTpp3mK1I5mP/N8
 Fzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294686; x=1793899486;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4A4AcHiztzOnu/TxoJMI7gFBVfETl6VApiXh5L1B9JQ=;
 b=F5QW9JJPzWlex1iwhqa3hVk2nITaV1beaonkW+XqQN1HTF0q8AfmzR6wmtVAl3+LMj
 x9qaWT/sjIc1paZ6q484DW7E7LSx7FvxBNjNMa9PzKWnklqdhr1kT0yB4poxwI/l+VmW
 PamQjgbRNhjdNVAHeORKnAaAcZusJYNjNtKr7DgVGSxepanF2QixH+jjCodGfEFiDYtk
 bimkGwg6TKx3iwjrFKA15HBq93O0XIaFhhPTZJmzhw9Uvne32irSwzF7LpRp9pIYIrny
 jbv1TyY8sHWARCR3Zt9NitWepE+l3DcQgASkz51k3F4ODNep3g6EEp9mlfrbQd5koory
 RO0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+Pf7I1KJWD9PEMUkgNIux7QXmP1A+/piQTB5hyHxbWo7lFzycNp50TCsk43rtyJSBpw+Iwc+fzOA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkqWP5yd871VfHp8ydnJo5kqGYHDUI5e5K3Mo+dhjn6eZYs/FP
 EBtcCxJ3OonSEiPjKepylknbHlbW+6B5ZisIB4b4jPnJiWVAX7UdbpzW4jl5cd6QprQOmAksPlD
 OoqQXygqlmiHfsAF3MsbNp/waafYii7E=
X-Gm-Gg: AYBFou26GnWgSKYacW0EV2DFHSx+LBC5cv7TcCv+mif3nvpU43WwYLjBek9aXwU33Kp
 1hNSyEDNlyWTiPOBd/oDuDGZKplYfGYktNIMomj6Qj4zkxELykNC6jiT6VsMfLJ+K4WlpMXHEP3
 6uhDzRGX/1jbJsvo4F1Rmg/NBeqwtqchGnjz++qK/2xwmAknT16QIe6BrU95CC/+jVMil52f866
 cdWANXYovaslaANIHUlV9SFcraKLBJePu7HJ8ofm9BZWCX8XKNe1A3b1fdxMWXJ7eb7PC+fuSIw
 MJY51ulbVlPjTkFhuGKdWyFA7aATGjqHFkr9MyLMdwPpjdIV8CnNViO8CVZ84X/zP5ftDESq3zr
 Hf9FBQ2m4VVAefQLkWxTe1Y1NR8vpv9adh/qxwJlJM6DrFhDM8gEmJXVSq0vPJovpO+yzovNV3L
 VnHrHWuRiO3d62UZ7U+dx3Pbg=
X-Received: by 2002:a17:903:2341:b0:2e9:53b1:a3c8 with SMTP id
 d9443c01a7336-2eb36335149mr1770895ad.0.1793294686611; Thu, 29 Oct 2026
 10:24:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <3ff4ef96-9c59-4e8d-a0da-92a1ac6f5ba1@gmail.com>
 <CADnq5_Nn7+baU=Rdaa8QzOCo64H=ch9HeDaEwtmbQwW0kP00nQ@mail.gmail.com>
 <86cccaa4-62ac-4834-bc74-1755436b5be2@gmail.com>
In-Reply-To: <86cccaa4-62ac-4834-bc74-1755436b5be2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 13:24:34 -0400
X-Gm-Features: AclHuK-h1jtYia2NalGK12IWVn5sZl6dkp3ZXAqLy9ybsB7-D4ACQecyB4R4q90
Message-ID: <CADnq5_PxC-a3+SWmvnRTDmJ8_-=ayCr-G6Yhi7ryKhV1TEKUxg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: report synced Apple 5K tiles to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

On Wed, Oct 28, 2026 at 7:38=E2=80=AFPM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> On 27/10/2026 18:26, Alex Deucher wrote:
> > On Tue, Oct 27, 2026 at 5:41=E2=80=AFAM Richard Lane <richardlanedev@gm=
ail.com> wrote:
> >>
> >> When driving both 2560x2880 tiles of an Apple 5K iMac panel, Display
> >> Core's program_timing_sync() already aligns both CRTCs in hardware
> >> during dc_commit_streams() because the two streams share identical
> >> timings.
> >>
> >> However, on DCE < 12 (iMac15,1 through Polaris-based iMac19,1), Displa=
y
> >> Core leaves pp_display_cfg.all_displays_in_sync unset. Because PowerPl=
ay
> >> is not informed that the two streams have synchronized vertical blanki=
ng
> >> intervals, SMU7 prevents MCLK switching at idle or causes modeset
> >> underflows.
> >>
> >> Report all_displays_in_sync =3D true to PowerPlay after committing bot=
h
> >> tiled streams so SMU7 knows the tiles blank simultaneously and can
> >> safely downclock MCLK at idle.
> >>
> >> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >> ---
> >>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> index 548f975c7324..384a81371f80 100644
> >> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >> @@ -4788,6 +4788,19 @@ static void amdgpu_dm_commit_streams(struct drm=
_atomic_commit *state,
> >>         mutex_lock(&dm->dc_lock);
> >>         dc_exit_ips_for_hw_access(dm->dc);
> >>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> >> +       /*
> >> +        * DCE < 12 leaves all_displays_in_sync unset; report synchron=
ized
> >> +        * Apple 5K tiles to PowerPlay after commit so SMU7 can downcl=
ock MCLK
> >> +        * at idle without modeset underflows.
> >> +        */
> >> +       if (params.stream_count =3D=3D 2 &&
> >> +           params.streams[0]->link->tiled_peer =3D=3D params.streams[=
1]->link) {
> >
> > This should be made generic for any combination of displays with
> > identical timings.
> >
> > Alex
> >
>
> I have changed it to the following to make it generic:
>
>         if (params.stream_count > 1 &&
>             dm->dc->current_state->stream_status[0].timing_sync_info.grou=
p_size =3D=3D
>             params.stream_count) {

Looks reasonable.  Thanks!

Alex

>
> Richard
>
> >> +               struct dm_pp_display_configuration *pp_cfg =3D
> >> +                       &dm->dc->current_state->pp_display_cfg;
> >> +
> >> +               pp_cfg->all_displays_in_sync =3D true;
> >> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
> >> +       }
> >>
> >>         bool frl_stream_found =3D false;
> >>
> >> --
> >> 2.55.0
>
