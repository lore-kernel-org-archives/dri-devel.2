Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38EDCA5FA7
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A3F10E872;
	Mon, 28 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WpVeTqyr";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0007D10F8F9
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:35:48 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6aa13d8d9d0so7221a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 00:35:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321747; cv=none;
 d=google.com; s=arc-20260327;
 b=htxbuJnS6i6idlpcl3quvifQwd70vjFIPXKGguLfoWieewe7Z1MIowHv/XNxURODOw
 t+KFsqOIJn3/w2zDlgpXdyVU2RymVGUJ0i5qFiXPEyfDUSjUvL9rQcHmObGOycijf293
 Crqy4cfgFbTnGfuPBdxTuWDZAf9XG810gg0wLS9f/oMKffDSmnRv+GGdFHHxo/6y/504
 hJxC8WdaZ90gQTCB8A+M2ui9BR0cZoV8ncCWAOenrxEKwAckVoIMpaq5IENMxzxYuStm
 4KXjuJdVh8IEZfYtcjgPjFwz8Fk98b1vJChbXiZe7GnZ7WcSeyDw3E4JzHka3FUtEqhB
 3slw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
 fh=aDHaZgK1JnzS19gcRH80QiShDnmuXWEy6gpuiiuIAX8=;
 b=WFNSOWgvYCn7jQ/yzOYcmr7hGviyvbHgqGCVNEq+8rxmVGPBRMYWOHPhveXSl16mfW
 DL+K4s0zw1rXmU+3woTqqiRj/X4Hy9hQ9GYKh+y/QDlbtNThe2KQLpuf3nJkr8a9qFmo
 ECeE0O7VeYlELjU1+mG3Bc3WiZN6jVddlCfC9HiPOghfDZiegNBqUyIwqerqpT7BIfTv
 Af2zWzVc/iGaOBmWDSEXr97EfOu8NLrcLqnhj7f0wM/I5Wl/0n4nmVbci5v3DDtYnBzi
 x6eqhC9OXkPJq8h6YJh8c9yGeAFn3sJu7/IPuymND3bnWfdIhTA2qDX77bgN5qdGdbDv
 nt+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790321747; x=1790926547;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
 b=WpVeTqyrRxfKyJ2OOs7djbXJunoO7b31zKUEUUnoGhv0xm4mubs6X+Z8ZIGpcuNs17
 AM2q0XyQF8bR2cDZbG2WVtdlFD0vV4X3nA+c2gTCTTP07Iiar9+0dBEngWKc6/4Xa+p4
 vF5gc0/PjXmkoIE8V+7TyBpcn+Ygeb2Cy4Enzer3rQkAEDtJlyqJPaHv9PfGPYa6EuE6
 QwIRyeobc1s861gwkNIZ8viXxgswaTgL4SslMWIfWWPqIrLW3kNrJ/xm6/z/CU4zdHpZ
 u6YyQTRGDOennvnSI1vDPpICGPCEH4EYJDdMom1YOpBPPquf5Aaf181Gdi6Rx5f0XiZ8
 yGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321747; x=1790926547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TiarA2FI5/GYv9nr9lV3Ck7oSnVRWS2NuO02/gM+R5Q=;
 b=BLh4CqsCYUginMneWcslW51To+0wDiDIQez0Sxy/HxtZDeDzxV+e2qrfvvID1V1IvN
 ES1+xBGAmvd6399iPBU5EC/XYo9ZrTCmClApTJSs/ay7OlYV7O8KO5hFO0DW/BMSBQVv
 l6ih1ZC/TmIjXqZLKcGon9IpzvhWD8nY6JJ8XGnTsTOxxa5iFtNjPcjNuHfXNAZIZNrj
 ZGwDBb89+hP7c2nouX7og8dgxwbfCshYf2dVapxyZBUB6LG7TIARUWGzJicvgHOZHAVI
 +jf0TfdbGYOLJQGp10WEHPhZl9PFIoNYq1V7L12asixQsTAT+5rLPW7Ll0egANpxEAFY
 JP9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWgx762dAi+mKCj3URzLqnEPlBC5z/Wdvsw2fcepbYQlqle4tOWNy9QZX8ZqLza9pJ9gd9hHp+KZ0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mTwss5f8SNzPDIdGtTRTOJNOKIQ3jWQ8rZhRYHsCDiHjclHKPY
 MIz/q5XyMa7M/FvrbI1pKU5hpKT4uicmnXFB2z7IOEHXuihgA+W/7EGTzmLJtC6WqS5d+y69pAh
 r78IFV037FMlGiXvoJY7Iiw7QXRUWRyDn6Fe1y0ow
X-Gm-Gg: AYBFou17V469x5aiL0OE9MqyxSgT8Gaw+fJkPOFFlcZEwM8+6KgU1LDjVjJhkK5+Jcn
 cpDX4nVA7lIhNL/OLjpAO7x6iwkcvtKYPwRKrwzjSIugQ+TgQWFYZfrTWMuiEG+kNHgA1YppMDU
 /bAyPNBy9kFsXWZ3W8/D8YG8TOItBtpZWsob3bLLUNS1bfXXlFzk38WPj+qvVoaO3s80P+nus/j
 XRT4MqeeuuyhhLLAHUDVYQ25wq5GLJUkEyYIHgXf/qK3HllVn2WeuSHYmh7YfCxNsXbKAo041zq
 JqvqGpYLP2nFDV2emtwu4hM9Ll7uhZfyd1+ttsfx7o1Vsi67x0PfgXUTpgBSo7vU
X-Received: by 2002:aa7:c64c:0:b0:6aa:e332:b762 with SMTP id
 4fb4d7f45d1cf-6aae49c58f0mr23500a12.8.1790321746110; Fri, 25 Sep 2026
 00:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-6-4583d8a23bca@kernel.org>
 <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
In-Reply-To: <DLNSNQP7L4FM.1JZQ0GS9300H9@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:35:33 -0700
X-Gm-Features: AclHuK_NuiQlFRW78Nf23QbG4E3oej6nx-ZjiAb0IRRSHloLT2xGmv-6NXWsN8E
Message-ID: <CAJuCfpHpo58c6eOPY_CvP+ts2zwXQEDNX2bohXd0CBANYWrBWQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/40] mm: make map_kernel_pages_[prepare,complete]
 internal and unexported
To: Zi Yan <ziy@nvidia.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Doug Gilbert <dgilbert@interlog.com>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>,
 Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
 selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

On Thu, Sep 24, 2026 at 12:30=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > There's no reason to export the symbols for these functions which are o=
nly
> > called from internal mm logic, additionally there's no reason for them =
to
> > be declared in mm.h.
> >
> > This patch therefore removes the exports and moves the declarations to
> > mm/internal.h.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h | 3 ---
> >  mm/internal.h      | 3 +++
> >  mm/memory.c        | 2 --
> >  3 files changed, 3 insertions(+), 5 deletions(-)
> >
>
> Makse sense.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
