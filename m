Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0BFC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 19:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18EA10E6A1;
	Sun, 27 Sep 2026 19:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6gxJKmz";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E65710E6A1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 19:33:38 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-141a5d476abso104782c88.2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537617; cv=none;
 d=google.com; s=arc-20260327;
 b=XkNns1fzMhacTmMF2QnpXgZUWRLyfc++y07efl7jEkHe3E3WIhMQSZkKdJ8r7wx9Ri
 k2tM2dTghIsgKTbo3++1nsrj+qL81CxRjOeKLdWCR4ML2tCxQiziEIGd+UsW2dqgWPX8
 ex7iTVDstcP74+GQJxX30XdUO6yMlK9RMGmReLPVvRBIP/tQg/5DDVsavb+cFRHd5oSC
 B+xw4PJ4o/3Oa+bYpBqFaBKnUz56vMP28OCLRGbR7wYp6nPp/oEkfG57Qt94hiBa7tX3
 Cp/8g4VL7//CqvJjOSEYp43B9SPkhZRHEwAx6yLy+WbcMA4RfyXXT2umyaqsQa9n953M
 SsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 fh=sfdXIymhNyWMi4Lq+vWUhSm5916R3sEAK3YL1CYnEUA=;
 b=hUNstp15jOGxETDMJ3QeTdfdpGJoftQ5UKbzhiPj+w6lbbqZB/nz29ZS9H5Z8i+dBB
 Dkdbmk9fGRq0T2kkAMkpTPaZ7LKJzHzSVjTzUBioU6eW3Ha2qKzg8a1xFVS/FpdpPWqa
 2ZqhqNVoXYkbi80VZDjCAH32WmJ8eUBJrK32ZetxUS6aUhCbzEkelZcGqI5MPdFV8Gr6
 dwUndbHton9mjGVZM8SWLfgROf3obLVVZ1cMEzl7fg/vacXLtqAnd+yObc+v8lBLj0T5
 TNC2NmrDNcKQzAMpnAJjRHEsEeNRziM7e+t4i2spFfPAxOZR3qFgf+XcR0uSflqB+nkV
 Ts1A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790537617; x=1791142417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 b=A6gxJKmzGCeIG8aLNQxk709+bqwxbnxwNXTiJth48fq91Us8CyAb7Y7Otx7ku1hWtt
 f99CGgLQYuaYNVHPZV3Js3QmnU3V6vYKDckucsP0qh9QX0MaStLCEktBpBcAv+bq+h8e
 +CPKegvm6bgNfgcbP2sSZkXXeNA6f5hEdzGUmIfmhnDpQ5sGeIAm4GApQUqDo7buCFk8
 /2sqiybsm3+xiDWPU5U8BCnHLvS59bk3LqB6/q3x05Mz2OMNQa4Tz+hkTXgArw3Hc693
 t5V7AZ0jaYh9TI5LRlOBQvpMG3NKB+zHYHNy4LwvCl8xe6bWSz3HcaFCShyeyEDmigNG
 4HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790537617; x=1791142417;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l5q866BvvSma/IMVrDV/6rai/IHNDTchFlxM/hoTak4=;
 b=jeBwvH+7NSiwuqeEW3rKcUrDgZwC23L9I/pnPssGw8MMjCToKHt6kXkcPfZQGmLhct
 dcA1U86pOuGuHrJ9ZkV5kvQrNPXs+kdzsZBMnoMtb63zqkQI+gYqT4R5IOgLJmmw7r0Q
 /3yftufljCMGJ8H0gUozz/3CL3U0ypggrAUPWInX7uuYAhJSxG3rJM/hVIegzdUZuXfw
 2qpBN43XjJK/E3mMd86jczLSOw0dEv2jkgUgzp9YzbYUvxhNDwDfIDoRqis0rD0YsUb+
 q7XQNyhIyycwHQX0ruc1HCHCi2/hZBz8CS3jdFKRfSnRyNPUx02LyyQP4M7WyzPsumQ5
 r0TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHI5ZdM5dqxNj20yG1Ob+M6MVgOYrRhXDeJQiuAMCstDSvHhis91Z6FXCoF523uf47fYsbT5qEJDs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nPZrrP9uXeM4FEE9YPckfuOaVQ0RLC8SO3AWmzOUPnN+MtUpWW
 jkLN/sudjXWLOMCLT2WvJ3M7GtHuPFCtPq3rUHQn0pidTqENVIQCAcSGiA7wRycxg04VEVzfQBz
 mpO/NrDCreDvnjubbNCYCutObSrtkgoI=
X-Gm-Gg: AYBFou1T1BkfhtmZhhg+M8an+9QJxOLvMJDwJPSEmF8n1QEvzSNn4MG/E6zstJKul2u
 caJH4+eWXZ2yxEEaXvmJ7CBA/xrUyA7o+GPkjCinXTmvKtkipcc+K3Ym/pdFp+1IcIAzrSgvs3u
 ForZGSo3OH62HsNDWDXrrhOkL5Fc0XFipU4Wb2fUOyFGGt84GKa4tNEnXn/fITXk6i+UTHUme6r
 284+LplhDKRM38OHw7e4tIXDfhUCRGY553LbpsQyTcLGr1oUrJHitRRA9T/wOY6Tz67q1zco2jy
 SZXkGfHnzs1vq0qJeUwXYgYwO5RwPSSyDTCZrBYHcrxBhUmTefzLPi131wzu1IucfBkaY5yG9G+
 ZlhZs3yJj89BERZwQngOeHLaDwY6x8jfFMSJPvgoraA==
