Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59D606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=gS7PkGNv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C5C10E05A;
	Wed, 21 Oct 2026 19:02:53 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393B510E05A
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 19:02:47 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3ab3dd9681fso10441781fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792609365; x=1793214165;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YMPynNC1sw37bsVrWwh/P6LXB5IqWl7o3sALpze6n4Q=;
 b=gS7PkGNvaWFjEzblPOcCeg3JHOzIE+gv3ti1JQx1bQemF7om5jI9nwANodyU9qmyYB
 uhHt/cB5HNQVMQc1vsZ0gN/uRmuteUb/8bWZzgCDeO+zE2lnvt5k2mF5UHTkZyGPFAoo
 0zaq5vbd7CZy0K8Cy4/4Nu4R9PTABJKJVPDmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792609365; x=1793214165;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YMPynNC1sw37bsVrWwh/P6LXB5IqWl7o3sALpze6n4Q=;
 b=pX6Hs0IFRMM+8QjPbTE5JHhIeZLg6W8oDHHyzoAtCNE08mlr3MpgIFaRdmmC1JfVt0
 2DXBQAbSh1prK1Gw5EXPhdwlPQfzV9LGUww2KqF7nA31Czvb68IUYs9a0wrG5JlKf4Vh
 e1RJEzSyK3EUUMePzXL/TI5u6f5mkdn10E2bhuXCWmCHGVpqLBUIaVMJq2g2uRuRmtKl
 4XBuwmZO5eyeqFeiIY5V70cKxq1L0EX1MGr/pZge1KahKWLTm5OENnrTD3y5jSR7zLvq
 s1VkfW2TrgBy9MFfO6FgWVYLRjrm4/gkvGhqois1BQo4IqAV+cyebZOhZuEQ3+MyOAPU
 hF/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0aIZvnJ2+o18n/ay+yDPx3TZ75GVvLILe1QNHRPyvn8jJaTbZ2Ri+7bsXtRDwBBRt3hlIGuqGYeQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQnO3SKOGq7hOhkFZsR3QahrPW/bH3NJKbd/L6vB9hML+Fwc+C
 wWHL0J6k9cYDIHqpVO0YKnogCJgTSN+80Ge0eIedGQaCno/C5jNYfiqmp/5JRj4F7lXIrMIzF0e
 RPPQamb+VOQ==
X-Gm-Gg: AYBFou1xZkJsxVNirqyLgIlWj45qZByADdPYZlrWX3dhN2LRjBcFWP/rxVAeoysNBz9
 teXOOEq8w2jCC5U2TrBoUvNjCNaNNqYenTaoRpNC9Uxd5J4t35V1bYTzz/ufkNkIvW5D/XdS2Hh
 TaykXL4UJfYzlJgEL4sdOukFtnY4nVlbgtL7r14Ksg6chI+MNypCTDs5wngR6x2C3BfbxYsn31x
 Dm6ietjCSToHNfG0/aPD7NIITHBBhhvASc07IJJyTU1S6+4+taoMKJ7fCQTXL4fM1dKQT5Tt6xl
 sS2qS6g3Qzw2tlR2+X2zfBkxT46LADuS2E1b6U00fix+Q+DI/cGr4MIhoLb5SVbbqHgJAUHZ5lg
 vYTLKQrngqNZ1pzloPDDchbh4Y4D3U6AFPbjph5wCwPuGfwRTu3YzDyW6h8pW3JCki/at1v1Bom
 HYKzZhrFbZ+tmTedjx/5Y7CKSWyraUOctrjFPuMaxm14jRWpL7BXryT/52ZwIpykLRGQE7MK2+8
 ZPGNruK92NVjCIqOrcQBBpOqLl7XvpYiHJ61GmVhIOzGiCTQzWmQhtyc2vh3xSjjc1QF/8XUu8+
 qBHBSHd91XOaecQs9ZfK0WPIV34W
X-Received: by 2002:a05:6512:3b1e:b0:5be:414b:9032 with SMTP id
 2adb3069b0e04-5bfa1cdde82mr1101693e87.31.1792609364885; 
 Wed, 21 Oct 2026 12:02:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfa1222d55sm674789e87.58.2026.10.21.12.02.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 12:02:44 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5bcb1f1358aso840971e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 12:02:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByTMgXHXGPna8OUACm1AewZC6UXI8DRF6tC+3Zi6TcqIQwPPZ5VXGnFGbEIvCyZFDIiMY1jfkR5EMg=@lists.freedesktop.org
X-Received: by 2002:a17:906:f5a8:b0:c40:4848:f7fa with SMTP id
 a640c23a62f3a-c4679725421mr277727666b.44.1792608960698; Wed, 21 Oct 2026
 11:56:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
 <atdqUYdIOqmiqqTt@gmail.com>
 <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
 <CAHk-=wjFBSH9M2GYKRnd-jrMGaa-gPBoGhuscJAu4n1hGsuX7g@mail.gmail.com>
 <CAHk-=wj51-syPoqMBLnxMeLnsbCMDMXfKzKZCtOHhwWEk5DeRw@mail.gmail.com>
 <20261021025403.GAatgpS1rcSTOTs8sS@fat_crate.local>
 <CAHk-=wgDm1nHurWJLESiLeYr0_0yv_F7W8YbvrmMEfbhxM1e_g@mail.gmail.com>
 <20261021184317.GBatkHxUL2xqH9EUkY@fat_crate.local>
In-Reply-To: <20261021184317.GBatkHxUL2xqH9EUkY@fat_crate.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 21 Oct 2026 08:55:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjs-DWseqMLciovdLmhcs5xhksPGOZRCoXK_sr8tmEiKw@mail.gmail.com>
X-Gm-Features: AclHuK8f57nKb-4MoMEUR-mEL87s3HzD_7o1XJKaCavElfq4o0c-Mbe4dFzOcTs
Message-ID: <CAHk-=wjs-DWseqMLciovdLmhcs5xhksPGOZRCoXK_sr8tmEiKw@mail.gmail.com>
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

On Wed, 21 Oct 2026 at 08:43, Borislav Petkov <bp@alien8.de> wrote:
>
> Yeah, I wanted to take a detailed look on a fresh head but you pulled it
> again. :-P

Ahh, I removed it because I merged it locally, but then I decided I
should do a full build before I push it all out because I had missed a
merge error yesterday due to not doing a proper full build on my poor
little laptop.

So yeah, it's gone, but it will show up in master shortly.

And by "shortly" I mean "not as shortly as it would have happened on
my home machine".

I think I need to upgrade my laptop eventually. It's a perfectly fine
laptop, but it's from 2019. I'm sure there are more powerful ones out
there that are still lightweight.

        Linus
