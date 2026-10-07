Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3430CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7B0610E3C7;
	Wed,  7 Oct 2026 11:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0K3CFwz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aS4J4MKO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9E710E3C7
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:38:09 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697BVK1g4178576
 for <dri-devel@lists.freedesktop.org>; Wed, 7 Oct 2026 11:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SCLqHrdRMDamyWTNpn1AL8
 6J7a2kB3ua/9lYaSuJ3BY=; b=X0K3CFwzxAayaOK1TtbGpm0N+yzvMeXqVWfYIu
 fqST2KBf3p07VV2eXmD72p9bOZ7bmV1YdvwB/TRe97/pFIqVtZOBxDoX+V3+OKV0
 L7An974wd4iyoyX7RCgbWasjGT1eF2b14vBQR+o92OuO3cDnlhQDoN/P4C0OICWB
 MWHf5VWngtAAzmhy24nvuBJKLTMrnSr2i0rQt3lP9srkDUr4DDk56vuvIjc9vogD
 m1tJ1N3ge4VHBvpAJid2MrAAL6wlNE7z/4Ut5aZ2h8ltIPFfkqVX+US9QP71PZ+b
 HYhx9b2uLarXjeoI49RsMYqKK1pLxEHVNhWjsglaxuALu1Ng==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c609w22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 11:38:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so6808657a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791373087; x=1791977887;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SCLqHrdRMDamyWTNpn1AL86J7a2kB3ua/9lYaSuJ3BY=;
 b=aS4J4MKO3RE870T+4WAKutY0f+xVSdoPEBY1mT/WucOsWaDKn+48u0Xmi6uaMzOkfI
 o77eQin5CEGpl4KPxDUuQtr+jRbKDMamZejWV74huSWC9aDyjPnzw/hPn6JKb8HAa6aK
 UPFpg2t8H2W7Hj5NEzfsIEKYjc9ATF+AHpSoFJ8OFxX7FXOn/VAu2sVIoaxz/Vkv8v+m
 5i2R58AW6MLF4I/RqJgA79grvBeZTg5tqBV2++DB/AGNZvfXmPVDfviRN0nE97f21nze
 kYBTofj0TEgD3kViaaiyFYWnOhkNCifY4pxzS2UVxqQ/bbPuYzuL3qDbf1ACamZhb/U1
 kkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373087; x=1791977887;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SCLqHrdRMDamyWTNpn1AL86J7a2kB3ua/9lYaSuJ3BY=;
 b=mSjWCYUh6XX/gUXzc7aZoxKaZodhWPNI0u5A0rIpfnO+D0tJ7tTS5C2tQ0JQZnlWKn
 zvO+dUZOjkKc7+Y+wgONTb4j0nk8uEbrb1XQqYg6qzW31kpNMvqOWoMvIcpvm3Yn3bE6
 9O3w6AC0UgnA3sHEDDdzeUg+a+NPmxPX+/w0Ur35y7dZoOZjLiSAqGo3qnAKE/KZg83v
 oBO8wtdp5ORXpQA0f4QuE3/1fgaXly0p/BUdHa+JRJkGUy5ahzV+m6+kmkww+8UxyVj+
 3Ng3EIrA0XumsQyVN/GGkedmEpYy37aaF2PxloCbMXiu2AKcVVbTKiViOW2e2/9vdaCA
 PZLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjmssROE1HnobGW4+X5NqtKh95FqaRF+SO6VYWHI79RKOYBKZIxvK4E3igzgXR6FY4bR5e2v8j2hM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIEqcjzvenIBd6LkNwCyVy9RV3T91nIdVZ3KBK8ZzfIvqJmXKon
 tr0MpyUW8CDPtm5Dn8kZ7qAkckgwwTgfM0d/d68AE0ccXIVa5QD8S7neB6+KnhHZgVkLqLSNTCR
 nBWkFDg3u9ZF9UUUsudGwd36tb2s8VtyPCxqBeayVBBEUVQIJG/BOUz0Q4PtD/rfaIWjlagE=
X-Gm-Gg: AYBFou2zYowrtxp4FHwAYfy51E/joi8nGhXyfE9KFx63O7KkrW8RLtqX8HM4bSEpeBF
 CwKBbqt8S4cyOPEPJ2l6hGjx4bgXu6tXDrXvcGPatw7n15uWYRwFaytO+Wu5yfCm4WhvC98bQQp
 8M+6ZlaZ2BkxZ4hANrIKrJxAt9KgjP79Rti74+slaRrhJNHJHiZjMUsvow4vcxoRPLLw0wAFXie
 eAB9qYog0Gz2O3f8VMJOoXuTh2W8Kl5HcGaeBztE6GFwMBoxI2vGH9vM+LBqcRpR5/2sRAUV4Nv
 xGcGPqCll0s0DJI5pyoJeXJFobFrVmmJGg45tUsnOS0zwgNY/dEaUBTZaspjb0XCQxsbo1LNDi3
 Tpmwe+VKqal3iD5JZxTFcZ0/7Dh9iLzrH
X-Received: by 2002:a17:90b:2584:b0:3a0:7cbf:b8cd with SMTP id
 98e67ed59e1d1-3a8a17f8da5mr1710271a91.14.1791373087011; 
 Wed, 07 Oct 2026 04:38:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2584:b0:3a0:7cbf:b8cd with SMTP id
 98e67ed59e1d1-3a8a17f8da5mr1710247a91.14.1791373086529; 
 Wed, 07 Oct 2026 04:38:06 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8a5e0eeb6sm1454001a91.2.2026.10.07.04.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:38:05 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v2 0/4] misc: fastrpc: add extended IOVA mapping support
