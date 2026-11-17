Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A478606A89E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nWuM9W0e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4930010F8D9;
	Tue, 17 Nov 2026 19:32:52 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D03310F793
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:32:39 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4925ef75fc4so83256f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794943957; x=1795548757;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H4pN2M9wOQsksT8v2A6luJsQGTApmzqSYccD0MaszVk=;
 b=nWuM9W0e/CWWlVWMRRU4dLlj1VuwZrhl4Pr4Vg3XPthoMpFLmelz0l68jlY+xgpb9a
 Kz1ROxSq+bTPuF1KhE8gYNabRUhaULFwujbXcGBzBA6x4ZJISURQUNAaz0FHgVF/1p92
 jx6xJPWhtkbKWbLUIflMCvODT1VUV+pscL/wfzg5hBYr4/wVcjfcLgsyy9g7k3p6AmoQ
 9TlMuyYMksGn6170gyG0kBJzvkN+JE24QGK5McNEUCaI9aZDy0m8a+M7Radh+Q7w8oYT
 r9GceX1DtFNWY+RseuIE+LUQWUaTYdgalp0ex8Zy3hxowEyvMzbIPMLZQcHxO5kKhkpQ
 Vhog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943957; x=1795548757;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H4pN2M9wOQsksT8v2A6luJsQGTApmzqSYccD0MaszVk=;
 b=BsGV3eWdo0Yd2qTqiD1I08VAtxHblFExVrxgWlFFy0j0TuSFwI6vVUkLGlDpU9L1wV
 BuSqZpavSxCOjd1xtquuhduGCDRui5q9Imopoi8idFjPt3DN/f1raPKHyUSuq6SSKCEM
 EFL7DVbOGopv6oU04sRTBQ4spOXBbO+/svpFL8BlgIqGs9QRPkwK/K76/3Cpfoai+P6H
 LG9ebG9V5oGib7OI/xZNHmUxiz3CbS20EY+ZDDpFwXT+Hlqid7tvGcjJgM/DbvJyHRs7
 vbuUjDqVQWrMnmt4HJYdT/kq8VXoPraN3Ikfn5/9a/TXCC0Rxx3Uo1sXm5fpMZ6mJCkG
 blTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGqS/DHmxITMxv1+gg4B0z2PaEyB+ROzUtRyLkxmqR1M5VNOzbghFemXxsIKrbPeSOC8imkgxx/LG0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YMLxB3RiB5lmJk5/8ENp0B0imgDZ4eFRIm5eOPdiDObtQ/sP9
 qkySnI3BAkLloL0ydPixr0yI7HwEJDzMtfke4LY0FfAnv0+TgeVa21zX6mDoe7L1SV8Br728JPJ
 973pK/1CqFb8bh+bChQ==
X-Received: from wrri7.prod.google.com ([2002:adf:fc07:0:b0:48e:a88:307b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:4b41:0:b0:4a3:8b21:51bf with SMTP id
 ffacd0b85a97d-4a63f182f83mr740599f8f.48.1794943957287; 
 Tue, 17 Nov 2026 11:32:37 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:19 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=+WyZnWDfy306Ajq1PPGtwj5xtYYAYr61kK3N/Swr1tU=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQsa1UM5WU2G5oJXUq4SO8VXyaXylfiF4lZ
 iZXO7H889uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 RmOED/9SPEc5SVbIFzMOA6exlWVkV17LrOPMbmZ73sFVMoW6dCfBjoLKmng6Ja/pJd0w8Dv3LzD
 CpvEactijAk0jM504Lfmq0eO3Hlu7DpONrjHI+6FRM3pEY7wItYzrkKlhaCp1UmneTU301YlJhe
 xWOV1nOW9Jxt2tBUlTG1mL9eeUiXB/cyfGesZFlTg1OGvyIA+zscZIf6qyf36NL6/rYp6tog4CJ
 ObGH201LRf/gJx3W4Wwfma+Fmu6adSlZf3I/4dXwqf5TLtSYuSt9mIxZEVYsmaWgSepSLsPwriF
 b8KsXKB3oR6FD5nRgJEWoiQSvbXaQ4h/yDq0CX5ohQ1nTSlSAtrzKAiuKTmP2XYpaBvFQOQNLzQ
 QKK9NGzbeulrMV/+dc2l2GhzgbbKUvHYQ85IdcxdCY6vWRs4+EkOp32kW/iDpaQfotRqxItDSdb
 a/SN3nsMgQPLc9NgV5Zmakgr9HdXrOxFeF8N1xFRgaB2Rggd0LyV0mpKM7WLFRl4hmGVctueN9G
 aXQuMEtmhaFiEGToBlacYoxZxAL0Qf5zQ8GJYGLqXY3LEI8ICybR3mYK9Zxd7jxIubVUUp9E+l2
 yiHoYfcfmW884QNrI2NgtfgooFHlOA3QbRPK9rVtt5JhMOaIgBEXuPA3Whj24i04wGYc1Sa2XCQ
 YjvraWdGlh012KQ==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
Subject: [PATCH 2/4] rust: iommu: pgtable: add iova_to_phys
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

From: Sami Tolvanen <samitolvanen@google.com>

Tyr's VM_BIND remap path rebuilds the page-table mappings that a partial
unmap sweeps away, recovering their backing from the still-present
entries. Add IoPageTable::iova_to_phys(), which returns the physical
address that an iova maps to.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: split into separate gpuvm and iommu commits]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iommu/pgtable.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index 5f9b42ca92c2..306c03862a72 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -199,6 +199,29 @@ pub unsafe fn unmap_pages(&self, iova: usize, pgsize: usize, pgcount: usize) ->
         // SAFETY: The safety requirements of this method are sufficient to call `unmap_pages`.
         unsafe { (unmap_pages)(self.raw_ops(), iova, pgsize, pgcount, core::ptr::null_mut()) }
     }
+
+    /// Translate an `iova` to the physical address it maps to.
+    ///
+    /// Returns [`None`] if `iova` is not mapped. As in the underlying C op, a mapping to physical
+    /// address 0 is indistinguishable from unmapped and also reports [`None`]. The returned address
+    /// includes the offset of `iova` within the mapping block, so it is exact for any `iova`, not
+    /// just block-aligned ones. This walk is lock-free and does not allocate.
+    ///
+    /// # Safety
+    ///
+    /// No other io-pgtable operation may modify the entry covering `iova` while this walk
+    /// executes.
+    #[inline]
+    pub unsafe fn iova_to_phys(&self, iova: usize) -> Option<PhysAddr> {
+        // SAFETY: The `iova_to_phys` function in `io_pgtable_ops` is never null.
+        let iova_to_phys = unsafe { (*self.raw_ops()).iova_to_phys.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `iova_to_phys`.
+        let paddr = unsafe { (iova_to_phys)(self.raw_ops(), iova) };
+
+        // A zero return means `iova` is not mapped.
+        (paddr != 0).then_some(paddr)
+    }
 }
 
 // For the initial users of these rust bindings, the GPU FW is managing the IOTLB and performs all

-- 
2.56.1.703.gf848ed807c-goog

