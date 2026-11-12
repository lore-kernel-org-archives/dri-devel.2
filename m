Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2711606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=k6DVWet1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF79112248;
	Thu, 12 Nov 2026 17:12:28 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66EA9112248
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 17:12:22 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3b155f50c24so3249788a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794503542; x=1795108342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=khMH15UrWwDPVaDjMg8F/SoPd4LjFp0hVV0BhxLmj3M=;
 b=k6DVWet15rMqKlZmtOUJUlpS0pszOUyYDaNJg6ziZEEmau7XHdD5mgp9mO67kVD2F2
 jy+2YQv41IAd3JgX2ONfCDSnYwBRMzTIt+IutfJWAO6EXeJ2d66JwtaIJAQmvpYlknZu
 RptQyoYhM90ep7a7yPskIqz/xIzfSUZiosZ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503542; x=1795108342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=khMH15UrWwDPVaDjMg8F/SoPd4LjFp0hVV0BhxLmj3M=;
 b=vQNaAT3p3Ovv2SXQp/GajXQjuujjmF2fIJlmy9M22oJwKIoUB5ZGiw+dKOlCgCFvp7
 vvuUhHrq8DJwtFpZsnYFfyMLfOYnLjeGJilG6m3+lIZg3GAtfvkYoOVuOnqQt0CodAtZ
 a1ZMU/MNVAnBMrRwRusI208FaToJcWP5itQOziAOB+4Dw/iSh9PflGT6JLpw/ffGEM96
 Lp2KAW1QC5Z4p3nykPXHvGaCNBT3NzgUh1u5eJKKTfLUXdzkuB7PB91WlPbfA/R5ssfD
 Bkwuy64CM1VekUSTbSdAruC8NVBuXuJgcp1zs87jsFvVv+8q2ta3OPGQAIdS5EymFTz5
 UkLg==
X-Forwarded-Encrypted: i=1;
 AL+hErEyj25Y14zC93FY6ZeM5Mlg2p8Emilgii1IQj2TuxydgojIRRgEAL7irchXpGf42qtmMqOKO13DFDs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pRpiym1HpBtKuy5pFbnaDfvhTZJgmRyw5nYt65c7AUOD41Ceg
 HfEetfUpiQtl1TqIP+sdswp0/aZx4bKtPxTtAHmwikybdy5yKexng/RDkopfruzC0bA=
X-Gm-Gg: AYBFou1c8vxotDaaPpZsHPv/T4a0vfCxIKE78L7ZcwETOgOkpFG7WM3KFZpz0GKuc6c
 j5qTQo6r5VUU4wZPDWLU0Iq8Fdwb2v6vsi6zwhkent15jMIDPWFPv14MLLpCu0+OmkS7Zfyjqi/
 cYmjtw3J3Ez02570IJFsOYEyY22USxwbCc+F1oQxBrDoMxG9VRdycrhCiVCSlEx3pgglcndicer
 OgVfpOR5kr2X9SCCc5Hwl3PHNhadDmgq2n23eBtyi46BEoaxestcyntRBKHh8ocla2z2QkZo7/g
 5xCkEflmd3GM+fVCLDm621P/ap2iBlPlqMAuN3AG7k1A/p5JhllE0sZxoNAZ1YBZ5lPc8iFuJQ7
 7GVFN14Akjly8ZK2xM8f54qhUoRE1vICYG6n6ZcVgPq4kQeiPmXObd4/1/uF1XEFczSL88HQetu
 dCmnKR8DtNd5XPAT7F18ixmO27OxCs5PlqeCfjZO5zv6M7CRfXiTab9a6qZDTcUshPXGwV1uweR
 ViNkiIyrEd+7OTBa5UdyExbkzSBUGKgTy0yH4dCFa4TgIyxnsfQVGU7hy5+P6dilBaodofFvr9g
 ttvt0HqnXrP245coyCFudZoC6hQAvXtsn+Mxb1rZ2FL8YvIeDHPjXLT49UuU+3STgknenqyeK/T
 QTODkbV+bjA8p
