Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7086606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxuNd1SK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C026110FC54;
	Wed, 18 Nov 2026 13:47:08 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479FF10F701
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:59:38 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-377157fde7bso252721eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794995977; x=1795600777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jv3D7pDj2E4aOj0PkkrA1zTTgm5//UaMEcOixeC6zTQ=;
 b=gxuNd1SKBX4x+x9Ha51PZMH0H6kt0XPiMYbSTyB/xfd293iC7XIejVmkVv4+J6tOkb
 fGgZf58NvyA+OhWSvq54N7mNaxQcjoKNA2cjUgdhnIInwslCNPPezgLt+WdmqAXAeorA
 Y6YMrlM8YjGBajA7j28J/pk1AtsPWnUkCuii49eDGemRrflmQ6XJTHFIfFJY8TJ3rpzz
 m9KmFb+SwQiUlhsBByIMovNnxuBplrlpO8wZHf10AtR0r49koHk6PQtirbDp7DS/1XLq
 MQ6Y6Pd/O5Ml9EOyAQOi8UqXQ20jQO2WpihSjdqJ99FcE2GaZgs8aiphsc47nKOEW0cq
 lPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995977; x=1795600777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jv3D7pDj2E4aOj0PkkrA1zTTgm5//UaMEcOixeC6zTQ=;
 b=cJVPySrDF/0m4GZ1QMQg6gW+KPxuPmzgFT/Onn4Y2yKUGDqCWOlzc+9dvWwKaU53ys
 tFUFIV1+J9NCtUtyUbkO8CbIUUpo1cuQGKKIlih+b+hobTSME08LRmgIWvLdjB51iamG
 bNctbILKEn612Hq/39JRKnI3dS9UMj5kUVN+EIkBxZmCV23cIUfzKJwhkYF07i6DiaEw
 ry55Hq79PgasM7ES7HpXCACHREArMu6GE6I7ZL+K1WRGi3eOfdIYvxCLrIVqlB5c+A2k
 QQ6j+f11/2q7aQ9wnwpG1//bE1RkFcHLU0hOsMQNKeec6xV7hV08AAS9mC2oEE3Ms64u
 evAw==
X-Gm-Message-State: APuU4Z8rge+mFC/WSr2HWKGpDpacJQxCjRXS2nFvpXjxXkm336mJz9E0
 WAgCx6NISLNsoTk+0wphoTQG/9ojknOwySoFWwdZFdra9iA7qfKejD5e
X-Gm-Gg: AZFdTZdM04fLqpLaBnhjXkqiiYAYxNtf92oabGda1BkIRUyeBcqHcd9TFtQYsllAPBD
 t9ZZwqzYLUsobh3zLBAVyEtu9qOrDB1dalkIflgZz4kz3hCpEFmvAwi8JEEYPlNvF4nNBH0RHjD
 7zBPxGamVl9HhmucDjcyTnPjnqLP62R+1GMlN0waC6PXQ7E3e2IyavoL/iCYbdFUhyxl8Nf4V35
 qeLxFzPsOGdlKAdnL1aXSXKkrHQN8i8rUReLAa12rc5yQ29Vx3YkTe+ml39iETC4Na4ybrGLheM
 vr9zCCv4uvUNTJLm11rdyaysq11gvqhmuC2DnsQ8MHnm1r5bCMcPhOyd/DtClh63wEJ3iWuGV8W
 fVVxuLRqIbaHM3OJhC6o6qPqLm5++hcqQrTBezzTA72ADaTlRoCtL8u2Vc/S2WpKNeT/b0Ceq7W
 ZUyZjVH4CtjjbVShCj2PUiuMV8YQ890dyr9jNO/wKoCFkSCwS1Q2akvHV676V7mij7FYyJOQTyr
 xBoQ3E+3L9wMLPXrvPo8ez/Fqu+Q6Gt213+vBqfnGcKxaINBvcqTVraLcFNG0UG4Ua4Rky/UyJ/
 /QJH904gqJOy+yiHrxubVOVJIRCYudIC8f8=
X-Received: by 2002:a05:693c:880b:20b0:36f:202c:48 with SMTP id
 5a478bee46e88-38280a3ad37mr2255912eec.14.1794995977212; 
 Wed, 18 Nov 2026 01:59:37 -0800 (PST)
Received: from pjhArchLinux ([199.102.217.182])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a680032dsm5868358eec.10.2026.11.18.01.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 01:59:36 -0800 (PST)
From: pjh456 <pengjunhao409@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v3 0/3] drm/panel: ilitek-ili9881c: add Industio Purple Pi OH
 panel
Date: Wed, 18 Nov 2026 17:59:02 +0800
Message-ID: <20261118095905.127658-1-pengjunhao409@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the 7-inch 800x1280 ILI9881C panel used on
the Industio Purple Pi OH (RK3566).

Patch 1 adds the Shenzhen Industio Technology vendor prefix.  Patch 2
adds a board-specific panel compatible with ilitek,ili9881c as the
fallback; the module is marked ZC-700010BH and has a 94x151 mm active
area.  The vendor device tree only describes it as a generic
"simple-panel-dsi", so no panel-vendor compatible is known.

Patch 3 adds a dedicated driver entry with the vendor initialisation
sequence.  The existing am8001280g entry (another 7-inch 800x1280
ILI9881C panel) was tested on this hardware and only lights the
backlight without a picture, so the vendor sequence is required.

The panel is reset through GPIO0_D6 and its backlight is driven by PWM4.
On hardware, the panel probes as DSI-1 94x151, modetest reports the
expected mode, and the geometry test pattern is correct.

The board DTS that uses this compatible is part of a separate Purple Pi
OH board series.

AI assistance: parts of this series were drafted with AI coding
assistants, using the vendor device tree as input.  All changes were
reviewed, built and tested on hardware by the submitter, who takes full
responsibility for the content.

v3: resend as pjh456 <pengjunhao409@gmail.com>.  The v2 posting used the
    147148383@qq.com address through Gmail's SMTP, which is not
    DMARC-aligned, so it never reached the lists.
v2: add the vendor prefix to this series, drop the redundant
    width-mm/height-mm properties (the driver supplies the panel
    geometry), and remove the non-standard Assisted-by tags from the
    commit messages.

pjh456 (3):
  dt-bindings: vendor-prefixes: add Shenzhen Industio Technology
  dt-bindings: display: panel: ilitek,ili9881c: add Industio Purple Pi
    OH panel
  drm/panel: ilitek-ili9881c: add Industio Purple Pi OH panel

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 222 ++++++++++++++++++
 3 files changed, 225 insertions(+)


base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
-- 
2.56.1

