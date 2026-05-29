Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0C9CD6E4C
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23788112714;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ac6dtwSF";
	dkim-atps=neutral
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE39D10FF71
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:51:00 +0000 (UTC)
Received: by mail-dl1-f66.google.com with SMTP id
 a92af1059eb24-1363e78746eso10341927c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780062660; x=1780667460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqOHPyyH5EfN3wruBEgkXAHRsiGcQZOI00mYuQNCffs=;
 b=ac6dtwSFV+UiXBKNvwuOoT2I59DwNQxS/hyajsQftE5bT4yrLYZ/QhcvOpLKcX1ARH
 dkz/u3jfAiDAO50e0E8Pcg85OYMh8KwyTLxUwRsvMDpLaBmVWx/KnWpAMq1fl8p2RqKe
 pw9Q78JQl6ONgiSlUTUDicm6HECIHN2rB+WdbB2FZ9SwplS53GZxtQsgnzJK3FwqYGD5
 CU34gQZHecs4oDilPZLSg6n30R9SktN9MykK0MDgpLIed1neRrUW3Ur5y8KnD3sJEaeS
 aNlsfTM/iaKD6Yp11cCeJVxJhmJ5uuht2isWc/MHshsMG/99rPGGuXTxQ9KqHmQ2LG0X
 qs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062660; x=1780667460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rqOHPyyH5EfN3wruBEgkXAHRsiGcQZOI00mYuQNCffs=;
 b=ByIdcLaG7+nhNN6J/iiOh0i8gCHiBq9KnCFn8O7AxFJLa8B6iN9JTS97Cakt5LewY5
 uSKPJphfO227Dqh54gZee+ZrLythtdwSIilq/S65w7XHL9yqHI/Nb21aBdhe5RwRKPnw
 i6+2A8ZaDOFm30eMGwinWtdxIx0wnvA6y20DND8QxLw7zcQCgI0kEMYSTjulqu8CQRy0
 0WBLA0rIJ6Q2RO69ybAG3HkXMYQmFkjSLDxYGrsyaZrKepYz1ACsaEHis6fWZicxGLW9
 xnCsKG3NvMogS7Fh1yo/khxgzpsXiScoa3gzIasWHyTyYKmqHnDAOY0DwGjwpbutngRR
 hI0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/okdLu2/1rcSsLi51hXqOkGvTJSq5UHfENQYGP6b8pzmynI5VtiE4BfcVfwydLCRix23X+oxsVVmQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0uyi6RToM1kuSaB1cEa2fjsBnM4LAATnsox+8VRSabR+Plgsc
 IWD69DM9IEZNTAKS20Bo2XLmF8TTx/FQcmjuAdk0Ta1nm+B1zsSdkmiR
X-Gm-Gg: Acq92OHD6HBR5LChVOTFoLRukbaA2TkCEzwMWB/aj7M85tcJLM8BWCP6SQPlL4SS6cZ
 doMDsv62fhGhTPoe17isEMD4IRBKAyh0F5iyXXcZojwrn1sZAjs5tVJONVj/K5sZ15SFXL4S8zk
 JpWGd7Uq8oPPL1u24ZnHYoLhdnuWoIJbjOOymgqEGUUnslmhfbc2MWH0JMNTiDLG49ZAZHES3yJ
 it/G5cNZqaTMXFJOiLDpkETz+/ShzP05DTXJR25XCUj8381LYfXOmH6djmnl8jwCxUqF1+nJnd8
 JX1aAaHFSvTTitvR/R/fBDB2Xq1oEyuRMPEZ5sdKeec59sVTbEY/4W8eg0CwbK2I+Mp+VLjw2FL
 0TUxlLhOmVpQ5BTEspGbtOJBRaN1Kkm5Sa023RzMjzGrku3qwRHsozyXGXwX515psrudJBw7pTd
 BQnIrYR2o/58j6Jb0xFfX/+cmMQl1SxyvH
X-Received: by 2002:a05:7022:2522:b0:136:60e7:53b with SMTP id
 a92af1059eb24-137ae975179mr1065625c88.1.1780062659647; 
 Fri, 29 May 2026 06:50:59 -0700 (PDT)
