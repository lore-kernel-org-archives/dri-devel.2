Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DD9D6AAF8
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3880410E047;
	Thu,  2 Apr 2026 19:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="niJI/PvC";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803AE10F297
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 19:34:45 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12a70b4de9bso66412c88.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 12:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158485; cv=none;
 d=google.com; s=arc-20240605;
 b=DBBkfXmoQA1oY2/CPf3mnI5ekBgEkjZs2ndoRKbjyDvVqbrhR0yuCXgASQODUIHq0I
 o9aVdaJkc056hXx351kPWzIOrG0WEip6+OeJYNEy9klckg9ePEmZlZyn/qna/fDcusC+
 CIxsuyH+CzucmlSHHSl+nPDWdIHS+9wqT+OFssX6fmNsrIGAIhwIMa0mo8jGB7M+hVjw
 I3AxAjrshKcUhlQIYP6icbrYNnDwKnLq9ldUW26GVlDGwY+DuZ05y6BghkGI+wAVJvQn
 MTliyzQpSlUEbHt7iAGMrkhdAu95qa+Aw9E3iz8e5CKpX8PDqTORdCwTWgTG5M2wEuTh
 RiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z6paV10TjiBBQpUTwHKDd5p6LgrjhSvi+dQvAUrRBGg=;
 fh=Psrhke5aJqxgoAkUW4cSWOhJVI9soQZtjUrR3FtKh90=;
 b=QGseU/FF4qwTHCzQYyBijbnIo0n2HmPFcZkGzc0TWG2oeEo+YsNUk0juQkuGn63eNg
 yLtXb4cJ5HlwE8r+5oSuZd8SnjrACH0uPxWTBjcXkkY/7R8/S35Phn/YAw92P5nzLCES
 CN7AELVBLTTkwkdHBpamVSNd4KnZnvGcRb2kPbN6LKVxssUR8G3FY/9QFxypXsvwQkYn
 2hR+g41atfTI4phBP+KbX/8HEItl5ZqFdNYJ3gF1XeKkGCSgUUiPNM/pzuLm5XJn6Ty7
 ysHUKRI1d9OUgREpOFZUMpNjSghRnDjgxi5Zs+tupVMkSMZINA8vrJjcAOmu3ZZAQysL
 XqtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775158485; x=1775763285; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6paV10TjiBBQpUTwHKDd5p6LgrjhSvi+dQvAUrRBGg=;
 b=niJI/PvCdyMF/n8p1oOXgapxTqvdc19ChPcyDpBw/qW1FN9iVzFoc0vZ5X3X4sudww
 GW0h+aiBR4dfvBbN9RKknJ2e24DTAfMrRXmwx3k5HbAjBnrzu1vHGPV3Z/Kxd7buC6ds
 gTCP2OdaSLmMN8BS2x3aVJD7tTr0uU+Y9jrydqnU22jEHvq3N/dkIdTMkKiVYNMwtE27
 6+TsjrbyaY8MnANSQjbAtohTFh9d47YJF/0UEBRPlPQ86/aiXHI32WENdsboCH5gWS+p
 5DmvYiU0H8HTs1rGlt6vIFs/50i6iGn5a+J1zAjhPhgrXbL6jHB7h3ekHldJ2Ok+LdIP
 y9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775158485; x=1775763285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z6paV10TjiBBQpUTwHKDd5p6LgrjhSvi+dQvAUrRBGg=;
 b=CycBO4cityTp34V38TtOLzhSE3/KUQrk6X3MaSVC1cgdumZvLafOaWdo3+SNj/nKW0
 okbIP+Cz9YtSLGPM6yghUdUlAPdanHxmnSV57HsNk8CWE5lX0hCxaFM6Se3GarwAcEtD
 coQlVLnG+78Ke2YJIbdtxsLi8u+3CeaxEtNaXVNPCLawAOJm4D9+yH6bAnV5VP5GsDFi
 peFXtDK86WqduySWUKmjGCArHe+lH9mYLlf7v48+WRFUzeBs+cpkRqnyufAqbF5Iuezz
 nPJ41GMAVgVVxlERyKZIgtkdnCELtS95scxBKgsZoZCUpoqPTQE6IX6DXRDIBQMBshk/
 pjkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF++LcKn4GuxTjMh3LFF2zxg2kPvBzXkegHVG4MLJYaPEL2ZaHa1zVFjDg15QkeF2a4B1YgYQR+7c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzjXsthmEvEp5bG6dDvfmM14RtjqJNDAqUAX1vrdgR8hqrBbD9
 Iwhtaxqom/wat4fzM6cQSRhgN567uPkyIccc6/76uTr7zKq3HUw8959/eyAkcoblTqyN5NlGKa4
 TFGQD4WzrzKEAhkcVGIoMNL7SHfBG40M=
