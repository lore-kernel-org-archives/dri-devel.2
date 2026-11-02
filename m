Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE6606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 04:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8TKQVGg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ECBD10E52C;
	Mon,  2 Nov 2026 04:32:34 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABF810E50D
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 04:32:28 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-36a1947498bso302654eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793593947; x=1794198747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N4/DN4JjGSFdmF5hzcGibgD4U5xzUUUKSaINBRUdmcc=;
 b=R8TKQVGgo9XKTspeKd9Tc20tILZPu41m71zH6ovCZJJ5lHupbgvMkkUoT517wEktSp
 XXCj1lMgRTc/Pd/rMl6mSj06bjgPfzteEdtmKjz+TY5p7uBRIQG7W5LCzpJVT+XTtjbT
 lltDjvWsAsIgiLRCxMQy60VVAvtR5AGs25QZOWebc+2tD0IaAcUC8YNQ/FT85Btb3xer
 Mx9jYPMjZG/Z9kitzTL8/K9xtOwhu7fQJVvcIgMm4CvLjJi8DEqzIgHbDmFZVNYYJSD9
 kj/Qlo99NpH+tJ8OoMTDXrN0P1ZHqCZr9wOWygb2Z1cwOLyRAhMk9AAf//5Hn08r7inY
 55yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793593947; x=1794198747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N4/DN4JjGSFdmF5hzcGibgD4U5xzUUUKSaINBRUdmcc=;
 b=SsctzXfeCNXvomceJeKZP2/YS4L2pWz21sL5q36wdLnDKfIldZwq12EAp+vmhcThxA
 Zj5bTx+7PKwAfh2tRVlimyoJZMcmGba7oLsKM4wNhb8Ow6XmrJkduvtOUDaL6TloS3k/
 jZrC3bPrK+bZhTDn9nns+JlipDml70PcHebDmRVAzBWuXuOuZCa47/PVD4doFQgJZv6Z
 0dY0VvNIPvQYM3GVuq6OOXrf5Ukdr/4dc+73hsR62vUWPlVoBqo4Wv/SdiPMDPiwZtSr
 /PZi/fVcUcwSEg0xzUMuwDNNSQCixu0PpV2h+I2NXq9q+qo3xDNCVoEIjzoocCuZmhCe
 /SrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuLgpnbnfsz3gBo4UXjqKUQS/lbO7oioNyYVZks1GRFXcyns1W1ssFt5T6IAynFS6U8GkRyqnhD+A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/3oCazAd25nStDj9sxQnp+9+D07Xme4T3P3nfBHAs5K37xNIiW
 PKmOrJgBKCLg8PoKJVJjmMS6ov93xuknyW+SL8613sGZUl9Y42MSYRUs
X-Gm-Gg: AYBFou0VxL2oKqKj3+FR/sb8PUGlfIbo8iqGaxzbHW0rBzjRSEBXR4RNPDhKBq/z8BU
 0xgu72IFzU33UFrrrkbz5qcbkqJQgMrFaTmg2YndprAqjlk0dqTomurXxVSBiZ6KfMaUPIaCT7I
 ygEMzIRM0suXSMx6OPYOjjVqXYjZCtVJE2WHfIdjInFHQnpIk15kju+UEwGUiEy9XqHy6lNYpa+
 mb6yKfjQiHELCdOk0q9DY4IHlzRa8QnnZHGF2eQXFJlWtchsCt7rZVVIxn4qg48Y+PLH0eUujsK
 CcfUp4ckZkLQa74aOXh1CfGxj5bBhr1EeRY8oFFxQkxcYm3SSqfT3cariuvaoKxhpLR61FwDx0f
 L29b4WnsuueK0Ol7mRjV99LfjUylQA3KHPMI2jdx7snFf40sPIh4WNQa+lHE9dNLU9hMz6Nk0RV
 3liPeRoYqNT/4uMa0NvKjbt4W5mzzgqOgjC6v7KFlQ+OpqfyzWMDISknaQEi3jIAvtIEHVutL/B
 b8FnvUkVoE4GdsY7LXaTMa2gOLH52ulSKcabPMMET3BxWnPE3IBr0l3YjK+QPLs2Uhv3HkODOcA
 CAmup7DfTlKS2qv9jY/myXxtXTsKOezfc1N8yqM0A41yAx5tVdS8yD9Iwq4hm07Tkh1iRzApzRD
 P7k7OvpmMv1xDxjlQhoaO1hy+NjItiC7KzWgLVkLv/9YvxtXYEkTvukQFVP0Y
