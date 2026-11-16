Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F27606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BjTQbKVQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AAB10F098;
	Tue, 17 Nov 2026 08:09:42 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A51910E487
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:57:54 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-91ec396c93dso71729176d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1794873473; x=1795478273; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kNMtaHpahG58C4CDJTpyGiQEPKrM5bilgLdnVmpa1D8=;
 b=BjTQbKVQGLxLjrPYR/qNvpCQkKHEYRBzLdBf86Bxqk6N+fAEExkWKBfnj+EtMXfcq7
 qVO2cDx8hMvKWs4jNaUViomDFcY+ggGFxu1WwYw16QwWngqdsg5vAzgvQaLL6gRl/Nny
 n7BKGyUuWLq4DQsU6shEViebdtX9f3u5xd4m8m7n4dbsQi+dLEWTN7yCiVZVFSQ/oraE
 0sV49KdJ+YAAhYBn9tnLz5l2X9KoLGsavMO2TxmxV+cp7Vf9GfAmKnHNOeyEHyDFX3lB
 V8NhPVC4A4HHr+pfTG1fvUsFoXHwacwybCX+D4T0BFMXQ9SqI/nlAQyO3ZKUXBug+vPN
 F07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873473; x=1795478273;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kNMtaHpahG58C4CDJTpyGiQEPKrM5bilgLdnVmpa1D8=;
 b=H4SELN1LJ53MYM51phQE3YLdnr9wIQJ7Gjlmd4yFlp424PrMlGWCrInW6s9mhGXpkj
 jpDvUKpTKzbM45o7lXfqmzzT2NwbdXMzISMYMUkfKug1T7f2WOUmbIm7kjMD6naITaZx
 8+fMloEqP7rOPgH3r+fLnjTuPbRAlK4P054uVRNfepOoTF6ke0sdFkt1FAXfkJACCQ0o
 hRB5pdZceUOAg8vhBSuHv0uYHQmTIb+Yp8dvizBbFbjyu1/9/+gUNjGYGpc3pvPkIVQm
 pCoqRFFpsB/XIYCw0Tb8pRhVtRtTU1p/kfk8jhiKErczW6dnnYkhfhHpmM3Icu7lH/4B
 sBQA==
X-Forwarded-Encrypted: i=1;
 AL+hErHWMIm1yGg3vAZo+t+ESi+dsaqF+LFrGbfdTZ2bhI43HWqJy8Fyz7ca4xm7u5J0OIBnFA2ngYXe3aE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+vhOvYFifjk5A4x1HJcJscrA/zgmWx9+SDS/gxEZ43VYcPmUtl
 ec/UElyQ7OSU/ptRnoL6iXdYiuTuM8Q4zFj8U+7YZ18csk35ZUf19m1ys/XH5xkYEnnuzBm9fIO
 1gWnh
X-Gm-Gg: AZFdTZc/KWCaRbgyt7tQA77K9smMyELN5L/u7eYGb7Soun3Ji9EbGp1JDKoza3qWeHm
 IGe0jkcVfEW5oTk90x09naP3FP/OXuj5nIMS19ILWIpY7IEciYfctm42o1g7zJ6oNx0gvf8MpYN
 DeW2tStjoxb3w/Dcrjuf/p2uaOcqFXl4ejjkvOr0mwKjowXZqzGkzfo169hww8M6ibb/B/y3azO
 b57IdZkmFuBPp66HQA0WSf/tbUMAfsUTONU5QHwVtJYGGEryaX195bg1POfdlMC6s/6JoITqztL
 Bu/MSZ+xj4fUoWfkclblLk45iyo9MPwWyNr80vqjbLz9L2oulBnayYLQrqbq2daL18GvfhNTCK8
 gNqbxhIpmgPDkIXZ2whFyAbTA4IB63w7iY8wWC8tSlsWke1xyUkdtNyBJJlMM5b79HTgATUM7ID
 VmKSou5qdWyqeoUZd0bzVVSRbNxLQzAnRVVLM6MrSDIXUt5TpcRhDuCO4Y1A2TvI8ukK6lydGTp
 C2zMXT5VGo5/pKBJdfjFOM5OVOi6L5QIaYJAwMxhCFm0Xn3Y8AvcJGvZedNy1z0fGeMe6nGN3j3
 5ioge5Tt5DsWAIR4AJ5Rxb+9J4YSmC3s5xdRCW74pE9yf+JlM257xWJo+h/I4Dw3Tl/VDrxPjVX
 T6av91vg=
X-Received: by 2002:a05:6214:4019:b0:91e:a219:fed9 with SMTP id
 6a1803df08f44-91f2400c99emr200139666d6.1.1794873473078; 
 Mon, 16 Nov 2026 15:57:53 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net.
 [71.191.145.202]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d453casm97144106d6.10.2026.11.16.15.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:57:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mm/hmm: skip NUMA balancing on protnone faults
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, linux-mm@kvack.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, 
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <avuN2eIrlqrO0u6O@nvdebian.thelocal>
References: <20261112-numa-v1-1-ad9cbca8f49a@intel.com>
 <b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org>
 <1993e931e6a4b0cda5c04e72b1a8d5fb924f950a.camel@linux.intel.com>
 <9ec3e8b9-064a-47a7-8d00-566ff371b846@kernel.org>
 <179460319801.482102.15329919214055018110.b4-reply@b4>
 <avuN2eIrlqrO0u6O@nvdebian.thelocal>
Date: Mon, 16 Nov 2026 18:57:52 -0500
Message-Id: <179487347201.482102.6428415219993123805.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:19 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-17 10:24 +1100, Alistair Popple wrote:
> On 2026-11-14 at 07:53 +1100, "Gregory Price (Meta)" <gourry@gourry.net> wrote...
> > On 2026-11-13 21:43 +0100, David Hildenbrand (Arm) wrote:
> > > On 11/13/26 21:34, Thomas Hellström wrote:
> > 
> > > I recall that John (cc) kept saying "GPUs and NUMA balancing is inherently
> > > incompatible, you have to disable NUMA balancing".
> > > 
> > 
> > If this is a NUMA-hotplugged GPU, then this is resolved by a private
> > node, because this:
> > 
> > @@ -6404,6 +6404,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
> >         if (!folio || folio_is_zone_device(folio))
> > 
> > 
> > changes to
> > 
> >         if (!folio || folio_is_common_memory(folio))
> > 
> > And all folios on the GPU node are never subject to NUMA Balancing
> > 
> > so balancing can stay enabled while the GPU memory is not subject to
> > PROT_NONE spew.
> 
> Hi Gregory, just to hopefully help clarify understanding a bit here this isn't
> related to folio location and therefore private node won't help much.
> 
> This about a driver getting a snapshot of current PTE state to program a
> secondary MMU (in this case on a GPU, but can equally be a NIC or other device).
> 
> Even CPU memory being subject to NUMA balancing can have quite an adverse impact
> on GPU performance due to increased incidence of GPU faults, hence why John says
> GPUs (using SVM) are inherently incompatible with NUMA balancing.
> 

Ah, I follow.  I'm still working through the performance implications of
mmu_notifiers in the presence of PROT_NONE faults, but if i'm
understanding correctly it tracks that you'd say it's incompatible.

I presume here the driver needs a global view of memory (or at least all
memory it can potentially DMA), rather than simply just a subset
(some set of VMAs)?

~Gregory

-- 
~Gregory

