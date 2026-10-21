Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE47606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N/4cxgFM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ADF410E294;
	Wed, 21 Oct 2026 13:29:30 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A86D10E294
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:29:24 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-34c522572bfso82111eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792589364; cv=none;
 d=google.com; s=arc-20260327;
 b=KYeJJ/lxGBeKZIGkBY9tGbK4eBL6bL9RnJy0zDQpbe96s2gI1sS+bYJuxB0mhCrWoN
 O9aDkztcOPcDRVDNx1KmGgftXOeXMvCM27PWLqZGyick3cuhtsAwqR3XlSbQ1LmZzbgR
 Js0YUUIewWHgY3aKa45bUmnbjbXy7HwNhnBp4/JS46ukx1epWHPrdYuVj11kQdtPHskS
 hLxakXdi9DUDj3g8LUG7rC2w/VHcqYMNGK0C92d37xkagooSEcNWKQ2F3t/uFQ5v5Q1O
 e0K4kTGLGoYAMbS2mdO4Ncs+YFn+TrV2Z+ny4lwe5t73RXAf0wDSWHR4swnBE9jGSQdj
 Whqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ICV0izRDhDmyM6tuJD0GMf9ng2ou6ANXKZFOyI/J0M4=;
 fh=mkdcld4v75mDrOPai7+POG1MfhMIDBjTDWxEn5MYCnE=;
 b=Uvfdt3PV0Cq3v5+ggubQ2tVVMktv/VqStMQgdL+AHZZa7ORxpge0syg9JdvrXgdhuG
 cNq+ndaVj486fJsS8wCreoUvw2kV8ZXEJXOszwjytK4vnxTR8XO1ZGKwgzmo28GLnp5w
 rq9waGKed+bs89vWprg2xCfAk60v87B9m53s+ulkjz+8J4Zj8/G4ql+iWj/E8l7CaHpX
 P6Wo2bFGf2Nwy0+EileewDqJz/3Jiqi3Mq5Fhem0fh4vmbgsn4zRLM1vdHMV/mPTtl6O
 12QzRjaVLelQPgdHvaVMApAvLyC54RUr2VirZxuKjL6NbeAb//6ArS8rgrGFWt4IcYYU
 YSxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792589364; x=1793194164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ICV0izRDhDmyM6tuJD0GMf9ng2ou6ANXKZFOyI/J0M4=;
 b=N/4cxgFMZdQ4ziCZUZzV+j5xMsqjNugcWy0RMYNTlkuIkvJ4fwtK7FZyKFuWVyv/Uj
 PA7ynED92I7iJZ2uEGfMeuxkFJDjPto+6o+gMtJnS2D2ipOPKW/A6vo/lUY1x3gcMqkR
 Y9WNbT/Z8bXNhJcP3k2wg9es0P4zfXKtvBSVJ7SxilCDkPH81e9HZ4kN4ToJbNIQW3LJ
 VEi0PHl7ahNk5hxpu2IsR9dOKGI3AHMWelpfozatSdL9OmaRB3VUz/QBs7/aajjnc5vh
 I7yJ/CWpOCWmfwu+P756Dr7tuE1uIlHZ4b9q6aInVzXYGizqEhHLHUg/5jtzDTODeZKC
 +1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589364; x=1793194164;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICV0izRDhDmyM6tuJD0GMf9ng2ou6ANXKZFOyI/J0M4=;
 b=HyUow5/bdUOVseRnlXwiKf1nfFcs0dpFYLTXYMcTg9xPbNAIwaW9MilGkkL+rK3G+2
 GPv3ZnsBjeW2fBMixh2KA+7upnxVQZiYFdDVQs7hpsBmnBhZqxBQ/rpeMVrXRXlt0NQF
 gGjwn3h2Mj50ktd3aofSCBeYiY9L7tuhvmSWkhHBdcTSHbWY0NCRE+untWOd4mAyqPin
 e85SJENWtVR5lrxxXQzPD9swJ0bFcJhDQ2CXo4mjZYeKE4NQCnkwAzchrPlniPytHjeB
 JMP0+NUoCvUEkE5zFRAKKKQy/hPcd3SJtn7kC4CpY81YZ/hqjDxw9UsoVTO68KkTvVk7
 6zGA==
