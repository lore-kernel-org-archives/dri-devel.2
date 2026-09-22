Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7855C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DED10E56B;
	Tue, 22 Sep 2026 05:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="AqOLuhL6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A664610E3E1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 05:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790055286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZqncuA8V9KN45lL/iPHOVqmTI1CzmtLR7XQjhWRrog=;
 b=AqOLuhL6ICB7NAHKvpndRYIH00FR9Tm2ndaUlHHpC6eftbteHGuYQFPNaTiEolX/XEnimW
 kCQnjtfAyV+yOF1cS81b6jGMoL3E59jITAoHPNp7dabHosjnuJrdgSxehJHx97PzNoagJv
 Az1cZTkzN+ahS7/Soj8FhIP0Sd6zJxs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-XdSAH27aMlasoOYjUCA0mw-1; Tue, 22 Sep 2026 01:34:45 -0400
X-MC-Unique: XdSAH27aMlasoOYjUCA0mw-1
X-Mimecast-MFC-AGG-ID: XdSAH27aMlasoOYjUCA0mw_1790055284
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b8ceea282dso879748e87.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 22:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790055283; x=1790660083;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RZqncuA8V9KN45lL/iPHOVqmTI1CzmtLR7XQjhWRrog=;
 b=Ya7OnW20eq5hlROtseJHbMfsQ/E4h/6ndTAo/A77hWdrsrsu004j37erxolNAq4m3I
 t63ECxGYugcmhlMcE2qtXz+//3tKI9WGcxhdFP27sM3XFFEHNlPTjthLh+PE6LmnCKms
 UDLLYoAjKLElH2kenA/FpZD4pExkCPBXJoBV1zHNPnd+oQYtPWEI6OKj1Cny+9AGAdXl
 0Q0iWcIQD66CZvK8EEu4JneEjr/mgvIVn/o6FB9JrVQRKHMz8ROH51vMVgfmUMJ2I1gU
 5YdCRGPdFxzSJqAlDZUDLwXtwd7EGU4ER8gG/5pYRAVtU5wbt9GzMGPeoT7d7OMNti1i
 Gtxg==
X-Gm-Message-State: AFuF++lnzAcVPGL2IMHeVX0wb7gHoEZmQN5pJyuQ7OqzguZ7406JvLZb
 ZoLVwmLX4E0FKd9+X+6aI6vlJTD9twGdMh5fxPf7S5O7uIlebAAgN0hijK7hUDx8dtexFSIGV+q
 rpVx/xFxAl1nu58VHbHy038J5k+DR3JcqSJnAznNfE7o+clAvNi+6RfL60jqgaly5rHtm
X-Gm-Gg: AYBFou16o+dpPZH+m15rPyoHToIYKTM0RpTFTkFs1Gxf0Z7lHVU1H+HWxbWM5vzEWxT
 6shS0S63RKBT4ybccrvfJVrcoNMYfn56hFqIhrvcdwjbQ7cwc0rFkkd38VZcBl56H9LbK+r2Z5d
 dGYkl7OsZsWTTKhegEYfVYt/SXk3y0XrT7sWKl64EWVTRgMBs0aru+EcPaqeFNT3WX75X5Sh3TO
 AtWXtoMmSooL4UulyhUrWSQTGhwx8xNJA+rU0nZSV99mfmLKRD6nYoteTv38kI4HxZR/w6S9gc6
 7TWRC2upX3aRRPoAgNxVusfdy860CmOvo8YyNky9bEHbXmaIxtSq2Ys/51RteHyxwsP48HCRCNs
 uw8R5bp1Y83TmwDmg1f0c
X-Received: by 2002:a05:6512:3402:b0:5b8:b3e0:74af with SMTP id
 2adb3069b0e04-5b8c195ea85mr3626239e87.59.1790055283567; 
 Mon, 21 Sep 2026 22:34:43 -0700 (PDT)
X-Received: by 2002:a05:6512:3402:b0:5b8:b3e0:74af with SMTP id
 2adb3069b0e04-5b8c195ea85mr3626231e87.59.1790055283051; 
 Mon, 21 Sep 2026 22:34:43 -0700 (PDT)
Received: from fedora (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d46e0966sm191742e87.55.2026.09.21.22.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 22:34:42 -0700 (PDT)
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
Subject: [PATCH v14 01/12] mm/Kconfig: changes for migrate on fault for device
 pages
Date: Tue, 22 Sep 2026 08:34:10 +0300
Message-ID: <20260922053421.4092027-2-mpenttil@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922053421.4092027-1-mpenttil@redhat.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RXE6tOtv9_6hthdVYXJuaug3zWQXDcIBLFtbQyST0tg_1790055284
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

