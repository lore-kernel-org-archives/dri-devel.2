Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188CA606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h6go9ga4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFEE10E627;
	Mon, 23 Nov 2026 02:50:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED81010E15E;
 Mon, 23 Nov 2026 02:50:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D72A6402C6;
 Mon, 23 Nov 2026 02:50:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795402246;
 b=crxjGKCvz37Nm+Qg8erK00Dc81JgNnYPASFnVGHHgb2O6NRWX9mD2nRYRCdlqJK4bH0g
 f2LQozYdMIGVSWiO0uuu5FIxzMYjVia8W1/Zb/2OIvAKuVEu9rG33C43PNnRzIFN+PpaK
 eQoQ4Xnw1jchy4H/fj3VTCjSd6b4rIKTivKANfLlB8QsLtz9GOcWrB4b+IrQ82g6y8hKJ
 r16fHz2o15t3pLRAc3hqVYpoCCBKc0TLX2jyLEZukWzL333lgeqziPpoirWd8271w6Si8
 IDgYQmiq1O7CqQCNkgp/aGVQ0GrCkj1wNgB/GBTxgX858bWaehxIohNkEiQ7iZzMYIA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795402246;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=mYzftP7okWYVccrfzLATrhm/+frQGPys2Igd3BSptls=;
 b=XGzefRSdENPnv2ZDp7X0EjzmYFeFdnsHsCkYP1hE7naYbxcQeFsKi7mtUL5nlTqvtUOq
 kJHgMtqa5l1hXT6bkrfMbTvyQMLC1Ogn4pLhHcJww9ShMG2o9mKrE4gAPvmEJTa6eKHrB
 9RtezKzxf4nbcAafPr7WIOxrAI4UI0/+3Camo1CYzQy6ftXho+kbJ+hK1gNItMs8+55vY
 9afeCWvJz7lB9gxtxB9a2prGzc3xLDOvM6P8fa1+rV9SpGbUCqLxy/rcqJYOI6eVDPqgi
 z/6O4F4Ob0B2n1TxJ98x5uLjtmkc/Rc2NeamcbEOyqYd/FT8g+YoyC8QtY0/8+YUp7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 90B501F000C6;
 Mon, 23 Nov 2026 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795402246;
 bh=mYzftP7okWYVccrfzLATrhm/+frQGPys2Igd3BSptls=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=h6go9ga4yGCeZmOUZqEoS/S0ZgR3XqIlm0IK056bI+WQWNMQWVo2nEFRNUQvJNytg
 DysWSCBfCw3m/3L5mVG6zkJbba7tDSqRyBz4OB2h2zkpgTBugPEiNC4JFUOPmRDBa6
 5Af1lC+ka5Dyu7QmDloCrI+4oIMatmhn/myNluQfAMs047+3vRZV2VSPyZXKGCVNE5
 oszT0KCqOmpuOnZjMD3pCwyd7tr2asDh+A0CRjE7Zh6iZNdPyv3sj/teR0eUxS1OHo
 Kt7j2dRBLP1ktp61VjeYbMw5ErqVJnGLrG91pWbzrRkw0QCaFN67q4vg//5y1+C2SN
 Xe2NZrDLg4r8g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1E77C4C300;
 Mon, 23 Nov 2026 02:50:36 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 23 Nov 2026 12:50:29 +1000
Subject: [PATCH v2 3/3] nova-core: only bind to GPUs when explicitly requested
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-nova-nouveau-gsp-v2-3-5e8c27aa8555@redhat.com>
References: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
In-Reply-To: <20261123-nova-nouveau-gsp-v2-0-5e8c27aa8555@redhat.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3934; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=ktgnVzJ6BELx72lt+TM44DFV7qUNrRVPclg3oukRFbc=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrA6n6T/ovkwnCH7dJPiz7GYYvvFweCZ0MC47WW
 gXl8tEd3hqJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawOp+gAKCRAMdPNZecSG
 viicD/9oIepXbyTGfnO64WYJMrkhIvxypKd3ss2vP3ZyOTcc6TVAR8EgjRKKlgZExLay4dG+f5E
 473ODtE3kH+zyhG9/5hoW7PQPNLq5T2e4ZnHLv1szp8iukd+wpu4ep+v6PjRBMdP+HnsCSAhtJV
 /Q1PJPXnYXK1ryNmcHYq55RFjwYZuz29C+PFLs2iG5qTbfgXxy5qOziS0FHQ+hZatH4SwjmFzMn
 pbMAdOjNsOpJKfZfJGej4PULmBx1twfKySk+DlL2D8olFWSMFuGUbKYNGcelLjBsKvlvbOOujkN
 0niPvgE+r13XNUUMOfmp5TixoAFkjm/PED/dCmo8F1r9kOUK4K0/7d7gx65HhKu40IYQ/A++2t3
 ARfvvcg1MHLfy9fSfl86e9N/l3uc7vKZcViBkB+6w3GEmDyWNfxDoeJjJMFQrSFRRBJPOn+j0UX
 nqBgkFXARdtGoDEW7+VwlhQvtaIbGVg1ahO8s6QxvelqEH6cP62TkwnsXy0KGOUan5bgSb5i20p
 eUYetUIgEzTdEX6CiZXc0p6zjUOWc9X0nwe2sG9LlHowv++vBDekwL5FKaZkKidOG4DScWiG7bc
 Ij5xbO059NkMMUqgk288ghtdhoQMxKRDlz1cn5eq917NCcMKKp8a5zEzvEgtQ/HOt0GwEmHYetR
 ARW0vuyD6Ae7ktQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

