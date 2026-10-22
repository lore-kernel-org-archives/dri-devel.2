Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D9606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uzv+GHKU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270D010E397;
	Thu, 22 Oct 2026 06:06:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2523D10E397;
 Thu, 22 Oct 2026 06:06:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 992B560211;
 Thu, 22 Oct 2026 06:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240181F000C1;
 Thu, 22 Oct 2026 06:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792649204;
 bh=39Xz6kiHucTz2MqhdH1twx0TufHy3rTxBBlsI6v2y+k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uzv+GHKUw8R5uFwvnPGG3P1fWkOMgSyjJSG9yuL7MXjoPo2sRKa+nRYYvfdHcHrwD
 +Tr3lc5pl0QW4l6hYmb8zqlF/qMynTPgonkBDFAz4AK3pzBSIIbipGc+tFA80LH1Bf
 SBZvDl3Umko8111LBpTmR1kWYEQhDEVeUsu3hBy6pXBsaKmwnW7P0eiit2r/+1DX70
 fFflM1m/iLa+HQG5BjQ8+LPlr3GC9l08QMs510v53nLjWnQKqDAK9CZsJhQTs8u5E8
 3GMHt43BNKTptbiZIUql7Y9IqgHrSoq6Xe515vi1THfs4LbzXa8a11Gk20LJuvtKxL
 /anKfFnjlHJyg==
Message-ID: <sashiko-outbox-181058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/12] lib/test_hmm: add a new testcase for the
 migrate on fault
To: mpenttil@redhat.com, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, "David
 Hildenbrand" <david@kernel.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Balbir Singh" <balbirs@nvidia.com>, "Zi Yan" <ziy@nvidia.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Lyude Paul" <lyude@redhat.com>, "Danilo
 Krummrich" <dakr@kernel.org>, "Marco Pagani" <marpagan@redhat.com>
In-Reply-To: <20261021060506.2377545-11-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-11-mpenttil@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 06:06:42 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mm: test_hmm: unmapped device pages on retry in do_fault_and_mig=
rate()
- [Medium] selftests/mm: pre-faulting buffer in migrate_on_fault skips hmm_=
do_fault()
--

commit 43a1dd324a1ecfe103c0cf9ba76ea8935506e50c
Author: Mika Penttil=C3=A4 <mpenttil@redhat.com>

lib/test_hmm: add a new testcase for the migrate on fault

This commit adds the HMM_DMIRROR_MIGRATE_ON_FAULT_TO_DEV ioctl to the
test_hmm driver to test faulting and migrating memory to device private
memory via hmm_range_fault(), along with a corresponding kselftest.

> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index f05f801b8404b..2045896493ae3 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c

[ ... ]

> @@ -1377,6 +1398,127 @@ static int dmirror_migrate_to_device(struct dmirr=
or *dmirror,
>  	return ret;
>  }
> =20
> +static int do_fault_and_migrate(struct dmirror *dmirror, struct hmm_rang=
e *range)
> +{
> +	struct migrate_vma *migrate =3D range->migrate;
> +	unsigned long timeout =3D
> +		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> +	int ret;
> +
> +	do {
> +		mmap_read_lock(dmirror->notifier.mm);
> +
> +		/* Fault-in pages for migration */
> +		ret =3D dmirror_range_fault(dmirror, range);
> +		/*
> +		 * Set this up even on error: hmm_range_fault() may have collected
> +		 * part of the range before failing.
> +		 */
> +		migrate_hmm_range_setup(range);
> +		if (ret) {
> +			/*
> +			 * dst[] entries are empty, so this marks every collected
> +			 * migration as failed. finalize then restores the source
> +			 * mappings and drops the associated locks/references.
> +			 */
> +			migrate_vma_pages(migrate);
> +			migrate_vma_finalize(migrate);
> +			goto unlock;
> +		}
> +
> +		pr_debug("Migrating from sys mem to device mem\n");
> +
> +		dmirror_migrate_alloc_and_copy(migrate, dmirror);
> +		migrate_vma_pages(migrate);
> +
> +		mutex_lock(&dmirror->mutex);
> +		if (mmu_interval_read_retry(&dmirror->notifier,
> +					    range->notifier_seq))
> +			ret =3D -EBUSY;
> +		else
> +			ret =3D __dmirror_migrate_map_locked(migrate, dmirror);
> +		mutex_unlock(&dmirror->mutex);
> +
> +		migrate_vma_finalize(migrate);
> +unlock:
> +		mmap_read_unlock(dmirror->notifier.mm);
> +	} while (ret =3D=3D -EBUSY && !time_after(jiffies, timeout));
> +
> +	return ret;
> +}

[Severity: Medium]
What happens in do_fault_and_migrate() if mmu_interval_read_retry() returns
true after migrate_vma_pages() has already migrated the folios?

