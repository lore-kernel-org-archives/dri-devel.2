Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B96CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 05:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811A810E931;
	Tue,  5 May 2026 05:18:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gnuYNIZ3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55ABA10E92F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 05:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777958283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=gnuYNIZ3GOZKj8WbfbI+TAux0w8pDmUroNh0aYba0Cavy3Ue+RzBIgiLLF+K0NxWLPiFWa
 0fqyxioa4dChMU+o1CfHJfJqeJdUBrEV1yMI3yY7lSQTnVl7RAg9QQeRMqkYHT99V3xXT9
 pBHPL6Y2GOhaMRcsUziSW9IZBJvUvy0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-B23_Gr2kNbiHchbTprcihg-1; Tue, 05 May 2026 01:18:00 -0400
X-MC-Unique: B23_Gr2kNbiHchbTprcihg-1
X-Mimecast-MFC-AGG-ID: B23_Gr2kNbiHchbTprcihg_1777958279
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-393800f642cso13604221fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 22:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777958279; x=1778563079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xl5SeCFAdc6WoqyWBYEluyvHLd+oZ4wSvK+mq+H5Z7o=;
 b=dzwkca/iLMbjQfeZG/HJVpGrGO/gsacfnMEmivTW03pp/rqUqzeHNw7JnPakwZiDaN
 yIYP6HHw5q+S9/dE2bSuFRGfesj3Flc7fXIx9fSZ2QfXpeQN1dfphIsrvS76GeXe+OLI
 UzGIUfhN/h/qZP4Rp5SoZpuJkALKMMK64aooAMaSaR7TXe6x+ojG63x1vz1A8NRde1U0
 nqPUBoQHc5Zf6BfuEfIxCY8RsaJDQXxjU8lAv4YYau2dT3bI+SIk24Rc/sMZmz2hsH2b
 h9dhHISgyAvzD7WdYsxb9d2yhlA7Pivci45h3HFWrL20TneKqa376xdLF9J05Kqxq3Lq
 YXLw==
X-Gm-Message-State: AOJu0YyR5zLMUQ6Cj8ZOkkovzhhYHVUPauoFJyIeoKcxGFR+cy41gkM4
 Vw2iasoxN2hlKlZlyTk59m/v6fAN6E1ZCzh5bugedIC58BbucM51mYTtR+yyohWliYwh7yVCnrY
 /HDcqOzQO33RBbveJqtBfaqdT2iU8s6eFysH57hdeJ0p6xXxymRW2cQcACXHzdIuppm8v
X-Gm-Gg: AeBDievsnRlqxvJZ3DxQfwcHbiFiBbQxzVqIcURkwFPqk3x5jUGwUvCddb4uhtlYo6P
 3IlZxejXKItD88WR8iEp2y1WheVNPzO9xvXXf0S7Ge+MeiDAzGdBqG3QtbJ4ZKz8lrYbi4prKOT
 Ccyt0jXDPSayjyRxObOkUKYs/EQWR6S3MR8BDzsX/5Mb7FajeGBh6CfzpqE8FOcmApeaNHXHXE+
 xf83SUlC/1fuR5tcrJngOpgX1F+IEvlp6uh0AyQTFV8lNDBWtMPRhqe251j1OhGrA2P8wMfvAnA
 IgvMjWhY8htaHwR4lI1Y8zfhwSlYnK4okBajd//pjbc44sAlBjh4NJv8vj3ygoiMFss7tgCjWwB
 2Q1kXh0OBHFMZisjoPs+PZnJ85Vmw36ApT8LQJWJq9mXfy30=
X-Received: by 2002:a05:651c:4199:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-393b495a02cmr5464491fa.7.1777958278627; 
 Mon, 04 May 2026 22:17:58 -0700 (PDT)
X-Received: by 2002:a05:651c:4199:b0:38e:186e:350e with SMTP id
 38308e7fff4ca-393b495a02cmr5464161fa.7.1777958278137; 
 Mon, 04 May 2026 22:17:58 -0700 (PDT)
Received: from fedora (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3936138935fsm37206141fa.41.2026.05.04.22.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 22:17:57 -0700 (PDT)
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
Subject: [PATCH v9 1/5] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Tue,  5 May 2026 08:16:54 +0300
Message-ID: <20260505051658.2219537-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260505051658.2219537-1-mpenttil@redhat.com>
References: <20260505051658.2219537-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1KfR6xIgXYl7tmbOMfXrCk4sJ7VdObqgMiRrEjJ9I58_1777958279
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

