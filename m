Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8A606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dVJR0BOy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB01112C2D;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A410510E5C6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so10142405e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 15:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793833542; x=1794438342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
 b=dVJR0BOyQiPXJWsZBlDl1H/UcGwWbF2MEWPNt29ePzW5CLr2TTuVNn9pb7meZucHmM
 WQvFNXXNTxf1TNiyCFWWJjMmrlfk0JEDSsnHys5pTInZAtDIRHGaeNvL5qH6CpiGUaoL
 fXrJI8iWMf40FzNe7hLoFBoJq1exY02+O2/VZzO1xkra/A/jTYPzyRwKpYb73s9EvTef
 RIy/tQKmpEtVQV/6dKLfVSaPEbCc0aPRfBxvqS+aDU1u9NUGM3heOJIM5RL45vDZQ+n3
 bumpLAe6lwKuEUpa+Zdqk0NXHJwDjnelhgq9/oxiH5S2T/+4Ylf+N0xk6zxykEXBT0e1
 0bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793833542; x=1794438342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOpStKtlaMBvTw82l7hk12nLoKUsFYT90GYDj+kAndo=;
 b=QtSiAaYbbWzGAnE+Xb7OSk2IV+6kjjUGCqWX3U586/y3hPayn5MTzGqqYJ6EDiJgZx
 yIH16dVh8cy1x4ZBxF3qO6pjWfNEQ+aho5N6lbH5/19o9aYMve+i3E6M0b0AQv27YXJ0
 f/F4rBAtvtem2AUYomr8LmxP2/tYDe0yW+zOPVktQVn2ZlmYahpOS91ihU4Gx57hM5mD
 TfDl9hnPjt0L+WQ9awonb4WKn4ce/ewlkRNj5sHhE6EiFOhdeaTVkNzDQmtGh16uihwj
 0/wnhfw+8oSV7XC0dv35xbIXFJd/YNYGmPxvOHG14MzDogvNCc131XBXM+/ooz6c6gGl
 AVKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8ytlLVqA/MXHS/aazPcEVHNrM6iGTrmIrjuWo6fFdO00AFD7QUYgFmMsqCLGLlXAlqJaSztuvuEw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+NWlzG8PmVQhOc3p/ouyTQmx0IhWwP0I2u5rpS5JtPLbmf2K92
 F6lwAHXJ6g3ZbfNcYBc/5ckfItKDkMDWasUY5hhqQSCqD4Fx/xIN6HZG
X-Gm-Gg: AYBFou0JEfvX8HGeZLXTjdT04v+6xSbf3seXYh/nKNbo7H9LPnHC1CNUqgT3yaLJkCj
 v9YLbd59ra3DG04gVR6sn4xq9Mh0rct/Mw0gB0U+zPNh4VBzXHuevq2/D2l+2hIHPQpax5953lf
 KrOuGXO8cE9olyR4ulYHWuGR/SAM7HdPO27LIqnkfCseUPAMwhM6oLReq5qBDiqMOhDyUffWyS1
 Vu/WlM36exSWZJ5pUrLz+xKyeaRD9ujvcIkn2x/qifi3gt7ywh2vsJdGYgRPMB310QgfcNkEMF1
 tLw2SNf27Qv0fhjhtMOtyYlMEUWSpMKawdhLyhq4LYXH8L6H4737eDDVkkf0hSoM7ZUxx6Iz+Ht
 gUdUG0mECdmbgM7bmiY+Tz1LCsfrx+s5pMli4OxQPNWEK+WFMoxkGmJiqOzdArSeWrSpgenYAjT
 s0wFTnQCC1c+UsBs8AL47fgwSM3GUOl9kbqkeW0takcZjTjrqCPAzCA1gfjWloPttK9CkUMNhGn
 v3bzWqit3prbukVP03UxcJc/BAOkmnEt2EhkuewKLqmgWOpkJaiEqELU0CjUtW1SC6AcH6jT0la
 jDzAFrycRZfhLU/F7nhC0JI=
X-Received: by 2002:a05:600c:19d1:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4ac1970b9f7mr379985715e9.34.1793833541916; 
 Wed, 04 Nov 2026 15:05:41 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed5538basm5998977f8f.44.2026.11.04.15.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 15:05:40 -0800 (PST)
Message-ID: <853a133d-f332-47dc-b7f3-eb57f34d9344@gmail.com>
Date: Thu, 5 Nov 2026 00:05:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] mm/huge_memory: copy file THPs at fork like
 copy_present_ptes() does
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
 stable@vger.kernel.org
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
 <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-2-c56d0d26f970@virtuozzo.com>
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
> This fixes no bug: it makes fork copy a PMD the way copy_present_ptes()
> copies a PTE. Until now copy_huge_pmd() skipped every folio PMD of a
> non-anonymous VMA and left the child to fault them in again, while the
> PTEs of the same VMA are copied.
> 
> Treat file folios as the PTE path does: take a reference, duplicate the
> rmap and account them. fork then pays a reference and an rmap update
> per PMD, and saves the child a fault per PMD it touches. The next patch
> sends PFN mappings through the same tail.
> 
> That covers the VMAs vma_needs_copy() sends here:
> 
> - private file mappings with an anon_vma;
> - VM_COPY_ON_FORK ones: uffd-wp and uffd-rwp, VM_MIXEDMAP, and
>   VM_MAYBE_GUARD, which shared shmem, file and DAX mappings get from a
>   guard region.
> 
> The DAX huge zero PMD is copied too, with a reference taken by
> mm_get_huge_zero_folio() as for anonymous VMAs. A migration entry of a
> file folio is copied and accounted like copy_nonpresent_pte() does, and
> made read-only in both processes only in a CoW mapping. A device
> private entry gets the same CoW check, as in copy_nonpresent_pte().
> 
> The copy then gets the same tail as __copy_present_ptes(): write
> protect both sides in a CoW mapping, mark the child's copy clean in a
> shared one, and drop the uffd-wp bit where the child is not armed. An
> anonymous THP is now write protected only when its PMD is writable, as
> a PTE is.
> 
> A page table is deposited under the copy where the fault paths deposit
> one: in anonymous VMAs, and wherever the architecture needs one.
> 
> Cc: stable@vger.kernel.org # needed by the next patch
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
