Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6A5CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD8910E08D;
	Tue, 13 Oct 2026 13:57:41 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B2210E615
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:57:34 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3a4c78ee4d6so191880a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791899854; cv=none;
 d=google.com; s=arc-20260327;
 b=HilsDtRhnW7UIZALHoJgKJGWLJY7LxzSyTEjNQM6GP6NwNtstmJzLsrAKcMH9bGr6s
 uuUQhtPobtkLLHFZJXtybhvsda3H+xifG0o/NQFS5wsZtUm4El4vuO7zHiNRqsy34IXu
 bUv40oiGhbnXMFxJNaWFwkn7066NaO4yXpWy8vaTUjmWxwrxSQosPQ0Ia2Nc1yWyQY0n
 g/Q872wftuFRG34Q+6JwjX52jPXB0RDnQh/rrrlu0FwBkwsIDdTCJSAWMLDONw3tyP5o
 h9+BQuU+uLpBuB5fGG9rDKqefLozt+KhnVTRRB8M8I7HpZ28ikJuKCkQqD+9MzPd/l4M
 AOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rfj584oy8UA5F67nkuq0WsKUqLvK+JnvySyOkFpdoyI=;
 fh=9g09NTs0mbCyOXDmsXhzk+P7fu3sOpq4yiORWgMW3WA=;
 b=Ld0vl+R2YJXZ0o0Abou00zNC0Eb0fK8i274d12zEiBmpPt+AQsnc3mTHujNNjf/MYl
 VsTmtiQovbYfQthyckRY396iBEEmHB23WWnCitI375YmP6JIRk4IA2Ea72kXb8GwR1X7
 7+27BAdggCSS1oYohScPdUTS6QcUuCih7IbHFFJ4qW5YJT/FOW4Ar+KXrL64gUDBKOhX
 I1uwn2fgx/4joQGB6YGu/hFF432F9a7GVyxBtH5t3pY0V8oiEwEeh9IWKQVboOk97Cr3
 NSJqJQv+sVMjfPwm90U76ieeJg4odkbVw5T8qYJEWZTSI86UHsVTfW8jI39DIiqd27Cr
 XGmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791899854; x=1792504654; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rfj584oy8UA5F67nkuq0WsKUqLvK+JnvySyOkFpdoyI=;
 b=De/cAZlT33jx9NaKFgLqt7VfQ2d5tBhQ3hm+2Ej+8ImFD38W46uCOSPpPLl0gy4nMr
 fZfx/8bwZPpRUM8maOIqY0Ki+yBF6U1DXU+MvVKaWzV+QF91af3VlOhZ2vWFZPmoZC3i
 JtdVSZiS8RSrlMWra5bHqORaO+oH4XSBUWsBP45EYQbSsz4rh9Jl0pBcL1H+d9o0UXpw
 gdPXju331K4RMnPB7J4PQtiCZHfPDnjUClvWrAWF9luQAXr81vDlOsmcW5EOhHHoUa4g
 ovagwXic69z8PFJz+XASctmafo9y6W/7nG3OVUVawqEO1+GigK2om7vGPqm9/WQ0L8l4
 WJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791899854; x=1792504654;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rfj584oy8UA5F67nkuq0WsKUqLvK+JnvySyOkFpdoyI=;
 b=fofpRP9DrxYmeE2KKT0KxuUqxiv4SGP+HT5+MtxfOmXaAkGEEshXx/mw3YPBBJQNJj
 3zEcu7JddzSIKCDWIkShMfbUecb1a1RBRROwwvm0MhpAdVlFpGPAVFjiNclfy+pkaKUh
 IRrJfFvA9G7i+VSXa6YIC+bCblhQhDdkNS3dIcXBStG4G8oyriSTCt2qkjJu+CGlLI/r
 BDHe8n6mMeGaZ/L4cJXynUoHj6vCtDP4vDafzi2Rps7hpMK9/TA/qpgys1nImMOBTXu6
 XECyu9hX1rzVGUyYV/mz034ZiOzCuPAr2DYSxf3ocjrHd69ay9EtBlTaYjrY8hMCzpMx
 pODA==
X-Gm-Message-State: AFq9FYI4xjgNcxpG9nlLs+W3EAXFeOnKfeGmOPQiqeO6pciPB64Ks/l7
 9aov1SxdRtAF9oFr288Eli52CfD3Rh1egWXcsddf8IRFplOYjAAmNYP1a3futkZgMRsWsjQa0pw
 3SF5Ch67RnQScvysZ/jLexEqTlykSrSkfN6+s
