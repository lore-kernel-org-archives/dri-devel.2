Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E6606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nt3PK++7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5799310EBA7;
	Wed, 18 Nov 2026 08:23:18 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B9010F9D9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:41:45 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1158509eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794958905; x=1795563705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m1Cjer+iNpU1iImlMMK+vYAvWTpXzGaSEtw1yB5pZVQ=;
 b=Nt3PK++7Cd/pKxzip3h5Dn8PDa+WS7L+wkqhPEKQGu79IKMXkMpAR7gAgqQkNLk1Iz
 cw1O8ppR7EhaJ88fNBOoEp2viwuWMsPRB3T1OIWTx9YHK/6y55UO1RhJdTM18ZC0hGJl
 /+elc881+IWhAtPorutd6RUDJ1jx8t8T88WCPLOArXhGbKfNDW5B6qxzGUKD856IGN6U
 /9c8syUu5pcdPjm9bG5V19s5vjzW7ItqEL0dFvfnfi3cd81Zs7eASmJg6XDzq38V8X8P
 HurwGO9Bq4i5EKHsI3q8T6w5F18ikhPfb6DKuOhGFbL0vqA5Kv4WFZKO44psZ0BGELBY
 H09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794958905; x=1795563705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m1Cjer+iNpU1iImlMMK+vYAvWTpXzGaSEtw1yB5pZVQ=;
 b=g8BSqA/Gi9JxEKTayGSHb2YVfgDxxxLXL3nHzVRkkvEQSYHPbssKhHChtBm7AtD47D
 2bxfFbCGhAndMKkPR2GJKrmUwRNxpPxT3JC5sqhijGIv1dkD+h/nlb96CbbpxCd7KIBg
 oLMi92WMw7RZoYaT6RqPwfVuRQZw6wDeA4YCxsrM8Amwsp1oc7JSGrTXAV/F9uJ5xMvY
 FaElpVekXB1KBGJZnBS5oP4jNl+fQhmxI+mD0WjxlcdfkO53zuJSuvscpifhYlfs+eA+
 La9mgxFOKJyaPxhKr5Hi+hbpJV+zigBE7gv9f2F7640uoWCiqtVCEFf3F39WhD3UmqW6
 M/sQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEW5yRTfc5YyeVuwOm/Z1ETpr/Alfe1sN+9sUvxhAxaMqx6XdUqEOE+74xcLYPpmpgpLITlWIDDBRU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/IuRVeECklymCfoIkgAXindzqXNXjI50iZ01DF2iZ57tW7IPNW
 0Wd/fXsS+aDWhgxsAJdKdi6MKC1jM/jaImZ6rMbBC7WOcPF86G5tukrPYhWcjU3W
X-Gm-Gg: AYBFou13odJpcZRLiy3TGXrg5/59ShRNiugY9b4H/mxI7tzKAh9qTQZmUGitOhYLGxK
 +ZzHn6TbgZdWoIqCRsfvBuqrM/9XUI7AVWqrcnfdGLJIyObYyXwc9gBtY4alhAyH03WZx+v5LyN
 JOkghC5jGOTZ2bzY3gk+MriA7UIe9A7mI7a+iH8AdKe71sJplTdraO+9JiuRzEsA30dHtmbCyWe
 4OXTl3gmKKie9CKgE+Ho3/LGnoIIIeel7oirbnRWSYLKjFI6RKQymOj9bdH5Pbei1mSUO2BXgj3
 qY4jiQZRbeyHqsnvjX5yjVciRRUCAaevLvblNL4qkA1dCzdrc/X+phfQS0qtCbuAC5GqzY2SzJr
 nc1QXJevC166wX+hgVN1J4i5oRZZ2HVnHZ9ZdfLB7tT7HroPRIuIusMzNjjxmfxMQbokQbXN01v
 i3rXoGMSfG5g0OFMS+Kpdoz8kxu9/7FfsVzQKmCMr1OIZnNFGKBiTt0RNHrI/2Uv13YJB1GvE0g
 YRhir/4Pz2ev4s43AJS+yjrJ0MRBEeJbihIh4a5rTbQbcqi/xk3y0R0SQ5BR8h+w+wg1RlkrvXn
 1qitRfrtGymf9vb6XnLa4FpdXSd20fOTY477Dk3Tz0RgNdPH7NI2ond4lM7VoaBukUSemYY=
X-Received: by 2002:a05:7022:7e83:b0:1b5:23c0:4f15 with SMTP id
 a92af1059eb24-1b543c3fd9amr1080809c88.39.1794958904954; 
 Tue, 17 Nov 2026 15:41:44 -0800 (PST)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5447dc5e9sm2095199c88.11.2026.11.17.15.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:41:44 -0800 (PST)
From: Henry Zhang <henryzhang62@gmail.com>
To: mripard@kernel.org,
	dave.stevenson@raspberrypi.com,
	mcanal@igalia.com
Cc: kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 henryzhang62@gmail.com
Subject: [PATCH] drm/vc4: dsi: Register the PHY clock provider with devm
Date: Tue, 17 Nov 2026 15:41:07 -0800
Message-ID: <20261117234107.1298575-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

vc4_dsi_init_phy_clocks() is called from the component bind. It
allocates the clock data with devm_kzalloc() and registers the clocks
with devm_clk_hw_register(), so both are released with the devres group
that the component framework opens for the bind, when the bind fails
later or the component is unbound. The OF clock provider that points at
that data is added with of_clk_add_hw_provider() and never removed:
after an unbind it stays registered with the freed data, and each new
bind adds another provider for the same node. A later lookup of one of
these clocks, such as <&dsi1 0>, would call of_clk_hw_onecell_get() on
freed memory.

Use devm_of_clk_add_hw_provider(), so that the provider is removed with
the same devres group, before the clocks and their data.

The analysis, this change and this description were prepared with the
help of an AI coding assistant (Claude Code).

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
Found by the Sashiko review of
<20261117205902.1293962-1-henryzhang62@gmail.com>; independent of that
patch.

Testing:

- On this base (drm-misc-next 467ac0b56aeb): arm64, DRM_VC4=m, W=1, no
  new warnings.

- On a Raspberry Pi 4 with a downstream 6.18.34 kernel and an
  out-of-tree modular DSI panel driver, with kprobes on the provider
  functions, reloading the panel driver (which unbinds and binds vc4):
  - without the change, each bind adds a provider for the DSI node and
    nothing removes it;
  - with the change, each unbind removes it (from devres_release_group()
    in component_unbind()), each bind adds one, and the DSI PHY clocks
    are back after each bind;
  - a bind that fails after the provider is added (with the old DRM
    device held open, on a kernel that also has a backport of "drm/vc4:
    dsi: Allocate the encoder per DRM device", where the bind fails in
    drm_bridge_attach()) removes it again (devres_release_group() in
    component_bind_all()), and binding again after the old DRM device is
    closed works.
  No warnings. In these tests no clock lookup went to the DSI node, so a
  lookup on a stale provider was not reproduced.

 drivers/gpu/drm/vc4/vc4_dsi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index ec008f766..ed99cec9f 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1592,9 +1592,8 @@ vc4_dsi_init_phy_clocks(struct vc4_dsi *dsi)
 		dsi->clk_onecell->hws[i] = &fix->hw;
 	}
 
-	return of_clk_add_hw_provider(dev->of_node,
-				      of_clk_hw_onecell_get,
-				      dsi->clk_onecell);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   dsi->clk_onecell);
 }
 
 static void vc4_dsi_dma_mem_release(void *ptr)

base-commit: 467ac0b56aebc804360f276feffbc9032c265a6e
-- 
2.47.3

