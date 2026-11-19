Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8D60A2600
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dE2bLvck
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76BA811268D;
	Thu, 19 Nov 2026 17:04:21 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74AD011266F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:04:11 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b597558c4cso30589b6e.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795107850; x=1795712650;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WHGlKM/TYaoTSSlrFQblz+QKKasbM+5dQbEhB2u9x0w=;
 b=dE2bLvck20Doz8NsF8LRMNEyMgs8Pb19LQo47Y6emBjYN15VO0J8NJ2BHJOcZeAP7x
 QYoyijZE1EnxEA6U4U0ZVs59aYGwGNm8QizZJ/Zvva7El1yk2w8FPZqnMz/19YwVatd+
 4H6HSoMWzwGalS8Rtmc2hhyZe1qhXMO7duA/w0b4UtcYFkno0RVMlCBAwOCJiGKm6/Kp
 XCOZWzjgfxQvH1WoFZCg9QFeKKQHaw8v3PmEc9npDoYMcuR1jN3KieyHq/qI2ACUTqsB
 yxrd1ptyj6zhsPu889/8+rqurQztdFGRHEjE4Dk3iJoD9vbfJAvS7tN5ZGtqv0T7HbPz
 K+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107850; x=1795712650;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WHGlKM/TYaoTSSlrFQblz+QKKasbM+5dQbEhB2u9x0w=;
 b=tLqj1aNtxrKoGyWcFYSgcI8ED5KsUOUpE9bKZJ4Ksy+OEsCF4nOcL3RUo6WUbB5pnt
 oxvunh3As4Sa2KlCkYPFCUVR/RFDDecgF8MfLPcpLSra5vhk1UFlreXeRzSq9NTctx78
 VLCzV13mlaRuH4VR6xfALcJg+jFANp7FpPId2TNt47ojrwSekf/ksbam+HZ/vpg12j5N
 tca89f6XO+0HTXoQSB0s/CgQHNbnAJflPL2qjsNcHK/6nVrUUG+xDaS37z0lyNOBiylr
 jE6RwtyN3lAGEb0i550fk2oe9YV0hueCKbYuci2IFPfXARWuR+ozRMKMvebYyUMbCBlv
 0quQ==
X-Gm-Message-State: APuU4Z/QZ/USfptP8iLAcyrBEpHWHLZoBQ1+12DWlxc6+g3xAq8+usLt
 GEZi/hNnjORxIupfMySK3Pmr4bIBqP+F9/A44qzCz12iBbnBRBjS1azF4IBvW0HXJWXFk8ddX8l
 d3JnywEjvXQ==
X-Received: from ilbdx25-n2.prod.google.com
 ([2002:a05:6e02:4219:20b0:51a:af50:87cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23c2:b0:53c:8f0e:ee3e
 with SMTP id 5614622812f47-57a0b34690bmr545790b6e.36.1795107849735; Thu, 19
 Nov 2026 09:04:09 -0800 (PST)
Date: Thu, 19 Nov 2026 09:03:58 -0800
In-Reply-To: <cover.1795106937.git.irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1795106937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <8b8db80fa775d701fc94bf9e4aa4b0cc577febf3.1795106937.git.irogers@google.com>
Subject: [PATCH 2/2] drm/nouveau/kms: Initialize primary_crc for RG CRC
 capture on GB20x
From: Ian Rogers <irogers@google.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In crcca7d_set_src(), selecting the "rg" CRC source passes
NV50_CRC_SOURCE_TYPE_RG, hitting the default case without initializing
primary_crc before packing it into HEAD_SET_CRC_CONTROL's PRIMARY_CRC
field.

Initialize primary_crc to NVCA7D_HEAD_SET_CRC_CONTROL_PRIMARY_CRC_NONE
in the default branch, matching crcc37d_set_src() where RG CRC capture
leaves PRIMARY_CRC set to NONE.

Found via Clang -Wconditional-uninitialized on an x86_64 allyesconfig
build. Verified by building drivers/gpu/drm/nouveau/dispnv50/crcca7d.o
with LLVM=1 W=1 (-Werror) and -Wconditional-uninitialized; not
runtime-tested on NVIDIA Blackwell (GB20x) hardware.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crcca7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crcca7d.c b/drivers/gpu/drm/nouveau/dispnv50/crcca7d.c
index 912f59aebe87..02db81e5c8a3 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crcca7d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/crcca7d.c
@@ -65,6 +65,7 @@ crcca7d_set_src(struct nv50_head *head, int or, enum nv50_crc_source_type source
 		primary_crc = NVCA7D_HEAD_SET_CRC_CONTROL_PRIMARY_CRC_SF;
 		break;
 	default:
+		primary_crc = NVCA7D_HEAD_SET_CRC_CONTROL_PRIMARY_CRC_NONE;
 		break;
 	}
 
-- 
2.56.1.708.g77570a6a1d-goog

