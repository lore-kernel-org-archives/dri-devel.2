Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872A7CD8C85
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0629510E132;
	Tue,  9 Jun 2026 07:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.b="cftHFXnO";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCC010E08F
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 05:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1780983727;
 bh=oiQztLu7ayEL1BZi0J/ISbX7leUJfOCstoweJDCYphk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=cftHFXnO2C1KpdhaS12eCzVJCtf0Kubx+ff8mRLE+4knqaCjr6JdWWrR3vQRI+Sba
 P3d5QPrxYVKL/VEneh47aa0JTc9gTfTIIc3x+t9f/YQnY+bitRmZPljTX/+TzBhqYR
 hGgoDP6fU9AXrkbPDksu38Kzx1yIWqknibx3oPbI=
X-QQ-mid: esmtpsz19t1780983419tfdbcca62
X-QQ-Originating-IP: 9YbBN8UemGC7/4w7eZkwyFmDB9pRzgNBtufUVXhGxqY=
Received: from PEN202512010004 ( [113.57.152.160])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 09 Jun 2026 13:36:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14602859154893020583
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, raoxu@uniontech.com
Subject: [PATCH] drm/debugfs: fix dentry leak when removing files
Date: Tue,  9 Jun 2026 13:36:55 +0800
Message-ID: <D43FE6467BFBCD12+20260609053655.2406749-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MBN1Gf7pvZQZ6dtJo3SRvjzw3RzpVRYjhv+QuDY9q4tkQBaHjgXA3rhH
 inLNUNaNPDVzYUc4Rv8qa5xpE7O//F4ZPAkfqCxO7NOKjEYWVBVCzVo829bQj5oOXsfEvQA
 h4U9kD/ZN/yotzZbiYV2YwHRQyYiHJq188d8bAT411qkRptowMyan3W6THCL44g3qZezZlu
 2nxze9cj9Z+0AicuSl0e7A0qJOGWuztU5QVpqOMbwKGsZQPP3tzLEo4NLA3oHAxDXgQiTxA
 7yXymn0aNIzfwpG5oXavGxXiOe+VQtlXnGwP611gOoBAM41ioSOwUX2KQwoBYnpmn/UnM/G
 56dU//UGtmAuU3dLegXzqNOw99e0EAzxk1Sa474i/U5PzGoHizjM8smJ/U8hgjxf3oSu+nY
 cT6hlzE9OwytP8qgnd/Hi9S3Mdy9YHOfdK7XfyTQq8ZQyELSO/pKFn/GTVHUnIt9OrNFhNL
 r2m91cnZ8BpG0z+yraCchDrbgppKowDYuSDTKHlORGpz1L5ctPN718+mafmI+N/f5TUXsXK
 vBLPMCQhQ+Q1doloO8z3g/peTd79lBGFblpq6P5LdUAElunVc84v1oCiS/6WyQBOvme0KVp
 pO45zBvKI5G7nLNi7VTtfeRwc+3MgvFIE9rtwqOZW/nvmb7SL1t/XzaNyaQ7/deWIuUAh+O
 bEHOOJj0VS+eUywy/jkELhlZr7fuFOBC71YeutZ/5QsqomergwD51113M0VTPMU4W+i4dL4
 2XyxhHdpqL/kU5YN1oBRp+ZruL0uKMvBaG3J5zoLxu2jGcs0afUovLa93FcbZKYQaSaJqFa
 JnL3R1VuFkzwIqt5Q3hLCPyEJZbwIxl74OB+NCBPYntgscM4MudzbcXv0XN/S89c6XBfbHg
 dqm0XnSfgUtjFXpkVeWMVnLYiTwDFM2SvLL4EnXbC2sBKci4VETA11oE0BT2h+yyrn6ljJY
 bqbDFz54y+KaxgwiQ65OJZxhwAfM3Nr3wQ/lKmlOAmgwKLZt230HiwUVCYW+fL4DLlMmr6i
 Tg1GW8lwa/A01cgcr+ZvgdDuu/9jfD6Jz9Of6lBA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:14 +0000
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

From: Xu Rao <raoxu@uniontech.com>

debugfs_lookup() returns a referenced dentry. The caller must drop the
reference after it is done using the dentry.

drm_debugfs_remove_files() removes the looked-up file but never drops
the lookup reference. debugfs_remove() does not consume it.
debugfs_lookup_and_remove() exists for this case and does the dput().

Drop the dentry reference after removing the debugfs file.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/gpu/drm/drm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index ae1c6126c2c5..fbaa53ec2a4c 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -285,6 +285,7 @@ int drm_debugfs_remove_files(const struct drm_info_list *files, int count,

 		drmm_kfree(minor->dev, d_inode(dent)->i_private);
 		debugfs_remove(dent);
+		dput(dent);
 	}
 	return 0;
 }
--
2.50.1

