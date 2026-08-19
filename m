Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6C3C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD43510E582;
	Wed, 19 Aug 2026 18:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NMe7e2UW";
	dkim-atps=neutral
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch
 [109.224.244.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97BD10E582
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1787165208; x=1787424408;
 bh=hMJu3QgsZs8TCdcBeB9Zz/yumkYg03H4j+Dga41n/50=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NMe7e2UWqM+nAb+bPKyYr16+vNBTbmmSDyG7lGu4Df5V4j89vLuLchuZ7O/Gdjun2
 vlNU0zHB3oB20JW7Bd3vdg/j31x5A5K/v/iAGhgqKd4rwfr2HOJdEDiS/edAvlvDH3
 Aurog0mhjDnaj/iEgH7UKMB9HTKaRKKeOZDTItFCAefjKfme/kH2xhMYSyFm0WxwcX
 rnzpxx5o0VeCvk+bp+5VeL2eUC2k83a07M0GqZTfVcRhmPvxEUqP8KJRDTynJmicEi
 y5qPShEP6jVeOPEHpY/vIQOP+zqndidqgQRXg/isWrA+1VkNjSEp27MOzUIla/Rn/l
 qkTWNqX7zA0Ag==
X-Pm-Submission-Id: 4hQFsf32xKz1DDLh
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 1/3] drm/tyr: clear stale IRQ state before soft reset
Date: Wed, 19 Aug 2026 21:45:39 +0300
Message-ID: <20260819-tyr-reset-impl-v6-1-7b4e1e041fe5@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
index c5063b2be94d..90d6cd988cd2 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -86,6 +86,9 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
 }
 
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
+    // Clear any stale reset IRQ state before issuing a new soft reset.
+    iomem.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
+
     iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
 
     poll::read_poll_timeout(

-- 
2.51.2
