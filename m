Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E270606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bNPmWLjn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932BA10EC63;
	Mon, 26 Oct 2026 08:36:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7A3610E208
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 18:46:50 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c315869241fso278179566b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 11:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792954009; cv=none;
 d=google.com; s=arc-20260327;
 b=ewyzWK0Z/ncgvAoGt5uFq88vmsCvRqQRp3CB4rRiEW4llR9WBOo1Oyl6EFEsuj2+1s
 YvyV9oQK3gf4lqdYxc2ExzVNhadeyqYYe1ysnVI6Y3c2ozjXb+mJXt1WvWVRhGpjy4+k
 /ZsrdfugBW3qk3XGBTeiGRsJhvJMQ4EPZOpMRAuK+fRTgMz33izsJAly1roNeCjzn1Nh
 keP/yDroTr3TBoDkFDCnCN4RBZSDkPXUQF9RwMRVYL0Ibcrl8k0BIi97N/bYlx14kWo5
 glLzUt94e/549tNPC86DN0qDNNSde/6mRkfWZy0AxcNgTV7R1xJpVmpDDeV1Ku5GTwgt
 KXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eqNpD+49VOUxCgo9bVSSjGzAaSfLXWRGle/Z9fMpunE=;
 fh=yrfoeM18OOOx5Q/IjduSoBMvQiehAgOyxPkBQ3/LssI=;
 b=LJw413WwYz4sItvNlyRDlaMRerzAXsbjmoTj2noMdEXWx1TZ7BFQjWZLsrhpQ5Srkj
 bYInS7M5BIO2RY/so1a+VpPkuCx7G27lDzg4HaMNlOcGbK6iDflfpyBQqu7NK3iiAsS8
 TCAAIV5va29ZqqlQmNhbdK84eZD1Vi3dnHj2i7RmD5MFwj4yT3Diil7oa0e0CemOjS5K
 tuDMBBo9NJqTEiwT9WJFJdYbGDbW1wAXgH/jJIqWhcVGiSuxvRG8+Uh6nWa68wfJf1ev
 V/URdpKAmcO0q5QWLrxo4OxqxYTqhtkr733JcbBSAgnHwTPhpbiwUAhqCOiO1S7TruNC
 5fKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792954009; x=1793558809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eqNpD+49VOUxCgo9bVSSjGzAaSfLXWRGle/Z9fMpunE=;
 b=bNPmWLjn2Z3G41YfKzUt86isviLBgCqkDCCRu6jlZSt2TVg83W6tN4uigICbZcFQyT
 vrvoK5QAxU0/f0ljBOTyCMXdSlDVzeh9w7DIZSxS9S3MUzRvnNRrGS7V8e4kc3TuVA6u
 sJ/k2A6Ae3gVe/ziuCF4Rv5Of+fih9t8EUZw/PgCXhhYDOJG4g+AMDqDFYRihvn3fc/V
 6Ax9tZLVlthqT2J7N6eMX0rfs5gODl0Lo3M0roRcBZJjMXmfRHQK+osjRNahAkFX8jS5
 eYYyq8GshKFONXENdsCCC8KtJtAEwOGvAqYLZeXVFj5oNanC/edzzJW9L3H3JlCq1VqP
 FScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792954009; x=1793558809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eqNpD+49VOUxCgo9bVSSjGzAaSfLXWRGle/Z9fMpunE=;
 b=gvDumSS/qaXXC7G3BL2fnwKBoMZKz+YUdL2G3JHUiB9Vy/LmtFCcZNc7uGp0YXH/Ev
 A7xpDZSY8H2XYVK4/ozstnhjaBY5AzD1fLGR/wBDKPzGmPBMS2hYL1wOaP4V857H+sHn
 dnpMjC1HrhXwVGaMuIKkivUxBTMpWNQ6Mx0091x38CivqSmvH5mZ6I1Q0PLNHhuugJ+c
 Kv5Nv5hdmDdjTSfWd5D4YcMoB6JsCOi014wR0DJ7rY06ZeDEkGEMw4gb+H4LyAkt7AEU
 Og4WnZ5ynC8mOl4VT2XwDs/QK2f0I8eIcjqq1UF+9eIarZpYX0zVIIGvYjPXiay2Kga0
 blIQ==
