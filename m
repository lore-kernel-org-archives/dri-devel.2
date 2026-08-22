Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB9C5DF9B
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE3610E498;
	Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/xmcby1";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E29710E3C6
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:54:11 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so18819635ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787388851; x=1787993651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XSAtM60aX5eEvOcf6pdX1RWdmcuk2ZJPzvzzbZMEPQw=;
 b=Q/xmcby1Rci6tpYcv/xHgEvaQGnL4EbtGO94rQYeSp6hzQA5G4E44+Z6gUtBtPY1lD
 yW2Mh6nA+/A0ILm7PoEIuh+CXpW3NHwCDBDxyNhqKzbq9BLaLUAo3CMAAPPeU8bhYKc6
 oYiX6n2Be3MI03JQ3Wa2RGSZk2IHknzdWxUzouX+KKwpXnPPwSCz8WosXcB6RJ8WqvtQ
 DYore1NzXF3xf+IqO0OKBk8B64EHCbEz2TWDd/9SlIem0g5X0XVvhlB3L+Q5lt5+x3Y6
 +g4IdZ925Fwaz+Uobi4/pXF1jY9eK9KhfCJKJfHKNacxCccr3f14h0KARX20ikk3Euh0
 dMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388851; x=1787993651;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XSAtM60aX5eEvOcf6pdX1RWdmcuk2ZJPzvzzbZMEPQw=;
 b=KCkZKVV8bjKSJoWGQ2Z2DxGQII0DY+kd5w2FNSxzxy/dQlkQ2KDvfMwqcW9hk6apnY
 eZovnENDJdxrtguyxzj3eGWNUiykuH/4gYSYR/8orLaNNnoLj2IacA62+dnzNsAK5152
 ykTF+S18oPE3w4aDpso8SNT0Rj/fB+t/aMmPaOQCmXkOo+xT21sb0BWco2jTUfVrG++F
 LQXAlrjM/PaErJ456pBKO2/+PimxzotK8GM3zOB357v9SF7MRUL2lQsXvhCAlScngkSM
 hAyPv9tpFHl2HqRGdA1xEcF5xVfv436260TFkw5yJZLiZcSp3GF/YO+ovehgPi/ylV1b
 O7Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCaoN8n/k1JIsHNXBnwWhMtrSuZDBePLwfaIuo9oyxWjOErb51q2KfEpxju1CQfn9M9pq4KS99qvg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nVkIEX2iHmn1UwJYwaEFrVJnBZpm33v+k14c7XRWZhWQQhMrjN
 QuzGBNjBrtSPHtpxwAp7PmzMMQnw6POFTeYtBbE8gED1t8452y4LLL8B
X-Gm-Gg: AR+sD13KqrfDMy2am3QXNeTOpjubLSLxSm6nSs5GPvqf+fIV0Jemw1pMtQ5G3cCc4wl
 v+pPtZuj88swG5HunugFprRohEDs063dI4ltvyOjveITykpgNN8ggB8Swduw3jv3ciTl938xsuN
 aOLTXz658U+eYZFEdFzXcWPH7bxKoq5473TPauNS8EQnGtjjWmLDoMCTrkLFidC9kwu6n9Vi175
 z3LnCm09tDem7momFx7fGnMlLbVy/NUM2PnupgOErSyurvstmRbchGwgfTV55hkDbLgKI7C1lzM
 HqN0ixwCRJd4VXMHGa7uE6nW3KSa44as48wMTaQ26P0a6iPR+IwwFxS0Mj+7ADb5x5Xi4LZrJRF
 cO1RwKrwUDltGvI9BJ/E6Lz53ttINM9DelmLlacjI5E23rkxrOzzzKaFS/T0FtnVJ4ACh3bLqBh
 +9MNAc2nkIFShOQWAd7IDZdPU01sty88R0NA578iSrkaQZdQQuKwBFKdk1+StCSs0QhEg4QFxf6
 fDr//Sv4Q88/Q==
X-Received: by 2002:a17:903:1a6f:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d64b1851fdmr202120735ad.13.1787388850676; 
 Sat, 22 Aug 2026 01:54:10 -0700 (PDT)
Received: from mcp-node.. ([240d:f:fe4:c00:e9d:92ff:fe83:dbda])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d67676170fsm2982575ad.6.2026.08.22.01.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:54:10 -0700 (PDT)
From: Yuta Higuchi <avablaba@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] drm/xe/hwmon: wake render domain for BMG package
 temperature
Date: Sat, 22 Aug 2026 17:52:03 +0900
Message-ID: <8215b921cf29322ee2a434b3a772756e56c8d03e.1787385860.git.avablaba@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787385860.git.avablaba@gmail.com>
References: <cover.1787385860.git.avablaba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

On one Arc Pro B70 (8086:e223), the BMG package-temperature value
exposed as temp2_input updates continuously while the GPU is active. After
the final workload closes, it emits a short snapshot burst and then remains
stale for more than 200 seconds while VRAM, mctrl, PCIe, fan, energy, and
runtime state continue to change. An independent PID reading the same sysfs
node sees the same result, excluding the collector as the source of the
staleness.

