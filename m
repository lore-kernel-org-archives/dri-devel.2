Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C8EC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 701C410E089;
	Mon, 21 Sep 2026 19:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q1NNkqFs";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B01610E089
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 19:00:28 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso23403795e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790017226; x=1790622026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fY3g4FN86lO7gTsP1NjKj+WPROihpzXWYs8IbUHywVs=;
 b=q1NNkqFsPJ1v6qC64AqGJJoRJoFKC1tlWXfmuf7Zp+VHmN3HNANvUVoeUCKjOhWx4A
 N7Z9qIrjuRwzTDE9aZGXHoN3TmTU7rGXdHrG3hlWAWbzzR5M7rOPc1cbQleWa5nSFILj
 G1xq+6B3J37KSnZPsWW4q4pT+wwxvHGckZttOtWzF5fGIDPd7p684TAbkiTNHUOQJLWm
 waALhOGOa9JfNlFjdFSzoXGFu/ZRULJ36+QRSb8ipjbh9ctj0eA36hWfmdMhzv+oWsED
 jQrx37F5dLGRuP+fdQJhQtEMEIzbNyRPYLvIsarZ+YWKnzIlIDJPh7byW10yVO09Np0c
 RFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790017226; x=1790622026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fY3g4FN86lO7gTsP1NjKj+WPROihpzXWYs8IbUHywVs=;
 b=rUc+H/JP4M9tcHt4K6PATEo8vPHs/jM3lfEyzefJ10DeJdAfDn5vXdinoKaj57rM/f
 tHkSs3bIgPTUNNrTEXn9BUXoiYcU6xWchGFEquFImp3zzQPN8hNB4YDVBKZku0LkoXC1
 Nto+pOqWZ42GtUAdlmZbYBuuKm4gwHNNovbic0OGnP4VZ2ZpfW/GXPEZnA6peoRJDZHh
 lRXEt0Hh2iGpOlZpwXvWKDshDtYYxWs4sh2JzEAr5rTHX4Wg/3sPsmIpXSNKwuPMlE/r
 23aFUQlq019txyiAAeLvNlmnC/TXXg+sVqiQa5tfqV+islUDPNkufOkmwOy6R1y8sFRf
 G1Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/KCDviDDQPpWIZ93UXotLhgDmKTYHTZsXcWDNK1zo0f7rK3eVGZL4WCsu01+a9RWLEkElOChBxq8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJzuzL6okfJjdtEfpGpSROaCw2otSqjnLV69VfXZLNqvWq0PFT
 a6yk/C8tWNeC4aQ7XE89IafADKz0CGGpy/YRCboS8fe1le1nWxwypxjq
X-Gm-Gg: AYBFou03OLEBg1pAdtSXc6flVtWZxBL3sqQqNQ60uwfayccWsMuoqU+XDQng5pU/UiB
 y6EpjaiwtR/9jaM6NDodSFFjAxGyhLpBotR7p9dmXVLCujAb0V5vdk94Chlk+yf3CKNQmPJzgtg
 sAYNVWk0CaeKILp+Xf6op00E8vAwueWPh4i55e/BBuxE70NvIuK969ftnaQk0f0h98mBe+GzVvl
 BNwqpWb48mFZ6a+b/iGr6je+Jhz9W5q9ZFkNuOoyYA7aKndEUG5epcZFMYSzlTR7blPXcALhPXQ
 uA/MeXJN04c6FMKWIgIalPW95FQ+FH+Hd0hBlUJ+HjHrhnKY3ubZJTxcMMe4SatpCCi6XW6s+wt
 U62VYHdPLazm4AgOYdx0vlrjWSMcTaq7qCEHkxm5ZrIdIVZk/5Upgpz7ebyd2n4hs2Dyl6bh6IS
 EzM7gFVgG5/2+CS3Zx5gaxfDqycafX8LHw0Dnp2+z6413ruOhiobC8GifEUKgw2FOrslDzREFmN
 9N/bGSjDHCUHYBmy4nfaPN8fIaEEM4zGuuOe3TFyg==
X-Received: by 2002:a05:600c:1989:b0:496:c1f3:e8f8 with SMTP id
 5b1f17b1804b1-49fc5673292mr181013065e9.7.1790017225923; 
 Mon, 21 Sep 2026 12:00:25 -0700 (PDT)
Received: from karanja ([102.205.238.36]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8cb5e75sm11475555e9.14.2026.09.21.12.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 12:00:25 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] drm/v3d: Restrict v3d_perfmon_stop_locked() to v3d_perfmon.c
Date: Mon, 21 Sep 2026 22:00:14 +0300
Message-ID: <20260921190014.38231-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.53.0
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

v3d_perfmon_stop_locked() is only used within v3d_perfmon.c.
Make the function file-local and remove its declaration from v3d_drv.h.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h     | 2 --
 drivers/gpu/drm/v3d/v3d_perfmon.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 29fa14be130b..611618030519 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -703,8 +703,6 @@ void v3d_perfmon_put(struct v3d_perfmon *perfmon);
 void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon);
 void v3d_perfmon_stop(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 		      bool capture);
-void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
-			     bool capture);
 void v3d_perfmon_suspend(struct v3d_dev *v3d);
 void v3d_perfmon_resume(struct v3d_dev *v3d);
 struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv, int id);
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 07dab7fb3060..34f17e7b8f6b 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -305,7 +305,7 @@ static void v3d_perfmon_capture_locked(struct v3d_dev *v3d,
 	v3d_pm_runtime_put(v3d);
 }
 
-void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
+static void v3d_perfmon_stop_locked(struct v3d_dev *v3d, struct v3d_perfmon *perfmon,
 			     bool capture)
 {
 	lockdep_assert_held(&v3d->perfmon_state.lock);
-- 
2.53.0

