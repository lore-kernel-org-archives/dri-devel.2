Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDC1CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0872010E98D;
	Tue,  5 May 2026 07:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Wv46Z3wE";
	dkim-atps=neutral
X-Greylist: delayed 575 seconds by postgrey-1.36 at gabe;
 Mon, 04 May 2026 00:04:22 UTC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B67C910E04C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 00:04:22 +0000 (UTC)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1711E3F16D
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 23:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777852483;
 bh=F/bINxzi7hJ1BZBsneD55Rkz+Z19txcxR+zX/G3j6xc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Wv46Z3wE8+ZM+3qlYZyf8vHwWGymo1Zl2CCptzlrR09JE6HMrT1plFarkYHx8ZyzR
 PQSzv2ZIOaRPQ9RFdYjd0yasB9zyU3AV57xAX6tKc2vMdbvAca2j+yNjtWqblyU9HS
 /PLDlL3ZzwxVzF16JHCQLr0V+NMvMzrSIC55TvqcR+cv88prOWkoSD8M3y161ECKGg
 2ADEJlJMWAO+JF1Jnrv3zD8QBS/VsyYra3xwHTq+XhaENOQfqm1eTkhAG1KPZ8HJRo
 /x8LTgWbW8RnzQ4xTRjcfsuvlIESoZX+0boxgKt6JlUTIuDiQUiJ1Cm5RxNR132twl
 SwEDWkhUqvzvpcWX7WjuStm4FTfThukhvVz+nvmM7XfGOGH6jqXh17zusBS/5cGUN/
 kqI0kgjtxfp/qXBwZHvhR5lsdEpB5PK700cqLsuqJH6Yi2CPb0Tv5GdXUEkDEwydbb
 rTfhNzwSiMQxe0hQa9jukV1Ki7NMQw77vfg4FzBcB+BoQDmECCUjkiSIvDpN/i1G7R
 JeQeHsxPS2+adtlcX00QSK+dw/1NOP8TO/uKyEWTxKu9Su7PRuG/qU19GUAdyRbcqo
 l5aDxa70E8HYHa1U5hRfsJYNYG6Q3C7H6aaYH457xHGHdZjkGgZHokUcD1WLYU216V
 LNfQ2SYiMk4OoPsjInuHDU5g=
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b461b36990so38858945ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 16:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777852481; x=1778457281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/bINxzi7hJ1BZBsneD55Rkz+Z19txcxR+zX/G3j6xc=;
 b=GHKUXTo0lnnJfeTgcOi53mW6n6KHYhYcIEX/denRodLhtJZh5Nz75kDX/1nt8ZcRZq
 v4xhv3fjNJlN0cODUCyoNAitn+7z6ftWeDSkaPhXmp6vboSYiJRjUkw6YsAHQR7o/X07
 Jm/81M6eGvEO0j8DzaowtS948bu1yfEVUbsCl89HTKr5G4agR79HuX6Hezu+cDsvRYuc
 4IvBCYbjMlFj/h3rTYH0F4NM/qezSettkX50mOyXhP9TEOW9VKwPfUPeAYU7SJc3uSQW
 tDBBK9+siwSMHgxiW5Ttd3mQq1mRSc56VxnjjbDgBt3+lYS81cf41GEjKK1eAnxf6qbl
 xtHQ==
X-Gm-Message-State: AOJu0YxkMJ7XvfwBkvn+Dz/5rt0DrAQDPopH+rwP72VTlRtY/099OwnS
 io5Ua+J8OlnRMHIYm46zXZkhzpqhB4Y/d9YO8DVmXINeg7ULmJoBde2dQ6n7t/Qftu2mzItAM0t
 SCZEAMI23KulOH0qLQcDsyhMDOnqox1S8UbvE9em3Pb/OqypZazBJQCTOs4Depo6kFfusYbo4QY
 1wVAK1ujOSjazhHCjL/A==
