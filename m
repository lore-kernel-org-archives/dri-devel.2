Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA03C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C0610E5B8;
	Wed,  8 Jul 2026 11:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gCnsAKSY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AD210E5B8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 11:53:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A62464193A;
 Wed,  8 Jul 2026 11:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211EA1F000E9;
 Wed,  8 Jul 2026 11:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783511629;
 bh=rdxl7IdBBRnl/VjmGlLMS0ydVwD25wn/ZqHLovQ6J6I=;
 h=From:Date:Subject:To:Cc;
 b=gCnsAKSY+e6QbI+E+K7+TivToH0yJwdaWxYXBes+wU8hsG0n0ifOMFczy/pA5VyOD
 c+Fgnq+QddgwI4x7CFLcN3oCn5ymePLeucyEQ8EVgK56u1YAFpw1JO1f+EFZPc20Uq
 ref8rB2EbglbPiCVHMADGqYvGXCc0SpneRRs6vIKc4tMWPbg2GfwSU+g0sKzrYmyX3
 Rp1o7wuSniLXA33RteEWnIKrazXENCrXN723ImJ8KbD1K7khmQUCEpTANVDHpiNIvx
 F/hu+632nGu7qojRmvN2+Ah2GILBmvhw5FVZc/WHtRQqRaE/yjhiK1kUxaWbk1ybxK
 /alm3AcHuOPig==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 08 Jul 2026 13:52:21 +0200
Subject: [PATCH] rust: helpers: guard dma_resv helpers with
 CONFIG_DMA_SHARED_BUFFER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-dma-shared-buffer-config-v1-1-8c1571000855@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPQ5TmoC/yXMTQ6CQAxA4auQrm0yg4jGqxgX89NCTRxMC8aEc
 HdGXX6L91YwUiGDa7OC0ltMplLhDw2kMZSBUHI1tK7t3dldMD8D2hiUMsaFmRTTVFgGjNEfT5x
 j77mDmr+UWD6/9e3+ty3xQWn+/mDbdtC4iq58AAAA
X-Change-ID: 20260708-dma-shared-buffer-config-bb135fdb61f4
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Asahi Lina <lina+kernel@asahilina.net>, David Airlie <airlied@gmail.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=GFw7D/JMS0BsuGX/tR7HOdbhomGNW/4YluYwoedfrRI=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqTjohxZF84h7fJ2UmPYxqA3vKydhfq68R9bG+u
 XHX9BC8+nyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCak46IQAKCRD6UCkIqsW9
 0KbgD/4qZPbBYIIzwFdYkfFfWNNcSR/UjYKuc8ShlJJMJuVC+okSfR/t/PEmKH/d5rWhgoZKSQI
 wakFdKarTn2mL5aUUGzxVg3c+XZDhMsbTn7ORMkIXS0xJb/i1Al8lq7zRIvtWqo+yxdG35npfY8
 Br2odXPH9fId8f7pZ+1tWTJNxjk7xHSooaqmHwGJe9Tb8ZvED7IzQq/tdCB3II/Z9gfJDJToBVx
 cefsOFlTGR8bZJ7p6jY177YFeuCrQbK43Q7ayEUpnR2obYAIqpX8kTHt2W/LIV+/74DfhxE0jJy
 EHd49f+i66phQnOhTnAWgSWZH3tHIudzPfcnKC+PmJyHqOOtp+WyAZXjO0lnTVKGFpZF4nqJLVb
 rtLItXxPl7+HQE/ZvaD90Qy+fD2DSUNpSn2m0yZFDRvxBJ2iYD7CRm010mrzqXVePAokiD7tA5y
 Eu3jvLQ8RHO4FMch1BE3MCmfZXUs2qVatz8njLXLJNrNaaYK78M1yVAlcDdETAkEfr8seGYf11F
 LtAH7YfmA88CYenw8iKSvX6vHMtU5LteV3Pb5UfJhy54fF59Z3z9U58YVDHNPKltY6xeb2pZMlW
 lDanf/t1GhoEViAW/wHPWS7921LNLacFViQ/gym8xnBZJ8Y555VO6287s0vXMjWsFdrj1dN9fiX
 a93sMYAhVp+8LwQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Commit 9b836641d3bf ("rust: helpers: Add bindings/wrappers for
dma_resv_lock") added rust_helper_dma_resv_lock() and
rust_helper_dma_resv_unlock() unconditionally. However, the dma-resv
functionality is only available when CONFIG_DMA_SHARED_BUFFER is
enabled, resulting in the following link error when it is not:

      LD      .tmp_vmlinux1
    ld.lld: error: undefined symbol: dma_resv_reset_max_fences
    >>> referenced by dma-resv.h:463
    >>>               rust/helpers/helpers.o:(rust_helper_dma_resv_unlock) in archive vmlinux.a

The dma_resv_unlock() inline in <linux/dma-resv.h> calls
dma_resv_reset_max_fences(), which is only compiled into
drivers/dma-buf/dma-resv.c when CONFIG_DMA_SHARED_BUFFER is set. With
the option disabled the symbol is never defined, so the helper fails
to link.

Fix this by guarding the helper definitions with `#ifdef
CONFIG_DMA_SHARED_BUFFER`.

The only user of this helper is the DRM shmem abstractions, which already
depend on `CONFIG_DMA_SHARED_BUFFER`.

Cc: stable@vger.kernel.org
Fixes: 9b836641d3bf ("rust: helpers: Add bindings/wrappers for dma_resv_lock")
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/helpers/dma-resv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/helpers/dma-resv.c b/rust/helpers/dma-resv.c
index 71914d8241e2..1698092b9317 100644
--- a/rust/helpers/dma-resv.c
+++ b/rust/helpers/dma-resv.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#ifdef CONFIG_DMA_SHARED_BUFFER
+
 #include <linux/dma-resv.h>
 
 __rust_helper
@@ -12,3 +14,5 @@ __rust_helper void rust_helper_dma_resv_unlock(struct dma_resv *obj)
 {
 	dma_resv_unlock(obj);
 }
+
+#endif

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260708-dma-shared-buffer-config-bb135fdb61f4

Best regards,
--  
Andreas Hindborg <a.hindborg@kernel.org>


