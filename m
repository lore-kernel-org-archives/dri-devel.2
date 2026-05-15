Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB926CD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E762510E2F6;
	Mon, 18 May 2026 07:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJu+Vk+i";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DC910E238
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 18:08:28 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bd4f81505ccso6374366b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778868507; x=1779473307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=la+O/bFtpnyaY0c5pxjy6SLIjk1Ilk22rZ0fIeKn2mA=;
 b=NJu+Vk+izmqoTks2Mx9CgRawXMfNH1olI5W1gvcGXDcugT/McYxF+08vnlmzltTM9A
 iCIlyVkjIoIKxweK2Eo9bjWRJ91usLFdJT+KYQKcUIi136dGFPGrGlD/ORq0IJgEjvvo
 bTC9U776KyW5Lf2xeR2kYbYHC3vxg2J17Mcoj/moI2DqMOkyDmk7z7EnO1CNwCusMbKg
 CCL9hkgZpx22dPJkDesBvPCGc5FvaO2bUZromFfUAd/AEWXEq/BB22WdTMcP17XbkKH7
 IK9j/rKJvIG2sa5PY7323ZIXhJu/Np5Byd/vqayxmWaP7IWIQiL9HDk92e/almGQXH4u
 n2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868507; x=1779473307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=la+O/bFtpnyaY0c5pxjy6SLIjk1Ilk22rZ0fIeKn2mA=;
 b=OQ2abn5uIZm5erUW/cNfj1AAz3ZtsM0fi/x0kja9t1vlEYA7EsRzB/U0NWb1ZihoIN
 JqeIWnZjmFjO/CcacfLDo12fsNh9BfaVxJldwXx8bHM7KhopIa4emBx//nXyzMFzpDNk
 YrIvBzW7hoPoCJWaM91MQH3CdJj6QiaMTTf/s9lGOdLH4mBl8LlyyEoGvmNEeuEDX24B
 lVRFpY3EEwj/cmKgzGwmvhvMqI5XWs7n0540RtS9jolVzCT0xoWIYWZ272qvv/B0L/QB
 jA0M3c2lA0oqIvKz1lFRcZu0NyqHvZnWrQXaaydDttCwiN8IV5RadrgdrdF/bEHSQWxt
 g93A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cpIPymcsML0M7BCYdqc/zehL5hEA/vFb3IovDXucmTFvAP0c1K1LYGUoQF+8e656AEgQyuQnHw1Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNDU64z28fmuwdzDUjcQE8lWMUi05lRaYKW1dubcI8lS90qG7g
 YQAqDZmQ3Mv6+XxMKGQxWIBk4CgKkd7MOU3rcnfWfmjUYoV6mjkrKzw9
X-Gm-Gg: Acq92OFge1spweVpTThtd1kQzZZHIvf61+K/IEv7i1KeayENOzdsLngojRqRT4wve3M
 bamS8Qx3oqr0MubBYuX4DvMKGPhdGP8T2Id+nxWLV3NoY2q+tpfy8qfART58alPtKD0xhDcEJaN
 LWQ2Oun3M8rYgRhGQ/L/tXjWT9Zk3p2MfR9j+0Wd5KAy/34yfUUB5ZmeJlEaQci6jTS4QW6kc1l
 EWOOw9D2u+FEaPxjhmaF5p+C9SP69weD81zfxQexF3R8oMpHg23+m0DDxrllknVxPh/MzoPSA3f
 pm9yg5TuMKuHqUD4lIzL991C0GUtrB/6I0Y9ICNqUljLSfVVDdct3f0XjTNqCuaq7TT2HSG7gYp
 97Xg3SxmSgMagKpuSbbvpwoF8PKEvglg2eOP76Daw1q5NF9n97QmJj4EGBLHOo+nZk3mQ+euboT
 knnBfICVdoppCMcx8DEHva1mnvfY5a/oXv
X-Received: by 2002:a17:906:6185:b0:bd0:6dbe:22b1 with SMTP id
 a640c23a62f3a-bd5177ec5dfmr278321866b.12.1778868506983; 
 Fri, 15 May 2026 11:08:26 -0700 (PDT)
