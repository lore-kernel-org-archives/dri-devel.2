Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BEEC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 04:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DFF610E822;
	Tue,  4 Aug 2026 04:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Wq51YGji";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9461B10E822
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785817613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwL36eymgoLnccdesFRfeMb71MKt5ljy6aFM5YklG3k=;
 b=Wq51YGjixDLeHhsKYX0TC9gYhPWfwK46/ZDK7kRDjnL0TyE2eBOiGpZ3q1YqjVmdUs2aSG
 QtOIzWDyLQ/rHaq0vtQYufrMYr1yU8d/pbe1+j/SgAxBJw3KHWet2yeQ37HJZofNBlX6de
 nP2aWOiQ2FRwCoWvOLLs632R/AIuxBs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-4lsai-ahPJ-D3MU0STCTcA-1; Tue, 04 Aug 2026 00:26:52 -0400
X-MC-Unique: 4lsai-ahPJ-D3MU0STCTcA-1
X-Mimecast-MFC-AGG-ID: 4lsai-ahPJ-D3MU0STCTcA_1785817611
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b2b9c6d6e9so1989643e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 21:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785817611; x=1786422411;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hwL36eymgoLnccdesFRfeMb71MKt5ljy6aFM5YklG3k=;
 b=nV9bjw47ppnz9+162AnyCVlZoI56PMANqTVIHksVEKJWrvsHqVzc2yrcAY7/UvXDAN
 ZPBe6mhI7jwiwsT6LbLbC3SdLUK17y/M2xRH9IRkDeDU91e7eFSDprmCwSJ101INcEx4
 n43vSBuLB5SVIKtTnZAWbGJ9kXLfShKvLGZkLV3BAbz7l7wlzPRNOQFfTx+fO+OpwLM5
 8QKjh3yUMRNEiPURwwSZ+ul0Mhc7k1VL6ExMhxURVjc2o4nXOLBh6qv/8H3wnPIGHgZo
 nz8HD9UjM+SaEnqrzqTH9KfFsq8I/nlhAX3uV8+jx75zhPKm38F801UYN8oc10DvismM
 Epjg==
X-Gm-Message-State: AOJu0Ywog4PDd/UsrbqtnlsOKLMq/GE7K/gui+pmBVw0rDcmYFfpOIgl
 p+ORbqH/Hoh/ofdncpaCsSlYckuIsPjJAAVfR+nMqVJWZnzvT1S3f5WsQt5ntOCuXRsiIhSTsfT
 gyuH3hZ227iWfT+Fuhl6mRphokI4glfIMYHyHha9QPC8KjcnFn6QJloQtQG3ITjohdn0d
X-Gm-Gg: AR+sD109V1wTBgKxmFwlolD5y0S6G4YuEhZcnBg1jrH5jBFjkrULiDiSQBEZzerfSnz
 z3duezolPlRDdtOByyRQ1axoqzlyBFhzIZDSNoq/JA6eHDuZ+dA1M4pe7TB0XaCyGCaGtWPihPq
 zsYKEyfmr5dBxq2a7OK76fEBqI5jfYXEGGvoUHwPXgxmLRWl/jS4Dkl90K8haDnk5j8zM3tCUt2
 YsqHOLHiNh8E/OhZkjGw4nsli511pNG+KH2oKkoQCiEX2tM3RmtYIFxWZYtYtMXDgZ08+6eeHop
 DcfYr0TpXcY+fL8ExoEUluJtVw6rZCG9r6jwqKW0cTZIc3Kpz9RKkUY0uEShTVA7JNLjUPg4QLG
 J6S+c4QCF0HdLfOCg
X-Received: by 2002:a05:6512:3c96:b0:5b2:991f:90d1 with SMTP id
 2adb3069b0e04-5b2e4f3cb5bmr2664339e87.26.1785817610752; 
 Mon, 03 Aug 2026 21:26:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3c96:b0:5b2:991f:90d1 with SMTP id
 2adb3069b0e04-5b2e4f3cb5bmr2664315e87.26.1785817610290; 
 Mon, 03 Aug 2026 21:26:50 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2e23c46c4sm2311351e87.17.2026.08.03.21.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:26:48 -0700 (PDT)
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
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v13 01/11] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Tue,  4 Aug 2026 07:26:21 +0300
Message-ID: <20260804042631.2175585-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804042631.2175585-1-mpenttil@redhat.com>
References: <20260804042631.2175585-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GZtQLTTmzVbh4oILPEEN84wm_ye1ehCsDFePNVJ95OE_1785817611
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
Cc: Lorenzo Stoakes <ljs@kernel.org>
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
index 9e0ca4824905..7647671f37f0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -699,6 +699,7 @@ config MIGRATION
 
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
+	select HMM_MIRROR
 
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
@@ -1260,6 +1261,7 @@ config ZONE_DEVICE
 config HMM_MIRROR
 	bool
 	depends on MMU
+	select MMU_NOTIFIER
 
 config GET_FREE_REGION
 	bool
-- 
2.55.0

