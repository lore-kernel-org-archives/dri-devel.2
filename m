Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D03CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6601C10E839;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ORXEZCJf";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305C410F8FB
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:37:44 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a5f9b036f9so5559a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 00:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321862; cv=none;
 d=google.com; s=arc-20260327;
 b=ZBCh4pMXvshdXKNSPnq7f+BKCpJ+N6WfPuN6YK6vklKNt6fSPhP73jH70FYSjxvbkn
 +/+nApwGIiFVAw6OztZnLGVROPze+yepjnzQOISv+A8a2COT3RT+e4ITi60mYUNLhuro
 WKZKFPbZnqh8brSklEFX1XEpb3iyQ2mhBI7jZOAElY82cv6qgKHvHbQcg5lXZeB/qTLH
 EZ2vCVVeCGckMBgguVWiX/Rn4FU+qXiS44lDojzxwbqr7IwC6jCBRNAwRFTwuQSqTFUv
 /1XeYCnNFefgVZAo9uT7DldHK4eoNj1bReQ8Itfc8tTQ+Sv3Br+TSgRpWal8VQcfeJJI
 h3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
 fh=BlPsUDqtRk8UGzdIbhWV2VuNSdUr+Ol0FdV8D+OXPoA=;
 b=P4ob2JBkX9UkXRXRtwdrwj/EoXUrxU9xRV8MFK0QeNdmIs6Z/Gbpy8amEumXVL5ikk
 6tAr7L/GBVDjucIdyjC5D3uRmIe+/Tl+DCY0C65MIf5/MqyV3T9UzMuphoUaCAF7K7kC
 kK1AGaafhrRGMkM05ffWq7fIlYMle+6joXh2o7UfAtGKd1Oe7d+DnhAoSoMbl4jTKmNJ
 +47wnn5dlZ+6G4EKKRx8sLwdEjEVu7HCQI6mmOP4LDAxsfRgttuJdpoMcce0xAIV2e0C
 XP76eFMzln0UJ6ASrxCMptQU3hVUXgvvkjr9PG45GvjVHevo2o0pSQULWPpMh3xOzxlc
 d0DQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790321862; x=1790926662;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
 b=ORXEZCJfMIm0f/4Fs7DU0vKGI+ASuhxzlj6/3FxyhKkWtcrSFPbPgUPr81ML7WKsYb
 VmQGRRWWpdAxelLf964iO/8oszIFBW/s4/eUdubVe8htXoT0NNnNZM2HmNw5TSgmShJZ
 ZfG/jHrFeA8uXR6j2dHkr7eCUnb7cYxD6Ffub8U9FcV89adWc7Kum3dwpm3Ct6V8W3jp
 vatT4jRPVqdJWzJemTjzm92GHo11z5RYPhbfShNxr9bT78aytiTCRF96iy3D+TfHZOJO
 XwS0TDxcCfOUvvSmg30H+hm7KwInefVvD8kwoNunn2mUfBsR4mXNPTUqWtjq/f0X95uS
 Cx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321862; x=1790926662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Oc+jzCqS0Wyq/bTJh2/I4jluChyvqK4NXUNsIigcps=;
 b=Tz8P4BAGcq3TchmGMPe8pmM+Px68AbpEyYUPgCCrfbt3BkEMO0KRcPBoe5BucQObLO
 BKkeO05E4za7g7uEw2bHvYVwmi3NqBFTswA0IFzHinx8SovqNBg7o0DrDc/EnO10bX3F
 jWP+k5C0bzvtuGGX2QEWGojEdar25mg3/vtDlTFRXjqE3IWJcqRIiELz9C1SXATJhGMa
 TRFx/K9fy4TPv21HG73eCANUHjZ1RZdK6yeHHC7c0jooO7k2bVvG2fIyrUCTaNnvWomt
 YWe3Y5kPvEmrpWlK9dJfBRRUw6WYzT3cFbXPIp860OB1d0SeF1aARuJvVzz3BWfilvqY
 zeuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBVwwurt+d67rMeC54IzDnkoi7tjsBdPzdBEsMH18B3612haMC525Htmb8WJa8J8UNXSuzyBauR7Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lqmD/L7i4IgSfmjicU3RCDQsu1jG1PpqNyI5ZQ/x0y1RgpZKD/
 dDBbvezgkzozGcEL++/5L/xJSB0R869I5LIvjtRWEkaS+CAGAaUuFUoYSb4A0aQVtTmJCq869Qk
 HWeXT7Yn8ymKAnqgZYV36FUNHlUOb/vZirjIeW9Er
X-Gm-Gg: AYBFou0Hvdc98FoYA+h2bE3VRAGzAOR/5NZeCKcaHjZkOeQnVDKnbTyMGiuFdNL2weX
 0cGB9vTDIV/sqv+9pPw4lc8kN/gCqy7BqU6b/0fzgjHxZf2wwzsE8/H44tGSCOCYmTr3M/1r79j
 k2P54nDlBJEK663V1BF7aQ3hOxvzWeHFCrSM0MZbL1H+GCPEYIW2bFUH9PwuWieonwKCaZlgE5a
 AuJuGrX+Vuc/pZYfveYKCH3QHKnMEBSk8/vo2uvN/J0+vNmyChIknDZmmtxRP05xQaO+VUTqcHc
 rjsS/RR/R8PXEvcGl8DqmZdZ6o/A6CVkK9emHrSexL8+VsK8VFPj4A==
X-Received: by 2002:a05:6402:2714:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aae4729638mr36915a12.4.1790321859803; Fri, 25 Sep 2026
 00:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-7-4583d8a23bca@kernel.org>
 <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
In-Reply-To: <DLNSOBMBHIVC.22QI9YBL1U72E@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 25 Sep 2026 00:37:26 -0700
X-Gm-Features: AclHuK_RUT9CXNFLpx8ZY_roLEZNzp5S3oNdpNL4cW25fJBFg9wRGnSWohuMdYA
Message-ID: <CAJuCfpH6AF-hOo4jU6OeNVpd+fgpqLpmcfAGs11J=nPCgAqG_w@mail.gmail.com>
Subject: Re: [PATCH v3 07/40] mm/vma: tidy up map kernel pages enum values
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

On Thu, Sep 24, 2026 at 12:31=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > MMAP_MAP_KERNEL_PAGES is a mouthful, discard the MAP_ as that's implied=
 by
> > MMAP.
> >
> > Also while we're here delete useless comments for mmap actions whose na=
mes
> > clearly indicate what they are for.
> >
> > Also update the userland VMA tests to reflect this change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 2 +-
> >  include/linux/mm_types.h        | 8 ++++----
> >  mm/util.c                       | 8 ++++----
> >  tools/testing/vma/include/dup.h | 8 ++++----
> >  4 files changed, 13 insertions(+), 13 deletions(-)
> >
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Best Regards,
> Yan, Zi
>
