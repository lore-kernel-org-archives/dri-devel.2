Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A97CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BF410E97E;
	Tue,  5 May 2026 07:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=maestretorreblanca.com header.i=@maestretorreblanca.com header.b="eSmvPsaw";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258EC10E2D6
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 00:57:40 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-956849ae1efso887451241.2
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maestretorreblanca.com; s=google; t=1777769859; x=1778374659;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hl0NK+MUV3aWIGSEg80ZpP+e1ygTELg5+PZ5Oxbl4PE=;
 b=eSmvPsawfT9yA12XBCYBH5nC/USeNiKLAgz5p9hix1vP1SCqULCP6BuEmIgtsAm+Ai
 wIxDcsixQiprYeioX9vqqdxJ+D8DnzwS744Fw+CSOvoYqIkxrjQcRAbrCqey0EvgXye/
 0N0sxWyhGQZHALfrUNbe9BhvJrip1yQTCJbKMfoLXmEQqX0ztNN+iWWqRRaz1tejfE1x
 VTSVrWdR7DgKU1qTg01MI+XV1t1u6McAaO4KIFRf0ULAltqKqAl/vQvDLsfWNJtyZAlS
 Ql9fxqdV0FZKvesJJN++x0cFpSZozFKf1s9Vb8CSJ3C0HLnYU5pzBKvKbM9orze/2GKf
 uScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777769859; x=1778374659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hl0NK+MUV3aWIGSEg80ZpP+e1ygTELg5+PZ5Oxbl4PE=;
 b=qQ/UoPm7ztMEWL5/a8P7OH831erMCDks6jLLFjSDOljdDoKn4xy2A70KdWDYrbG1Hr
 1PV2sWZ2ymtINADwdbBnfVZZJYSo5UQ/HaM7aqYWn7dONZvuqtggSOIOlwfTGpQaIMlT
 OuWVIFLO/vQHJ77rH5QRjes++gLcVVN/P1nr/37TSRfvaAWFZLxbZIg/c4+fjF7F2lp8
 b4fVM+l2K3kwSRCBWEVYHkffQEPC5Q/X1MxJqSS4Dq2ir55P8RrAh99qMPbIdMROd2+8
 fkuo+JrGOsW9tII0SsXs38IO5ab5WgRhcGKIozVoA3qNVzTwyfuA/ZxhxdeUITawCQXQ
 162A==
X-Gm-Message-State: AOJu0Yx1N/cqgZysrNoI9xHgC15WqEQmal2Ck7sreVgTobLZbdXxYQnu
 8PvR56ahhFtdccEHanG4prVoJOmqJnS8hIRXH0YFD5uhVPz0HiDfeeLeqlLdUXPIJ+s=
X-Gm-Gg: AeBDievrRrG7BZXOHGSzY14Q27PgixcauE5xQ2UuFWhq6OQAyljAaMz2I7iSNPaHtfN
 M1HProFgKkPQjShIjKy419QRBuUI1oulO28vCmmt3FSqiGpHNk2nKwbC06kV/1HdwEj+uHR/ihI
 +BglLJcWwvJCz5Bh26BAiTuIp/V9oVdLHLCp0ZYoBg9lZ7vAgU6HSvmmnqFe6J+bocRzPQ/YUUJ
 +SIVbMsTN2K0tx7HJyo18kyht/WhkmbVJLto/84omFKPVyTZrVegHuNnyL8JGlh2w+91CWowT5J
 eQPlo6837kutmRajQ5zxAf3KKBpJ9yEroPE+oxdRWYaACDBRL9uSI4mGc/7a1LXNAMHeg/zV+aq
 TKj7RjAYyHEDJRDLjenHffEmu3tBuAPW5D56nRnE+BqeKkfNVYLRhtOpnHOsqMAo4LISa6QtANw
 ZpTflc9/nocyE39GtqbYHQ0II+8CVCPLG3PIWcMKuieYij0QdLSKXdzonGFRsGhlvzEddRjATmK
 o/qqnJqXYbjSFwovPA5GA/LA3QdYuYCubiCYg==
X-Received: by 2002:a05:6122:829f:b0:56a:fc35:9664 with SMTP id
 71dfb90a1353d-5750c4acd6cmr1861099e0c.3.1777769858811; 
 Sat, 02 May 2026 17:57:38 -0700 (PDT)
Received: from localhost.localdomain ([95.214.114.12])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-574a6c6c582sm4009834e0c.9.2026.05.02.17.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 17:57:38 -0700 (PDT)
From: Francisco Maestre <francisco@maestretorreblanca.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Francisco Maestre <francisco@maestretorreblanca.com>
Subject: [PATCH v2] Documentation: gpu: todo: fix typo 'themsevles' ->
 'themselves'
Date: Sat,  2 May 2026 19:57:33 -0500
Message-ID: <20260503005733.68932-1-francisco@maestretorreblanca.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

Fix a spelling mistake in the panel-simple/panel-edp TODO section.

Signed-off-by: Francisco Maestre <francisco@maestretorreblanca.com>
---
v2: Resend as individual patch, not part of an unrelated series.
 Documentation/gpu/todo.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 520da44a04a6..e371134782f8 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -456,7 +456,7 @@ be turned into a WARN_ON() or somehow made louder.
 At the moment, we expect that we may still encounter the warnings in the
 drm_panel core when using panel-simple and panel-edp. Since those panel
 drivers are used with a lot of different DRM modeset drivers they still
-make an extra effort to disable/unprepare the panel themsevles at shutdown
+make an extra effort to disable/unprepare the panel themselves at shutdown
 time. Specifically we could still encounter those warnings if the panel
 driver gets shutdown() _before_ the DRM modeset driver and the DRM modeset
 driver properly calls drm_atomic_helper_shutdown() in its own shutdown()
-- 
2.50.1 (Apple Git-155)

