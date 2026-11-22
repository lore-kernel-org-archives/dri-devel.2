Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498F606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ijxLbAOa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A9B10E499;
	Sun, 22 Nov 2026 17:37:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5970B10E718
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795369036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3khkEbh3+4+UW9EqZNzFj2fkzRmCDGkNMhSbTs+zklo=;
 b=ijxLbAOayjsBBW6egURZWzzAOE/yP9cp5E94apNRkiY3hBLG1pqO+lRROovHmAt3GMAKKN
 TrsjWo6atYWxbBLtcSG0zAIwsMWR5NdIiKrmq2owByX50p7MPof1Tc5AOZ6CVSW3dUcRd6
 sHWiY+vxcxur8WVuOEMBtgjgNr2ybwA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-TYQpH3Y7PgqDORByPXigaQ-1; Sun, 22 Nov 2026 17:37:14 +0000
X-MC-Unique: TYQpH3Y7PgqDORByPXigaQ-1
X-Mimecast-MFC-AGG-ID: TYQpH3Y7PgqDORByPXigaQ_1795369033
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bb9379a835so5643245e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795369033; x=1795973833;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3khkEbh3+4+UW9EqZNzFj2fkzRmCDGkNMhSbTs+zklo=;
 b=NHppZMSoTSgudgtvlMOjVxib9PBatJ9j2kbcOfz4Zzn+8ZWC129jnDiEPHXdTsPbDs
 mfsRtKKS6r9dAI913c9WTzQrYdUVoxe/hNc5Rupma/X4/+QRjnTdtxZ9/PIvva/HJfX2
 yka1lfXqcxDAieVTL5Ica5GDUBfMbUr7/berz2BzsDtBOB+cq0dk6rfqgomVaTnk1P/y
 lbanbrbPZ6cEYlOFTAl4gqgL1315YJbrEobwiA4Nda5hQsUJq5v/uI1/6Fm2Jd8KuijM
 BN3WfCypv4mmzDX02JQIcXfiaAyXszctuFyu+2eZ+7djqDWEhaLj5FFLM6m0T6FMp1Vo
 1f2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEbA23SU9IDL2ClcjpKwNdWbJdFtPQBgAw+pjWq8eE6p/TopH2a4CWOiOFT8sT1wPYpURtMTJqG16Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8gwQnf35+C9g+w69h2aHMRccUVzuZ3Ot8r+oo3j8O21pD21GHo
 dyFIENM1YLRchPDA0hwI98A5jRSNSQUESYKYi4jmR/xtSZlTOQePiO4KmGdMCHw/i7ri0/CDWW6
 llYc2qMmT+FQlV8pmWaSVqn1U3ty8A2WEKVn4ArS0Ih71/PKravkPfNleoF+mRvtwBeso
X-Gm-Gg: AZFdTZdWKoYZpOX3ayoL2adI8KtMBOx+t2cRuXw6jiS6jcFyUz4lWDV6nknjawc6eZ8
 nDDjEPs2+TkmqxIF2/6yNSMi9MD15A8tjFROwbpmZ0jaAhWXHm5b4FDCC5meMvvgU9TPzqI0WwD
 Z6J5aG6elxquGqekEycQUDGRfGVZ3+aDGvaiWeQD3HomJpy1ee5QSx+xGEkkWoBEH22Ws5PlwsK
 bjeF1cuakcf+KMTJ322ACVgW9STDfiLWzmlFmf8+TFXjy6C5TTpuj9DXYyyBthxDVNihMxyZZYb
 Gr4pzbcbsL/SdcxJPF4xC0r6foOs4w3m9La5V6nBTE9V/tUs8jB7l8zL2C5JUOJpRBztI7NoJ5G
 McNmbhfKGbqBFPTZ5ua9vB2DOH0LnqqMcT2NBas1dGDnBjnW7hJaY9Ob3U5jxXihoQdZSNHDDP1
 Ukt1Ei
X-Received: by 2002:a05:600c:674f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb8880fb9bmr195004235e9.23.1795369033363; 
 Sun, 22 Nov 2026 09:37:13 -0800 (PST)
X-Received: by 2002:a05:600c:674f:b0:4bb:56bb:1196 with SMTP id
 5b1f17b1804b1-4bb8880fb9bmr195003715e9.23.1795369032886; 
 Sun, 22 Nov 2026 09:37:12 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906cdcc1sm114828375e9.2.2026.11.22.09.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 09:37:12 -0800 (PST)
