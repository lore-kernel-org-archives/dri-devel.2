Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C616075500
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I9CViI8h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1960E10EEE6;
	Mon, 19 Oct 2026 15:49:03 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8A610EEAD
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:48:56 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cd5e6f0a22bso809505a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424936; x=1793029736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SrddGqGEKlVywaBQP9jvBbsEZndrBLK5f3u5R5NoZ7Q=;
 b=I9CViI8h/d7wJWehdNBN5xixUSWplCPBH+N4yh8R+qfNzgywHXU9Qqa6Yqhs7yhb99
 tSVloLa9DVViYVteCaYVemkfoi2/JNwfWJN6Hzn9NwxqTLhMWErVTfN9GSAOnKbGZRBK
 rZ1IMFt9ol1Mn5QjbpAPMuBNcm29+YbWq3edVGVUEFgBwR6BTTgRrxXrFXZOn1tbFDSQ
 ocsTZjL/wkC5U+tioBecz2TAw/9x/XEwqFjxFqij7UF10DhNnNSfzFxT7914kvYMcdq0
 qe7+ltgb7pE0JwDRUxbHjrPeRe402u/2ObNGWhqYKImITa1nbeOG1QZZKr+IqF0Civwv
 zZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424936; x=1793029736;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SrddGqGEKlVywaBQP9jvBbsEZndrBLK5f3u5R5NoZ7Q=;
 b=qkUSUXgSb6DpN7pxfDp1LQc5bdWHtp4VonbhXI8aYX+dEa3JFJsMAQKzxu0/rA+I9H
 JrjDifbL7JvqNt9S8ns6zGBx8GtLTHRJv949uTMtP65+gx5ZCJwX5FLLTNJq7Jnobrcd
 wU6RS2p3bmSZP05WDF5TPRVpJZmFlRYWZuVW2gTrAIbKP1UoYc5x96Ds7h3+WnMQnKjb
 wNZx8880Pwm3wGstsa5rgb+QG/7+KRLj96rEvWCzCXeBd5QFMT2pb9cfsBJLEWUe+I+E
 NRqjh+ErpfAscEwGyvcxsU7rhf1KPUH9DizSlFX2336KFCziTJDccTv1ZuKTV54RFTyn
 DyUQ==
X-Gm-Message-State: AFq9FYK3mj76U0EeJ4dnEXFKKserMoPC5f/I/Gpl/emBhRY5E2GiDyil
 ggI9fB79SzbnCWC/pLUbzDu9o7sy265NY1J2SGweboeB5l/CSmb7ayzoqhcKhzOl
X-Gm-Gg: AYBFou1mw4r8+OUrpWBPGfdZE7jI8PFxXTanz5gm9y3frqaK3uDzsos9XgrqOQt2hLO
 /sKt+DZZ5kGYJtYaw9krhh0wmgSbk++AYWqQ1mqvNDUXKbu5u73DGckNwfIFFYVXXPpWh8UpB3F
 q5Ma+eqppul+suHF3on6whcMM90+ZN8xyDu1PilLsaIa/+aLk/loYsDzaPa8cSWFsfOPrUhGbo+
 3MYV429qR93lUi68zV7PtxYNQN/x7pHtYIhuV+hpKAP/s3dlE30Rs9S3vTuAOiiNastWqN5t5Zp
 1YxnWAEr7cIsKkUV7LiflPbPWLsfQ/RFCRBsvFPOiql/reMW9ZCAa/NHtBJe+tINVFEF0d7VQBV
 OrAJ6IAQXllgZ7RQp1tDMiJxCvN9NUn+uvcmK2beeEVUQhZoMQpt7TxkzzqLjXqeun7gtEfTC+N
 4otRbfjb7Ywh99B1HdW4iM2JU+Z3bJANlwhXAXh4cza50d8whWbvHKQ83rIgSYQhWvjaGA+bPcD
 vsm8HtSzEBw0udp/gaV2VOsAs+nsPuKdl0deH3Kf/XRCXpHitA8rZVFG9e3
X-Received: by 2002:a17:90b:17c5:b0:3a8:211b:6c6f with SMTP id
 98e67ed59e1d1-3acef5f91d2mr7219305a91.67.1792424936253; 
 Mon, 19 Oct 2026 08:48:56 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:a144:150d:733a:5ba2])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ad5cc13658sm63271a91.4.2026.10.19.08.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:48:55 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] drm/ms91xx: Add Kconfig and Makefile integration
Date: Mon, 19 Oct 2026 23:48:08 +0800
Message-ID: <20261019154820.68659-5-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019154820.68659-1-hjf3108@gmail.com>
References: <20261019154820.68659-1-hjf3108@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable building of the ms91xx driver

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
index a08087fb6e678..b7be4261bc054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8243,6 +8243,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
 F:	drivers/gpu/drm/panel/panel-lxd-m9189a.c
 
+DRM DRIVER FOR MACROSILICON MS912X/MS913X USB DISPLAY ADAPTERS
+M:	Ho Jie Feng <hjf3108@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/ms91xx/
+
 DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c65..93d73c7b90ce1 100644
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
index 2c6bc093a923a..8e98b7ac89f2a 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -191,6 +191,7 @@ obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_ROCKCHIP) +=rockchip/
 obj-$(CONFIG_DRM_GMA500) += gma500/
 obj-$(CONFIG_DRM_UDL) += udl/
+obj-$(CONFIG_DRM_MS91XX) += ms91xx/
 obj-$(CONFIG_DRM_AST) += ast/
 obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
diff --git a/drivers/gpu/drm/ms91xx/Kconfig b/drivers/gpu/drm/ms91xx/Kconfig
new file mode 100644
index 0000000000000..526aaa2ee5504
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
index 0000000000000..98dac2602c135
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

