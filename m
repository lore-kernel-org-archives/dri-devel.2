Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C75CC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEFC10E67B;
	Mon,  7 Sep 2026 07:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RGkARPSZ";
	dkim-atps=neutral
Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD8C10E63A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 05:45:34 +0000 (UTC)
Received: by mail-oa2-f9.google.com with SMTP id
 586e51a60fabf-4667f43a4ccso1411897fac.0
 for <dri-devel@lists.freedesktop.org>; Sun, 06 Sep 2026 22:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788759933; x=1789364733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o5qbbR1yQ4iI2orK8p1mAk+KPmFDgRJcpOZbeD4+1ts=;
 b=RGkARPSZpXxjiNuu13zw8UeiZeH53KEpTzREbyhDm/Cn9X3pQgQt3M7D7s28uZ8RDl
 cbAm7WmWPLP8Io7wBV/NKAtA22ZbGmcKSqydgbMcN2kJMpawiuaHJZM1sMC6Da8PfJF2
 2sepQQMzKX3aSpq/T9AQ3mCUxXALvORufPPsEXBW0+eQvw9RbzIqpxGnvQzOWf9opLa7
 b3M7LSUgPA0b5r9kD+2f/+PIHhDTfL+wAyGMmlqHL6P1w0vxF+/EYvOJJpC5gyKNN8gX
 8c+ZItSOW4YvIXr3FXP8cBs3JcuePyD50RKJKorIVu3IXN1RGl3DmgjBLBZAqnNdJV92
 rGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788759933; x=1789364733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o5qbbR1yQ4iI2orK8p1mAk+KPmFDgRJcpOZbeD4+1ts=;
 b=Q2OoPVeGKP3rBhe4vygQxg1N39iPaUtQBbIbEb4BP3z3ONFgV27g8f9SqHsXV1vvE6
 E6gwSjpt8aX3cytxJTIglleMubV71CmX8fMnh6SKvRzi3J+2CsxHXZlLn4PTY5zJvW11
 hfteGk6hylOHTuRzc1WFMbTLza1fq5tM9DnAnEcIahjgAdChcJpcxN6LMxJPM844uxg+
 +KkQSuEP5tt6z6zdL5sJ/jb4RSZTpQ3DPAM/iE8qU245gmAPPEk2VacMLP6uc1OpbIlW
 fpKK2a8Vv7jYR+0jPFQCnsOXD8pFIdxqFkGUaVwUcN+p2JtLiVn6s5UUW6Y++qt0A3ou
 wPtw==
X-Gm-Message-State: AFuF++nW6LZW4RV9iT6VZXiHV3fTlQyodlrD1TmyMCmUEQr/lDDQJORm
 S6WU+ojUedpdjmewzfJkFjmLQvOFPxvmkyqhpGWxtDrODqNJVXW4u+bu
X-Gm-Gg: AYBFou1l/+2VLIN6xlC8yEvtscUMKcEk54jXtUDvib5nQeMS/kyZvZM8xb5NhME8/1W
 a5rXpENi35fEjiFANo/+GVApgwRw+5ZFuTgoQfZ4vtP/bXiMGl72aL3MVnqK5N9i7PVV9KOOpq5
 d1G6tJqfs+whgxCWkPKDI2GQv8n7/Vuvq8KwLNvXHWpWoty6Zr62Kpgot3pt3G7IjximYeOIz92
 NHOI6HjrlSdKP/Cpvzjo7IbOKhL7fkcT095C5tHtUNHpk0m7IXU4RfigT0y8wHOE0tvqzzzzgcd
 3BojTAkEDatoIgi+egXIKOtAvY930Im/Uwsw4Viejc6H+APa8Ain97qgmCZEW8iKWuyYyM3ylYP
 Do81leRVZ2hqz9d98NrVCXB1BqnhAAYQjHgaE9hiZscVqKS+COvhPBvOf/a1fnDoakC4spCCesW
 G7zzAjjdYHkimzXnv+JKt5tLeku2IeAC4G/alht4C2tkwEMShNBd+7L74PPXrSCQ==
X-Received: by 2002:a05:6870:96a3:b0:440:67b1:b59b with SMTP id
 586e51a60fabf-4754d5745e0mr13037030fac.0.1788759932942; 
 Sun, 06 Sep 2026 22:45:32 -0700 (PDT)
Received: from ryan-dell ([2600:100b:b039:79f4:f7f:ccf7:cd6f:384])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47989a71ebbsm204482fac.17.2026.09.06.22.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 22:45:31 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Nickolay Goppen <setotau@mainlining.org>
Subject: Re: [PATCH 0/2] drm/panel: add Novatek NT51021 1200x1920 DSI panel
 driver
Date: Mon,  7 Sep 2026 00:45:06 -0500
Message-ID: <20260907054509.118237-1-ryanbrue.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905-rbrue-drm-panel-add-novatek-nt51021-v1-0-939f59e89fc9@gmail.com>
References: <20260905-rbrue-drm-panel-add-novatek-nt51021-v1-0-939f59e89fc9@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 07:00:30 +0000
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

Please disregard this series.

Nickolay Goppen posted an NT51021 driver a week before my patch, and I
didn't catch it.

https://lore.kernel.org/all/20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org/

I checked that there were no patches on the mailing list prior to
working on it, and then forgot to check prior to sending mine. What are
the odds, for an 8+ year old panel? :D

His covers more panels, but my panel seems to be slightly different
from his, based on the vendor kernel I referenced for my bringup. I
tested his driver on my hardware and it works; I'm going to make a
reply on that thread, and I will set up the Amazon Fire HD 10 panel as
a variant on top of his series instead.

Sorry for the noise, I'm new to this and I hope to learn quickly.

Ryan
