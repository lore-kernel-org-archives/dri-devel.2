Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D87E85374
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CB510F371;
	Fri,  3 Apr 2026 14:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M3kivujS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B7310F371
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775225595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2OXmkPnk3xdLi6S85WCOSMj2pCVYR8dHaWwnDoveRE=;
 b=M3kivujSkZBsMMNS1fx687nYHgOSxl9V3yDIH+XUE+a7rGvZ7QrK7aaz4vMDNq0K85ryl8
 WcvNVsPLrmdwrp4rucaWZAhPt35tKlWPdw6DSBtD6+OEmTptViT9SsNR8icM8a1ueGfg98
 U/wnwl+wJlpf9UUWg+DdY21huiHWy44=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-wnUVK9plMBe1OpVuoYjSpg-1; Fri, 03 Apr 2026 10:13:13 -0400
X-MC-Unique: wnUVK9plMBe1OpVuoYjSpg-1
X-Mimecast-MFC-AGG-ID: wnUVK9plMBe1OpVuoYjSpg_1775225592
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cd03be011so44949626d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 07:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775225592; x=1775830392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F2OXmkPnk3xdLi6S85WCOSMj2pCVYR8dHaWwnDoveRE=;
 b=PFcMx7VeZ9xIiWdTJeHMQZBAKmxJN8RMg4rpTWqhco6VJ6R+chMcd7FESazK1s4dfC
 I9tyEGMo2rMfRQ+tU7BiK7dqOQZyBTIaDvmqgKGUI83l2n+MCU58gwvVcSdOnp80VCac
 ODhit4L7yIlsoPw6uSedFqJJi+sx+fH4UsE4ntIrkZm4AVhEWqb4VFpJb2iHKUaBTZ8B
 p3+kPcteHV3NRAD3tYZzQo5fJBo2iS/Lo+f29Lyfl5UX4wTIimmqB/+eVpykc6Cf2bN/
 GzzMev5Py3fyjYoT/UL2h04ZFdchn45L/7zny/aqNTBL5KFyggy8MRYCz4JNz85N2u/Y
 MSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2gS/9pisWlWbntwCj9nSyPVu3+acq6YtP6r4ZRWaJwd+xnnF6zBj/RFifRRFcA57I9fm3S/St97k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzpPS0pP4OlSKXq3NUGg4VdFR/gmofb7pce6M1spiWVff/xVPq8
 Dz8Js+GPvSMvJaZkt6ojYZIjEk9+IzvSUYsfmDZNB/ooGzZy/me7S24buYO/3rApuuJ4aLI3tLA
 apIEuy13D0czI32odQDNTlpuIdTmzI/F0Jp3YuVJgKzEDpfE9Bvhv0fIAP0gbZdkuziy1Kg==
X-Gm-Gg: AeBDievwPC+Or7OVisX+BOsZu5jxGSYnwkvaY4huzC1OhzEI0bw/duWZ6wcfiO4LzzD
 DGgTvQ+ndBPPw87elrMO3efyrPOAg8KSgu9IreJq1WSb7a7j56PwKkpA3o5IQIg6nhKK1d/gPs5
 mqry7TDOZqEvb1YVBZ7/4DpxzXW/EYghUCH7BZZWMejRH4JCRbstn2n09w90tbUx27XwvI72uV4
 U5+UdKDdxscnfqP1BGc6S1k6xROrEXliJle3mCCsd9GjR9aNdHOzH3Jjtyn3cWOdm0GGo5+Ctj0
 ndMg+n8D0Atj9AUgMItSkRkJKM5A9JO8+rgaMRszvssH1g2G1irV2bc86Jkq8VWLgyVF2yuKbuB
 95C34LoJEfOkFglfU6d8LA3ffM9/++Fbv01w0AtUjNl7u7gJ6MowpEIbRkWFav6U=
X-Received: by 2002:a05:6214:76d:b0:89f:123c:4d9c with SMTP id
 6a1803df08f44-8a7025b7636mr47917326d6.18.1775225592255; 
 Fri, 03 Apr 2026 07:13:12 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:89f:123c:4d9c with SMTP id
 6a1803df08f44-8a7025b7636mr47916446d6.18.1775225591562; 
 Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net.
 [100.17.19.56]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a593330a98sm50147126d6.2.2026.04.03.07.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:13:11 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 03 Apr 2026 10:08:35 -0400
Subject: [PATCH RFC 1/2] mm/memcontrol: add page-level charge/uncharge
 functions
MIME-Version: 1.0
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-1-c371d155de2a@redhat.com>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KCUFleGTk3hBb_KmGuaXhmnikhtXyB5HB-Rn3zWpCJY_1775225592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Expose functions to charge/uncharge memcg with a number of pages instead
of a folio.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 include/linux/memcontrol.h |  4 ++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 70b685a85bf4cd0e830c9c0253e4d48f75957fe4..32f03890f13e06551fc910515eb478597c1235d8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -642,6 +642,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
 
 int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp);
 
+int mem_cgroup_try_charge_pages(struct mem_cgroup *memcg, gfp_t gfp_mask,
+				unsigned int nr_pages);
 /**
  * mem_cgroup_charge - Charge a newly allocated folio to a cgroup.
  * @folio: Folio to charge.
@@ -692,6 +694,8 @@ static inline void mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	__mem_cgroup_uncharge_folios(folios);
 }
 
+void mem_cgroup_uncharge_pages(struct mem_cgroup *memcg, unsigned int nr_pages);
+
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
 void mem_cgroup_migrate(struct folio *old, struct folio *new);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 772bac21d15584ce495cba6ad2eebfa7f693677f..49ed069a2dafd5d26d77e6737dffe7e64ba5118c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4764,6 +4764,24 @@ int __mem_cgroup_charge(struct folio *folio, struct mm_struct *mm, gfp_t gfp)
 	return ret;
 }
 
+/**
+ * mem_cgroup_try_charge_pages - charge pages to a memory cgroup
+ * @memcg: memory cgroup to charge
+ * @gfp_mask: reclaim mode
+ * @nr_pages: number of pages to charge
+ *
+ * Try to charge @nr_pages to @memcg through try_charge_memcg.
+ *
+ * Returns 0 on success, an error code on failure.
+ */
+int mem_cgroup_try_charge_pages(struct mem_cgroup *memcg, gfp_t gfp_mask,
+				unsigned int nr_pages)
+{
+	return try_charge(memcg, gfp_mask, nr_pages);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_try_charge_pages);
+
+
 /**
  * mem_cgroup_charge_hugetlb - charge the memcg for a hugetlb folio
  * @folio: folio being charged
@@ -4948,6 +4966,12 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 		uncharge_batch(&ug);
 }
 
+void mem_cgroup_uncharge_pages(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	memcg_uncharge(memcg, nr_pages);
+}
+EXPORT_SYMBOL_GPL(mem_cgroup_uncharge_pages);
+
 /**
  * mem_cgroup_replace_folio - Charge a folio's replacement.
  * @old: Currently circulating folio.

-- 
2.52.0

