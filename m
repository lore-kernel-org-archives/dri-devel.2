Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A037C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF19E10E66D;
	Mon, 10 Aug 2026 06:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDC9JUiz";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ECE10E088
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:48 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso655173b3a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223448; x=1786828248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ZnZdNInXJH3ydcuEXxhiXYZkKv9ONVp9lgUwHUOreg=;
 b=jDC9JUizbBnYiWopSTp5UJIBZ4zoA2Xb+02RaWgr1JzIzy5LO9UEpYAbNGnVoC1J5W
 yEX+wozS3YdAqeLN8+tOjaEBn0bF0zpScGGZInZQw6nEPmH1eN5g8hKDVO7aunWNTH8u
 a1WvLPQ3ZLYK55xEFESwKr65P1llGSG/2TQIMVcOrGpLfVcBc0daW9FCl/YIjVZSgf4j
 xHH9WA1H3rDaOK9sbYg+ljX6r17emMd6NVb/6y7JQ2yIf52xTA/R1xF+ZX+p4Gr6C6K2
 BxzJqmqzEztQXkLkbJiEF5wbBOTlagGgt8PQDvdGKq+a092DoZXVOj4JKomadc2W4FOu
 RAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223448; x=1786828248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ZnZdNInXJH3ydcuEXxhiXYZkKv9ONVp9lgUwHUOreg=;
 b=FbmBChaj1kftwwbOebWgpCWhGM9Afx23nldAiGIfhAmYQ+j5jCaXhjhjVzgzU0dPU4
 jGnb6587XchwxMrC0lzf1+RYhkIVSmG8/NXhi1YSYgQF/JZGPrqaWNDUTTwIv6F353wW
 cK5GAX7+bEJ9v1YL71UfffnAEojsK5tL1fKdZuqUx/aDPUZhEOSimvmqBPCnqxMhFM7X
 qSsMMatlkw8qtE4+WYJDGSdzck0jbJvzqJFnNkzEu6MMIxx+pESJWLSHOay/ZD6dsBTi
 I6+jiJeYyqnMLxLDjaBaQetHdQPMi4zLYXxbiY14DznQeOUbl0A2G033mUGbJF6oim5y
 rc2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrP81KWvGqbGyNK7qFJvx3k7kOhaMHC4B8cH4SWlOXd9H2Q7zvkXqutjp/nspkpBkNNtoMHUNGr8tU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6TH3KljYpzW5XF+/kThjSwypoXnldasXt4ysSh6Tkw6pW/rBS
 jtqAxm78iMEQfTQ3WKnyj2hCkYyoNcA/C+PHCS1j0mYJoycanyeMoLnn
X-Gm-Gg: AR+sD12iXfNhhHOYgZwOaGWjlG2ISa6hZGhQ1ItDMdlD1l1n9jhYmi/uXGWkZIXuJbI
 7HX6KhQlhVWNGm8ICMI+mDbcQGcxTYINziAGotEWlC4Un0r/WDMAMRJyfnkqo6hgvz6kQ5N6j++
 euQvTdosVg1nrS51yt8hzqTBVbp5dEW4Ri6u018fjhvyGz4g1xp9+lItmiiVYJzAlk6ZA9J6l/s
 PRcv5GS0z56CrZoS/mQjpbnioxB+W9ThzlZtYA8ngg+RuMrKTfOrgs7I6hTmDfddyoIzsJ+D4xN
 Jg2ztPgWHoZg3SSDt6jE7oVkxKxuSzS01GP1mGakxQWUIUEgADQAMEHQzNso1tsdiCsnDrViKve
 SvX0nVs7vBOeQRDp3JBvyjF1DRlJHQn78DOWocAC35Jezl8f8KAPcPCpx6fzlIxJk9Ul5OBDBnC
 loAnVYHgvdrZ9xf/nNOX7GLjU1INt4ykMHvdF3fBGCF7wQvhyqc/qt5tQAYjPS3rOdWTbReDKNg
 zdQG8favh0=
X-Received: by 2002:a05:6a20:3949:b0:3c3:a9ad:a747 with SMTP id
 adf61e73a8af0-3cbce92f86bmr9478414637.26.1786223447996; 
 Sat, 08 Aug 2026 14:10:47 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:47 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 5/5] drm/amdgpu/aca: Fix off-by-one buffer size parameter in
 add_aca_sysfs
Date: Sat,  8 Aug 2026 21:08:52 +0000
Message-ID: <20260808210852.2938-6-sreekuttan2156239@gmail.com>
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 47f3bcd5de0b..99c315283f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

