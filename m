Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58165606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=OOPTwjCQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D3A10EA04;
	Sun,  1 Nov 2026 11:58:24 +0000 (UTC)
Received: from mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B7910E5A5
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:48:10 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=6IcMIDVurWSAy1aeWi3vXutHP4gnx0qWt96gTgko+d0=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364489; v=1; x=1793969289;
 b=OOPTwjCQ5xHfNUuTv3/KB+6DI5LZawqjGkh+ZRXatVQyBKp8pomd6YytIXJSxZMnhMwJ2jkt
 ah1+MFczTSIp5unSUBGu5/Mq75xGYuwZsVqDEdBNrdHqHlZo+Y4j5FWafc/F4kJfzjwWGn1RZUG
 QySkurSAj/XhMvcDvmuyMCenZop8j2jAc5pQc6uZQh3B5x2ME0uyPrleilZP5OMQYgSWGFpOMFV
 UZShAornLqUptk+RUESpOhzJsbGK7DZchHqEXlEzCI+eqMkDcuIkv6zHmxUSOcuMxFDcWYYpgYh
 2xh11GeH1l1tS3mg7rdO/FdeRgoTVX69KRDTrTkfUp1gw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 7b69efa69f680fed;
 Fri, 30 Oct 2026 12:48:08 +0000
X-Mizu-Trace-ID: 7b69efa69f680fed
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 20:48:05 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>,
 Tomasz Pakula <tomasz.pakula.oficjalny@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/connector: Fix HDMI VRR capability member
 documentation
Message-ID: <4b9b0f01c86a84b4666a1ba38a085c7b84e9a585.1793364084.git.wy@wyuan.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Sun, 01 Nov 2026 11:58:11 +0000
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, when running 'make htmldocs', Sphinx complains:

WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')

Please take a look if I'm doing it correctly. Or if duplicated, please
ignore this.

Also for this file:

WARNING: ./include/drm/drm_connector.h:293 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')
WARNING: ./include/drm/drm_connector.h:293 struct member 'cnmvrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 struct member 'cinema_vrr' not described in 'drm_hdmi_vrr_cap'
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcnmvrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cnmvrr', 'cinema_vrr')
WARNING: ./include/drm/drm_connector.h:293 Excess struct member 'mcinema_vrr' description in 'drm_hdmi_vrr_cap' (did you mean one of: 'cinema_vrr', 'cnmvrr')

-- >8 --
From: Weijie Yuan <wy@wyuan.org>

The HDMI VRR capability comments name mcnmvrr and mcinema_vrr, but
the members are named cnmvrr and cinema_vrr. This causes kernel-doc
to report both missing and excess member descriptions.

Match the comment names to the existing members.

Fixes: 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB")
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---

 include/drm/drm_connector.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..bcdb402a7ede 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -265,10 +265,10 @@ struct drm_hdmi_vrr_cap {
 	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
 	bool fva;
 
-	/** @mcnmvrr: flag for Negative M VRR support */
+	/** @cnmvrr: flag for Negative M VRR support */
 	bool cnmvrr;
 
-	/** @mcinema_vrr: flag for Cinema VRR support */
+	/** @cinema_vrr: flag for Cinema VRR support */
 	bool cinema_vrr;
 
 	/** @mdelta: flag for limited frame-to-frame compensation support */
-- 
2.56.0.438.g30c3f27cb8

