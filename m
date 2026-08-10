Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14475C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 18:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7956089207;
	Mon, 10 Aug 2026 18:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NBIVkl1c";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1292E89207
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 18:40:58 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-384c94c9423so304540a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786387257; cv=none;
 d=google.com; s=arc-20260327;
 b=HylkTI/AhHa0gRzylYXMRC5UfajXm//HHJD4kcCum2d4IIeuFwsiga6ChF/2lbEV7c
 ka2wz+c4XvERPNXCSq6PKp0z/gjDTjRRT+l6VAOZgXeBfcj1lrMoyn7NMjZ7GoqhM6A9
 H6Knv43gtBTA3+MXNgqX0NGajPkd97HZRP7u3dfEqs2rOscQTwNDLaPsjSRyt+TYW9OS
 /0Vh5uVnIqB1B1nbAHlAvLbD4mM8fHxiuzt80sK6L24POJBbDPj8uhjVQOcygGOtfgan
 Wx7kFh5etoHejyqvZHh1/BQ6dEf8peK2uwvute9fRECmzvihJlTgG1bijl7gEyk5vimm
 5V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 fh=0ri00FQd2AxvxJgvXq3fmevvczWeuFirFP6L3q8wTi8=;
 b=Xm0BZ+wixtOWJ7EFtAe6dUyCf+1uxG5iuPD9Qqe+hq4Z+/yeYaeT9Emg/XTStNqB4v
 ua6uc4MTUmws5SF8TXXcbHrUIPB5HJBOSp3qjTFWYnMSP2tPZjjioJw4C7OFp3brcAxL
 av5MGkRWlEPetodNbFDQq51RrJ1jATGylSO8BXNB/sPSieNuzKwaCOGogj1SLl3H7uLd
 mFqzKk6GbhJlhGyL5xD5Wu57tup0EpmizTGDKiJUCncVg+i1QKOxwBi6KCli8O23CcAU
 DFYAQuZnL45E81R4jr0icT9hjsNy+YoA73GBWIXQwT7AX9QGxvLwZBENDscSXy7A1BmH
 Tnvg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786387257; x=1786992057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 b=NBIVkl1c/QBHnIZEU8itbiFhMz9VFLtBTf0FknW6CGg5UeA5YXPaiHiuJ65nnStdu9
 dAKj8GPv9zzPNTcHoIMI4G7Yy+juIvhlIKLiv2Yft01llMyScFru76e38AcqlmEroVUG
 cYyT94zbKn+LUciX7KJf1KpxmtKiRpXKkJoTnFd9Wwo5zGG9iA69D1zoXaag39ATvu0q
 3cMg2zWkjbnnWCri7Dm61AuucLgG0nllcXjJszKKo3ytUnGNw4R0DapoWZ7ijHKov49n
 nVKRQbQPt4DnsGohL1t+T8e0soeu5QxnkE08WB8JxZKpUnVV0fVAJuJ0/TBCeazcwP59
 ygsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786387257; x=1786992057;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IDnbD2UO3WyOuDehW2mkqgikhPKgQCT+Ce5Oy6rQhqo=;
 b=M68lvzolvAMOv3OQXnN9nPgdvK9FOX7frrZItWjCsvM+8tii0IdCu5QBkDrBaV757z
 XFigAcO62BFYYiDX9rApwlQbV3kmOTXDD/IyarIv22g6w8lMD4jP1UU+1+1tBic3uk2K
 oolS17xlmPJpZXJ/WEmC3WfVqkIJTvHPBMiJoElQwjjOzPH5tsazRyRn8gqe9wRhjacG
 FuN20yhG2Ja9Mfb6oM91aUFiiJ9FeEdXxOACajXwFYvNjLM77HSRXw3cySHuyX5qbOkl
 VjX4a0Rc0ld5+w7JHu0PoH658/nLHQND/HX162CtVNTNCClognV/l0dRme1gXwXvsbuy
 NBXQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpnmtNdpMzXV2+5N6w/suPDZjgASbWeXuYM+aI080nqmHZT9am5VI8ViVqnDvlOtPREWUIg3V+urss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXOeRZvqOMjq9V+YF3BpoFibHPdyYwFZ9quHgvB71twmjeh8uo
 MoXhRAJaJL/+IFgPr4LlnnZ+NFk2eGOFW1dlDwc0uEK7gNmBybZwskH9OrR7oZE5K0vBwbjwN7s
 SwpsJvu1a6DGBQF96HqxdvCR/JJSD9xY=
