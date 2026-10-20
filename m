Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E8606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=BfAVtqaq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9634910E08A;
	Tue, 20 Oct 2026 21:10:38 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1951A10E08A
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 21:10:33 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c2a4e013a44so503490266b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792530631; x=1793135431;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8u8VU+962WndPKMDAHe6mqFpSZn6rgF+uoU28f5/v/U=;
 b=BfAVtqaqyAZRpKPsBUQmAEzpaqLIpcVtCS6husHUmnqUjuQLrcj+x+SUn8MY3oZ9mc
 m1wjPRHpTOczpYQGLueewwFaYb/wj1ogh4cai2nUy4XPZdLz7mKuNx+qtCzJcez6VRVD
 42NLlK2KSnjUIOk4kRKybsZdQl6rPSVZOFTq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792530631; x=1793135431;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8u8VU+962WndPKMDAHe6mqFpSZn6rgF+uoU28f5/v/U=;
 b=Xs8HDTqFf8PK9N41msGzpIm/Akouj2Skr1CiK3RrSGs5hgeI5eFkUxjk/N1OZqgr4P
 X74fAO/Q8Jm2yGDHEfgnfpwbshUT1QkLPZ80AaFZlwZDfK6VxJnX3VpIMPAuNq6vpgn7
 EQrT8IBPCjwrTaS/0mM+H6kkD3oFvuEAvTjAfzJmSQhts6DnbTmwj363UWSTis/I+JoH
 u7ctr0e+N/jqvc84Jva8faHokXqm3ATQqJlusZUxZcGAuNvou/CIBF2wB0Oi+zP2nI0o
 25BpPt/Q5HyfkRZw4/xuAWsU7K2SGb2mRVKqUcdqvAP39oNRjDQoauE68nvQe79z3PNL
 +a2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByFPP19Fznk0R47j8BdfaB3oJmVOrKCCIOawmXnnSPdGwqxZRYRCrK8AZrUzxRRZjWp31xz4wRFtOk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlsitWSaX8yDqOVliohXykDQTT+ZMXBMo5rFcOTiuHMfS2qftK
 I6UOfJKp2OpK/lyyNgak1T/0QGNHHa5lE29COqkqkdyyZGa7V5PGmZkyQBM8IF7MAa9t+rwpmDV
 Iml/EkWdLlQ==
X-Gm-Gg: AYBFou3DnbaY1w0wzaq1LyxfMBTXzGVl46IN8H7lQnwXyygh9/CAGm1vV9i7EfVDpz4
 TgX1sN02wEe9mO9vkntaGEuMt7fgwSyH30Gl6DViSSoo6Qbko80ZShqWWmmT+QQkx+mZIiVl/L8
 ABt1rUzae51XXbN7YztitGXnPW2wsVEoJCshna3AvNgPscBE/4pyfH3xnENOV2aL4YpSVt9y7wi
 hGUdMzXo6TPL+hZHcGs2STQ1rK00NAoSU+he4TTeSyO44uCeQr9Lo24ZcfxjHhqamMdiW+CbXZM
 BqbsTBZpedR87wGeYZA2Uu0ZU21xKyBQVr1UmAuFqmLeP0GbtNz2O4NThamMycgcTmmS9kkmGfZ
 +gUOQF0GBN1BgZo9fciHq2hz/p3sPM+aHiyuKSlpSv7LVZqeg1qbjJfcZ46inPu6FCJFzGMJtoq
 ACHTaJdAqpB2tnPIAzGw9Z0o3+vrpSdSt8kG7z9X1fOQ4VeEg7jB+yOz/XxteFSR9Ww6V++ITN8
 kmnSgrqHYARyK8u6+RLPABXyIRa1px1MCJ2lBKkX8tIeTM=
X-Received: by 2002:a17:907:7208:b0:c2e:6a4f:a88b with SMTP id
 a640c23a62f3a-c4678ff7fe7mr30977466b.0.1792530631157; 
 Tue, 20 Oct 2026 14:10:31 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com.
 [209.85.208.44]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4678fa97f0sm13087666b.38.2026.10.20.14.10.29
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 14:10:30 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso4632627a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:10:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw3JQDyYl56Ab9zwYptvZO8ZgQp0bPUiiN+B5KLTZviZ+/L+ulJHxsg6vyRECeviXiDmq5QFWnz7D4=@lists.freedesktop.org
X-Received: by 2002:a17:907:a089:b0:c3f:7270:1093 with SMTP id
 a640c23a62f3a-c467975217fmr26146266b.26.1792530629511; Tue, 20 Oct 2026
 14:10:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
In-Reply-To: <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 11:10:10 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
X-Gm-Features: AclHuK_6KLe4MdJBM16CPxiFHqLhafyIe7uBjQxeCZuvD1ajy5NbBw09RuGahAk
Message-ID: <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
Subject: Re: Removing __get_user / __put_user for good
To: Ingo Molnar <mingo@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Borislav Petkov <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A. Dadhania" <nikunj@amd.com>, 
 intel-gfx <intel-gfx@lists.freedesktop.org>, 
 dri-devel <dri-devel@lists.freedesktop.org>,
 "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 20 Oct 2026 at 08:14, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Tue, 20 Oct 2026 at 03:19, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > ( BTW., there's a new dependency introduced by this series,
> >   if an architecture gets rid of __get_user(), then it must
> >   define arch_get_kernel_nofault(), otherwise it will gain
> >   new uses of __get_user()/__put_user() via the generic implementations
> >   of __get_kernel_nofault() and __put_kernel_nofault(). No big deal
> >   I suppose. )
>
> Yeah. It didn't actually look too bad to just remove __get_user and
> __put_user in general, but I ran out of motivation.

Bah. I'm using claude as a fancy coccinelle script, and ended up doing
the ObviouslyCorrect(tm) safe cases.

And it all really does look obviously correct, but ...

Anyway, the branch has been partially rebased to add the acked-by from
Michael, and now has a number of those "obvious" patches for alpha,
hexagon, 32-bit arm and powerpc.

I think I have - once again - run out of motivation to go further.
There are still various __get_user and __put_user calls around, but
they are starting to get rare, and I've run out of cases that look
obvious.

For example, I looked at the sparc32 signal cases, and decided
somebody else needs to do that part. It just looks too messy, and I
can't find it in myself to care. Same goes for m68k, loongarch, parisc
and mips. I just ran out of steam.

But I think this *did* get rid of the bulk of the noise elsewhere, so
now it's hopefully a case of "a motivated architecture maintainer has
a few cases to look at".

                 Linus
