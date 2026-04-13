Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5C7F34C56
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:16:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F72310E4A2;
	Mon, 13 Apr 2026 14:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KnNgj//X";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502F310E4A1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:16:03 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-82f2aab311eso589965b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776089763; x=1776694563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e0zbRRSwXZ7Pwh3Wo3GiTsNe9+S5y60LaaG4gtv9gLI=;
 b=KnNgj//XJq6Yk8E2OMB1wUy2u18LmUGaw854Tkyjp8QZBWaXtFJCteaBgLIpfap7hu
 33946D2nKD0m4Wp1LfhHz8hTEYKOj+nNiGRxpm8pHPIfo2z5iPBhLlk1SqG+n5UHc6MC
 Uo6qbesQK+6wghEONDWFBuh1CcPsGJShi46whxw2zP/DtQERgXId+ps2Wo1SC9lDNh9p
 uG5wEkpn02YCKyYpprD+cybrDrXq/41fhPZ4L6BSkguNjjwJfN/XSTcxHLXoMh9vmdnm
 oEgWUrkcgwpsamtqqJd73ZBiy9pt0QkhT79HQTtJyupeIOLW5glG4avhjfKBEiCllzMW
 s9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089763; x=1776694563;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e0zbRRSwXZ7Pwh3Wo3GiTsNe9+S5y60LaaG4gtv9gLI=;
 b=rDr4sb6F0sCV8ze2+KVvm2yRDuYkiAixxkcgiu8vO4AzW2DK1pQDxj5ESgcObWFR2f
 I7Ew+2OpO1cGcniozQhZTLiNOTzw+gf5bQU10iIT2IyF2ORv2Hm70HaT8Ze9wKo89cZG
 PM2ilB1EO1sxv3xd21Ynj2bAX4XoIhMPv2ubkDdVsdcRPVVYfvGzvCelG3IVZEEdAeL9
 +CsphKqWnhwcMYm0AI4hP2X2Cpz9Y41ajHxfeFg4jijLB3Gmu2eeK+dJsF4iLBim0f3A
 t8D6QVOY5A+jfjOtVZzkDh0CVEXQbrQ7/YTi0dNe8Gq/tUa9Ns0of5Fx6NOWP/A7Kvnb
 KXjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JP5WHtv/exU7tZDPMprnggt2eEOPjWLv3XVuHo6fpusE8CrUvBR+QMypOKmkVrYqaIyamwhchBN8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjvrAocOuMAaHGcru2OqgEGBILAi4NQiejqb4YBOXbW5nLb7/7
 f5OKAMKgsQjOos3nA62lWcOSuzQltoOPdL+1iY4t+CcQyDYeIfT5+I1v
X-Gm-Gg: AeBDiet+fkC2VIIudSPWEDx6nD8fIc4JD69fm3n718CW9s2Mysk+ZbYwyEajN4l7HES
 0JTfOyep4ClVq+rnlLH9n6HXUhFwqPLAnLklbxXPbFuSWeJD4Sk7qD7uLuEWpCglH9gvS3jbXoY
 DZGpJbPcVnhJZVKzIqzKP/VvQD0r6Q8KqgKHHZRLaYMtJtMDlIaOm1+aSuX1jfZWo8SP79w3iKh
 qV6ylAS+LmhN3yWwqbtslqIkgILOrgz1wtxGXp571ufEMVeer2M8C+ipSJD8/av/Pm29J8nq2Xd
 dHNKMWjHv5jg/uoi3aLd1xNezctY6c+hLrsqFZQqJPGpVEklnR9i9GJRcoCqdItAH1v70Mf2wts
 YIIIw8tmqJbdoCOc2B6V2c09tJn9zqxDe6RJP5JO5FVFo2+ndn8qg5SAG+ZhSpaNJTFY8XvpwXp
 R5/vUkACFfAiMMnhNAN8W02wEsAikewRs=
X-Received: by 2002:a05:6a00:170c:b0:82c:ddbb:7db3 with SMTP id
 d2e1a72fcca58-82f0c21d396mr13302565b3a.25.1776089762689; 
 Mon, 13 Apr 2026 07:16:02 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b17fcsm11396301b3a.33.2026.04.13.07.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:16:02 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mark Zhang <markz@nvidia.com>,
 Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Date: Mon, 13 Apr 2026 22:15:26 +0800
Message-ID: <20260413141526.2961841-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), if host1x_device_parse_dt() fails, the current
error path frees the object directly with kfree(device). That bypasses
the normal device lifetime handling and leaks the reference held on the
embedded struct device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device() in the host1x_device_parse_dt() failure
path.

Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

v2:
  - add Cc: stable@vger.kernel.org

 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 63fe037c3b65..e3ac85848aec 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -452,7 +452,7 @@ static int host1x_device_add(struct host1x *host1x,
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
-		kfree(device);
+		put_device(&device->dev);
 		return err;
 	}
 
-- 
2.43.0

