Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47C606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JZusFduK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88D110EC74;
	Mon, 26 Oct 2026 08:36:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E3810E182
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:08:59 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso340910566b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792955338; cv=none;
 d=google.com; s=arc-20260327;
 b=gOVhFONQBR7yPZBy/3Jt7isAsZGGtEAYWudrofmmTc4xaGTKp+crDZYXZxkb7VVKGc
 pEl0Tyq6RtirHk7vLus9aX7rwdVfNBAvsfO5kQBIPGI3CJREgmfFcmv9osxYw64B2ekU
 wmWGDNVqekGSVLlc1cxsjyDNFzZVgZVbB/pEkTfuTaevEwRlNEIUOdvc7Ox7+QfuwFnR
 kW/WVpzeSJ0xc+s/w2tes7Rt/L+3JnCHMXw/XX4kKXRcpXl2f5eCsLxexS/ka8TBt0Nq
 iyPcRoZcpIXZ0cjUcECEcer3oV/R7O9bePbaRb8981GSsQt7q2n8rksL9tROu6vpm7+D
 ZXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LeCO7qEaNBJrzxOEvXJrLV1syT4Vi4NWXKWCOjXhSLg=;
 fh=+aQAFS1M8fyHGgjhqFIgBcc73lYAwSLsYDgiptWJXDs=;
 b=shBLu7yLHdzaxoXBOJgUzD+KRIlFxl+tuIvzf8502b6ghqFHc+ym+/RivgA7nEljSH
 QDcBCT7D7KqXeGhagMnqbu2MTX6BFXOIyBte4emMmeoQHJQeuvr55xuSCwvZWhTz91vo
 +J4iNBAMu0xYqiSAVs3uCiwEm6JjWH10Ox1q812nmlx5D4/kaeu4hXEv2/PWIpb+imzV
 rxRW20msLUVEomcVMLMRnja3xAIC+31RDp7s+NQXGuALdTRJoGcyMmkMmqM5f0IXCpOh
 bq0pRcFEqJT1GCnE30/BSwUdoJr4QTLbDcvYTToPjXMELb4SRMJZTmn35/c/zg0CBNXe
 tpZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792955338; x=1793560138; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LeCO7qEaNBJrzxOEvXJrLV1syT4Vi4NWXKWCOjXhSLg=;
 b=JZusFduKCm3uykDmYl/HzF3OdTzx+cSQKHSi2PZuK3a0RF0Ez6wOLltklOiYlgEXhC
 YqVfMibWV/SvPEXgeqWMtSZkCSY2imenbZ9eFFPAi3QPCrKCF8Vx7XgNdg2iEuweHeFS
 pc7x2OXtphJo+PUC74qxzyendZ5hb4L1vJ/fXDvcMRwpvMkBuB/HsO0v2bjH7R3oA7eZ
 /mc4KxOCKD/eAQT3U2768Qt7xNJhp8nL4Xwpz+mLVl2hDxsf0FuTiL+ofjPdK7I+sz1G
 w76946KiI/3fVOOUZ4GaIEuISAkCjly4TyFZjQsxAC5eSrn/wcdwHyWfQk1+Om52fI1d
 v3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792955338; x=1793560138;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LeCO7qEaNBJrzxOEvXJrLV1syT4Vi4NWXKWCOjXhSLg=;
 b=wRZ2YyxBOjiFhSAKfIHe6F4eWXyCEvCZSU/6tLFM00xfgG+7brNmb6ndshjkVwG4hu
 M8D2sNE2/kOtdGDmkYSH5FohuWdd0EiDap6nQdiPg9guyQgMHj2gYZYMATpGleeSy9ka
 JlvxhXCb1uQsri39PixMqiON8hLC4CcNWPRJ44joLl0G62a8calRSi6iTap7im4O9g5/
 3BKX5MhnAooTMymZ84e0E+DYfO+kIsHMNpwec6tLLgiN15Tahiettry+TfqtbIzObYLM
 7yWtofFv/j7Ke56lnfEGE9wHEz6seI8DqNalU8FpeCPy5Qcztzn01k8mbZSG0sWkhwFY
 H0BQ==
