Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E80FF588C2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6727710E5F5;
	Mon, 20 Apr 2026 13:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tIxYgqBo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F422310E5F5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:18:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DBD0F442EB;
 Mon, 20 Apr 2026 13:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90172C19425;
 Mon, 20 Apr 2026 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776691082;
 bh=kJp0f3Qe7jghhdutSl0szZVzMtl5wM/wNl1r+wM57XY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tIxYgqBorjnK9HuIHcO+GJSv9HQUKNc5A3cQqPLNqiZL+22UBAFF8TnL+gu7NBykZ
 3C4ExeEuWayv+9lBCpTFDqkBHkitkgabywkdOsro7Ryc0pfAQA0FwQCBtGNtnhNFm2
 pouCZ56e4RqYcg0NWOQZ44lQjmmri9xSJZiPnB6G2YU43UE1jwYnp5ykakkqxEV0lZ
 gUgr/A+JNSHKLXu1CySzXWco+GBT84Lcnb8jo+jVIaY/z5D/xdfX+ePOwKOOXWX2nN
 Lc1LYzgkjUOexIHT1M+J5kpUOuYspZGm/2bdBSR9FN0crnicLsw0tg6LaSuZz2pAl+
 JroB3er6LFLwQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Melissa Wen <mwen@igalia.com>, Sasha Levin <sashal@kernel.org>,
 eric@anholt.net, airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
 maxime@cerno.tech, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] drm/vc4: Release runtime PM reference after
 binding V3D
Date: Mon, 20 Apr 2026 09:09:09 -0400
Message-ID: <20260420131539.986432-83-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
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

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit aaefbdde9abdc43699e110679c0e10972a5e1c59 ]

The vc4_v3d_bind() function acquires a runtime PM reference via
pm_runtime_resume_and_get() to access V3D registers during setup.
However, this reference is never released after a successful bind.
This prevents the device from ever runtime suspending, since the
reference count never reaches zero.

Release the runtime PM reference by adding pm_runtime_put_autosuspend()
after autosuspend is configured, allowing the device to runtime suspend
after the delay.

Fixes: 266cff37d7fc ("drm/vc4: v3d: Rework the runtime_pm setup")
Reviewed-by: Melissa Wen <mwen@igalia.com>
Link: https://patch.msgid.link/20260330-vc4-misc-fixes-v1-1-92defc940a29@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/gpu/drm/vc4/vc4_v3d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index bb09df5000bda..e470412851cc8 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -479,6 +479,7 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_set_autosuspend_delay(dev, 40); /* a little over 2 frames. */
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
-- 
2.53.0