nova-core currently binds to every NVIDIA GPU it supports
(GSP-capable, Turing and later GPUs), competing with nouveau for the
same devices.

Add the NOVA_CORE_BIND_GSP Kconfig option (default n) and a bind_gsp
module parameter, defaulting to the Kconfig value and able to override
it in both directions. Unless one of them requests binding, probe()
rejects the GPU with -ENODEV and leaves the device to other drivers,
such as nouveau. The PCI driver still registers, so module autoloading
via modalias keeps working when binding is disabled.

As nova-core is work in progress, the default is to not bind at all.
Developers can enable binding with CONFIG_NOVA_CORE_BIND_GSP=y, or
nova-core.bind_gsp=1 on the kernel command line, combined with
nouveau.bind_gsp=0 (or CONFIG_DRM_NOUVEAU_BIND_GSP=n) so that nouveau
yields the GSP-capable GPUs.
---
 drivers/gpu/nova-core/Kconfig      | 21 +++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    | 13 +++++++++++++
 drivers/gpu/nova-core/nova_core.rs |  4 ++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 2e11e46c99c7..058742d50692 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -30,3 +30,24 @@ config NOVA_CORE_SELFTESTS
 	  logs its failure and lets the probe continue.
 
 	  If unsure, say N.
+
+config NOVA_CORE_BIND_GSP
+	bool "Make nova-core the default driver for GSP-capable GPUs"
+	depends on NOVA_CORE
+	default n
+	help
+	  Make nova-core bind to all NVIDIA GPUs it supports by default.
+
+	  By default nova-core does not bind to any GPU and leaves NVIDIA
+	  GPUs to other drivers, such as nouveau. Say Y here, or boot with
+	  nova-core.bind_gsp=1, to make nova-core claim NVIDIA GPUs
+	  instead.
+
+	  nova-core is work in progress and may not be functional, so this
+	  is intended for nova developers and testers only. When enabled,
+	  nouveau must not bind to the same (GSP-capable) GPUs, i.e.
+	  CONFIG_DRM_NOUVEAU_BIND_GSP=N or nouveau.bind_gsp=0 is required.
+	  Otherwise both drivers compete for the same devices and
+	  whichever is loaded first wins.
+
+	  If unsure, say N.
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d6bc972d47c7..66208a244cab 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -105,6 +105,19 @@ fn probe<'bound>(
         dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
         try_pin_init!(NovaCore {
+            // Only bind when explicitly requested through the corresponding
+            // Kconfig option or module parameter. By default, leave NVIDIA
+            // GPUs to other drivers, such as nouveau.
+            _: {
+                if !crate::module_parameters::bind_gsp.value() {
+                    dev_info!(
+                        pdev,
+                        "Not binding to GPU; make nova-core the default NVIDIA driver with CONFIG_NOVA_CORE_BIND_GSP=y or nova-core.bind_gsp=1\n"
+                    );
+                    Err(ENODEV)?;
+                }
+            },
+
             _: {
                 pdev.enable_device_mem()?;
                 pdev.set_master();
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 84f777844592..d18dacad98b6 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -97,6 +97,10 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
             default: false,
             description: "Keep the GSP-RM log buffers in debugfs after their GPU is unbound",
         },
+        bind_gsp: bool {
+            default: cfg!(CONFIG_NOVA_CORE_BIND_GSP),
+            description: "Bind to GSP-capable GPUs, making nova-core the default NVIDIA driver",
+        },
     },
 }
 

-- 
2.56.1


