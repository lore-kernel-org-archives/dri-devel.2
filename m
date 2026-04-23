Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF8AFDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 20:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385C910F289;
	Thu, 23 Apr 2026 20:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="NesvFSUV";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8CF10F28B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776977732; x=1777582532; i=deller@gmx.de;
 bh=kD4ByncE5P0r3WsGsYODs4SPEglRPkKb/2LsfSNN6+A=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NesvFSUVac3pHVHFVwmt8TLM2plRq5QMYThFAJzxrlfbZsc6kFClYcUQP6kRVl9S
 W2IsUkLwfu+GrFS7MGET5JyoTO8eWk7YfCAP7vnDtF5xVBGXw2wkyA/2SIdcFx5DT
 4Q4D7uIgpJB1mn8bQvWKE/FIdfeJfy4GYm58z938IM+I3Og75lcI/iXKbFw4HeAPz
 SQ/Ib4TxxnPlEJsk4WVYzhmlSEcPRSQ/y/FxXaSpKHK89U7SXy4O1QObJ1N2jPUhk
 gbrVPax7PLzF9Bc1sVu217EOaHyCdSt/Cb/b2HHo56Q6AbVhu+qlwLO3dK4LwH0Wq
 FxplY84WckGfw/DNGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1vI3mo2682-00tVYl; Thu, 23
 Apr 2026 22:55:32 +0200
From: Helge Deller <deller@gmx.de>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
Date: Thu, 23 Apr 2026 22:55:31 +0200
Message-ID: <20260423205531.49971-1-deller@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zWc8qvNcoUyvBkSTTVLMaIkLyxTSpiqlY2MoxfQRdKbA4Zn9bKX
 QEdq5uNVz3CUxknSSFfxULQE5fZ6IN1SGdW71miw113Qjz/CssGMyluuSdczfsvXY/69I69
 FS9YPmSfQk6QvTQjS5chXfUs5OcZXkJFWD+pNSt2lcAOsdVvXEXOvwg3g6PGUBcdY1gogez
 lPeV2erpntazgE35xN/Uw==
UI-OutboundReport: notjunk:1;M01:P0:O4/AAyMIJ3E=;UOPQzFVos9rXuF0egNFt/VTSxQJ
 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
 /cylCsOZQdytSals5YNTUanevuSD1AlKq5iU=
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

This item is tagged for beginners, so often people not familiar with
the fbdev drivers think this is an easy task, start up their AI tools
and blindly send in the generated code as patches.

The problem:
- Those patches often introduce bugs, so
- ideally want the code tested, since ressource misconfigurations
  often lead to failing drivers
- The patches are often unnecessary, since in the old machines with the
  old graphic cards resource conflicts usually don't happen as only one
  graphic card can be used at a time anyway.
- and today most relevant drivers have necessary patches already
  implemented.

So, let's get rid of this todo item and silence the steady stream of
stupid patches.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 Documentation/gpu/todo.rst | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index bc9f14c8a2ec..b4dd64a8cc06 100644
=2D-- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
=20
 Level: Intermediate
=20
-Request memory regions in all fbdev drivers
=2D--------------------------------------------
-
-Old/ancient fbdev drivers do not request their memory properly.
-Go through these drivers and add code to request the memory regions
-that the driver uses. This requires adding calls to request_mem_region(),
-pci_request_region() or similar functions. Use helpers for managed cleanu=
p
-where possible. Problematic areas include hardware that has exclusive ran=
ges
-like VGA. VGA16fb does not request the range as it is expected.
-Drivers are pretty bad at doing this and there used to be conflicts among
-DRM and fbdev drivers. Still, it's the correct thing to do.
-
-Contact: Thomas Zimmermann <tzimmermann@suse.de>
-
-Level: Starter
-
 Remove driver dependencies on FB_DEVICE
 ---------------------------------------
=20
=2D-=20
2.53.0

