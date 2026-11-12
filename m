Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CC606A331
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED301123C5;
	Thu, 12 Nov 2026 22:59:44 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B63910E703
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:32 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-8b33de9d2b1so3044227b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524371; x=1795129171;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBKSY09ZovYk2pHSCRwweS5xYcSJ8LHMABnEWEesotc=;
 b=GlqzvFDWyXDMHTSMPXRzafyflLOPjkh914KUniosNm16zftvEnVoIQZRtMUmyO2C87
 kAlbU5b5GJ7ntWhZ/JHfDgES2q6t0lHzfWdw41KlvuxKL1ZPN5eCoKKv5Q9BB72G/uyN
 CytziqQ0Dro2DBKb0qxOdRGKos2T5RfnV0Tugu54ZxpsVdCTtOF0NWAW8EusYOecMOCG
 DCBjPq3Ci8QPCzLxfxtn9SgiUSKj/newZ16wAsDPb/qi2Lfem6hsTTvaQsgYgtizxCXC
 drCQzh5oz6fY4u5SN1aRMbgDqur5wXR0xT0mTHq1mEo6eQfzZAoffFQH3N1E58y5VNKO
 uqRw==
X-Gm-Message-State: APuU4Z8AKgoxwF9G242aDaF9DbF7FzpdYtR/NLp/q4LNugYmnIcGmH8Q
 EYnNymELnhF/njWE1PbLY21+P5nhfiKCXlW76OQakWOj2NnN+WWJW0HO
X-Gm-Gg: AYBFou14X7c9o/y4sUTNLCRC9FWMQ1Yz++01Bqwjj5n0o39YiWLXBE3q3T1lZYOChI7
 FQxK8B8gz89HSNcJ5+NS+xvBAOeRR8y6yf3ILhJEx995gRfkB+B5JcNnwP9DVMmHSccpvoOZB4W
 aDLWsmvbsgBIEiSCO9yO6bFNrFheUWC0VHLZ1Pq/Mc45nIFxjL0VyrEKg31icuVULGLZdR1bIc5
 fdBmDlB5UkLX6Y7kP6H2bDHB+RrSSxelJYo5LeU0KEIiQIQGtZJcPBidWnIomqIIvC/+WLmI+yT
 AI/9ZK4+51WDAQgdhcRRU4gFBS9GvMCCQCpru5OVC0rgNHdgtGqKfcbNjId9vVqDeSLFyiJ+k4K
 1Riw61LjqwDN2XeDXXq/OzPfYTSfHpSADEwERYTw23qagozcOQnkcMWaqkQzGlNq0/vwLAvQWY2
 KaCWUv6+KL11VDqkjisN9O8i5R3JKBdAox4kgRgDlCnxdk+7XZpQcsMrhAdfYbweVNMOLK5f+oh
 3klHsWgV/ORrtB/0Iwv5/+y6mldLcPOUqx+EksJHBVH92X8QLCYXLlzHsreHOokW9Fw4w/NDlcO
 3wzWdMOYkhbiwocHkI39Gphb9ZZrrzW4AUrH7WDQe+GO5AZKyc/m3huZ2+0Pyv1fMyhiU7Pls9m
 IIvQMZHROLguvfYLuEa5/ZxcgbXpnP8O+jus3doolgO2rbBRCyxgTFjW0iyOxxN4U/xzq+2syt2
 zqr+hIuJebbF4UiCwvZSkm557yXk8=
X-Received: by 2002:a05:690c:f87:b0:8b3:5fd6:a544 with SMTP id
 00721157ae682-8b4aa28e410mr5929767b3.58.1794524370594; 
 Thu, 12 Nov 2026 14:59:30 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:29 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:59:03 -0500
Subject: [PATCH RFC 13/13] drm/powervr_sgx: Add KUnit tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-13-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Tests that need no GPU:

- powervr_sgx_fw: a well-formed firmware file is accepted, and each
  malformed header, table and checksum is refused.
- powervr_sgx_kobj: the chain of kernel objects a released client
  leaves behind is freed at unbind.
- powervr_sgx_core: the core table's lookups and entries.
- powervr_sgx_equiv: every register write and every structure the
  kernel builds for the microkernel on the SGX545, through a start, a
  command, a recovery, a stop, a resume, contexts and a two-frame
  render, checked against a recorded golden.
- powervr_sgx_ccb, powervr_sgx_rt, powervr_sgx_usse,
  powervr_sgx_validate and powervr_sgx_prime: the command ring,
  render-target tiling numbers, the instruction table, the shader
  validator and a job's cache ranges.

Run them with:

  ./tools/testing/kunit/kunit.py run --arch=x86_64 \
      --kunitconfig=drivers/gpu/drm/powervr_sgx/tests/.kunitconfig

The tests are included into the driver's own objects, and with them built
in, the register write helper calls a test hook so the equivalence test
can record every write.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/Kconfig                |  16 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c           |   4 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_core.c          |   4 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c            |   5 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c         |   4 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_render.c        |   5 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c          |   4 +
 drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c      |   4 +
 drivers/gpu/drm/powervr_sgx/tests/.kunitconfig     |   5 +
 .../gpu/drm/powervr_sgx/tests/pvrsgx_ccb_test.c    | 111 +++++
 .../gpu/drm/powervr_sgx/tests/pvrsgx_core_test.c   | 119 +++++
 .../drm/powervr_sgx/tests/pvrsgx_equiv_golden.h    |  32 ++
 .../gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c  | 555 +++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/tests/pvrsgx_fw_test.c | 168 +++++++
 .../gpu/drm/powervr_sgx/tests/pvrsgx_kobj_test.c   | 203 ++++++++
 .../gpu/drm/powervr_sgx/tests/pvrsgx_prime_test.c  | 125 +++++
 drivers/gpu/drm/powervr_sgx/tests/pvrsgx_rt_test.c |  63 +++
 .../gpu/drm/powervr_sgx/tests/pvrsgx_usse_test.c   | 145 ++++++
 .../drm/powervr_sgx/tests/pvrsgx_validate_test.c   |  32 ++
 19 files changed, 1604 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/Kconfig b/drivers/gpu/drm/powervr_sgx/Kconfig
index dbbba1d68..6c880ffef 100644
--- a/drivers/gpu/drm/powervr_sgx/Kconfig
+++ b/drivers/gpu/drm/powervr_sgx/Kconfig
@@ -47,3 +47,19 @@ config DRM_POWERVR_SGX_OF
 	  bring-up. Dma-buf import isn't supported on ARM yet.
 
 	  Say N unless this kernel is for such an SoC.
