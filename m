Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1511C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E024310EF32;
	Wed,  9 Sep 2026 06:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vcJPn1JB";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFD910E177
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:22:59 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff3aca07so1905ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 13:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788898979; cv=none;
 d=google.com; s=arc-20260327;
 b=cFp7abR884hQ9vdCI3g3dJ+M9QUv9D/qHvqHK7PaBHf1T3pMidlD0FHHciNZ+dQYS0
 9ghrBps98lfcMbSH1OoTYJpp1gf2IExetAEibbEer50ILqiv3cnRmO6YHXiIFWyj7TpD
 E3VGK+XL6SrjEFm4VcjudRIQLxxFWplTApHUsK6gmefpkAYHsFIXe2z+JN/fVgUqWF/I
 KyDq3942h5ZClulGsJAN9rAuTCNUJqIAELG+sF8GhFsddkYfSvPCGDLUGePENeOzzr2Q
 ZkQ/P7RSmWFt7QCIIVBmcALQ9b9z92uNyeTiC6QwrE9gnFX2D3/yJHw8lf17F8WpKpLf
 rfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
 fh=oeyUP3MOimLLIULZ+G0J13z0fCHlE+7d1qb9huE4DLU=;
 b=Xwou9mT2V+Tc2WWmTrxtqWTm0HZC73nWTEsxau2OMDSaUH511FPsTkDU6Wz77WDKj2
 Ngr+MtuW+y7XeVzbctgoAEqpGrfvgMTlW9M8SQTDdA50BovQ5QaCmF0QATrIu+I6ZCcx
 rs/fVcQTOqkVNpXtYfoTH0Q5FzXpZsX1u5rVr6z9ofo3D8HHUp6iDFhU79qztyCWi4Ne
 0x5+ubloqlZYbY7eTAbb8it8MynbkFwlco2pFgdbgmLJbkAQSrEFDTdnSEYOIT25rdyz
 uk01YNzBeJZ0iAZ0Zxo4upNzwLELmvN3VSStG56ZvST/UNTuu19RTh2VYP3BlqLlZ9Jh
 WuJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788898979; x=1789503779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
 b=vcJPn1JBoUAEmOoSYq8IbrX7p82npVRacZ9v69+opxUB9kaahDrG3uVNwT1eh2o+GJ
 Ts31W8XdZ6jVKug2MgvZ0Mj/a6pqLMfGK9XgZs/irTZvfTEmjCZ4CKG/ZN8Q1N1aeImX
 Ljr2s3wSvjkzexMOs0h80PTF9zj/PFIKqanQ97o+PTxvd3YN2zxvMNtraLWMhp/tB1Bv
 OFyjmGDa5t2iqE9mgrFNGQmu0XEQDogKoRKV/l2WOpDLXV692ZhfldqoWeogGFMvz64l
 XbHASguNRVvfkf90RRq4KvHLQ35nCEZvxomLHh18GAmuFfR00TdsUAAE8YvzXxId/WaM
 miFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788898979; x=1789503779;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TsLhOzf+D46xHpyx683mbvtqY0bc9njzNbabbHNEj0I=;
 b=l0EG435hSwfXtJHt+A6c6RQT1wmzGF0Q5vQeDlIpbbkleYsgVCJhq4cfU1munZ1vcH
 FxTf3xjg6z6vouFc0Ug6rmB8UbcsNCMSDQItmF6ZBz91CLZDHYtlMqZkx1Lp03amQbbJ
 X0lBR8GJUpnAeJHbRDkjV08/YldIfccwCU4IDelYkb11R57k3zBXAa6j5vzXCsa9wCmf
 uRUs5UKVH4l0YTZccbK5b3xAFhu4p/nIiaZfy5c+wZXE10Q8+e4f8id2R+Z3nP/3NRbj
 2Lsob5Q7jCmY99FgCxtoAEUtTEk/K8/naC+fIyXPljXIdDb8nm9rfD4KfLRE7eSdDitH
 yfww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBGQXmIrOcbPLTN4Co5Eqc+Jt2IhrS4elDYcLVc1zOIo5+UlYhc6kHqYLI9yMAypE1FadukNDTbK0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+V+zPPdJ2Nzj8I+3Q3RHvVCu9eQDvB6uvzbQSqg3hlIIA0lRU
 ZQw239rkTCzJGi6mcm9sHUe0C1HiAiHEuq/yB8CfkFrMwn6pXsQCRU5+iYq3OBq/hKw6qJkJl78
 X7JHAb8yKWt/JUuOfSM6IolhIk3YGEKLT1KSKYbeH
X-Gm-Gg: AYBFou28bYE/DixpFMdUIpOsV6m0ayBjYqmobMcV5BwlYuGga0SUC6oUYbQF0ng8vOZ
 9IDdDz2rqylYDHns0NzHNxIT5YttSTP1cWmYuuOVpFT6mU2UmSKSKYiRWPDwi7fGAS4KofzykZi
 9nZUgxdTOuwHQ7Ebx4gNCU1I/GXEKU9pVwLaQCS1UgGd3PADJ2P6ufd2rbO2qv1h50Mcd8lUZ2P
 QP6q+LH0cJiy3UXposCHBcEye2txkkpMDCz0N0bmul8gQQFye7n3kyzqugFr20kZkmM4VAUV/e4
 xwJFfNQZWWk/zR4jHPGdl0YCM76DWRSxdpL5GpBNb9ePQkXtnmllcEpYKDZoIFDYrusDBJ7A5fk
 7XSQBwHglh1DvDKHVWKl3YB22irCAEx3r
X-Received: by 2002:a17:903:fa4:b0:2d1:1d3d:97c3 with SMTP id
 d9443c01a7336-2dbfeccdf9bmr1436185ad.13.1788898978067; Tue, 08 Sep 2026
 13:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
 <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-11-dacf19cce22b@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Sep 2026 22:22:20 +0200
X-Gm-Features: AcwNN1W16jAho4HwK_fzY15wUA-qa4DGJ92-DrEx1Ojg_VFhiHj2JxDdZTxOKSI
Message-ID: <CAG48ez3Ucb8HyhjC1-fijFiYJsnWcTLYHvJjzMyU710mgegxnA@mail.gmail.com>
Subject: Re: [PATCH 11/39] selinux: reject writable opens of policy file, drop
 mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, 
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
 Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-rdma@vger.kernel.org, selinux@vger.kernel.org, 
 linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
 fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

On Tue, Sep 8, 2026 at 10:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.

You should also be able to remove the sel_mmap_policy_ops.page_mkwrite
handler, which is only for shared-writable faults, right?

> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>
