Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADD4C5B56F
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAD6210E650;
	Mon, 10 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JtyYo/qM";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4331410E06A
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:23 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so496107a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223423; x=1786828223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=JtyYo/qMaVTVLQwobWbuprKNJ0N8N+x/T0ky2GQgwtmiVMFmFBdhwMRntOckXRUKQo
 HmXBWc8bx3nU+QJJfdk80U8pvHBsHpcUULlraaaqNirHfVkdrqKAGzzKNPjaWTaX2DEP
 s5J2ja+yvSczKvKcHIfXuwqZaZdBpn/aGWei8ubjJXM1QK0/y2wIMjv0evvTPjTj6ZdR
 SbsscUvBPGg9IMRtow0AeCZuPC3WblK0TF8+ZwbFtzF5T3ryknddjC3RZNoPxU6gzwT4
 Q4XbSvsT/0DLPmi0mIvTHFurRCxRCXK1UAq79ktr9H66fZI4t8u1KDMO7UyrZzDpBj9p
 lNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223423; x=1786828223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=Q9HMfwTOMQjA6lkRiDijqFuM43c+qOZC22Z257Zq/kxTxswu8iLFMhPP72m9YrDLY0
 bjYUYpMmmNpY8xZUnfrsbpgqV9dRQF4NUyYr4Z5+xpWdg8ybZ2TfRw7tkLLo/uO8G5Tt
 623JKl3T0Jo/kvThTOTFxDAI2sZOfhhcSkXRewNayr0LpwGqwVnMENjmkbJ6oTTIue1Y
 USHjwGgUQYzk462i/Ej6fKsQ+AaDV/yevYoMZGkPlDEL2PhzGz3JMFBdO3qulaPpHMlj
 fXpGLUQMcdCjuat1Ksbe5WWXLjCzL8S2lZcHmv2a2Qt83j5VN30KqFjBN5xexXGvUNod
 6PIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3eBUOWhp8uudhl0exMr/UNRrMLzcORdlqxAeAfGndrHbuFLQvUZUjR7Qzvl5TiEiLh5IBBwpQgbg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJwD+r9NAnrJhmgqqK4SWVKIrZW5yO6ooGN8bptoVAyOjD61/b
 nsIXKBV8mpzLW71HibVWOhhpCEoVQmijXL++fN8K6HFZHZudsfdmKAoD
X-Gm-Gg: AR+sD10ju0TH5MQkW7fmTulr/+c9i5Gwz6/v4IKq0bLRn+vB5P9KJeJUrBXJ53CnWBn
 JdzPOdnudBdGh4/fxwnvyhiMSCnA7800EM7Amhj/3mGxotwQPjN6quFl/6cFseL+d2v7l/3ik+a
 iGaSKo+V7jsj6lD06kQ0q2rET+PhADnC1wS7At9jeDUdHc99KeSNLpH3UPz2MnjfvH/aW9Vgl6p
 nb3qz1c2N5Rf8RyFn+DCjWBPBB93czDV03K9xPDb2dICnYPLCJIexvFZzLJigNfYpVGqN3Ri5ck
 rvRGh1Q/I+WFxKxslbSEdazfg+903nm9vCt+mAlJF5qstSSs062lQTwZ6gKNxzee0COHl1ErENY
 WjLxvnTA5bsbdHeMXthVh+9cBEN0T8oiQkdEetCzIW4gwirTXDRHXrmjpGzMpOs1CR9e0QoGTJa
 1lwMBg78k5E8fK55yKGaDH5i3khU1uGPtGZ8n6zEa84BZm40wk18n4A5J05BpoGk5LAuTTub5AE
 bL+2ibzHmQ=
X-Received: by 2002:a05:6a20:e211:b0:3c3:875d:c546 with SMTP id
 adf61e73a8af0-3cbce6cadc7mr10236790637.7.1786223422496; 
 Sat, 08 Aug 2026 14:10:22 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:22 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 1/5] drm/amdgpu/aca: Fix race condition and UAF in error cache
 logging
Date: Sat,  8 Aug 2026 21:08:48 +0000
Message-ID: <20260808210852.2938-2-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

In aca_error_cache_log_bank_error(), find_bank_error() released
aerr->lock prior to returning bank_error. This created a time-of-check
to time-of-use (TOCTOU) race window where a concurrent caller of
aca_log_aca_error() could acquire aerr->lock and free the bank_error
node via aca_bank_error_remove().

When execution returned to aca_error_cache_log_bank_error(),
incrementing bank_error->count resulted in a Use-After-Free and
potential kernel memory corruption. Additionally, bank_error->count
was updated outside mutex lock protection.

Fix this by acquiring aerr->lock at the start of
aca_error_cache_log_bank_error() and holding it continuously across
lookup, creation, and counter updates, while removing redundant
internal lock acquisitions in helper functions.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index db7858fe0c3d..d0d473082431 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -237,10 +237,8 @@ static struct aca_bank_error *new_bank_error(struct aca_error *aerr, struct aca_
 	INIT_LIST_HEAD(&bank_error->node);
 	memcpy(&bank_error->info, info, sizeof(*info));
 
-	mutex_lock(&aerr->lock);
 	list_add_tail(&bank_error->node, &aerr->list);
 	aerr->nr_errors++;
-	mutex_unlock(&aerr->lock);
 
 	return bank_error;
 }
@@ -249,22 +247,16 @@ static struct aca_bank_error *find_bank_error(struct aca_error *aerr, struct aca
 {
 	struct aca_bank_error *bank_error = NULL;
 	struct aca_bank_info *tmp_info;
-	bool found = false;
 
-	mutex_lock(&aerr->lock);
 	list_for_each_entry(bank_error, &aerr->list, node) {
 		tmp_info = &bank_error->info;
 		if (tmp_info->socket_id == info->socket_id &&
 		    tmp_info->die_id == info->die_id) {
-			found = true;
-			goto out_unlock;
+			return bank_error;
 		}
 	}
 
-out_unlock:
-	mutex_unlock(&aerr->lock);
-
-	return found ? bank_error : NULL;
+	return NULL;
 }
 
 static void aca_bank_error_remove(struct aca_error *aerr, struct aca_bank_error *bank_error)
@@ -306,11 +298,15 @@ int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_in
 		return 0;
 
 	aerr = &error_cache->errors[type];
+	mutex_lock(&aerr->lock);
 	bank_error = get_bank_error(aerr, info);
-	if (!bank_error)
+	if (!bank_error) {
+		mutex_unlock(&aerr->lock);
 		return -ENOMEM;
+	}
 
 	bank_error->count += count;
+	mutex_unlock(&aerr->lock);
 
 	return 0;
 }
-- 
2.54.0

