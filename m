Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B877F41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CBE10E161;
	Wed, 15 Apr 2026 11:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TV1SR84Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TmmEhkZ0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3589D10E161
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F8fbpX2005518
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=L5W9eUth5C6sQLYvD1LwKVnbRfoQjFfPpVJ
 CNUqAszk=; b=TV1SR84Q/uktgKfoyhVMSkb0ZB5zTpkdVSgayF7ky+uOpKrn+o1
 D7e8Tr0uQN/fv+YDd5If1ebqtqtB1g8QKEFEci4kYg4DMOSp8kxfurVrfbsEtqPP
 oYiiIUeNVTeoIBMSmsYjLRFI5QtKLX/jGnM5CsgIr1OHDGx/Zsd4PbAgUI0p86Np
 jncxP5PulufO//A1FjC5YboaFegppirzTY77Qyd2HsBR87rKgz9Cv5kvI0kExRSf
 44nkdvLSMlhwcPVirwQbLL9UjIp2lItEgPRZeEpyA9aqUUkGUhMjESLAn54OweDz
 qh68yYyRrz5SGMQWbhtxMU9ciP5qOFOa9iw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrsjufb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4678c6171so29181435ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776252336; x=1776857136;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L5W9eUth5C6sQLYvD1LwKVnbRfoQjFfPpVJCNUqAszk=;
 b=TmmEhkZ0YUeGB/KtgL5QcKdQtJuRMh1Zwb4gct98CMWHTR6xwn3IiNZVOB1xB2BjJu
 loJOZV5VLFKz0/zuz7Slv9URRvShjIvE44merdhriyif1I6qUQ/ZOWhmd+IX1qdypPyh
 qU5FeTAa0HmXjXCS5YZgENfgmzfBLXE5Cn84NRvLmtpEFjz4ttDfF1rnbjjY3BjOOqdT
 SMa9NJT+L0gaHMMKVB/n83z0Ri4kvrZqI7ENHANHrsC8xiIhEP7qesqR4rUmaUzoQIky
 ZqHQpfVKNFzCrUWUnB5aVI3LjWTMqKwrrELyeb9bJ8lX++L6blhOECWp144PGHI8lZmq
 nq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776252336; x=1776857136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5W9eUth5C6sQLYvD1LwKVnbRfoQjFfPpVJCNUqAszk=;
 b=CKZaMhFl5UrjTopkrSJBgVmwYA+zYmsK+yrGMNs8EEgl7C21SePAzLNoFwgkH8V1ca
 S5Z8AHzsEf3sR4aM1eVU1z/wQPkOHsgvcK8km5aefZpuGPDK4lqmg6bQiYk8HlaSfz8q
 5sqG+Qo7qEpovR2QQlvsaxb30RgHeHcM/P1Tdk4XHDiVdROWDRdbHq2Fshtrp4+1yD2K
 +QZ6ZejstfsgPd9NQOEAJV101vTpvZNMPhwAsvhGbMWewqvZu5wPJcgcNa+QyIaIAOv2
 DSv8liPQ7RA4xvqhH3MKvd07qG829TF2Cs04J9yvHzExohDlWyZJVVbujsERuFb5zagf
 dlHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ85HorlGmFefKux84p+BCEB1VH2kNsYXFRBUJofUWWq0XUp5I2HaoBeyiaQn24PSjgXyvdYdTxD6EE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIiq6DUqibv3/OQGdad0JrfMzHjzQzp/Y7fAkzsQW7Esgxhtut
 BvCAtU3ZLSReiXQ+DuRKoQzhtChHp+6sWUZ/cRunW9wNHIj6gF3YDD69Rhn3PiZYIbrZRuszUpF
 0L8Dsg7uZ+6XZ+VWLMzbg2a6b7os/jHqDUZU0FFieZUskqCrPJCH0PuIcQOrITNT1mpTvlrw=
X-Gm-Gg: AeBDiesla58K90xJQX6RTA0nqBS8B2vfZF3FK51zghTNHPc5DHSHmnXcnIahxDyQSOE
 hEs2QMSMP7emHFCag8tRDnqEsuddEkNYHniCYvt8B2C4TxNel8T2D2LHJzMx8QLsDOjkAasacN1
 7x0bHQNO5qRi89pMoG1hn4kDshdNOTAb9pfzblpaGUq6wNzheGUV+weFKIeFYsavXY83FdlXLU0
 SpSY2MPvEwKTh0ixbkQbhLBJxBPZBeUEvM5ViWwXTotztdGYnsnc0Rb0OfmjXCCALJQxJFjWCAt
 vxrkOY799QAENTzVP56lvJwDbY4ub/nds8YDiQJFwNYEUGOq8CGcK9QXyRlavtjCe8fllRFGrZ5
 jgjV0Pr6y4ifYDFgKn2P+9xvevHfmkpJgkg3SY6Khny3ga7N6cfkWsHXKVApJjvBg
X-Received: by 2002:a17:902:7003:b0:2b2:5258:a23d with SMTP id
 d9443c01a7336-2b2d59808d0mr153165855ad.14.1776252336171; 
 Wed, 15 Apr 2026 04:25:36 -0700 (PDT)
X-Received: by 2002:a17:902:7003:b0:2b2:5258:a23d with SMTP id
 d9443c01a7336-2b2d59808d0mr153165585ad.14.1776252335662; 
 Wed, 15 Apr 2026 04:25:35 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b6fd8sm26794325ad.73.2026.04.15.04.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:25:35 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Subject: [PATCH v8 0/4] misc: fastrpc: Add polling mode support
Date: Wed, 15 Apr 2026 16:55:26 +0530
Message-Id: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WKhPmHsR c=1 sm=1 tr=0 ts=69df75b1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 3OU_rS914pjxB69s7ST_iNx5_p3N4Cyi
X-Proofpoint-GUID: 3OU_rS914pjxB69s7ST_iNx5_p3N4Cyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX5Wtsbv2TbVsQ
 8mOPfG5K3WjLOnnIqTWwq9wNS9Yhc+z9r5swWtbi1n8/QXD1E5fpYKQWEVrJYbDrqjgkoUKqhOx
 69zzfb2l46qTLGYmdX/PFZ/V4gCzZsTFxkgobj4FzVSnc/EtTHIZHu1r0C8ko6/17hKPUBumrzI
 QKTy0K1YEH151jNmnAxJZ4vbFHhqj9FVraYJeyGYOn8oYZktn50ZzNceKPTj39IsSoWfatda157
 stpPxtodDiQCVTB5C3s3WemVeo9C2MHkXMut/58Fh1LiATTB3cxOoAvS8K0agLnVvd8G/1RC/cU
 2yWeoDYdJGbg6n83kfPwJyFJCuCueLT/9BRKzA6yXq7Jxcxwa3eSeI9NMXqHCagwVlinvpSlaRH
 jBTvMM1HgRN7odhjcpUAP0sGeaXZTSbkKmZDEIWoBa+U/KJx0O3XooUtme0c2fD916i0fBUDJ5Y
 HO8HTiBv2KyuAkRbokw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150105
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
Patch [v7]: https://lore.kernel.org/all/20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com/

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

 drivers/misc/fastrpc.c      | 159 +++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |  25 ++++++
 2 files changed, 164 insertions(+), 20 deletions(-)

-- 
2.34.1

