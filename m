Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F51CCD98D2
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:43:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD19A10F659;
	Fri, 12 Jun 2026 18:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="t9D9nNrP";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9F210F659
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:43:56 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-68cec9f4c6cso1796969a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289835; cv=none;
 d=google.com; s=arc-20240605;
 b=VOmkvB7hFq9MjBzvdPh5VnsTM1BIeR227uklvge1FQ4bfz7LaJIL6lJmrcJOH5QTau
 rAKvdZhhHTRa+xUk+Ez9ZktIYOGYauG7C6gR8t2Mn80K7WPlNFFc9fbPpQoqpVfqIKWa
 Go1A1jsIaok8QMDXNg/SvWmqdlO6PlOTK9/PPipJLkE+DvD5Ob6vaZiExWXUIMD1UmfL
 Q9Q85g6Bktg2QHpRykqf/ziSQxapE6YUoDNtkbFzbulrEV6fWxfwhFrmfPHeor+SvXt5
 Zo3IbL3kLLla/EIrk4yRYT9ferTW323zX4UFOw3X2bolHMlpeGbMLyE+1ExHCaO/8Qqg
 ReUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 fh=IBii0uFKWlKzTQMSLId2LIv6sMGvcsg86YjPYT6FRV0=;
 b=HVQTsToze1AxQzzCdlVzrrchY8n1DFIrZs9HwlR+fgx/92HYBgsS8LjoaGQ5Q9ip4c
 P/UJKI5MgmXwbRTgffQltUxnaFR0yba4s/7MWfu1DSa9I2HSFeWp3UWcuh1jiES6TbpT
 HvtLHKX1llpxwnU1NR+Fif2VtKH1JzLyIMJlQ7zfiXl9LIK1OGxHYX3x/tCEUAVAXqja
 otAHc6hGlkPA9+I3ZeLV3wT7lmunwGa0ckFaGKU61UfS3bA41uI/PRzKPy5vn5rx788+
 AFbHdamBBwVgq2+xuaZUdFdbVjuJVzzxWzcbIIsWj/iVWnv+zbWIlk0qL/XJOt9krB31
 Bucw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781289835; x=1781894635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 b=t9D9nNrPoDo6ftXuNApa2mKr7APo9WSckCfd5/tp/tdZN+lObIJiwHeWWaW5rRc0Gy
 iasYRngq+9UWDO0R24kXkePwbL+PCDuUQEmu607hhpePJQzOiBwC5SB/pTqdXm0LRuas
 TKP08Fb/SOwAdUglUTloexF8YmvwVmQIYnSdDYOZXzUfdlfeiufucPcTarOYug12pkiY
 xoH3tAGTS++L7EwkHbIMDQPtzcgyuEWUZ1BYEzqbdoBiFTM2AybSv81QIU0gAx1iBWvF
 j0/DGuNgXRTEgP2Y0uKpcYQqpwzxQ3p3TGFdWUdUrb2cwtxDNZw+qs6EzlCsp7N8EsTi
 JElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781289835; x=1781894635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6DnumblQJH/uXGfU059VkkZKwxZmNHcGuyxEw+XU2qE=;
 b=QRzTkcsi99iHR+xOm0KoODNfSTY3MquSsL7xFpYdYktG1RvJ8cVj1kosdIvPEMoHC1
 yj+OSwMfBhLjFXqHyUfjFeDsmvaNqrFiBwEiep4NpNBgSBzwlsIZ4swoybO0Bubu5R8W
 D7rZAoUC/Dek89nnATqSPb8Bh+2LkwTbupgHot/QFQtSoH6NsQ622j8PnuDaaqLgZ3LY
 olrKeu7Fan6Zs4EayYrRDrjPUOg5ApA1msnh+9DQC41+3oTBPjTBcSCEXHsW4+v1cNf8
 /kOOCMH3+KCWk6uqPKyQuXYKsE/Ihi2kXdceJv32lSJBGjezEB7orCIIIVb7DDw3yAQ9
 eWXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ946t5qdo4l1xl60Hth1ViAwEBlRiXAeSOdeJMHvKe+WJHnYqL18stXfS3ue4hW4ma4cDgeIi4Gqck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy901t0aW2fNdGPWvgHeO5xNxIIUgSdwTlR2vHSbvNeIJXR8CiQ
 yQKQrQqMbpvcqQTFue1ySZ6nCFQSHFIjeRvYwkihaLQuh+3/8AUTAWrYrGNP4XrS9RUZQ8Z0645
 fnDffImSP04nM6/B4/FglOC6whx7e5Y96y1/KcsVgwQ==
