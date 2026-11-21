Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CD606A6A1
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Mcg3/rS2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E9910E992;
	Sat, 21 Nov 2026 13:12:32 +0000 (UTC)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307A010E9A5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:26 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266744; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:Hy8EhkOL9gEXAkyJxmgRk1dH+KsY
 JatjmyxS4FLXQvuGaaSaqU5ErYM/20yzjyXMSt8UjlsGEWXKXbevJTKgLYePryZv0MQlNPeBsGu
 lnucw3j4Ls1UVPaj9+PQvXLgk//PhxknjmxCnHbv2Kfp3WkhyJ5xx+QRwjdYDE/zb4/DUr7TekS
 LvziYgj4j7pmYYvZp4qazkI7z9aAnL8Ajsc42lZDOEPqw0RjVrM8ulWufFxuVy3LpZooHViQ3BO
 AvIAh8ninWwG5VbUpw3T2ydMUOg9t6J6/DC6iSQEeTpbg0r8D/dGx0f7F7QZawzP8EZzMSUWFD7
 vCVwA8RRD4Xp1w==;
Message-Instance: m=1; h=sha256: MstuCGLLPgdGruADsg6sggiFp4jrtf6fzD3WbUjBKaw=:
 PKJTlDVAjSSCiZ4sse/d9hXP8acgrgKHHDNHT4z8ufs=, sha512:
 z+ijhi1LsMLhsjjsVPkttrVd0jVFhuvSkovmcndAKRm2pIAbpxNzzWRdmUZZ3SKYr0AfqTf6mGdwe8FA/Ovnow==:
 kxEhs3sBeGin3ImfvbGwY3cAWoXY9Mv5uGE8zqt1f4IISor7I7lq4g00Q7V44AXY32hA+/pNe6A2WbqWAlrW8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266736; x=1795871536; i=jan.claussen10@web.de;
 bh=BF/1P4AvrIIFA9XMFtkI38tLivXVyi3Hsju2semGjjo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Mcg3/rS26fdlbmlvbtNr1TkYCOUeCHdvRRea+YZdwgbaFlb+S74Rp4HAhfIrCXqH
 eDVRewRct0X82sGVCTBucdymbeT7eLyhnJ76PeOO1+ET5EHugaZCe3KSFF04soLEp
 g1yHcRVCtU1OC6hBtYfsynKapNKPw4/vbVp2PS2hXmEKB67FdBU7IFyzA1RUuwVO0
 EaOl85SvP/Uy/ELEJo+dEUAkKVE16VJXamVrQ/pK7jFhXQ1l2nOjbVk+1vggn3tjm
 v/VYIFZX/XT85F+YY/+/V+Sm+UOkGwdnUaEoNotjBt9yEAfAdLG5i1Aii6Q52Sw1h
 SpgVYeiUx3nYQGP3hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwsB-1yHrTe3h0X-00oKuQ; Sat, 21
 Nov 2026 14:12:15 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] drm/connector: hdmi: Create the colorspace property
Date: Sat, 21 Nov 2026 14:10:57 +0100
Message-ID: <20261121131126.3358-4-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uKjTIq+fEr93LWnrLQPvuBplGnIz82Cqc9G+dTfhXFSLx1Dr2CK
 9xAsn9A+N2tS53sWPTgLce6qv0PWgPJro+ZdKCzX/bY+2k/N7DnS+A007C8w2bqMkNE41JI
 dBUaT9mVsyXjDMYHdoZDPGOAJ+aUE2TzGSXe0DOcG2iucisWnXbIvcmjWaLcOAR8tdUup5N
 gWlulG0f6LQbxZADTAa3g==
UI-OutboundReport: notjunk:1;M01:P0:FXKtCPyEP70=;K7Pwm+t9WdK7AmkCCVlnbKDT1l5
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

