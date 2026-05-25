Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABC9CD5BD5
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C01D810E5FC;
	Mon, 25 May 2026 08:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OAoZvNWg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3652A10E51F
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779698747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=OAoZvNWgwZXIthU3YhT+TGsY82owpOJfHHPJdpIjzEXiOMDikXD2wHtMoqZDzVGLgEommI
 HdvUre6R8DWaF1/FWDNhMhAU2RlCN8a+/99EEDomRX3KUqlurAWot9K2KqjoZzq2MI2U7+
 OHORL2812JxdyJkHi4Mdw18Dg3Cgltc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-O3N5GYWINtCH1wTtswYtmw-1; Mon, 25 May 2026 04:45:45 -0400
X-MC-Unique: O3N5GYWINtCH1wTtswYtmw-1
X-Mimecast-MFC-AGG-ID: O3N5GYWINtCH1wTtswYtmw_1779698744
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-39389bc702eso42589161fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779698744; x=1780303544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=VG3KI1Q+gxnbtjw1mYNYyc6q78s5lUpOhbQUDn2DtS7wIXs8xZglTMqxoZ3vws0tjx
 soMfy9utbH7TDic+zJ+EgG/Ba8gsMWsc2F5H97TlreXLB359P8PTQ/V7vddSGGy0zR40
 kyhD8cHwl+ExDrdqKgG2TcYkng9LB/LRN4Lscgrev1tjKF9EvOdDhfpOyqAMEfHx466i
 dxLrzwDFl5DdkU45J6u0Y7UzU31GcD6axHXXQprDHmapQKT6uKF02zZZt9ZmYkh8D8Ua
 /WiFFlo1sM4aok0rYRtD9BbkNhw2ookORtMRTe5RxUVpmYGZh3D6t0OBkUemCk0WtIoH
 1h7Q==
X-Gm-Message-State: AOJu0Yxxi7KyNs1CxObboRi08pSywsLysLHID4TdldzPQlL40eNkfOX3
 aefX/fHslTVt2OJ/tg6gJ+Bl2ufkzA457bGNCMz9H5Thqk8hJawOv5pqZ/ZdPG8kzPaHwpD4LCu
 rQ7RcWITqu9PB8pNvWoA0SSCW5zwxQAn4fOAsFx0bmMU10fug6tvtXc6NIfXfk35WNsxt
X-Gm-Gg: Acq92OHdJJsoKjlah8i/Z+sM+HaF+PBP5S2qx0wDZivTCvHAU1+dqMGwmhW+4/mJWH5
 hzqRrdeJ/QmtCcVPOJITsIiL5lWB8fbwU/fkFLHlamG2ch2YqnVqw0IcF1nmYB++oNg50XIMOHh
 kEdOXFKjdGQj6PhonDbH4o5BTb05Y1EB4hRgKuC+OwpR8BC9DrQ6zLCvAWFWnpNEdRuT4t987f3
 2qUUvlDgkh8S0rhNN1V+2Mw+d1aeSPf4zMQd0GoR5PrOZlkal5GoPQzGWbH8ua/laUYayoCfk34
 7V1sITBdfQReJQM1dhLPxA1979inr42wmzek+6dR5Xsyl+3Zih3DxL7gvu2GL6ucpPJ9S63W96e
 7AzSNOfG34MzkH6lpoyaUOjSKWXBNuKQUkhK2
X-Received: by 2002:a2e:93c9:0:b0:38e:4810:4f36 with SMTP id
 38308e7fff4ca-395d8c93098mr29703771fa.9.1779698744243; 
 Mon, 25 May 2026 01:45:44 -0700 (PDT)
X-Received: by 2002:a2e:93c9:0:b0:38e:4810:4f36 with SMTP id
 38308e7fff4ca-395d8c93098mr29703571fa.9.1779698743730; 
 Mon, 25 May 2026 01:45:43 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dca7bcddsm21679061fa.16.2026.05.25.01.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:45:43 -0700 (PDT)
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
Subject: [PATCH v12 1/5] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Mon, 25 May 2026 11:45:20 +0300
Message-ID: <20260525084524.139868-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260525084524.139868-1-mpenttil@redhat.com>
References: <20260525084524.139868-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YtI17S6l6t_QbdYFznvHor7LrPQyyFJKDLsmrQtW1pE_1779698744
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

