Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097B60A2603
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gl7EKH7q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955BD10E0E6;
	Tue, 10 Nov 2026 04:30:13 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 461ED10E919
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:30:07 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-9440304604aso169040785a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794285006; x=1794889806; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Q+FU7s/IaJwwuXx/A4tn6m950pvjid5cEZuWPY05gI=;
 b=Gl7EKH7qv03b9OZ1akhy67Blc++Se9WI8LCisCTUCNfQh366T2a4e/Cgc2fldia3vc
 0k9884HZPidtP8GrC0nUyeWbLa474AAA9dlTZpPaqPKg4OCDjmwtiRDek1/2ROEtML2G
 TPEUEm9JsfYCl/0YmTPRM7UbpOsSFzxGvSbTK6Em+/lZQ8vdnglbBqC4/RXTiP6hNtAD
 TFIKVpsEgRfQDBWCNb60gq3XWIy4TWlACwvTeuaM7TydCzPMw2AYb48YQJDKUCaXNwD0
 oOIlwLLbeqEA9J+TLRuVxFy3zE8kBzAGCl1OnDYu9skErHT4eFYZrHwTu6hJ4g2bUoU/
 jWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794285006; x=1794889806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Q+FU7s/IaJwwuXx/A4tn6m950pvjid5cEZuWPY05gI=;
 b=vAzGRUDgD5Nwjg9EL8YGnK3r3PnA9ayDW6JudoTa261go2ZMDt5ifrHqYcMeS8kGzI
 Vj9d/tZ4At8Ij/Q+aTTYVsDRdP2EbolUbHWhugbf5AZn+N9EJdwTUj0EhJPX5xCdW/zB
 WIUHywM6IyAJLzqekpooZ6MKtix0Sv+ZVXvtm0L5A1EvaGJeIX94bIqdoVcjIdD9iWI0
 fKKqYuFpTOfXojNygGYmKtz43KJ7ahAC0dVLvncahl1hV1v1iT6UlogPGBi8vJAzzwZY
 o6Sud5304cW5uFPbMVTSN8MBVJNBdEfR3/jSSieu85YeeRxR0tduWHcLFDAllC6ZwWUm
 ftpg==
X-Gm-Message-State: APuU4Z/3W+huaBo31IRoKU0YMLOKb1NPlnnCqTgU2DXD2ptj/IzsjjW6
 lY3knG/5q0Dqq8vqY2gvKPtWSmZPgAFg4+b7iJFD8CMpehZtj1IuGOI=
X-Gm-Gg: AYBFou2DUXbc3gPhuKGdiGN8aNx5ONRGnxG/y8DFb6IiXXB2GSTAzN5JeRZcugwlufw
 tp9gTkfFfzbLWrXWNSEAdK5o558rShJ47bR3V6+3xhfIrE7UpcBXfJLo0FVZwV0Xzh+WRhxfHyW
 GgA/hyxNhgAogfGB8KDgyUZ8ZK/7z4vEANZxC8fK91+0fR65eXVYsLT3MricaysWIUV3doyPgc3
 W7D15ikMscQmHfDxFF0lhhSH/1wP//Fp+JmtD9GIesXzY4vRsZp58vZQ6XgcNEfoOQslv44rVwC
 g92G3cmyvfQZ0DwB48nJL3mth3DNFer9RGvZudCyW3SAmo3FuH5Ej5rfX3zA1XtbeEK8oUwuC4b
 Fl7Ak9E7YBIUy4aTZY6VtrI+f5/Y1nS64CtreNdPMuOzXIvdYlCVCqFw7TSSvxAVH03KQbYm5F7
 ZcnyPudvw2/g0lblwxYhonwkpOG5BFDKRaEwJlAFW5+uPq4iJpatrT/cqHYsnPI3TSBBR1SI0nv
 ouiatGob6JqQ2JiAzGeH1KvFVwqY6gEcOZshH/W+tYKZf6adhkH3cQmIj1G00RCQKwCbV3ldOCi
 /DVRRnAMtDp8lRtpy25tTvdK5YAtz++EuvyZ+iFmY9E1tJ38mVD/8PnJ+lI7pB2lnTmX/xw8J52
 k3ww8y1vqlzAZyQ1OL/YV/jm5A2orTLQazv3YnESGkteeBV/W0Z+M0a87JWx+3q6k5A8gCGEV8n
 UojDoJkzxsMw==
X-Received: by 2002:a05:620a:4015:b0:943:fe60:3748 with SMTP id
 af79cd13be357-9479f4ada94mr265600785a.25.1794285005889; 
 Mon, 09 Nov 2026 20:30:05 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e734698sm136705185a.13.2026.11.09.20.30.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Nov 2026 20:30:05 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/lima: disable the recover work before tearing down the
 scheduler
Date: Mon,  9 Nov 2026 23:30:03 -0500
Message-ID: <20261110043003.56648-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GP and GP MMU interrupt handlers queue pipe->recover_work to grow a
faulting task's heap and resume it. lima_device_fini() tears down the
pipes before freeing these interrupts, without cancelling the work.
It can therefore run during or after drm_sched_fini(), access hardware
after clocks are disabled, or use the freed lima_device.

Disable the work before drm_sched_fini(). Use disable_work_sync()
because interrupts can still queue it until lima_fini_ip() frees them.
Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 9a1e6b9ecbe5..7a9ccca1291a 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -539,6 +539,7 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
 
 void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
 {
+	disable_work_sync(&pipe->recover_work);
 	drm_sched_fini(&pipe->base);
 }
 

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
-- 
2.43.0

