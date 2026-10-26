Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC076606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWY2p8JR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3616410EE6C;
	Mon, 26 Oct 2026 11:40:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6325310EE63;
 Mon, 26 Oct 2026 11:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D69D5438E3;
 Mon, 26 Oct 2026 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB4F1F01825;
 Mon, 26 Oct 2026 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793014822;
 bh=0yefSR5LAq+yRlKgrM9IRhvf+GXzpYxLxjuPWbHRJwg=;
 h=From:Date:Subject:To:Cc;
 b=XWY2p8JREhrMm3Veyl+xOwFb8pzbv8J45pDcJUC4wfkSceA2tFWJ9ovSJqXmlRww6
 z9D40B3w7RH5F9lngxcA8NDIvJG3oT5e0OeB9McpiXOtpz/lcTErNWWZeZe/iyhp0c
 UBhK09FlLaVps2ouwFbVx87zEOoqkeZqE0tvJ4glocH1K+lqZ48HTtSeSHW1ney72O
 G1xU9+FCVczMnWGw9KyHb4dT5WYedDlAuI37Knkrim1/LZyBj18mHSazwzBDNrvkKI
 SBuoXLd37XQTSUF2SIrJnZjhvPoAGwvINYDI7RYP2MJ0fYzaTUbjWxD2PYuLn2AGsU
 3U2kGyblTPSKQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 26 Oct 2026 12:40:02 +0100
Subject: [PATCH RFC] drm/msm: move VM_BIND op validation to Rust
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-topic-vm_bind_rs-v1-1-6581465f2428@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBCF4avIrDVRVHAVEdEajERJB5GIuysWb
 /Et3n8BoyNkKIMLHB7EtFgPGQZgxtYOKKjzhjiKM+kntmUlI4650WS7xrFQSkmdRzJNigz8bXX
 Y0/klq/o373pCs70duO8HXTFKhHQAAAA=
X-Change-ID: 20261026-topic-vm_bind_rs-5551b8014396
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793014814; l=11657;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=D/O2iXmm9rxUdCpJtmhtCsReFTSUEdBCS3Uim6S7Idc=;
 b=WJhzXB9MO+758KRkCbzgMTjiG8fGYOv7mmD20cf9yvLXggsb13kMH6GoAHhsdZvvq51btR9lG
 k5VMZo1/zR4ATttUOyktiBhL/NUevh8Ee6D9xkKVMqrbB09UNbnAn1o
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Much of the VM handling code is a headache to read and maintain.
There's a soup of mixed-signedness/size types which need to be compared
and added and getting that wrong in C is very easy.

The "(range + obj_offset) > obj->size" check could wrap for a large
obj_offset, which let an out-of-range map be accepted and then mapped
as nothing. Oxidize it and use checked_add() to fix that.

This commit is a "get the foot in the door" type change to make sure
that folks building kernels for Qualcomm SoCs have their Rust setup
ready. It may/should be extended to the wider mm code once the
appropriate abstractions are finalized.

Worth noting, the C UERR() macro expands to dev_dbg() and the Rust
implementation for that currently doesn't support dynamic_debug.

The DRM_BRIDGE dependency is dropped because including RUST exposed
some spaghetti dependencies ending at DEBUGFS and it's enabled anyway.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
(if this is rejected we may just patch the C code).

Notably, this will regress some ancient configurations:
-- arch/arm/Kconfig
    select HAVE_RUST if CPU_LITTLE_ENDIAN && CPU_32v7 && !KASAN

Smoke-tested on Glymur
---
 drivers/gpu/drm/msm/Kconfig        |   2 +-
 drivers/gpu/drm/msm/Makefile       |   1 +
 drivers/gpu/drm/msm/msm_gem_vma.c  |  66 +++------------
 drivers/gpu/drm/msm/msm_vm_bind.h  |  16 ++++
 drivers/gpu/drm/msm/msm_vm_bind.rs | 160 +++++++++++++++++++++++++++++++++++++
 rust/uapi/uapi_helper.h            |   1 +
 6 files changed, 188 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index ed1c4775d1e9..f5c4749f8e95 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -3,6 +3,7 @@
 config DRM_MSM
 	tristate "MSM DRM"
 	depends on DRM
