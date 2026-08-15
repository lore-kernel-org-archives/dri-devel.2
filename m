Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B31BC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6080110E2F8;
	Sun, 16 Aug 2026 14:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FPknFBT7";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC46B10E133
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 05:08:33 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5b28c91fba5so1920256e87.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 22:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786770512; x=1787375312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NgkFZajAQJmzi//1l9aIpRfIFvgCaKKT8i3Z0CDYaWs=;
 b=FPknFBT79+skyxmr3REZWLlfUOUfHx3YaD1YEFHPhmgmmqTZkLQzueCj18c6TmAF3b
 8zsH79lH5YAxz7Guoaz3c2DLqQ/7J7SqGn7Y8GQfVSbZ27bmXehW7cC6ZdGKyM3gLKEW
 KhLUQDwhajpQ4N8VUS2n0vnZPK7vxHWx3RFKoLNilcIi++vrgITR4eZaFtLXA2oOybA8
 M6R81x7iIKJ9hN+FCpqZFnRjPdjShObgSn1c+rQV2ZkCw1AYTvntHa3sTcwVgVyqF6/y
 e1h/ORxTzuKAPuKq2xfmOHviEQWlk7wDgkoP5spJ7MHlnfDZXy5CJenRC9Oe3y33X+NQ
 3bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786770512; x=1787375312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NgkFZajAQJmzi//1l9aIpRfIFvgCaKKT8i3Z0CDYaWs=;
 b=g1WzxSs9EK5HNl1El/Uv0SRnSax8oYCz6eeAOfndn+1ZmlEaRzpWXF8Jom9+VcdBDD
 FI1u3EifXgIdHtB6yQ6Aor/FPxU2oSIr/2Fp89MyCazWgA1MgT0HoJc0g25/EZWdw7N4
 prfZoUJoX2k6qE5Fs01KnA/wwR1mIRAswGuxDm2q1kx0ZeZ8QmGXKT6VpKxeNpg5hzss
 annDx5lKWSgMN37HCvSWlfbCCEidz5fnP2EXM0sAWWSCqzQQ39tt1mND1m2bANufMkAp
 ckM3GfQ0QSaxTU1rOyhB4WXLbg4Nu5vO55dvMzZF5Re8uf2IbIQAwGfW346bGqEjaMZk
 69FQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLZ+cYFGOcldMImXw4UHG/l0zBwMV8BGbt9KnXwvhFS1MF3JuL4/phIDqGXZuBslOgMxVk5Kt8pLY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzivAdoPZgsvyyXmci5a5niTHqmVF3LcEd0gCQKcP2zZxhAxLDX
 rqBTi0TvF41JOGq6o4H/QWJtr1eKh48Hx5hxdukXHWwKunT/GAt3Gzs0
X-Gm-Gg: AR+sD138M5CQ1nC8WTLDLzWkoMnNZRkZ3eHst9Op+ZeimmAsdDX1vZcTcT+jHpaAI/D
 kIcRIcTdroqzHpcpem68CLFmLmK1sTn7SSjZCPCjePw5kJ2IuDg7RlK7rX4oSpqNxxUIHdX/YLM
 BnDsdR9HpTjwVtw/HU2ckVmVYUDq5Stz6a4KSyXvPOzh10DWzD2eeiTFPNO2R3U3YOUarKbIQm+
 1O3+mBbKAYZ29trWoWwzxmaQiBXaUUWFqQlbEWDb43+4Cf3BOQNywcTa+6bus20UX2odEX9e6Iy
 vBTwKIMfe6Aq5lMkRkdgXYYJkiUvzFpN/ylZZ/fTIBNpRRy5obVF/6lWK17hgpjxdCNIaqtRFTJ
 WbHER08/JJv55h2VS94jpkhudRuJWtScIGvBd+Fpue3mGTQjFpwtWqP8HS7fyXt568mVdeiZBVd
 4PiWkRtEegzH21q8lBzcS0t3g0q/ooKxLcH9nh1Bzrc0LR3nhcqQVrDmibMMiQhokvdsE=
X-Received: by 2002:a05:6512:150e:20b0:5ad:68aa:8a78 with SMTP id
 2adb3069b0e04-5b453b9adeemr2672003e87.5.1786770511539; 
 Fri, 14 Aug 2026 22:08:31 -0700 (PDT)
Received: from localhost ([95.190.110.153]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b458b9a9a7sm932354e87.13.2026.08.14.22.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:08:31 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v2 2/2] Documentation: nova: remove completed GSP log buffer
 task
Date: Sat, 15 Aug 2026 12:08:26 +0700
Message-ID: <20260815050826.306717-3-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815050826.306717-1-vladazaharova2018@gmail.com>
References: <20260815050826.306717-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

Exposing the GSP-RM log buffers through debugfs is implemented, and with
the gsp_keep_logs module parameter they now also survive a failed probe,
which was the part of the task that was still missing.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d5130b2b08fb..cae0578d32f1 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -141,18 +141,6 @@ Implement support for instmem (bar2) used to store page tables.
 GPU System Processor (GSP)
 ==========================
 
-Export GSP log buffers
-----------------------
-
-Recent patches from Timur Tabi [1] added support to expose GSP-RM log buffers
-(even after failure to probe the driver) through debugfs.
-
-This is also an interesting feature for nova-core, especially in the early days.
-
-| Link: https://lore.kernel.org/nouveau/20241030202952.694055-2-ttabi@nvidia.com/ [1]
-| Reference: Debugfs abstractions
-| Complexity: Intermediate
-
 GSP firmware abstraction
 ------------------------
 
-- 
2.55.0

