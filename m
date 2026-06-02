Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB62BCD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 317A510F324;
	Tue,  2 Jun 2026 16:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rb1oANhI";
	dkim-atps=neutral
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 525FA10F324
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 16:17:34 +0000 (UTC)
Received: by mail-dl1-f66.google.com with SMTP id
 a92af1059eb24-137f27712fdso70213c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780417053; x=1781021853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ajva4//4bxspriKRwU9VltKASgTH4F65lB5PSd9V+c=;
 b=Rb1oANhITrvJhQNO2T4oCtrclax8+7/f3Pyp6kjpqGmFssBsyMpzcrUy71xfU8vPfP
 yD1ME2u6aWGlE4A83pF0h6VT+7ApeYLwbQrlHCkqdLfJxk6+UCVHqLi7oHBkSghgEUhH
 q/Ks7SVt4eZDsL/gWoO6o1kMi4aBhkzAVPaitg16XcEDGkEOFtcMrrkcaeJ1qj7WTs58
 41vmCB9BGLqJLW0x+HqO10Wq5o1c0Ym/RHLeSzWlXSgwB+XaUWyVC5EmQUw64z+HK6un
 PK8kIk6kbXABnabgzBnPiI4lV/QV10Z+IlYuu3FVDH9szsfyqowsUpdwa3hgC0tlgv4S
 HVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780417053; x=1781021853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ajva4//4bxspriKRwU9VltKASgTH4F65lB5PSd9V+c=;
 b=URlA8WuSLx+Uh3b9QOxQeHO1MIkihBNPJ7YiSJ+FCsGkaEFGZf/UVR5WybJ6l0vo+2
 vB5B2wVM08k4ZOYzm4up3xpQqgBsUruQXftg7EJtv8CUUlRYPE0LBPA8Icl4tPj2vDMz
 ggLtAyxW+Kbgf54DZNuCUoGgtBQds6syyiq019JbeEPBcZfF7crYcpidefxfy4MIdS24
 lls5A4v8Iuvim+NYhqkyU2N0OE9A/A2IDJbhmstxQ7yf0XTo5lNlZ2hqTl0zHTtT+nsr
 2u4okiD2/bzEmTtyhhocPBr3P1XPHXTXG7m0jvx0sbX63diNB0xHWboqdDjgS61V0ySh
 +X7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ94cc9Ktuw0tMoDHG2M4hO6P2zqxx3zPlouZ/H7DagkP34HkbsX7W2NMuZlhsM5EWt/ZYeM/gQhzf0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2rTux5YNhhYXgETMTAd2vVZgNZ2Z69Yh7ep9yAK1LarDEBCqF
 vI2IzqBjYJPtR5VYxbLB7H40nAUjqVShEMrqcMFAVcAuBQFEI+snco6s
X-Gm-Gg: Acq92OHJt8xbhpuNJiotofzX8CaD9/ScJcZghnxKU0VrawaffIdx51p055J0SlcPb3S
 jX/a5AwO0akvmex+tNF8eyh4u2c+7UmKHXfN6w1tUVMMIVUl308UcfX58ZRopxKtLM2yxy60qT7
 Vi//JfeHg4ZQMfmjqS3Cqu1P1xE/goUV0QVHFnyh228xd94cf4DR5y/IWEWIZmA5NgTSzBFBWu9
 Us5pTHHLwUaUBlOeTW88R9CzXiQUE0DMgGJOLFstUnwGF7dP2/nfSIKQJGp87JGBYo6RrV9N2xf
 F3J+jqBcqQAzvHVjRauuvWe8x8cikHJ2RNXblJsrcjThlcpFPJUxL9daEnmvlHr0V1xE99+iyPa
 PPYNU7Ofct2Nhni3X2y8Gr2CugxKFCqKxRUDS4eBgyTiW3cLZJHz9Fwx+7DtGlcp8/PfNObR4Y4
 tJNeTEKdE+G8+vTngiy8d7TqCTdV/gtC+X
X-Received: by 2002:a05:7300:6427:b0:304:d75b:f5f4 with SMTP id
 5a478bee46e88-304fa67e9c3mr8513884eec.16.1780417053229; 
 Tue, 02 Jun 2026 09:17:33 -0700 (PDT)
Received: from zhanwei.. ([192.227.223.214]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5b8fbbsm11976463eec.26.2026.06.02.09.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:17:32 -0700 (PDT)
From: Zhan Wei <zhanwei919@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: raag.jadav@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhan Wei <zhanwei919@gmail.com>
Subject: [PATCH v4] drm/xe/hwmon: document DG2 fan speed reporting quirk
Date: Wed,  3 Jun 2026 00:17:07 +0800
Message-ID: <20260602161707.18922-1-zhanwei919@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahqN8Esjz9SmGofH@black.igk.intel.com>
References: <ahqN8Esjz9SmGofH@black.igk.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On DG2 the driver always shows two fan channels, because the
FSC_READ_NUM_FANS command does not work on some cards. OEMs decide how
the fans map to tach channels, so two fans can share one tach line.
When that happens, the second channel reads 0 RPM even though the fan
is spinning.

Note this on the fan2_input ABI entry so the steady 0 RPM is not
mistaken for a driver bug.

Fixes: 28f79ac609de ("drm/xe/hwmon: expose fan speed")
Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v4:
- Add Fixes: tag and collect Reviewed-by from Raag.
v3: https://lore.kernel.org/intel-xe/20260529172449.41504-1-zhanwei919@gmail.com/
- Drop the dedicated Documentation/gpu/xe/xe_hwmon.rst doc and the
  index.rst hunk; add a short note under the fan2_input entry in the
  existing ABI doc instead, per Raag's feedback.
v2: https://lore.kernel.org/intel-xe/20260529135028.20763-1-zhanwei919@gmail.com/
- Drop the code change that reported a single fan on DG2; document the
  shared-tach behaviour instead, per review feedback on v1.
v1: https://lore.kernel.org/intel-xe/20260527115311.13398-1-zhanwei919@gmail.com/
 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon b/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
index 55ab45f669ac..0da739d9a816 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
@@ -251,6 +251,13 @@ Description:	RO. Fan 2 speed in RPM.
 
 		Only supported for particular Intel Xe graphics platforms.
 
+		On DG2 the driver always shows two fan channels, because the
+		FSC_READ_NUM_FANS command does not work on some cards. OEMs
+		decide how the fans map to tach channels, so two fans can share
+		one tach line. When that happens, the second channel
+		reads 0 RPM even though the fan is spinning. This is normal, not
+		a bug.
+
 What:		/sys/bus/pci/drivers/xe/.../hwmon/hwmon<i>/fan3_input
 Date:		March 2025
 KernelVersion:	6.16
-- 
2.43.0

