Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E541BCD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337A810E02D;
	Wed, 20 May 2026 06:50:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V+eFaVkL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wj4/dZ6u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 229BB10E02D
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:50:56 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JMU2b01739353
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=yxNka9h0X4XMJU9qmetE4w7520NEDL25/rq
 /Xg3a2dM=; b=V+eFaVkLPujpyKxpSBCRGwpaMV0la+sBCNRU7xrLkAGS96CXVOf
 FcRzAxRP+Yaz9DNSBd5W+NicwU/7VrmXjq1JdBOBEzt7sS5Q40Z7Lna391geM3U5
 hrPCuAxNEY7Dm45jdPa7rNrI0tt9MTrdNGevCr8uTHtHi5V0miSbIX/JqDe1RepE
 La6NM0sIzxmsVi2lYfBp807cLhalQsbviv0ofsJFOXYbUfhXwp4WsH+IvlWuYGXW
 6lQWk/TU8xbOFUNl8ICNR/yEs+CqvO0C2uGJjPHs8HXHmJD8HjdRgFw1uGIazX/N
 ubRrkdsPY0qr6SF06woi3zwvGzel3k6YlWQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qbb9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:50:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba718173d1so72367425ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779259854; x=1779864654;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxNka9h0X4XMJU9qmetE4w7520NEDL25/rq/Xg3a2dM=;
 b=Wj4/dZ6uP0Hntj3ybWxB/Vyb8pD4TdngIIZOqgri7MhVijm95/jha2Q0lb18zelM2a
 ykMvfUrW9dubgyA04k596ipBemCLyrNCqZGqondAA1GwltQvUnkRnxRG9fpYgTj4X+Av
 g3VvdJy4yvK05FKgWKRJz+4OQHd/mVqqpjuFifByT86awKBsPca41I7PEP8wU6x4Bjhz
 leCRhJXxSUey3PDH4bbFyZ8eSsm/kFvCreNqY1a9IAig1vyk7fsvLMsca+AMJY/CAGaH
 9SCOU9FFd1SYeQ3uCtCuHPxT+Z9YCt+BavzO94b5ZAEPc0+c/eMAvb31UtOnAfN2ebBO
 /0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259854; x=1779864654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxNka9h0X4XMJU9qmetE4w7520NEDL25/rq/Xg3a2dM=;
 b=jH8aDj2oclTUp1+Rw8ob8k4xnlPxJbwTxoMYPg6Kln6L3a4qh4yCl6w6sJW2oWSE8z
 dTZDEuwrOkV4VcXrUeBC5lLxOOPDsDp09VrziC4XpPMi30KRpYqofj0VpHgm7l3j7FZo
 T5DVF0BJxF2DDFnhBPIJqyVmoLjNpenu7xw52W1s9GjQ1mUu1rIvm/WYvc/h+IngRxBj
 Tk2LLjlGVtyvLbZXm7vZd4j723Gfx2cMj0hk7EQTs2zLAq/hcM76VzwOrCN7PqwLLRXP
 8WUaixz1oD3xTdctZP4CXWpppL6o/EOYcY58/1Z7VcmWngK9fZkWExiui+XOh5JvdIb3
 YjgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WOnpde82HrPEEmoeX1irnrDDAvNZykWx1YXnHH9Un/MT1AFqlvcUuwq+dbRmztN54JnnUwKn5XMM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHHEXM+wgaMS31TEfbF5XeRmM2T18EHL6tNzhp8URjhq4VNXHt
 sFeKFleP4SFtj7vFU/+pcoGEjsB4mG+lg/3TAMctxOuYSyD0jS2vFxh5/M3vhd9ZjbNUVYZXL+B
 np7P+sOPewK7/uK2GlVVrDlVwdvwShM2uLlaP0jexx52XKtaovaKXMHf9ThyztSBWkcUyDjo=