X-Gm-Message-State: AFq9FYItqu6TsiypbsU7iTRY3ccvIpHiIwNVi8JU3T7ISKjDKHGMx03x
 sZrgXN/2Lp4keaioeKLOkCcwm2JLBW6PPYPC0sKL6EcFgGL6ll647nXkXW1nfGjidtJ+HHxVlId
 HznnqQsXbTK0m80xuDRaaqcRnbhnsfO8=
X-Gm-Gg: AYBFou02i3KOVHPOUjTfQdLsKoJoltpOFTM/LLnfdEjKcLwagCbewdgwKWoVUix5WO6
 U5tB6F/xepqWhpblzOMG+faLs4TZYpPTjjbnoRRtvXBG2gygi/BrxAkPBJ79f3SGvCub8ROWqMv
 3BhLZHq8VSw4dOsepjfaiEiIxWe4gLsONaFDHZRMDtn5QPYBS/1MFOmJGBNYvBPHQWrguPb95iv
 LLvaNoomNtj4xOMQYpSk3KN7KeHBpVbjAqR1widpUzH3nEsUbgXXosohsHOCixRa0toSM2CnwBN
 Yh8bXUhUR9jqsWjnU9GhkxS3DSdo1vcG9sDNJtb7pmISdFcvezvkt+eDwKSX8diN5te6WP2bgRQ
 +OoeF17unpe99GWstF0aTKW17QrJRjNrvIrbIQWV+4U8yBA84zxaT4VKrmQqN/ZoIPqG3aJU6w1
 necJAoITDaBR1zyqPt5Y8rRRY=
X-Received: by 2002:a05:7022:407:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-190a418f034mr5158436c88.1.1792589363414; Wed, 21 Oct 2026
 06:29:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019144916.108589-1-kolomiiec@gmail.com>
In-Reply-To: <20261019144916.108589-1-kolomiiec@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 09:29:11 -0400
X-Gm-Features: AclHuK_NZzUuPhZX9BqRhfNDmU8_Z9WYBeImi8vjgzfu20QpQNQjV1PLt7Igm3k
Message-ID: <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: ukrainer8 <kolomiiec@gmail.com>, Leo Liu <leo.liu@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ Leo, Christian

