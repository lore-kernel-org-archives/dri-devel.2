Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7E8105F79B
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07FF110EBA5;
	Fri, 13 Mar 2026 11:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qTxn7Y2u";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9FB10EBA5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:27:01 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-439b7a87fb5so1604902f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 04:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773401220; cv=none;
 d=google.com; s=arc-20240605;
 b=IkqGAaG5DFqHaYC/179IWmnV2azlMjjI3UqMOfD736vwmzkZjEjESSD3RYhn+W3xVU
 G6HW9g4Imnn/oSCOpd/1Is8lxW9JFT9n6M5TS8ASt4Vz2MRhVnHj+x/NiWUr4UMVwyal
 SMgD+orjaxitTGbPIJXcCmEznLM0F0oKwBG98YlQHXlmNoUSazJCTaO0dUDJbg6JtRJo
 mTkD2OEyrrYYGK1tgN5hCAPJ5VyjXWrYmCUa19th5HOYM1X42Afg9EgMqECDBeshJfNR
 dkvgFljJz0kbqlrUR+LXAOXDR4Oe4uCKF30QW/69VEAt/fEsVlh1bkvlQEI6+Cbw0ixN
 Wk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oyt+ZfMfYxDKRVuKbiCNT4uX/OXqUN9qFlMYleYX9OI=;
 fh=gv6L85g9iGNrLWtpkOmaURbhW5KrbxQNQWeKqahFnY8=;
 b=kQjiiZSnE+IvKKcK8Q/69S5KjfcuhdhDiCuTe1HEznuMRQBlohyL/Gu3l8YXtoXRjn
 G2P1E14rUQoxEpGvbO5mlBMYxtKco5wGTYUsZhf1geqdtxFOhYwnvATKlqONnYfNEUab
 9VEhIHHAQpsZaqQxFEUMgSICixyJ31YHq1uHDo3uybVPR4tJwRYapi+W//v319lGgVEz
 J2rHix3HjNKoS6t4RIdncJX731I4/IzInGc6Pigqk3hsfQU/NYxj//m+wTzPO/IkTrHw
 e12Umws3VICnTvf3twHfZ6thuWlFO3yzs1HZqOr2YApI0SVj0jTh0rNg+5KZzR+uaCHR
 mgog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773401220; x=1774006020;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oyt+ZfMfYxDKRVuKbiCNT4uX/OXqUN9qFlMYleYX9OI=;
 b=qTxn7Y2um+6vzBFN3OhKPRGGIGjPT2ME4kYmjtF8ez/NfPd11U4uqkVS3lS9sDsS2T
 VlZvoP5Ds5FPuiYri5n5t4HlOLQvoDJawzj95JhJBD4oxPoqIE1b5M+YPrmcjMIFtob/
 IcEfW76XvFICH4hzcbL7WZ/AgR53I0avE7ALYZ2JBnovaacK4qwFNFC7N3I11ypaMnCT
 CRMSxxOcrVHEx2D0S1qDB/PE/7LkQrxhxZeap8pwh4sWPFB6ER0ddrY3Op3fi33ZaivR
 IokrgaIb/zhetkX+47CZCONOt/in6ryeChGxEiKo6Pn6nt4fKIyx/f1+ogC05yRWqq1V
 A82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773401220; x=1774006020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oyt+ZfMfYxDKRVuKbiCNT4uX/OXqUN9qFlMYleYX9OI=;
 b=D6n4QafLnOSUQXyb3ocjyl56RU1HvD+mVtlf4zbkYJIfxv1/eJuVrmKMcNPmS+C6WB
 1/Cmb0X9EbvGnU73RPiJ0cI4hWed74ViwRdH5L6zliNZAgCUox77Nh1RJjHK9pUNOJl4
 7W2eECRfI3+nHx/S1ZMcMNl8U68w5Y80YaxI3+d/+CLl0pCK4k1r4yxNhFoNPn8Fo2B2
 7Me3zxxjudRzKtnFtsismq7qgjmhZwDaapCTltmbUNWobusBjTCu6pynXgP+zR8mDI8B
 X7rgmugI4NwryJnWS5hg22XgJqqB+Rk2BBzvPEN8Wwyt87fzdUk01znzgthOoYfSKuZt
 kGyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtNPwuRHNAo4DMQkkqIX3oZoBk+3jSP7kDaCUZFFV7DxenP4mW9LRUt6tJUiJeyC9RwZJH/rHTtnM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzi+zKt3hl5CTHIZ+YXWudjHf5c3CPNTL+e8yB1bk2bnn+3kHC+
 EzlE8sHSq3WA3Gersx/YShXW/3ODBYUCVdkZlJwB4TBKkmwnYaZVoet8VIcPr/PEUJovv0Wxv9e
 xPFtmI4SzU/EO9wmDjDvPpwnTGY+/Mhnuoi26a2dr
