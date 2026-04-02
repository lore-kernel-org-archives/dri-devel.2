Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FEDD6AAF9
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF9110E0AA;
	Thu,  2 Apr 2026 19:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fMy1ujUm";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6914010E0AA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 19:02:04 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-66c05fb27e4so2261383a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1775156522; x=1775761322;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePUNrbdwnW/6ontZGK8TOL9te6Vsn2aDppf76uZ2K98=;
 b=fMy1ujUmAxKUbd+GOeKo3Zq1robK8rVtiIAKXLk0VCJZ9w9rZg7CQ/oOLkq6uLpcOz
 q0GyGU0q/ORdTHtbaoyqubQFPtrsRLnkNeE8ot3MmRnO9WI8ImyfQ+7jm0eLkq2MzoPV
 /wf/mnJ7yheuL2MhG4kvp2if2ZZs1YQ/TDY9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775156522; x=1775761322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePUNrbdwnW/6ontZGK8TOL9te6Vsn2aDppf76uZ2K98=;
 b=ro8x3wqP/k8w3C1x4DBIUQV7FWy+xByGqZyBibMxly11zS8SkwOeeqnCZRUNx8oo4y
 yvveoq2KP3mBVl/4+2CzGTL2nEwNkHtXKJEcSr0fg1O5VXhwW8bq0jIyq7qyA7jvdr+g
 AP8Pms7OQyGrx+HJK/8QKZHkVElUy/pTamFguRmjEg5os/ZvoQic19CWfO9tUlIo6q6e
 pZYKX/Z5CzUekDx5BV2+ZJKKaFECAnONc1CTXwLLhN/CZFHeQhPWooozm6xr98JUr/UT
 KMyqoc2VISDc6JKe+Wr7OJ7M5LYZ7U2oVqkbPvi4hJdP3Yl4ay0xSq9L+39J77eNVArX
 w4mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbvZrS1gVQqbnKLj13V1rj/qcqjfLwpzwNKwOfK3qBjYmH8F2KfljZhPemn18BookZw7S+UQGaL/Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7j51Af9hjiI9WgofoFsks3ZxjRgA2BFU43oUYJhaCui+dUIgw
 6r7oe8i7rwxvGZjA9O2/Jgc0fTPj69SkyJs+XF6P8qfGBK4eAFw5kdyUrCNBY8fgWJrnvxSTfbE
 SRlhW3TI=
X-Gm-Gg: AeBDievH6o2JpOCfLvdWnG0vuGMAVqT2pKyoCFbqG+IIN9WqzTew7mTMhpdsCCC05Rt
 7/xEtKwnHWX3OlVVm7c+tOmLZ++B2c6QAhQQ7mHPGtfR+9knvgKG5Lg0sc5kRtZRg8HFEwiJ7px
 6HeN2d/tN0dVyollphITaoIXPX1ACiLYanHDZbhGLh9QITym4vAPn62TrGRVHGGacY+HGMNFyaS
 LGbldvOZOHiXXDQLv3dA31a+fBYM/0UFMyINlXR1vh9SAuJ69HAdeXOhAAhd2euaFTOJwe3qcXA
 7xO1Zj/wD5GzOpFKl9hnQl+A6jm1FEhOlSk35vhDx6rAnSca9CHh9uEf/JrqM3XOWRSIfWwAthh
 TqB7Nb2f9qhH6Zj1qA/AyDc7xFb4BOtzgFlxaP/cF8fM9Rq/genbc1GtIXoBvaidmQtMf0njKqT
 B26BS5OuHQZWiao2IUTutb9cQsTzlG389qFIawPAZhp4P0DBQAXxY34Gw2aftapfPA+l1ePPQh
X-Received: by 2002:a05:6402:2547:b0:65f:71ed:7ab9 with SMTP id
 4fb4d7f45d1cf-66e3f708baemr87475a12.22.1775156522204; 
 Thu, 02 Apr 2026 12:02:02 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e06479211sm912177a12.0.2026.04.02.12.02.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 12:02:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-66e36d12a00so613133a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 12:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXvBHYINqgCUotRfSBvVlGetdRiNFcFr8Ag0llrLX3Ra/xRQ31SlbN6lo7UiXVEjMtoxobOKmIjHYg=@lists.freedesktop.org
X-Received: by 2002:a05:6402:5d3:b0:66d:f536:a63d with SMTP id
 4fb4d7f45d1cf-66e3f3bf8e4mr130709a12.4.1775156521322; Thu, 02 Apr 2026
 12:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
 <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
In-Reply-To: <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2026 12:01:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
X-Gm-Features: AQROBzAMZbuTN23P8TkIKiMVHa1tHl57TLivKQV-jC6Njhuyf6GRrqJ_sBY0N3w
Message-ID: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
Subject: Re: Regression fix for audio issues with pre-DCN401 chips (was: Re:
 [pull] amdgpu, amdkfd drm-next-7.1)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona.vetter@ffwll.ch, 
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org
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

On Thu, 2 Apr 2026 at 11:27, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> There are always new fixes.  Worse case it ends up in 7.0.1.  If it
> causes other regressions, then we end up introducing a new regression
> in rc7.

This was a regression in rc1, that was reported several weeks ago.
Anything that gets reported that early in the release cycle is bound
to hit lots of people, because the number of people testing early rc
kernels is relatively small.

So why pointlessly delay *known* regressions for fear of a potential new one?

And why point out rc7, when dammit, this could have been fixed long
before and *not* be that late in the release?

The bug was reported a month ago. The patch was posted  ten days ago.

It could have been in rc6 and gotten a bit more testing, but was
delayed for unknown reasons, and now the argument is that we should
avoid the testing in rc7 and just put it in a stable release instead?

What's the advantage of releasing 7.0 with a known problem, and delay
any potential reports of whatever new regressions in 7.0.1 instead?

What is the logic here? Really?

As you say, there are always new fixes. But how exactly does that
change anything?

The fact that there will be new fixes just means that delaying known
fixes will only result in all those fixes just piling up.

Or worse yet, all those known *problems* piling up, where known
problems may then end up hiding even more problems that people don't
even see because they hit the first issue.

So what is the point? Why are things delayed?

The whole reason we have rc release candidates is (a) finding bugs and
(b) GETTING THEM FIXED BEFORE THE ACTUAL RELEASE.

What did you think a "release candidate" was all about if that's not
your reading of the issue?

And if fixes look too scary or uncertain, we *revert* the change that
caused a regression. We don't go "fixing it is too scary".

And yes, we have more timely releases than pretty much any other
software project has, and that is partly exactly so that things don't
build up over time.

We don't want new features to build up over time - long long ago we
had long release cycles that then dragged out even *more* because
there just was too many changes and they all had issues that needed
fixing.

But we also don't want the known problems to build up over time.

One of the points of of "release early, release often" is to find bugs
quickly - and then *fix* them quickly so that we can leave the issue
behind instead of letting it fester and cause longer-term issues.

This "drag your feet because there will always be other fixes" makes
absolutely no sense to me, and it's not how we work.

So  honestly, there are exactly two choices: apply the fix, or just
revert the commit that caused the problem in the first place.

Because no, "let's just have a known regression" is not how we roll.

            Linus
