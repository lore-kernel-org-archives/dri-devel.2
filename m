Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C3606A332
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pimMMLzh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A03410EA14;
	Sat,  7 Nov 2026 14:27:56 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBC310F807
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 12:07:16 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-33c10faf6easo73914eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 04:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793966836; x=1794571636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vki/0J58gJY9s6b7lYTU3pm2Hogb/GLKqW+2hrl5trE=;
 b=pimMMLzhsVu/WHUfbJMok5Us6xGUGKuDrdBZTyYoco39q8CGtJDIZ+vk6pERFs1Bhr
 sLTJYgtRO3xQOCldyOx/yyfL41XGytyyQ3DfZ5+bwOTuSjBn4/lwoG0+yBU8Hmf4++gw
 zpCIc9EWxbIOr8Yi2sjFMLyhb005HOlMJ/TVdOQDqOSrXqVIO/mLVmA16GlaAfuKrpMD
 hkudKxLmpcR5vs8yj1yHxvzZE8+qomvC2kRkIcnX2HlU5uodJkHnJfePIx4QRZzq95f/
 Aeu2MBfkf1jH/1g9bmeknLXHNH4hFevTWRBes0+wwZwbPG//te29gMZo80HKPcLBCC+q
 LprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793966836; x=1794571636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vki/0J58gJY9s6b7lYTU3pm2Hogb/GLKqW+2hrl5trE=;
 b=zvzV33sxRYHZtqdlLCJ9brQqHv39uvFyATrBxNIwn735x0y7I0KPB58WMnBYwlWldY
 u0NBksQylxjuK/027M7vGXLa4v/oNWVoH36/mPEf+7Aznv1bQ9QXjSx5zd3gKddzFZRm
 iF2a+qsHst+qxurmulS7DYvcXO3H6I/n5aSw5CEP649AlaXnGiZIN6mvQ9Pu+kbc+hPC
 epOw4OfaZleWjwNpAILeXsQ3FInClhv522MudXt8SYqXZDtW5UzW6GZk34m7l/QEgZbd
 jPyPl/VnSfXNy8dbTRhf7KEFTnsONJwZbbR4kqEl4GcrrzTQf7s2Qs2skZj7CZ4PcQW3
 8veA==
X-Gm-Message-State: APuU4Z+T+XVyx5L8El0PpYc7MCJDR5QwDxIV1uUPkaFjmrcy/HdWGr1C
 U8nn0pe6z+2Qm5qb+ZJl9F55Eii7GOYIgyfirN8N+oN7ZC3PdeeSyWCIAkDuObSI
X-Gm-Gg: AYBFou3MQdcSNhXwj5IiAsyGMp8Or/M66vUTpCNUmGrvfwUhfdmwasRR4oDE7lG8i26
 yAFZTJkvsoylcegtGjpOdrZ0V2d/Tf4jaHERBQF9SMhkjt7X1mGup/DwgnyCX7heOk3HlWOOfLT
 ytN3HnMr6l9fqgUVrgOEmPNpSK3iCZflnTKopKIhwrQHd1Iv+DmIa6UhjWiHwG6Ah9lMUK9h7gB
 i9XsK7wjrZ8R03lgktaVeIM8yJ0i3cTmHeiD7NZcOeqamIxUUTcHCORDJNouL/i0SV87O8myPi1
 V+1qMclm0SQDNpGZA7lwYwl22kGqX8Qg9aiu7JgXwxNu9IvuDCut5abcRuNX0rP/ffuFgXb+kYT
 kRqFkdGIML7ExO9+vDGoPCxhTPv1q8t9Xa3ajXkHK+l/xDfJuaa6hWTIEljDbm6KSM0PQlQ4X0z
 x8bdgm2oUxGiiaXQJHf7MunnoL3leE1vFQjbzceI/Dxs/9zsp7G34yFPCYi/GMmwcc3WCoA8s4f
 Qs6yNGjbMPXn12rKgPOuUWXanQKhOYI80Hg1eI4x6REVWNc1B5jdMi4xouUWZmj44sPCqYvA/jk
 MENQjq3JIOp75APmnKTcjaB8wZWZr2WBP92vqWn9CQ==
X-Received: by 2002:a05:701b:4585:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b25d2075ecmr4295827c88.0.1793966835410; 
 Fri, 06 Nov 2026 04:07:15 -0800 (PST)
Received: from localhost.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e407cd1sm5992200c88.3.2026.11.06.04.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:07:14 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: ogabbay@kernel.org, koby.elbaz@intel.com, konstantin.sinyuk@intel.com,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v3] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
Date: Fri,  6 Nov 2026 20:05:45 +0800
Message-Id: <20261106120545.2352844-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104095159.6487-1-lui2012qwq@gmail.com>
References: <20261104095159.6487-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:27:39 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hl_device_fini() uses flush_delayed_work() to drain
device_reset_work.reset_work, but a flush cannot stop the work from
being armed again afterwards, so the reset work can still fire while
or after the device is torn down.

Simply switching the flush to disable_delayed_work_sync() is not
enough: a reset retry sitting on its timer holds reset_info.in_reset,
and only the work itself clears it (via out_err once
device_fini_pending is set).  Killing the work without running it
strands in_reset, and hl_device_fini() then waits for the full
HL_HARD_RESET_MAX_TIMEOUT and returns without tearing the device
down.

So keep the flush first: with device_fini_pending set, a pending
retry runs immediately and clears in_reset via out_err.  Then, after
in_reset has been claimed for fini - so no new reset can be queued
and the reset thread does not re-arm - disable the work to guarantee
nothing is pending or running during the teardown.

Found by static analysis.

Fixes: adb51298fdc4 ("habanalabs: improve hard reset procedure")
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v3: add the Fixes trailer suggested by sashiko; no code change.
    
v2: keep the flush so a pending reset retry still runs and clears
    in_reset (sashiko review); the disable now happens after in_reset
    is claimed for fini, where no new reset can be queued and the
    reset thread does not re-arm.
    https://lore.kernel.org/r/20261104095159.6487-1-lui2012qwq@gmail.com

v1: https://lore.kernel.org/r/20261103163354.1599176-1-lui2012qwq@gmail.com

 drivers/accel/habanalabs/common/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 09b27bac3a31..c27c13e693d5 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2527,6 +2527,13 @@ void hl_device_fini(struct hl_device *hdev)
 		}
 	}
 
+	/*
+	 * in_reset is claimed now, so no new reset can be queued and the
+	 * reset thread does not re-arm with device_fini_pending set; make
+	 * sure no reset work is left pending or running during teardown.
+	 */
+	disable_delayed_work_sync(&hdev->device_reset_work.reset_work);
+
 	cancel_delayed_work_sync(&hdev->device_release_watchdog_work.reset_work);
 
 	/* Disable PCI access from device F/W so it won't send us additional
-- 
2.25.1

