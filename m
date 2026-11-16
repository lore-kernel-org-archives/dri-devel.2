Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EF606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8R0D1Jk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2942810EE16;
	Mon, 16 Nov 2026 10:32:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B480310ED7C
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B255628C1;
 Mon, 16 Nov 2026 10:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556471F000C5;
 Mon, 16 Nov 2026 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825118;
 bh=UC/SrA/tC7Pwu8E3xBEUpm72k/jU347FcGuaZSqzLGM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=b8R0D1Jks0TzIeM1BApaMwlLEbJf/Tp7ECdGEKvGFnqZM72qoH6YNP05ONtNMTHrf
 oxAxuEdeTnaqf4lWAjSDnQrf1V/zUUR3j3gbw3sZpAgLjajjK5VNws07Dq9QLOy7tR
 y1WZfaw0UkJK56w8nqqvwjSHfYx/4L9iNKGanKskqJrSxcn70swU8azp52f99krZq7
 iCoFWgVrL74CJ7mZyip+f2xcdeO9UyMTZJn/UPlzyJsqRx5klyR5LPIk4VKHGDU++B
 Tly7FIVrs6dDVTVZpUyk0aJbqMT1rxRMTny1TU1pd5cpIlq+1Yq7NxXfFQVuJE5wCE
 +pNJXPf9G0YHA==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:35 +0100
Subject: [PATCH v2 19/64] drm/mgag200: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-19-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6561; i=mripard@kernel.org;
 h=from:subject:message-id; bh=o1sAv4nOzQZYRzdu01ISuMNxVt0ZuQKk9jyCbw9nL9w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bns4ubyIfbmWiWWRZtq9BnmmDLOvBRf+2IhvEWpoq
 00/GqzWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYyp56x4Yqdrfud83fLRWam
 BP3ZsvyL9nTOjbMzd2vNYV3oKlK2bKnYmm6vl5GnbtebVE264xFxiLHhytU/86rL2CO96lb+WDz
 B0crAf5ub6rVror6vmT7zt25Q1g+r9n7kaD6nIKAw4OUulikA
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
@@ -399,10 +399,12 @@ struct mga_device *mgag200_g200_device_create(struct pci_dev *pdev, const struct
 
 	ret = mgag200_g200_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
index e64bfeafbefc..b6ef287c05da 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
@@ -271,10 +271,12 @@ struct mga_device *mgag200_g200eh_device_create(struct pci_dev *pdev, const stru
 
 	ret = mgag200_g200eh_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
index 183b7676ea6a..973770ee941a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
@@ -176,10 +176,12 @@ struct mga_device *mgag200_g200eh3_device_create(struct pci_dev *pdev,
 
 	ret = mgag200_g200eh3_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
index dc375c055b0e..0241244bd3f5 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh5.c
@@ -196,10 +196,12 @@ struct mga_device *mgag200_g200eh5_device_create(struct pci_dev *pdev,
 
 	ret = mgag200_g200eh5_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
index 205678a57bfe..df83857b9634 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
@@ -304,10 +304,12 @@ struct mga_device *mgag200_g200er_device_create(struct pci_dev *pdev, const stru
 
 	ret = mgag200_g200er_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
index d60693ac0749..82ee58b3faab 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
@@ -309,10 +309,12 @@ struct mga_device *mgag200_g200ev_device_create(struct pci_dev *pdev, const stru
 
 	ret = mgag200_g200ev_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
index 9c14d0eb66bc..19c6a65e8621 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
@@ -194,10 +194,12 @@ struct mga_device *mgag200_g200ew3_device_create(struct pci_dev *pdev,
 
 	ret = mgag200_g200ew3_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 349ec36f6d49..937bceb8309f 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -516,10 +516,12 @@ struct mga_device *mgag200_g200se_device_create(struct pci_dev *pdev, const stru
 
 	ret = mgag200_g200se_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
index f65d4238422f..92e4cd9ef50e 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
@@ -318,10 +318,12 @@ struct mga_device *mgag200_g200wb_device_create(struct pci_dev *pdev, const stru
 
 	ret = mgag200_g200wb_pipeline_init(mdev);
 	if (ret)
 		return ERR_PTR(ret);
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ERR_PTR(ret);
 	drm_kms_helper_poll_init(dev);
 
 	return mdev;
 }

-- 
2.56.1

