Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF14C982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B83B110F2CD;
	Fri, 18 Sep 2026 10:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="IaI7rP/e";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77ADD10E4EE;
 Fri, 18 Sep 2026 10:41:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dMiX1686909; Fri, 18 Sep 2026 11:41:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=TW09tO1eNYu0QNxueGrr8gB
 mcCAk42NG1cXgKZZLcHw=; b=IaI7rP/ej5WyNogp2bZyIY2tvRICKieisXCj1SU
 WSowHyOvu2nTkklff+ibv3kBX6Y89daXgiMemaQ0m2hYjAILIQWbwgwPv1hs3cVX
 y5JtgjBvq3Hza3TqOjT6plLa3tDXojzpZotId4QykZe0TVhR/aySQhBUnt1uWplu
 dQxflz2SO4xBO397fyFhiaCtK/JRcURffJir4KElwqrEc9YJi5Lw/jgUgC2N5Xot
 D7Cc1K3kRXT/mL7hgtH5NdIjcZMqX3hW9+KPjOJjCXCHb2bL1UOTXZXFnd5063bF
 WhQr6Fa3lQ3oYyZA+E+r/9nvQcJQ/gBKaj/gXtTUhHyZw7g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtunguu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 11:41:28 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 11:41:24 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v3 0/2] Fixes for map() path
Date: Fri, 18 Sep 2026 16:11:12 +0530
Message-ID: <20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgVrWoC/2WMQQ6CMBBFr0K6tmaYCogr72GMKWMLsyiQFhsN4
 e4WNmpcvp//3iyC8WyCOGWz8CZy4KFPoHaZoE73rZF8TywQsIQaUDr3uFl+SlWj0qRLsCWI9B6
 9SfNWulwTdxymwb+2cMzX9b8RcwmSikKjsk1FujmzaydDexqcWCMRv8T8+BExibYigINtDIL6E
 ZdleQOOn9+m2AAAAA==
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=jl0LlIyb/kdZsiN4FL70ADH1UeUo0Gf36OUlMZYY08M=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrRVTeq4DNnAD4ZLVeOhfRP39iXk97vC00eLk6
 Z2vKmvXcSyJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaq0VUwAKCRDQJndZfgLx
 cL5jD/94trGHQDszowJlFB62eoohvE5sbqllmdguslv/bYpuzb40REq0PuvF2WaCtkRGiU+Z5pU
 F+i7frsA7yCZzsdfdQ5H1VYlPA0FLEhlJhde3bdfL21yCjAzGS3v5o4kPg19SnQw6KMDa9S1yDK
 dwGcKyz3cuYRgZ2NvHkyDOleUY176knM3nIV7oTifYlZR0djh0GdCY4X6RRS+e5XHyymJFFOWCZ
 gnbOQ1fF2YxeVfj4crr/uOoq2FXgiOXNunjwk2HAbVNZB+PX3B108GsAquEN0mKuTpWuYcV6/Ha
 XDBr4Ra/VhzWAJrLsEzN5iS1RX16G3vyDN1mE0fYwXM+PargkEIHxdLBRVwGiJkJt6pgmZoN0EX
 oZMEgDWgzBBOWJsTF+eJbyLV7nXecQ321fXvzc2vXKax6ECPdTW6oq5uDpCdYqyIpizxd9ATYHB
 3gaMzXTESmo7AKgkBnQfFUECozhTv6QmldnmO+Vt1+TvKON+22xcnq2wje79gbhX+yVj/hnfGBA
 pllyNXYe3u8g098WmGuPnZkcZuiKMNK1q/GwAc0Rs3+W0phBfH5tLzSpZF7Lpi3sNv6e/ZEPwse
 mXsmLmcjS4f2jP9Sg9FOH8esPKq1J4e9Zsz+Gtdm+gNVd1K1hAJuSqPVEVbM5gJotSsJ1wdlCEA
 6NyGH7y8vfhzMhQ==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Originating-IP: [172.25.128.225]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aad1558 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=BHDeEogJK7FFARuNjgwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: Ysdlp0h79vLmHDHdMRQaS64Vlgp271_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0OSBTYWx0ZWRfXylxXZvYqb03o
 tkgQcyU24EeeXozAFZx3djaddy6wsDPxYtrWyt+7Q5IizvY2Ug8UfO5ud/y1i8UfMUTa6zG0bdM
 qHmEMYuxR1h4bRNJWE/5Gyj1N8x5EWbRPV4uCBqdFL26/2Rf2b5mMW6iNCeOgqoLS7cjIj8UgT4
 EACJ1ZA+/x1rj5lSkL8cwgavkm7qLN6JtChfOcoBkQIuFfVg2WAOxz3rZQkk9YLSPCdGKSJYoms
 8NHfSYa1vE/APvu9DVLrsLXztRMWQUOj/nJ3XAGTtCt/xhcIUBY936nkPUAarfZcZF4hRGZlfM9
 Tx5wl/nNHfjPIx9qNx1/tfvgeIXvisnk3rtti5DW38WQs9gtUVMmpyyhMegs/Fi3FME0PlVXEBN
 Tzn+llw2GqpJZuV02EWkmKZME9HojZilH4LHOJxH8sqa9mVDAm6rLS24dSeE7VTOWp9PE4SoWRp
 5QAYgrB/5Re5vqXVrbw==
X-Proofpoint-GUID: Ysdlp0h79vLmHDHdMRQaS64Vlgp271_Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0OSBTYWx0ZWRfX8mmgdI5/QLOb
 uiYjebj+IcHaZi61+laucmABuTS4797wtPaKRL9bz1rc/v94mC/2cPVrDtwl0JG3cGpKfQKNllW
 bRNFi0CZIdLRdkOmieBo8gLGee0lFjc=
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

Two changes in map() path fix a kernel crash and a map failure.

Patch 0 fixes error path handling which triggers a kernel crash.

Patch 1 fixes prealloc page table memory requirement for a mapping
which led to map failure due to running out of page table space.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v3:
- Fix the description update suggested for patch 1 in v2.
- Link to v2: https://lore.kernel.org/r/20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com

Changes in v2:
- Update as per Alessio's feedback.
- Fixed variable name in the description. Move the error message to a new line.
- Link to v1: https://lore.kernel.org/r/20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com

---
Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

 drivers/gpu/drm/imagination/pvr_mmu.c | 19 ++++++++++++-------
 drivers/gpu/drm/imagination/pvr_mmu.h |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c  |  4 ++--
 3 files changed, 15 insertions(+), 10 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260902-mmu_fix-3923aca60f60

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

