Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165B4C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63CF10E002;
	Sat,  4 Jul 2026 04:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="S9FSdPx5";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F92910E002
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 04:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783140422; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=THjF/0SP8mksH40DdfewQUbCE4++PJSvZcCaDAjP8A8cZeedgrqtrUTUgocwPqpIc1k/Dx7aNvs9V0GIcy9ot1naRw4c26cmjq7so0yHsFxehN/V5l/zVXSF1MEI0UnOzgn4x97QhbFR3waUMJYRvi5NvMRHUIod7qxLvyLvC+U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783140422;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Atfhk1xwLRF50ypmBJ4bx96WXbHzkEXym39L2zvevJI=; 
 b=UmY7rCksVGe5Zn4rAwmuMP7OaQpPhXRKfK/vb85g9Wbu7rcNyDRlNT5gh5RrLbRFgQq5M536HOPd7kiopszORgxoAJ3uHU0ZwFbg4RPYlYILz7i87aODekaxkJFTFfdERyibHJt4ZbIQPbfO/yeAwHibJwERTMwj3WWq8FcxEkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783140422; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Atfhk1xwLRF50ypmBJ4bx96WXbHzkEXym39L2zvevJI=;
 b=S9FSdPx57O983F7QdVlRSx2EtnC3/fGejtVXljvxcQ5vr8MlJyh6YozRHcv+PY1x
 jUBsdH+vtG6LZEaNpFPTcYtZrMR2SQkqRXv//uGwz8gq3TQVvrBHerW7Z7QDGeMLWr5
 JN3ciZ94LxKIG12LZPey0I7k1dwB+Rh5fdsvGkek=
Received: by mx.zohomail.com with SMTPS id 1783140419931842.8332238353531;
 Fri, 3 Jul 2026 21:46:59 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v4 0/3] Add vm_bind param check to ensure no overlap with
 kbo AS carveout
Date: Sat, 04 Jul 2026 05:46:43 +0100
Message-Id: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N0QrCIBgF4FcJrzPUzX9bV71HRKj716w1Q0uK2
 LvnFkG0Lg+c850nCegtBrJePInHaIN1fQr5ckFMq/oDUlunTAQTwIDnNJ732vb13rRoToHmwAq
 pFYNKMZJGF4+NvU/gdvfO4aaPaK6jMjZaG67OP6bHyMfeB4dfPHLKaCWBVyUwoTDbGNd1SjuvV
 sadyXgQxTdRzQiRCC250kpnsin4PyL7IsScyBJRSoQiZw0Ygb/EMAwvNG+uGUgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2544;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=Tvf5Hc0SK7ZbQaTipFm4SZO869kcuY12ln5Z9N7dQso=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqSJA/p2vjfOFkajlQfQyiFwbcZsJ0HWzu1c2Kd
 S8X4+Ot3eGJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakiQPwAKCRAOJn5M7lND
 PcrLDACLXHsitC7H4fig5p/FN1/1ghsuxJyNg/9h7aSSoS9iasVX9Iz6FWeVrS8Oi4Jir3WP3sw
 3AnaKasbHBHNb/JgzBTd0WVslq2Mbf/KoN23T+Ctji8/VOcZCM/uo+Alh/tVabMqoF1gdwNfdt3
 tYWZo0u35osxv0bNhgd0NCUzOIeRd1YbwI41XcgJYUElADOhy1WYMG5dsEC1WA9OAHfww1rk91X
 X79Xh6Te7Y80eCesZzo8udlP65rC0f6xl3BY37HdueABjgeVFEVxR3KsXj9n/UYHiPwblw4oTma
 +XAt0XrAsc5JEEsCmqBVLXOScXxJUn51tp9JPPgVrbIsRLxRF+EH/PgSmiuLhfAF6riyAMtmZp+
 W2tifCYM84DxCFVtlEt0ZEYowwHDBnwmnlBW4O4r2WE66axZJQL8jxMYAoZB/sh4Xdl8ju/eYP4
 t/AaAamYtOA1Ek9pUcOsdQ5Ov6oxP+cnwDTGg7v7AOCg9Z/FkokpVdTtewvWLn/ua8qC4=
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
Adrián Larumbe (3):
      drm/panthor: Check for sparse binding range overflow
      drm/panthor: Add vm_bind region with kbo range overlap check
      drm/panthor: Fix comment to reflect actual struct field name

 drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)
---
base-commit: 8fca3d8dbebf8d960dad7b10db3cb4a61139454b
change-id: 20260614-vm_bind_checks-46075ba069a0

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

