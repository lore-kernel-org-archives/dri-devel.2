Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DEA106FD84
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F1B10EAF1;
	Fri, 13 Mar 2026 06:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="sQE0ZZ+b";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E85210EAED
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:39:41 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5sO7c2322817; Fri, 13 Mar 2026 06:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=YIwwBRAnlu9AyotaWSSVntn
 QtxwLg6KTo1hImWkEDuo=; b=sQE0ZZ+bA+cQRilVJXHTbvFzHt8bjfS0Im4HAPt
 tXtJ/P2osEU6oeyvm353DABA359a5uA+xEvc0UN1T92tTUB52NYUUdD14WFqO1xB
 UVzYSL/Qca96Isc4+4V/4qpOuQanc3+JYnbCZvfreAMJhRBdwX3ppKZd4q+6VulE
 KLNJizvnQKCiwWPjvvtmeUvW6LxVvDlxqwDjS6IfetHyAz/8moToWnS30BYpWJ3Y
 0Ih6XXxcS3nib07fEmSw1Iev+xya73aNywn6COoJ3N1ELAmGZ4/hecRIFBe7tGjN
 KB2dzCT7T2ON/I2i+C07U0tmmno9WNDqX0a09gtMMI6GVaw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxygj76w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:39:30 +0000 (GMT)
Received: from NP-G-BRAJESH.pu.imgtec.org (172.25.128.99) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:39:27 +0000
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v2 0/2] drm/imagination: Improve power off sequence
Date: Fri, 13 Mar 2026 06:38:23 +0000
Message-ID: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+ws2kC/33NSw6DIBSF4a0YxqUB0T4cdR+NMYAXvEmVhktNj
 XHvpSaddvifwXdWRhARiDXFyiLMSBimHOWhYHbQkweOfW5WivIklKi4qTgl7XHy/KGX8ErdqCN
 1RhPw3hnjpK6VUZZl4RnB4XvX723uASmFuOxns/yuP7f+686SCy6uFyWdlmcL7oajT2CPNoys3
 bbtA3MLcbbHAAAA
X-Change-ID: 20260304-b4-staging-layout_mars_base-dfbbf1a53b3c
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773383967; l=717;
 i=brajesh.gupta@imgtec.com; s=20260107; h=from:subject:message-id;
 bh=CfaOp2rQS41zS4J9MEnmIO1VjNjxFV9h+ixEE6YfIQ4=;
 b=Nirr7F0VawBH78KS00eqb1RBhFsHjmIQ0dXyBE5NxOFuqRu7fNqdoTmR0tYq6mG7jVCMfEk+T
 cY5bGN+EU5zARv73BDnqiLkd1+h454eNoSEIAmGFeA6U+oJ27bKpb6F
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=mxdDr22E/sHiu68U/bLe0W/SRYi3i848ZgoBuEyk21E=
X-Originating-IP: [172.25.128.99]
X-Proofpoint-ORIG-GUID: ARHwZKqu1GOVRMRAmGu3W3gCKSIOhqMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MiBTYWx0ZWRfX8/6PacPJZu93
 7i0YG/LKqIU8/kxEMfVCN9O0peHZf8xvPZxGsI2u5+ROzFBj3RndnZHdDR7KPLddrARkiTD0sKw
 xwQP8M1S5208jAoN4Xdi9URlPOKN0lnqjMXCPZjvX/zh99DUgLeQGEQe7V9vkV5GOdHVxEgecTh
 MD+dxeznURxePoG6XrxAFeAzn/dScse2VeqYf3SWTjJBbbw6ePRJ/d1uV9v5xMsg1TgG44g1M8I
 nod6YAaKsHLt58C9BTG+CGmvel8qN3s8hBu08m3SX+z+s/7s9xOc8bJK1z7NuhZtWBB43dUf080
 +sJ5QAgApFhHXV6uhpc+ziGRMHi3WcX3j1ICuI69VRk93Uw9y6jpuVsBdtZo1lnS0i9YgrIXuZN
 MOWxBBMx57ku0TLPby1aOxtI5egsBNRRCYqGOjup4w+LqNKjG9NYf+AV+L/T8Zj9ZcJYF9wMdpE
 BHNAhYXeOmGMrw+DhSQ==
X-Proofpoint-GUID: ARHwZKqu1GOVRMRAmGu3W3gCKSIOhqMQ
X-Authority-Analysis: v=2.4 cv=NevrFmD4 c=1 sm=1 tr=0 ts=69b3b122 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1Ouegpa_-vYA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=cWoSPm01kt51RX837TEA:9 a=QEXdDO2ut3YA:10
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

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v2:
- Patch updates as per feedback
- Link to v1: https://lore.kernel.org/r/20260305-b4-staging-layout_mars_base-v1-0-09831fa17cef@imgtec.com

---
Brajesh Gupta (2):
      drm/imagination: Improve firmware power off for layout_mars config
      drm/imagination: Skip 2nd thread DM association for non META Firmware

 drivers/gpu/drm/imagination/pvr_fw_startstop.c | 100 ++++++++++++++++---------
 1 file changed, 66 insertions(+), 34 deletions(-)
---
base-commit: 68b271a3a94cfd6c7695a96b6398b52feb89e2c2
change-id: 20260304-b4-staging-layout_mars_base-dfbbf1a53b3c

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

