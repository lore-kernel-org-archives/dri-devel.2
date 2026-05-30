Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F521CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 19:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A83D112997;
	Sat, 30 May 2026 19:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ojmyd5d6";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB31112997
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 19:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aauNtjMGBqIyEKuSe/QutO/PoOoUZpL0MWQOPEVrCDw=; b=Ojmyd5d6BYI05nT9MqjkqFK2is
 Te8bmZu28mI6uNqxzlzNr37zIdhJaTx7ZSZjLotBX8cUpZ+CoVrR1zdnHd1m2FNbE5dMExEiqng0y
 Ht/zAUSgg/ABN+46XiTRcgddRVKODbqUnBF2gB+F2KPoPkH/tcSa0Bk01/w0r6oKtUt8qPp28LWPI
 RR4DBjz1ORzwPdDVyFdAsZFcTEDkf2Z1Vf4kUVK4vuxG4tLkbDQ6XoOLvnKZqQryQmLouxefN7UH7
 a1Libotd25mwj5zhrbFjRPhPX+oTF4S+gWWOrWvgWRKB1fEC8uknEGEehHlbmTIEGcx+CHSipGSA+
 dfFkkmXA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTPiQ-00AMOG-2B; Sat, 30 May 2026 21:51:26 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Fix indirect CSD jobs with zeroed workgroups
Date: Sat, 30 May 2026 16:51:17 -0300
Message-Id: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bkENLfpKdBBday8WGhKIf086D
 sxMhUyJKcM6VEhUOPMVO8hxAHfaeBCy7wxKKCO0NFgmj4Ff5Og5kXvQZY9mEcYFJayeLfT0TtS
 df7vtrX0yJEfVZgAAAA==
X-Change-ID: 20260516-v3d-fix-indirect-csd-6806cf20a57a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=855; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=zXU1bjcXYaqqJeD7XFUHjdIFKMhUsrYPKJBUJM80q18=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGz+7klskmc5fCZ52jor3eaBpbvXBF4RZn21J+
 aQRFv9bcnuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahs/uwAKCRA/8w6Kdoj6
 qnIhB/4t/SucvdSEbumbp6H10PBvW3kfv10CLN9C9mzlOaGKdo+tSEDZjv4WSrMHuqUcalaIc5w
 GVdbd1NyVhbXZmFU2qOsRr7kDhvLxefBwXCPG5/IaZVWYtkOfWzCcjoUS9KX0oUjeJKslE+1kYd
 DmnHdbuf0Xu+rlvzIVoD0ey8Phic+ZsgGDIqrgYfq//t9UAjxAPrYzYD10sAy8OC303pXeHDnlL
 WjfsqMTvd6+kNOGSuhwbGjYSydcYqjKhGkRuD4i80IY7V4vDl/E1qbMXhbToP2QSyxKDdcD0+hd
 SbfVJQ2+2Q94CRcKYSZioOZSVM9OuTkkdFvwEoG/wY65FeNs
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Hi,

Indirect CSD lets userspace defer the workgroup counts to a GPU buffer
that is only filled at runtime, so the counts are unknown at submission
time and can legitimately turn out to be zero.

However, exercing this case exposed two issues in the CSD path.

  1. Virtual address leaks when the indirect CSD has zeroed workgroups.

  2. CSD jobs with zeroed workgroups shouldn't be submitted to hardware.

This series intends to address both issues.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups

 drivers/gpu/drm/v3d/v3d_sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: 5ab62dd3687bcc2cc542b99385aabac5c996db6f
change-id: 20260516-v3d-fix-indirect-csd-6806cf20a57a

