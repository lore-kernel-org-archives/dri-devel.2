Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3A5606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ddywqgbC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A4410E54F;
	Sat, 14 Nov 2026 04:43:55 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109AE10E631
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:43:49 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3b094e649d3so1805444a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794631428; x=1795236228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/Osil3p9tI+TJ45W4tyUJkbTxb/QirMyt7rDHJX8Ic=;
 b=ddywqgbCjhCP/E1Bh74QHLpB/de2Cs2yL6eRjoAHUvSGlSf6bfSqChaMqhOEd67A3j
 69mFbKNCNI3isboMP+anbbCzaTQdSmswx9qwqFcPhdfT1tKVKvvo3L9zstqpl+2V9ATK
 mTj+K7nTbUy6WJ6RX2qz5klBOLlUggN3dIp1rsOikWdDTlpsQB2Ree5HLmVzQrsRTeR8
 5692o5HFKopRfPmeicaKh6Nz5vL3kOIcEt9gKaNMxs0quS+ufxjpKW2MwiDWRkYd+tBn
 zWBA/TiRyY4pD8+qeFano9ND37eH2UTIHXnQ2qJTGyxCs5vnsLL4mMRZ4Z/ImQsJ98V+
 l7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794631428; x=1795236228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/Osil3p9tI+TJ45W4tyUJkbTxb/QirMyt7rDHJX8Ic=;
 b=E/WDa7r80DsO+TxhVQKH3bvDavOjxiEe1FMqwgycMCpxmN/nPutrbzUVkuSj3Lg5cj
 K+o3oIjsm1exp/kXRJHn9LZen/sYRIWXysP6pOkd2ch7b5nvx8lmorDGwJRUF35vkB3/
 h8eFBfOmxOeZYwSvjP1SyMU3dpXYaaeV69Ij4DmHQHsM9LUMN6JcnIrwJM6L8dOd/UHp
 N6x5TCWJr9xaQw9vlRVNQIcTA/Rhr+7jgGlnSt1e/qP93kSW+m3sYJ24l7FVfgWX+dOH
 ToO8KP99l7bc2e8/ahmW7FXLiNcZeXVJruqD1u6YI+nIC50PkTh6TrcscgDEnZhWKjh1
 9HBw==
X-Forwarded-Encrypted: i=1;
 AL+hErE2Ar0GcWa0t23Qbz0A7Seh0y04Aj/2Ddu+RC/moVrUyIWi0/Oo17cFDYZtNI8aB+o1PNYStOA1dlA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+0VmvnuovxN7CwoytBSrPtgetLJ0xhLvM5TTr2mon2dCf2pc5H
 9LYtNKSRI7+sJ1/++d/4zxWpXvkqcEIVQnQovW2hGnuO6o8P0e+RmOqC
X-Gm-Gg: AYBFou3hZO69tmPkg9dQkzFlP42t2CbMsha24dddz6ckFnarsFU6hgDZtIb/YS7etll
 Eig/bs31QX/wxjJvXRwihyUCTEq18UQOcw0F8B69dcYFJr4BW7mFH9Td8ZBDaiL/np5Q4y7J4u3
 SyT7ouP+u6oQu7/cRUEL0LfUYcNgKlTTaIas3AbnrdQU7hC56nXGDusY84/67TX5fYG/dmS896e
 CiC1dZEiLeLWZ78MOWUjHHkziUPIDrXs+56hqWuMFd1KzOeWj3mrSIVNlLJ2KTGeIncx4QuUfJ1
 zeFMEUoCKH71W/eIxpAvMoHr+GLzmEvwo0y5VNVzir1KYj/KCfjxgbuiLce/j2wMIyUwts26LuZ
 TPNvxrSy5SeKZZeue8IU2gxcXj+8eDui+RYZ3K5GM124s+kSsglTGRxoT/I6zjBLtp3LTtud6s5
 kC7B5X7r7jUFp8B7BQcFEUfsT0Y6yzSUmFI6HS9EhUJbTKYVggE68BG4TRFKazuc3IavvfRSROX
 68hdkCWvRpVWjva+T5EYRjv6RzoDQEb6Xuko9FbeusjlCyUZgiAnZLpEXWTQMvw2GvTfbRwyVl+
 ClE/JRWD/qL+2hiVv1p0KI2chay3r2+omlU=
X-Received: by 2002:a17:90b:590d:b0:3ac:a7ee:6770 with SMTP id
 98e67ed59e1d1-3b1b087b76bmr4366544a91.7.1794631428549; 
 Fri, 13 Nov 2026 20:43:48 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3eaf732sm3230685a91.3.2026.11.13.20.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:43:47 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v8 4/4] Documentation: nova: remove completed GSP log buffer
 task
Date: Sat, 14 Nov 2026 11:43:04 +0700
Message-ID: <20261114044304.245684-5-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114044304.245684-1-vladazaharova2018@gmail.com>
References: <20261114044304.245684-1-vladazaharova2018@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GSP-RM log buffers are exposed in debugfs, and with gsp_keep_logs
they also survive a failed probe.

Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index a01c362b1be0..28fc7329d56b 100644
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
2.56.0

