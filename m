Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B8606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XYH2gDkp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F1E11277C;
	Thu, 22 Oct 2026 15:44:52 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F08F112763
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:44:46 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-7cc0afff8d6so85590137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683885; cv=none;
 d=google.com; s=arc-20260327;
 b=LO/FxeFzEv2TyThTk/qbiFsOfHF8CvB5cFb+01mI5a9WbaYvQfkimA8nKaB7Ck0JHz
 rdrRCTc2UFvh7T2NZLYt/Mcbo1p903QJH4mpTMfKkuGV+nrbGgWkJa7AsCPpsSInFoc+
 qJpKvVk6+mYNF9t3P36iQtoqA4E15+rAFBsoyN+1lkszXVNHACOCVXpdNirKlWzNhFT4
 hR5x6Xb4AXkt+KXK3Cm3fL+9ezTfoQe3X6JLDEtFNfbN6LFsRu7Xhcm4kQq3F5kU0G+G
 ++ev3wFDLb1tdD0eWhBeX/vWU6/MuEe7hOnP3uWFU6ubN4AoAB9p3vFUsfmrXAYQRMc5
 k7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yUARhyZN7o4TDHOQIy+ltnwpZXOCsvCvJJ1qzYBwdfk=;
 fh=364li90SDhaCaTLShJ3wjT55IJzRm3YW1Ywc1Oe54vI=;
 b=fYG2eMu1kGAt8orlXt9tDpsFUOHfKKFM/B31ACVtsrYaQOujAwasNhz99i2moNI9I4
 VXJgNoP4TAZZGg6nDwGOB0OvK8FAAU/Kxk4hl1aCwH6tbffcReRXVqv4h4K9CQbqWiKz
 WWE2w93zo7SZ5veHUVFtG7Pvjm8mCfOEC8EmLtX2JL84ldL158FAe2uOsztBROFlKqJF
 CO+mxoCbrs3kemzYzcD7jMsAExeuBjKworRO2HShXoaprLZivPpoiq3oFKvN53TBL6b9
 ezgYdENpjKnckOX+4jV18NmQw9rVeGDU0rZXZXpt4zgkFhe/j2ENhUwncc0JdE+GjUgC
 a9WQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792683885; x=1793288685; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yUARhyZN7o4TDHOQIy+ltnwpZXOCsvCvJJ1qzYBwdfk=;
 b=XYH2gDkp4u0C0127cF+uEOYfqIW09CpMq/KQUCK4GuGd8JD09BArNvAIqOKt4StbNE
 wCIBA/nV81NbvOOfjb2wNZpmNrBTeONWSMjfEQKQbNoFeBRxfKSKmPPVhMfV8d+S0U1g
 IcFKxS/GXJ4QRxmRQ7h4fNIaW999jALqOggIzwToniTHPWblU82E7He60jfRAFhLLQS4
 ILOnGfIeddbxxQOU8BIXFOAMpfnoq475e16ZCztQkF65x+QpoUbufVstC8CUdE3uZJz9
 s6VvdnNIGboZezQ41v5sZQxAyTO5/UH7zW+ibbrVx6hx0271uUERMHvVaHFI3OMwxzAZ
 Ay2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683885; x=1793288685;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUARhyZN7o4TDHOQIy+ltnwpZXOCsvCvJJ1qzYBwdfk=;
 b=xV9T8QOfNZTPvJmK4LQd4LTTtFGZCgW6Dorvqj/x3812Yg8qbn5y84T8GUWXn7vZBe
 JPbsUxL3VKBYgbKDCbYWDDrRTpo76sPEJLwXDA7PPh2wrRndQUTh1IHyVA3jndURY8xk
 ow6wnMTilpVxmdrZ8QKOERjl+4GYPqHL4xNOzmKEpomptNDBYYcoqxaPFNVMXwhi0jIY
 Gtclbh//ts3IGNmhUtxnx5RdD3TZO+GHuievkMe45zbgYi4X/0cadQVp9I9uCuwz9Zt4
 mwZj34K0ixq6X/ATmm+OULbfQjIj3sRLM/3jFycGOmZAUcQ34k6P7xQPF2sVSE66hVgB
 uO0A==
