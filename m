Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C2CCD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 05:45:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C5F410F1D9;
	Thu, 21 May 2026 05:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OXEe49/6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qtptoc60";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D708910F1D9
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:46 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KKlaje2157882
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=BqqubzpdbdtQfA/IGavwMW5/BByOyO7liDh
 sovCQsGI=; b=OXEe49/6MlCPmsETZ3xUsFLCNgzTkjBHG4on5TfbEB0set4pPTD
 nZpez+zgIB8rLyPCM75GC6I8b759vFOTDuKLySUo7YdmIXoRSEjlolmgS4w4Xh9D
 ryiWJfA2jmWEHkqS87NAfsyVGlg0kzWeecNj6IEOxXs0tlPFIx2Gu9o9xg7NRxVW
 wiweW+ZVKsxx4RiIvYlt6/ZwUMUgC6Fdrl/3ebZ0wwWgl2AoGQe/3y7M/jiAOoqU
 Ry5bWxtRI55TboRDTBY2FBiSLjPm3u2B+tUr19kxtr0wxFN9XyyQH4Tzba4xv+ME
 xr5UqZerbzYWbSamR0xT0v8WJCk8gmEDElw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ma41jvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36865d109dcso5347578a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779342345; x=1779947145;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BqqubzpdbdtQfA/IGavwMW5/BByOyO7liDhsovCQsGI=;
 b=Qtptoc60jvrHKqRRdPhmTRMPWCYEJDgHQ2NSFRgym0cZD7n2pHcJQalajNYboKg3ox
 9c9OXuGaKwwAgAiAfh+Y6YVswm78OFyda78+h39orGf6lFGWD/xLCnlvQ3GPJpksCnIj
 xvFGxPEJREXljkCvRsnrovSEgXBma6xAabFYmpajF3Ge0r2LuFc/aCraXbwgCJLXCjf1
 8SCPevdu/alyce7OLBxJ0xZMTPjIRg477MsyLAQUbUh0XOspoycEC55x02oLQ5kKjeUI
 bXzjSr+6u0s5qGbIOgtfQ01JUfV2Ms/7ElbL4s9C7F/gEY8sprieuTwPz4wJyACWY7F+
 95Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342345; x=1779947145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BqqubzpdbdtQfA/IGavwMW5/BByOyO7liDhsovCQsGI=;
 b=R8nIJz+KwFE21usvS6XkDpfphU8ROx1tQVrQJ4tAO9jT8BGws1Lt+rMJlB1Zl55Z47
 UfFrpIkGGVxMMMJZ/mSpRo9pU7gZKfZXShA9F8BPrAwvXJA79aIs9vq3YatG1Qblpd1D
 NDsSXHe0/RvxhSHPkLyGuHrJpy8u1XS1n0JnJpEQaVYlreV1LKCOk5/2iJGpLUdy46gz
 3L+MU17kslwUUnt5f14rp8cFNGFUBKTtR2YOaWJQAh/Trpbb3lCxic+++iH8QFbw1ilB
 +hnMBa+Dh5MUSl8bKdn3RHsyY5FV17EAfQ5DJ5Q1iojvFVVHx7NDGgjKksl8nRjfT+Hg
 7DDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ANcEE0Es0QwjtsqH6Fm+DYR35xbaVgUmokvivx9hRckbisV2Zg8ZgfNglYTeeICtZY66u5ykgKxg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6VPUK9mSwY9RasT1L4hJX9fBF6NWYxrs7KcgSXuMQKrW1Sidh
 LZAbLg56HL+KvhJJ9BBNDBL/zUG1DMckgeYzp0+5D7wxuN1J3LKvfq2xO6AOyZPHOFlyVLPh7ar
 7GyGqp2pnEVov3NKizUi2LmRqQaah0OYXAF6hKx/oEyPsdGPG5tmCtw+0EljVM5rDkXxiw7w=
X-Gm-Gg: Acq92OE6mDfpBwbxhVPqbhzeB5nYrTFCMl+lF+XekT2BR5XcT490wsUITXcB5EEFzRM
 bBwJ1cFLrvvewMOzIqzm3TYyNU2sMHoswoF0rqnRb47zXci6+pF3lVyc/VAgz4XpvZgeu1yNdpz
 GyvmWd+UYk0JS5LtZ24f+utK00QsWzV5t1QSOF3LfxWA88H9yuyPrHTgV1TE/Fmk0dXn7a/LWAP
 yYRBxr579eqLiyGgF/DBNjNYMXoyEs8IkiMSffz69GKiOIXZdVL0W3R9F9OBB0xaZ7pbO4rsS0K
 IlIif/kiS8XTQ/C3opL5F/Av7X7N9lGF8hKtM6ZaZrfxR0B9Vu/8emBZbM60+Zv/gDUVc4h7ENc
 O+rEH3SzsAokzaIxGnV+nB09TdIeSnhZOZwB53c2C3XJ0NqTRH67dXEnmjqW3a/IK
X-Received: by 2002:a17:90b:3811:b0:36a:2a9b:3fb5 with SMTP id
 98e67ed59e1d1-36a455f8dd7mr1388604a91.18.1779342345196; 
 Wed, 20 May 2026 22:45:45 -0700 (PDT)
X-Received: by 2002:a17:90b:3811:b0:36a:2a9b:3fb5 with SMTP id
 98e67ed59e1d1-36a455f8dd7mr1388571a91.18.1779342344735; 
 Wed, 20 May 2026 22:45:44 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb323e3sm1474847a91.4.2026.05.20.22.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:45:44 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v12 0/4] misc: fastrpc: Add polling mode support
Date: Thu, 21 May 2026 11:15:35 +0530
Message-Id: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=K9kS2SWI c=1 sm=1 tr=0 ts=6a0e9c0a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: C-Nmza0IGY3kPAp7kBCLXYFqeth8Yyqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MiBTYWx0ZWRfXzmQyCl0r8HdR
 J+KGMCJgfDjUIrb8iWnFyVCHWj/nyunlrhfkK9/+T8seqkoDXj34PYmQXB9vr7Az6EJztl8dNP4
 jK3nlP19aYwkuEmXTdYNdhBkNtg81Td8GdkkjRnF/8LHhZjjmdfwXIAqDOzVoxi7hZP03nC2+01
 WWVr+XQayVlYw3Yn0FCw/wnmlQHoUN6UgWP85lPNUzVWNkZyuzQc7LHMXb3obVuRMntHcHh8Tn2
 3Vm6Oc16Lp+CZ8vNovD0b6YioE7xgUEO5+5jfnQIw9KLvfNlxHnAQxYjeBaV6AxLoMOZFBLbQK8
 wetN5tYGFM+I8YPrL4/WurdwJTePcPFz5F8+ECT5Berk9ZDikeoJd8YcqqWEeJpCB5a+dW5reKQ
 8T1NldqvG0433faED04R1vDYy9rS3GfC54gYkqaREYAqMEC3HlXqaS5ts2oAJ3WNSL7sZA+U6dq
 zPdnKbdxcuSV89MRzFw==
X-Proofpoint-ORIG-GUID: C-Nmza0IGY3kPAp7kBCLXYFqeth8Yyqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210052
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
Patch [v11]: https://lore.kernel.org/all/20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com/

Changes in v12:
  - Fixed poll_mode_supported check.

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

