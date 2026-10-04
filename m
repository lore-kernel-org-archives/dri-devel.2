Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2475ACA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 23:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2304E10E125;
	Sun,  4 Oct 2026 23:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEFvrnH1";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5288810E125
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 23:52:58 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33bfb26865fso753375eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791157977; x=1791762777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZqiKuFnajSw67rytiWL4B9vhK9q5bykbBSbbq28tnv8=;
 b=MEFvrnH1DSDCTLxUvLoTres+MaatMQysdcECtjLH52J/O9pj99I5B8MBhh7BFFcCat
 6G+Tpwrur1c8I1EHUIvbJY6VDx51cbPrwL50hqSTkKpaAIVIU8cpKG37eIf5HsFoPPiZ
 QCdOGyuJA/aePP9Yl21G5ZZajU9f9B3hQZk+ljw2/i4VRBzx8vfGNSPsFKD/Zf3esQvx
 oF3H9lNiEVaN4VzxSaDZPXwIDKzNknWMsHyjbeJn4yJCPFy1gKfzy5xzGV47WUIyJzTw
 CW32Sc4bNr8vnKXVeiuac/FBXk503h9ib7WEUeAUQ8+XrFi9ptVrMNFXW+Rz8N9VNfPg
 Mtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791157977; x=1791762777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZqiKuFnajSw67rytiWL4B9vhK9q5bykbBSbbq28tnv8=;
 b=eq5z3pmjjDTEv3mhkaU0s45i9GYU3bPmwL7rTuDkXUgwA/+uO2Gg+AAkIpQNrisy6h
 wr70fqK5G57nOBR6GAadS5WAN2ldf2+wgKcPeNeyq2TZEnK1x99BJDPC84zjZGR1uPQv
 brP4yNxO0xZDZTHZeNMEYzh3Cn1By9sOrrfQtgVcZGVaDbLqDvBwTkIEFPmGHdJ1bm2V
 PGWa31tTg9RPOxGZDMUtTA+/WlKkDamdxNtnVDGyLqyUXdjFrDCctkTWMD9eucJGLfQO
 M7Q978SLWA5GsK3uZzdFrUrwDT30qWSyEKswOpr3xuwcREj9WPHR7kKGsQTiFv4Ow+64
 GSJg==
X-Gm-Message-State: AFuF++lV7NiYBGFXhHyLDIvEMCo7nGD7iCmsCwZM4GHH23Q2bSPX51NR
 uxNyY3yz9yyOLDYv0ztHUisSd2fhlVw1dTc9dPLXh860d96jQhd27zF4qj2/zlyVaVE=
X-Gm-Gg: AYBFou3jzu92J5jgAKMg+s+wK8eTP7fr0dYCRArscn8QBd76HIuGEusgNdsNXSIGSQG
 rh4ZQ01gLbOxzCWBF+H6PiWu6edv59Lm8T4DMNxdY/s02coH6vXjXeXoib/z6j90WoP8Bn11khY
 dJu9WNZtw4/glPAsIwm4VsjLQxj5d7Qm1EtOVSl7tEbtLyF23r2D2Bh0VJljZojS/e8JuPRGjue
 6dkH3TvbLlGSYIiJ57Xuwi3S4Ulm7Ba4udVg/g9QN6VAzZ6aXrr6Lia7xMobN4KOpbPLMVgeGO9
 ZOCry8Te0ONGcaF7rVcDz2P88Vxm+TbCW1WjXXh4h6tY+4djLZaaiab44WF5cA2FVtTYE9QXJxz
 JJRUnPddYoHW2dhyf3dLf7c6oTzsP19YZjyZBo6s61QLvq9XcVxSC3eCyLlvS7Eyttn1X8PVpdm
 wTgmyaIBwCeFUDqN3LEDmhEG6K3H+l2IlG28jrRO09lcT6wsD86+J98cYomRQRRwiJkLPB4s15k
 vjXpZpRLaf7/dUcSpRAtXSMXiJ7sz7qDE/ququ2+APaV+KGYQFFI29OjLqLZKSIP4gdaUgRlDOP
 DLqUW6kiAQt8xQkmgqzcB8/LQahUQf24D+2ug3zMEorZAHz3
X-Received: by 2002:a05:693c:4019:b0:34b:fd9e:ad4f with SMTP id
 5a478bee46e88-34f21856407mr11608346eec.22.1791157977345; 
 Sun, 04 Oct 2026 16:52:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127161456sm8126005eec.14.2026.10.04.16.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 16:52:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] gpu/buddy: drop stale @p from gpu_buddy_print() kernel-doc
Date: Sun,  4 Oct 2026 16:52:55 -0700
Message-ID: <20261004235255.547593-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

gpu_buddy_print() lost its printer argument when the buddy allocator
moved out of DRM and now prints with pr_info(), but the kernel-doc
still describes @p:

  buddy.c:2153 Excess function parameter 'p' description in 'gpu_buddy_print'

Remove the stale line.

Fixes: ba110db8e1bc ("gpu: Move DRM buddy allocator one level up (part two)")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/buddy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index 2f2aaadafe35..503f7d5934e4 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -2148,7 +2148,6 @@ EXPORT_SYMBOL(gpu_buddy_block_print);
  * gpu_buddy_print - print allocator state
  *
  * @mm: GPU buddy manager
- * @p: GPU printer to use
  */
 void gpu_buddy_print(struct gpu_buddy *mm)
 {
-- 
2.56.0

