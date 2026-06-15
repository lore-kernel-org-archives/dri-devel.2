Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3440ACD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113F810E543;
	Mon, 15 Jun 2026 16:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kyH64PaC";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A91F310E537
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:07:28 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1365eb2a773so176760c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 09:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781539648; cv=none;
 d=google.com; s=arc-20240605;
 b=iwpT4VmGwdjudXgSUaVFypE8s7dOaU+cEksQjUTPtFbXDUqwYg9/0NbFI3OU7b6G0C
 ZWMv86DxjB8OzUXs/QAC+i3br9+UgOQ1AejHAv0OWohDs3hqM/rH7Qhp69A6/7p7Esow
 vj7gt2GkM0iZyfPEoHHsz34meACbDwHCX04DROiDdV0vlw+Si5nQJ6v7VZlaCOchXISG
 cII4EnPJII+5/iNEKsCbp1d+LieHNOmA1FXZxZKX+i7M/OkhLG/Er1l71GCrRgw9kLB5
 GRLOJ58u/XFp8QrF5GNX65OC2Pnk4KnSWr2Nu1lWA28JVU4Js5+7oWtiObJDKR2Xjrfu
 ESOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mQhB2xvbV4B2oYmCAIBExO3PWOsuBM4dJiFzqvFFcao=;
 fh=61s4GZHpq65z1LY1lhk8yuN/X/O0c7VsdS1Plm5mV2A=;
 b=P++ymlzvOCrNqdRBDEzXtPhkwE2qDNbd7pSXCUnNqcvGb8NddZFN1ydIe7mGjcUpEG
 9Z+v5ha9SJkk19zJTo1QPUiWD530YPoBxULq0X/oIP8+528GFsGK7fDAVSLpmdV0lqph
 QtCJWKX9PjXgR2jhOG3FwBgI2pHzXY514uTdhxz7A5mblZBi9ibZhJS4Xl09Xi357oL2
 k2wDeVOc5d0Lk8nicTSWhirq8qIrQmtDmZTFHgXXpUDoC91gTJmTGCuIg/7ursZCj+tO
 lFaai1t1ZGWSrJby3kBBBG7uiJ5tNYUB/z8hQc0asHR8UqM9KunZz0hqcQDaM+gbsj3b
 Vjlg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781539648; x=1782144448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQhB2xvbV4B2oYmCAIBExO3PWOsuBM4dJiFzqvFFcao=;
 b=kyH64PaC9KCrCZShRGAECKvCNDHd5rX7BbU6gtILU54gNRl4PrmpeOK0S6W3dfu38Z
 +NK1XML4YY9OCP9puzggTuTqSLAyQM4CtGWQpiKWuh+QvNwob60Wq2vGzERwpXgvPdZK
 f5IbgoktGxlwPkHEIWRWsnHNIjXxdyy0vfcAC24C46zQ63A/rHtXTlT2zYCbGWcwGV0s
 4Q1nyWJPUrREO2eNSlH8X8W4YnrUEzYNeS0o4BxW/JKLHQ4D+/TbpkpeZzGsrMWI561b
 m/nlxeEmFb2qTbq5lkJ+PwvPEe+3xcmApI7oM/PSOtW5BP7OEMiyatw7lfCv6/LP7qQa
 eL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781539648; x=1782144448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mQhB2xvbV4B2oYmCAIBExO3PWOsuBM4dJiFzqvFFcao=;
 b=n3Ogx6iQpvoIrLxm0OpUWyCJmJz8eQYd4EQJY9jmlIfb/HycxoKL9AvVykV3/CRGCo
 xE02/tQYCb57Cp2LeGU3eECGdQ68Dak6NAb5xmv8Sj1rP77MYmLnuoyMKOnJiueEojM5
 iwch1CgsTE+Xt0re0JP6qdP3jk1o/2OCxARdxVFcu1PlKnxGyQVUdeQABXFw2s33qE9I
 zWJm0NJsTQp5MgCUGpZjTWMxa/Js5PckrwXrC6hz/kV643O+Cj5tvQWORC6mwkqiKhFY
 Bqor0XJxxmdcZlNrAtwp+1b5fHLSC3bIbLeo+mq89xyGhdn80RdMW48DMExQBHCg8F2c
 D4pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZmFduBOJP1Xjvw/qmelp7MMwkyGQaS6MuzdHojghXUBTB8Get5bjhIyMzh7vQKdkpfYCTRMJ72Co=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwECIw6fBd+SFXTjk15xaqboFtAMiBWbavOgjfayDde3avtKcuu
 g/zRD4gJd4axYOhp7aajiCNcP/CBSqFKL75sfpXYishDGixfqhl95zVYkZI83iuMNjoBr3ioQd5
 XVG/ol6LNj/owp+xIwiUH7s9TIkBNE/4=
X-Gm-Gg: Acq92OFbHnZi0mYBUK9WCOSVvSFSdE/Zx9lhR1tfGJqsF8/qUYtY4i4A6VTK9af7L0r
 1lINQiPGYxxGoaaTMAliioyidzUGn4YdCf1wan5/MOVnwG1WRJoO9RVHApq5h2b1Z91wYh2KmYq
 8FBR0PRQoMUdMJY0vWepray17kdUjuf7sqzn9OCFW3NzVKFezu+xbMTRr1JKWGX/mOA/YSCu7HQ
 8NUqd1G+cW77HnD0dvE6x4ko84QrAffvfQsjO/Z1quN+n3NfnZwIfM4SzrG6VJodXf1Dm+IsSNF
 KPNrYwocMIe+JMHdHh2Pt0JzhpLe2ZAdXx1bLwiYwVWWDKzjA+rxMTVGCR4FohiuR5QjtQ==
