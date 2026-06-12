Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D93ECD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E491A10EAEC;
	Fri, 12 Jun 2026 17:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JFsoQ2pP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 052F110F5AD
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 17:17:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36A3A601E5;
 Fri, 12 Jun 2026 17:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5B10C2BCC7;
 Fri, 12 Jun 2026 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781284655;
 bh=ASg6th/Ywmh/h86ebbxcUhuLfc87yXzCgfN5EC0OsO8=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=JFsoQ2pP0uFB/bFTqDn57k1zqF7cf2M3k+YjLhW0QjBZenlUyA7CL3zRwCEONukoQ
 jp/tpEPq+nXf6b8co/NmAq4KvctppX8ToDVXqIhfBhUPaIMDizJosbcEtYeVqpy2x7
 S3shx3snBSAF4lG3dSRNo+IC/b39PzqSKxrQ585/ySB91M0DqwVpXYl6melnfDcS7v
 lbfNiyenIL+0nAWbjwKDBuJ/Un6CaUtbbDPWg8XkST7evEXA0s3WXpwGwZ18GFpn/Y
 rVT8o6Pk5Kldlh1eU1flmvmNudBfQmTk0zFceRb+QXdDQkxJ3Qm6h98g8LHWZdspxW
 xQruwPpt71CPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CA644CD8CA8;
 Fri, 12 Jun 2026 17:17:35 +0000 (UTC)
From: Alberto Ruiz via B4 Relay <devnull+aruiz.redhat.com@kernel.org>
Subject: [PATCH 0/4] drm/solomon: batch command sequences for
 SSD130x/132x/133x init
Date: Fri, 12 Jun 2026 18:17:15 +0100
Message-Id: <20260612-ssd-batchcmd-v1-0-c61e5f7c24bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Mj3eLiFN2kxJLkjOTcFF1j0zTzpESLZMNUiyQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAltat13AAAAA=
X-Change-ID: 20260612-ssd-batchcmd-35f7ba8c1e8b
To: Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Alberto Ruiz <aruiz@redhat.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781284654; l=1263;
 i=aruiz@redhat.com; s=20260612; h=from:subject:message-id;
 bh=ASg6th/Ywmh/h86ebbxcUhuLfc87yXzCgfN5EC0OsO8=;
 b=f72LNDqZsghUxEI3JFC8MhurK58aFX+wDsNTgvTFeOgVPaJv/5lNTa6gbaLgCz/o31XMezW2L
 gNk9qIQ4jeQBsNOPDM3DSURKL0b5zycnjcGNdMdH6b7DuOrfp8qJ1e/
X-Developer-Key: i=aruiz@redhat.com; a=ed25519;
 pk=d1doFQwve1B/jU9nG5oPl1W5d+t+iFrjkkwk/hD97Ow=
X-Endpoint-Received: by B4 Relay for aruiz@redhat.com/20260612 with auth_id=818
X-Original-From: Alberto Ruiz <aruiz@redhat.com>
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
Reply-To: aruiz@redhat.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The ssd130x_init(), ssd132x_init(), and ssd133x_init() functions each
issue long chains of individual ssd130x_write_cmd() calls, each
followed by its own error check.  This is verbose and makes the init
sequences harder to read and maintain.

This series introduces ssd130x_run_cmd_seq(), which interprets a flat
byte array of length-prefixed command entries terminated by a zero
byte, and converts the three init functions to use it.  The result is
a net reduction of ~110 lines, with the hardware programming sequences
now expressed as compact, declarative tables rather than imperative
call-and-check chains.

Signed-off-by: Alberto Ruiz <aruiz@redhat.com>
---
Alberto Ruiz (4):
      drm/solomon: add ssd130x_run_cmd_seq() for batch command execution
      drm/solomon: use ssd130x_run_cmd_seq() in ssd130x_init()
      drm/solomon: use ssd130x_run_cmd_seq() in ssd132x_init()
      drm/solomon: use ssd130x_run_cmd_seq() in ssd133x_init()

 drivers/gpu/drm/solomon/ssd130x.c | 367 +++++++++++++-------------------------
 1 file changed, 128 insertions(+), 239 deletions(-)
---
base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
change-id: 20260612-ssd-batchcmd-35f7ba8c1e8b

Best regards,
--  
Alberto Ruiz <aruiz@redhat.com>


