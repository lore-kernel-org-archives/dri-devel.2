Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60721FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6956B10E09E;
	Fri, 24 Apr 2026 22:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="VnsyjAeJ";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA58B10E0A2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 18:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1777053558; x=1777312758;
 bh=+rIN4AoFQDCARUNcTNv+OAPOjIHNpFlUIFmOxApD1WY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=VnsyjAeJ+qbZhWOuoAf0Uj9PjMeBHSNZv43D1eYGODbxHSXe6bgg1OeYKj1GbFOdZ
 1bL42kewOHLTNlU0M5RZlJvkQJCtxQpa3kU0oXBiWNCJf3mOLICLgp7kRR6n/I9K6g
 u1gaEE2a7bYr4posymmvd+EAmvzRZvcs7k0mtSEMBFhydt53RWnN3yDhQu/3wjmZUW
 ds90FDXmdKTEqejnXtx7SxOR718Gz9fRKx5sDszEFdXuk+rr/3/JdU1mOMG+X4leyZ
 umuQJzbdPrUnPhFvPDXlPfAUE2GjJHfZGdaELUin5vSNlNtmYyDUdVms2ilcz4owHl
 II/tvxAug3hzA==
Date: Fri, 24 Apr 2026 17:59:14 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>
From: Aditya Garg <gargaditya08@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [PATCH] MAINTAINERS, mailmap: update Aditya Garg's email address
Message-ID: <20260424175846.15103-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 89dc5780f8fa7a69d7654c614361dff868dd0ddb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 Apr 2026 22:08:49 +0000
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

My Outlook email address often sends emails from kernel devs to the junk
folder. Also, emails from some addresses (eg suse.de) are not received
at all. Update the email to my alternate Proton Mail address.

Signed-off-by: Aditya Garg <gargaditya08@proton.me>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 28eedfaa2..5c219b40e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -19,6 +19,7 @@ Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codea=
urora.org>
 Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
+Aditya Garg <gargaditya08@proton.me> <gargaditya08@live.com>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
 Adrian Bunk <bunk@stusta.de>
 Ajay Kaher <ajay.kaher@broadcom.com> <akaher@vmware.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 090b52a5c..0ebd747ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7894,7 +7894,7 @@ F:=09drivers/gpu/drm/sun4i/sun8i*
=20
 DRM DRIVER FOR APPLE TOUCH BARS
 M:=09Aun-Ali Zaidi <admin@kodeit.net>
-M:=09Aditya Garg <gargaditya08@live.com>
+M:=09Aditya Garg <gargaditya08@proton.me>
 L:=09dri-devel@lists.freedesktop.org
 S:=09Maintained
 T:=09git https://gitlab.freedesktop.org/drm/misc/kernel.git
--=20
2.52.0