X-Gm-Gg: ATEYQzwcnzSPvj8EK6qgminpbgsSiCyEsTH6WzfK54MtT35TJ8+PHW3cV+9n6+22m1j
 fNdMBxkrbs5zGlCUjUMmVcXeEWyf52PqCpi/9k99VhzQBeqp/U29CcCkfgs9bQcb0aJzaTq7vOK
 O2wvUiB69MhqmniWEhrbdj6PP4JkYlsqz6OWcmtM7AOnAKebwSUXt2ZshWyPhmTCWZNxYdY+gvI
 0nokcQ99aog1DQSLAyzcb66oLzJLnFvnP8+kPkNynWyX7iiEeesqOfGe6N3P+A/ePwbHWgFKh0X
 kQGG09PJChQmrMRioOJJJlmJT+bRR5tfHirpM1a2WqkCAFiYG3XJfBWqQ4lE3pfS+eBmHw==
X-Received: by 2002:a05:7022:4396:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-12bfb6f27dcmr67982c88.1.1775158484591; Thu, 02 Apr 2026
 12:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
 <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
 <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
In-Reply-To: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Apr 2026 15:34:31 -0400
X-Gm-Features: AQROBzDmFsLYBUfG_KyTv2yWvRF9jyysl3p7CylmtFmeiPAhvDxo-SPdx5QhP6o
Message-ID: <CADnq5_Ns+NEm3eNJjs+7HG8qBnX8OX6TMsj444B4xFW7=z7P8A@mail.gmail.com>
Subject: Re: Regression fix for audio issues with pre-DCN401 chips (was: Re:
 [pull] amdgpu, amdkfd drm-next-7.1)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona.vetter@ffwll.ch, 
 Linux kernel regressions list <regressions@lists.linux.dev>,
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

On Thu, Apr 2, 2026 at 3:02=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 2 Apr 2026 at 11:27, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > There are always new fixes.  Worse case it ends up in 7.0.1.  If it
> > causes other regressions, then we end up introducing a new regression
> > in rc7.
>
> This was a regression in rc1, that was reported several weeks ago.
> Anything that gets reported that early in the release cycle is bound
> to hit lots of people, because the number of people testing early rc
> kernels is relatively small.
>
> So why pointlessly delay *known* regressions for fear of a potential new =
one?
>
> And why point out rc7, when dammit, this could have been fixed long
> before and *not* be that late in the release?
>
> The bug was reported a month ago. The patch was posted  ten days ago.
>
> It could have been in rc6 and gotten a bit more testing, but was
> delayed for unknown reasons, and now the argument is that we should
> avoid the testing in rc7 and just put it in a stable release instead?
>
> What's the advantage of releasing 7.0 with a known problem, and delay
> any potential reports of whatever new regressions in 7.0.1 instead?
>
> What is the logic here? Really?
>
> As you say, there are always new fixes. But how exactly does that
> change anything?
>
> The fact that there will be new fixes just means that delaying known
> fixes will only result in all those fixes just piling up.
>
> Or worse yet, all those known *problems* piling up, where known
> problems may then end up hiding even more problems that people don't
> even see because they hit the first issue.
>
> So what is the point? Why are things delayed?
>
> The whole reason we have rc release candidates is (a) finding bugs and
> (b) GETTING THEM FIXED BEFORE THE ACTUAL RELEASE.
>
> What did you think a "release candidate" was all about if that's not
> your reading of the issue?
>
> And if fixes look too scary or uncertain, we *revert* the change that
> caused a regression. We don't go "fixing it is too scary".
>
> And yes, we have more timely releases than pretty much any other
> software project has, and that is partly exactly so that things don't
> build up over time.
>
> We don't want new features to build up over time - long long ago we
> had long release cycles that then dragged out even *more* because
> there just was too many changes and they all had issues that needed
> fixing.
>
> But we also don't want the known problems to build up over time.
>
> One of the points of of "release early, release often" is to find bugs
> quickly - and then *fix* them quickly so that we can leave the issue
> behind instead of letting it fester and cause longer-term issues.
>
> This "drag your feet because there will always be other fixes" makes
> absolutely no sense to me, and it's not how we work.
>
> So  honestly, there are exactly two choices: apply the fix, or just
> revert the commit that caused the problem in the first place.
>
> Because no, "let's just have a known regression" is not how we roll.

My point was just that I wanted to wait for our testing cycle to
complete before I pushed the fix.  In the past I've pushed fixes near
the end of a kernel cycle without waiting for the testing to complete
which ended causing more problems than they fixed.  The testing has
completed and the patch is good.  I'll send Dave and Simona a PR
momentarily.

Alex
