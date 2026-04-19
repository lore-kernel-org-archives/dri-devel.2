Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E8EA71A1
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 14:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8021F10E204;
	Sun, 19 Apr 2026 14:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="JmLxZpJl";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyC8Kdq1";
	dkim-atps=neutral
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C4710ED0D
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:45:55 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id B0B7C7A00AF;
 Sat, 18 Apr 2026 20:45:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sat, 18 Apr 2026 20:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 ethancedwards.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
 t=1776559554; x=1776645954; bh=+ryyt5gM1krKhmzbZX2sB8GTsWehBb0P
 fTP5kNNxTZg=; b=JmLxZpJlVmeyaQMDetTvMd4A9wORwND1+SYKtinYyFCappTP
 g0y/hc4R1WfzVQs5ONHLCeSm6vM4tUH4kioMD1NngbWpun4faUNymIBbUrPf6/2Y
 qxyJnWwhj61HhfD6R5Wx6ZmmnqAt+5mb63M/aZmOgs5MzkCF4xqGPY/4UZ6wG11j
 ejIPX8boRdfa3gYe+lSkEtZ8Mmb+U7HLhL1Pda5en+G1PDJXy1OM90OgYTXkQzMx
 jdzn5eLxt+54xs5EvEX6fAsYeGMgtT7JOE0L3Um/qRJwOmq0SDBnga8RoQ/RfIXI
 IdTVq1v0Lm0XMu15kb2eNAmTmk51/hdpKpZXBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1776559554; x=1776645954; bh=+ryyt5gM1krKhmzbZX2sB8GTsWeh
 Bb0PfTP5kNNxTZg=; b=lyC8Kdq1pzb912zWR0STY1SWLvHA/dXKhq3NZOf9HBHf
 Bp0sag3HM1E/XHXFCo1bwtUbdx9DQ6vIHCS7L7hjqlayJX6lXn1ZbIZFFd0yt1V6
 9vsUIsA7hJ5hj96fo4hAkV1El4EMaCuIntY9ATo3ZFXZvZhXU3HTscH9T7FTbR7n
 lI54rN2QPURcDfUM1Wvbh/SbjTqoRLvLdkkL54pLcT4fmz3pQ7B1NgQ0CwNkKMHL
 g/yHma3C/YKonW2IVwgYOaCJ6uumFWv8nmC/81O6VJlg79KxMElKpbEIfqcjfLM2
 RPSoajUqSCeylXBttDryjAqpurW2qM/ROx3C5TKNaQ==
X-ME-Sender: <xms:wiXkabXJ4dbJYKvhYCArf57xN34CfI-sSuKvxKSBh-h6bSgZY8Nz_w>
 <xme:wiXkadmdILdjVWgBV_QctuWBC1ntem82xSWCA8lmXBQyxSpKF0voTYwzjWxJsFbF4
 PkATUjwEHXtKjTJlkxyVu8laID1HvYrOw4kXvS2YtgqnOeKyAujTEI>
X-ME-Received: <xmr:wiXkaeC5_iDgoYRbURVqEdFl92f9QLDvQIwUn7sB6SoC_91kIExMgIdeykvD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgedvgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepgfhthhgrnhcuvegr
 rhhtvghrucfgugifrghrughsuceovghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtg
 homheqnecuggftrfgrthhtvghrnhepieeuhfeuhffguefhffekfffgtefgjeeghfdukeel
 vdduiedutdffffeghedtiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepvghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtghomhdpnhgs
 pghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvlhhlvg
 hrsehgmhigrdguvgdprhgtphhtthhopehlihhnuhigqdhfsgguvghvsehvghgvrhdrkhgv
 rhhnvghlrdhorhhgpdhrtghpthhtohepvghthhgrnhesvghthhgrnhgtvggufigrrhgush
 drtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghs
 khhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
 gvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhhsehkvghrnhgvlhdrtghrrghshhhi
 nhhgrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhjrghnihhtohhrshesvhhgvghrrd
 hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wiXkaUhirGKZwNvgH9flKBReUuSEEZRiTTUoiCaBwhguKIuvI7f4Mg>
 <xmx:wiXkaTzZ1XBqTQp_KPc279nJAb9WBizZsh2hEgpxf3ogOD9cii7xog>
 <xmx:wiXkad1GPaouBjiDbYXS295GTUWqwEQorgzvqEb_X80N3Qu05vRc6g>
 <xmx:wiXkaQ-PmwoN_nYFaWln_-O_6OD3CrXzMHf7MT9bFlfVPEBOHKIeJA>
 <xmx:wiXkaW5HTpeMoaOEHxiKTQ7GTzq3CbnA4wHDL049LWB3GoIr-hExa_rX>
Feedback-ID: ibf9e487c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Apr 2026 20:45:53 -0400 (EDT)
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sat, 18 Apr 2026 20:45:50 -0400
Subject: [PATCH] video: fbdev: aty: Fix spelling mistake "enfore" -> "enforce"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-radeon-typo-v1-1-8e075365089b@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAL0l5GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ML3aLElNT8PN2SyoJ8XUsLQxOLJMtUozRjcyWgjoKi1LTMCrBp0bG
 1tQDevMZhXQAAAA==
X-Change-ID: 20260418-radeon-typo-98148b9e2f37
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=GNU/MRGok5zFJKRq5TRgaA/qhTEKDgwPGLJNEKyjzuk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpENVJQZmpEU1plYjcvZWZONWMrRzZ5M1R2QzZ6UFUzCjZNc2FuUzkvZGx4VTBqSC9Y
 cGZYVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0lrY2ttRDR
 aM3VXYStxRHByUkptNFRyV1h6dmY3WXhmN0ZEOHRQOUgvZjJuZS9RbU13NTR5ZkQveUR0NTZlMA
 paeC9tZExIZ1kvZHB0WlRjdkVIeVdOSDhsVE8vcjlDKzkyZTNEaXNBQzdKUmVBPT0KPThUR3cKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Mailman-Approved-At: Sun, 19 Apr 2026 14:39:49 +0000
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

There is a spelling mistake in a comment. Fix it.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/video/fbdev/aty/radeon_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index df55e23b7a5a..621d13a1a1d9 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -654,7 +654,7 @@ static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
 {
 #ifdef CONFIG_PPC
 	/*
-	 * LCD Flat panels should use fixed dividers, we enfore that on
+	 * LCD Flat panels should use fixed dividers, we enforce that on
 	 * PPC only for now...
 	 */
 	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type == MT_LCD

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260418-radeon-typo-98148b9e2f37

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>

