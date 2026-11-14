Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF525606A897
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSpL1NfU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C0B10ED10;
	Sat, 14 Nov 2026 03:04:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB05110E805;
 Sat, 14 Nov 2026 03:04:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA1B260D12;
 Sat, 14 Nov 2026 03:04:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625444;
 b=f8BLwQvAkGJrAh2gH8EROZu5f/SiFc+5LC6fbNSXFQRJba6Nz18cGNVQv4YwwM+LnXni
 pWXLC1cl9370um+vc0e+FW3F3Iksd9JYcvuPR8tG81ggjyOstjUfOBvbBVZsTkkC+lA3t
 L0ypBjpDyhWzraP59ljVjXFMkhT+Hy/DEAJr1LrpfdFNfwVn9rcbwshcHwH5hIDC3fdyc
 M4CpHXJP8DBTkgPSt+oJkjVjk3QUDnn3cS2J8JeaBDXV20Z1q49uwihryqOWV+t/TVE4C
 /nIVJjpZkEIbgILhiamA9RqK1MXX4yneW1xnFhDAd3Z3t1ILnmQ1Nj29ZdEZc+nNSrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625444;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Mtx3GfnLXp4Rhzfjhr++N1BEMbALLyD5gvT3TXKN8Ck=;
 b=tSi6nVRuF398FA6cHEEc8q+DQOE1JvWrdNAsQxAxaoCbVuwvAdEvay8FbXba7a1Xq+7Y
 PvDlR507zL9mXgnoX9U36fKAh7qN8aAp1yqFVWizxZvYsqXVOvJHYjbLeADq8QT99Ia+7
 p7KtEXyKoJqXJYK/kIirZ+wMO/8eeVQhpCbo/fuZcUyhEM19xEzD3dqevmWu3y5iA0Wr1
 Dwx28iDiHVTPPfh3haIIl8Vvs0lhL3HSZw3K1wcGuX5VfV84oTRt3WOb79dSfGc24sRE5
 QOz39a1uYXRN0cZIQuHlh2WpPZBgI8VbQr3X71VDNChyTLcBY633jwwS2M9UHJwiU8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3CC731F000C4;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625444;
 bh=Mtx3GfnLXp4Rhzfjhr++N1BEMbALLyD5gvT3TXKN8Ck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=FSpL1NfUz31Otrq8x44qVyYkWJ5L6lejsdqCgJknMtF1l9CzGMXjKaRdUQtGGqAvQ
 M8lNrKRRYlOTkT0X8OZRASCyYXSw0WgcxamP3olpJyGfQPxZVqCFFWqoWxFxseRY/E
 5n4N6r3vdIhfJbCHFqdfYhlo050LYvDLBkvGk2oH2AD8Bt7QoN2TCjWdTtRkex9JNV
 od7WK2Cqpa++GZBxhIVMO3tiLibsXHwlH7oRSga014ozD8gZE7th7C/YdQtmhrY0No
 5DCMbW/trQ4BJ18cFC8fvac/7RUPV2rceQUX2t0xNRyxuvYsvJzjNosa9dgLBY/KgQ
 E2mDASIR6UHHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A705449C4B;
 Sat, 14 Nov 2026 03:04:02 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Fri, 13 Nov 2026 22:03:21 -0500
Subject: [PATCH 1/5] drm/amd/pm: keep smu8 sclk level lookups within the table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-smu8-overdrive-v1-1-763f07bdfca9@etsu.edu>
References: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
In-Reply-To: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joshua Horne <hornejd@etsu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625442; l=1580;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=Qw7ty5DZi+616ScsabYegzMjC3dI6GW4j0+vEMg4yZ0=;
 b=a1RH1Nq3WCshMtEv0rpbnrYJ3IMr5u998eGY8joSEyNDTw5z/ZJGR/4hZPM6PcQQwQC1MEU0Q
 ZS8Zgnn5j1TAbv/31Qe7YGPdqbGaqzAP0oKiYYAgJVs14wF8m3xGLWl
X-Developer-Key: i=hornejd@etsu.edu; a=ed25519;
 pk=HNOtiwerBbrJhfhzLHLxj3GDsUH9udRXflqnaI8sQmQ=
X-Endpoint-Received: by B4 Relay for hornejd@etsu.edu/20261109 with
 auth_id=1469
X-Original-From: Joshua Horne <hornejd@etsu.edu>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: hornejd@etsu.edu
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Horne <hornejd@etsu.edu>

smu8_get_sclk_level() returns the table size for a minimum clock above
the highest level and -1 for a maximum clock below the lowest level,
and the callers send that to the SMU as the level index.

This happens each time DPM is started, so at every driver load:
smu8_program_bootup_state() looks up the boot engine clock from the
IntegratedSystemInfo table, which is below the lowest graphics level on
at least some Carrizo VBIOS images (200 MHz vs. 300 MHz on an
A10-8700P), so PPSMC_MSG_SetSclkSoftMax is sent with 0xffffffff. A valid
limit is sent shortly after when the performance level is applied, so it
went unnoticed. The display's minimum engine clock is not taken from the
table either.

Select the nearest level instead.

Fixes: bdecc20a986b ("drm/amd/powerplay: add Carrizo dpm support")
Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 8f82d7c07e8c..f17894b5301f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -123,7 +123,9 @@ static uint32_t smu8_get_sclk_level(struct pp_hwmgr *hwmgr,
 	default:
 		break;
 	}
-	return i;
+
+	/* a clock outside of the table selects the nearest level */
+	return clamp(i, 0, (int)table->count - 1);
 }
 
 static uint32_t smu8_get_uvd_level(struct pp_hwmgr *hwmgr,

-- 
2.56.0


