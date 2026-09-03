Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1FC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF1C10F49E;
	Thu,  3 Sep 2026 09:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zylaj5uB";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2C710F49E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:39:04 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DDEE1CF5;
 Thu,  3 Sep 2026 11:37:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788428251;
 bh=/XrhpQhgML/patl5tvbJhQokPqoO8e00UtkhqEtUdV8=;
 h=From:Date:Subject:To:Cc:From;
 b=Zylaj5uBmDePLy13C8G3W4nWg8Yf8O9V7PQfINx4dcm0+A0MTyujbIJOLxDKXMn8n
 O0pCWn5V7P10WCxkYbXAQNKTXn8LMkLiPTHok24iA+yxWdogPEpHlKB/aKagc97d1x
 mDU8LNrEWsvqC5xA1wkMOPCPuD/p6fiYkFPC4Uo0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 12:38:40 +0300
Subject: [PATCH] ASoC: ti: omap-hdmi: Fix build error from a merge commit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260903-omap-hdmi-fix-v1-1-b0447a1d35d5@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAB9AmWoC/yXM3QpAQBCG4VvRHJsaK7+3IgfsDkb5aRcpuXeLw
 +er773AsRV2UAYXWD7EyTJ7RGEAemjmnlGMNyhSKRUU4zI1Kw5mEuzkxKyjPGEVtRnl4D+rZT9
 /var+7fZ2ZL29EbjvB83f6r9xAAAA
X-Change-ID: 20260903-omap-hdmi-fix-7f085e21b708
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/XrhpQhgML/patl5tvbJhQokPqoO8e00UtkhqEtUdV8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmUAxLId3anRmnRy1ht1FIJ8xxfMn0whluUd7v
 veFq4f04wKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaplAMQAKCRD6PaqMvJYe
 9UvbD/9K5VxOI1QWJZ9kSRAwaGRKwHIwjvZscILiy9KJ/3Ab1TM6Hz3vCQoc0VU5g3XqZaDUk2O
 km7TptwQIRyz0NQLHslwEmHVFiNbfW++i2cWqZupvK/deMNy+VNox2gdda7PWTahgCB9hQL10+w
 JIabGzwzkEuLctrQd97S3T9nCHD893FTDp3ZBnoKzETwxvtKirD0sTLSMTyhcoa5eOXQSKFXnCq
 LaU7CAhxryaroZQHEIbX9Af0j+cGSG2VT+U5Ksce64YFIB2OAS5dBAraiMjk5iircoE2Nw8RHBs
 9VjYyTTji3rNow13D1lXEENogOuzVFqbb5pEbzO0ZUytUCV1APcnjReJ/80lpabhg7n2B0w6FDu
 rMut6n4F2R3LQI0VVw82rebxd8h7LHFMtfLwZd4CSMDev6281ufnPfh0R//gVnr8npJVi1BVHLa
 W0kZaKiuN6bsmnAKX8+cmYBXE1BVJ9wJFDuj2ad5kpHgllc8w9dqUv7MXd+eN0ZrJ85pzmk/C4g
 /4DsLRtsmynvYbkNp+aU8tgibyG1tHZGH40/lh0rj7gHZzsMb+XtXZ4PjIudH3tXXMXzznW+lUh
 DP3V/dOyk2NZeIMZlY8Nc9UgIExZA9F/y16AF6w8qFrett4f1div4+vMfWAP1t2F+f0YC6Yi/g+
 t/I3hqPhTua/zmA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

'ad->card' was removed in commit 9af2c1d4f847 ("ASoC: ti: omap-hdmi:
remove unused *card"), but commit 699e5975e2a5 ("drm/omap: Report HDMI
hotplug events to the ASoC HDMI codec") moved that code line. These
commits were applied to different trees, and the merge was not quite
right: assignment to 'ad->card' from the latter commit was left in the
file, causing:

sound/soc/ti/omap-hdmi.c:408:11: error: ‘struct hdmi_audio_data’ has no member named ‘card’

Fix the issue by removing the line.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/apbbvQSfUbzYRFaw@sirena.org.uk/
Fixes: 1ae7fe832c2d ("Merge drm/drm-next into drm-misc-next")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 sound/soc/ti/omap-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/ti/omap-hdmi.c b/sound/soc/ti/omap-hdmi.c
index c32ec7c0b0cf..2cabd4cc5b0b 100644
--- a/sound/soc/ti/omap-hdmi.c
+++ b/sound/soc/ti/omap-hdmi.c
@@ -405,7 +405,6 @@ static int omap_hdmi_audio_probe(struct platform_device *pdev)
 	card->dev = dev;
 
 	atomic_set(&ad->jack_state, -1);
-	ad->card = card;
 
 	snd_soc_card_set_drvdata(card, ad);
 	ret = devm_snd_soc_register_card(dev, card);

---
base-commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1
change-id: 20260903-omap-hdmi-fix-7f085e21b708

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

