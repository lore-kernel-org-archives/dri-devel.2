Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904BEC88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B2E10EE3B;
	Mon, 14 Sep 2026 13:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YZqDZe92";
	dkim-atps=neutral
Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74F210EBCA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:41:01 +0000 (UTC)
Received: by mail-lr2-f3.google.com with SMTP id
 38308e7fff4ca-3a4f7261b56so18862391fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789371660; x=1789976460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cpZ8aiz1nJMHc4s8HTwIf+eLIqHawFVPZ8yiJXV3xqE=;
 b=YZqDZe922zN+fJ0EqenB1tnRHEjz/ps0TEnhAX2UlZDVpvSMW0Ye5jx5NtSWCCqg6Q
 Wf8jANqYzO/7Qwbnzlz6tGJK8lpBbg53YxH7XOcVWn9O5dMPEr1BhC/bziMcr5gfdsVn
 3Mx0UZhdYUpnMgm7lsFvh67QjWElB4IYUcXI0X4Pz5HIJDM6hoVDMQWGcczzptavLm5S
 T7GufA/tHUTrbNmt+DWCmeKnhMkU7zPVHlOIE/pzp3pHaf9sseULktIace+qaCa5Irbl
 B/Sap2wsQ2EWBqd28PukC+Ym9qtRO/Ccsj218bkVsnqI3fJNyE4YFVNNJE1VL48pLxII
 DA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789371660; x=1789976460;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cpZ8aiz1nJMHc4s8HTwIf+eLIqHawFVPZ8yiJXV3xqE=;
 b=Mj/GKM5xBFLBsmJSs+dPwAEXW2/V8/XQK2c99ZBxV+NeckjKjrenvW3iRZuA8GMEpb
 OBakd+hWlxM4kSAK/aRN5k3M81xRzljUz0jFwpwefXRT+ZWStTIBwHn+n5+2LOyBvZyd
 +a+teZdrjSRhGJJWDEmoteEOOWa2J/gzfXuRIGaCqVtg+fnqX5XxipjCdD2y181vueLm
 cnpqFJh37Ve1ox7k7eEQwldkdRmj347qD/OvcFv1SWCu9XYsuOomZC67TiANsI5Ye/42
 YacLSWlHawoXdnRaOzssE/uXXZPj1bXTVqASmlwK+GqIxcxVVxFgWu12uKu4M/d4UW3p
 mAJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx25YaqekSqV4N22U7yYVdJeO5t8Y8yoqy1JPui3pzqsvDykIdaX7pnH0vxKtqWEdipmh1nxggFdSE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m2aEu6P6mzwtMeIpRBL0KZcuAcDoAV+FXsx3Ph+FlAs3+peVU0
 YabVzIUic5yK5GaK27iiNoBr1NpKttQTzYN/BfZzKZmQsoxr5T3jl5uH
X-Gm-Gg: AYBFou1K0qqyZvBV1DAxkrgGk0SAKoqB8mtawstwAloR12d0QFZrJKaVn0ruMsfwTKb
 0ZogHSIGdVbDbaS7Mj7Z6wVgJYRGGpP+jwYCmDBCQMbVywMBO3ObQobsY55UceGv7SvTFJzt1FO
 SGuvpzBIj2I4VC3qpyx/f0X4fuoQvpGDgJK+xKVOJAj/WlaxGqFtU3GvZC2hxz6R+O+Aqi7zeD+
 D4ivYedqt1Ax1jVp5zVx3m64p2OivNmL42TUfciyCiI1BnuXOsPm98YLZ/NYqgAJCwJNKF3W2LJ
 78SyQ3TbMC35GK/VQtj3n7jZDXF+JkTSi9xJPo+rssMpO65kxH9Tso8slPYrYLWD4QQQr1Sqhwf
 uzQs0ObrwUQvQboAb47f+dFTfanrNwzLyCnwwuk6O0pX01DAi/5wJ+2FIf0ZtQgEmtHoGW24eAG
 6lImTk5cusa2buuM7nnrBl81u73tJVjR0UydeKLpC3C/JshhlPzoPmOB6J3PQJLdw5X2+CihfkA
 vW2DanWHuqOdRSG
X-Received: by 2002:a05:6512:1053:b0:5b8:ab9a:1e97 with SMTP id
 2adb3069b0e04-5b8ae6b660dmr352514e87.57.1789371659553; 
 Mon, 14 Sep 2026 00:40:59 -0700 (PDT)
Received: from localhost.localdomain ([78.40.184.2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a045726fsm2241169e87.20.2026.09.14.00.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 00:40:59 -0700 (PDT)
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
Subject: [PATCH 5.10] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
Date: Mon, 14 Sep 2026 10:40:47 +0300
Message-ID: <20260914074050.10384-1-roman.demidov.nn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:10:56 +0000
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
Backport fix for BDU:2026-01386

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

