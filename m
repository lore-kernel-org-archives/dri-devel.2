Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7460A3816
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TvE9nBZj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFBC510F902;
	Wed, 21 Oct 2026 06:05:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F223310F8F5
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792562730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/j5EYytItjUwk1/CqHyOHSfaQ3+6rA1AecV+p7hbPA=;
 b=TvE9nBZjFADycNCFlVfOLJXjuNejnYdwNUD4Hu7dGHijzQiPWAj6BfAQeAVs7SCDLepXQk
 1m+jzqGvcHz+j2OK+RxhTFre+9sobmLQNRb7MmJrFPs637f1vtEw7X4yKrvL5tJGYynQs/
 3nq91wyy1mdEGinENIT+DvzzeweOUkw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-TGNhcpXnP8GABKhDpqwLnw-1; Wed, 21 Oct 2026 06:05:22 +0000
X-MC-Unique: TGNhcpXnP8GABKhDpqwLnw-1
X-Mimecast-MFC-AGG-ID: TGNhcpXnP8GABKhDpqwLnw_1792562722
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so145126f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562721; x=1793167521;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h/j5EYytItjUwk1/CqHyOHSfaQ3+6rA1AecV+p7hbPA=;
 b=jrF5RFtN7DkCFbnGGrr+SkxbiGoo9ueVUokc1DOYBFoGFHwpZP2fp6i7Fx09junEkH
 EhwNyUslY72cxw6ZfrUXdMg8HJHb+tQ2Zc1AmeUJkVv8LPMb28QUNXafnAcVY3lNghw4
 47hTgXRbJWLPDT/W4i+gXFq0dLKyqkty+vfwHWjnd3XoJV5AFhTugB3rjbVZdvixiqgM
 5MNG9eLoLrsbBS1gj7NOL7gByeSovYPYYWDT8Z9lEIoSKPY0snZy1zJGKg4AWPx+Ua+n
 JMt25dLJtE6s82GR+4aY9+QiMnM3yg4HawE3TKpzlZII6NhanzOGzUr6jadgMO1mK/aa
 XZiw==
X-Gm-Message-State: AFq9FYJT5n6upzavhcGDZ8A6RATrbKstQLca1tuA3XAhKb5T5IFAuzbI
 pY4DUAeicO9kKCtLKUfb4VncUl5KzOesu3+Zla7PHiJiEdgqJqwsj6ZQPYFSf+65PUb5Xw4ZQqs
 rwd6ku+hptkVg5QsSSgd+F4g+uaqpmrcSnnkaezP5j5g1Rc72XPsYnUDit+eFdYIeNPl2XJwE5C
 FH0fY=
X-Gm-Gg: AYBFou1A3fPH3mRbbM4ndCCVhpQdRJyMqR95fbm27jNmfXeYeqMQsPEzhB2l77uDAh4
 BkCE0hrnjYiN/dYhKJpPLQ4me1SCOKOLncATTkXAZlIhHifb3pUSFsd1YXDrH7OntN2K4+6oPhD
 BwSA0eUmPGzCPaMc0Cgu0K736CmppEQ2lSvliaM25g6RtGQdMMAL9l/f8TXBlVySr8fnbpcaQzk
 n9G0RQfQKIY77EQoSNIVAVTeshkiBEGmf+m/zuGnTUOKhH9WSIEpMQzFqPMRybIsLnNGFQS/3pK
 7SODTPqCR5MBNCLUQfGI5gIRglNCeabzmHG8IHaVhuY8Eahpd5NYhhOPXycxt6wTM7YL9jsyeF7
 /YiHx4wXv9neBUySGLVT4m2jS7svENZcayZEx
X-Received: by 2002:a05:6000:2a02:b0:48d:bfd5:79c with SMTP id
 ffacd0b85a97d-48e264d9d19mr1041955f8f.42.1792562721641; 
 Tue, 20 Oct 2026 23:05:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2a02:b0:48d:bfd5:79c with SMTP id
 ffacd0b85a97d-48e264d9d19mr1041925f8f.42.1792562721270; 
 Tue, 20 Oct 2026 23:05:21 -0700 (PDT)
Received: from fedora.redhat.corp (89-27-86-246.bb.dnainternet.fi.
 [89.27.86.246]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm3413741f8f.3.2026.10.20.23.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:05:20 -0700 (PDT)
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
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v16 01/12] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Wed, 21 Oct 2026 09:04:55 +0300
Message-ID: <20261021060506.2377545-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021060506.2377545-1-mpenttil@redhat.com>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HIkPUIaIXqc1SPUGME-HoIcO3OxSQU70ezirAyaUMhE_1792562722
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

