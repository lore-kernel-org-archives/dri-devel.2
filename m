Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25062C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338C410E44C;
	Fri, 25 Sep 2026 07:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Li2pE3fA";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC9C10E92C
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:09:53 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-52faa58bff5so276961cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790179793; cv=none;
 d=google.com; s=arc-20260327;
 b=ao0StDMqlctvY2hOV3+hIVODUWh8H0TDoRekOtoLke2ZG9Tpqqx0oPk5NJlDwwj8Ki
 ecVx4Ml1+aSKq+uI1VHSsOEB6dyyecH6Qva+sJbd+fkUI+H3rHOcK4enRxSrqhIj09FS
 9KPGGNsIApBepNAmjGvWiJBCwafV3yOSFvnc47exsmUO4h2Iu5BYtCY9YDJd8zngC2ry
 fOCKZpJ6cUCDsoIvE6VriEiE4LW6HEJ5bvE4Zqm7kkYN9zYrBY0sijOIMhBGa8tXFcNZ
 JY/O0Jwt/TTDPaFdJT8SzthOIefjyXitk5RZct/fNGvkh59BT04v8dudYwYTree3gl6A
 r2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
 fh=oc3mJnFtSGHHvxF/qDKa2nWr3TdBORueoF86TiQR1DU=;
 b=PVoP44w5+JLkYLOJpVL5Zvt9lk4ePFaDV1T2/MTKCqnTP8mTsg2Z2GAKrB1PGpl9l5
 hdf07ghdWQ1XxwC5gMZebPzfq5CoskTHN7yhr60IfCIXJS4n1C+PFN6cT0KwIhoy7DWt
 44tl5EVLDA/njbZEKDWautPUkIcLTG5m/f7AKy+3LEjDHj5eakfGCzZd9NG0+XqJ5smg
 LtcHtzT0M3U8WHmjs5njbXV6m4M8Eewbk+fM4Gb24TzIAk+kGMPx9ptovdY+1C4Lk9ng
 6gdSvBoV3ZVrcVMXBXEoNYvdUHI+QYJe596eKznzMEdljelMl4EzCmWSkIYd4wDzoTMX
 L21g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790179793; x=1790784593;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
 b=Li2pE3fAXQcV3XqMA9ZkSFZQYQ0C8V6TKSFbzxjT+lR/1wzD4ngMv1/BhOw2g2xIWf
 jpapMqzxJRi6fi1pw8pKKH107rh7/mAq7fD0D/BxXsasDT9qtmirhiTg4mik37eqzVqZ
 mvxcwUNBUltZKnTS3b2cQYmp+4wy2cI/7Wryy6rHxaZUWMdOSe8pmRvMT988UU7fDTJ3
 A5VP6f5QoVdhA/XW5eSCTnqem05AuDCAohErPXUn7HC+f8UFmYqhDvX8Oi9nT8d4x0u0
 YJWKQINSQeAcaj5PymUWUD6e6BdYYQg/5W7WatTxxwDU15kuAtGt2fjaUgiin4qPIqAi
 uSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790179793; x=1790784593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HHWyBmRaGzTNumsbsfRRD90WYZuPVsFs3XssqLSLFrU=;
 b=WJJNmZzwU6ZJIdif/gH2P4cwWap/3KXh7t+JJrY8A4aaHrcRTHqV2EIWBJ9Q+OEXPh
 Cvg0kRgl0zvkuW6TBp+GRcaDWxmccBUJtZs4OsydaELYkWHYGt3/ZkzZcEipgNumovhM
 CNMIOvY65i/nqPw9tlG8xrhEL22QXKizbKORLuRJl97U+yGrtc+6AX3403y2eSSfiZxx
 mVR4skv9OjATVua5kdPC7ICwkomUaZLdpj+hHqL/U7ZlPBpziGvvZdi7cH2NEhT9ly7h
 9tKgxTXRG2VJIJ0+Alzb2nF8bp0lpzvlhAyvYOdJd8YcNgADHPm7s/FM1PLkXzLoee9i
 l1zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNP4kMHFf2saNQ4E9AkQueKnj1tgoT5BcGqCylwtkfuEdfuBw97rKAEuKxBPRq9c8u3QaZpyTMOaQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kb6Tcg+NKUS9SDcpV7RZhNE3WKwmJnIF/o3yibJuAf1K2BcqlI
 WKzuG7d5A00xkwZVcWtsciZ/IP0W8rVacoZjVYDBi7BUJNqGPWJ5GxlqJD1tCVExaYYDGEzsOgT
 C7DAlXJ0UmlJlpc3NTxD2CmI+G44D7tZOo+QNza1H
