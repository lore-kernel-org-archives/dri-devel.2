Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69536082BD7
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=0wkqtW/M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45F510FC36;
	Wed,  4 Nov 2026 14:16:00 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEBE210FC3D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:15:53 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKSCX3X7HzKmSs;
 Wed, 04 Nov 2026 15:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793801752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtARmKugIQb+7L25cEk3dwin99E1zGAgqgjVr3BvYFM=;
 b=0wkqtW/MQjNfmmaCrI/NKKDd7SrLdD5okc+3APAIMfyU1Vk75/kjp4dx4YAl83AwtyGQ2l
 zD2+UUSP8sxXicB7tBjP5lu+y5B9hyBBXymZnd/MNnSjWmF89SquKKxRWS1v3D/WG3SVqq
 pfBll66qAhQyXmCD/r+5oj83Pz5cy35o7wJk4gzy5ONtGVHib/UnKzIlZ+P/p7pmOaj/64
 Mj1Dew28dvty8rBriJ0O0RlSylB0Bj1ELdxzc0zfVdqqfVHGGcMdFX8h0T/FJYxj+/taYg
 UZGCT55uzGGXhgml+J4/xug9P76rwzpKX99mvzPfipi5YlstGruvHzIrTfF99w==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
Date: Mon,  2 Nov 2026 10:17:54 +0000
Subject: [PATCH 1/5] drm/amd/display: Render the panel power savings kernel-doc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-abm-sysfs-commit-v1-1-e5addfd9539a@hsal.es>
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
In-Reply-To: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, harry.wentland@amd.com
Cc: Hugo Sales <hugo@hsal.es>, airlied@gmail.com, 
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
 christian.koenig@amd.com, simona@ffwll.ch, linux-doc@vger.kernel.org, 
 bhawanpreet.lakha@amd.com, ivan.lipski@amd.com, 
 dri-devel@lists.freedesktop.org, ray.wu@amd.com, alex.hung@amd.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=hugo@hsal.es;
 h=from:subject:message-id; bh=FVHKsTcB+kzVbQ+9zevb2MG6df7WbrsHz6OXzX6yqvM=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4khzmcze1q+fFU/NzGfeUNNfpz+FN3XLZZqGntd
 SzumTHja/eOUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmEgrC8Nfke2Lk5cm7JHx
 E+yr9dl/IM5repLL++adFgtDI7gzxRnPMzKsMvgsrqe59dmMT5Orf8o2Bm9yT7i7Y9ey5ZNrd79
 MXH6ZCwBNfEr8
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Rspamd-Queue-Id: 4jKSCX3X7HzKmSs
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_48_96,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DOC section for the panel_power_savings sysfs file is not included
in any rst file, so it never shows up in the built documentation. Add it
to the Display Properties section next to the 'adaptive backlight
modulation' property it interacts with

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/gpu/amdgpu/display/display-manager.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gpu/amdgpu/display/display-manager.rst b/Documentation/gpu/amdgpu/display/display-manager.rst
index f6de9e7779e29..ca4a956d2aa17 100644
--- a/Documentation/gpu/amdgpu/display/display-manager.rst
+++ b/Documentation/gpu/amdgpu/display/display-manager.rst
@@ -187,3 +187,6 @@ Display Properties
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
    :doc: property for adaptive backlight modulation
+
+.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+   :doc: panel power savings

-- 
2.56.0