The package-temperature read currently reaches BMG_PACKAGE_TEMPERATURE
(0x138434) through xe_mmio_read32() without an explicit forcewake
reference. Experiments on this Arc Pro B70 isolated the observable
dependency as follows:

- stock forcewake_all kept package temperature updating;
- a persistent main-GT XE_FW_RENDER reference kept it updating in three of
  three independent rounds;
- releasing that reference was followed by renewed staleness in all three
  rounds;
- main-GT XE_FW_GT alone was negative in the single persistent-holder round
  tested;
- transient XE_FW_RENDER acquisition produced a fresh value in 1.17 to
  2.172 ms; and
- a 20 ms RENDER hold with no sysfs reads yielded a fresh first read.

Acquire the main GT render forcewake domain around BMG package-temperature
reads, allow 3.0 to 3.5 ms for the observed publication to settle, read the
register, and release the reference automatically. The delay is empirical,
not an architectural contract. FORCEWAKE_ACK_RENDER only acknowledges the
wake domain; no public temperature-producer-ready indication was found.
These experiments do not establish that register 0x138434 architecturally
belongs to XE_FW_RENDER or identify whether PCODE, GuC, or other firmware
produces the value.

Keep the change limited to the BMG package-temperature channel. Runtime
validation was performed on one Arc Pro B70. XE_FW_RENDER was
single-domain sufficient among the directly compared states, but media,
GSC, and other individual forcewake domains were not tested after that
positive result. This does not claim that RENDER is the unique minimum for
all BMG devices or steppings.

The equivalent Ubuntu 7.0 diagnostic implementation passed three
independent 180-second cooldown rounds; 1, 5, 10, and 30 second read
cadences; four concurrent readers; a 30-minute run; OpenVINO workloads;
suspend/resume; and Xe unbind/rebind. The directly tested drm-tip
submission candidate, based on 75140c4ee9ad, additionally passed one
clpeak/dual-reader/180-second-cooldown smoke and one bounded OpenVINO
two-model smoke. No GPU hang, reset, fault, wedge, or kernel taint
occurred.

Fixes: dac328dea701 ("drm/xe/hwmon: expose package and vram temperature")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7805
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/4560
Assisted-by: OpenAI Codex:gpt-5.6-sol
Assisted-by: Claude Code:claude-fable-5
Assisted-by: ChatGPT:GPT-5.6 Sol Pro
Signed-off-by: Yuta Higuchi <avablaba@gmail.com>
---
 drivers/gpu/drm/xe/xe_hwmon.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
index 5284cab67..1c0c6d3ab 100644
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@ -3,6 +3,7 @@
  * Copyright =C2=A9 2023 Intel Corporation
  */
=20
+#include <linux/delay.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
 #include <linux/jiffies.h>
@@ -14,6 +15,7 @@
 #include "regs/xe_mchbar_regs.h"
 #include "regs/xe_pcode_regs.h"
 #include "xe_device.h"
+#include "xe_force_wake.h"
 #include "xe_hwmon.h"
 #include "xe_mmio.h"
 #include "xe_pcode.h"
@@ -330,6 +332,28 @@ static struct xe_reg xe_hwmon_get_reg(struct xe_hwmon =
*hwmon, enum xe_hwmon_reg
 	return XE_REG(0);
 }
=20
+/*
+ * Experiments on Arc Pro B70 show that package-temperature updates resume
+ * after acquiring the main GT render forcewake domain. Allow time for a f=
resh
+ * value before reading. FORCEWAKE_ACK_RENDER acknowledges the forcewake
+ * domain; it is not known to indicate temperature-producer readiness.
+ */
+static int xe_hwmon_bmg_pkg_temp_read(struct xe_hwmon *hwmon, u64 *reg_val)
+{
+	struct xe_force_wake *fw =3D gt_to_fw(xe_root_mmio_gt(hwmon->xe));
+	struct xe_mmio *mmio =3D xe_root_tile_mmio(hwmon->xe);
+
+	CLASS(xe_force_wake, fw_ref)(fw, XE_FW_RENDER);
+
+	if (!xe_force_wake_ref_has_domain(fw_ref.domains, XE_FW_RENDER))
+		return -ETIMEDOUT;
+
+	usleep_range(3000, 3500);
+	*reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, CHANN=
EL_PKG));
+
+	return 0;
+}
+
 #define PL_DISABLE 0
=20
 /*
@@ -1037,6 +1061,17 @@ xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr,=
 int channel, long *val)
 	case hwmon_temp_input:
 		switch (channel) {
 		case CHANNEL_PKG:
+			if (hwmon->xe->info.platform =3D=3D XE_BATTLEMAGE) {
+				int ret =3D xe_hwmon_bmg_pkg_temp_read(hwmon, &reg_val);
+
+				if (ret)
+					return ret;
+
+				*val =3D REG_FIELD_GET(TEMP_MASK, reg_val) *
+				       MILLIDEGREE_PER_DEGREE;
+				return 0;
+			}
+			fallthrough;
 		case CHANNEL_VRAM:
 			reg_val =3D xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, chan=
nel));
=20
--=20
2.43.0

