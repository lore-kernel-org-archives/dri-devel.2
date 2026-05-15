Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E106CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C31110F43E;
	Fri, 15 May 2026 07:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XgPKRDqd";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2453510E0A6
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:46 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-82faf871346so6548887b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778823766; x=1779428566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QMruzNzp/w/H8WMl6Rm7xeR7IZKT2QV9Y6KPDlL64Q=;
 b=XgPKRDqdddvaXbtga4HO/yUkElkd0TAa6lREFpIPTj+EwU14IJU1VstUpogcRt6xY6
 8kLOtNeaWOH7/uPLVRjONhK7xbxf3dQUrnHfQJpxxpYR2CwKImDmA3MAwLQEhfIZBJfa
 5Gg4xM+ZnLC2FQnHh9g6uyGD27Y+3L0rFSAZEx1mMst38vw9eCMOLFF+LOXgNUBMGqjy
 VXRxYvivNMKJ1R40N+Xi38lLXE8QkBBQicTG2Ko+nU2oTwQ+evnELb1mKQZcKu7Plym7
 WrNeCjINvkJtr++lf2bz49e7ubB18CiGmqru+i31AXffZZZyFMdPF2eRSIHjofMpHfN5
 Uo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778823766; x=1779428566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QMruzNzp/w/H8WMl6Rm7xeR7IZKT2QV9Y6KPDlL64Q=;
 b=kDXmgRmhrneg8dThlCmEQUvoRLM6z0AGktjuXWLgRa4aWD8i29Ea4x0+GJ4nE07xJ9
 2qmS5/UKkAj1EtJSD25DmEPMhXNVXtYDoeSTcYDW/BrpXlzdj3vA9VS5DY7wm+n1Gbnl
 AVYpICCqGOosgoPDjFAJY1mYQNr+RdDv2J6Glvy1CXzUD49zIZcc7XTeVuUtV5cm16uG
 vdVouKqRpUK2ckziK/vZSJaANw/BhF3j4OzL5q8w2fx8+QnSfpbfcC5dDJc4F+HOW3hZ
 D04tivU7OpjHUU7Zrih8mRMA9LNDimCwhNV2IS550AEyLfl91ekUUqfKuIxApCAQ3ug3
 yDWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qa8Tlkp5kcVIEdrMLQOkKm0zlENnICiZ7eegkBruF+Bww3SiEU24SDq9Hc1si1zPtxAva9UR5DAY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNt0pcDmMmEZs8WZVpwSAa6LV+g3VXq13D/zVMZZl9o9H+HF3Q
 oCg00WC3lUKrjF9sb/t7XTHE5FqQiRM0bToF4gKjV4CuYM4RbhfpFVpc
X-Gm-Gg: Acq92OGqrAJj5xQFOvD1uagRsq7XbXLXkkRtvhBXZKKyn5bKZ7URmeULA1FvoAF6iBk
 GIovxqlcrJ1N0hqOSRCEVxv59eAaquNvJHXSxEKMwLc9O7Es7TseYw/Oc9cXeNnZ8wQXOMIGh8U
 m0VatSDxkhlKk7B4y73d8PmuE71lv6w7PAtoXYsTh6sQ73/V3C/+qSeTF7HQTYp1DNTPhsKPlYd
 kOOLY5s+I+2rwgQ+yEUy/SHQe5yHqbjwcZJ1okQcv6QNPkctmSyhcGoc+ytW0klBSuqEVIM7E5F
 4iAlHyC9m/ZsAdBwJMuRzjyhmLLXbQJmKshv52/3NdWZDWIdUEKc+V5kln5Q8M8eAmGAkj7wWAN
 q0jBJJ1epUIlNwDGh952XtFPWI5R05zxXRz+QxFkClbafrii8Z7sIQvQC7cZtfqxVqwxsvVJNwW
 xNLRdPdTf8sVGf07F1xDWNifLYcArIq8/XpD17iyervUozFJmY/U/t4I0vKNTOvRL+TMoOjRm14
 C6u+zQ8WTylMkEJp2EBODjk2rM=
X-Received: by 2002:a05:6a00:340c:b0:82c:6b46:271d with SMTP id
 d2e1a72fcca58-83f33d0a2e5mr2772793b3a.48.1778823765596; 
 Thu, 14 May 2026 22:42:45 -0700 (PDT)
Received: from harrison-Surface-Pro-12in-1st-Ed-with-Snapdragon.wework.com
 ([203.117.161.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f2b9bec8fsm3106116b3a.33.2026.05.14.22.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 22:42:45 -0700 (PDT)
From: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 luzmaximilian@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 3/7] platform/surface: SAM: Add support for Surface Pro 12in
Date: Fri, 15 May 2026 15:41:48 +1000
Message-ID: <ab458aadea651396d9ea7629419a32dc7510c593.1778822464.git.harrison.vanderbyl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 07:13:06 +0000
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

Add a SAM client device node group and registry entry for the
Microsoft Surface Pro, 12-inch with Snapdragon.

This set enables the use of the following devices.
1: cover keyboard
2: cover touchpad
3: pen stash events.

The battery info and charger info devices have been
purposefully omitted as they are also reported by
other drivers and cause conflicts.

Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
---
 .../surface/surface_aggregator_registry.c         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 0599d5adf02e..884049961415 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -422,6 +422,19 @@ static const struct software_node *ssam_node_group_sp11[] = {
 	NULL,
 };
 
+/* Devices for Surface Pro 12" first edition (ARM/QCOM) */
+static const struct software_node *ssam_node_group_sp12in[] = {
+	&ssam_node_root,
+	&ssam_node_hub_kip,
+	&ssam_node_tmp_sensors,
+	&ssam_node_hid_kip_keyboard,
+	&ssam_node_hid_sam_penstash,
+	&ssam_node_hid_kip_touchpad,
+	&ssam_node_hid_kip_fwupd,
+	&ssam_node_pos_tablet_switch,
+	NULL,
+};
+
 /* -- SSAM platform/meta-hub driver. ---------------------------------------- */
 
 static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
@@ -500,6 +513,8 @@ static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	{ .compatible = "microsoft,arcata", (void *)ssam_node_group_sp9_5g },
 	/* Surface Pro 11 (ARM/QCOM) */
 	{ .compatible = "microsoft,denali", (void *)ssam_node_group_sp11 },
+	/* Surface Pro 12in First Edition (ARM/QCOM) */
+	{ .compatible = "microsoft,surface-pro-12in", (void *)ssam_node_group_sp12in },
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
-- 
2.53.0

