Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB67C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FC610E279;
	Tue, 15 Sep 2026 14:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lkniws/F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E1310E279
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:24:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AF204327F;
 Tue, 15 Sep 2026 14:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29D31F000FF;
 Tue, 15 Sep 2026 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482297;
 bh=CLpKU5Ssyf0dnES8vm27XOqTWd6W03hYOuNf/eiRcSg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lkniws/FDYNSf94/J8rfOp5pqQd1/s3CpLkHDbVndd5JWb7RbH5AN4UUanR6z28Nh
 wCteXUpCO2q3/R73oF86kkurf7lscIMGQuZGcLWtV5GkZ4RWTzRHFpZEq4GaBDEt3N
 4Y7G9etyQ7ys/IB1cZjEBi8VH/td3qTBXsLNnvdEbNmRcokSqUDSL2zt+egmH9FMYm
 kbhkHYCB6jVlajggQsuO1AfIWl4MQkzQiB5GWBZVEYfH4AGgULM1rrBGfIcQt0FvYV
 Vt1TY6TSewgh5qnS7RVsV8bCMsunTJljDvTItxgom1FXvJtJcktjBKhniqPmlQBPmQ
 74LIGCD8v5RpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:42 +0200
Subject: [PATCH v5 01/11] drm/arcgpu: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-1-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JGkU53X3m7n+G0MDQKVvjwVXrG19wyxMYvIRwfCj13k=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ3XDtzvuSm2oXJFyzWHmO7nvqWci33/x0N/5IFx9R
 Ve3yWP7jiksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRZlXGip93DeqmrEy9++ry
 lsdZv59LXzm90oM9/uzUiH3rZTznd1yZvjoyxl/l9OZPDhXT/spdZ6wPyn3OwraK//7CZD6OWBW
 vzS2PH5dkh/eoSFyz/xf92OGz+UOHrPnBPAIPpW0SbfZplwMA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The arcgpu crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 19a943f5f792..aaf814c622b6 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -305,11 +305,11 @@ static const struct drm_crtc_helper_funcs arcpgu_crtc_helper_funcs = {
 	.atomic_enable	= arcpgu_crtc_helper_atomic_enable,
 	.atomic_disable	= arcpgu_crtc_helper_atomic_disable,
 };
 
 static const struct drm_crtc_funcs arcpgu_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state	= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

