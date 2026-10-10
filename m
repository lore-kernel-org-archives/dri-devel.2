Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B8CA9EC0
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A904210E1DD;
	Sat, 10 Oct 2026 11:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=zohomail.in header.i=linuxuser509@zohomail.in header.b="OYYSsvkv";
	dkim-atps=neutral
X-Greylist: delayed 912 seconds by postgrey-1.36 at gabe;
 Sat, 10 Oct 2026 10:38:43 UTC
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0320D10E090;
 Sat, 10 Oct 2026 10:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791627805; cv=none; d=zohomail.in; s=zohoarc; 
 b=QLOPbYtfRQDP4XpjsKqXwQJuw5VlNN6iYZWSdXkatGEfU/MEszeEuLFqQbNgIg05CIxeAWZNlDJVNd5emf/sCp0OwOk+tQGu4A8Jn3Q9w7h3PCPnfdO7Ukh23f36pOlCeyNx5QGS8VSmq6veoyGdoaqbsiPCR5iesM/UzbqKlYo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in;
 s=zohoarc; t=1791627805;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Uj61p2nyqPz0X8L7bYck75AAjf/48Y9e7L9N7YT6+Fo=; 
 b=Uvvg+8DOVYorLkCnxzL7K2WMmQMSEV9Kyk/V5la7XXrHeRQxRrz6pp/gM6u+7oLEILzL+jI+yBwnjCcf3yH6qiM7M3mPbGEILVMdc2uxid57oy/ArpYnMq6M8Yk+UqFHSw8bK0yvIlpfPIGFD7hF6kwzOFG1NLWwGen227ghUlo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
 dkim=pass  header.i=zohomail.in;
 spf=pass  smtp.mailfrom=linuxuser509@zohomail.in;
 dmarc=pass header.from=<linuxuser509@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791627805; 
 s=zoho; d=zohomail.in; i=linuxuser509@zohomail.in;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Uj61p2nyqPz0X8L7bYck75AAjf/48Y9e7L9N7YT6+Fo=;
 b=OYYSsvkv0FDplasgwICze7IfE274MoSbQwM2nHuz6SVF4Q9lS1v1hl3U0yeLsDfQ
 MmnagzcJ0YIhRJiY/ohFX98BxKCskD9CtWVxdD+ILFsOVNHRehSNjBTODtoLha02EJf
 F/HdJckfq5u4jCWzn2tPp5Ww18zDfmyQRUuWCS3U=
Received: from mail.zoho.in by mx.zoho.in
 with SMTP id 1791627800352565.0157336159798;
 Sat, 10 Oct 2026 15:53:20 +0530 (IST)
Received: from  [152.57.170.22] by mail.zoho.in
 with HTTP;Sat, 10 Oct 2026 15:53:20 +0530 (IST)
Date: Sat, 10 Oct 2026 15:53:20 +0530
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
To: "intel-gfx" <intel-gfx@lists.freedesktop.org>
Cc: "janinikula" <jani.nikula@linux.intel.com>,
 "rodrigovivi" <rodrigo.vivi@intel.com>,
 "joonaslahtinen" <joonas.lahtinen@linux.intel.com>,
 "tursulin" <tursulin@ursulin.net>,
 "dri-devel" <dri-devel@lists.freedesktop.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1a12556af17.597a885f7429.8559089497420287597@zohomail.in>
In-Reply-To: 
Subject: [PATCH] drm/i915/sdvo: Remove disabled HDMI buffer dump code
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

From cbebdc3b5dce2d4c0ce8c9b69c62b539fc77dce5 Mon Sep 17 00:00:00 2001
From: Ashwin Gundarapu <linuxuser509@zohomail.in>
Date: Sat, 10 Oct 2026 15:42:48 +0530
Subject: [PATCH] drm/i915/sdvo: Remove disabled HDMI buffer dump code

Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
---
 drivers/gpu/drm/i915/display/intel_sdvo.c | 30 +----------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 3075ef04df56..d9c6a620377e 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -974,35 +974,7 @@ static bool intel_sdvo_get_hbuf_size(struct intel_sdvo *intel_sdvo,
 	return true;
 }
 
-#if 0
-static void intel_sdvo_dump_hdmi_buf(struct intel_sdvo *intel_sdvo)
-{
-	int i, j;
-	u8 set_buf_index[2];
-	u8 av_split;
-	u8 buf_size;
-	u8 buf[48];
-	u8 *pos;
-
-	intel_sdvo_get_value(encoder, SDVO_CMD_GET_HBUF_AV_SPLIT, &av_split, 1);
-
-	for (i = 0; i <= av_split; i++) {
-		set_buf_index[0] = i; set_buf_index[1] = 0;
-		intel_sdvo_write_cmd(encoder, SDVO_CMD_SET_HBUF_INDEX,
-				     set_buf_index, 2);
-		intel_sdvo_write_cmd(encoder, SDVO_CMD_GET_HBUF_INFO, NULL, 0);
-		intel_sdvo_read_response(encoder, &buf_size, 1);
-
-		pos = buf;
-		for (j = 0; j <= buf_size; j += 8) {
-			intel_sdvo_write_cmd(encoder, SDVO_CMD_GET_HBUF_DATA,
-					     NULL, 0);
-			intel_sdvo_read_response(encoder, pos, 8);
-			pos += 8;
-		}
-	}
-}
-#endif
+
 
 static bool intel_sdvo_write_infoframe(struct intel_sdvo *intel_sdvo,
 				       unsigned int if_index, u8 tx_rate,
-- 
2.56.0




