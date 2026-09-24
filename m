Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D06C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D3510F318;
	Thu, 24 Sep 2026 06:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZfqUom6N";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345D210F310
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790232817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/j5EYytItjUwk1/CqHyOHSfaQ3+6rA1AecV+p7hbPA=;
 b=ZfqUom6N3llfuYbpIXY80RUsmP7Wps/vxoUO9TPUsqQ9oZ3zKaKCVZqHLsam1dO0WsqdVX
 FtnvEM8916vWJv1etbBKIOOlxt92QF/uqQ+DYQw1dEji9mNsjTQKZW/0JW7qR4/Z0MaUDT
 CpH3oKVt+n9OYlnk0O4B0XObOE+FTEg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-8WPGqW85OM2cMlxxO2avsA-1; Thu, 24 Sep 2026 02:53:33 -0400
X-MC-Unique: 8WPGqW85OM2cMlxxO2avsA-1
X-Mimecast-MFC-AGG-ID: 8WPGqW85OM2cMlxxO2avsA_1790232812
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a35015f2afso3927211fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232812; x=1790837612;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/j5EYytItjUwk1/CqHyOHSfaQ3+6rA1AecV+p7hbPA=;
 b=vNmty0xEDeZRz3ldcAljHB4bH6lU5qW9XPE9TsB62WzXu8hUUwKUtqXBOLetSXE9ja
 ucEENku9U2kkwKL7CsmitzNkLBg97jCI/auAfFFkBQb749lb43LsC7LMPet6RYLPfti0
 6hxsrbTT7FMnp8gGe438Xav6qLCS6FNwSLnC/9YUhTjrvaSIaLUbEV8vU0iI3NAGUOFg
 ogtZ0YAhXNEVE4PYBHp4FAlAk2sRbf52+GRXJqubEHDPlqAuRi0RlcGCn3XNCSk5HRBv
 Wi4/P4LiZSgo+fDHVK6+YgYyzNsU/bzAnv3oUyHaUTj2NWvrip/WKMeD59nsWUEqAQLE
 bBnA==
X-Gm-Message-State: AFuF++lwlpMeSLtJQsUMrwyeSc27atRpC9XjffvKIWBkwwyXgXSEqG9/
 08A6qfPGtr4+fmdOVo+xbCfHLNoRhmT0WDO3F8rUf7rVsiTCfQ0bnESVB428os6wYmIauGz1cnn
 7ncRsqRUAZ4XSzfZgMSays1/GNJOlBDjbZ5Bs5m6VRsqTvkjFamwuu618ccAFebitfArK
X-Gm-Gg: AYBFou3OhQXMcoPmgaZYcyw2OmLXTBmfewJwdluThowIjum2p1ZHDgYNcJBzh/nNS1/
 vNlopspgBMpM9nZkubMH9ergV8i8f5Pp18guFlp45MleGrdsKQex06fIb8JGoOX5Y893YdLQzly
 27AfFvSXEcb0RZMZTDR3rjKqmMJztO9mB6Qt/pku4Nz61gBrEoCFdn1BD1fKj7MTkfYteXilXRW
 wYvDxLhjgQdhDu7jLPuk3z1aOvDsjyYCzsJBeX0ADzNNcUXwderwW+CCGXnUySS8acX2t2u9vrv
 Ke128atSXeCdBwfFJgEn5VCNcs7R2/bsztyD0ZqO1A5lcqVTzYGXUiYBjcubR7UGoLwr1vvsfDy
 8i7rW9TXn7HmPcuxQ6rlH
X-Received: by 2002:a2e:a593:0:b0:3a6:d50:e26e with SMTP id
 38308e7fff4ca-3a63bf1c44fmr3484711fa.2.1790232812385; 
 Wed, 23 Sep 2026 23:53:32 -0700 (PDT)
X-Received: by 2002:a2e:a593:0:b0:3a6:d50:e26e with SMTP id
 38308e7fff4ca-3a63bf1c44fmr3484571fa.2.1790232811952; 
 Wed, 23 Sep 2026 23:53:31 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bf57909sm4803141fa.29.2026.09.23.23.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:53:31 -0700 (PDT)
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
Subject: [PATCH v15 01/11] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Thu, 24 Sep 2026 09:53:03 +0300
Message-ID: <20260924065313.899730-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924065313.899730-1-mpenttil@redhat.com>
References: <20260924065313.899730-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UyuJTZmokhHlFJvcCxpd_5rLVF2pK-aBF_qjv6QT20_1790232812
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
Acked-by: Balbir Singh <balbirs@nvidia.com>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 604c58199acb..b7a485beb9a7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -687,6 +687,7 @@ config MIGRATION
 
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
+	select HMM_MIRROR
 
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
-- 
2.55.0