X-Gm-Message-State: AFq9FYJAN3nCjj95sForGM5BCBcYpFuIJK5hE+7FikImZMm5qSoS19yW
 Rhxbu0GPHs30xqssWq57p12q5e7wctNf27jKGYmeV1PqWBfpeYqo79gNMzEjcy8Cxe+IRLoo5Yh
 mJDY+nH/Qbc8diLK6X3xOGXmrSpg2k5wQt7OK
X-Gm-Gg: AYBFou3qkmAkS7nbmcrdrwTF8jZyNT8eSCZVLZ4jx6wi6h7SygrEGynJFlT1mTByKzd
 xz1iLd9hI3fbTq9HD/reg7XIvJMlYYGMS0bSgSAilbeozS2oSjODfU2J8evCVMZwIc9Q8NlhdAu
 Jxn6iDGakhmGJimm+Oec5psbpLe4AGSvu/r4Asy/xEuGChpIzM6v1Lsv08J+7CxlyU5UMqSf7Rv
 +ybbQlWRu3Qcg3n8WxMcgoqzRm1OU6g1Tm66SHoAR5IXqQujZqFBkY6M/tNi2sP3aA6Xni86wXE
 8C1vVpzpuoiMgHllLxeU0cRBlqcYjl6LX0272SHvMo+aiaac+sj+QBhT+jMkthm1p5gvK8J5M2O
 yLv+EqWpqO9lRMtebzln/M8y6cC7zuCZzJTn5Zg28K0SzW15PXlls2zCaXqsFzsKZoxYIjCAm5q
 dXxnyYYbmIVsc/1K+j3t9fQsIs
X-Received: by 2002:a05:6102:148c:b0:7cc:1137:9d98 with SMTP id
 ada2fe7eead31-7cc9223d291mr2009161137.0.1792683884658; Thu, 22 Oct 2026
 08:44:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021213635.235393-1-kolomiiec@gmail.com>
In-Reply-To: <20261021213635.235393-1-kolomiiec@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:44:30 -0400
X-Gm-Features: AclHuK96NeYoBgBEEqGatLOwF-c1rXKq8UqKhwRn7Pd6TMbNtkm0C4wBFJc6riM
Message-ID: <CADnq5_OwwxyS8GCTVxg29ognO6gypW36pNwMXCMvk+33DAsR-w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: retry UVD v1 init on failure after resume
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

On Thu, Oct 22, 2026 at 6:06=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com> wro=
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
> Retry the init sequence instead of giving up: on failure of clock setup,
> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
> try again (up to 3 attempts). uvd_v1_0_stop() runs only when clock setup
> succeeded - MMIO writes to an unclocked UVD block can cause a PCI bus
> master abort and hard-hang the system. Each retry logs the failing step
> and the attempt number, which also makes future reports of this failure
> mode self-diagnosing.
>
> On the same machine the patched driver went 6/6 OK across repeated test
> runs, with the retry catching exactly the failures the stock driver used
> to declare fatal.
>
> v3: dropped the warm-up cycle and the widened poll window per Sashiko AI
> review and our own measurements (neither prevented first-attempt
> failures); kept the guarded retry loop.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> Link: https://bugs.launchpad.net/bugs/1865130
> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.=
0.0
> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>

Picked up this one in place of v2.  Thanks!

Alex

> ---
> v1 -> v2: guard uvd_v1_0_stop() behind successful clock setup (Sashiko AI
> review: MMIO on an unclocked block can hard-hang the system).
> v2 -> v3: dropped the silent warm-up cycle and the 2000 ms poll window.
> Our measurements agree with the review: the wider window changed nothing
> (first attempt fails fast, not by timeout) and the warm-up did not preven=
t
> first-attempt failures (5/6 cycles) - the retry loop already does
> stop+settle+retry. What remains is the minimal guarded retry.
>  drivers/gpu/drm/radeon/uvd_v1_0.c | 40 ++++++++++++++++++++++++++-------=
-------
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -158,24 +158,48 @@
>  {
>         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX=
];
>         uint32_t tmp;
> -       int r;
> +       int r, retry, clk_err;
>
> -       /* raise clocks while booting up the VCPU */
> -       if (rdev->family < CHIP_RV740)
> -               radeon_set_uvd_clocks(rdev, 10000, 10000);
> -       else
> -               radeon_set_uvd_clocks(rdev, 53300, 40000);
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
>
> -       r =3D uvd_v1_0_start(rdev);
> -       if (r)
> -               goto done;
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
