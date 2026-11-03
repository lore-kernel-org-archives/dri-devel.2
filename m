Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB0D606EE89
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=ZWkcACQf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0333610F47D;
	Tue,  3 Nov 2026 08:37:23 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EA010E511;
 Tue,  3 Nov 2026 08:37:11 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A35Wq4u3269100; Tue, 3 Nov 2026 08:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=cANI97668GsCuPQO6W/6kct
 9AjkFv8U+ngiTKgyJZu4=; b=ZWkcACQfT6GS2oTE8RETJqRA9IEMwWiohRoTcrk
 e+wV4YXWUZomnqq4rh/QpNTi9ZLI39HGCR1VgUFgnDH52Zx82hsU+RPzYUgw/TZ2
 d4SM+9gV7v7bNa1GqvW+ABwjmHmhnsrzQhWcJI7hMYgghA5C8CdsO0nIDe2yX/GO
 yNEK2BwUUkgDqbLGjVzpaRIKMR7KwGIuWdwRyIYF3Sb647Vh3Oxbwn/lOX0j3L+8
 ktW4JzpV0WWbSr6dL8faIJW+LcIHTy0ErI2GVgwUEyR+gl04Vzi/wsWR6VkPiW0W
 TnScBv1u/DFWHi7bFlk21Hyrcy+jma7NANG006alNiNZ0zA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hn7ft239a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 08:36:52 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 08:36:50 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v3 0/5] drm/imagination: RISC-V and META firmware interface
 updates
Date: Tue, 3 Nov 2026 10:36:16 +0200
Message-ID: <20261103-prep-meta-fw-arch-independent-v3-0-563dbaf1b779@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAACd6WoC/43OTQ7CIBAF4Ks0rB0DNKXWlfcwLigMLSb9CSBqm
 t5dqBtd6WaSl7x8bxbi0Vn05FgsxGG03k5jCuWuIKqXY4dgdcqEUy4Y5QeYHc4wYJBg7iCd6sG
 OGmdMZwxgjBZaacGFpiQZqW3sY/PPl3f2t/aKKmQ0N3rrw+Se2wOR5d6/W5EBhbpExoShnNX8Z
 IcuoNqraSB5LPJPrvnF8cS1jam0aNpaVt/cuq4vhfzeVSwBAAA=
X-Change-ID: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793695010; l=2876;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=S9myfWbC7UBl3b49CPkRxkIKUFPauY5A1Unn3wq/YuQ=;
 b=jppBDapa84q3RwFHj2PPkEhNR7QROmmXBJxxVvGkYiwZNTdmoLK0RmRtM0f13hkizdFMaQjaI
 We/don5Y8FnCuB8pPGJ0NTEJJsD4Ocj5b6JT+lAHLeQke6xpeafvGL/
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: U4kkKWtW81Mlf18E-PfbKhogaDGVxxrb
X-Proofpoint-GUID: U4kkKWtW81Mlf18E-PfbKhogaDGVxxrb
X-Authority-Analysis: v=2.4 cv=HaSB3SE8 c=1 sm=1 tr=0 ts=6ae99d24 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8
 a=gXtLJ4WPg2CJrXxS_-4A:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX7fI1S8OftG3N
 B56LhCUuaTAAi9gJKBE1AkX2tiHXwnX3+h4AKhy9qDA7gnpkjDlQzBUW0SxACGq3+6ZCMeVNMcO
 We94qoUcm7JOWh/Y5+FFxigXIA6zT+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNCBTYWx0ZWRfX0WlOmMIX+H7L
 PeV9rnGxVZMoJCoXrZ6otuv4lO1KaIkywOvCLW7F6nkByc+9X0Ywo82hyBPLFF01fAlru0fl1ZB
 Rh/rpn/euJeXE5XvKS+bK9Vxi7D73gPDey94zw0nAYSQsNgpHvXUnBp78TWbHKe3YHqYSR7mqbc
 3X5gZlgZR0a8BV6U/G1sgvsJdkvkt98IYhRyJ9rOMdn+OX2lHnvbZWnQsZy6/3mNWKj1lYqBcUt
 DwZdtFRa8R+vHtidCEAQCSfFuKK3HsM7PjYBXkK6E6gF4Sr3ILzUo5ECCAMrOrPALagESO5JfSm
 ZHJMNnuCi/9mPxd5CBx8v6V57RYH05LtFT9EiGVsefah5JmdvGaekxouLHunHtG5J74c7OhkEdR
 zt8pIh6yIaiVtB8ja84248S41V8xKzdeO0gbnV92HmoiQp+JvshrLUbnSuORu5eFgCljO09PW68
 KrkdbH6MIlSKgZ1twvg==
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Refactor RISC-V and META firmware interface headers to have a more
generic and architecture independent approach:
1. Limits access to the RISC-V and META firmware respective interfaces.
2. Aligns RISC-V and META firmware headers with the other processor
headers.
3. Add "_fw_" component to the headers filename.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v3:
- Fixed remarks raised by Sashiko in pvr_fw_startstop.c.
- Link to v2: https://patch.msgid.link/20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com

Changes in v2:
- Update the commit messages to better describe the changes.
- Link to v1: https://patch.msgid.link/20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org

---
Alessio Belle (4):
      drm/imagination: Limit access to the RISC-V firmware interface
      drm/imagination: Make the RISC-V firmware header arch-independent
      drm/imagination: Limit access to the META firmware interface
      drm/imagination: Make the META firmware header arch-independent

Alexandru Dadu (1):
      drm/imagination: Prepare heap config header for multi-arch support

 drivers/gpu/drm/imagination/pvr_fw.c               |   7 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |  26 +++
 drivers/gpu/drm/imagination/pvr_fw_meta.c          | 104 +++++++-----
 drivers/gpu/drm/imagination/pvr_fw_meta.h          |  14 --
 .../{pvr_rogue_meta.h => pvr_fw_meta_internal.h}   | 175 +++++++++++----------
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |   1 +
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |  13 +-
 .../gpu/drm/imagination/pvr_fw_riscv_internal.h    |  43 +++++
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |  61 +++----
 drivers/gpu/drm/imagination/pvr_gem.h              |   3 +-
 .../{pvr_rogue_heap_config.h => pvr_heap_config.h} |  26 +--
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |  39 -----
 drivers/gpu/drm/imagination/pvr_vm.c               |  18 +--
 13 files changed, 289 insertions(+), 241 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

