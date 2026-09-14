Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43087C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1826410F9A4;
	Tue, 15 Sep 2026 07:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.b="IrDlEwY3";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB7710F1AC
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 19:57:42 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86b90133ae8so1980657b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415862; cv=none;
 d=google.com; s=arc-20260327;
 b=Mg2ZUOWDPByLAP4J8h8xnOwMvKro0Xmnd18rlTNSdkCPamjwjW9/RokDhqfjs3Q0bj
 G/LnKZlJ8DBa/h9wwnBRLjTF//R1wCF61+Pv7wq1cIb2l2WORMYNNEImSqk3qznXuLmr
 bRnErGWS3gH6S8jV4UPjlW6CHK17v98xz/Lw0R+oa9/s/KUS0no/4bYpIOs+Te7pxIUv
 EVh3LgqbPNyzn0JvspspCx5dvM2Gsuj302AFHjF8+edksW+TRNnyAQNz2hDGB5aMb8Gk
 zWuIw1DL4tKHLf2/vhbUgcxGTLbmUvIfNwdzpkA1I561+dhFBwcyaL4YzX4qHL+zxB+m
 Hdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
 fh=khzl13nnk9jxktNTTUUxJs+/cHR9HBRFYz5/0q/ctrM=;
 b=LHUBgpUUZfsGs678N098eIPum76V23iIi4FJNOKItY5LtYZVNeKfjfUXojy0rypGBR
 Jko15cp+2cICOIK8lk8H0ZOBhDcv9XgB96DYMxopo2Cq0yIgzRZBRfiTAt9zGeHeG32A
 jfNATMg3cSQVKiyfNAML9ZIEXhMLsS4mDyLhEYsaDYXskWl9gvZsfeyo/ctu7SoJiI5m
 LRSJp0PZCDKndxlhF80KeRf+eMB3iiRD2Jwu8Zh1ZKebgZwnYKfp954uKgEIquo2JNsT
 2ENjPeVi7XfwvxYO49DFxeIkjr18vIxpAL/1y5xKQuArlwwJdqNLugLeHSFk9sfr+VAE
 5PAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1789415862; x=1790020662;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
 b=IrDlEwY3oe7kesxfgkv2Sa4c/naO1WW3ASAg6zNcRkFD/qRQlcjoXVhbiiYhcsKg8V
 dldWlYy/v520MtS8zPVxXUqcB0cUkQ38KrRDMoMQeQN4mlU+l+1QHmBqg5fjYcC2vjzm
 OLSmleTWGfYmodEOAdFnwhlB3aVQh49tq1BBCIh+PrI5GDbTB95e2IkuWb2daDb5m98K
 Q1Z/qjY5owzsDaJHCo6AqsEYU0XDM3lb3SgMDEoXx1WIHWk8hQw1LTL9idVqR1omRlcZ
 2hjcBa7mHumM4AgbPRjSlEKF11Qwm6wQ5FhVZjRnzbZFJjvnE/yUK35uZd9wu1Hte+hW
 m4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789415862; x=1790020662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
 b=U+evI9kFBp5v952+GVAYmFG9ncXFXp3vc0rhGk/LNpMf4cb3vr/9Gsl/h8Y0Patzwv
 YrBdOugChbk2RzMkh6hH+4fZU0zJreeI9GsdA9uP0zGN2gQKzh7GuQpGAYC3f5fVDYDf
 AwdtoV+w4PIgQIil2ftRCBELB67IMhzWdgo62uo40KE+NTm8hUQCOeES7wTWbSowt2cp
 zA/bCiuuLObfUZ+n0V4S98MJgfLiNnT/W0r8yl43MxhnH6p7p7y5WhGLMs+DGZ52gnFY
 TQbPm03zbH56TXWI/cvAEa9IYtCDGE9YkAlOxaGoTG9hqJ5rS9q3ymhL5FiqP7dYwola
 UnSw==
X-Forwarded-Encrypted: i=1;
 AKwUvByk2mKT9fU9tGACH5T5lSYqcIHx0nytsHopFpSw2V7FYOUTphwAp7Qs9yhO/0ZjOjbIukmZrGydsJo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0UFlTOivBp7+bBOoCit9YBFWxtaAnseNm3378b0tdb7s11Cr1
 zDy1PmjJDfgai+u1G3HVL5cTdwqoYP/M9mpyJgzV8Vep3HtfJdrSiUZuPvGbXZC33rl0b1URMi7
 tTo8VJFj3V0ZEm3bZRTOVb8pVoHw1F/3mW8K3BUb9
X-Gm-Gg: AYBFou0jbuHi/rqZzkLVh6UMC8482WgaxwobwVH856Nqt78h5UKG+ZT+y8cxqluXqP0
 vvudDmV+AyvIzd4Dstj6AhTSds/O4Ajv7balJbdj1oG5EYAEvhHyWH5DkQah4vMNZGEappaJAyG
 WyI3Jk3SlKE2zF2wFeem3VURnkfG8eLg1pak6Xy5U0axb3ss4kk78bBc+AIYLD/0LTJMb1PmFmg
 o8SN7QIAxTIdc97lcqBs3kHmQpsOG6vQl7oBj1BoIouUMBAN9c/gBkLF5quQ4yVd2oISyS6rYAj
 rUIGQnrCni3M5FozxMH2p6MHo0pLrWYDij9P5MPCDL1f13L0jWaIUIYqMOQODSrJ1QAIan8ZcTZ
 nCokbTCV6r18=
X-Received: by 2002:a05:6a00:18a9:b0:858:b809:6ec0 with SMTP id
 d2e1a72fcca58-86f869a920dmr8896742b3a.23.1789415862342; Mon, 14 Sep 2026
 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 15:57:29 -0400
X-Gm-Features: AcwNN1XaLRK0KaZAmfcRvdaBSkZOdh14LF1fb-xWULoFVhBfqyRklsdKoWBmLag
Message-ID: <CAHC9VhQ3TwdGGH6YtVyMqJX4avJwsadcRvRhAoUhCvJEHk=i=g@mail.gmail.com>
Subject: Re: [PATCH v2 12/40] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>,
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
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:27:57 +0000
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

On Mon, Sep 14, 2026 at 11:05=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
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
>
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
