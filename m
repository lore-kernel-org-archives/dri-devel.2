Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB93FC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BD810E79A;
	Mon, 17 Aug 2026 12:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="Ndx9FCLc";
	dkim-atps=neutral
X-Greylist: delayed 444 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 12:45:20 UTC
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F246910E799
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1786970717; bh=qkhm4uDqTcn61rxXD17rLcN6hVGKjX3nV8ymNLxK7UU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ndx9FCLc9+u1Q5TysOpKI0nqwOi6kaEChloliDgA6jLNEkNbyXleAyhIPcx9N5Z28
 hfqJMKwfk6WqHcCDhpEdsgvZM4+AVI35UHN2eYKAT0A7gHaQCH+hpax8TLHJo9rwOj
 STaru17ikAU4jsR2IN5toGoEXMTqXQpc7FDGSKc0=
Received: from lxu-ped-host.. ([111.198.231.89])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 9732E29F; Mon, 17 Aug 2026 20:37:51 +0800
X-QQ-mid: xmsmtpt1786970271t6v8z49n9
Message-ID: <tencent_C6A625E0BAF4BB77334C9E0F1B244B7B1B08@qq.com>
X-QQ-XMAILINFO: MSPab3JKqisNXcta34i6a2/T2XWDsBD1fF8aY6I/yqQhKf4ixVHwZrHwdOz3JU
 vaorDWsjNuBDXYm7eniiNvdX/X5vhvYX8WcRihqR2iNSOZBJLJ3YxjcWlY1Mx8M7PK85CeJ7Dw3N
 M77txHpGuvo8yRh8tLwJ4srb8zImbYjBfr48IZYduEZVpltm495E4Lsv7MVtYK5WSOsvaR2is6Fo
 XOjWcpyYrLf4+V78bITN1NCc8O37+daTmErx2vRake4q5gnpdrbtTs+Q3mp0ztdTF95QUCSfM8Y1
 qHSmA9l9fkdNSFVNH3wk/isKljZX3nca0DMFv1g0LtaE5pI7+AYPH5uG2DLziyeo2sHtHxEo0yKj
 nu8J9eT0eJGMvDDYb+WGtAL56Nr/FPxDwREVaNsALe7/4RY/f1q4N+cjwepXHIvSCjTDlqscnQjO
 q+68JGfwMQOpx0Gcc0JQZg12I1tZd5+iLw9eoj6KobGe00ZJ+c18RKBCZWc1xhzMGIfaiHeQyZPX
 Xw8BBJ+A3dFVA+hdgZFsrswpYNAkch5v8Z+cI9G5RBfQEAoBZMxkXg5C+Eu9KKr82Y84ClS2T8k2
 F9WW1M/GSVqytsJ81HwYx8HT3vmfb0I+8jeXvwlB3LC0wvBGDFldQsGUVsy84ERbJaTWfoRHe9iu
 x+q+m0dL3Rqrx3gb+hBu10AT7CT/ZFW3sdOCdDzQovkpfGQXxE+bf1vB3qSmjLvuUegsLzQZjllb
 Vp1ZJJ0/JRe1HLqB7KxKfvuzmiZ1N4gwM3Qo5RLvif82HQ59B/weoXh6EdKL5IMuf9KNBda9Gp4q
 xVUvGE9x1m9gYSv2p3w3S0dOUvgk6aakDFCh03P7F4z+chf4GYzm4v4rdfxyYDCCB77Ir1DXMVTG
 5O1akft+YUapCN8XhnAFrrGuslAjf3auBeajtr1gqPJ3tXgWYD5FFg4XhZw9r86RzQysbv5NwVaW
 HpmgKEDwqbOjGOsupzKMaPibqc69lxrE+RY883ECytlTndo/T7gUlFEMLXWPJ2+BMapPU79GW+vC
 PJpDosgK5wGBHsLwEz6R/loFVsBbUYg3pia4pq5w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, rubenru09@aol.com, simona@ffwll.ch,
 syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Subject: [PATCH] drm: Optimized by adding the TV modes attribute
Date: Mon, 17 Aug 2026 20:37:51 +0800
X-OQ-MSGID: <20260817123750.364706-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6a829a95.dbb3a75c.20434b.0043.GAE@google.com>
References: <6a829a95.dbb3a75c.20434b.0043.GAE@google.com>
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

When adding gud properties for drm connector within the function
gud_connector_add_properties(), if the TV modes property is not added
first, drm_mode_create_tv_properties_legacy() would fail to add the TV
modes property because the tv_select_subconnector_property has already
been added.

This causes gud_connector_property_lookup() to fail when looking for
the TV modes property (returning NULL), which subsequently triggers
issue [1] when a NULL property is passed to drm_object_attach_property().

The fix ensures that within drm_mode_create_tv_properties_legacy(), the
TV modes property is correctly added regardless of whether the subconnector
property exists.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
RIP: 0010:drm_object_attach_property+0x85/0x3b0 drivers/gpu/drm/drm_mode_object.c:240
Call Trace:
 gud_connector_add_properties drivers/gpu/drm/gud/gud_connector.c:572 [inline]
 gud_connector_create drivers/gpu/drm/gud/gud_connector.c:680 [inline]
 gud_get_connectors+0x86e/0x1700 drivers/gpu/drm/gud/gud_connector.c:717
 gud_probe+0x17aa/0x1c20 drivers/gpu/drm/gud/gud_drv.c:635
 
Fixes: f453ba046074 ("DRM: add mode setting support")
Reported-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1944765c3659f63d3777
Tested-by: syzbot+1944765c3659f63d3777@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/gpu/drm/drm_connector.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 11646453aaac..ecbbc967f51f 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2175,8 +2175,12 @@ int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
 	struct drm_property *tv_subconnector;
 	unsigned int i;
 
-	if (dev->mode_config.tv_select_subconnector_property)
+	if (dev->mode_config.tv_select_subconnector_property) {
+		if (num_modes && !dev->mode_config.legacy_tv_mode_property)
+			goto other;
+
 		return 0;
+	}
 
 	/*
 	 * Basic connector properties
@@ -2199,6 +2203,7 @@ int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
 		goto nomem;
 	dev->mode_config.tv_subconnector_property = tv_subconnector;
 
+other:
 	/*
 	 * Other, TV specific properties: margins & TV modes.
 	 */
-- 
2.43.0

