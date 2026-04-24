Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75733FE51FC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BF110F498;
	Fri, 24 Apr 2026 09:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXc8xt3r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ad5NipoW";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7367A10F498
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O7GNNc1822941
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=KfSjDCquPwtnhzWWJgoDqMumMUxQ1tlnJEP
 eeQileIU=; b=dXc8xt3rSUN/NQywe4+ODdZ3ZmAFEK+P6Y3jNlZISubPg35fl9t
 3ZQw5wMBg5G81oT8JvQGlgkDGqHL6qVlmDN5sZwvlpvz3TaREZq6hf8Ivbl0MBZF
 87A53kt20t7oAZfFv7olg7N5CcaSSAyZZvlV0HE6Z9QmqchVXcyeaqN2qndBQsjN
 MITX7pQ53dp6vvZRv6RfxhUy1yXnQK768ucQOgnC8KGBpjjescWFDsGllThjqCKT
 RLkbQoNdPZr820Z5Ca6scoqhQVMuYzXN3sir8ZeBPJxjtp1E6PDBiCaegigrtfS8
 ley7x0CIxG3zmYtn/ULoHzJ77qh+aYQNhAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqv5rt9hh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f896eb6faso8152362b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777024750; x=1777629550;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KfSjDCquPwtnhzWWJgoDqMumMUxQ1tlnJEPeeQileIU=;
 b=Ad5NipoWf2PqNAGmZJdO2PzJpKf2yUzCfwgy9xcafPMN0YNBLu1+BXUrQw3OF5pYYe
 AAOkYsI5kDC2Gv0Zf+gPOd+g53QU4GxEOVkEtmrxwQzZdX6B7V9kerqZOqLfUN6L86Eo
 2/IrNBy2zd4K9y6PhBj1mGN6zhhKtuLs1AtakUh9SNwod6Uk6c11kiEuvhFiZF6JsNIF
 YGNfZDuQfZZ6QDb7uVOxTcInV+dVK6GrmpbMcyPTiyl7NhmFdoEA247+P1LNiW7b/YhK
 G0U8kuJDTg3WJhCz7Q70PmZD6/1esLm2Ic1fymj7jHdtLA7uMcnZtsi52SlklyQaETF8
 JMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777024750; x=1777629550;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfSjDCquPwtnhzWWJgoDqMumMUxQ1tlnJEPeeQileIU=;
 b=CcKqtyL8rPJQkWsaztrskZwmwgsGTttoPw2hzPLtHIAEEsT05clZci9NDrZ32A3GbW
 +AeXgDI9uqnyCMGMy2utxRkWLt2vop3aQfR7Bw/8XCtLOY8lnNYTObDWjkAqXKhA1Knb
 C0Evn5lf6o2AjA+DRUJ8GPWYq3ByfYNG83jpirOPo6Z6doeAQelxUB8EjB96PO5X3nwo
 0wMDVSSpimum6gFDqxON/ZGD7+qnno9en/f0Wd3sfKXoBKg3p2ZqUYSaXr3KxzQPTcez
 H3ucLGZsjOjayBX8nfS0ONNUWy2z90Vj0s27SH+QP4mBhGLyXZdO8mGU0a9QKpnCv4Wu
 ML8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YhbLi3JNFlZb1fJ+Rsb/7hB0X4GpCxfjCWNdQfh1IaDJf4d/O816Y1CXsOawFb6xq7EQLbo7PrT4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzISNqAMETdbOgXfysuRndBsnRv7HMM7fSq9agbZ/lpC3itNthW
 XX87i6OvDMl+QjMeZGnhl7za9gxOjScvyAOGrHVI3Dk/n7tR4JfHzREQpqzXL0Dtrm2FPmhEWe2
 gOpkmZKdhz473/nc9Ex+LCop5fXvRj/JzP9oH9kf4ZbNI14jFJAKdIFn7JWOK8Udnous+Ja4=
X-Gm-Gg: AeBDiesNcwZ8zJBC9DjxU/pOFiGzVTanl8p88FrkJborx1npAcgrSRE1UYBVHdavQhs
 mysFL7xqvwXj1/Wz3TqnXm8BGU/7IOh2TA0WE2V80CUC4O6hB83/d9FGrMMzom5Yq3k+xpIVtn3
 fstPgOt091EOcAktFW8OkxIYPBlfjcKPIPw2m7YcLpIDHo8AXBTNqWLApBUfpdUJLl1q7x5vCYh
 mhETqOv7GoE+X4PWtqWfzuWNHcUTtNm9NvPVImmjaC+gr3rc5cGkJIR5fN7KvgnOEI2KeknCHbu
 pQRvRgvxThJyN4p8K/a+NhX5e4KGDbB45I8EQB6FBMHwYkxvfxlqsIi+3z9D0H4/Fm0jtlOUXre
 O3RMiEx2lUwCLerv8f48FfxG04/zytraMfYsmUYQp7GzXH4rX4cAinAgVDgkLS/jW
X-Received: by 2002:a05:6a00:3385:b0:82a:805a:7cc with SMTP id
 d2e1a72fcca58-82f8c7da23fmr32439330b3a.4.1777024750276; 
 Fri, 24 Apr 2026 02:59:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:3385:b0:82a:805a:7cc with SMTP id
 d2e1a72fcca58-82f8c7da23fmr32439293b3a.4.1777024749858; 
 Fri, 24 Apr 2026 02:59:09 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d35acsm23679702b3a.15.2026.04.24.02.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:59:09 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v10 0/4] misc: fastrpc: Add polling mode support
Date: Fri, 24 Apr 2026 15:28:59 +0530
Message-Id: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LqiiDHdc c=1 sm=1 tr=0 ts=69eb3eee cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: fAiw7i8w59V9IBpOUgT_OL16SJZBJV1p
X-Proofpoint-GUID: fAiw7i8w59V9IBpOUgT_OL16SJZBJV1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MyBTYWx0ZWRfX3Rs5y/rniUOa
 Bf0/5UJzPKrHiM1gRD457UVQmuy+3mHgaZYhKLvsOSYSX4CU8Wjp67cJn5L1zAkrfHJYcuXMbMk
 iEexMvVatIYE0Si3zS02b/oNTz/XNz5a1nkMpj24T6wB/kBZCTMqosmlg1cBJY4D0zsWWTsJ9EC
 mZF0v/pvy8cAJpFp7/3TciLpUmXGJ2yMPfJaGe3xgXkUyV9ph89+d02+jy0/2D++6KL182JwBlh
 YKzG2iXO7qQLobnaj3BgMgjQzyGCapX+d6OEHcdDqt8X1uRiV3zQCxKT5hQUv6bjfyIhcuBRmu9
 zLROzcUNIHKAQWYZRDizb/A7RuphACRt/e8SVv6561Jefx3xqQRJ7CFWD/hA1QJi8LV2zvW9WET
 Vz1SliSw+TizQLHa/NX5KQsK+JC7BESl9d2XLQU2vctC0554XA92PpBynRMF/J0zHK8pB6eBluO
 USRrGFzlGvdBaHBAhtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240093
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
Patch [v9]: https://lore.kernel.org/all/20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com/

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

 drivers/misc/fastrpc.c      | 177 ++++++++++++++++++++++++++++++++----
 include/uapi/misc/fastrpc.h |  25 +++++
 2 files changed, 182 insertions(+), 20 deletions(-)

-- 
2.34.1