X-Gm-Gg: Acq92OHczbK2tieAz+XWogKkHr7W4aOx3y4I5rbUHKKVzHM12Aa/BdICBDkZc6zlh2w
 CWtKHD0yPZGfnbmBBcYKcn51j2OwPFKJjygubOJKx2qN+tihd0VHb7d2VEIr3TotOeucrbeHsIq
 r5vNK/bwh9Or9r+xlhoQLe2D+anIklUkLqZWp7ZIfzzWrn9Nzrs5n9Ss1+cr2aAOK16h9okXkV/
 5woW2k5l538idUdbHCwvUQd85OpcNoXZFYbWPyazb0pV6pdBt15hk6Y/OYfIgvhbNfnrsqzSPk1
 3/ta37tqMjc2gYMJi2/suwNq1f77fsJ+TdWYeVq/bVOzDGfdEY5jevJeY8iDBLBFvRCVbD1g04x
 VRtlknUKbNEkfTxKrR0G3XZgOfhgki5pvnEW3
X-Received: by 2002:a05:6402:e85:b0:691:a699:da5c with SMTP id
 4fb4d7f45d1cf-693c6a6ae83mr166917a12.17.1781289835396; Fri, 12 Jun 2026
 11:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
 <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
In-Reply-To: <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Date: Fri, 12 Jun 2026 15:43:42 -0300
X-Gm-Features: AVVi8CcfB6VWasgjDsXNWWEnkpmrEqTP8ocKbH7N_vHLj19h1d7NE8oW539gptM
Message-ID: <CAJgF-xtvOSwB4S8Xw1JwkyWQVEMEMfpmVyTxAKaESi0s9XoRkQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation
 logic to lookup tables
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 airlied@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com, 
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Fri, Jun 12, 2026 at 4:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/11/26 21:49, Guilherme Ivo Bozi wrote:
> > This series converts the GPIO HW translation logic used by
> > multiple DCN generations from large switch statements to
> > static lookup tables with shared helper functions.
>
> Not to block this patch set, but please keep in mind that when some array=
 index comes from userspace to use array_index_nospec() to avoid security p=
roblems caused by speculative execution.
>

Thanks for the feedback. I reviewed the relevant GPIO and DDC paths.
In all cases, the offsets and indices are derived from DC BIOS tables
or internal DC GPIO service mappings, not userspace-controlled input.

If you still prefer additional hardening for consistency, I can send a
v2 with array_index_nospec().

> We already had problems with that in the past when people converted switc=
h statements into an array lockup.
>

I=E2=80=99ll keep this in mind for other paths where array indices may be
influenced by userspace.

Kind regards,
Guilherme Ivo


> Regards,
> Christian.
>
> >
> > The new implementation reduces duplicated translation logic
> > across generations and makes the GPIO mappings easier to
> > maintain and extend.
> >
> > The series introduces generic GPIO translation helpers first,
> > followed by per-generation conversions.
> >
> > The following generations were converted:
> >
> >   - dcn10
> >   - dcn20
> >   - dcn21
> >   - dcn30
> >   - dcn315
> >   - dcn32
> >   - dcn401
> >   - dcn42
> >
> > The dce60, dce80, dce110 and dce120 implementations were
> > left unchanged for now.
> >
> > dce60 and dce80 contain special switch-case handling paths
> > that currently do not map cleanly to the new table-based
> > representation, so they were intentionally excluded from
> > this refactor.
> >
> > No functional changes intended.
> >
> > v1 resend:
> >
> > No changes since original submission.
> >
> > Automated review:
> > https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-20260=
512190019.228440-1-guilherme.bozi@usp.br/
> >
> > Guilherme Ivo Bozi (9):
> >   drm/amd/display: add GPIO HW translation helpers
> >   drm/amd/display: convert dcn10 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn20 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn21 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn30 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn315 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn32 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn401 GPIO translation to lookup tables
> >   drm/amd/display: convert dcn42 GPIO translation to lookup tables
> >
> >  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++-----------
> >  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
> >  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
> >  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
> >  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
> >  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
> >  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
> >  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
> >  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
> >  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
> >  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
> >  11 files changed, 1274 insertions(+), 2035 deletions(-)
> >
>
