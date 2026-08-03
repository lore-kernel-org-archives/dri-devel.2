Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B09C5518F
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B208B10E02E;
	Mon,  3 Aug 2026 10:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Qv8I7zjy";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C2A10E010
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 10:22:48 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6735hfks451638; Mon, 3 Aug 2026 11:22:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Gt+w02/oPstQ24Kar2LLzb/
 9vFsxlPpoG+6in6groHg=; b=Qv8I7zjyO+TEdCHCf0McBH2KnKlRZp0RGQYmpRx
 8bY42AuF7WP4cnc6gipYYurj/MUBuJd6E5kGJhFb6Yg4Ifd+7Saqh/8ogGeUcrm5
 et8XbqXhoLbnAdwL/6Uz3+SNkW1MdQpESJPgRvksniIH24odwVSfsBm05PTqvLvA
 QWPoi8/jJU/hRyw7XJHUPFh4u3LLgbtjRkxdKXBpjzKRsurWMPpK3ndLZDdbQPNj
 FFtr+Bt93hwcx6wjFe6ej7ISqA5F9EGC0i49wl5QrYvu3gOznjI5EiYMJ+6yT38t
 PQfwaLQy86TpjmPTgy/vdqSrM1QhA53xFvqdyRZJCBYHXkw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72psc8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Aug 2026 11:22:40 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 3 Aug
 2026 11:22:39 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Subject: [PATCH 0/3] drm/imagination: small series of fixes for the pvr
 documentation
Date: Mon, 3 Aug 2026 11:22:24 +0100
Message-ID: <20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFrcGoC/yXMwQqDMBCE4VeRPXchKti0ryI9pHES10OUrEpBf
 HfT9vgx/HOQIguUntVBGbuozKmgvlXkR5ciWIZiakzTGWta1tVFSZGXPfMwe+UgHyh3CDa4u3U
 PGCrxkvEbStu//tbtPcGv3zc6zwuCSbxGegAAAA==
X-Change-ID: 20260803-staging-pvr-docs-fixes-6ef8fa78a9e0
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785752559; l=844;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=gscLRVhwLpkyg4tr37+s/bdGl979iLisF7Km5lRFphQ=;
 b=G77zm7MPHS4gHfsnpxl/EDG/pgkDOAkzKvt12t9RU+KuQ8+qwxM/l8ApSCYsiK6bS6UwMvYo1
 TEqej17jJPiAYGkLZO410zuuTFBE3gKhFFyK38h9JnRAnVIxquFWRyK
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfXxEUTZ/U9M/3p
 qOibpfmxIDpUeutTr0DvKyXn9ZVLWLCysNUTXfHMUWCqeSjaxb+gWvd8mnZPPSGA+i0MQHKhApg
 07u7oWYdGQWnv7uKbL1Yjpb6gA8BEfo=
X-Proofpoint-ORIG-GUID: B9YYv9GvCAseXSqFz8VXjgUPEoOj4-RF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MiBTYWx0ZWRfX7mmclSOy04X+
 g/jGdELmUkNCZsouYn+9X/xM7wrtcXT9O+559bMwdqM+4o/3HZ7r1fr5pmrNK2YhblAWGd3VrGF
 J+0DNC5Tac1/SjChQk/Gy8CEorQHRi+47857dOCJ3uWZok4cgNES1BROwA79JDWJal5vLWzdEG9
 z8JYU3PQX609w4gfSL8lnDJJR6AJRmBe5PlAn18yKGG/EOgs3nO4EgeU61NpAbhVsSBsrBIMS3S
 g4/J0BOF4JdIwWn6/IH9/UXMDOSvNbnVFjSyKukbj/2eEeRggoKJdl6dZ9cjnfYv+FCrxH9ShGp
 RnVMn9ZBmIS/WDfdd3MiZGkiu9B3KQ1K+WCf7Qpyeypx3qyJRismUveemUq1FI2dWLuBBX98Wza
 +G7fac2QKENnh8y56uHDkTy5pEUkr0HseQnW2YCqVhkzcbEuVTt3LkkBg1fDlAg5UjW315JN4zx
 7W3iXGuChlm/b8bFKvQ==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a706bf0 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=hqTuxnwouQmGYaj8bqIA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: B9YYv9GvCAseXSqFz8VXjgUPEoOj4-RF
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

Small collection of fixes for out of date and incorrect comments
documenting pvr code.

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
Alessio Belle (1):
      drm/imagination: Fix repeated typo in KCCB documentation

Alexandru Dadu (1):
      drm/imagination: Update Rogue heap comments

Matt Coster (1):
      drm/imagination: fixup some docs in pvr_gem.h

 drivers/gpu/drm/imagination/pvr_ccb.c               |  6 +++---
 drivers/gpu/drm/imagination/pvr_gem.h               | 15 +++++----------
 drivers/gpu/drm/imagination/pvr_rogue_heap_config.h | 10 +++++-----
 3 files changed, 13 insertions(+), 18 deletions(-)
---
base-commit: d6c075f797a672a6e3bd2fd44aee713801698ec2
change-id: 20260803-staging-pvr-docs-fixes-6ef8fa78a9e0

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

