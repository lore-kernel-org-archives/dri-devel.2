Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94360A262F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=k+4GV8MZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450E911257D;
	Fri, 13 Nov 2026 14:33:46 +0000 (UTC)
X-Greylist: delayed 85861 seconds by postgrey-1.36 at gabe;
 Fri, 13 Nov 2026 14:33:40 UTC
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF8F10EC04
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794580418; x=1794839618;
 bh=axQDKUzAx8Pm0m4ncArYXg4Xi4s26jXTvzsLHd9rKhE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=k+4GV8MZMnZb6ynN31sjs2G2FzQp7T4pNgf56eZx95l+WPXtsARwLbctIuJEzzvnQ
 Guv5PPwF8J4LtYzorgK5rVG53dvCcTsMCkxd/IBvXbI/4A0bW7mJGeKiHnq+o/6K+I
 IBUgufTKl9tRYuIK/9tv7ZhNXA+haClifL0G8UBaFz/uib5smxs6NVF2bsQywMSeyx
 fEp3rdMCPnViI+YO2ilUcbKwXaCdOQcLFlcvih9u7DlRfLKiZ8yp90yLPN8q0Br8DQ
 14JQRd75sHi9pWsTf6WhJCkzCPgUf56a9gI70KoulAj/UPW6fo6JbU0ErtZPi2o6Bg
 j4qwyxjzdiShw==
X-Pm-Submission-Id: 4jR09q0KkPz1DDrS
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 boris.brezillon@collabora.com
Subject: [PATCH v8 1/3] drm/tyr: clear stale IRQ state before soft reset
Date: Fri, 13 Nov 2026 17:32:26 +0300
Message-ID: <20261113-tyr-reset-impl-v8-1-2ee298ac9808@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previous reset may leave the reset completed IRQ set which can make the
poll return too early.

Clear the IRQ first so the driver waits for the current reset to
complete.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c2b99d67369f..5b57bc9a1d3e 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -87,6 +87,9 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
 }
 
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
+    // Clear any stale reset IRQ state before issuing a new soft reset.
+    iomem.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
+
     iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
 
     poll::read_poll_timeout(

-- 
2.51.2