Received: from zhanwei.. ([192.227.223.214]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm1169747c88.11.2026.05.29.06.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:50:59 -0700 (PDT)
From: Zhan Wei <zhanwei919@gmail.com>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhan Wei <zhanwei919@gmail.com>
Subject: [PATCH v2] drm/xe/hwmon: document DG2 fan speed reporting quirk
Date: Fri, 29 May 2026 21:50:28 +0800
Message-ID: <20260529135028.20763-1-zhanwei919@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527115311.13398-1-zhanwei919@gmail.com>
References: <20260527115311.13398-1-zhanwei919@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

The number of fanN_input attributes on DG2 is hardcoded to two because
FSC_READ_NUM_FANS returns an incorrect value on some boards. How the
physical fans map onto the tach channels is left to the board vendor:
some OEMs route multiple physical fans through a single shared tach
line, in which case the unwired channel's pulse counter never
accumulates and fanN_input reads a constant 0 RPM.

This is expected behaviour for such boards rather than a driver fault,
and the driver has no reliable way to distinguish a shared-tach layout
from a genuinely silent fan. Document this so the flat DG2 fan count is
not mistaken for a bug and "fixed" by lowering it, which would hide a
working fan2 on boards that do wire two tach lines.

Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
---
v1 -> v2: Drop the code change. As pointed out in review, the same PCI
  device ID ships with both shared-tach (multiple physical fans on one
  channel) and 1:1 fan wiring, and FSC_READ_NUM_FANS is unreliable on
  some boards, so the DG2 fan count cannot be lowered without hiding a
  working fan2 on boards that do wire two tach lines. Document the
  behaviour instead of changing the reported fan count.

v1: https://lore.kernel.org/intel-xe/20260527115311.13398-1-zhanwei919@gmail.com/

 Documentation/gpu/xe/index.rst    |  1 +
 Documentation/gpu/xe/xe_hwmon.rst | 48 +++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/gpu/xe/xe_hwmon.rst

diff --git a/Documentation/gpu/xe/index.rst b/Documentation/gpu/xe/index.rst
index 874ffcb6da3a..3c14cdcaa8a6 100644
--- a/Documentation/gpu/xe/index.rst
+++ b/Documentation/gpu/xe/index.rst
@@ -30,3 +30,4 @@ DG2, etc is provided to prototype the driver.
    xe-drm-usage-stats.rst
    xe_configfs
    xe_gt_stats
+   xe_hwmon
diff --git a/Documentation/gpu/xe/xe_hwmon.rst b/Documentation/gpu/xe/xe_hwmon.rst
new file mode 100644
index 000000000000..8cd48df59386
--- /dev/null
+++ b/Documentation/gpu/xe/xe_hwmon.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+=================
+Xe HWMON support
+=================
+
+The xe driver exposes hardware monitoring sensors (power, energy,
+temperature, voltage and fan speed) through the kernel hwmon subsystem,
+typically consumed via ``/sys/class/hwmon/hwmonX/`` or tools such as
+``sensors``.
+
+Fan speed reporting
+===================
+
+Fan speed (``fanN_input``) is reported in RPM and computed from a tach
+pulse counter: the driver reads an accumulating pulse register, divides
+the delta between two subsequent readings by two pulses per rotation,
+and time-averages the result.
+
+Number of fan channels
+-----------------------
+
+The number of ``fanN_input`` attributes exposed in sysfs is the fan
+count returned by the ``FSC_READ_NUM_FANS`` pcode command. On DG2 this
+command has been found to return an incorrect value on some boards, so
+the driver hardcodes a fan count of two there. As a result up to
+``fan1_input`` and ``fan2_input`` are always exposed on DG2 regardless
+of how many tach lines are actually wired.
+
+Zero RPM on DG2 is not necessarily a bug
+----------------------------------------
+
+How physical fans map onto the tach channels is left to the board
+vendor. Some OEMs route several physical fans through a single shared
+tach line, while others wire each fan to its own channel 1:1. The
+driver has no reliable way to tell these layouts apart, and the same PCI
+device ID can ship in either configuration.
+
+When a channel has no tach line driving it, its pulse counter never
+accumulates, so the corresponding ``fanN_input`` reads a constant 0 RPM.
+On DG2 this is most often seen on ``fan2_input`` for boards that drive
+both physical fans from a single tach line. This is expected behaviour
+for such boards, not a driver fault, and reflects the board wiring
+rather than a missing or stalled fan.
+
+For this reason the fan count on DG2 is intentionally left at a flat
+value rather than tracked per board: there is no driver-visible signal
+that distinguishes a shared-tach layout from a genuinely silent fan.
-- 
2.43.0