Date: Wed, 07 Oct 2026 17:07:47 +0530
Message-Id: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsvxmoC/3WPS27DMAxEr2JoXQXUx6rlVe5RZCFRdCKg/kSyj
 RSB7x7Z2WTTDcEZgMM3T5YpRcqsrZ4s0RpzHIci5FfF8OaGK/EYimYSpIFGGk6PmYZAgfdumuJ
 w5dZD4wGVgCawcjYl6uLjiPy5vHWi+1KS57fJvMvEcez7OLdVjTpoYawB7ZWqUTXe47f1KDoEB
 VrapmymY59EBXDnMWB5WCaeKe/cmZOTDp1DYa1u15rt/28xz2P6Oxqu4gD4v8wqOPAA2qBAb53
 tzmPOp/vifnfeUxnssm3bC2KmB/I3AQAA
X-Change-ID: 20260826-extended-mapping-9b08b0c3108d
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791373080; l=2625;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=gD+sZ/XfrHoeN0nWyfXWUolsOlsAlPdOWWDPH+/1dI0=;
 b=4f5g65+nQpadyWvy9XnL7GP5GyYDJdMYOEVAV15iwEdCkAjPxUAXj3rHuGhCzStYbAafzUT5x
 +ZD33dIOYyuBQ6+Ix8prgKtIxSuF2v+C8jdAH5XbjAMLYUQ6VskOYxG
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: 0RCfWnlEqWQ8fd75Shw7dSNh91ZBpt1x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX7qMsaWwQCiyc
 zV9DdRvGHPA8jPUdBvRsjXkTTVEDLws/YJpBYf61lNBCEAyG4/eLpijAd14l4e/8cCLri1EJzr7
 qcUS+MgZ7aAGrufyNx4Drf4vJZDKZAk=
X-Authority-Analysis: v=2.4 cv=PM+aavqC c=1 sm=1 tr=0 ts=6ac62f20 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QMnnIbI3AxnTgdsYXzkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 0RCfWnlEqWQ8fd75Shw7dSNh91ZBpt1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NiBTYWx0ZWRfX2I1VDB4QGlfs
 EV48iaopeZZTuv4GPnoGCyvf0sCVszFCNsA/jcXAl2ziRwFZQQTTDOxuXNJTaVLLzw5sfk7282N
 CldMTy2MyMSk+sWr0eL8vqAslq5I2mQ5Xuig6TSEdhYfRkk8udpGKovbG2ONc/PJvpPGc4J6AB2
 im8I/wO9+N8bfzMFZby+m3i1cCc4ssZyqVFi4hrbRBFjq7rwYuEEK/4rB/rI+XTbFJddIiCE2WS
 PinjOqu40nVUr3Zx2JIUYsRTRrUGeuh1yGaoEE+zpzp6xL4KYGjQGN3SjEsxg1ubUB2P2U57e5Z
 RtEOcUDi/TOAXeJuPSlZ4z+Ds5NYL3N9es1I367PNlhX8lPXYKaKl6KV10Elrgqkgw0bQT+S/as
 VvihPwbplj3LLhp5TjW9QYyGhOBIBlT9ZJopgrRgh+XXU2VuXZsWm5gG5bdBFV4J/glWmSxFy6z
 c2onAFsN2aJ6Xb+KxHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070046
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

FastRPC context banks on kaanapali and glymur are limited to a 34-bit
IOVA window. Large compute workloads such as LLM inference on the CDSP
require mapping buffers that exceed this range. Dedicated extended
context banks exist in hardware but were unused by the driver.

This series wires up end-to-end driver and binding support:

  - Relax the DT binding to allow 64-bit iommu-ranges values on
    platforms that require extended addressing.

  - Fix SID extraction to read the correct cell of the reg property
    on platforms with #address-cells = <2>.

  - Detect extended context banks by the presence of iommu-ranges and
    register them separately so large allocations can be directed into
    the wider IOVA window.

  - Add two UAPI flags (FASTRPC_MAP_FD_EXTENDED and
    FASTRPC_MAP_FD_DELAYED_EXTENDED) so userspace can explicitly request
    mapping via an extended CB.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v2:
- Split DTS changes (kaanapali, glymur) into a separate series.
- Fix DT binding to allow iommu-ranges on compute-cb subnodes.
- Fix krealloc() called with GFP_KERNEL under spinlock.
- Fix dma_set_mask() error path leaving stale ext_cb entry.
- Fix ext_cb sessions not invalidated in fastrpc_cb_devices_destroy().
- Fix lockless read of ext_cb[]/ext_cb_count in fastrpc_map_attach().
- Fix fastrpc_free_map() using fl->sctx->dev for extended-CB maps.
- Fix fastrpc_map_create() reusing a cached map with mismatched CB flags.
- Link to v1: https://lore.kernel.org/r/20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com

---
Vinayak Katoch (4):
      dt-bindings: misc: qcom,fastrpc: add iommu-ranges support for context bank
      misc: fastrpc: handle multi-cell reg in context bank probe
      misc: fastrpc: add extended context bank support
      misc: fastrpc: add UAPI flags for extended IOVA mapping

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |   6 +-
 drivers/misc/fastrpc.c                             | 132 +++++++++++++++++----
 include/uapi/misc/fastrpc.h                        |   7 ++
 3 files changed, 123 insertions(+), 22 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260826-extended-mapping-9b08b0c3108d
prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v5
prerequisite-patch-id: 425dc9414848bbc3f2a053d067195d849898e2ae
prerequisite-patch-id: 4fea14b47d11a5a3e18065d8cf3a461841ee2b86
prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

