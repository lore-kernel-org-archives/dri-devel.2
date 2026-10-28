Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A1606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=fAiBo8UL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11D110E587;
	Wed, 28 Oct 2026 06:03:03 +0000 (UTC)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE24810E587
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:02:57 +0000 (UTC)
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
 by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4jDxbz4T3fz8sd2;
 Wed, 28 Oct 2026 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1793167375;
 bh=1okY4/WQi99J7SX0kElMLxT+6AgqYCI7lGDlpsDqa+A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fAiBo8ULWstc9LQnFor1eWiy9y2h1iQVBO8Ml0nYw6NgYJnJqC6CGNvDeInwQN8DQ
 K/YrYmEpEvGvaNzav6FPa5YpGSFFWenbu3xepK1f1bkfTIHzW+20rTMxeI73biav6y
 M+44CEY5xcXqaV3moEIwbgQqnWRW57EaprPF4gik9Hsu6a3kBzvsapzk3HDaSqdpZF
 AQb/kspy+U6e4/LRz0TkqBt/D4nMPaIUZXTbfrLqwnzMGzzIvzLXJ4UNsyevgyZMpZ
 e3gmqrJU9K2NoYF4ALm1/AVhyF8s3SNEbDSyyQjpREHg3AjcNaNtInSzeLWpKo0e/v
 iqOx/Fgzi/Z7A==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4jDxbz3mJ9z8sbb;
 Wed, 28 Oct 2026 06:02:55 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jDxbv1pfpz8sgW;
 Wed, 28 Oct 2026 07:02:51 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id F2C265F9FD;
 Wed, 28 Oct 2026 07:02:43 +0100 (CET)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
Date: Wed, 28 Oct 2026 07:02:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Konstantin Fastov <kfastov@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20260804140403.16337-1-kfastov@gmail.com>
 <20260804162924.0268f80a@fedora-21.home>
 <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179316736461.617485.9239835948581871887@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: F2C265F9FD
X-NC-CID: zzZh23SNCmq0eCiirHBvMPb1mMm7zOOn/wv4ZUvO7omB48g47ew=
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[CCing Paolo and Sergio]

On 8/4/26 16:57, Konstantin Fastov wrote:
> вт, 4 авг. 2026 г. в 17:29, Boris Brezillon <boris.brezillon@collabora.com>:
>> On Tue,  4 Aug 2026 17:04:03 +0300
>> Konstantin Fastov <kfastov@gmail.com> wrote:
>>
>>> Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
>>> .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true,
>>> so vma_set_page_prot() removes the write bit from vm_page_prot of
>>> shared mappings, and the vmf_insert_pfn() call in the fault handler now
>>> installs read-only PTEs even when serving a write fault.
>>>
>>> For regular CPU accesses this is transparent: the retried access faults
>>> again on the present read-only PTE, goes through wp_pfn_shared() into
>>> .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers that
>>> resolve faults through fixup_user_fault() + follow_pfnmap_start()
>>> perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
>>> after "successfully" handling a write fault, finds a present read-only
>>> PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
>>> EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
>>> mapping virtio-gpu blob resources die with EFAULT on first GPU access.
>>> The traced failing sequence: [...]
>>
>> The same issue is being discussed here [1].
>> [...]
>> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@redhat.com/
> 
> Thanks, I missed that series, I searched dri-devel but not the kvm list.
> Paolo's patches 1-2 are indeed the same fix (down to the same function
> name), so please consider my patch superseded by his series. [...]
FWIW, it seems that series takes a while to get polished and mainlined:
https://lore.kernel.org/all/CABgObfYgZ87%3DW%2B6E%3DN%3DWwTuyYkaoKU3hqd84JDTSAvT3_9dh6w@mail.gmail.com/

To quote: "It ballooned a bit and getting acks from everyone involved is
hard... Either I or Sergio will get back to it."

Is that something you/AsahiLinux/the world can live with?

Ciao, Thorsten
