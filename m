Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F20606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JuILMOJl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF25110F8DE;
	Tue, 17 Nov 2026 19:33:01 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F67410F8D8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:32:42 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c508bafaddfso5815766b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794943960; x=1795548760;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sEdsgEuo8ODT+rI1rQ1WVM7pBhVs1i3Hp1pw+AHwR1c=;
 b=JuILMOJlQMdhYHLwF/74g1ljJnqmJjd8hlWOq85tjQRfF5TFIJdmSGV4L/vd5XptlO
 FKM1GZk+J1p5Kz0zwOJFKXfUshDAT4Vqbb835KuS6UUCryS+Ew6B43T6ooc862m/DNaN
 Le2DZqTi4wwwFjYd+lOzv5bLxQWh0hNLVhHjuHcy0APyTrbZ3ME0v3hNKi+nYZf2yKBa
 jY0mKLdZ4yzjin9zWHCl8AvbU4ZdTeG37BDw2f+FSFvKedZykSd1EKy/+UfB9/7+sxbY
 PZLOvQ9AkjI3Djv1aeV3zMGG712BUhxNELuT9OGGQdensSjLc6xqHD0EEq1vVutt8qWC
 ikJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943960; x=1795548760;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sEdsgEuo8ODT+rI1rQ1WVM7pBhVs1i3Hp1pw+AHwR1c=;
 b=rN+I2Hu3oO3rAKVw/WbQ8D5zmbiGax015IzJdLJoXm9ArQg88QwpL0+w/d/kHF1Knp
 4dGtLOOM53uf0zXNCQGTLHfRopYXO4qRJLlXpg6HfQodRUFRwFwjEeTYbsfTrexvvdBd
 JijchUxC+fum7fNY5BPgmoq1FvcZ91gSI7o+tlQog6x/fKiaOdtu/ffhk6goj+rD+K3p
 c9NsdO57Igwgy7a5/V6KIGGObZwL0dVD8j/UwMtYAdJDGO+/QaXUdVdjouxsy967lS1f
 6sFe1PUHMVu8JzAb7ZyR9VegbsyFrQAS8XLZT90oqrsXHwI5LtJWLoXlJKPh2hEyfK81
 hdqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFEYaAXazZeu9ND/8JsVtimXVMyTZYL5s7/9iUlHNpDgLYjBw8wIphkH2BE2T6+pDkGWSSdrlgbAGA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z92dqDjqvwUKPUI07TLAHdobieQ+es9NPxM0eY6O8KVaR+5IEg9
 N7Th4Z8cTSmd1sgaqKPAy8sSfLlBwvziG7jOEkjmE80ulN+tau4JW05I3vNzYbGUDlTypk8GrIO
 GWzOZ5qc821DRRzfc9A==
X-Received: from ejeck9-n1.prod.google.com
 ([2002:a17:907:e1c9:10b0:c46:aa24:8716])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72cf:b0:c2e:2252:6ddb with SMTP id
 a640c23a62f3a-c510e19b51dmr22046066b.10.1794943960151; 
 Tue, 17 Nov 2026 11:32:40 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:21 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=fHxqvSNi6j+mg7W4SOrkydkocL0Pw6SV4czczy3ta6w=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQUDExEsHiZ6Cbk1w6CzxYFmFSS4BSPnhEk
 MSLEGspzROJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 Ro49EACB0ftf0GHD6NVKJk8qoRRSAA8NtLcQxD9TKYzGe5l1VQ2v/ZRDvNthAokzdRvaDp8M5PW
 1IvhSetFJ1EPRT9FlJXK2lAOTgNOjbV31SMgyfAeog3PyR/AAEA3mJegzv0uA8x2BFW2ftoq9ez
 ftvL5TL/kRzHs/YDi6niQqRXc3GlcM1r3KgpKlj0pw1CgsDeZsfeW4DA8zi20tZ0dVQy8k6SN74
 rnpMamiABEsq9czO0k0TAIo2PdqLkksEo7LJrATWxZZbSw91E7qLnu7xVAqb6VQqH8KVjDyFQ4L
 3D90Xoq/m9Rzqv9GUeIsTH+oGkRb3rFkj5NdcdOybMq8+orYHWW+qHORyYvOBdGdzy8ICUh66XI
 2O+Mez/FxA2cxniGl8lj6y0zYwl9OSQE+6w7sOXqEYHamldd+54o0hcZQIXUFNk3WaA8PnqKRFp
 agH5mLLhUCQo0e1DL5UHQxBjwRtmyqQZ44vAMgM8d4wFArAd38y2VLOKLic+hHzm7WcRo1p27P7
 gq6FHPM27S4LPzaN3Kl94tyFAKa4gt1bju+FU6AXnvDVFK+fY+Gs3Hf2GAH8Kyv5Xpmh0pFcwiV
 O4rKaY4DkUE50L1H+Gl6XcUjAkTinnrj9ZXxVMj4eaxEwyvrozh91m1ow3Ep9bEm3FNtth4J59R
 iniBlvdTGiEmd5A==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-4-2a8efd4c8180@google.com>
Subject: [PATCH 4/4] drm/tyr: vm: check the remaining length in pt_unmap()
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

pt_unmap() subtracts each unmapped chunk from the remaining length and
relies on unmap_pages() never unmapping more than it was asked to.

Check this subtraction and fail with EINVAL on underflow.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: use safe casts instead of 'as']
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/tyr/vm.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index bcc864b17428..acbca552d133 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -41,6 +41,7 @@
         ARM64LPAES1, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     ptr::{
         Alignable,
@@ -1063,8 +1064,9 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
             return Err(EINVAL);
         }
 
-        bytes_left_to_unmap -= unmapped as u64;
-        iova += unmapped as u64;
+        let unmapped = u64::from_safe_cast(unmapped);
+        bytes_left_to_unmap = bytes_left_to_unmap.checked_sub(unmapped).ok_or(EINVAL)?;
+        iova += unmapped;
     }
 
     Ok(())

-- 
2.56.1.703.gf848ed807c-goog