X-Gm-Message-State: AFq9FYKNHG/wON6TT4Sb6a7SccMPXQfjKRn6KeTmXVbt/VtHimQMPHkq
 QlI6qZgUFxaLAQJSvLN3Gcxw5yYZkregNvVsEo3n6FXuZLQsY0aQTcNjaoZrPzzxB3AIS4bOIpQ
 ZYFfM7X+I1Ql8foTfGUo0cY/k3ecnMlfKazunNKg=
X-Gm-Gg: AYBFou3cLkXfsB/v3v1XOeqJsTegIG9Uf0x94ahJ7JB9ynimMjdVcFZv9dN+tPOEtOz
 GZtb3u5HVlTFeS2AGOlCghpf+IUyA21akfxucGfjr38IAJRNM4YK+0ro58IFb4mOULOD0ne6Kh/
 WQLN1u+jZpJKyBSH6PMD/MtPIzF55CI1rp1M4l5tXrFL99UIgisuN/gGwO5pFboRa1vkb7KI1nZ
 kVaSoH4udypNsymQz+rzJ1rjHCDMD+hPgp1jY00AIMYM+pAk/mnCtQ5spH67QYX5jR2XPUFjUEh
 hm8rRGtg0rufRjveglIZFlV0PefE8wlFdUp/sy35sXpnhM94aH72OoVolyFcsgEO0kpOMPIhXSX
 hANuqmeZupkx6FvMITz3o+5l+s4BdAZYNztQArjlKenqCQahT/CK44qeH/P1TCgKxP6vd4V79kO
 k/AyZKxa/kIWEIsJvy2BxsbA==
X-Received: by 2002:a17:907:94c1:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c46bdc2a4cbmr654173566b.12.1792955338135; Sun, 25 Oct 2026
 12:08:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019144916.108589-1-kolomiiec@gmail.com>
 <CADnq5_N3bnL6oMbikTRVtDzZAPGwd-ptZ5ph2Sr6wPykShwm4A@mail.gmail.com>
 <CA+e2gLs3jiLmQOHwS+nxsVEdb0HvnZxGDQKKU=wwPrKS9d==UQ@mail.gmail.com>
In-Reply-To: <CA+e2gLs3jiLmQOHwS+nxsVEdb0HvnZxGDQKKU=wwPrKS9d==UQ@mail.gmail.com>
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Sun, 25 Oct 2026 21:08:21 +0200
X-Gm-Features: AclHuK_XR-WXIU_A0Fq7TIoDC-5id0uuOH_ghksFTfIklNTTKSHebUAfVnnUjqs
Message-ID: <CA+e2gLsh5cdcRuk1Wof1M+tp3qxa2UpEhAMm9w3s=KKH8eor6w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Leo Liu <leo.liu@amd.com>
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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

> IIRC there is also a bit in the LMI register which is called
> *_VPU_STALL_* or something like that. Setting that before a retry and
> waiting a few miliseconds is usually a good idea as well.

Follow-up after checking the code: the retry path already gets this
for free. uvd_v1_0_stop() stalls the UMC arbiter (UVD_LMI_CTRL2 bit 8,
STALL_ARB_UMC in the newer SoC headers) and waits 1 ms before
asserting VCPU_SOFT_RESET, and uvd_v1_0_start() repeats the same
stall-then-reset at the top of its sequence. So every retry already
runs stall -> settle -> reset, which is most likely part of why the
recovery is reliable in practice.

The named UVD_LMI_STATUS read/write-clean wait that current SoC code
uses after the stall does not exist in the R600/NI register headers,
so there is nothing further to poll on this generation.

Thanks again for the pointer =E2=80=94 it confirmed the existing stop/start
path was already doing the right thing.

Regards
Oleg

=D0=BD=D0=B4, 25 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 20:4=
5 =D0=9E =D0=9A <kolomiiec@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> > That is not really the problem, question is rather have you seen any
> > hard crashes with this?
>
> Short answer: no =E2=80=94 zero.
>
> Across the whole testing history of this patch there has not been a
> single hard crash, spontaneous reboot, PCI fall-off-the-bus event or
> any other unrecoverable failure: the three stand runs (6+6+6
> suspend/resume cycles for v1/v2/v3), every daily resume since ~Oct 12
> on the patched DKMS build, and all 42 cycles of stock behaviour before
> that. Every failed resume on stock ended the same soft way =E2=80=94 ring=
 5
