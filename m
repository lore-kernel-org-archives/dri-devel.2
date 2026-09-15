Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9ABC88E72
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF8C10F806;
	Tue, 15 Sep 2026 00:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbS67WHA";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F82610F7F9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 00:54:54 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-939109fafddso226107185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789433693; x=1790038493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wPbpaLTfdjYqHBQHnPbcqcrKPKopAanNoJX+x2503BM=;
 b=mbS67WHArltxzJoS7CE5IvOiwHb9xpUfAcEql6sUBoely9dF7TrSz4X8TEtw81dOfF
 0RKJ1lB0zxpHMlVlvpzxnv8Cr7fPcAkjzI39T421aA2HgwoaKyrMqyUrtypcUaGpnWdF
 nUsJDYfwiHVCVxnvurG0x7sBaxtzSe9Sn8yaqproC4e7ceVTmvn+OnSlTYRiNM+aYGmn
 QK1NKTCDf6rRtKm8P19NYSvIzu+08jkknD1weLYdxpLlRC7HjUa80qW3q4cCx71CVvWm
 K5kXq29yCUmF38BFmiNMnaLOTEsFz1iPE9ECZxBysQDnJez3VlHf/9h9LGFTjxtfcsiA
 bgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433693; x=1790038493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wPbpaLTfdjYqHBQHnPbcqcrKPKopAanNoJX+x2503BM=;
 b=D+f29MMfkuLB6bHbH6Rq3diT52OpDhR3DWKKCsoUfR5Pw3yhlti7V7Y4THswNic4UZ
 Fmoom54p9TbmeRUaf+yoziVDCFcgV+c9Bw9RO9PMIEDxid7nZEB2p/+g8J2akBQpu78P
 vnbOO5ThmjfTEkS8RTPRAgeA5Gb088F2y5V/TjC5/1esSjWlam8ivsoJVflmRUG7SSiC
 XWvf3QfrlmDpQI9dCA4CYyPDyLGaC0Uyjjq61e9xKqKSFedJ4viw49OURA+on0Dq1l1r
 mlpHO0AtH2/OiQlNroq58rOIy2sHzkJu8DII6Snc2pLufeRMFWHh3Itx53VctvedlMCh
 2Bzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYWBiF+13OUzybq0vp1BFQZutuBWlLdSQQsHmUhQAAQ1mMdVPNOpnndNslJaYxQjSMvb/Uvov5f2s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kJs+bRb2AXJGVzsH8rmazK4cNksjsPJK559pH6VwHEN6LqEd/y
 zx4gdaq5CWF+ayI6U6J3kBGtSnu+zydEfGRQz62XaCo3p7n/pyuWTt8=
X-Gm-Gg: AYBFou2GU2fkPUNVPVTtVSO3q8gm4b6mnDOVMuRUKAJfMJS7OLmWztDfYS/f/dbp0OR
 wEXAYARjAEt8TXeZszexQsfUfygBGsetFejSWlOlReb9dV64Zx6XuwfT/XCBVzTwO327QzxnC56
 thwr2j//9nXN3GfoXjabbEk9Ss00HNeEOvhbyH4d6dwlzT+XsHRF/iH7O4dw65GuP61aq8wX+yx
 EGwZl/s8rfI2TX8vvIgU/DaH2fYBbSy3Wd3Pm5mPTrff8E0cZfW4gAFTait5T4kb77LcXKMzZDw
 mBgoIhABSSeyZ6PXnzZ5Ml8+lxh2OVeAU7XXHXNbK/ziAiBt0Jk7yu3mO4gtTRy/hdkOw0lTQQB
 68M7E90L6slkDBf8uF/+BAZcR38WlP3Wf/GdUyFlo3jZWGUUWKh/KEpmywiNHHw9DWmIiz4Xgen
 yhp90wMw2sFqT4EFkRCriWhwRyFysb45yGcvlB91pdroUJskrr7v9jabnDA29Njb4wrxrB1zqV0
 KX5FuVoQjmEAnsw894weUTj4o2UGj5BMKJWTPMa5knsBdmWo8pnTdKooLvHMOGhoFxDoGKZKihY
 L1cCDM5YGbJzAPAcmTYcdHhxAfw+AnlHNJdgejtsEbOK/86OawliCgho7wuvb4DU9ZphRpVJqEc
 =
X-Received: by 2002:a05:620a:43a2:b0:939:6c31:2318 with SMTP id
 af79cd13be357-93a29a13b19mr830053485a.34.1789433693467; 
 Mon, 14 Sep 2026 17:54:53 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu.
 [104.39.213.233]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4b3dcesm108370476d6.31.2026.09.14.17.54.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Sep 2026 17:54:52 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Antonino Daplas <adaplas@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] fbdev: nvidia: Release write-combining handle on probe failure
Date: Mon, 14 Sep 2026 20:54:47 -0400
Message-ID: <20260915005447.51995-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Failures in nvidia_set_fbinfo() or register_framebuffer() leave the handle
from arch_phys_wc_add() allocated. Release it in the shared error path,
as nvidiafb_remove() already does on normal removal.

The missing cleanup was already present in the initial Git import,
when the driver used mtrr_add() directly.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1424,6 +1424,7 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	return 0;
 
 err_out_iounmap_fb:
+	arch_phys_wc_del(par->wc_cookie);
 	fb_destroy_modelist(&info->modelist);
 err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
-- 
2.51.0
