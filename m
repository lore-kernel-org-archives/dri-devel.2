Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F14DC79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E1E10EF47;
	Wed,  9 Sep 2026 06:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UrTmL8Tt";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1513410EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:29:07 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso36319065ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859746; x=1789464546; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QPg1uLKI5p/H7J2E4b3w0DPqeVInWxkk5y+GYwVR13I=;
 b=UrTmL8TteCC3NSD4D/4vHhaobKdF/e5yWsIGKPoqbTBqA3tYhrPE8aaxOfHtNtgBvO
 HidREkXS15y2XHzroYMDEC1fZs7PLWMAdjFr+g5EfgMpjBUuyvUyvTI037mrd6QkFZLA
 m2SmnDFLP5v6ZPRJV1i8ob8+CwkdbpkKCARx2nh9jGe+/bU3LWr00iREGAEye7KhJ64u
 bXh5VPuTd5cpL0DK/i6uk180G6f2L3B40W7ztvmsxKPtpqul7Pubhv9LFuV5yorLoAc6
 Wvc5Yb4jOkNhl2Jj6ZvT5JO21STzx5/i22OZQARGTTn0tLFztCnuq074eWq9BrX5AVdl
 9zvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859746; x=1789464546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QPg1uLKI5p/H7J2E4b3w0DPqeVInWxkk5y+GYwVR13I=;
 b=gaH/VYatBWa/RYfoZveklGtHVjm6CXrwtHA8PzP70vhxYuHogVj0vxNLRfT6R3Ths+
 guVOcLy5AXwAwcjnEMmgFGXO3/xFNHdslj2JxeNMJr3yYnd1M5NX22MRfO9mTvOMNdjf
 o/nOAq6+9DTHMxohpW3lCBIjBSoPLgXag071hFu6JIUaGUG7DU7WFuhmr/JFUVmTfmpB
 7WeWvgGL5D6Jq+Vu9Wg4n/0FEjkeKzpLB/oCll0HXS4dkZ9bFtBcVVGo53EayyEfd6JB
 Fl+DRFf9Wi88dLowtrGz9fhPj7HOFldUUwSnB20p+Vz18SADmXvXZpgK0kTwlE4wQgNN
 B2Lg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGNZrnpD5FmSU2wyeKLuLq9hzO7+hRcS60fPYwvuqdfwV5UZ4xk/iL7DmIvAl5OA7IjeqHKi/U6z0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kyDIPPfLlnfhZDNimogUuQ7TsHFvKlavRqQbQT8ndweG46Ab6L
 ug7w2RBIwXFTiUlOCFUdVDWDCGgyC3a8z7M5RP5dGKDOY2JXbWwE2eqq
X-Gm-Gg: AYBFou1DhcHt9BhJEHGCsncUV1TN+EshjJ8FRveOd+1NVuE9/21EOSficW3nuA6qsO6
 pHlbRjH2j/ZQlO8zLI+MdZ8uqHgsX+m0jgKALRLndY8F5tjoFq4w1fD45qYBnOEjOUwCePkjJXd
 zWVteN2pVrnamu+ovrq+3+90o4QJo7eaiWhoSvX0jxl0Plg7+tHwljw9Lfx+UJxBRUfMjA3Z28B
 GTDD1JHOUlo+OnOz/FLfhyBXROx1TAyHcQmm2/T74Ohw6f+NkEAp5gTWYr+L9INzIkXm+DsMfoc
 hP+8LeZDQ7ecrdEzdVQn5JWax7N2T3NM4sevACLos6CaopmgIRp4/jJDdJLA2iLOCWvn5J5HirD
 mn4HKgqPCzAhFc/OaLna7byihDotl3GerAZfEdhJRMo2WyzggkLphB/WBNRs2jkKKYwD+OPL6PS
 Y1YyRAvGbh/eDH+UuTIixIVPiRDeN/RJrSNu8YKYhu2b5VnBY8sY1beGULDo8PmHMlrrvmztynP
 eMPi45vtM0L87Kzzw9pIzIkYOT/H0Y9N/FKsXCr9Maua0iiASyDxBImC2c5iEg=
X-Received: by 2002:a17:90b:1641:b0:399:1f8b:d255 with SMTP id
 98e67ed59e1d1-39b260dd3fdmr40172772a91.5.1788859746500; 
 Tue, 08 Sep 2026 02:29:06 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm32109846a91.9.2026.09.08.02.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:29:06 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v6 5/6] drm/verisilicon: add DCUltraLite chip identity to HWDB
Date: Tue,  8 Sep 2026 17:28:39 +0800
Message-ID: <20260908092840.225220-6-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908092840.225220-1-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

The Nuvoton MA35D1 chip contains a DCUltraLite display controller with
model number 0x0 (sic, the model name contains no number either),
revision 0x5560 and customer ID 0x305.  It has a similar register map
with DC8000, only one display output and only 32x32 cursor supported.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_hwdb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
index 91524d16f7785..7d630a667a3f0 100644
--- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
+++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
@@ -129,6 +129,16 @@ static struct vs_chip_identity vs_chip_identities[] = {
 		.max_cursor_size = 64,
 		.formats = &vs_formats_no_yuv444,
 	},
+	{
+		.model = 0x0,		/* DCUltraLite */
+		.revision = 0x5560,
+		.customer_id = 0x305,
+
+		.generation = VSDC_GEN_DC8000,
+		.display_count = 1,
+		.max_cursor_size = 32,
+		.formats = &vs_formats_no_yuv444,
+	},
 };
 
 int vs_fill_chip_identity(struct regmap *regs,
-- 
2.43.0

