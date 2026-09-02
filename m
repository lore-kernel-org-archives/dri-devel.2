Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8436C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 20:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C2010E045;
	Wed,  2 Sep 2026 20:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPo3DI7A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jyobGtUF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B362910E045
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 20:16:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682Hr5km2209789
 for <dri-devel@lists.freedesktop.org>; Wed, 2 Sep 2026 20:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohah
 T+j6al9s=; b=WPo3DI7A9bAW4tlVrg0bqu4V+styJyUGUWS5W2JZCHN1MQPiTEi
 B/GveQ3mT/MrXBHqngiJvivPBht8vzfcWMVEe4SKqmIWxL6trNRvOAqeBCQxa9Cr
 CWxC7O6PRXcoIuZHFmx9f3HHaBfZ14Fm6UC9YMn3bMaA2GNvqkFiKTdYJzVrn8z0
 hJOGd1ybUsWB3nmQ5aLfFb0YTMEd1iqn7U0jVHt4/SGXznL8v5A7BR7nOU0B/Gyh
 gwvi2r+y7o9EnlAP8R003zg6xp9/l3tKssS7AOrIDul135GXM5UYereiVFD5t9Xu
 q6VoVNFAk528wRFtBLUFlQ4ltt5gNafAp0Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gepv5s4hb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 20:16:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so2531411a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788380212; x=1788985012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohahT+j6al9s=;
 b=jyobGtUF0fHixgKqLU2ji4z2wjt0p+iNyFtjjcXPjcWQLiBuNoTPf5V/94HLz8TGQV
 t3TISET84G8sCWqvbfxz4iSmjG122QEDJr66PnYvK88QXok40b4Mxkn0YszhT4vLZP9K
 xRWlnqRFShK7EqAzLabaNMY+qDqTASr1rW9aWHR60GhetZ0LNobLLq9nApDXblpbQiLp
 ROV/CYZ30l5iBZc2Bmf1l3rJtApPG91q1/MPOVQUTuGYaehV0mlaxMowayi2mSXC19Za
 /M4kWfkiJ0TQ/1giV5Ah0SN+MlWDfktU5oQ0taWNQrEql1hV66Xhg/MRgg6XmGIEKvqH
 +xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788380212; x=1788985012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=46siBCCvcvlpzJgw+UUQdDmQusxn/J6ohahT+j6al9s=;
 b=Zq5skKsKD2YFvU0yf9DgYzoSyT2bSbCRdUZk3Xl3/997Je8hMgxGyakWtKK1HuTUJF
 ARnLXIhKpKGrmJSvzqsI1ZiAVzdalhwF6m881YRkG7zHjsKHoNo+XIttw+hPHZaVWo6s
 w6h0yFAmvQbOpoyy5MpVQjmp1eCPBpqcBZulcyyhh1eZvPWTePNU0pWcfq8Pt/DAA1Mn
 xd467iwa5xL27pq6IMxS72kDbphiKt0Gvpv13h7DbxrsDh/8+2vD2GBLgVIJWsUjYb3i
 V1I/np5tzwLb9y22OsqLJpSQfJr8cbkOvWZsY6WaEIBsfhxhCFNwY9U4IvJNcRlY1NLr
 kYHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxF5cXRlkg3Lo/CBfeKgEbVYHhzlNLhE9JZ4VBw/E4iGuOl/RF9Y2UVEviWzJhGh1VtWCJ2lA9zoto=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlcXMt9hgaYlTxN2r5DzdJpG/todA0SfWN7WkT3+tUzh3vRRwg
 lBogvJjLvWKUqBPwySie4t69Bms0ROuQhP+oVRPmUMoPKBcFFN9YMtefzTLrRnbmsV29ksrgrat
 Up6L0L2b8PG9Nc1LG0MdgPC/FCbA5+mRlzlT0yxRYRX5E/0xDeCi9J0qsiRh9BdQmBtFyvBc=
X-Gm-Gg: AYBFou2pkPRol4VhyxXujKS/nkedPwEMKh+MPpzNUuSzhM/s7z7MSVZ88QWLYzJolJm
 qwyAHnc0rOWa6hCmOJ0/4eaINwC4UKlwWUBaCdfo6lgRZQ0TGcgYj0ISn8L/PjCOjdjjtneMHL7
 7jD0l4ShE8eibiEMVColHgPfyJ9woLJcyqVjcpxfBHibCzjjER4q+Wi+fYU0vx18+gyCvqKJMRM
 yotoWDEHecPIB/fZxJJEld335i0MXFwhyEWvKyteuwUYxFNXs1hm9iazOtUiRPxi8BZY89h/pFX
 NTjHNu38K0GUfV0kp+aJA+FPLBHQWF+AtJWDCHizTVcUWner1YJrpql69Z120VCuYJEfJZ4X07u
 hmavbYZwbZ0gFa1BlojFRo4LtKeA=
X-Received: by 2002:a17:90a:c107:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39aedf7c6bbmr11956066a91.1.1788380212423; 
 Wed, 02 Sep 2026 13:16:52 -0700 (PDT)