Received: from pc-oliwiera ([2a02:2a40:4bf0:bd00:6130:de6:bb7:addf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4bd1bc9sm263471566b.9.2026.05.15.11.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:08:26 -0700 (PDT)
From: Oli R <sigmatwojastara@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>,
 linux-arm-msm@vger.kernel.org (open list:DRM DRIVER for Qualcomm display
 hardware), 
 dri-devel@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display
 hardware), 
 freedreno@lists.freedesktop.org (open list:DRM DRIVER for Qualcomm display
 hardware), linux-kernel@vger.kernel.org (open list),
 linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP)
 DRIVER - DB...), 
 linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Cc: Oli R <sigmatwojastara@gmail.com>
Subject: [PATCH] treewide: replace /usr/bin/python3 shebangs with env python3
Date: Fri, 15 May 2026 20:07:59 +0200
Message-ID: <20260515180806.246914-1-sigmatwojastara@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

Use /usr/bin/env python3 instead of hardcoded interpreter paths
to improve portability across environments where python3 is not
installed in /usr/bin.

No functional changes intended.

Signed-off-by: Oli R <sigmatwojastara@gmail.com>
---
 drivers/gpu/drm/msm/registers/gen_header.py                     | 2 +-
 scripts/macro_checker.py                                        | 2 +-
 tools/crypto/ccp/dbc.py                                         | 2 +-
 tools/crypto/ccp/dbc_cli.py                                     | 2 +-
 tools/crypto/ccp/test_dbc.py                                    | 2 +-
 tools/perf/tests/shell/lib/perf_json_output_lint.py             | 2 +-
 .../selftests/devices/probe/test_discoverable_devices.py        | 2 +-
 tools/testing/selftests/rseq/rseq-slice-hist.py                 | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/registers/gen_header.py b/drivers/gpu/drm/msm/registers/gen_header.py
index 2acad951f1e2..10316f517a7d 100644
--- a/drivers/gpu/drm/msm/registers/gen_header.py
+++ b/drivers/gpu/drm/msm/registers/gen_header.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 #
 # Copyright © 2019-2024 Google, Inc.
 #
diff --git a/scripts/macro_checker.py b/scripts/macro_checker.py
index ba550982e98f..7dbb114a57d5 100755
--- a/scripts/macro_checker.py
+++ b/scripts/macro_checker.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 # Author: Julian Sun <sunjunchao2870@gmail.com>
 
diff --git a/tools/crypto/ccp/dbc.py b/tools/crypto/ccp/dbc.py
index 2b91415b1940..cd56a63aa8ce 100644
--- a/tools/crypto/ccp/dbc.py
+++ b/tools/crypto/ccp/dbc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
 import ctypes
diff --git a/tools/crypto/ccp/dbc_cli.py b/tools/crypto/ccp/dbc_cli.py
index bf52233fd038..bfe34f01e619 100755
--- a/tools/crypto/ccp/dbc_cli.py
+++ b/tools/crypto/ccp/dbc_cli.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 import argparse
 import binascii
diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index bb0e671be96d..0ee3da6c6be7 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 import unittest
 import os
diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index dafbde56cc76..dccafd507bb7 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 # Basic sanity check of perf JSON output as specified in the man page.
 
diff --git a/tools/testing/selftests/devices/probe/test_discoverable_devices.py b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
index d7a2bb91c807..72a94bbfbc7b 100755
--- a/tools/testing/selftests/devices/probe/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/probe/test_discoverable_devices.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2023 Collabora Ltd
diff --git a/tools/testing/selftests/rseq/rseq-slice-hist.py b/tools/testing/selftests/rseq/rseq-slice-hist.py
index b7933eeaefb9..2c43b2e2bf0d 100644
--- a/tools/testing/selftests/rseq/rseq-slice-hist.py
+++ b/tools/testing/selftests/rseq/rseq-slice-hist.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 
 #
 # trace-cmd record -e hrtimer_start -e hrtimer_cancel -e hrtimer_expire_entry -- $cmd
-- 
2.54.0

