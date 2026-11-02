Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001D6606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rs4J3X+1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA8910E531;
	Mon,  2 Nov 2026 04:32:38 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F7710E00C
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:31 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36a2551d7b5so4588611eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593950; x=1794198750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DlXdMLkjEmJpYFky7r1GU2us5l+hwiPBAYsVgOOCBHI=;
 b=rs4J3X+1IBYRzl71QripSyFL4GuPOMdJ9kerCGse00sZdieYFufetHS+YoJ7aYGOL6
 mZQQWX3HP8/IrRzyPQlzkxvVkqdQS9bbU3XZvvrZ+VvuetnemWns/603mgVwc4uFgA5c
 qcc3pSAeGFgCjsgD/A62cdVnPDQtCgpxfh+r2I53wf3W+pyiI4imfRNv8diksrtYd00n
 ZsdoOra2azKpxVNGyA4DBQvtXAoNKjFLIwHpbyb4mq/TllHn5hB1BIOxluuOK/5FFHhX
 J+eGtzdGEJWTsACxcgpq5JvEe6s0AY3HaihmQXuLWPSWbNBuHd+Er0NfA3112huElZCA
 Utkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593950; x=1794198750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DlXdMLkjEmJpYFky7r1GU2us5l+hwiPBAYsVgOOCBHI=;
 b=Ums+6dJcCnFIriDY5x9Qf3Xx6stF3IsAzNapIaMjG1A0OPZMqITs1pr7QdKaQjwaJT
 +Ar2iEEMcrZK17JCTljK4oOHlR00vMsRVfN24y9FfSjxju8/dYyJhpKlpSUoEXF8pq3P
 7OMdSSNf+xh8JDmlU13ghZ+0gmZfi8mgBjbYKq8yeim6XdvryMf4kVst7SKl2eACiCIZ
 3wywzajuF6WwTe9kHFv1fPuZ4IYgsONhmlWW5IRC5d8w4RNZ+UEFHQTiG6JYW2ZAY0cv
 0BTuK9yK/GwQe6nDud3wClSE3pfi2FgsFmuKo9eTv6qwbM0Rue2uC79u/J6FImi3Z1mo
 UT8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1Eh+LqtFnR/bfCbSEFjliMf6yV+w4tnZot/zUlvGQBXS7T1gm1jsbZteo9F00D9FBWVT4mSED87I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8QgX7d2kR1ATPhXYXjp/5hNb7+SHySOS21y/kNmCz0Zm2jZ3Lo
 eJsOeNQesCDVMs38OhV3kP+ohMBf5aiD9q94Z27KS3FHTlKAGHI8JX0B
X-Gm-Gg: AYBFou3LSzCqrwKd5rqnLJssGkYk4gsIPjo3ZYQzEZJks0ew6BrTqjrtYSK4hlrOyR5
 5I3IHD6Hb7sS/MLGYcPD7/wt3PQhxw8kZFm5Navp50wk5wAdI8p0exsCLfBunBcV1xyRueKgUUE
 253e21YUt7vMj+QCyEIbAiLcRBWGQhO0CmQNfrXzoCrltmGHJYdTWuvvbECZAtzMVAqrnL0Yv+G
 3qIO1P1jPPLDL2BcOVJOU2pTS3l8Gjf8SOBnFK2iEV5O4FnqEzFV5NyiDpVH5K9VlQMN0QY/SDt
 ORDOTJql6/XTskgKZDOg+BzBMuVdPt6Mo/FOkxhiQyJj2xW/z8DiBG8+bPtEewGzDS3bhTTtoD9
 CpXWxdWLMhWV4Elh+MKYj8uxVlk0M3xWC3ZgocenV8v0vEtPePjZVfqN2CjOUTlqdTCL4tm9gfx
 LEhIkNAiJxD4+7582+zFt41+Xm+lBciqsjYy4jifmde5fzBLnsBIYCLkIC6jzFn5GlVPVEnawFL
 s807O1lwElq9XzNas24GAbZljssZZeF62n1srh3wGGcATIrG9A9LzxAf3hoViElt7H9GzhwOvYS
 n575NnOdiokB56Y6d9xJpy00GltpKLpBbnDMPYCG5dCwUSaC9xCogii6op+7A+1VQbRdIjtxhV7
 XFoYe9CzjHh+14qhm6f0rB899AnkzKZUBnwaAU5lIRFIPV+7PKElbOZqkKrXlGA==
X-Received: by 2002:a05:693c:415a:10b0:36a:647b:2d7a with SMTP id
 5a478bee46e88-36a647b3661mr4922339eec.0.1793593950041; 
 Sun, 01 Nov 2026 20:32:30 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:29 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>,
 Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/5] drm/panel: raydium-rm68200: Fix prepare error cleanup
Date: Mon,  2 Nov 2026 12:32:12 +0800
Message-ID: <20261102043215.990351-3-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102043215.990351-1-hungen3108@gmail.com>
References: <20261102043215.990351-1-hungen3108@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rm68200_prepare() returns without disabling the supply regulator if
EXIT_SLEEP_MODE or SET_DISPLAY_ON fails. Since drm_panel_prepare() does
not mark the panel as prepared on failure, drm_panel_unprepare() does
not call the driver's unprepare() callback, leaving the regulator
enable count elevated even after subsequent successful
prepare/unprepare cycles.

On failure, restore the reset GPIO to its unprepared state, following
the existing reset sequence in unprepare(), and disable the supply
regulator before returning the original error.

Fixes: 2b7ed18bed1a ("drm/panel: Add support for Raydium RM68200 panel driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-171393@kernel.org
Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    In this patch, rm68200_init_sequence() still returns void and only
    logs DCS write failures. These failures do not cause prepare() to
    return early. A later patch in this series will propagate
    initialization errors through prepare(), where this cleanup path
    will also handle them.
    
    The error path does not send SET_DISPLAY_OFF or ENTER_SLEEP_MODE,
    as DCS communication may already have failed. Instead, it follows
    the existing reset and regulator shutdown sequence in unprepare().

 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931903..3a59eb00274d 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -277,17 +277,26 @@ static int rm68200_prepare(struct drm_panel *panel)
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret)
-		return ret;
+		goto assert_reset;
 
 	msleep(125);
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret)
-		return ret;
+		goto assert_reset;
 
 	msleep(20);
 
 	return 0;
+
+assert_reset:
+	if (ctx->reset_gpio) {
+		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+		msleep(20);
+	}
+	/* Balance the regulator enable count on prepare failure. */
+	regulator_disable(ctx->supply);
+	return ret;
 }
 
 static int rm68200_get_modes(struct drm_panel *panel,
-- 
2.43.0

