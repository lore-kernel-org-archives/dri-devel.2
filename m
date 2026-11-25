Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95737606A331
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hgvc7vhF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB14410FEC5;
	Wed, 25 Nov 2026 18:13:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0777B10FE2E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:13:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E301A46391;
 Wed, 25 Nov 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795630379;
 b=j5QCxM6qS5zzLOwwJUMZjoYz8Kzf2s4rJVplKyDXSRRW/DDNaufa0kK1SUHX5kepb/Us
 QfysymlYRjDSDv5Va/ckED5VD9KnjkGRyHukAKEnGmHP6D+PS09ojrfXS4+tcIXdbTLwR
 HXOlaK2jmauXK7X3TIbIz+7B/H53njPclKfLV+gLK+ImTOCG12POm3rYuUETzERt71Qfm
 mybJZFBKWE2hGIFJZ93/Qy0yuuh8kBpGbucdwwk/QWtULLDdUO+U/P9u+2JywJyaUQoFl
 ldniifu5YojySBDyOWCe5XS287Qwv3Y7YTZozzptKXhV3JHNOd73FgIRJDMzcuSh5pA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795630379;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=OO0R6iAuyt62WY8LQAxPucD4HgDtVrM36vo2ROZdtpw=;
 b=azZ7RBVAUfg2j1PhfFB9OTNOIIrO0QOXxQJihMMtjpgNaxWnndDyhO/K1gcldu0J2YWS
 ZMYE62EGXN5pZtKiz8AtvlUnsnhM5KlPqRXJkRzB4vlf++sKEhAcxN5d3lqiUc8paud/e
 CF+pP11XhqzhrvnYNQzI4asOZOgWW5MCoo6RaCMaExkg5BnG/qgBN9HW/1wkggxQlOci+
 AicOYMKiMDNcGzt8xaYtEI71HxeP11itxFy8+CUABWIkXiNyFpx0vTAF/FNESq7Ekwb/9
 4yHHmVAANuhOTTMJrOwCXwqetDkyWY8wUTCPt9ZMObeX/iRAobIeUKjk43isgY/sVYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EE4811F000C0;
 Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630379;
 bh=OO0R6iAuyt62WY8LQAxPucD4HgDtVrM36vo2ROZdtpw=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=hgvc7vhF2ge+45ls6F1yGNz+bps9moibQ8j2tNFDEU5K5cyJM1DYNp/ocSLMongvc
 GQs+8FrwdnuJdbMXBrcmfoe5unc+daFhBIpnhwRPEtfR57a3jIZdqiBBujmNARJZNP
 oDla3iwvZhLpiAZI1IKedtaCO0abGdQc8Xh5XhnTV0FlSCD4H/Jw+y/OxqSGkVgAG/
 Lvp2T0i8EsLEkuizA9DD/+rEbSmvwvrYA9tf39hugT4G6yAivmmnq0dETWAHq8rmVp
 dNpHrMlbNW6dqoBc+by9JuupaqmH5r4Pq19QeNv6gzdm2higTyAH++W+9D33h2YfeO
 NzmhW0bjTw1GQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4A7684CFA0;
 Wed, 25 Nov 2026 18:12:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v4 0/9] Pixel 3 XL display panel support
Date: Wed, 25 Nov 2026 19:12:44 +0100
Message-Id: <20261125-crosshatch-panel-v4-0-120adc58e737@ixit.cz>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23N0Q6CIBTG8VdxXEcDMsCueo/WBR4OSWvqwJzVf
 Pcwt2bLy287v/95kYjBYySH7EUC9j76pk4j32QEKlNfkHqbNhFMSKYZpxCaGCvTQUVbU+ONMgm
 ojSxcqRxJrA3o/PBJns7zjvfyitBNnemi8rFrwuPzs+fT3ZwvBPvP95wyalFisefCmkIe/eC7L
 TzJFO/FkucrXCTOtN2DKp0SDn757ss5Z3qF7xLXytocIXcKFnwcxzfKcvqWPgEAAA==
