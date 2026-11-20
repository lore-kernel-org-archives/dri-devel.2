Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45160A2615
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEcS1+yh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9686610E05D;
	Fri, 20 Nov 2026 17:19:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B97610E023
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 17:19:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E823A40137;
 Fri, 20 Nov 2026 17:19:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795195142;
 b=QFho46/Wr0seqVeF+t2UTATyOGt5IEHRLvO1mHeEPP/rDwDd8kZNC+R+rChJ7FHUZ2ko
 oK08qEujA5pEHEF28E2Ysnv3MLovUoiVWJdGAW23AD1JfIVC8xWH0tOmrHPd4R8ycO5YW
 zMRdA/R73+LjLkjX/3TMin47BBwuk+pkEzdKi9P/j+/Su/UlxX59wZ9Lv+OCOw9Ayf5XK
 bjubIVvzjob4iLLd0Hmq/Y7kaz/2DqbiWmRQRbc1J0rjteQQ4AqadPCi/0R6CtuIUttK2
 EHF9TVifS0Z5Zgx9BaYPzm4bHBxP3V06KC9nHrPA8MgrFYvg4tTYC52XHBfBOPNRBHw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795195142;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=yh5n9jWo/3W77LwmiI39asuVgN3yT8N8hYH+AL2o/iw=;
 b=CxDq72xJVN2sTznpR5Ad2/eGBlcwihwyvcSr9uLgK/UVAO74v/fzSgmm6kQkNFyIuhR3
 sUjvE+mVbc1i5gOER0b1MiQxRMzW7z230RQ5DzFBis9MgvJN1V0jsWVi8lMchP3rpscKC
 MnxhKgoohu+6aTFVSkLPNsbhruZ5pyod+zEyGeKvCKGcH/b1ls7AJpO+Qdoz1Rf0o6GDf
 xoo89vraywklFmbWUxLcMjIZqxRzT/nAHLEKugQRJjPc8cxiPQbKmDNqjmEZSOEwqWDPD
 yI0vXet96XIijENR76t/trryVj6TmsNHRzxfGZtwyreIgWx8NKZvAcTP4k2er4gP88w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CCD411F000CF;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795195142;
 bh=yh5n9jWo/3W77LwmiI39asuVgN3yT8N8hYH+AL2o/iw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=hEcS1+yhhiO6duCO1O93xW/CRD01YuvtqfVr5AH7mhBZ7XvGcj0VGpHaX3r128iIZ
 KmC46roAC4PRs/aCASjDz7hvvIKKuTj36D2mRb44JvNTMxzJjA/GbEOYvDB83foEeF
 tOnqsL2Kae2se9JHzyy7hsu10Lwi7Tuo1on2gkcjiRXHeNNS0r6VATpYX/00nCx850
 B+K5XK8almyeTJCOy5Rg29NMKnv4sZcs98f/DK4Lm/ldHYjpdq6mrzUbg3RWZ62XQs
 iOWIax1itvlk5j6z8CskL9jhgV9iYkybly32/PFZ4WQGYseHe6zmsxC1OH0KP51rDo
 /vA8jmuiwMBZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 592A04B87D;
 Fri, 20 Nov 2026 17:18:46 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 10:18:30 -0700
Subject: [PATCH v2 3/5] drm: fix config dependent unused variable warning.
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-rd-mostly-v2-3-88056ede02a8@gmail.com>
References: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
In-Reply-To: <20261120-rd-mostly-v2-0-88056ede02a8@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795195125; l=1090;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=FWl5eybJevr+52Kq5KRfTj77HDYm3mQVIttIFHf1YBM=;
 b=NOIutQD7kqK1VDi5lWhr/3MbHVkNy3BWiKygm/5FUyz8vqm+NhKzWvQHtDpOo/JTpswB2rCf6
 ArCsKbgc6SBB7oIAgpHM1xZDuD/c6LoxyRdqST7f4JZguv4n1e4CRNW
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: jim.cromie@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jim Cromie <jim.cromie@gmail.com>

__drm_printfn_dbg() does:
      enum drm_debug_category category = p->category;
then:
      if (!__drm_debug_enabled(category))

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, __drm_debug_enabled(category)
expands to `true` without referencing `category`, causing an
unused-variable warning/error. Silence it by passing p->category
directly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 50cdeb1b15e2..12b95901eb70 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -218,9 +218,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);

-- 
2.56.1


