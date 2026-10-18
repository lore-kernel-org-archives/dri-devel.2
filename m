Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C23CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E8610E5EF;
	Sun, 18 Oct 2026 12:36:43 +0000 (UTC)
X-Greylist: delayed 327 seconds by postgrey-1.36 at gabe;
 Sun, 18 Oct 2026 12:36:37 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F36010E5EF
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792326995; x=1792931795; i=jan.claussen10@web.de;
 bh=+YwrntOyRknbggwrQKU1gw4YodNY/Moq08w7g8XJTR0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=A41vWBsLHFwwMMGEFhwALKGD54Dp3oEAierfiLJU+t+BuuSxV+vH5PLws+PttvvV
 3raAVeEIq6Xd7Bdlnjrdfo6oIInjOrVIFFswstOxVrTESBbQCfQSWcpE6qKzESu9X
 cKpF2aTKjk6lX7Mpr3kL4C/V2cBDn57hMt7GDcUnDNWw0h+PNHbIr0N+Swhg65aop
 iwjhksFIQv4BkkGqxOUWXFjxJCYQsg2uI+zebxxDd0eUUCA8nQCTWbUf6sLG9DOAF
 J8KlEgaO6xxCvHIj3loFhtZ3djJ73Hbf0kYTXG9tnh5in6OVY66dRnnck5PV4Pi7/
 WWBMGlavujUMTPMGOQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Gki-1was700pfe-010PPu; Sun, 18
 Oct 2026 14:31:04 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] drm/connector: Fix typo in colorspace error messages
Date: Sun, 18 Oct 2026 14:30:11 +0200
Message-ID: <20261018123037.19560-2-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ed78oEEJd3UFj/RlSQj8Op6VAN5EEHdsU3JxKPcvqcZYx5RKsfQ
 iWZxmAv37UtKFiJSYyaVBdJ+COw9rBvgr0L8QI1b3GqYXjMHgdgKGmiKhFIP5oVBvRg0FtL
 quGeZsYsBYYcf/oXV2kb2wij7siOHOQ7FI3aw5Z9sHXa4wIvUBaggyQ0trdxBfi3VeM8E9I
 zSL1A/NE96jcvRMMGnmpQ==
UI-OutboundReport: notjunk:1;M01:P0:/Ph3M3tSkZw=;MbxXPTNKX+4aM7iDhcatKc+9PJ7
 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
 =
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