> test fails, UVD declared dead, display and the rest of the machine
> keep working.
>
> I take the FW-signing scenario you describe seriously, and it is a
> good frame for judging the patch: but the retry path performs exactly
> the same set of MMIO operations as the stock init sequence (raise
> clocks, start VCPU, ring test, stop) =E2=80=94 it just performs them up t=
o
> three times. It introduces no new class of register access and no
> firmware interaction beyond what stock already does once. So the
> signing block sees nothing it would not see on a stock boot or a stock
> resume where the first attempt happens to fail.
>
> And per Alex's call on the list =E2=80=94 if such reports ever do show up=
,
> reverting is always possible.
>
> > IIRC there is also a bit in the LMI register which is called
> > *_VPU_STALL_* or something like that. Setting that before a retry and
> > waiting a few miliseconds is usually a good idea as well.
>
> Noted, thank you =E2=80=94 I'll keep that in mind as a follow-up if failu=
re
> reports ever surface on this or the other UVD v1/v2 families.
>
> Thanks,
> Oleg
>
> =D1=87=D1=82, 22 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18=
:11 Alex Deucher <alexdeucher@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Oct 20, 2026 at 3:46=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com>=
 wrote:
> > >
> > > On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume fr=
om
> > > suspend intermittently fails the UVD ring test:
> > >
> > >     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0x=
CAFEDEAD)
> > >     radeon 0000:01:00.0: failed initializing UVD (-22).
> > >
> > > Cold boot always succeeds; resume succeeds only in about half of the =
cycles
> > > (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts pe=
r
> > > 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD =
stays
> > > dead for the rest of the session and hardware video decode silently f=
alls
> > > back to CPU.
> > >
> > > The resume path runs the same full asic startup as cold boot
> > > (evergreen_resume() -> evergreen_startup()), so the difference is the
> > > hardware state at entry, not a skipped call. Field data shows the fir=
st
> > > ring instance after resume is dead functionally, not by timeout: the =
ring
> > > test fails fast and deterministically, and only a full stop+init cycl=
e
> > > revives the engine.
> > >
> > > Fix this the way the Windows driver effectively does it: silently cyc=
le
> > > the engine once (clocks up, start, stop, 20 ms settle) before testing=
,
> > > then run the init sequence in a retry loop - on failure of clock setu=
p,
> > > VCPU start or the ring test, fully stop UVD, let it settle for 20 ms =
and
> > > try again (up to 3 attempts). Each retry logs the failing step and th=
e
> > > attempt number, which also makes future reports of this failure mode
> > > self-diagnosing. The ring-test polling window is widened from 100 ms =
to
> > > 2000 ms as spare capacity; the early-exit poll keeps healthy hardware=
 on
> > > the fast path.
> > >
> > > On the same machine the patched driver went 6/6 OK across repeated te=
st
> > > runs, with the warm-up absorbing the dead first instance and zero err=
or
> > > lines in dmesg.
> > >
> > > v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko =
AI
> > > review - MMIO writes to an unclocked UVD block can cause a PCI bus ma=
ster
> > > abort and hard-hang the system.
> > >
> > > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> > > Link: https://bugs.launchpad.net/bugs/1865130
> > > Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kerne=
l 7.0.0
> > > Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
> >
> > We'll see how this goes.  If anyone reports any issues, we can revert i=
t.
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > and applied.
> >
> > > ---
> > > v1 -> v2: keep the clock-setup result in a separate variable and only
> > > call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI rev=
iew).
> > > Also folded in the silent warm-up cycle and the wider ring-test windo=
w
> > > validated in field testing since v1.
> > >  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++---=
----------
> > > --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> > > +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> > > @@ -158,24 +158,58 @@
> > >  {
> > >         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_I=
NDEX];
> > >         uint32_t tmp;
> > > -       int r;
> > > +       int r, retry, clk_err;
> > >
> > > -       /* raise clocks while booting up the VCPU */
> > > +       /* warm-up: silently cycle the engine once (like the Windows =
driver),
> > > +        * the first ring instance after resume is dead functionally =
*/
> > >         if (rdev->family < CHIP_RV740)
> > >                 radeon_set_uvd_clocks(rdev, 10000, 10000);
> > >         else
> > >                 radeon_set_uvd_clocks(rdev, 53300, 40000);
> > > +       uvd_v1_0_start(rdev);
> > > +       uvd_v1_0_stop(rdev);
> > > +       mdelay(20);
> > >
> > > -       r =3D uvd_v1_0_start(rdev);
> > > -       if (r)
> > > -               goto done;
> > > +       /* after resume the first ring test can race with the hardwar=
e; retry */
> > > +       for (retry =3D 0; retry < 3; retry++) {
> > > +               /* raise clocks while booting up the VCPU */
> > > +               if (rdev->family < CHIP_RV740)
> > > +                       clk_err =3D radeon_set_uvd_clocks(rdev, 10000=
, 10000);
> > > +               else
> > > +                       clk_err =3D radeon_set_uvd_clocks(rdev, 53300=
, 40000);
> > > +               r =3D clk_err;
> > > +               if (r)
> > > +                       drm_warn(&rdev->ddev, "radeon: raising UVD cl=
ocks failed (%d), attempt %d\n",
> > > +                                r, retry + 1);
> > > +
> > > +               if (!r) {
> > > +                       r =3D uvd_v1_0_start(rdev);
> > > +                       if (r)
> > > +                               drm_warn(&rdev->ddev, "radeon: starti=
ng UVD failed (%d), attempt %d\n",
> > > +                                        r, retry + 1);
> > > +               }
> > >
> > > -       ring->ready =3D true;
> > > -       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> > > -       if (r) {
> > > -               ring->ready =3D false;
> > > -               goto done;
> > > +               if (!r) {
> > > +                       ring->ready =3D true;
> > > +                       r =3D radeon_ring_test(rdev, R600_RING_TYPE_U=
VD_INDEX, ring);
> > > +                       if (r) {
> > > +                               ring->ready =3D false;
> > > +                               drm_warn(&rdev->ddev, "radeon: UVD ri=
ng test failed (%d), attempt %d\n",
> > > +                                        r, retry + 1);
> > > +                       }
> > > +               }
> > > +
> > > +               if (!r)
> > > +                       break;
> > > +
> > > +               /* MMIO is only safe when the block is actually clock=
ed */
> > > +               if (!clk_err)
> > > +                       uvd_v1_0_stop(rdev);
> > > +               if (retry < 2)
> > > +                       mdelay(20);
> > >         }
> > > +       if (r)
> > > +               goto done;
> > >
> > >         r =3D radeon_ring_lock(rdev, ring, 10);
> > >         if (r) {
> > > @@ -421,7 +455,8 @@
> > >  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_rin=
g *ring)
> > >  {
> > >         uint32_t tmp =3D 0;
> > > -       unsigned i;
> > > +       /* after resume the ring buffer controller needs ~1.5-2s to s=
ettle */
> > > +       unsigned i, timeout =3D 2000000;
> > >         int r;
> > >
> > >         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
> > > @@ -434,14 +469,14 @@
> > >         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
> > >         radeon_ring_write(ring, 0xDEADBEEF);
> > >         radeon_ring_unlock_commit(rdev, ring, false);
> > > -       for (i =3D 0; i < rdev->usec_timeout; i++) {
> > > +       for (i =3D 0; i < timeout; i++) {
> > >                 tmp =3D RREG32(UVD_CONTEXT_ID);
> > >                 if (tmp =3D=3D 0xDEADBEEF)
> > >                         break;
> > >                 udelay(1);
> > >         }
> > >
> > > -       if (i < rdev->usec_timeout) {
> > > +       if (i < timeout) {
> > >                 drm_info(&rdev->ddev, "ring test on %d succeeded in %=
d usecs\n",
> > >                          ring->idx, i);
> > >         } else {
