Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23D606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I6HSlJMR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D52410E5B4;
	Sun, 25 Oct 2026 04:02:41 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37DD10E66A
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:02:35 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-19305bcb72cso1174290c88.1
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 21:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792900955; x=1793505755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=osKiCGgvhu8yMTzDeDh9QImzUzGTyVINpwGdXaYWlN8=;
 b=I6HSlJMRwGwIsNFFOo7F4PekA6v/mVHEwmJidF6ilZYcQaImrqi+B7oxpwopzcmbYD
 WmpYdcdnCilv9uc15QQ3QPRIWAaeMxZU9OARm8LVC+iL9y26NGPaUBdCrSGKycvB3GSU
 YNEd2NTWXn8vqu8USdfHQ2r0v04oUpDesfk3hgSUje95VluIaoN0dzWeMAdkB92fTYO4
 MSiVboV2qc6s2shJyQXilXBykLWHQQnZ/l/YzmAw3DY2QFoLfSgt7wWLl2FZG/L0Hcq2
 M+kwK3sWTifekhdBAbiom3VDekEAI3xkDBfoWMr8XCeCaN2IxJwKcqZfD1BsKAbsrK73
 1vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792900955; x=1793505755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=osKiCGgvhu8yMTzDeDh9QImzUzGTyVINpwGdXaYWlN8=;
 b=JsWPf0ZP4rgPNOT+p+dXzzk9nIl2gnZTSMzpub0lo1ghxJGMm7bg6wXrruqXaUcWq+
 vuxl9dwQMEb1eKfBlQwWXgy9CJyalH2WEpWHVi/sQXNsadxNg0E/AxYjTpKmQW+8Bamt
 sEncHVyJWt1rwPnXtAdsefpRGtLsB2W6Pt5i+P7J3Mzju8t21CngA0E+UC5c7Y0akpPB
 xu8Q7siCK0DJosCFfrlHG0AWq2Hl99zci8kBoVqDKs84QHQM74ZAyl5jbaJ2xn8hGg+I
 QFcCMmzojh88X8A8YwBFGbCzcPaNc3PCAtciJCXNuEZYSv8sTHkSdvxm3K2be4JbTxQV
 COJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7piKHk+Xj1Nt3fVHJaWcmc0YktXwag7n1UDMio8ogSrdlxWn2v6aZZB7ppDCWKde9gAJCQ14A29o=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJXMuIouzJ7MREJJEQ1kirQsFJgAgAZJ1UfjGBzCJZgWdpkZzih
 iaVLzWCfeKP59v5fleksXTE+PPCmkjUP2pKY1v6ol3J6A0Du0IvZgxU=
X-Gm-Gg: AYBFou0/mxT2K5ZUuRpigM18mQ8XTzvOO2ZewtTnRLQCXktu8gFSMBMnxys92So2Zq7
 whassapNsvSeKEwXWqbujfkG5G1mpM1br3/nqdNFhKH7gtIWldg6SNM965sY45BMq8oJxsbhyk7
 4HzGFqhMecnPDiwoq6piElb511YpLfbhoywfllZQnGEe5h4FTeRB5U/jO/t3qCashQVEiyLO3p6
 R06mnW5ecDKLKyJMcqwmgPaNKSWp1pHei5loRl+hk+A0ew1GadDKymvmdhxn+67NUUxoVQ8AgDP
 Z7zJjfWsWxOn2rgc8p5AsRJe2yDFTWhNgkWGbn6lomfc6aENy542TBReG/vT8ikZPcte+sTfWIP
 1xsm1fS9R8ykXUKLQVj8u7fso2MeUX0tj0fOYwPaw8RL1Y/v1bCb9VXen5O0rTWPjpcsXMgS7DI
 t/b/g3UD6rRttx0rw/4RvDs3KiSrxxVlFlOlfdtc90E8t1re03As0RcBErW08vlYmGk0Ao1YwSs
 2EeQadoK/g0upZNlGGDwGVk3VuwvmX+RTPrNczmeVUSbIxOiW/hp+gOPETtIMTV22m83YV1iMQQ
 X8Cwn438HS4IjlPX
X-Received: by 2002:a05:701b:465c:b0:19a:9a93:c9b2 with SMTP id
 a92af1059eb24-19a9a93cdbbmr3658412c88.13.1792900954786; 
 Sat, 24 Oct 2026 21:02:34 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 21:02:34 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Andre Eikmeyer <dev@deq.rocks>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
 "H. Peter Anvin" <hpa@zytor.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)), 
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 05/13] platform/apple-gmux: Write switch state to EFI on MMIO
 devices
Date: Sat, 24 Oct 2026 23:59:41 -0400
Message-ID: <20261025040046.1602-6-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andre Eikmeyer <dev@deq.rocks>

On T2 devices (MMIO), the T2 coprocessor reads gpu-active efi
variable, and macOS seems to write it, so to properly communciate
to the T2 coprocessor, we write gpu-active.

Co-developed: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/platform/x86/Kconfig      |  1 +
 drivers/platform/x86/apple-gmux.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index c37e76066..01895d511 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -217,6 +217,7 @@ config APPLE_GMUX
 	depends on ACPI && PCI
 	depends on PNP
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on EFI
 	help
 	  This driver provides support for the gmux device found on many
 	  Apple laptops, which controls the display mux for the hybrid
diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index bef87a57a..637b3b216 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -27,6 +27,7 @@
 #include <linux/dmi.h>
 #include <linux/workqueue.h>
 #include <linux/pm_runtime.h>
+#include <linux/efi.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -494,6 +495,31 @@ static void gmux_write_switch_state(struct apple_gmux_data *gmux_data)
 		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
 }
 
+#define APPLE_GPU_VARS_GUID EFI_GUID(0xfa4ce28d, 0xb62f, 0x4c99, \
+				     0x9c, 0xc3, 0x68, 0x15, 0x68, 0x6e, 0x30, 0xf9)
+
+static efi_char16_t gmux_gpu_active_name[] = L"gpu-active";
+
+static void gmux_write_switch_state_efi(struct apple_gmux_data *gmux_data)
+{
+	efi_guid_t guid = APPLE_GPU_VARS_GUID;
+	u32 active = gmux_data->switch_state_display == VGA_SWITCHEROO_IGD;
+	efi_status_t status;
+
+	if (!efivar_is_available())
+		return;
+
+	status = efivar_set_variable(gmux_gpu_active_name, &guid,
+				     EFI_VARIABLE_NON_VOLATILE |
+				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				     EFI_VARIABLE_RUNTIME_ACCESS,
+				     sizeof(active), &active);
+	if (status != EFI_SUCCESS)
+		pr_warn("writing gpu-active failed: 0x%lx\n", status);
+	else
+		pr_debug("gpu-active: %u\n", active);
+}
+
 static int gmux_switchto(enum vga_switcheroo_client_id id)
 {
 	apple_gmux_data->switch_state_ddc = id;
@@ -502,6 +528,8 @@ static int gmux_switchto(enum vga_switcheroo_client_id id)
 		apple_gmux_data->switch_state_external = id;
 
 	gmux_write_switch_state(apple_gmux_data);
+	if (apple_gmux_data->type == APPLE_GMUX_TYPE_MMIO)
+		gmux_write_switch_state_efi(apple_gmux_data);
 
 	return 0;
 }
@@ -1283,3 +1311,4 @@ MODULE_AUTHOR("Seth Forshee <seth.forshee@canonical.com>");
 MODULE_DESCRIPTION("Apple Gmux Driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pnp, gmux_device_ids);
+MODULE_IMPORT_NS("EFIVAR");
-- 
2.55.0

