Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A622C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE6B10E08F;
	Mon, 29 Jun 2026 20:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="a01M9bkb";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358DE10E08F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782764233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ENszz+OoXinHdZvvh24JE0Mb7WN/X4yi3eeNAfh9eSdkuJL+9kmuB5/jpkXbu2HbSwQbRRSam7Q/lK+3KRlKKpksR7/UzrKHM1h5LQh3Gx95ZCSXuoFse08fX0oP01uI60LOWeIjoAqM2iBi1k2AepjgOvYqvTXeSvreUD3smMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782764233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lMc+NJRkwTOumFpeA8lImgwcUF3F9t6LvbTcSSqIMDk=; 
 b=CKIkS0VHjiA0SPEh4eyY/+rMfcegX/0GVmBrbqqL9V76be+3rMUdS+qbVAAuvl5qH0PGKRAuf31RW5SEgQMFI+27GxKuAR6LzaHhjJwIlSRhNnDKQHJGmGth0a7HjMN5DWi5BiiGUhxyc7S3JtWo3Q0uqxq4/xOxJgAkBLDXmB8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782764233; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=lMc+NJRkwTOumFpeA8lImgwcUF3F9t6LvbTcSSqIMDk=;
 b=a01M9bkbpUIvxpcCYiYp5HfxkI3J3idBhp6L/Yf32U6LymmCokY/jKw/5kSmEm3Z
 R/sRruip8D9zhERj+8fCJ9XUok6iOq+ktt2PQRtmqO3naHUGBgHPgnvXHQJgeAhY2QY
 NeZmt5Wg/FlZyKAuIh4JhbPDUFhu+wqm/OHLl+z4=
Received: by mx.zohomail.com with SMTPS id 1782764231064542.7586660592837;
 Mon, 29 Jun 2026 13:17:11 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v3 0/4] Add vm_bind param check to ensure no overlap with
 kbo AS carveout
Date: Mon, 29 Jun 2026 21:17:04 +0100
Message-Id: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XN0Q6CIBgF4FdpXEcDFMyueo/WHOBvUioNjNWc7
 x7Y2ppdnu2c70zIgzPg0WEzIQfBeGOHGLLtBulWDhfApo4ZMcIEETTHoa+UGepKt6BvHueCFFx
 JIkpJUBzdHTTmuYCn8yf7h7qCHpOSGq3xo3Wv5THQ1PviYo0HigkuuaDlXhAmITtq23VSWSd32
 vYoHQT2S5R/BIuE4lQqqTLeFHRNzPP8BpArCCsFAQAA
X-Change-ID: 20260614-vm_bind_checks-46075ba069a0
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Sashiko <noreply@sashiko.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=yJU68m5QumUX17a3Zu5Y0TvxaMD7l0OVXtjEi+ySmVI=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQtLClm1kfCbJzWYd83Xl4APp1HSdxPnqCeu4W
 xJEGcY3o7KJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakLSwgAKCRAOJn5M7lND
 PXYcC/9BJQbfGwcVxAFOwFMgDvukDqhzeVenPLqFO7fxgqXzGKvmd11Yk2YpwiMVYpqnhCubiky
 mcgzUcH9vypYVVW+EFXozwTY9bqTOhHRSbeeOo/uKB0VDkuuDeLhcSK1Is7ILK1iOqLAdCSGqyt
 67QHzhRk0SH/d1QcNGkzB+IkJZR9VKv6iU8YYG2wffiuMpijAtLu8yEsI9/5h+juCbZUUq9Gia7
 Om/rmC6fy0m4aS5e09eQ5IvIoLi+L+L+114T2ZSSL4P8ZKg1rPlWHDE8rW5wX30VLE9fKsTCaUs
 khTFh2ewHZ5JZY62KaaazItzjautwCfjSFE5PaK/6yP9AELeVTC/zj3PG3hHZjW3ODOHjesiq8K
 8KG2sWgOlJBKcZ+nZ9oCaj1NLw6yyEcrxmr3ZuLp1Rkyt8DsteMMpSanwNxM8kMiTg26AL4XVXQ
 Z3I5cAfOKRfh85WnGahR60vBnxHLh9FxqrHHpLdPQEhEVOAnzFCuiboNUdLjnRSfCnNyw=
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

v3 also comes with an early bind range overflow check for sparse mappings.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Changes in v3:
- Fixed off-by-one error for user va range calculations.
- Added new commit for panthor_vm_prepare_unmap_op_ctx to take a whole operation.
- Added commit with bind range early overflow check.
- Link to v2: https://patch.msgid.link/20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com

Changes in v2:
- Simplified user VA range with kernel BO range overlap to a single statement.
- Link to v1: https://patch.msgid.link/20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Heiko Stuebner <heiko@sntech.de>
To: Grant Likely <grant.likely@linaro.org>
To: Adrián Larumbe <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Adrián Larumbe (4):
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name
      drm/panthor: Have prepare_unmap_op_ctx receive a whole vm_bind op
      drm/panthor: Check for sparse binding range overflow

 drivers/gpu/drm/panthor/panthor_mmu.c | 42 +++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)
---
base-commit: 8fca3d8dbebf8d960dad7b10db3cb4a61139454b
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

