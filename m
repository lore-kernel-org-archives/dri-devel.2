Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F3C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6687810F912;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aXdJnsuu";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F302B10E54B
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:32:56 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-530e8c6fb80so258551cf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790177576; cv=none;
 d=google.com; s=arc-20260327;
 b=lN5vqJ7uz1lB/PM41455UowkCb0ZbU0TXVEg/bf1eCsS/irrMcI0s8LDphswWET8fh
 1yMaEfHjxfPWAgXw6fbGnnAP0O0HPnVbqtFBA3xy3ob1Wk3UqFXnG5ahgH8Ruo5qGDSR
 UiCQ8FPg0dpYOo2NjBJeAmh0S+qxIb9hy05Px6hOUkgE030Rk3iIYa26yfv/sRyGl8QB
 vE3jvbUHxWMzEI7oC4i/jSfO9rCo52N6CsiDn+R21MNY6Ukct95OFnZgpQBDu++LpxJr
 BbtytghVWBX/PzSUzNlWFQoaN6VnWA8P8TEEWUUCPYzHaZZqoyjKS0JqZTvl8w3fzH5a
 NJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
 fh=uTL8JqPwoowoeLojkoeOhZ6ZGOp46dkBO2OTaEwjw3o=;
 b=NLh6L83zad4o8WI4MiRas6SJFDjRbDLY3n8n+hh2PvopD3ef1DUbBhvsFUl9e3IIC2
 BO5zjjetir8MTkGzHFz69p5iyspMhE4FBDaiFGTFoM9uNEoYQe28INVqfELO7220gqIY
 wx12l0oa7PNHzNOWv/bbZLiMrtR9EKDBLf8oQX7nSzPC95VCe8WCAfp5hXo3nKRzu6M7
 qBzb/tAu75iOCSUMuOiUssJsGZOkiRSty+dEucPENWpLgLFbBvhw0gjlLfKMycV5aj/4
 4CdKCDQLqTKEmHizgvj2DMlQz0FOPxNb4A5WsG7mEUBq/n1hflJJ7bwiAmvJg9a4uYPQ
 XOmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790177576; x=1790782376;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
 b=aXdJnsuuaeAzahzoUysiqrvA70An4xvZ87/2RO7qLFnpByzS+XMfgDmEuivN6GrQ+7
 Q0i8AEffLgFaTGtRiNREcreW59lBFpVpSVNlucnjXePOcqVYmGC0CJkawN0ZCmIchLrS
 DRFpdMYmmKnlh2EbiMjasVGgAI07eHJqkHyuprQeXf8j+hhnFuN1OTLglGHie2/QY5+N
 NFdgeBq9+8wFwgzhjo8thqH+vnKQYxfcYTzPMy8Xj6qC51injVPKEHdP1pI8R/ObmGEf
 Oa4EsDJbVpNyArZl1DQttZ/Nqt7XZL+hEFkGcKoYefBa7+y9HFuGNin3EMb9qiaCdunp
 yX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790177576; x=1790782376;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hKtcWNVFda3wl86zaKIN0hpMLzWuZcmeXVfEC0xSzRI=;
 b=BP6UJJbMbX5uVBCWZLyVC1ehRSEoxs2a/DrF4fTN/qhP30Smxj6x+Ta94L9Lr3ZNHO
 c6FyL+m2my73Bk63A+Yns5fpRUH1VcRVLobr528mJCmRfmMYdIw1e+zzps3k9YuzCB7w
 E8/t0I48cQ22/BaefywyeemlX8NBZRoVge9UDWECjZxxzxHHTy9E8URJr92IEXq6pZZt
 qDJChtbG5yLvCNfuK1PDBw2frCeIMBm6iveXiFOCv/gxfrz4u3eEwf2OMds+dodNTW1I
 1Z/GScvh7M2Z2mvbtODCqN2euniMdxUHBjEKbnHABm+9m7knBNtTCeEUhkX950Cr8bYv
 QPag==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwK0ByLEY/UM05v+l/OOaQTZAF8KYWzTG0QyF6Ym/x/HD7zH2Zk8LAbyzWmC71h6H3ChF4bPMy8bU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nK+fHFbvD6SmGATYR8OBjwotuNJIazA9C1MQUyA6kcN/B/Ocba
 NYHYZyaWbqN3LPK00quqQklyqqC/rQzVlIrZj7VewIikp1WZ/V0tW122svpHyxA+JXinowg2BNL
 v2s/Vp8LSM7ONEAbLzzyi4VmW0nKsBglSy9nDwRgG
