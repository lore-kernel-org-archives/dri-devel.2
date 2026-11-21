Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD5606A331
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=RJRnTsem
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CEAB10E3E1;
	Sat, 21 Nov 2026 16:07:59 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A39D10E3E1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:07:53 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277271; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:c/iTvcye4S9vAEPynjg7iXj58ycc
 eKaxlFfpw5D/4jBnupvuRvDx1BUsda2sfcP/ekbtq6RgYwEzCeswZO2XjFcA+b2w/ohfP3beLG1
 jL7DoTU8IFNriEH4JuzeFEJjnhkmnO8z/D7v7u1uKm9tDnNqkIzYbVMFu+iqihdJ7xz4gsHsu/3
 f567s92Zz+7vZLWzZHkWXsTsaKyfrEK4ic5YjTlavmlPy+kb85+tbaYkT7MwY/S7mbBBJ7c3tlB
 52NqiLFLsU9sLl29ka7nbmdiPbONoNtXAlYMqNCpRnz7LWOSHgiQxWxJq3sBh0Tms6flMkkaVLP
 AvMRX6aKu6o2BQ==;
Message-Instance: m=1; h=sha256: JchyeI+6U4uhSB8jTCunh7NioKX/qNOdEGOV6Jm2dgE=:
 HiTtcdQ3+Ds0m4DX1z6pWYfQBN5jbny1N8mHXunV++8=, sha512:
 9xzimRSJGqT48+6SYhWoi1QX8SGVvBbAxDHTRJhosg4+xK5HA/GY87vmMcwfN2mwog71qLCIaiD3yyGqCqBNsw==:
 ck7djbDvzNd24QZtwIjwXq/m35ph6EEX0/yW8aaitb2iQ8mzxv+SBLkuibsRUoXLkMSYG72SpaJg81h13BmPCA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277262; x=1795882062; i=jan.claussen10@web.de;
 bh=+YwrntOyRknbggwrQKU1gw4YodNY/Moq08w7g8XJTR0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RJRnTsemuNGzx7CTIXWT6ucmGQhf33cAjmCpCQ6iOyJAQ3/+A6xmFabWg705+RAm
 W5E+ZIEd7KPqu0S60DmasUZOkrEctb/6uaR+bWWYIJ1dWsGd9WhPKM30st9nUqr5x
 6mfd6Do8RiAje8o37R+r+ZB6qQwKbiq8Pt83dh6ak27C8U8ofxojJiLN3ZpsJOlAw
 oRtN3fdcTU1qtWwVnFhK9AIPo1IsrrXwxvMbQTZhzM/YuhUHBWFjd1bPx8bBcVpOD
 UYzxYK02QniLPKNvC5PO3AeoNSCwbGZfzqGABHvbov6QkkJAaLbkksn32jtFy/foD
 nbcynWmje1s+dxVEiw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRYf-1xmban2A4p-00YM4E; Sat, 21
 Nov 2026 17:07:42 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] drm/connector: Fix typo in colorspace error messages
Date: Sat, 21 Nov 2026 17:06:53 +0100
Message-ID: <20261121160725.6344-2-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdtW/FheIkht93+7ryHQb7gqQ+tSI7jH9Mi6y6EkBcpTvFqIkUi
 2MXJzxt0uZQ1VfJLM4wnYoVx7qmiYtyivwkOWLlqUxESq9ac1OkskasBL0u83PLbUMnEotk
 ld1a786Mkc+MSLEmx7p0FjLch5R/wT8t5aDGwSFCh+GOBki/7BP+UanprIhFcJMt6ImAhWU
 sZ6c68I5CAP6Fj0KpKkZw==
UI-OutboundReport: notjunk:1;M01:P0:VY7gREGOLTo=;EBISMnvIhkMLJ3TZSEC8tg8OSTZ
 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
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

Change provded to provided.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/drm_connector.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connect=
or.c
index 893716a9e489..66f53e155342 100644
=2D-- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2768,14 +2768,14 @@ static int drm_mode_create_colorspace_property(str=
uct drm_connector *connector,
 		return 0;
=20
 	if (!supported_colorspaces) {
-		drm_err(dev, "No supported colorspaces provded on [CONNECTOR:%d:%s]\n",
-			    connector->base.id, connector->name);
+		drm_err(dev, "No supported colorspaces provided on [CONNECTOR:%d:%s]\n"=
,
+			connector->base.id, connector->name);
 		return -EINVAL;
 	}
=20
 	if ((supported_colorspaces & -BIT(DRM_MODE_COLORIMETRY_COUNT)) !=3D 0) {
-		drm_err(dev, "Unknown colorspace provded on [CONNECTOR:%d:%s]\n",
-			    connector->base.id, connector->name);
+		drm_err(dev, "Unknown colorspace provided on [CONNECTOR:%d:%s]\n",
+			connector->base.id, connector->name);
 		return -EINVAL;
 	}
=20
=2D-=20
2.56.0

