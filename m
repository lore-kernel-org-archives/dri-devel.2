Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87559606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5KSnCc3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22CE112E4F;
	Sat, 28 Nov 2026 00:15:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227B9112E4F
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 00:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B846045131;
 Sat, 28 Nov 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795824946;
 b=0G1kl51kUIBufk8zyKl2SAzsy1WvmNI7UFnAsTeZCxvB7sQ9a6htL9K2TuA2NuVO4any
 xDqWuyqr6b65Da7nhUs9Tr68Hynvb1C/FZpJlip5X2O2VSOuQv1v8WW7c9y5uoYQtZBmb
 afDvor+zdGxpJ+GsV30CHIj/9RW8/WL1zJUHDpF+YXJ46R2wheZPKfpEBDQPQjg/4NAcb
 NiVWV+56SpQM00H0RazITZkQcjrcvuo+s/EAZqTGOtQ8KTBUsuQ+poKCdj9PM/zGemYzL
 Ta46xeqC0MStz71YJBAL147LwAx2uGzHOX/52BPTAoPtg+pLecDLMrmYl687fXtcacQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795824946;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=EkG+Dr/aMoMzUSj5tk5nyxA5r22ol56pbCQ3Z9eMFeE=;
 b=HFcgasndquT2PBlmAW6uJ8QAi5DtjcLIDB0aVfdB2UHwjbORsN0U8IazmQj8b8SlkGxg
 ei+H9ix3ltYHoGErEk7yOEXDqqVyqSabC8P+kn1I5psv/0Lr6J5AKG1M/b3bFadIqEXhJ
 y5Jo4ExdfCuL0cnJsGnz0i5++2UD84hQumm5JgSqjJvAc7zu3pvMmftnxsAlz3MDLif3c
 uvwwU+jfywK+USqPaiVKdCoNOjDF/A2Lxvqrg0oBZYxUzWOMObXQN8xw0bPLVllkoD3aR
 +qWlxuwHwBudx0jhA3kXFoQqmNPO9wlu4waHWdeHN+CV47sUxug4oc9Zl4jxuEp740w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 557E91F000C1;
 Sat, 28 Nov 2026 00:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795824946;
 bh=EkG+Dr/aMoMzUSj5tk5nyxA5r22ol56pbCQ3Z9eMFeE=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=X5KSnCc3RR5u9MtXkP5u6O66AlVgZNLqKGyvC3Gxpr0NoHSPrA1vQ9Tu5h4N5M2a4
 EYF9p9APgQMlLakThl6BihyrKLVHfZwJhMC6oZjsfHZcNr4SDmZKorpvudQuSzPmpR
 J8AznDSoGXwuwlkE1wmm3H6380uv8d1YGDo/ogHhBCoUHiy8hxyQPBNajG4uVp36wP
 CclKdQDZSTR72+OdYiY22RPWVKUnFrmhPYVj5oE130QFJJKh9WHteSCuoRiGw5AHb7
 jupn9/gp+Hp/t6YuckcoT8biTQ6uv2Hg/ugKoDiWTwuLpA+aIkLrSTocmN44YwD+0F
 CBWHYQHl18etA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D78BC4DEA9;
 Sat, 28 Nov 2026 00:15:44 +0000 (UTC)
From: Felix Huang via B4 Relay <devnull+akafelixab.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 19:16:55 -0500
Subject: [PATCH] staging: fbtft: fb_tinylcd: align arguments with open
 parenthesis
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-fbtft-align-v1-1-92de6f92ebe8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3bSkkrQS3cSczPQ8XdNks8TkZEtzY4ukJCWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgBeq9lObwAAAA==
X-Change-ID: 20261127-fbtft-align-5c6acc9738bb
To: Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Huang <akafelixab@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795825022; l=1084;
 i=akafelixab@gmail.com; s=20261128; h=from:subject:message-id;
 bh=I+0cYZeTLzqxiZSLHzV9PNt605lEdXdHOIenXaZROZ8=;
 b=JmL5hJ8fJbaXQJtTCdgX3n0mKDHm2kGaJuFYf4Oa/FIgQJFLQTK1Mgd97AahsOxXSa/QS/nvK
 lZUCN+x83s7AA+GfI4FqTaz/m1ZQyf/tPe4Bc4ogDfbSW8kAEgh1B2z
X-Developer-Key: i=akafelixab@gmail.com; a=ed25519;
 pk=Axl3BM1UWa+m0/AWcEhRIdIk/WY9FnY4wZkyQn64uVY=
X-Endpoint-Received: by B4 Relay for akafelixab@gmail.com/20261128 with
 auth_id=1670
X-Original-From: Felix Huang <akafelixab@gmail.com>
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
Reply-To: akafelixab@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Felix Huang <akafelixab@gmail.com>

Align multi-line function call arguments with the opening parenthesis
to adhere to the Linux kernel coding style and fix checkpatch.pl
alignment checks.

Signed-off-by: Felix Huang <akafelixab@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c74..d58b12472 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261127-fbtft-align-5c6acc9738bb

Best regards,
--  
Felix Huang <akafelixab@gmail.com>


