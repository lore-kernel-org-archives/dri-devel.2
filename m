Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B5606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QtATdAra
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFCD10E584;
	Sun, 22 Nov 2026 12:04:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3329B10E58A
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795349080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+yb/y9hVY4gQHBtq0ety+i4x7YbvicEI/eHAt9Cm/M=;
 b=QtATdAra9RhIwPgRhS7ygnxiUsv7aGRaEtVv/V9javQUjljEfvnitQt838MpxOLMnZQZRy
 5UgPfmIB9WMmlg1dSMEBQzTlRSh3lMBl8ka372+01J7jf3jP1w1YCTtvdvtXVR7x77X2AU
 MzJ4RIfh4ETtbo47V2tFa10PXO+Gosk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-JKV8SiqXP-qfisc_aDXrSA-1; Sun, 22 Nov 2026 12:04:38 +0000
X-MC-Unique: JKV8SiqXP-qfisc_aDXrSA-1
X-Mimecast-MFC-AGG-ID: JKV8SiqXP-qfisc_aDXrSA_1795349077
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5bff4099b52so987911e87.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 04:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795349077; x=1795953877;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V+yb/y9hVY4gQHBtq0ety+i4x7YbvicEI/eHAt9Cm/M=;
 b=tfS87+Uf2Z+lrZF4L8GuDXYq2orzyuTOXBXpp6EVnwqICK/CNqtR3eNv+KZ3AMJ/cm
 yYV/50l5B1cKh4EiJuakUdOSJqSPSVWSQq+RYpg4OtTQGbr+zpJcesqqUFHrXKJbZtqR
 Wd+Eoz8X3TeeNhg8+8afjE5X4SVMOd928JhdCe+aOOH/hmWok+047LxPiumpgzB2wYb+
 BhRv3eDNJDxvWomkBTs73zKxa27YHnjwGrKxBmFezoSLhk0jm9sMu0Jf3bIwKw6x4TWQ
 2PlXjxETKoseR5R6nqZSaJ2enop0EKlEOPJM8Fq4oub2EUuGcujhKlsnEYcOtT38rALM
 eoaA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZuFw9IM28pxL2Sk2XcomGC0TAaoqWn9EY+lcJLkZNS8JBmv/7+bqbSbZGglTnuFW3h1IqHDi2A54=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qfdpxxk3DxFAo8+W3bHCwc85grbDIbKHyKdW7gcrnUjpBaPtb
 Lf+fJTE0gfdy5h9EUEoZA8F1voOARSIBOVy1pIVhxymGEHCJytqTzFLu63uQaiiaZoCY+HL6OwB
 dtsYVb4OVDic0Ae1Vu1JKe6r2IHJoUVibWhYAFNlbcYjX/5gDzcSmdbnQRbyUSjRGfmkw
X-Gm-Gg: AZFdTZezjZcdgJ4k8nFNrQW9Rpam19pG0RQt7BOj8r1vvK20YGTdc+pdSek3NWu41Id
 6t365BJHISgEYn5T8gtdSzibklYktrMVQnaLIrAe+959IcH1SkNFiPLR11yz1RgiL+WoIZAFUOm
 G5uXq4qpGCNLWLAA+5nBg0fRF8NgOUEO01W9DdFbUNWiQ1oQQ1mCE7Rwu3D/ZFRNgIlGwFWvhNJ
 DbJdhYNh9Yms9R0mpqD6qs/3aC8+h297zyv9iD5d+QPKvR7j562PVP4quo3Xag2yxBH2TozEuua
 Cwev65umLnQIa7hyBfHsLLPWgZy4LZryctmmLSezAK80LfnTtrtVhIvT5S5epcpWx+YIj0FvKM/
 1OnmWSRQdQG/RMJKLdKWeMK9VGIu5r8IQFJ+eqnSouinEqAC9OCJ9C9lxes0KtEMKGsV1Ctjqt1
 6z87Tk
X-Received: by 2002:a05:6512:251f:b0:5bf:e540:85e6 with SMTP id
 2adb3069b0e04-5c1bc80fc24mr2490859e87.24.1795349076678; 
 Sun, 22 Nov 2026 04:04:36 -0800 (PST)
X-Received: by 2002:a05:6512:251f:b0:5bf:e540:85e6 with SMTP id
 2adb3069b0e04-5c1bc80fc24mr2490845e87.24.1795349076163; 
 Sun, 22 Nov 2026 04:04:36 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd017803sm2088742e87.38.2026.11.22.04.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 04:04:35 -0800 (PST)
Message-ID: <ab91c700-311c-4bd5-8d8e-d90d573f57c0@redhat.com>
Date: Sun, 22 Nov 2026 14:04:34 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: account for subpage offsets in device-private PMDs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>, jgg@nvidia.com, leonro@nvidia.com,
 airlied@gmail.com, apopple@nvidia.com, balbirs@nvidia.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Brost <matthew.brost@intel.com>, mm-commits@vger.kernel.org,
 Patchwork <patchwork@emeril.freedesktop.org>, SeongJae Park <sj@kernel.org>,
 thomas.hellstrom@linux.intel.com, Vlastimil Babka <vbabka@suse.cz>,
 ziy@nvidia.com
