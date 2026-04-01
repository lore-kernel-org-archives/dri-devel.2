Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF2810FCAE6
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429C210E7E7;
	Wed,  1 Apr 2026 21:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nrbwr01w";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E359910E7E7
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 21:22:29 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso28000266b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775078547; x=1775683347;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDXL+tWAaeLKiYVautvlWKkmnxZljqgnepO1JJNEfIM=;
 b=Nrbwr01wp1FmScnWzcR2nPyTIZlS9j0eDndpmuCEMUyJAUaBUqLM5coNwfgfhtKPPy
 sKcVEx5wf83UPJlBTaL4XODC2l1UgHLYPi5OFFBA/MdEXv1siRgC5CO5/kUVXVPybPaE
 CihxlFhJJ8M/vPOOjGFTFRHQ9hG+lK7uqp07o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775078547; x=1775683347;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oDXL+tWAaeLKiYVautvlWKkmnxZljqgnepO1JJNEfIM=;
 b=Bp4Atc8DFObDhkJFWtEDoxKSoRle+dnU8qDDmS1BFXXSJalPWLJoPQG6RmsHz7Iy7R
 fRHlqTn7xIrnG0MXgydqnc53Ky6x/Q2u1y2dtSjoKxEgHmBdyDHRhvHKRA4p5b74+jVv
 nO/6HmDvHBsrRj5DaZubnt6qhahOsAfSmzoyq10VAynOLMsm5Ggz3W8zVIxpdcDQOBen
 UpkM9a8214Q3apmE7tGWpXZVn82M9Ty9GSYLtJCDzqpJOLXFerj3QHbjnie6MWTKR2pA
 HgKbvvMgBXY3Uo3odynXNb7r+009ZFfmfz2Ip5gGii9xjAPDVdsqxIN7/jZ3f0gzONtB
 9Iwg==
X-Gm-Message-State: AOJu0YzbPd0pPtbFEba9uf+/32RqYNccI1g+ztoz4uRrpgbWuHM4oDYh
 jexogJRExJlsN3tSiVo843mNaYb2iRAs5P5rbNcxROU2g+4r33Bgy0KN4anVRtDL7VQspV7kryi
 Hd3QtBw==
X-Gm-Gg: ATEYQzyEIC64swxaT1QDtSAmlB52Pdf1cAXrOmxCLV2vLOjdeyRIIoHEuJLBB0xYlOE
 BUKo/X7y4381e5oggHvFcMXcTOgObQTjlfy1ZYxBpyp2hUBBjwlivCWdLZlm37FPwn1ADgSFidY
 dCE0i6C3UvTP/SWPXw2jJZZuJXHQZX6U/YSX74uweivQzcQ0ZoNhVV944MdIL9u6wTliNf5Oqvt
 85KZK1azQdDi2hKquDbh/MznH4DUEyhKeM/5ltd+fLFWlPw4Itp1Vw3fXtP+zKPKGqHZOdzickh
 iuYUNJF/ALcz7tA/TV+KW8y1YJw51xsGxPDD6tHNs3INI+8ZS0u8gu0AkJla34ZCd30GFpxxDeK
 klurg57paxcJl+caDZMnwEDeQydS7l62rC97ZcID/34xgiMLSamPSsnwiJzQwHdjRpbgCVuwCt6
 7rwYxaavCgQuMLibj7cpSe8+xzw2Cxr96ZkjXkuh0ccrsFB1bnjD2rWtw0h/98AQ==
X-Received: by 2002:a17:907:608e:b0:b9c:1a5:acc1 with SMTP id
 a640c23a62f3a-b9c13b182bcmr345696366b.28.1775078546586; 
 Wed, 01 Apr 2026 14:22:26 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3ca9a145sm26517266b.25.2026.04.01.14.22.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 14:22:22 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso126802f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 14:22:22 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43d:613:33d8 with SMTP id
 ffacd0b85a97d-43d150dc486mr9979954f8f.29.1775078541499; Wed, 01 Apr 2026
 14:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260401090334.2329270-1-alvin1.chen@lcfc.corp-partner.google.com>
In-Reply-To: <20260401090334.2329270-1-alvin1.chen@lcfc.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 Apr 2026 14:22:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOL56zaLUGNzDUWcvbSENiHbDvNjD5dmkCgcHqUBL4QA@mail.gmail.com>
X-Gm-Features: AQROBzCff3_mic6kdtdG3NCK5-lSNuNEnN6IR-P_WLrPr1U24_9dvZFRLWc99fE
Message-ID: <CAD=FV=VOL56zaLUGNzDUWcvbSENiHbDvNjD5dmkCgcHqUBL4QA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change BOE NV153WUM-N42 enable timings
To: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Wed, Apr 1, 2026 at 2:03=E2=80=AFAM Alvin1 Chen
<alvin1.chen@lcfc.corp-partner.google.com> wrote:
>
> BOE: NV153WUM-N42
> 00 ff ff ff ff ff ff 00 09 e5 b3 0d 00 00 00 00
> 11 23 01 04 a5 21 15 78 03 af e5 97 5e 58 92 28
> 1f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 9c 3e 80 c8 70 b0 3c 40 30 20
> 36 00 49 ce 10 00 00 1a 00 00 00 fd 00 28 3c 4c
> 4c 10 01 0a 20 20 20 20 20 20 00 00 00 fe 00 42
> 4f 45 20 43 51 0a 20 20 20 20 20 20 00 00 00 fc
> 00 4e 56 31 35 33 57 55 4d 2d 4e 34 32 0a 01 92
>
> 70 20 79 02 00 81 00 15 74 1a 00 00 03 01 28 3c
> 00 00 60 49 60 49 3c 00 00 00 00 80 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 cb 90

NOTE: EDID is only needed here if it's different from the EDID that
was provided when the panel was first added.


> The default 80ms enable delay (T8) for the BOE NV153WUM-N42 panel
> has been found to be insufficient for certain hardware units,
> leading to intermittent display initialization failures and
> "drmSetMaster failed with -1" errors during VT2 switching.
>
> Through extensive stress testing, increasing the '.enable' delay
> to 200ms provides a **significant improvement** in synchronization
> reliability. While this adjustment may not completely eliminate
> failures on marginal hardware units, it substantially reduces the
> failure rate and provides a more robust timing margin for the
> DRM driver to complete initialization.
>
> Validation:
> On a previously failing unit, the 200ms delay demonstrated a
> marked improvement in stability, successfully passing over 1,200
> cold boot cycles before a failure was observed. This is a
> significant leap in reliability compared to the original 80ms
> generic setting.

I'm really not a fan. Is there a way to determine the deeper root
cause here? Have you asked BOE about what's going on here? Do they
understand why the panel needs this extra delay, and why even with the
extra delay it still doesn't always work? Is the problem truly related
to the panel, or somehow about how it's hooked up to the board? I'm
just worried that this is papering over the real bug by pushing around
timings and the bug will come back again at some random time in the
future.


-Doug
