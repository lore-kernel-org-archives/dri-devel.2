Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B972606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeBdYYGU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42388112C52;
	Fri,  6 Nov 2026 09:18:54 +0000 (UTC)
Received: from mail-dl2-f1.google.com (mail-dl2-f1.google.com [74.125.229.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1129710FA93
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:10 +0000 (UTC)
Received: by mail-dl2-f1.google.com with SMTP id
 a92af1059eb24-181cbb6d0b5so2466c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793785929; x=1794390729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2zPH0c78vT+epvIgcKDA8jYHJ5WbJ3viLmvlO5ZklNw=;
 b=EeBdYYGU1OAOFLjb/L9NRIPanXnbFamhNOBv2k7QIeVtlBib2mtJdbtgvvMfGOzURk
 GXa1sOF7mKQMQu6Q1T9s7GW108PS3rqTcsie1DgmuAPSZorTXaZfdewHR/xv2fu75VT7
 suD8JxcdYXICsiv6RgZuzZbnrsHDEJQWkDoPimTzk3QNdLuO1iM07u9FfCuE4GQm2GH9
 WTvMca6UsSSE2Vc06LRiwxxwcyFW3FX6mD+B89CXt/D1FC1kOkLF62a3HxU7X17nmqt/
 SddJc5mTJSZnqo4xsZVOFILBlkP+NqNyX6vGDEUIeMQIpFRmDqP8vX0eF02js2jUAonz
 K6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785929; x=1794390729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2zPH0c78vT+epvIgcKDA8jYHJ5WbJ3viLmvlO5ZklNw=;
 b=ORKfyOa5xZATLShwGwM1Omlkk0a3W/cpdV7uYIitXVp6pE/2q/KiTc3TkpdCypi5Wz
 JkgPb7q/RiW6JC9qLdbiefxcjwUlJy/l2jNMFEH2Nmv2Qb0fW5yX0fXh0D7JPtQ9IBfn
 9AuFe8PHL31QGEAhwzxf3joaPv2iC26S9mnYIaYMNw50v1ngNUYrh13vGsFKrYE8vUIB
 TjzFwhq6d4x9Ld9bHc0rtERJqCbrawANuZLB8+/am3HJpxntDM9ZEP9SQLUmuvLGVp9j
 ZDlvOf2CSrr99852CB5awCLJiewEdm4Pj1WvoKF1cGAJZgv45VQKhNaxQlqZyRVNydix
 2u+w==
X-Gm-Message-State: APuU4Z/tGNcIAB61ue25xjVtKgPcgVgZoVwwFFxct2PUEmuLpfEJvA0Q
 gqdU4aa0AnKg3uQwkmhF55Oa77q949CPzDEEciZdBYFoqZDXflL9QQt2XwYPBEPCPA/MMw==
X-Gm-Gg: AYBFou2GssaHAW69fujU28IhX7QSS8OP2GlM4d5GiUdq0725eNfFocdSIZdOYiGYTLU
 tp8xnhO/hj/Mbm+qbttVw6sN8dFDp4P0fKAGEqO1OkfpJPmIlnCDUOsIOW3nh8GobOqQb2BDU96
 pjAaMAhOdnm/bP4H6bFWo11s6Wkaq+CLOgOMF0poha1aalPQbeSpcw/f50HRXh8L0OIB1QmnLN2
 mozNdpypRw/JbRHvW/GjSqoEPEgT57W88s3FPVLgWteYvNoitkTdhXJPMD4/mjUiHVTy1ScdfOg
 9aomvp87B/EEqmcttM6bJ0nvHityi2ZPCIhBEwsMhpSLgmXzdcJYahFlDpz7DU4c7773HDmETlu
 M7JWpF+GXsm6U5gKN9YoueDXg4FHsjkjg3UbpNJKmljDElbBvwg5PzCPzCg44Dkg62a++aunbZe
 39Rlzf1dUOV8igIXpKYVLcPtIq1n7j2jXLnXlArv2r2R5sQf66spxz/g+S8ssnvT+Fjzr/QZocz
 +Yyz7iBjwIUmnsgr7WdiJ9Bk+wGK0wE0mcV61ytUs0slTbdoKrl4zm3oOvu/82OcQOHS9Uv0SPx
 mu6vj/K+8C0TisS6IIcuwhTIk/i0HZDCm/3qxLOdpHAhZfVYY8aFjpjyycY7DzQ=
X-Received: by 2002:a05:701b:428f:10b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1ac4f91ef0emr38639933c88.0.1793785929157; 
 Wed, 04 Nov 2026 01:52:09 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c748eesm6239065c88.23.2026.11.04.01.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:52:08 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: koby.elbaz@intel.com, konstantin.sinyuk@intel.com, ogabbay@kernel.org,
 Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
Date: Wed,  4 Nov 2026 17:51:59 +0800
Message-Id: <20261104095159.6487-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103163354.1599176-1-lui2012qwq@gmail.com>
References: <20261103163354.1599176-1-lui2012qwq@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
being armed again afterwards, so the reset work can still fire while -
or after - the device is torn down.

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

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v2: keep the flush so a pending reset retry still runs and clears
    in_reset (sashiko review); the disable now happens after in_reset
    is claimed for fini, where no new reset can be queued and the
    reset thread does not re-arm.

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

