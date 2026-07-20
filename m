Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01E7C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DDE10E722;
	Mon, 20 Jul 2026 15:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="bh4SmQKN";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B4510E722
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784562527; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j0O5N5Kd+RGnvS5RfbVBr/pTn7WZlZcnF7vrXnxi5H7KIJctD6WUG1HjLKJCF/q+9dJQp8d22zMUO9drh5qIsQyHOH+/+MbIE8QJA2F+ufXsLGno06fofkPmktMWs6j6I3N3zB6ChsUUyIqsJ0uLe2IT68d+vmDeB936cmhw04M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784562527;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=UnBXGhdUaTbovxDBoqTFoQiROL85ZvXWEL88IIcfhHU=; 
 b=VaXoJLp7wLmQaPbUJnssL+PJjoAKqinJbcsep4Tjw3e4aB20BUSeGQ7yd6xo2QfllSA+bSpZIP1uh/bG4F93MhHkZp+0mdylejW/5H4KD2nvsM2QKg4pXa2e1obNYjWTP/k0pZOZQJ2EO+HBXiVxXlOU7dS+bd3xS/YLHPNodZ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784562527; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=UnBXGhdUaTbovxDBoqTFoQiROL85ZvXWEL88IIcfhHU=;
 b=bh4SmQKNyn1HOSX3MzfTLSdbg6SbWjfx97I8Rd1OaNqdxg7aUJJ77Q9UAmCGRetS
 /b3EVgv9X3m1oUZcnSk/6KO5cRtbKALVxLn2RmkLfn8Sqy3wJZlS5CasvpSN5UHZqM7
 TCXP0+Ucl4Rf9PFLOejcVUahHBJ3ojaV2Uqwb4XI=
Received: by mx.zohomail.com with SMTPS id 1784562525747881.6151551656292;
 Mon, 20 Jul 2026 08:48:45 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v6 0/2] Add vm_bind param check to ensure no overlap with
 kbo AS carveout
Date: Mon, 20 Jul 2026 16:48:40 +0100
Message-Id: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23QTWrDMBAF4KsEresy+htbWfUeIYSRLNdqE6tYq
 WgJvnvllFITe/ngzfdgbiz5MfjE9rsbG30OKcShBHzaMdfT8Oqr0JbMBAgE5KrKl5MNQ3tyvXf
 vqVIItbYEaAhYOfoYfRe+7uDh+JvTp33z7jorc6MP6RrH7/ti5nPvD8dHPPMKKqORmwZBkJcvL
 p7PZONIzy5e2DyQxZIwK0IUwmpOlqzUXc23CLkgxJqQhWi0x1pBh074LUL9EzWsvpRVIVQN2qI
 j0zW0RegFweWK0IWAVkiuqGta0z4S0zT9AKfpzlfOAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=BzPcB8VL4XQ1XaR8ZVOGMU5zx/WA0ZHDE4uqZYUuC30=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqXkNZt2+Pf3rIF6HJE6DXGeTz3v9Vl5W8SsSM/
 NFK2BKtuKCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCal5DWQAKCRAOJn5M7lND
 PeRDC/4hdum/lLbdZUNfMwcY/m1Joe1GU8YLUpwLTrYpzxvzzY7kvreyR7LeZeegjtmG7PWApqI
 kdF2r1sfrO87BOuTJUBkRKpxkbPvF6QWiSwzYVvZryGxSbtM35D7ADlMfBXc6Mma6RCGXWILt+A
 v3Ky1WsgktUHaom8HE7j1h8xFxX4a4cCNMjQrk8YkyhMdLE5xiu5COr7QnbfEg49im4emi/aGgM
 bQwrXPwGMZtkEOa8ELZ8B+iqNRfl2XlUT65+nFpp+rB7kh7t8M0ec1lB2oqwG+Fv1B6ZV5Hhh3R
 XDgId4MTjSLJzY6tJHgaxwDVQv12ia0GWdL/iSCY9uGWVz0taDVpqyvHuK3rR9wYSyTDo0YJk+r
 8q07byUtouR2sx0JuSvDWyiCjmWIF4dJRMtIsDbuzLMvCMcf/iNopNZGH89NLiLXiMxqxozEalb
 +auPWXCf2tSt9SkoPficQyIczkf4J2l7BZC/oLi23/Xr6Y4mYfVp1L3AOvBdFnWrhf0GM=
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
Changes in v6:
- Filled in 'Fixes' commit tag for first patch in the series.
- Link to v5: https://patch.msgid.link/20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com

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
base-commit: 35fff4830cb999b5496ae892a85516fef2912438
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

