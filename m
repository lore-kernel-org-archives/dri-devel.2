Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8DB60A2622
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M1PmQFxV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 970E810E61A;
	Tue, 17 Nov 2026 19:32:41 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CEA10E61A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:32:35 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso57702f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794943954; x=1795548754;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWEIybWOyPQ+4rZV05KjYSAVt6nHfWxtoLBA9Fvcf20=;
 b=M1PmQFxVJe4jwdGc4SNmfSsiP88mPmr4Hgt2fkwgEOwUralDRY7hey7QHAVUEigC8K
 DNfgWM1MadmTRLi0GMsydmaNf7UCev3x+i01cxbbKFUyWS9pjolo0R68V23nBwWJ+5kj
 OYFgpflQlzpt5/35oLrmL5+FJvTyggtEi7w1ZPXvnX9w7S97GYl6/3K4oXZT7JRhJkd8
 fb0UqidTf9bCkc3qpNi5c6d/T+4+1HmkKD7+YobxKmpEL93Omb02RGLsMAD+qIlWYA/L
 TDNj/nsa/hy7uLa/SjdteeFqfrOhwY4dvQNcP4XMamPuUScmk0bqouBa9Uc3EsVUtRlH
 Lonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943954; x=1795548754;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CWEIybWOyPQ+4rZV05KjYSAVt6nHfWxtoLBA9Fvcf20=;
 b=bV1qK6s2KOac0P6xCtCuuOGvGnO9le5OiilicJAGQBdZqNTTsNzzD0B4o9ys3uoFAV
 fylkv++soSa5EA1O5VsE7HC1z6C14JBmvRZ0r8bLTWP6FTnS8fnJMWFM/99kOqi4lb7T
 vngY1UQkJ7fS66fZup13UVqo3pGhlF3q9jYfbQV/AQNn2zKWgKqjxmEnSc24ShvQwGrp
 7/a+e5OIYWE9PnIBhGL5Q8fOUvWyqgfxZuLSr+x38u/XxnQSsnRAMsRHmiP3WD87RN0O
 JCsw+3fRANdFMXVGvV9HiKRCYMXobjTO0BEnqRi3n2iq4F0J1/t2CRjkYpNOL9vKSz31
 mZZw==
X-Forwarded-Encrypted: i=1;
 AL+hErF+DRpeHHxiDKsetej0hPglvVhVNd7BYwZTaeEBI2KwE2q2YClPwxEQQGmTN0uCCVhvQBOTmU0gZ2Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+XXMHabRtNQfF6Wbbvk35UAowF3qWjYCIeE1gGzSKb1nxIyU+b
 aElbvoYV3peOLm3dLXTcXzQJTglEmkWkoaEseSdu3YR48AktA0eJHgm7LTsVzEsJ3agk+z5YnHH
 BU+ii87m1qHb3ChMGPw==
X-Received: from wrno8.prod.google.com ([2002:adf:eac8:0:b0:4a3:4620:1d69])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e193:0:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-4a63de52730mr1008245f8f.35.1794943953550; 
 Tue, 17 Nov 2026 11:32:33 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:17 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMKr/GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3ZLKIt2i1NzEAl2j3CRd80RT4yQLE3PT5LRkJaCegqLUtMwKsHn
 RsbW1AOkuzV5fAAAA
X-Change-Id: 20261116-tyr-remap-2mb-7a53b8475cfc
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=vSb8dcnD2eG8K9E1baNk0JXzV820WUHmszz9zfbL9p4=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvIxRmUX8ES1X5aoMSyIxD/DGyKY46COBIZk
 l3WJbGYM6KJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyryAAKCRAEWL7uWMY5
 RlBYD/9LZxWa1EOICrXfCQo6+2FEaGCBTsGLsBCGNZt1aDkE705pnOcpv89yKcb61oL5jKTgTnW
 xpQGfS8/AHinHSIETT2reeDB4YrpfzKFFlHy+s5uCvqaMrDkS0xGr3eeSsaIDFJWASvdkEippTS
 96axYSKcL7IFwFLAmgcG6sX6tc0b5GG6YfPj75KMsMDqJ3kzAy4GDySRre+ze+MkIPI5rPoSdlC
 bDZ1yQZ+MrXVRxE2tuP33TmNT2izHdDsTxsdkPvzk7AGQ+oihOvv6lzCMkGxAhW+iBy91sIchkX
 /ewCL9ObYoq8wv3Fo0015JzMRoffi43yZVGOgl2jWFo/tAfMB0Q9JHTVRlIC6z2Mqwx6cGSbLJq
 2y2G/r950f+7EEb0Sk8FQDfRZbzval9lsEozVfD+HmJhsjPsowLG2Ts6hYCYggj1F6apuPx05oK
 bGAWMT2i3wIdIs47VBY+0nGf7hM4dTIQ8gTLYTtEEv3Uqup3mp+APnE3UgC20V73mFjgF+a+bd0
 ct/HDow4DEd8WlnxgPELic8aqxm7FxfePM7Mmc0Z9EsXXPs5ntYG4v696CXy794wL5Ab7FxxOSq
 vghzvQB8amoJ5I6nF85Ee23Zss/K18MPB4vI9M4+qLYN2grL4wfzZKk3nCZkI9DsMoWR6CGB/8j
 /nHigx3AoV+EAnA==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
Subject: [PATCH 0/4] drm/tyr: fix partial 2MB block unmaps on GPUVM remap
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tyr configures its ARM64 LPAE page tables with 4KB and 2MB block sizes,
but arm-lpae rejects unmapping part of a 2MB block. As a result, a
partial unmap or overlapping remap that splits a 2MB block in
GpuVmData::sm_step_remap() fails in __arm_lpae_unmap().

This series ports the remap fix and supporting accessors from tyr-dev
onto drm-rust-next, along with a defensive bounds check in pt_unmap():

1. Add the GpuVa::data_ref() accessor.
2. Add the IoPageTable::iova_to_phys() accessor.
3. Expand sub-block unmaps in sm_step_remap() to 2MB boundaries when
   the swept head/tail fragment is physically contiguous, widen the AS
   lock over the expanded range, rebuild the surviving fragments, and
   take the preallocated GPUVAs before mutating page tables.
4. Check the remaining-length subtraction in pt_unmap() against
   underflow.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Sami Tolvanen (4):
      rust: drm/gpuvm: add GpuVa::data_ref accessor
      rust: iommu: pgtable: add iova_to_phys
      drm/tyr: vm: expand sub-block unmaps to 2MB boundaries on remap
      drm/tyr: vm: check the remaining length in pt_unmap()

 drivers/gpu/drm/tyr/mmu.rs               |  13 +++
 drivers/gpu/drm/tyr/mmu/address_space.rs |  29 ++++++
 drivers/gpu/drm/tyr/vm.rs                | 152 ++++++++++++++++++++++++++++---
 rust/kernel/drm/gpuvm/va.rs              |   6 ++
 rust/kernel/iommu/pgtable.rs             |  23 +++++
 5 files changed, 209 insertions(+), 14 deletions(-)
---
base-commit: 8045d0e7d208ad389a387f1407ce0db9070805af
change-id: 20261116-tyr-remap-2mb-7a53b8475cfc

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

