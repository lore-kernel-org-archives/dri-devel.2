Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A157C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9D210E6E4;
	Mon, 24 Aug 2026 10:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXzuErcG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GL9gy/o9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C3810E6E4
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:22 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O99AKw2900586
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=W9AqnDvUfk80kJjzC49ocT
 OI/5jiFU+rbZ2aFlURa3g=; b=iXzuErcGZlnJOYFQMy8GGdkr+0aZ4cDTp1H/tG
 AwkrVGyCHqKhR9us09At8KbH25AehjnjymGX0Fu2KsbM+X01wrhH68NXHeqo5bHM
 K4vg5mt7IvLkCezkmKRnjuOt9+7JGbqMq0usAeZ80ki2KYXIpPNFeDHiA4AaC4lM
 scgBWUjbLi1RJZr6wPlx8FCxBG07L02DElaed0o+wcLTbtLV6HBq8f0/vZsAGgMo
 5EzKegBGOVkHutDKxMR74bwMyMyYfFZA9Pwk3ncGKzPZSvVcQoszdPbBntjxL/kj
 WeLT7Z2eBwUw5PytC48iLLEMquErEOueZCK+UmbT0r1JqlnA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hjgrv2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 10:49:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so6391284a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787568560; x=1788173360;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W9AqnDvUfk80kJjzC49ocTOI/5jiFU+rbZ2aFlURa3g=;
 b=GL9gy/o99YeoHJ75cjX5C8Vd8D5L6RE2XPYL6DLy3D3ADl9wjmmZbbR7tNAyJ+cdti
 3kqC2yMsiSDk8kQNBEUhCsDkLa9zkm+FCaWRI8AzEo5vxt4Uo0vJv3cOLZdNRcBZC6Fe
 a1QIasr6ROwbrdLMFR4X0ZbDSgGRdathEOp0Mmw+6f6c1u5jcG1WIe78aiObYfTonrwC
 dD2FQ0yJPIxh+bYgcUtPGljJwDftd0OLGWRK0Uhdh3AX8MvDzgkE7b8jvc3C7+gDXho5
 CnS47joGT5tJABOD/YhR9uQsqXPNIjWXjvcFi9XDpH51DdXKkGCT3wtT5FojnnA9xC/B
 q7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568560; x=1788173360;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W9AqnDvUfk80kJjzC49ocTOI/5jiFU+rbZ2aFlURa3g=;
 b=Yq0yWsyUvPIcBXVacowG6KzSSfVHI5Bs8ilidy7/Oh4/OP96iz7ahPQ14CQ12fNmHW
 QutY70qIxOWXTJ1YJUXIVclFaSMZguLsA6Gk4+v9LnlJ1U3P/cdQcJEat8Hha4PlSRXM
 y4lWJA9QL8wWCsgerxlQ2WeV+lgrZxPXLUn634BXoLuiD8ZS5VfvRCFhYTsqf+vXDDVk
 TEz0nW6gg4J7Kq/mxqj9OpBhF46PYIsdSnIELqL2CCrU1Zu3l33yIpZeOjKEEHgeBqNA
 XwZxYZ6zmgjN47P2Upz2ONiKhgb302jwHBpc4Dp4WWc7J7EWNs+H2aRHSDv7IJdeUs9Z
 vi8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RooX/Axpl7b0sMI7Xr01MFW5rAbnPUvDSC7IMosCzFoGiTXyCDL5+dQpQYmm7HBQfN7CXi42A3q8g8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lv/DlhWAozcwtfLJNDtpfEDcNSPiTqPh6Y2cV2lSyqyVnNSqjf
 PW5YcGFp7upFMbjDdqLgxGFsPzsosFFgmRqJXNmqDrYknoPYnq2Xb6+62JwVe/RiYX1s2bgh8rg
 7zbJhPpNGK0hZ6gd+JzUxd35J2KjR8IKJeonNUBRksxQ3bhRnvzl68yY34XZUI41dVMRDKspSBF
 Jbe5o=
X-Gm-Gg: AR+sD13SYh4Fm8DllZfKMe4T9YUAiFkUdBKH5Ds0rtVXUXsRNxCx7f4IHeC/sGUpMdV
 aMB7xjnTuv0Ta7Y5iQk/cpF6U3ZzsDuuF1wTMW8X6Hkm/iezC44jgrGeSqB1gQQiUaVZRln/CFd
 yW74c0zx+ngioYcuPV/WFVk4rTjCyyHNUsxOmqK/4dFP9D17Ocufx0/Xg4g5pIf0+Ehm5WAw0jH
 aoHEeF4duwHYF1XFfY5fH1b5fE0tAFf3FLJH2iI3gsxi5QseUkRD7oM5WhFLu1ym3+Hh68b8VSL
 QpFMCowHafrsUJ1cQpZnh96ekFC/baFZRhMgCinTXiwsa7JwPnxu9XoJX/PDHn+S0NUxFxCNdTk
 CAiTo/sYg9viyMuHRioh4SAHl+nai8oX4+Q==
X-Received: by 2002:a17:90b:164e:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-395c352fa60mr37363937a91.9.1787568560589; 
 Mon, 24 Aug 2026 03:49:20 -0700 (PDT)
