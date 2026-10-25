Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90649606A32D
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k22Q5IVB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66CB10E181;
	Sun, 25 Oct 2026 17:13:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C498810E181
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 17:13:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B5304600AA;
 Sun, 25 Oct 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792948430;
 b=1PTCrToDr33l+3C4LTh/nMpuwkNcenC7mIlSSZVpt2OsJPMmje7wWdv+D14A+GveIBxY
 nm/nEKG11rlRIEGtASBQ1M1nxCXNFA9y5e91as9EdRrRfFSKjKes3GV3ZcQlfENmMzWOy
 VbPTycqXHGYlP3uliT3duZ6NsCKPJoVdMqn52l3QlaJ0AkqmMThWl3mQLf1Gtbe4X9QvG
 xLqX0Um7i7MXR8LoDBU7RAQsc6+KSezZz6Sj0VoTQ7GH4ywXEwHPlzZbx8jexsdhIamSW
 fUyy4rgAZtGVs9OAd74bl2j8EdogBs+fwqjW8gAMt/9jwyyLnzYWAAaCPzqSFhWvXJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792948430;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=HFA68Xy32wtf4cFQgxRHRCe4WyvrjzEfKiorTbbnMvc=;
 b=Ed9P0lM8zUlWGUb2p6XDeqXvgfzgyFF6KNmo+ufikxq65awGwCr+NJRa8TQ5X/Zq21mL
 r27B9dOp/fd/2FDJIsvJkMYdkeolM/uNd8ryZ7buAWifW2RzRQDb5K6NE7UBxeWQBdqHl
 XH1lEcDNR8I+1YeVK6gGTGwjTv1wk3HyKeMSRm18mssZELsJwE1v123xe0FweXX68Yptd
 m3Wnmyn56tv4GiaWKZp2MfkXstCdlYul/IfltB/a6d/AaBCa88DBjYqwtJc9lY/N0aXlS
 qAm8HGaxDUuihBKy0QK9XaCKWtuSUbXICisgeuxUS7xAqLQvDZqAumhg95mQPozpHQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id DE9881F01825;
 Sun, 25 Oct 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792948430;
 bh=HFA68Xy32wtf4cFQgxRHRCe4WyvrjzEfKiorTbbnMvc=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=k22Q5IVBJ1hN8Aucs5MI9cK+JEajrFcgteC8VspPFbp/RA/KcwmRs6l8Lq+fZQDzj
 Wnckn0fyQlZezwQASvz26xRWP4PE7d5kO3sSvuv0RZolp94BiJKi/JxZgE/2el7i1J
 XpX6V969N0i2gPSHUEMRcvm4VH1eI8++2SUjJ8WfFIblrzPqVyWhe5w8Uz0hz6oVPc
 JlXIDEFhO8ondVt9yM//dfQgJExiltuLMd8qOx6cwfOFtRDEfV19CydM4SPxxkFA7I
 zkFgyizuFuKe07Y+H8sXDXQFheHRC8uQAjf46JY2/a1PnxWjkpWlpOFcsyaL/419y+
 VGInKKZROAGKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 6EB7344A74;
 Sun, 25 Oct 2026 17:13:49 +0000 (UTC)
From: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sun, 25 Oct 2026 18:13:44 +0100
Subject: [PATCH] gpu: host1x: mipi: Disable clock again after powering down
 the pads
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IAjXSqxQXMZnqtFVDJhZBv
 HtTXb7F/zsIJSaBe7VDoi8LL3OBrivwo5sHQg7FYJRptDI3XKPkRG7CcZGsN5w4MvrPG9vGUnB
 BW9srKHlM9OTtXD+6y7L2L/L5/4Pj+AFsAn58fAAAAA==
X-Change-ID: 20261025-upstream-host1x-mipi-clk-867edad177b0
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792948429; l=2449;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=IqCP8sWJtCLgWyd5xt/XstbRFuDUueRcejtTTWyeurE=;
 b=lBTdo24bssxZ/0pg7gT0fqak5kfrXQlhLtVnpWYodJfpjoF4etnW0lF+foOFhOoHAiunw9n1x
 8qt7ntmx10hAiLVKjs8lOCLZ3ymbg5E2EhAuFgYhXHvL7Kxy5OQwynN
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
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
Reply-To: admin@tsv-stahl-riesa.de
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra114_mipi_power_down() enables the MIPI calibration clock to access
the bias pad registers but never disables it. Every disable/enable cycle
of a DSI or CSI user therefore leaks one enable count, and the clock
stays on for good after the first power down.

Add the missing clk_disable(), matching tegra114_mipi_power_up().

The leak gets more costly with "clk: tegra: Fix Tegra114 MIPI
calibration clock parent", which makes PLL_P_OUT3 the parent of
mipi-cal: without this fix PLL_P_OUT3 would then stay on as well.

On a Tegra Note 7 (P1640) the enable count of mipi-cal in clk_summary
grew by one with each DPMS off/on cycle of the DSI panel. With this
patch it returns to 0 after each cycle.

Fixes: 15372d4be7f0 ("gpu: host1x: mipi: Power down regulators when unused")
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
Mikko's "clk: tegra: Fix Tegra114 MIPI calibration clock parent" [1]
fixes the MIPI calibration timeouts on Tegra114. While testing the same
change on a Tegra Note 7 (P1640) I noticed that
tegra114_mipi_power_down() leaks the clock enable it takes. With [1]
applied that leak keeps PLL_P_OUT3 on after the first DPMS off, so the
two belong together, although this patch applies and makes sense on
its own.

[1] https://lore.kernel.org/all/20260930-b4-dalmore-fixes-mipical-clk-v1-1-0518be6c7979@nvidia.com/

Tool use (see Documentation/process/generated-content.rst): this patch,
its changelog and this note were prepared with an LLM coding assistant
(Claude Code). It traced the clock enable counts from my clk_summary
dumps and wrote the code change and the texts from my measurements and
instructions. I reviewed the change and ran the test on the device.
---
 drivers/gpu/host1x/tegra114-mipi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegra114-mipi.c
index c084a09784d1..83a43a5e33af 100644
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
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261025-upstream-host1x-mipi-clk-867edad177b0

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