When mmu_interval_read_retry() is true (for example, if an invalidation bum=
ps
dmirror->notifier.invalidate_seq after dmirror_range_fault() drops
dmirror->mutex, such as during migrate_vma_unmap() on a shared page or
split_huge_pmd() in migrate_vma_insert_page()), __dmirror_migrate_map_locke=
d()
is skipped and ret is set to -EBUSY, but migrate_vma_finalize() still commi=
ts
the device private entries into the CPU page tables.

On the next iteration of the retry loop, dmirror_fault_and_migrate_to_devic=
e()
has configured migrate.flags with only MIGRATE_VMA_SELECT_SYSTEM:

    migrate.pgmap_owner =3D dmirror->mdevice;
    migrate.src =3D src_pfns;
    migrate.dst =3D dst_pfns;
    migrate.flags =3D MIGRATE_VMA_SELECT_SYSTEM;

Because the pages are now in device private memory, the retry walk in
hmm_range_fault() will not set HMM_PFN_MIGRATE on them, and
dmirror_range_fault() also skips dmirror_do_fault() when HMM_PFN_REQ_MIGRATE
is set:

    /* update device page table after migration */
    if (!migrate)
            ret =3D dmirror_do_fault(dmirror, range);

Won't this leave those migrated pages missing from dmirror->pt, causing the
subsequent dmirror_do_read() call in dmirror_fault_and_migrate_to_device() =
to
fail with -ENOENT?

[ ... ]

> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selft=
ests/mm/hmm-tests.c
> index e5f273ca84c10..897ff2eb34061 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c

[ ... ]

> @@ -937,6 +944,53 @@ TEST_F(hmm, migrate)
>  	hmm_buffer_free(buffer);
>  }
> =20
> +
> +/*
> + * Fault and migrate anonymous memory to device private memory.
> + */
> +TEST_F(hmm, migrate_on_fault)
> +{
> +	struct hmm_buffer *buffer;
> +	unsigned long npages;
> +	unsigned long size;
> +	unsigned long i;
> +	int *ptr;
> +	int ret;
> +
> +	npages =3D ALIGN(HMM_BUFFER_SIZE, self->page_size) >> self->page_shift;
> +	ASSERT_NE(npages, 0);
> +	size =3D npages << self->page_shift;
> +
> +	buffer =3D malloc(sizeof(*buffer));
> +	ASSERT_NE(buffer, NULL);
> +
> +	buffer->fd =3D -1;
> +	buffer->size =3D size;
> +	buffer->mirror =3D malloc(size);
> +	ASSERT_NE(buffer->mirror, NULL);
> +
> +	buffer->ptr =3D mmap(NULL, size,
> +			   PROT_READ | PROT_WRITE,
> +			   MAP_PRIVATE | MAP_ANONYMOUS,
> +			   buffer->fd, 0);
> +	ASSERT_NE(buffer->ptr, MAP_FAILED);
> +
> +	/* Initialize buffer in system memory. */
> +	for (i =3D 0, ptr =3D buffer->ptr; i < size / sizeof(*ptr); ++i)
> +		ptr[i] =3D i;
> +
> +	/* Fault and migrate memory to device. */
> +	ret =3D hmm_migrate_on_fault_sys_to_dev(self->fd, buffer, npages);

[Severity: Medium]
Does TEST_F(hmm, migrate_on_fault) actually trigger page faults during
hmm_range_fault()?

Writing to every element of buffer->ptr in the initialization loop populates
all PTEs in the range as present and writable before
hmm_migrate_on_fault_sys_to_dev() is called. When hmm_range_fault() then wa=
lks
the range with HMM_PFN_REQ_FAULT | HMM_PFN_REQ_MIGRATE, hmm_pte_need_fault()
in mm/hmm.c sees HMM_PFN_VALID on every PTE and returns 0:

    /* If CPU page table is not valid then we need to fault */
    if (!(cpu_flags & HMM_PFN_VALID))
            return HMM_NEED_FAULT;
    return 0;

As a result, hmm_record_fault() and hmm_do_fault() are never invoked during
the migration walk. Should part or all of the buffer be left unpopulated
before calling hmm_migrate_on_fault_sys_to_dev() (similar to TEST_F(hmm,
anon_read)), and could this also use the existing hmm_buffer_alloc() helper
instead of open-coding the buffer and mmap allocation?

> +	ASSERT_EQ(ret, 0);
> +	ASSERT_EQ(buffer->cpages, npages);
> +
> +	/* Check what the device read. */
> +	for (i =3D 0, ptr =3D buffer->mirror; i < size / sizeof(*ptr); ++i)
> +		ASSERT_EQ(ptr[i], i);
> +
> +	hmm_buffer_free(buffer);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021060506.2377=
545-1-mpenttil@redhat.com?part=3D10
