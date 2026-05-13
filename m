Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04FDCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052E510EFE1;
	Wed, 13 May 2026 18:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjHwPJ+P";
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C053F10EFF3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:20:24 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-439bdbc86b1so1146336fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778696424; cv=none;
 d=google.com; s=arc-20240605;
 b=X5UNBkxvpSCgHnAu2nQtYL6xO4yiKpdngHP3PJ8Xaq26Dlo+IySuqWvbWP/b4vPC4P
 5ECaXYngXHC1S6Pl/TB8f0+YZ0JYenp29+qewKwr+VcozrNYnkiSM7fZDnMygnwB5yDG
 R3dE+lIMNiVjySjd3/sqPsa8P4Zw5yZuymE655ew026BMKrumQbgHXDuo7Kc/ujWxX4Q
 AC1zPN9uUYx/1Y9WAcw4z8YoGi4XO0m8fmub6GtYS1voPeOXpYT8ehcBjqTkMXu/28/m
 UI9ZJloQLpjnKbTuVx/FNRM76JYO10fhMzfuHJnSRNEpTmxKzPzo+iKZzkCM0ElSyYCr
 uafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mgn1boyrCqawb9REQeHaTy5vvzJZAE3auqnIWGL8hXU=;
 fh=vtJAaidduX/FQEy9XDeFjs+zN0sIefddsJC6HR1nakY=;
 b=IJSEf3BxgWxvQxHL5LEhz2cDF4UTVX07CezFGKcZ/UiR1vB9oe26jttBqY/453pJ4j
 9Mx0BYtR+tmDvPY6OA8QbN8Z2oh2k7IlknHe7ekpYpJRWMapEjwJcxgWiS3suzyHYY3v
 ssEIqeCCEc4YZjyqHe3arQVaM1tgH5z9YVm5kVI7a82txPODDIchGbih1l+IJFBLVXKz
 +irblj4ryb5qT88Q8p42RykA3F11HIjjeoZlztQkhWoCFmJAZudgxWjJEmS6PmrP5PyB
 qCZuYwcH4ydBN9ibYW2l7D+T2CnTe4NLYPsIEKk6Y7T0jMAE8uaqpRvHUcJ9kN+6ubVV
 lXpA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778696424; x=1779301224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mgn1boyrCqawb9REQeHaTy5vvzJZAE3auqnIWGL8hXU=;
 b=YjHwPJ+PaN9z07ry0Gm9Ymy7pcCNSYPV5Xr+EqUCkg74eyyLNNKTNebjPY5EiGqkE2
 bTV0wcWb2dKsM0Bva5f8C8p90E0+thHokUIwjWDN2CaflGO0saMHgyLUXfW8EB3XZHov
 E06HsUZdhg/yAriMftXEL9VRGzImz9gvFvmFYRpLkdvOM22MBuQj1yD4oqJznDWDLx49
 vOmStDFPYHouanUbPkUgsqqlKVp7SfkRuehcZH7ZTLFhL6ZZAqEXOzSa3BF0myfPyqjK
 s99PZzPhWp3bI0vrf2cjPrPXEepRbR12ir1romFemFzMD8HXSxiWLz0F+6ZsKYK8ZkIY
 VK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696424; x=1779301224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mgn1boyrCqawb9REQeHaTy5vvzJZAE3auqnIWGL8hXU=;
 b=qPVYsGweJrtbwd6Wdv2beEcEXMUlqDmjtrS0Np7SV9I23YR9NAhn+K7MBybBig5DKC
 BlK47JiJPziWG8t2hYIBP8zwwk1NX909tLgA6AxB/cbGa2RJXbwpbObSwuTrC2xlDou8
 frJSD4bhPZLuhjidsCkgQfgOP/m6VHUvzUF9ANf1jlfc3A0kciRpWKsM+6ZBN10Vbgco
 EGlBCBnQ3dqRHJSgh9ZMumE6M777pvglUqbvOXdVOVbayl2tfIOsANBsOA+ImipQUagu
 xYF1WOdbf+nnppIbt+qRmLz5q3AVU8uhUFJoKdKVQtJg6wer9JvTOQszrl8nk3NUzCrd
 QSzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gSU+LkfInu9j+MDm6IOUv+6g+oX0LJpFtE6xKAP1gtmT4tJFQ3tgrTsirR1B23kFSn8ip2S+KXPA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHWWvOrUbYIwLhChinXJ7AHybYs80HbTZP8HhElJMJpj5AYgIA
 pQFl7XSkiahey4XP1NGeFpkuR5PWGXtHa/wOJgbE0HM94iNcNCfUMH/E50odVsizJdp2XxyqMu9
 uL9rItYG4Fa+iyLhG2e6EnqJuYmYcrOM=
X-Gm-Gg: Acq92OG9oR9JtgQ0M1+d1Z8DkmSQxsjUc8LMZboeDplyM3xIx7DfrGLQqoDkSGUvmuV
 yyHTnXkxTMJlhT4ESgx7BgrxCOnzcNaShDJrN71sQLLzzqNIv3DCo21nwSgg4/hxN2T1+8g7KP/
 dFJTWFeLSxVg6a424p8bTM+Ov3BT2htod59IZEGtUEwmaPzkBG0tz9LXzv9BA1IrK4E+BuNeSUU
 SQsK+PUqrT2U/JOX1ls0fqex2bKKvgPo58518q2aQEHgFZiKOoqBRWAQYuoWB6vH8toTaGczxfj
 g/f0kDp3IdzmVh4WUg==
X-Received: by 2002:a05:6870:b4a7:b0:423:9751:c1c5 with SMTP id
 586e51a60fabf-439f959b6efmr358496fac.22.1778696423863; Wed, 13 May 2026
 11:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260508144446.59722-1-johan@kernel.org>
In-Reply-To: <20260508144446.59722-1-johan@kernel.org>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Wed, 13 May 2026 20:20:13 +0200
X-Gm-Features: AVHnY4L08ILfePm41aLnEnfOy5yj8ETQWQZWTnPKXsSh-yHW8XDofX4xS-1aYUw
Message-ID: <CAMeQTsYVgUDPf5nYyBxHfZJXWMerOFPoStspSgQfdL6aDv--HA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/gma500: fix i2c adapter hang and leaks
To: Johan Hovold <johan@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, May 8, 2026 at 4:46=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> I stumbled over these when looking into i2c lifetime issues.
>
> Note that the allocated adapter (or looked up reference) appears to be
> leaking on successful LVDS init as well. Not sure if it matters.

Hi Johan,

Feel free to fix the leaking adapter if you have the time. Otherwise
I'll put it on my todo-list.

All fixes look good to me. Applied to drm-misc-fixes.

Thanks
Patrik

>
> Johan
>
>
> Johan Hovold (3):
>   drm/gma500/oaktrail_hdmi: fix i2c adapter leak on setup
>   drm/gma500/oaktrail_lvds: fix hang on init failure
>   drm/gma500/oaktrail_lvds: fix i2c adapter leaks on init
>
>  drivers/gpu/drm/gma500/oaktrail_hdmi.c | 1 +
>  drivers/gpu/drm/gma500/oaktrail_lvds.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> --
> 2.53.0
>
