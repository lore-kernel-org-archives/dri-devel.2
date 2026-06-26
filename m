Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A18CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25B310F4A1;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="DfFGe01N";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F07510E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 03:00:22 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1390f75d8bbso48448c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442822; x=1783047622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xyfqQaJzQGqQ+w3Wgkei2isTk6qDBF7q1W+qeueb6IQ=;
 b=DfFGe01N7W7muGjca4A9MDNH4HNtWw91wuF4IS6PWSbEzXi9TW/EJKu4CX+oIqjw6N
 OKqlpdUbNnqgj0dzJf1qLl6ip0CRyin7zFLy5eBVYrsasGNLB/kAA8Kn2tMHvUDQ4Ujp
 Yt4jMxWFnkS9DZ9V9s5j6BTtfkxgk+As/T9j7BxAkAfLPAGPpcgmNE1kzE6P8ij90yDi
 NvpiTeDOxFw6XvR2zp9f0cxF2uLLSNOCIcmygfjGaYjBNGKJRwZo+rCnXHtHKVHDHgQ6
 0n26CHJ03J+JQ5QGpr4gFU87UQMS3sJZa9c3jYZTtnJhYU3cru1B2/IqE/3LURTW2wgU
 NYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442822; x=1783047622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xyfqQaJzQGqQ+w3Wgkei2isTk6qDBF7q1W+qeueb6IQ=;
 b=FrYbkHAK9L2W9vGdKzJnJKw8nlCYOtSn9xHk/eslV0SB9YYZ8ADQyG43Ie4jOe9kpd
 lmaZymqakd6lssZZ8wwFCxwyFCi1ScDKNqQliTIJoOarPEkMOJ8+iHOzEwJq7nO5idX0
 tEYSKWbivV1RXq4JVEE3moF4AAencq/TvpTH2o7EcJIzjnX2qTwPQsnQARyfI+ZlrnL/
 Rb0q/zWk/lliQK0oFGUD8Ea29PM3lQHriM46I14qtCq/kL3RYqE+AzxDAhye48QoVl+H
 iQe6C+fJTyeQBZo7dIdOr9WDyROSCVWHzBEcRB5dRqHx3m7YTfq3D8QSIRu+hs2cAdEd
 O1IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3ZZcXlLyvfOf0EJsMv3neMoD8CETjV766Nwgvphlnz3D3np5BtIS1Fy6ORzWT62NhAs/jyncQyQo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySL25A97kYZ+8WHHxtQ1FcUrJCkj3VF8VwQvCjJCKk0i/w+pae
 m5cTd+nru7i+0R5ia5lZV5Th0/ubNWglasn8LUSH/wojTUgDx0xxctSLux7zTEI6aJU=
X-Gm-Gg: AfdE7ck6PfoH0SRQK3W1vaOjD1/oFMUOQ2TO8qLna+gMAHzcXBaQEg7wuIHAUlLgRMl
 d8whJRs4yvRhFIY987yvpy3Ge2xsh3I7HbEtm1aRg0lUuOb9dBX8YHFdT89YW+HGmjV62Nq2O9c
 k5+fWa2+BeMfUCb1NjNzCVfmAgTOXtphIf+/XNqMqvPbknYJigglQnpVZnriF6br8U26RMon7/S
 GWjdR841yJk9i9XMWXTwldnoVfDrUFY34s5N/w3Ssb/vFULV7vCRMQgFOqGiG/WimWXVqHJfgkp
 EtqGbO1rgPaPLUGFd5dtNK5R6Yn4dxLqnyruMuKf7R8o+4kAjhwuWv9DiPPb9k5YWpCxxRot9sU
 pREmkXQr8wvKOwp863nvw6u0WWRAd9hS8sEBA9dAmlhxVe4M/EnEXBlrZIBhTmnwojppx9p9P6+
 tfG8tnTJ6MkT22y33g1yODRGdZQdlES6iHmUAWyfAAJB5gMOyO1yxIeTutVS91YetaVkuG1g==
X-Received: by 2002:a05:7022:5f08:b0:139:dfe9:c8b1 with SMTP id
 a92af1059eb24-139dfe9c90emr1949342c88.8.1782442821140; 
 Thu, 25 Jun 2026 20:00:21 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm13048415c88.6.2026.06.25.20.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:00:20 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch
Cc: Tiago Dourado <tiagodourado@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] drm/amdgpu/jpeg: deduplicate process_interrupt across
 JPEG versions
Date: Thu, 25 Jun 2026 23:59:11 -0300
Message-ID: <20260626030013.20569-1-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The JPEG versions v3_0 and v5_3_0 have process_interrupt implementations identical to their predecessor versions (v2_0, v5_0_0 respectively). This patchset removes these duplicates by exporting the original functions and reusing them.

v2:
- Replaced macro alias with direct function pointer assignment in the irq_funcs struct, as requested by Alex Deucher.

Tiago Dourado (2):
  drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
  drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 21 +--------------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 6 files changed, 13 insertions(+), 42 deletions(-)

-- 
2.43.0

