Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D6FFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53AF10E0E5;
	Mon, 27 Apr 2026 07:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MfYIzXhS";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F1E10E0E5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:59:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d73422431so9140621f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777276757; x=1777881557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hcBXRILgB7ySlKIgu1NiwSsUgu6C/OB+9EO2Yb/lKmI=;
 b=MfYIzXhSPKwOoEjvVaGbFLcs65/ggkm26JbIW25X5HYWOnqcfaSe2IGbEFj8kpIbSw
 OjUgveq2Itae8ov6fpJ3OGP2WFa04PSw11vpUm7fMAaUdsna1ldde224Eq9+OS1akE8x
 TeXSrPOFr4t2lCYMg1lYLtJDF+03MbS96GfZ14ym+dT9Io6M++Wx1Ct2DbRf/ABapp5v
 8CShRzAr2/L23GYmN2gy2/TdX1sTxCj3xvQwoODqgSqP2eFanl3KEkVUotO+g6ywAVD9
 6HrXbcQykUThQJF+yKJHjXuh+SJ0q5nNI3W7BUDvmGufNDNyVZAE1wRlwK3EMflEaa2P
 edHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777276757; x=1777881557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcBXRILgB7ySlKIgu1NiwSsUgu6C/OB+9EO2Yb/lKmI=;
 b=UrG66pC5cZ/HGNe/fa9vilFl3AaqW1/d2vk9nqefneHOkKxZA9Wx+P8/YnQ9/Agttq
 2ypCDXtGgTlPQL7LyJ1BFYClrqbiN9wbDfjyNhUx6grSM1ddLj16CRyjDLAZxL3NcNEe
 VNqz20aJYghOuZ5OLiSxlrFx9lR1za6GeSrsWtNyPcOzgPrMid/D3O1zX/wfBDPtH7dy
 12XfOOwwV6R9fOfy8d1XzLkOr0QQkQ23u5NCPKrEfEEl0my/7tzXV5+NnSmah7IzO0Nm
 AyB1suMhR/Et2qgVKl913vPPSplWVywWyJ9bTV2ZHgW2A2GZJG3sSAB4guCJwVL9r4+5
 oA7g==
X-Gm-Message-State: AOJu0YxUCVuDm+CPnqXqrlwrqfQdQO/qYyQH/iteQpWrJzEDu5bvEPUH
 7QpwIhj5JrjHZ3gise2gTbTalxevYMrYZY7LO1Gh+Pzp6Qxy2oHH0TjJ
X-Gm-Gg: AeBDietSMtCGplRW/SRBXdpVXMnmv9hAnrvzmhwnVr1ZuvJ7BKFZuN2+VqDuwR3JMrn
 OY1UwpIOrH5cqkvD5zjU9t9uwFAOrC2HzGR93vluT+PdzLNSTTxFrIX2VnBwx6g8yTsLFikIUKn
 nC6V92rcIa/jatAjyRFuh4yY/OHE+4Xa8jzl+dwXh0GE26McL29TxAPxMQMsoSNLZdZA19Hn2L4
 Q2ldGv+XkM8ouNgAD87wlbaJ66vgSiEHh8hFen6oKtzM0Kh8setAMcP9EkV33ctzE4vGfOjaqaX
 PeW3g+iID5SmDlAb7QjSgnrLbl2KEvfSfg6BiAHBBIf2LRCDtefmzUKNBIOJfLQ+sUckteBKkMJ
 UGF1JwjhBJf6LAyiyKIvydy73RLHWyMod4ql7hCTKg+UP56WVhjaGbGfelmFBTQTxE4hyEc1KO6
 RFyOhrij2WNzm4zSemaZBZc9gg/fLWMOE72g==
X-Received: by 2002:a05:6000:25c6:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-43fe3e0d44emr62576337f8f.29.1777276757142; 
 Mon, 27 Apr 2026 00:59:17 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm79918386f8f.2.2026.04.27.00.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:59:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Mon, 27 Apr 2026 10:58:55 +0300
Message-ID: <20260427075856.85208-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

The gr*d_remove() has pm_runtime_disable, this indicates it should be
paired with pm_runtime_enable in the probe instead of being inside
gr*d_runtime_resume().

Ion Agorria (1):
  drm/tegra: gr2d/gr3d: Move pm_runtime_enable to gr*d_probe

 drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
 drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.51.0