X-Gm-Gg: AR+sD130Ep76H3YIGZo1y3qbRq3ukuIl+Of94GBPynaioJwsWEvDpXLkJIZIKJd7s4y
 oRKhO6s4vAxWMPC5WzuJvXj9IQQV/KWPd+f7Vz1bZaz6NAJYvgcKmkpiJoQ1gHcyVc5s33/mCfi
 IxJkb3h8LGNZ3UsvltNsajz8GHfy6lCbqu5Uh3nx48Q59l4C2JF6GAWu8G6DCse/G+SND7g7Wgj
 51hLE/R6RSNJUDCH4AqD8okw4mfl90GO9NUMbCweIiuRJhztxTLKkBE7T8W7avJwmaBHlfM/k4h
 aMSKzHEQGEdKEe1BByHAJlul/sF+vzkbZvQnFV+IUehCiZEOCJ247pTsdKoa+qr60wm/nsSpovp
 KuK7HhtynG4791XPqcyN9bR3gyzQO+wQ=
X-Received: by 2002:a17:90b:5807:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-3903c5fa99emr31653029a91.2.1786387257375; Mon, 10 Aug 2026
 11:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260807115712.22423-1-mwen@igalia.com>
In-Reply-To: <20260807115712.22423-1-mwen@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 14:40:46 -0400
X-Gm-Features: AUfX_mxudn7S1bY6Go3YBiGO4RqcIMi4pOzDB7fnjayynPlWt6hEpFSuLHctVIU
Message-ID: <CADnq5_OxnaEdNUpC1VQsCgensRYAgFCMeGy3uL5n6mYXqOHV-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use plane color_mgmt_changed to track
 colorop changes
To: Melissa Wen <mwen@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com,
 siqueira@igalia.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org, 
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

On Fri, Aug 7, 2026 at 8:08=E2=80=AFAM Melissa Wen <mwen@igalia.com> wrote:
>
> This is a resubmission of d79716401a95 ("drm/amd/display: use plane
> color_mgmt_changed to track colorop changes") whose change was reverted
> by 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of
> https://gitlab.freedesktop.org/agd5f/linux into drm-next") during a
> merge conflict resolution.
>
> Original commit message:
>
> ```
> Ensure the driver tracks changes in any colorop property of a plane
> color pipeline by using the same mechanism of CRTC color management and
> update plane color blocks when any colorop property changes. It fixes an
> issue observed on gamescope settings for night mode which is done via
> shaper/3D-LUT updates.
> ```
>
> Fixes: 0461ba9a7994 ("Merge tag 'amd-drm-next-7.3-2026-07-02' of https://=
gitlab.freedesktop.org/agd5f/linux into drm-next")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>
> Hey,
>
> I noticed this problem in the resolution of a merge conflict after
> testing drm-misc-next on SteamDeck with KMS colorop API support and
> verifying the issue of missing updates in nightlight-mode was back.
>
> Let me know what are the right steps to address it.
>
> Thanks,
>
> Melissa
>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 67b825cbb88f..d0e612371c8f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4202,7 +4202,7 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_commit *state,
>                         continue;
>
>                 bundle->surface_updates[planes_count].surface =3D dc_plan=
e;
> -               if (new_pcrtc_state->color_mgmt_changed) {
> +               if (new_pcrtc_state->color_mgmt_changed || new_plane_stat=
e->color_mgmt_changed) {
>                         bundle->surface_updates[planes_count].gamma =3D &=
dc_plane->gamma_correction;
>                         bundle->surface_updates[planes_count].in_transfer=
_func =3D &dc_plane->in_transfer_func;
>                         bundle->surface_updates[planes_count].gamut_remap=
_matrix =3D &dc_plane->gamut_remap_matrix;
> @@ -6012,6 +6012,10 @@ static bool should_reset_plane(struct drm_atomic_c=
ommit *state,
>         if (new_crtc_state->color_mgmt_changed)
>                 return true;
>
> +       /* Plane color pipeline or its colorop changes. */
> +       if (new_plane_state->color_mgmt_changed)
> +               return true;
> +
>         /*
>          * On zpos change, planes need to be reordered by removing and re=
-adding
>          * them one by one to the dc state, in order of descending zpos.
> --
> 2.53.0
>
