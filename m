Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879C606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=SRuUeCW3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEF5510E0A9;
	Thu, 22 Oct 2026 08:25:32 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4059B10E0A9;
 Thu, 22 Oct 2026 08:25:26 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M751701909612; Thu, 22 Oct 2026 09:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=uk6belgLZ4ULVN1tSc57Dgo
 4UnK/rwjpJGEZlGz8kQE=; b=SRuUeCW3kuI01pNa7Hu3Tg3Eo8W7lO0C8cNBXYQ
 sFKV1J7Catn3ZXLEUoGIJetqPavasm604IJf+Ru6Ni67OcavsWTI003JIX5xsKjo
 ge8dbSDg5defGViBje6T4yc5Lcy+4VD0CQGVVpf8XwB+peJVr1NTBGisuc8oNZet
 pJtrhl5GIlkQv4yui4l0/L8f8Z71zNHy5JjSDa9/wqzeg+QpNQAKIHjFpS7amW2g
 DdSGVzKLoWnVpNLSJMKdeHWEYTansKzC7Pi911FxxguZV1x2UriW+w8YMe8AD+vh
 EgpRjyLrndi3bxmIufFS7ldXRrSUB+Hclz31jg9PgWLgE2g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hf88f87ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 09:25:06 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 09:25:04 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v2 0/4] drm/imagination: Clean up MIPS firmware interfaces
Date: Thu, 22 Oct 2026 11:24:50 +0300
Message-ID: <20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFLI2WoC/42NTQ6CMBBGr0K6dgytBI0r70FY0HYKYyw0nUokh
 Ltb8AIuX76ftwrGSMjiXqwi4kxM05hBnQphhm7sEchmFqpUtSxlBboCJh9e5BbwFBhCQrDoGFB
 plK6WFysrkfchoqPP8d20P+a3fqJJ++HeGIjTFJdDPsu9949nllDmuLNXresbKvUg3yc0ZzN50
 W7b9gUTZew91QAAAA==
X-Change-ID: 20261014-b4-simplify-mips-pte-defs-e2be1f613d14
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Matt Coster
 <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792657504; l=2415;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=wZ0b+coGu1+6iWrHM0UzC97RlL/KcSm5gcAcmMeyjUY=;
 b=DFY1PnLXF+U6Ja5SN2q/7rwQp5cEXUxD1gQCiSN+pkJ7fDG3aElxOge97X6pd33Lp+wN328cn
 EgBMykjHiJqBIb7YtRDHSU4MAkbxCC/kgdGkXxclGAjueTsmOEJNtN5
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-GUID: YPN1EWICYuiWmanDokKBzPViA-kRTWs6
X-Proofpoint-ORIG-GUID: YPN1EWICYuiWmanDokKBzPViA-kRTWs6
X-Authority-Analysis: v=2.4 cv=e7+T2qp/ c=1 sm=1 tr=0 ts=6ad9c863 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=gXtLJ4WPg2CJrXxS_-4A:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfX6CvUPNxsCfOa
 I9wpcAGrpXdVjEHa1uzX+5G5ximAUHcAbIJwuVbm89rAdzXovZM9e8pFVo4jASr6tOHLHA1r+NL
 +foBGTET8TT4+PMDt9nlfiK1TVx24us=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMyBTYWx0ZWRfX9eWW4mvV7VFR
 FzHmEEIwJGr/46+ghpcwn2MXft3qkZAx+h1vqFq3lALwD9ociLrA33idQxCzWN2+kzEsx2cECXD
 aTWWkEGDiGtTbuGz0v0M9KLbEcbGyYiyXoy9TFijY0ioSnUHRqMf4jYfioWXaA0P/Zzer+0LIcj
 D472IUvzb8dKuwLM85cauKf57DE9PKitwdvjHx1CbV/BBzf8UsAumN40Wk7u24RL9Ta/MPltQcX
 FEI6Es9eKWMFq8zrNm0T7qUxu8YBH9lFkDQ+uv+A7hZcAtnSOx8MCWzK51PHSbmFin8fMBnQrTk
 WE0asWG/ZnNDN45Rc0Soa2C+u/XY8nELpRfwWfVzPR32LJeRaJp2/fND8HAESVDD/Be5PFQpM7X
 v+M4HwnIKzMLAj9Ilr4ctPsYyRBVxQowPGI6B7r7h/Q3hX8CGnOJQba3QvBkZqkOhG1oRM8S9Hw
 B2Xh0BkAWgkSFg22LgA==
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

1. Limits access to the MIPS firmware interface, keeping its state
   within the relevant implementation.
2. Align MIPS firmware headers with the other processor headers.
3. Improved logging in error paths.
4. Simplify MIPS PTE definitions.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v2:
- propagate the commit update to PVR_MIPSFW_TLB_GET_PA().
- removed the RISC-V group from the target group of this update.
- Link to v1: https://patch.msgid.link/20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com

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
Cc: linux-kernel@vger.kernel.org
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

---
Alessio Belle (2):
      drm/imagination: Limit access to the MIPS firmware interface
      drm/imagination: Make the MIPS firmware headers arch-independent

Matt Coster (2):
      drm/imagination: Improve some logging in error paths
      drm/imagination: Simplify MIPS PTE definitions

 drivers/gpu/drm/imagination/pvr_fw.c               |   6 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |  11 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  79 +++--
 drivers/gpu/drm/imagination/pvr_fw_mips.h          |  49 ---
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |   1 -
 drivers/gpu/drm/imagination/pvr_mips_internal.h    | 309 +++++++++++++++++++
 .../gpu/drm/imagination/pvr_mips_internal_check.h  |  35 +++
 drivers/gpu/drm/imagination/pvr_rogue_mips.h       | 335 ---------------------
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h |  35 ---
 drivers/gpu/drm/imagination/pvr_vm_mips.c          | 162 +++++++---
 drivers/gpu/drm/imagination/pvr_vm_mips.h          |   2 +
 11 files changed, 519 insertions(+), 505 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261014-b4-simplify-mips-pte-defs-e2be1f613d14

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

