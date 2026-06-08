Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F8DCD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E43510F5CC;
	Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="Ixts1PTr";
	dkim-atps=neutral
X-Greylist: delayed 1697 seconds by postgrey-1.36 at gabe;
 Mon, 08 Jun 2026 09:44:31 UTC
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com
 [203.205.221.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C6310F078;
 Mon,  8 Jun 2026 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1780911868;
 bh=gkEGl6klor+eq4IPgefmvgOhe0uBLMOYG1nnW7uhDxI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ixts1PTrxIvsqsJ31J0CfO0eICCfrZ91XlU/NvEW1Pq6K3XZ2V1BkDcSoO1nolWQ9
 0CK3Tq0mulnXVP/sLef8ql8HZk0X7Uir/or56k5Apa6J7p1m/GkXPAUGW44xmhaT69
 WU8u+0YkMFVen/3SiCii/U6wybgoqXbI+TvcQk0U=
Received: from chafi-Matebook-Ubuntu.. ([117.25.98.102])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id 32F830C7; Mon, 08 Jun 2026 17:12:47 +0800
X-QQ-mid: xmsmtpt1780909979t5qps3k3l
Message-ID: <tencent_F96A6D2FFEB6459BF167B2F2F27E8B016C06@qq.com>
X-QQ-XMAILINFO: NsH3EniEpYuY++gQphxxtp/UKwZBf4XhDzLzDtrRZifbrTQvBxvaNEq0FlYZbL
 3qBQKHdMw5W4QsLhqXaGMdfm39g98LLduA+c5gFDTrPAGre/FTj/68z2V3QbOvIWEea1Tml0OYKZ
 0e2K0fuB8TX3h6PpQi0C9D7H31XmQ+DZb4aQau/sAOvyZEe8/KhklLVHUhrGU+PG/kFAlSMvPowR
 jKJZ90m8aAcjQP2iDOjwCaQjyu8Mp4U+YL0SVLENDPsSQ6yIxDrOMLobvM3TghuPDgN/y1s5TnGu
 iPm5Oo4hmGU98luxc2/4W6z0URNdTbKCeD1f0FP76Qk00QJGb9kN7h9FjPW5o1QuJpCX4xIGyF7Z
 XF5yA+vE+9N1kw0ul2cnJnI4Q312pwmS5kDolmJ6kyUVznoE6OZbxmREmMNSL3RnKxT3iJM0NlC/
 7PfR0q2aWT25nZ3ycYymyACUujfkLtsu4QRzCA2fMkBtD46b+xVpiMHiDDljU79PrH8KsxODZ+/u
 w7on4AMawXrIO+0SURa/Gq4N0DNlhp9Dpc6WiIdhd6uD6xeVsOkscOM5KeKKrDRg33GSZ/wtcyr7
 vqyzmRCjxwDyWacQ80+lTJ64PJ+OFZNKRas8FrcqWNKDkGeTzlyViWMY1upQZoYOJ64OODUntFVd
 ZA08suZCY/AvfTBoy1ughid9o6a0TKe/ie1nErLzvBnoPIrlbFS+x68XNCIL0+QvzP015TZD9XL+
 05fjlVyFgcP3KDwiLGhTSGiDcTDICKMxHtUcVyHVH51M/Yf8i0NTHXw3SJw4BUqlCSfYp5Eng1J9
 r/l/HINXICrBL2IBjilcbeenPxfF5aNMLX/JUpcCQrNRL5UeiByLqbAD3WYBf5jF3mUwzFIAT3G2
 7FqyNNYCVnsKJBOOskMH9NoCcTOqyn+dKYtTw5woI+fxNyeugH5YE9lfeIbiry01q47d3z/XAh8x
 PdqWtk9xgbG/TXJnDNRWQ6N/qvfqcNn1DCJShy80Whwe1HCUlNwwfEoXdrHKsceeZIJ2qwHLxV1z
 /DqzRI52XYpXnlmqga7620aSnnqZ6Kc+/edfo7951LHBZuTexx
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: chafi <chafiprc@foxmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Yu Zhang <chafiprc@foxmail.com>
Subject: [PATCH 3/3] drm/i915/dsi: Fix TE pin configuration for dual-link DSI
Date: Mon,  8 Jun 2026 17:12:44 +0800
X-OQ-MSGID: <20260608091245.462464-3-chafiprc@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608091245.462464-1-chafiprc@foxmail.com>
References: <20260608091245.462464-1-chafiprc@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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

From: Yu Zhang <chafiprc@foxmail.com>

gen11_dsi_config_util_pin() skips UTIL_PIN configuration for any port
mask that includes PORT_B. For dual-link (PORT_A | PORT_B), PORT_A
still needs UTIL_PIN as TE (Tearing Effect) input. Without it, vblank
interrupts never fire and flip_done operations time out on command
mode dual-link panels.

Only PORT_B-only configurations should skip this step, as TE comes
from the slave DSI1 through GPIO in that case.

Fixes: 963bbdb32b47 ("drm/i915/dsi: add support for ICL+ native MIPI GPIO sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <chafiprc@foxmail.com>
---
 drivers/gpu/drm/i915/display/icl_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index f579cba28..cb60aad92 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1113,7 +1113,7 @@ static void gen11_dsi_config_util_pin(struct intel_encoder *encoder,
 	 * for dual link/DSI1 TE is from slave DSI1
 	 * through GPIO.
 	 */
-	if (is_vid_mode(intel_dsi) || (intel_dsi->ports & BIT(PORT_B)))
+	if (is_vid_mode(intel_dsi) || intel_dsi->ports == BIT(PORT_B))
 		return;
 
 	tmp = intel_de_read(display, UTIL_PIN_CTL);
-- 
2.43.0

