Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9379C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F7D10EE1A;
	Wed, 22 Jul 2026 14:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IR9ZL0go";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5423710EE19
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=XBeWR5p3Fe6SSOnkPWG+8lg86ukLfnbIU+xZc9w0qJo=; b=IR9ZL0goeuytpgDQ0e/QSWjnDu
 KA3mo8UPNnOdGm0NUZFsDxPWQoKFa6+7Ygbd+3UhRO9EcuE/w6eGSMhxxolWchE+sbdnENLwJS7QV
 0jsJ4sZuRxddHG2hr0kKJiMkhz3BLbxqCZU/lUkNL8cucrd2FVM6C7tNuHjBUYAnUrjXgIC8AbbSl
 GhUdYrlUE/UmSC+JLEgR1at+eM2495DJQ6Gu7HdC8RPcxLSp3JjOS6vKYGf/EEYil/R1Bt0CYDTW4
 Y/h5bpf0D3BM9LeJU/L7WpYHeMC7/iLKFd99y9gxPjVQtIrG0EI6M888XMIogqkxG141b9nmQKqlW
 1sikt7gg==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmY8N-0032O6-OM; Wed, 22 Jul 2026 16:41:20 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Douglas Anderson <dianders@chromium.org>,
 Eric Anholt <eric@anholt.net>,
 Gregor Herburger <gregor.herburger@linutronix.de>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2] drm/vc4: hvs/v3d: Fix null dereference in unbind
Date: Wed, 22 Jul 2026 11:40:54 -0300
Message-ID: <178473125185.615894.17655363603087049124.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721-rpi-vc4-fix-v2-1-b813dcd01dc7@linutronix.de>
References: <20260721-rpi-vc4-fix-v2-1-b813dcd01dc7@linutronix.de>
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


On Tue, 21 Jul 2026 17:38:19 +0200, Gregor Herburger wrote:
> The hvs and v3d drivers use dev_get_drvdata(master) in their unbind
> functions. Since the vc4-drm gets removed before its dependent drivers
> (vc4_hvs/vc4_v3d) the vc4_hvs_unbind/vc4_v3d_unbind functions try to
> get drvdata of its master and fails with a null dereference error.
> 
> Use the data pointer passed to the unbind functions directly instead of
> dev_get_drvdata(master). This avoids using potentially freed memory.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: hvs/v3d: Fix null dereference in unbind
      commit: 7dc3680b7ffe01add3e9299fde8471d2dd53a8ae

Best regards,
- Maíra
