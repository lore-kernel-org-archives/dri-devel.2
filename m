Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E181606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VwVt2H95
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06769112452;
	Thu, 22 Oct 2026 09:41:45 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5554F10E1D9
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 21:47:46 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so1598107a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 14:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792619265; cv=none;
 d=google.com; s=arc-20260327;
 b=VXrbapYsGwjdWrIuapUiCgTrsMFiQwNXPr/OepOPkLpivJiMQWYa/4n0IB9A590b9V
 RMbegoYfGTAYEN/cQ+k1p0YsjhH9mWb/UQic/YcmvOLpm1ecVZ47hv8qPKW6NuWVe+Ql
 07dchRl1kD+8jW/DWFXT2QzA6sgof2fHDJ+H3tadp+yV0v277JxbX611PnwoKqZXUnVY
 pYfPkE2jwhy9YGU/y0C1qJ9GgME3URCRSPOy3gTvt8hhauaCxQkCQC7WnpdEbxRzdnP2
 8D7S4fV0wCoLwtf1SN2F+8F1VJhKKCcg9SL4luvvCVYYyGj5cJjGepi3q0EXdAMSvAjL
 lleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 fh=hr4UoM2xCf+SzgidXxcip/3O+JMHamcuTfWlFet3FKQ=;
 b=lPb8uBMg1wFxbm+r2+EAekdvu+2+N7IuffBuDS0oOBB/rYzTKz/9nPZqhdWuFDbyIM
 LiEa70wp3iTfVwb8xUq8e6tCvPgUMw4P5ijqFwvO8Sp+1SPjhLlM+0SRLLN9Sw0v2Vp8
 UsVR6OAhcyIoLyLZC4Ea9euIxKMWG5zT3YstaKxC8U8XbbObN5n0kH3TE5Vpyjg+nqf8
 xttJ3ob0fSqnWGY108dF7kRVk/nTOdX4yR3qNWFnGIJLyzg5WR/Ik3t+32I3OiJGa4ZO
 Pe3T6t4RU62nHofjN8sGs1J3728LgEXELtWf1Q2yIHU7pmlfomJSXmKWy0oVupmJ/omu
 ce2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792619265; x=1793224065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 b=VwVt2H95hJ8CQ57GOexous870mg9hQLyVJbDfWFaRtwUwwxTo9Kknhvyd7z+S03689
 8UKIZpJAES8MrTSvYCfn9M0ujHbm4h38gyjaoAG+U7QA5scZlVGqNaY0UXmdJ6mWZcGo
 LZV10jrk+Od2sgb5rLQyyx6/KGX8MqZRYFA48n/ahdWsJMxDxTGB5/uUxaAg4CmZXzQ0
 J9ad2aHAhv0bHKkVy8/q3tVyvax/LOULczlQEd+lnQFFW24TzI0NbOll/7JqbMqFKIay
 Gsd+j5fb0YBnefxcZMgD8W1+vGhlGl9r8A8a2t5JRGoJyxACBfaS8DjZdgaJdHcZUPJ1
 jfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792619265; x=1793224065;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nfuyv0XJXEbAmq50FWhFjJ94nQ4G+vWr3TYg/YVC61o=;
 b=2MCRCCwNKSJET1moXERSx5ZIFjP+ttA4XY5FvLjYG2u2XdLxCsekCpxau4CgnEts18
 mYDjbQyvGKzeDv1C2RBFv2RMrf5qe0/sBzoFBJd4gezjGLPORdQicHzkFnNXhAlLIU1O
 tnkIZs4Ppjd39BAjzsBH+o/lc0S70mqn0cYeTGghhCL9aLwWX40Oo+BCSzKkeQ1UAVL7
 m1qFozHDJSTRdfNSYUeGoAQURg+prQrjXze2ytkALrvO+DxWI/Da4HyIq/MLArgobSVS
 xJGWSLNsESQqaCC0Xon6BveQYSJWjPgd1no7aajwVVJ5kXbjl8p3W6qfR/rPOt/kNQo+
 4j5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTf7Azrc5EtaCYXI3gEY1Tc6VVK0JfZ2iw1cC4OY3x9xGVwwnVrDEzCW02RdR9dEtQw3qR2opQ0XU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKm9uRMlpM7kw2WawFNo3zZhuI4mrGgStVkpx+Cb5PaTaj5kXcx
 EVpo8ASIoDrqM+gQleKFWOBArMaSbScjz2oxKvhNRmu5IIufu3UE0Uv7337LWzWMihwKoxxPn7B
 /PAn/GlCEbD0SG8hM5FaVXxBcS3fn0LU=
