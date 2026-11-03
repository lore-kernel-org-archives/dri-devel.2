Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C6606A333
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hFKFYw+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A8C10F7E7;
	Tue,  3 Nov 2026 20:36:34 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEED10F7E7
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:36:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793738181; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DDlv12rk9rKzIaATLgnXoA5qSygbFakFdb2HP2wuok52/9mXkeZCrQ9RMCWvlpNJT+nEE8l169Wn8+Qff6uW8g5jk642lebxuTVMaqi39UjPB1TLJvjz4ffCPrlLIhKw8RvvuxDoPavu+cwoCvhRgMV8ulD8qy3w5su5gYtaflI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793738181;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tpEII053p3mhNfn30gTOffmnMpSklTjLEUHLptTr0Fo=; 
 b=A1VdwA2cJWG+2HQBAN0TwdXvdyS3zprerKo0d9uwb2avh/iHBBEouZ7V+Mr4l8X2Lw9HIg4lX+1uOBV8+L2iIg6v74kqddme8iXb727wYWRD76YbM/Y6A1jbE3CfoYjxVBw5dzffKc20t8U6U3THeQSkcZ83c/0OvamOeVNAGYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=hFKFYw+GppvQihmNZVs5V7WsYuzDn2H6ftn5z17WLIO0kBLDDsjaUQ7dFoTVBVIs0oXDfsiU3w3s+G9+bmm5ygt5uTHVhv6vl6+Rll//NwB90U4vuEoBzE3B8YDYY6ie1ju6HZJzHTse4CVw7xOKnhX1d1fdPI5JnSLfJ7SyER8=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=tpEII053p3mhNfn30gTOffmnMpSklTjLEUHLptTr0Fo=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179373818058011.607757256583909; 
 Tue, 3 Nov 2026 12:36:20 -0800 (PST)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v2 0/2] Two small perfcnt fixes for Panfrost
Date: Tue, 03 Nov 2026 20:36:07 +0000
Message-Id: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4V0bU3b8BBX/odh0Q5TqUFKZpBoC
 P9uwbh1c5OTuXPPIhgpIItztgjCOXCIQwJzyAR0drihDG1iYZQptdK5HO3gKfIkCRlTWkCWPrx
 Slr7wJi/qFmon0sBIuB/S/7X5Mj/dHWHaFrdGF3iK9N7ts956P1HxTzRrqaRzVQ66OpVWuQvEv
 rcukj1CfIhmXdcP2oDCydoAAAA=
X-Change-ID: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=E8MnxMy9vF68TqjM4+LG2zhCzTUUYzvJPrza97Mqc28=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq6kW5xYci1qak3iNu7yOhtteIgrBtPP7wwv6gF
 oljX8uUUmeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaupFuQAKCRAOJn5M7lND
 PWT4C/4u/2kZE1A5PwP3aJUIDLQDPl0lIn+HeqBrYVh8YwHgbOawQ/N+jGobl5lKWj50aKIS52p
 bLXv0O59VAuV9nR+iU/LBlO3rVESHxU0rqewzdFOzdAWJZaoniNyuXjMufzLGcoqTK5sj3RDDIF
 ABuBqEFO4DrIHhJLBShoFBcCL0yTxhGdn1u1RLl1cLwmfLzzGWBctcoKwPY75KiX+PencehfItq
 ayOR0xxy2eEPLHDhCcg2RtAVJKwEsQozMRVPSxmQYeyMf7si9TDMDbyNY3AMtnC0e+lER6oGuIl
 Gd6g+iBeO2yIKofll8pneGk87WrgroXGYWE1D5bai9gINTIt7eFc79tbdrT62GvaEC+i+7dA73H
 73I04s4UOFTLrHv4voT5b7mwD9OgHxw8Z7wp2FTNQP+u09ApEZcpxaJBwHry8ZUZy06pj0lSXrN
 vN5Ma7cYmUQ/nv1OrXk2AKUTyf9I+oNy2kU4QsSjyftxQvvOMftHcC/IBOs4pBKWDs9vQ=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

First fix makes sure cycle counter is enabled when starting a new
session. This is required by some profiling frameworks like
Perfetto. Second fix deals with a recently-introduced race condition.

---
Changes in v2:
- Added review trailers.
- Removed warning from cycle count reference check.
- Link to v1: https://patch.msgid.link/20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Adrián Larumbe <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Adrián Larumbe (1):
      drm/panfrost: Fix race when restoring reset state in perfcnt

Boris Brezillon (1):
      drm/panfrost: Enable cycle counting when perfcnt is enabled

 drivers/gpu/drm/panfrost/panfrost_gpu.c     |  6 +++---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 18 ++++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)
---
base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
change-id: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

