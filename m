Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B114606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SakcjKrb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAF510E56E;
	Tue, 10 Nov 2026 02:04:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493B610E3F6;
 Tue, 10 Nov 2026 02:04:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCE404237F;
 Tue, 10 Nov 2026 02:04:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794276268;
 b=ryu4lPEWi0na9AzqshXhH8nlhGd/Dir2MgPascJwVKi4q6QEGC6YEeJj8OHWKXgcb8j0
 2tVvimVw2Y7Wv0CyQjy9Not87yhcmq8viU0E0A0FmOxlWlMPt5V0mvdcmPP96sCGeOaFT
 RTCk1SKoxRVjj54f91D7EayX/TrJ6H9bq9dzPC7bR0cQgyjaufaLNfREyTGA5p8t8X8bI
 0pkibxLG90wbFtdW4EEmHrrzCo1WK/EbPNJUxDEZYje9FlDEyuxWnTDQBxS6SQaSKJBU1
 fxiNl5R0ElEwTarbseptwv6fBj33v8wiSJD3LkFzQ9j3GgLPzWakJbp7EDtf3AKG2xQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794276268;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=QL5/saREYS2ytipt1kpYCkZKYDA0eyUnzzTzKFGrWZE=;
 b=Z+9W4nUpGjRtGtvtdi3IBkPZEYt3SCGd/1VoOYnX7tpk7upcp54zqRjtuuhHnMl+xKG7
 bwZJCWlGVx2ZANCU9FaPuxNXAa3kJEmp7vkvttoDqRK/zzGge88B/7LjApFIOAfnNlgCn
 NV9yOXN9kMNc69686Ead9S/EBg9IrvzD7Zphoiqrf5u7eoB2iH+/Y4R1cva595Ve8ISf5
 MMVyl+FevLsstdPQmqSgLBWSkfikGDwl9Rv0PCPwYaJ+p1FkSlBMrotFNfhNqN0VmivCD
 wxb9ECtV2tBHnz+2erlJsx5WuqE7R1B2lb3lJGwd3a9p5kGt79P/G8GjheydB9Cx4dA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 11F411F0089F;
 Tue, 10 Nov 2026 02:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794276268;
 bh=QL5/saREYS2ytipt1kpYCkZKYDA0eyUnzzTzKFGrWZE=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=SakcjKrbS4xHKcuIGHFDW9gLdt2xr8z2vg63CFCKQvE2mR7kNL7IKNc3qw6Y3ey25
 bWy2xLEWBBC21Z3Sr+BmBqTIer7CgfNPK00ssaO8zaACprPXOe53WeOu5zK7r+oQJ0
 9vXorVXDVpAIFZBx1svu5r7Sk0V0wCoesyXbw2n+LAvxofiPvklhlM+KcvaQMagEhm
 E1ZeoeWY3QELVjFVYi8qh8ok1Saa22vUJvdNzWbniVW0wRWk93Ca4xvjiO9s5vF5YN
 JvsnqNDXtdRVfSpxdZLA2Rjby+lBVIctFgvwGtdb32i7qLCnRwcxercSSTchld58fI
 oOCWxT+qC57YQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 644E94875B;
 Tue, 10 Nov 2026 02:04:27 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Mon, 09 Nov 2026 21:01:45 -0500
Subject: [PATCH] drm/amd/pm: send smu8 sclk level indices, not the level mask
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-smu8-sclk-fix-v1-1-47c6c0c8c2c9@etsu.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNL3eLcUgvd4uScbN20zApdo9TE5KREo+SktGQDJaCegqJUoDDYvOh
 YCL+4NCkrNbkEZIhSbS0A6099aHEAAAA=
X-Change-ID: 20261109-smu8-sclk-fix-2eacba2cbfc0
To: Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Eric Huang <JinHuiEric.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Joshua Horne <hornejd@etsu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794276267; l=3289;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=58O5MHeXCEaVD9HsyyZFkQq4n4nbwD/ow9aQHlfmGAI=;
 b=7NCjH5LDUPWBhzAljm0F65Im6wf9GUvisZyEkg17V/rX8UK+kyCSlYt68xZyk4rCmJRF7jaLM
 Uw13hNjQa9bD3HQbVNQ4VUXfHUjJlhwfDY+OtCcgmAqm6N/JfXh4qna
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

smu8_force_clock_level() passes the pp_dpm_sclk level mask straight to
PPSMC_MSG_SetSclkSoftMin and PPSMC_MSG_SetSclkSoftMax, which take a
level index, as the other smu8 callers do through smu8_get_sclk_level().
In manual mode, "echo 0 > pp_dpm_sclk" thus selects level 1, "echo 2"
selects level 4, and masks above the highest level index are out of
range for the SMU, so e.g. "echo 3", "echo 7" or "echo 0 1 2 3 4 5 6 7"
do not select the requested levels. The original single level version
sent 1 << level and had the same problem.

Send the lowest and highest level in the mask, as smu10 does, and reject
levels above those the SMU has enabled, as smu10 and vega20 do.

Fixes: d7341ef66870 ("drm/amd/powerplay: add some hwmgr functions for sysfs interface on Carrizo")
Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
I found this while working on overdrive support for Carrizo/Stoney on my
laptop (ASUS X555DA, A10-8700P); that series will follow separately.

Tested on that laptop, 7.3.1 with this patch applied to amdgpu. In manual
mode:
- "echo N > pp_dpm_sclk" for each N from 0 to 7 moves the current level
  marker to N
- under GPU load, "echo 2 3 4 5" keeps the clock between levels 2 and 5,
  and "echo 0 1 2 3 4 5 6 7" lets it reach level 7 again
- "echo 8" and "echo 0 8" fail with -EINVAL and leave the level unchanged
Without the patch, "echo 0" selected level 1, "echo 3" and "echo 7" did not
select the requested level, and "echo 8" was accepted.
On amd-staging-drm-next the patch applies unchanged and builds without new
warnings with W=1, sparse and smatch.

I used an AI coding assistant (Claude Code) while working on this. It
found the bug, wrote the change and a draft of the changelog, and wrote
and ran the build checks and test scripts. I reviewed the change and the
changelog, ran the tests on my hardware, and I am responsible for the
patch.
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 8f82d7c07e8c..5a3f697a37a2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1483,15 +1483,25 @@ static int smu8_store_cc6_data(struct pp_hwmgr *hwmgr, uint32_t separation_time,
 static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask)
 {
+	struct phm_clock_voltage_dependency_table *table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+	uint32_t low, high;
+
 	switch (type) {
 	case PP_SCLK:
+		/* the SMU takes level indices, not a mask of levels */
+		low = mask ? (ffs(mask) - 1) : 0;
+		high = mask ? (fls(mask) - 1) : 0;
+		if (high >= min(table->count, smu8_get_max_sclk_level(hwmgr)))
+			return -EINVAL;
+
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetSclkSoftMin,
-				mask,
+				low,
 				NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 				PPSMC_MSG_SetSclkSoftMax,
-				mask,
+				high,
 				NULL);
 		break;
 	default:

---
base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
change-id: 20261109-smu8-sclk-fix-2eacba2cbfc0


