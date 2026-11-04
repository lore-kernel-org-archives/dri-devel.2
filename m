Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C0606A33A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Cr5Tno3+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C9210E8D4;
	Wed,  4 Nov 2026 23:06:00 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DBF010E1F6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:05:51 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKgz04t5sz8txs;
 Thu, 05 Nov 2026 00:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793833548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk4WUdGtMBpXxFlU2gsTKHL5X57Q6FlmfAkxcOewlgA=;
 b=Cr5Tno3+fe+947pjEHRbQJWU42djxq9ROJ9nS5yqy0wxIDebBfo8wyXyGiKCENiQcH97tR
 Ra5GdRjEj+yTUtt60z2eM4wRJjF7bs5oDTumNsGUObPqLJgOlZQTac749ZlsuzI3/eF49G
 gkkbIwUrHsiauml+qdeVSv4EO3hfiDJ6Y4Ycd2vUnC/GeYaEe5I8emqatP2yMugVV82+8C
 CN08/j9FVLe8rhl1dbcgRxs5f0CSoWfaw4hgFDVMQ7I2RJ/QNoS77MmwooUvsFxdNtjBGv
 ZFPLYYZ/CL2K4+zX8eDkbXtrMPuYxIrxY67ZleoZHml7J4i4OBABB6ag9tKVBA==
From: Maurice Hieronymus <mhi@mailbox.org>
Date: Thu, 05 Nov 2026 00:05:36 +0100
Subject: [PATCH v4 5/7] rust: pci: add Vendor::QEMU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-5-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=1273;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=HRhAsT9Seny6GaddcwsH5oWJkF9JcIp3UyvO8eRc4IA=;
 b=stUPfWXStt9A4zT/FGWJnenOAWvAH6mHoJ6cOzSR9fsd55OTNzblZ7itmjdvn4EVD1cf0E9Ax
 O10BMGziEJ+Dt0et4E5lIG0lWs3pMXMUOqOChM4Icw6fzrmegzgnFCW
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: shizh1y38efqmn11hq1ypj6x3zs1u9s7
X-MBO-RS-ID: e88ff492b45b83564d2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose `PCI_VENDOR_ID_QEMU` as `Vendor::QEMU`, so Rust drivers can match
QEMU's 0x1234 devices without constructing a `Vendor` from a raw ID.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 rust/kernel/pci/id.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index dbaf301666e7..d17706485402 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -418,6 +418,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     CYCLADES                 = bindings::PCI_VENDOR_ID_CYCLADES,                 // 0x120e
     O2                       = bindings::PCI_VENDOR_ID_O2,                       // 0x1217
     THREEDX                  = bindings::PCI_VENDOR_ID_3DFX,                     // 0x121a
+    QEMU                     = bindings::PCI_VENDOR_ID_QEMU,                     // 0x1234
     AVM                      = bindings::PCI_VENDOR_ID_AVM,                      // 0x1244
     STALLION                 = bindings::PCI_VENDOR_ID_STALLION,                 // 0x124d
     AT                       = bindings::PCI_VENDOR_ID_AT,                       // 0x1259

-- 
2.54.0

