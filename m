Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C8CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D00E10E615;
	Sun, 18 Oct 2026 14:32:14 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF8810E615
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333918; x=1792938718; i=jan.claussen10@web.de;
 bh=+YwrntOyRknbggwrQKU1gw4YodNY/Moq08w7g8XJTR0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wG+7PyWpup7hsPpifcmYVWqz/xo8f2c4SH8WRbQBaLT2hfd6/HweGHOz+sgEOAf6
 bpvBrel6tt5d/CdwRzYNm5/Hf2hp6wqB7GvFcujb+F/ZW8bCHNfM/7QNeVavcTfV/
 fue4TM2vV6IrYvievpeW5wZW2RRswPRPgguAo2WHYbPjsjGc+f7dKfomK+2xsciSq
 zCuWPcNQaxJ00oDKbG2sYUGN8GC8snSUPcKbeNmvbNRBWctX1mqOSEgoc1Qqb1Or/
 w50iEt1zsKTrgOASOEZ+rq+8mDWsXY5qTOm85QU6jXFgLdvwHlWHjUe3DFZNtxAm6
 wvJBJDg9NCleixUlJw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1xLlqk1AKy-00EL6A; Sun, 18
 Oct 2026 16:31:58 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] drm/connector: Fix typo in colorspace error messages
Date: Sun, 18 Oct 2026 16:31:07 +0200
Message-ID: <20261018143135.5745-2-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tPi+IaPaL73wKlshkUqjvqof9I/VHEUHTuiXSzDIjLiy3ctQTuH
 +HZuWOR9J2RZyJCEnnCJ25k5HJAFQWnj0/fLIfPXh9WBxD3+NyDmRdDodSTzFEZ1xn2QTI7
 Y09HOfCPvGGvUyK6UjNXlmB7qulzCi0B1+QaZNPJd7a5Q3tvvb9sW3aZV+Ewg7weT2bfJcP
 a/0Z7/gfbAj4fuE6WA37A==
UI-OutboundReport: notjunk:1;M01:P0:Kd4jchQlTNM=;6prRlzE+MstJVgT7AuQiyE/yfYF
 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
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

