Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3C606D834
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zQHh+sk1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B570D10FCA6;
	Wed,  4 Nov 2026 15:19:15 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA49C10FCD8
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:19:09 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso631455a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793805549; x=1794410349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TXMNp6D6dnftjM/lgn3eHCYCFJRX9HjksHyNmOga4wg=;
 b=zQHh+sk1Aj/Jev3zsiDsVPrGx7DcXD/8k0bZdt5/8fYYsIR5o82XRHw0QCWbzAVnP8
 q+rAtr+sSK//Lnw9eWLD/4Ux5+TFqgVuCyhgC7eSvI7slMFYLUS6WXUdKW+ZCeCbOiPg
 2VX9A9+gKHJC5JUWJ8YspwJfOEBa2fX15pPisWsFkNJ8H1/IyO+CNxLQz6DYlSIT9Ecm
 n43/vqyEXFjo/H32t3Gff8PmpQ/b2oWamIwn1QJOoFcLcetIQMHSlYJE6efRE97/Abyz
 h4hQkhfAwyeEMS8mVqqTgOZitov43QvhWT3Bjko6bEw7h18FJ/FCLmrVf5MPHw1JXnMG
 OT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805549; x=1794410349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TXMNp6D6dnftjM/lgn3eHCYCFJRX9HjksHyNmOga4wg=;
 b=at3zl3ehsbA9nhrvtjwj4W5NPnsF2/vA42lyuu5HPqUhS3hKYC9KE39foaKKUZk1eT
 UJwnHzL5E21XTeuvaCOeFpp8GBBCknpdqxnMBIpuqsIXk425sFk55kyrHZWgSRT6S+0N
 TBTJnp/tgebYnMivMNYS/g9xOOH9QWkkv7BXeYa26Zi0rbw6M0GQrvvJpi5+SdVYn57s
 xNw2s+ZcDZEbQt0kK7OoF+7Q5dC5Zi869PKBO4Puq3f0QGwmPGRg+GVjF9XKBFuUy+4I
 U5izmYncmC0eMDnOYEQqO7dkjQERrCaYotz1fMpzdvlzQiMvqP8TfyINMT9eWpN7uYCQ
 ZNkQ==
X-Gm-Message-State: APuU4Z8anZb6Yt01dUiD5jiaGJ6T0D0O9BNmNJAD2hDcmlGWJopdfEFo
 DnGBzYONd+Mwfmn1vKiIWz3d/gAbtsaotoDPi70cJ7W3xOEl5Gk6vLo5Ls6Sbl4M
X-Gm-Gg: AYBFou1FRYZkuDVXFwoiasRZYRpWqveBz7S7X5nsX6x+zMQ+jgqvEDft0cKNN40/0Nw
 67jy0vVOA7F1L/meYXQETl/gA/ug/7jluuLYP83p05odFezbiW/E1h3cBJQPMy1b42fUz5B5GG6
 vxFiB4kGIOsiNvnn90nTv20rIdYZPsSSVCIzhyHiU20zJ+/YTWGMrkXMK6Ub9pn6TdguIVb0E1j
 VJ8laNtj6jkPy4FVojuUhxqgiEBZvvMA7PragVwaJOfvZOffrPzo56obCC5IlulvFCKRRF9kTrW
 juGQSlQybwGQUWITYsn5pDCaga5667C6di33e9vaXp5E/ynHoIrN1kDd8yExeTmA1r+7Jx6FcpR
 wQrJ+uzmOT+frDJm34prsVDknc66rX50nFD99xC7+kEPJzoVod2J21Ww8aU6Y9//b3fOSpsPwwz
 Gv/KBX+Tb4p/zmSuudPH+gw89vWQmSDBxb1eRN5F3GejhjW7sdCWdNIgiGAScEP8gDTAxAIEGKu
 vdftWP5HdKeavty3sHJy/dbVhBLyUgkuJqqNyi2z0oc+KRyo/MKLUxKqS82+5+YP4dWGtH3X4fR
 t7PbM769D87n2HRp/NSDF+cDIeyVNCgZnym0t1KrZJQYOqxz9tbX8NPNiF8j7C8t3Tdk5bzbo25
 2lsQ5