X-Gm-Message-State: AFq9FYJXr5uuAG325gxtY8rHRezNdCi1aTQhRpRUM66UUWUC2mEYVVfy
 QIDJ0Op3CthUthHWRBkixMdR5VBamTKOH8FaDGCDWBMFTmDdDKjbaVzphSQiBL+RuIZfdYQE/1Q
 V4O3Qc1JFsY2UfFi568cDZ1loQZieZTsygpmz04A=
X-Gm-Gg: AYBFou0t8OA2P5Ji2DVMDdvO0xbJr1U7sL/2zCWaNdLu33exSsKZsAoqr4SNGHGHu1Z
 qg+6dZiVJr8wkxtakKhXaMJcA6fewjuFgYbp/IgrJoIWDviePn4P4h1841UgIAS901vck9qCZoM
 uXn6oXF/qCHxiQ31ofm328CVrinnKsdA1ubaVZUz19IdC4YUTqve8vYv1dAkEi0VC7bepIoISw8
 gZZGRSF+qCbe46W9GxIt1pHdkc6yniBMe1t+nNcipwAK/WXj3fy4EznePL0rKlzr5eCTKFdfn4l
 oIP+6wv+jhblOWumAQk5H0aoQFc0oTLMcvWNCoVkxgq7Qw7X2WyJSCeGUz/RrQFtXTbEzoEurJU
 nXMU6n4RBudi2lrw7GYHGXiWtYg67YoEXs9kpXFe5cumtjVZV0RMYr4XdLJ8OdPZs45Qg059JTM
 b9zm975WGaUZ8P2D2QOisMFg==
X-Received: by 2002:a17:906:c141:b0:c46:b3c3:cc4c with SMTP id
 a640c23a62f3a-c46bdaa8004mr678783566b.2.1792954009032; Sun, 25 Oct 2026
 11:46:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021213635.235393-1-kolomiiec@gmail.com>
 <CADnq5_OwwxyS8GCTVxg29ognO6gypW36pNwMXCMvk+33DAsR-w@mail.gmail.com>
In-Reply-To: <CADnq5_OwwxyS8GCTVxg29ognO6gypW36pNwMXCMvk+33DAsR-w@mail.gmail.com>
From: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Date: Sun, 25 Oct 2026 20:46:11 +0200
X-Gm-Features: AclHuK_-Z87FF7dHQwuulqBv3heOPhpI2Sz3yh5i1tHfuSoEizcUpOxnlYSvphA
Message-ID: <CA+e2gLuFj2LvZEaVO0e_A_Pn5J5n-yZ7WjXR5cg41cE1CiPdfA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/radeon: retry UVD v1 init on failure after resume
To: Alex Deucher <alexdeucher@gmail.com>
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

Thanks! Happy to help if any fallout reports come in.

Regards
Oleg

