Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D185606A691
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ASqcE82w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885B510E413;
	Sat, 21 Nov 2026 16:08:34 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F34110E413
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:08:27 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277306; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:DqipahTEH0e/mI30AWjs1Khhh6M0
 KOmgtsq/pCSEyvitpXi10L1xj9ORE50kGGcGDLwVXS6fXmfJD5wzPkf4U9CUSHAt0p4iY2AUMPA
 M568Ch1MeZQkO4b1xUiz3QIcxJ9tJq6xB9nGRZzLW7plPVtWDGvn7oj0RsY7CwAG0V6BJFRmrJs
 ccJgJz6Ux6V9C8XRuuHmTy1akZ2eJVsXd7OG58f+QwUYnXAIE5q9OgWkZpGp3IXOEtHmLsJmbav
 mKn0CfRZMMUVUCY1p1X2lq4l6zZwtnc6d57nMZCRGTh+yHhz7yl9cg1zNbYljVPH0kLAat4UY4t
 BFNyCx8sNC28cw==;
Message-Instance: m=1; h=sha256: WcMJ5MwSAhMoCRa5SSaFvRkw4sJ9bgIOJbtxf08S54w=:
 PKJTlDVAjSSCiZ4sse/d9hXP8acgrgKHHDNHT4z8ufs=, sha512:
 6ed5b2fKQIUgilgoGbzeIylsWdw94evcoWuiiAodGmszUGO9Tta57KzsHTjXJDJ+wG3BI+LrC7ZfJzmp741Oog==:
 kxEhs3sBeGin3ImfvbGwY3cAWoXY9Mv5uGE8zqt1f4IISor7I7lq4g00Q7V44AXY32hA+/pNe6A2WbqWAlrW8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277294; x=1795882094; i=jan.claussen10@web.de;
 bh=BF/1P4AvrIIFA9XMFtkI38tLivXVyi3Hsju2semGjjo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ASqcE82wMJ8vBxDaAdddg5lxutRvhSijJzATLisKXzgWiEwVudBE4lgg9H6ufw69
 EepwXjhwbEgpp/gP6Xacds4Yoh1sM9HjRfkWBhwV4WHa5wBQKL4c0RP8ZD7/+0BNK
 NueEUUfiNtDtgEX+VknrBYH41CGBSdzDU3R6qepZtgo+5BkuhQ84aC7s00CmE/ORm
 IBX9FJMYvwjaFbXzppKY/twkCHdD8smnXbMce//BAHhcMHAA87fglJxkaDYnnHgLK
 AJjFKfhaeM//orP7Dou22xjwfzlMhGnwtk7sdC8nFdcFnwZwKDMUsCH908t4dhjbJ
 qer8KIkjssAPluIhVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mcpuw-1y4PZH3GHy-00aSb4; Sat, 21
 Nov 2026 17:08:13 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] drm/connector: hdmi: Create the colorspace property
Date: Sat, 21 Nov 2026 17:06:55 +0100
Message-ID: <20261121160725.6344-4-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+nm0LK7kCAkHVO56fj0ddSmi+HIPuoYMISCC/M08HaV/59uhKWE
 dgNllmTjeOSFAtGdTsImON3dhK+bdJ5T16+7bDF2YZnPkvPORpnZFkGVQ8fZoX4n4T90zSY
 NgqCkJfJt20aYewyEVPYXslqFoldjGh9mw21ME3UQBICd4xuklAXC59M54cRr740BDreIbU
 mu0IpOzGVKE6JmBRU5xuw==
UI-OutboundReport: notjunk:1;M01:P0:mNlEyL10uRU=;q7/D7T+j7oz1xpY626w5i0dYoFr
 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
 ZKamcHgOZbmSB0vOSTZ1Ns4LbI/xzYEdP0
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

HDMI connectors initialised through drmm_connector_hdmi_init() do not
expose the colorspace property, so userspace cannot signal colorimetry
such as BT.2020 for HDR output. KWin, for instance, does not offer HDR
without it.

Add a supported_colorspaces bitmask to struct drm_connector_hdmi_funcs.
If a driver sets it, create and attach the colorspace property with
the colorspaces it lists, next to the other HDMI properties.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/drm_connector.c | 9 +++++++++
 include/drm/drm_connector.h     | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connect=
or.c
index 66f53e155342..eea27bb6557c 100644
=2D-- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -672,6 +672,15 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
 	connector->max_bpc =3D hdmi_funcs->max_bpc;
=20
+	if (hdmi_funcs->supported_colorspaces) {
+		ret =3D drm_mode_create_hdmi_colorspace_property(connector,
+							       hdmi_funcs->supported_colorspaces);
+		if (ret)
+			return ret;
+
+		drm_connector_attach_colorspace_property(connector);
+	}
+
 	if (hdmi_funcs->max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
=20
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..9d2d133463ba 100644
=2D-- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1521,6 +1521,13 @@ struct drm_connector_hdmi_funcs {
 	 */
 	unsigned long supported_formats;
=20
+	/**
+	 * @supported_colorspaces:
+	 *
+	 * Bitmask of &enum drm_colorspace listing supported color spaces.
+	 */
+	unsigned long supported_colorspaces;
+
 	/**
 	 * @max_bpc: Maximum bits per char the HDMI connector supports.
 	 */
=2D-=20
2.56.0

