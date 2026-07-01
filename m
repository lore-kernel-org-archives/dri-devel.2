Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74082C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB66C10E2CA;
	Wed,  1 Jul 2026 01:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AF1cwD8O";
	dkim-atps=neutral
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com
 [209.85.161.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B5C10E2CA
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 01:16:46 +0000 (UTC)
Received: by mail-oo1-f43.google.com with SMTP id
 006d021491bc7-69e9b037d82so102766eaf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 18:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782868605; cv=none;
 d=google.com; s=arc-20260327;
 b=ZfdkFyRK6J0xuF1e9Raee0c8pxL2NDsLEhETxHRLgJndYvH4FIvpGSFXh37JvxajpI
 AQph2Ggen4/Q1m6Jyt5csE67+DJMw4fdnKs8E8NMf4ymNUdTQKxw5h0l+Fejf9FDs9ql
 YJA4tOLmhZkMPMoGpMyhoUk1sZ6idg1/IUuOR+M482JEnicmd6vKgUopjISe6sb4vplX
 0YY9fREQ6LIdVtq7mEmO/iCvVYHC1lpW5PMuYnC0IYQiS4unkndTtjEVQG3TGYQ6v8WI
 LzORm7knmy8a5MPfpCrv2zSdWu5I2yw2TBNiFYoe/3lsIqd+9bQLKC/4wl9kcJtybBsq
 yDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JCAHsvWeryAOa0Vnzt9FOFM8CAiOiK/er9PdNLtoWJY=;
 fh=TcxjOKydRUw6oup4PLrEZdNc1tDqnD7LCYvd1JM/UAI=;
 b=ZlyfC7BIc+zq4hwo83PPDgN3matA+beILlZ9u/ddgpl6iXuXqn75ZIBZYgiAU3JKsx
 cMoiS417tKm17KeaIOyAxbCZxbPVrAyF00aTJriYTbcI6JCTUe6cH6pkBt5KtXlzXv4N
 3KFsp5MTZ2ctkGIvjuMNA1t3aHZWGUKDEVL8wZ6GZR3VdpJ2Xpql4p9C9oe8ZkEWXug6
 bXrEofRVXMb1vXmxPYw3LPm/awe08ABxU9QvuFgkQnpP3jPkKZ6U9z400ndGfgdUDTyJ
 wRiC1xHXFpZF7iB/pVGFsevHFxBlihjS8LwQPq9URdEG47lu3ROY3P9iMCLPihZeujKB
 69Cw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782868605; x=1783473405;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCAHsvWeryAOa0Vnzt9FOFM8CAiOiK/er9PdNLtoWJY=;
 b=AF1cwD8Ob4qjP4PzvZ8R8VJP8PGQC7sbReXVgxRmI/BJ3DmEYJhv8wBaC71P2zdxKX
 HplrwjqB/TdLMDToBjegHRSM9Yv4nk8wPiyrPx7YViWIhAQ0Q0nTjNookhXGpU8Y+pPt
 P/AMorV1Nw56mQa52Ln6U44Mrs+hxhcqji0DU7dcgcgvQVCNLB7FA7uY15jeBt5GaYLj
 vuHNIdsMAuMvEl2vdIxMK6yDv6iqg9aiEUbWvNtIX5mruPCkNTIp4SThQUhiBr8hMJzr
 H3kBswfrkff7frmH8rQFlFtV0Ai3Rz21291kGrLT893DbsueEHw2aH+7z40Ff2oTnpRz
 IsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782868605; x=1783473405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JCAHsvWeryAOa0Vnzt9FOFM8CAiOiK/er9PdNLtoWJY=;
 b=WilEew5wO0BfOTEb88uWXT30bb5Q3pG2Qx5yCTSWpurxlsOYqrHZ69i/xC6MdWAb7a
 Me5vpd2HgrO6YaJ/F55R1qh20kNIpsLTNcAgm9Sq1/u1OXYhl/viC9mcK8lOiPdkC6G0
 Qu6Ef3OcuNYg03hyOzi9sk2he7WxSRTcmwZivDA4KHmQ90gmcXKWwFTN25N+EnPml3LC
 Kc8PLu1cLhFI0PtdAkix/ld1b7Qu2d7b6waTxuWkbhARE0SCzme7iZKy7zLgS3zG/kPo
 thYS7ud00a+OiP3zhpKsvXuPn9v9ybV7nTBv2c0EvDyeImYCyjjcx1LLv8EyAsEiE9jn
 MAXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GkNh8ULLt0CRxrWt9PSP23KGziUtFdPT/gCTjxQrJjrmbqLXgZje6w943IKFzxCQU3QC4UWSvwXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa5JL4lnP33jvvVMzDuIYHX0ko2ossMuqO8MOg1ddFYQbsmT2b
 Vtzf3yaDjDHLi1boW4lkrV4FKi7+WdZGgyjGwHhopxUs8m6Et2UCd+VYbLHVuwIQdm+AXq1xMtr
 9CRqCyb3e0A/Yans09Op4ivpHyIPI2OkLUjrMVVX8sA==
X-Gm-Gg: AfdE7clGLt7tRG5lhdqLm9nNHLwSOjuQdqD/ZlLKA9jmsDGN3mIoDTrIMF09NP/go9b
 FGCeyRQcEeuG4QSQnsmOULVeBr6YyjHpYi0Zc+Cj+DZJVm9iSgItd/EYIJOZfa5V9hDj5TrAeFc
 DOC+sDxnhPwU+K8ZkL7UONK5sA6GZXQpTdZye/u/X3EUNan7lRKMioS7IxUnJpMLWe4YQYO/mkj
 HiG5K5UBgnXooTdLDSOkWtq4Sbe7y0E6QTAjNTdvQlLou//YHhm248jjMgy0J5gHkrXgWJY+A==
X-Received: by 2002:a05:6820:559b:b0:69e:3d6d:375b with SMTP id
 006d021491bc7-6a1890c3320mr3007486eaf.27.1782868605594; Tue, 30 Jun 2026
 18:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
From: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Date: Wed, 1 Jul 2026 09:16:34 +0800
X-Gm-Features: AVVi8CeyTEH3SdMZBGENUQjyl6rye6EcA13QIf-38WH8-KOxtU4l030l3i1klMk
Message-ID: <CAKDRTegZxEsE36qpebdg0hAFek0NN1py1aLt4SWPVD8S7S-nbw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
To: Doug Anderson <dianders@chromium.org>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

Hi Doug, thank you very much for your reply,

On Wed, Jul 1, 2026 at 1:33=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Sun, Jun 28, 2026 at 8:09=E2=80=AFPM Haikun Zhou
> <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> >
> > Due to panel characteristics, when the panel wakes up from the S3, the
> > main link data is not yet ready when the backlight turns on, causing
> > a garbage appearance on the screen. Delaying the backlight by 1000ms
> > can avoid this issue.
> >
> > Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
>
> This really doesn't feel right; it seems like a hack papering over a
> problem whose root cause hasn't been found. If nothing else, what does
> "S3" have to do with anything? The panel isn't left powered on during
> S3, right? So, as far as the panel is concerned, S3 should be the same
> as S5. Why would you see this noise only coming out of S3?
>
> -Doug

Yes, this screen issue isn't limited to the S3; the backlight turning
on first and then
displaying garbage isn't limited to this issue. On Chromebooks, the
same phenomenon occurs
when the backlight is completely turned off and then back on.
Measurements with EE revealed
that when the backlight is on, the main link data is already being
transmitted but is still unstable.
Turning on the backlight at this time causes the screen to display garbage.
We had to add sufficient backlight delay to fix this issue, and while
we could modify it in the DTS
settings, since this is a screen-related problem, we wanted to fix it
from the driver.