=D1=87=D1=82, 22 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:4=
4 Alex Deucher <alexdeucher@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Oct 22, 2026 at 6:06=E2=80=AFAM ukrainer8 <kolomiiec@gmail.com> w=
rote:
> >
> > On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
> > suspend intermittently fails the UVD ring test:
> >
> >     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCA=
FEDEAD)
> >     radeon 0000:01:00.0: failed initializing UVD (-22).
> >
> > Cold boot always succeeds; resume succeeds only in about half of the cy=
cles
> > (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
> > 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD st=
ays
> > dead for the rest of the session and hardware video decode silently fal=
ls
> > back to CPU.
> >
> > The resume path runs the same full asic startup as cold boot
> > (evergreen_resume() -> evergreen_startup()), so the difference is the
> > hardware state at entry, not a skipped call. Field data shows the first
> > ring instance after resume is dead functionally, not by timeout: the ri=
ng
> > test fails fast and deterministically, and only a full stop+init cycle
> > revives the engine.
> >
> > Retry the init sequence instead of giving up: on failure of clock setup=
,
> > VCPU start or the ring test, fully stop UVD, let it settle for 20 ms an=
d
> > try again (up to 3 attempts). uvd_v1_0_stop() runs only when clock setu=
p
> > succeeded - MMIO writes to an unclocked UVD block can cause a PCI bus
> > master abort and hard-hang the system. Each retry logs the failing step
> > and the attempt number, which also makes future reports of this failure
> > mode self-diagnosing.
> >
> > On the same machine the patched driver went 6/6 OK across repeated test
> > runs, with the retry catching exactly the failures the stock driver use=
d
> > to declare fatal.
> >
> > v3: dropped the warm-up cycle and the widened poll window per Sashiko A=
I
> > review and our own measurements (neither prevented first-attempt
> > failures); kept the guarded retry loop.
> >
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> > Link: https://bugs.launchpad.net/bugs/1865130
> > Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel =
7.0.0
> > Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
>
> Picked up this one in place of v2.  Thanks!
>
> Alex
>
> > ---
> > v1 -> v2: guard uvd_v1_0_stop() behind successful clock setup (Sashiko =
AI
> > review: MMIO on an unclocked block can hard-hang the system).
> > v2 -> v3: dropped the silent warm-up cycle and the 2000 ms poll window.
> > Our measurements agree with the review: the wider window changed nothin=
g
> > (first attempt fails fast, not by timeout) and the warm-up did not prev=
ent
> > first-attempt failures (5/6 cycles) - the retry loop already does
> > stop+settle+retry. What remains is the minimal guarded retry.
> >  drivers/gpu/drm/radeon/uvd_v1_0.c | 40 ++++++++++++++++++++++++++-----=
---------
> > --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> > +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> > @@ -158,24 +158,48 @@
> >  {
> >         struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_IND=
EX];
> >         uint32_t tmp;
> > -       int r;
> > +       int r, retry, clk_err;
> >
> > -       /* raise clocks while booting up the VCPU */
> > -       if (rdev->family < CHIP_RV740)
> > -               radeon_set_uvd_clocks(rdev, 10000, 10000);
> > -       else
> > -               radeon_set_uvd_clocks(rdev, 53300, 40000);
> > +       /* after resume the first ring test can race with the hardware;=
 retry */
> > +       for (retry =3D 0; retry < 3; retry++) {
> > +               /* raise clocks while booting up the VCPU */
> > +               if (rdev->family < CHIP_RV740)
> > +                       clk_err =3D radeon_set_uvd_clocks(rdev, 10000, =
10000);
> > +               else
> > +                       clk_err =3D radeon_set_uvd_clocks(rdev, 53300, =
40000);
> > +               r =3D clk_err;
> > +               if (r)
> > +                       drm_warn(&rdev->ddev, "radeon: raising UVD cloc=
ks failed (%d), attempt %d\n",
> > +                                r, retry + 1);
> >
> > -       r =3D uvd_v1_0_start(rdev);
> > -       if (r)
> > -               goto done;
> > +               if (!r) {
> > +                       r =3D uvd_v1_0_start(rdev);
> > +                       if (r)
> > +                               drm_warn(&rdev->ddev, "radeon: starting=
 UVD failed (%d), attempt %d\n",
> > +                                        r, retry + 1);
> > +               }
> >
> > -       ring->ready =3D true;
> > -       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> > -       if (r) {
> > -               ring->ready =3D false;
> > -               goto done;
> > +               if (!r) {
> > +                       ring->ready =3D true;
> > +                       r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD=
_INDEX, ring);
> > +                       if (r) {
> > +                               ring->ready =3D false;
> > +                               drm_warn(&rdev->ddev, "radeon: UVD ring=
 test failed (%d), attempt %d\n",
> > +                                        r, retry + 1);
> > +                       }
> > +               }
> > +
> > +               if (!r)
> > +                       break;
> > +
> > +               /* MMIO is only safe when the block is actually clocked=
 */
> > +               if (!clk_err)
> > +                       uvd_v1_0_stop(rdev);
> > +               if (retry < 2)
> > +                       mdelay(20);
> >         }
> > +       if (r)
> > +               goto done;
> >
> >         r =3D radeon_ring_lock(rdev, ring, 10);
> >         if (r) {
