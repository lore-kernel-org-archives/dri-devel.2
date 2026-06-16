Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD11CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D047C10E7A4;
	Tue, 16 Jun 2026 14:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="EAjOTU3/";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337D210E7A4
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781621217; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cz+lcSHpi6wudcEFFVsn5m1HLLNlpaDdTia32ro//rfxwP9yGLqUMLecOdQpLqZKAl8IS0hAdXX1UyuStZcR5Gtc4ijM91D5u2BjBwIv7g59+6Sw08LawbboNGAJryqwVar8XJP/h02JNG9Jf2e/vl7pH0YEBUqqSZ8WBLnxY6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781621217;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CvU9uqxpVI8+FBbleIGMJBIQpet1Ok1y5/R/6uF0SPA=; 
 b=XdSM9qWhB9pbichPldDt8v+a6/AQuQqLXwFyoBNJXuwlAx3jYODoLnRsTM/MQLsjPp/YYM8OW9/k6bb3Zd9mCoo7uU1bnNogT6JsbYk8Ky1iXf1vqtiUYCOzXPxZ+8uEbI4OmO8+qPB1leEgfTE8IO6GwYC2QvEvLzDh3Vz2gtE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781621217; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=CvU9uqxpVI8+FBbleIGMJBIQpet1Ok1y5/R/6uF0SPA=;
 b=EAjOTU3/yQ7FjAJhnnPegH3xMivhRYp/EvT9nwAhYg/QR/oeBazPhZ6hBNXyEjyJ
 pHIbciRWVAzzsDvzgsox1LQ+SAxbhObvpA7aRSfvOmYJnJih/mShdMF74lqyCiGK5VU
 WRTcaGBfMQTYMPiXk48/isL/Wkg6mqi5ViVuyBKI=
Received: by mx.zohomail.com with SMTPS id 1781621215329594.2759744164969;
 Tue, 16 Jun 2026 07:46:55 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH 0/2] Add vm_bind param check to ensure no overlap with kbo
 AS carveout
Date: Tue, 16 Jun 2026 15:46:42 +0100
Message-Id: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBsYRSP2KqWEJI46lkbJWCmId
 zfq8i3+30AoMgk8sw0irSw8hYT8kYEfbOhJcZsMBRYadV6q9Wsch9b4gfxHVKmxrpxF3ViEFM2
 ROv5fw9f7tvzcSH45L7DvByCW4KhyAAAA
X-Change-ID: 20260614-vm_bind_checks-46075ba069a0
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=F6KraEBBktbFCEfAWkWNMW41geaQ+BkD1x+4on1sTjg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqMWHcGRIxR5ifnnfkekTnAlHvpehop1KVeaCAs
 VrLwx1OprqJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajFh3AAKCRAOJn5M7lND
 PS1cDACtOuMlPUzntjDIKJzOpWRV52FpbyENTXWZBg112ugdwJ7s4fU1dxiddyl2/rE/5J45BUH
 wwy4rjySUm0Z+N1wgQyBnEFjwPLwW7WUnW1Sth+gvMn2zQ+7C5v2hw7sJ7JVeCAOTGwZ9YTN0Mj
 07vkgYy2CooJJvWM7+cGuU0tfsEhhIQCqeWPHzLeentGmF6mxW8Sx43ypQn2w5D1kUrFbMMAdQe
 9TfvKmPFGq3sVUFPAJBGCRx0U1MegpnJnMOMBIZ4nce3zX/kx1fOGQbMixfL9jhUtEvG5r9S92V
 /xz4Un/SU0vLD5sCcZi15hPUDTqH1mt5CYGF0J63KNLUK4o5xM4SVd7pYKkDJ9uSyB2ilJADD7G
 BsVSUfb3P1RTqrknhG1kpxQoL8/SxSWKlDQ4kHdJ/Dm50GHR+60ILih8KkcdqBZr7NCNFlzEM50
 c3bTmuUN3vFLz91AUpFobSmSzo7N570PWvvj+2njekWLcTBYjzeNVw0EW4a1vNHGd8AFs=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Just a quick check to make sure user-supplied vm_bind regions aren't
clashing with the region reserved for kernel bo's.

I tried to introduce a similar check for panthor_vm_alloc_va(), to throw
back an error when mappings of kernel bo's against specific addresses fall
within the auto_va region. However that is not possible, since there's one
FW region that must be mapped right at CSF_MCU_SHARED_REGION_START. That
is usually not a problem, since drm_mm_insert_node_in_range() will pick
the next one available.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Adrián Larumbe (2):
      drm/panthor: Add vm_bind region with kbo range intersection check
      drm/panthor: Fix comment to reflect actual struct field name

 drivers/gpu/drm/panthor/panthor_mmu.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)
---
base-commit: 2afdfc658f7a7e9ee2a67ec6663922da9c799c53
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

