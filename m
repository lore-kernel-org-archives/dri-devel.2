Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EE606A33F
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fi/+4kBu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B7A10E1B1;
	Sun, 22 Nov 2026 05:12:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F3610E1B1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:12:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B0C660A9B;
 Sun, 22 Nov 2026 05:12:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795324341;
 b=vzcrYZFxB1IVfsmqCqYA52JfQU5Fh1v/uEgIHCnWoHSO7LCahCiMqZSdrDIElkh3c0Bo
 kMEdLtt21VssLt8vtHsvPtXCI3eBmO5W1awwjxAKGboYE7F+TSY7fvuE0o8scxAZiFMhb
 GiFo2jDzJMAkkULZ28HjoARFlU954JNZDGPWluHm6WGiW7CKM7lfpdD1y+Q2B0ZxJWZbl
 a4lJ/OAhssHie/KXmMS+z52mS7/Ci9H7SBEyXVSUfi+gI8VGLTBltz9facLy/7TnCzW6c
 CTuakz80+WMDf6t5z9LvxkLurh1z8He3xAcFS7+A6YRxwZuddJks7456gnaRnmRDEDw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795324341;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=4dbbCzZ75Q1GsplI4UC3NrZKwL01T+CKD3zQQuzUDZU=;
 b=2u7EvRHi/c7Z10Izg4ysbqY7gbVtmwsuHH/qzlzFxPQKw3jZ3nqXwSPzKbxnWPaS4GYr
 +u9ueRxZVN40kRvpHow4XJUaHjh2JFzYhPDORKXx4QzxzXlPqtuLVvcEGca/kaEA0SklE
 Ja/KWOTkcJ/VBdOT5d+tIQN+qknTvUmvEy/g9d7Y25ShpoYNG/4ip+6F3mARYo3rMXQ8t
 x411HesVfgOjFMTTuphstuW4PhvQHsMyf1G9A7bjJgtwN6jtnX88tY1OuhUJ0At5qiS8c
 /goZp6BhAbZidBc5OEJtqZJpWtGMc+MRbgE4pjVQ3lA71MuYocuI4tfbNsZVLiXnanw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D08531F000C4;
 Sun, 22 Nov 2026 05:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795324341;
 bh=4dbbCzZ75Q1GsplI4UC3NrZKwL01T+CKD3zQQuzUDZU=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Fi/+4kBuJLl2ummIONxC6uS58dl2SGBVw51ldLyi7JmYG3n3f8kpJSuVcWYhdK/uv
 2I585dyRvZTlOXD6HTKqEnGokMjBYxm9TIdcucFdaAviCpHHAPKvu4PxlMnTMbnYJg
 eC8JDMFsWpdkm6gSxObvRrvpXCtONfBoJL4ajZyHzr0qNz0H99STOvl8O4Bk/wNwty
 vD5CIIr0B0Gt0vY82rjIgQ0779KEt6QaCjMRojzMSEcWUNWoUEoFih4tNwm5EgM1WI
 0mHIGbqu2WkORPWUP0yytuLslXGal3pDYvTV8uG5s6ZMQAdDK89oa05j4Y4h0NNCPB
 5oXi6OkcLWvGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6099C4BEEE;
 Sun, 22 Nov 2026 05:12:20 +0000 (UTC)
From: EMCP333 via B4 Relay <devnull+emcp.enser.io@kernel.org>
Date: Sun, 22 Nov 2026 05:12:17 +0000
Subject: [PATCH] gpu: host1x: mipi: Disable the clock
 tegra114_mipi_power_down() enables
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-b4-host1x-mipi-clk-leak-v1-1-c14ac933945a@enser.io>
X-B4-Tracking: v=1; b=H4sIALB5AmsC/yXMwQ6CMBAE0F8he3aV1gYTf8V46K6LXUEgLRISw
 r/b6vFNZmaDJFElwbXaIMqiScchwxwq4OCHp6A+ssHWtjHGWiSHYUyzWfGtkyL3HfbiOxRqLZ8
 dmcbVkNdTlFbX3/Pt/nf60Et4LnelQT4JUvQDhxIVnpbL0WFkC/v+BQtT4aGbAAAA
X-Change-ID: 20261122-b4-host1x-mipi-clk-leak-ebf2c34b1640
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 EMCP333 <emcp@enser.io>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795324337; l=1713;
 i=emcp@enser.io; s=ultron; h=from:subject:message-id;
 bh=VGbtm9BeYSryKFEeMyTEi0gGwHdJTCkQyOlvmFoDkwo=;
 b=DYbtM9drcCf73KA8nDzug6e9NoLHkS655765BRprUKsqCyKFuFILPSeuaiaIANKNWRt0iUsx9
 zw37LaQzJYeCQJDQwmMITxyYAZ73wpS0ReG3A1+SE+MxoZM6f1XX2GA
X-Developer-Key: i=emcp@enser.io; a=ed25519;
 pk=5sG48Lul+Vn7OzXu3VZrCWk5uvEFPYMXYnAV0TZR/tY=
X-Endpoint-Received: by B4 Relay for emcp@enser.io/ultron with auth_id=1598
X-Original-From: EMCP333 <emcp@enser.io>
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
Reply-To: emcp@enser.io
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: EMCP333 <emcp@enser.io>

tegra114_mipi_power_down() enables the MIPI calibration clock to write
the bias pad registers and never disables it. tegra114_mipi_power_up()
pairs the same clk_enable() with a clk_disable(). Every DSI power-down
(each DPMS off, each suspend) therefore leaves one more enable behind,
and the clock never gates again.

On a Tegra Note 7 (Tegra114) the mipi-cal enable count is 0 at boot and
4 after four DPMS-offs, with the clock still running while the display
is off.

No register access follows the new clk_disable(), and every other access
in this driver takes the clock itself, so nothing depends on the leaked
enable.

Tested on that board: the mipi-cal enable count stays at 0 across three
DSI power-down/power-up cycles.

The code and this changelog were prepared with the help of an AI coding
assistant. The submitter has reviewed both and takes responsibility for
them.

Fixes: 15372d4be7f0 ("gpu: host1x: mipi: Power down regulators when unused")
Signed-off-by: EMCP333 <emcp@enser.io>
---
 drivers/gpu/host1x/tegra114-mipi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegra114-mipi.c
index 49ed05d1a6..06130d453b 100644
--- a/drivers/gpu/host1x/tegra114-mipi.c
+++ b/drivers/gpu/host1x/tegra114-mipi.c
@@ -197,6 +197,8 @@ static int tegra114_mipi_power_down(struct tegra_mipi *mipi)
 	value |= MIPI_CAL_BIAS_PAD_PDVCLAMP;
 	tegra_mipi_writel(mipi, value, MIPI_CAL_BIAS_PAD_CFG0);
 
+	clk_disable(mipi->clk);
+
 	return 0;
 }
 

---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261122-b4-host1x-mipi-clk-leak-ebf2c34b1640

Best regards,
--  
EMCP333 <emcp@enser.io>


