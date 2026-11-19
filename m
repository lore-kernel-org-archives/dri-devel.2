Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2660A2618
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WtaCEJ0J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0466911260F;
	Thu, 19 Nov 2026 17:04:15 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB5D112663
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:04:07 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-38531c1a566so678394eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795107846; x=1795712646;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gP2dFp+nPAltPmlpy+sjF+Wz7tzVFG9r5/IcbCuHryM=;
 b=WtaCEJ0JcrZDd7jAYstOPfBFcF3kmsVgiPOQGKdORMzs57zDcUcDha/xltjhnqKbG4
 olRDCn1E4+KapIXba3IBQHFJjm5Zcub1IjtnBqWESBHVTSBYK/3Kc0DIVnpPoTuQxlIY
 u2NdBWEfVzcrSkaUkF6skAZ6MxZaVTgPYmkLTRvXUnPb73CR/KRTRa7oIEuznKNTZWnW
 hEkUHSxCWD3uy9OZ4eFa9fZRM0ANl02C1b/7KSNjFjDeCpVl56AHNM56rg/6WFpsiYfP
 mdNnhXbfK12TCLCWH/yITF1scKMUU7vWlOsLy13z8z4xJ5Ryn8B5waFajlcOcEW9KuQ1
 h5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107846; x=1795712646;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gP2dFp+nPAltPmlpy+sjF+Wz7tzVFG9r5/IcbCuHryM=;
 b=vPFvl3bkmlpmwbY0hrsWdZYFPWgZ/ueOutYhcGsADgQfzE7OVzaJ+ckdY33qTwpGUC
 ObGiQE9gVj7rp8ICdrJWeiQHUNLqboLuNYnYrtooMKrJvlGRiIYO5sQpSRlJ9u9xmH13
 Ph1xtRhQBZB/Wh8fRDrPsNnZu2IUBKEbaXVQt/wP1m6Ru0urUdCl5dY3bg/gTyAQQPyp
 e3Y3jrI9jRbEMWRNF+DMuhKTA9W091z2wmQapLrY9fx/1yZnDy+xah821H2q8saE3Lt4
 0/FPU3t6NJkNUNbNxJsDU109Q5mAmdzCOrAhpAIQvzCEMgUvgyhDn6lXQISBIvvyiHzP
 qAfQ==
X-Gm-Message-State: APuU4Z8YSBnG1lPZFgv9cyynCLK06XuuDqkCdnOxn3zZlMaIDDPhfSZf
 aRHnEwnEIj5S2vcrhokzuF7YmOrPB5he+N3Ocp9aPSsl5ud7usOcMa5cyAKvr7cANnRH2CWIsZE
 CvJu4emiIfg==
X-Received: from dlbur4.prod.google.com ([2002:a05:7022:ea44:b0:1a0:8cef:34d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2649:b0:194:9e7a:3ba2
 with SMTP id a92af1059eb24-1b5567f682amr277048c88.2.1795107845817; Thu, 19
 Nov 2026 09:04:05 -0800 (PST)
Date: Thu, 19 Nov 2026 09:03:57 -0800
In-Reply-To: <cover.1795106937.git.irogers@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <cover.1795106937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <f0db7ca640d19d1021b4031b08be426532425095.1795106937.git.irogers@google.com>
Subject: [PATCH 1/2] drm/nouveau: Handle NVIF_CONN_TV and fix error cleanup in
 nouveau_connector_create()
From: Ian Rogers <irogers@google.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In nouveau_connector_create(), the switch translating nvif connector
types (nv_connector->conn.info.type) to DCB connector types omits
NVIF_CONN_TV, even though nvkm_uconn_new() maps DCB TV connectors to
NVIF_CONN_V0_TV -> NVIF_CONN_TV and the rest of nouveau_connector.c
handles DCB_CONNECTOR_TV_0.

Furthermore, the default branch returns NULL without destroying
nv_connector->conn or freeing nv_connector, whereas both callers
(nv50_display_create() and nv04_display_create()) check only
IS_ERR(connector) and immediately dereference connector on NULL.

Map NVIF_CONN_TV to DCB_CONNECTOR_TV_0, and clean up nv_connector->conn
and nv_connector before returning ERR_PTR(-EINVAL) in the default
branch.

Found by enabling Clang's -Wswitch-enum on an x86_64 allyesconfig build,
with AI coding assistant help to audit the warning and prepare the fix.
Build-tested with Clang; not runtime-tested on NVIDIA GPU hardware.

Fixes: 8b7d92cad953 ("drm/nouveau/kms/nv50-: create connectors based on nvkm info")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b..51580824df36 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1394,6 +1394,9 @@ nouveau_connector_create(struct drm_device *dev, int index)
 
 		switch (nv_connector->conn.info.type) {
 		case NVIF_CONN_VGA      : type = DCB_CONNECTOR_VGA; break;
+		case NVIF_CONN_TV:
+			type = DCB_CONNECTOR_TV_0;
+			break;
 		case NVIF_CONN_DVI_I    : type = DCB_CONNECTOR_DVI_I; break;
 		case NVIF_CONN_DVI_D    : type = DCB_CONNECTOR_DVI_D; break;
 		case NVIF_CONN_LVDS     : type = DCB_CONNECTOR_LVDS; break;
@@ -1403,7 +1406,9 @@ nouveau_connector_create(struct drm_device *dev, int index)
 		case NVIF_CONN_HDMI     : type = DCB_CONNECTOR_HDMI_0; break;
 		default:
 			WARN_ON(1);
-			return NULL;
+			nvif_conn_dtor(&nv_connector->conn);
+			kfree(nv_connector);
+			return ERR_PTR(-EINVAL);
 		}
 
 		nv_connector->type = type;
-- 
2.56.1.708.g77570a6a1d-goog

