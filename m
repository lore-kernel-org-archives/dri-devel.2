Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED91BC79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE3F10EF3A;
	Wed,  9 Sep 2026 06:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lie+R18k";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B435010E126
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 20:52:13 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so48125465e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788900732; x=1789505532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8YsqsoNDEKQnLJ62BEZDMso3RhbAevKRTh54YJUBzi4=;
 b=Lie+R18k4M37n0GKKykzq/mbh6sjVFC8Wjm5JUuWtkH4IWmkL3ZZsQaEtNiYRV1bhE
 bPQFNSCnPbBc5atseKbH9sZ+Nh6D2GYovhxwMxxjB5gOKcfDHeoKxGRuMQQqyco1v8EP
 4z3yg3bAO93WrDNkpCZ2nva0zId3l7xiU5lZdaVYxk1FBvvMobmhBD1lMmAMXcFc5LP8
 mh+yv3IEMHoV0IepNOpGGbqkbeRd1XoJ/VHnhjJzDbqY69qSeBXxWtydlvVhWACS0TXn
 UYc8V+MSv/6O/vlU5FyNPtHiCHVDo07c+mdLzAxkK/XkqfSIHBSvTPvf/0Yx4dCWL9O+
 bDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788900732; x=1789505532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8YsqsoNDEKQnLJ62BEZDMso3RhbAevKRTh54YJUBzi4=;
 b=SCS7BFvttEDHysk0RmLXtuYOwJnq+Xkg/SkE3X7n62SJ+xEuc4uV9SnEaMvRVAB7Ct
 rxm5URVjje0aJ1t448f/EIzIZSnz+EjGwQ0/Ju1lyNRKAOFawXOpXkRzxMPd5LNecgQt
 N1zrfziaZUXTC/0sqoVnJdB2O4PZI/OlK7Qhao152Qwbl2v4fd7ec8/At4n8ILNYxmD9
 4NZsSeBSoId7Z3YCMtJoO4LGdGDA0YHi/JbnwWsEEcJq+qIWyGt6PiCKoP4uXVfT4jAv
 EOra/+cWLJCN4vBjPpAo/9O863aOU66tgUT8kfWhMVNJ6AhZRZp3jiGVVmrrUHdTWXno
 ZQQA==
X-Gm-Message-State: AFuF++kByiF84bo5tZXlQozSltgqMU+82wndim0zFhLj6WfTczruWpe2
 NW2DHR54KMx9dhqkWDK2YvjnPpdPKcEUdTHG496pYdIlaQeOiAukUhQ2
X-Gm-Gg: AYBFou3pVLYcxRdo07DMoY6cUZ3dXPCoMGJYYXcDr9Wi6Ts+IpXPbmJJmt5DsQOtA56
 lhjiHLmgi2IUoG0gNLHlgFR3e+3DMCUxa4iorjvyIemZnQs5vPuShkHZ4kvxjipIQ3uhhkH/t3N
 uaqw5vGHeh2ZdtrE1LzDLkzuTIg1NH5qRvYxPPGjd+VP50mdHsFYM0RytqiuJttyRlIL1Og0rVZ
 0onCxdtpeNw4zNM6Fh9+eZ57okV7Hh9YceJlEQomH5kymWnudALbQkqXUVZ2Kr5VNGmXeKqAZTU
 jQyGSp4Do2Sl0rw4hqGULQUVMOn9t3g6++uHDy6SYRXv2HttV15iob/1vk4XJET8gYo/9IN1QUY
 eSNOdqEcYDyiDzcZ5Qpls+03wqEsRkSd/XAmDmNoa51chpryB4s5uKWSADCQ/80OmCDJAKvps9h
 BOF9Sdw0tPIfk0shPOBoOpalE6zAbkTX9JaPCiSXb2S/CgoM9Q8+yWLW5uDe9cXqyPKgwCWuIzp
 4LIp2iWxsCThGLA+1Gp4lqpKVsUgTKFBMLPsSSc7Q6V
X-Received: by 2002:a05:600c:c48f:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-49cf825d507mr320789835e9.9.1788900731833; 
 Tue, 08 Sep 2026 13:52:11 -0700 (PDT)
Received: from arch.home ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm565265465e9.5.2026.09.08.13.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 13:52:11 -0700 (PDT)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>, Frank Li <Frank.Li@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH] MAINTAINERS: update MEGACHIPS dt-binding path to yaml
Date: Tue,  8 Sep 2026 22:52:02 +0200
Message-ID: <20260908205203.649957-1-gawindlin@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Commit 74459b0dacce ("dt-bindings: display: bridge: convert
        megachips-stdpxxxx-ge-b850v3-fw.txt to yaml") converted the legacy text
binding to YAML schema and renamed the file, but forgot to update the
corresponding entry in MAINTAINERS.

Fix the path to point to the new YAML binding schema.

Fixes: 74459b0dacce ("dt-bindings: display: bridge: convert megachips-stdpxxxx-ge-b850v3-fw.txt to yaml")

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da3e42d2d190..e830a31525d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16848,7 +16848,7 @@ M:	Peter Senna Tschudin <peter.senna@gmail.com>
 M:	Ian Ray <ian.ray@gehealthcare.com>
 M:	Martyn Welch <martyn.welch@collabora.co.uk>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
+F:  Documentation/devicetree/bindings/display/bridge/megachips,stdp2690-ge-b850v3-fw.yaml
 F:	drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
 
 MEGARAID SCSI/SAS DRIVERS

base-commit: 5acbae5f7eb3d5275120abfe698c394b7325dcec
-- 
2.55.0