+	depends on RUST
 	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on IOMMU_SUPPORT
@@ -63,7 +64,6 @@ config DRM_MSM_VALIDATE_XML
 config DRM_MSM_KMS
 	def_bool n
 	depends on DRM_MSM
-	select DRM_BRIDGE
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 1e246616f83f..826759a820a0 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -129,6 +129,7 @@ msm-y += \
 	msm_ringbuffer.o \
 	msm_submitqueue.o \
 	msm_syncobj.o \
+	msm_vm_bind.o \
 	msm_gpu_tracepoints.o \
 
 msm-$(CONFIG_DRM_MSM_KMS) += \
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d..3c453b034e8f 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -14,6 +14,7 @@
 #include "msm_gpu.h"
 #include "msm_mmu.h"
 #include "msm_syncobj.h"
+#include "msm_vm_bind.h"
 
 #define vm_dbg(fmt, ...) pr_debug("%s:%d: "fmt"\n", __func__, __LINE__, ##__VA_ARGS__)
 
@@ -981,23 +982,12 @@ vm_bind_job_create(struct drm_device *dev, struct drm_file *file, struct drm_gpu
 	return job;
 }
 
-static bool invalid_alignment(uint64_t addr)
-{
-	/*
-	 * Technically this is about GPU alignment, not CPU alignment.  But
-	 * I've not seen any qcom SoC where the SMMU does not support the
-	 * CPU's smallest page size.
-	 */
-	return !PAGE_ALIGNED(addr);
-}
-
 static int
 lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 {
 	struct drm_device *dev = job->vm->drm;
 	struct msm_drm_private *priv = dev->dev_private;
 	int i = job->nr_ops++;
-	int ret = 0;
 
 	job->ops[i].op = op->op;
 	job->ops[i].handle = op->handle;
@@ -1006,48 +996,11 @@ lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 	job->ops[i].range = op->range;
 	job->ops[i].flags = op->flags;
 
-	if (op->flags & ~MSM_VM_BIND_OP_FLAGS)
-		ret = UERR(EINVAL, dev, "invalid flags: %x\n", op->flags);
-
-	if (invalid_alignment(op->iova))
-		ret = UERR(EINVAL, dev, "invalid address: %016llx\n", op->iova);
-
-	if (invalid_alignment(op->obj_offset))
-		ret = UERR(EINVAL, dev, "invalid bo_offset: %016llx\n", op->obj_offset);
-
-	if (invalid_alignment(op->range))
-		ret = UERR(EINVAL, dev, "invalid range: %016llx\n", op->range);
-
-	if (!drm_gpuvm_range_valid(job->vm, op->iova, op->range))
-		ret = UERR(EINVAL, dev, "invalid range: %016llx, %016llx\n", op->iova, op->range);
-
-	/*
-	 * MAP must specify a valid handle.  But the handle MBZ for
-	 * UNMAP or MAP_NULL.
-	 */
-	if (op->op == MSM_VM_BIND_OP_MAP) {
-		if (!op->handle)
-			ret = UERR(EINVAL, dev, "invalid handle\n");
-	} else if (op->handle) {
-		ret = UERR(EINVAL, dev, "handle must be zero\n");
-	}
-
-	switch (op->op) {
-	case MSM_VM_BIND_OP_MAP:
-	case MSM_VM_BIND_OP_MAP_NULL:
-	case MSM_VM_BIND_OP_UNMAP:
-		break;
-	default:
-		ret = UERR(EINVAL, dev, "invalid op: %u\n", op->op);
-		break;
-	}
-
-	if ((op->op == MSM_VM_BIND_OP_MAP_NULL) &&
-	    !adreno_smmu_has_prr(priv->gpu)) {
-		ret = UERR(EINVAL, dev, "PRR not supported\n");
-	}
-
-	return ret;
+	return msm_vm_bind_check_op(dev->dev, op->op, op->handle, op->obj_offset,
+				    op->iova, op->range, op->flags, PAGE_SIZE,
+				    drm_gpuvm_range_valid(job->vm, op->iova, op->range),
+				    op->op == MSM_VM_BIND_OP_MAP_NULL &&
+				    adreno_smmu_has_prr(priv->gpu));
 }
 
 /*
@@ -1118,11 +1071,10 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		op->obj = obj;
 		cnt++;
 
-		if ((op->range + op->obj_offset) > obj->size) {
-			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
-				   op->range, op->obj_offset, obj->size);
+		ret = msm_vm_bind_check_bo_range(dev->dev, op->obj_offset, op->range,
+						 obj->size);
+		if (ret)
 			goto out_unlock;
-		}
 	}
 
 	*nr_bos = cnt;
diff --git a/drivers/gpu/drm/msm/msm_vm_bind.h b/drivers/gpu/drm/msm/msm_vm_bind.h
new file mode 100644
index 000000000000..e8aa6adb9181
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_vm_bind.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __MSM_VM_BIND_H__
+#define __MSM_VM_BIND_H__
+
+#include <linux/types.h>
+
+struct device;
+
+int msm_vm_bind_check_op(struct device *dev, u32 op, u32 handle,
+			 u64 obj_offset, u64 iova, u64 range, u32 flags,
+			 u64 page_size, bool range_valid, bool prr_supported);
+int msm_vm_bind_check_bo_range(struct device *dev, u64 obj_offset, u64 range,
+			       u64 obj_size);
+
+#endif /* __MSM_VM_BIND_H__ */
diff --git a/drivers/gpu/drm/msm/msm_vm_bind.rs b/drivers/gpu/drm/msm/msm_vm_bind.rs
new file mode 100644
index 000000000000..164208e0a1b4
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_vm_bind.rs
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//! VM_BIND operation validation for the MSM driver.
+
+use kernel::{
+    bindings,
+    device::Device,
+    error::code::EINVAL,
+    prelude::*,
+    uapi, //
+};
+
+/// Validates a single VM_BIND operation.
+///
+/// Returns 0 if the operation is valid. Otherwise logs the reason and returns
+/// `-EINVAL`.
+///
+/// `page_size` is the granularity that `iova`, `obj_offset` and `range` must be
+/// aligned to. It is the GPU's alignment rather than the CPU's, but no known qcom
+/// SMMU lacks support for the CPU's smallest page size.
+/// `range_valid` is the result of `drm_gpuvm_range_valid()` for this operation.
+/// `prr_supported` is only consulted for `MSM_VM_BIND_OP_MAP_NULL`.
+///
+/// # Safety
+///
+/// `dev` must point to a live `struct device`.
+#[no_mangle]
+pub unsafe extern "C" fn msm_vm_bind_check_op(
+    dev: *mut bindings::device,
+    op: u32,
+    handle: u32,
+    obj_offset: u64,
+    iova: u64,
+    range: u64,
+    flags: u32,
+    page_size: u64,
+    range_valid: bool,
+    prr_supported: bool,
+) -> c_int {
+    // SAFETY: The caller guarantees that `dev` is a live `struct device`.
+    let dev: &Device = unsafe { Device::from_raw(dev) };
+
+    match check_op(
+        dev,
+        op,
+        handle,
+        obj_offset,
+        iova,
+        range,
+        flags,
+        page_size,
+        range_valid,
+        prr_supported,
+    ) {
+        Ok(()) => 0,
+        Err(e) => e.to_errno(),
+    }
+}
+
+fn check_op(
+    dev: &Device,
+    op: u32,
+    handle: u32,
+    obj_offset: u64,
+    iova: u64,
+    range: u64,
+    flags: u32,
+    page_size: u64,
+    range_valid: bool,
+    prr_supported: bool,
+) -> Result {
+    let aligned = |addr: u64| page_size.is_power_of_two() && (addr & (page_size - 1)) == 0;
+
+    if flags & !uapi::MSM_VM_BIND_OP_FLAGS != 0 {
+        dev_dbg!(dev, "invalid flags: {:x}\n", flags);
+        return Err(EINVAL);
+    }
+
+    if !aligned(iova) {
+        dev_dbg!(dev, "invalid address: {:016x}\n", iova);
+        return Err(EINVAL);
+    }
+
+    if !aligned(obj_offset) {
+        dev_dbg!(dev, "invalid bo_offset: {:016x}\n", obj_offset);
+        return Err(EINVAL);
+    }
+
+    if !aligned(range) {
+        dev_dbg!(dev, "invalid range: {:016x}\n", range);
+        return Err(EINVAL);
+    }
+
+    if !range_valid {
+        dev_dbg!(dev, "invalid range: {:016x}, {:016x}\n", iova, range);
+        return Err(EINVAL);
+    }
+
+    // MAP must name a handle; UNMAP and MAP_NULL must not.
+    match op {
+        uapi::MSM_VM_BIND_OP_MAP => {
+            if handle == 0 {
+                dev_dbg!(dev, "invalid handle\n");
+                return Err(EINVAL);
+            }
+        }
+        uapi::MSM_VM_BIND_OP_UNMAP | uapi::MSM_VM_BIND_OP_MAP_NULL => {
+            if handle != 0 {
+                dev_dbg!(dev, "handle must be zero\n");
+                return Err(EINVAL);
+            }
+        }
+        _ => {
+            dev_dbg!(dev, "invalid op: {}\n", op);
+            return Err(EINVAL);
+        }
+    }
+
+    if op == uapi::MSM_VM_BIND_OP_MAP_NULL && !prr_supported {
+        dev_dbg!(dev, "PRR not supported\n");
+        return Err(EINVAL);
+    }
+
+    Ok(())
+}
+
+/// Checks that `[obj_offset, obj_offset + range)` lies within an object of
+/// `obj_size` bytes.
+///
+/// Returns 0 if it does. Otherwise logs the reason and returns `-EINVAL`.
+///
+/// # Safety
+///
+/// `dev` must point to a live `struct device`.
+#[no_mangle]
+pub unsafe extern "C" fn msm_vm_bind_check_bo_range(
+    dev: *mut bindings::device,
+    obj_offset: u64,
+    range: u64,
+    obj_size: u64,
+) -> c_int {
+    // SAFETY: The caller guarantees that `dev` is a live `struct device`.
+    let dev: &Device = unsafe { Device::from_raw(dev) };
+
+    let fits = obj_offset
+        .checked_add(range)
+        .is_some_and(|end| end <= obj_size);
+
+    if fits {
+        return 0;
+    }
+
+    dev_dbg!(
+        dev,
+        "invalid range: {:016x} + {:016x} > {:016x}\n",
+        range,
+        obj_offset,
+        obj_size
+    );
+    EINVAL.to_errno()
+}
diff --git a/rust/uapi/uapi_helper.h b/rust/uapi/uapi_helper.h
index 489748ef642c..38741220270a 100644
--- a/rust/uapi/uapi_helper.h
+++ b/rust/uapi/uapi_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <uapi/drm/drm.h>
+#include <uapi/drm/msm_drm.h>
 #include <uapi/drm/nova_drm.h>
 #include <uapi/drm/panthor_drm.h>
 #include <uapi/linux/android/binder.h>

---
base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
change-id: 20261026-topic-vm_bind_rs-5551b8014396

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