X-Received: by 2002:a05:7022:ed0e:b0:149:c766:2965 with SMTP id
 a92af1059eb24-149c7662eb8mr808764c88.2.1790537617314; Sun, 27 Sep 2026
 12:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <179039514312.597384.1659548947123427650@kernelci.org>
 <8ad00f0f-d924-4b19-986c-8c17dcdade86@leemhuis.info>
 <CADnq5_O7R096UP9mF5RvGSzT+c2p2v2Dm8M243CLxXa=VZvRwQ@mail.gmail.com>
In-Reply-To: <CADnq5_O7R096UP9mF5RvGSzT+c2p2v2Dm8M243CLxXa=VZvRwQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 15:33:24 -0400
X-Gm-Features: AclHuK8c840Og0RGxMLZ7uUkzrUME3CtmSIvH_BZYI1XGrw_XTLZ4m6Qt7dWeFs
Message-ID: <CADnq5_Mg-0CjN1hVm58N=jVhFO_abjNU6mAPY3MpfsajsGfUMw@mail.gmail.com>
Subject: Re: [REGRESSION] mainline/master: (build)stack frame size (3096)
 exceeds limit (3072) in 'dml_core_mode_prog...
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: kernelci@lists.linux.dev, kernelci-results@groups.io, 
 regressions@lists.linux.dev, broonie@kernel.org, 
 Alex Deucher <alexander.deucher@amd.com>, DRI <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Sun, Sep 27, 2026 at 9:29=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Sat, Sep 26, 2026 at 6:37=E2=80=AFAM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > On 9/26/26 05:59, KernelCI bot wrote:
> > > New build issue found on mainline/master:
> > >
> > > ---
> > > stack frame size (3096) exceeds limit (3072) in 'dml_core_mode_progra=
mming' [-Werror,-Wframe-larger-than] in drivers/gpu/drm/amd/amdgpu/../displ=
ay/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.o (drivers/gpu/drm/am=
d/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c) [=
logspec:kbuild,kbuild.compiler.error]
> > > ---
> > >
> > > Log excerpt:
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > /tmp/kci/linux/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/=
src/dml2_core/dml2_core_dcn4_calcs.c:10513:13: error: stack frame size (309=
6) exceeds limit (3072) in 'dml_core_mode_programming' [-Werror,-Wframe-lar=
ger-than]
> > >  10513 | static bool dml_core_mode_programming(struct dml2_core_calcs=
_mode_programming_ex *in_out_params)
> > >        |             ^
> > > 1 error generated.
> >
> > Hmmm, there are known "stack frame size [...] exceeds limit" problems i=
n
> > -next that should soon be fixed there, see:
> > https://lore.kernel.org/all/CADnq5_MFMriR-b3eX0mTZShPDgUBgwoObgumEjJ9cJ=
qdmDM6xQ@mail.gmail.com/
> >
> > But this error is new -- and happens in mainline. Wondering if this is
> > caused by a fix for those problems.
>
> + Leo, Alex
>
> Looks like some combination of compiler and/or config options explodes
> the stack even further than the recent changes handled.

Should be fixed with this patch:
https://patchwork.freedesktop.org/patch/756590/?series=3D175063&rev=3D1

Alex

>
> Alex
>
> >
> > CCing Alex and Christian in case this is really something new they want
> > to know about.
> >
> > Ciao, Thorsten
> >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > > When fixing this issue, please attribute this report according to the
> > > patch submission rules:
> > >
> > > Reported-by: kernelci.org bot <bot@kernelci.org>
> > > Link: https://lore.kernel.org/all/179039514312.597384.165954894712342=
7650@kernelci.org/
> > >
> > > For complete logs and details about the environment used, see the iss=
ue
> > > on the KernelCI dashboard:
> > >
> > > - dashboard: https://d.kernelci.org/i/maestro:24dc0670f5eb77688896917=
0a199e08b7f23f99b
> > > - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> > > - commit HEAD:  6812ce4e4379ffc99c52401ec28f0d7ffbc36206
> > >
> > > # Builds where the incident occurred:
> > >
> > > ## x86_64_defconfig+allmodconfig on (x86_64):
> > > - compiler: clang-21
> > > - config: None
> > > - dashboard: https://d.kernelci.org/build/maestro:6ab70c1f5ec73975aad=
e9d6e
> > >
> > > #regzbot introduced: f14572c203d57492e1d4e5d7851a3b143e083b82..6812ce=
4e4379ffc99c52401ec28f0d7ffbc36206
> > > #regzbot link: https://d.kernelci.org/i/maestro:24dc0670f5eb776888969=
170a199e08b7f23f99b
> > >
> > > #kernelci issue maestro:24dc0670f5eb776888969170a199e08b7f23f99b
> > >
> > > --
> > > This is an experimental report format. Please send feedback in!
> > > Talk to us at kernelci@lists.linux.dev
> > >
> > > Made with love by the KernelCI team - https://kernelci.org
> >
