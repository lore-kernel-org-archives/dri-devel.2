Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA8606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TdT1COf4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 086E410E66D;
	Wed,  4 Nov 2026 08:58:15 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367F110F6A4
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:53:33 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2119feee8so6320375e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 07:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793721211; x=1794326011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N3SYB/BgxSNTh4u+DnHBIGPI0+Di9/c/+FCF8jLlAW8=;
 b=TdT1COf4c+GZx8PshmWlFJjMdFVHtGspcE48YYoxlk28CWhy4TrM3/lHnCAMG3CoTF
 p7MkeVJTw5VTvFvYmEUdf/ySt76NuVogprOjMCVFWdq4UjMvm9O8/AFxrdBg9X+V94Ej
 L/S1d5Xt2Y1/Pofs6fFVDipRW5ozW7407oN8M/ernLsOREowegG6S+E371e6eHQq7wVh
 tczF9UjOCRSqg7DmRUKttyIm7aPdbXqx6yjV8R6dWs4m1/0yPdIdlIuYbdrhea6ZMmcC
 tKSSHBbxkkNrxgK0tzkP1KXxfxdnKQVhv7Wy/i6XaGI7k63eWRHcUfGhg6AAdgMS6BlQ
 6uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793721211; x=1794326011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N3SYB/BgxSNTh4u+DnHBIGPI0+Di9/c/+FCF8jLlAW8=;
 b=o5Po6JIKatYbcHVjcalKhJAFrBlD+o66gm9aquYVp8+drp7Jqs/V/gOmRQinOa3Z/Z
 Yl3WARlppvg5XlFn5B8knb6bC8IBBoz9OILPXnSSpU6PaTJFJWb/+klma+Evw6agK78k
 q3wEIEVKP67/dlD1UDqK8Th1OzwBSb/gSIGbuHqY1LrlA3VXwXEuD6hXKzWvV3VTgqnW
 k2X6KDnn67uv82n10VFuNOTlRWsM/vSYW2v+78u7ECaw7e6V0X7mrCfKtZvQeiISyrI+
 TmczxAofCWDrDYFZ7bUqd90fl/2iGoCEhrpyUfFOj6WtfiL/xiLOQBVrVSqn3k2527XD
 DwTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzu7OsSo4f2jzElGqnkPr/bhAP548UhIJI2Rz8tVJZHyazuPB7BOtub8kvMO1Uj3iHRtELl7UlpeI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/cZbePSMEPCiJ2djd4wTzqervqAqN9chRCLmjPZyP2Dys9Rxff
 ZfUzYh1JSCD0vHPp38IwcqxM75nj+hosAH4+yH4TidbrXXrRq1qf56G1
X-Gm-Gg: AYBFou04cA8hvoJ5XpSLxmuS6rAy1QKwgVi8QOF7GMsyVCqobeGqNl+GwQVm/inbW7s
 2QYAKesyNozXDLHypKJn3R4yrl1ORPACp805OcnS//ZYKeaumimlx9PKcpAM56jWMGwXf2CuDIY
 isdm26efGZRzSFNh+njWEwCr8OP61CEAO9BmlYDu97QWfN+Osn7pOF7NyVtpyM96Ji0LN5xiPqr
 stRMjvkxkrgQHqkzumZGO0x2E6rskXJyt0k2Ff9bJ4SBqDSVr/FUxIzX73/+TV+ECeZUqMW4NIh
 tOTvuqBEloVb6s9uHsRcw+0tWEPkiwxo1WktJU56IG9xOc8XnE+181MyCq/HZr5/Ojk6Ro8LEiW
 42/ueMpRnQFyenwln0SJEVv+eUQIdidY/xFzlE8Jlz6q/tUn/RYKxsGtqG3C+g/oEOSKJZXxubf
 KzrWW9u+lPj7pym5f1Qfzr2TQD5DB92VYiPGtnarmnVf1f+DRM4QZfRBwwYZuQLNtlitt0KSDG5
 uPuNmhViTaLycGphmfNpp05jTTEFJ2Yk2wkzLfaVTJ8iW+r/QBBHU1TuALw3owD4y94J0X0X1Kr
 GQd/SDMjgBDPJ0At6hFhyOZFlxrUfPmH4fMWo5Vl6EZ9a2k0fRQ=
