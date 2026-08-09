Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3776AC5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F66510E68A;
	Mon, 10 Aug 2026 06:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSVpt1UN";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B7810E0CB
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:39 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caced6038eso7520255ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252419; x=1786857219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3uV1jDlXdjYzrBZ5UiAE52SxJwX6HGbMM4vfraaFeu8=;
 b=oSVpt1UNuL/L68khgH3VTwfZLNOg7XMZjQAGSnAQIaAi/brfw0OWm1NPrhO6GQb93E
 3pWLYlVdePSe7EkdezP+nxQZvJjv2yT5TBkBiHb5CFHCkvBz65dqM1Cj7fm76Vtmbev2
 Y4vprDB27rEF59hP8naElfc7uUoJl91XvtOMKShx9EEzPstcp7lZrih0tyK2YQOMdMyg
 GZjKQlLaRMQfMjhnThNQct2ePjeqh+H1yVsfrVONZbh0fEYVl6q6CxN05KiQChTqXh5g
 pq5yQo/AA/koHkG/AsA0A41X42YtMsglV3MPqa8GA0KOJCsHB4EbnaKxDhpmtPGq9ulL
 prcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252419; x=1786857219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3uV1jDlXdjYzrBZ5UiAE52SxJwX6HGbMM4vfraaFeu8=;
 b=Ah2na7BNrEei1jXyydTVLxqRoC7T96i9fj/1jFRm685ZJl9oZN7IuIaxV3mUWqDlyF
 frDUMcqF+MEilqD+14vlB9z3wuD/3rvBwL+m/wI8adpx4RIQ44iCThpB50VIB24SpRRy
 6Wmf4GMNjzVW0VJqxBiILSCqfQmg3dAcm3Cj2nkVG0tTPzfcbpTGzhaDNaPGXdmNEUYu
 vc7mHJVhzQtTpF1r00Vk6LzAmfqq3XuO7qe4TVKpFwqz6u568mnECJjcZTVf40HhqKhO
 r1v4c1uxQ/shDvbHKYq90E0u7gWj7WSbGlwJh916OL8RSMIxfRl+pK5bemAajEd8sapQ
 HDxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyBJM4J4wcnq2oIYH9hmDorCq0w/ZVh2N26D9mtGgEjCm65YI5UHOi32fgYd1wUt6gKheN/NCLsyU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzj2XLInDz8W6a3mOqgIb3oaGvKIoGbEWIqpbz2+eDmFdpq5MMa
 q3LDHHsfEBtMfHxhOVNdTL5jTCYLkYxU686sRfjuh72W13WcX8rZEdiA
X-Gm-Gg: AR+sD119vWdbWt0usuZXOItICK09rvY+FHHJb9JF6rCshRnK7Qh3UVkDX2F9iD4Zqju
 MZsRSJ1lzVzIT357ohBaqiuG213T8D6JJSGE904XLoHOhoNbit+ZcGm0agP6d/vWTClIrFsiPDy
 Khsv+DBb9umhx0EwLSt2ipSJLjU9dKOUVG7hRGcKyX2I5ZB2pXjraIYu1stBYEyOa7195+9uRd/
 kshrMstwv3+oLrF/kilz4IzSUmw3pJPFyY4UqGtDBNvam6iiYdik3C1PAPMZBs26pgdAr6Rk5Bu
 Bwpq2xh86ifACLYxbwtTLRoLcIUJ82/DGrC2p9kNMIC3/a9h/qiuQAYqp+/hHfa8dgCpPTZmUnY
 7LTvma/O+IposbMCjX5YRD59O9iAjjjBbETwX9DWAQkP2UNsTtaxKtw1BzCZgXHxy0Jl++I2e5z
 m1mUUNHYTHZ0Vwyuf0/1P+Pixn0aU2pkWg8uBZYmmjaNN8QoUWu5N5kxDj515WHo1+EhLESP8Jd
 9lcSACVypvt
X-Received: by 2002:a17:902:f612:b0:2d2:a982:a388 with SMTP id
 d9443c01a7336-2d2b2eb169fmr124489795ad.15.1786252418944; 
 Sat, 08 Aug 2026 22:13:38 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:38 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 5/6] drm/amdgpu/aca: Fix off-by-one buffer size parameter
 in add_aca_sysfs
Date: Sun,  9 Aug 2026 05:11:59 +0000
Message-ID: <20260809051200.3276-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
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
index 79326389d75c..4305092f134b 100644
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

