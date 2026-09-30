Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663A5CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC71410F31C;
	Wed, 30 Sep 2026 11:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="PntTtYYR";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADE310F31C;
 Wed, 30 Sep 2026 11:44:11 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7UFf3261300; Wed, 30 Sep 2026 12:43:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=f1NVjmqUIrj9iofAoxL6NL6
 iTmifSZ3Q1Ln10T52L8w=; b=PntTtYYRf44ADs5YvMAakvZ8pzdDziQfibCiWB7
 TUgy9ncqvl7lEiWTFcKkit1Omo21LzoCPBsfz0rbC92MGX5dZKFnwENjzGNHuOhG
 nYGsA17JCAqH3yGvU0PtntnWpJ7+WQ3c/yBfvF5Vop91V9ycp+//3PpW+pS9ghBv
 Qg1AZ7v181heMTb6D3phBoGbxWK/q2Dk8mvVHpY61YxibnBT76JRfA9T7fFSP6ZV
 l2L4wo0J6RWisrPauZAbb7PNOujMgTs5pPehpqYsvpn2uY6gLf9Wj8hpVBbfjUPJ
 uOAzYgs4jAFUewJIalZOCw1sPOEAAtMbDE2nuHDeMGkzRCg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gx64t3h65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 12:43:55 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 12:43:53 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: MMU defines updates and improvements
Date: Wed, 30 Sep 2026 14:43:33 +0300
Message-ID: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOX1vGoC/yWNwQ6CQAxEf4X0bJMFjIK/YjxAt6s10DW7rtEQ/
 t2KxzczebNA5iSc4VQtkPglWaIa1LsK6DbolVG8MTSuObi+dTjuUZSm4hnnuaDnIMoZo04fK7a
 MopVD3fZd58IxEIPZHsmW7+3pfPlzLuOd6fnTw7p+ASZ9TmaLAAAA
X-Change-ID: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790768633; l=801;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=kY9PNrHnRsnK1pHNVTr1DX6hwQp5zWqpc7srOPMP4/8=;
 b=16T4LH1DdIwMiPzh5U3/9B0SFVZ72AsS4AI/RjeEInZJoLDUny3jLFO7/oaXHIfM5kJB7B6UY
 +8ByaAFUa5RCOAl02wbvu7GobG5sCEFbBAM+6UmvRPedzkZyR6PM+KV
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NiBTYWx0ZWRfXx3X+vNADi3O5
 UkmBQw+RzTt7W4CHhnQLG+ZASwJl0PGXUTEhwM+Q8EOcov3dq7/LtBjbxgSB2nLrBJOd54WxHRE
 LnFATEF2oXgL1Vl0I+stzaYjuSyCdO0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NiBTYWx0ZWRfX7Ye3WndlWsP1
 rboCjPy4Ci9+n99FLUHYWFfc6nsh9rIC54oP2A2bp32xuKYVMaryx49SnLcTnE8BtLWtJAaejN7
 035DxYsSVaiJLUZFxFvnoaDqG5mDgoteWBQ+vmNwtTuVtnCpDJLCVaxonueZ9CwHtTL3evOjoBc
 YGVjJiflLyCKtnxtbC8E9rHrR3+0nL4Y5VV9pgPucyMR6agV8NMJLbvDgc/rt1ojM5VheGpk1Jc
 H0cwv9Jop7g9x4Lu2O2FdyKn2E/ECEVYAEsZeHoJQSrme4ytmTQ35gBEeMIojDASczl5Sy6Ht9G
 vR7iMOmD3laezP+kqqMk4xUSJkiNGSst3qiIE9tBURtfv98Hlus657ktcEuCOiHSVf/EO0Vkws/
 lVvwWM9PqW0QPjDqwjG/0hCDy/NKC5qxS4krg/x6UlhO/q5KZW/T1KRQ6sEloT/m3HQaNHrylNy
 U6Ai+j6V1YHOMCbhY6Q==
X-Proofpoint-GUID: nB421Hgmj8e_GbclUzlRgQgxCmPNLBv5
X-Proofpoint-ORIG-GUID: nB421Hgmj8e_GbclUzlRgQgxCmPNLBv5
X-Authority-Analysis: v=2.4 cv=OasNnRTY c=1 sm=1 tr=0 ts=6abcf5fb cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=zqEJJt7gt7PNtOVAKBUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

- Restrict the inclusion of MMU defines to MMU code.
- Refactor MMU defines to use kernel style and access.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Alessio Belle (2):
      drm/imagination: Switch to kernel-style MMU defines and access
      drm/imagination: Don't include MMU defines outside of MMU code

 drivers/gpu/drm/imagination/pvr_mmu.c            |  91 ++++-----
 drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h | 239 +++++++++++------------
 drivers/gpu/drm/imagination/pvr_vm.h             |   2 -
 3 files changed, 151 insertions(+), 181 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