Message-ID: <2f60e148-f9ea-4b48-b8b9-3c524b6a8a2d@redhat.com>
Date: Sun, 22 Nov 2026 19:37:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: account for subpage offsets in device-private PMDs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>, airlied@gmail.com,
 apopple@nvidia.com, balbirs@nvidia.com, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, Francois Dugast
 <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org, jgg@nvidia.com,
 jgg@ziepe.ca, leon@kernel.org, leonro@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Brost <matthew.brost@intel.com>, mm-commits@vger.kernel.org,
 Patchwork <patchwork@emeril.freedesktop.org>, Shuah Khan <shuah@kernel.org>,
 SeongJae Park <sj@kernel.org>, thomas.hellstrom@linux.intel.com,
 Vlastimil Babka <vbabka@suse.cz>, ziy@nvidia.com
References: <179342234355.4.16705453209886955762@gmail.com>
 <20261121160037.1a479f3c8b4e860bc23c106d@linux-foundation.org>
 <36be0904-168d-4813-82ff-27ecced464e3@redhat.com>
 <20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org>
 <179535872126.34.4789080961796247940.b4-reply@b4>
 <af91d4a7-11ca-4f84-b8da-33ee1a585916@redhat.com>
 <20261122091419.f82e88761dbd12771fb6c976@linux-foundation.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20261122091419.f82e88761dbd12771fb6c976@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wd3w7fXU4vz0vVWLPrPV0NC1k4M_OZ9kYzype9TvHMA_1795369033
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/22/26 19:14, Andrew Morton wrote:
> On Sun, 22 Nov 2026 18:41:39 +0200 Mika Penttilä <mpenttil@redhat.com> wrote:
>
>> On 11/22/26 16:45, Aveline Noir wrote:
>>
>>> Hi Andrew,
>>>
>>> On Sun, 22 Nov 2026 01:52:46 -0800 Andrew Morton wrote:
>>>
>>>> Store the corresponding RAM backing page instead.
>>> This avoids the oops on the first read through the second descriptor,
>>> but leaves a stale backing page pointer after CPU faultback.
>>>
>>> Since the mirror XArray entries don't take a page reference, they rely
>>> on invalidation.  When the CPU later faults the page back to RAM,
>>> dmirror_interval_invalidate() skips MMU_NOTIFY_MIGRATE for the same
>>> mdevice, and dmirror_devmem_fault_alloc_and_copy() only clears the
>>> migrating descriptor's entry before the backing folio is freed.  The
>>> second descriptor still points to that freed backing page.
>>>
>>> Reading the same page again through the second descriptor in QEMU
>>> triggers a KASAN use-after-free in dmirror_do_read(), and the read
>>> returns the stale data instead of what the CPU wrote.
>> I think this is right, but a fairly artificial scenario: it needs two
>> descriptors open on the same test device in one test, a migration through one,
>> a read through the other, a CPU fault back, and then another read through
>> the second descriptor..
>>
>> The fix lets the device private page content be read without an oops
>> in the context of one fd which is an improvement. 
> May as well fix it.  I'll test this updated version.
>
> Mika, please feel free to take this over, perhaps integrate it (or
> something like it) into whatever you've got going on?  Or not, let me
> know ;)

I can handle it in the context where it made difference for me.

