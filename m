Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3473606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=HGcx9T22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B413E10E1FA;
	Wed, 21 Oct 2026 01:38:27 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3934B10E1FA
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:38:22 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so278852a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 18:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792546700; x=1793151500;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ip0ICHthJWEmUKKjzlYjjwoeVHBFduWqszKoqXMUOQo=;
 b=HGcx9T22F2zAQZjavUVA0smlcL4tow5LZv1vTo9URFz9oRjOybtgxRq0wdVhNiitQg
 azog091q09oPbDNCMBkRnN6IsexifBHylzqVPzzVcsv2yC1p1VNBvfgdeDfMezYRD4Ns
 +qvObXU5TxXmn+cMr9VVdZmQw0jc9zyJwyrVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546700; x=1793151500;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ip0ICHthJWEmUKKjzlYjjwoeVHBFduWqszKoqXMUOQo=;
 b=fQAiEjKNED+tCQi3Dgb+ysHRl/BZZPWqV1yLcmiyFlpV0IaT5fyTwswfm/3VODHsTD
 ueQ0JTbFFr/7g2efXVvkpg92OZKudlRne5Ylmebj7wW5EwGWTjgo0hQ9D5IcQfiU9jC4
 BPSGjkKntW2MXERPSGkawnhB+nhrf0j3pxYSO2jXE5SSpoTAU83xyfO3HK1am/xtegYN
 2byiDjmLp2ro62mvlN8p2t+lYGy7stkwXvWtASUIhZXq8Cj0qfX3mermz5N3Nxxs+qgt
 2FWdh7mqguyqxFAXmMlLHXfHX+Ra32hO6qqjLEtHEaclL0mlNhQEE0OvBIgaqVasQ5X8
 BGvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwj8gCvAyk6fhHZxoayy6AH7gh3bYadg/dC8iN//s/UCG/V3v+4nrWCsPM+voBwmaj/5SOMXObDSWw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKUBgSoGIL8BdYSqc2Y3L/XnX9CWDKs3q1W64LfRS0tuR967YeN
 VVSEfJ+hbuQRtRDFEW/xTWwUAog9Cd8Vxa29QddUSmXhgDOGMFH6bh5x7DsBHelo8JaeCLKbg7z
 BTgQtjynS7w==
X-Gm-Gg: AYBFou2QpjF5slg3CqpIuGhsW3HNaZg5VhIfgTniO9omSGvsybjULkUkpZXWMHqnKqk
 Qt1g9UYB3EUmMpaIvKV/C/r4PuEwWulXKxg+SF4kFDiBCqhW03y2yyMJOsZwd9qB38Uauju+JJI
 sxWl7Tp4hSxU6zqZ2LjuFYrJeCDFOEN4uFUlAs8Z2pPg/xH6SqoWuBysn84MXlV0KJstrzqMa4S
 iXThFo/kS17HulvCfVmr+ZUhguxSUY55TQi3gdL/MluqLR4ThuF2XEmzesMrejCkhUpmwlEwzeJ
 PwgkckbCVLTmJxhqdPThNcRlM4Wb5k/tz2W+MJKSLuoPlDml78n/nGrvo9HoqbDqCT39YLGM8Mg
 rt37afyUGxHFSpz2GqPbScr4A7FOG2EkwQARK/Hwp9pGo7SeNDYxSbHzbvhrbBfIySPt4fpT1g2
 i/JQm6EGKgv369MXfRYYY0+eULUj6foaIHaP4l2xDA5aEACIiCxk37jwp7gbg9zMzvmosSqbCls
 0K+vZ1zVMqYR/92XxIiFUeb+y9V36MM/kZ9ObsHHg4A19NdwQLz8ZJRUfPMf0BhqZtCHUAF2S46
 92zHEziud71jOwZM8u73/BbaxaV3
X-Received: by 2002:a05:6402:52ce:b0:6b1:ac0d:6f77 with SMTP id
 4fb4d7f45d1cf-6b408dae533mr231253a12.5.1792546700520; 
 Tue, 20 Oct 2026 18:38:20 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com.
 [209.85.218.45]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b402f2c658sm302504a12.5.2026.10.20.18.38.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:38:19 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c38ac26cc5dso16924866b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 18:38:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz5fpikcM99tlvJRpFtlNWQBTinx1hPEgOzW4zhnvss11vaQMNWBZk8v0xtbc9jnLJrzh8u4T7eSaY=@lists.freedesktop.org
X-Received: by 2002:a17:907:928b:b0:c31:8cfe:9a25 with SMTP id
 a640c23a62f3a-c467961acc8mr54992866b.9.1792546698623; Tue, 20 Oct 2026
 18:38:18 -0700 (PDT)
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
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
In-Reply-To: <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 15:38:02 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
X-Gm-Features: AclHuK8UwKWz21R3BEqGAonpc0khJIwht7PnfSJeL-qcDnlQnZnkHVx2CsaC1KU
Message-ID: <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
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

On Tue, 20 Oct 2026 at 11:10, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> And it all really does look obviously correct, but ...

I think I'm just gping to merge this. I don't love all the changes,
but I love __get_user and __put_user less.

And the one change that makes me worry most is the i915 one, and I
have at least minimally tested that one by virtue of now actually
running the code in question on my laptop that does indeed have i915
integrated graphics.

It does change semantics, but it does so in a situation where I really
do think that the old code was actively buggy and would have triggered
a lockdep splat if it hit that situation.

The i915 code also was actively wrong in its comments about this all,
with some of it going back to some stone age code with
'verify_area(VERIFY_WRITE)' that used to actually trigger page faults
on i386 in order to do early COW.

We haven't done that since the 2.5.x days, and even then we only ever
did it on 32-bit kernels and only if CONFIG_X86_WP_WORKS_OK wasn't
enabled.

Put another way: I'm not claiming my patches are perfect, but I think
they are an improvement, and I'd rather merge this early and find any
issues than keep known-broken code around.

And yes, I might have missed some situation where __get/put_user() was
used for some reason I overlooked.

The reasons I at least thought about:

 - the legacy case of "one single access_ok and multiple __get_users
is faster" case

   This is not faster any more, and hasn't been for years and years.
But the cases I thought might care about performance - or the cases
that were trivial to convert - got converted with
"scoped_user_read/write_begin() {}" and unsafe_get/put_user() calls,
so now they *really* are faster.

 - The vhost use-case that wants to use get_user() in atomic context,
but used __get_user() in order to avoid a warning

   The warning was *correct*, and using __get_user() was a bug waiting
to happen, because some atomic situations aren't visible at runtime.
The fix is to actually use pagefault_disable/enable() and get_user()
to make this all explicit, avoid the warning, and avoid the issue that
some atomic sections aren't even visible in the preempt count.

 - The "either kernel or user pointer" situation. That was the x86
coco/SEV case, and the alpha "is_prefetch" cases.

 - A couple of "kernel pointer only" cases that should just use
"get_kernel_nofault()", but the code pre-dates that helper existing.

but it is possible that there is some case I didn't catch. Still, this
"remove __get/put_user" is way over-due and now that I finally got it
done, I don't want to leave it hanging.

                   Linus
