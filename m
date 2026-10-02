Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B99CA5FE6
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2A410E6B2;
	Fri,  2 Oct 2026 21:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l8WFAk//";
	dkim-atps=neutral
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com
 [74.125.227.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A0410E6B2
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 21:55:06 +0000 (UTC)
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a6f8525bfbso7838a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 14:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790978106; x=1791582906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwlbxNoSoLRMmJKLl4CKJFzcuVtF8rGKpkUB89vx4iQ=;
 b=l8WFAk//MeiZiMtIDpfIm5XPUw/kfKerJXksV21QuVjBUy6tFiXIVhHPuY8aLdB65Y
 8IPWTOoIJL3vCaJKcPgQ04B7FjFJY6izNG3iF+zBABijreCp+HnenehOAMMYVpfvN4ZM
 P8CTHBWdvp94HQ/K+J8963EhEMU5SjyjpyiwkwIqSRsiMRHXwrIEATpjEB6Hs/AYpZB5
 wlWV/6nv7a2cIrzG0xFOTX4fZi9QdG75ulUdeJ31PZk9XS+IsB+GcwHUrXZWgf5VRWsQ
 nXaVLx1OhMKq7YXWZPFv7OwOzJfT0YEiZnWUP4yooxW3PnsVclm01L1uRdw0zqZi+7N7
 z++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790978106; x=1791582906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vwlbxNoSoLRMmJKLl4CKJFzcuVtF8rGKpkUB89vx4iQ=;
 b=afXW8zXzaX8iufsQUeo8Un8alKIYLddBCle/lPGTrXW7JTQeSf4CawussMgEW51d4W
 JphKXXRNzqK9PxG1rgYXOwg7QjadfCOfnxp+TMQ/AYI+zfIjORB0nR/NLjDtoIv8J+we
 Nc9v7l9TsT8c8Gjdpu5qs2lLToXdErrbofL62egtQ3Tj+C5MzLRjZut+PGz9GPU/1FaG
 u4PWoYs13TieB3bh68OQrGh+HI6H/o992UXmNHBhGI3EevhpYQLgkasi9fgvmg6HSexL
 cCeQ3mhYWaIaIcFFTyAp9pi2XP6xx9wQ93SrrRATbzw2auRRKxtvzPEEJ9s/gYS6KWoe
 f29g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2pjzKMU37P8eEIyxw1LVPAIkxfhPQ49izNg/C6GuK9zyDGSOr8y8ocfWTqBFBXsF5SRRYLfw5/08=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKym4upXyrXZj+KPbsm6MRyePyEs7HySR4p8PWKW4h179tmc2CZ
 w9ithPIOEmFbPlFHz7KKRoKi57q/TsZcmdx8cFDKtnmYybSeEFApvFkO
X-Gm-Gg: AYBFou3uo/M2xBry4KL+CCzSnOktOuWA0HNbdaCGhQ3KbjUGfYW5BZ4bBCPIsqB09uk
 QVa0TvTevlDOYzEnZq2azL/UvLuLg/edm84spJRjXtABiT5wsyxFud7EivWnMB+z7Vwi6Jc05Af
 kyWaWL+5/EidE4w2UodFKf5zl3+wLaIXwJdN7cclotX4+sa9jjunIm1K4839U+ApFxVZY6vR73C
 gD410Ss20y0O17EmcCQa4k4qgKMkc536naxW5rg2CaK9VoUG4Viwuch7Aktw+pwB+nk+RtJ0YLt
 Nq5EBTZEUf1c12fn7S0fEvdyuqFfLzC9pikgJFwY4dNE/uRohW/ldYah9wSEOSXnSX1SCxi+yXQ
 IbAvODx7qCdhY3yW3xSYVMzawu3o+Q23NDu1C+CddZzzFxcvY3KiZdco+vHX+b0AE6+dHI0cv04
 Q4jzAIL9nnYv2QLSR7XD9KbYLwEomHprEhts2MHMoma+IExgC40skNtgut1TxPu0yrFPmn3Dwh1
 oau91TifXOJiq0MhRt5bNaWVDo5K9LIB/aN5wMiy9JHMNe+hX8nEsE+EgqoDCsZeM+wP2IA1V6h
 093mL6+ZJvaEKqokAztLLBuEB8QDU93s+62EY6Pd4tpCnQk=
X-Received: by 2002:a17:90b:28ce:b0:3a0:b40d:827 with SMTP id
 98e67ed59e1d1-3a6f321f4b9mr1342400a91.0.1790978106232; 
 Fri, 02 Oct 2026 14:55:06 -0700 (PDT)
Received: from 0xiviel.ip (122-63-128-121.mobile.spark.co.nz. [122.63.128.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4a1bfesm185515a91.12.2026.10.02.14.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 14:55:05 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 sashiko-bot@kernel.org
Subject: [PATCH] accel/amdxdna: document trusted mailbox ring geometry and
 drop the power-of-two check
Date: Sat,  3 Oct 2026 09:58:14 +1300
Message-ID: <20261002205814.178031-1-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com>
References: <67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com>
MIME-Version: 1.0
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

The mailbox ring buffer geometry comes from AMD signed firmware, through
the management or mailbox information block, or through the CREATE_CONTEXT
response, and the driver trusts it by design.

The power-of-two test on rb_size was a firmware debugging aid. Nothing in
the driver derives a mask, a shift or a modulo from rb_size, so no code
depends on the property it tested. The ring index wrap is handled by the
explicit comparisons in mailbox_send_msg() and mailbox_get_msg().

Replace the test with a comment that records the design, so that
automated review does not flag the absence of a bound here again.

Suggested-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://lore.kernel.org/all/67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com/
Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
The pkg_size check in xdna_mailbox_send_msg() is left in place on
purpose: it bounds a driver-supplied size, and with Max Zhen's pool
patch (20261002161122.1350075-1-max.zhen@amd.com) it is the only bound
on the write into a pre-allocated message slot.

 drivers/accel/amdxdna/amdxdna_mailbox.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
index 05c3786de135..c4a36858668f 100644
--- a/drivers/accel/amdxdna/amdxdna_mailbox.c
+++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
@@ -513,11 +513,13 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
 {
 	int ret;
 
-	if (!is_power_of_2(x2i->rb_size) || !is_power_of_2(i2x->rb_size)) {
-		pr_err("Ring buf size must be power of 2\n");
-		return -EINVAL;
-	}
-
+	/*
+	 * The ring buffer geometry, rb_start_addr and rb_size for both the
+	 * x2i and the i2x channel, comes from AMD signed firmware, through
+	 * the management or mailbox information block, or through the
+	 * CREATE_CONTEXT response. The driver trusts those values by design
+	 * and does not bound them against the mapped region.
+	 */
 	mb_chann->msix_irq = mb_irq;
 	mb_chann->iohub_int_addr = iohub_int_addr;
 	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
