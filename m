Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A2EC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F46310EAA8;
	Wed, 16 Sep 2026 12:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rSdSSWlY";
	dkim-atps=neutral
Received: from mail-ed2-f4.google.com (mail-ed2-f4.google.com [74.125.228.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A3E10EA97
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:49:39 +0000 (UTC)
Received: by mail-ed2-f4.google.com with SMTP id
 4fb4d7f45d1cf-6a9988c6449so2756072a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789562978; x=1790167778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IP+zMj/7tZqqAbs+ICnN9SjIasciypQH4dlBRvF1XM4=;
 b=rSdSSWlYFKkPoway49pqCzEuhui2N2wEjsOMca1MPMd5Xa1I4glkFbszCrp31m4QgF
 qWD54dBSC7CmPW+l4YXiywu1v5mRm/WZ+KXxughMzcvyGP0dmGPVge1XpXNH7O0iJYZi
 7U+NogNCShi1TYpid8bwy++Z/NkMIsjwzPyNl3FEE5qwtC33aRRyHMYmrhK16Oii7xUr
 pMOL/KkZUpvfEn0/5PHtGzzXYVNNdDeXRf3iVlD+dDazpiFtSXx2b+lNaZBcfY+lXf5g
 7ecQ3XpZQ1NJAhogg+cOAV9/t4HjpZcpr9jkxEyDnfeEVphablCV2OwNin6IV4tN+fQO
 1kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562978; x=1790167778;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IP+zMj/7tZqqAbs+ICnN9SjIasciypQH4dlBRvF1XM4=;
 b=zsuXt+9FBRewmEwewY+ZDHQyyAnrcyoeFi6A3yJD9PjKJXzBY8BWAbI89WpQ/owkhH
 vLciMhp8z4+Y4xzjm8tpmJTWpoSojqAj8xzE0IJ7Nbh+WU1J23NN4RCc9ULkGh2tnQoY
 dN2+KI2971d1IetGlTEPlMFkyGzJdEl0qi2QfEPxs8Xn9qw3xPOVbPI/NvV3/3uxpOmN
 mZ3rKfVPsm+4BCF+MPKs5HUNdH0BEJrR7rQUWGWDdugvc2EkdMBtLUFrlhQXafX74prt
 zN3ZbRIz4xSrw9PzWnGBgzgwTiX+8zbTqWZGpQUWxjdGFsMVf9PApH5plfNkrAin2Q7s
 uTaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP+lo6p1udLi4tqfcgpLm4mK92CIa+ik+3QarUTxB5q4Ht68j5IQfA/HqKw8m9/61N45K+0RVnaF4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kAy+PWGlHkLsX9u2VvlU80PjGHvnj6fYrlZB37yn7JYueJYgIQ
 zYZTPcHKZipgs4Qxjd9t606mFhTwYg8k6EzinvBOZYZoCcf5SeY+1Yhh
X-Gm-Gg: AYBFou2qY9o62zOzs8UbpmIHi+RIO3ECoZVeh9DGnR5YYWUIMe5SLYrL/1Zdq0ndj4B
 F2/HhDm66nfNlGX0xmMqRR0U8pBpz9uTn9DPDjsOkt+yXByPY+JgIFwKvpiAvby5rgnDRY3n5zQ
 mgXdwJdb4IaqXhz3QIx+LW3I2/KO5LnwzTQCbXmiA19VcKllhEQBTiWXcTzwA7Q3r+PMFcoUY9q
 8w4MBs7sc78Y/OzVqM7EEAQrrTg7hGv6Sb1VND+AOUQ8Q9OljdtSgHqe9wAAXZikMfU7rWwPAVk
 zmVRm6AxWcTESSW/EdGls+ioLYwvjUA8cp+NRsulW+kFzODG4CZO2GSdOXS80haivL9lOu7MC29
 PBVou55B4T/9aikDA/kxcT5K7SuxUoOWG6K0XOT5TLf4tuTrlaQHUKIKqG2Sw1u2N+BnLDDxC8M
 ReJShRdLrh3YdXQuKk7EnQ4tL6g3O6PWAvYrge18ZMLniV052SYz5Ua/BAf2sRphIxrr2ylut6w
 VWchTua/fzt21mK
X-Received: by 2002:a05:6402:21cf:b0:6a9:b523:375b with SMTP id
 4fb4d7f45d1cf-6aa22358ffamr3948276a12.6.1789562978036; 
 Wed, 16 Sep 2026 05:49:38 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d27ad36sm1543017a12.21.2026.09.16.05.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:49:37 -0700 (PDT)
From: Roman Demidov <roman.demidov.nn@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roman Demidov <roman.demidov.nn@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sasha Levin <sashal@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Candice Li <candice.li@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Junrui Luo <moonafterrain@outlook.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, hackyzh002 <hackyzh002@gmail.com>
Subject: [PATCH 5.10/5.15 v2] drm/amdgpu: Fix integer overflow in
 amdgpu_cs_pass1
Date: Wed, 16 Sep 2026 15:49:19 +0300
Message-ID: <20260916124922.189809-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: hackyzh002 <hackyzh002@gmail.com>

commit 87c2213e85bd81e4a9a4d0880c256568794ae388 upstream.

The type of size is unsigned int, if size is 0x40000000, there will
be an integer overflow, size will be zero after size *= sizeof(uint32_t),
will cause uninitialized memory to be referenced later.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Demidov <roman.demidov.nn@gmail.com>
---
Backport fix for CVE-2023-53707
v2: Include version 5.15 in the patch.

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index addeda42339f..4e20daa34305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -100,7 +100,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	struct amdgpu_vm *vm = &fpriv->vm;
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
-	unsigned size, num_ibs = 0;
+	size_t size;
+	unsigned int num_ibs = 0;
 	uint32_t uf_offset = 0;
 	int i;
 	int ret;
-- 
2.53.0