X-Gm-Gg: AYBFou0KEizHpRb9uj3c1tbeqHJSb531EWyIBJZiOY4Fqzqk59K3oKSXMA04fpORoJx
 rMe+zBiBuBo2xGATYAetTD/7ykuMxrGMkrHokajtiIc330aFEDcKukvtf9QFmsSW4ZCKoPaaZN7
 mfEgTW8bV5pLLxIReKisF+fuNcJA7LVaRyXvSN5cMxXlRTIJrzfRCKMmCtYzY4aRkzFYIAvjf1n
 z08t6R/Zjt99kWOSihGD5PpW4XLxqxtluq6F2xLCCTH1jI4SG7JDJOJNd42+BlHa2Ig7pqs7ZvW
 gK/StZU2yOG+0KX3Kgh0MBTL8ETMzHxd2RLLwGDFqKwEijpWTQ4lxYgNTM1O4NKCSXlZoqkRQlk
 nUqOY87DlPlQ=
X-Received: by 2002:a05:622a:591b:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-532f8b3b7d0mr1642301cf.0.1790179791981; Wed, 23 Sep 2026
 09:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-2-4583d8a23bca@kernel.org>
 <CAJuCfpEa8tUmYJBjx-cRdAE8y-jcKY0C81kAOa1QZS7F6tKdfQ@mail.gmail.com>
 <arP0oJgrgZlgtrb6@gremlin>
In-Reply-To: <arP0oJgrgZlgtrb6@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:09:38 -0700
X-Gm-Features: AclHuK-pjLwt7GcAJrmXZc-kWYiEiXZ02rewi0rtPA2ju4vBD2OPEsiN1JlMpG0
Message-ID: <CAJuCfpFPPGaK-grNx9qiQOhzAXbxU+SO+95Fht1571TGREx2oQ@mail.gmail.com>
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

On Wed, Sep 23, 2026 at 8:54=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Wed, Sep 23, 2026 at 08:32:43AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 17, 2026 at 9:24=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > >
> > > It only makes sense to manipulate VMA fields if we allocated a new VM=
A,
> > > rather than merged it.
> > >
> > > VMA merging does not compare vm_ops or vm_private_data, so a merged V=
MA
> > > keeps its own, which is also what the legacy f_op->mmap path does sin=
ce it
> > > never touches an existing VMA. Previously set_vma_user_defined_fields=
()
> > > overwrote the merged VMA's fields with those set for the new mapping.=
 In
> > > practice these are the same values, with rare exceptions such as shme=
m
> > > selecting vm_ops based on whether the file has been unlinked, so no
> > > user-visible change is expected.
> > >
> > > Make this dependency explicit, and additionally constify have_mmap_pr=
epare
> > > while we're here.
> >
> > The fact that we might be overriding attributes of an existing VMA
> > that we merged with is technically a bug even if we never hit it,
> > right? If so, should we have:
> >
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback")
>
> It's not a bug, it is an in-built assumption that the state used to asses=
s
> mergeability implies the same properties.

Hmm. What prevents two VMAs with different vm_private_data members to
be merged? IIUC is_mergeable_vma() does not check vm_private_data. In
such a case set_vma_user_defined_fields() would override
vm_private_data of an existing VMA, no?

>
> And if it was, it'd need fixing a different way (check the field for inst=
ance)
> and would apply to the legacy mmap hook also.
>
> This change is needed for the series though.
>
> >
> > >
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!
>
> >
> > > ---
> > >  mm/vma.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index fa784f069da4..4b74b48c29b7 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -2894,7 +2894,7 @@ static unsigned long __mmap_region(struct file =
*file, unsigned long addr,
> > >  {
> > >         struct mm_struct *mm =3D current->mm;
> > >         struct vm_area_struct *vma =3D NULL;
> > > -       bool have_mmap_prepare =3D file && file->f_op->mmap_prepare;
> > > +       const bool have_mmap_prepare =3D file && file->f_op->mmap_pre=
pare;
> > >         VMA_ITERATOR(vmi, mm, addr);
> > >         const pgoff_t anon_pgoff =3D addr >> PAGE_SHIFT;
> > >         MMAP_STATE(map, mm, &vmi, addr, len, pgoff, anon_pgoff, vma_f=
lags, file);
> > > @@ -2937,7 +2937,7 @@ static unsigned long __mmap_region(struct file =
*file, unsigned long addr,
> > >                 allocated_new =3D true;
> > >         }
> > >
> > > -       if (have_mmap_prepare && !map_is_anon(&map))
> > > +       if (have_mmap_prepare && allocated_new && !map_is_anon(&map))
> > >                 set_vma_user_defined_fields(vma, &map);
> > >
> > >         __mmap_complete(&map, vma);
> > >
> > > --
> > > 2.55.0
> > >
>
> --
> Cheers, Lorenzo
