Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7654606A33F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIWFyLsl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB120112C71;
	Fri,  6 Nov 2026 09:19:10 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FA410FFA0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:09:27 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso8607325e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793833766; x=1794438566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
 b=wIWFyLslrls7xQZN7NiRijpLkacMq7ODfG27L06SbVL2QG1iQv8FovezQ2dALPw+tn
 UqFGNnOHbc8kRjDXaLeOdr5SOZ/rwQR7SetYHVhqcEHFfklDufT6w54tUv4TVBQMXv6V
 OHf3rW/5Lv2OdskIdZSHZW3F8JMg2lLIISrdtaZFQ3n8uGGNq/AYYsxWBjgnoq8vhjeJ
 nDqyJqVjZH5VAdxmnufLqhtebhG00sXgLHoz9zZSFMAhd5yAJoRISQbh8l7OcKGnWCPv
 feF2nZvyaKqzXmDVU5/D/KbNzwTvwT+grApRvYfoIcABKliGsu1PH+zIFciUWJKuyXT2
 VVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793833766; x=1794438566;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJ44xLdhQI1uBh7xxp/N2gaMNtMNeyLEDRfUNR/7E78=;
 b=hg0uNDvxbiZnWqqVGq8tl89BeW3uxWqvO9WY4UVHPHcA1DbuejRasEHDksuYbD9GGS
 yljYFyhm1XYSJCmw9gC++yjkXtMj7BfgrzVQPHHnoTI/mjeMiC13K1vTn2stjbvEsdHN
 3TlMTYRhhp4OLxGHGzOXK/OOzCfjI3dPJCkpdekI2YDTGW6zp6cxhqTnorLwkpE+LxfE
 be/us/KWMmlDINdowPFBReNG3aM91nzPLLmM9X91wsfHuuq00i/GcK7WF7V75qAenyz7
 1MJ1Nu9CTCBZWvkqmeYhEDV1ZIf/no9uZ82HDyK5GzMlGsqZZYlV+jsHIuIBnv8tzRDW
 OjYA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4xVqQx6oKtuWW80hcmXg85fDP6ZOJVbo+u5gpaHVgtMt6MlvDxGNKEF9CXOz2RZ2REt277cD2SQw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8SDnt2WGGF72Vpcqi/S96O4hkNFDhNE9k8h4hu00jc4Py85Frx
 cKHLORxegw2k39KWriXJWQoVNyduK/P+3HJOs1DPCQyIzDs8wtHOJGcq
X-Gm-Gg: AYBFou3RyhEr61jWv2s82SiYOz10cR8foceluH3Hpv/Eu4bHFVrxOuuRIXXNOnQa4qA
 glPbnWH4DsTIY/MhJMDfbOdYdwWdmDWwV8FOCIsdnZ3/Tw/Z0x23XngfEH0T0PwAp64VbMTshFi
 9jk/ZW4KTqnhhFJY3qho68pFNSzKCCBX+4070o+8KwRxOEjduFetZvK6z3Z8iV7+37r6u8oWDff
 ZYa9vlt3+owB2VNiSaKpifr5RuWPIK4sAW658gQ27NewZw0O2kuZgfFWMxXgTqoXv94y6K9hOKQ
 UmBLrkhDwOhq87vFQLN85X8pZI4/6p5H6BqYbQva9++LW8CRIQa1eXynvlcPXFD+tfAlrj7Fsh2
 dg0vj4j+Oohvblipu8sjjdjMNC7hVgYlSCZHL6pi1LxzSnnRKv9pgeV6hzf+5Pv9CkhHN06DYAc
 mJr+D0fOBpKNS+7neraK5/fMkRDngPPXMRUGsW7hmFK0mvqK1Tg51gMeaFciq8qGfM9jLfVF+xA
 QGHqqViDK8d1yj18RuvD/8Hdiizq8cNJFj0P4a3iKKWYEFtFAMJKMBkfO7FTZF2ASgAmAl8jgzh
 4di4RJ9va9Uk/r0QXgrYZx8=
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4ac187a6ffcmr414345865e9.29.1793833766131; 
 Wed, 04 Nov 2026 15:09:26 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae73csm18115315e9.1.2026.11.04.15.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 15:09:25 -0800 (PST)
Message-ID: <a9ed4146-691d-4a35-9b82-e60329688277@gmail.com>
Date: Thu, 5 Nov 2026 00:09:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock
 in copy_huge_pmd()
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:40 PM, Konstantin Khorenko wrote:
> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
> 
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
> 
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
> 
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
> 
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
> 
> The copy of a PFN mapping then goes through the same tail as a folio:
> 
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
> 
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
