Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38E606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsrLbKrK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952E4112B65;
	Fri, 20 Nov 2026 14:58:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319F1112B63
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B1F246AFC;
 Fri, 20 Nov 2026 14:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35011F000EC;
 Fri, 20 Nov 2026 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795186699;
 bh=psyrX4pTbPek/o1VXnvLS2FKhiZpCmC5h25HbgAdlSo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MsrLbKrKyVvWQtzAJm7MG/EMLqkO7az6m7gZ2EzHMUmpSdTyLypdzQgtmLcMls5LG
 0+e55w/njSrDwy04lmOt+ORQbtnXPCoGV8/nwc4B9M2sDhYgDIFRJjlEdc26RhdLiy
 FuTRez103kYhGVf6CLOk0yIsLuTCQfy9jum8wtS9Gljh9EZx8Z2QwiqQJKsGkUFgps
 51R84wEGanW+vkZwHNl/+Uq+E+UqL3h/LnofgNJFZt5/3hc1ecliozbrzgSHk0w33A
 7yQBNI7QFfC0MhjYZUBjNBq/KsCWNT5ze7beu0rqvA8reAWpCFtSwdfb44e2dPyytW
 5IMVx8sIXRayw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Fri, 20 Nov 2026 08:57:33 -0600
Subject: [PATCH v5 09/19] accel: ethosu: Account for feature map element size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ethosu-fixes-v5-9-52d459acdb84@kernel.org>
References: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
In-Reply-To: <20261120-ethosu-fixes-v5-0-52d459acdb84@kernel.org>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The feature map bounds calculation currently accounts for only one byte
of the final element. This can leave the tail of B16, B32, and B64
elements outside the validated buffer.

Use the feature map element size when calculating the final byte.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v5:
 - No changes.

v2:
 - new patch
---
 drivers/accel/ethosu/ethosu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 11f41382dc5d..b5df8e61c1b1 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -436,7 +436,7 @@ static u64 feat_matrix_length(struct ethosu_device *edev,
 		return U64_MAX;
 	}
 
-	if (check_add_overflow(addr, 1ULL, &offset))
+	if (check_add_overflow(addr, (u64)element_size, &offset))
 		return U64_MAX;
 
 	info->region_size[fm->region] = max(info->region_size[fm->region], offset);

-- 
2.53.0

