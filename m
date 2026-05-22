Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F03CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B9D10E191;
	Fri, 22 May 2026 10:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/ENIXqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AaGajSNh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8651410E191
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:00:50 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8aTRn399102
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iuCxH5D+n2gNFhyOX5Y2of
 7w5Zcuoea+gH2Rlo6K2Go=; b=l/ENIXqkelqIqqwXddP6me3HQDLOS3HeQ6XeQX
 LwNoPTpsDBSv5zrl2ik0fG6gITJ4e+6ClFp+6iaJWWX4u6U4ii/68Z2rW9B7WZ22
 DFV/3IE1SXnSCUPZr3wiPDyH6bTDoVwEP7BjuW9mvpDpX8eLVcQ0ea/75QxDWDyn
 y19PwfJPx3RnVZvQxlxqFVCmDKC8VyrwzrytSsASaY+XKk7VtX8m6VjM1/lLT9rp
 c0pRLs7bh7cboj4U11RSyJOAIzkKgsD+x5KmXnN3deEvJkr7+5ZiNC8/L+R/nLlZ
 Uksb8TOeK7tqFoBFRRjmEs6rgmX5aNIiu3Jo+2/oKV+ddFbg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea5p9urwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:00:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c827bda3052so10698165a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444049; x=1780048849;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iuCxH5D+n2gNFhyOX5Y2of7w5Zcuoea+gH2Rlo6K2Go=;
 b=AaGajSNhAIDS40Tgj+km3Tcw6zZJa2CBEN+IPVW1xbD/Myq/7sBxAzp7hZefgRFsGs
 ZkxU6YnDr/w+FzdWhZcJo+Ant/CV402nDwUbUZtE+CmiLA4oyVNa70YqsvLng3T6MOsN
 kjNC0INZ4LW7i6Pz2ecXXp4gDI/6eOfsioRHLEbcIfFedQf5gzjB/iBCVUnD6IBKuV6h
 GT8Mm4C0H2y7Ez2jfWRrKEn/Nw/hNDhIWVznTFi4I/ZWhKh/nu7Qq//35L+CWbTe6hBf
 SQvD73gCzErWxJVu101vIusPOzsWXVfiJVV79f/DTCOKmv3by1gKMfWvhhIUjejqUomZ
 vyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444049; x=1780048849;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuCxH5D+n2gNFhyOX5Y2of7w5Zcuoea+gH2Rlo6K2Go=;
 b=ndNKyc5zmyGwRaGldGeCQqOEjoEi8yol0O1xsLZ0JE+x81VoJH+WeCOw0g7EvgVAuQ
 1z7GlA/yt4wHWtMa/IU2pNi5RVsit/Bz9aWlslA/cxzYi/+vZHX3ovYGzdE30PJ6P7WF
 23e8iZMnXSZsCOB3d+Sj9fhYI8dX71dkyV+H6fjSgVvKgrgVE34XuMKUUiBOs8Swo8j1
 pDf45ON36+2EcaR0eEGUFSZBRiBeoTaDxyBgo/nOxiVIShWStDpir2tW8NLuo4P/4OyU
 5LQKWb4dkLvdw+mlGFTA4l9ZwqIL5IM5Fru7zPB2/UcWmPhJw28DsAUO1FSFiHt+3VfB
 OMRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+B20Hj2Xh/9zKAZgEndeYhzXGLO8yeGA2FSYGqjZhHA0nCypzMQ8pf/wtzxjlFdVFu3pq1Pxff4KQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywq9q983mnxcB8ZxjPla/awHWJJZtoKfB/WNoDlmmjcrHsmVVfO
 xZdf+73kCbG3vgFEB0VMKlzcrr8sKnO1PfJ+2137ypCYEjHsx1QOieP82S8Qi1OTDpJvg/yZcYg
 W+3fcCv+ji4hGEfHn86iarh75GsyKA5wHnrZdBInEHVQqzIBmoeK/AhpxfYYVBMyFN6RSkx8=
X-Gm-Gg: Acq92OFTpdrFHZ5oTr8nLD1KdgFbRgfIlitKRZdKf/n9Wzf2oHP3yvitPAcsaReA6L+
 6hUrz34Cbzn5WvPzMv331zkM0ywZ9/ccuwZ64OvSJPrEh73qXec2pyVr+X23X68JkmuJUqtHOQ+
 ZgN1QyOJRqNoANuiQ00ZYpPMsEOP4HOjNYgsDv02gWyH9AiewmyqKbjgop1aFGKo7Tk3A/O51uL
 XsM+eg2PWKDk43tU7oZg93HSz49fA+t24939E130IU9A266ZtCe8D9mUrH7NsSjTOd2CslGOmPA
 x0yyiozOk4M3v+Dca3Qlj8pzNnl7On1pkVWPErPhmuijwiV7iSTmuxfmNj284hpfjAffRtn0Qnu
 mbg1PGh0gRdQXny5qatTr6gU1694UqQv2sD4IOwJOyvy+yD3Gg0PVKqt0
X-Received: by 2002:a05:6a00:3e01:b0:82f:1369:7268 with SMTP id
 d2e1a72fcca58-8415f5dcf42mr2983283b3a.30.1779444048768; 
 Fri, 22 May 2026 03:00:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e01:b0:82f:1369:7268 with SMTP id
 d2e1a72fcca58-8415f5dcf42mr2983208b3a.30.1779444048116; 
 Fri, 22 May 2026 03:00:48 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9b74sm1516641b3a.3.2026.05.22.03.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:00:47 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/6] bus: mhi: Fix broken runtime PM design
