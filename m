Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D372FCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA5B10E05D;
	Mon, 18 May 2026 07:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gceE5waf";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B83910E0B7
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 17:05:01 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so1815607a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779037500; x=1779642300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D6n/+RyCb939qAJyBNb0yYir20+X71GnlDVWuo/Eg5E=;
 b=gceE5wafnUj5KArV1h9KCNan2k4ug30ZpmE+cbzkBm36uTcr5mIs5yL47y6vmIJmCK
 2Syh2XlGoaBlIk2rEWjVKI78amv4dRfUbo2/VcnbKUxeMUO4jp6mWLYXU86S6F1v5emi
 vFJaSAfndpxlOxLeP4W04p2iQeLRUEpShp6sWkC1VcecN8AyfOcgJ5gXLd60hP1T/tto
 XENsIjLXrEPxRJJxo9cJRYkLaRYiIG43leavxkDoxdncAzlgpNhzPAbn5buKNqmZumSN
 w/9dYoH7jSDR3llhzxHbG4o4DZCzBn2PEap54Bp4e35seyfvWu0wxAKjqykQxOIdmFbp
 OSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779037500; x=1779642300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6n/+RyCb939qAJyBNb0yYir20+X71GnlDVWuo/Eg5E=;
 b=kzhNbFynWvVDBS7YJ1p+Xt9Iqxbt92RZNr9HWK1QwOoSdCVNZsQ3GFx29AkJE6y5jU
 zulYd50r/iXs0Q87xAm1b6aJE0LPSeaZdnpjSnQ5SQzZirpibMrWjgPjOx9puvZi3uJO
 Mv2p4d4aq7IUSEBSd0w27cAd9oOSA/BcEZvniMlwAk86mDRrAKbxrwRjkjC1dlutqF9u
 PjoK3SudT5rOdJVuhL3iRRPDZotPr3DHzlQzp29++Qeg41ECBCWG47Ou9ijf39RGDc4S
 hyu0lyV6WZBRlCjGiSS5p7dZd5uvVia/NJHjs01ZLe8DeEaDBA4p6TdgopNLbDWQWV1T
 UBrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gskPKS+Di+RYjp68Q57rfERCY0WV4Sz4ePyrn9wo948QPmYvoRnq91oQ4AsiqzekekrijEUFIPio=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9yCGIzBs/UKkZuPBiX+NGgJhESGPyCSBKM6KDRGq3dCEi1iJd
 vzKkfsC54CuhdJw0aCpip/PdChExxtgauTFpVk0CSxHJW+vgwmgOHbod
X-Gm-Gg: Acq92OGq3Gew93Y9cdY/QDjAx3FGoGzitxC2/3uKF2febZVks5x7mvK50UjAic0tq4+
 PSXqW+Tdqx7q8FOy18MEVlDMzHnfyoLaYEoZCMRUqzIcd13Bj5WDhZw647lwP4q7C00dtBy8hBC
 Ah8V8GNvGwxKbMc08lwHW8pA+YY9vK2ITY/Toysp3VPQNO5o9DM10oWtPkol+xBOz8zQ0LtKp/e
 OQ1mYPmf9msFXFckyebYpnC0LoB1t/pab6E18Ss9ynvtvyJjSx0hgWb4RAJZ39ZoWq0k1S1NtGm
 Eh6YpnZlc4IJLH/MvWXglV78wbxVOTooGALnBctISbSCXN3gE18FHdJTtI91r0kVI6lTl4E27ZN
 D4Pagx+dSGtqZYDcd6XDM58qe+OdFgSJWdB2WbpczFUKVOdPckttX5TCRkhmtBZIABvLnnR2IUh
 7uQjUOm1XB5HjVSlCnkMvYmKck04EZIXbfRPd9zHlTdS5ZbQ==
X-Received: by 2002:a9d:5381:0:b0:7dc:9908:6cba with SMTP id
 46e09a7af769-7e3f1024c53mr6941913a34.6.1779037500072; 
 Sun, 17 May 2026 10:05:00 -0700 (PDT)
Received: from MacMini.lan ([172.127.162.94]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bbd10aesm5924188a34.18.2026.05.17.10.04.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 17 May 2026 10:04:59 -0700 (PDT)
From: shayderrr <darknessshayder@gmail.com>
To: thierry.reding@gmail.com,
	cyndis@kapsi.fi
Cc: airlied@linux.ie, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 shayderrr <darknessshayder@gmail.com>
Subject: [PATCH] host1x: bus: Fix missing ops null check in error teardown
Date: Sun, 17 May 2026 12:04:56 -0500
Message-ID: <20260517170456.84927-1-darknessshayder@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

In host1x_device_init(), the error teardown paths do not check
client->ops before dereferencing it, unlike the forward init paths
which correctly guard with 'client->ops &&'. This can result in a
NULL pointer dereference if client->ops is NULL.

Fix by adding the missing client->ops check in both the teardown
and teardown_late labels.

Signed-off-by: shayderrr <darknessshayder@gmail.com>
---
 drivers/gpu/host1x/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index f814eb4941c0..43ce048de73a 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -221,7 +221,7 @@ int host1x_device_init(struct host1x_device *device)
 
 teardown:
 	list_for_each_entry_continue_reverse(client, &device->clients, list)
-		if (client->ops->exit)
+		if (client->ops && client->ops->exit)
 			client->ops->exit(client);
 
 	/* reset client to end of list for late teardown */
@@ -229,7 +229,7 @@ int host1x_device_init(struct host1x_device *device)
 
 teardown_late:
 	list_for_each_entry_continue_reverse(client, &device->clients, list)
-		if (client->ops->late_exit)
+		if (client->ops && client->ops->late_exit)
 			client->ops->late_exit(client);
 
 	mutex_unlock(&device->clients_lock);
-- 
2.50.1 (Apple Git-155)

