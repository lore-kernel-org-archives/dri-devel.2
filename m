Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00548CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B40610E61E;
	Mon, 15 Jun 2026 20:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVOgcuNS";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BB6D10E61E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:18:06 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c8629bed4e7so2705491a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781554686; x=1782159486; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZBqFtiSeOSQRIEswK+IwUUFhan45ti0foUrddU+Y3VQ=;
 b=dVOgcuNSFSRax/Cg+wXgHYnVUu3lEYVBzfud/ODKjyf9NBfn4eh7T/izsWwTNC+fMb
 54ljDshJ5F2GwUX3Sbktmeb50jvih8KpoKp+swxOvdwaapZrfABcEYNfVep0AUk5pgnS
 mmeZf4ZjVOYMju4fh9K6PnNhSkpqdvRuFD4YE9bMHWaijCAIB0dsrzY/hhl6Ne50A8lL
 dd6iku9FRSRTefWA5JCPWl7DdP3Dcf0KrTm9PZ0ptyyDH0av+a/mH9V9sPJkN0jNQ6D4
 Lba8WN6UQal/bCwbnNfO36oOOixuxny5XyFUdBEBYtgO8RVdLIETMMIL1orT0QA4T6wc
 Gaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554686; x=1782159486;
 h=mime-version:content-transfer-encoding:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBqFtiSeOSQRIEswK+IwUUFhan45ti0foUrddU+Y3VQ=;
 b=fXgJmxIfKq4J+DQEWpFmI2gpnSfKV8mcc/Ol7i6u0gJ1rZoOH9fxDllKs/zFiKgfzB
 1cJiCwW/iaRY5sopVfxt4xWrS7qmeh11SB7Gtizd9FFhXk8F+1SAAmazVL6rxiwvEpRH
 U0KF/yls8mHG5pOzn30QyTwJ2+D+hJ/kzGnLp2GN7u8V0Mqs5u7oAKkN45Fl+UP3kMsc
 hxofIYujBS5TXYU//qaE4U4T/eoIyq5wdxfej17jYvbqhFrHWUC6hDPf5BGs3npRaLV+
 ipqn8E2+HhlvsPcvAiozOXWVqo0ryYQt0+z3BWoPKO4pZ2gkkQJX9mbgxXEW3EreALpw
 m/3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+aDPV/KYDOnsfxQLHQ/pwOT8lRdpuQ+E+oE9PbQyWoQxJQEAeB3DfP6Ku7K/h8oLpcIow0H+qM2Ws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwCbuD4gBfMitfH2BbUHHzGRTucdAsnH9Ws6jTk0FdqCR+gX/j
 wOIlDYulcR+34Cua4LUyg8kuBFBs1jbCpq8nYGm7Vsyv1lmRl2WntELj
X-Gm-Gg: Acq92OFSE4vKjmk3lKtXmkTfaAfaQIiFRvvhX/VE99ddSv6HRzDuDR5HTe224RLIxWq
 a/dy0ENcqwYj9it5kbTE6wQewVksq2mZRZ6xe4ggCqeErfw+oNJHaUFPwcOGer/pQs7CadjqfpU
 vmaWSKj69VXx+GcWHtHHqlEGCLMDtdisYj+57ea/qJUXpFQgiIunUgNW11P9SMtP9L9EJIFSS8Q
 GVEFE0t3Ngamdbd+ZA2kMoL4RgoJEPFlhf+jKZJR8NJ7BxGtQZE2WSzF6x47vbqyvHUODAKfVut
 JexMSn0c6KrGCcfd/F9PdlNd9V+uMjrI+FrzXKzMbGH/HIVvPjnBxNHfkL4cEsi+JxOF4MR63Ua
 5+NnYtTpIbFbWrltEWUR5HFYymgVcbgmLb1ZZYxw1SZN5Itg6YAro5QbjzsdYrAKSPi+NFHvQgL
 NapHI69Lw32N86tmtnjOO/th1DYFGWJLxg91j3UEs/JxKdrEdS13LmKrc/aYQMD8MIhPIuo3mX8
 ql/OsuwmSn26mB7d8Ab
X-Received: by 2002:a05:6a20:db0c:b0:3b2:924c:567d with SMTP id
 adf61e73a8af0-3b7e4baf716mr580096637.46.1781554686460; 
 Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local ([103.129.135.168])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8665186aefsm9576342a12.15.2026.06.15.13.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:18:06 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Use caller client for debug BO sync
Date: Tue, 16 Jun 2026 02:03:00 +0545
Message-ID: <178155468039.81818.12173237984867749651@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

amdxdna_drm_sync_bo_ioctl() looks up args->handle in the ioctl caller's
drm_file. For SYNC_DIRECT_FROM_DEVICE, it then calls
amdxdna_hwctx_sync_debug_bo(), but passes abo->client.

amdxdna_hwctx_sync_debug_bo() uses the passed client both as the handle
namespace for debug_bo_hdl and as the owner of the hardware context xarray.
Those must match the file that supplied args->handle. The BO's stored
client pointer is object state, not the ioctl context.

Pass filp->driver_priv instead, matching the original handle lookup.

Fixes: 7ea046838021 ("accel/amdxdna: Support firmware debug buffer")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 3 ++-

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdx=
dna_gem.c
index 6e367ddb9e1becb8d03cb4badec25deed38a851d..6c16b21994abc8f0ce58ee6dede21=
9a84ade6825 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1027,6 +1027,7 @@ int amdxdna_drm_get_bo_info_ioctl(struct drm_device *de=
v, void *data, struct drm
 int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 			      void *data, struct drm_file *filp)
 {
+	struct amdxdna_client *client =3D filp->driver_priv;
 	struct amdxdna_dev *xdna =3D to_xdna_dev(dev);
 	struct amdxdna_drm_sync_bo *args =3D data;
 	struct amdxdna_gem_obj *abo;
@@ -1061,7 +1062,7 @@ int amdxdna_drm_sync_bo_ioctl(struct drm_device *dev,
 		 args->handle, args->offset, args->size);
=20
 	if (args->direction =3D=3D SYNC_DIRECT_FROM_DEVICE)
-		ret =3D amdxdna_hwctx_sync_debug_bo(abo->client, args->handle);
+		ret =3D amdxdna_hwctx_sync_debug_bo(client, args->handle);
=20
 put_obj:
 	drm_gem_object_put(gobj);
--=20
2.50.0
