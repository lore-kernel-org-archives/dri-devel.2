Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24B8C5DF81
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4737410E489;
	Sun, 23 Aug 2026 09:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CRwO4K0/";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF95110F22D
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:19:02 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so641806a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787296742; x=1787901542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xDp4rmhAwTlJo2Sslrv1XZ29SdV6qudtW+6TKgzPyrc=;
 b=CRwO4K0/AvM8fqma6okA3djBkrRIP1DdS3CxjbSREBdVwUJtQkIyWDygVng8zFOvDW
 vQkSsJ/hhf2rvJnccuaFBMbrhSFhs/4lWznyD4imfn4D18q+mEGfK8nSmvY9JyPf5fS8
 zLQJdw1QFiaDKDBTUDIjBSjVz01eRyprnAFMT7yL6IjVGvNum3xnumIErYkHbPxCWdQl
 /CpWuAKcGZpDsqZW7n/XUhuVQsm2nhgVwcTGo7kImvsAGSTRaQyOimgTjVT91/j1WHDb
 m8ieq6n8K3Wd639Tsx6Y2QqO1Baeh42sY6LugTNdfUFCxyct8JhFOj5nTILxU4KWv5BI
 SuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787296742; x=1787901542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDp4rmhAwTlJo2Sslrv1XZ29SdV6qudtW+6TKgzPyrc=;
 b=sPj2CDTkFX6PvWjTCa8cBAIb8BW7wOoiXeZpfXjwf3XJxz/RiIi7gFPbKvP2n75AT+
 eFF7bCi1A5RdaEabh0v9+fob6aB+G940gY01lCNuq75JlteMPJbGTjwdz83dAhnawSzM
 nNlrgG4TE4o40beVWOfih5/we0lB9iczEd69NEhwgWdlVlxtpdgRkmvMKog07tFgGWhu
 eR1AMzb4nkWFqv3UDvpcJLqlWPof6fiajHE3HNpz0wLDQgQt07WiI3r+T/siiQVHYnqw
 /dAOc8dDIgXklepYXNLiZhrPZM0pXJFyxv4g1WXWTfC4WV9TuXhMRK7WEY0gXPf271/D
 jXxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqefiY1T21b6WW1+Jf4jg2HLgr55x5HXjplc1kUypM0VF38bj3XhpqqMluOEkkX4MmClvy/p0airY0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mERGbfTl7q9YXi+pH8NtnAHih0JkmS6ghM4lYTOHdDZC1W45bV
 Z/KWul/W8LvyTRmVEY5MCakYIDK49+IvB69rtPWxAJP7qsmyK2/O0DIX
X-Gm-Gg: AR+sD10bLp2j4BAGNyXmHAN4PLo2H4c0X0oQUa1jJxN2M3DFUqYWi5SmBbZhVyDW24e
 sfs0UD5yDfdZXXhKQCxRUC1gLNMAIZ13+vCy5TFai8L4HPkVLjeVKN5G2nK6z/SOPSJRNhBBZ9O
 a7TER5qvfoqwD5hBSCv2eYJJykH7qvVs+jsMp4Ll3aIdZkDaLgvd/keSVhCDMjM7m5xpf1FYvDa
 L1AZidXrJn+09pbU6mLuOSRppLvbcGpRF9v2C5p10vvQBpEixVd6xDC5bVr7IOCSd7XEgFCJQYP
 EBZYXYqGihl32N6LvIGjQQ2c0ldQEI2uNdUyNmSDyissbYCPYW7/FObxcwpF6sj48EPEDj5fovZ
 NEDHzQ3sEekENKa3LJahk3IXDpk7Vgurvb+21R1iXbDk83RvbbAV52FiwiEjHoc7nqD0bbuarvC
 9TQ6igSrTR9p8znqLtNbqjR6BM9kPBxPHj6tWuxFLaoJzxMl1IObOhTZRLe3ay
X-Received: by 2002:a17:90b:4a:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-395c352f984mr6908265a91.11.1787296742134; 
 Fri, 21 Aug 2026 00:19:02 -0700 (PDT)
Received: from fedora ([111.223.30.106]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae5f1ffsm36733073c88.13.2026.08.21.00.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 00:19:01 -0700 (PDT)
From: Sajal Gupta <sajal2005gupta@gmail.com>
To: rubenru09@aol.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com,
 Sajal Gupta <sajal2005gupta@gmail.com>
Subject: [PATCH] drm/gud: validate GUD_ROTATION_0 is present in supported
 rotations
Date: Fri, 21 Aug 2026 12:46:13 +0530
Message-ID: <20260821071812.16500-1-sajal2005gupta@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

The rotation argument to drm_plane_create_rotation_property() is set to
DRM_MODE_ROTATE_0, and the device reported rotation bitmask is used as
the supported_rotations argument. The driver never validates that
GUD_ROTATION_0 is present, so a device that omits it from its
GUD_PROPERTY_ROTATION triggers the
WARN_ON(rotation & ~supported_rotations) in
drm_plane_create_rotation_property()

Fix this by skipping the creation of rotation property if the device
doesn't have the GUD_ROTATION_0 bit

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=efe2810681f1b065d3a8
Tested-by: syzbot+efe2810681f1b065d3a8@syzkaller.appspotmail.com
Signed-off-by: Sajal Gupta <sajal2005gupta@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 89bd6ca36003..3a1b9e2a2eaa 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -289,6 +289,8 @@ static int gud_plane_add_properties(struct gud_device *gdrm)
 			 * but mask out any additions on future devices.
 			 */
 			val &= GUD_ROTATION_MASK;
+			if (!(val & GUD_ROTATION_0))
+				continue;
 			ret = drm_plane_create_rotation_property(&gdrm->plane,
 								 DRM_MODE_ROTATE_0, val);
 			break;
--
2.55.0

