Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05648C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAD310E4BC;
	Wed,  9 Sep 2026 02:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="gwMgIwV5";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3316F10E4BC
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 02:09:14 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49d0b98d6d0so32755485e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 19:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788919752; x=1789524552;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q9Xayl9dx51mDNzYzQJokyIz5EKoLm+Ut42MJBF6ftI=;
 b=gwMgIwV5biTYD9MaZ/iHb6cqtJAI13ulc9R9k0HyYIAgyHVUsxIdB6lAaNR+8V4ba7
 +38RdiCK1fzSf9cvJl173X4L4ZPRlrZ21GqTxAT3g/pTlUZXGnpCK5KxVvwJWS6Q90Wk
 7S02PQUJJDcAMyLIYwzLPpcA+Jl7oE7lN6ATmQqu9T/J/9EPiJbYe5Ql9t4GshEf0NlM
 spwNLNMfu/rK+ydFj4X1IAq9PsG5QBJ8tS+FQRaBgUL7Z83mJhqAKkaVaXTTHAXqCRzk
 9L62oX9hUnvngb0TiYhW0+cLHklg9W+4O2Pp0922i3BIIRC6rNA9dYLoGKn+zPT5YF7r
 hL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788919752; x=1789524552;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9Xayl9dx51mDNzYzQJokyIz5EKoLm+Ut42MJBF6ftI=;
 b=D1h/s3aO3y124kazAyUUfvV2Iv5oALMygBjz79iThxjazmTX0ZaWjsjvtELAuulQEf
 VtZt8p3wFJrvGT+lHkxY+51oYT4oeHIaGB8/mXcd9RaMBmufWccR69FWkHNUazqLnzCa
 edPYSNtb4VpnVWUodPHAcKhFlTcPs+6fHiQOloT56yoPikdrK4tzHqfru0W02x0roY25
 mqAkJ5o0X7z+/63BVs6CpWJYJ7EO5RCDq31C8VRJHN7LKljC7o/bc84EJvHTNEp00avW
 3B+89SOGUzKJyjInpz/sZs7qUtSdO0X9mUrgB4U3vca/mjbuzkDZ1Nb3ddHb9ue8lZKd
 14Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+ewx35shQdIg9rLyi5VPxV6LX4tqzAp02GRGLd+dRBQgwRctOMqAcocNsmDd0MxkXgaPR2Lw++dw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nRn/cyM/FwctCAtcEJ3j6LNK/gnfPJlI/XhoYW2b5oUhfUXZ18
 9yZzB5z+tjPINWmytBR7imUvB4lykyWeHrIKGuhbiwe5t4NONHwSrKjVpcmz+iNcXg==
X-Gm-Gg: AYBFou39d+r27LcPjBMvPwq9ZjR8gbqm9Lk4OP2XwedSXR7PGQzEzPLxH3CGFbhbAHo
 bUAoQ3u+81bs9Tf/Zipx1Gv1zmR0lpmlytOxw3cGMpJ29cChoLXn8IPAtcRfjoFYaGJx14jbEXi
 YCTuSu+a6w1QsIqWErQk7/Fo42wXIl+tncECzGuKXmRhkfT9vDjrsEprpr5HQm+Opejl29SPQO4
 GJay6S8/5GAFiGWwCvBZFZM9kS40l2w+ZkASQGsEzMDeUYL3afV1WutXzIagfm/ohKIKvy+wSF6
 c8NKoyN0Je2TQ6/TFV9RmPQX54Hqo/Bopom/L+FUoUDlup/ywpmfVXQh8yi3cZfWmbINIYHLG0R
 p0QXuOw+1p3yXgYosrHpqwrzSUMWFxxZEIPB+9BpmNuEEZltwzZalg6BCha9rX9DghRz3/050OJ
 4nrHtptIw+SiL80bAh+IBu65CkUu7QCq/doTSXVl9UpEm0fKMTBS2fO48qJXdrm+4yJQIQzkyCW
 NrAknElnS7UMxjnJgEbboYSESU=
X-Received: by 2002:a05:600c:a01:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49cf8222d53mr323280465e9.4.1788919751903; 
 Tue, 08 Sep 2026 19:09:11 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fd5959fsm13203405e9.1.2026.09.08.19.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 19:09:10 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH] drm/amdgpu: don't migrate a dma-buf into VRAM while runtime
 suspended
Date: Wed,  9 Sep 2026 03:08:54 +0100
Message-ID: <20260909020854.58462-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
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

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment, so ttm_bo_validate() can migrate the buffer from GTT into
VRAM.  While the exporting device is runtime suspended its SDMA rings
are down and the move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Taking a reference here would deadlock: the reservation is held across
these callbacks and is also taken during resume, which is why
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") removed it.  GTT stays accessible while
the GPU is powered down, so leaving the buffer there is safe.

Only request VRAM when the device can perform the move.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
runtime PM for externally attached dGPUs") was working around?  That
commit explains how to detect external attachment but not what breaks,
so I can't tell which.

If it is the same thing, could the pci_is_thunderbolt_attached() ||
dev_is_removable() check there be narrowed or dropped on top of this,
so eGPU users keep runtime PM?

I can't test that here: this box hits the bug by missing that check.
The dGPU is on an oculink port off a native AMD root port, so
pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
and runtime PM stays enabled.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.  With the patch the map stays in GTT
(ttm_bo_validate() returns 0, mem_type TTM_PL_TT) and the dGPU keeps
autosuspending.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..d1dae5f3fee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -191,7 +191,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
-		    attach->peer2peer) {
+		    attach->peer2peer &&
+		    adev->mman.buffer_funcs_enabled) {
 			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 			domains |= AMDGPU_GEM_DOMAIN_VRAM;
 		}
-- 
2.55.0