X-Gm-Gg: ATEYQzzy9Q0O6CKAtFeybArxGPmEAYxSkopNF7UqWJK+etOVWFMqA0uHdb8qMsDu2dR
 Mrn7pNdES7fzTylerFwrlGJ17ZDD00tBcLeXSJzYWEEqBDxKHPRGo1uiAuF0YnwpXH6GKGhrkAN
 hnHPvaNXqTO+7NX9sdnF30UufQTEk21DtYsksPmXg3Or7/lpVtI7XNJT9gdSq5yZnIsJbEJzQhw
 Z8Pj55cZ5GpPzzKnLHlvrfPNV6+9GKZFhvmhlHbmUluEyx615NYCNr56LcZo0VA6be8PLD54afh
 8mdHTX6b5eqQZ7I4SfxrSz3//29lWyILEmzQ4YUq2OuWKYCl6uMkCj84pUNU83GUjkl6rA==
X-Received: by 2002:a05:6000:18a6:b0:439:d73d:95e with SMTP id
 ffacd0b85a97d-43a04da8191mr6114695f8f.27.1773401219803; Fri, 13 Mar 2026
 04:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260313091646.16938-1-work@onurozkan.dev>
 <abPeUBWpTB3mQRQs@google.com> <20260313141228.36ad6e43@nimda>
In-Reply-To: <20260313141228.36ad6e43@nimda>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Mar 2026 12:26:47 +0100
X-Gm-Features: AaiRm50G5PW7f-JOBV2MdV0GNAwCIyaeaW1Vc_JgUVMxQ2LNOQ5DdcEHR8VhrHE
Message-ID: <CAH5fLgiDvCaK7xu+R-cr8Cp8ABK0=xSQxXAJxKhSLRhtjH4fpQ@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND 0/4] drm/tyr: implement GPU reset API
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dakr@kernel.org, 
 daniel.almeida@collabora.com, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
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

On Fri, Mar 13, 2026 at 12:12=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> On Fri, 13 Mar 2026 09:52:16 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > On Fri, Mar 13, 2026 at 12:16:40PM +0300, Onur =C3=96zkan wrote:
> > > This series adds GPU reset handling support for Tyr in a new module
> > > drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset
> > > controller internals and exposes a ResetHandle API to the driver.
> > >
> > > The reset module owns reset state, queueing and execution ordering
> > > through OrderedQueue and handles duplicate/concurrent reset requests
> > > with a pending flag.
> > >
> > > Apart from the reset module, the first 3 patches:
> > >
> > > - Fixes a potential reset-complete stale state bug by clearing
> > > completed state before doing soft reset.
> > > - Adds Work::disable_sync() (wrapper of
> > > bindings::disable_work_sync).
> > > - Adds OrderedQueue support.
> > >
> > > Runtime tested on hardware by Deborah Brouwer (see [1]) and myself.
> > >
> > > [1]:
> > > https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/63#not=
e_3364131
> > >
> > > Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
> > > ---
> > >
> > > Onur =C3=96zkan (4):
> > >   drm/tyr: clear reset IRQ before soft reset
> > >   rust: add Work::disable_sync
> > >   rust: add ordered workqueue wrapper
> >
> > I actually added ordered workqueue support here:
> > https://lore.kernel.org/all/20260312-create-workqueue-v4-0-ea39c351c38f=
@google.com/
> >
> > Alice
>
> That's cool. I guess this will wait until your patch lands unless we
> want to combine them into a single series.

You can just say in your cover letter that your series depends on mine.

Alice