>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib/test_hmm: invalidate all mirrors on device-private migration
> Date: Sun, 22 Nov 2026 08:53:12 -0800
>
> When one open of the fake HMM device migrates a folio to device-private
> memory, a second open can fault the same address into its mirror page
> table. The second mirror then stores the inaccessible device page, which
> can oops the kernel when dmirror_do_read() copies from it. Store the
> corresponding RAM backing subpage instead.
>
> That conversion also makes the backing page's lifetime significant to
> the second mirror. migrate_vma_setup() notifies all mirrors before CPU
> faultback, but dmirror_interval_invalidate() skips the notification for
> every open on the same device. The faulting open clears only its own
> XArray entry. The other open can read or write the backing page after
> migrate_vma_finalize() frees it. Aveline reported a KASAN use-after-free
> and stale data through the second open.
>
> Handle migration invalidation for every mirror under its mutex. This
> clears pointers before faultback can free the backing pages and waits
> for an active mirror read or write. During system-to-device migration,
> the migrating open installs new entries after migration; other opens
> refault on their next access. Remove the now redundant XArray erase
> from the faultback copy loop.
>
> Extend the PMD migration selftest to read its last device-private
> subpage through a second open, then fault it back to RAM, change it,
> and read the new value through that open. The trigger is available to
> a process permitted to open /dev/hmm_dmirror* when CONFIG_TEST_HMM is
> enabled; it does not depend on physical GPU hardware.
>
> Link: https://lore.kernel.org/r/20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org
> Link: https://lore.kernel.org/r/179535872126.34.4789080961796247940.b4-reply@b4
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Aveline Noir <jm5905938@gmail.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
>
>  lib/test_hmm.c                         |   20 +++++++-----------
>  tools/testing/selftests/mm/hmm-tests.c |   25 +++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 12 deletions(-)
>
> --- a/lib/test_hmm.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
> +++ a/lib/test_hmm.c
> @@ -292,6 +292,12 @@ static int dmirror_do_fault(struct dmirr
>  		page = hmm_pfn_to_page(*pfns);
>  		WARN_ON(!page);
>  
> +		if (is_device_private_page(page)) {
> +			struct folio *folio = page_folio(page);
> +
> +			page = BACKING_PAGE(&folio->page) +
> +				folio_page_idx(folio, page);
> +		}
>  		entry = page;
>  		if (*pfns & HMM_PFN_WRITE)
>  			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
> @@ -327,14 +333,6 @@ static bool dmirror_interval_invalidate(
>  {
>  	struct dmirror *dmirror = container_of(mni, struct dmirror, notifier);
>  
> -	/*
> -	 * Ignore invalidation callbacks for device private pages since
> -	 * the invalidation is handled as part of the migration process.
> -	 */
> -	if (range->event == MMU_NOTIFY_MIGRATE &&
> -	    range->owner == dmirror->mdevice)
> -		return true;
> -
>  	if (mmu_notifier_range_blockable(range))
>  		mutex_lock(&dmirror->mutex);
>  	else if (!mutex_trylock(&dmirror->mutex))
> @@ -1198,7 +1196,6 @@ static vm_fault_t dmirror_devmem_fault_a
>  
>  			src_page = pfn_to_page(page_to_pfn(spage) + i);
>  
> -			xa_erase(&dmirror->pt, addr >> PAGE_SHIFT);
>  			addr += PAGE_SIZE;
>  			copy_highpage(dst_page, src_page);
>  		}
> @@ -1822,9 +1819,8 @@ static vm_fault_t dmirror_devmem_fault(s
>  	}
>  	migrate_vma_pages(&args);
>  	/*
> -	 * No device finalize step is needed since
> -	 * dmirror_devmem_fault_alloc_and_copy() will have already
> -	 * invalidated the device page table.
> +	 * The migration notifier has invalidated all mirror page tables
> +	 * before the backing pages can be freed.
>  	 */
>  	migrate_vma_finalize(&args);
>  err:
> --- a/tools/testing/selftests/mm/hmm-tests.c~lib-test_hmm-invalidate-all-mirrors-on-device-private-migration
> +++ a/tools/testing/selftests/mm/hmm-tests.c
> @@ -2087,6 +2087,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	void *old_ptr;
>  	void *map;
>  	int pagemap_fd;
> +	int fd2 = -1;
>  	int *ptr;
>  	int ret;
>  
> @@ -2143,12 +2144,36 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  		}
>  
>  		close(pagemap_fd);
> +
> +		/* Read a device-private subpage through another open. */
> +		fd2 = hmm_open(variant->device_number);
> +		ASSERT_GE(fd2, 0);
> +		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
> +		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> +		buffer->ptr = map;
> +		ASSERT_EQ(ret, 0);
> +		ASSERT_EQ(buffer->cpages, 1);
> +		ASSERT_EQ(*(int *)buffer->mirror,
> +			  (npages - 1) * self->page_size / sizeof(int));
>  	}
>  
>  	/* Fault pages back to system memory and check them. */
>  	for (i = 0, ptr = buffer->ptr; i < size / sizeof(*ptr); ++i)
>  		ASSERT_EQ(ptr[i], i);
>  
> +	if (fd2 >= 0) {
> +		/* This open must not retain the freed device backing page. */
> +		ptr[(npages - 1) * self->page_size / sizeof(*ptr)] = -1;
> +		buffer->ptr = (char *)map + (npages - 1) * self->page_size;
> +		ret = hmm_dmirror_cmd(fd2, HMM_DMIRROR_READ, buffer, 1);
> +		buffer->ptr = map;
> +		ASSERT_EQ(ret, 0);
> +		ASSERT_EQ(buffer->cpages, 1);
> +		ASSERT_EQ(buffer->faults, 1);
> +		ASSERT_EQ(*(int *)buffer->mirror, -1);
> +		ASSERT_EQ(close(fd2), 0);
> +	}
> +
>  	buffer->ptr = old_ptr;
>  	hmm_buffer_free(buffer);
>  }
> _

--Mika

