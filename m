Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B880C1061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D863910E5BA;
	Mon, 30 Mar 2026 17:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gStX10QS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF2310E557
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AKUURQYni/bSFDR2FkS1RsePkvmLzNiw3DMN68+2gww=; b=gStX10QSqqqcWM16giHAMcsBIb
 NIjLUZaA14Db4XHUcfrw+w/7tMD38woIj1CXsx2RsxAkASOvEkFKFZ6zH5lyTdDpq9UFWX9BthwFZ
 jGl7kJOYBKwyZmyxMp3myLbhqRNfYDv+tzgLelvzOZENcK5iN6Fo2s5NYo2891/pAe53zk7RXymr3
 BIT8Dx9JTryXVJby4wEtZkmPCJB9kADAjjz7jZi2KquOX3IL5MJMSxRqM2peSZWp6WOSv1mWzHk9g
 dzTWQGumJ3NRCkMwH1DzpaKzBlinXJsYDY11F6MkUXKkSqZSNP5V4B8tgduYtVeHw+vlhVs2nymYM
 zmyfZtxw==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7GmL-00961G-06; Mon, 30 Mar 2026 19:51:57 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/6] drm/vc4: Miscellaneous fixes and improvements
Date: Mon, 30 Mar 2026 14:51:42 -0300
Message-Id: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LQQqAIBBA0avErBuwsrKuEi3KxppFFg5EIN49a
 fn4/AhCgUlgLCIEelj48hlVWYA9Fr8T8pYNtao71TQKH6vxZLHo+CXBYTW9dqbVzjrI0x3oD/m
 Z5pQ+oj5whmAAAAA=
X-Change-ID: 20260330-vc4-misc-fixes-9b874f854fcf
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1573; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=CYSDQAurW7VMs8AZF011KUDGyoqkVA0RY9ouMQa1tRI=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyrg43mE2yO/VUyc6j0J60lohDjcmjiGMzNIi7
 DmHwr8DSWOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacq4OAAKCRA/8w6Kdoj6
 qg9BB/4t6aYLvIVPG2l1XAn/nTchq/Ac+iXZhjVwgukLml+83SvvsGivnhwefnAdZftMDgdI4nF
 O4UIFtCJe/FtC88ZeVQxq1SYMr9Mq4e9eF8wogNgrOYsDrAiFsCd5wZzRXEnoQr0eKzjdTcso4O
 AJZd1UdwP9mKHuLCAd1v3yBnoR0Uq1MTkh3lxkKeT3tp9mx13gEKaUskts5Lv9JRpQEePDlYZ0C
 bMLK9ktB9KQDS5L55CGAYNSUwlN57hILrW6rH2iIFBelQc3WmzdH0V8eft9tOOI/8lH60zDC+wu
 vazHO8dk1pFMWzSXTbVNBTQWCIYlR9kVRs9Tv+uU9+O8mEdY
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

Hi,

This is a spin-off of the series "[PATCH 00/11] drm/vc4: Switch to DRM
GPU scheduler" [1]. While I was writing the series, I noticed some small
bugs in the driver code, so I compiled the fixes and code improvements
in this series.

Patches #1 to #4 are bug-fixes related to PM reference unbalance, memory
leaks, and race conditions. They will probably go through the
drm-misc-fixes branch. Finally, patches #5 and #6 are minor clean-ups
and common API adoption.

[1] https://lore.kernel.org/dri-devel/20260205-vc4-drm-scheduler-v1-0-c6174fd7bbc1@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (6):
      drm/vc4: Release runtime PM reference after binding V3D
      drm/vc4: Fix memory leak of BO array in hang state
      drm/vc4: Fix a memory leak in hang state error path
      drm/vc4: Protect madv read in vc4_gem_object_mmap() with madv_lock
      drm/vc4: Use devm_request_irq() for automatic cleanup
      drm/vc4: Clean-up UAPI header inclusion

 drivers/gpu/drm/vc4/vc4_bo.c        |  4 +++-
 drivers/gpu/drm/vc4/vc4_drv.c       |  2 --
 drivers/gpu/drm/vc4/vc4_gem.c       | 20 +++++++++++---------
 drivers/gpu/drm/vc4/vc4_irq.c       | 33 ++++++++++++---------------------
 drivers/gpu/drm/vc4/vc4_plane.c     |  2 --
 drivers/gpu/drm/vc4/vc4_render_cl.c |  1 -
 drivers/gpu/drm/vc4/vc4_v3d.c       |  1 +
 drivers/gpu/drm/vc4/vc4_validate.c  |  1 -
 8 files changed, 27 insertions(+), 37 deletions(-)
---
base-commit: dac97a6bd6c4a24e60a147cb2cf750eddb7594a8
change-id: 20260330-vc4-misc-fixes-9b874f854fcf

