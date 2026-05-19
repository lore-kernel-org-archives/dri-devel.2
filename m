Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0E4CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6F210ED85;
	Tue, 19 May 2026 16:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Xki1FUAp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D45E10EDC3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779206483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=T6OjxI0zZxwDX8SXPRnZD+crOhWj/eJOyVt4Fi52IP8=;
 b=Xki1FUApFb36N3OZAj95mXHXWlsVZCy/aGfl4CpElbHTgz3RX/DeOeVwbnXEsNpPnE5+Jd
 OA6M36D36OOzp8Tpzorzf1dm4LX+vdNX0KUH1RXQDGHXe1jAmOE/qZhEiUIlKeIuB0UWIB
 0Ne2yakGS6s8zmIEAbaowCXATzCKNPA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-fD3dEzsjMvOKK5LkXmD7xg-1; Tue, 19 May 2026 12:01:16 -0400
X-MC-Unique: fD3dEzsjMvOKK5LkXmD7xg-1
X-Mimecast-MFC-AGG-ID: fD3dEzsjMvOKK5LkXmD7xg_1779206475
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90d2d8dc97bso885338885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206475; x=1779811275;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6OjxI0zZxwDX8SXPRnZD+crOhWj/eJOyVt4Fi52IP8=;
 b=KBg+iTugZ2aoJqTvSsv+lmogqxT57NlJkD1NUYypWzJvC2nugo+6QbLrh+zJM34lw1
 2ruq0RIp4Db7+ViVoPXqMK9kGqui3wv+rK4QqzaWKg27BtFr+1x4Oyodz92rSpQklIGa
 8+RivuMOMGQlPuO4wuyVm+ss+uu4Tbi0htYIM+Q/sLhIkvbB52WvitwApy3wf4MxTu0+
 K9aZnUr9BKgo7X4mml+VBEMzSuBwX7IB+oRtjhNmeKhVCix7M+8b4I0idzPDcBV3/AF8
 eyXS1T6vPea69OU9E5zTJ85XH6yrP8J9oIcqgJTEcOjJpwWbq99mQWqwAQetSzbG/bxZ
 jIIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8H5lS+U/ghPlWfyUtsO04uGau+9WPK9ojAieeK98bxF29vxtxWJN3P7hpD3pHRSBLEbSnJ9VuQLlQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+cExOK5taXTOZBKBGw54hYveDU2amMNLSBh6Y80LLMg6Zpv7+
 Dfe2YvfW6rDK/+TjP4/7umkoE+mhjREpFdA2Ut/kqDy74zS7SiEo0hPOtoHOlRE9blofkOHYsKL
 wyJEIzTsTvCA7hcpjTQ+IvQICSSHThsuKkhOgOXQy9/3DCxPooDNe4DNZLUmkddbFosRVWQ==
X-Gm-Gg: Acq92OFtZawXnz0tQ1BRU0sDgyjpSlXLH8VykFC75bwIK09zpYUZBx/XRSPjauyLXQC
 AZmSzaiB6V2KHxxppPzd6ze/l8OnQyKqJp3WgHxeyIHsTZKDdINviJGQiKXJ383VFk90Yhg7RPL
 OwADFgaJLlTFcraVsLLEwz/tFvHN5/cTT+CrAssDqCk/+3/dX+ERwVk2erWNiLOX7m3kF6v2qS7
 szXvOHPWqWO147wNdNGxIEf9QG8zRuHCCadUeFBAxiUmsNr3NULGzQ+OaNyq5z4ttOHP4tcYtLt
 SSH7WAKx8kSSjO7z0F8uycXZGIdJSUcSvHZwN5VAJuCCO8j8eBntqEvPYrzq6zdnnXOzPEuzAPA
 7QFYXyeluRlPrGFqK8+altF3cC0Gc4bIsHb2s4uj+su317hjzYXzsShW8Ytk7Sr6ifA==
X-Received: by 2002:a05:620a:460f:b0:911:4cb1:8a60 with SMTP id
 af79cd13be357-911cd178131mr3073463685a.13.1779206455637; 
 Tue, 19 May 2026 09:00:55 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:911:4cb1:8a60 with SMTP id
 af79cd13be357-911cd178131mr3072809785a.13.1779206430240; 
 Tue, 19 May 2026 09:00:30 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc9363fcsm1883933785a.27.2026.05.19.09.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:00:29 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2 0/2] cgroup/dmem: allow double-charging dmem allocations
 to memcg
Date: Tue, 19 May 2026 11:59:00 -0400
Message-Id: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQrCMBCFr1Jm7cgktRZdeQ9xkSaTH7CNJG1BS
 u/uoAdw8Xg8+PjeBpVL4grXZoPCa6opTzL0oQEbzRQYk5MNmvSZWt2jDSUvL3QjjyixAV1ehie
 j4EVw8orIXLwfvAaxxFTnXN7fg1VJ3X+uE7V/XatCQtv2yqmuc6zNrbCLZj7aPMJj3/cPgkfhe
 r8AAAA=
X-Change-ID: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org, 
 Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qv85GFbTnFc0NRb7gKgDpskJtoIZYOJSmBlUQfeTvgY_1779206475
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

Following suggestion[1], offer a cgroupfs entry to allow an
administrator to request that a dmem controlled region also charges to
the memory controller.

Add mem_cgroup_dmem_charge/uncharge helpers to resolve the effective
cgroup from a dmem pool's cgroup, perform the charge and update a
MEMCG_DMEM stat counter.

Add a "dmem.memcg" control file at the root level to configure memcg
charging per region. The setting is disabled by default and locked on
first charge attempt.

[1] https://lore.kernel.org/all/a446b598-5041-450b-aaa9-3c39a09ff6a0@amd.com/

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
Changes in v2:
- Use mem_cgroup_dmem_{,un}charge to account for memcg pages instead of
  exposing raw nr_pages functions. Use it to centralize where to find
  the effective cgroup from the pool's cgroup (Johannes)
- Set depends_on for cgrp_memory if CONFIG_MEMCG by having a memory
  controller in children cgroup (Michal)
- Move dmem.memcg to the root level as it applies by region for all
  cgroups
- Add a dmem memory.stats entry for reporting memcg charges for dmem
  allocations.
- Wrap the memcg enable/disable/lock configuration under a single state
  to avoid toctou races and simplify transitions.
- Link to v1: https://lore.kernel.org/r/20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com

---
Eric Chanudet (2):
      mm/memcontrol: add dmem charge/uncharge functions
      cgroup/dmem: add dmem.memcg control file for double-charging to memcg

 Documentation/admin-guide/cgroup-v2.rst |  23 +++++
 include/linux/memcontrol.h              |  16 ++++
 kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
 mm/memcontrol.c                         |  65 +++++++++++++
 4 files changed, 259 insertions(+), 3 deletions(-)
---
base-commit: d989f135f71699294bb2ffd4726b526456e2db68
change-id: 20260327-cgroup-dmem-memcg-double-charge-0f100a9ffbf2

Best regards,
-- 
Eric Chanudet <echanude@redhat.com>

