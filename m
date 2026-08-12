Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31397C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5B910F25F;
	Thu, 13 Aug 2026 09:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mI0FnOKb";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AF410F05E
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:00:42 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1344744a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546842; x=1787151642; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gMOizgIP9BJQteM6A8h6tNJgWMELd3MPmjUznwQtZHY=;
 b=mI0FnOKbbxsW1oFWXBiz1MtSijmXwyf7IHgrNO1nP4Wgl9uG+fARnlA9+NNGqszwfs
 IiTo40/ne9q3Dwg6+5UosqF2QwJlY7v3DbRRALtYUYtObRPrr48sDu+B3TFJ8u0vk8VV
 +KEbqn+mrpTSR/LoLtT6nlPxvL9VRMKyelB7c9KgfUkLuMWueM2AX6jTf3rHdB14y2LP
 SyFRgfWlQiJMqz0H4HN/eL8gt66c2rlyLBCoFQySM0OUMDAd5UrDoJso24eGJ/ib11jY
 V2mXx/r+O4Ya5dJu2JJjg1Ac1mQP6gbZwapo5YdVLU5IWJegknYvdFx/m+mcZ3QFOE6P
 i+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546842; x=1787151642;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMOizgIP9BJQteM6A8h6tNJgWMELd3MPmjUznwQtZHY=;
 b=rEuExJ+OnpDx2JB6ZP+a8h/Mr6iVkPUxwLBwWOO+c0uGNKDWL7ZVc5VRMg3TenWrCq
 7MSPbiK/urQfmosYB6jw5tMpvefBYS7FPIJpASIUO00N7sRZG/pwft4fyr3BkTVmrY49
 ht9yWij4oauneyjgjCPS21fu7hESVLGXQbrwMwwPZmMU4mXQwNrKf0EuSUwT1UQ1iAHi
 L4k1Iq2pQ83aeJfR43/FSOXpK+DHhGq07efuXAGz/6xMZuIi8I3UyUfzQerJkHKbPXqg
 5TLg9UDcxXBi/FnnECpw1RkyGgCSxw9GLfYX2ofq/KhsESaijdv4AW7fKCxQBQgKzl1j
 8V6Q==
X-Gm-Message-State: AOJu0YzlUW1/Lo0UEI+Pl/BhedsCZN1sh6XLn0Rw2/YQBkA/HYM5Jk1e
 YPSJ4Obc6TCb0mEC6VWJA4k/YQr6hC6wBj1duqAXFhv4U4JVsIv5JFT2
X-Gm-Gg: AR+sD10ZwiAYK6ADKF+eI3udaUByOxi/n332jeVxRZJmJApL4Yp7mtGg8GYRxHybyji
 ywoRrRt3nRIRFsdPkCXPmxO3ddajZey8t+pWt/yQVLABK9N38iQAqinB7V74mWVUihw9djF1Ues
 pPpAcs8dizDKpskugpoIINlesX2nm9YHYImL60sNMlT4wQMllPL+oNE8zR7rqtnYTZRbTU9oAby
 coLs0t0qjJpjnMIZYocURFo1H71bObHI3ApeF86LW96LSrMBp+JNJgtwzDm2SSO06HAVNffKqud
 2dnjmzw0RDTVoJrNoCiLFOAbV3lPl7XhgYU0TorOoKr9EMbnPPAkCLx7nO+68eQ04dabtLUxXxF
 71Ejofq5Nh4nHVCukhZbTNUhTMLAoLMwBXBlLq/q+0NHzVmFlkvK/SF64y3hZj4bzRdYs2LjOky
 WblGXxmWDkNfVhsMwgnGiR5vI8Yv7gG/uw7X1wLGHPMqKUbd6q5kDWMfO9cRE=
X-Received: by 2002:a17:90a:dfce:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39300fe8cb7mr6781997a91.0.1786546841182; 
 Wed, 12 Aug 2026 08:00:41 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:00:40 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 23:00:05 +0800
Subject: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in
 GETPARAM_GRAPH_UNITS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=1659;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=DHIfdikRkZ3mKShlh/+V7tgkqvRSlEckIAj2mwx7osQ=;
 b=HXxJzWcsyd2sKVHR1T+erLcdLCL/gkjA+9ra5ROLCdEp3ElbPtmAtHX0Jsk42Eej69Bbe3s1z
 JWrY3tlQYitDwdc3sM1wMfPD79z2pvggbmWqZhaxh2KZjHZR0tFAaXe
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 13 Aug 2026 09:42:01 +0000
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

nouveau_abi16_ioctl_getparam() fetches the graphics engine with
gr = nvxx_gr(drm) (i.e. drm->nvkm->gr) and, for the
NOUVEAU_GETPARAM_GRAPH_UNITS parameter, passes it straight to
nvkm_gr_units(), which dereferences gr->func with no NULL check.

When graphics-engine construction returns -ENODEV, NVKM treats it as an
optional absent engine: the NVKM_LAYOUT_ONCE device constructor deletes
the subdevice, leaves device->gr == NULL and continues probing, and
Nouveau still registers a render node. An unprivileged client holding a
/dev/dri/renderD* fd can then issue DRM_IOCTL_NOUVEAU_GETPARAM with
NOUVEAU_GETPARAM_GRAPH_UNITS and oops the kernel on the NULL gr.

Report 0 units when gr is absent. This matches nvkm_gr_units() itself,
which already returns 0 when the engine exposes no units callback.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..dd3f8d386377 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -306,7 +306,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = 1;
 		break;
 	case NOUVEAU_GETPARAM_GRAPH_UNITS:
-		getparam->value = nvkm_gr_units(gr);
+		getparam->value = gr ? nvkm_gr_units(gr) : 0;
 		break;
 	case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
 		int ib_max = getparam_dma_ib_max(device);

-- 
2.34.1