X-Received: by 2002:a05:600d:6505:20b0:4b2:3c81:103 with SMTP id
 5b1f17b1804b1-4b23c8106abmr73912745e9.2.1793721211351; 
 Tue, 03 Nov 2026 07:53:31 -0800 (PST)
Received: from Termis-ROG-FLOW-Z13 ([2001:16a2:4495:e600:1209:ec98:a2b4:9c5a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm63777815e9.5.2026.11.03.07.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:53:30 -0800 (PST)
From: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
To: Mario Limonciello <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bin Du <bin.du@amd.com>, Nirujogi Pratap <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>, King Li <King.Li@amd.com>,
 Caspar Adriani <caspar.adriani@proton.me>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Arec Kao <arec.kao@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
Subject: [RFC PATCH 3/3] drm/amdgpu: add the OMNI13B1 (OV13B10) ISP sensor
Date: Tue,  3 Nov 2026 18:53:13 +0300
Message-ID: <20261103155313.114347-4-saif.elden.hatim@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu creates the ISP 4.1.1 devices only when it finds a sensor from
isp_sensor_ids, which lists only OMNI5C10. The ASUS ROG Flow Z13
(GZ302EA) has an OmniVision OV13B10 with _HID "OMNI13B1" on the same
ISP, so its camera is never set up.

Add OMNI13B1 and register its GPIO lookups:

- enable_isp on AMDI0030:00 pin 85, as for OMNI5C10. The ISP4 capture
  driver requests this GPIO and fails to probe without it. On the
  GZ302 no ACPI device claims the pin, and the ISP also boots with it
  left undriven, so its function on this board is not confirmed.
- the sensor reset line on amdisp-pinctrl GPIO 0, active low, under the
  "reset" name the ov13b10 driver requests. This is the same ISP GPIO
  as the OV05C10 enable line.

Like the OMNI5C10 tables, they are registered once and stay registered.
The ISP setup uses the software node that amd_isp4 attaches to the
ACPI device, so this needs the amd_isp4 board configuration for
OMNI13B1 to be in place.

Signed-off-by: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  1 +
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c  | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 63088c072..412d3992c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1726,6 +1726,7 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #if IS_ENABLED(CONFIG_DRM_AMD_ISP)
 static const struct acpi_device_id isp_sensor_ids[] = {
 	{ "OMNI5C10" },
+	{ "OMNI13B1" },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
index 363266f3e..7d6072e27 100644
--- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
@@ -65,6 +65,14 @@ static struct gpiod_lookup_table isp_sensor_gpio_table = {
 	},
 };
 
+static struct gpiod_lookup_table isp_ov13b10_gpio_table = {
+	.dev_id = "i2c-ov13b10",
+	.table = {
+		GPIO_LOOKUP("amdisp-pinctrl", 0, "reset", GPIO_ACTIVE_LOW),
+		{ }
+	},
+};
+
 static int isp_poweroff(struct generic_pm_domain *genpd)
 {
 	struct amdgpu_isp *isp = container_of(genpd, struct amdgpu_isp, ispgpd);
@@ -240,10 +248,13 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
 		return 0;
 	}
 
-	/* add GPIO resources required for OMNI5C10 sensor */
+	/* add GPIO resources required for the sensor */
 	if (!strcmp("OMNI5C10", acpi_device_hid(acpi_dev))) {
 		gpiod_add_lookup_table(&isp_gpio_table);
 		gpiod_add_lookup_table(&isp_sensor_gpio_table);
+	} else if (!strcmp("OMNI13B1", acpi_device_hid(acpi_dev))) {
+		gpiod_add_lookup_table(&isp_gpio_table);
+		gpiod_add_lookup_table(&isp_ov13b10_gpio_table);
 	}
 
 	isp_base = adev->rmmio_base;
-- 
2.56.0