Date: Fri, 22 May 2026 15:30:31 +0530
Message-Id: <20260522-mhi_runtimepm-v2-0-fbebf41a82bb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8pEGoC/13MQQ7CIBCF4as0s5YGUFJx5T1MY5BOZRKBCm2ja
 Xp3se7cTPJP8r4FMibCDKdqgYQzZYqhhNxVYJ0Jd2TUlQbJpRJCHpl3dE1TGMnj4FnfGOyUtFa
 pBspmSNjTa/MubWlHeYzpvfGz+H5/kuTiT5oF46w3N33Ya21No84x5/o5mYeN3tflQLuu6wcpq
 3SisQAAAA==
X-Change-ID: 20251128-mhi_runtimepm-f7aed52cc557
To: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, netdev@vger.kernel.org,
 mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com,
 vivek.pernamitta@oss.qualcomm.com,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444039; l=3236;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=+1xqvOBtTjhR467f4KD24eV71y2gTMox1bK7uo2F8/c=;
 b=iacSYbanGsCgJO+FPf6WYlX9gd+HwgLu3fqlbeWGrFLEf8k83HR9i9JLXwUGXl1VNyUq9NpK0
 IN5Dw8Qus9yCJf1P0rKQA7/BzSTy5rzWWcg3vO/q5CYIoLB3Wz41hRb
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=DKm/JSNb c=1 sm=1 tr=0 ts=6a102951 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KH93JrovTcJc50lypuwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: MCjxs-NxOz0reu6KotfJPdDtik_rJLyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA5OSBTYWx0ZWRfX+vX0jq9XPCPJ
 5ph0vn8qfjdaieBf3lDIJE69ITumbc43nIi4R6K7fYnAwC0v866G7b4nEaLPgusrck7JKcLPWIO
 l+tDe31xF7NfQBDixrbRApek67K0bwkW26Zbeu0vE/xYXOZEOyNV1Nl6d2us277/I3ZGuzXhV2s
 9FpBC4uQfg+Krgr/8xxSJXa8vtP6+RUE3pOGLohZ2uqnyFJ8cwIFEV6cYJXnESei8qjXDANqawD
 K4gidcEbPKB9I7AsVpGxINFJMwEjjl8+BmcTtGVKgIIVVM5mmuzn5JoEUOi6GVlwOT29g8lkf3o
 vMOBFt0TBDKDEDncxCCftGLwtqFD3ab4pimZIJAbXpgjEYefNIgqqx7FcsOW4ZvBmpVw0HkanFd
 NUje4j98g/FlTfSBE35iD7gC58i7AMueFR17O3B3TOSesyteckD8GlqkJ8Mu3DYCcih3hvf1s+j
 77oYzfJmjmV98t3RM8Q==
X-Proofpoint-ORIG-GUID: MCjxs-NxOz0reu6KotfJPdDtik_rJLyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220099
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

The current MHI runtime PM design is flawed, as the MHI core attempts to
manage power references internally via mhi_queue() and related paths.
This is problematic because the controller drivers do not have the
knowledge of the client PM status due to the broken PM topology. So when
they runtime suspend the controller, the client drivers could no longer
function.

To address this, in the new design, the client drivers reports their own
runtime PM status now and the PM framework makes sure that the parent
(controller driver) and other components up in the chain remain active.
This leverages the standard parent-child PM relationship.

Since MHI creates a mhi_dev device without an associated driver, we
explicitly enable runtime PM on it and mark it with
pm_runtime_no_callbacks() to indicate the PM core that no callbacks
exist for this device. This is only needed for MHI controller, since
the controller driver uses the bus device just like PCI device.

NOTE: As we have dependecies with other subsystems, Mani can you take
these series through MHI tree if other maintainers give a ack for this
series. To all the maintainers please ack to this series after reviewing
so that Mani can take this through MHI branch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- Rewrite commit messages (Bjorn Andersson)
- Remove autosuspend and use normal runtime get/put API's as there is
  already autosuspend in controller driver which waits significant time.
- Add pm_runtime_get()/get_sync() error handling.
- Add rumtime pm for wwan and qrtr.
- Link to v1: https://lore.kernel.org/r/20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com

---
Krishna Chaitanya Chundru (6):
      bus: mhi: Replace controller runtime_get/put callbacks with direct PM runtime APIs
      bus: mhi: Drop controller runtime PM callback indirection
      net: mhi_net: Hold runtime PM during active data path operations
      net: qrtr: Hold runtime PM during active data path operations
      net: wwan: Hold runtime PM during active data path operations
      bus: mhi: host: Fix runtime PM ownership between clients and controller

 drivers/accel/qaic/mhi_controller.c   | 11 -------
 drivers/bus/mhi/host/init.c           |  4 ++-
 drivers/bus/mhi/host/internal.h       |  7 ++--
 drivers/bus/mhi/host/main.c           | 21 ++----------
 drivers/bus/mhi/host/pci_generic.c    | 24 ++------------
 drivers/bus/mhi/host/pm.c             | 18 +++++------
 drivers/net/mhi_net.c                 | 39 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.c | 10 ------
 drivers/net/wireless/ath/ath12k/mhi.c | 11 -------
 drivers/net/wwan/mhi_wwan_ctrl.c      | 60 ++++++++++++++++++++++++++++++++++-
 drivers/net/wwan/mhi_wwan_mbim.c      | 44 ++++++++++++++++++++++++-
 include/linux/mhi.h                   |  4 ---
 net/qrtr/mhi.c                        | 57 +++++++++++++++++++++++++++++++--
 13 files changed, 216 insertions(+), 94 deletions(-)
---
base-commit: a293ec25d59dd96309058c70df5a4dd0f889a1e4
change-id: 20251128-mhi_runtimepm-f7aed52cc557

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

