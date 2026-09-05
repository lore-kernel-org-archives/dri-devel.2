Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2402C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5851010E5B3;
	Sat,  5 Sep 2026 00:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SnBjQ16r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47CA10E594
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:43:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 369106025B;
 Sat,  5 Sep 2026 00:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A818F1F00A3E;
 Sat,  5 Sep 2026 00:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569036;
 bh=i9FIEzPfm/uew4CacS6zP4HA4rLMmusojNCkX4ydPTA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SnBjQ16rUQozMKgVtqIPpi0Cmy35PC6l5+zWvtXv1rnl/jkzm3dSxx3grrxUq9jYM
 6+1qfW2eTlT62NsVamfgi10kQaGCBOExRzhzhq7m1/ejxxNsAN2g4qq8v8dGd5inz7
 QsZRJ1XJh5TViv7hH/CsV6Zlx1u/hBj+gxx9ltoOmuziJyj3fLuFrC2NvybhDzMwRs
 KdGCDrldnfGv3J4QHXdWPReBli1G+5h2pXmeVUl4RuGJyaPcyfNbkJvvg3pGQ8llbw
 c7RNY0X3IRUvtHHp6mZjWXbyMAEt6/6tFWhSMsJ4GMAkg6InrtLODazQ0aY6Qr0wXq
 /cy1GvpAUXS7w==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 04 Sep 2026 19:43:30 -0500
Subject: [PATCH v2 11/19] accel: ethosu: Account for feature map element size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ethosu-fixes-v2-11-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
In-Reply-To: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
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
index c54496fa08f4..bca68fab0527 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -415,7 +415,7 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 		return U64_MAX;
 	}
 
-	if (check_add_overflow(addr, 1ULL, &offset))
+	if (check_add_overflow(addr, (u64)element_size, &offset))
 		return U64_MAX;
 
 	info->region_size[fm->region] = max(info->region_size[fm->region], offset);

-- 
2.53.0

