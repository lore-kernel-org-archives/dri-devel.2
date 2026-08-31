Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F36C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097DA10E881;
	Mon, 31 Aug 2026 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TyKEY9e2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457F710E884;
 Mon, 31 Aug 2026 13:42:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E4D0416FD;
 Mon, 31 Aug 2026 13:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA761F00A3D;
 Mon, 31 Aug 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183722;
 bh=0t7owjKK3meNtzZcqD3hi2vRM8HWlCZMjlHj7otn3/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TyKEY9e26OH0IKYGeLL25nE/Ht9cUFR9XWUisRkWNsPP/VbG6tUzk3ReJPnqLKe+t
 PH5Y65ZLECrmFD/+x9V4Hq4BaO+q/1y0XRq7YPG25KgImcJC72/oSok8fSJSJeiyrH
 n8MUCS1AudfSL+YMJ/UDeEBe/UKk2V180oU++SM3s+Xv/o20B76ueiNCiQ6QnCsF3L
 x/18TAjTVVTyoguiFMx6lHFnQBvp7qXwGoHUEYB2PUGJV1vlWfkTksdEvmAy0G/kX8
 G4FLxEicqwRBtjhyojmMHQwacEKdnxjt2cBC4hBOwtumQEVu445v8jm27+0Cjko3xW
 DXRrFqIU2JWfA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tom Chung <chiahsuan.chung@amd.com>, Ray Wu <ray.wu@amd.com>,
 James Lin <pinglei.lin@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] drm/amd/display: Fix CRC open failure
 during active rendering
Date: Mon, 31 Aug 2026 09:24:53 -0400
Message-ID: <20260831133314.4125787-265-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
Content-Type: text/plain; charset=UTF-8
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

From: Tom Chung <chiahsuan.chung@amd.com>

[ Upstream commit 5eb2fdafeb6f4a442643b77a21a4c9e70586a146 ]

[Why]
Opening the CRC data file during active rendering can fail with -EINVAL.
The wait for commit->hw_done returns remaining jiffies on success, but
the CRC path was treating that as an error.

[How]
Handle wait_for_completion_interruptible_timeout() correctly:
positive return as success, 0 as timeout, and negative as error.

Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The 6.18.y backport check found no “CRC open failure” commit in
`v6.18..HEAD`. The fix exists only as candidate `6ad40a4a964c0` on the
`autosel` branch and is not in 6.18.43 HEAD — the buggy `if (ret)` code
is still there. Verdict remains **YES**.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index e20aa74380665..596a97092e0dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -584,8 +584,13 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		 */
 		ret = wait_for_completion_interruptible_timeout(
 			&commit->hw_done, 10 * HZ);
-		if (ret)
+		if (ret < 0)
+			goto cleanup;
+
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
 			goto cleanup;
+		}
 	}
 
 	enable = amdgpu_dm_is_valid_crc_source(source);
-- 
2.53.0

