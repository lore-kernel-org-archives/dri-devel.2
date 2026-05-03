Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB474FF886F
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 16:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 145E810E335;
	Sun,  3 May 2026 16:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bFyy+mIT";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4FA10E335
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 16:38:57 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-678e678970fso4641347a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 09:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777826336; x=1778431136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dx1E17McT3yMJ8F2BtpMdFWZT7NS0EuMQsItPFsAxhA=;
 b=bFyy+mIT+SMUlPXhJ+Z24ot+N2E9VOMD2E2CMudwz6MBarcnZw6otc9bTwFpnQ1aHP
 AuxLaT2iPTEOmx1TTHf56PPVlZLRNnvwJwuyxirQj/A24if2haXiiVbdu1HHjc8e4avi
 dF6OxAB6nnswGdWtgZlVc5n8tFOoxWCIn+iNcDPYAsRqvDMGk7RDp+AjAsbqoJ7yCwlb
 KvVIADFV3LZI2JayOn5xlzVpwTa/6MgPKOvz2fWSFZyG3p9Pxq6wsVU/JCopkk0LZZP+
 52IjmWVldv0+/n5HkJUe1d/CtvCTkJ+WQSAAPYtJTXhjL9eIQIMHBnl3TPFVPhxAEq7O
 eVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777826336; x=1778431136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dx1E17McT3yMJ8F2BtpMdFWZT7NS0EuMQsItPFsAxhA=;
 b=X4DZ+F2MIPIK2ukaXbA3EgTl0QUzt2QsVdQU8TUuHcG6MnFqVa/hq45Hk4NCA5qRPx
 WGUdgDiSthxi9HFtvKuCNsIZVHEoxkPPOnAOdwFiovWGN9k586vQq4Cn++SUgHvPxqxV
 voF3rUUBbq4+AEtCKdN+kRY6gwAPL6BALSzeTZg2cnvwKi/Sti8zKRJsofpDM7VrFcMU
 yQjO7pgRF0nDLaUXJ13Ok1EmqiEfmAmSZsYELSjHHAY20KduRMfq6idfEwd7BlYB1/GJ
 qr+9UOfHa6K6fIvCecg9bFd7qGcY2ky9KPRMrp9HUyy/5Rb7Y6oYzRW7G4GXbzm5j8ka
 zFTQ==
X-Gm-Message-State: AOJu0YzKr4HzqoMzeYVr3h9yPZzyWtHrTMONe5jUyMJZuJ0rt/GfTowm
 a6ThcBXp13XEBuL/l3sE9D27PZwx72Gj3tgiYlju50VZXPeYK7lydbsf7MNPxg==
X-Gm-Gg: AeBDievsYMuURHMO06ymYcqxvFEsqYADkXzbb5LJtweEjUWndE253DEXJ9yujqn5FbJ
 fBNVTq0y8GTuz9GEfqNcwI4vOBEOChPpi1SqcK2JMVEg85Tins1AIL7FyenPKJyPIuXbWFL7iGK
 z3rKPLSCPQ1ZXQvagf0uBZ03zPvOK004kZLUJV7QVmW+FypdUp9BDSBxyVznVftQcMu5JPsUkBP
 lAU16IT5b9o0/uUhi73kP41WYCeopFTX0qdf8sDxuajgUet6bM8mQL/T6KX3KSuant0w4qFjf42
 0c6alNM/H1Axg0JJJmpbxtQarrOSOtqrzLIwEIO/yDXujJ4MQUAlYAyQa8UAKrYxZZxISUiObaq
 +myi92deBDiU4LBAI4DBRkBHcU8XK4yooE2tZanKwXn6kjAEqdcjbDZUZycENtFnns5duMtfB3S
 zkB+hb3AnsaFfMeEyA3YWWw3I=
X-Received: by 2002:a17:907:1c9a:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-bbffbf853f4mr320445466b.43.1777826335947; 
 Sun, 03 May 2026 09:38:55 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bc1ffd6f8e9sm44126066b.13.2026.05.03.09.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 09:38:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/tegra: gr2d/gr3d: Initialize address register map
 before HOST1X client is registered
Date: Sun,  3 May 2026 19:38:41 +0300
Message-ID: <20260503163842.213489-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503163842.213489-1-clamor95@gmail.com>
References: <20260503163842.213489-1-clamor95@gmail.com>
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

The host1x_client_register() function is called just prior to register map
initialization loop, making the device available to userspace. This may
result in userspace attempting to submits a job before the register map is
initialized. Address this by moving register initialization before host1x
client registration.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
 drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 21f4dd0fa6af..e4148b034af7 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -276,16 +276,16 @@ static int gr2d_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* initialize address register map */
+	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
+		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
+
 	err = host1x_client_register(&gr2d->client.base);
 	if (err < 0) {
 		dev_err(dev, "failed to register host1x client: %d\n", err);
 		return err;
 	}
 
-	/* initialize address register map */
-	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
-		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 42e9656ab80c..47b0c6c56bfd 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -506,6 +506,10 @@ static int gr3d_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* initialize address register map */
+	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
+		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
+
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
@@ -513,10 +517,6 @@ static int gr3d_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/* initialize address register map */
-	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
-		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
-
 	return 0;
 }
 
-- 
2.51.0

