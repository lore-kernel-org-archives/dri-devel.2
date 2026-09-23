Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476E1C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:28:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 892F310E93E;
	Wed, 23 Sep 2026 16:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRpWzDA7";
	dkim-atps=neutral
Received: from mail-dl2-f39.google.com (mail-dl2-f39.google.com
 [74.125.229.167])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18E410E93E
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:28:54 +0000 (UTC)
Received: by mail-dl2-f39.google.com with SMTP id
 a92af1059eb24-1438cb9b3a3so1179933c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790180934; x=1790785734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
 b=bRpWzDA7n12g0D4rLy7fGRxlA5wUrNs8OOxrH41hOplYyZAY/HFpvk9Tc61DYwBNRf
 vOq7BzuWY0Om+apv2reB6QS7OIbPMCI3V5PR1GZxuZfrjyo/MqI0jCsEFjSwtR+g6srG
 wJyluzqzJEDuvBwGIOOw9KBv/lcB+X54rK9d7+kXdtyC67YDdo9BvkuxaAKCbGRLFfUp
 Xa0mLZDASkZumAeDwK9oqFxIjunW8sey9hIrMx9vWEQpTQwEVZlUpC9VOo/yUoNYiO1n
 cZ6tduMxPA2Iwi2PsCYM5jLCm/gXhbd0sKApYRZvWDuSg3ipyXUb8BqPKXJS4wWMNVIU
 4fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180934; x=1790785734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iB3sCFIdT441Ve5Xr6bVNZSuT6o8nHC9HcOE4t6cLwY=;
 b=B4OGSESQU7ARobON7UniRugo19GN3NJwQhBLI3ofiYyWimxyX6E2WOkwu+ZcKOMrHi
 VOg7eZCH21aDw2OABNM3lDSD8gcP0hAQTEhPS9qByXxN4YxmXbWJZAoqw3JsfUYyNICG
 IAOVlO3l3gsuVT8RJR20vlRTQKXXo95o1bGRhVE9lKx4hUtfpYBKHkpfLOPhg/CGFSet
 i+aDU9KUOCApJ6I4OzNbA5iNsy9a2s5coWqIuR306igVizEyK9L0SNW2RMyDoDxMvIF/
 nYGWjCQ2403ET/uINYhxJON+JWTt9nqCTvG325SHrvNhxlLJl5hPEHpMJ/pXSunVfuus
 0JhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBymWTieu+NpJO3SqtbH43yy/7haCbqb/Wz5cuzEAABYdQToOGNWfbZZHrqcP7dtpDr1/3yocgKQrs0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kOMWei/TMgyRYmCiJNDdX5GVnmlj+NiCB/VvoR30acAP59THug
 EYEXbYcxOK6gafKQAa9pdv/fDrz8/SLhlTF21j5d0WU64VPhkzaWp9Xx
X-Gm-Gg: AYBFou0ambRYmLnDCdcUoCNvTZsJMeKjd2JYbaHrZrivVxz36EYNTHJD3mh+qHi/0h5
 wGOHb5AspLBwyWibKbFtldHUX96vl7C6/1DnxOZ4dHVK10HZ8uL99GoNrifokjyU2FopZFwhPQy
 AjvO/IS7K7tqj1rW1YdMKTp5NP27KAdctfFAEmBTHVr5WAAI8Dtn1sVR6sdvAICzhU2ZExpcJIJ
 Io3s1TqYX30zAh4lE2MqF3zIQd8WidfKHZjzLezsPL9lG/4z+e5gnML5SqW2ibMq1W/DmpP1OTG
 Vk+LppAK1SJ7YLvx3Ovnkdwu7vY0yd/dX7LY9Tkc0ySjSiAHocguGyGH5tSzJd8f21dLsvOK6FN
 IlFX+afhXB6RTclFcZulbtzLRVAEe2b7vXY6EV6Uw11kXKfYF51kPxhv31kEF7hkXDE30Qk7not
 BXh29BA4HIREnyqPN0VTT3jzVrNzIgGisRy41QhfYIpTWOz1qeWO1JSKsRg9OQWlse
X-Received: by 2002:a05:693c:2518:b0:33c:e61:e1e5 with SMTP id
 5a478bee46e88-33e8d9c95bcmr3116205eec.21.1790180932368; 
 Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
Received: from beelink.. ([187.13.30.172]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e939fd955sm7844052eec.1.2026.09.23.09.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 09:28:52 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Aldo Ariel Panzardo <qwe.aldo@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Wed, 23 Sep 2026 13:28:39 -0300
Message-ID: <20260923162839.1379927-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923163157.1354872-1-qwe.aldo@gmail.com>
References: <20260923163157.1354872-1-qwe.aldo@gmail.com>
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

atom_get_src_int() and atom_put_dst() use idx as a dword index into
the uint32_t *ps array (ctx->ps[idx]), but compare it against
ctx->ps_size which is in bytes. A malformed ATOM table operand with
idx between ps_size/4 and ps_size-1 passes the bounds check but
accesses up to 3 dwords (12 bytes) beyond the stack-allocated
parameter buffer.

For example with ps_size = 16 bytes (4 dwords), idx = 5 passes
the check (5 < 16) but ctx->ps[5] reads/writes the 6th dword at
byte offset 20, 4 bytes past the allocation.

Divide ps_size by 4 in both comparisons and in the diagnostic
messages to match the dword indexing.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add coordinate ATOMBIOS table support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
v2: also fix the pr_info() messages to print ps_size/4 (dwords)
    instead of ps_size (bytes), so the logged limit matches the
    actual check (found by Sashiko AI review).

 drivers/gpu/drm/amd/amdgpu/atom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index e0e585f..dd6c22a 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -232,10 +232,10 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 		(*ptr)++;
 		/* get_unaligned_le32 avoids unaligned accesses from atombios
 		 * tables, noticed on a DEC Alpha. */
-		if (idx < ctx->ps_size)
+		if (idx < ctx->ps_size / 4)
 			val = get_unaligned_le32((u32 *)&ctx->ps[idx]);
 		else
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 		if (print)
 			DEBUG("PS[0x%02X,0x%04X]", idx, val);
 		break;
@@ -510,8 +510,8 @@ static void atom_put_dst(atom_exec_context *ctx, int arg, uint8_t attr,
 		idx = U8(*ptr);
 		(*ptr)++;
 		DEBUG("PS[0x%02X]", idx);
-		if (idx >= ctx->ps_size) {
-			pr_info("PS index out of range: %i > %i\n", idx, ctx->ps_size);
+		if (idx >= ctx->ps_size / 4) {
+			pr_info("PS index out of range: %i >= %i\n", idx, ctx->ps_size / 4);
 			return;
 		}
 		ctx->ps[idx] = cpu_to_le32(val);
-- 
2.43.0
