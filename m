Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E37606D82E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860AB1128F1;
	Fri,  6 Nov 2026 09:34:46 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0049010E3B5
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:34:43 +0000 (UTC)
Received: from [172.100.0.8] (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAB3hJUqn+1qZ3ZrAA--.6348S2;
 Fri, 06 Nov 2026 17:34:35 +0800 (CST)
Subject: [PATCH v2] drm/tidss: Fix serial clock reference leak in
 tidss_oldi_init()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Date: Fri, 06 Nov 2026 09:34:44 -0000
Message-ID: <179395768470.2284859.2950332168774127628@iscas.ac.cn>
In-Reply-To: <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
References: <20260916182950.2092071-1-vulab@iscas.ac.cn>
 <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: rQCowAB3hJUqn+1qZ3ZrAA--.6348S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18uw4kCr17JFyUZF1DKFg_yoW8Kw4fpF
 4UGrsFqF95JFW8Kw47Aw4UXFyj93ZFyFyrKFWvkwsa9r1Yqr1aqFnrta48WFWqvrZYya1j
 9r95X3Z2gr1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
 0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7
 v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_
 Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxV
 CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
 6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
 WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0
 rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJV
 WxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU5o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgADA2rtkzgtFwAAsQ
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From 55466ce37d710051279174f70d4f2f89af161636 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Fri, 6 Nov 2026 08:58:25 +0000
Subject: [PATCH v2] drm/tidss: Fix serial clock reference leak in
 tidss_oldi_init()

The reference to the OLDI serial clock taken with of_clk_get_by_name()
is kept in the OLDI bridge structure for the whole driver lifetime, but
it is never released.

On driver unbind, tidss_oldi_deinit() removes the bridges without
dropping that reference. The situation is worse when the OLDI
initialisation fails for a second transmitter: tidss_oldi_init() returns
an error and tidss_oldi_deinit() is not called at all, so the reference
taken for the first transmitter leaks too.

Use devm_get_clk_from_child() instead, which is of_clk_get_by_name()
with a device managed reference. The clock is then released when the
driver is unbound, or when probe fails.

The candidate issue was found with static analysis tools.
DeepSeek-V4.1-Flash and GPT-6.1 Sol were used to help audit the error
paths and to prepare this change; the result was reviewed manually
before submission.

Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
Cc: stable@vger.kernel.org
Reported-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Closes: https://lore.kernel.org/r/59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Use devm_get_clk_from_child() instead of adding a clk_put() to
  tidss_oldi_deinit(), so that the clock reference is also released when
  tidss_oldi_init() fails for a later OLDI transmitter.
- Apologies for the very late reply.

 drivers/gpu/drm/tidss/tidss_oldi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 5eb749f495d5..485e9f862fb6 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -586,7 +586,8 @@ int tidss_oldi_init(struct tidss_device *tidss)
 				goto err_put_node;
 			}
 
-			oldi->serial = of_clk_get_by_name(child, "serial");
+			oldi->serial = devm_get_clk_from_child(tidss->dev, child,
+							       "serial");
 			if (IS_ERR(oldi->serial)) {
 				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
 						    "OLDI%u: Failed to get serial clock.\n",

