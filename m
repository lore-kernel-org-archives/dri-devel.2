Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E4BF8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879348905A;
	Thu, 16 Apr 2026 16:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="D4khchrl";
	dkim-atps=neutral
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch
 [109.224.244.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469C510E266
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1776356665; x=1776615865;
 bh=jTqTkrmbgUx1RiSdH5IwyezXcSZLW1HO+PTj3QHXYsk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=D4khchrlNlRMmQes0Zc+6u7wNiV7q7OxB9wXxwGpJVlyyxfrJ8tcCw9zNYfq1iV6i
 +c3iBiTy01DQsCkBbTrf4PFIB4bj2Iz6CEHxEruaMNEDUJa2MbiTpNttdKM1tT/hd7
 G/dXRPkcoUHkeSxp4Lg1WCpuriUOATsMRP01JRRTSHPDTPUoygXLmLaG/IgvCZZWtv
 nKZIM6+VWleCaC20gEBRPTUHerxTFiD9kekU3meTFXOkP0yqBAR28CBSb60pM3lDBq
 DraoVL1yQuvFB/OpcocX9axnhWgaPPoOevcYmzgwm5FZmvJuVb4jPZGZ9esq5TwvIB
 sdxB+1xupr6Pg==
Date: Thu, 16 Apr 2026 16:24:18 +0000
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
From: Simon Ser <contact@emersion.fr>
Cc: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v9 05/11] drm/fourcc: Add DRM_FORMAT_X403
Message-ID: <SQRHbzJxi9A-aeEnsDNGLR894I12tg2scl2pctpSh-TkMc0l9DvzXUmuvYAk9br0__ixXrxPE3k5qa0IhKDrLpKTX04fNUAlWEzl-vzssCw=@emersion.fr>
In-Reply-To: <6abc165b-4220-422c-8190-283a3dea1f62@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
 <20260325-xilinx-formats-v9-5-d03b7e3752e4@ideasonboard.com>
 <jCbIrZ5-fvx73de8DmjQ7xpuEw63kTCQ5p88cdF7yRcUk7uNbE9y0YU7uZbPXNotQAB9y6c0u5n3TrnXckvQ8Oje_J3QGxEwBSr_liQVDK0=@emersion.fr>
 <94283390-29cb-4640-b5b4-6a332dd7f2a4@ideasonboard.com>
 <6abc165b-4220-422c-8190-283a3dea1f62@ideasonboard.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 34605617869f672ea6b1b08b3c7caddeb1ffba54
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Friday, April 10th, 2026 at 08:54, Tomi Valkeinen <tomi.valkeinen@ideaso=
nboard.com> wrote:

> On 10/04/2026 09:07, Tomi Valkeinen wrote:
> > Hi,
> >
> > On 26/03/2026 16:43, Simon Ser wrote:
> >> On Wednesday, March 25th, 2026 at 15:02, Tomi Valkeinen
> >> <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >>> +/*
> >>> + * 3 plane non-subsampled (444) YCbCr
> >>> + * 10 bpc, 30 bits per sample image data in a single contiguous buff=
er.
> >>> + * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endia=
n
> >>> + * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endia=
n
> >>> + * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endia=
n
> >>> + */
> >>> +#define DRM_FORMAT_X403        fourcc_code('X', '4', '0', '3')
> >>
> >> So, this one is different from the Q family, because Q has padding in
> >
> > Any idea where the letters (P, Q, S) come from?
> >
> >> LSB rather than MSB. Speaking of, maybe we should add "LSB aligned" to
> >> the doc comment to make that clear?
> >
> > Yes, I can add that.
> >
> >> Re-reading the sibling thread about DRM_FORMAT_XV20, sounds like the
> >> first digit matches my expectations for sub-sampling. How did you pick
> >
> > I just used the name in Xilinx's BSP kernel.
> >
> >> the last two digits? I think I would've expected "30" here rather than
> >> "03", since the last two planes are Cb Cr rather than Cr Cb.
> >
> > Hmm, but X403 is Cb:Cr, and P030 is Cr:Cb, so doesn't 03 make sense
> > here? Oh, but Q401 is Cr:Cb, and it's 01...
> >
> > Now that I look at this... I think I have to go back and do more
> > testing. From the Xilinx docs, it looks to me that the XV15/XV20 should
> > have the same CrCb order than X403. But the comments in these patches
> > say otherwise. I'm pretty sure my tests conformed to the comments here,
> > but now I don't feel so sure anymore. It's been more than a year since =
I
> > wrote the tests and properly tested these, so I have to spend a bit tim=
e
> > to get everything up again.
>=20
> I think the comments are correct. I guess it depends on which way you
> look at this: for P030 etc, starting from the lowest bit, the order is
> Cb:Cr. For X403, starting from the lowest plane, the order is Cb:Cr. And
> that's probably how Xilinx HW "sees" it and thus they use the same Cb:Cr
> order.
>=20
> But in the comments we describe P030's components starting from the
> highest bit, and thus it's Cr:Cb.

Thanks for checking!

> >> Has the first "X" letter been picked arbitrarily? It's already used to
> >> denote padding in other formats so I wonder if we should pick that
> >> instead of, say, "T".
> > I didn't invent the name, I just took the naming Xilinx used. I don't
> > know the history behind it. I assume the "X" is for Xilinx, but I could
> > be wrong here. What would "T" be for? "Tomi"? =3D)
> So... While the Cb:Cr order can be seen both ways, perhaps the Q formats
> are a good reference here to follow, and thus it should be "430", not
> "403", as you suggest. As for the letter... Anything that's not
> currently in use is fine for me =3D).

P, Q, S are used for other YCbCr layouts, R is used for red, and T was the =
next
letter in the alphabet=E2=80=A6 But I really like the "Tomi" format layout
explanation! :)

I'd also be fine with pretty much any letter not currently in use in other
formats.
