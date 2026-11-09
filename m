Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfwalAi8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3601410E278;
	Mon,  9 Nov 2026 20:35:11 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A3310E278
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 20:35:05 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7d2da36b729so49981137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 12:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256504; cv=none;
 d=google.com; s=arc-20260327;
 b=KshKWW/U9bZyRXQbF9PcJqm0S/SLpGVModAHq10zP4Ioy8MdSx8wBqP5/+2MEejg9a
 FW0GlahCtxNxzvoTKRMTksLh734uthXF/NZ0PMK0oEvtDiUOxrbuy4OApD2sjNcIwqNf
 s3E/mu4vpi4eFfKVrN6zHzh90CcUYgAYpEqehA3kx3xIaYUxmsj+lwYX1E1i2GxSbUDE
 r52Tp2ce6EgUz/cctPQsw0Wytwkx+1BelgOT9ohvWScHI0M+PX2l5jE1PB494GMb8wry
 Fdmg2gnZrEtiXaACUVzD4jNktyPq2FEreeqescIRMvFWxOje3qrnLDcN5Oyo3OjEnsDP
 Disw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 fh=l0QAUaBclxgaAskjpWs93ZaCPg825DkGYCE1UM/kO4k=;
 b=V3WMC9AgJucStE6ee46ftJU8JGiqM7UKK5HMcP0y2bc32Ij64PEx09o4GetAHxtaKk
 OdR6mN5b+7hW9FOxpYAClzpFL+FljY79am5Z9WUPVTbqA2noojQL87zGusNx24h+RH5T
 ysUuf9KJ68mA6a68o8bf1jCWnNO+vjFQyj6O1rnpkYf+UDAx8anFD3jUu3SlSLRbST9q
 xYnhdW7l4pYM92T0Poni2oxY9aCf+0sf8c6ylajy2trpcnXOmWG1KOHuJr5IxsIMlflm
 2fBb/6AW9v/4x6ukAd2ZsJ/e2KZxznaOZbS+nhGbhymus/rPlVz5a/6tzrOGxY/XHoOr
 Y6TQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794256504; x=1794861304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 b=TfwalAi8eOaZkw2viUx7KgwcJWro8EoXbSTaW4k2A98bFavlo6uxehomr7yRZI5V6T
 KuClJvEfmrrdw4x4q13Fjn31SUIypoc6jSwg+GtyaGCUUFRwQjg1RUeOA/dbGrjSORbV
 x6lcsYGe3k2oAkSw5PAJpYAfnF29xaPqOHjSw12P0urnKyhMEAsDwhScMxnTOVLhPY2m
 WupEMoCJcsuDZwc4ylvUDHU0Xnv8JJVWMZFozb6zhzRiiz/SsKVtHv7rd+bpGoZ9xej0
 X7bY1WYu/PzGK9Cg1P2sUA40qrzmXUz29BXEseH8D0U52dHsvVqevaPzR6BxRnUtE8fu
 Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256504; x=1794861304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 b=JNidytQMUJ2/yw+HBGsKI/CC/zrWzbC+8zBKyLHjp+o2mTif6TrtjhX+P3qC0b1kMA
 s8fzx2T/zEZ7MG1RbtLtu4+6u76a7djfHyX7+L2/yop7ae8S2UYahABZYCN5JFuPiEon
 eVzLGallK/Oj3cO0joV5S/nvI1+u8NkEE3HiLCeRZb/qIFHeqciSdmetwACkUIVxV1+O
 f8OiMSuSGupALnJNrcSYYY+1X7jZ8tIkYr5pc4IcAE0KAugBfkW6oQMgAwNUt7B9/8jU
 m8WJVvEPEkpJVNI9TAau2/SGnxVUFufSBM+C1cDw2K1e5bzE0MAuq51Utfe5kB+uii5h
 Ol8A==