X-Gm-Gg: AYBFou1LkuUbi645RwdIhF+JQsM7SmjJN4UW0AMx1o8EyjwpKy72sqdYlo+lEw0YY5H
 p+zPYHBRrPYF3MWi+xz/kXmWMQBEGR3cXgbrYC58iNPyXDb4RCmW2mrk9NsESru9u5P4mMya3LR
 nJDJ4Ip5Q7GxDr0s9lexrct12GBoTCX44oZzvW87my6GOAHiHpSUgWgKzu3MTZnWkzGDwRqt+M/
 MSRW9V/Ss+H9xk2k9HIg79xIOfz3CT4muOS2kpDx/usxsKBt0RVtRrWwNeIj8XRkfBKJKky4phj
 fblB0n7uj/2uq2PMD0f+W2V/rLaAldwzPzBkA24pMQ6/NTDEJbzbycw3Q8CB8nTDQEfNVxwMCzz
 MdF+6SMs0qkMc80WgzGUyN3cWX/1UZ9axdBjCj4Q5UA==
X-Received: by 2002:a17:90a:d44d:b0:3a0:c162:51af with SMTP id
 98e67ed59e1d1-3ab39fed8b6mr16753074a91.0.1791899853803; Tue, 13 Oct 2026
 06:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+e2gLsfGRVzJ4WmGPOD-C9Bx8F=7Oeoc-v9FWUX-oUfNDRGCA@mail.gmail.com>
In-Reply-To: <CA+e2gLsfGRVzJ4WmGPOD-C9Bx8F=7Oeoc-v9FWUX-oUfNDRGCA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Oct 2026 09:57:22 -0400
X-Gm-Features: AclHuK8KzMgaLDFczBk64c18UXm36p8AQbMKmHq5UdNHNo1Z-CDTtYojx9wtI5Y
Message-ID: <CADnq5_PNQmJEtVDyP_8o+irkG9zKPfNetzLXHU6ybar3aUxJHA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
To: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Cc: dri-devel@lists.freedesktop.org
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

On Tue, Oct 13, 2026 at 4:16=E2=80=AFAM =D0=9E =D0=9A <kolomiiec@gmail.com>=
 wrote:
>
> From: ukrainer8 <ukrainer8@users.noreply.github.com>
> Subject: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
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
> hardware state at entry, not a skipped call. The single 100 ms ring-test
> window right after VCPU boot simply races the hardware coming out of
> D3 + ASIC reset.
>
> Retry the init sequence instead of giving up: on failure of clock setup,
> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
> try again (up to 3 attempts). Each retry logs the failing step and the
> attempt number, which also makes future reports of this failure mode
> self-diagnosing.
>
> On the same machine the patched driver went 6/6 OK, with the log showing
> the ring test failing on attempts 1-2 and succeeding on attempt 3 =E2=80=
=94 i.e.
> the retry caught exactly the failure the stock driver used to declare
> fatal.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
> Link: https://bugs.launchpad.net/bugs/1865130
> Tested-by: ukrainer8 <ukrainer8@users.noreply.github.com>   # Radeon
> HD 5650M, kernel 7.0.0
> Signed-off-by: ukrainer8 <ukrainer8@users.noreply.github.com>
> ---
>  drivers/gpu/drm/radeon/uvd_v1_0.c | <diffstat>
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -158,24 +158,45 @@
>  {
>   struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX];
>   uint32_t tmp;
> - int r;
> + int r, retry;
>
> - /* raise clocks while booting up the VCPU */
> - if (rdev->family < CHIP_RV740)
> - radeon_set_uvd_clocks(rdev, 10000, 10000);
> - else
> - radeon_set_uvd_clocks(rdev, 53300, 40000);
> + /* after resume the first ring test can race with the hardware; retry *=
/
> + for (retry =3D 0; retry < 3; retry++) {
> + /* raise clocks while booting up the VCPU */
> + if (rdev->family < CHIP_RV740)
> + r =3D radeon_set_uvd_clocks(rdev, 10000, 10000);
> + else
> + r =3D radeon_set_uvd_clocks(rdev, 53300, 40000);
> + if (r)
> + drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attempt =
%d\n",
> + r, retry + 1);
>
> - r =3D uvd_v1_0_start(rdev);
> - if (r)
> - goto done;
> + if (!r) {
> + r =3D uvd_v1_0_start(rdev);
> + if (r)
> + drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\n",
> + r, retry + 1);
> + }
>
> - ring->ready =3D true;
> - r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> - if (r) {
> - ring->ready =3D false;
> - goto done;
> + if (!r) {
> + ring->ready =3D true;
> + r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> + if (r) {
> + ring->ready =3D false;
> + drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d\n"=
,
> + r, retry + 1);
> + }
> + }
> +
> + if (!r)
> + break;
> +
> + uvd_v1_0_stop(rdev);
> + if (retry < 2)
> + mdelay(20);
>   }
> + if (r)
> + goto done;

Your mailer seems to have mangled this patch. Can you try and send it
again, ideally using git-send-email?

Thanks!

Alex

>
>   r =3D radeon_ring_lock(rdev, ring, 10);
>   if (r) {
