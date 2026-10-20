Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91202606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=ValjyYfR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A6B10E1EF;
	Tue, 20 Oct 2026 18:14:38 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A6210E1EF
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 18:14:32 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c34bff61551so503752966b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1792520071; x=1793124871;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AI3sBbenOq3VZh+TQ8EVyC3GkeDOeDtX825lHVuYChI=;
 b=ValjyYfRn+YRTUy9q4ZmApHm8rXYkTFAIGsuJoZwjQehLjTf/C3PzONMGdPQlP02y+
 0vP9xnuzIR1bIAbCZVQFKWt2biLCCdFHfHaMAx+TDWS+ZQSvW+BaQV3tjjSsWhdwN1Gr
 6goia7Qn6elJnozdiRbOD8rHooQeTSCcLi8Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792520071; x=1793124871;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AI3sBbenOq3VZh+TQ8EVyC3GkeDOeDtX825lHVuYChI=;
 b=GQ1AubXiiqGCpJnusumH2scm+iOLrpEFySWxgGaX8xb0MJ+hag+rdj59C65VvYul8/
 Q1GWQ2FEUaIgWdlRt7KoEIdy2YuCj2fI1U5HFOXS30+OVavoD9GhS6gLLj4HHzT2U/8Y
 jNsqxZwGWifTI1n0dFF+AN2mn/4YJdCf25hoHFMQuYJ2uehrXm9P1jAV9TT5iKdhTjQE
 /Lr4fJEBoiP240aXmbDSkvhgoH2K1w51YDVMjlnWZZLMvM4Lhtd7Uujys2+lPNuOqL6T
 FnIvt8e2VUdfTJY+YP9vn8DkvIN2tYUPYm9j8bppkgCAb6qBFQqXomZDZ3P3UNV+BJe7
 AkZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCTahnJ1HMdMKN3HbDasM1xI4CFemp2ghZb/W4D+p1qqeqvI9iIc50jSwpOWZhdxrmqEblHLtZYNY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKKzDnAxIuukAY75E3KIQ2aWyYnOkBmoZ6/0+G7V3zCNJT0oEWV
 N/gYwjJ/cO9GseZA7v6ZyS9FCdJbIuN8VR7P7dloOjy64pWhieSkSH48xC+LOB/el3GU9/7JqaL
 kCKbaZ4I=
X-Gm-Gg: AYBFou1q5Bq3d2yTadlkOdPjoLHDx2Um7NxrZgTIXvIIDxyTKkViq4NR1SeibDKFhyD
 vzzmvjYHR6fXwaoD4ao3wTGiom3GZtvG9XIvPpe0Y04gxQrF9KpjS8keLku2ZYr+AEGZi5cf3dd
 6RyaXgYI1Iom+V8967krM4j6DJZvVK3shipIXdwjGuPFC+86i2yYEpDsDN5ShxSbEis+Q3MElOj
 ZgQi8tRy4Knfl3kj33GEA96Rh6ieS6DeCLKoFb4TX0DsyubrWM+nSCpnpzIbInPRdYdhQE/03Db
 cvYiyBx1gGRWFurzlDftIAGb4/+nwmEy1bBGmbOakF3y13ugG+TxAssTm5iRlYEhosoXgjOeYPk
 dl+cWuGkwWGLMywc2GmwLWZpgvQHTSSKVMkap56p5HNVzjWw8iafPpE6vmqcpgH4lvNdwXGC8eo
 W7a4iJiBh65/QVUFaB+vFQPzikssBoV+rEZlimvd3hdLwyptsEDqROfVGshg9JyHXLVzXSOXR3L
 mdpyOsyhPFPKCKHzJRe3QViaqMf+9Hxmy6D7h3VFxYA8gI=
X-Received: by 2002:a17:906:1006:10b0:c42:53f:af64 with SMTP id
 a640c23a62f3a-c42053fc28amr522078166b.49.1792520070673; 
 Tue, 20 Oct 2026 11:14:30 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com.
 [209.85.218.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4678faa5easm2250566b.44.2026.10.20.11.14.30
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 11:14:30 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c34bff61551so503749966b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:14:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByejV59yqfVGASopnR+qxDQRvWWbRcHMhEdwBBxzDy3dqqfOxup6eiXLFpyzJtqru03yA8HzYZyHnM=@lists.freedesktop.org
X-Received: by 2002:a17:907:9711:b0:c2e:350b:7220 with SMTP id
 a640c23a62f3a-c467960c21dmr1978466b.9.1792520069782; Tue, 20 Oct 2026
 11:14:29 -0700 (PDT)
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
In-Reply-To: <atdqUYdIOqmiqqTt@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 20 Oct 2026 08:14:13 -1000
X-Gmail-Original-Message-ID: <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
X-Gm-Features: AclHuK-HJYHxkUsyBkGy3Njf6A4fOgxIA6b9mjsApIllpv7mDCRHR9A0DndLsLU
Message-ID: <CAHk-=whrUi2M+whqwS8yfqZ=W9ts6NPOzxzGfBOwOfCC3ooeMA@mail.gmail.com>
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

On Tue, 20 Oct 2026 at 03:19, Ingo Molnar <mingo@kernel.org> wrote:
>
> ( BTW., there's a new dependency introduced by this series,
>   if an architecture gets rid of __get_user(), then it must
>   define arch_get_kernel_nofault(), otherwise it will gain
>   new uses of __get_user()/__put_user() via the generic implementations
>   of __get_kernel_nofault() and __put_kernel_nofault(). No big deal
>   I suppose. )

Yeah. It didn't actually look too bad to just remove __get_user and
__put_user in general, but I ran out of motivation.

On arm64, it's a non-issue: __get/put_user is the same thing as
get/put_user, and they both do the full checks.

And the bulk of the remaining cases were on architectures that I
didn't feel were a big issue: alpha/mips/sparc.

I *think* they are all trivial - the bulk of them are just the
historical signal stack stuff and should be a direct conversion to
unsafe_get/put_user() wrapped with scoped_user_read/write_access().

So I think 90% of the remaining noise is truly trivial - not like some
of the cases that actually had *semantic* reasons to use
__get/put_user (often very _bad_ semantic reasons, but still).

Not a huge deal, I might get around to it while waiting for test
builds. Or I might not.

                 Linus
