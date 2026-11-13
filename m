Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC7606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=06pjvRsD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABDA1127B8;
	Fri, 13 Nov 2026 20:26:30 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDAD1127B8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:23 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-675617e81f9so1633518d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601582; x=1795206382; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zy16GvL527lzzGuoIX/ONvafjAxpppyaMd/GVGB7e58=;
 b=06pjvRsDIiJnQ3CI27SI5Sd90+7GKqP/8FMuiJc/zNJWUMn2SZmRLHrFNhmzn9hDbY
 aC1QwgWw1ZtQ33pJjCbGJC2zcffFO0XdBOcmpclUHjAHu7fZQP8+HfI8Def4KUYyKhpH
 WdlgJ4irhA5bIHIh5bdzTS2S8xg7OD0fHXH3CzgKZUZYaqp5uqoN7gWMG3Z6NNPaHxqU
 tNGxDTfWJkxmOi42X9lTcE5m2a5K3CdjpedQcdQa3nixfBgv2LWJY6+2ge2d6+N73fhv
 ub3VDnSsO1vkhYLOGBOWQznJ83BICIRQEqpeHi8e1O1nWsIOvO8+hnXz/YMmnELBIeZy
 o14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601582; x=1795206382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zy16GvL527lzzGuoIX/ONvafjAxpppyaMd/GVGB7e58=;
 b=fx7f129VgQdvOB44B3EO8xvCwuY/XG1dkkBWvVtM7bXGvKudo0Qc6FE2j8kBu6uNyj
 wvQQuxmUp1+zDhzndLhkdXPyxhHmdQEPbzLrhLN7nJFcIX41Nv8baLd+LgMDXBBBj2qT
 ZweDiUYMyePrQHAXtFfdppeFA5c1Tyq3b4SfCUKT8azmeh5zNQ2hIqzSjlL6e8ig8ZFc
 n6E2cIJw/KMTds3EKR1310IWV5dcZ6EVajUo0clTcukJA+VZDOVPc30CBe14LThJxJ+/
 DRAhHPM3/L65zjl/D0N31qXXhCFQBu6AEH3zs948LrQrS45YSGZwrQ1D+HjoE5ECjjMJ
 eA9w==
X-Gm-Message-State: APuU4Z9qYNSPw7j/mxd4fiBEtVHEnC07lk0nwpwTsB895nYD1aUq0ryR
 MdlXf89ecIaCHlzCLu3PhtxKGGUGtQqgACUYseVmWlSGgOYO9zyF+AFCy4qWZNK8yBA=
X-Gm-Gg: AYBFou3PlZQTPA+61puBJeJJaNgHKLaLMQ+jbppD564uZWNiElMB5a3RhPoyHxDxT5Q
 9eJRHNkKaAyPvWZ+G8Kpx7hr3dSkgArvVjmJHQD9lkgTTAIcclQNewhUWlEUv6Jgf11QlPuq53c
 JVt7qFMGKg5evWP4acv3atDmHnwiJJHGD+jwp4owuzamAiJKM5GkPlEPh3W8jlFtfNH21qclupB
 fTij3xhbdZk1heFkCzzTr5TrIiIyvlrZIqB7E6+j1+4OhfhAbpss/pF0VwGlRzKcDA0sKhL87TM
 DREx0fZuZoDr+0QawO4kD9SgIdQEnJx8kN+aqPCBaBY3bQ9muI5YidhBaQqAc4f73SftdQmj5Kj
 sajpkrOFg0uGr9UguZcGQohfUVYdKuh7EN9BJk3CNxnvZDoX7c3Z1idiMNOFYEtY55uoo0TSdXq
 H43okcC75U/I9QqrHqU3O1mG8lT7d9jK8jiaDn5o41i74wLGBmAl6duUiUxV6YFP7PnCU0e6S15
 +SbIyX6a9K3gSIDJBOhb8h0LNA+YcATFAAphMgtIB1vhuYC9IkHOnPxQnSgTGK/+9goypDMAhLD
 tN8M7GRX+2WKAa7cZDpuaQxxAhYJaPDB/ZzEUV+biREPLERJW82vZUe1yI88tNbpzvs=
X-Received: by 2002:a05:690e:1242:b0:679:94f9:5e7c with SMTP id
 956f58d0204a3-67d896ff4bdmr2309051d50.69.1794601582525; 
 Fri, 13 Nov 2026 12:26:22 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67d8a5b3b62sm2944923d50.13.2026.11.13.12.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:22 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 5/10] drm/gma500: make zero-page MMU requests no-ops
Date: Fri, 13 Nov 2026 17:26:17 -0300
Message-ID: <20261113202617.15464-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The inner do/while loops currently execute once for a zero-page
insertion or removal, touching a PTE and changing its count. Return
before the loops so empty requests become no-ops, including empty tiled
requests that must not divide by a zero tile stride.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 34ae0f125b83380b735ae454c775775cd74d0f62..6815b48f00d3b1bacf4a1bb492a5205cdc58e7e8 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -534,6 +534,9 @@
 	unsigned long next;
 	unsigned long f_address = address;
 
+	if (!num_pages)
+		return;
+
 	down_read(&pd->driver->sem);
 
 	addr = address;
@@ -578,6 +581,9 @@
 	unsigned long row_add;
 	unsigned long f_address = address;
 
+	if (!num_pages)
+		return;
+
 	if (hw_tile_stride)
 		rows = num_pages / desired_tile_stride;
 	else
@@ -631,6 +637,9 @@
 	unsigned long next;
 	unsigned long f_address = address;
 	int ret = -ENOMEM;
+
+	if (!num_pages)
+		return 0;
 
 	down_read(&pd->driver->sem);
 
@@ -683,6 +692,9 @@
 	unsigned long f_address = address;
 	int ret = -ENOMEM;
 
+	if (!num_pages)
+		return 0;
+
 	if (hw_tile_stride) {
 		if (num_pages % desired_tile_stride != 0)
 			return -EINVAL;