X-Forwarded-Encrypted: i=1;
 AL+hErG9oNBfzQ2bDmzUbxmKnOMK/bq3mLB9Lw29MLeabuLSv9kwEtI5p4m3zEs18ohz/QsF2Llld0LJnbU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+thDB7NN8Uk7Uo1BLD7Dh+45ghTLdNDEB19V0M2fVIT4uFEmyi
 bupCYEKwfoQKETpTVKzAM48FBWn3bMjXWocr+DhsbdD7byTiCqzTXxEIlHqbcYuSJqEGR6JjaOH
 RZ67oTnxhfIu/hSJndR/vEYKXCFAlmjs=
X-Gm-Gg: AYBFou2OGRBmdulmyyzM1wD5nh/BLdlnOSVYb+/rUgEuFgKdP4gZsljllZv6tUaiOOm
 JMCxwkY770Zn0crcQKgX8aaTJrKa1FT4WIUE3at1jD3tFl7EhfISuXJm/8oirDnGd/i4ZbXAlkM
 oWgZ/0SAL/yzaq1KXWVNryuE3+H3e4vHyYycRzNCp7Ei0jhzEvW1LgCI7Z6s0zfQ9kX+RE8ooN9
 TiCjQ5nDB16f7pK1Re1ckL88LFYHzZnAqKv/yA6mHrQ/fgK73DGN8hzZipB6N22XO73L57G0Htw
 O2vkhxm3XsDQLF/FjHetJcuMNptkk+DMVHUnMVs0SwB3IQj4T8NP2a50BSjEeHpmo6h87TOqNQp
 IA4j2Ol7NBIwa+4vcBXrpl9xOusKHMH9CsarqH1YD6K/AHx5LSwUgCK3Ib9PA8asOSW7Kfl9G8S
 Ja9mEdqrVd6iEeG16g1Oep4YufkcnqJRf9I5zaDgmsm4tJZPjErd788zEStQM=
X-Received: by 2002:a67:f80b:0:b0:7d2:a064:aeda with SMTP id
 ada2fe7eead31-7d301b8b63cmr193657137.3.1794256504228; Mon, 09 Nov 2026
 12:35:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
In-Reply-To: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2026 15:34:49 -0500
X-Gm-Features: AclHuK_TD2z4jCOaoy6VhUcvF5q3LaXcr9adQrWeNzozi9jR9qfmBoEWs4Stl4M
Message-ID: <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev@gmail.c=
om> wrote:
>
> When driving multiple displays or tiled panels with identical timings
> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
> Core's program_timing_sync() aligns the CRTCs into a timing sync group
> in hardware during dc_commit_streams().
>
> However, on DCE < 12, Display Core leaves
> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
> informed that the streams have synchronized vertical blanking intervals,
> SMU7 prevents MCLK switching at idle or causes modeset underflows.
>
> If all active streams belong to the same timing sync group
> (timing_sync_info.group_size =3D=3D params.stream_count), report
> all_displays_in_sync =3D true to PowerPlay after committing the streams s=
o
> SMU7 can safely downclock MCLK at idle.
>

Looking at this a little deeper, the function bw_calcs() in
dce_calcs.c already calculates all_displays_in_sync using the helper
all_displays_in_sync().  Can you look into this and figure out why
that is not working as expected?  My concern with this patch is that
DCE and DCN have different logic for handling mclk switching so I'm
not sure it's safe to call dm_pp_apply_display_requirements() directly
from common code.

Thanks,

Alex

> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 74cd88d8d580..b4531383437e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>         dc_exit_ips_for_hw_access(dm->dc);
>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>
> +       if (params.stream_count > 1 &&
> +           dm->dc->current_state->stream_status[0].timing_sync_info.grou=
p_size =3D=3D
> +           params.stream_count) {
> +               struct dm_pp_display_configuration *pp_cfg =3D
> +                       &dm->dc->current_state->pp_display_cfg;
> +
> +               pp_cfg->all_displays_in_sync =3D true;
> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
> +       }
> +
>         bool frl_stream_found =3D false;
>
>         for (i =3D 0; i < params.stream_count; i++) {
> --
> 2.55.0
