Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14B606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EwuDqycs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B79C10F320;
	Tue, 20 Oct 2026 07:37:01 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13C810E04F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 17:54:35 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso2652118eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792432475; x=1793037275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bNlqELENpjqfUnGABPu3IfjplZkGaehiACydkTInEus=;
 b=EwuDqycsLoFkOXxzsmziuaYEaWWx6aZGNXV/XS4GIbYxKbYIQneJXeRBCmv9x4FM2Y
 0cIS5lkSftUtYGhtA7yL6qj3k6HHgbKJqUT8HuEG/h2yQP+YRS1um0+YEBJPrcP2guAf
 cHbnkLdbu72BIE9TOqWkX+4WhsqyD68bBAr2ZcqzvjQIOt0fsmZ47wMzkkmZdf/6NdXw
 mWiBwgPfLsWlA7Wp77FwW7D5qx+1Dbl+ZHlI3EDVn8h6P8+1sCVnQyhqk0UJMZlviwEp
 TMx3PpMz02nDTeo8zXzmbfyZu/x/QYPC91GU39OlyiAyzF+xOja+tznjp+OeFQvsfVFJ
 bTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792432475; x=1793037275;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bNlqELENpjqfUnGABPu3IfjplZkGaehiACydkTInEus=;
 b=yECwrHOtOyIzZKbtrv5MMN0LWu6mQFxFrNLKSR5CNVHr7WSsOWu9g0oaXrrULpAWzw
 5PfprYEGzB+juDR1LGhUKqDpVib9we3B1OtDtAeYDsaTxjOhQ5SnCq6k8pfdvJ+Mos85
 SBO17M1cqS3HOfLWqf6s22HtaT64fwHM6j9whEPv5l3RDndBfK3+brEehrsxOcPOwUU9
 81Nth62dS4O3wABsZAhYTTAu+Pax9qLrR19dI397tKtBsw/U/ifBwjFlAyuXnBSpX6dq
 3E2njwuZ58cUby4WO+gac7/ZwQNVryJcr+8A00txjYPcZPqXBqtZ9o+Q3IHxPW3lIvB5
 fOuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/v32qagdNHvC2/iDj3E6wP7jXlrWnEsZQc4iFSpSltzRZ3S+vzPHY/leM56DG6j+c+jfd5ZwfUGI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYDPYAwTGGRlaYP4vdVzV0SxH0i7b5oe7tgk3WGcGygPJfLfCY
 aHPPg3FxpP9/4gRtMcgixVf1Vz3o47fLEmx1MgmXJPjjidcHvXO3QJyw
X-Gm-Gg: AYBFou053U3JKBjOVbMgTCzctmPM7mxE6usVArSeQd9Iwv/gLCMLhyKsXDXj7DY+LOK
 6GwT6RRlnpAtDYIDL8gvcIcFurCpOpOlTmREEhqWe/vMruLgJRn50sLmMJjAmi/g3wgw+9pjLRi
 FavgJUfBj/9AQrx0MLbOIceG7e+N412tOk3NlHPzPlcbmgKN9ZZ5z89S4qrudrOZBLDX0QO9X+/
 pTHpfwTC+265L1pMnUnsVzR8n5IwZrUOw2hFOr9lhBP2Aa//1AzasOHaByXSa8R/cqWaeB0URRo
 xJbrZsQIoBz6O4v7mqafrjKauEXuB9S6ek2TYIftFst0sk1OXaJU4Y5Z6FeTF9xl12qjGvKhf7T
 Hvwnr0irIUCIlWEhYNuLqaBXnqRTDpe8xQDR7o98XrUdodQ+ae5ctvDJxx18OibemZMEL9AZwz4
 yYAZib1c7oSham42Uj17IDjgOOp2/8kFs186A6Oic8e1KslkkNWtt2ADgOs4ebo4wG8u+2c9tD6
 7RiEQdnG8gM6XhseNbM9Ca8pIkk25e/zFhvejA=
X-Received: by 2002:a05:701b:464a:b0:14c:8461:b3ef with SMTP id
 a92af1059eb24-18513e7c64dmr10593192c88.24.1792432474641; 
 Mon, 19 Oct 2026 10:54:34 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c5cb39esm31837697c88.22.2026.10.19.10.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:54:32 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: henryzhang62@gmail.com, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/vc4: dsi: Make failed reads visible and recoverable
Date: Mon, 19 Oct 2026 10:49:27 -0700
Message-ID: <20261019174930.7237-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DSI reads on the Raspberry Pi 4 (vc4, DSI1) can fail in two ways that
the caller cannot handle:

- A peripheral that detected an error answers a read with an
  Acknowledge and Error Report. vc4 copies its two bytes into the
  caller's buffer and returns success, so the error bits look like
  register contents (patch 1).

- After a read whose bus turnaround times out, every following DSI
  transfer times out as well, until the display is switched off and on
  (patch 2).

Patch 3 serializes host transfers, so that the recovery cannot reset
the block under a concurrent transfer.

These patches do not prevent the timeouts. With video running, vc4
does not keep commands within vertical blanking, so a read can still
collide with active video and time out. That is a separate issue; this
series makes such failures visible to the caller and recoverable
without a modeset.

Tested on a Raspberry Pi 4 with a 2-lane video mode panel at 120 Hz,
using a backport of this series to the Raspberry Pi 6.18 kernel and a
panel driver that retries failed reads up to 8 times: 499 of 500 reads
with video running and 1000 of 1000 with video stopped returned the
expected data, with no lock-up. Without the series, the first timeout
left DSI unusable.

Compile-tested on drm-misc-next (arm64 defconfig, DRM_VC4=m, W=1), each
patch on its own.

Changes in v2:
- Patch 2: restore the registers in the same order as pre_enable, and
  call synchronize_irq() before the reset (Sashiko review)
- Patch 3: new, serialize host transfers (Sashiko review)
- Link to v1: https://lore.kernel.org/r/20261012190249.3167-1-henryzhang62@gmail.com

Henry Zhang (3):
  drm/vc4: dsi: Don't return error reports as read data
  drm/vc4: dsi: Recover from a timed-out transfer
  drm/vc4: dsi: Serialize host transfers

 drivers/gpu/drm/vc4/vc4_dsi.c | 145 ++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 7 deletions(-)


base-commit: e6bb593b800813788dc16179d1305747ff974d00
-- 
2.47.3

