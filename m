Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089446080AA2
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dQiUJ5Cp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658D510EEBD;
	Mon, 19 Oct 2026 15:48:39 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1268210EEBE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:48:33 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2044974a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424912; x=1793029712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D5ibEBjYYGDjpoR4yF5DIOCUI477W7gW0Qwdc18+UCA=;
 b=dQiUJ5CpAuJgRjXB/y+bKHN9UTv6wyHzHLN/IUUnfqHnGRw4aRbGf4aDQ2q5FwQZ+/
 orneJV2dI+DkaeXNGC7dtj9djjGZJwB9AdFbIQ/kHuoMeZyy+4otQ0C5XRrsCWp3T8lh
 HgD6nDau5GMG1Jg5UCfxs9tdIaEYDN7rsQmNWiqn1bk4i9bqYJBqdnysILML9+RfNFWQ
 WBtCYWmoHD0nqKLngt+J0FF2IGrSw5UDSAR+Z4kcTBykuzWgjuyDNwrCxcH5bUKqLR+g
 +S4JXFGMxW/bwcKCotR+OJLGJg2gdGuPA8gIJQy7h8/tEFQFqB7C8UBr9rHLDnJXmjf6
 g+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424912; x=1793029712;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5ibEBjYYGDjpoR4yF5DIOCUI477W7gW0Qwdc18+UCA=;
 b=ATiVuHnZ5rXX8kGpdrf01TgNtZCHwszfKmygoURlBqqVeIK8aNGVzpNo9gugkg+Ur4
 7mazU2oyN1+zts4ElaQE1TQdwfjvcQ2DSKiJ7/8ubUjESgAvwXrrUNKx8V1uTutXTyE0
 gR3S4jvlKPdtvsnJtx7NgWVZH6kTAnPqWM7N9rBWKlS+Gj0UZWVdiABrXy4wslVhgVst
 rnO4Y9Dl20OheiupJegQdtU6yRpjwXE/bCoNF4Sa7gGROdYUWmAz2smWtJIST+8BTjPa
 Zi2Z0lmdN2kfot1t+ah5FisK0jwATXvNTyHFgbber2u5wie8J+gIqtBofdIBVmldK6/l
 8lfA==
X-Gm-Message-State: AFq9FYK5Dq2s57piwU/TgSnuYSUfhGRPXbguIopf51GMJXkflNItf5fN
 AX42RBC4oKl4b6wZ9YArFnd1no1KtrNZpdw2SbOIFfN/Cbx6BIHQdYbKJWIZn3Rd
X-Gm-Gg: AYBFou1tW8T7O9gfSENNGvWbloAQQphInU8/kcjAAh7A9hkpk8TboSxWLmggOTxYhZz
 ichKTggXaExo+z/HouobeMrM359gwXl6HrocM1DS8QGNUc5pxfEJpq9lAcBKYalzrX7+SNkAH7C
 nMnTJZYLkQxHR0wXc+J26T8hdKGtBrMY264Qv2js+aI+KtkU38KfJSPCdJwPPj/jOg2XVM4GNZz
 nIhmqgT9TXc65JiZ8/qJ2bpsTYvvJrmHCIllOF0kqkFujk2hlA0uQ2WTH6OuVKM/nNEd7NUAkls
 0kbijwd5i+q0VOX3MHDcKOle3J0JE0K5n/v+uRLBMfsv+Ci900ivxZ++lLQjMHNWHTPEB62W6HX
 AdHvBAad+pbjrVuHS1P8oVrwZzuEetN1WrP3OjPlFuagi1EvwaO+OELRIxGZSfpg6qaJ2Ack0Xv
 7zMhDfcsEY6L6uRwMAI95sOmwYXhX/16gN0AYT2pcPDDVK6cBS5rGtrMTMvUaIDIcvGrD7ATujC
 D/Rc3s5nqnwCGbTJMesuGmLnTcrVVH+bX6XD0CuXrb7UR2iNA==
X-Received: by 2002:a17:90b:39ad:b0:3ac:74b3:a8f3 with SMTP id
 98e67ed59e1d1-3acef542337mr7164449a91.44.1792424912467; 
 Mon, 19 Oct 2026 08:48:32 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:a144:150d:733a:5ba2])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ad5cc13658sm63271a91.4.2026.10.19.08.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:48:32 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Add MacroSilicon MS91xx USB display driver
Date: Mon, 19 Oct 2026 23:48:04 +0800
Message-ID: <20261019154820.68659-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds a DRM/KMS driver for MacroSilicon MS912x/MS913x
USB display adapters.

The four patches add:
  1. XRGB8888-to-UYVY conversion helper.
  2. Register access and connector support.
  3. Atomic modesetting and USB framebuffer transfers.
  4. Kconfig, Makefile and MAINTAINERS integration.

Some code is referenced from the vendor linux driver.

Tested on USB to Composite/VGA/HDMI adapters, both USB2 and USB3.

Ho Jie Feng (4):
  drm/format-helper: Add XRGB8888 to UYVY conversion
  drm/ms91xx: Add register access and connector support
  drm/ms91xx: Add atomic modesetting and USB framebuffer transfers
  drm/ms91xx: Add Kconfig and Makefile integration

 MAINTAINERS                               |   7 +
 drivers/gpu/drm/Kconfig                   |   1 +
 drivers/gpu/drm/Makefile                  |   1 +
 drivers/gpu/drm/drm_format_helper.c       |  52 +++
 drivers/gpu/drm/drm_format_internal.h     |  19 +
 drivers/gpu/drm/ms91xx/Kconfig            |  13 +
 drivers/gpu/drm/ms91xx/Makefile           |   9 +
 drivers/gpu/drm/ms91xx/ms91xx.h           | 217 +++++++++
 drivers/gpu/drm/ms91xx/ms91xx_connector.c | 263 +++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_drv.c       | 518 ++++++++++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_registers.c | 386 ++++++++++++++++
 drivers/gpu/drm/ms91xx/ms91xx_transfer.c  | 218 +++++++++
 include/drm/drm_format_helper.h           |   4 +
 13 files changed, 1708 insertions(+)
 create mode 100644 drivers/gpu/drm/ms91xx/Kconfig
 create mode 100644 drivers/gpu/drm/ms91xx/Makefile
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx.h
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_connector.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_drv.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_registers.c
 create mode 100644 drivers/gpu/drm/ms91xx/ms91xx_transfer.c


base-commit: 5e756743945d3b6bde6d8d1e3f943a03269c0ece
-- 
2.55.0

