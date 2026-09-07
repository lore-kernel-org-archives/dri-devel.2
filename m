Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A406C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A735F10E9F7;
	Tue,  8 Sep 2026 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTFnyZCx";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C6E910E7B6
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:52:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so27079065e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788781954; x=1789386754; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vgAaxOdJ37XQvKZXxM7LpSpiTxD4plNlhS9nHZF19I=;
 b=bTFnyZCxQzoN5sREzB7/goQrFuV6ewjbgv6y4Oihjxocpv2IT3cQSZCuFb2TJawwq/
 wTELY9DmM8ubJJE3EhSM8xYM5xGfxpgf3njkzb5YkbWfIFvqm1GgMuM+RTPOlvUTHnoh
 LYz9c6gGYLOcjFPe7pgRedVTH7hjnT61UypZ/rl4yxW0RF0RaACrLioyp+m1zRUxGum1
 sZk6+KFaeRUuhwOGGqgX8g5dN1lm8xVMOlGliIu279UVFCM06eIu3XRnDS8uqFjz5W/3
 BJI3SVVgUlblrALMM4jT5hPpCfQwJHvVUUbcdN/9sR+A/50xWxr/egCyBWkMU+kOcQKS
 L/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781954; x=1789386754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vgAaxOdJ37XQvKZXxM7LpSpiTxD4plNlhS9nHZF19I=;
 b=gL7PkXXal1lFSQdhanbqcicL44N5hm1brFSCpk26cAemYsxzubm5O3+NqzMyVve9up
 R/0eLdWZtaNzOxBburmVlkjAmyEfMveYx4b3vzkFqXawVQyIx1ett98pLxafuZ91uuku
 qQDYux4fOPiacjdsE0/CGnROJgXDssYiHectJz/xlTJrRzCEl+aebcQ8ae6lyrOGm7VG
 NBm6L6iVZGaUJBZe/nPEaIcMRYOKR2orPSRUQ9eTVJj2YxkdAb1TOYIe5OYgeAN9U4MO
 ojNa0sWWxZUyh3nojGuxm6JXAuptE33f+F9HF3ZNK2/pA9WqL0hNAMZVO8RosRUyHDUJ
 s4Cw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDDjRyLp/wTvBAL4lekMDDctqJs35oT4DCIZV6V5xVrthBQt+GrYEtx1qCe6d44Duu4L2QhzRVpkw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mRMws1gJJSji5zyuFMErc3WT1Z/UfkxVoekATSFiWJxD4VrkBl
 lCS78iERZ7GijPaZDGomsk9V/tB3hCrUlAZn2Q6c+BMmZslbV03D3HG+
X-Gm-Gg: AYBFou3dRB2O+PZe1FRaVxJkPKBsvGJBCQAOnaCdSHxChQD/jqziObfQcKgQqbeNFuT
 pUZuTLZ4FWSmtiL9/6FetjvASNCB7/Ouuc/QLga+HHBoghaANnS2axMiaiI6KtU2KJKV/kI3cPI
 QkxGWnuLM65LfBZ35A+rU0RYpWl2F9MeNmjIwRhuTjyCgOtbPwijhp/kM37Isvubni/pVzqDiZG
 VgYTKwMRMk2pl2ukk8BfUrq7Qa2JFU3BdxK9IxRVU44Bh+epcPgwnO5Qu85tiehZBLTPHjFrHIZ
 FhB4iexlC/PrYZhFCHhYW+1yG2NxeKsuaGXCJqfOPfQtaAro9zGynHYvJFwR+jPBFEbGaKV8MTj
 +UodqElH3f74AernMVYKaO1cARTO5tv/buGbvLimhFynRDY14CaUl27jHdLdopVndb5ABEeeA71
 GQCIyfxQXa5mMwgfAgb0EzE18aodkc/pDoqLGhdNm/UNHX7XYJtQ4zsc3SmIM1vjdT
X-Received: by 2002:a05:600d:8497:10b0:49d:daa:af6e with SMTP id
 5b1f17b1804b1-49d0daab034mr51583285e9.16.1788781954505; 
 Mon, 07 Sep 2026 04:52:34 -0700 (PDT)
Received: from Empers0n ([193.23.219.104]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm26830718f8f.3.2026.09.07.04.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:52:34 -0700 (PDT)
From: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: jesszhan0024@gmail.com, conor+dt@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Subject: [PATCH 0/2] drm/panel: Add support for Samsung AMS662ZS01 panel
Date: Mon,  7 Sep 2026 18:51:28 +0700
Message-ID: <20260907115130.95394-1-sevanevorotov29@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

This series adds Device Tree bindings and a DRM panel driver for the
Samsung AMS662ZS01 FHD+ AMOLED panel found in the OnePlus 9RT (martini).

Vsevolod Nevorotov (2):
  dt-bindings: display: panel: Add Samsung AMS662ZS01
  drm/panel: Add Samsung AMS662ZS01 panel driver

 .../display/panel/samsung,ams662zs01.yaml     |  75 ++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-samsung-ams662zs01.c  | 398 ++++++++++++++++++
 4 files changed, 487 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-ams662zs01.c

-- 
2.55.0

