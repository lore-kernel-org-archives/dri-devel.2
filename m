Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0F3C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 983A710E227;
	Tue, 15 Sep 2026 16:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zqf9mNGe";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0EA10E227
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:02:52 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c293c683202so502098066b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1789488171; x=1790092971;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
 b=Zqf9mNGesb+00OvNp9YToumcgRHbx1sI3XB2FEag9MNZa/LJW4xO51Yiwt58oTqkP/
 EpNs3SRChpOyfMisiwNqf3eaIFmzcd4LPKMq2T2HgYGHjNsvP01UkEBtuLdii5l8HBLu
 nvJbLsGCA8zBhTqN86zr+nK0XFgkh2x5v5xbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488171; x=1790092971;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
 b=sUdcS0WsaZHAkP+Oko/NuREwWiiFZ/Jf0MNOMRDXL7+IMx+ifM92GWcIW5Jrt5R8fh
 THwTwzlSFPplMnUI+kitsZURtaaCfXK/XdEzQ2UWWmw3bdAVgubFOzb3V48o3ptylFC8
 dyt45s7zrntLdPA6PHFfmxKFOyiKe8kWkGwu4irz3ZVCSLg04b4V/ZTu1ZrLyAk7RU+3
 G4+s7NE2Lg5dvFXEoF/K5q0iY8aRyTHdZzW1Welzm1iQDs5syHtZYclAZZlA/gOVYbbn
 KbthkBJQk3xCFtaRPH3PvQWG8DhVYMyuVpuQYIjySeQ/yNWznoRtVWS/4cZHe+zsw9hV
 N+3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy/GQZKGI3bWYbLrgPUAso7Ee6n/hdXhJ0h6Dcujn4vD41CzgEdGI67t1zoHdbKrva5tiBdlNoum4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMFVoWL4yBUkb0iZpURGaDN6/eQwAa3kjjnBfGL/4RfD6YHV3c
 r5lnkz4tK1Cyd/Tu8c5/wEE5wNkGm5VHDey935K9O/CdqvTefgZkUsz5w3sSGNX3OCv/zblJDqy
 HLzA/JNc=
X-Gm-Gg: AYBFou1CR6/1l+kR/SXaIklxbWPrutXsp2IEb/c3YFNOU9/3TA6faDB7VE1KnSKWPlr
 KKHwVs3WA2TaDWhsrEh8+nHr1z6yrzdp2E9DjB6JRLHRKQTEjDtpUMs5FeY12QHcAwN4vEdcCgG
 f9EWoRBhKQWUWZrlPcr+nFSEjQ14OQekT79Q15JSQOaD1N1yIwjn6NEYH0K3HChF8bzMdLzCPjR
 E5LBS8Jb77/6fK7W5pDmRSHvV2rbT0D6KG0Zn7CxV72pZgTLqdZ6/WqXcnZa2Zv5eR1rPAlaD0U
 mhcslYXe2YcTZCjNImC+TbcumGQVEcgX1qTi+qfh3TAqBZALfuVMPu4VHX5/9069M6lPzlA0E5g
 VTwwjV09V5RqfcXVO6NScterLZ8WE0+UmWSE8E771q1adrrCXl9WOJpYk+SchEqHO8SLTQJkuUG
 KyKrC199WRbX1KT/ncLghHJrGfxIbwQsUMYmKAqJKE2OGa/zGQZCryQKeMDGZA4FaZs1qMQW4Lq
 E+JPy6p4nlPRdsbWYZjkDrWpdkHD+C+19rJtmSWpFTkeCM7Y1I=
X-Received: by 2002:a17:907:a88d:b0:c26:2c3d:67aa with SMTP id
 a640c23a62f3a-c29b8762c09mr507573466b.47.1789488170587; 
 Tue, 15 Sep 2026 09:02:50 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com.
 [74.125.228.140]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de454b88sm1016366b.20.2026.09.15.09.02.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 09:02:49 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2953a01240so573092166b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:02:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzaYpVFFV3eSqM0h02qtQZ0FP0TW+ttL8GVhDcFP8JVvijFvniDmwHlLidB2g3oNLl68R11mp4TZyQ=@lists.freedesktop.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>,
 Jan Kara <jack@suse.cz>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
 David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
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

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
