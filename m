Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C86E606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EPdsYRx7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AB6112975;
	Fri, 23 Oct 2026 06:40:34 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258A410E5B3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:40:20 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a20c923847so4286165e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792737618; x=1793342418; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nI3N8MrEeubTFBg+n+hiFqxjlTWdSSoRNoSmz7N6G04=;
 b=EPdsYRx7u/ImL5+7Gy1w0Q0J4rgRamlDxOEVtIFYF7y32Djq1rBhHzcDTlA1+57wLC
 Vys9TOBYKU7HIR9FHtKavxZEmuIe8p3/BKLL6lgUT/YKU9mMITks//v8KZEqV62ECFhu
 azDW531PUDi9JtgKfVmn10ADSpaA9OtaY99i6IZA1NQwGF41cI4gFj2y3Fb5w1Oa6K8F
 KtP1Z6mSw73wM1oI82efLywfd4lIkg81wyrKbJ8HG+QmhIhCQ43CVZdP8vx3djPtBnC7
 n75K6C/luqhWmBnO8Fu7V2Q8JFmCDzhhndk6rTOSrxGlQWo1cHcpV1DWWXV8fky1lXi0
 qxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792737618; x=1793342418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nI3N8MrEeubTFBg+n+hiFqxjlTWdSSoRNoSmz7N6G04=;
 b=nhjnkhedTt5ggkub/McPCEBMO9wK8KCt5JlmH9jCOJrcImU42rjTSVDqTriyj9RJmn
 HhW8KBZuLiyHqJh9y6y4uAsUcj5u5TcBWfpdlle8ty7A2iURY5KkdbAxAZlsaGlF1ajp
 eb8kgkXdZw8mrXp7DqvZLUqXLHcJ5o6/MXtVvEKd6/mmSfmwwnU5PPh/bfXDhRk+Mxtb
 iSBZ6DQ5IfXXE/HfF7KyMVPKy0Gwzbo+dqjzfrmEx/SkmZYQ72pT4b1SaveO78iAoyNo
 OTzb9IsMAl/wzjBCJjBudvGK/k+mw3gA0Z1wksPaHZ6n1pWtUgcMuUvqdFtZruw1v0Zu
 z49A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsFOkLr7sT98XwYnskSpJ7SLyRd3q8hAG+KzRJogkcNdtw/TMiMIzfHmVV7zxqjRYG50fwfekCwHQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLQgyvQ63vHquyTLTpOOd3Srzj7WTvxMg2+55zTBgypbSvSo67h
 Szq/2c+2vwNMtB76HFDUipqh2PoKbZssg/gIyzmjm7aKdZiFfbKZZMAS
X-Gm-Gg: AYBFou2so2nWsyUZDU3qgVQnRdkEc76NrRhFlXG9Y5xATqNmwfsbWE3bUVZoyApL2fo
 9vg86wcSlpN2xmbE+VrXlHnRAVVw6DP14R9EKyZ9b1LG1LhYSKE+ejZUmwII6LbiuUXMQUy9Jm/
 s9143MjvDfv7f37kqaBm75i7sl3MoXsN/sehddkcx0imAfiNEqGogNayj5H3ikSZPkYqoAVDe88
 q98sD75uKjbEZmvsYOSeeZa15oXYxP5mACzqthwZ4/WTn+qyMxfJi1CgnmubgkVieEYVlr0v5uO
 4OxkmL3H6+0CxW+UzgEPyrSiJO8rjNlzKeUoNToT7Z7Il9aLqrd4jf+sP0OtFadySmPR5Pg3vK7
 uEsttZZE8PjsGIgfPi9sgNNvtGcB81X3+ulIGs1mOJRExg3deX9BAQWyT88GpIqSRf3qCM4rBH3
 DVNV3rQoWKS4xbtBGu4WA+Cpi1xv9y33B0w5PIWKjjTn8dg+YovyBJrFNgkIH4k4R5ekapcBbjy
 4PzpPbZQNsv8L2fvBP/1vBNQ4OqF/HMjm1S5L/sn/bRkzUxddlWT6eTONbuXFta1XSAwFLvbgtm
 qxi4f7RMsKFO3cY6yI60MbJpkboXETKS5QvwEbcHJlZ0OGF+SpaAXNtgrCvFEhza3wM5RGY/gDB
 Mdpg=
