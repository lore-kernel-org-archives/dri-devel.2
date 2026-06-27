Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB4C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 20:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 426ED10E511;
	Sat, 27 Jun 2026 20:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jQwxzQFv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YcdPJ9Xl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94FD910E511
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:03 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65RJ0W7P1869348
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufB
 wKJu9ttI=; b=jQwxzQFvVaWtgUuhCEJwAofHiH4adIImh7BWtIZWUEby4QBwz9M
 uf3m2BYv3YX6Ii6XgxybOxdYk+PH0tf22mkoRLUNXMEsr3RN7r5/m681bGiWwfax
 bUlhpKHDI5zT9e9ISrwSmCV4pvcBWaDV03wEGvMsHEyXFdVGU8/Yz1yVy/A1aaTc
 c/gKDHG53yTBu7e70kKgEGx9DYttnPV2BxJVM1Fk0vGgvxWlq1RJuhZLFIEkJnqd
 8dS2qLfGyAALkoQG1/LrOmtPV27txrqpBqkDgYF9RgDPazw9Wgc/qQgVvFFbE6kq
 ixDV3Fq8Dre0uB04h3/Tdy5IdphOjHZqHJw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27t7sjfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 20:44:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca3374c6aso4873642eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782593042; x=1783197842;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufBwKJu9ttI=;
 b=YcdPJ9Xlc7OQ7fpQayL7KtQ3WdKpz3x+MziHv6LspIreKRehrUIfZU24eCnwfXeRWp
 +q/gn2O/eeIcwu6Nk5sa92QHEvwSjoQEVp5O3RNK44JFx3HLGyEslyBIk4etVHSuZKOi
 uOTSYDYESnRBgRiB4eV8jya+PckeitrjaZbWJI6pj+s0fhUdN/X35M243Aw4krsfwzq1
 UovnyylTppYxvMPI1DNSJg2M90LZsCsC+skgYT2NjqCPTfyhyd51R1MKHcSk6VFE4rCL
 lifjSDMowW5AAFYXRoNDYnSjgw8ysjNbTaRw1X/yBWnmn0+Zk+2a4UZij/fIWRCKUbeG
 T25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782593042; x=1783197842;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ect+Q+S5hithsedm3WC4zkUdX1VhwQDufBwKJu9ttI=;
 b=G6DR4otfx9GabKSflKFshHazNZmq7LyjLogm+qRRSpuMSQ8w/aTOKnH6ntdwsPlXiL
 yx9xlxLjU2AeNLk7iO0fS6wpyLzmKOVI88n+dyfslm44iZKT95o4zu1WdXhLRivVNIqj
 CNOO3YeEF05f1xl2kiFwsWjU+8eILtLMxXqhqZuaDL56GAyrrzW4MCAzSlOKAgpXakgb
 nEevUaUA1rG9YZbpnZIYMYfQM93Ve/tDT591W7wK4YEvkTnnmJnaeqgf2rc+SgyhYjkO
 +Fr/kzUgILbdMV9PdORMQZAfwOVkahSSyiAU7bkq7grpNdufEX94gyp7VJtHyPLgIBbd
 xWoQ==
X-Gm-Message-State: AOJu0YxeAlvdtVZuyBW7EIuCaicZf4aMorpdDcpkFGeSde5rgQzVHwOB
 7Y1sHdfsegv5Scsi7khDZBglQx5EnYB0X7T5oCQFmcy/Vy+GKX8OnvaXO7Tp6+fRuZyQAxZCxUJ
 tEC9xpRb+dhsvzzjZCszXj3L7vBaYokj4Fl76ORUt/2i7dobH4RrDVi6lK2th3QvPNuGCVegOK/
 3hDV8=
