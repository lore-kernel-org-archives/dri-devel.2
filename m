Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31A4F3380C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742AD10E4F6;
	Tue, 17 Mar 2026 08:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wt+BIeKW";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA91910E4F7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:08:37 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so2540623a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773662917; x=1774267717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vmt6JmqfOvMD971meinjv4RPE5FU1VzZS/x4CNlI5L8=;
 b=Wt+BIeKWwQCpNdkRItFqtN1AumgnSOD2cz40AdpcqDEuvCbVOyhFFl1muX1Z/fmMte
 3RNYiYTTOFBaOAVYMHvJcTlvA+bSPiY0Tr4jbVCTIBOCFQjjqF48xZbCqzcQU6BRdKlD
 1SaBcsxIN39hBiQ/54Zr2IqQrmFOJyNLHH1SQf1nbXdReBvVKs+OETMdWoF3mz2St0pn
 7JNKFnMkDKQEO9WKrMTNLYX3I0cI0AmQUKdijWDuKnCScUHw1J7mG7JNj0uqAdcjAYav
 nyMeU745/PziKMnfKlO+xm22BLSu3m7ZQij8ZQofofpYBKwW1CWqSkHjN9uc9adE5anR
 Vw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773662917; x=1774267717;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmt6JmqfOvMD971meinjv4RPE5FU1VzZS/x4CNlI5L8=;
 b=tW1oxiWzV3A/eOgy88Zm0eTs5pv96AdVV3PyIE4N6MONIJLFYF0hYCr/SUPvtoi6o1
 MxAfv5WxO5wf93g6GEe4DUhqkPh+VBEcGnXog1VArMGkUidsoYC50GuzHscwlBEEQMZx
 jrB3KKQ1JoIrVo7cZpHDCT9L4ZjEhJr3YCf4AsMijTcbHoLG9pqG+H0VvBOZemzQH69V
 o88rGBJNgmlBOZlx/Xo4y9JJx2vu8DELIsWCIWTe2i6XY1WsIEd8ziAZJgpCj9b5S48I
 Z5y7EnKY9+zanN+1CcVZ8DWv6N9ZQEniJvWZ6eaSNjtO+Q0LYcj5qn0++g7jPY+5dakq
 1/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUthyvw0Rg2NX4BsuXcVvP9LghQw8tV+ir1+zCknRjZ0Jl00F+tt3ZeuouKfw6Zc1QJJ1MQ/mj0v24=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqMPv2/c96Vy36xoe3UpsCHfn2oH00DRJoMUTtoe0i3+UgRb1V
 b8+MqgZQqRINh69d03ZtvzKkMipn0p9vpchHGSAnKGha+dqaSmGwjXx3
X-Gm-Gg: ATEYQzwoYE4I6yAqhK7dZNCNW5gDbial/xXXn1GJH7kHZ1kSWVsqQsWPXTtbTBJ9fNr
 4u1TfDseM4C9VAKiZ3FsOF7FSOsYzQWcrJWw8xmlA4CfS37gVvUMvatjc0MEvevZzENeeBDgUcL
 Bn5e2gNrzq6CmEAWBI2E6UOcQom50Nu9zp3JxXUeJ9ItNWXnbObdauyg3cVt1AqmNXpTum5IkH1
 aa8hjSNfhnRUebA15V6hf0X25tmxthKTQ7zBT6nIy6dEiRqYqzYr551gOgbxvasrakq7sfi+z+f
 VjkLPX4MorcRCK4raa8qavQyGkr9QbAFwrSh+gaxv3Yrk6q5lgvTgg7st7Ps6GfJFFGI3IJkd8w
 E1I9Z916n77zJqVrdCZEPTpLdMyrIPVHYMefX06Cqhd5MOrDDzQCw+8mEdNFlPpTWwqay2S315O
 vzhO1hJx2RznuUuvTw6zYl81aDNtbPIGRWdiSx0pqIcXKYuT2eFpWG77qmqLxwngM=
X-Received: by 2002:a17:90b:1cc8:b0:358:db7b:f686 with SMTP id
 98e67ed59e1d1-35a2206c05cmr11091492a91.26.1773662917159; 
 Mon, 16 Mar 2026 05:08:37 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net
 ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35b9e36f45asm3240083a91.3.2026.03.16.05.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:08:36 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v2 0/2] gpu: nova: rename drivers and directory to use
 kebab-case convention
Date: Mon, 16 Mar 2026 20:08:18 +0800
Message-ID: <20260316120820.2117081-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Rename the nova-core and nova-drm drivers to follow kernel naming
conventions before these names become UAPI (e.g. exposed via
driver_override).

Changes in v2:
- Also fix nova-drm driver description from "Nvidia Graphics" to
  "NVIDIA Graphics and Compute" (John Hubbard)
- Rename drivers/gpu/drm/nova/ directory to drivers/gpu/drm/nova-drm/
  and nova.rs to nova_drm.rs to match the module name (Danilo Krummrich)
- Link to v1:
  https://lore.kernel.org/all/20260310062443.2763230-1-yphbchou0911@gmail.com/

Link: https://github.com/Rust-for-Linux/linux/issues/1228

Thanks,
Cheng-Yang

---
Cheng-Yang Chou (2):
  gpu: nova: rename drivers to use kebab-case convention
  gpu: nova-drm: rename nova/ directory to nova-drm/

 MAINTAINERS                                            | 6 +++---
 drivers/gpu/drm/Kconfig                                | 2 +-
 drivers/gpu/drm/Makefile                               | 2 +-
 drivers/gpu/drm/{nova => nova-drm}/Kconfig             | 2 +-
 drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
 drivers/gpu/drm/{nova => nova-drm}/driver.rs           | 6 +++---
 drivers/gpu/drm/{nova => nova-drm}/file.rs             | 0
 drivers/gpu/drm/{nova => nova-drm}/gem.rs              | 0
 drivers/gpu/drm/{nova/nova.rs => nova-drm/nova_drm.rs} | 2 +-
 drivers/gpu/drm/nova/Makefile                          | 3 ---
 drivers/gpu/nova-core/nova_core.rs                     | 2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)
 rename drivers/gpu/drm/{nova => nova-drm}/Kconfig (84%)
 create mode 100644 drivers/gpu/drm/nova-drm/Makefile
 rename drivers/gpu/drm/{nova => nova-drm}/driver.rs (94%)
 rename drivers/gpu/drm/{nova => nova-drm}/file.rs (100%)
 rename drivers/gpu/drm/{nova => nova-drm}/gem.rs (100%)
 rename drivers/gpu/drm/{nova/nova.rs => nova-drm/nova_drm.rs} (92%)
 delete mode 100644 drivers/gpu/drm/nova/Makefile

-- 
2.48.1

