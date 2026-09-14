Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A6DC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 05:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84AA10EB44;
	Mon, 14 Sep 2026 05:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LLZto3IQ";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9490810EB44
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 05:47:27 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-486fa798933so950874f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789364846; x=1789969646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rjb+OYWz+/bKaY6AiNvmi3TeWvwlpKbGSDH/yB8xs0k=;
 b=LLZto3IQ0QFExUHxE6dboM1CfajU5828xlFT2KMrMA1iucaBQTqBAk2KxVy6vpuP1V
 FavuUyIO/uaVJ0/54xYPwi/Pl/zUHuFo5h3lS/CWYfaBTr3FTXHwqrDvewCTY+PczxSg
 uew8P+8acy04E8C6dwehx2S4NH9x22IUMifusDdiZBC59hWkNLgoziQVWOFwdMP5DulV
 YSvs+zmYFyaElIOg7S407YGD8MGwfqD3KoSdVzj/roJo7BTdLuFoihNNVEv/5hK1o8jR
 z6AKdh+ynkf+s8DJn1vKvA9lS1Y9DtzDjeza9hJoDLuOBgm3emHN5rHX2gTamamNkart
 9v0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364846; x=1789969646;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rjb+OYWz+/bKaY6AiNvmi3TeWvwlpKbGSDH/yB8xs0k=;
 b=BxQ5eCnuWba96oU4es7NeUEJBauHYjPZXOXfNQ9HjZWKHkSVbNUB+A06mqpfn20xlZ
 YdTN535GoT+x0g/qbzSHGV0P0uTZtmxqsbW9TWV4iYqYGGD0xJCGcW6V241IRu32HAGT
 7XAF4P46CEbehbR5AP4cd5YDMDhw4ZDCsWFHhKG9ecn4uu83QQotLhBtjclaWNpxFSHQ
 viXUml+WyN5oEWImHZ5eJ7ePTpiy1GSSRP1Ew+TkaoQR9yFkVWudyRsumGqCxGl4cIok
 Gw+Dmz8IKGNOVidM65byndOIP8mzGNcl4lnCP2qZqirsvORSaWBunsAeNvknVv7mw/9E
 klLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfgv9iMCFuziySA9bdqtMwcOHu23WNnGiVL+F1+++q1yBOzWjvq0RRBTbd86H6sSrxCwp5GgTBUJc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8y41X9n3uk1eWfGQugbZRHgVV/q7PMSk2PBW+LLHNl3DId3JD
 swxFDBxbtxjoBYao+1GOrVbXqPgvqWZG5ZfzFnbcYMYSyhAM4qkcPCmu
X-Gm-Gg: AYBFou1MTdK7Qdl8jJhkkkRvVI+lD7ONbWawE12ms+nm3g9otAST5XPhg4wiDyBACuf
 Xh8lOmaESsxV7SsSgMYjjd0TtspHjhvre1LksNmxMEjhSwUhrtaLQREhz913j9JMeiVvJeCWI8y
 VkwSy4JHDPtLn6RfWmGPbiq0uSDnrtm6uaONKeLlhuR+zSVQhpJfRipwYJD7AuzQ8UqENlpWpLv
 9Pn4hfoFgaLpwU9dlXf2X5T+E4g5/VFNH6Pl5JYgXr33prulWyxtSgNAHy7RANWJyRg/vsW1S6+
 Yad10ybEdi28BGI4geGpH9wMrX9Vm/epX6vySMsshcbtZJ6IiH64SGDWmTp/2MMvYl4/fCtmTxd
 zPcRX5ZowvDbgZYFZY2bDYeIwUmKIlb1FMliT4QjLlrjs2VTV1Alt4tzto0PSKck7pQBw/G9oH1
 rMUUThqkRsLzbow2rTNtmN02tqXqStIzTaUS0wDllWmmlnvZuBsH0PCSQDJ8AVBq/71KBBBSamO
 cc/kRmGOv9A8l1EGOVDz8o9j9ZKhyrLiIg7EfdCEbA1VNVxHrOdu2/wVc+DQ3xgD5r+1dzccpoJ
 Fc1nPoaaK0Jacj6kIjThVwfX5lVR9ds=
X-Received: by 2002:a05:6000:288e:b0:485:8c16:5efc with SMTP id
 ffacd0b85a97d-48702b31ab6mr934116f8f.54.1789364845667; 
 Sun, 13 Sep 2026 22:47:25 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm22609515f8f.10.2026.09.13.22.47.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 13 Sep 2026 22:47:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Mukul Joshi <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: Initialize UALink handle uniqueness state
Date: Mon, 14 Sep 2026 07:46:04 +0200
Message-Id: <20260914054604.12850-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

amdgpu_generate_ualink_handle() continues when handle_lo is zero. For
accelerator ID 0, the random value can become zero after the low 10 bits
are cleared. This path reaches while (!unique) without assigning unique.

Clang's -Wconditional-uninitialized reports the read. A reduced
MemorySanitizer test reports use-of-uninitialized-value at the loop
condition.

If the uninitialized value ends the loop, handle 0 is inserted into
exp_xa while robj->ualink_handle_lo still says that the BO has no handle.
A later export can create another entry for the same BO.

Initialize unique to false so the zero-handle path repeats the loop.

Fixes: c67cb19811ec ("drm/amdgpu: Implement UALink handle export")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ab56420..c6b7122 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1819,7 +1819,7 @@ static void amdgpu_ualink_npa_mm_fini(struct amdgpu_device *adev)
 static void amdgpu_generate_ualink_handle(struct amdgpu_device *adev,
 				   struct amdgpu_ualink_handle *handle)
 {
-	bool unique;
+	bool unique = false;
 
 	do {
 		handle->handle_lo = get_random_u64();
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.53.0

