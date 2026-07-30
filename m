Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E6EC5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 707A310F023;
	Thu, 30 Jul 2026 18:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="f5sSIxL/";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EA8F10F023
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 18:27:12 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso148106b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1785436032; x=1786040832; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFQ1vlo/U5kPhUKDIkSFcUBW9GP6124E7pQ5VM7OJ4I=;
 b=f5sSIxL/HTPHQmDJkIER6BdAmltAJmPZg4HbCVyw+H4+6KyljSVSQQLgfer+1P1GuF
 mGFgo/5rztqsneWVL+ZXrKhBtdkU0EYV+IcOfbWVm8g7G73ammoC5A9PFajFcuHP9u8K
 skUIY+z+4hZqnhs3v1yJcZKT0E/EzU+fPbQxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436032; x=1786040832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XFQ1vlo/U5kPhUKDIkSFcUBW9GP6124E7pQ5VM7OJ4I=;
 b=U6yU1BB4ioLl9fdQG0ZxZ43eMnT7HldhLkMz5tpQom9IO1HZw2ZRh0AyDBZ7bFuzQ3
 M04H3nAz/cZwHLw4zO9iomeIQORGP6aVaOJZ2U2QkIumd7m7dxXTmhItGTbViRHvMw7H
 y5Peo6Q4FFNmm9QVohs6YQR8Hbt/EmLQJaLMWHyzHZAkFQ1ur5TB8edPVLbgKoKLNYl6
 ddeOFhywpUgT5EgXvywUwEMk+CxAQokOPLBnW7nEgREdcysQHVkBtZmxniqA5E933cKY
 c+neOf2juuyObzbbqeWiJLvLM2x0sXlA5pEvzO1oXdo21HR4AUjqgfugGyoHYMW2yS3r
 Q7FQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvNST3IzTmaPJVv5qQJHB9di93S0SOiNf93iQWWj/4PzudrppY8Gn9hfORosijMrszxhd7g7o9Oa0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvWemb/yPsBEPn+hNAJ+SBJJWd+6Q11kDkbrAJ+BVupczw7EWX
 1rQ2z208q162rZwxvJrSHKumxoVPg8pvYdTDPnlx9H1OtmiNbJVviVmwJKzL6oOSChA=
X-Gm-Gg: AR+sD10vZ8CFMYvE1zARssHecIDQgyBolsbg7uSRlWBeONNGUI7FuQIla5vmUE77N0e
 c33GmbqD/qTVp6DcV4CQIm6OjSWHJQxjoz/rwn2hG8A0iMKg0eZ6g2y61NnM0jmrYcz5Kvv1vO2
 6ruzK+WmbzBJp04ThyoEtIYDYUtnSuw7Gh6Hmmc/d5uBUjkFxe5qABpMpMFYLguL9IAJdxiosFK
 uJ659jxRs4+kBVv9uvGodTVNfN9qWEWl9rICDeFrZ4vQ95vqMppPJIsXHTWNtEf7Mo/Wx8lRRE6
 ztUO1vNoibRyWdV18HPEPOVk7iLOWyir5YhJipG92F1g+amM3pEZMtSgbRRq17at6nUeFPLf61G
 n9LySwYZluzIcNdo+AthWrlywqpuHbavojPpBmvbTpthOCoKj2QpnrOZtyd9UjZQPVr+/UTdFFc
 SUJ+S+5cB0lQSwaJqYMVpJUZoS8vD0emhpkle4gA+/tnQLtiHRAcU=
X-Received: by 2002:a05:6a00:1391:b0:847:8b1d:230d with SMTP id
 d2e1a72fcca58-84ebc1f5bb4mr3620610b3a.3.1785436031780; 
 Thu, 30 Jul 2026 11:27:11 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:27:10 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 5/5] fbdev: tdfxfb: Program the initial video mode
Date: Fri, 31 Jul 2026 03:26:40 +0900
Message-ID: <20260730182640.2808572-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
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

If the card does not get bound to by fbcon set_par() never happens
and the initial video mode is not setup and the display detects
no signal.

Program the video mode and also clear the framebuffer memory so
random garbage isn't displayed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 9d55efd2c934..d03cb47b34a5 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1692,6 +1692,13 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * Our driver data
 	 */
 	pci_set_drvdata(pdev, info);
+
+	/* Program a video mode so the display detects a signal */
+	tdfxfb_set_par(info);
+
+	/* Don't scare the user with random garbage on their display */
+	memset_io(info->screen_base, 0, info->fix.smem_len);
+
 	return 0;
 
 out_err_iobase:
-- 
2.53.0

