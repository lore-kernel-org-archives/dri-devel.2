Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB4606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=C3dHLycN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD34F112A8B;
	Fri, 20 Nov 2026 14:13:09 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7033510E8FB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:12:58 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-38587f3de36so1060863eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795183978; x=1795788778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OcPIQ0d5qXJOh07IzuyFSR1AEkkv6LDZJPL7nbKJNWQ=;
 b=C3dHLycN8SSs8SoRKyQpwqUS53ZowJleAgyDE0V+7TVTq0Xl/uXQiNJG9AeYNnWxcY
 FYUL5TKEnWVyR/7JgNhuoqbF3eOdpzs+22FaAQVCv5MfAu4YgdFPWBb4SA8qD70mQ8vY
 pyJftWKAGQMREjHDwrG2z/mdi5kCT2FSv1kMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795183978; x=1795788778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OcPIQ0d5qXJOh07IzuyFSR1AEkkv6LDZJPL7nbKJNWQ=;
 b=sd4zZxlsrSYf5+avHcyHdMBUGa767i6SENxZIPNctpUshI/AUtUrSO+Am0Y3vVmbtr
 eDhVto3ZgicNrIa+E8jS1DZCnbTnjOZUeQ/UVbAx/RxSeHoBxxtdCA5wYJCLYcM9YHmJ
 DeZfA2hVudyxqA5ddzLbT6PMxKgsoTZiZnWquh/XqVPWyf2yh0RnnzGk3cEh30oIyuqv
 bwc1tThAscKuLiP26m10olGYJwZkS78a95yBAMFbIvjccmtr02A2gAcB0VUyBvrtDZIM
 7mmm/2a+v/VruY5kXpOoAkDjSUwBSqLbHLkn6V08Pn16WeD0ug3LKJAevDSCF5TFqTGB
 RIgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG8d4V3KK0xnq7IG3/Bc8MJhNlee3Zd706hUvsLC+rJ8EQPKGeH3nRACR0dgElHc2zUcKroNyH4Wzk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8fSvotjf3smZPnnNgOS983wfnSi6zeB1RRWODf1jU4+no2rWU+
 foBZw1j4MhBMej64uwUYh4wHnE6wxGOsIsbpb7S2f/JRJcclVyddMh8JWrv4y22uotA=
X-Gm-Gg: AZFdTZfK1UWvwuFtjW50N81D9TMzb22bg46fbeIWu/fZJ4H00cyOZd/mBLNErJJDj5h
 wT1lw12Vp1WuBRatpH7mXjil4j+8NBZMfSAi2f12LFpQ/h6sJmHmOjA6ttfXMeMGRGJjAaX0cDs
 Uy8auGKCV9rBbaBGv+Zq557epWNqSzN/ddTUvzOnabDitITFOak1jzPKv4ONlFQtjNbOQVP1c2p
 sYLi2y4xXmxZKPa4FqZ70sIv4FXeeRoKiWsShSmEc3SamQt1sE4dOjlHBWYyZJ0bXZEH2E/jJwN
 UzcVTcaFmVksJuy4iWNol9x00X6OC1dt7rAy64nXkG9J1asUdd2hyq8ddLl9U5T4e4YRTk/LBfx
 Ca4ZivI3Hl7UqRFbf7wIIQsn3yytD8MZ7aDQW4pFRfsWEpmp9ci5glaMaOED6bfr0AJYfboL2R9
 M5ldTfxD6ls1jV3pPZAmROv2QyUHYgWsySjsqbK3ngMGAP29IZc/hGPYEQpfOezCui+JZ3D1SrL
 tv+xw7nudwrq/nUSvaZEXI0mW6X8S5cFCbKjzJfQkZ6/K5+1Co4pF/TS2e6fNqU+8fjRcH5FSvF
 OtpDL5PsJ7ZXJN8Bu136iozH4756p1QL4Rz7Cxn7kCYr+sv8oa+meSpDHCKKzxiRG62HZ8sn5hR
 2mpnXi2k9omOJ
X-Received: by 2002:a05:7301:18aa:b0:384:eec:aba0 with SMTP id
 5a478bee46e88-3857073eebamr2968011eec.36.1795183977458; 
 Fri, 20 Nov 2026 06:12:57 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm11244434eec.5.2026.11.20.06.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 06:12:57 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, ckoenig.leichtzumerken@gmail.com
Cc: Tvrtko Ursulin <tursulin@ursulin.net>, mcanal@igalia.com,
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sidong Yang <sidong.yang@furiosa.ai>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v6 2/2] accel/rocket: Report NPU usage through fdinfo
Date: Fri, 20 Nov 2026 23:12:25 +0900
Message-ID: <20261120141225.789350-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120141225.789350-1-sidong.yang@furiosa.ai>
References: <20261120141225.789350-1-sidong.yang@furiosa.ai>
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
drm-engine-capacity-npu set to rdev->num_cores, the number of cores
bound to the driver.

Document the keys in the rocket driver documentation.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 Documentation/accel/rocket/index.rst  | 29 +++++++++++++++++++++++++++
 Documentation/gpu/drm-usage-stats.rst |  1 +
 drivers/accel/rocket/rocket_drv.c     | 25 ++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/Documentation/accel/rocket/index.rst b/Documentation/accel/rocket/index.rst
index 70f97bccf100..d633502c8f15 100644
--- a/Documentation/accel/rocket/index.rst
+++ b/Documentation/accel/rocket/index.rst
@@ -17,3 +17,32 @@ project.
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
+number of cores bound to the driver. The time is summed over all cores and is
+accounted by the DRM GPU scheduler, from when a job is handed to a core until
+its fence signals.
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
index 5d7805c41dc3..b5fd800f500f 100644
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
@@ -139,7 +141,27 @@ static const struct drm_ioctl_desc rocket_drm_driver_ioctls[] = {
 	ROCKET_IOCTL(FINI_BO, fini_bo),
 };
 
-DEFINE_DRM_ACCEL_FOPS(rocket_accel_driver_fops);
+static void rocket_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct rocket_device *rdev = to_rocket_device(file->minor->dev);
+	struct rocket_file_priv *rocket_priv = file->driver_priv;
+	unsigned int num_cores = rdev->num_cores;
+
+	drm_printf(p, "drm-engine-npu:\t%llu ns\n",
+		   drm_sched_entity_get_runtime_ns(&rocket_priv->sched_entity));
+
+	/* A capacity of zero is not allowed, skip it once all cores are gone. */
+	if (num_cores)
+		drm_printf(p, "drm-engine-capacity-npu:\t%u\n", num_cores);
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
@@ -150,6 +172,7 @@ static const struct drm_driver rocket_drm_driver = {
 	.open			= rocket_open,
 	.postclose		= rocket_postclose,
 	.gem_create_object	= rocket_gem_create_object,
+	.show_fdinfo		= rocket_show_fdinfo,
 	.ioctls			= rocket_drm_driver_ioctls,
 	.num_ioctls		= ARRAY_SIZE(rocket_drm_driver_ioctls),
 	.fops			= &rocket_accel_driver_fops,
-- 
2.53.0

