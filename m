Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DD606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yu757b3R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE9710E51F;
	Tue, 24 Nov 2026 05:50:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3352110E51F;
 Tue, 24 Nov 2026 05:50:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 114F8601D7;
 Tue, 24 Nov 2026 05:50:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795499416;
 b=UDJqaP6HtR2cDH95Z76QwXUjlBT3XGAHbMAJ0MddHkPHQmsDC5EkrDTey1PAbOfPjWUa
 0BXW8GNma1CERB2Q9C+mX3ruJjq+wlpFT7dhsCy7SeakOQowqTV/18I1rxf0aM7NbVwqy
 zTQVVdYM3bhvlByHa9XDvo5KZW2y8ZMgnEo138rKn4l17H0sLodmNF+uxJ36BykkSHIqd
 iwlEp3YEA7d3vz5xX/jCen0yn0PrMrjcLEDmYZwQK5/yjoeQg2WXrJRmSw4mbddlf7ttn
 rWwqlze7UBVfdURdUWy8xc1qBpJy5vEsYpqW3Zatj7cY88AW64hnmn7JkuvX0ce0qkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795499416;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=tOH/h6Tqg+37W/1zILx4kz70sQUpVXm1aS47prv42lU=;
 b=nlEC1/00HcS8CIMGnf4H1esf6YOWpQE6RhMSGgs+NgITJ2fWrl4BrEy/yTdeFDaY0aVV
 s92UfYOdeSkw9wOJtEH9+ZGPVrZXtci7fooCeqhpdENPOPPgfDmDVtzVDGX1IJwa5BjtS
 gCTLMTpLcV3SrekniiQcQsWxaO53QknoS2rKajArBx1TSfMGX8xzk+HG3FnPvgxGrTkxx
 iaeVM68p4GftlYSi240X2x50L9buy+TBZX/SQIct6qqUJI9Zmp1IYaI26z3YELPhEUB3O
 ly0bJU1ogt1NTVxF1FEECP7zRH7o0/PhNi8olBXtBFZKaOhI0I4smwTIeI+y2Fxu+2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 987B81F000CA;
 Tue, 24 Nov 2026 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795499416;
 bh=tOH/h6Tqg+37W/1zILx4kz70sQUpVXm1aS47prv42lU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Yu757b3RmnPlmwl62LOeOgOtrTBDeuvwy3dIoAmrS+sK86M1hZ4OqlFiG4VhrbLfr
 rIEOyfvmExtcvt24lbwhnUrrtgMwGqBWzGbLBdAc/p+KoulHMloVHxIGywzSYRpErh
 ZvKn8xwIJVR/2cmJn29aHqhNy6Fht66NIu4H1SUefZ9Pk9lgTfZtNHsnSlA65QdYhY
 CzI0Y8EwLXSaDOePDuiW8IufE2/xGwLX8fTUw9Bv3aOwfUPfz66LlLtk2fQlPLmlRa
 QEQAg4+Fv+MSvrhRzBbJqavHkDJNKRGgR0GgBcgoWL3pzw3VtiuQcSXRh4G5rX4Kbf
 Mzere5HJtc2bA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 264334C8EB;
 Tue, 24 Nov 2026 05:50:12 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Tue, 24 Nov 2026 15:50:03 +1000
Subject: [PATCH v3 2/2] nova-core: only bind to GPUs when explicitly requested
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-nova-nouveau-gsp-v3-2-e1440479ded6@redhat.com>
References: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
In-Reply-To: <20261124-nova-nouveau-gsp-v3-0-e1440479ded6@redhat.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=/JpuA77SYXr8eZJdlvYdOTmWAURnFQ/JxaNq3z83tIw=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBrBSWSObEJgGsFuNvh6iZPJbIQjxe6j6BZsVjzD
 Bt26fgV2P6JAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCawUlkgAKCRAMdPNZecSG
 vqpEEACaRteeM6+s/rEp2HuYOtgMQyXK+dsq84P0BFYxfhwfjcZ4xir4QTO/lxRpWzGJ3PTLpmU
 Kqyg8zUxXKhb2WFKEr39fcKc0QJfCNYbw57VNx8uXWlTHukQ1DXpbYam4hCXndqN85EO6/i8nRq
 gjvRZSmTqWyYBfQE5ae2X3SXYxmigN/V5EH8BXDPWlC+MiH1L6h7YwJ5j5z5inlCqFw475F45NU
 baZwnqOTv51Jlm8UmKQuxo+3Q0bmGfPourPpM/Yk8l3iC9AG6OqNof9Lg1X2kMROqiTslmRS8rx
 f0gAgdgPCS/Owf0sjY8WiF56glGZKq+V4qi/cE6EFXrINwiLnWdEkQ2Fae5mrRanTgC1xpDSBT5
 06D86BnhyZ4Xd+mlrmKHYytmMXafnL7PzyAY9vbVa1rmye54TnLLcMse4HyNIS/TMZWVxZPx8lZ
 yo3nPcNrsmmunGgWhEdlhS3090VxP1/GWgM2bnAI7Rrn6y/TETKVJkOBHJoXdER1P7K5D9w9Bkk
 KzGZM3D7pQmg5AamCKLkO4bMqExfTKogNDFHWIqGY3tcsjI5cG5wW3y4ha9XuXhXWCTDCuIaIgE
 BJnExyduzkTeVyyGJ7sU8kBGF8j1DnppCKuW2uE2xF6S5F/CYgppil5PbUFKI1RQuB685p6pZda
 hz6725D7y7B+THg==
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/nova-core/Kconfig      | 21 +++++++++++++++++++++
 drivers/gpu/nova-core/driver.rs    |  4 ++++
 drivers/gpu/nova-core/nova_core.rs | 23 +++++++++++++++++++++++
 3 files changed, 48 insertions(+)

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
index d6bc972d47c7..e89967ef0cd5 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -105,6 +105,10 @@ fn probe<'bound>(
         dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
         try_pin_init!(NovaCore {
+            _: {
+                crate::NovaCoreModule::check_bind_allowed(pdev)?;
+            },
+
             _: {
                 pdev.enable_device_mem()?;
                 pdev.set_master();
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 84f777844592..483e5c1d427b 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -68,6 +68,25 @@ pub(crate) fn debugfs_data<'a>(_dev: &'a device::Device<device::Bound>) -> &'a D
     }
 }
 
+impl NovaCoreModule {
+    /// Check whether nova-core is allowed to bind to GPUs.
+    ///
+    /// Binding needs to be requested explicitly, either through the
+    /// NOVA_CORE_BIND_GSP Kconfig option or the `bind_gsp` module parameter.
+    /// Otherwise, NVIDIA GPUs are left to other drivers, such as nouveau.
+    pub(crate) fn check_bind_allowed(pdev: &pci::Device<device::Core<'_>>) -> Result {
+        if crate::module_parameters::bind_gsp.value() {
+            return Ok(());
+        }
+
+        dev_info!(
+            pdev,
+            "Not binding to GPU; enable with CONFIG_NOVA_CORE_BIND_GSP=y or nova-core.bind_gsp=1\n"
+        );
+        Err(ENODEV)
+    }
+}
+
 impl InPlaceModule for NovaCoreModule {
     fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
@@ -97,6 +116,10 @@ fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, Error> {
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


