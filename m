Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016D606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=emersion.fr header.i=@emersion.fr header.a=rsa-sha256 header.s=protonmail2 header.b=CONgnt9n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39FE10E23A;
	Sun, 25 Oct 2026 11:40:06 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974F810E23A
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1792928394; x=1793187594;
 bh=6eslfCC3ABP4Z1XjVwXxbHKPfc8IzpMrU43LTb75dzc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=CONgnt9nZi9rhqmdNxjWVSi/+ZKpSa8PmNnTWrofL+pbko3aKOgD/ataT7cdwg9xv
 I9M2VQL3D3bzf0nA2I0aIwRoVPYbsML69uAbjL/zOfgLGCjz7hbk360EsA8DHuutNH
 SjBprRCgkVeHTZ6DiDPJbOaGfWZWAwhPTC5wNEJ3h2AiDKtIzA9S4oFGwxyRbUYmr1
 hPYXRinu37H7cYiAI5WaBiRVnJq13GsM6dkPWwNXZ2O9DzKn409AuK5CLk5NgDnBv2
 Rjnx8o6g6TpAmDW7tMw0ZID8er9KVrxdBNCq0mvx18KsY9zSNpF4QKNTuo2nYbRjZG
 S7DzEtoqUA3eg==
Date: Sun, 25 Oct 2026 11:39:50 +0000
To: dri-devel@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 Daniel Stone <daniels@collabora.com>
Subject: [PATCH] drm: guard Linux-specific headers behind check in drm_mode.h
Message-ID: <20261025113946.111649-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: ffe6c0cef57655290cdd539d959ad307fafdb9f9
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Non-Linux systems (e.g. FreeBSD) ship drm_mode.h but don't have
Linux headers. This causes build failures [1].

Guard Linux-specific header #include behind Linux checks (kernel
and user-space). The macros depending on these headers are not
usable, but this at least unblocks libdrm upgrades. A future
patch may re-implement the required macros.

[1]: https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/462#note_3=
473512

Signed-off-by: Simon Ser <contact@emersion.fr>
Fixes: 4c684596cde4 ("drm: Add CRTC background color property")
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
Cc: Daniel Stone <daniels@collabora.com>
---
 include/uapi/drm/drm_mode.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index ed1a660a3dfd..b0e3d8c4df9f 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -10,8 +10,10 @@
 #ifndef _DRM_MODE_H
 #define _DRM_MODE_H
=20
+#if defined(__KERNEL__) || defined(__linux__)
 #include <linux/bits.h>
 #include <linux/const.h>
+#endif
=20
 #include "drm.h"
=20
--=20
2.56.0