X-Change-ID: 20260801-crosshatch-panel-06ce8a69fb7f
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Petr Vorel <petr.vorel@gmail.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=YE6uRQHX3frxMj/6HJyZlh9S6ry+tb/5u1Co16RoWHM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrByUdjIHhZsyDm0D45ADd1nzAhvMIdNhRlEJ5d
 RCRlmigj2uJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawclHQAKCRBgAj/E00kg
 cg6PD/wIDgT0i2YnmMltMCXjiIiAXM7Tw57g64kdw/CpoMXAUVGO8gTBower1KaV9G1lfUZ3j/T
 adSF4+iDlSVVnvWSziJt1q9/IvBnuaG3gkZihfTny2Zu3cJzYMUZMYdESChgwU1ygiKcnrcl275
 6X5QS8Qc8ziYWAW9XHZLiAXP72IGpxMERZ10+jVix7nZZO7sP/SS9WkTuhGL4ngwXirv6gv2J5/
 QN54hIgeSn0joz7ixjB5sMgaa2LK1mLMLTigRv33fdczbAbfknRM03nCEf2HCc1ZDa/g16PQP6Y
 2376qchOrs1BIfcSZBnA3NgpptvHHF3j9QdDEGT+JIcp6zG/q/VpCchnWpC/qb8MI4jNFHIQNJ6
 wuSNepz4G0OLYjt419nikOg20EomKQ+MgCYVniixO4aOrMuMCKbzZNEVH9o5aly+A+dAPqFeDqF
 UOy4gFHtaN+2b7vtYVGOtXCXPv9v28GLA8fwtwGRsFPsmWh/t2k4G/LZQSz4A1sufMmOEGLxy1D
 EjlFh65pvCb3IBRnqYXDh/tDcT1Eml8uaN+HNijtMLTh+Hj1BBYKdSpd045bstPLcoW93Khkpii
 nKNSmXsH36ZUzTgiBCMjBC/bFPyJo2LzqBawhhQr7OIPcdGnmMvEmBg1hdIrhcWXKP25CtGaFuu
 Ca5N7Cd2m2xpfog==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce Samsung AMB630QY01 (Google Pixel 3 XL) panel.

Includes refactoring and improvements to the S6E3HA8 DDIC which is also
used by Samsung S9 (Korea version).

Patches 7 and 9 switch to the new compatibles, so they must not reach
the qcom tree before the driver patches land.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v4:
- Entire allOf goes after required: block. Now really. (Krzysztof)
- Improved wording of 1st commit. (Krzysztof)
- Link to v3: https://patch.msgid.link/20261108-crosshatch-panel-v3-0-87dd4ec4f7cc@ixit.cz

Changes in v3:
- Entire allOf goes after required: block. (Krzysztof)
- Expalin dt-bindings changes more explicitly. (Krzysztof)
- Dropped "Really assert reset on the failure" as requested by (Krzysztof)
- Not addressed: "No, this is wrong. You just broke all the users of
  this DTS.", due to non-existent usage outside of Linux and DTB for
  this device being shipped always together with the kernel.
- Link to v2: https://patch.msgid.link/20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz

Changes in v2:
- Rebase on top of next-20260923.
- Cosmetic fix s/Cosmtetic/Cosmetic/ fix in the commit msg. (Neil)
- Link to v1: https://patch.msgid.link/20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz

---
David Heidelberg (9):
      dt-bindings: display: panel: s6e3ha8: Adjust to reflect the DDIC and panel used
      dt-bindings: display: panel: s6e3ha8: Add AMB630QY01 panel
      drm/panel: s6e3ha8: Introduce AMB577PX01 panel compatible
      drm/panel: s6e3ha8: Prepare for supporting multiple panels
      drm/panel: s6e3ha8: Correct the polarity logic within
      drm/panel: s6e3ha8: Assert reset GPIO in unprepare
      drm/panel: s6e3ha8: Add Samsung AMB630QY01 (Google Pixel 3 XL) panel
      arm64: dts: qcom: sdm845-samsung-starqltechn: Update panel compatible
      arm64: dts: qcom: sdm845-google-crosshatch: Add display panel

 .../bindings/display/panel/samsung,s6e3ha8.yaml    |  52 +++-
 .../boot/dts/qcom/sdm845-google-crosshatch.dts     |  60 +++-
 .../boot/dts/qcom/sdm845-samsung-starqltechn.dts   |   4 +-
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 304 +++++++++++++++++----
 4 files changed, 354 insertions(+), 66 deletions(-)
---
base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
change-id: 20260801-crosshatch-panel-06ce8a69fb7f

Best regards,
--  
David Heidelberg <david@ixit.cz>