X-Gm-Gg: Acq92OHIsW4pNZ02VRiQ2XLDfDIcA3I8McFl4RHKtEycvNkL0bZDYPEIgACWgfgmraD
 A48gWAPJhoJ2rSIvgaQBTl0spnjkHp9grU3LSN6dlrPvuT6tGKOmJSKLM7oyDRbQN6XmVPWxUXA
 cCc3oVpxqmGXhFaLkeBlRJMn/XiTbUxvxZ8Wpqdi6EcYRFW0aauIjPWOFe8fOodLpCgpwWCFwPX
 jtFAQ6LXXvipVRe/qvgUGXSPxd+IXNIX4BhTLHn1rKEKcrev7H1sPFLLMTvYS3C9a6gbQkpGbRI
 izBHUqLJgdBGiqkJaZI3A6ViJCMSRhWPKkk5P5adBBZ22Yu5W5qcpYgr6NjaCnzeaJCkhcennT1
 7hfFJrcAHPg/4NA9Jjr9nSUxsHMdc0Kbba/0pAx/7upmXgfppj394rA==
X-Received: by 2002:a17:902:f78a:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2bd7e8f25f5mr248224415ad.23.1779259854227; 
 Tue, 19 May 2026 23:50:54 -0700 (PDT)
X-Received: by 2002:a17:902:f78a:b0:2b0:ac1e:9720 with SMTP id
 d9443c01a7336-2bd7e8f25f5mr248224035ad.23.1779259853709; 
 Tue, 19 May 2026 23:50:53 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe51sm206410165ad.2.2026.05.19.23.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:50:52 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v11 0/4] misc: fastrpc: Add polling mode support
Date: Wed, 20 May 2026 12:20:43 +0530
Message-Id: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ELidKessAav4s_LAWGD67LVmpFCazoHz
X-Authority-Analysis: v=2.4 cv=LcMMLDfi c=1 sm=1 tr=0 ts=6a0d59cf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ELidKessAav4s_LAWGD67LVmpFCazoHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MyBTYWx0ZWRfX6UgCg5xbO5Cv
 Qmr8jCTk0AIh2vTVutLGp0gvOvc7+b9mTZdKFwb+OrD1dEMrYV9HrLXZKnwNcx2gvBHUudH1DKQ
 6rhqZyBtuAfYOQuFFXKscsQqpEYTvCMNOwiLbF7/mvESNT4vw9NvIm9LKLdDL8qcI3hCAo5YGDA
 gLfpk1O40YYCZd3W9GCRwRZQe0vCfrirKtXBLWLw0XEHz5bzxSRBAi2OMWefulSlTPrhWG2GQT4
 Dry5zMZy71QDTdflnb2mYYQ6gyC+/N52m27LGKJIYHU1WEWJEbpObbMElH1kKsfjPeZJTwkw8Hi
 F7ukUhqOzjys8Byyyu+T/JOXfK5GqpxiY7wwQf8ddrPUv5e33fjM8pBhoD0Na9jl2li4PrGhUW0
 n7g/TZ9XTURnJ/ONeVFr+qXhm+CLihXwiHHl3XGMAHRvZkztTCDhWfcsnlmflOJ5A819Bf66AY2
 9jwJ0bwCrepuQLKKavw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200063
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

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Userspace change: https://github.com/qualcomm/fastrpc/pull/258
Patch [v10]: https://lore.kernel.org/all/20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com/

Changes in v11:
  - Moved back to read_poll*.
  - Improved error handling.

Changes in v10:
  - Add milos and sar2130p to fastrpc_poll_supported_machines. 
  - Updated comment for supported platform list.

Changes in v9:
  - Added platform support check.
  - Moved to readl as per Luben's suggestion.
  - Cleaned up fastrpc_wait_for_completion().

Changes in v8:
  - Added more comments.

Changes in v7:
  - Fixed warnings.
  - Fixed commit text.
  - Addressed clean-up comments.

Changes in v6:
  - Fixed poll memory calculation.
  - Added few formatting changes.

Changes in v5:
  - Add more details in commit text.

Changes in v4:
  - Replace hardcoded ctxid mask with GENMASK.
  - Fixed commit text.

Changes in v3:
  - Resolve compilation warning.

Changes in v2:
  - Added comments and fixed commit text.
  - Defined context id position as a macro.
  - Added new IOCTL to control polling mode as always enabling
    it might cause excess power consumption.
  - Cleaned up polling mode implementation.

Ekansh Gupta (4):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Replace hardcoded ctxid mask with GENMASK
  misc: fastrpc: Expand context ID mask for DSP polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c      | 189 ++++++++++++++++++++++++++++++++----
 include/uapi/misc/fastrpc.h |  29 ++++++
 2 files changed, 198 insertions(+), 20 deletions(-)

-- 
2.34.1

