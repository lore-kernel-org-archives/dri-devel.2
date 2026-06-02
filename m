Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D35CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A464510F4C4;
	Tue,  2 Jun 2026 18:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=grimler.se header.i=@grimler.se header.b="lyLKTlSB";
	dkim-atps=neutral
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8685F10F4C3
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 18:44:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
 t=1780425462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ifzs265vUAPV6IFIZqod6woQ6e3KxesGPyzpRuY/iQY=;
 b=lyLKTlSBQSQJUwrUC6x4vG/WGdEJePCQnq6NVERHIGUwOlV7NeAqpEC2A5PYYTeRM4YwQT
 3if7BAnbRhIm5dZwAO8amUxkTsAlByPdU7nS5e6/8Wp6P/vFoXwRzJDr5pCqluka3qY3Cm
 PCkNjWRi11HbsnuNPylJomeG2W1CbLY=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH RESEND v4 0/3] drm/bridge: sii9234: use extcon to detect
 cable attachment
Date: Tue, 02 Jun 2026 20:36:47 +0200
Message-Id: <20260602-exynos4-sii9234-driver-v4-0-9b2fc38e104a@grimler.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org, 
 linux-kernel@vger.kernel.org, Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044; i=henrik@grimler.se;
 h=from:subject:message-id; bh=+9icRJM878guDktkvKRdV7M11E818HdtxnWGnfxrGmU=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBqHyLk9cgk+1xEeOBEHFUSpeRNgrTIniPD26alJ
 mpxLsjrnnWJATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCah8i5AAKCRCwB25JC3Fh
 a1hBB/9Sv18iNp9etcxbIHTuwjpTLL2QqfhikCmtehealHMm8Dd7N3r71Bx7InayxC/j2KNDfod
 mPC61myClxgXnxatDXBDhhr6N+OlsBJrVuAYCRtIbehKvul4unwOD5JspIfECEK2YUxPWiC1TnH
 x8oTDDy/a1aQ27N1H4q6EkFEP2+MMmm8ZhmZTqzkqf7oJG5eoJATscB2x6uyWatK2YGej0OxJqo
 jx8aWRp+UNqv/Dj3Tq3tFQ5s0zmEqi9hwm0vDw45mu4EKBjbn1nrVRFbkNWMLRio5HVVFUapxjj
 822T2mk5dFJjygbST/RDFskh61NnUrey1ARv5cjOg+I42moL
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT
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

Hi,

This series fixes so HDMI through the sii9234 MHL chip works when
cable is hotplugged, by making the MHL chip use extcon cable detection
functions. Patch 3, that actually implements the extcon parts, is heavily
inspired by commit 688838442147 ("drm/bridge/sii8620: use micro-USB
cable detection logic to detect MHL") by Maciej Purski.

Before these changes, HDMI only worked if cable was plugged in before
booting. If no cable was connected, then wlr-randr still showed HDMI
as connected, with 0x0 px, which confused at least some UIs (phosh)
and caused problems:
https://gitlab.gnome.org/World/Phosh/phosh/-/issues/828

Tested on exynos4412-i9305.

Best regards,
Henrik Grimler

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Changes in v4:
- Collect tags
- Link to v3: https://lore.kernel.org/r/20250824-exynos4-sii9234-driver-v3-0-80849e716a37@grimler.se

Changes in v3:
- Fix return of dev_err_probe in patch 2 and patch 3, spotted by
  Dmitry and Marek respectively.
- Change to depends on EXTCON || !EXTCON instead of select
- Collect tags for patch 1 (not 3 since there were (minor) changes)
- Link to v2: https://lore.kernel.org/r/20250724-exynos4-sii9234-driver-v2-0-faee244f1d40@grimler.se

Changes in v2:
- Add dependency on extcon in patch 3. Issue reported by kernel test robot <lkp@intel.com>
- Link to v1: https://lore.kernel.org/r/20250721-exynos4-sii9234-driver-v1-0-2e47ed02f677@grimler.se

---
Henrik Grimler (3):
      drm/bridge: sii9234: fix some typos in comments and messages
      drm/bridge: sii9234: use dev_err_probe where applicable
      drm/bridge: sii9234: use extcon cable detection logic to detect MHL

 drivers/gpu/drm/bridge/Kconfig   |   1 +
 drivers/gpu/drm/bridge/sii9234.c | 124 +++++++++++++++++++++++++++++++--------
 2 files changed, 102 insertions(+), 23 deletions(-)
---
base-commit: a87fef0880c4f52769b5a3c2fc1b2d73aaa04eb3
change-id: 20231218-exynos4-sii9234-driver-d817d4b511d5

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>

