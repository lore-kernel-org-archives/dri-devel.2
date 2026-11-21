Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A37606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=EiWhD5lC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AFD10E9B3;
	Sat, 21 Nov 2026 13:13:52 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8261910E9B3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:13:45 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266824; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:sWhgwFj9rm0lbeHWiRFiSKovSKDm
 +N/iQzvNmFU4+4Qd3UyOMCv31Vla10XYSXkWVciuzqXtjwC/SIlVVpKhVZSIbuHInu3VeJfjl5Z
 vZAo9qAAe7OIhYCgW48FG0XfR+QwZ4lzuN3A9vUl4G3W8OxyjkkMSTUStveoF0F+GzpIHwQbc1A
 q9Bfu50nAaePnE1v8I+xn3thligv2DggZCvQKDXupYXX/QcU94Bods7AkWK5mLeQy64yd4YXP9j
 KadeitLpjVrPBWpwLtDJdtH06teuPoSec1Y3meuiiR56e0znPmN/msSAVDyEtfOuzlP22iTuhnO
 Jt3M0s6gqidD+g==;
Message-Instance: m=1; h=sha256: lD5fZ50bfQkgziubU2YgeX+ksYR9PvWp7dRk+5rotqc=:
 eQTQOpDy20avckqeSwISdmX48gNkRyRt1JlXQY4G2XQ=, sha512:
 LKMmDYYAQJIKEE760apghuYny63lo7fHsGwvnHgnlz9z0de+EZk2Wf1gxXVAeaiueS72xmTLKcL/CI9xQyfoBQ==:
 FBAJ5o00moWgt9VuzBUZBTf1HhHMGElbphV1F/+kpl8ZVRU8FWfKI7muS0EZBcrqj8cLgWgo5YLIwNIDEbYUIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266787; x=1795871587; i=jan.claussen10@web.de;
 bh=Zsmosk/7xptQZiuCZvG/XXkwmDg6kwdhqizkWSN9V10=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EiWhD5lC3dF9EQhM1S6E9gKPzxqZAk18nhaovYfJp2hqjOIXm6mSE6FppurRk98t
 +VLoWMLrEB0vaq6sKBidmyyo5m3Q57cC6mWI8ASiB6Lqj6rQIMb6+3fXHER4RRL4D
 UFQYFLoXM3CmgsCyQSQAWEnNNMaTIDIN0hk3bMvjIKseyBCBlm1xaju6YHqEK3l4C
 e1vDwp3EzkNT0wublcVNGnTsHwHC4s0ltqfi7Q4ibhE8EcyiSADzK78MR8nu+I8DS
 sXY63GMRFnwCXMVKmqgR4tcYSRdYcSrFxXBRlQSgFT03aMLBuYSTNwaFy9e0f02Fv
 IamcMBnsM08wdGeo7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjIR-1y11Of49Qd-00KXS5; Sat, 21
 Nov 2026 14:13:07 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
Date: Sat, 21 Nov 2026 14:11:01 +0100
Message-ID: <20261121131126.3358-8-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WTiaW8IHxHx54FbwJbEbavJiT+YFtkQ8kmWpM7PJknjjgBWazJj
 VW0L8Ts0fplnheXuZE0EzjllCRrw1MhbhmM4Y4lRm2AkqtbSmt3Cmw7rYZAg7V5ZwI5yjYm
 tsz6lYBuA4V4ZRVOns0I/m7fwAW8wRfLMN0W5GEa59W8h9RUKGlO/qszNz8BVL3y6Fu0lGY
 v1nHfcBbcLWm5jx4+6biA==
UI-OutboundReport: notjunk:1;M01:P0:w0oPaIaMqCU=;sdy1PZTz4K3sCWVY5zfzR2oHboW
 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
 JmmbxKw8rP1KoR4Ruw==
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

VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
state's colorspace, but the HDMI encoder never sets it, so VOP2
always converts with BT.709. Once the colorspace property can
signal BT.2020 colorimetry to the sink, a YCbCr output would be
encoded with BT.709 and decoded with BT.2020.

Pass the connector colorspace on to VOP2, and do so before the
early return so that a colorspace change alone is applied.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi_qp-rockchip.c
index f2a1ea8dfefa..24a28b5f4576 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -205,6 +205,8 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_en=
coder *encoder,
 	if (ingest_fmt < 0)
 		return -EINVAL;
=20
+	s->colorspace =3D conn_state->colorspace;
+
 	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
 	    s->bus_format =3D=3D ingest_fmt)
=2D-=20
2.56.0

