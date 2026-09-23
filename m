Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4D9C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0598410F91B;
	Fri, 25 Sep 2026 07:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jezB+Rmy";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A479710E93E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:23:58 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-52faa58bff5so282471cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790180637; cv=none;
 d=google.com; s=arc-20260327;
 b=H7h4UWo18Db1tyhG0cT2JZwkl0ctjGqpxVhJYS3/4ecZc01BBaF8C9R1ckAeWAK37f
 C1p2o24Y+964sgGXfvsTiA1D5DEer4kzyes1f9FSKCo5A6BLUHciE0vzLXvUSi/gSVmE
 ux5FoSDOw2XWezP9ou8pgek0pNvb5KKIYTRDLCHwmVThsnK63gL7+9BTDqdY3AJQx6cD
 MVihUAZeTvLfyu7+zYsO5uAhWulgR044bzphqmVaWEM8SXhK5DNAOkhzayjC+UBNXjBD
 6OKw3fSBlG2FCr6ZF+EfocW1FfSFfFKQkkylRGEESHPDz71T5LzWxMx4reZOmfiq4edb
 JIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
 fh=ZmEySal3m883EhTJx1bIA0I/bO0BxFZxiBqDSGdA5dg=;
 b=A3LEgQI8gRdqaghHOI+rayrnKNVO3a27S1HC9EV2oYt/j9nKu51CgFbzTYtwDzJV04
 5aVuyPFqZRoAPvCH1Xnu1ThGpieMOXkE6woO63tiJ/6JYKTg5gmL+5NTGmo0n+uLvgua
 e5XEPiTa+B8Q75CAFegmgrqP/0i9LjRlEsNgZkTs2yznzB/8dGp4Mxy8qCmZ+If7q2Wh
 fKlQCWiOEeCvJ5GwdOqIysE376aN1LnqrQrqujTRzcjFlXIIwqJM/6/R0r2nZtVWtZoc
 SX5X7EAekm8OzSPj9RkKSJiRY68W3YZ/iMqhOLokYESDhDjJrRN9NlFqSQQa9SjJ6sHV
 xU9Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790180637; x=1790785437;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
 b=jezB+Rmywh8AJxPghZB7zyGLBVK1DXYn+dhNQPyN/YZ3vHDcqbbF9AJmHVflsX5rfI
 MWiMw2yJ4nMxpRRGuowGuXz2ps1MJ3AcTUVGcPmr1wCwA8Uc4gEYC6q8hCsvm+rSLyzu
 J0veqh/8wZm58oyyp8ElBmAw555MQ5vJe/GBAhHwAOQqp9wh2Ua8OzAURJN1jlGyGkdt
 jTTRyCPSOYfK4EMBsVFox4vngc51S9wP50BCJBiG+RiPZROOkzU8pETguv9XbiguB1DX
 OTZZDsfAVQyo+qjZMxVtKtbcvBudkM+ZV2AMKItt1scfS2kAhwL6PDwkkueVQbmJnjw8
 eypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180637; x=1790785437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3FzOqkymgnKp+HaLHwhofGZjaEcw2lbzuDYsddlgiEM=;
 b=hl8Rc529jearFVICQgxrMLj9lpGQ8cTtWKmQTPc62kilRuEf9vFsNEjQ97Vfd1D1AT
 Mx46ke8/IixK7tzejGXBz3aBsCK85wdSmvShBQIXB91WGINF6wzynykKVK4uZG0kxO+d
 mTiSy5Vu/16PoWoZ0ctskUYIHKEOLeVcoWh/unzSsHqgljCASQtFxLHFSUk5tthsRWI7
 tzdYhdET9TTghcMZi2BjrMY4GPgFZxlx75flPsRjyoNX3bKWpnyP8Ora2NKsOxaobBP6
 UoC7TL84BeY59MHzeQk0dnPY6gAeU0UNYDi3o/p+N2cDaXZj6kUGV+yD3i6aZozHawA9
 5fFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWh/SYNfPyocW3h7wyDdGG+R9vDFQlx3MWzD+DnOmgeN7kJ6bdx1N+QzUCZzIhIjl/i/Jq9KxZsKI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kv8+m9lRNUir935Qr8uXLyPLdu02qo7UOgvjOlkPGcOPbO+LIX
 NRDj7hutavSihtngNs6aVf7vCsE5Qh7UacPZyiY6EMJ3TNfY3SZsLl8B/av3oggZIXeBlMCqDQZ
 BEDJe7yegjnWAUiYhhPSgHlqTu10Ux0dUnT6MRUSK