X-Received: by 2002:a17:90b:164e:b0:38f:2168:b9cb with SMTP id
 98e67ed59e1d1-395c352fa60mr37363831a91.9.1787568560089; 
 Mon, 24 Aug 2026 03:49:20 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c91ce453sm4125829a91.4.2026.08.24.03.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:49:19 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v3 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Mon, 24 Aug 2026 16:19:04 +0530
Message-Id: <20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAhjGoC/3XMwQ6CMAyA4VchO1uyFYLMk+9hPJQxZIk4XGXRE
 N7dwcXE6KXJ37TfLNgGZ1kcslkEGx07f0tR7DJherpdLLg2tUCJlaykhnYagS2vdwyWkAyRUVq
 XIr2MwXbuuXGnc+re8cOH16ZHtW7/QFGBAqx0UVLT6I6Ko2fO7xNdjR+GPA2xehE/xl7WXwaCh
 JZK2Wmja8Lmh7Esyxu6fuuD8wAAAA==
X-Change-ID: 20260609-dup-sessions-ea2acaac1994
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787568554; l=2038;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=ANnA+2kwuTCSv9U2a2VFjXOq4cUZZZE0B/UXz7fbkBA=;
 b=Lb/hqbgOsVYONqGKGOue1K5qPmLYqIXJm6fVB17Qyqq07I7s+pqzamLkLtMrMZWjDfxxL9ESz
 6ngD0Z+F5sLBgXFL1oE9q8RRja5Sb8OvOh6qNsZ1MujFvNvmJGqHnx/
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX1K/geSBWnTGe
 cXZb6/t3tzsTk/qCbZqnczlO/ZeTpmyizb7yjdPPrfc9C9TUy2oI4FMcpFyVZ8Nba1Mm/DhgG3/
 fgsdIqGi+cyQgPKm9AYZNSiKrwvJKfM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MCBTYWx0ZWRfX0DCRJJk7xuT8
 QY0CxiZHpJx7R9nn9MevMcYWobCu8mSZOzPG15AiQ12s8kqSWOf1RIpOcT0bf0aFxu4N37xPVaJ
 zfE/K+njab5y3cbJYK7xemERJr0vThwoK7DWzRznk4GbkUQkEqgktc8EDt5HUUkJhBUJUqP8j72
 BbFTaKeM7pMqXxTCGY4HhSJG3bELA0NOEVlQhsmd2HSCmwcmqv1d+OmzbRxEnk7ZeV86AlWo7mO
 2PuWRW0iB0vR86k2PMv5ZP4IxDqzUVRVfr0MTYNwJea5ERBrMHzQDoVfuwWyZDopopPHTvvQ6h/
 mV5tBfhot4WOw/wof4GIsCBfZksWXJNzrHuuzTTiD3OKSE6y2hJ+5Z5c0kykOVlFNOlIefVdniI
 48ZkP9wh58HQkX68Ofp090WvrsjQftveQtSYDtF3Q6uu7IqCLvcND22uKFXAc7Mcw5lkO+O6t85
 oltsAm1koILb3n0CUQw==
X-Proofpoint-ORIG-GUID: UoIXcY2t_mByEMlLf2cvkzai60h8SlBh
X-Authority-Analysis: v=2.4 cv=CoCPtH4D c=1 sm=1 tr=0 ts=6a8c21b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NE1WMI8jZMYHMT0A9YIA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: UoIXcY2t_mByEMlLf2cvkzai60h8SlBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240090
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

For ADSP, only a limited number of FastRPC context banks (CBs) are
available. Each CB supports a single session, which means only a few
processes can run on ADSP simultaneously. If all sessions are consumed
by fastrpc daemons, no session remains available when a user application
starts, causing the application to fail.

To work around this, some DT set:
  qcom,nsessions = <5>;
which duplicated sessions inline during context bank initialisation.
Upstream feedback indicated that this policy does not belong in DT and
should be handled at the driver level instead.

This series iterates over CB child nodes directly and synchronously,
replacing of_platform_populate(), and moves the ADSP session duplication
to the driver. The qcom,nsessions binding is deprecated in the same
series.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v3:
- Add patch to fix async probe race with of_platform_populate().
- Rename fastrpc_cb_probe() to fastrpc_cb_init().
- Reorder series: sync fix, nsessions, binding.
- Collect Reviewed-by tags.
- Link to v2: https://lore.kernel.org/r/20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com

Changes in v2:
- Added patch to deprecate the qcom,nsessions dt-binding.
- Kept the logic unchanged; only split into two patches.
- Link to v1: https://lore.kernel.org/r/20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com

---
Vinayak Katoch (3):
      misc: fastrpc: iterate CB nodes manually instead of of_platform_populate
      misc: fastrpc: move ADSP duplicate session creation to the driver
      dt-bindings: misc: qcom,fastrpc: deprecate qcom,nsessions

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   2 +
 drivers/misc/fastrpc.c                             | 112 +++++++++------------
 2 files changed, 48 insertions(+), 66 deletions(-)
---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