X-Received: by 2002:a05:7022:688a:b0:138:63d:e43e with SMTP id
 a92af1059eb24-1384bb7c5e9mr3260964c88.4.1781539647815; Mon, 15 Jun 2026
 09:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260611195026.25125-1-guilherme.bozi@usp.br>
 <33b42033-a5ae-4fa2-bafa-ea007a29eab1@amd.com>
 <CAJgF-xtvOSwB4S8Xw1JwkyWQVEMEMfpmVyTxAKaESi0s9XoRkQ@mail.gmail.com>
In-Reply-To: <CAJgF-xtvOSwB4S8Xw1JwkyWQVEMEMfpmVyTxAKaESi0s9XoRkQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 12:07:16 -0400
X-Gm-Features: AVVi8CcvJ_LxWBys5pApzXEYFZorrvkQUcYRsoAaDlW4-qZk0SaOyWk-HOsPs8Y
Message-ID: <CADnq5_MA582cy9t69EaA+h42DHNhUoR-i9c3nUo=C4YRe1nJtw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/9] drm/amd/display: convert GPIO translation
 logic to lookup tables
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 airlied@gmail.com, alexander.deucher@amd.com, simona@ffwll.ch, 
 siqueira@igalia.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Fri, Jun 12, 2026 at 3:39=E2=80=AFPM Guilherme Ivo Bozi
<guilherme.bozi@usp.br> wrote:
>
> On Fri, Jun 12, 2026 at 4:34=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 6/11/26 21:49, Guilherme Ivo Bozi wrote:
> > > This series converts the GPIO HW translation logic used by
> > > multiple DCN generations from large switch statements to
> > > static lookup tables with shared helper functions.
> >
> > Not to block this patch set, but please keep in mind that when some arr=
ay index comes from userspace to use array_index_nospec() to avoid security=
 problems caused by speculative execution.
> >
>
> Thanks for the feedback. I reviewed the relevant GPIO and DDC paths.
> In all cases, the offsets and indices are derived from DC BIOS tables
> or internal DC GPIO service mappings, not userspace-controlled input.
>

I don't have a strong opinion on this.  @Leo (Sunpeng) Li , @Wentland,
Harry , do you have an opinion?  It doesn't seem like it really makes
much of a difference either way for code readability, etc.

Alex

> If you still prefer additional hardening for consistency, I can send a
> v2 with array_index_nospec().
>
> > We already had problems with that in the past when people converted swi=
tch statements into an array lockup.
> >
>
> I=E2=80=99ll keep this in mind for other paths where array indices may be
> influenced by userspace.
>
> Kind regards,
> Guilherme Ivo
>
>
> > Regards,
> > Christian.
> >
> > >
> > > The new implementation reduces duplicated translation logic
> > > across generations and makes the GPIO mappings easier to
> > > maintain and extend.
> > >
> > > The series introduces generic GPIO translation helpers first,
> > > followed by per-generation conversions.
> > >
> > > The following generations were converted:
> > >
> > >   - dcn10
> > >   - dcn20
> > >   - dcn21
> > >   - dcn30
> > >   - dcn315
> > >   - dcn32
> > >   - dcn401
> > >   - dcn42
> > >
> > > The dce60, dce80, dce110 and dce120 implementations were
> > > left unchanged for now.
> > >
> > > dce60 and dce80 contain special switch-case handling paths
> > > that currently do not map cleanly to the new table-based
> > > representation, so they were intentionally excluded from
> > > this refactor.
> > >
> > > No functional changes intended.
> > >
> > > v1 resend:
> > >
> > > No changes since original submission.
> > >
> > > Automated review:
> > > https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-overall-202=
60512190019.228440-1-guilherme.bozi@usp.br/
> > >
> > > Guilherme Ivo Bozi (9):
> > >   drm/amd/display: add GPIO HW translation helpers
> > >   drm/amd/display: convert dcn10 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn20 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn21 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn30 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn315 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn32 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn401 GPIO translation to lookup tables
> > >   drm/amd/display: convert dcn42 GPIO translation to lookup tables
> > >
> > >  .../dc/gpio/dcn10/hw_translate_dcn10.c        | 484 +++++++---------=
--
> > >  .../dc/gpio/dcn20/hw_translate_dcn20.c        | 432 ++++++----------
> > >  .../dc/gpio/dcn21/hw_translate_dcn21.c        | 417 ++++++---------
> > >  .../dc/gpio/dcn30/hw_translate_dcn30.c        | 432 ++++++----------
> > >  .../dc/gpio/dcn315/hw_translate_dcn315.c      | 418 ++++++---------
> > >  .../dc/gpio/dcn32/hw_translate_dcn32.c        | 386 +++++---------
> > >  .../dc/gpio/dcn401/hw_translate_dcn401.c      | 392 +++++---------
> > >  .../dc/gpio/dcn42/hw_translate_dcn42.c        | 193 +++----
> > >  .../drm/amd/display/dc/gpio/hw_translate.c    |  86 ++++
> > >  .../drm/amd/display/dc/gpio/hw_translate.h    |  21 +
> > >  .../gpu/drm/amd/display/include/gpio_types.h  |  48 ++
> > >  11 files changed, 1274 insertions(+), 2035 deletions(-)
> > >
> >
