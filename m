Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFFCCD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C4C810E063;
	Thu, 14 May 2026 22:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="FiqWNNO3";
	dkim-atps=neutral
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E98010E063
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:45:57 +0000 (UTC)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so3919992b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798757; x=1779403557;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TdalToY785SBD7KCeHZ3kuDVygT65e3z/bCNeB39po0=;
 b=lsCU2aR9+idKEFk9Bmbhh2KzIacD2NamBh+lESUkPB0gXKG9620pmN8EeyA15ZONII
 qNqrnS0/4zvvdstCQA+zOi0jww6i6nVcv4/EREZb74l+PpPyXoEeKQmFC8BsWG5RE4xe
 V1sJs6bCzsMY0lNz8sBk3blc7Vh9wlZ+R7QijSQHSSb0cI7jzdDi0K8Qej/370KAxeh7
 khKFCbOmRJ6xHTnTqailjgQ4WOFIjB/F842Q9PsdyCBVz3TQxBeMqJLyu9Jdo6yqZEKf
 USKsbNPZlWzoTaUyCgRgaVPz4xJCulMjSJMJ3N66zzQOgsyx4VmeeurTA2uoTzGcqap8
 TurA==
X-Gm-Message-State: AOJu0YyskjeM2wvaxuScIbNwVUuDH72DtRrZZrCnNYdXiT96IYAWlfco
 nRvF5wubo26aVl6Zd3A3OuiI5BqZgsgpBCPYW/QMqXLVrmNPzK6ujflPNLbGsGW8Id/kBzlAJcv
 kjWjjM7CgwUfFURA4F4OBEDdlYhzVz0Acc8BBsW5PIzJ+rQu6tkWFiHo1N/Z40+M44QIzi2QaTf
 Hxf0Wg/QO0/JuBX5uVoheeTLOaiUKeh3tDdyu6e4SqF1aUv81IcOZb8l81rcXQRzMGwMddhz6W9
 7gaxIAIBV4OTTKAP60LzG0agmo5OQg=
X-Gm-Gg: Acq92OEj4yj+qk/gp3u5zErXf20je+WWa5MKUBXjFFsNyHQBVmzBS8tZiTqJV+l5prL
 KpguwIIdnAEt3hcmdN/9FHCwD2PD5r/eYN2FJzQfpeyhcGT9b6WTV5Rdwu0kC4bB76mdAR4flCg
 6xN7/xc3Gq97v85inP3EfsxBCdpjkNZC6NbNE8n9zKaToLFDC6VqBq2YjYfqxoTu87kulJgILaD
 NwzjZQoO4l2gxs6t4q5RwTVI3Qy6+cqDExn8YQjswik4U5SIk9xHvs0iciL+2h6+IOa8hBbhcmE
 h403TZkkBP0RjPnNb6+rkLIFtX44sz8dARAFsQqrZK0/SsgZ5fm02ARxOUVDMjyYEUSyHepYEsH
 evfb1PAZ6kWjmrl9rq+zzRLxKEN8FNlqwP62NPVNUUTon4uI63HQLnvacwf9cmPuXrrXdyAHzWl
 zbzRNRvQ+VwFCOeGeYcOOwXz6NGP3BUbujLVGII/6D4v6wqqdh9w5Om7UugK9Kpw==
X-Received: by 2002:a05:6a00:3005:b0:837:db9d:9606 with SMTP id
 d2e1a72fcca58-83f33d26f5cmr1505894b3a.23.1778798757065; 
 Thu, 14 May 2026 15:45:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-83f1980259fsm335143b3a.3.2026.05.14.15.45.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:45:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-132d5ad9c32so10255564c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798755; x=1779403555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TdalToY785SBD7KCeHZ3kuDVygT65e3z/bCNeB39po0=;
 b=FiqWNNO3u9GZTpq9gqIUTG4fugqolzMeXznCas8N41Kqn3QRf7ImlsAQTFdqPLKQ27
 bOOats4VgAiMVbIR2LdPTv8tevd2OM0kkEedNOQo4Yn9Y7Qdv4Ojv+VYa8mnJhrfogdf
 ydxZU5793/6eK8NrFNTaQDivq1d2PF2Us7EWk=
X-Received: by 2002:a05:7022:4183:b0:132:1e01:8737 with SMTP id
 a92af1059eb24-1350542e5a3mr550478c88.26.1778798755145; 
 Thu, 14 May 2026 15:45:55 -0700 (PDT)
X-Received: by 2002:a05:7022:4183:b0:132:1e01:8737 with SMTP id
 a92af1059eb24-1350542e5a3mr550462c88.26.1778798754473; 
 Thu, 14 May 2026 15:45:54 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:45:53 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 0/5] Fix some issues from igt runs.
Date: Thu, 14 May 2026 15:48:14 -0700
Message-ID: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I ran igt-gpu-tools with vmwgfx and fixed some issues I found.

Changes in v3:
- Minor changes so series can apply cleanly on drm-misc-next.

Changes in v2:
- Changes based on Zack's comments.
- For vrefresh changes, removed stdu specific checks so that test
kms_invalid_mode@overflow-vrefresh passes with sou and ldu displays.
For ttm ref changes, fixed a ref leak in ttm_prime_fd_to_handle()
which fixes a memleak in test vmw_prime@tri-map-dmabuf and removed
release callback for dumb buffer surface since the gem buffer will
handle release of the surface.
Added commit to remove duplicate functions in vmwgfx_bo.h.


Maaz Mombasawala (5):
  drm/vmwgfx: Add some checks to vmw_cursor_plane_atomic_update
  drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
  drm/vmwgfx: Reserve ttm object before resv usage
  drm/vmwgfx: Change ttm refs for dumb buffers.
  drm/vmwgfx: Remove duplicates in vmwgfx_bo.h

 drivers/gpu/drm/vmwgfx/ttm_object.c          |  7 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c           |  6 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h           | 15 ---------
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c      |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 16 +++++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h          |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          | 32 ++++++++++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h          |  9 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c        |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c     | 12 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       |  4 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c         | 12 ++------
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c      | 11 ++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c         | 12 ++++++++
 16 files changed, 94 insertions(+), 55 deletions(-)

-- 
2.54.0

