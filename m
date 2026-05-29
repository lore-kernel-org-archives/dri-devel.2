Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901FCCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004ED10F975;
	Fri, 29 May 2026 06:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="bM8oqX+m";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06E510F975;
 Fri, 29 May 2026 06:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780036497; x=1780641297; i=natalie.vock@gmx.de;
 bh=EPoM/bGKRx+EAZy54i/ajOwXnKH1NW0h8ot5mRJFek0=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bM8oqX+mZm12Cct9Jy4+hWuiZK02HiD1EzpRn8aVGSyViWc1Vs2PcsTjOzjnQxaC
 XKhcVqEhv2b5eHJJ8NnYKtUEfYRxV3h//WkOv4/GpUXZ2cPC5C+kmbXEnfAVumjqf
 +PNrGnQZXrd9Rl8+tUebpsyCxONcJRLR0OuA3YPjPCjhQqBkqtiGT52DqVabBVdZg
 tJmdA3xARNO/v70WW2LDytHYM6wAsq02NWJPWBJgBgz1WAWZnc/x/trhFRp7XkT4O
 3xCMTtYDF1KtrxN+8i7GzHbcGUlK2vLBs9QOprsxNHQWj4QxPT9+5ZrWn4/aJqKmJ
 I8h4/WfFWThLAhXd/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1wXTFK134t-003Jvl; Fri, 29
 May 2026 08:34:57 +0200
From: Natalie Vock <natalie.vock@gmx.de>
Date: Fri, 29 May 2026 08:34:40 +0200
Subject: [PATCH 3/3] drm/amdgpu: Bump minor version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260529-prt-explicit-sync-v1-3-9f1c60955cab@gmx.de>
References: <20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de>
In-Reply-To: <20260529-prt-explicit-sync-v1-0-9f1c60955cab@gmx.de>
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Provags-ID: V03:K1:l8NjjEwb3NB3hrnZ8FqjFZfhPpyYbfXfoEnT/5oYRu8EEtD/ar/
 y+c+dAdaNNmbGnBVw1PPqmC+aqzMbYbWrhRyW6EDoMoYwSusvWZZvYAULXf3LlnAXp1XVk/
 aJqJp5zRQvS/079P2yjOqr/h6KPgutddiKdwFMBvyA+OwBdV5p8Gtff0zW7s6wH4h1D5KaJ
 fS3V+vaVMm8jj7vjC6+sQ==
UI-OutboundReport: notjunk:1;M01:P0:E3llLmWLHVA=;f1NgEZVjf1Z1W3qZNMPSU7g+29f
 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
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

To signal availability of explicit PRT sync to userspace.

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
index 1781c0c3d010f..f3b86fa4b181e 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -127,9 +127,10 @@
  * - 3.62.0 - Add AMDGPU_IDS_FLAGS_MODE_PF, AMDGPU_IDS_FLAGS_MODE_VF & AM=
DGPU_IDS_FLAGS_MODE_PT
  * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
  * - 3.64.0 - Userq IP support query
+ * - 3.65.0 - VM PRT explicit sync
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	64
+#define KMS_DRIVER_MINOR	65
 #define KMS_DRIVER_PATCHLEVEL	0
=20
 /*

=2D-=20
2.54.0

