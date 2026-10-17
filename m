Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFE0CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499E710E659;
	Sun, 18 Oct 2026 14:53:15 +0000 (UTC)
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1C910E3CA
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:33:34 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id
 41be03b00d2f7-ca7fcfe1669so165951a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792233214; x=1792838014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tDddWpoHqTtkxFsBbERUVZlldFJw6rS3OQ/sbeQSp+8=;
 b=XZhxqFNAR/W4GhB/bWDyVI8m8EatmDBxHFqLGWwVtQYdCDDGzxsTLixyPWSM9bzfpb
 aWzmE82I0lfflAAafAW1rhoHCOU/gqVA6tKFDo0KhPAAR1bJrjwR/Xq07qToGct6Mno2
 JLBvEahl83Q6LYO8GJP3Xh3+Qp651htx+lkVOiDXoA/lOLIgbwfGpPMsXGLt0qRkNuhE
 uo3ubhW29SuqrVfGAuZRlB96N+UtS2AFCgBEzgxGq3KKiZlPl3n9DFLmpSEmyUaWqzaD
 DgKL7+9G+pwL/dCEvz0yLoFRMUMQ15u59QJ4mbXKCXZUrI4ZbG1xIqg3jUOk+YShd/4q
 OCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233214; x=1792838014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tDddWpoHqTtkxFsBbERUVZlldFJw6rS3OQ/sbeQSp+8=;
 b=RgnfiXfX5OJ7NF31PXrHEVZp7FHob3ND4LOETP+ox2vJ6a8WQr4l2XeOD/y1wid5FG
 gNXNfdc8MBYTpJQ8YwiFS3p8ZDzY1uO6+m2qeP878gJprNjXyonJemeMX9eIeMaUFWyO
 oap4R3d8nN5OO5NRgJ31zxcvXS0Imlvb9l3/mdLlwX/NIfvytLiiEIxXU3Jt5jLcSpRU
 nqxo91a46xBhdMpvmNS3YhByQ/Bx5IC1s5rqduEmB87BkDxcKzfMp4omrtpufR1gxhzT
 WKuiU2orEUGCJmFS95/IlnVvx0coENUn73RfJxQ1UEraLaEuKy9hfHBERQ/gRH0Xy//h
 juRg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKM1p6/Sp0wzJxY1RS7Y4xbkT0USG4MSkTKptKdHCiTT/Qey5rB60F9EnhLaIuZ5ZrU50e2+T050I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIiA+vbzv5HUaulbJqmJ27P/c2HRSy+v60Nq5wq6Pjgm1JrTzxl
 kRl3A4qT49Mwv+Yl+FvGTbO8afO9FHwUK7va+q6AjkKFe+MDzJzpg+rb
X-Gm-Gg: AYBFou12Unp9i3DUbT/ZVyExG6YYf4cyKZ8JaH+dRjXOM6sUiWZTLth0EqnJlZJy3TO
 Ci4RRW0KZR+xJtaD/vUPCkM5qO0Z6BJY2tDqiHtQtG9KGNbrzt0PwRcsAiby+B+onBWq+O0xMf4
 TnNkWLEAnu305s6iz8gMeLPpQkGKMnUeWTkILqq3yR7nOkQSQFCFZwUsG5havRjCpu0kLGAciCk
 1XesHloqQJdmd8S/t5nMp9j//ig3HLeWQYWNw9P3bXDT4Y5J3bceu+RKKxwXwCU9zeDlT9pQXvl
 qF/3yNfyHueHNzKiMTCNSIJrwAenK0cG+G9tZihfxPkL9ZKLnRsr6XUUEb1QU9646a31wsOt9DV
 Sl3uJ+vVA8VW5GGS4C15KAgPe8BoAjRPf5szMVckGczgTanrYE0NnzSKdVkqudPVjji7boyYXdj
 KS3tqsWK+VTHLlzxVOMtzG8p4ZspLptbRBk8DXTVEiz1LK5uJymUOB9h1+
X-Received: by 2002:a05:6a20:d80f:b0:3df:5190:2275 with SMTP id
 adf61e73a8af0-3e22607d574mr1478512637.70.1792233213912; 
 Sat, 17 Oct 2026 03:33:33 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:372d::57f:4e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58414986sm2051585b3a.57.2026.10.17.03.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:33:33 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add smartisan
Date: Sat, 17 Oct 2026 18:32:48 +0800
Message-ID: <20261017103250.800109-2-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017103250.800109-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

Add a vendor prefix for Smartisan Technology, used by Smartisan
devices such as the R1 (trident).

Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..6ad8d3499227 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1535,6 +1535,8 @@ patternProperties:
     description: Skyworks Solutions, Inc.
   "^smartfiber,.*":
     description: ShenZhen Smartfiber Technology Co, Ltd.
+  "^smartisan,.*":
+    description: Smartisan Technology Co., Ltd.
   "^smartlabs,.*":
     description: SmartLabs LLC
   "^smartrg,.*":
-- 
2.56.0

