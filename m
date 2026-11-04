Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DBE606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E3010EB7A;
	Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
Received: from sraa.de (sraa.de [85.214.240.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F9BC10F988
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 03:05:05 +0000 (UTC)
Received: from [161.142.148.162] (helo=localhost.localdomain)
 by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <basti@sraa.de>)
 id 1xOQq8-00Akzf-SH; Wed, 04 Nov 2026 03:35:05 +0100
From: Sebastian Raase <linux@sraa.de>
To: 
Cc: Hans de Goede <hansg@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
 Sebastian Raase <linux@sraa.de>
Subject: [PATCH 0/2] Add monochrome framebuffer support to simple-framebuffer
Date: Wed,  4 Nov 2026 10:34:48 +0800
Message-ID: <cover.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds support for monochrome framebuffers (1 bpp, packed-pixel)
to simple-framebuffer.

Monochrome framebuffers require far less video memory and bandwidth than
16bpp or 32bpp framebuffers, making them useful for small devices or FPGA
implementations.

Sebastian Raase (2):
  fbdev: simplefb: Add mono framebuffer format
  dt-bindings: display: simple-framebuffer: Document mono format

 .../devicetree/bindings/display/simple-framebuffer.yaml         | 2 ++
 drivers/video/fbdev/simplefb.c                                  | 2 ++
 include/linux/platform_data/simplefb.h                          | 1 +
 3 files changed, 5 insertions(+)

-- 
2.47.3