X-Gm-Gg: AYBFou19JKFiSkq4SMmnnP9xXbs8iiHoODCMQIW9wd6crwzv/+D3282iQNtZFFKpxoy
 wGN5QTPBqobQW5oiWpSwmcMq1WesCwo7aZwMLtNLN6psHIiVP/UG7iDcAz9U5jsmAD+MOqvdWqf
 LH6O3ICLWO4ajBRWz9nkZga5ee7g3v9l+lWOH/HjWBxY0ddvZymYwi4yWbMLxQeWMfLt4tGW2AS
 FjW0iOSQ/nYhFSOBDEYxnZfZZDCkXnaRH5eQdE0UcJSf6H/iBkhvsaEB9j6DE9xkS8pUJ8erQFv
 IcwQJbJ3NVPhjAhupua6jPrmlapGwjOpKFUv1OqXazWiAZkKyK3GUqPNwX+rICbYtabmj8lgeOp
 RxqGwDXCc6Q==
X-Received: by 2002:a05:622a:609:b0:531:282:6560 with SMTP id
 d75a77b69052e-532f9d4a86emr439391cf.15.1790180636277; Wed, 23 Sep 2026
 09:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 23 Sep 2026 09:23:45 -0700
X-Gm-Features: AcwNN1U-1rGp6GFHFrF0qqhOHTzivX5krrdmfBch0hMHABT_yaCwm6D93D-Dyz8
Message-ID: <CAJuCfpE0WCr1Kp=+4EVJB7UdbH22HuCouOEtGMNCL+a8TnCQPQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use vma_[flags_]can_merge()
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
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic wit=
h
> two new functions vma_flags_can_merge() and vma_can_merge() and update th=
e
> merge logic to use the former.
>
> This abstracts the check and expresses it in terms of the desired behavio=
ur
> rather than an arbitrary and confusing VMA flag.
>
> This also lays the groundwork for making further improvements in VMA flag
> usage.
>
> Also update the userland VMA tests to reflect the change.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/mm.h              | 21 +++++++++++++++++++++
>  mm/vma.c                        | 19 +++++++++++--------
>  tools/testing/vma/include/dup.h |  5 +++++
>  3 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 969594074fd2..68250ece4219 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1612,6 +1612,27 @@ static inline bool vma_is_shared_maywrite(const st=
ruct vm_area_struct *vma)
>         return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_flags_can_merge() - Do the specified VMA flags permit the VMA to =
be
> + * merged with another?
> + * @flags: The VMA flags to test.
> + * Returns: true if the flags permit merging, false otherwise.
> + */
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
> +
> +/**
> + * vma_can_merge() - Do @vma's flags permit it to be merged with another=
 VMA?
> + * @vma: The VMA to test.
> + * Returns: true if the flags permit merging, otherwise false.
> + */
> +static inline bool vma_can_merge(const struct vm_area_struct *vma)
> +{
> +       return vma_flags_can_merge(&vma->flags);
> +}
> +
>  /**
>   * vma_kernel_pagesize - Default page size granularity for this VMA.
>   * @vma: The user mapping.
> diff --git a/mm/vma.c b/mm/vma.c
> index 4b74b48c29b7..05d2c676672e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -924,13 +924,14 @@ static __must_check struct vm_area_struct *vma_merg=
e_existing_range(
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
>         /*
> -        * If a special mapping or if the range being modified is neither=
 at the
> -        * furthermost left or right side of the VMA, then we have no cha=
nce of
> -        * merging and should abort.
> +        * If the range being modified is neither at the furthermost left=
 or
> +        * right side of the VMA, then we have no chance of merging and s=
hould
> +        * abort.
>          */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!left_side && !right_side))
> +       if (!left_side && !right_side)
>                 return NULL;
>
>         if (left_side)
> @@ -1152,9 +1153,11 @@ struct vm_area_struct *vma_merge_new_range(struct =
vma_merge_struct *vmg)
>
>         vmg->state =3D VMA_MERGE_NOMERGE;
>
> -       /* Special VMAs are unmergeable, also if no prev/next. */
> -       if (vma_flags_test_any_mask(&vmg->vma_flags, VMA_SPECIAL_FLAGS) |=
|
> -           (!prev && !next))
> +       if (!vma_flags_can_merge(&vmg->vma_flags))
> +               return NULL;
> +
> +       /* VMAs with no prev/next are unmergeable. */
> +       if (!prev && !next)
>                 return NULL;
>
>         can_merge_left =3D can_vma_merge_left(vmg);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 16c09dac59d9..2fd422789717 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1647,3 +1647,8 @@ static inline bool file_is_dev_zero(const struct fi=
le *file)
>  {
>         return file && file->f_op =3D=3D &zero_fops;
>  }
> +
> +static inline bool vma_flags_can_merge(const vma_flags_t *flags)
> +{
> +       return !vma_flags_test_any_mask(flags, VMA_SPECIAL_FLAGS);
> +}
>
> --
> 2.55.0
>
