Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5C606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=cJKoytNO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC61A10E34A;
	Wed, 21 Oct 2026 17:02:39 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F3F10E2F1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 17:02:28 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6b1b13e09ffso1312577a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792602147; x=1793206947;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EjCuUwpomnnJOqEQ0aOYfzzrmAC2AQlZYb4tqJTWlT8=;
 b=cJKoytNOTEK8KUEYmaqsT39WUUmcd81WykumUhhJSs99vGiMskdBb4I47Rm5ZPeqvo
 uxLeMtZBGtgC+MfSyROyRs/bYIunMYmFMfGxoI/bjzmlZRb488C8ip0sJi1cYn+pKzYo
 5sQIjeGLXcT1rAKhxa5mQhKh/duscmqOKEsoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792602147; x=1793206947;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EjCuUwpomnnJOqEQ0aOYfzzrmAC2AQlZYb4tqJTWlT8=;
 b=B3mhWDzWTXDFmtZrXDTN4XEre1E67OIAiZ2PXqR4iPkVzectv8O2lCqACFLQSMwzvP
 bKKBongjwtzbtfdmwtgxfpme1ReJ64DHgx0iSLZ4mb61DGux+/QOPNjnVjX1AZfpOXAe
 XoejRW5ud3/8dRfpmfpVszqOPRiTzSm1j+vMV9YB7nr/FHrjLId6f+n5ZvPHZVt1mCkG
 3/hafuFKnfDwQvicwmi1Z8/ZnJWHnJ//NI4BVW54dLJ6prdV2Cn1TMMUwUTbCuI6hFSw
 WKgTi/oZuU8yqPLqMes5VtSXRDr3sfxKe3v6NwlwQHnPs1nsOA6C5V27hrs/87lDKGf9
 FPKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkn7abnT4VoSGiNiMjoo/zvPJLk7RwYkEqM8YZmnjA/JhDKN0DZn5jEj/gm2puhg1lpIHoq1TnT0w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpjMBhTu86XgXO5qvP3OXjpu4h08P9lqGJHO4atY4b3gd5gQBU
 CGYA5c3Pwr7FFn31K0nLfUCTUVlsY7Al9GbexRIsgOFnwO3ijf5vZulu5Nafi2Jc2B2Urhr2t5r
 arQI1FMqKeA==
X-Gm-Gg: AYBFou1QAntGicgAUc1lBMl1tf8vyh4x3/q2t2lcRuH0/30xl3s6OHfLHWJKRiWcfKB
 iLtqR2EimkoQ2D2HZeC0+dSTbdEpUueZg/GG/sJ7xOoC+AUdmzcxH7r9FOfuigl3drI/b5EI9dL
 rOHCmy2i/c8EKJkNZQ//WVa0OtnPA1wNlOGxfGZoL4aithr8cdXIgLltgfPPNURCvGmLYRLyaOK
 hDY7qbJOlWUrxyPkymMEiZ47+lSIwk+S6RIaS96pCEqOdmhpLl2TeyoblvQqjHDo90uzMZuhSqx
 B+nT/F25xjqmX/pBPwUqrTGUtZ4dqxlZtG5clmuRcaqHoLBTACoBmI7XCs97RCft5zbrKPIDCnO
 j/8S6E+VwbzshLvPay4vqQMljxwLq1dXs4XOHZ/cdcp+1Z4e6SQ/zTO/0NNklYN2iKpamykv1uZ
 hNClCqYj29dHMDsLj5WtTRrg4xKqKtDOj8GsSUp1EVVjhSioOXdxUu7OKLGlLUbL5Bwwj4IjRC8
 gFP/AUTNShOZ6hIhC3/iC2fJ0Zvk+yXouC9oP14V/zVFoSqOGeyAJ/py1pwnjKv/ETxrWJXf+di
 /usWtCymvOHTg29Gqd120FD9tZc8y7A0yxVLkRYXn9vAeIIcYg==
X-Received: by 2002:a17:906:4fce:b0:c44:9a32:b27 with SMTP id
 a640c23a62f3a-c4679682019mr251154966b.25.1792602146567; 
 Wed, 21 Oct 2026 10:02:26 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com.
 [209.85.218.49]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a1f0526sm23468466b.1.2026.10.21.10.02.21
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 10:02:23 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c263415982eso127928466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 10:02:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBylwzun7c2lkkxUv8EExDxxZ3HaWP/veZx4j6AfdCwtzXoqG+Kh4OyptXdKICpBxnVsVw823KL54P4=@lists.freedesktop.org
X-Received: by 2002:a17:906:794c:b0:c42:102f:15d3 with SMTP id
 a640c23a62f3a-c46797171bcmr253709766b.34.1792602141364; Wed, 21 Oct 2026
 10:02:21 -0700 (PDT)
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
 <664c8f8c979a76be18b3e6538a15d3c4235fb8ac@intel.com>
 <atjp_I_dCfw0tW0W@intel.com>
In-Reply-To: <atjp_I_dCfw0tW0W@intel.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 21 Oct 2026 07:02:03 -1000
X-Gmail-Original-Message-ID: <CAHk-=whB5bOZ8C9dyoQT_SQQc=2HRaJNbdFuJUNne2bMkkCQHA@mail.gmail.com>
X-Gm-Features: AclHuK_g8l2EJDN48ZLd8K9V90bgnoz1MjFPcU7jmrVp6UUYwPtCB5cvD7AN8tQ
Message-ID: <CAHk-=whB5bOZ8C9dyoQT_SQQc=2HRaJNbdFuJUNne2bMkkCQHA@mail.gmail.com>
Subject: Re: Removing __get_user / __put_user for good
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Andi Shyti <andi.shyti@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
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

On Wed, 21 Oct 2026 at 06:36, Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> The new commit 'drm/i915/gem: Don't fault on presumed_offset write-back' [1]
>
> reverts commit '97a37c919f62 ("drm/i915/gem: Ignore readonly failures when
> updating relocs")'
>
> And this blows up exec_reloc concurrent tests that uses
> mprotect(reloc, sz, PROT_READ); [2]

The old code had two separate bugs:

 - it used __put_user() while holding locks that could deadlock with
fault handling

   Fixed with the pagefault_disable() around the put_user()

 - it didn't actually check failures, so a read-only area silently
just dropped the write

   Fixed with that "if (unlikely(err))" addition

But yes, I didn't see that the error handling had been removed - the
removal didn't show up in the code

So I'll remove the error handling from me branch before merging.

But that code absolutely smells, though. It makes no sense to silently
drop the relocations and just go on - and continue in that loop that
will then drop the next one. And the one after.. You're just wasting
CPU time and doing nothing useful.

So I will merge it with that error handling removed, but I suspect
that test is bogus garbage, and was testing for a bug, not testing for
actual behavior. But I may be wrong.

But the __put_user() and the pagefault_disable() around it stays.  The
old code was very very buggy - and not in a "waste CPU time" way, but
in a "you could cause deadlocks and lockdep issues" kind of way.

                  Linus
