Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A01606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MuNWd4Ej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACE310EEAB;
	Tue, 10 Nov 2026 08:33:57 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6EA10ED21
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:13:43 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-36a315ed211so1736310eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794273223; x=1794878023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Asvo/JWf9IudVRqIRZvrwZdNjM8xuitU/qHAWd3ZeV4=;
 b=MuNWd4EjBAy2UaTZZEJTAMkd/pS8Ka2Zpqfg9VMO4a1vLd57FfGF5lWVnmXYkoo6cP
 7y675s5Vbc4NIrO2w2ynMvYVq1rTEdAkcoAtRssEDsW1Q40E531sxNxHkmu1wzLzVsCv
 BafxnXKAC/ZTPwPHYxzVGRyapsFhbvI/q01c71JayPUpIP/k+EicoT8Ri4otkj601H8D
 R8PtFvUUhscx5k3N2sUJ1sz9qA99I4yGHv44JxXtDnpot0ASiUqdG/k76AHVetM4srwQ
 WR0+J7kVI6P1PP8E563lxoYNxR61BCtjXdjQ4w4qCgTi3miC5KBrXFiIydz+OpVEj91M
 Tsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794273223; x=1794878023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Asvo/JWf9IudVRqIRZvrwZdNjM8xuitU/qHAWd3ZeV4=;
 b=NV0xLc6fXZiyE42Sl93a43M7ET8xwFB8sKXAC4UDLxDqdOg5Hu6XoglbyNHhn0SNrz
 ItvZI2gKCdHpSgi4Qwe34U67Pi5LsI35u++/hXCnjmPafnE8Nikthxn4qcmb7Rmam1YP
 qwSdosAvxFpv96PYZT/q3OJDJNdnmTr0kIkf5/pDslnzjMbDNf3CrR+0gjBqhH0LgMPe
 42QEjwZzaGOSyULh2KNeuUeo8lH51Kf0hbKlLhyomDMBFM+giRQCbHs1Fmvmd4EvNuEt
 Ki7Qi43lEgWJWczFRDI57f7qrfOuZ09JnI5o2v5Vr1An0Ui1up0fV0cTuEq+uEZIS1FF
 8O9w==
X-Forwarded-Encrypted: i=1;
 AL+hErGoJGrMta8fBO8RbDA0/bP1TH+lzQlKQBwCCh5hrupXPFtI5K4L7mhBbo83lG8mdWiBHnDA6kbUUqU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/GbeLZRY/xKpAOLAXUyNKSpiPQC3mxZgN+NIPdqSs0+ZdQWlod
 IRF4ytB+qPNQBIOLTzK6nj0rV+T0Ktq+n5Y+2A6YuZ9VSzX04hMO2XwK
X-Gm-Gg: AYBFou3/Q7i68UuAlcg06ymM4RKe7rZxAToZqdf40SVnxqcr0ldZLXFMbUGATdBDCUs
 gcNE/HjzJ24Ephu2elUbf07BuJDojzWNHx9urNymKEuDtJh3Hixh7EmcV6TtyHOZugqIbHzjI3r
 wG8moVt1fgI249OqsRJzGQhIxaY4HYHXRi+B3YkJKe34T1ItPkaGOsbJCpYYo68zABJxLs1GJQZ
 wBAilQYDEo0eDl/AnWer52xzdpA4xOKhiRG/VaM62ZfTBwq6FZztdKhhGLu7wKnWXuePImAPXPx
 AUlLfk5aV6HnsJDQPrGh+b67dbZ9i+Od0hWN7e79IfQpOPvOpXPZexl72CC+Cfc+QQmdApBCXcN
 8Dyf2ql0aEOGB9jXpWskgmHdoiWnnPy1FwPNLVBGKXosegJmOs757xAF0OzVsWxPI+cN/+oc64O
 CqxYt7NWD9ihps7dwbIpAuenZ+Pk5RBLnFbzbpz2LsmszvDtJag2uhRfRs0BkUKNzNwrezo6s5y
 vob1+U65BQH1lxBrn+05B6/xv+B15zPMk1v/+Xz+A0X7efOb4xJ7tG+KHLwpJ1ivveKXp7imvsy
 FojT7i394c8soVUZ
