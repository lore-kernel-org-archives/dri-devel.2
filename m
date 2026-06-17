Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1B8CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F84689304;
	Wed, 17 Jun 2026 10:05:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhBTZB1+";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B8E89304
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:05:01 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-9158fbaa4bbso635350485a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690700; cv=none;
 d=google.com; s=arc-20240605;
 b=EY4JnEcdIxdSPiJewTg67jvKc6M6+ssLsIxpAfaPe+JF0Sj1LamHLdCGq9kP0GRNc2
 73LCLU3kal3Ok2X2Y3/37lvPwBm2Mqfj+sgPRq++5yckeOFiZN20OaBb5qvd2yiH/nDl
 g5I+USO0nbzkwuGC60Nd0ZZhLFNZmm1QBvmE2ZoNnMPDiR1YDwDcvIXktpXaT2rjfySy
 121q/NaHDpnJwimSlC/hi0tJ34JEgu2TFpvI+sWgzKjBjyQqxrclw/nOIq905ZKy3CKL
 P5sscWhNGtyFkHviacWdVAp+oUncjxROUSUpIwMJYu2rvP7I2gs220qz6sXBy4I3Nz17
 k/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qSyY8K0IR4Y+Gsz0shZFstWIZJxq9UJAKUi6SU2oTjI=;
 fh=/IY5ffb5aVd54xHBPrtI8rvXKdkhCbdi9YaOqMiXa7U=;
 b=SyKOSKlqwK/V4qukL/D7ZaASX1qZ+F7MvDqeXqQs5D4RRHxjSRu5ksbNFxR5MD4O8I
 EQHzgWshtLCD2A0XWPkDuHXZ5j/qoAWVDBCGcqsrL+RUfwjPd+roB3XOOk3JVaJ+5foi
 U79JwJphbC4TKH1fv68X3kHusl2AXzrmLRl5D5tfryMImJyQVrbyLoGupGgo166Ifnf/
 ra1qUaZNrxddydCwiE2peKJDErid9gLdMal5LgtEg7VYuyVrNpOsOslEKzv1f0f9+mTU
 wzSb5sny+Enu3luuoy8ZN9rpbnQfUJRdHoiaNcoHuZFvKRi2Hq3zbN6afWfGpSHNPIVz
 e6NA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690700; x=1782295500; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qSyY8K0IR4Y+Gsz0shZFstWIZJxq9UJAKUi6SU2oTjI=;
 b=lhBTZB1+I1Nlb7yY6cs1s4PpHTbN5kLYruF1800w2YsyIPPOzThbVaSWA8ERMlimE9
 ZPRMIjTZYlEj0EvLUh0MAtls8+0Odvx2G5kYrd7em7k0D74X1BVH9keHcp2cGGJZd97+
 Ta4isfCNNZOo0ARQNmgCT/s5D21Jhpc/1zC3l+mMfgLBMOd0QyMZYtv5e1oq3l8tBN7F
 y8FOKMTcCavnDB/g6aXc/cFGwVn+Zqhm0uo/UY7uAQACVgkgRO5heyCkXWQ3m3+xFPui
 aNyI3y1JlrFz+VJ8GwIBWrvLe5lT6uYLEC2WH2wnTWipEJG6qyNiUxuCrLPYCTkOUH85
 JHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690700; x=1782295500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSyY8K0IR4Y+Gsz0shZFstWIZJxq9UJAKUi6SU2oTjI=;
 b=F2p4mY8QkzFV6kK+6dTJA4eBEY0oMVX01F573WTnokdby2SV95E3LIYT+9uOuhWYPN
 frkdr5Ig5y8CUdxTB4Y8xeQlQ3FVDPtTSG5f9M/+yqyLXYOkUepcZVMMp3EzQXon6BbS
 LHUUgb6YLToyHG0lKXffCzQnjvR9z4L8ov76DiixqJjMT2q0Xn5qGKnRPihdR2Vfry+Y
 clpxl61tLQxgtU4cHfOIgQCfGJq4KsPhYx0xGk/ENVTM63DFXx+0gjRYDPUNifSSLX7h
 jH1oTiki/gmVoRSh+lCDQFAQqEAlzjlb/II2/QDktrDjGGcvLcD9nErEhN0nGKHp5wLP
 saFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G0LCAWrx5BeNcd9WeQ3HPRrhMW7rKOfpwnMcCZAVhO1Plz9PJ2Y09mgzDLKQ67dyVoW1X/fBuqEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBNGIqu8YadRMwtxfyhspgYTs28LObChv8N8Fmkk4fmuwrGpxE
 CsLsfCVX8wIv2y11SX8SAjizJICSsRCpbn42gCHopfadNnc1i0ymgbsXEC822Trlq2mwLire3Lx
 w3gouOYY1Iv1K8kpUJKBaNR95mdPIpyQ=
X-Gm-Gg: Acq92OEMFvYSTfKz2+HlHEyLWtWgEULfj2e37IlCDb6ZuRyrAED1T1G2qqVT9H6CivK
 0ct+sWL9GYGGrMqEehBiqGPo38FiaskSG465APbGLV8jzlEoAgQtlb4N3IN97a6kpFoaeRQJjQB
 ejBnr0Os925OwaYP86P2A2RFgA9Palgz80mZePsZxGiWfclG21jKjTRNm7stxCwJz1RIRn7+e5Z
 TK8sa3LlGW/yk41W8fhGXqHxjwAHNDmlvI/UJlJd9xAv2OaZY3+nq8MLbB5ScF6DaQFUkQnGkRb
 UfLvqhRolzcHJJ81C8vMgs4Xy69TJTF9B+jfDevSeklb97p8CATbBMsXtQ==
X-Received: by 2002:a05:620a:6488:b0:915:89d4:df18 with SMTP id
 af79cd13be357-91d8b4bd8admr499751285a.41.1781690700284; Wed, 17 Jun 2026
 03:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyvcK=48vPeSB-DH8yd9=eZi-77kWgJSAP54d+kJWx6Jw@mail.gmail.com>
 <CAHk-=wizdcwDYToe1d2niV3Qzq+K_zkyN0tn3n+=EqEt3xtvOg@mail.gmail.com>
In-Reply-To: <CAHk-=wizdcwDYToe1d2niV3Qzq+K_zkyN0tn3n+=EqEt3xtvOg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 17 Jun 2026 20:04:48 +1000
X-Gm-Features: AVVi8Ce61kndnORy0c2dPm4MzotIAzRrKsrvtRoboUU2NyhBbrOImUgd8PAuapc
Message-ID: <CAPM=9tzUCOf9PriQ1Wy6+m+xkO3QvsqcCo=vg84oDKphSCRoPw@mail.gmail.com>
Subject: Re: [git pull] drm for 7.2-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 17 Jun 2026 at 19:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 17 Jun 2026 at 07:19, Dave Airlie <airlied@gmail.com> wrote:
> >
> > None of them were too confusing, but the panfrost one isn't that
> > straightforward and amdgpu ones are a bit tricky.
>
> I think yours is wrong. You don't do that
>
>         op_ctx->rsvd_page_tables.count = pt_count;

Yes I think that is missing in mine, good catch.

>
> that I think you should do..
>
> Other than that my resolution seems identical (modulo some trivial
> whitespace around the same area)
>
> > The commit list looks fine but the diffstat looks wonky for some reason.
>
> Yeah, that's garbage. Did you do it after the merge or before? If
> before, it must have picked some completely wrong merge base.

I did it from a completely different tree where I have drm-next and
origin/master not sure where it picked the base from there, it has no
insight into my merge tree at all.

Dave.