X-Gm-Gg: AeBDiescz0GK9YDVvqMM0jP5hLBkfUNmG/S4ggc2/bhT/eJfT7FMhXyBHUQp2YTHuZs
 AMIi9PbS8kwO3KkdjCvW8ctvq7i7BWCBdBJYkvDhMguu4smAzJmz4jryPN+H/ihC21Mc6sWNbJx
 4XdRCnOp07NWjPVGWjBz/yAfygnH1HGWSK5igOVZg8g8uBb/ovrLdZfjDeELbtyOv9mdC7Qt4LO
 WO3UjGwvHXZxPXRt3L7ZsUvy28GjBhFB+XrRGiwKP9CHGxGl0M2FnaKI3M4UMQeiJXqqUCKHk6T
 z5ciS9Sc4WiA6zhJwW9hMCwreOgGLVVuiIaFZel7RscY9MrtYyPGlnLVH3wdjTmFI1T1W+SwuH7
 78qONHPM8nBsShJkIazNsHm5bWIHZ3sJkvx/S02MUI5hEJg5KRlXA0+/Sk9Wl6EhQi5df9KEZ/o
 2qjGJBM0VimyQMsOpYWG3/5iKbVw8KO8X1oGSDG5W1RL/qp01Hk/yPN5ZooRwn/h3m+l6T9TQFx
 BtjyPJPpsiLvu6t7ABujbXAy+sJOaC4lYcak3nr
X-Received: by 2002:a17:903:983:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b9f283926cmr69528955ad.36.1777852481104; 
 Sun, 03 May 2026 16:54:41 -0700 (PDT)
X-Received: by 2002:a17:903:983:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b9f283926cmr69528825ad.36.1777852480729; 
 Sun, 03 May 2026 16:54:40 -0700 (PDT)
Received: from tokamak.localdomain ([161.29.67.113])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9ca953894sm87291015ad.0.2026.05.03.16.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 16:54:39 -0700 (PDT)
From: Robert Ancell <robert.ancell@canonical.com>
To: dri-devel@lists.freedesktop.org
Cc: Robert Ancell <robert.ancell@canonical.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>
Subject: [PATCH] drm/fourcc: Fix descriptions of 32b float formats
Date: Mon,  4 May 2026 11:53:27 +1200
Message-ID: <20260503235327.92428-1-robert.ancell@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

The channels were described in reverse format, i.e. RGBA instead of ABGR

Signed-off-by: Robert Ancell <robert.ancell@canonical.com>
CC: Rob Clark <robin.clark@oss.qualcomm.com>
---
 include/uapi/drm/drm_fourcc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index ac66fa93b5a3..42f6918c2d38 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -242,9 +242,9 @@ extern "C" {
  * [31:0] sign:exponent:mantissa 1:8:23
  */
 #define DRM_FORMAT_R32F          fourcc_code('R', ' ', ' ', 'F') /* [31:0] R 32 little endian */
-#define DRM_FORMAT_GR3232F       fourcc_code('G', 'R', ' ', 'F') /* [63:0] R:G 32:32 little endian */
-#define DRM_FORMAT_BGR323232F    fourcc_code('B', 'G', 'R', 'F') /* [95:0] R:G:B 32:32:32 little endian */
-#define DRM_FORMAT_ABGR32323232F fourcc_code('A', 'B', '8', 'F') /* [127:0] R:G:B:A 32:32:32:32 little endian */
+#define DRM_FORMAT_GR3232F       fourcc_code('G', 'R', ' ', 'F') /* [63:0] G:R 32:32 little endian */
+#define DRM_FORMAT_BGR323232F    fourcc_code('B', 'G', 'R', 'F') /* [95:0] B:G:R 32:32:32 little endian */
+#define DRM_FORMAT_ABGR32323232F fourcc_code('A', 'B', '8', 'F') /* [127:0] A:B:G:R 32:32:32:32 little endian */
 
 /*
  * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
-- 
2.53.0