+
+config DRM_POWERVR_SGX_KUNIT_TEST
+	tristate "KUnit tests for the PowerVR SGX5xx driver" if !KUNIT_ALL_TESTS
+	depends on DRM_POWERVR_SGX && KUNIT
+	select DRM_KUNIT_TEST_HELPERS
+	default KUNIT_ALL_TESTS
+	help
+	  Unit tests of the driver's firmware file checks (a well-formed
+	  image is accepted, and every malformed header, table and checksum
+	  is refused), of kernel-object teardown at unbind, of the core
+	  table, of a job's cache ranges and of a render target's tiling
+	  numbers, and a record of the SGX545's register writes and
+	  firmware structures that a change must leave as it is. The tests
+	  need no GPU.
+
+	  For developers; if unsure, say N.
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c
index 351a7f930..1698ff9f0 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c
@@ -202,3 +202,7 @@ void pvrsgx_ccb_inval_reap(struct pvrsgx_device *sdev, bool all)
 		w->done(w);
 	}
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_ccb_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
index dd8fd14eb..ebc0cba0b 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
@@ -294,3 +294,7 @@ const struct pvrsgx_core_info *pvrsgx_core_lookup(const struct pvrsgx_core_famil
 			return &cores[i];
 	return NULL;
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_core_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c
index b3c0d1891..4787ed69a 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c
@@ -729,3 +729,8 @@ void pvrsgx_fw_stop(struct pvrsgx_device *sdev)
 		sgx_rd(sdev, SGX_CR_SOFT_RESET);
 	}
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_fw_test.c"
+#include "tests/pvrsgx_equiv_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
index e6aca1145..cb5ddf212 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
@@ -201,3 +201,7 @@ void pvrsgx_prime_put(struct pvrsgx_job *job)
 		drm_gem_object_put(job->ranges[i].obj);
 	kvfree(job->ranges);
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_prime_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c
index 00b444d05..67e7dfc11 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c
@@ -950,3 +950,8 @@ void pvrsgx_job_dump(struct seq_buf *sb, struct pvrsgx_job *job)
 	else if (job->type == DRM_POWERVR_SGX_JOB_TYPE_TRANSFER)
 		pvrsgx_transfer_dump(sb, job);
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_kobj_test.c"
+#include "tests/pvrsgx_rt_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c
index 9aa0cd4ab..38d2bd302 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_usse.c
@@ -234,3 +234,7 @@ const char *pvrsgx_usse_refusal_name(enum pvrsgx_usse_refusal why)
 
 	return why < ARRAY_SIZE(names) ? names[why] : "?";
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_usse_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c
index cf9cfcf87..4a52ff10d 100644
--- a/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c
@@ -186,3 +186,7 @@ out_obj:
 	drm_gem_object_put(obj);
 	return err;
 }
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+#include "tests/pvrsgx_validate_test.c"
+#endif
diff --git a/drivers/gpu/drm/powervr_sgx/tests/.kunitconfig b/drivers/gpu/drm/powervr_sgx/tests/.kunitconfig
new file mode 100644
index 000000000..3bf1e8f2c
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_PCI=y
+CONFIG_DRM=y
+CONFIG_DRM_POWERVR_SGX=y
+CONFIG_DRM_POWERVR_SGX_KUNIT_TEST=y
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_ccb_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_ccb_test.c
new file mode 100644
index 000000000..fee8a7fe8
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_ccb_test.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * KUnit tests of the kernel CCB's cache control, included from
+ * pvrsgx_ccb.c. The ring, its control words and the registers are memory;
+ * no microkernel takes commands, so the read offset never moves.
+ */
+
+#include <kunit/test.h>
+
+#include "../pvrsgx_drv.h"
+
+/* A device on the SGX545's table, with quirks replaced. */
+static struct pvrsgx_device *ccb_test_device(struct kunit *test, u32 quirks)
+{
+	struct pvrsgx_device *sdev = kunit_kzalloc(test, sizeof(*sdev), GFP_KERNEL);
+	struct pvrsgx_core_family *family = kunit_kzalloc(test, sizeof(*family), GFP_KERNEL);
+	void *regs = kunit_kzalloc(test, PVRSGX_REGS_MIN, GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, sdev);
+	KUNIT_ASSERT_NOT_NULL(test, family);
+	KUNIT_ASSERT_NOT_NULL(test, regs);
+	KUNIT_ASSERT_NOT_NULL(test, pvrsgx_core_family_get(545));
+	*family = *pvrsgx_core_family_get(545);
+	family->quirks = quirks;
+	sdev->family = family;
+	sdev->cr = family->regs;
+	sdev->regs = (void __iomem __force *)regs;
+	sdev->fw.cpu[PVRSGX_FW_CCB] = kunit_kzalloc(test, PVRSGX_CCB_SLOTS *
+						    PVRSGX_CCB_CMD_WORDS * 4, GFP_KERNEL);
+	sdev->fw.cpu[PVRSGX_FW_CCBCTL] = kunit_kzalloc(test, 8, GFP_KERNEL);
+	sdev->fw.cpu[PVRSGX_FW_KICKER] = kunit_kzalloc(test, 4, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->fw.cpu[PVRSGX_FW_CCB]);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->fw.cpu[PVRSGX_FW_CCBCTL]);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->fw.cpu[PVRSGX_FW_KICKER]);
+	mutex_init(&sdev->ccb_lock);
+	spin_lock_init(&sdev->ccb_spin);
+	return sdev;
+}
+
+static const u32 *ccb_test_cmd(struct pvrsgx_device *sdev, unsigned int slot)
+{
+	return (u32 *)sdev->fw.cpu[PVRSGX_FW_CCB] + slot * PVRSGX_CCB_CMD_WORDS;
+}
+
+/* Without the quirk (the SGX545) a BIF and a data invalidate go together, as before. */
+static void ccb_test_inval_together(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = ccb_test_device(test, 0);
+	static const u32 data[6] = { 1, 2, 3, 4, 5, 6 };
+	u64 seq;
+
+	sdev->fw.cache_control = PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA;
+	KUNIT_ASSERT_EQ(test, pvrsgx_ccb_send(sdev, PVRSGX_KCMD_TA, data, &seq), 0);
+	KUNIT_EXPECT_EQ(test, seq, 1);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[0], PVRSGX_KCMD_TA);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[1],
+			PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[2], 1);
+	KUNIT_EXPECT_EQ(test, sdev->fw.cache_control, 0);
+}
+
+/*
+ * BRN_28889: the BIF part goes alone in a PROCESS_QUEUES, and the command
+ * with the data part waits until the microkernel has taken it. Nothing takes
+ * it here, so the send gives up, bounded, with the job's command unwritten
+ * and the invalidates kept for the next try.
+ */
+static void ccb_test_inval_split(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = ccb_test_device(test, PVRSGX_QUIRK_BRN_28889);
+	static const u32 data[6] = { 1, 2, 3, 4, 5, 6 };
+	u64 seq = 0;
+
+	sdev->fw.cache_control = PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA;
+	KUNIT_EXPECT_EQ(test, pvrsgx_ccb_send(sdev, PVRSGX_KCMD_TA, data, &seq), -ETIMEDOUT);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[0], PVRSGX_KCMD_PROCESS_QUEUES);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[1], PVRSGX_CC_INVAL_BIF_PD);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[2], 0);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 1)[0], 0);
+	KUNIT_EXPECT_EQ(test, seq, 0);
+	KUNIT_EXPECT_EQ(test, sdev->fw.cache_control,
+			PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA);
+}
+
+/* One kind of invalidate alone needs no split, with the quirk or without. */
+static void ccb_test_inval_alone(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = ccb_test_device(test, PVRSGX_QUIRK_BRN_28889);
+	static const u32 data[6];
+
+	sdev->fw.cache_control = PVRSGX_CC_INVAL_DATA;
+	KUNIT_ASSERT_EQ(test, pvrsgx_ccb_send(sdev, PVRSGX_KCMD_TA, data, NULL), 0);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[0], PVRSGX_KCMD_TA);
+	KUNIT_EXPECT_EQ(test, ccb_test_cmd(sdev, 0)[1], PVRSGX_CC_INVAL_DATA);
+}
+
+static struct kunit_case pvrsgx_ccb_test_cases[] = {
+	KUNIT_CASE(ccb_test_inval_together),
+	KUNIT_CASE(ccb_test_inval_split),
+	KUNIT_CASE(ccb_test_inval_alone),
+	{}
+};
+
+static struct kunit_suite pvrsgx_ccb_test_suite = {
+	.name = "powervr_sgx_ccb",
+	.test_cases = pvrsgx_ccb_test_cases,
+};
+
+kunit_test_suite(pvrsgx_ccb_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_core_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_core_test.c
new file mode 100644
index 000000000..ebc7059ed
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_core_test.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/* KUnit tests of the core table, included from pvrsgx_core.c. */
+
+#include <kunit/test.h>
+
+static void core_test_lookup(struct kunit *test)
+{
+	const struct pvrsgx_core_family *f = pvrsgx_core_family_get(545);
+
+	KUNIT_ASSERT_NOT_NULL(test, f);
+	KUNIT_EXPECT_STREQ(test, pvrsgx_core_lookup(f, 0x01150000, 0x0001000e)->name,
+			   "Intel CE5300 (SGX545 1.0.14)");
+	KUNIT_EXPECT_STREQ(test, pvrsgx_core_lookup(f, 0x01150000, 0x0001000d)->name,
+			   "Intel Cedarview (SGX545 1.0.13)");
+	KUNIT_EXPECT_NULL(test, pvrsgx_core_lookup(f, 0x01150000, 0x0001000c));
+	KUNIT_EXPECT_NULL(test, pvrsgx_core_lookup(f, 0x01120000, 0x0001000e));
+}
+
+static void core_test_unknown(struct kunit *test)
+{
+	KUNIT_EXPECT_NULL(test, pvrsgx_core_family_get(0));
+	KUNIT_EXPECT_NULL(test, pvrsgx_core_family_get(535));
+	KUNIT_EXPECT_NULL(test, pvrsgx_core_family_get(544));
+}
+
+/* Every entry is one the driver can drive, with the registers it reads first. */
+static void core_test_table(struct kunit *test)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(families); i++) {
+		const struct pvrsgx_core_family *f = &families[i];
+
+		KUNIT_EXPECT_TRUE(test, pvrsgx_core_family_usable(f));
+		KUNIT_EXPECT_NE(test, f->regs->core_id, 0);
+		KUNIT_EXPECT_NE(test, f->regs->core_revision, 0);
+		KUNIT_EXPECT_EQ(test, !!(f->features & PVRSGX_FEATURE_MULTI_EVENT_KICK),
+				!!f->regs->event_kick2);
+		KUNIT_EXPECT_NE(test, f->regs->use_code_base0, 0);
+		KUNIT_EXPECT_GT(test, f->num_init_regs, 0);
+	}
+	for (unsigned int i = 0; i < ARRAY_SIZE(cores); i++) {
+		KUNIT_EXPECT_NOT_NULL(test, cores[i].family);
+		KUNIT_EXPECT_NOT_NULL(test, cores[i].fw_name);
+		KUNIT_EXPECT_GT(test, cores[i].clock_hz, 0);
+	}
+}
+
+/*
+ * The SGX545's table holds what the driver used before the table had it:
+ * the heap constants, the shifts and the registers.
+ */
+static void core_test_sgx545_values(struct kunit *test)
+{
+	const struct pvrsgx_core_family *f = pvrsgx_core_family_get(545);
+	const struct pvrsgx_heap_layout *h;
+
+	KUNIT_ASSERT_NOT_NULL(test, f);
+	h = f->heaps;
+	KUNIT_ASSERT_NOT_NULL(test, h);
+	KUNIT_EXPECT_EQ(test, h->params_3d.base, PVRSGX_HEAP_3D_PARAMS);
+	KUNIT_EXPECT_EQ(test, h->ta_data.base, PVRSGX_HEAP_TA_DATA);
+	KUNIT_EXPECT_EQ(test, h->sync.base, PVRSGX_HEAP_SYNC);
+	KUNIT_EXPECT_EQ(test, h->pds_pixel.base, PVRSGX_HEAP_PDS_PIXEL);
+	KUNIT_EXPECT_EQ(test, h->kernel_code.base, PVRSGX_HEAP_KERNEL_CODE);
+	KUNIT_EXPECT_EQ(test, h->pds_vertex.base, PVRSGX_HEAP_PDS_VERTEX);
+	KUNIT_EXPECT_EQ(test, h->kernel_data.base, PVRSGX_HEAP_KERNEL_DATA);
+	KUNIT_EXPECT_EQ(test, h->usse_pixel.base, PVRSGX_HEAP_USSE_PIXEL);
+	KUNIT_EXPECT_EQ(test, h->usse_pixel.end - h->usse_pixel.base, PVRSGX_HEAP_USSE_PIXEL_SIZE);
+	KUNIT_EXPECT_EQ(test, h->usse_vertex.base, PVRSGX_HEAP_USSE_VERTEX);
+	KUNIT_EXPECT_EQ(test, h->usse_vertex.end - h->usse_vertex.base,
+			PVRSGX_HEAP_USSE_VERTEX_SIZE);
+	KUNIT_EXPECT_EQ(test, h->general.base, PVRSGX_HEAP_GENERAL);
+	KUNIT_EXPECT_EQ(test, h->texture.base, PVRSGX_HEAP_TEXTURE);
+	KUNIT_EXPECT_EQ(test, h->texture.end, SZ_4G);
+	KUNIT_EXPECT_EQ(test, h->pb_max_pages, 0x8000);
+	KUNIT_EXPECT_EQ(test, f->quirks, 0);
+	KUNIT_EXPECT_EQ(test, f->regs->bif_fault_addr, SGX_MMU_ADDR_MASK);
+	KUNIT_EXPECT_EQ(test, f->regs->bif_bank_set, SGX_CR_BIF_BANK_SET);
+	KUNIT_EXPECT_EQ(test, f->regs->bif_bank0, SGX_CR_BIF_BANK0);
+	KUNIT_EXPECT_EQ(test, f->regs->use_code_base_addr_shift, 7);
+	KUNIT_EXPECT_EQ(test, f->regs->use_code_base_dm_shift, 25);
+	KUNIT_EXPECT_EQ(test, f->regs->cr_b30, 0x0b30);
+}
+
+/* The SGX530: one directory list, 28 bits, BRN_28889, a layout the EDM reaches. */
+static void core_test_sgx530(struct kunit *test)
+{
+	const struct pvrsgx_core_family *f = pvrsgx_core_family_get(530);
+
+	KUNIT_ASSERT_NOT_NULL(test, f);
+	KUNIT_EXPECT_TRUE(test, pvrsgx_core_single_context(f));
+	KUNIT_EXPECT_EQ(test, f->num_dir_lists, 1);
+	KUNIT_EXPECT_EQ(test, f->va_bits, 28);
+	KUNIT_EXPECT_EQ(test, f->quirks, PVRSGX_QUIRK_BRN_28889);
+	KUNIT_EXPECT_EQ(test, f->regs->event_kick2, 0);
+	KUNIT_EXPECT_EQ(test, f->regs->bif_bank0, 0);
+	KUNIT_EXPECT_EQ(test, f->regs->clkgatectl2, 0);
+	KUNIT_EXPECT_TRUE(test, pvrsgx_core_family_usable(f));
+	KUNIT_EXPECT_FALSE(test, pvrsgx_core_single_context(pvrsgx_core_family_get(545)));
+	KUNIT_EXPECT_STREQ(test, pvrsgx_core_lookup(f, 0x01120000, 0x00010205)->name,
+			   "TI OMAP3630 (SGX530 1.2.5)");
+}
+
+static struct kunit_case pvrsgx_core_test_cases[] = {
+	KUNIT_CASE(core_test_lookup),
+	KUNIT_CASE(core_test_unknown),
+	KUNIT_CASE(core_test_table),
+	KUNIT_CASE(core_test_sgx545_values),
+	KUNIT_CASE(core_test_sgx530),
+	{}
+};
+
+static struct kunit_suite pvrsgx_core_test_suite = {
+	.name = "powervr_sgx_core",
+	.test_cases = pvrsgx_core_test_cases,
+};
+
+kunit_test_suite(pvrsgx_core_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_golden.h b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_golden.h
new file mode 100644
index 000000000..635481da7
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_golden.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The SGX545 records of pvrsgx_equiv_test.c: each phase's line count and
+ * CRC32. Change these only for a change meant to change the SGX545's
+ * behavior, and say so in the commit message.
+ */
+
+#ifndef PVRSGX_EQUIV_GOLDEN_H
+#define PVRSGX_EQUIV_GOLDEN_H
+
+struct pvrsgx_equiv_golden {
+	const char *phase;
+	u32 lines;
+	u32 crc;
+};
+
+static const struct pvrsgx_equiv_golden pvrsgx_equiv_golden_545[] = {
+	{ "init", 102, 0x0df03815 },
+	{ "start", 82, 0xb260b7dd },
+	{ "send", 20, 0x09fa89bc },
+	{ "recover", 197, 0x4ae5dc12 },
+	{ "stop", 26, 0x936dee2f },
+	{ "resume", 82, 0xb260b7dd },
+	{ "ctx", 29, 0xeb46322d },
+	{ "render", 429, 0xe7477b44 },
+	{ "heaps", 22, 0x85d1b2f7 },
+	{ "teardown", 0, 0x00000000 },
+};
+
+#endif /* PVRSGX_EQUIV_GOLDEN_H */
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c
new file mode 100644
index 000000000..aa10ee3d3
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_equiv_test.c
@@ -0,0 +1,555 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The SGX545 path, recorded: every register write, in order, and the bytes
+ * of every structure the kernel builds for the microkernel, through a start,
+ * a command, a recovery, a stop, a resume, a render and a transfer context,
+ * a render target dataset and two frames of a two-kick render built through
+ * it, and the heap query. Included from pvrsgx_fw.c so it reaches the loader's
+ * static functions.
+ *
+ * Registers are a memory buffer, and a stand-in for the microkernel answers
+ * the init kick, takes every command and confirms the power-off. Physical
+ * addresses, which differ between runs, are recorded as the directory they
+ * belong to (PD0, PD1, ...) or as page flags only.
+ *
+ * Each phase's record is checked against pvrsgx_equiv_golden.h: its line
+ * count and CRC32. A change meant to leave the SGX545 alone must leave every
+ * record as it is. On a mismatch the whole record is printed, one "EQ|" line
+ * per entry, to diff against the same test on a known-good tree.
+ */
+
+#include <kunit/test.h>
+
+#include <drm/drm_kunit_helpers.h>
+
+#include <linux/mman.h>
+#include <linux/uaccess.h>
+
+#include "../pvrsgx_job.h"
+#include "../pvrsgx_render.h"
+#include "../pvrsgx_transfer.h"
+#include "../pvrsgx_vm.h"
+
+#include "pvrsgx_equiv_golden.h"
+
+#define EQ_REGS_BYTES	0x10000
+#define EQ_LINE		64
+#define EQ_MAX_LINES	4096
+#define EQ_MAX_PDS	8
+
+struct eq_fx {
+	struct kunit *test;
+	struct pvrsgx_device *sdev;
+	u32 *regs;
+	/* Physical directory addresses, recorded as their index. */
+	u32 pd[EQ_MAX_PDS];
+	unsigned int npd;
+	/* The current phase's record. */
+	char (*line)[EQ_LINE];
+	unsigned int n;
+	bool overflow;
+	/* BIF faults left for the next recovery to find. */
+	unsigned int faults;
+};
+
+/* The fixture of the test that is running, for the write hook. */
+static struct eq_fx *eq_cur;
+
+static __printf(2, 3) void eq_add(struct eq_fx *fx, const char *fmt, ...)
+{
+	va_list ap;
+
+	if (fx->n == EQ_MAX_LINES) {
+		fx->overflow = true;
+		return;
+	}
+	va_start(ap, fmt);
+	vsnprintf(fx->line[fx->n++], EQ_LINE, fmt, ap);
+	va_end(ap);
+}
+
+static void eq_pd(struct eq_fx *fx, struct pvrsgx_mmu *mmu)
+{
+	if (fx->npd < EQ_MAX_PDS)
+		fx->pd[fx->npd++] = pvrsgx_mmu_pd_addr(mmu);
+}
+
+/* A value as recorded: a directory's index, or the value. */
+static const char *eq_val(struct eq_fx *fx, u32 v, char buf[16])
+{
+	for (unsigned int i = 0; i < fx->npd; i++) {
+		if (v == fx->pd[i]) {
+			snprintf(buf, 16, "PD%u", i);
+			return buf;
+		}
+	}
+	snprintf(buf, 16, "%08x", v);
+	return buf;
+}
+
+/* The microkernel's part, answered at once. */
+static void eq_wr(struct pvrsgx_device *sdev, u32 reg, u32 val)
+{
+	struct eq_fx *fx = eq_cur;
+	u32 *hc = sdev->fw.cpu[PVRSGX_FW_HOSTCTL];
+	char b[16];
+
+	eq_add(fx, "wr %04x %s", reg, eq_val(fx, val, b));
+
+	if (reg == sdev->cr->event_kick2 && val == sdev->cr->event_kick2_now)
+		hc[HOSTCTL_INIT_STATUS] |= HOSTCTL_INIT_COMPLETE;
+	if (reg == SGX_CR_EVENT_KICK && val == SGX_CR_EVENT_KICK_NOW) {
+		u32 *ctl = sdev->fw.cpu[PVRSGX_FW_CCBCTL];
+		u32 last = (ctl[0] - 1) & (PVRSGX_CCB_SLOTS - 1);
+		u32 *cmd = (u32 *)sdev->fw.cpu[PVRSGX_FW_CCB] + last * PVRSGX_CCB_CMD_WORDS;
+
+		if (cmd[0] == PVRSGX_KCMD_POWER)
+			hc[HOSTCTL_POWER_STATUS] |= HOSTCTL_POWMAN_POWEROFF_COMPLETE;
+		ctl[1] = ctl[0];
+	}
+	/* The recovery loop clears the events once per fault it handles. */
+	if (reg == SGX_CR_EVENT_HOST_CLEAR && fx->faults && !--fx->faults)
+		fx->regs[SGX_CR_BIF_INT_STAT / 4] = 0;
+}
+
+/* Nonzero words of n bytes at p; word pid_word (if not -1) as "PID". */
+static void eq_words(struct eq_fx *fx, const char *name, const void *p, u32 n, int pid_word)
+{
+	const u32 *w = p;
+	char b[16];
+
+	for (u32 i = 0; i < n / 4; i++) {
+		u32 v = READ_ONCE(w[i]);
+
+		if (!v)
+			continue;
+		if ((int)i == pid_word)
+			eq_add(fx, "%s +%04x PID", name, i * 4);
+		else
+			eq_add(fx, "%s +%04x %s", name, i * 4, eq_val(fx, v, b));
+	}
+}
+
+/* Every valid PDE's flags, and the PTE flags in runs of equal flags. */
+static void eq_mmu(struct eq_fx *fx, const char *name, struct pvrsgx_mmu *mmu)
+{
+	for (u32 d = 0; d < SGX_MMU_PD_ENTRIES; d++) {
+		u32 base = d * SGX_MMU_PDE_SPAN, pde, pte, run = 0, flags = 0, start = 0;
+
+		KUNIT_ASSERT_TRUE(fx->test, pvrsgx_mmu_lookup(mmu, base, &pde, &pte));
+		if (!(pde & SGX_MMU_PDE_VALID))
+			continue;
+		eq_add(fx, "%s pde %03x %x", name, d, (u32)(pde & ~SGX_MMU_ADDR_MASK));
+		for (u32 i = 0; i <= SGX_MMU_PT_ENTRIES; i++) {
+			u32 a = base + i * SGX_MMU_PAGE_SIZE, f = 0;
+
+			if (i < SGX_MMU_PT_ENTRIES) {
+				KUNIT_ASSERT_TRUE(fx->test, pvrsgx_mmu_lookup(mmu, a, &pde, &pte));
+				f = pte & ~SGX_MMU_ADDR_MASK;
+			}
+			if (run && (i == SGX_MMU_PT_ENTRIES || f != flags)) {
+				if (flags)
+					eq_add(fx, "%s pte %08x+%x %x", name, start, run, flags);
+				run = 0;
+			}
+			if (i < SGX_MMU_PT_ENTRIES && !run) {
+				start = a;
+				flags = f;
+			}
+			run++;
+		}
+	}
+}
+
+static void eq_arenas(struct eq_fx *fx)
+{
+	struct pvrsgx_fw *f = &fx->sdev->fw;
+
+	eq_add(fx, "data %08x %x", f->data.dev_addr, f->data.size);
+	eq_words(fx, "data", f->data.cpu, f->data.size, -1);
+	eq_add(fx, "code %08x %x", f->code.dev_addr, f->code.size);
+	eq_words(fx, "code", f->code.cpu, f->code.size, -1);
+	for (int b = 0; b < PVRSGX_FW_NBUF; b++)
+		eq_add(fx, "buf %d %08x", b, f->addr[b]);
+}
+
+/* Close a phase: compare its record with the golden one, print it if they differ. */
+static void eq_check(struct eq_fx *fx, const char *phase)
+{
+	const struct pvrsgx_equiv_golden *g = NULL;
+	u32 crc = ~0u;
+
+	KUNIT_EXPECT_FALSE_MSG(fx->test, fx->overflow, "%s: record overflow", phase);
+	for (unsigned int i = 0; i < fx->n; i++)
+		crc = crc32_le(crc, fx->line[i], strlen(fx->line[i]) + 1);
+	crc = ~crc;
+	for (unsigned int i = 0; i < ARRAY_SIZE(pvrsgx_equiv_golden_545); i++)
+		if (pvrsgx_equiv_golden_545[i].phase &&
+		    !strcmp(pvrsgx_equiv_golden_545[i].phase, phase))
+			g = &pvrsgx_equiv_golden_545[i];
+
+	if (!g || g->lines != fx->n || g->crc != crc) {
+		for (unsigned int i = 0; i < fx->n; i++)
+			kunit_info(fx->test, "EQ| %s %s\n", phase, fx->line[i]);
+		kunit_info(fx->test, "EQ= { \"%s\", %u, 0x%08x },\n", phase, fx->n, crc);
+		KUNIT_FAIL(fx->test, "%s: %u lines, crc 0x%08x; golden %u, 0x%08x", phase, fx->n,
+			   crc, g ? g->lines : 0, g ? g->crc : 0);
+	}
+	fx->n = 0;
+	fx->overflow = false;
+}
+
+/* A microkernel file: three entries and a patch of each kind. */
+#define EQ_IMAGE	0x100
+
+struct eq_file {
+	struct ukfw_header h;
+	struct ukfw_pair entries[3];
+	struct ukfw_pair patches[5];
+	u8 image[EQ_IMAGE];
+};
+
+static struct eq_file *eq_file(struct kunit *test)
+{
+	static const u32 patch[][2] = {
+		{ 0x10, UKFW_TA3DCTL }, { 0x20, UKFW_HOSTCTL }, { 0x30, UKFW_CCBCTL },
+		{ 0x48, UKFW_CCB }, { 0x58, UKFW_MISC },
+	};
+	struct eq_file *t = kunit_kzalloc(test, sizeof(*t), GFP_KERNEL);
+	u32 *w;
+
+	KUNIT_ASSERT_NOT_NULL(test, t);
+	w = (u32 *)t->image;
+	for (u32 i = 0; i < EQ_IMAGE / 4; i++)
+		w[i] = 0x01010101u * (i + 1);
+	for (u32 i = 0; i < ARRAY_SIZE(patch); i++) {
+		w[patch[i][0] / 4] = 0xf80dbeef;
+		w[patch[i][0] / 4 + 1] = 0xfc000000;
+		t->patches[i] = (struct ukfw_pair){ cpu_to_le32(patch[i][0]),
+						    cpu_to_le32(patch[i][1]) };
+	}
+	t->h.magic[0] = cpu_to_le32(UKFW_MAGIC0);
+	t->h.magic[1] = cpu_to_le32(UKFW_MAGIC1);
+	t->h.header_size = cpu_to_le32(offsetof(struct eq_file, image));
+	t->h.interface = cpu_to_le32(1 << 16);
+	t->h.features = cpu_to_le32(PVRSGX_UKFW_CLEANUP_V2 | PVRSGX_UKFW_SECURE |
+				    PVRSGX_UKFW_DONE_SEQ);
+	t->h.image_size = cpu_to_le32(EQ_IMAGE);
+	t->h.image_crc32 = cpu_to_le32(~crc32_le(~0, t->image, EQ_IMAGE));
+	t->h.n_entries = cpu_to_le32(ARRAY_SIZE(t->entries));
+	t->h.entries_off = cpu_to_le32(offsetof(struct eq_file, entries));
+	t->h.n_patches = cpu_to_le32(ARRAY_SIZE(t->patches));
+	t->h.patches_off = cpu_to_le32(offsetof(struct eq_file, patches));
+	t->entries[0] = (struct ukfw_pair){ cpu_to_le32(0), cpu_to_le32(0) };
+	t->entries[1] = (struct ukfw_pair){ cpu_to_le32(2), cpu_to_le32(0x40) };
+	t->entries[2] = (struct ukfw_pair){ cpu_to_le32(4), cpu_to_le32(0x80) };
+	return t;
+}
+
+static void eq_noop_work(struct work_struct *work)
+{
+}
+
+/* pvrsgx_device_init() up to the start, with the firmware from eq_file(). */
+static struct eq_fx *eq_device(struct kunit *test, unsigned int core, u32 core_rev)
+{
+	struct eq_fx *fx = kunit_kzalloc(test, sizeof(*fx), GFP_KERNEL);
+	struct pvrsgx_device *sdev;
+	struct firmware fw = {};
+	struct eq_file *file;
+	struct device *dev;
+
+	KUNIT_ASSERT_NOT_NULL(test, fx);
+	fx->test = test;
+	fx->line = kunit_kcalloc(test, EQ_MAX_LINES, EQ_LINE, GFP_KERNEL);
+	fx->regs = kunit_kzalloc(test, EQ_REGS_BYTES, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fx->line);
+	KUNIT_ASSERT_NOT_NULL(test, fx->regs);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	sdev = drm_kunit_helper_alloc_drm_device(test, dev, struct pvrsgx_device, base, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev);
+	fx->sdev = sdev;
+
+	mutex_init(&sdev->ccb_lock);
+	mutex_init(&sdev->done_lock);
+	spin_lock_init(&sdev->ccb_spin);
+	spin_lock_init(&sdev->inval_lock);
+	INIT_LIST_HEAD(&sdev->inval_waits);
+	INIT_WORK(&sdev->reap_work, eq_noop_work);
+	/* The restart path queues the reap; the real driver's own workqueue isn't set up here. */
+	sdev->wq = system_dfl_wq;
+	sdev->free_wq = system_dfl_wq;
+	sdev->irq = -1;
+	sdev->regs = (void __iomem __force *)fx->regs;
+
+	sdev->family = pvrsgx_core_family_get(core);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->family);
+	sdev->cr = sdev->family->regs;
+	sdev->core_id = sdev->family->core_id;
+	sdev->core_rev = core_rev;
+	sdev->core = pvrsgx_core_lookup(sdev->family, sdev->core_id, sdev->core_rev);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->core);
+
+	sdev->kernel_mmu = pvrsgx_mmu_create(sdev);
+	sdev->idle_mmu = pvrsgx_mmu_create(sdev);
+	sdev->reset_mmu = pvrsgx_mmu_create(sdev);
+	sdev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA32);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->kernel_mmu);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->idle_mmu);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->reset_mmu);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->reset_page);
+	eq_pd(fx, sdev->kernel_mmu);
+	eq_pd(fx, sdev->idle_mmu);
+	eq_pd(fx, sdev->reset_mmu);
+
+	pvrsgx_kobj_init(sdev);
+	mutex_init(&sdev->pb_lock);
+
+	file = eq_file(test);
+	fw.data = (const u8 *)file;
+	fw.size = sizeof(*file);
+	ida_init(&sdev->fw.pd_slots);
+	sdev->fw.name = "equiv";
+	KUNIT_ASSERT_EQ(test, ukfw_load(sdev, &fw), 0);
+	KUNIT_ASSERT_EQ(test, fw_arenas(sdev), 0);
+
+	eq_cur = fx;
+	sdev->test_wr = eq_wr;
+	return fx;
+}
+
+static void eq_fini(struct eq_fx *fx)
+{
+	struct pvrsgx_device *sdev = fx->sdev;
+
+	sdev->test_wr = NULL;
+	eq_cur = NULL;
+	cancel_work_sync(&sdev->reap_work);
+	pvrsgx_ccb_inval_reap(sdev, true);
+	pvrsgx_pb_put(sdev->pb);
+	sdev->pb = NULL;
+	pvrsgx_kobj_fini(sdev);
+	pvrsgx_fw_fini(sdev);
+	__free_page(sdev->reset_page);
+	pvrsgx_mmu_destroy(sdev->reset_mmu);
+	pvrsgx_mmu_destroy(sdev->idle_mmu);
+	pvrsgx_mmu_destroy(sdev->kernel_mmu);
+	mutex_destroy(&sdev->pb_lock);
+	mutex_destroy(&sdev->done_lock);
+	mutex_destroy(&sdev->ccb_lock);
+}
+
+/* DEV_QUERY_HEAP_INFO_GET, through user memory as a client sees it. */
+static void eq_heaps(struct eq_fx *fx)
+{
+	struct drm_powervr_sgx_dev_query_heap_info info = {};
+	struct drm_powervr_sgx_heap heaps[16] = {};
+	unsigned long user;
+	u32 size = sizeof(info);
+
+	user = kunit_vm_mmap(fx->test, NULL, 0, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	KUNIT_ASSERT_NE_MSG(fx->test, user, 0, "no user memory");
+	info.heaps.stride = sizeof(heaps[0]);
+	info.heaps.count = ARRAY_SIZE(heaps);
+	info.heaps.array = user + 64;
+	KUNIT_ASSERT_EQ(fx->test, copy_to_user((void __user *)user, &info, sizeof(info)), 0);
+	KUNIT_ASSERT_EQ(fx->test, pvrsgx_query_heap_info(fx->sdev, (void __user *)user, &size), 0);
+	KUNIT_ASSERT_EQ(fx->test, copy_from_user(&info, (void __user *)user, sizeof(info)), 0);
+	KUNIT_ASSERT_EQ(fx->test, copy_from_user(heaps, (void __user *)(user + 64),
+						 sizeof(heaps)), 0);
+	eq_add(fx, "heaps size %u stride %u count %u", size, info.heaps.stride, info.heaps.count);
+	for (u32 i = 0; i < min_t(u32, info.heaps.count, ARRAY_SIZE(heaps)); i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "heap%u", i);
+		eq_words(fx, name, &heaps[i], sizeof(heaps[i]), -1);
+	}
+}
+
+/*
+ * A 720x480 dataset, then two frames of a two-kick render: everything the
+ * kernel writes for the microkernel at the dataset's creation and at each
+ * kick (the PB, the dataset's structures, the TA commands, the render
+ * details, the background object and the syncs).
+ */
+static void eq_render(struct eq_fx *fx, struct pvrsgx_context *ctx)
+{
+	struct pvrsgx_device *sdev = fx->sdev;
+	struct pvrsgx_render_ctx *r = ctx->render;
+	u64 pds = pvrsgx_heaps(sdev)->pds_pixel.base;
+	struct pvrsgx_rt_dataset *s;
+	struct pvrsgx_job *job;
+	char name[24];
+
+	eq_words(fx, "pbdesc", kobj_cpu(r->pb->desc), sizeof(struct pvrsgx_fw_pb_desc), -1);
+	eq_words(fx, "pbblocks", kobj_cpu(r->pb->blocks), 12, -1);
+	eq_words(fx, "pbfl", kobj_cpu(r->pb->freelist), r->pb->freelist->km.size, -1);
+
+	s = pvrsgx_rtds_create(ctx, 720, 480, 1);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(fx->test, s);
+	eq_add(fx, "rtds rtword %08x rtdata %08x done %08x tailptr %08x", kobj_va(s->rtword),
+	       kobj_va(s->rtdata), kobj_va(s->done), kobj_va(s->tailptr));
+	eq_words(fx, "rtdata", kobj_cpu(s->rtdata), sizeof(struct pvrsgx_fw_rt_data), -1);
+	for (int i = 0; i < 2; i++) {
+		snprintf(name, sizeof(name), "rd%d", i);
+		eq_words(fx, name, kobj_cpu(s->rd[i]), sizeof(struct pvrsgx_fw_render_details), -1);
+		snprintf(name, sizeof(name), "bg%d", i);
+		eq_words(fx, name, kobj_cpu(s->bgblock[i]), 0x60, -1);
+		snprintf(name, sizeof(name), "hwsync%d", i);
+		eq_words(fx, name, kobj_cpu(s->hwsync[i]), sizeof(struct pvrsgx_fw_rt_deps), -1);
+	}
+
+	job = kunit_kzalloc(fx->test, sizeof(*job), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(fx->test, job);
+	job->ctx = ctx;
+	job->render.rtds = s;
+	job->render.nkicks = 2;
+	job->render.render.base.depth_addr = 0x20100000;
+	job->render.render.base.stencil_addr = 0x20180000;
+	job->render.render.base.pixel_event_pds_addr = pds + 0x300;
+	job->render.render.base.pixel_event_pds_rows = 3;
+	job->render.render.base.bg_pds_secondary_addr = pds + 0x200;
+	job->render.render.base.bg_pds_secondary_rows = 2;
+	job->render.render.base.bg_pds_primary_addr = pds + 0x100;
+	job->render.render.base.bg_pds_primary_rows = 4;
+	job->render.render.base.bg_depth_f32 = 0x3f800000;
+	job->render.render.base.depth_bias_factor_f32 = 0x3f000000;
+	job->render.render.sgx545_render.zls_control = 0x00171004;
+	job->render.kick[0].base.vdm_base = 0x20000000;
+	job->render.kick[1].base.vdm_base = 0x20001000;
+	job->render.kick[1].sgx545_ta_kick.ta_flags2 = 0x1;
+
+	for (u32 f = 0; f < 2; f++) {
+		for (u32 k = 0; k < 2; k++) {
+			u32 woff = r->ccb_woff, data[6];
+
+			KUNIT_ASSERT_EQ(fx->test, pvrsgx_render_job_build(job, k, data), 0);
+			snprintf(name, sizeof(name), "f%u k%u ta", f, k);
+			eq_words(fx, name, (u8 *)kobj_cpu(r->ccb) + woff,
+				 sizeof(struct pvrsgx_fw_ta_cmd), -1);
+			eq_add(fx, "f%u k%u data %08x %08x woff %x", f, k, data[0], data[1],
+			       r->ccb_woff);
+		}
+		eq_add(fx, "f%u entry %u cmd_off %x done_val %x", f, job->render.entry,
+		       job->render.cmd_off, job->done_val);
+		snprintf(name, sizeof(name), "f%u rd", f);
+		eq_words(fx, name, kobj_cpu(s->rd[job->render.entry]),
+			 sizeof(struct pvrsgx_fw_render_details), -1);
+		snprintf(name, sizeof(name), "f%u bg", f);
+		eq_words(fx, name, kobj_cpu(s->bgblock[job->render.entry]), 0x60, -1);
+		snprintf(name, sizeof(name), "f%u w4", f);
+		eq_words(fx, name, kobj_cpu(s->rd_w4[job->render.entry]), 4, -1);
+		snprintf(name, sizeof(name), "f%u deps", f);
+		eq_words(fx, name, kobj_cpu(s->hwsync[job->render.entry]),
+			 sizeof(struct pvrsgx_fw_rt_deps), -1);
+		eq_words(fx, "rtword", kobj_cpu(s->rtword), 4, -1);
+		eq_words(fx, "sync3d", kobj_cpu(r->sync3d), SYNC_DATA_BYTES, -1);
+		eq_words(fx, "done", kobj_cpu(s->done), SYNC_DATA_BYTES, -1);
+	}
+	pvrsgx_rtds_put(s);
+}
+
+static void equiv_test_sgx545(struct kunit *test)
+{
+	struct eq_fx *fx = eq_device(test, 545, 0x0001000e);
+	struct pvrsgx_device *sdev = fx->sdev;
+	struct pvrsgx_context rctx = {}, xctx = {};
+	u32 data[6] = { 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 };
+	struct pvrsgx_vm *vm;
+
+	/* The image built, the arenas mapped. */
+	eq_arenas(fx);
+	eq_mmu(fx, "kmmu", sdev->kernel_mmu);
+	eq_check(fx, "init");
+
+	/* The first start. */
+	KUNIT_ASSERT_EQ(test, pvrsgx_fw_start(sdev), 0);
+	eq_words(fx, "data", sdev->fw.data.cpu, sdev->fw.data.size, -1);
+	eq_check(fx, "start");
+
+	/* A command that asks for every invalidate. */
+	sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD |
+				  PVRSGX_CC_INVAL_DATA;
+	KUNIT_ASSERT_EQ(test, pvrsgx_ccb_send(sdev, PVRSGX_KCMD_PROCESS_QUEUES, data, NULL), 0);
+	eq_words(fx, "data", sdev->fw.data.cpu, 0x3200, -1);
+	eq_check(fx, "send");
+
+	/* A hang: the restart finds a BIF fault left over. */
+	fx->regs[SGX_CR_BIF_INT_STAT / 4] = sdev->cr->bif_int_stat_fault_req;
+	fx->regs[SGX_CR_BIF_FAULT / 4] = 0x3e001000;
+	fx->faults = 1;
+	sdev->fw_running = false;
+	KUNIT_ASSERT_EQ(test, pvrsgx_fw_start(sdev), 0);
+	eq_arenas(fx);
+	eq_mmu(fx, "rmmu", sdev->reset_mmu);
+	eq_check(fx, "recover");
+
+	/* Runtime suspend. */
+	pvrsgx_fw_stop(sdev);
+	eq_words(fx, "data", sdev->fw.data.cpu, 0x3200, -1);
+	eq_check(fx, "stop");
+
+	/* Runtime resume, from gated clocks. */
+	KUNIT_ASSERT_EQ(test, pvrsgx_fw_start(sdev), 0);
+	eq_words(fx, "data", sdev->fw.data.cpu, sdev->fw.data.size, -1);
+	eq_check(fx, "resume");
+
+	/* A VM with a render and a transfer context. */
+	vm = pvrsgx_vm_create(sdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vm);
+	eq_pd(fx, vm->mmu);
+	kref_init(&rctx.ref);
+	rctx.sdev = sdev;
+	rctx.vm = vm;
+	xctx.sdev = sdev;
+	xctx.vm = vm;
+	KUNIT_ASSERT_EQ(test, pvrsgx_render_ctx_init(sdev, &rctx, 0x40), 0);
+	KUNIT_ASSERT_EQ(test, pvrsgx_transfer_ctx_init(sdev, &xctx), 0);
+	eq_add(fx, "rctx hw %08x ccb %08x ccbctl %08x", kobj_va(rctx.render->hwctx),
+	       kobj_va(rctx.render->ccb), kobj_va(rctx.render->ccbctl));
+	eq_add(fx, "rctx scratch %08x sync %08x", kobj_va(rctx.render->scratch),
+	       kobj_va(rctx.render->sync3d));
+	eq_words(fx, "rhw", kobj_cpu(rctx.render->hwctx), sizeof(struct pvrsgx_fw_hw_render_ctx),
+		 offsetof(struct pvrsgx_fw_hw_render_ctx, pid) / 4);
+	eq_add(fx, "pb pages %x base %08x buf %08x fl %08x", rctx.render->pb->pages,
+	       rctx.render->pb->base, kobj_va(rctx.render->pb->buf),
+	       kobj_va(rctx.render->pb->freelist));
+	eq_add(fx, "pb desc %08x blocks %08x", kobj_va(rctx.render->pb->desc),
+	       kobj_va(rctx.render->pb->blocks));
+	eq_add(fx, "xctx hw %08x", kobj_va(xctx.transfer->hwctx));
+	eq_words(fx, "xhw", kobj_cpu(xctx.transfer->hwctx),
+		 sizeof(struct pvrsgx_fw_hw_transfer_ctx),
+		 offsetof(struct pvrsgx_fw_hw_transfer_ctx, pid) / 4);
+	eq_mmu(fx, "vmmu", vm->mmu);
+	eq_mmu(fx, "kmmu", sdev->kernel_mmu);
+	eq_check(fx, "ctx");
+
+	eq_render(fx, &rctx);
+	eq_check(fx, "render");
+
+	eq_heaps(fx);
+	eq_check(fx, "heaps");
+
+	pvrsgx_transfer_ctx_fini(sdev, &xctx);
+	pvrsgx_render_ctx_fini(sdev, &rctx);
+	pvrsgx_vm_put(vm);
+	eq_check(fx, "teardown");
+	eq_fini(fx);
+}
+
+static struct kunit_case pvrsgx_equiv_test_cases[] = {
+	KUNIT_CASE(equiv_test_sgx545),
+	{}
+};
+
+static struct kunit_suite pvrsgx_equiv_test_suite = {
+	.name = "powervr_sgx_equiv",
+	.test_cases = pvrsgx_equiv_test_cases,
+};
+
+kunit_test_suite(pvrsgx_equiv_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_fw_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_fw_test.c
new file mode 100644
index 000000000..a278cdc41
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_fw_test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * KUnit tests of the microkernel file's checks,
+ * included from pvrsgx_fw.c so they reach its static functions.
+ */
+
+#include <kunit/test.h>
+
+#define T_IMAGE		256
+#define T_ENTRIES	2
+#define T_PATCHES	2
+#define T_SIZE		(UKFW_HEADER_MIN + 8 * (T_ENTRIES + T_PATCHES) + T_IMAGE)
+
+struct ukfw_test_file {
+	struct ukfw_header h;
+	struct ukfw_pair entries[T_ENTRIES];
+	struct ukfw_pair patches[T_PATCHES];
+	u8 image[T_IMAGE];
+};
+
+static_assert(sizeof(struct ukfw_header) == UKFW_HEADER_MIN);
+static_assert(sizeof(struct ukfw_test_file) == T_SIZE);
+
+/* A good file: event entry at 0, two patches, the image a counting pattern. */
+static struct ukfw_test_file *ukfw_good(struct kunit *test)
+{
+	struct ukfw_test_file *t = kunit_kzalloc(test, sizeof(*t), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, t);
+	for (u32 i = 0; i < T_IMAGE; i++)
+		t->image[i] = i;
+	t->h.magic[0] = cpu_to_le32(UKFW_MAGIC0);
+	t->h.magic[1] = cpu_to_le32(UKFW_MAGIC1);
+	t->h.header_size = cpu_to_le32(offsetof(struct ukfw_test_file, image));
+	t->h.interface = cpu_to_le32(1 << 16);
+	t->h.features = cpu_to_le32(PVRSGX_UKFW_CLEANUP_V2);
+	t->h.image_size = cpu_to_le32(T_IMAGE);
+	t->h.n_entries = cpu_to_le32(T_ENTRIES);
+	t->h.entries_off = cpu_to_le32(offsetof(struct ukfw_test_file, entries));
+	t->h.n_patches = cpu_to_le32(T_PATCHES);
+	t->h.patches_off = cpu_to_le32(offsetof(struct ukfw_test_file, patches));
+	t->entries[0] = (struct ukfw_pair){ cpu_to_le32(0), cpu_to_le32(0) };
+	t->entries[1] = (struct ukfw_pair){ cpu_to_le32(2), cpu_to_le32(0x40) };
+	t->patches[0] = (struct ukfw_pair){ cpu_to_le32(8), cpu_to_le32(UKFW_TA3DCTL) };
+	t->patches[1] = (struct ukfw_pair){ cpu_to_le32(0x48), cpu_to_le32(UKFW_HOSTCTL) };
+	return t;
+}
+
+static void ukfw_seal(struct ukfw_test_file *t)
+{
+	t->h.image_crc32 = cpu_to_le32(~crc32_le(~0, t->image, T_IMAGE));
+}
+
+static int ukfw_try(struct kunit *test, struct ukfw_test_file *t, size_t size)
+{
+	struct pvrsgx_fw f = {};
+	const char *why = "";
+	int err = ukfw_parse((const u8 *)t, size, &f, &why);
+
+	kunit_info(test, "%d %s\n", err, err == -EINVAL ? why : "");
+	if (!err) {
+		KUNIT_EXPECT_EQ(test, f.image_size, T_IMAGE);
+		KUNIT_EXPECT_EQ(test, f.features, PVRSGX_UKFW_CLEANUP_V2);
+		KUNIT_EXPECT_EQ(test, f.n_entries, T_ENTRIES);
+		KUNIT_EXPECT_EQ(test, f.entries[1][0], 2);
+		KUNIT_EXPECT_EQ(test, f.entries[1][1], 0x40);
+		KUNIT_EXPECT_EQ(test, f.patches[1][1], UKFW_HOSTCTL);
+		KUNIT_EXPECT_MEMEQ(test, f.image, t->image, T_IMAGE);
+	}
+	kfree(f.entries);
+	kfree(f.patches);
+	kfree(f.image);
+	return err;
+}
+
+static void ukfw_test_good(struct kunit *test)
+{
+	struct ukfw_test_file *t = ukfw_good(test);
+
+	ukfw_seal(t);
+	KUNIT_EXPECT_EQ(test, ukfw_try(test, t, T_SIZE), 0);
+}
+
+static void ukfw_test_not_ours(struct kunit *test)
+{
+	struct ukfw_test_file *t = ukfw_good(test);
+
+	ukfw_seal(t);
+	t->h.magic[1] = 0;
+	KUNIT_EXPECT_EQ(test, ukfw_try(test, t, T_SIZE), -ENOENT);
+	KUNIT_EXPECT_EQ(test, ukfw_try(test, t, UKFW_HEADER_MIN - 1), -ENOENT);
+}
+
+static void ukfw_test_crc(struct kunit *test)
+{
+	struct ukfw_test_file *t = ukfw_good(test);
+
+	ukfw_seal(t);
+	t->image[100] ^= 1;
+	KUNIT_EXPECT_EQ(test, ukfw_try(test, t, T_SIZE), -EINVAL);
+}
+
+static void ukfw_test_header(struct kunit *test)
+{
+	static const struct { u32 off, val; } bad[] = {
+		{ offsetof(struct ukfw_header, interface), 2 << 16 },	/* unknown major */
+		{ offsetof(struct ukfw_header, features), BIT(7) },	/* unknown feature */
+		{ offsetof(struct ukfw_header, header_size), 0x58 },	/* below the minimum */
+		{ offsetof(struct ukfw_header, header_size), 0x84 },	/* not 8-aligned */
+		{ offsetof(struct ukfw_header, image_size), 0 },
+		{ offsetof(struct ukfw_header, image_size), T_IMAGE + 8 },	/* past the end */
+		{ offsetof(struct ukfw_header, image_size), 0x1001 },	/* not 8-aligned */
+		{ offsetof(struct ukfw_header, n_entries), 0 },		/* no event entry */
+		{ offsetof(struct ukfw_header, n_entries), 65 },
+		{ offsetof(struct ukfw_header, entries_off), T_SIZE - 8 },	/* past the end */
+		{ offsetof(struct ukfw_header, patches_off), 2 },	/* misaligned table */
+	};
+
+	for (u32 i = 0; i < ARRAY_SIZE(bad); i++) {
+		struct ukfw_test_file *t = ukfw_good(test);
+
+		*(__le32 *)((u8 *)&t->h + bad[i].off) = cpu_to_le32(bad[i].val);
+		ukfw_seal(t);
+		KUNIT_EXPECT_EQ_MSG(test, ukfw_try(test, t, T_SIZE), -EINVAL, "case %u", i);
+	}
+}
+
+static void ukfw_test_tables(struct kunit *test)
+{
+	static const struct { bool entry; u32 idx, a, b; } bad[] = {
+		{ true, 0, 1, 0 },		/* no program 0 left */
+		{ true, 1, 5, 0x40 },		/* program out of range */
+		{ true, 1, 2, T_IMAGE },	/* entry past the image */
+		{ true, 1, 2, 0x44 },		/* entry not on an instruction */
+		{ false, 0, T_IMAGE - 4, UKFW_TA3DCTL },	/* patch past the image */
+		{ false, 0, 0xc, UKFW_TA3DCTL },	/* patch not on an instruction */
+		{ false, 1, 0x48, 0 },		/* value 0 */
+		{ false, 1, 0x48, UKFW_PDTABLE + 1 },	/* unknown value */
+	};
+
+	for (u32 i = 0; i < ARRAY_SIZE(bad); i++) {
+		struct ukfw_test_file *t = ukfw_good(test);
+		struct ukfw_pair *p = bad[i].entry ? &t->entries[bad[i].idx] :
+						     &t->patches[bad[i].idx];
+
+		*p = (struct ukfw_pair){ cpu_to_le32(bad[i].a), cpu_to_le32(bad[i].b) };
+		ukfw_seal(t);
+		KUNIT_EXPECT_EQ_MSG(test, ukfw_try(test, t, T_SIZE), -EINVAL, "case %u", i);
+	}
+}
+
+static struct kunit_case pvrsgx_fw_test_cases[] = {
+	KUNIT_CASE(ukfw_test_good),
+	KUNIT_CASE(ukfw_test_not_ours),
+	KUNIT_CASE(ukfw_test_crc),
+	KUNIT_CASE(ukfw_test_header),
+	KUNIT_CASE(ukfw_test_tables),
+	{}
+};
+
+static struct kunit_suite pvrsgx_fw_test_suite = {
+	.name = "powervr_sgx_fw",
+	.test_cases = pvrsgx_fw_test_cases,
+};
+
+kunit_test_suite(pvrsgx_fw_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_kobj_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_kobj_test.c
new file mode 100644
index 000000000..59de4da9f
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_kobj_test.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * KUnit tests of kernel-object teardown at unbind, included from
+ * pvrsgx_render.c so they reach the device PB's static functions. No GPU:
+ * the objects, page tables and VMs are memory only.
+ */
+
+#include <kunit/test.h>
+
+#include <drm/drm_kunit_helpers.h>
+
+/* The parts of pvrsgx_device_init() that kernel objects, VMs and PBs need. */
+static struct pvrsgx_device *kobj_test_device(struct kunit *test)
+{
+	struct pvrsgx_device *sdev;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	sdev = drm_kunit_helper_alloc_drm_device(test, dev, struct pvrsgx_device, base, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev);
+	/* The kernel object ranges come from the core's layout. */
+	sdev->family = pvrsgx_core_family_get(545);
+	KUNIT_ASSERT_NOT_NULL(test, sdev->family);
+	sdev->cr = sdev->family->regs;
+	sdev->kernel_mmu = pvrsgx_mmu_create(sdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sdev->kernel_mmu);
+	mutex_init(&sdev->ccb_lock);
+	spin_lock_init(&sdev->ccb_spin);
+	spin_lock_init(&sdev->inval_lock);
+	INIT_LIST_HEAD(&sdev->inval_waits);
+	mutex_init(&sdev->pb_lock);
+	pvrsgx_kobj_init(sdev);
+	return sdev;
+}
+
+/* What the device release does with them; every range must come back empty. */
+static void kobj_test_fini(struct kunit *test, struct pvrsgx_device *sdev)
+{
+	pvrsgx_pb_put(sdev->pb);
+	sdev->pb = NULL;
+	pvrsgx_kobj_fini(sdev);
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->graveyard));
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->kobj_unmapped));
+	for (int r = 0; r < PVRSGX_KRANGE_COUNT; r++)
+		KUNIT_EXPECT_TRUE_MSG(test, drm_mm_clean(&sdev->krange[r]), "range %d", r);
+	pvrsgx_mmu_destroy(sdev->kernel_mmu);
+	mutex_destroy(&sdev->pb_lock);
+	mutex_destroy(&sdev->ccb_lock);
+}
+
+/*
+ * A client's last render context goes, and no render runs after it: its
+ * per-VM scratch object waits in the graveyard and keeps the VM, so the VM
+ * and its PB reference are freed only at unbind, by the reap. The PB's
+ * objects join the graveyard then, and unbind must free them too.
+ */
+static void kobj_test_vm_held_by_graveyard(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = kobj_test_device(test);
+	struct pvrsgx_kobj *scratch = NULL;
+	struct pvrsgx_vm *vm;
+	struct pvrsgx_pb *pb;
+
+	vm = pvrsgx_vm_create(sdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vm);
+	pb = dev_pb_get(sdev, 0x40);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pb);
+	KUNIT_ASSERT_EQ(test, pvrsgx_pb_map(vm, pb), 0);
+	KUNIT_ASSERT_EQ(test, pvrsgx_kobj_new(sdev, &scratch, PVRSGX_KRANGE_3DPARAMS, 0x40,
+					      pb->base, vm), 0);
+
+	/* pvrsgx_render_ctx_fini(), then the file's VM handle. */
+	pvrsgx_kobj_drop(sdev, &scratch);
+	pvrsgx_pb_put(pb);
+	pvrsgx_vm_put(vm);
+	KUNIT_EXPECT_FALSE(test, list_empty(&sdev->graveyard));
+
+	kobj_test_fini(test, sdev);
+}
+
+/* The VM goes first and nothing waits: the PB is the device's alone at unbind. */
+static void kobj_test_vm_gone_first(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = kobj_test_device(test);
+	struct pvrsgx_vm *vm;
+	struct pvrsgx_pb *pb;
+
+	vm = pvrsgx_vm_create(sdev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vm);
+	pb = dev_pb_get(sdev, 0x40);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pb);
+	KUNIT_ASSERT_EQ(test, pvrsgx_pb_map(vm, pb), 0);
+	pvrsgx_pb_put(pb);
+	pvrsgx_vm_put(vm);
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->graveyard));
+
+	kobj_test_fini(test, sdev);
+}
+
+/*
+ * A reaped object is unmapped at once, but its pages and address wait until
+ * the microkernel has taken a command after it: that command's cache control
+ * invalidates the BIF TLB, which may still translate the old pages.
+ */
+static void kobj_test_free_after_invalidate(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = kobj_test_device(test);
+	u32 *ccbctl = kunit_kzalloc(test, 2 * sizeof(u32), GFP_KERNEL);
+	struct pvrsgx_kobj *o = NULL;
+	u32 addr;
+
+	KUNIT_ASSERT_NOT_NULL(test, ccbctl);
+	/* An empty ring: everything issued is consumed. */
+	sdev->fw.cpu[PVRSGX_FW_CCBCTL] = ccbctl;
+	KUNIT_ASSERT_EQ(test, pvrsgx_kobj_new(sdev, &o, PVRSGX_KRANGE_KDATA, PAGE_SIZE, 0, NULL),
+			0);
+	addr = kobj_va(o);
+	sdev->fw.cache_control = 0;
+
+	/* Released before render 1, which has finished. */
+	pvrsgx_kobj_drop(sdev, &o);
+	pvrsgx_kobj_reap(sdev, 1);
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->graveyard));
+	KUNIT_EXPECT_FALSE(test, list_empty(&sdev->kobj_unmapped));
+	KUNIT_EXPECT_TRUE(test, pvrsgx_mmu_range_empty(sdev->kernel_mmu, addr, PAGE_SIZE));
+	KUNIT_EXPECT_EQ(test, sdev->fw.cache_control & PVRSGX_CC_INVAL_BIF_PT,
+			PVRSGX_CC_INVAL_BIF_PT);
+	KUNIT_EXPECT_FALSE(test, drm_mm_clean(&sdev->krange[PVRSGX_KRANGE_KDATA]));
+
+	/* No command since: still held. */
+	pvrsgx_kobj_reap(sdev, 1);
+	KUNIT_EXPECT_FALSE(test, list_empty(&sdev->kobj_unmapped));
+
+	/* The next command was sent and taken. */
+	sdev->ccb_issued++;
+	pvrsgx_kobj_reap(sdev, 1);
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->kobj_unmapped));
+	KUNIT_EXPECT_TRUE(test, drm_mm_clean(&sdev->krange[PVRSGX_KRANGE_KDATA]));
+
+	sdev->fw.cpu[PVRSGX_FW_CCBCTL] = NULL;
+	kobj_test_fini(test, sdev);
+}
+
+struct kobj_test_wait {
+	struct pvrsgx_inval_wait w;
+	bool done;
+};
+
+static void kobj_test_wait_done(struct pvrsgx_inval_wait *w)
+{
+	container_of(w, struct kobj_test_wait, w)->done = true;
+}
+
+/* What an unmap freed waits for the command that carries the invalidate. */
+static void kobj_test_after_invalidate(struct kunit *test)
+{
+	struct pvrsgx_device *sdev = kobj_test_device(test);
+	u32 *ccbctl = kunit_kzalloc(test, 2 * sizeof(u32), GFP_KERNEL);
+	struct kobj_test_wait t = { .w.done = kobj_test_wait_done };
+
+	KUNIT_ASSERT_NOT_NULL(test, ccbctl);
+	sdev->fw.cpu[PVRSGX_FW_CCBCTL] = ccbctl;
+	sdev->fw.cache_control = 0;
+
+	pvrsgx_ccb_after_invalidate(sdev, &t.w, PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD);
+	KUNIT_EXPECT_EQ(test, sdev->fw.cache_control,
+			PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_BIF_PD);
+	pvrsgx_ccb_inval_reap(sdev, false);
+	KUNIT_EXPECT_FALSE(test, t.done);
+
+	/* The next command was sent and taken. */
+	sdev->ccb_issued++;
+	pvrsgx_ccb_inval_reap(sdev, false);
+	KUNIT_EXPECT_TRUE(test, t.done);
+	KUNIT_EXPECT_TRUE(test, list_empty(&sdev->inval_waits));
+
+	/* Once the GPU is lost, nothing waits. */
+	t.done = false;
+	WRITE_ONCE(sdev->lost, true);
+	pvrsgx_ccb_after_invalidate(sdev, &t.w, PVRSGX_CC_INVAL_BIF_PT);
+	KUNIT_EXPECT_TRUE(test, t.done);
+
+	sdev->fw.cpu[PVRSGX_FW_CCBCTL] = NULL;
+	kobj_test_fini(test, sdev);
+}
+
+static struct kunit_case pvrsgx_kobj_test_cases[] = {
+	KUNIT_CASE(kobj_test_vm_held_by_graveyard),
+	KUNIT_CASE(kobj_test_vm_gone_first),
+	KUNIT_CASE(kobj_test_free_after_invalidate),
+	KUNIT_CASE(kobj_test_after_invalidate),
+	{}
+};
+
+static struct kunit_suite pvrsgx_kobj_test_suite = {
+	.name = "powervr_sgx_kobj",
+	.test_cases = pvrsgx_kobj_test_cases,
+};
+
+kunit_test_suite(pvrsgx_kobj_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_prime_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_prime_test.c
new file mode 100644
index 000000000..9eb7faab4
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_prime_test.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/* KUnit tests of a job's cache ranges and their checks, included from pvrsgx_prime.c. */
+
+#include <kunit/test.h>
+
+#include <linux/err.h>
+#include <linux/mman.h>
+#include <linux/uaccess.h>
+
+#define R(f, o, sz, st, n) ((struct drm_powervr_sgx_cache_range){ .handle = 1, .flags = (f), \
+	.offset = (o), .size = (sz), .stride = (st), .rows = (n) })
+#define RD DRM_POWERVR_SGX_CACHE_RANGE_FLAG_READ
+#define WR DRM_POWERVR_SGX_CACHE_RANGE_FLAG_WRITE
+
+static void prime_test_range_accepts(struct kunit *test)
+{
+	const u64 obj = 2944 * 480;
+	struct drm_powervr_sgx_cache_range r;
+
+	/* a linear range, the whole object, rows 0 and 1 alike */
+	r = R(RD, 0, obj, 0, 0);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+	r = R(WR, 0, obj, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+	/* a 64x16 damage rect at (100, 200) of a 720x480 XRGB buffer, pitch 2944 */
+	r = R(RD | WR, 200 * 2944 + 100 * 4, 64 * 4, 2944, 16);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+	/* the last row ends at the object's end exactly */
+	r = R(WR, 0, 720 * 4, 2944, 480);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+	r = R(WR, 2944 - 720 * 4, 720 * 4, 2944, 480);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+	/* rows exactly stride apart are one span */
+	r = R(WR, 0, 2944, 2944, 480);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), 0);
+}
+
+static void prime_test_range_refuses(struct kunit *test)
+{
+	const u64 obj = 2944 * 480;
+	struct drm_powervr_sgx_cache_range r;
+
+	/* flags: none, or an unknown bit */
+	r = R(0, 0, 64, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	r = R(RD | BIT(2), 0, 64, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	/* an empty row */
+	r = R(RD, 0, 0, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	/* rows overlapping: stride below size */
+	r = R(RD, 0, 64, 32, 2);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	/* one byte past the end, linear and in the last row */
+	r = R(RD, 1, obj, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	r = R(WR, 2944 - 720 * 4 + 1, 720 * 4, 2944, 480);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	/* one row too many */
+	r = R(WR, 0, 720 * 4, 2944, 481);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	/* overflow in offset + size, and in rows * stride */
+	r = R(RD, U64_MAX - 7, 16, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	r = R(RD, 0, U64_MAX, 0, 1);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, obj), -EINVAL);
+	r = R(RD, U64_MAX - (u64)U32_MAX * 2, U32_MAX, U32_MAX, U32_MAX);
+	KUNIT_EXPECT_EQ(test, cache_range_check(&r, U64_MAX), -EINVAL);
+}
+
+/* The array checks come before any copy from userspace or handle lookup. */
+static void prime_test_range_array(struct kunit *test)
+{
+	struct drm_powervr_sgx_obj_array arr = {
+		.stride = sizeof(struct drm_powervr_sgx_cache_range),
+	};
+	struct pvrsgx_job job = {};
+
+	KUNIT_EXPECT_EQ(test, pvrsgx_prime_ranges(NULL, &arr, &job), 0);
+	KUNIT_EXPECT_EQ(test, job.nranges, 0);
+	arr.count = PVRSGX_MAX_CACHE_RANGES + 1;
+	KUNIT_EXPECT_EQ(test, pvrsgx_prime_ranges(NULL, &arr, &job), -EINVAL);
+	arr.count = 1;
+	arr.stride = 0;
+	KUNIT_EXPECT_EQ(test, pvrsgx_prime_ranges(NULL, &arr, &job), -EINVAL);
+	KUNIT_EXPECT_NULL(test, job.ranges);
+}
+
+/* An element longer than the kernel's with a non-zero tail: -E2BIG, before any lookup. */
+static void prime_test_range_tail(struct kunit *test)
+{
+	struct {
+		struct drm_powervr_sgx_cache_range r;
+		u64 tail;
+	} big = { .r = R(RD, 0, 64, 0, 1), .tail = 1 };
+	struct drm_powervr_sgx_obj_array arr = { .stride = sizeof(big), .count = 1 };
+	struct pvrsgx_job job = {};
+	unsigned long user;
+
+	user = kunit_vm_mmap(test, NULL, 0, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE, 0);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_VALUE(user));
+	KUNIT_ASSERT_NE(test, user, 0);
+	KUNIT_ASSERT_EQ(test, copy_to_user((void __user *)user, &big, sizeof(big)), 0);
+	arr.array = user;
+	KUNIT_EXPECT_EQ(test, pvrsgx_prime_ranges(NULL, &arr, &job), -E2BIG);
+	KUNIT_EXPECT_EQ(test, job.nranges, 0);
+}
+
+static struct kunit_case pvrsgx_prime_test_cases[] = {
+	KUNIT_CASE(prime_test_range_array),
+	KUNIT_CASE(prime_test_range_tail),
+	KUNIT_CASE(prime_test_range_accepts),
+	KUNIT_CASE(prime_test_range_refuses),
+	{}
+};
+
+static struct kunit_suite pvrsgx_prime_test_suite = {
+	.name = "powervr_sgx_prime",
+	.test_cases = pvrsgx_prime_test_cases,
+};
+
+kunit_test_suite(pvrsgx_prime_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_rt_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_rt_test.c
new file mode 100644
index 000000000..ea4e8a124
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_rt_test.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * KUnit tests of a render target's tiling numbers, included from
+ * pvrsgx_render.c: 720x480 at 1 and 4 samples, against the numbers that
+ * render that window correctly.
+ */
+
+#include <kunit/test.h>
+
+static void rt_test_720x480_1x(struct kunit *test)
+{
+	struct pvrsgx_rt_numbers n;
+
+	rt_numbers(&n, 720, 480, 1);
+	KUNIT_EXPECT_EQ(test, n.te_aa, 0x20000000);
+	KUNIT_EXPECT_EQ(test, n.mtile1, 0x82010018);
+	KUNIT_EXPECT_EQ(test, n.mtile2, 0x02010018);
+	KUNIT_EXPECT_EQ(test, n.te_screen, 0x0001d016);
+	KUNIT_EXPECT_EQ(test, n.mt_tiles, 0x40);
+	KUNIT_EXPECT_EQ(test, n.rt_flags, 0x88);
+	KUNIT_EXPECT_EQ(test, n.padx, 0x20);
+	KUNIT_EXPECT_EQ(test, n.rt_mt_tiles >> 4, 4);
+	KUNIT_EXPECT_EQ(test, n.rt_mt_tiles * 0xc, 0x300);
+	KUNIT_EXPECT_EQ(test, n.region_bytes, 0x3000);
+	KUNIT_EXPECT_EQ(test, n.tailptr_bytes, 0x1000);
+	/* ZLS control 0x001710b4 with the client's bits 0x00171004 */
+	KUNIT_EXPECT_EQ(test, (n.zls_xt - 1) << 3, 0xb0);
+}
+
+static void rt_test_720x480_4x(struct kunit *test)
+{
+	struct pvrsgx_rt_numbers n;
+
+	rt_numbers(&n, 720, 480, 4);
+	KUNIT_EXPECT_EQ(test, n.te_aa, 0xe0000000);
+	KUNIT_EXPECT_EQ(test, n.mtile1, 0x8180c012);
+	KUNIT_EXPECT_EQ(test, n.mtile2, 0x02010018);
+	KUNIT_EXPECT_EQ(test, n.te_screen, 0x0001d016);
+	KUNIT_EXPECT_EQ(test, n.mt_tiles, 0x30);
+	KUNIT_EXPECT_EQ(test, n.rt_flags, 0xeaa26e26);
+	KUNIT_EXPECT_EQ(test, n.padx, 0x30);
+	KUNIT_EXPECT_EQ(test, n.rt_mt_tiles >> 4, 0xc);
+	KUNIT_EXPECT_EQ(test, n.rt_mt_tiles * 0xc, 0x900);
+	KUNIT_EXPECT_EQ(test, n.region_bytes, 0x9000);
+	KUNIT_EXPECT_EQ(test, n.tailptr_bytes, 0x4000);
+	/* ZLS control 0x0017116c */
+	KUNIT_EXPECT_EQ(test, (n.zls_xt - 1) << 3, 0x168);
+}
+
+static struct kunit_case pvrsgx_rt_test_cases[] = {
+	KUNIT_CASE(rt_test_720x480_1x),
+	KUNIT_CASE(rt_test_720x480_4x),
+	{}
+};
+
+static struct kunit_suite pvrsgx_rt_test_suite = {
+	.name = "powervr_sgx_rt",
+	.test_cases = pvrsgx_rt_test_cases,
+};
+
+kunit_test_suite(pvrsgx_rt_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_usse_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_usse_test.c
new file mode 100644
index 000000000..0ef4a9d52
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_usse_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/* KUnit tests of the USSE instruction check, included from pvrsgx_usse.c. */
+
+#include <kunit/test.h>
+
+#define W(hi, lo)	((u64)(hi) << 32 | (lo))
+
+/* Each word, alone at instruction 2 of a 512-instruction object placed at 0x100. */
+static const struct {
+	u64 w;
+	const char *what;
+	bool ok;
+} validate_words[] = {
+	{ W(0xfe210000, 0x2000001c), "ldr r0, #28", false },
+	{ W(0xfe290000, 0x20064080), "str #3200, r1", false },
+	{ W(0xf80000c0, 0x00000180), "setl r3", false },
+	{ W(0xf8000100, 0x00a00000), "savl r5", false },
+	{ W(0xf8000000, 0x00001077), "ba #4215", false },
+	{ W(0xf8000080, 0x00000000), "lapc", false },
+	{ W(0xf8000240, 0x00000003), "br #3 [link]", false },
+	{ W(0xf8000040, 0x0003fffe), "br #-2", true },
+	{ W(0xf8000040, 0x0003fffd), "br #-3", false },
+	{ W(0xf8000040, 0x000001fd), "br #509", true },
+	{ W(0xf8000040, 0x000001fe), "br #510", false },
+	{ W(0xfa440700, 0x00000000), "phas.i #0, #0 [wait=7]", true },
+	{ W(0xfa440000, 0x00000102), "phas.i #0x102 (in the object)", true },
+	{ W(0xfa440000, 0x000000ff), "phas.i #0xff (before it)", false },
+	{ W(0xfa440000, 0x00000300), "phas.i #0x300 (past it)", false },
+	{ W(0xfd200000, 0x00000010), "lock #1", false },
+	{ W(0xfb100010, 0x02003004), "smbo #1, #2, #3, #4", false },
+	{ W(0xdc2c23c5, 0xa0008001), "fdual.fssq.mov", false },
+	{ W(0xff200000, 0x00000001), "op0xd6 #1", false },
+	{ W(0xff200000, 0x00000000), "op0xd6 #0", true },
+	{ W(0x00080001, 0x08a04103), "fmad g5, r1, r2, r3", false },
+	{ W(0x28090001, 0x20600000), "mov c3, r0", false },
+	{ W(0x28030000, 0x60003900), "mov r0, g50", false },
+	{ W(0x28030000, 0x60002a00), "mov r0, g20", true },
+	{ W(0x28030000, 0xe0000200), "mov r0, i4", false },
+	{ W(0x28090003, 0x20800000), "mov i4, r0", false },
+	{ W(0x28a33001, 0x20003000), "mov with an indexed source", true },
+	{ W(0x00000000, 0xffffffff), "fmad with every operand bit set", true },
+	{ W(0x00000000, 0x00000000), "zero", true },
+	{ W(0xffffffff, 0xffffffff), "all ones", false },
+	/* Number bit 6: a flag only where the format makes it one. */
+	{ W(0x50021000, 0xc0000001), "and r0, i0, r1", true },
+	{ W(0x50021000, 0xc0002001), "and r0, i64, r1", false },
+	{ W(0x00420000, 0xc0006103), "fmad r0, r1, i2.f16, r3 [fmt]", true },
+	{ W(0x00020000, 0xc0006103), "fmad r0, r1, i66, r3", false },
+	{ W(0x9183f802, 0xf0002041), "sopwm pa0, i0.c10, i1.c10", true },
+	{ W(0xfd100000, 0x00000100), "setfc #0, #1", true },
+	{ W(0xfd100000, 0x00000101), "setfc #1, #1", false },
+};
+
+static void usse_test_words(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(validate_words); i++) {
+		const u64 *w = &validate_words[i].w;
+		bool abs = false;
+		s64 bad = pvrsgx_usse_scan(PVRSGX_ISA_SGX545, w, 1, 2, 512, 0x100, &abs, NULL);
+
+		KUNIT_EXPECT_EQ_MSG(test, bad, validate_words[i].ok ? -1 : 0, "%s",
+				    validate_words[i].what);
+	}
+}
+
+/* phas.i with a target needs a place, and says it had one. */
+static void usse_test_phas_place(struct kunit *test)
+{
+	u64 w = W(0xfa440000, 0x00000102);
+	enum pvrsgx_usse_refusal why;
+	bool abs = false;
+
+	KUNIT_EXPECT_EQ(test, pvrsgx_usse_scan(PVRSGX_ISA_SGX545, &w, 1, 0, 512,
+					       PVRSGX_USSE_PLACE_NONE, &abs, &why), 0);
+	KUNIT_EXPECT_EQ(test, why, PVRSGX_USSE_REFUSAL_PHAS);
+	KUNIT_EXPECT_EQ(test, pvrsgx_usse_scan(PVRSGX_ISA_SGX545, &w, 1, 0, 512, 0x100, &abs,
+					       &why), -1);
+	KUNIT_EXPECT_EQ(test, why, PVRSGX_USSE_REFUSAL_NONE);
+	KUNIT_EXPECT_TRUE(test, abs);
+
+	/* An object with a target must not cross into the next window. */
+	w = W(0xfa440000, PVRSGX_USSE_WINDOW_INSTS - 0x100 + 2);
+	KUNIT_EXPECT_EQ(test, pvrsgx_usse_scan(PVRSGX_ISA_SGX545, &w, 1, 0, 0x100,
+					       PVRSGX_USSE_WINDOW_INSTS - 0x100, &abs, &why), -1);
+	KUNIT_EXPECT_EQ(test, pvrsgx_usse_scan(PVRSGX_ISA_SGX545, &w, 1, 0, 0x101,
+					       PVRSGX_USSE_WINDOW_INSTS - 0x100, &abs, &why), 0);
+	KUNIT_EXPECT_EQ(test, why, PVRSGX_USSE_REFUSAL_PHAS);
+}
+
+/* Each refusal says why. */
+static void usse_test_reasons(struct kunit *test)
+{
+	static const struct {
+		u64 w;
+		enum pvrsgx_usse_refusal why;
+	} cases[] = {
+		{ W(0xffffffff, 0xffffffff), PVRSGX_USSE_REFUSAL_FORM },
+		{ W(0x28030000, 0x60003900), PVRSGX_USSE_REFUSAL_OPERAND },	/* mov r0, g50 */
+		{ W(0xfe210000, 0x2000001c), PVRSGX_USSE_REFUSAL_KIND },	/* ldr */
+		{ W(0xf8000040, 0x000001fe), PVRSGX_USSE_REFUSAL_BRANCH },	/* br #510 */
+		{ W(0xfa440000, 0x000000ff), PVRSGX_USSE_REFUSAL_PHAS },	/* phas.i #0xff */
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(cases); i++) {
+		enum pvrsgx_usse_refusal why;
+		bool abs = false;
+
+		KUNIT_EXPECT_EQ(test, pvrsgx_usse_scan(PVRSGX_ISA_SGX545, &cases[i].w, 1, 2, 512,
+						       0x100, &abs, &why), 0);
+		KUNIT_EXPECT_EQ(test, why, cases[i].why);
+	}
+}
+
+/* Every slot set holds slots the checker knows, with pieces that fit a word. */
+static void usse_test_table(struct kunit *test)
+{
+	for (int i = 0; i < ARRAY_SIZE(pvrsgx_usse_forms); i++)
+		KUNIT_EXPECT_LT(test, pvrsgx_usse_forms[i].slots, ARRAY_SIZE(pvrsgx_usse_slots));
+	for (int i = 0; i < ARRAY_SIZE(pvrsgx_usse_slots); i++) {
+		for (int k = 0; k < USSE_MAX_SLOTS; k++) {
+			const struct pvrsgx_usse_slot *s = &pvrsgx_usse_slots[i][k];
+
+			KUNIT_EXPECT_LE(test, s->kind, USSE_SLOT_SRC0);
+			for (int p = 0; p < USSE_MAX_PIECES; p++)
+				KUNIT_EXPECT_LE(test, s->p[p].lo + s->p[p].width, 64);
+		}
+	}
+}
+
+static struct kunit_case pvrsgx_usse_test_cases[] = {
+	KUNIT_CASE(usse_test_words),
+	KUNIT_CASE(usse_test_phas_place),
+	KUNIT_CASE(usse_test_reasons),
+	KUNIT_CASE(usse_test_table),
+	{}
+};
+
+static struct kunit_suite pvrsgx_usse_test_suite = {
+	.name = "powervr_sgx_usse",
+	.test_cases = pvrsgx_usse_test_cases,
+};
+
+kunit_test_suite(pvrsgx_usse_test_suite);
diff --git a/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_validate_test.c b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_validate_test.c
new file mode 100644
index 000000000..0fc2f197d
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/tests/pvrsgx_validate_test.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/* KUnit tests of code placement, included from pvrsgx_validate.c. */
+
+#include <kunit/test.h>
+
+/* Where a mapping puts a code object, in instructions from its heap's base. */
+static void validate_test_code_place(struct kunit *test)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_core_family_get(545)->heaps;
+
+	KUNIT_EXPECT_EQ(test, code_place(h, PVRSGX_HEAP_USSE_PIXEL + 0x800, 0), 0x100);
+	KUNIT_EXPECT_EQ(test, code_place(h, PVRSGX_HEAP_USSE_VERTEX + 0x1000, 0x800), 0x100);
+	/* From the window, not the heap: window 1 starts at +512 KiB. */
+	KUNIT_EXPECT_EQ(test, code_place(h, PVRSGX_HEAP_USSE_PIXEL + 0x80800, 0), 0x100);
+	KUNIT_EXPECT_EQ(test, code_place(h, PVRSGX_HEAP_USSE_PIXEL + 0x80800, 0x1000), 0xff00);
+	KUNIT_EXPECT_EQ(test, code_place(h, PVRSGX_HEAP_USSE_PIXEL + 0x400, 0x800),
+			PVRSGX_USSE_PLACE_NONE);
+}
+
+static struct kunit_case pvrsgx_validate_test_cases[] = {
+	KUNIT_CASE(validate_test_code_place),
+	{}
+};
+
+static struct kunit_suite pvrsgx_validate_test_suite = {
+	.name = "powervr_sgx_validate",
+	.test_cases = pvrsgx_validate_test_cases,
+};
+
+kunit_test_suite(pvrsgx_validate_test_suite);

-- 
2.50.1

