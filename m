Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E1CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7499210EC52;
	Thu, 11 Jun 2026 01:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ECISjwSd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QwNgjnwT";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8C110EC52
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:00:32 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gbPTC4BSKz9vNd;
 Thu, 11 Jun 2026 03:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781139631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDncZbVMMSc+BHIOspAcsIqJHhTcal4soa4ghV1QVjo=;
 b=ECISjwSdwODZNwIJa4ihFfq0OAZ2U+lFaAK3dQbuLARGgnJ/PkCMWIDto1/67slWhoJx9t
 UoPubEdRTP/ldqdP+KxLZzEfz6+soljbCC+KAfG6KtT5XT1yjPT2RDhmmuImAf0LULyDtp
 vIptmnaYh4KCuXGgBNADJNmjmw+i7qtxoIvkDLrxHKgPhQ2SA7SSg33XG8kg+7r8onfXH4
 uQ0qhSMicvBinWp7ngqJx16vjJSMZ5HMyPVu2F6XCylQsJaqRRz25RO4hToJgpJypJKB8+
 Xv1DeTuD7QtxMIbiIfXXE3nntko9rW23KG+zC+X2+uJZtW+tGTaj4nIBb6w5WA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=QwNgjnwT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781139629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDncZbVMMSc+BHIOspAcsIqJHhTcal4soa4ghV1QVjo=;
 b=QwNgjnwTQ1DlUwdFOxVTClqY4yr5JlTo0j14AtQ7WXxqo6H9XTaPFpkInZfCgPZnSVtDwm
 DzOkNAHkwf7bBJ1PEKCephoKHeUNmLFP4/ODwj+0q5MoIqN4yqzo8NK/b09hIjqdQZyjyM
 Isj9JTopaiUx1lDz2nthO6+G5F8ysW+iBN5vkORhiGBlMiaotzJsKCcp9T1ZqN6jcBMT/u
 6bf98WaEur7lYbsC8I4HYcXdA9sPWKJCBZtrtNGuN79Jj4e8HKPBs2r35CeELzTSy5OoZo
 VupdwAYKwp0y/71MYxNkmVN1RZq1aGuPwqc1Wc9yByLbABIZy/r3isk3EK4Zdg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Frank Binns <frank.binns@imgtec.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Matt Coster <matt.coster@imgtec.com>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: r8a77965-ulcb: Enable GPU support
Date: Thu, 11 Jun 2026 02:57:31 +0200
Message-ID: <20260611005952.146825-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
References: <20260611005952.146825-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3z87w3ndeakzfhsi4buxw55mu6h7mqt4
X-MBO-RS-ID: fc35fc77e4364adcec3
X-Rspamd-Queue-Id: 4gbPTC4BSKz9vNd
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

Enable GPU on M3NULCB with R-Car M3-N.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Matt Coster <matt.coster@imgtec.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 arch/arm64/boot/dts/renesas/r8a77965-ulcb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965-ulcb.dts b/arch/arm64/boot/dts/renesas/r8a77965-ulcb.dts
index 71704b67a20e1..127eb2ea3c920 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965-ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77965-ulcb.dts
@@ -31,3 +31,7 @@ &du {
 	clock-names = "du.0", "du.1", "du.3",
 		      "dclkin.0", "dclkin.1", "dclkin.3";
 };
+
+&gpu {
+	status = "okay";
+};
-- 
2.53.0

