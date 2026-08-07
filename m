Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E8CC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 07:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6074C10F3D8;
	Fri,  7 Aug 2026 07:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="eBW4lXvB";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52AD10E3DF;
 Fri,  7 Aug 2026 07:17:43 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6775mc8h2406790; Fri, 7 Aug 2026 08:17:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=9jR3Tgs+e+yTatyObdwpX8l
 jt+CnfD9EJfnqLhYq824=; b=eBW4lXvB/v345QcqwT9yp4O72pMpWjYSJQeCrkM
 MrJbSFOOhrAhvAsk7z5jEgCR5gjPowMfqgnE2mnOtHrDm3CVKV3QZkAb04z8nd2V
 BSJpWewuvv9KB3t0VM5cJ2qBkTvX7HUPKfjV3oC/IMakTvlY0bGFzvWLPiSiBtio
 379k1D77datXN0nNIvptwEvK+OraeU6q4zz+DAvi2ahLI3doJqANATNF65VHajqJ
 nWt6SI7qSgGuUox1iNB1uuc6vvedL/iLDch2Od/f7zQKB4gVq1s8FsX7hNye57nk
 +7z/dVV0jzZrKN5JFWxYZ1LxbLG8AE3mZHQVp7okMyaB1qA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fvxy30hv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 08:17:32 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 08:17:30 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/2] Unify repeated register definitions and move FWCORE macros
Date: Fri, 7 Aug 2026 10:17:23 +0300
Message-ID: <20260807-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v1-0-375208fbb579@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOGdWoC/yXNyw6CMBSE4VchZ+1JKppCfBXjopcpHhNa0gJqC
 O9u1d18m/k3KsiCQpdmo4xViqRYcTw05O4mDmDx1dSqVqteabZnXqKEN2dMMDN8HQN7hMImeh7
 TCg5PlzJ4NC6nwt2pC0p59DZoqr9TRpDXr3m9/V0W+4CbvyHa9w8Nez4JlQAAAA==
X-Change-ID: 20260806-b4-unify-repeated-reg-defs-and-move-fwcore-macros-737f00de8bf6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786087050; l=890;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=YCPQ6w+d0PCVVFZdBe9GB62B4H4EqKlzIWKUGGvyZgI=;
 b=hFUbrIb9T9WuWoldc7NemV6XSV1GKt+zDGTorZo7PR4J6HJLT/dAjvUoabFPWWXytMaoL1yfs
 keDbM+f/mmoCk4dm+UB0t4+se3IS4mmWbRFANjpj1c0U929mOMFUf7K
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Authority-Analysis: v=2.4 cv=cZ3iaHDM c=1 sm=1 tr=0 ts=6a75868c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=n2rDnpClJBrIGh5nJN4A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfX7BTTCZgYQH96
 crFwcjxbbJofdDQUxDebPskHOPaI4F15qY67l428TpqON+7QmsYV4u9mM+evPaF4ZuInDb/kyLC
 da07ia07pGdMy7/kch1JEeQkjmarSZeXW1UR9GRMqpuI/ijPIqxIJhrx1NgcstzBMKGRFm8ZfW9
 7edjoxYMEom9vvzeqiAczv6eLSl4wOpjU1Ij5R1t8Pbyz8No5hNahVQMhSUqPKrpUYyuwh6aB5N
 rIuesE+CjBw11v4f+FrJFnJiFlA6JnJ4UkdYNtfDLKxkov/erjMt2PAy/lpnoN4P6crS2XuAvBK
 yn8cvQCtLZEMQKLAZ3SSkHP0kaAV3exuwl9VavVkU0xwh8Vq/8PWfa8HZxdG8pwEGeenYjLSi01
 STlPrlCm+F4e4hqXr14BnxHvyUoLRbNaHjDJIRjbB+T3G6DcdGYgonnGz4sgAzBedAYqxSgqpQX
 mc/mlolWJy3wSPSn2Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfXy98EjVMKk0o+
 fjR/FyjwBO5wfi8TZib2uoyjlfpQNRRpfBJxMe1S+UOMaRD6FljsJFILtHxZ961sEA7BFpDnJNJ
 e7JX0kK4q2Kzh04k3JG2YdnOClBSDBQ=
X-Proofpoint-GUID: 7SnYqle2aPxmYetWWBfpeK5VAWEbFaOd
X-Proofpoint-ORIG-GUID: 7SnYqle2aPxmYetWWBfpeK5VAWEbFaOd
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

Refactor repeated register definitions into base/offset pair.
Move FWCORE_* macros to pvr_rogue_cr_defs.h.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Matt Coster (2):
      drm/imagination: Unify repeated register defines
      drm/imagination: Move FWCORE_* macros to reg defs

 drivers/gpu/drm/imagination/pvr_fw_riscv.c      |  28 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c  |  24 +-
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 920 ++++--------------------
 drivers/gpu/drm/imagination/pvr_rogue_defs.h    |  22 +-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h   |   2 -
 5 files changed, 155 insertions(+), 841 deletions(-)
---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260806-b4-unify-repeated-reg-defs-and-move-fwcore-macros-737f00de8bf6

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