On Tue, Oct 20, 2026 at 3:46=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com> wro=
te:
>
> On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
> suspend intermittently fails the UVD ring test:
>
>     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCAFE=
DEAD)
>     radeon 0000:01:00.0: failed initializing UVD (-22).
>
> Cold boot always succeeds; resume succeeds only in about half of the cycl=
es
> (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
> 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD stay=
s
> dead for the rest of the session and hardware video decode silently falls
> back to CPU.
>
> The resume path runs the same full asic startup as cold boot
> (evergreen_resume() -> evergreen_startup()), so the difference is the
> hardware state at entry, not a skipped call. Field data shows the first
> ring instance after resume is dead functionally, not by timeout: the ring
> test fails fast and deterministically, and only a full stop+init cycle
> revives the engine.
>
> Fix this the way the Windows driver effectively does it: silently cycle
> the engine once (clocks up, start, stop, 20 ms settle) before testing,
> then run the init sequence in a retry loop - on failure of clock setup,
> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
> try again (up to 3 attempts). Each retry logs the failing step and the
> attempt number, which also makes future reports of this failure mode
> self-diagnosing. The ring-test polling window is widened from 100 ms to
> 2000 ms as spare capacity; the early-exit poll keeps healthy hardware on
> the fast path.
>
> On the same machine the patched driver went 6/6 OK across repeated test
> runs, with the warm-up absorbing the dead first instance and zero error
> lines in dmesg.
>
> v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko AI
> review - MMIO writes to an unclocked UVD block can cause a PCI bus master
> abort and hard-hang the system.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> Link: https://bugs.launchpad.net/bugs/1865130
> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.=
0.0
> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
> ---
> v1 -> v2: keep the clock-setup result in a separate variable and only
> call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI review)=
.
> Also folded in the silent warm-up cycle and the wider ring-test window
> validated in field testing since v1.
>  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++-------=
------
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -158,24 +158,58 @@
>  {
>         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX=
];
>         uint32_t tmp;
> -       int r;
> +       int r, retry, clk_err;
>
> -       /* raise clocks while booting up the VCPU */
> +       /* warm-up: silently cycle the engine once (like the Windows driv=
er),
> +        * the first ring instance after resume is dead functionally */
>         if (rdev->family < CHIP_RV740)
>                 radeon_set_uvd_clocks(rdev, 10000, 10000);
>         else
>                 radeon_set_uvd_clocks(rdev, 53300, 40000);
> +       uvd_v1_0_start(rdev);
> +       uvd_v1_0_stop(rdev);
> +       mdelay(20);
>
> -       r =3D uvd_v1_0_start(rdev);
> -       if (r)
> -               goto done;
> +       /* after resume the first ring test can race with the hardware; r=
etry */
> +       for (retry =3D 0; retry < 3; retry++) {
> +               /* raise clocks while booting up the VCPU */
> +               if (rdev->family < CHIP_RV740)
> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 10000, 10=
000);
> +               else
> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 53300, 40=
000);
> +               r =3D clk_err;
> +               if (r)
> +                       drm_warn(&rdev->ddev, "radeon: raising UVD clocks=
 failed (%d), attempt %d\n",
> +                                r, retry + 1);
> +
> +               if (!r) {
> +                       r =3D uvd_v1_0_start(rdev);
> +                       if (r)
> +                               drm_warn(&rdev->ddev, "radeon: starting U=
VD failed (%d), attempt %d\n",
> +                                        r, retry + 1);
> +               }
>
> -       ring->ready =3D true;
> -       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> -       if (r) {
> -               ring->ready =3D false;
> -               goto done;
> +               if (!r) {
> +                       ring->ready =3D true;
> +                       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_I=
NDEX, ring);
> +                       if (r) {
> +                               ring->ready =3D false;
> +                               drm_warn(&rdev->ddev, "radeon: UVD ring t=
est failed (%d), attempt %d\n",
> +                                        r, retry + 1);
> +                       }
> +               }
> +
> +               if (!r)
> +                       break;
> +
> +               /* MMIO is only safe when the block is actually clocked *=
/
> +               if (!clk_err)
> +                       uvd_v1_0_stop(rdev);
> +               if (retry < 2)
> +                       mdelay(20);
>         }
> +       if (r)
> +               goto done;
>
>         r =3D radeon_ring_lock(rdev, ring, 10);
>         if (r) {
> @@ -421,7 +455,8 @@
>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *r=
ing)
>  {
>         uint32_t tmp =3D 0;
> -       unsigned i;
> +       /* after resume the ring buffer controller needs ~1.5-2s to settl=
e */
> +       unsigned i, timeout =3D 2000000;
>         int r;
>
>         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
> @@ -434,14 +469,14 @@
>         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
>         radeon_ring_write(ring, 0xDEADBEEF);
>         radeon_ring_unlock_commit(rdev, ring, false);
> -       for (i =3D 0; i < rdev->usec_timeout; i++) {
> +       for (i =3D 0; i < timeout; i++) {
>                 tmp =3D RREG32(UVD_CONTEXT_ID);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 udelay(1);
>         }
>
> -       if (i < rdev->usec_timeout) {
> +       if (i < timeout) {
>                 drm_info(&rdev->ddev, "ring test on %d succeeded in %d us=
ecs\n",
>                          ring->idx, i);
>         } else {