References: <179342234355.4.16705453209886955762@gmail.com>
 <20261121160037.1a479f3c8b4e860bc23c106d@linux-foundation.org>
 <36be0904-168d-4813-82ff-27ecced464e3@redhat.com>
 <20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20261122015246.d8b6b98ff5a8157168156339@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mEiPtMGQP5Lh2Aadnhg7ea9qF7Rg0G1ESf1N0jOVeXA_1795349077
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

On 11/22/26 11:52, Andrew Morton wrote:

> On Sun, 22 Nov 2026 07:55:37 +0200 Mika Penttilä <mpenttil@redhat.com> wrote:
>
>>> So it accidentally found a bug in lib/test_hmm.c on the way.  "The QEMU
>>> run exposed a real test_hmm bug: a second open of /dev/hmm_dmirror0 can
>>> put a device-private page into its page table, then dmirror_do_read()
>>> tries to copy from that non-CPU-accessible page and oopses".  I'll prep
>>> a fix for that separately.
>> I noticed that also and will make changes around it in my series.
> I came up with the below.  It all tested out OK.  wdyt?  I guess it
> should have cc:stable>
>
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: lib/test_hmm: use backing pages for device-private mirror faults
> Date: Sat, 21 Nov 2026 17:06:45 -0800
>
> When one hmm_dmirror descriptor migrates memory to device-private and a
> second descriptor reads it, dmirror_do_fault() stores the device page in
> the second descriptor's page table.  dmirror_do_read() then passes that
> page to memcpy_from_page(), which can oops the kernel.  This was
> reproduced with an unprivileged process using the fake device in a QEMU
> guest.
>
> Store the corresponding RAM backing page instead.  For a large device
> folio, retain the subpage offset when selecting the backing page; using
> the backing folio's head for every entry would return the wrong data. 
> Extend the existing PMD migration selftest to read the last subpage
> through a second open before faulting the memory back to RAM.
>
> Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
> tl;dr: The unpatched kernel oopsed when an unprivileged process opened the
> fake HMM device twice, migrated an anonymous 2 MB PMD to device-private
> memory through one descriptor, then accessed its last page through the
> other.  The patched kernel returned the expected bytes on all three ioctl
> paths.
>
> A was reproduced and saved before B was built.  As uid 65534, a static
> userspace program verified that all 512 pages were device-private PMD
> entries.  A READ of the last page through the second descriptor produced a
> KASAN-enabled kernel Oops in dmirror_do_read().  Independent A boots also
> oopsed on WRITE and READ_UNLOCKED at the same last-page access.
>
> With only this patch added, READ and READ_UNLOCKED returned the expected
> 0x0a byte, and WRITE returned the expected 0xa5 byte after migration back
> to RAM.  The modified in-tree hmm_device_private.migrate_anon_huge_fault
> selftest also passed (1/1).
>
> This reproduces a userspace-triggered kernel Oops in the fake HMM device
> used by test_hmm; it does not establish reachability through physical GPU
> hardware.  QEMU guests used matching kernel configurations with
> CONFIG_TEST_HMM=y and KASAN.  The guest device permissions were set for
> uid 65534.
>
>  lib/test_hmm.c                         |    7 +++++++
>  tools/testing/selftests/mm/hmm-tests.c |   14 ++++++++++++++
>  2 files changed, 21 insertions(+)
>
> --- a/lib/test_hmm.c~lib-test_hmm-use-backing-pages-for-device-private-mirror-faults
> +++ a/lib/test_hmm.c
> @@ -292,6 +292,13 @@ static int dmirror_do_fault(struct dmirr
>  		page = hmm_pfn_to_page(*pfns);
>  		WARN_ON(!page);
>  
> +		if (is_device_private_page(page)) {
> +			struct folio *folio = page_folio(page);
> +			struct page *backing = BACKING_PAGE(&folio->page);
> +
> +			page = folio_page(page_folio(backing),
> +					  folio_page_idx(folio, page));
> +		}
>  		entry = page;
>  		if (*pfns & HMM_PFN_WRITE)

I have this same chunk. I think it's needed, all dmirror readers expect to
copy_to_user() from pt.


>  			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
> --- a/tools/testing/selftests/mm/hmm-tests.c~lib-test_hmm-use-backing-pages-for-device-private-mirror-faults
> +++ a/tools/testing/selftests/mm/hmm-tests.c
> @@ -2087,6 +2087,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  	void *old_ptr;
>  	void *map;
>  	int pagemap_fd;
> +	int fd2 = -1;
>  	int *ptr;
>  	int ret;
>  
> @@ -2143,12 +2144,25 @@ TEST_F(hmm, migrate_anon_huge_fault)
>  		}
>  
>  		close(pagemap_fd);
> +
> +		/* A second open must read the last device-private subpage. */
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
> +	if (fd2 >= 0)
> +		ASSERT_EQ(close(fd2), 0);
>  	buffer->ptr = old_ptr;
>  	hmm_buffer_free(buffer);
>  }
> _

Looks good to me also!

--Mika