X-Gm-Gg: AfdE7cmrt8GhA4js2TytDBhZ1Zhwt3dRP+ppxl6sUmtu0CTvLX+GDttVYfdB40E4Y9w
 R/rUJNOGwsRaYAMwKEF4vGwu7jzZML/HCfYshsmCmVM+rjpS1CKngfs/Xte5haGUIqLfQPDdKxK
 xS7JDVsgFRjSHpf1tHntQZ0i9dTatsFPwN0VvzlOBq/0fOZyX8ZFqVBP1bRYH6Vkt/OtO7Jmtnt
 a9CJ0NXux+0JSU2GlXD5MsO+puwaw07KEHR6r0/FoBQcH9XxGhCbzuqCFIanlOWrRS8HWKp0Mqa
 mdo2nC/PpJwS7iHuD34Pf3bTfkzfSogya1UdVrH951EtLrHn4GOxPX+W6gxttwgEV51UJ0TVnuT
 6sNujvUhjrB7+4koHC6m80uaPNCmygq98goUk
X-Received: by 2002:a05:7300:50c:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-30c84e494camr13514866eec.33.1782593042167; 
 Sat, 27 Jun 2026 13:44:02 -0700 (PDT)
X-Received: by 2002:a05:7300:50c:b0:304:ba84:a0cc with SMTP id
 5a478bee46e88-30c84e494camr13514844eec.33.1782593041333; 
 Sat, 27 Jun 2026 13:44:01 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ca5f14f8asm16882963eec.6.2026.06.27.13.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 13:44:01 -0700 (PDT)
From: mohit.dsor@oss.qualcomm.com
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: [PATCH 0/5] drm/bridge: lt9611c: improve HPD handling and driver
 robustness
Date: Sun, 28 Jun 2026 02:13:52 +0530
Message-Id: <20260627204357.3336040-1-mohit.dsor@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfXxSF9hPhR2Jh4
 r3OMDDrMY6tOao9xM6QTP194g3YXerTwSUVcCivrSTAWxW5ujJ2s/rIOCpjmEXnKoW4sQOKtbGy
 QUKrJDRXiEmyx+IOHPVxEM0L5TEq/rJvmjevKl3PnZ7cUVamaJSstdwO8rnPrNCM+MfZzqO1nRl
 n22QkZ21rwppkjL00dI4j31KESVhUOogRKgufVDKvo4n4lUJtxowytQBi9UcgS5Znaiu+AbeLnD
 YeKVlz1vTvs17Fpfljp54KCfOGCWmwuwhSCfmdZCFogqM5JY4sl1KBRIjYQ10cOnJ4JV/qrSWge
 cpQTvhRJTVy04ss99uzXnNyjnVKAfYfiItqDLsjDDWun61WErQpiLi4DWrxj1fU81WjjYrISzyF
 znjLpr8ZfK1UFLae8HUeuD5K5pLD4u8wnKwqvi+x6bQXJulqnhoOCs8lE3L5q1rPUPdK4Kpyp3p
 lpi3sJcX1BE4mjpU8tA==
X-Proofpoint-GUID: ewITM-08I5apg4pqgBa4gO1ksUM3EmbR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDE4MyBTYWx0ZWRfX7/MgF8/hNw+e
 e789dTmcIFEc9hmB0WcJLLKpLsXFSztSlWoX3ONWtxrtTIPxpuWeNPFTWaGCAGHekKXvEXL2sXz
 FH5U/wCL53P17m1sgMepvTfnQiXCvHw=
X-Proofpoint-ORIG-GUID: ewITM-08I5apg4pqgBa4gO1ksUM3EmbR
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a403612 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uxIXVRn-lxS0ewNwCQQA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270183
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

From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

This series improves HPD handling and overall robustness of the
lt9611c bridge driver.

The HPD status read from the internal MCU may fail when the device
is not fully initialized, leading to spurious disconnect events.
This series mitigates such issues by falling back to a cached HPD
state and adds support for explicit HPD enable handling.

Additionally, it fixes DT parsing and bridge refcount handling,
corrects chip type initialization, and cleans up probe and remove
paths.

Tested on LT9611UXD platforms.

Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Mohit Dsor (5):
  drm/bridge: lt9611c: fallback to cached HPD status on read failure
  drm/bridge: lt9611c: implement hpd_enable callback
  drm/bridge: lt9611c: fix DT parsing and bridge refcount
  drm/bridge: lt9611c: fix chip type initialization
  drm/bridge: lt9611c: clean up probe error and remove paths

 drivers/gpu/drm/bridge/lontium-lt9611c.c | 39 +++++++++++++++++++-----
 1 file changed, 32 insertions(+), 7 deletions(-)

-- 
2.34.1

