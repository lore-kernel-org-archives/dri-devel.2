Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF3606A328
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAAvE60n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45C8210F37D;
	Tue, 20 Oct 2026 08:10:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC5810F37D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:10:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A030460A65;
 Tue, 20 Oct 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792483814;
 b=MslniPsiqXmB4qGKdbhGfT87cfA95o/AG8TXEHZsbC2Mhdyw9/W44doHh/3x4892rPPG
 f+A7EljKOwoOwjytsKWxzR6o+qb8woKiyuKaCWRmBc0lofmTcdssRaux49vymd8ENra8m
 BqdmAbN2Bu8UpADM9fc+mNRlhX1uIMxOuAUt2IaE5Xpo/DKBAWXasCwd/Xr8B0R2gBQap
 GXKFxSJGIWVd77Wv0EqnywF190i9mvdBIhGVcXWC4FJioCosupvLYduvmj9yYWC02gg3m
 q6uBmPyfTDcyRXWBpSrPjhkdih1FbJMQjJEdHYk2VphQX0Lvp+nSW8HmotrDevduz0g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483814;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=wdjAbO5fFZ4SU/WJZdQY3BNCfbKUwODdR2e5Miu4Hcc=;
 b=RmKRIDOEkLO89HFPkrwWTKjGApi89tJub6LyHfiyiGyS7W25KO1qj0xol3zrrdgIyXFV
 CfrkuUk2PkBNajFOBxq35C4skzO7FDtWW/ybJ7JnR2LT5WCjFKfzbrQe5i7t+dN2rCvkN
 y9UqQy7KOtM5SqmxcHI+3vLL+avQJieD+x0aIU4PCuki/VCNGz6M+UWjOZsA26cJsiWfg
 W3rrUMEgpgZE8t3NUHd605glt6vW0842uhS/jW2ocyZqmU+CYHOhWg6ON2R0qjB+qqcrl
 he3jhyendkw38PeIi37ntDpSJcPHmPMEsmaJFM9gAzWyCgXQYgooUCmNLh4ChNdsYTA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9B9C91F00ADF;
 Tue, 20 Oct 2026 08:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483814;
 bh=wdjAbO5fFZ4SU/WJZdQY3BNCfbKUwODdR2e5Miu4Hcc=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=RAAvE60nCornBKyBbQ++wyFJY5i5uCjKRcqoTzStE7zu45Br0XgDi1zPmjus5bc3p
 OoywqJLP273SuhqD2Au0IMSCFRNzPkV+p8DpD53lg76zEX1ewaUigBQKSNA0CTR39q
 KjB1T2hrQ6bPs5f5FOVF2cJRKoDsvQjSW5S6LJI8oFHBUMEG0IFC4F8TH/PZiUfGmD
 vIfAx8RPqO0O23lkFoIO+tgL5u6hBTORRHTZGj40OiML+tjSnTGoNVyRjN4H0MiRfV
 aqaW6RrlO2Mq4e/gGa2hBdJGoRZ0bOi33/CN/DL9HJIF5RWKqwXKzaS6MH1gixx3qz
 TxfbvhTsCngkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D125043085;
 Tue, 20 Oct 2026 08:10:11 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] drm/tegra: Support YVU formats
Date: Tue, 20 Oct 2026 03:10:06 -0500
Message-Id: <20261020-tegra-drm-yvu420-v3-0-7f19a834ba98@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBCF4auQrq2ZaYuiK+9hXJR2gCZCTYuNh
 HB3CysWxuX/kvlmZpGCo8iuxcwCJRedH3LIQ8FMp4eWuLO5mQBxQoCKj9QGzW3o+ZTeSgBHW9d
 nVECl0iyfvQI17rOR90fuzsXRh2n7kHBd/2AJOXBr0CglDUAjb22v3fNofM9WLIkdgL8AkYESR
 VVdEKSu1R5YluULwDvQafEAAAA=
X-Change-ID: 20261008-tegra-drm-yvu420-1dbb7140e54a
To: Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483811; l=1918;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=UNJCnLzNELDA2JhJJEdojVulK80QfqyCajHgxLoaqXY=;
 b=4SHbIyPX/mu4c17CytuieKZ7CuYq1/sk1jNotZQ7DQ5BNbWStdZOimoS87zN+9YGv5tI+VySY
 1Q1bJLZHcMTD+t8z8dKfUnpoBO/wRcVUE7VGhGtlPFVxEN+q99Jqa/V
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is not directly supported by the display controller hardware.
However, this can be handled efficiently on tegradc by just passing the
chroma planes to the hardware backwards and reporting it as the yuv
equivalent. Nvdisplay has a hardware flag to handle the swap in
hardware.

YVU420 is required by AOSP for software decoded video playback among
other things. An attempt was made to handle this in gralloc by swapping
the chroma planes there, but it wasn't working. This kernel
implementation is working and is more generic anyways. This has been
verified on a SHIELD TV 2019 Pro for the tegradc path and a Jetson TX2
NX for the nvdisplay path.

---
Changes in v3:
- In patch 1, use the SWAP_UV window group flag instead of manually
  swapping for nvdisplay
- In patch 2, support the chroma swapped variants of the other yuv types
- Link to v2: https://lore.kernel.org/r/20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com

Changes in v2:
- In patch 1, simplify pre-nvdisplay path to a swap of the window base
  address
- In patch 1, address sashiko report about failure to copy the new
  struct entry in duplicate_state
- In patch 2, address sashiko report that yvu420 was missing from
  tegra20_overlays when the targets already support yuv420.
- Link to v1: https://lore.kernel.org/r/20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com

---
Aaron Kling (2):
      drm/tegra: Support swapping chroma planes
      drm/tegra: Support YVU formats

 drivers/gpu/drm/tegra/dc.c    | 13 ++++++++++++-
 drivers/gpu/drm/tegra/hub.c   |  9 +++++++--
 drivers/gpu/drm/tegra/plane.c | 29 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/plane.h |  3 ++-
 4 files changed, 49 insertions(+), 5 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261008-tegra-drm-yvu420-1dbb7140e54a

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


