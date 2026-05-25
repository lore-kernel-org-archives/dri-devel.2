Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F24CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 05:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F7110E3C9;
	Mon, 25 May 2026 05:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IeKXi43r";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADCE10E3C9
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 05:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779685734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=IeKXi43rwCc84RDy1yeKw6K34eidyjgTbre1l3EtdJ0DfDReA4Vx5H3shupy8pYC708NuO
 OOHl5hojhi7bSpWoAr3kyx7fIGQmAuEhBLw3Wsdg2bY0I+wStbbiVnD5IXyWQBQlY2OYcm
 p1v6YwgU+AwT0oYabwAFccD93PI45BQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-Mze29MfcMGm3TDIz9JP5cg-1; Mon, 25 May 2026 01:08:51 -0400
X-MC-Unique: Mze29MfcMGm3TDIz9JP5cg-1
X-Mimecast-MFC-AGG-ID: Mze29MfcMGm3TDIz9JP5cg_1779685730
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38eeb467db3so35502201fa.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 22:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779685730; x=1780290530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=rVEBE3Dh2HwiTTiBjS/YU4glEGAImavZvFYKnZRzt+iO6rvW8DQVHsFaUSEXeLZ5eu
 DhxjHuaZkLJntPvnltKhSQhas3U+63f6hJHcpPcpgcpzVGofyRsrmiQmZqvJQoZdAz8q
 KXXy4txzbDp+lHQMeqLJDBFZjpgLyqgcQsBYOX/jP8j5WKZVDVLVOEgT+9SBGNWN44lg
 d/or/jPHLZtg9Y49iDwZO8NObY/zz3Qk/wjVlBHxotGAB5dx3Q2TBT5XQU9DqTfwcdg7
 A/fA5vaZZr98mooIRA7ckGvC9aZFZE7bi0Og/ujQY0x0Skxk2tkhi2ra3mtHre+HDT6F
 6DDg==
X-Gm-Message-State: AOJu0Yxux4ZgKgbwCWkdKfKXh5i7YTKwLIB2TTkEj39Cu1DfcTdaH7qa
 QNLp46uWuCptq/H7MknO8nZaRIntD7OsKAEp9TOKgA6HifKoZLPsIhXyO8EcAHZcd1eZxkZVQU0
 Qo2+Huw9H8uoLslqbZUdns3w6drP2k81BdktEVYbg5Kz2rcfE6F1WY3huJPBUN94RcOpN
X-Gm-Gg: Acq92OFIPlycS9oPWf615b92CTbJBvV2tedEv7kQkV/7fm8mrqKZFJHe7PpVWibFzgl
 k3ZxDMucX2DspOB/NZBfcmkHgSBsgyR7ijdWsy1B9n7t+QKAwPqO1Q8yjqhjIEBDQA3oZt5L8s+
 gcECCboHYIAfHNk52XpXAAWUdQfZ3CIYLTYw1FWmhCo0RIBaeRChDg5183WI+LLPZK45rvbEtTg
 E4fYCNrVuVAdik2SRUlRPHq6nBaGAEm7cUpgOmMU2ZpzHzDsvo48eu6SyjN+xYhLiFDTfDh5n9N
 UkV9NiI4hSQZb1rZ3TDBZuFJn+W9CJepkVWe5S/+ACeZp3qt6oAxlM3Gh6WqDwS/eMGCnIuqBZ7
 dqYU2TUqha54qV6vqCqtJc6rFFbjT2iQOKYQ6
X-Received: by 2002:a2e:bd06:0:b0:38e:a00e:2bb5 with SMTP id
 38308e7fff4ca-395d8d1d1e5mr38101511fa.19.1779685729906; 
 Sun, 24 May 2026 22:08:49 -0700 (PDT)
X-Received: by 2002:a2e:bd06:0:b0:38e:a00e:2bb5 with SMTP id
 38308e7fff4ca-395d8d1d1e5mr38101271fa.19.1779685729251; 
 Sun, 24 May 2026 22:08:49 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dca7bcddsm20698161fa.16.2026.05.24.22.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 22:08:48 -0700 (PDT)
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
Subject: [PATCH v11 1/5] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Mon, 25 May 2026 08:08:26 +0300
Message-ID: <20260525050830.100254-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260525050830.100254-1-mpenttil@redhat.com>
References: <20260525050830.100254-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ryCcp25r1ecrpq0Ic2brQztrJb4OjIANZdNTJeHZldI_1779685730
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

