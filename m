Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AC606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=JBms0MKe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4905510FBA6;
	Wed, 18 Nov 2026 12:08:53 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 283C310FB99
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:45 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-49a92144733so370176f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003723; x=1795608523;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I0MHFtYg7sE1F1vIvy43zcgj8YN/1frwYJLkdDo9QaA=;
 b=JBms0MKe/w4UiKyyIl7eTxESdCIr5EhQSQ4tYIV/+uHT86qew6fgbiRC3zn+Wb/3js
 hu7UA4J1pW+Cg045UKZe9lbPrz1k0vKnz6wAh5bWtjqCCSifzHcf2vMThOVnU2aCv/3Z
 ZclH4+gCf6VayPw2v1fgFD+A3WWK0a1E3FajRRav/e1U8au1Y0XaJUMGAddtcXbGas6n
 TFpvwF9IER2efEAL+lAPnzrGbStaDoffKU6KvLqRxPV+dGAtOzQvX90qIV2s9tWNYWfV
 38qSQp0ktk2ehvLhVqPDFLIqpZcEmtkgX1RTcst3zQdTCiF0+2pdQO1D298uYwxDRzp4
 UPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003723; x=1795608523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I0MHFtYg7sE1F1vIvy43zcgj8YN/1frwYJLkdDo9QaA=;
 b=dWWWCVKoC6BUaIEhlM7vNXD1Ibg1OFeqokj911KwnSlawZ7fIF9xpr9+6WOnWTSpJq
 ocjzWesQW81C6SwSZvEWoa+0tSigh0j8cUvAkkFE230m0ESzGvDDiGYlIBhVlEvINnqo
 VDADn5ZFJuYT1fdQtSKFlzzA7jCtfXhGxNhqz1nMYpyIed4fBlr794bXSutKM3myz+HC
 Du1f1Asagai8W+g6PpgwYZV+MVajf+9IQEJ5xQzJ9b3LNtuSlScMZMIvhwm+1YGyLNO1
 EjXDuYUSCnlxC6VhlKwnrtw1oDfIL8hF40IrFqxQx5HxaSIUcb7ab4lw2JxyyaYZ6Uji
 YXqg==
X-Forwarded-Encrypted: i=1;
 AL+hErEuPcZjPhRrbJVs+9YGfU3RTbQ3dEyG125DmGHTIiCGpq4xxlbZn0NPaj+mOLogydANhEAwzZNzV6c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SUTlSFdTMiS2wVXKleicnxizG9fdsV9ITrNWI68O/kS/9ImV1
 Scb5jgGVLe2KdcN7ALpb/e3ag0fkvHn/AVan/9N3iTOM1mHeRGiRT8mtJ2Q16iqFbnk=
X-Gm-Gg: AZFdTZdD+TpBMx/yrikIRIPovQy0jm5a83nPvY15s5i8w0wsydPnyBEKENrT0U/JwOw
 gd5Mb71wCqGaqEfGw9D38Ubh/ylEmXJsgjIetlfEwK9KnZc5G3YS5jE2H0xttezlKx3FJhuD+iM
 Nt2kebLAtw0v+9GFIoBFxegC48yj7KlQa/pZFILDreONmUSiE7UoESO40VcH5JjxpX1yhNEDw4l
 uElpO/NiJaIN8LrkiLLXvJNw2zXHJ0CvR8OLQMWy0wQ2tn7NUPADatnPCaG2juZamIDqNVI+g8D
 gw9ETaKW+/EjcE2Pb4ktT7ws9gkHao7p7H8LMPKUIWavCJjDU2UqL1awokF+Z6bM6xATuDFyrG8
 O6zqLn19Kra1vEYxwnQQ+QREDRqPWKbJhh9eKuHTX4rFYv1TWoeQy5nn/fe6rknW+kQ/t8j2vza
 IwIC+lKLarbHL3XB0SGdODIpVxX+aXznnG7VWi9zTRJI41Dsl13TZmOBBCsZIDxub56CQ6/giYB
 aH8oZ5fe+tu7MqnyDHj+z3mQDwn/z8dPtxfebJvKVYA8Qrh1yKC/CylpldG5tRalqZ472RKP9gn
 ShbSEWGNmZld9Si4AfgZAYUjDxO+ZvUyTw9SMuo1/KOh/EMm43QqXJ/Fg+njEagyd90IDwrfm+2
 7j1dG8Mku0vmdsmk=
X-Received: by 2002:a05:6000:1865:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-4a638bd6badmr5586622f8f.11.1795003723550; 
 Wed, 18 Nov 2026 04:08:43 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4a65560882asm4774987f8f.27.2026.11.18.04.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:43 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Yongbang Shi <shiyongbang@huawei.com>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 7/9] drm: Use an empty initializer as pci_device_id array
 terminator
Date: Wed, 18 Nov 2026 13:08:14 +0100
Message-ID: <dc6562a484bbb7fe91d5d5c081ab86505eec9662.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1334;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=8gR79g7fiC68voxSNKR3RR0KczXakdzvIV8MeFQvtn4=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZU47cToFxrVACTYLmaod/+jUC3yHiJb1f5ZM
 9OFjPNDfKqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VOAAKCRCPgPtYfRL+
 Ti7HB/0WB8bTRddWPanDvCE7i75M5DEgfWFUdTYhqVB9jXxq1UCgo/BW05vioYOQokw5/ps70Bs
 DTI2DyUlwp6I9NvhTz/ia4m7YNbEjngMT/EPfXA6Kc5DgfiCwJLBOd5Ico0qed+pC3juf4SZa9R
 usp0HXL3ekiTRstFhQsvsngIJB0EaSOdOPT6c58UGnKeQSaGyF1FaT/f7bsMl7Aq+Cs7BG5Wmie
 bUKu7fyKs33R6tfGURnu4wv3PIRTP532skB5vEntmW3/ctkgbrPu3AenUHvmYy57LEe6V9Oo+Iu
 d8pa4LIl2JWkPY/faOfHDKgWJQTmHV0r35brWmrEZTGhVv2y
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rely on the default initialisation provided by the compiler instead of
explicitly assigning zeros.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/ast/ast_drv.c                   | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index ba6cf5fa901c..effe289a6921 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -186,7 +186,7 @@ static const struct drm_driver ast_driver = {
 static const struct pci_device_id ast_pciidlist[] = {
 	AST_VGA_DEVICE(PCI_CHIP_AST2000, NULL),
 	AST_VGA_DEVICE(PCI_CHIP_AST2100, NULL),
-	{0, 0, 0},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, ast_pciidlist);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 602930964e93..b80f1d4e83b4 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -491,7 +491,7 @@ static void hibmc_pci_shutdown(struct pci_dev *pdev)
 
 static const struct pci_device_id hibmc_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, 0x1711) },
-	{0,}
+	{ }
 };
 
 static struct pci_driver hibmc_pci_driver = {
-- 
2.56.0.rc1

