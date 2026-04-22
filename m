Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885E0F9B5F5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FBE10EDCB;
	Wed, 22 Apr 2026 09:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C947puJ/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YU+nC1ty";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE1710E98A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M98KcH1080558
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NKqvNe4mpS/uLX7LczWmthkrVulr+nWnWNm
 iC+mC+So=; b=C947puJ/dKgJNtjjlBgEYRC6Eysn/TUcL6xP8j+1etHiVKKusJ7
 0Za6Sku9pJmWtx1bPquCvvLTNqLg9QFUwNytBO0wOc+kCrvSrY0O2WWiyhP8XFx8
 g9nSetkOXkNUAYxeEhLnJS4w8KG6D7NHkHxjkFbRKzPG4i9vLi+d9xT4pvgQuRaA
 odPEtOH+xP4drB8s8JZYLWFtuhdtyPFtZgqX94xktCmBKIUr2MLumYNWryXpkN7U
 N4UukgDfcCzMgQJx9kLgHidxXeCWA6U+bzgKNh/QyNMdKurPCSCJwd0ZmSkEyMc9
 2ovwPQ4MKNdvE03Uww5UucvQJwwX0AbyeCQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpeng2rn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7977177675so2573624a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776849857; x=1777454657;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NKqvNe4mpS/uLX7LczWmthkrVulr+nWnWNmiC+mC+So=;
 b=YU+nC1tyFTYUjImp5OX/pzDvhEJOUW9J7YRdCLonueLCgXvA0IPOznvopp8z+xiQhX
 r1fSMA4OjCeNrzpbTSPlkrnHSTmku859M6l8zDKWiiVp8VzMJ7UqS/rsg3COjevEfuq5
 dmyYDGQwkkU7eZl4grfelsrXG7iKDbcB3PykgTis6u3kRHJ9KMWr9DB6tb2vOHU+71Rp
 K5ZghbFNW6rggZoXNF/yq9Gvo/1g9oL3RDbsWoLr7hGJnpUq06xb46cxXxgNuHqIvrbv
 tRzBKfnNQLnFxqYWrp/ZFzG2fymLoxwBNyeWQfQFtZOj9ww4kZey0Gxc3x8e0k0AZ8qD
 R9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776849857; x=1777454657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKqvNe4mpS/uLX7LczWmthkrVulr+nWnWNmiC+mC+So=;
 b=Wy9y15s5uvcK2JGIFOijcDJ5xFFD/sKGNbc/WMflM2hGOpzBU9XXD1ILM1oTCXinqy
 t2kf4a9asOwkbD+MV/YfDZhb64iBlbhisEK4dt7eoA10Ou4bh0djAQuem03IJf5S3ql5
 QpyiIOc4x/USCPWLR+lOdBJnsYyB4/y93DoXmjMKdpKgHLsmU/ZgU1JiiH7OEZnXnSSf
 7oRyv8OVfBRpiNqXbvlCA6olQDU/T9qjtfB5U+PaAe0UMNXq+2HurKfAVbXn8JMevYF3
 LVGMr+bTqBbR92lHE/frfDFvdQeKXGLsEJ3sJ6SjkxbIHdOTChlYioMP0wHUfhDIavxa
 hufQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M+pLkOPJhs3tj9T4z9J2LeheW2/V2haE6r/9YvrI2/cIT+zKBCtDu/rcHN5B2Y9/YSiIJ1+YQThM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0D2HE1tY+ieLS6blEuHOHvnlSUiwF4nQRlwNwJDYxKY90p4SG
 tEeHjP5tOLMuN/d0ljyWgaILzjB8NFTfWckv/EMOAdXxZdMOzekE+fySwgC4Lqite0NvjBDYozI
 e6J45jIbdtD8fVd8yfblN5FU4rdE/ZkLlwZeEVes8m7hZ2mZ6Vnt2zIHzjNMpbDT1z711Zjs=
X-Gm-Gg: AeBDietRqhKGJBzoZmFlfckDo5ag9a50UW0riclSg3XDkCcj+PrtKBNmiT9YxFcIwKT
 oaRLHEiSmpsDt+BCwNfydL4cG57OU7N8YVuC3AznFv3gkRILtnsQxhH9CGTMRp0wT+ASR0ml2Db
 bm9deDYeQw8AcJ8Scv6w5oHVrBbiJ64/0L6PXbtrdCC4PGikLyYix6VQTr36REisXf/k2OSmKLx
 8gnio3FS2+Z2SeESwEBmdHA8MAzVFTKzIjRs1mcTGReR1WjRQaJdTWNhA3KyA3GkzsZfD/ZvGtL
 veXa/WR877htKKKQ6jwttIngBqnzMMD7xrYSLIwieZLkht7hgm4LjTieABeGI9jIr8+xs2DQROb
 EaVOAKyjnWbti7Aul5o2uBxrVcHXNF2KO9zV1p/ZaRUNlEwhipsAf1BW9Ej6Xu5wj
X-Received: by 2002:a05:6a20:6a11:b0:3a2:d68d:9e7e with SMTP id
 adf61e73a8af0-3a2d68dd1e9mr12341511637.41.1776849856742; 
 Wed, 22 Apr 2026 02:24:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a11:b0:3a2:d68d:9e7e with SMTP id
 adf61e73a8af0-3a2d68dd1e9mr12341468637.41.1776849856235; 
 Wed, 22 Apr 2026 02:24:16 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38ddsm15778576b3a.34.2026.04.22.02.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 02:24:15 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v9 0/4] misc: fastrpc: Add polling mode support
Date: Wed, 22 Apr 2026 14:54:05 +0530
Message-Id: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CNUamxrD c=1 sm=1 tr=0 ts=69e893c1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Ukq7u7DioRJFuzGyon46Wra2LlZ1hrPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4NCBTYWx0ZWRfXzLrzq4DMsGNY
 LXV08n48dkVjSvLFw8vPW74zAy0oj1pyRd1v3ZCqAcSqAs2KC8f/RG7qY1P188Ur7f8pLw0CFUI
 kCYAuAwLUzBaZvW9vr/c79lMdboSpz/iw4howSxi83yOe+aYapi6l5TqVCIPOLtqT8I5EXJ57IO
 uirDrcvGG+qBuqITdo44DAL08LtRkHYYVk/FaImPyaPvlQzFx4g8R8Zh8LQ9ic6BC6sVfcLVn6c
 OqnWuL6qunu8ft92y5T9GICd1nbnFYTZjgyWeidR2CohQI7nS0+xkpHPvoRMsF+12mqr/S2B/wN
 EVIkzWUfXlvwCLI+t9bajg9l1ZwiHzksUTbG+eZQTeFpbYF9EJ7HwQ3xfLIwZbxUkgRgtg9tSN7
 Qlzaurt8Dwfi8QDZHkg+EshAg8E/JXkU0s79iaYV7EpXs+aTkSRK+fy4/kMx1Jsrbt8/Sbg61sG
 hFHXg9UYmP8qpmb4ApQ==
X-Proofpoint-ORIG-GUID: Ukq7u7DioRJFuzGyon46Wra2LlZ1hrPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220084
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
Patch [v8]: https://lore.kernel.org/all/20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com/

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

 drivers/misc/fastrpc.c      | 170 +++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |  25 ++++++
 2 files changed, 175 insertions(+), 20 deletions(-)

-- 
2.34.1

