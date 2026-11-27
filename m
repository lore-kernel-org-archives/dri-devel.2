Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F134606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+5hGzMb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3D81127AD;
	Fri, 27 Nov 2026 02:15:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E8A1127AD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62BE641295;
 Fri, 27 Nov 2026 02:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC821F000C1;
 Fri, 27 Nov 2026 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795745704;
 bh=AxO6ITynFYCz3tbaMENDiJEbA1Xn/FD4c7DpBtb53bw=;
 h=From:To:Cc:Subject:Date;
 b=M+5hGzMb0Dv0e7MP9/ygGNIsrN/GQKIsP4HBIflDhn/YloB3b0rPuljc15qttw4iS
 2szIK9KEpwvqFEezDjtqMEYahpYkIzKlXhLJsUCVXHwgagq/e5Ivu/GvfdlokvCVyV
 8FLUG7Z+NlgF+hIcK1ICqltDMMcLYh87rsvXwf4lkxGUQ1yVfWnBLW9xfY9aLw8jye
 3nXzIjfl1hClv5jRq8GAOGOTys3CDV/TD372Wuet/oA90m4c0lKUU9OqwtDk7AUd28
 Sy6Ux+4ead4CBUdPR9V4wLdRepW8DBPiFDQAEMQC9mWX4iH2khAgeODwzuQ1DBRHQe
 XAzGqOSAnmJlQ==
From: Thorsten Blum <blum@kernel.org>
To: Junjie Cao <junjie.cao@linux.dev>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Thorsten Blum <blum@kernel.org>, Junjie Cao <caojunjie650@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: aw99706: Clamp negative max brightness values
Date: Fri, 27 Nov 2026 03:14:23 +0100
Message-ID: <20261127021423.656745-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=blum@kernel.org;
 h=from:subject; bh=0R0jCEkBvOQqFhQNu9vWsv/8OunR3DCCny4Kf8o4nvE=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNkcz+s762/MerP9wkxp3vs9p8vWX05a+OaZ5+XT5TKfl
 /ff+n/oY0cpC4MYF4OsmCLLg1k/ZviW1lRuMonYCTOHlQlkCAMXpwBMpLOY4a/oXu77y999+Lbv
 +Odnh6o/2hdvPrL+0ouq6ZK/3N82ZzouYfgrwxQn9Pb2L/GmK0brXkxwUDurcsjKgf9iqGiMxRP
 zDYFMAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

device_property_read_u32() reads the "max-brightness" property directly
into the signed int max_brightness field. Values larger than INT_MAX are
interpreted as negative and pass the upper-bound check.

Also clamp negative values to AW99706_MAX_BRT_LVL to prevent this.

Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/aw99706.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 43f82c83f91a..c8168a36284d 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -272,7 +272,8 @@ static void aw99706_dt_parse(struct aw99706_device *aw,
 	device_property_read_u32(aw->dev, "max-brightness",
 				 &bl_props->max_brightness);
 
-	if (bl_props->max_brightness > AW99706_MAX_BRT_LVL)
+	if (bl_props->max_brightness < 0 ||
+	    bl_props->max_brightness > AW99706_MAX_BRT_LVL)
 		bl_props->max_brightness = AW99706_MAX_BRT_LVL;
 
 	if (bl_props->brightness > bl_props->max_brightness)