X-Received: by 2002:a17:90a:c107:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39aedf7c6bbmr11955961a91.1.1788380211806; 
 Wed, 02 Sep 2026 13:16:51 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33256414c60sm497205eec.24.2026.09.02.13.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 13:16:51 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paul Cercueil <paul@crapouillou.net>,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Linus Walleij <linusw@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH v2 0/11] drm: Use devm_of_reserved_mem_device_init()
Date: Thu,  3 Sep 2026 01:46:29 +0530
Message-ID: <20260902201640.2024648-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=T8y8ifKQ c=1 sm=1 tr=0 ts=6a988435 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nZq82LKI3H6k8voUjgcA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: k49M4jD6QndFiHtoJJt_oW-GVS4DoBjP
X-Proofpoint-ORIG-GUID: k49M4jD6QndFiHtoJJt_oW-GVS4DoBjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfX8Rmj2dIe5OAW
 AMEJz6wX2NDylJn5tgbAF8WQG/a/ezFelyKOC3g7kGdyf2ocCxVe1sibxRPp/DvK0hnBCeqCFWk
 kLc6mCQTkdYLSzC1VEzdkimvgv5JZFyle5b84OMOccbsuDFRvFdZEPl0RzhhA921nieJT5oQqWO
 lHvShZePvGWamhZplJVXFBKhb3LQdxBecLOx/61VDW6eByHDVr8465nWj8gZOH16yDqtZIZsiGC
 KvqcyCS6Eoeu3Wg6PsfASCoUjnqE4C+TmKZfAT33zj6AE6k0Pm6ReUZOs7dYsqxaMNd4MqDvp5u
 3pdpxUPqwOZrR0MwaLCGIf1qyT60rQA9zgxu/sjOrhxaspOkL+bO4Q4znu+L4iJC4GzC1GaNh5p
 uDVC0vIz3Sd4ULuTSYv0d69ILdIJb4+cF8tFsbg56NCdHFTUYYx7BenpUaLOiT5pEugfQ0Q0x+N
 iojTAgMaMpw2Qn71heA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3OSBTYWx0ZWRfXziFgRzMu8jQF
 7khuqR6eL6RGs4OtpDG3kTWnrTgSVqDLI9vXJWFe48c7jrAMKqi/8cumzH7gOlhFTEBgW3DPqG9
 xc03e77oe/BVsNhWkw6vejoo+TOAlOQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020179
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

Several DRM drivers manually manage reserved memory lifetime by pairing
of_reserved_mem_device_init() with an explicit of_reserved_mem_device_release()
in the remove or unbind path. Missing the release on any error path between
the two calls leaks the region for the lifetime of the driver.

devm_of_reserved_mem_device_init() was recently introduced to tie the
release to the device's devres lifetime automatically. Convert the affected
DRM drivers to use it.

Note for drivers using the component framework (hdlcd, malidp, sun4i): the
previous code called of_reserved_mem_device_release() explicitly in the
component unbind callback. After conversion, the release happens at device
removal (devm teardown) rather than at component unbind. For standard CMA
or system heap reserved memory, this is benign. Drivers relying on custom
rmem->ops with meaningful release-time side effects may need to retain an
explicit release in unbind; those cases are not known to exist for the
drivers converted here.

Changes since v1: https://lore.kernel.org/lkml/20260703193855.110619-2-mukesh.ojha@oss.qualcomm.com/
 - Carried R-b tag if any.
 - Rebased it.

Mukesh Ojha (11):
  drm: logicvc: Use devm_of_reserved_mem_device_init()
  drm: hdlcd: Use devm_of_reserved_mem_device_init()
  drm: pl111: Use devm_of_reserved_mem_device_init()
  drm: komeda: Use devm_of_reserved_mem_device_init()
  drm: malidp: Use devm_of_reserved_mem_device_init()
  drm: ingenic: Use devm_of_reserved_mem_device_init()
  drm: kmb: Use devm_of_reserved_mem_device_init()
  drm: sun4i: Use devm_of_reserved_mem_device_init()
  drm: xlnx: zynqmp_dpsub: Use devm_of_reserved_mem_device_init()
  drm: aspeed: Use devm_of_reserved_mem_device_init()
  drm: arcpgu: Use devm_of_reserved_mem_device_init()

 drivers/gpu/drm/logicvc/logicvc_drm.c             | 21 ++++++++-------------
 drivers/gpu/drm/arm/hdlcd_drv.c                   |  6 +-----
 drivers/gpu/drm/pl111/pl111_drv.c                 |  4 +---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c   |  4 +---
 drivers/gpu/drm/arm/malidp_drv.c                  |  4 +---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c         | 13 +------------
 drivers/gpu/drm/kmb/kmb_drv.c                     | 12 ++----------
 drivers/gpu/drm/sun4i/sun4i_drv.c                 |  4 +---
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c               |  4 +---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c           |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                     |  2 +-
 11 files changed, 14 insertions(+), 76 deletions(-)

--
2.34.1
