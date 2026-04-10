Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D96F45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E0410E9D5;
	Fri, 10 Apr 2026 21:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s2ev2TJg";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F2D10E9D2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:28:20 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so957575f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775856499; x=1776461299; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h4zwVlERIznTZv83IMyyoL1Es2Fk7kS1w5EdxpsFxhE=;
 b=s2ev2TJggerSgL1RPGj+/hCfsgCjWtb7/DpOPmSCFb6o0kmqMFf6u4/7vatOWZ65YV
 xfbhme2+bYVzK5W9Qdz4o35BiBDcA9VtnORa5aWzOgWgTe1XP/oPzx99wgChZRvHbuJH
 8qzBLHMVzykB1h0t2/gNXhPP/FwpG3tSOFOXV+QM+0UdBngc49V9slfrIPxzCxrqw+9P
 2gQnJ7QX/Hd4aAJNNDyipJl978V90ZIyZgJAKbZetlkmp5XmY+gL98bdZ8LS+Wly0Eyi
 DW1QtXbXbvHT+IE3+VkQMxycTJJJlM2oPJpZiAe2PuIxNW1pdVQwfFreaD3jWmQlKa2o
 wRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775856499; x=1776461299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4zwVlERIznTZv83IMyyoL1Es2Fk7kS1w5EdxpsFxhE=;
 b=FFvRlW6b/XEQXMdXRA8gA/0EFLojwv5PPvLnmBcABOQa/aIInJhMP1clwdLgdZlzAs
 08FZUaqU4CLZfwLznD2M2vMrwkLxEHONA6KB7OE6A5h6aIqiMYjD5Va0OREyE1CH3Bam
 MwEB/GgAOurT5J6Tz4n1He3JlgAxZdn+oxyZfM0KeCQITsy4uH6bByjqNls7EmwDdQ6E
 q8DrYSvCuHwhWEvyBrCNA3XgytXhf5ngcxOvtw2Cguck3UmUFzYCo5LH0FgA/mRJdr9T
 jVqnsEB0qdZRSbrCleu1czKwwUUW/u2+AVow8g3d/pVSScitQpsOdh8EArkbQVgVms0e
 polQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrxn/u5y41Htx6fgU2AQlCCCgAjXJboPG7Qx/+AMN+RhgX37ubevOV0Ct+XI8Te8ooxhsnW89O6SM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZBpVCQVwcOOSUd7cM2n0w7ZuaPVtvRnfUPB6Kwl6C4dtx9cCw
 pKFEqNzn2FtFVryMBooVPZjIWsS6C0B7YwQElWEq6lPhONjzgZvHghL5
X-Gm-Gg: AeBDieu2UXoKm//ycaoI2b6iti60B088YSXH4RPOVH9OqqAQVhdQxQfYRxxLdGd3Ofp
 UyJlN4IIET0nxAFWEdgTZHFVVl643u3PkpP3AJTQdVnpzlAyf/4zYlyZLhXDijCJQ7mslnZPBYG
 1JPT/iY4OyE0hA0PLr4kp1RO8NF/+6r3zcre+hA0JZ4SOVnjAHFF9Rb0sTdnE3Bb6vllx86p3/G
 1mmZXlBwosOJIo9pyq5+cqa7kYLZ9LJ3PihD8GVgu2rccqHpwBjLDvADD5P+Ovkj6M84zvX+KfY
 z3ZTAx+KfuepeXgsfObikRuavih8WRXa+feL3oSjAIPQL7CBvK9ZqKkxXOBDj4c5Z87sc6/KHdh
 vFAbBU9BticUGIzbflOy7P2o8NGQzaHShbjatz/FS/i343NSYrIqrac3NS78/03IlZKM50CfhNg
 s68w54psHUKTDRaqYEVp7l2HxAvBvCXASbIf5G7OZpIJNPKDCeA3cHSRUtWuB+gUi/yzrzzA==
X-Received: by 2002:a05:6000:184f:b0:43c:fed2:bb72 with SMTP id
 ffacd0b85a97d-43d6424c6e8mr6975505f8f.19.1775856498661; 
 Fri, 10 Apr 2026 14:28:18 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50015sm11205992f8f.27.2026.04.10.14.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 14:28:18 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Alain Volmat <alain.volmat@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 1/3] drm/sti: remove bridge when sti_hda component_add fails
Date: Fri, 10 Apr 2026 23:27:57 +0200
Message-ID: <20260410212801.413827-2-osama.abdelkader@gmail.com>
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

when component_add fails in sti_hda_probe remove drm
bridge before return

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/sti/sti_hda.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b7397827889c..1b4ba9097005 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -783,7 +784,10 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hda);
 
-	return component_add(&pdev->dev, &sti_hda_ops);
+	ret = component_add(&pdev->dev, &sti_hda_ops);
+	if (ret)
+		drm_bridge_remove(&hda->bridge);
+	return ret;
 }
 
 static void sti_hda_remove(struct platform_device *pdev)
-- 
2.43.0

