Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC48CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC46210EFA4;
	Wed, 13 May 2026 17:24:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LBbCLHfb";
	dkim-atps=neutral
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E1810EFA4
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:24:56 +0000 (UTC)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8c64d635955so19910406d6.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778693095; x=1779297895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pFCIqGgLigFKHTXskPbCr2tSj2xG+Q75yI9Jsp0dlrU=;
 b=LBbCLHfbYdLQvzS163dwxluzwvidSWBn8tlVgd4JOvnJAqE7rdzVzYJV7rsF1NCdCo
 gDgX32cLvumqisqXArR6ewAVaNpwIdO451PBCg0R1HPUXO2DCVbtGZKoaU1UxnfRXqMB
 ry5arqgg8p/Epsqp2KIOD7NpI9S4RWcFr9aB0dhkRG7dVTjLLUpF4VJTO/QAXWoV0fzI
 BjnR4aI+riJMQoYAfHZWG0XbRH6tperZGMZjvVmcxQouBeip+NYho+rhnEXxQAQNbL9+
 gC4PHsOCIdYK+PyuEYBSsj3kV0lnjQKSxp64DEIUD08S/B/smtnb2hVEn/DmrYbaIJkT
 30jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693095; x=1779297895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFCIqGgLigFKHTXskPbCr2tSj2xG+Q75yI9Jsp0dlrU=;
 b=XJ5mAYkL9ZfrY7qHnP3htrZdrqWhcgubcwYM9r4l8fkTF7ef1U7rpnxUgKyZcNBUjI
 qvqBPbKH9Ud6yDJkCv83UYcV9wgNpG+TbyLvpbh/o3fk32MGfiCHrpyShAJ1ltRqAtps
 +NxiDq+RMROKt/3eGVC00vzvLVat/YrrmyKVJjCjGtca2FxHbuPS0uFV6trFm1SlvWSy
 sLGT3DDAttMnSBCMnpDuxVNpwSku5myhWnQjH9sONFEB23keUnpAv5II1gDik/20RQ3C
 Q3WcWbiFLxXYTcGox6j3MOC0teTtnccz+uQOKH+Db0iMAGHLCB7oPgKs6t3tRAJaoBxD
 KU2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+q0bYDckxQNyJM6UejgHy8tRnGoi9xvyGIf6/vTEfdp4uYIl6Q8tRRG9h0C3q0eoFpfiRLAAK6oUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3FeH8qWAgkHR141b1ByfbVOsnNNL6hoBSbGlSWWGP5HL3xGhP
 FIdRaFF39gb5EC/M8DPkn/czLqGJduwXWnqu68djKMSSMRmTtStsu/Na
X-Gm-Gg: Acq92OGchf6QuexKt+6NlXDWIVJH86Ezr7+TKnbC96lx+yMyb95+EOaJaNvZtvQTVey
 UmtqbK0HGH6ddZsgSBaHnfCaqg7dWYTK8aVj6PqrgLRS8LO2To2PjRztEP1SDxuawwJ3eeGjsPm
 rbP44RdscdDGjbWI+gvotIxl4i9X7bnpE2MvgeZcQ+rlki46IQ32eU8nm1X3ixReq1jBvahcO5z
 QuxUjbHJJOfXq61f+xJnSxf2Su9YABJ+fohaSORl5SIPbgIWK2v/QnIoH3xx8BPJBtt5GOU5wMi
 8FaL43qeaGrYNtdZzaRd0EuA9pLBpkuj911AR61fGEPFZfhC7gXj9FX8927fAVnzty7sMpCAxJd
 P5bOpBWyyB9hXioL+EyHsRPIBL9CRMwuBLFij9jU7Q4Yk9TifxojIT6eZm6Ojc5ChwrcrNcqwow
 tjuZLdnbfMuf7FvV8cV4hWbVU0TQ==
X-Received: by 2002:a05:6214:33c3:b0:8bc:81:c1db with SMTP id
 6a1803df08f44-8c7e01a08dcmr57850306d6.43.1778693095211; 
 Wed, 13 May 2026 10:24:55 -0700 (PDT)
Received: from localhost ([142.181.178.53]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908562955sm1884916d6.10.2026.05.13.10.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:24:54 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, Yifei Zhan <yifei@zhan.science>,
 Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 0/2] arm64: dts: qcom: pixel 3a xl support with tianma panel
Date: Wed, 13 May 2026 13:25:47 -0400
Message-ID: <20260513172549.1345-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This expands Pixel 3a support to the Pixel 3a XL, starting with one of
the panel variants. The Pixel 3a XL has two variants with panels from
Samsung or from Tianma/Novatek.

This series depends on the IMX355 front camera devicetree patches
(https://lore.kernel.org/r/20260217002738.133534-1-mailingradian@gmail.com).

The most recent test on a Pixel 3a XL is in v3. v4 is still
compile-tested (with relevant schema) and tested on a Pixel 3a.

Changes since v3 (https://lore.kernel.org/r/20260310002606.16413-1-mailingradian@gmail.com):
- disclose AI involvement in review (Konrad's review tags retained) (1-2/2)

	Some changes appeared in v3 (under "Changes since v2") which
	were suggested by the "Claude Code Review Bot", an experimental
	AI reviewer deployed by a DRM maintainer:

	- preserve same touchscreen physical width in sargo (1/2)
	- move entry in Makefile to correct place (2/2)
	- correct top-of-file comment about which panel is supported (2/2)
	- explain license identifier change from GPL-2.0 to GPL-2.0-only (1/2)

	The AI involvement already occurred between v2 and v3. The full
	AI-generated output is accessible at:

	https://lore.gitlab.freedesktop.org/drm-ai-reviews/20260217000854.131242-1-mailingradian@gmail.com/T/#u

- rebase onto new front camera patches
- drop applied patches (previously 1-3/5)
- add review tags (1/2)

Changes since v2 (https://lore.kernel.org/r/20260217000854.131242-1-mailingradian@gmail.com):
- add support for regulator (Dmitry's review retained) (3/5)
- use common set page function (Dmitry's review retained) (3/5)
- squash new labels into common dtsi patch (review tags dropped) (4/5)
- specify framebuffer in terms of memory region (4/5)
- only specify height in XL/non-XL specific devicetrees (4/5, 5/5)
- remove status in display devices (4/5, 5/5)
- preserve same touchscreen physical width in sargo (4/5)
- move entry in Makefile to correct place (5/5)
- omit copyright year in new file (4/5)
- correct top-of-file comment about which panel is supported (5/5)
- explain license identifier change from GPL-2.0 to GPL-2.0-only (4/5)
- add review tags (1/5, 3/5, 5/5)

Changes since v1 (https://lore.kernel.org/r/20260210023300.15785-1-mailingradian@gmail.com):
- use multi functions in disable callback (3/6)
- add and reformat comments about XL differences (5/6)
- mention the sdc panel (6/6)
- explain google,bonito compatible (1/6)
- remove TODO item in code (3/6)
- add review and testing tags (2/6, 3/6, 5/6)

Richard Acayan (2):
  arm64: dts: qcom: sdm670-google: add common device tree include
  arm64: dts: qcom: add support for pixel 3a xl with the tianma panel

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/sdm670-google-bonito-tianma.dts  |  32 +
 ...le-sargo.dts => sdm670-google-common.dtsi} |  22 +-
 .../boot/dts/qcom/sdm670-google-sargo.dts     | 714 +-----------------
 4 files changed, 53 insertions(+), 716 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts
 copy arch/arm64/boot/dts/qcom/{sdm670-google-sargo.dts => sdm670-google-common.dtsi} (97%)

-- 
2.54.0

