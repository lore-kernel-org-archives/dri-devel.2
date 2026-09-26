Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BFCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88CF310E842;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cps7uyC/";
	dkim-atps=neutral
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com
 [74.125.229.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656F210E049
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:32:52 +0000 (UTC)
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f16f15so1720489e87.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 07:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790433170; cv=none;
 d=google.com; s=arc-20260327;
 b=FVWZ+fDxWL0BHouNMepQmSGonkB1SG+lSZT6yF4T9x8ZYwMRxRRb621eMidGhLbj9W
 9Dq4Ru54ZGVcWOO97OYcfhWsZHLl4zqvcTdIsIX0bv78Koj+v+hWeKhmhTl/Xz2lkNw6
 D7jiTp90MBBjrQ8HDGHVgG1/OdssmNh5H/0UuIrgR6uhpAxMuFTZSItXJeEMeJnavXzt
 JVfh8skH+2bpOSru5XxFZ7EFjjk4QkvSouj1yU+juti+NdMdTuHUlhAIFTWt4OFN2VMP
 LOdqpUOo12H9sv4EV/s7QgmgCOFBR56VXadjpcV7CBB/sebpBb64qrwJi9ooV/SvVU7Z
 CCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=UwnKxeYjjB35jqKs1JWfeWzfpTBQMWF9hmaBGIxYM7E=;
 fh=MNBXXHBpBMRu9HhX6cXQhrYNdHS1DUtEhjLT7PwdGB8=;
 b=KBNbaj8KMInSBzNyXPsnFc/uvZ2jCdRislcFIOPR0Z0dbCd+Mr9X2Jt14s8Dd4EZSN
 DQ8d/sWNgZsgNuhzmET2RrsgbWf9jbJnRar2BHD11eLFbhidNX9XDE4G4qPz7E390s4C
 DoxbhlOeACswKWXchuFikSo082O49V8a+O7I0aydeo4a3wAj6YQ4KHpPMNpEq5HSKtA1
 2pTyF40KuxArYRh8je+Nyawn/Ri9lKJPA182yOmvgebnRFt5NJxasOkcNthlImfdLuoQ
 SZ7wLN+d2OX9C4Pj79vDG0UAgLMg+NGTrLshQX3oNxo6oRXBY4/JP2zezaikaF7MA1f5
 PL5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790433170; x=1791037970; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UwnKxeYjjB35jqKs1JWfeWzfpTBQMWF9hmaBGIxYM7E=;
 b=Cps7uyC/7WTKp6SneoxIai4BWCy+jtbIMmrfiujAZQgPMWrPeyOIPkBV+CYk0n3At8
 s3MgFa1vsHtZghPAr2uE3jsFybv/kEYT8C77qG7SR9lrCb07yZaio84whk3TFS5l/O2f
 ZqyU+HMZckiFNyASoHvmN830RNwp03oQboXb3LOJZ3jhgzFgjZBga3gGtW528W9r8ffj
 LNHytUwyFFs7LmwW9A7VuisNe9imASBHkL11CM/JOuV2xIQ2tln0fmHIiqrFReZLdjPl
 W4KfhH8lKQKQdemX+1ye5AKH8+tkiWpU1B9EkDlbYK/rd3wbTfGgSSmhwf7cJhTY7atA
 YnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790433170; x=1791037970;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UwnKxeYjjB35jqKs1JWfeWzfpTBQMWF9hmaBGIxYM7E=;
 b=HheC3WLyp70gRuPwtxGmr2H3XQdHIOtBimPmVJ34CXYmxdEGRknoBd4MpChDP39X5a
 ptz6/0MjVSKEdG46fp+cbQxSGbO0rXL+3dkoh61W6Oq3LbbPW7X/bW4wPH6WyDUkstJX
 G7nS0KoFDmZqfi/hD3cQiWSWaTn4Uo+ZbPD+54Mx2McVBu9p5BCpsPN1CckjjCBr4i8n
 yJCjM9vY1IZ879Ud0Ny6eoJM97xvL2C+FnTjyrQb6ZwR995B+bLnxRCjAfwj2r8a15XD
 E+y85UszJhUGNyCn5ZyEsNNWZo4r6xhJF9XoaRG+tuFicLe1Hyzvl+njFge6Cto1X7Le
 eT0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgkqJvkiZkGd7CSkmNR5OMR92l94pIgb0qkIhaGfGlESjJk7j704CWLSA4bI36GfUlcu2iwJ0M5OY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nnuE2H8rzKcvXYdq9kXiFibebA9xVnsb9BvjKFJ8IyhZWclkCD
 p3GFcNDp/T5xCJ+iXljE6YmKfLwJ0s2UFbLeufNMWj5o/17LpG4xFHFIruHbUqZyhZa1UInQZma
 iltRWM8GMmydNRp/E3Oq5sQZAjF6dumw=
X-Gm-Gg: AYBFou1jqKRoSN5iJxLrskDCqELpAOVpg2ScPcJocuQJ4tF8ijYYMBm+G7ubBafndmS
 4a4YSh+toL1CvjU/VQbUoLEaogi3rE1J43vSbLrngSai7ewrYTFT4uHCadJZGHUO2lDLTSB6+IO
 SKFYOmY6NZkMO/Fkoh3RPOoJGA40RcdK7NL0566b0od5TBMzdFfhELWDjOx8hmWvhUvNsgYoEmf
 Tp0B0H+uj8zcTFJzxf0es8iqijMTwx+XRpIjGXYTcCKZrl2q27VqO4MSsyjs/Cs96jqRs1OGc9I
 LsqrQ8YAD2+ihlxAcEkAxUWxptT7mE5ZB3sdXckaId8xvVKgDAUClPdplIlx26QLjrR+aJiURxv
 r48JWMKOJrNG3U3BONeYMx6Sb1METKwiewy9sLRSmg/tnnOLJVdDU9KZRa/7m0VCTnCpE+PA6It
 nGGNpDZpyH+11XbhpzSVExtBVT
X-Received: by 2002:a05:6512:251f:b0:5b8:ea1d:ce0f with SMTP id
 2adb3069b0e04-5b8ea1dcfebmr1597289e87.67.1790433170155; Sat, 26 Sep 2026
 07:32:50 -0700 (PDT)
MIME-Version: 1.0
From: krishnanand G <krishnanandgeetheswaran@gmail.com>
Date: Sat, 26 Sep 2026 20:02:38 +0530
X-Gm-Features: AclHuK-CL75w8EKdw7F584-DPLQiFrVOcdh4rVjeBan5-ZoM4N5k6KSj03DryME
Message-ID: <CAG_41B+424_C5FA0PX9g1pDEPz2WX8JSeFhTWFpJ2TWgWLQjBw@mail.gmail.com>
Subject: [PATCH] staging: fbtft: fix spacing in macro calls
To: andy@kernel.org
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: multipart/alternative; boundary="00000000000019ee1f065c63b576"
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

--00000000000019ee1f065c63b576
Content-Type: text/plain; charset="UTF-8"

The two calls to define_fbtft_write_reg() that use the default
modifier have a space before the closing parenthesis. This triggers
two checkpatch.pl errors.

Add an inline comment for the intentionally empty modifier argument.
It satisfies the spacing check without changing the macro expansion.

Tests: scripts/checkpatch.pl --no-tree -f --terse --strict
  drivers/staging/fbtft/fbtft-bus.c

A full kernel build was not run because the sparse checkout does not
include the architecture makefiles.

Signed-off-by: Krishnanand G <
118352827+Krishnanand-G@users.noreply.github.com>

--00000000000019ee1f065c63b576
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">The two calls to define_fbtft_write_reg()=
 that use the default<br>modifier have a space before the closing parenthes=
is. This triggers<br>two <a href=3D"http://checkpatch.pl" target=3D"_blank"=
>checkpatch.pl</a> errors.<br><br>Add an inline comment for the intentional=
ly empty modifier argument.<br>It satisfies the spacing check without chang=
ing the macro expansion.<br><br>Tests: scripts/<a href=3D"http://checkpatch=
.pl" target=3D"_blank">checkpatch.pl</a> --no-tree -f --terse --strict<br>=
=C2=A0 drivers/staging/fbtft/fbtft-bus.c<br><br>A full kernel build was not=
 run because the sparse checkout does not<br>include the architecture makef=
iles.<br><br>Signed-off-by: Krishnanand G &lt;<a href=3D"mailto:118352827%2=
BKrishnanand-G@users.noreply.github.com" target=3D"_blank">118352827+Krishn=
anand-G@users.noreply.github.com</a>&gt;<br></div>
</div>

--00000000000019ee1f065c63b576--