X-Received: by 2002:a05:693c:8806:10b0:369:f97f:72c1 with SMTP id
 5a478bee46e88-36a4241bbd5mr14639941eec.36.1793593947131; 
 Sun, 01 Nov 2026 20:32:27 -0800 (PST)
Received: from NB150512.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a77c0dsm38581063eec.26.2026.11.01.20.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 20:32:26 -0800 (PST)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH v2 1/5] drm/panel: feiyang-fy07024di26a30d: Fix prepare error
 cleanup
Date: Mon,  2 Nov 2026 12:32:11 +0800
Message-ID: <20261102043215.990351-2-hungen3108@gmail.com>
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

feiyang_prepare() returns without disabling previously enabled
regulators if enabling AVDD or writing DCS commands fails. Since
drm_panel_prepare() does not mark the panel as prepared on failure,
drm_panel_unprepare() does not call the driver's unprepare() callback,
leaving regulator enable counts elevated even after subsequent
successful prepare/unprepare cycles.

Disable DVDD if enabling AVDD fails. On a DCS write failure, restore
the reset GPIO to its unprepared state and disable both regulators,
preserving the existing 10 ms power-off interval between AVDD and DVDD.

Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel")
Reported-by: Douglas Anderson <dianders@chromium.org>
Closes: https://lore.kernel.org/r/CAD=FV=Xm48DUT==8HuuGCSFZtLTEk-W2Q6UTfqt-MnM4nULzTw@mail.gmail.com
Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Power sequencing note:
    
    The error path retains the 10 ms AVDD-to-DVDD shutdown interval
    used by unprepare().
    
    The FY07024DI26A30-D datasheet, Section 7.3 (Power, Signal sequence),
    specifies T10 > 0 between AVDD/VGL reaching GND and DVDD starting
    to fall. The delay allows time for AVDD to discharge before disabling
    DVDD, but compliance with T10 has not been verified on hardware.
    
    The existing unprepare() comment associates the delay with T11,
    which actually specifies the DVDD fall time (0 < T11 <= 10 ms).
    That comment can be corrected separately.
    
    The msleep(10) checkpatch warning is expected. T10 has no specified
    upper bound, so a longer sleep does not violate that timing constraint.
    msleep() is retained to match the existing unprepare() sequence.
    
    Datasheet:
    https://files.pine64.org/doc/datasheet/pine64/FY07024DI26A30-D_feiyang_LCD_panel.pdf

 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index c1d8ca5ca6e1..bb4cc1ea2ece 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -59,7 +59,7 @@ static int feiyang_prepare(struct drm_panel *panel)
 
 	ret = regulator_enable(ctx->avdd);
 	if (ret)
-		return ret;
+		goto disable_dvdd;
 
 	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
 	msleep(20);
@@ -84,10 +84,21 @@ static int feiyang_prepare(struct drm_panel *panel)
 		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data,
 						FEIYANG_INIT_CMD_LEN);
 		if (ret < 0)
-			return ret;
+			goto assert_reset;
 	}
 
 	return 0;
+
+assert_reset:
+	gpiod_set_value(ctx->reset, 0);
+	regulator_disable(ctx->avdd);
+
+	/* Preserve the AVDD-to-DVDD shutdown delay from unprepare(). */
+	msleep(10);
+
+disable_dvdd:
+	regulator_disable(ctx->dvdd);
+	return ret;
 }
 
 static int feiyang_enable(struct drm_panel *panel)
-- 
2.43.0

