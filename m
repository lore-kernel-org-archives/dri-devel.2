Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FCF4368F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378D410E9E7;
	Fri, 17 Apr 2026 10:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k9flvQdl";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4DE10E9E7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:47:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so4254875e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776422877; x=1777027677; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9/EUUegoDXn44FXScp1to+APnGd2Tnc7fnqt4PuWeU=;
 b=k9flvQdlJP6dBl9izMNHJ4rALT6+x4r5ejJzHj+lDxZVhkHtfohFOLZeoeGlTZqe+4
 aP9AF3fHvgbRGckgFbqM4dXwsHqO5cGSPw92Rsx86ml9q1Qh/whW2AeuKPpLgYX576Y4
 iJsV85dwipbhrpohi2Qi+8qzrRgXzPb+tBycmvZ2hpmD8HFf5mye1eTLyH0ElxoYKcId
 rm+GMjKWyX+E7fNdJ67FK77UE2uCrveuKYxHixQ8ZJEYhq7MPaI0QM0nE4K+jnOCM0Wb
 eNA/HnzFH1GERdSOYNuUeDyHa+DsF9pzFDQDo3b/6za1yqWCItDdsCi5jt8ZI0EK9+oy
 +lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776422877; x=1777027677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9/EUUegoDXn44FXScp1to+APnGd2Tnc7fnqt4PuWeU=;
 b=ftwWmYIns6ZwvP6IqZRHfbetwOjs/JE1nWEWAz6DTA0TULt3NMMRch6prjusw+yj35
 zZa+uEBge1RlcfPB6pvyeR8OcFZHUkjXfAkcnyvR+ELD33/ektHYYhgz5Xwlno6h2btU
 vWgXXqQvqYDInBEvgD80r/WV84KM8Od0eeYbCvNg4/ACU7x/TpW4XQHUXuTqNTue8hHf
 9HIIAvJsz9WL5asKaLQZO82SuTW4D50Uf0S9VFaXbH89KbZNQvQoLQy89Awyk3eJRXnR
 hTBks/s8UJG/2XMrrct1RBt0rPYN2dCMuiQFWIbm5qCKNlyio63rP9xEJ0n4MYZHwayH
 sZ/Q==
X-Gm-Message-State: AOJu0YyoMtSdAALUyuIfnsmikpVIo6Iu7iQTqy6D3BARSG8mBJ9e78WO
 h9IGQEB9FH5M1LlN0k2W8GMAg/TBIFPiy8IoW9Sr8SM2fHVe1VOJr4MGLWMBSX+p
X-Gm-Gg: AeBDievzEm9c7fGwsdVrIyygDlhGjcISL2kx5OkDE9x7Fd7gZk6myFfQLSQHTRaCc6n
 s705Htc7sKvnZXuoz/4LBGvbUBqZ8Cvrcg0BVd9JpWFyHb2SZKTewvydNfC+FoGPF55CYMVB7ff
 2j0ku6zsxVvEOQhxEVmttFnGs0WWo/XgqYdQ6BysmJMwrm7lyDOIj5Rwk09LCsypps7MKO3BZ0e
 m+kDgMCA5WpRw6cYOTGncQU8ExhWPxOS4na9oUlatenQT0dV5u4jeHHZn2e0rbq6iefKO89dn3f
 /j4zAZ/xPz3J0R6Y712JGWvDeTt2FhS8LlIEenPDJQ+0BdhzZ0EElaVgVNYhAYVzBoYrXrIMyqe
 Fh4GZwUIVIgEPyuUKWaKp+pK1MFrbMDwXdbQyE+3zfCb6vviVImc37scYzjPnAaj7WCVryV7Rv6
 cf5aGhwL+XAqrCRD7Lct2Ii12VHtf7Iw==
X-Received: by 2002:a05:600c:a6aa:b0:488:a9c3:44a3 with SMTP id
 5b1f17b1804b1-488fb881cacmr18412825e9.2.1776422876800; 
 Fri, 17 Apr 2026 03:47:56 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm3732966f8f.30.2026.04.17.03.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:47:56 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marek Vasut <marex@nabladev.com>, "Kael D'Alcamo" <dev@kael-k.io>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add compatibles for
 Zhunyi Z40046
Date: Fri, 17 Apr 2026 11:46:30 +0100
Message-ID: <20260417104740.259689-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417104740.259689-1-l.scorcia@gmail.com>
References: <20260417104740.259689-1-l.scorcia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Zhunyi Z40046 is a 480x800 24-bit WVGA DSI panel based on the
Fitipower JD9161Z DSI controller found in the Xiaomi Mi Smart Clock
x04g, apparently in two different variants.

The Fitipower JD9161Z LCD driver IC is very similar to the Jadard
JD9365DA-H3, it just uses a different initialization sequence.

Since this is the first supported device from this vendor, document its
name to the vendor-prefixes.yaml file as well.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml   | 2 ++
 Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index e39efb44ed42..158388a284d9 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -24,6 +24,8 @@ properties:
           - radxa,display-10hd-ad001
           - radxa,display-8hd-ad002
           - taiguanck,xti05101-01a
+          - zhunyikeji,z40046-ctc
+          - zhunyikeji,z40046-boe
       - const: jadard,jd9365da-h3
 
   reg:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6339988e3805..debaec59e9a0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1923,6 +1923,8 @@ patternProperties:
     description: Zealz
   "^zeitec,.*":
     description: ZEITEC Semiconductor Co., LTD.
+  "^zhunyikeji,.*":
+    description: Shenzhen Zhunyi Technology Co., Ltd.
   "^zidoo,.*":
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
-- 
2.43.0

