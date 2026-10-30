Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19C606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wyuan.org header.i=@wyuan.org header.a=rsa-sha256 header.s=key1 header.b=QtQhDgqv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6C910E9F5;
	Sun,  1 Nov 2026 11:58:13 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Fri, 30 Oct 2026 12:33:29 UTC
Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D80610E139
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:33:28 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=J6yTWKvyYdR4sg8KhoLGX7qxgtJ97l4XZ+Y485k12dw=; 
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793363607; v=1; x=1793968407;
 b=QtQhDgqvMapCmH0YkXxMNqtXGoMIsXn+ipceXC07awk98zPZF+w1jHCAYt8fbsAs5TnuNI+v
 6ilEtUuvXJIis9zN73ISqZP/93tCw5dZiHFIoCp7SyOdAYh8+hFBLuwJ9mnVAwfXyeQhEm+JB0I
 psa7hn2ID150ELFGu3hFCi5Lg2Jr9/q4fD+ZgkIcrCsauBurT7itcRBszRWkc44Q7arr/9YKKGn
 Bgc8CEPVQRA812O+IWWK7JDvav1KPcOXJpIViO89SsgmZF/MxM2UNuJ2haVzVv6NcpihuhNjfA6
 OhmQKBWchf6j25sHo4gKGg2jqpB4hjAUiA7wHKUqBsMeQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 323cb4c8f6ab2be3;
 Fri, 30 Oct 2026 12:27:23 +0000
X-Mizu-Trace-ID: 323cb4c8f6ab2be3
X-Migadu-Flow: FLOW_OUT
Date: Fri, 30 Oct 2026 20:27:13 +0800
From: Weijie Yuan <kernel@wyuan.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry VanZyllDeJong <hvanzyll@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sreeja Golui <sreeja.golui@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use a plain comment for panel polarity
 declarations
Message-ID: <dfd520477e9987eca7719e537b2865f4abe43043.1793362629.git.wy@wyuan.org>
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

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:3883 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Panel Polarity Control

But since I am not familiar with your workflow, if this is duplicate,
please feel free to ignore.

Also for this file:

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:329 struct member 'max_gamut_remap_coeff' not described in 'mpc_color_caps'
WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2225 struct member 'u' not described in 'dc_probe_status'

Thanks.

-- >8 --
From: Weijie Yuan <wy@wyuan.org>

The Panel Polarity Control heading introduces several declarations
rather than documenting a single function. Its kernel-doc opener
causes a warning because the heading is not a valid kernel-doc block.

Use an ordinary block comment for this section heading.

Fixes: 7dcd85c2241f ("drm/amd/display: eDP panel polarity control and test support")
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..03286f6aa651 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -3880,7 +3880,7 @@ unsigned int dc_override_memory_bandwidth_request(
 		struct dc *dc,
 		unsigned int bw_mbps);
 
-/**
+/*
  * Panel Polarity Control
  */
 void dc_link_set_panel_polarity_enable(struct dc_link *link, bool enable);
-- 
2.56.0.438.g30c3f27cb8