X-Gm-Gg: AYBFou31r/P38KaNkKdkckbVKZ5EXYsIhQltz6NcTxTf96EnuhbzHs+SVvxY6W0mvX1
 xykhKlrMilTftZguVTCRai3EPEXSxhNQKtIUGyW65WJmgm8dwfo9LorhYJIbBdTAfp14pvDjBmX
 j4nG0QfMC7z5NoqQ0T8xzVUFEHYHsFquNu1rt+Vxqp+3mxTbIfHOqg3COuZEG9+X5RxGwJab4qp
 +ccIQl4lNAEh9yzFVPLuim4ANuvMas2w2zBcjuT1rsFkzLLW6ZDWdsM2tquRrtWoRs7GHthMfKJ
 aPp/3SviN2mwDkpAmXHE8/lDAFk+KqTmk2zV7FsxouY0fdzcjj4cuB+fqrleP6ON69uGy6glTx1
 fJ5NNUw5ltw==
X-Received: by 2002:ac8:5f13:0:b0:532:8423:1e78 with SMTP id
 d75a77b69052e-532f8eef5afmr573491cf.10.1790177574693; Wed, 23 Sep 2026
 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 08:32:43 -0700
X-Gm-Features: AclHuK8Inh8u6lJouEWaJf_8_dOxdEc__Ja8ROlufrRS70N8N3MQ9iMsAEM4G5I
Message-ID: <CAJuCfpEa8tUmYJBjx-cRdAE8y-jcKY0C81kAOa1QZS7F6tKdfQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/40] mm/vma: predicate setting mmap_prepare VMA
 fields on new vma alloc
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
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
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
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
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> It only makes sense to manipulate VMA fields if we allocated a new VMA,
> rather than merged it.
>
> VMA merging does not compare vm_ops or vm_private_data, so a merged VMA
> keeps its own, which is also what the legacy f_op->mmap path does since i=
t
> never touches an existing VMA. Previously set_vma_user_defined_fields()
> overwrote the merged VMA's fields with those set for the new mapping. In
> practice these are the same values, with rare exceptions such as shmem
> selecting vm_ops based on whether the file has been unlinked, so no
> user-visible change is expected.
>
> Make this dependency explicit, and additionally constify have_mmap_prepar=
e
> while we're here.

The fact that we might be overriding attributes of an existing VMA
that we merged with is technically a bug even if we never hit it,
right? If so, should we have:

Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")

>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index fa784f069da4..4b74b48c29b7 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2894,7 +2894,7 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
>  {
>         struct mm_struct *mm =3D current->mm;
>         struct vm_area_struct *vma =3D NULL;
> -       bool have_mmap_prepare =3D file && file->f_op->mmap_prepare;
> +       const bool have_mmap_prepare =3D file && file->f_op->mmap_prepare=
;
>         VMA_ITERATOR(vmi, mm, addr);
>         const pgoff_t anon_pgoff =3D addr >> PAGE_SHIFT;
>         MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_flags=
, file);
> @@ -2937,7 +2937,7 @@ static unsigned long __mmap_region(struct file *fil=
e, unsigned long addr,
>                 allocated_new =3D true;
>         }
>
> -       if (have_mmap_prepare && !map_is_anon(&map))
> +       if (have_mmap_prepare && allocated_new && !map_is_anon(&map))
>                 set_vma_user_defined_fields(vma, &map);
>
>         __mmap_complete(&map, vma);
>
> --
> 2.55.0
>
