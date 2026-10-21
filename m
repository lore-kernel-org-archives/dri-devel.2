Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206D606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=E0BCTeY4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4863E10F8B7;
	Wed, 21 Oct 2026 03:01:24 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB7710F8B1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 03:01:05 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c441e267930so21497066b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792551664; x=1793156464;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6vPeyJTMHdyRvdIHSAi9aE4sr1TloBvZFIlu5+rPWzU=;
 b=E0BCTeY4enWCnvEgvrdocP60YqywCNIoH5f4z3sfJR5f3wvlRf+pGxNYqg1DDToyUx
 go3HljoDtD5sLyE6TmqXSTljDpQavLRaLNulnnstPSieyvsTm0z0f8ioxyarDQOpsfBD
 gWmns6MLI3YqIVJSQWDh5rv4HCPK6go7RsUjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792551664; x=1793156464;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6vPeyJTMHdyRvdIHSAi9aE4sr1TloBvZFIlu5+rPWzU=;
 b=ZTu4KiSTL/gIgxriI7S77i7kri1YLkfBTh4j5vIg/ZkvBDfKTgTymcxRJi6xQ3r6+3
 n56srjdP50t8oWpxg1mk7lg8Z6G0wqAV0zl6cNzESSgC5hQ0h2y2tZu30eOG/k+hk8X6
 48XvLtxSoyAaS0EsRvJ7a7Z+/Mi8sgWGJICUeOgTRnVAEaZ8uEqANol6JeCmReV694TV
 3tVSJMYn/sKWr9SNiBPBoVk8+gabcPOlDboJTSrmQaZhdbmWPZmLCKle+es70qX4gyAU
 65rkg9PEiydPalN5kdLO8yR4YKEmEEZSqNsdoOXJbPAQisfTl4xS/4KMv1PZhfwaOPnM
 PA4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzivsPQstpaoUHssAm4SSdAP9nsDK5i474z6MDBELEDzxpuMYhx301jd4nQr9Aw74XdoLO0cDwNjCQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJQ/gnIE+dDXh+4qn2Vep3m3/xj8WSY8rw1fW2g3fEoAOEHomnM
 KkV1axDkA1MWwPbJhdudBz0k/T5GXhh3/ztzBbrD0lugwAsmrqk+rRNl0n5hYYWFVJDys/vw7aq
 xQAguYVRj8g==
X-Gm-Gg: AYBFou3keVfMXofH0xZyghEFXWv1Q6y6kvVsCRN3xr1yjbcr3x4uRL2cQ/sOIdoKIwQ
 oYrKCVz5HvSlZSsIMtDv2T7adKHlHcka9RbmgEs5j33AHnptCmlZghkbDeuMIc88V406RZ8F92w
 s2/iMZqJS1EnO76LRBTyI6uHSPEkDIJUztDK0QjVsteQc8G2EN+sl3oFxBn5bcKLqciog6APBBX
 gRHMKAIsZqjlLW1nqphar3jJbzSzLjcpgF4TAtFqm3RQLTMSC/+gCRrdFkngo7BJN0GwMKxoREx
 foYpQ+Ebda8cg+ZY6PcNQtiG2roZuC/3TCd80TJNebPmhUQHBJhy/weQg5hB6et6add+/DFuRm2
 0ppWrjGt+eCVF6AFQCOXEPg0uykGzrO9eeFry6Pb158I9OrKoIzWYA23kEk4TW2+J30Hpt4rogN
 IUz1izPskEGPlEFCNEWygYveTbKQZt/xMTQx6NmfKx4khnNTMEkptOzTP7+6TqnVeqpNa9kThWp
 v5FMhmXWNcjMEpS9HuiNUEEfpDnZQz6/+jZbSIHA/+bG5I=
X-Received: by 2002:a17:907:86a7:b0:c26:1648:a06a with SMTP id
 a640c23a62f3a-c4679684c8bmr58478766b.37.1792551664168; 
 Tue, 20 Oct 2026 20:01:04 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com.
 [209.85.218.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4031104f2sm315814a12.16.2026.10.20.20.01.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 20:01:03 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c45551fa84eso23491066b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:01:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBy23HVDB/yG2eabKfjT3ynNQnY3a5H8UFlsiA2yX+AOVHxBNS9t2OmmkBbWWbE/3QT4r6YTIzr2Yks=@lists.freedesktop.org
X-Received: by 2002:a17:907:3e96:b0:c41:6de7:7dde with SMTP id
 a640c23a62f3a-c46791027bcmr73264866b.4.1792551662590; Tue, 20 Oct 2026
 20:01:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
 <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
 <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
In-Reply-To: <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 17:00:46 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
X-Gm-Features: AclHuK9HmsJiPNq2pQeGfp6RqCtErZ0oevbHZB1cNI1n3cwuB4Oa9aipnTwjAUU
Message-ID: <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
Subject: Re: Removing __get_user / __put_user for good
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Tom Lendacky <thomas.lendacky@amd.com>, 
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

On Tue, 20 Oct 2026 at 16:54, Borislav Petkov <bp@alien8.de> wrote:
>
> My SEV-SNP guest boots with it and we'll run more extensive tests soon to make
> sure nothing falls out.

I don't know that code at all, but from my reading it will only
trigger in fairly unusual cases ("rep movs/ins/outs" that need
emulation).

But the replacement code *should* do what __get_user/__put_user did
before, just with a local helper, so unlike the i915 case it shouldn't
actually change any semantics.

Famous last words... It's the largest of the patches (well, I'm
ignoring the ones that just do multiple accesses to the same signal
frame - they may be more lines, but it's just the same thing repeated
over and over again).

             Linus
