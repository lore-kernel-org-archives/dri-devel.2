Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82F606A330
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=bfzq1aGz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5568610E20F;
	Sun, 22 Nov 2026 15:47:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4EB10E20F
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=sHzBEyxIy7AzmSnKqBQiETOyR5yEjahrFbHL7xorXDE=; t=1795362452; x=2110722452; 
 b=bfzq1aGzADjgXbtMK9RFueZCAkjO+ulvgL4IXJS5ymNG18r4VnN5rfjpID+Y2+AQAYUReuse+KP
 +2f9XNPHNvtzTOJE7vz7tdq7MllPVMj2qKC4w36JaHgO+CV/BKNAjJI6/3BirdZWvbsavo0s2oCpr
 xgJ6x8LbnlVgbqlZoS/gD9FHFcIRR1E8FFSpH0t+o12eVu4iB5rPrXChfVU2w5GZ1IUINPjTG7yke
 YMeJJ/DRwb9q3rBn87NLXTePn4LOYsm+fGI8z4aSk63IkHcU44hDALXJjfLEznA1PRJsEhU4Ul6Zj
 D1GsFvAh8ylPmGVwkE0ZXCmZ8k9tjfuYFtGg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xV9mr-00000002er2-1PiP; Sun, 22 Nov 2026 16:47:29 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/v3d: Remove V3D 3.3 and 4.1 support
Date: Sun, 22 Nov 2026 12:47:22 -0300
Message-Id: <20261122-v3d-remove-33-41-v1-0-52152b454ad8@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNNUxS9ijgUGzWDVVoognh3i
 +Mb/n8gS1LJMDYPJCma9YwV1Daw7D5ughqqwRrbEVmDhQMmOc4iyIyOkPvFOe8oDGyhZleSVe9
 /Oc3v+wH/SgLYYgAAAA==
X-Change-ID: 20261120-v3d-remove-33-41-37c44a41d932
To: Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=DuoDY+s9tIUiS81WwrsIhQxlbTfu4MZWVGe6cLUTbOA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBrAw6OetStndkwTq7BBvcxKr7BbSb8abhfnGxlp
 7ZWdrGHXrmJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCawMOjgAKCRA/8w6Kdoj6
 qv7NB/0Vwd3fZrMKdpPryeRq1QE8eNfApiliHZdQ9dG1jCstPXbw5ecultXLifd9gV7eXM3ascb
 yfhGTg8iOiPgQ+eXem+SFrRLo9X5kJePpuK+CvcTVj3OpR9W4iYV4jb8gqJvPH9GMx2hvbRvUDo
 Whoe1m2zQvgLhtTudFv3lqhjQbYtYpFQMkQDMBGAZvToB+OfjYfjOGL1FQkX9GQ9dwLTjmQEZjP
 w3qXYfZ9DtIu52lm6JJgVIoSnMzGFAulgwDP3Q3F4xOqsCWD741iBKQ5kNuDArL/PptmNLkkUCz
 BLqKZo3nO3bDaNJw9+xFLDeelfp2MHT024umD0MoeGJX8S5s
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

V3D 3.3 (BCM7268) and V3D 4.1 (BCM7278) were deprecated in v7.3 by commit
7ffcc4fffb45 ("drm/v3d: Deprecate V3D 3.3 and 4.1 support"), following
Mesa dropping support for them in 2024 [1]. The deprecation warning asked
users to report on dri-devel and no one has so far. This series removes
support for both V3D versions.

Patch 1 is a small DT binding adjustment. It makes "resets" required for
BCM2711 and BCM2712, as they don't have bridge registers and must use a
reset controller.

Patch 2 removes support for V3D 3.3 and 4.1.

Florian, DT maintainers: Can I remove BCM7268 and BCM7278 compatibles from
the binding? Does Broadcom use these compatibles? I'm sorry, I don't know
the exact procedure to remove compatibles from the bindings.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25851

Best regards,
- Maíra

---
Maíra Canal (2):
      dt-bindings: gpu: v3d: Require resets for BCM2711 and BCM2712
      drm/v3d: Remove V3D 3.3 and 4.1 support

 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |   4 +
 drivers/gpu/drm/v3d/Kconfig                        |   6 +-
 drivers/gpu/drm/v3d/v3d_debugfs.c                  | 150 +++++++++------------
 drivers/gpu/drm/v3d/v3d_drv.c                      |  43 +-----
 drivers/gpu/drm/v3d/v3d_drv.h                      |  17 ---
 drivers/gpu/drm/v3d/v3d_gem.c                      | 120 ++---------------
 drivers/gpu/drm/v3d/v3d_irq.c                      |  17 +--
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |  10 +-
 drivers/gpu/drm/v3d/v3d_power.c                    |   1 -
 drivers/gpu/drm/v3d/v3d_regs.h                     |  43 +-----
 drivers/gpu/drm/v3d/v3d_sched.c                    |  18 +--
 drivers/gpu/drm/v3d/v3d_submit.c                   |  13 --
 12 files changed, 104 insertions(+), 338 deletions(-)
---
base-commit: ce335050d9a670491139f5e4337934c3e963e7f4
change-id: 20261120-v3d-remove-33-41-37c44a41d932

