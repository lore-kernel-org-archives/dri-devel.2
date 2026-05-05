Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1253EFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666F610EBD6;
	Tue,  5 May 2026 18:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CJziw1ci";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA6610EBD6
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778006693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=CJziw1ciPjfRtDVwWls0ATkXzN/iPFMJZywvnAyy0j34iqPfIJka8z+HJ4adj9gzDVQOdm
 4Wz0Fem2Rjy+iQoDPij6IZR4yV9TQfCxhXZo0m/NT1eMSVPNBIlw5xWq/G/Se3oXNicz9f
 3rNBLtHO5/MQurwzxObQSiex0beYI+I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-3kbp8gD1O_aEYw-MsnmtyQ-1; Tue, 05 May 2026 14:44:52 -0400
X-MC-Unique: 3kbp8gD1O_aEYw-MsnmtyQ-1
X-Mimecast-MFC-AGG-ID: 3kbp8gD1O_aEYw-MsnmtyQ_1778006690
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a3febf3b1cso3288033e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 11:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006690; x=1778611490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=fVBqGwWf6yRQPG7WPE5A2VftFrvwaZfWO2RE/vRWdxfr+NxfT1GJPyC1CKAYv7L5Wa
 9KsDrWLL5bXLsd8k+e8l6uZmikjnoRYjNdMyHjlBCFXDBPachfRPCeoc5SVR67EVsQJZ
 OkRnWyhet66BhGdxJ8d01gjePD5vk3r6XxESX1hgyoKqYhp7TM/uaX8QIfkt3u/BJ9sc
 rG3+icL4jSD/D36OcZl8kryg+ELSMlkfbTveurts05aFINKuLH16lySpZHSA77r9MlZb
 Wri3+Sn8sMFBEOE/1MJd8Q7BfTsUg1xdoalrPdIRCJuz+DQcXTuP2V+8CpT3qwrXHU9h
 aOnA==
X-Gm-Message-State: AOJu0YyGlO8mKFSboO5XV2LP5WHi31WH2JFzLf/l0enVA4Q489u6GNIR
 7ZJKY0uNGHDTBKBQ1W7RaNKOc3GUzFmaOr94ZxmaN4W4wJjmwAMiUhrNBeZG3+Q4eXQOZ8NIoIx
 H7HlNSx2bejJNS2pv8ZH1Gvh9F2zG9SN1y6Re4eU/cucYXIUQzEp6fDQqMsAS5cS8FJqS
X-Gm-Gg: AeBDiescoiD/eJdBgVHWWUH3QHPcU0H8pIejvrvgeZilAsm6yf5DMBBDgSIzJJ/Ul17
 jK8A0/hpBKzr3SRkd5Z1vQF4CE2CTT7Xw3nqWLPKv3TJgkdiqt4R3vdSMbcGvYEBE1OSvCMbHhA
 iRwyO4ExoD5E96pWeAmfl46ivYRuSdx5hZjvqsx3fE1bwzCL15/BbSgp7ovxMeg3RMcjRZSzMsy
 gb725Qg2eXYToC0Soav5NIC5u9eVTc+zKtWh5ZYu8MKt5mmWLE09KWO6D3QFOGL1WcfI5wv+z6g
 4SNL5CQkv86ri/VbZywjZXWZ+wsKl0H9ItCWKuM/POsm0CqyNnYNuQgQXX7XcWj5IKq2fCtPsie
 QF5EC+syFXn6yXc0GrBRl1Cfo93PIO5lp93R+RGe7NgoUGZE=
X-Received: by 2002:a05:6512:1241:b0:5a8:638d:6f53 with SMTP id
 2adb3069b0e04-5a87f1a04f6mr1942764e87.6.1778006690412; 
 Tue, 05 May 2026 11:44:50 -0700 (PDT)
X-Received: by 2002:a05:6512:1241:b0:5a8:638d:6f53 with SMTP id
 2adb3069b0e04-5a87f1a04f6mr1942737e87.6.1778006689860; 
 Tue, 05 May 2026 11:44:49 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a86e65fdf6sm2504437e87.78.2026.05.05.11.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:44:49 -0700 (PDT)
From: mpenttil@redhat.com
To: linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v10 1/5] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Tue,  5 May 2026 21:44:17 +0300
Message-ID: <20260505184421.2324798-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260505184421.2324798-1-mpenttil@redhat.com>
References: <20260505184421.2324798-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eLUYIuT8aGgoG-theypRvFg6v_yPgIqn2WzFJC5mxxw_1778006690
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Mika Penttilä <mpenttil@redhat.com>

HMM depends on MMU notifiers. With the unified HMM/migrate_device
page table walk migrate_device needs HMM enabled.
Enable them explicitly to avoid breaking random configs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index e8bf1e9e6ad9..0d8db75ffc23 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -646,6 +646,7 @@ config MIGRATION
 
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
+	select HMM_MIRROR
 
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
@@ -1221,6 +1222,7 @@ config ZONE_DEVICE
 config HMM_MIRROR
 	bool
 	depends on MMU
+	select MMU_NOTIFIER
 
 config GET_FREE_REGION
 	bool
-- 
2.50.0

