Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC560A263C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cpzaLalg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC4110F7CD;
	Tue, 17 Nov 2026 19:32:46 +0000 (UTC)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E5C10E69C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:32:37 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4923b9fdd43so129829f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794943956; x=1795548756;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+0+txM7MPeyJRwa0Sn9PNj0P/voFCRRCRvjyl+hjpB4=;
 b=cpzaLalgRjIOfTxCE7T5V/1pbUwbXNPAosr+Qrd5ldOtHP0E7kpFa+PmLURKw4HEMw
 cmqUHbl/tR09cD0Gz0IMUCMijxifJtg51epDB9ap+jHsQgPEZt9Eo4ArQ3mqU0jRF+B7
 iI2levRAZylclglpbmTDJeUXs5v8AuvraheQxOtK0OCmGm7c/Yr72ZwjNNO7McAlqsYq
 1xshHiGzRoj/LR0Wn011uY+BqvPs2flxiOw2o8hof1a1sym3lJNWAbN5bMi05cj5RI61
 UtWthrEFCSUyE5vbPB2S2ZlVLUQHtGbe2SQb7p7ySCj+frIp9FlTTDMgShKgU7xUFRmQ
 jsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943956; x=1795548756;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0+txM7MPeyJRwa0Sn9PNj0P/voFCRRCRvjyl+hjpB4=;
 b=omktbvBanwv7DZydMVhv8kos1aXmYRdQ+FffqMZcTc8IIbEEflkHX6Vq99R3xzT4ba
 fXM5EvJLvyC8Lc6StKv1h+jIT1zqdM6Gq1uf65utRv3SAlD5PRGJh3K0HHdgMqkQ9V/R
 fwQtvLKRQe5cTc2tgRdjzJqISlhKLrswVwXXZqhwrHkaUsPSov6M/s8H4rhztfmkXXYA
 CE/MbO2V7jRM8PRLcQB784kl52qMQXzig+pNfEVrOICsAIttK8WxJv6h8B5dc7PKq2/I
 hEAQ0pbNmEixRZEDrc11oAo/6t3XNBjyNJyDn7xs7BUnxmjYM2313iuoVKaIHvuZPNmr
 4Vqg==
X-Forwarded-Encrypted: i=1;
 AL+hErGAA7S92Ll7fNYYbwFyCUKTXg3lEDU81UwZwAzly6mA7klBZgD/ujcQCuFV0lDPF/lrIzp8wS9T6Ac=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Lsx+vS2omiW3cOFWqlhANDFAo4kGeivNMvzNSaxs9JKRKXiaJ
 MTRxRMAJPomqJccYHo8Mh0DwIqrCZuHpTMoiHOGHf2GLKWLX+na6OwLe7KqYi7XVfkhL1jPKzJE
 qtHT6kL2VWF2t7bCpRg==
X-Received: from wrnb4.prod.google.com ([2002:adf:e644:0:b0:4a4:9fcb:c0d2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:983:b0:492:820d:107e with SMTP id
 ffacd0b85a97d-4a63cd0eb78mr804149f8f.47.1794943955847; 
 Tue, 17 Nov 2026 11:32:35 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:18 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=qullzfbasZ1PBAiwmelJR8Wu/8Cq09DzJ4AhkY0NXXE=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQhhfo/i3hpH5lFbOyDEwYbHCYaKQPRqu7h
 BvCnbobi0mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 RojaD/92+hR/vatJndmWWwF1FE/2fpo442zd/mWkRgzBkO4VFIAIzF35Ckwt+5scDlitsJkhc4o
 7T+bS69Ze3KLWfegrGht24waHlj7oB6wbMYYWLuZPB4utAyG5ljJC0mvJ1qATyBmphbuTCBLuFi
 5wHzxgysG3H0vwDgykoqSpqhIhuDKyYQFHTOa+gQZhI/xcR0TLOEx0Dfw6zILOQX17t8WJz345G
 KDFh2xc0uqfU3sV8o9EcmfTo6F1641JtsXVIZY+Oc8yCAv826HzwsxKkFFYyfjlic3zEblEubUV
 xhxRwbdq76B9Xmq0i9Y1COm6pHZb9KUaT+yeeYxGUEamZwGS/M5a1palNLRGlKuWT8AOfxIiWcx
 x/w6kfDtP2nKNMYdbIFzkDF78wkZAsanc9VJOAca1Zotbxsz7w0NKQNoYgUV6WrYcbUQ/PVupF/
 g+6zuUAwfP1uey0kc0/sMvH3qwmkT0hHalKomEES5QimHuMCP738vgMWnft4jczbjNevxCtr7CT
 6vrskXM6peY7eqcGV+YNA7uCIc8fRk5XD+IXrNInmibFCEIe8m7qUPHjcOL28p7WLdh42VO/4Cq
 vXfm9Xij3ONUlRy/h4Vdizgeo4bpmukCIFSSZnsdGDujDlDMIDbMcpZ1cibReJ/j390RfadZalx
 zRc6pYOXWN28N3w==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com>
Subject: [PATCH 1/4] rust: drm/gpuvm: add GpuVa::data_ref accessor
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

Tyr's VM_BIND remap path rebuilds page-table mappings for the fragments
that survive a split, and those fragments must keep the protection flags
of the original mapping. Add GpuVa::data_ref() so the remap step can
read the VaData of an existing mapping.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: split into separate gpuvm and iommu commits]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/va.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/drm/gpuvm/va.rs b/rust/kernel/drm/gpuvm/va.rs
index 46493f0ec5a6..f81302faba61 100644
--- a/rust/kernel/drm/gpuvm/va.rs
+++ b/rust/kernel/drm/gpuvm/va.rs
@@ -87,6 +87,12 @@ pub fn obj(&self) -> &T::Object {
         unsafe { <T::Object as IntoGEMObject>::from_raw((*self.as_raw()).gem.obj) }
     }
 
+    /// Access the driver-private [`VaData`](DriverGpuVm::VaData) associated with this mapping.
+    #[inline]
+    pub fn data_ref(&self) -> &T::VaData {
+        &self.data
+    }
+
     /// Returns the underlying [`GpuVmBo`] object that backs this [`GpuVa`].
     #[inline]
     pub fn vm_bo(&self) -> &GpuVmBo<T> {

-- 
2.56.1.703.gf848ed807c-goog

