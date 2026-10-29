Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RhlV2mA2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD784112459;
	Thu, 29 Oct 2026 16:55:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8C16112459
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793292931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
 b=RhlV2mA2079QE8KGFWHDWxyHgvTa1V7KLCMFbGfYjQLmoqrFLrDf6peIwYAp1I8z+dCkbM
 DVBfVI8E/JVazf33ezs84DVdIjzJKcY0AwZ9VukHGHxaJhR0rWb0+s00jGtvBlr+F2XirC
 XvmmUlheQvgshdurmcCGyEHgeJiFpTk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-ZCpm9aZHPSqMrzaXZFIL5A-1; Thu, 29 Oct 2026 12:55:29 -0400
X-MC-Unique: ZCpm9aZHPSqMrzaXZFIL5A-1
X-Mimecast-MFC-AGG-ID: ZCpm9aZHPSqMrzaXZFIL5A_1793292929
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so555983185a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292929; x=1793897729;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:mime-version:references:in-reply-to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TXB64NJFF4WXwJ9sa1LPJLwRXbNGHs0rY5npnlz1t+E=;
 b=a6VUMxH8ikoDb1rDerg4I1zIjQ/zA6wvtA0kL/y6KrBZ+z9nzPf2cWaSZ6btqeleYk
 a5xS4RfF7M/Y7deeKZzDkFBYsThkgiBZ6FBnMOeOnURmTua4IxGQh0DDqRw6oo+fje7t
 nmXmN8GBkZB/VvLpKVzrXFEGdAvrmmS52w7KnhOjGI4l4Gbo53o4dXFGto+T7OzdP+8e
 1H4apOdZIou1GBNk7se7Hx8kykj2gWKPLHIIa7dvQ9vUGwm09TFjbrzz2+KyFrKHZxWH
 l3/QGtGqjlCRcNEg4oY9XBHKk2HW/XceLmdH/ilkGJ8rdFQHJu5SBLycvJZmGB2WDbmG
 Resw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAXTKMJKqlOgfRIns8lW2j3NxOvVVfULw9NC8jqPqVywZQhLmwvYKHmNrwsUccoqSmhT4kJA5fHrw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJK7ft+fJOlGQDAhx/KbSi7M7x+GQpBQ3+JA/BP7JZ/sGxNdaWq
 HK1XxPe8c3zdjkKWA0G9h58TQQp2OEJCuI30+jfyiYBSzOqbh61MmfJp8Dax6WqBAMEMLcmfkiM
 INX8Nr/5hQCMOkZ/y7D2+hlf8inBKKXHCfhz7DMLd1FN5bcag1A10Zh/q31PTwf1EbHt2Cu96zt
 BzaAAHFQu8zWExBa4G16s2ryEen4uedWlRPCrBmlHpPVVa
X-Gm-Gg: AYBFou3GDramCZz73OpMani/nD+unRU+KhJEpi8NEq3EvVQqhGcSOcVlZY4NJlkyiyz
 MYTS4uahm6plpybPlxBdQrl0aXxGVZVzRIQfbUo0Eb2Y6hJr9AfSi7lY2sGUhu94YqpiTjtAxxv
 zTepjP+Z5bogPMHj8VFOyPP2JT54mdkkD98jyKDuYZuVHQ4+HxhqYcODE=
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-94408cde203mr957070085a.47.1793292929302; 
 Thu, 29 Oct 2026 09:55:29 -0700 (PDT)
X-Received: by 2002:a05:620a:1a27:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-94408cde203mr957065685a.47.1793292928789; Thu, 29 Oct 2026
 09:55:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 09:55:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 09:55:28 -0700
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
References: <20260804140403.16337-1-kfastov@gmail.com>
 <20260804162924.0268f80a@fedora-21.home>
 <CABWhNekebS6dt=Ft+74iG4YpCq-5ZcV1EvvERNxT612VUOC9Ww@mail.gmail.com>
 <18f0bae1-5cdb-460c-a147-33cd1fa2acdf@leemhuis.info>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 09:55:28 -0700
X-Gm-Features: AclHuK-xgAN_fR_dbuTYNWejWEVdFE5MAwn_KoUGHzvKxdpt-_9FR1Wg7w13_Us
Message-ID: <CAAiTLFXd=LK93e=f3PE1f6y5m15yVknqqVNBei5rLz2AnSJ4pQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gem-shmem: Install writable PTEs for write faults
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Konstantin Fastov <kfastov@gmail.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
 stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJMY_eklweKKGlrulRaROjhtsLjdPSjEO-NhszHpuIQ_1793292929
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> [CCing Paolo and Sergio]
>
> On 8/4/26 16:57, Konstantin Fastov wrote:
>> =D0=B2=D1=82, 4 =D0=B0=D0=B2=D0=B3. 2026=E2=80=AF=D0=B3. =D0=B2 17:29, B=
oris Brezillon <boris.brezillon@collabora.com>:
>>> On Tue,  4 Aug 2026 17:04:03 +0300
>>> Konstantin Fastov <kfastov@gmail.com> wrote:
>>>
>>>> Since the introduction of dirty tracking, drm_gem_shmem_vm_ops has a
>>>> .pfn_mkwrite handler.  Its presence makes vma_wants_writenotify() true=
,
>>>> so vma_set_page_prot() removes the write bit from vm_page_prot of
>>>> shared mappings, and the vmf_insert_pfn() call in the fault handler no=
w
>>>> installs read-only PTEs even when serving a write fault.
>>>>
>>>> For regular CPU accesses this is transparent: the retried access fault=
s
>>>> again on the present read-only PTE, goes through wp_pfn_shared() into
>>>> .pfn_mkwrite() and the PTE is upgraded to writable.  But consumers tha=
t
>>>> resolve faults through fixup_user_fault() + follow_pfnmap_start()
>>>> perform no such retry.  In particular KVM's hva_to_pfn_remapped(),
>>>> after "successfully" handling a write fault, finds a present read-only
>>>> PTE, treats it as KVM_PFN_ERR_RO_FAULT and fails the vcpu run with
>>>> EFAULT.  Observed as AsahiLinux/linux#560: muvm/libkrun microVMs
>>>> mapping virtio-gpu blob resources die with EFAULT on first GPU access.
>>>> The traced failing sequence: [...]
>>>
>>> The same issue is being discussed here [1].
>>> [...]
>>> [1]https://lore.kernel.org/dri-devel/20260804120529.1730187-1-pbonzini@=
redhat.com/
>>
>> Thanks, I missed that series, I searched dri-devel but not the kvm list.
>> Paolo's patches 1-2 are indeed the same fix (down to the same function
>> name), so please consider my patch superseded by his series. [...]
> FWIW, it seems that series takes a while to get polished and mainlined:
> https://lore.kernel.org/all/CABgObfYgZ87%3DW%2B6E%3DN%3DWwTuyYkaoKU3hqd84=
JDTSAvT3_9dh6w@mail.gmail.com/
>
> To quote: "It ballooned a bit and getting acks from everyone involved is
> hard... Either I or Sergio will get back to it."
>
> Is that something you/AsahiLinux/the world can live with?

Asahi still ships their own kernel with downstream patches, and have
backported Paolo's series. But for the rest of the world this is pretty
bad, as it means anything that requires virtio-gpu with blob mappings
(venus, native context, etc..) is broken.

Since the proper fix is going to take a while, I think having some form
of interim solution could be a good idea.

