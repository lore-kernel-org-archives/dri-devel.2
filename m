Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A334AC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0BB10EDBB;
	Tue,  8 Sep 2026 22:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vx8Knk28";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC7FC10EDB7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:05:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6FB0560219;
 Tue,  8 Sep 2026 22:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF07D1F00A3A;
 Tue,  8 Sep 2026 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905110;
 bh=81+2lTuoLtNrrFz1cjX0UEXbYP1lwwUoV5MIK36Dgqc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Vx8Knk28Kc8ND3QWDC+qXD1kMPPNCkoFWn2f2bq+y2Y01KjrSASkxa+vvAJEpDuiG
 hkOprJXcJgAaduSVt/U4DDEXe5wtxsWX8Iv+CqhtkbG/AeeDpswA31fA3iHOFReiXb
 J0c8QaQJYkS9FVw+sAYrXSuL/7rgioC2LruYeWkAE4Rb7xPhmB1hMEXwqAnEnk/5r3
 k2yqu1fkFSr6/CT5AAPUjnJX9oBPVK6goQLW/PtNAgzftq1qzTqdbvLWFvTkF0uxEp
 wYgbdGoMZi38LcNkxKESa0elzDjITzU7Npb6XmtzxRR8HubCwX6g6YnP9mW/gEgtW7
 NKA6p3rq0U5Dw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 08 Sep 2026 17:04:51 -0500
Subject: [PATCH v3 14/22] accel: ethosu: Account for feature map element size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ethosu-fixes-v3-14-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
In-Reply-To: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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

The feature map bounds calculation currently accounts for only one byte
of the final element. This can leave the tail of B16, B32, and B64
elements outside the validated buffer.

Use the feature map element size when calculating the final byte.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 11aa3f4dd0e7..974cf562ef49 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -426,7 +426,7 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 		return U64_MAX;
 	}
 
-	if (check_add_overflow(addr, 1ULL, &offset))
+	if (check_add_overflow(addr, (u64)element_size, &offset))
 		return U64_MAX;
 
 	info->region_size[fm->region] = max(info->region_size[fm->region], offset);

-- 
2.53.0

