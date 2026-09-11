Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771FAC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3986410E345;
	Fri, 11 Sep 2026 20:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GDoCntrm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F5DD10E345
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:05:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C46EB405D1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91FA1F000FF
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 20:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789157128;
 bh=PpFeCwtNj9an8nsyLqFMRFYj6rfUEv/mKuwbF+j/cVw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=GDoCntrmK4hCKOqE49dngvd9moURrMlb6sACQb4cDw33T8PwwzQ4H1ytORTq9Yqss
 /8kgqkpYcJFYWcssG+xjprEjmFWww4u210YahkzVC6ESjPXD4E+0Lx6D7uQsPEpcjb
 bXodHI+bdMiA41w/ruTlkaYc2NO2Vlr/ZE4yE4eUHkG5hILBjFHnYKWn8wa+lZOD/e
 UXHqUIOC0+j/mnEtHVwFDlHP7yvGlnmowBDxjb0SnfdPk4gSboE/4T1Be9dE7c77nK
 jl062DAw2f0Jx3nDFQPyvHyWekae9/cnohrB3GPan8rNWAyJzvIR2k7bemuiTwNPRk
 IM0bnlCaRSSRQ==
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5b4ae0b3308so1066928e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 13:05:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxTZ17bDanAPhxtvTxSd0t5wV3EnuKUChSDgm+sZVhzC4OCAXkMx3DL867f+cz84CDg1lQ8xc2ipkg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyRclKXuBL1XkcJrZHgivJIEm8MBVkhXIJ1yQjmBbNF1LxMf2C
 EjqfbH+oAcwIiO1VU7waKIl3KQFEGYIONB28uP779RZZWMooAlBrdjNO1TINXKuvjvGwCo8hltU
 DlqDKpML/9I4kZG5AVE7LDDDQeCUdUB0=
X-Received: by 2002:a05:6512:32c8:b0:5b6:1a7c:aa1b with SMTP id
 2adb3069b0e04-5b8a0320bd0mr1348956e87.51.1789157127323; Fri, 11 Sep 2026
 13:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260825105427.686619-1-roshaen09@gmail.com>
 <CAD++jLnAoOaRwWpkVX0o1z0wF=Qs9PRTKbq9iq-GWSkJ2kyX8w@mail.gmail.com>
 <CAD++jLnBPAw9CJ4JtZt46yBd7+UEHYA189Dma3tNfuV=wu1TDw@mail.gmail.com>
 <CAD++jLk3Czenn1DdgFGGEwJHQQ9ZrmFng=fmih4MUP8NaRGx3Q@mail.gmail.com>
 <178915364143.207017.11386693869817053993@gmail.com>
In-Reply-To: <178915364143.207017.11386693869817053993@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 22:05:14 +0200
X-Gmail-Original-Message-ID: <CAD++jL=9bEn2iG5q7tTL63_mdBHPVWhK7Z7Xm7Um8LJKWSFEyQ@mail.gmail.com>
X-Gm-Features: AcwNN1XrOSAtcxWDwbkPX5C4KTo8dF5jcyvxN1B1BIG4eE22eRdTmpLCLI_O3Ow
Message-ID: <CAD++jL=9bEn2iG5q7tTL63_mdBHPVWhK7Z7Xm7Um8LJKWSFEyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/pl111: Advertise no pixel blending
To: Roshan Kumar <roshaen09@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Ze Huang <ze.huang@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
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

On Fri, Sep 11, 2026 at 9:07=E2=80=AFPM Roshan Kumar <roshaen09@gmail.com> =
wrote:

> Not quite. I tested the newer iteration attached to Thomas' earlier email
> (patch dated Jul 27), which Ze hasn't posted to the list.
>
> I also gave the v2 4/8 you linked a boot on the same QEMU setup and it
> behaves the same, so the tag covers either version.
>
> Tested-by: Roshan Kumar <roshaen09@gmail.com> # QEMU vexpress; v2 4/8 and=
 the Jul 27 iteration

Aha I see.

I will wait for Thomas & Ze to tell me what they want me to do
here.

Yours,
Linus Walleij
