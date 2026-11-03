Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2166606A332
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqroTrqI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BBC10F362;
	Tue,  3 Nov 2026 06:16:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7E810E783
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793686610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxeQ7ppGYBKjK5meXlEqKGqekI9iSYV6fmFE9Pb4Uvo=;
 b=MqroTrqIgjt84lnqIMOy2MlT2wzyvIElh+QdbKrpwvbKvmBFgaJNkwMTF4FpPhXA+mBu2b
 /JuPDLE4AGNL227KXTMkehzRWNTEuz4UncL1yAh8j28yYtKTUR/19UxFGzqiwl9yqzksBZ
 m95yUcXLICDcZrkKFkRCblOmxduRPxM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-tjGsmJVbPGy37dJ-JPKuEQ-1; Tue, 03 Nov 2026 01:16:49 -0500
X-MC-Unique: tjGsmJVbPGy37dJ-JPKuEQ-1
X-Mimecast-MFC-AGG-ID: tjGsmJVbPGy37dJ-JPKuEQ_1793686608
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5baf6f208f6so2004029e87.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686608; x=1794291408;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oxeQ7ppGYBKjK5meXlEqKGqekI9iSYV6fmFE9Pb4Uvo=;
 b=CEG8k8NZgk6RBcyCM2de9icscVES8axY9Sjfox3I2BljDwzzEc/omcQUi3h0HTyh3X
 tuJ3yOXTzLklhZCXVoAFvtrGtyL2I4rMnYOeUWmdhsSmOWi04iJdKZFCi+x5ZOnlp78/
 V8RU08yqIoKfPOb+xjJ1hLMuJLpidnrOGzk+4CCNMNGtk8I++PCubNkg639yUWNz4Opw
 0inUP3IL0Qgb+CeqPPS589/OSF0awbCAkyHpEMpA042XQ1/h/f59LbRrlX5kyMc/Vdh4
 OQVp2zjeVWkI5UX4iIsUa1Tkm8cgFYotqr53SajvCPn08+jQvQsU/yZSZALY+ZyFttx/
 djaw==
X-Gm-Message-State: APuU4Z8MteOCVIHtpHTtFVu3WfI+T/0XVYtRS4nhE6/oOVzG63i6nw4P
 F1JDh+/HRVjAUUmvfIeO+YszDgiRqiGuJLi2rmqbMJmmIRonthGKf0Sz3mJxTdwYZlhmHYkBSMm
 S1TDNQzOOp2SfFQVRkceadQBedl7FHH93M9tTwnede1SqmrgNClxb2k19o5qaqF07JsGF
X-Gm-Gg: AYBFou2eHYtjY76moCGkWCqcTR2o3np9dBQDRb69bGFsBL5oA3IVoNHPLguR4Vb1yaM
 x2RmahY9X8rRJWgj5T8NPHKeA+ayiNsrgci5WeGXw6qTuat6g4nO1L/+628IKWCrQfZH80xMVjX
 DDtdzHfjKOw0oLtUJYvntZNaOu3Q9t7j8bZMx5+9o9x6oWa+il6Yd9qfrS/yLTV1XGLrsT5lRMm
 eSphOtk5YuWfLpUsX8/R+nSdd8jUC7/cDwGIJ6w4djtxCcYfWT5cejYVt4G3lfT7B3dpV7Zmm8e
 YJSHeA2blTmgF1p04FjRh5T3sYrs2IYj1qOClZDMfop+b49bmcZ2Nxtdj2WDrW8xesUAZ1mRoUw
 92FOZ8Ig+H1WxH5jP1eEDvpkqDevbv1aAfLlAG9l1XEnaAOSQO9U5FwhQkNz+wgDNNQxeIw==
X-Received: by 2002:a05:6512:1393:b0:5bf:cfc6:edb2 with SMTP id
 2adb3069b0e04-5bfd951d540mr4443713e87.1.1793686607729; 
 Mon, 02 Nov 2026 22:16:47 -0800 (PST)
X-Received: by 2002:a05:6512:1393:b0:5bf:cfc6:edb2 with SMTP id
 2adb3069b0e04-5bfd951d540mr4443702e87.1.1793686607340; 
 Mon, 02 Nov 2026 22:16:47 -0800 (PST)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe073e0f9sm1964634e87.54.2026.11.02.22.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:16:46 -0800 (PST)
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
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v17 01/12] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Tue,  3 Nov 2026 08:16:18 +0200
Message-ID: <20261103061629.972669-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103061629.972669-1-mpenttil@redhat.com>
References: <20261103061629.972669-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CJCqukPYwWv5UCZd-K-LFi3kZtGMRzrEemB6NzZzbnA_1793686608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mika Penttilä <mpenttil@redhat.com>

HMM depends on MMU notifiers. With the unified HMM/migrate_device
page table walk migrate_device needs HMM enabled.
Enable them explicitly to avoid breaking random configs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
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
index afff1b25b543..6fa03655b575 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -682,6 +682,7 @@ config MIGRATION
 
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
+	select HMM_MIRROR
 
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
-- 
2.55.0

