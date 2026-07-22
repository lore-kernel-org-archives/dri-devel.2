Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A5C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E28A710E460;
	Wed, 22 Jul 2026 13:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hkA9mOAr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE0610E460
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=tFP9teOJG3GKeYmxPYNazXzHWh61fp1/54dvrTxEfAY=; b=hkA9mOArXkdg45yE4KjRUeCa6v
 CCNpHleSQiYabFZRoHXkj+5OBxvZkfyX1Hn2sBeB5bo0XHJjeb4mhDkTEFdTCobdB7tQhieMIuQ3t
 YFFJNYX0ul1WM6S1iFvBPKw24YaJ+nRyhkpBB7Ay7vBTgh2ikupaocrjMfuvxkJ0G4vxXcuy9jBUU
 jgnEXVKJUxSiauU8nlljy0LnNSvYQKf4tds4Nl4b0pfCmrTY1xzTh+4+ioxVSLohEPURErZEVID0g
 sHCih5p2nz6jML9rMzodX/P1y8mOL/LFNFbdKlFkYVT2q+2k6DhKjBkOj4V5mKF9MsiKmFqwgYzg3
 KilCyQqg==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmXAh-0030yZ-G6; Wed, 22 Jul 2026 15:39:40 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/v3d: Idle AXI transactions before cutting the
 clock on suspend
Date: Wed, 22 Jul 2026 10:39:17 -0300
Message-ID: <178472755224.461453.16781147218856784522.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
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


On Sat, 18 Jul 2026 10:44:35 -0300, Maíra Canal wrote:
> This series fixes a GPU hang seen on the first job submitted after a
> runtime PM resume [1][2]. v3d_power_suspend() disables the GPU clock
> without first quiescing the memory interface (AXI), so if the core still
> has outstanding transactions in flight the hardware freezes
> mid-transaction. That corrupted state survives the power cycle and surfaces
> on resume as a GPU hang with an L2T "pte invalid" MMU fault.
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Reach the GMP through the hub registers on V3D 7.x
      commit: f7df2da0d1c375c1c4c70e1e0b569592de0d6b73
[2/2] drm/v3d: Idle AXI transactions before disabling the clock on suspend
      commit: 07e769ba3d82ac614725c81c512a8b54d33f2c9e

Best regards,
- Maíra
