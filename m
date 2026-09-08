Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A129C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587FC10EBC6;
	Tue,  8 Sep 2026 12:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kiS+uzC2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAA010EBC5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A1DBF43D07;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80982C2BCFD;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788871504;
 bh=vzch2M62/WWHWost2D/9T230FaN7wq32AuSjdqMctMQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=kiS+uzC22HVOdgVM8xJzFJJOpakF1Ym0C6VAUQRTpznk+I/ZtO5w9G+w0t/GoCb61
 f4wbyU3Km6pvxpJom1q/WTBm5VvbRmDaiCvSxQrbrISlmZHD71SXpBA5Z4j3JDdBsC
 oNKn/zHg1Uy+CxzdMH56RNb0NUVMvGe0kGIPSZJbugdYXD0JL0UhACP5/P2eiVpQ7I
 ZR5tKl7uEOluP3o+IcTHLHdmJVbJmj3AfjGycuUrCYX/nnJXGvtdGegfeWzvYoUwYU
 DFZL8gE4Qf39gf6Vllyg+u7Zu9tYBzr8rmF7N7TO5u/IwvTOEdsEKbK+44Q3BVPFYG
 Md0ma5nKeEqMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 647FCC79FA1;
 Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 08 Sep 2026 14:45:03 +0200
Subject: [PATCH v2 2/3] drm/panel: ebbg-ft8719: Fix the MODULE_LICENSE() string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ebbg-ft8719-fixups-v2-2-5454ae1f5581@ixit.cz>
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
To: Joel Selvaraj <foss@joelselvaraj.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pcKWoYS6L82YgpVkEYWbN55kI5NvaLGqQcKX3/w4Jbc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoANObviOu0ox4MSAY8PbmPEAfrKuso2+WBjwi
 ga4pOVvfDWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqADTgAKCRBgAj/E00kg
 ck7SD/9BssSUhW1R5woL/myJctiVqZjTmd0pwcw+ZwuaNzsI4ZSLE2XXFR2bgpZ+zBvAqf5iJn8
 x15C6iD6dvW713r0htE9XL/VhtJHqULfQgpF3Eeq8ZF0VbKYKqcXFvm6ItQKeM1cThN8RBN16iz
 oxLg+9/FlVoeNPKnS/lkvG73Aa/KJ51Mjf43SuCX1rHl/mmWvcUX+eCg92SPMrt7tOE9Pb11FZ4
 Z7MblAsgt6Lb466HFpIFUeAoCDW55yQMk+5aifONk7uIa0bEYCsSLTybDHeKCjnQXzSqu65lyVd
 O1BYLHu9kC8Po79tAbPhZuS/Y9pWUTnurEJKEtyEQ3rmawwwRtQ73oGH2s1cWheTbherinsap76
 TFQkHeP3L5iNqnfMi2qTF2ZvDpf0CXCD3NifBdfsU3LjdK14+Z/I4HD7R0WYAAHkgO41W/5yU/g
 rrrl8JUxiGjYGPJ3WTE8T7x2xuvHP1sk4lGJrqD048XzJKOuXo3eM4v1juypspfAyDO0Xe0tyMl
 GSabg/Bd9nXct3H/8fRqCXyCcRDXucbUgm5fi/5uAVfz1JxfOGw8m+O+0W+H53SJiCyHPoUg5IG
 QhixLZeVqlNzoSzYzEGuG9Ooj9bUP7C43dY1ni3mAZW4XMFNZ/Xh/bZqDSQG0lLO5bdzdKAvwaP
 5n8FnYrInSqhPmw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

Replace the bogus "GPL v2" with "GPL" as MODULE_LICNSE() string. The
value does not declare the module's exact license, but only lets the
module loader test whether the module is Free Software or not.

See commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs.
"GPL v2" bogosity") in the details of the issue. The fix is to use
"GPL" for all modules under any variant of the GPL.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index 1ab09c50a6306..14982263a94f1 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -241,9 +241,9 @@ static struct mipi_dsi_driver ebbg_ft8719_driver = {
 		.name = "panel-ebbg-ft8719",
 		.of_match_table = ebbg_ft8719_of_match,
 	},
 };
 module_mipi_dsi_driver(ebbg_ft8719_driver);
 
 MODULE_AUTHOR("Joel Selvaraj <jo@jsfamily.in>");
 MODULE_DESCRIPTION("DRM driver for EBBG FT8719 video dsi panel");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");

-- 
2.55.0


