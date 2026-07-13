Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9362BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDD710E804;
	Mon, 13 Jul 2026 08:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="eTfDloii";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B897F10E804
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783932505; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lXKjaHIiHw8mXjf7Vn+TmZUYX2QhU3s0DjJwH/LN4kzuiJr9ZA8tH/Lv0HUGWGHhtDPtgDHdysYsdIjnS1QMgxqEr8GOWCliPuHcSSOrovafbjZdp8yHb7mGi7RY+VCjXG3bH1zwbc0kO342PxJXDUqlL9mCy5o86ypXg1kXppU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783932505;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KsfxWRzAagCx14YxLvnO4oX7Kh2sQPKkaZZcrk4rEJ4=; 
 b=lbta+zQ9p3jcSZ2leSDAdsqgwbE/5HRkcOUcA1zKlz8gnU4zmFjYs3XAGcr+qjN5qhf4nmWvzJTiSvZI4gD6MURK6tpmu5ZCqNYk59InIwohxi35oDQ2zwakT0yQroE3KTJrxeb3bHYx9Mc9l+9tw+yvI1+I4AIce7giX3WuuZ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783932505; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=KsfxWRzAagCx14YxLvnO4oX7Kh2sQPKkaZZcrk4rEJ4=;
 b=eTfDloiizlpLm3YsdFYEhWJPhSNku0fdjmBlNsVQGyq8DEYhIJ9Waf6dQvZMelkf
 UjdmvsBqgV8qCWPm0bS9AB/gFkrNvSYxMp4CC1oDpLi7RTX26pIrBkKV6a7HKTCFwth
 EW7pqRsHsuX6j8RGlWiadVCiHm0tf5WJGHTCPxZ4=
Received: by mx.zohomail.com with SMTPS id 17839325039261007.2755806448675;
 Mon, 13 Jul 2026 01:48:23 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v5 0/2] Add vm_bind param check to ensure no overlap with
 kbo AS carveout
Date: Mon, 13 Jul 2026 09:48:00 +0100
Message-Id: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Q3UoDMRAF4FcpuTYyyeZn0yvfQ6RM0lk32m4kq
 UEp++5mK2Lp9vLAme/AnFmhHKmw7ebMMtVYYppa0A8bFkacXonHfctMgjRghOL1uPNx2u/CSOG
 9cGXAao9gHAJrRx+Zhvh1AZ9ffnP59G8UTouyNMZYTil/XxarWHp/uLnFq+DAnTbC9QYkUvcU0
 uGAPmV8DOnIloEqrwm3ImQjvBbo0Xd6sOIe0V0Rck10jeg1GatgMEHSPUL9ExZWX6qqEcqC9ia
 gG3q8JeZ5/gHSALQhiwEAAA==
X-Change-ID: 20260614-vm_bind_checks-46075ba069a0
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=h+Y6xvjHuguWZKZVi+XscTQCBY616BZPFtqVxf0n/Vw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqVKZTNT05L4/JIjQm+Mo9SwvqbXBO7Lrlyydx7
 Ox0MrQp6VeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCalSmUwAKCRAOJn5M7lND
 PdQxDACzTYslNoeqyxIHN4lLekRNgKJCD7OQ+rA42184ROXJbGYHu93tu9SEnC1mooVZ+nZwQsU
 1p0O9MUD8zgknIj0MPKjU3z10W7tFlgyfI+O/dNvLPR7yvHzpIo5Sta5T4Tygw9pzh/6HB7Lm3e
 FXGvwyt59cf6wiwvu8Swb1cO/0jNTx4nGJBCgqTCht1aKJmlxMdvvhJLXjRNRLjsYyBYrCXxVsc
 hA2dIkJHCkpQ76e2SQPKXt9d2UWxI6kO5yxjdKyUaTMhC4HtK+Ly96BaUiBFtUZDP5ylHgWa/oK
 W5HVZJWulMD50nsEVW2bORCzu2Gd82xXMnbQHF8gdq2Q08RA9zp+XzAyw7lE0bSUuppUzq/T6Ee
 wlx766A8yGN9f/KTUA9vNEmdpD4csTUcfG5Ey+by+5+vY31LuMgkke88zbQGFCEWzGrvSV/NiHO
 HrWwUvwlavymcNlUYsu8b8Px07ATDw1qkRQS+XRHqggiwqssbView+F6d87Oi4xkCgXik=
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
Changes in v5:
- Coalesced uint64 and kbo ranges overflow checks into a single patch.
- Link to v4: https://patch.msgid.link/20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com

Changes in v4:
- Deleted commit that passes single operation to panthor_vm_prepare_unmap_op_ctx.
- Moved overflow check one step above in the call stack.
- Rearranged the commits in the series.
- Link to v3: https://patch.msgid.link/20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com

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
Adrián Larumbe (2):
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

 drivers/gpu/drm/panthor/panthor_mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
---
base-commit: 8fca3d8dbebf8d960dad7b10db3cb4a61139454b
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