X-Received: by 2002:a05:6a20:1f28:b0:3e2:21c0:3dff with SMTP id
 adf61e73a8af0-3e928e20ceemr15901497637.65.1793805549214; 
 Wed, 04 Nov 2026 07:19:09 -0800 (PST)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8b097fdf9bdsm1110555b3a.7.2026.11.04.07.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:19:08 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] drm/ms91xx: Add Kconfig and Makefile integration
Date: Wed,  4 Nov 2026 23:16:50 +0800
Message-ID: <20261104151652.59135-5-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151652.59135-1-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the MS91xx USB display driver in the DRM build and register its maintainer.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 MAINTAINERS                     |  7 +++++++
 drivers/gpu/drm/Kconfig         |  1 +
 drivers/gpu/drm/Makefile        |  1 +
 drivers/gpu/drm/ms91xx/Kconfig  | 13 +++++++++++++
 drivers/gpu/drm/ms91xx/Makefile |  9 +++++++++
 5 files changed, 31 insertions(+)
 create mode 100644 drivers/gpu/drm/ms91xx/Kconfig
 create mode 100644 drivers/gpu/drm/ms91xx/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 3951f85d2..85d4e7a3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16034,6 +16034,13 @@ F:	drivers/net/wireless/virtual/mac80211_hwsim*.[ch]
 F:	include/net/mac80211.h
 F:	net/mac80211/
 
+MACROSILICON MS91XX DRM DRIVER
+M:	Ho Jie Feng <hjf3108@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/ms91xx/
+
 MAILBOX API
 M:	Jassi Brar <jassisinghbrar@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b..93d73c7b9 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -330,6 +330,7 @@ source "drivers/gpu/drm/mcde/Kconfig"
 source "drivers/gpu/drm/mediatek/Kconfig"
 source "drivers/gpu/drm/meson/Kconfig"
 source "drivers/gpu/drm/mgag200/Kconfig"
+source "drivers/gpu/drm/ms91xx/Kconfig"
 source "drivers/gpu/drm/msm/Kconfig"
 source "drivers/gpu/drm/mxsfb/Kconfig"
 source "drivers/gpu/drm/nouveau/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a..cf83e3104 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -180,6 +180,7 @@ obj-$(CONFIG_DRM_I915)	+= i915/
 obj-$(CONFIG_DRM_XE)	+= xe/
 obj-$(CONFIG_DRM_KMB_DISPLAY)  += kmb/
 obj-$(CONFIG_DRM_MGAG200) += mgag200/
+obj-$(CONFIG_DRM_MS91XX) += ms91xx/
 obj-$(CONFIG_DRM_V3D)  += v3d/
 obj-$(CONFIG_DRM_VC4)  += vc4/
 obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
diff --git a/drivers/gpu/drm/ms91xx/Kconfig b/drivers/gpu/drm/ms91xx/Kconfig
new file mode 100644
index 000000000..526aaa2ee
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_MS91XX
+	tristate "MacroSilicon MS912x/MS913x USB display adapters"
+	depends on DRM && USB && MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_GEM_SHMEM_HELPER
+	select DRM_KMS_HELPER
+	help
+	  This is a KMS driver for MacroSilicon MS912x/MS913x USB display
+	  adapters with VGA or HDMI outputs.
+
+	  If M is selected the module will be called ms91xx.
diff --git a/drivers/gpu/drm/ms91xx/Makefile b/drivers/gpu/drm/ms91xx/Makefile
new file mode 100644
index 000000000..98dac2602
--- /dev/null
+++ b/drivers/gpu/drm/ms91xx/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+ms91xx-y := \
+	ms91xx_registers.o \
+	ms91xx_connector.o \
+	ms91xx_transfer.o \
+	ms91xx_drv.o
+
+obj-$(CONFIG_DRM_MS91XX) := ms91xx.o
-- 
2.55.0