X-Received: by 2002:a05:6000:258a:b0:48d:fdc0:7086 with SMTP id
 ffacd0b85a97d-48e3859a817mr1823119f8f.22.1792737618388; 
 Thu, 22 Oct 2026 23:40:18 -0700 (PDT)
Received: from [192.168.1.22] (cst-prg-49-173.cust.vodafone.cz.
 [46.135.49.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38030c47sm3104782f8f.21.2026.10.22.23.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:40:17 -0700 (PDT)
From: Tomeu Vizoso <tomeu.vizoso@gmail.com>
X-Google-Original-From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 23 Oct 2026 08:39:38 +0200
Subject: [PATCH v3 13/16] Documentation: accel/thames: Add initial docs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-thames-v3-13-3ab40aa17157@tomeuvizoso.net>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
In-Reply-To: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
To: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Nelson <robertcnelson@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Suman Anna <s-anna@ti.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 linux-remoteproc@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
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

With pointers to the other components and how users can make use of it.

Assisted-by: LLM
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
---
 Documentation/accel/index.rst        |  1 +
 Documentation/accel/thames/index.rst | 47 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                          |  1 +
 3 files changed, 49 insertions(+)

diff --git a/Documentation/accel/index.rst b/Documentation/accel/index.rst
index cbc7d4c3876a..eb115413db07 100644
--- a/Documentation/accel/index.rst
+++ b/Documentation/accel/index.rst
@@ -11,3 +11,4 @@ Compute Accelerators
    amdxdna/index
    qaic/index
    rocket/index
+   thames/index
diff --git a/Documentation/accel/thames/index.rst b/Documentation/accel/thames/index.rst
new file mode 100644
index 000000000000..6382ff2369be
--- /dev/null
+++ b/Documentation/accel/thames/index.rst
@@ -0,0 +1,47 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+============================================================
+ accel/thames Driver for the C7x DSPs from Texas Instruments
+============================================================
+
+The accel/thames driver supports the C7x DSP cores of the Texas Instruments
+J722S as compute accelerators, for workloads such as machine learning
+inference.
+
+Each core runs a firmware that remoteproc (Documentation/staging/remoteproc.rst)
+loads;
+the driver attaches to a core remoteproc has booted, boots one left offline, and
+resets a core through it after a fault or a timeout.  The firmware's source is
+at https://gitlab.freedesktop.org/tomeu/thames-firmware/.
+
+The driver and the firmware of a core share a block of memory reserved in the
+device tree.  It holds the core's Ring, the queue of submitted Jobs in the
+order the core runs them, and its Fence, the sequence number the firmware
+writes as each Job completes.  The driver adds an entry to the Ring and rings a
+mailbox doorbell; the firmware rings one back when the Fence moves.
+
+Each file that opens the device gets a Context: a page table the core switches
+to while it runs the Context's Jobs, so the buffers of one client are isolated
+from the others'.  A buffer is created without a mapping and bound into the
+Context at a DSP address the client chooses.
+
+A Job is created once from a program, its parameters and the transfers the
+core's DMA unit performs around it, and is checked then.  It can then be
+submitted any number of times, in arrays of Jobs that run in order and signal
+sync objects when they finish; the call waits on no sync object, the fences of
+the listed buffers order the work.  The drm-gpu-scheduler spreads the
+submissions over the cores.  A Job that faults leaves a fault record, which
+userspace reads with a query; the capability query returns the sizes and
+addresses userspace compiles against.
+
+Everything else is done in userspace, as a Gallium driver (also called thames)
+that is part of the Mesa3D project: https://docs.mesa3d.org/teflon.html
+
+The interface is described in ``include/uapi/drm/thames_accel.h``.
+
+.. kernel-doc:: include/uapi/drm/thames_accel.h
+   :doc: Terms
+
+Hardware currently supported:
+
+* J722S
diff --git a/MAINTAINERS b/MAINTAINERS
index c63ab2d77b01..dce817531184 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8024,6 +8024,7 @@ M:	Tomeu Vizoso <tomeu@tomeuvizoso.net>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/accel/thames/
 F:	drivers/accel/thames/
 F:	include/uapi/drm/thames_accel.h
 

-- 
2.54.0

