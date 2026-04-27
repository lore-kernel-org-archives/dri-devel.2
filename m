Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCF9FF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842D010E16A;
	Mon, 27 Apr 2026 21:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RQEGFp9o";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAE810E96F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:52:26 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-ba92146cc86so1161875266b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1777326745; x=1777931545;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
 b=RQEGFp9odf24Yt/w+kqr1+LS3ScvAZjzhvsZmvmnlnZs/81FuhxwIBx2VAIzK/WgZx
 UuBBhqtNpPqk1CaUtGOVbblXSS21Z55+neZa1b5RMM8RxMoICRycTZYiLavD+T8r92J/
 O+r9fPnlEKRxQHmKPV3/4nVJ/oYDaqZhN3yjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777326745; x=1777931545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
 b=aKB6xJf7jLT7i5WY8T8MfPsTk6w/qFpERmfeAgcD34aocrXeKV7v4hn900MkSd8chI
 sJbW0sVcgptP8uBrOi6WOR1mXtluXBMdwR94Hy87yfXLvP3QtVHtMM2MatLKYDPtUFf0
 ayjnhhmNb5ckgOE0k7/azFsC6K8OEJdhLuZzleAg5IO4TFAiJ0CwLQgS8SLBb9sJM8td
 zAhr6+CzL5i/oC2eRMcHrTUT4hy4BaHrstBAZagyCd7heRDYkXno1O0zC/Zjb0sR+WA/
 iCrZczmQ6LrGkBoHbcoyz+ZeE13hjLjDe6r4iNOfQEF4wicKRMTELVHu1zkY6BNsZpnt
 CivQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+ylbZZxuBitPSORJ7xW0x3U4/EzXd3I6rN3g+MuzxNQO9DTg2ISHq+7649H87fXmliQ+hiwUerrU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw71A4Zj9DJTMEuG5+tU8FWk7m7ncojBK+xjZz2KjcKN13HNRz9
 pts19cP4slbUuoAOM3eEhuS2bw35Wd7CByb/wjpNDvjIpmwLl7KG/fWFmCop30zZB+iXoZjg4WF
 MREDGBnFcrw==
X-Gm-Gg: AeBDies2uDZwoKw6zmuPlBk9AiKeWrZMLb6z85ezyz/DJr2cWJx3YyOCJRZO4Hu95oD
 Y6jaT2VXovZWDTI0XgDD/M2on7352VENFCyWCDa9DJUOxHOxrJSdqVlit48AeXKAQYiaiDAH9Fy
 BXzjytodDb6vAMg9bElkPjLMgz73+s/GVV0cIKxzaoOj2n7Q/McySqS+EUFRZcJ/TbJ3mymofKB
 3rBiLDBmcfC511VVRnD8xhCAyABtI4PDvQ0/r0nykbV20/LFy/DyRMUEJ6sjDf5orJLl8KJsrny
 3hMYdDKsYFIBpvhW5Ky9d7c7qcfZZfLn2ZsRvXKooFAN4twIarYo9IYZHeXsRZ7t9Rm4nlhAnG5
 JEGqbJAP24DU0zns3fun+BvYfAS9t6i3ZlOryiFvnjcEr+zxEOUbPpJJGZ/uKOkDo+Fyb6GQKdK
 djelxDCfhKjsYlHKAWA5KEWg6B8wqe1t6pCQUMQkKuTN/nIR52GgwMdl9oC97ZjiWcg/hLWJJsp
 J08CcznlMw=
X-Received: by 2002:a17:907:74c:b0:ba8:9137:da5f with SMTP id
 a640c23a62f3a-bb80377b922mr28869766b.32.1777326744775; 
 Mon, 27 Apr 2026 14:52:24 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com.
 [209.85.208.47]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80853e641sm10376966b.10.2026.04.27.14.52.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-676e62faf2bso10752232a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9XTYNeLoD5sGxaLQkiN2Zirl2rvLpJVqe6RQKnpt3r7S1aFNKHvWyMHrGwxyDhcxHkbP+9fNh+3uo=@lists.freedesktop.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
 <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, 
 linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
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

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
