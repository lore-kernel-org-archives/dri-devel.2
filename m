Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4869F4368A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 235B210E9E4;
	Fri, 17 Apr 2026 10:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J3N8AdjF";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C81110E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:47:56 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43d01d6b50cso517206f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776422874; x=1777027674; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EtF+ZEQP6zumvHcoC4Xl4LiFgpkDyF+mdpLzjK7diUk=;
 b=J3N8AdjFNgGci5cZ3QMHMh5MC0Qj9XMC9L+yBNhyyxqHv/a+rGo3nFI+vbHCytpeaw
 kxCww/Mq/rZz4mxwZhZFVh6tmBOJAg9ikK9YKgH1IyssZu6BtZL4AVaQI6p5ittbyJFH
 EKoSsaf/puEYOxSb1+3+ZFom5fic/r7Vdtu34mifjlrmoi3aFzxAAERk9rnEPszC56Me
 7nC89QZI9MJ6BYD7391LksK+uT6h/7cOpkM2n8Ar+lj8Jh70rWfymE9I62O3P32zQNwg
 612mH4mSw0n0YhyMXON/cswPVJmw+ONhqXgKGHgcEqbeeexmghnvW0Pd9an0dHE7IBwj
 HOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776422874; x=1777027674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtF+ZEQP6zumvHcoC4Xl4LiFgpkDyF+mdpLzjK7diUk=;
 b=eE4fcUMwU1+a1EvE96sWeLTEmTHBXkgptlxUi/bBaJha3vgozOKMuXaTju48BJjIhz
 jUoStZynXznBO1VDSy9Tm5NxBo4wc9gE9bld+jailxLEDxiaGKUaxbSVbx0kom3UsTKh
 WYdUFN5Bg4/1VRwvgFzyRur6CiWAj9dlFdBS8VPa7Dc/j5esGjHNT0OQxL6gUu12XmR1
 Y8TrfmwnJWGhrcptABFPg89jXgZiP4srpNuYVudoSY85GVdBNZTIDUx5hXdZagH2uaQG
 oRqBFLwEhK9vIGsmkDni6pfgxS0yNty2OjYtdvtAc4R+OkEHTOw3m+eODNoFk3jwtoJs
 O2Ng==
X-Gm-Message-State: AOJu0Ywbs/CyfdDTQESLmB1Z94i0GVrQAo4Aip6tRWMEdDyI1f2dKYjN
 yE2aF1Eyks6BkTUxbgkUouPtLArbCKYwZm6QWx3tYkn21Ws8OaPQPXUvhSu6vMQo
X-Gm-Gg: AeBDieujfiH/HNVvsX0uY7MVSr+HCul9w8wLQNXFSAEwBn/2NzSGRaBpohk54+IE+mD
 jIv0SJO+GeSmq2OdOgNn3BnBIRD90SnyxFWmeZGk6UXn6t0rCDPxIWES+MLBvUA0IfXafovkXlx
 h4sx96zmphHoUF5tQ07CQ3rw/4/W2Hn3cbf70qcjJnskt9Lw4wUVgxc8jRdVZC9XHgC9nvVYDbN
 ldGEXKuaChJ2/KVopvqHjiQ6qF6OiKYecTfvN2LznR7PsMSe7RLBX9Kib/e3L5Gj0bTGAyPOe0i
 hKOdSLDRwsgIl4DwDG8DR7gAjgKSW6RpVqyM0V7qxU2ATDYfQMrIuzu16Xq1r5/caHXac/tsS+f
 H2BMTEdanMyPBYZ9qx8VNohyot6a+3ek7Z45AGXk9Am4cxYSvZKEM/baS6rpXlDd1doNLlTeI3u
 9QJUOzUQcd2pLNrurCmNxetSJj10tMXA==
X-Received: by 2002:a05:6000:61e:b0:43d:184:8a9c with SMTP id
 ffacd0b85a97d-43fe3dd3a8fmr3614532f8f.12.1776422874310; 
 Fri, 17 Apr 2026 03:47:54 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm3732966f8f.30.2026.04.17.03.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 03:47:53 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Marek Vasut <marex@nabladev.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kael D'Alcamo" <dev@kael-k.io>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Zhunyi Z40046 LCD panel
Date: Fri, 17 Apr 2026 11:46:29 +0100
Message-ID: <20260417104740.259689-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
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
JD9365DA-H3, it just uses different initialization sequences. A
partial data sheet is available at [1].

The two initialization sequences for the panel have been extracted from
Android original firmware for the Xiaomi Smart Clock.

Variant -ctc tested on device. Variant -boe not tested.

Changes in v2:
- Double checked and fixed some mistakes in the reverse engineered
  initialization sequences
- Changed the generic variant names -v1, -v2 into -ctc and -boe, as
  they're described in the Android logs
- Fix alphabetical order in bindings and correct company name

v1:
https://lore.kernel.org/all/20260305195650.119196-1-l.scorcia@gmail.com/

[1] https://github.com/QuecPython/QuecPython_lib_bundles/blob/master/libraries/LCD/JD91651z/JD9161Z_DS_Preliminary_V0.01_20180803(1).pdf

Luca Leonardo Scorcia (2):
  dt-bindings: display: panel: Add compatibles for Zhunyi Z40046
  drm/panel: jd9365da: Support for Zhunyi Z40046 panels

 .../display/panel/jadard,jd9365da-h3.yaml     |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 313 ++++++++++++++++++
 3 files changed, 317 insertions(+)

-- 
2.43.0