X-Received: by 2002:a05:693c:20ca:20b0:375:11dc:7222 with SMTP id
 5a478bee46e88-37511dc7739mr1460603eec.21.1794273222784; 
 Mon, 09 Nov 2026 17:13:42 -0800 (PST)
Received: from evangelion-g ([2a09:bac5:40e1:11cd::1c6:7])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520512b6asm2043005eec.10.2026.11.09.17.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 17:13:42 -0800 (PST)
From: Ayush <ayush37735@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ayush <ayush37735@gmail.com>
Subject: [PATCH] drm/amdgpu: fix kernel-doc in amdgpu_gfx.h
Date: Tue, 10 Nov 2026 06:42:56 +0530
Message-ID: <20261110011256.157652-1-ayush37735@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:27 +0000
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

Fix kernel-doc warnings in drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h by
adding the missing 'struct' keyword to amdgpu_rb_config, properly
formatting and aligning member documentation comments, and adding
an explicit Return: block for amdgpu_gfx_create_bitmask().

Validated with ./scripts/kernel-doc -v -none -Wall -Werror.

Signed-off-by: Ayush <ayush37735@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 31 +++++++++++--------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3..96f4e4ce2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -181,7 +181,7 @@ struct amdgpu_kiq {
 #define AMDGPU_GFX_MAX_SH_PER_SE 2
 
 /**
- * amdgpu_rb_config - Configure a single Render Backend (RB)
+ * struct amdgpu_rb_config - Configure a single Render Backend (RB)
  *
  * Bad RBs are fused off and there is a harvest register the driver reads to
  * determine which RB(s) are fused off so that the driver can configure the
@@ -191,34 +191,28 @@ struct amdgpu_kiq {
  */
 struct amdgpu_rb_config {
 	/**
-	 * @rb_backend_disable:
-	 *
-	 * The value captured from register RB_BACKEND_DISABLE indicates if the
-	 * RB backend is disabled or not.
+	 * @rb_backend_disable: The value captured from register
+	 * RB_BACKEND_DISABLE indicates if the RB backend is disabled or not.
 	 */
 	uint32_t rb_backend_disable;
 
 	/**
-	 * @user_rb_backend_disable:
-	 *
-	 * The value captured from register USER_RB_BACKEND_DISABLE indicates
-	 * if the User RB backend is disabled or not.
+	 * @user_rb_backend_disable: The value captured from register
+	 * USER_RB_BACKEND_DISABLE indicates if the User RB backend is disabled
+	 * or not.
 	 */
 	uint32_t user_rb_backend_disable;
 
 	/**
-	 * @raster_config:
-	 *
-	 * To set up all of the states, it is necessary to have two registers
-	 * to keep all of the states. This field holds the first register.
+	 * @raster_config: To set up all of the states, it is necessary to have
+	 * two registers to keep all of the states. This field holds the first
+	 * register.
 	 */
 	uint32_t raster_config;
 
 	/**
-	 * @raster_config_1:
-	 *
-	 * To set up all of the states, it is necessary to have two registers
-	 * to keep all of the states. This field holds the second register.
+	 * @raster_config_1: This field holds the second register for setting
+	 * up the raster states.
 	 */
 	uint32_t raster_config_1;
 };
@@ -587,7 +581,8 @@ struct amdgpu_gfx_ras_mem_id_entry {
  * @bit_width: length of the mask
  *
  * create a variable length bit mask.
- * Returns the bitmask.
+ *
+ * Return: The generated bitmask.
  */
 static inline u32 amdgpu_gfx_create_bitmask(u32 bit_width)
 {
-- 
2.53.0

