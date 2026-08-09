Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E4EC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7DE10E0B5;
	Sun,  9 Aug 2026 00:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ENNPcCum";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F9710E0B5
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:04:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 267AB41883;
 Sun,  9 Aug 2026 00:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF560C2BCB8;
 Sun,  9 Aug 2026 00:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786233872;
 bh=ZtdBQ/ahumDHXcx5VpIi2GsmmsHcwZY7yFycaqOz58I=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=ENNPcCum+cDh+SvQYsFPXPHjsLLmRDAFAEVUkmedWfyXq+cvLvBz6VFDOVIWTEj+l
 rErcyApz20ROOkErL60WGeq1AdwG3d2CVuuG2MDCoRG0Wi2MqOGGpbvBebcpNpDRAh
 DXEwyAZ2wiL+xffcqpD18qlCRfrHGmLzw0WulfR9umeAdzB/UfWBsMJL/3FtWEVcoM
 KVBYKwlQXbsdzYWj457kMJhLZ+wCM4qVCe5F6c/JmGLZ4Ww8wBmYbrIP5VoU6X3isZ
 Mv3t4t1yK1HuBJLtGKHYRKidbrAVtqHdTUTArsZ6o/uOWmVJ1KrXhS2OBnqGdxeCTE
 StSxO1zC3HCOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B4B11C5AC67;
 Sun,  9 Aug 2026 00:04:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/2] Pixel 3 display fixes
Date: Sun, 09 Aug 2026 02:04:28 +0200
Message-Id: <20260809-fix-blueline-panel-v1-0-e7f3a6beb1fa@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBSE4VeRs/ZAzMJLX0W6SOLEnhJSSVQK4
 rs31uUHM/9BGUmQ6VEdlLBLlk8saOqK3MvEGSxTMWmlW9Wrgb182YYNQSJ4MRGBjde2c0PbeT1
 ROS4JZfWPjs/bebNvuPUq0Xn+AKUKhdN2AAAA
X-Change-ID: 20260809-fix-blueline-panel-af2b7c967f2d
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=ZtdBQ/ahumDHXcx5VpIi2GsmmsHcwZY7yFycaqOz58I=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqd8QPDB/IjJhsxFS9IR4ByO8d0VkQeuDXzY1A0
 iZHIvQpRTCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCanfEDwAKCRBgAj/E00kg
 ckKMEADBrBr79RIGllAVa62yrqdAKJBtyIKF0r3XbXaLyyLI8ok2Vw/AZeaaOy+/dVeoRHRAUwZ
 fJ9Pbp4qrAETzLQ890JapXp0+b+Lc1UFwTnpxl8HT2Nev6DIpp3x6SmmouJeKMJEBiluNNMCJ6K
 OkYuXWP/EUJpx2vyrZNNncVn6lrBiRl1/u+Sq5+Q+bNXWn58orvXk/STg5vtaLl2WGM0Ew4uRii
 d1tNA4NftJzeIpn8L/DfSzH5cM8LPk+eZgyny6BRUolrhijwjwpS2GPHg9DxfPNe/bEnlY0QlWz
 NTLtlh40nO3Dt45jKYC5+EEwhRoWkAXjkPTUch4dvtw0aYx9eOwU5nohV9Yo6lQq96JL36Hoyko
 d54ksSkkcKWfFD4Yz1mWAvcyi/YKqd7zt61FT1nPIUYvkJsb4nfgTNK53Svd9c2OwPkka4ilSBn
 Agr8K9I7aic9LvvfuLWkpxg/2/YRg9s3lC1h7fJFjCUbbsJQQsgMkZhT2Jz8fZBUyw+GKhk4197
 XznQbX4ZPGDlTMucnErG9rjzcZ6bH34a/EGBLhYgHotOu9hcSdrsi9wVCj+9Ediyf6dvN7qq6Vr
 0M2pKgxz2ZD1lq4hq7ZDsV/arfLSKScO4/TocVD4xjkleRKgMYFGluVN5zXpIPVKCvIYRlCbaMX
 3aiPHQ1I90pmlEQ==
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

Fix panel not recovering after unprepare and backlight intensity.

I extensively reproduced the vendor bootloader sequence, but after the
boot isn't possible to do the full initialization of the display (at
least on Pixel 3, and panel can't be found anywhere else).

The downstream, due to having attached touchscreen reusing same
supplies, never turns the panel off. Let's do the same.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (2):
      drm/panel: lg-sw43408: do not assert reset across unprepare
      drm/panel: lg-sw43408: use the full DCS brightness range

 drivers/gpu/drm/panel/panel-lg-sw43408.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260809-fix-blueline-panel-af2b7c967f2d

Best regards,
--  
David Heidelberg <david@ixit.cz>


