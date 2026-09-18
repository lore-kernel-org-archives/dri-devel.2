Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD91C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26F910E390;
	Fri, 18 Sep 2026 18:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="i80Cky3W";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A70810E390
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=ZFWn+9tZx2ZRpTC2S3B/gHsd+oomsNLU+dwzo6AFhds=; b=i80Cky3WkfZSf5211WmFavqThS
 OEmSRTkW060bX5M/YPaBslCf2KBAiuxzS5uCUMxYpDJS521PGYbblTu7mMKJSN3c3P2gJkuRYnYbu
 b59nh3gqFwlQWHiugds9HQCrHb7aeZV8ODeU8Ordt5KLcMcPhOqiYbq/mhRyzU1UA2fi6vj5MeEdL
 NcgowkDRVdK1QPP3RLtboJrJQDIrenCBbM6RRVaOueobd5ehqG7KyAxfPOZFfmWLiSVB7gIRrjXpd
 j+l3YumA6aiVo7QHyWPYSf3/dV8HzfHlsNmv3Ygwi/BL5neG5Y7VD2+iQnx1+uuvZnTzS558UAFWK
 LWtzy5Fw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7dka-0045KV-Ba; Fri, 18 Sep 2026 20:55:57 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Stefan Wahren <wahrenst@gmx.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] drm/vc4: Reset the V3D block through the reset
 controller
Date: Fri, 18 Sep 2026 15:55:09 -0300
Message-ID: <178975770640.2754751.4760048743026029481.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
References: <20260915-vc4-reset-control-v2-0-cb3a25b07822@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 15 Sep 2026 17:51:23 -0300, Maíra Canal wrote:
> vc4_reset() recovers a hung GPU by dropping the runtime PM usage count to
> zero so that the V3D power domain goes down, and then taking it again.
> Forcing the count to zero only works if the driver knows exactly how many
> references it holds, which is why vc4 unconventionaly wraps every
> pm_runtime_get_sync() call in a private refcount and mutex, making the
> code cumbersome.
> 
> [...]

Applied, thanks!

[1/4] drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
      commit: fb825a46e7982460bd620f5e6a71924c647f4280
[2/4] dt-bindings: display: bcm2835-v3d: Add an optional reset line
      commit: 6ab4aad3481903ac3743513517c290a3ebd39232
[3/4] drm/vc4: Use the reset controller to recover from a GPU hang
      commit: b4448823f151d0b4a3f3f4c5622c6ade51422c4e
[4/4] ARM: dts: bcm2835: Add the V3D reset line
      commit: 3afbeb6b99ddbe082a238a659b7e7a7239f49e0e

Best regards,
- Maíra
