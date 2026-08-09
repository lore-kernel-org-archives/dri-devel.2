Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0DFC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B220310E698;
	Mon, 10 Aug 2026 06:38:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkL6uj6M";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D0110E15F
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 14:46:32 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbe3fed2f58so748060a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786286792; x=1786891592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=hkL6uj6MsJhEsfs3r8LZT/l26kWfIpf2b3TIxtfsqTdy+i07j2fF+FQR5tyoAnVoIx
 8LJATsn8doFF5MQR22xbSX/WWy/f1RgAqNEeUINNdmjJvTINdrx+zgMBFbjuryImPEp2
 BJh0Ch5sa9SfpH8Am4YM3CDvM2viBdmn1Fe34E6dUxVmCycJ9gneV+WT7IlZrREqcduv
 q8ibZOLWvfEOGHS9aFl6YMs8i7iB5ukFwF3WiQlRjPvnpYIvuExZfVw96OdUJFk5A1cg
 TH7ckOTATAGzhnpzAeWLKhKr6LLdHlJ+Bba0WlMrEa0nxfCGZO/HhMlgftflnAVuB0PC
 szTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786286792; x=1786891592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=A3BeIAtfJ2/omVu82I5VMk45uIa8CTiHrIT/44X40ds=;
 b=NyC7zeV/43ilGdB3xn6m3men5jfZMDSYpa8Om6difdXd/5WR8Rx5eJDqCm4Asl1t2l
 NVZo8MIYMJa0ezYsEx+ABTWqGnCv7VmtQMRp76j00JG64Xzu82bbUk+BXKiD1rpnBWZt
 voeN0g3sw6GiknIt6P+qTIK91lJxCkUjc94l/bQiH9Apn0uC7rroYUDlDeNSPuXKUxGN
 nD7LE1AzShHARPQEpxHjyTOxfRUx9mKcGqcz9o+ZtqAgAgG8bhzKRV1U00xxhncDJVS1
 7lIbmEks7iEg5fMfeS4HfPkiCnw2z+i5jen/AKeezKfI64r1tfh/ZypXrM265nMEgjqY
 IlHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrG0yPoUViolcl6H4F+TAOu1gBGmEoZ+GaXOSk9J0Gq+vi6W2vmCNHWlIN1RsXcfuMvdfF0q60SPKI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxgi8mQjcZqU4r6CKomb46lf3YWagjWJet/5aFGMOvniazOrRoO
 ITt7hDq6d1QZYI9e3q+ds6z4cnhjr47g6k/KeJnH8ymXHVIHyz43REq6
X-Gm-Gg: AR+sD13CvLhgTzeY0rQnCSJ26sffUNwf1aDPF1Zhxbtwkt/zy3VslNLQ9XMfs+kKx1E
 iEuq0e+N7NAgyB2ikdwpvJwpBXpG9ANIE5FWNqreg6GUwJHQx3pN93eckK9urJIwA1jAqOJk2Ru
 awnKm8P/84GtO1TebBLFT9/BdZ1girDhnXZm++RwVEXrgBBre490/mKWi75VG4ZfO3qyoW0CCWC
 HfdOMYfCoJ8tKIqbi8tDYbNI+6LuzF71PKS8BOIMguuNRJIa8JVac+u6tdwQierLhuzwQJPy/hQ
 aapgem8BCIFl0CB5SkxrIJSCnTwMJzNw+NW8GHitU7UDUe8wMLmHRNOdo2KSgDZB30ZTMtfGkaI
 20rr2tOSF9KelbClXN82zO4xRzHlX7avPxuOrEvXXpQC1Q1dthveRIE1g5mUQB76Gndd2mODM3q
 NYpaSUVqOUYm/vqH8bx+wex0NG6N/o5qIhWRzhjslqm8MuC8JQyzoCC9L7tp4vW2bMibsTPn/F4
 w2pOzb0tCofPjuTmOt2BFs=
X-Received: by 2002:a05:6a20:914b:b0:3c3:bbe6:95b1 with SMTP id
 adf61e73a8af0-3cb85eef9d6mr36805745637.24.1786286791895; 
 Sun, 09 Aug 2026 07:46:31 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14101b7ad29sm25911224c88.13.2026.08.09.07.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 07:46:31 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v5 1/4] drm/amdgpu/aca: Fix race condition and UAF in error
 cache logging
Date: Sun,  9 Aug 2026 14:44:48 +0000
Message-ID: <20260809144451.35431-2-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
References: <20260809144451.35431-1-sreekuttan2156239@gmail.com>
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

