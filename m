Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B22CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059BC10FCB3;
	Wed, 14 Oct 2026 10:55:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AAF10FCB3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 10:55:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 95B99601F9;
 Wed, 14 Oct 2026 10:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42296C2BCC7;
 Wed, 14 Oct 2026 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791975351;
 bh=nGturtgrFk4ChNS5VbwT0gHcwlNvdAth/NDgIkP7DzU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kFIqLV76MdAF7TA0JuXxFLGGcI2fSPT3eGqdIjkLXiJp8E81lrbg2S0qRYbCX1cGH
 +sxDIVz7zrLxAfTrJMRe3okJZgmO5ziRj5L34JbeKU4Prj6PNb6vkX32gduZxvSMDh
 yFHKu+33eobE+vsEONZASqsXcf/SBa8ZYqAYkLfO9m/UYk/7k2Oi98sf9p+4hMSkPY
 X1KbTaPY5fw1x7XFp6n1uIkosKvSVkEJjcsOt+oUVSeFGKzSbXqZQEyAnnuqX7Quq1
 AkyKmH3A7OgGwzmhLzKp4YvUwiKthc2+GpGEyZV0US8SvBO1duoATqdDQN9Q/KocCr
 cPzJCGdeqmc2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE70CC6B24;
 Wed, 14 Oct 2026 10:55:51 +0000 (UTC)
From: =?utf-8?q?Santiago_Mill=C3=A1n_via_B4_Relay?=
 <devnull+santimillang.gmail.com@kernel.org>
Date: Wed, 14 Oct 2026 12:56:02 +0200
Subject: [PATCH] drm/tests: bridge: Document struct fmt_tuple members
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-bridge-test-kdoc-v1-1-883f7ec8bcfa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMFfz2oC/yXMQQrCMBCF4auUWTuQ1BDFq4iLJhl1FFOZSaVQc
 vemdvnxeP8CSsKkcOkWEPqx8pgb7KGD+Bzyg5BTM/Sm99ZYh0k+GIRTWwppwXcaIw7Ok7PnY/A
 nA+36Fbrz/M9eb7t1Ci+KZWtBrStnu/fJeAAAAA==
X-Change-ID: 20261014-drm-bridge-test-kdoc-a46e4183b670
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, 
 =?utf-8?q?Santiago_Mill=C3=A1n?= <santimillang@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791975361; l=1388;
 i=santimillang@gmail.com; s=20261014; h=from:subject:message-id;
 bh=xBhEKNdRFSh2ZCArxhg9+cTIQT8Sm2LYQdWKl1M7dMc=;
 b=bx87YpYiKOgpkhPmHQ9IzqIXl65n38C8Pfnm9Nzvn7+bHii9hlVO9J3QPzSJhyfc/m0WqYEzQ
 2dlbosQr900DKESl5AVhAnFVjMKzm6LmYjk3x2aSaY5g26FNR3UUz9E
X-Developer-Key: i=santimillang@gmail.com; a=ed25519;
 pk=53GrtI4i/ZCeWuXdQe6gXlcTQdbMxKlYzTUEI0heuV0=
X-Endpoint-Received: by B4 Relay for santimillang@gmail.com/20261014 with
 auth_id=1175
X-Original-From: =?utf-8?q?Santiago_Mill=C3=A1n?= <santimillang@gmail.com>
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
Reply-To: santimillang@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Santiago Millán <santimillang@gmail.com>

The kernel-doc comment for struct fmt_tuple does not describe its
in_fmt and out_fmt members, so W=1 builds warn:

  struct member 'in_fmt' not described in 'fmt_tuple'
  struct member 'out_fmt' not described in 'fmt_tuple'

Add descriptions for both members.

Fixes: 082fbc179c01 ("drm/tests: bridge: Add KUnit tests for bridge chain format selection")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606120201.5E4O2N7N-lkp@intel.com/
Signed-off-by: Santiago Millán <santimillang@gmail.com>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..b79d7b8b2d32 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -123,6 +123,8 @@ static const struct drm_bridge_funcs drm_test_bridge_bus_fmts_funcs = {
 
 /**
  * struct fmt_tuple - a tuple of input/output MEDIA_BUS_FMT_*
+ * @in_fmt: input bus format accepted by the bridge
+ * @out_fmt: output bus format the bridge can produce from @in_fmt
  */
 struct fmt_tuple {
 	u32 in_fmt;

---
base-commit: dfc3c7b84d43e7de918686e5cd7dd49196a5f45e
change-id: 20261014-drm-bridge-test-kdoc-a46e4183b670

Best regards,
--  
Santiago Millán <santimillang@gmail.com>


