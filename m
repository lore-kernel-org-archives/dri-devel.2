Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C45606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=rj71v5f1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6107210E874;
	Tue, 24 Nov 2026 13:52:20 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CA910E897
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:52:14 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b88b74e54eso5526085a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1795528332; x=1796133132; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t/4Oc8JJbURcLCaiMNMXPdQSaH+WSc+TJcsQQPs12Oo=;
 b=rj71v5f1ZXfcuLQ2pDF4MA+oYpywiFf9im7xb7pjwGIgw0uXGwq0p2jN1brPrULWLS
 t3gFqGawstR32ODlJR4UzltcThKR0V8N2mTzRWhZfwGdYUvQiPui2ymusoJB4s7xVl/n
 HG5MxAoAQByE4bGJSXPNTWchC3EmLMXY+eZI8qXm9NPwZGPj2vPIo1Uk0KBBNu92EqJH
 EYiEvAxCWtqNoCUp2FGSqRr4IkkPMSJUckQaBSUyZ5uCxX2IQYsSgV+xQJPv4+7gGgNu
 PqXc57cAHM1NjSnQyH8VnkUyelSt5sZX59paISJU3+tpOgqGOMWnl9yIYCfs2gGKsTl1
 8+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528332; x=1796133132;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t/4Oc8JJbURcLCaiMNMXPdQSaH+WSc+TJcsQQPs12Oo=;
 b=o9iRab/21j8XkwqVWrsh5zuC6EJybnBLNCPT00hczkCqM1Crwmz5EfgAqQOvzohJ6x
 g601zmx5sU3HSeFIDNR7ZWZ33g4cU3ctac54fuX8Bsw5Pc7j22+Qh5GxulHrfSZcWmCH
 4+EuCKjIJAy22VbPFTQOVsXM6h+g5+rg2MFu+NfMw+ekzxXvH4z/rID36vIe6hYj7Ry7
 3xemSLrKp9Mj8ZLECxeUjChipGydBYFe4qgz27s+T5OR83AfosBcwei2a8VDTob8mwmk
 BEJQ8yCE0Mkxro4YWZHL1ZSAVq8WfwgTJjk5oWJpdDgOsF3z1FvBlOzgUTBGgSZF5Jb1
 GQjQ==
X-Gm-Message-State: APuU4Z+kUCuVB429B4uIibapU/c3JFgOZYnfd8lET88bko6QYh9uWVWA
 ZtR44RlQT+mREzpW0D88YXqZTmtjhsfri8yLVUfin/Fu7iizAlHQ+inXoG0f2vCzI6Q=
X-Gm-Gg: AZFdTZcEdn30PXc56GWOMFfKUqqGJAtTTAF7ur4gFCEdeHDZMvv99ebCx/20ZtxXMe6
 c0VmFER33utLaKox9vBTaIbHGZeqLsrnKOcKZqQeX7f4AHU/esEU7M4J0ZAnuWOPweqhtQufT7q
 +2Yfb6ocJblI7ptkvFS+1WcENLzV9Z1LCXO1JXDoYnAEcFUYVWLzWWKCeQFUvNlLUraeASuBhmR
 Iy6ha2AR+ypwlZWUywg1+qyuhAT8HK5SIkBFZfaPnPCFEq7Zd6wpEBBxMZnkPh6FBrfxtdbc/qG
 wNclXZQe8knSX6hrZ4CwZvbFZdl4nO1kfO0xcp1r1ntNMBZptJzXLy+zmaxxBpYfeBMJb4kgbIX
 K+MyhqW9hspThtI9drGDJM9kleXX8X0KnqzJsR10GxcTWtOT0rrrBx0TL9UPmhIS6EvxWdn1f63
 eG9JE++R2NfxO/t98bcIDyzdYVDrXnKqBxa+56AYzGo/T3VFCxjWw9zR+WpPXsTEWOKro11F1yc
 DWcauqkO7Zv4NLhfxV84+vA1Kv3mkFxm3dScjat+EZBMSJsMG8tBZ/qtw4t//jeH2tZV51A8Jvr
 Qzn6VETSq7CmDblOX+68aG25u9g98i/8YtCbdm6f+p19PHiY4MCU7Z3MDakXX++5PUK9MpSeiuQ
 rVTDgN4I=
X-Received: by 2002:a05:6402:3646:b0:6b7:fe9a:23fd with SMTP id
 4fb4d7f45d1cf-6ba37c77c7dmr11354861a12.6.1795528332507; 
 Tue, 24 Nov 2026 05:52:12 -0800 (PST)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba854bed08sm4785252a12.30.2026.11.24.05.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:52:12 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 24 Nov 2026 14:52:07 +0100
Subject: [PATCH] drm/bridge: aux-bridge: Add parent to
 devm_drm_of_get_bridge() error print
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-aux-bridge-defer-v1-1-f1353d512665@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMBCE4VeRPRtIUpHiq5QedDOx60Flo0UQ3
 92ox49h/p0SVJCoKXZS/CXJNGa4siD+tWMPIyGbvPW1c74y7bqZTiXkJSBCjY1cvwOYrXtRvs2
 KKNud/Hwfp7UbwMvVoeM4AT+CbDp0AAAA
X-Change-ID: 20261124-aux-bridge-defer-0fc68decc013
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795528331; l=1428;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=26+RqYTwLPub4sHa03KBjV/Aw/yk4Ys0+q5quekWgnE=;
 b=bXgPuOw6PWXQfpW1+QRR16w9lxHGjODqUZpbd5qSAyhSJ25VZ0Nqsznwx4Hi739nLM7fTshDI
 D3BxuvuVpBpCgOCz/YDdovFk4Q2a0QPXBuGwVu7QUrD7aI1JTALBOsC
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add some extra information to the case when devm_drm_of_get_bridge()
fails, e.g. with -EPROBE_DEFER. This makes it more obvious what this
aux_bridge device is trying to do and what it may be going wrong or
missing - e.g. when Type-C modules are not loaded yet.

As an example, this will change the message to:

  aux_bridge.aux_bridge.0 aux_bridge.aux_bridge: failed to acquire drm_bridge for 88e8000.phy

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/bridge/aux-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index 90f76bb529cc..c0a13a77fa55 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -126,7 +126,8 @@ static int drm_aux_bridge_probe(struct auxiliary_device *auxdev,
 	data->next_bridge = devm_drm_of_get_bridge(&auxdev->dev, auxdev->dev.of_node, 0, 0);
 	if (IS_ERR(data->next_bridge))
 		return dev_err_probe(&auxdev->dev, PTR_ERR(data->next_bridge),
-				     "failed to acquire drm_bridge\n");
+				     "failed to acquire drm_bridge for %s\n",
+				     dev_name(auxdev->dev.parent));
 
 	data->bridge.of_node = data->dev->of_node;
 

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261124-aux-bridge-defer-0fc68decc013

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