X-Gm-Gg: AYBFou2crqOeQjv8ZPkElYn/uvP3XzChhOYncokaXqMTIUCORVbopARgeAFhQsCCBj8
 0REDp/XFQFT8Ekm3fHtVFosCp8RlRreLRLfdOAcdb3hioYNH2WY+uKbG5wUJWXIf6BxHH9FHkKO
 CKNa7coUdvUZId3pBUKRpfFjMd+MXhfJxrIvnyS2V0VUdziuR4LIlg0M94pbtirMh+kuB2RUnCD
 Rnd1hqX1+G/JvznITM3qny/n7R66xANH+aoLqB9g5DszUcwEy7uDWhiIZUj70qh1qAOYftUB2Nr
 UR5PU5nQeF8+3Hk07xipPI4R9dTzAu1G3I8ovVY/CMzTjwBv9h4CcH5sU8q6KvwhtnVmJuaYgof
 sCU1N2KI02Bey5GPk0KfFWB5rWnr8LRJmBg/adeUxzS/Rqqr4l3e4hF2IkVio5Cg1snE4CDpvRz
 efYgbnep2w0osUcEY1pHKxVdTi91p6K7CBPzmXOgnsuFM=
X-Received: by 2002:a17:907:96a1:b0:c42:5363:38dc with SMTP id
 a640c23a62f3a-c4679753a54mr300922666b.25.1792619264509; Wed, 21 Oct 2026
 14:47:44 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019144916.108589-1-kolomiiec@gmail.com>
 <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
 <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
In-Reply-To: <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Thu, 22 Oct 2026 00:47:07 +0300
X-Gm-Features: AclHuK_XnaUYo6AaPUrR3jIzbU1MZJglpcci8l8tDxVHI9qp8wpozrchlCEiY0c
Message-ID: <CA+e2gLu+tUWXgQ5F08W9L8FY3K12bMQKPAqaPdzb14NxKVdOFA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Leo Liu <leo.liu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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

Hello everybody,

> That HW is ancient!

It is =E2=80=94 and still in daily service here, which is exactly why I car=
e. :)

> The question is really if that works reliable or if that could break anyt=
hing?

Fair frame, so let me answer it directly.

1) The success path is bit-identical to stock. When the first attempt
works (cold boot, healthy resumes), the added code executes zero extra
instructions =E2=80=94 the loop breaks immediately.

2) The failure path cannot leave the system worse than stock. Today a
failed ring test already ends in -EINVAL with UVD dead for the session.
The patch only adds up to two more bounded attempts (~250 ms each:
start, ring test, stop, 20 ms settle) and then falls through to the
same failure state. The display rings (0/3) and the rest of the resume
path never touch this code =E2=80=94 and years of stock behavior prove the
machine resumes fine with UVD dead.

3) The one real hazard =E2=80=94 MMIO to an unclocked UVD block in the retr=
y's
stop path =E2=80=94 was caught by the Sashiko review and is fixed in the
[PATCH v3] already on the list: stop is now called only when clock
setup succeeded. v3 also drops the warm-up cycle and the widened poll
window I had in v2 =E2=80=94 both reviews were right that they didn't belon=
g;
our measurements agree (neither prevented first-attempt failures).

Measured on the target machine (HD 5650M, kernel 7.0.0): stock survives
resume with working UVD in ~50% of 42 measured cycles; patched has been
12/12 on the test stand plus every daily resume since.

If you prefer a tighter bound, I'm fine with 2 attempts instead of 3.

> when resume doesn't work at all any more then that would be really bad

Agreed =E2=80=94 and that scenario is exactly what the v3 guard is about.

Thanks,
Oleg

=D1=81=D1=80, 21 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:2=
8 Christian K=C3=B6nig <christian.koenig@amd.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> That HW is ancient!
>
> The question is really if that works reliable or if that could break anyt=
hing?
>
> I mean when UVD doesn't work after resume is ugly, but when resume doesn'=
t work at all any more then that would be really bad.
>
> Regards,
> Christian.
>
> On 10/21/26 15:29, Alex Deucher wrote:
> > + Leo, Christian
> >
> > On Tue, Oct 20, 2026 at 3:46=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com>=
 wrote:
