Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90FE606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WpXP6/my
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923F010EE28;
	Mon, 23 Nov 2026 14:17:23 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BFD10E7E8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:51:32 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cdadf7e248aso1285358a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795438292; x=1796043092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jX0RW6LaoLCUoJWieDzex2x/0egSw3B2iYNY4JlEL4=;
 b=WpXP6/my7DoabyBgTzRBYMdQHslEHe+mPe251MWZHnfgprrXmUGNGS8qZRPBUr1+J7
 yXNf6Tenwp7R4Nuz2jr+apMou6fHbnYKAl9iDSvWNafYIXkAnIC/ryuIX69SYQFem7oK
 ErrZ29DzgOBPU5lxfnW9B1ZSceHlN5LjtdHnzARN12IGKmU3O9E92cCPRe6ZRDCdyxx+
 qC6LAeWn31ngQSUy8AkWIRAN9/LEuN//6Q9Mhe5K33KDwo+CBsqbgDIlyCoO3MnpMBAW
 209Z+6Jd7uRxOJ6eST3yi5fa1axrNp2Bs2zpjWTLIvu/XhPXsTmlXB3o1/TJRmn5RMLa
 Tb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438292; x=1796043092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jX0RW6LaoLCUoJWieDzex2x/0egSw3B2iYNY4JlEL4=;
 b=QTgenByLGaf7AYlIdsmXl2/V0Gf1SYCLLy78gVmM8MBTv9FA1S7X/jIykXFzlntfZ+
 guoiUUwKu+wrCxRBwKIGxE2IFLxMfP/HclywLdP4RpVlIz9GkeUHKNVUJSei7cd5FriV
 Iyf5XXS5j+h6WD3KcQpPXp9xSlHs/QtkCaE1mMFpBr9mC3e5GDHLStUXYd+h3BsBbjsh
 huYri386QF5yGH9X80Z8Bejcg2M6aubLAf/TiAgzQ3evXnryUx/L35T7DZ9vF388jBv5
 +tnG+iEsI+qVxlC8TSQZSLGYkuBiAjm21OWY4uO5X+07j3ZXcjiy0kvGU/+tKh8q1tp4
 rGKA==
X-Gm-Message-State: APuU4Z8SlMhXID6+bw+15JIkgSXJTkcyIGN7ujylI5Td+3reuXzERgRi
 L3PAMvtj7NEhXpzlclLFoHVuQvRNEUIyg1hulHY/S8JeXRx03n/8XXM3JRaPxNoP
X-Gm-Gg: AZFdTZdp/ZvbKHJNU2FVKxnlZ+E0OqOuLhecBDy6WfWcyW9MaW5WZC22bhgyo6TtOmG
 TA0wrg3QKZbWfb1gmVGBA2XQR7qdx14fMCAaA+LOS0myUHlF8gL9+VY190L81S1Wn8FJcK3H+Tp
 XxUrO5s5C93I+8vGz7bGilCPB8XtmMjTT9W5OWGNCO0duX2QtnYyrcxsMZHrmDe0BgRl9X0J+tW
 3T4mzGDToke9gh7vWUNMuIQTbiwMoHRoVI2XeIz0W6Axj/DVC5QWVKSBHHAfhgua0OeroST4BvF
 kQyub0djTc3pqqVQRVE+RNHYPXIKqlKHLuDr4OXxa/dF+Anhgo7EVl2jmtiqqpjt+Rnb5LIHywP
 uH4Sy5lNPSBWkvgApsJhCOj1h2R3HhPlqNpvoBrtlSCh08R3fMk3Ln8ZDbzW/3T0K/ndilsF4pC
 TcVFxWIQfNhtXVeF3KTQ0eUvCU7X2IG8MkuenhcRs8hS1J6/sy2UDYVNI8bAH6uk5eG7u5C1wiI
 eyezkk998Z1wvVioP09cpXkG4dkdxRQA6RQHeWUgNs8NJxnveMFf2Lv8CvvQvB5rrjOQ9wwD6rg
 f6RqsVoHPWqABI+oxizZ
X-Received: by 2002:a05:6a21:328e:b0:3eb:a7ca:4d78 with SMTP id
 adf61e73a8af0-4014a276af7mr11920730637.8.1795438292088; 
 Mon, 23 Nov 2026 04:51:32 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c87334890csm5587126b3a.33.2026.11.23.04.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:51:31 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
 Honglei Huang <honghuan@amd.com>, TAKANO Mitsuhiro <takano32@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/pagemap_util: Drop the kernel-doc for a member
 that does not exist
Date: Mon, 23 Nov 2026 12:51:27 +0000
Message-ID: <20261123125127.4114196-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kernel-doc reports, with or without -Wall:

  Warning: include/drm/drm_pagemap_util.h:45 Excess struct member 'peer'
  description in 'drm_pagemap_owner_list' (did you mean one of: 'peers')

The struct holds one list member, @peers, documented on the member itself.
The @peer line was added with the struct and refers to no member, so drop
it.

After:

  $ scripts/kernel-doc -Wall -none include/drm/drm_pagemap_util.h
  (no output)

The warning is not cosmetic in a -Werror build: kernel-doc exits with
status 3 on the file before this change, so a headercheck run with
CONFIG_WERROR=y fails on it.

The other DRM pagemap and gpusvm headers are clean with -Wall as well.

The change and this changelog were written with Hermes Agent
(deepseek-v4.1-flash); I reviewed the change and ran kernel-doc -Wall on
the file before and after.  No build was run, as only a comment changes.

Fixes: e44f47a9bf51 ("drm/pagemap_util: Add a utility to assign an owner to a set of interconnected gpus")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 include/drm/drm_pagemap_util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/drm/drm_pagemap_util.h b/include/drm/drm_pagemap_util.h
index 19169b42b891..34fa879505d2 100644
--- a/include/drm/drm_pagemap_util.h
+++ b/include/drm/drm_pagemap_util.h
@@ -32,7 +32,6 @@ struct drm_pagemap_peer {
 
 /**
  * struct drm_pagemap_owner_list - Keeping track of peers and owners
- * @peer: List of peers.
  *
  * The owner list defines the scope where we identify peers having fast interconnects
  * and a common owner. Typically a driver has a single global owner list to

base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.53.0

