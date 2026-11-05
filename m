Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEF3606D805
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TKpnwBlx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED47B112780;
	Thu,  5 Nov 2026 15:31:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A08711278C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:31:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE93F601DE;
 Thu,  5 Nov 2026 15:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3AD1F000C1;
 Thu,  5 Nov 2026 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892711;
 bh=0TSSQ89yrgXwRa3JQy5A2XijRV8k7glzSjepBtT0NU4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TKpnwBlxa67b+u8oj/lmVHfgUcRgDq5YffCti541wUr/sLKMbqBCaLrxI7jJa8ddq
 8rpvQKoGbNTAQFUdZhetZLPIQkMdcbknDBiI5MeR9bk5gRmVSoll5OR97JjvepeS8d
 pf4x+Px6gQ7tCLS+PnClKuVWuLXIR/ZwQnYVRkkj0pm71XmT+JDGt7zZIXgJOwDJh3
 tpx8CpCjnDpa171pZPC7LejTMd42+KlhQQU1ksVLQoWtAP2sMisUym+PeaczXXiey5
 QBpjE/kU0jURTwCS/WAvV9FMM1Q9mFcX+slyzNR+h+XbA/u/FRtx57ml9frLIglVb8
 bMLdvew3i8f5g==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:36 +0100
Subject: [PATCH RESEND 27/83] drm/mgag200: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-27-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5822; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1X8bjqsJObLD2q/8ddAAbHm5lyX6VAbmxjOGAJw/KyI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFry8XDJj5XvThXM3+SmyFYXLLVt48UzGlLBHNu4v1
 0sKpE1/1zGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAm8uoNY8PB5Au3PRZucbgQ
 7Xtx2znJlbsWKF1dEsz96Bz7NCan6Yd2nljoOeWnU8Hfz4nsmvP/5fowNqx4uWi9T+V8ljfCkjf
 qX+pY3Nn1s8r0XMaMRYeXiEpwX2+vjni56Eb2A+mNK2L1Z9z/sA4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_g200.c    | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh.c  | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200eh5.c | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200er.c  | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c  | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200se.c  | 4 +++-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c  | 4 +++-
 9 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200.c b/drivers/gpu/drm/mgag200/mgag200_g200.c
index 9e6b4618fadd..d4788cdf64d7 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200.c
@@ -402,5 +402,7 @@ struct mga_device *mgag200_g200_device_create(struct pci_dev *pdev, const struct
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
index e64bfeafbefc..b6ef287c05da 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
@@ -274,5 +274,7 @@ struct mga_device *mgag200_g200eh_device_create(struct pci_dev *pdev, const stru
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
index 183b7676ea6a..973770ee941a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
@@ -179,5 +179,7 @@ struct mga_device *mgag200_g200eh3_device_create(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
index dc375c055b0e..0241244bd3f5 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
@@ -199,5 +199,7 @@ struct mga_device *mgag200_g200eh5_device_create(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
index 205678a57bfe..df83857b9634 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
@@ -307,5 +307,7 @@ struct mga_device *mgag200_g200er_device_create(struct pci_dev *pdev, const stru
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
index d60693ac0749..82ee58b3faab 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
@@ -312,5 +312,7 @@ struct mga_device *mgag200_g200ev_device_create(struct pci_dev *pdev, const stru
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
index 9c14d0eb66bc..19c6a65e8621 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
@@ -197,5 +197,7 @@ struct mga_device *mgag200_g200ew3_device_create(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 349ec36f6d49..937bceb8309f 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -519,5 +519,7 @@ struct mga_device *mgag200_g200se_device_create(struct pci_dev *pdev, const stru
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
index f65d4238422f..92e4cd9ef50e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
@@ -321,5 +321,7 @@ struct mga_device *mgag200_g200wb_device_create(struct pci_dev *pdev, const stru
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 

-- 
2.55.0

