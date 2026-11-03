Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9F606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCZUGN8g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776FF10E722;
	Wed,  4 Nov 2026 08:58:04 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6069E10E173
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:12:08 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-93e515769d3so10657085a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793743927; x=1794348727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zhleLxlgO/8KkinCeUWj94TJDi+jMt0bo+ONkONjbbs=;
 b=pCZUGN8gQ/UxbONXtce9bI74Te7aPvszGsKJxE5TJevI67fmjJE53bme2uJ33odSJa
 ey2SYsGPJWI+TmvZqBLwm3fKOiwMD3tJWzCqdiManOUgsshjAiBWLZ6hSKixf+lpx84L
 obmzU1Mv6ZB5zodzJik4gCZXo3pRENaehiNs66ushfmltj/NtWyNT9+ZQeup2qK+vspl
 Q0DBXc+eJTP8/AEOv/M2eMZiIi5bhv2JiLHl6QICFD8pGFzOXQ8zrakRID3X+CKKfpNV
 VYeNbhWIKAhDI8NfkJzvxxQtUYlRSKD9T0bkU8sCt7thDjgKFdwIEknbOEcbfzUSzwKp
 AKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793743927; x=1794348727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zhleLxlgO/8KkinCeUWj94TJDi+jMt0bo+ONkONjbbs=;
 b=f09qFGbd0+fI1qXghwkXMA+/cYwfGfjZvGWjFoDp4VQN6NZlE+pxT1ZU5CpRTQVPR+
 j423iyhD67SmCS9F6UfOuTpRxNO8q3/qp7GaVMWBLP0lNfo/pSAfZy/VRuNGPQjrDDI5
 fFmrEwp4664HCCJsohvczuk08K6Cu3OoKTINqjvhSelkpAmW3KqWdm6hdjRcH3OvHGcA
 B4pEnP+ztjsfG1klrdJL2OnVvnD7vYxgR8OIgbbwABrsFI+SJiUtSBdEr4QZ45ntadn2
 BkEZsSO73Y8L/IxEOJgHPZAmOywxOkjH3ZqWm3rOqAOx9nz1JULw2XEQytGr1StZu83H
 GCxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7Dazmt9mjsPbSSUS0gzYueLVJcAh89QQTSQZihTLK5l04NBWacVl9JpSQwkoUappsAYiUbvnEoWE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93HBSuN7ddjy/I3S5tHGoc11tNZQeFYZKIWxegTz5X1mkyMLuQ
 gmqQHfP8iqwBlt5v94DXLznKvlPFn1eddbsK6Hvf030/MparyegDM77R
X-Gm-Gg: AYBFou1ihNWoMvtWCcylD+Z9cuc8ZHv5wXif3qLaSAYN/1u+gMg6ByotH+Dn0uVeQLo
 ROz7mBnd9lL5jR3s2B+2NCDyuj8IkzT7GG9BF2sZcaUGjTIVm1MPH42PrXQriPZaSyPz+5Rog6l
 hvQO264n/Zez2Q6y1SWCr/eGeqlLEDgbcvYC5nH6WIgPCSrwJ487wsCDoL1g5FjRIzU3ZkpBIzT
 pUXG9MNi4Q6A7KZeH2oGsLsk1HSLsm6Zi9QjK/no+UM4BbtTej50LEF7LYu+l07yFrO8i9gYjGC
 PkjOnq8O5y8/bqD8txvZRKILnwfl3mvIKTP9OTQUTU9wUiuzIORjRAtvTj5SVnmqr/ZDqReBCb3
 nITUT/W5n9y3lCXoh82+4T3NGtTu/VpcaklNU90pWJutG6WcoCNMObNmjUGcOZomB8kI+2tJ6VX
 QzeC7nWQfnrqE+lv1MDYb/E13VHMriiQVGqfThSzM7tFZrCRREjCtl/mfhrQpRm9qx6HqU7Kjpj
 sanRQaiSPA8dcgPSIsH+v5FoJ2mP4/Z6UBh8EEZOGMsvQqkMKDNm4BGwNaF7yddcFbNwUt4T3X6
 HWbs6/miPJJg4/Ox/IlaCEsNaboDWlUKpObBffRec/HPZIF6IK/9I+yz4kDBRPwFaRWY5wrD1No
 TNICbio2MLx/ahI6cjm9c2+4us1kIY3JKbJE=
X-Received: by 2002:a05:620a:2805:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-944216db682mr2344562985a.59.1793743927168; 
 Tue, 03 Nov 2026 14:12:07 -0800 (PST)
Received: from
 codespaces-be20d5.ynsnsb35uh3ubhr4tvarlepncd.bx.internal.cloudapp.net
 ([172.191.151.57]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d4844be4sm39276485a.29.2026.11.03.14.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 14:12:06 -0800 (PST)
From: Eileen Blessing Kabi <kabiblessing5@gmail.com>
To: outreachy@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eileen Blessing Kabi <kabiblessing5@gmail.com>
Subject: [PATCH] staging: fbtft: fix spelling mistake "writte" -> "written"
Date: Tue,  3 Nov 2026 22:11:41 +0000
Message-ID: <20261103221142.45100-1-kabiblessing5@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fix the spelling of "written" in the write_vmem() kernel-doc comment.

Found with codespell.

Signed-off-by: Eileen Blessing Kabi <kabiblessing5@gmail.com>
---
 drivers/staging/fbtft/fb_st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a15414..c4db681eb 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -221,7 +221,7 @@ static int init_display(struct fbtft_par *par)
  * write_vmem() - write data to display.
  * @par: FBTFT parameter object.
  * @offset: offset from screen_buffer.
- * @len: the length of data to be writte.
+ * @len: the length of data to be written.
  *
  * Return: 0 on success, or a negative error code otherwise.
  */
-- 
2.56.0

