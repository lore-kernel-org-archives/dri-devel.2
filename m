Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEIHr4Df
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FEE10E536;
	Tue, 20 Oct 2026 13:19:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931DB10E536;
 Tue, 20 Oct 2026 13:19:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BF89419F8;
 Tue, 20 Oct 2026 13:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF171F000CC;
 Tue, 20 Oct 2026 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792502360;
 bh=M7mHwtNzpY0+cTgjY0PXWntZrMQkw4Vz23Sy77SH1vc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nEIHr4Dfawp2pcbDuCNayqcgO/KRVO/7FWwmVu8J2aJQKq7sJQYINfIWj6jbkvT4l
 K5/84Z98ZqsU6kYdG0wJNK7Y6OQui6NP/9GoTQfAwhA6vjAVT41axlK9PH7LnFjF6+
 Bmc0VrvGUdv8rX0rtccaPdRBc3ZG6TMKQSzf6OpQdEAbBPyv2exwTwTzxaviefq+Wl
 oaMw132pmnaIApzpWNQFlhhWfVyG0xV3MR9bVzEQuvzQ1rsKScO0SZV2AC24gayfir
 OFBVP7uTYtjmv3uSgchfhjdFObJ1W+fuHMPuSuSHq05d2iO9Er1PAuKG7nHY6LFJfQ
 BGTrmKbCHv9XA==
Date: Tue, 20 Oct 2026 15:19:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <joerg.roedel@amd.com>, "Nikunj A. Dadhania" <nikunj@amd.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Removing __get_user / __put_user for good
Message-ID: <atdqUYdIOqmiqqTt@gmail.com>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
 <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wipGHx_1Uztmu773yuTM2ka1fq996UmNoJpvKS0gqEdMg@mail.gmail.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


* Linus Torvalds <torvalds@linuxfoundation.org> wrote:

> Bah. I made this branch of mine public because I wanted Michael
> Tsirkin to check the vhost part.
> 
> But honestly, the i915 side and the coco/SEV patches are the much more
> interesting ones.
> 
> So this brings in some new victims^Hpeople for that git branch to comment on.
> 
> It's all in
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> uaccess-cleanup

So it's 'uaccess-cleanups', plural, in case someone copy & pasted
this URI verbatim instead of using the branch name from your
earlier mail. :-)

All the x86 cleanups look good to me in principle, and a quick
test-build & boot shows no problems (both on 64-bit and 32-bit),
but regular testing doesn't fully excercise the exception paths
of these changes, so YMMV.

( BTW., there's a new dependency introduced by this series,
  if an architecture gets rid of __get_user(), then it must
  define arch_get_kernel_nofault(), otherwise it will gain
  new uses of __get_user()/__put_user() via the generic implementations
  of __get_kernel_nofault() and __put_kernel_nofault(). No big deal
  I suppose. )

Thanks,

	Ingo