> >>
> >> On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume fro=
m
> >> suspend intermittently fails the UVD ring test:
> >>
> >>     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xC=
AFEDEAD)
> >>     radeon 0000:01:00.0: failed initializing UVD (-22).
> >>
> >> Cold boot always succeeds; resume succeeds only in about half of the c=
ycles
> >> (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
> >> 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD s=
tays
> >> dead for the rest of the session and hardware video decode silently fa=
lls
> >> back to CPU.
> >>
> >> The resume path runs the same full asic startup as cold boot
> >> (evergreen_resume() -> evergreen_startup()), so the difference is the
> >> hardware state at entry, not a skipped call. Field data shows the firs=
t
> >> ring instance after resume is dead functionally, not by timeout: the r=
ing
> >> test fails fast and deterministically, and only a full stop+init cycle
> >> revives the engine.
> >>
> >> Fix this the way the Windows driver effectively does it: silently cycl=
e
> >> the engine once (clocks up, start, stop, 20 ms settle) before testing,
> >> then run the init sequence in a retry loop - on failure of clock setup=
,
> >> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms a=
nd
> >> try again (up to 3 attempts). Each retry logs the failing step and the
> >> attempt number, which also makes future reports of this failure mode
> >> self-diagnosing. The ring-test polling window is widened from 100 ms t=
o
> >> 2000 ms as spare capacity; the early-exit poll keeps healthy hardware =
on
> >> the fast path.
> >>
> >> On the same machine the patched driver went 6/6 OK across repeated tes=
t
> >> runs, with the warm-up absorbing the dead first instance and zero erro=
r
> >> lines in dmesg.
> >>
> >> v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko A=
I
> >> review - MMIO writes to an unclocked UVD block can cause a PCI bus mas=
ter
> >> abort and hard-hang the system.
> >>
> >> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> >> Link: https://bugs.launchpad.net/bugs/1865130
> >> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel=
 7.0.0
> >> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
> >> ---
> >> v1 -> v2: keep the clock-setup result in a separate variable and only
> >> call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI revi=
ew).
> >> Also folded in the silent warm-up cycle and the wider ring-test window
> >> validated in field testing since v1.
> >>  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++----=
---------
> >> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> >> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> >> @@ -158,24 +158,58 @@
> >>  {
> >>         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_IN=
DEX];
> >>         uint32_t tmp;
> >> -       int r;
> >> +       int r, retry, clk_err;
> >>
> >> -       /* raise clocks while booting up the VCPU */
> >> +       /* warm-up: silently cycle the engine once (like the Windows d=
river),
> >> +        * the first ring instance after resume is dead functionally *=
/
> >>         if (rdev->family < CHIP_RV740)
> >>                 radeon_set_uvd_clocks(rdev, 10000, 10000);
> >>         else
> >>                 radeon_set_uvd_clocks(rdev, 53300, 40000);
> >> +       uvd_v1_0_start(rdev);
> >> +       uvd_v1_0_stop(rdev);
> >> +       mdelay(20);
> >>
> >> -       r =3D uvd_v1_0_start(rdev);
> >> -       if (r)
> >> -               goto done;
> >> +       /* after resume the first ring test can race with the hardware=
; retry */
> >> +       for (retry =3D 0; retry < 3; retry++) {
> >> +               /* raise clocks while booting up the VCPU */
> >> +               if (rdev->family < CHIP_RV740)
> >> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 10000,=
 10000);
> >> +               else
> >> +                       clk_err =3D radeon_set_uvd_clocks(rdev, 53300,=
 40000);
> >> +               r =3D clk_err;
> >> +               if (r)
> >> +                       drm_warn(&rdev->ddev, "radeon: raising UVD clo=
cks failed (%d), attempt %d\n",
> >> +                                r, retry + 1);
> >> +
> >> +               if (!r) {
> >> +                       r =3D uvd_v1_0_start(rdev);
> >> +                       if (r)
> >> +                               drm_warn(&rdev->ddev, "radeon: startin=
g UVD failed (%d), attempt %d\n",
> >> +                                        r, retry + 1);
> >> +               }
> >>
> >> -       ring->ready =3D true;
> >> -       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> >> -       if (r) {
> >> -               ring->ready =3D false;
> >> -               goto done;
> >> +               if (!r) {
> >> +                       ring->ready =3D true;
> >> +                       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UV=
D_INDEX, ring);
> >> +                       if (r) {
> >> +                               ring->ready =3D false;
> >> +                               drm_warn(&rdev->ddev, "radeon: UVD rin=
g test failed (%d), attempt %d\n",
> >> +                                        r, retry + 1);
> >> +                       }
> >> +               }
> >> +
> >> +               if (!r)
> >> +                       break;
> >> +
> >> +               /* MMIO is only safe when the block is actually clocke=
d */
> >> +               if (!clk_err)
> >> +                       uvd_v1_0_stop(rdev);
> >> +               if (retry < 2)
> >> +                       mdelay(20);
> >>         }
> >> +       if (r)
> >> +               goto done;
> >>
> >>         r =3D radeon_ring_lock(rdev, ring, 10);
> >>         if (r) {
> >> @@ -421,7 +455,8 @@
> >>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring=
 *ring)
> >>  {
> >>         uint32_t tmp =3D 0;
> >> -       unsigned i;
> >> +       /* after resume the ring buffer controller needs ~1.5-2s to se=
ttle */
> >> +       unsigned i, timeout =3D 2000000;
> >>         int r;
> >>
> >>         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
> >> @@ -434,14 +469,14 @@
> >>         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
> >>         radeon_ring_write(ring, 0xDEADBEEF);
> >>         radeon_ring_unlock_commit(rdev, ring, false);
> >> -       for (i =3D 0; i < rdev->usec_timeout; i++) {
> >> +       for (i =3D 0; i < timeout; i++) {
> >>                 tmp =3D RREG32(UVD_CONTEXT_ID);
> >>                 if (tmp =3D=3D 0xDEADBEEF)
> >>                         break;
> >>                 udelay(1);
> >>         }
> >>
> >> -       if (i < rdev->usec_timeout) {
> >> +       if (i < timeout) {
> >>                 drm_info(&rdev->ddev, "ring test on %d succeeded in %d=
 usecs\n",
> >>                          ring->idx, i);
> >>         } else {
>
