Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9AECA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D833110EB05;
	Sun,  4 Oct 2026 17:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=nozomi.space header.i=@nozomi.space header.b="bjDMfkaG";
	dkim-atps=neutral
Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DA2010E959
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 20:01:36 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
 s=mail; t=1791057694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tfREhYRXJ7Q92Tr9PPmVOt8zfNsE6sWWHy9z3k5zAOo=;
 b=bjDMfkaG/ZJjjETtW7E/RsdKMuH9oGtEYv7AZOLJC6xqUQmzldkgYwPQ9pUguIuw6cKI5w
 Fwmz0vRb22geNlaooD5FbCvhzXjrusd5ciHEPWZRNO5zSA5/WfGEd2b71axAzhnf/knczc
 Q2ffISz2qC4b+0DwdLUlmx2gR7VVxvJZBO/hBJ0TLWCOGAwJx5t1Nbg7ONvHfE5VxPVAkA
 hDMVqb9Az27FD/W+fHmNNx4SaqNVIS23iSm3jW5EW0+KMw5x+Soh2BiCwn0hPsqpMSm+9o
 f0AZYBensYlpw/Z5gApvC+r9ihIwPZUXR+aN2TDKKTx9xBzj/z40GRdylFed6Q==
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH 0/3] drm/panfrost: Enable the GPU timestamp counter on MT8188
Date: Sat,  3 Oct 2026 22:01:29 +0200
Message-ID: <20261003200132.866240-1-michal@nozomi.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

On MT8188 the GPU timestamp counter reads zero until a register in the
MFG configuration block routes the SoC system timer to it, and the
setting is lost whenever the GPU power domain is turned off. As a
result, the SYSTEM_TIMESTAMP query and the timestamps written by jobs
are always zero, which breaks timestamp queries in userspace drivers.

This series adds an optional mediatek,mfgcfg phandle to the Mali
binding, uses it in panfrost to set the register on every power-up,
and adds it to the MT8188 GPU node. Without the phandle the driver
behaves as before.

MT8370 shares the GPU node and the MFG block with MT8188, so the
binding allows the phandle there too, but the driver only enables the
quirk on MT8188, where it was tested.

Patch 3 is meant for the MediaTek tree; patches 1 and 2 can go through
drm-misc.

Tested on the Lenovo Chromebook Duet Gen 9 (Ciri, MT8188): the 13 MHz
counter advances by 100 ms over a 100 ms sleep, also after resuming
from deep suspend.

Michał Kopeć (3):
  dt-bindings: gpu: mali-bifrost: Add the MT8188 MFGCFG phandle
  drm/panfrost: Enable the GPU timestamp counter on MT8188
  arm64: dts: mediatek: mt8188: Add the MFGCFG phandle to the GPU

 .../bindings/gpu/arm,mali-bifrost.yaml        | 17 ++++++++
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  1 +
 drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  1 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c       | 39 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h       |  1 +
 6 files changed, 60 insertions(+)


base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
-- 
2.55.0

