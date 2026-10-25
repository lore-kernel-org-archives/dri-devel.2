Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3318606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=EJ8xm6eU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3F910EC77;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7458D10E1EF
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:16:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so2204935e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955802; x=1793560602;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0eUvvq6t18C5RgJIwzh9hbYdswBGCIE7/yO5zUERv48=;
 b=EJ8xm6eUUun2ZO+ix+k2F2P8p3n2Nsx4jZE5N1rMAs/8lizEIMq1jUL4DHO2hS7eA6
 XCo+wWTns0Iw/gbc2ip/g5/2+7bAMJxRKAZbu8QMVDW2r+gqaWBE/PotZgqLqptuN+9U
 wswZh3V+xqaH8+cnnQiHh8dnQIXONAsOPeeg0zwySymg9RZsZrqzklW2OnIOCwyiwPjh
 P95POJzzm3YmVAqjqk0ZGo8Y52CQH4MRYlbhN96z1wFc0Ti1vK63R8XDdBGK0Ipop8pK
 eYCcJgj6AVKHOvF/95CL4w1+TZfEfj42Vh9CSqmWSCNoyL/A9t1ShiwgUklExHOr+Bug
 qeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792955802; x=1793560602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0eUvvq6t18C5RgJIwzh9hbYdswBGCIE7/yO5zUERv48=;
 b=H9VxasprjYNPGEQDuGXL2/YfGtUq4i+s2YD96MQG1pai/Vg5eSeAT5K3l24sQCLkFD
 jgjEwhiDVJ0V8/5S2QgLvnrRjrbTqMyD/RqmycBfShCl3vzV0vSLz1BH81WmWm/n0d/o
 AbtuJhJXQLBJkFYfJyfCe+Iv4L+B2Im/P6QhwiLefS5QjeOFhtslMj3VUKCASOWGu0oU
 vNSrb+hxX47q+QUMOru+9Tr1nlfjPPCTulBHt+8NQdb1bBais1GPI7lKLtyp8nT1rIYZ
 skkBT7VX+p0qwixcxr7Qz5oPgiy1qLQSfQQrNktC7RZgPb6lDeVLOnYI7JkC5c9ei0e7
 SbqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDigstfdjLjYAgIEQd0Av5AFlbYrlmdZXamqvfQkq64FbDtLil/oCWKzmx5nj5NwuXMF+j5by2qLk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYItsYFRKcLbBiCNPjrdeOAcsZLxzfIgWcmROamJr3GiBCVow7q8
 2aCAHXZwmLcoADKgLfmFrHr+UpYfaB6UmRlE2v+mirFBFp4tFvoz8u9QUat0ccRZtT0=
X-Gm-Gg: AYBFou3mdkSjGJamyAUZux5bsNqoHCjVpEGi+16UlcxV85RIx17D3BBgnFSf6zNL4R2
 Kfu4QUoRD6tRpgePrk7hVZQJxgQksljTjjJT4xNPcNNUd0lJoj+Zg913FWV+o89Nvtu6GjErby5
 If8GbECP4j16STVXWpoBuJ5wzQ/QEhCGPFckRjUe/Bvj0hBw87HTdnNu7uf+dAOH0h63QU5N/UB
 L5ItCXshxMudhv6B+nlX9iDWLNbTfWJe6/GtdA6Y4b6lVT/C9gdw+Lhm4nY2WM3t226FM3+HAva
 5Emb5gu8DKWHwUilLPmEmSuPWHh1TvPZlkyZNd2wKwj6vxIrW58o5DkfN1rCWNAC4mb1MiqBNLV
 SDB/sWFuUhgIjLaTa2zxgQeNY4LPJhf3ckzeYHcmHVMIbbCAzEXyUOzp2T85Dr5NznnEiXAR0GZ
 Sv+qiFZiyRt7Dgq/xoVzyGn3suZ4iW/6Lnvkwa+QPN0BsQlDXtGhsnl9Zhs1cErZh8BxLj7tv2J
 YAZ5LoxArog051jkQ3cH5wNNLL2H/VJZRQWgsI7DhFhy4rCVTKxzluk1xYQOjNAzYXsmWGvjVNd
 yUXf4vHplBwPd6Y=
X-Received: by 2002:a05:600c:a08:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a35aeab300mr99622825e9.15.1792955801817; 
 Sun, 25 Oct 2026 12:16:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm144560865e9.11.2026.10.25.12.16.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 12:16:41 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: Add HiBy
Date: Sun, 25 Oct 2026 20:16:36 +0100
Message-ID: <20261025191640.13592-2-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025191640.13592-1-olivier@mgcrea.io>
References: <20261025191640.13592-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HiBy makes digital audio players, among them the R1.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..b5bb11c20471 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -722,6 +722,8 @@ patternProperties:
     description: HEAD acoustics
   "^hechuang,.*":
     description: Shenzhen Hechuang Intelligent Co.
+  "^hiby,.*":
+    description: Guangzhou HiBy Technology Co., Ltd.
   "^hideep,.*":
     description: HiDeep Inc.
   "^himax,.*":
-- 
2.39.5

