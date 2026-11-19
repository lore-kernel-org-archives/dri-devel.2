Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC621606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dVrD3PzW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1631410F060;
	Thu, 19 Nov 2026 17:04:10 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B6A10F081
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:04:03 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-382af5cfc58so6011553eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795107843; x=1795712643;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PpOydH3EiuVYC0JIFAKpgbAxwR7+WpJ/TuK8OmPVRpk=;
 b=dVrD3PzWsDp5I5pd5FaQLxRl/k1HQbVvc6SzD4dEfmRHA0q94vHt9NI7JIN8xXnaD/
 XaO3pHK3AL+Ec94aso81jOK0tuRlaO57Sy8xgPUxQlI58S9AZXgV+HcJvwencJEbA1NS
 x83+IAxkl+JjopH+FYN5RyLqmVP2UX75JVcXcg5p6yRpnDP6sEaeIeke3ovRBJeTCt/B
 2SubHRyVqduqihq6bv7zm7OqnCUpzoDEyRbhNYBOk4IGd152czKtWAbX5AWyU1QWsz1Z
 TgY+JPGhKZ5Fo88i3zpXgFeC+W/qEvIEqbGhluZh5e67ksPBQslJNx4BCQ6fSYn0V/bl
 e8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107843; x=1795712643;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PpOydH3EiuVYC0JIFAKpgbAxwR7+WpJ/TuK8OmPVRpk=;
 b=uoxYguTzctquSE62Fo6yQiKvmn1doH6/2uO7zC0VwwLRYFXOPdop4Z/3AXD5Cbbjx9
 8ZM6zGq/5Sm2sx5MQ9CvjetJ6Xg0s7YV2mBSNJyndsqT0QEv+ZhIhgcfktb5Vi1nQuiq
 arsLNSQlxQECssaW1+cdd5VLM98OD/wpDl053ndfqDBf7tiz7kWfM2MyKcSPq+J5kZqo
 wMqeX6JVZF7LW6NUSqyvOkhsPUZJ3YB6Tjx8zwNaIkvcH9ILyef1cP+xuVOtO8sH2l/I
 xRWnHWXMEQY17J6eOV7ryuej9ApBRr+HpS8BUBbTUtrBwHGVXhyLnQSSBKpEhWE2/Xr3
 1LOw==
X-Gm-Message-State: APuU4Z/fm5a+P8hpvOoKYDcnJHihQjwj2kakduwzhy6b5067HKtRqxKu
 1J6IbUeOCjj/WEUzY5dbCYGhuxnb/Z4dPfSaWkgWRA6ThXhnea6yoB6PE64n7GzzaU+3Yld/9r4
 DRFYpFvoRhA==
X-Received: from dybml48.prod.google.com
 ([2002:a05:7301:1530:b0:376:328a:f96a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2113:b0:37a:a9db:6bd2
 with SMTP id 5a478bee46e88-3828026960bmr6552673eec.11.1795107842263; Thu, 19
 Nov 2026 09:04:02 -0800 (PST)
Date: Thu, 19 Nov 2026 09:03:56 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <cover.1795106937.git.irogers@google.com>
Subject: [PATCH 0/2] drm/nouveau: Two fixes from Clang warning audit
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two independent fixes in drm/nouveau found while auditing Clang
warnings (-Wswitch-enum and -Wconditional-uninitialized) on an
x86_64 allyesconfig build:

1. Handle NVIF_CONN_TV and release nv_connector on error in
   nouveau_connector_create().
2. Initialize primary_crc before switching on src in
   crcca7d_get_crc() for GB20x RG CRC capture.

Build-tested with LLVM=1 W=1 (-Werror); not runtime-tested on
Nouveau hardware.

Ian Rogers (2):
  drm/nouveau: Handle NVIF_CONN_TV and fix error cleanup in
    nouveau_connector_create()
  drm/nouveau/kms: Initialize primary_crc for RG CRC capture on GB20x

 drivers/gpu/drm/nouveau/dispnv50/crcca7d.c  | 1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.56.1.708.g77570a6a1d-goog

