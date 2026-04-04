Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4D2E88D8B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 10:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E0B189F71;
	Sat,  4 Apr 2026 10:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dJK0HsQa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4759989F71
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8M156wfxsw08c/N3AsfeAf2KagUFS03fu06PBN70kOY=; b=dJK0HsQaEwf/UJnpEs487pcJ4C
 Y2NySHfJUwbOrj7lPO/sbgDir7632a63T/Z4mVtF2UHOEfgENzTSKiSfVuvdZtIyvTbl47/83OyCq
 4Dgwq1FhpFF/ulQWj0BhGFGcbqbesr3VHOZZqmuCRJNw1vw54OzROYYiAMeCe2QrBLG3JOMUSFr+P
 c2sesOCbIuTzoZFCwmqbxX8Kbr9Lnxtro43dGE2pcIBbfZKzqefTJyjH3GIFpa4NhgFyji4oTjf9e
 EXBZkv50/xkMk5V/rVxv1ZF4DxoF1MSsO7i5sc4ubkclhKz4ZLipz5tjER9McfZkOG/Z5KGLZtyQa
 pw0WPs3Q==;
Received: from [189.7.87.169] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8ydf-00Bnm6-9R; Sat, 04 Apr 2026 12:54:03 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Stefan Wahren <wahrenst@gmx.net>, Maxime Ripard <mripard@kernel.org>,
 Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 kernel-dev@igalia.com, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v9 0/3] Power Management for Raspberry Pi V3D GPU
Date: Sat,  4 Apr 2026 07:52:31 -0300
Message-ID: <177529993945.2604999.5241727039867600030.b4-ty@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331-v3d-power-management-v9-0-f52ff87bfd36@igalia.com>
References: <20260331-v3d-power-management-v9-0-f52ff87bfd36@igalia.com>
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


On Tue, 31 Mar 2026 09:35:50 -0300, Maíra Canal wrote:
> This series introduces Runtime Power Management (PM) support for the
> Raspberry Pi V3D GPU.
> 
> Currently, the V3D clock remains enabled for the entire system uptime,
> even when the GPU is idle. With the introduction of Runtime PM, the
> clock can now be disabled during idle periods. For example, with this
> series applied to a Raspberry Pi 5, if we check `vcgencmd measure_clock
> v3d`, we get:
> 
> [...]

Applied, thanks for all reviews!

[1/3] drm/v3d: Use devm_reset_control_get_optional_exclusive()
      commit: de1e32ef1d625ee4d717bcf10c23df2722324f62
[2/3] drm/v3d: Allocate all resources before enabling the clock
      commit: ffd7371ed4179827dcf401543b37b69e5781f924
[3/3] drm/v3d: Introduce Runtime Power Management
      commit: 458f2a712ab42b7d3615208862922dc35fe90ef9

Best regards,
- Maíra
