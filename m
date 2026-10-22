Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141360A6F66
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nl678f8l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9DE110E436;
	Thu, 22 Oct 2026 15:11:54 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A4CD10E436
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:11:49 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-7ba2ee12f65so48892137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792681907; cv=none;
 d=google.com; s=arc-20260327;
 b=K5PXrotnloFHFqG/9nDB6j3k44wzcZwjSL3sIVkFkYzcRUBQ+OYuONb3JU62JXY0mK
 crNmBBR64noFH96z1w9ZDy85cb92x97aaBTafnD34luy2nYYbWjYnbYLKhP/CHk/s+mi
 YvOdn7jcrb2nWYtYa5abDFcjTJIRubcsBK2r0W/u6YCBeN7HUlme/3BJJ8JYf9mfP7bH
 ObsXgbU8XrmNKwryGxKIoFAhJOhn0zMbR0Q0w+IUimrCUQ7nu9r2L+k7tAQByylcK5Fj
 1SXuMBv05eHnKryYBgQwcsPDwMhvDldqE/P8obE6c4do9iFD245xKpHZkS6okyyCBrXa
 vgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SK3wcTo8ANbAcMYXsYRl6Bwim5w4FiPpz6gTn24jMqY=;
 fh=364li90SDhaCaTLShJ3wjT55IJzRm3YW1Ywc1Oe54vI=;
 b=K4tF+rhdMDUcpnCcJ6qGHQ1uOoxxKfB5cwaeMcr3qEx8/VWeeui8ZElCfWq3cY4SZ1
 TD97s031bpcmDfBq/N0nrBAYc6GFfUi7D/yKaTjQsUB0pG+1gajfgwn5Trt5/sxoOdJH
 /vuFSIxNXXkCwTj9UVeFu679dWmANx4abnL9hqwU7iEI2e2kfHO95JIQsRmoye8rs/v3
 q/O2E5G/grpB1SSMhIXFTd6jw+CqU8LJlOTNrhk1x79RK7wDsA0I7llnMtaIoSVM8CW3
 U+V3h68cs1wfB3m7LLLw5shOx58tNfSoyYIPfgjg0dnhqRhU8oCBABjNu8VlWJ/DpTui
 6eYg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792681907; x=1793286707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SK3wcTo8ANbAcMYXsYRl6Bwim5w4FiPpz6gTn24jMqY=;
 b=nl678f8lAmSeXeAJzsrjadBLBu0yflAENqVNZ3Tf16EinC8Fez9hivcTjc98c8TONB
 1YYrq6C+mXcQUSILABnfMy9CRErEOAmlAu0AlELMJTqJ6y35b19WvivTRojuEwuhR6dl
 xskkIOQybh3oZtzRhdByoh7sQ2JjSFzAyvqyCA35cHFUH5KdSDNoASg5cHC2YU6jYGt4
 KXT7rudfEPHhRQNH7WdR+GTYRjcjpKt+Je8cTeHaF21gAGTXr1sqcZLcQ0VPZiu2WXVk
 /YxXRkMN/SNX+yAqafJEIqa6T/Lmh4kAC1Vf8cJdGlxKO/5+RBDg4nOfXzOrr8d0ecxs
 QvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792681907; x=1793286707;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SK3wcTo8ANbAcMYXsYRl6Bwim5w4FiPpz6gTn24jMqY=;
 b=CLUJRD7N6yL0LXs2QIKuKrbppKHZsdcl+G/uUwxssBxsvDxoKovshg4rbiahtVMQl9
 eIKLCTHf1k4PQHcSpKVcZNRyvRdDHakAu8c5Y3FOenTk8dGEIYMk1bYS9ILp5GihvHhn
 TqaVO9s35NV4QEtLdsI+Bzviql/9qJhwhPznuq2x+aYweyAkHh/GfaIk5VGeqLE+KFnI
 QKIO4+GW4Lidg/1fwC5XC6P/sYEjq2Z5/5HG5VkKxSF/TPDzQ7Pk7czcoZEY9liZ36kv
 3LaI62h+wb34JjeEaPxuMjny1ipl05F47Ti+RMgOMs64N++tjFJhSINBT25REFQ0fwyP
 zH5Q==
X-Gm-Message-State: AFq9FYIpVtxns4b9SXqL1omykW3vb7ncdB+DIeuSy549/9dXDZRfCUBz
 zm+iw7gUZp3Ea/+J24JyG4OZPHV3f+MxlgP/tQXOpiYBhnyKT1zCDZY7u4kxYrYOcccjqhlHOAi
 8xyblHQkosYxUfUs5kw11CxSj8w3SIsw=
X-Gm-Gg: AYBFou0nt3h7qoxeHw7KZlePh8KA8a5K9WEJyzLtcB7SpnBcZVNMfIKBLQL+IHLMDvT
 1r98Fib1wfNm7aJBmdMKC/amcOCxsJKhtQvzgbvGOB7b2jbhFGv9PATH/Pbd9aBtRUf/iY07H/r
 J9UFi35+f12JXTnKF2cbE1AkFrKe3Oz95PQ/dwXd20g72VRlg4HXJpAoTFgjRF1ok3qusCSpVB4
 L2G1i+N1IWMnBE+vz80sSWQx0jy+PdA8WkYQYIB8dxGKzEk6Zl3LO/eWmrcxLaDVsRdGtVNYARB
 ihMRukVLGizznmS1qXUb2AzfSk8udxipISo4ZMYrGGhLVuRT31bZQ3wQ9JIXIQuhjfg1r80uoai
 x79bJk8FXozI5Dk2AxchIlPqfQagU67lGBR0oWDSswq753+6vx+4xXok4hOmhfNeZNBKMsdiPul
 y6Zkq6Csv4jZYaKvvELiy3DiM=
X-Received: by 2002:a05:6102:5489:b0:7c3:91f5:26d4 with SMTP id
 ada2fe7eead31-7cc9265d495mr1850321137.3.1792681906703; Thu, 22 Oct 2026
 08:11:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019144916.108589-1-kolomiiec@gmail.com>
In-Reply-To: <20261019144916.108589-1-kolomiiec@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:11:34 -0400
X-Gm-Features: AclHuK-zvBTm7jsDu3nnmVOqA5wHXWSKBKs1SJReTwkCyAa-onvyKZKFT90oyjs
Message-ID: <CADnq5_N3bnL6oMbikTRVtDzZAPGwd-ptZ5ph2Sr6wPykShwm4A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: ukrainer8 <kolomiiec@gmail.com>
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

We'll see how this goes.  If anyone reports any issues, we can revert it.
Acked-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

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
