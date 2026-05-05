Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D167FCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE8610E182;
	Tue,  5 May 2026 22:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="c1qKJlVH";
	dkim-atps=neutral
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B69410E182
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:47 +0000 (UTC)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so50357325ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020066; x=1778624866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jz5/M8Zs9y9qCaOW8dRlq8pGWz8Bs9u9Y54VWckOywg=;
 b=T5LbLAfuadAltUop+7z9vC8HwqC1nv16HosCR5zdC1e4J9YMBhQDhvBb36xZEsCWbJ
 4W6CPo5KXGgN4gp8s6WIxHO6ZO78pyggBpVerP5PqnSc62v4e09xUaTPWhTrimCfsnNF
 bwt4HV6Mw9ewe5HT+Ij3164l/uTM5xMbNrzpFksYXtPUWxjvn69QddD1bGmnIcxlTk6O
 MPH02geXuhqIBpCFv8i8pSmNy9vZDDnymwpZKzlzIhDvRYGneAYrZKUDVh88Qk72M9rd
 TPdbAS0YuuZPliuiWetmG1fHxhbgRaTTE369SRmFH+raDQwFSVlMPHaowlED7gKYnpyP
 BWEQ==
X-Gm-Message-State: AOJu0YyaVaxwftWFtSW89hPeWeLCdvzsoUXC4yXzdLuRbyHr0K6m3Ht/
 Ok67tJxreyuoj97hFgcN9GbTg5EUMUJpryKTZickS+1gvq8kkOPm4GFPGU1N76c2NKRz374K8Zg
 WyR3QaBihUfetZ8n1LSI9gE3B8+/yt7Ery2wtkDuuhIaRYzb0jJ/RLkaAV1tk/f2zyVNJh2LV+J
 eA/1Kjto2DQw6Gzm26GO8ZoX1CvJMk4dVa6+BRMr7Ee+lgI4+YjiIL9IG0AyCngSvF8xyQugy49
 dziPz7Ytq+SnD6NRvdc
X-Gm-Gg: AeBDievT1E8xpTNhlmrHFXHGRCsdQcNVP90wpsXyA6VUYQHR0rlZoIbLYIxUI/d5LOe
 tQtOG9gXuY0Wbs8BplmfWLdDpjcpd24v8i9NbMn2tSKslO0BaOiUIVqHwJi0ydD45SOPEDZXYRl
 8gog4qaFebFmjDyZ4jBenyoQFS8QPxw31mndaFsLCsnTJPh6DRCxn0blY46aWNl+LKAi0tP9MSi
 F0jX41jK/pOgBo+w+UNb0MOsOy51jHBJVbIw1H7eQHS2UI40VzxGzG++kBCoIwNpipGn5hR8XMm
 z4kzeOo3v+1vAFp/bpaB9zyFZbkPq0PU40v5XBs90g/2WBChMmbW9U1nucHR6BjxyVSZHqyjxKm
 UT48dSHZlA4UfvmswACR0LdSHBr6gCNwWVgGyTd+1NKHT+S3ugU6Fdq7/kPdRW8xrGEbpIitldx
 I9Q2PCzunrV59h44u5J32QSrX3Fnh5izRVgg40OwMZCckIM56V851UQPX5HuJ+bwDV
X-Received: by 2002:a17:902:fb0f:b0:2ba:6ca2:bca with SMTP id
 d9443c01a7336-2ba79c20dd6mr4773485ad.26.1778020066551; 
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2ba7c9e7f2dsm396085ad.40.2026.05.05.15.27.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50f13da9684so72809021cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020063; x=1778624863;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jz5/M8Zs9y9qCaOW8dRlq8pGWz8Bs9u9Y54VWckOywg=;
 b=c1qKJlVHYcr7+W6T4qoLU8L3OEhSy/TGfNopJ52+HMp46l4nddOuLISIZJRa5VtV/5
 zU6ahbIVo9wkrDwWsQqQ17d5/8ySs8qgRQTAR18Vx8QJsadQCAZyURgnpuMdcfxfHrAs
 HqTl5FGkByK6bAdDrITlQ3EWdS3RxsWozgFY8=
X-Received: by 2002:a05:622a:12:b0:50d:9e36:f961 with SMTP id
 d75a77b69052e-51461c26170mr15711761cf.20.1778020063275; 
 Tue, 05 May 2026 15:27:43 -0700 (PDT)
X-Received: by 2002:a05:622a:12:b0:50d:9e36:f961 with SMTP id
 d75a77b69052e-51461c26170mr15711251cf.20.1778020062554; 
 Tue, 05 May 2026 15:27:42 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:41 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH 00/12] Fix issues found by claude-opus-4.7
Date: Tue,  5 May 2026 18:22:21 -0400
Message-ID: <20260505222728.519626-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

This is new for me but it seemed to work ok because it detected
issues that have been present in the driver for years. The fixes
were written by me but the bugs were found using claude-opus-4.7.

The following prompt was used:
"Carefully review the vmwgfx driver at drivers/gpu/drm/vmwgfx
for clear and obvious logic errors. Limit your investigation
to vmwgfx. Do not suggest patches or reason about possible fixes.

Provide clear explanation for why the code is buggy. Make sure
to include exact file names and line numbers not only for the
bug but for the exact execution paths that trigger it. Try to
follow the process described in "Describe your changes" at
Documentation/process/submitting-patches.rst to describe the
bugs.".

For the commit messages I've reused parts of the explanations
that were provided by claude-opus-4.7.

Zack Rusin (12):
  drm/vmwgfx: fix guest_memory_dirty bitfield clobbered as size
  drm/vmwgfx: reject DX_BIND_QUERY without a DX context
  drm/vmwgfx: clamp dirty-page range with min, not max
  drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
  drm/vmwgfx: drop dma_buf reference on foreign-fd prime import
  drm/vmwgfx: validate DRAW_PRIMITIVES header size before division
  drm/vmwgfx: bound DMA command body size against suffix pointer
  drm/vmwgfx: avoid destroy_workqueue(NULL) on vkms init failure
  drm/vmwgfx: enforce cursor size limits for MOB cursors
  drm/vmwgfx: skip hash_del_rcu when validation context has no hash
    table
  drm/vmwgfx: use check_add_overflow for shader size+offset bound
  drm/vmwgfx: validate external BO copy bounds for both stride paths

 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c         | 39 ++++++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 49 ++++++++++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 20 +++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c        | 13 +++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c   |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c     |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       | 13 ++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c   |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 17 +++----
 10 files changed, 134 insertions(+), 35 deletions(-)

-- 
2.51.0