X-Received: by 2002:a17:90b:3e8e:b0:3ac:9d83:885e with SMTP id
 98e67ed59e1d1-3b182f3e594mr7100466a91.52.1794503541921; 
 Thu, 12 Nov 2026 09:12:21 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae981c55sm263682a91.1.2026.11.12.09.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:12:21 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>
Subject: [PATCH v5 2/2] accel/rocket: Report NPU usage through fdinfo
Date: Fri, 13 Nov 2026 02:11:44 +0900
Message-ID: <20261112171144.3151554-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There is no way to tell how much of the NPU a client uses. Implement the
DRM usage stats: report the runtime of the client's scheduler entity as
drm-engine-npu, along with drm_show_memory_stats() for the BOs.

The cores are identical, so they are reported as a single engine with
drm-engine-capacity-npu set to rdev->max_cores, the number of core
slots.

Document the keys in the rocket driver documentation.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 Documentation/accel/rocket/index.rst  | 28 +++++++++++++++++++++++++++
 Documentation/gpu/drm-usage-stats.rst |  1 +
 drivers/accel/rocket/rocket_drv.c     | 21 +++++++++++++++++++-
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/accel/rocket/index.rst b/Documentation/accel/rocket/index.rst
index 70f97bccf100..8ae785b65a53 100644
--- a/Documentation/accel/rocket/index.rst
+++ b/Documentation/accel/rocket/index.rst
@@ -17,3 +17,31 @@ project.
 Hardware currently supported:
 
 * RK3588
+
+.. _rocket-usage-stats:
+
+Rocket DRM client usage stats implementation
+============================================
+
+The accel/rocket driver implements the DRM client usage stats specification as
+documented in :ref:`drm-client-usage-stats`.
+
+The NPU cores are reported as a single engine, npu, with a capacity equal to the
+number of cores. The time is summed over all cores and is accounted by the DRM
+GPU scheduler, from when a job is handed to a core until its fence signals.
+
+Example of the output showing the implemented key value pairs:
+
+::
+
+        pos:	0
+        flags:	02400002
+        mnt_id:	33
+        ino:	755
+        drm-driver:	rocket
+        drm-client-id:	263
+        drm-engine-npu:	2384122043 ns
+        drm-engine-capacity-npu:	3
+        drm-total-memory:	24216 KiB
+        drm-shared-memory:	0
+        drm-active-memory:	3000 KiB
diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 70b7cfcc194f..288764730d23 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -218,3 +218,4 @@ Driver specific implementations
 * :ref:`panthor-usage-stats`
 * :ref:`xe-usage-stats`
 * :ref:`amdxdna-usage-stats`
+* :ref:`rocket-usage-stats`
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc3..351be60b1228 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -3,8 +3,10 @@
 
 #include <drm/drm_accel.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/rocket_accel.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -139,7 +141,23 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(FINI_BO, fini_bo),
 };
 
-DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
+static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(file->minor->dev);
+	struct rocket_file_priv *rocket_priv = file->driver_priv;
+
+	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
+		   drm_sched_entity_get_runtime(&rocket_priv->sched_entity));
+	drm_printf(p, "drm-engine-capacity-npu:\t%u\n", rdev->max_cores);
+
+	drm_show_memory_stats(p, file);
+}
+
+static const struct file_operations rocket_accel_driver_fops = {
+	.owner = THIS_MODULE,
+	DRM_ACCEL_FOPS,
+	.show_fdinfo = drm_show_fdinfo,
+};
 
 /*
  * Rocket driver version:
@@ -150,6 +168,7 @@ static const struct drm_driver rocket_drm_driver = {
 	.open			= rocket_open,
 	.postclose		= rocket_postclose,
 	.gem_create_object	= rocket_gem_create_object,
+	.show_fdinfo		= rocket_show_fdinfo,
 	.ioctls			= rocket_drm_driver_ioctls,
 	.num_ioctls		= ARRAY_SIZE(rocket_drm_driver_ioctls),
 	.fops			= &rocket_accel_driver_fops,
-- 
2.53.0

