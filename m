Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283AC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822B310E293;
	Wed, 26 Aug 2026 13:46:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrVmYlJe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kejJhBmD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 273E610E293
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:46:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCCG8G882046
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lVVXlwrDpraS1EuWGFKN4P
 A95ibIxivwprgpu4s411U=; b=PrVmYlJeQLnOGXbM/rVA7O300WFadHHcrCI7iL
 9YkZGSp5SMAO+JEZqFAc+hF6VnsytiYFtaFGdniysh/MSRmqQaLCaiAiA06umgbr
 6YELij2KdV+vta9Of2yCxcNADIAt2WeqX6lAXFz5Hqrrn8Qbr7cipcbkUJwV+aw9
 Za7cQKKGeWlITSxRJB6wdXQWCc8bwq2NuKGN0yBbPxNDjl/wOgRWaLwspeRoK3k8
 TwCbSSxrJ5NftYm7RIqXR+excb0/8wuqb8zAvVFfCFy9482wg1v2EBWrqP2qrZw8
 dKlGQcv7kdDMbYzlrBI0UsQj6q6CR6W55fAcaED11QmmpUEw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k2d5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so1129194a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787751959; x=1788356759;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lVVXlwrDpraS1EuWGFKN4PA95ibIxivwprgpu4s411U=;
 b=kejJhBmD+GwDYuvng/QlD89BB3mBht4Tv6Pj4iHnfjy+ocm+ICRXglNW86etUZTWjA
 Y6fyxmbnoEcsFV/VBcHGbo5g9EZQxr9RE1suWgjle/igvVyEq9qc2qAgdFzyjKzhvxqd
 f2ucoAI/pqUaQ89qDP8J6gsj9D9BcG1QZTz7t3FX6hcnuUXZody3pVoLyVEy6PMcWBfB
 GQQC2E8xwb5wQe62ThJrFNs7xt5KA49/DhNNpJ2SgLQ++b0/oLSgK21Rh1ub8bk8/wlx
 9GcHs23f1UbRX3+6QPdaucx7ykzlrhG8eKRL0RM+uAxiPcXaw2Z+t5dHmdO1HcZGlHgT
 WafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751959; x=1788356759;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lVVXlwrDpraS1EuWGFKN4PA95ibIxivwprgpu4s411U=;
 b=nNOx8BTVYJZ5acucGMw839WLQrnu7cBWpelHd9K8XFd4Wi7GE6v1ZWHp0w/HwWYHwP
 Zghtf30bAaO0MncGpsVsTOmp6PH76kAD0lmWxi3+t7nTvTOubimOBSWsZ1AJBInYv4nK
 as0Bw3Q+PIhUT1rbnh+dPOpt4t08//E6rtzqhX4OkYu+4mLkeS2lRHBRc8hrbzLRUML0
 B5xbluohxuCVvh7bUYjb/8e7xF0X9iUlhL2tAa9Viz+VMUsw9URNURlvWAqzTIof3jpC
 ycecmlyFp6XrILejrUt3yzMg5MEiXj69qVjTtrtSy6p+/Y1+y/QUsPmFYqJAE858sS/e
 +Eaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RptZS4ARfzNsdNAZdu+rZ6/AHLQPr0bvMz5VLzAoQxe4IBVoGmbPal0+bNZkODAOMx3iCtdejECdYs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mizt/UPDoMyoze4phsFMB2OYcPmmQM+OyabiAs5LoyRmg0mXXS
 o+G+u8FP/JZJ6BbPtIhQxDzAi+enKGQ6P/veyPqFuYeNSRpQfOGAqehNGtj7FbOx0ruWuYDFKVM
 FS6M20Z5BHoSlKBRkDnXNtkgOAq3BBMr5Ho0/1ufAKCHmqBIlSIdnlmIi+eJMv1gvvOm6gA0=
X-Gm-Gg: AR+sD11pIdG3VNoHSxWKMTAEExqwRjoGndB9f+H9jT8OPOUaEQ+EVPDROV398qnokJF
 ZjQv7oGg+WLv4gMYAhnu4Gqn1yEmdOZ/pttirfpGXqjidgShtPKSB9krY7zPTDU/jlj2vJ0ws2s
 QLrobtdii6KeOsEoMZrNM3qDJ+0lrKMA2kqBA7+QDgoseCKzEHBTh4LCOsO49wqjF8deTCjvNa7
 +G9vBK5RMdBDUL+W53BauLs5WWVM7QHDwrWXXCbVtPLNuq23B/8qbDNS9jWfIU+0+EmG9s1sF57
 YvjW/OExnWS2DDSldg+YDhG8VSVmE5jEncgEUtqxSIHTjiFIBOxfhyTGef4ofUC2t2lDT4crnxh
 9OmDzWaSU7CTQnB3URC/flNkFzXPbTWRxSg==
X-Received: by 2002:a17:90b:4d81:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-3966d8e8063mr7894147a91.9.1787751958569; 
 Wed, 26 Aug 2026 06:45:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4d81:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-3966d8e8063mr7894064a91.9.1787751957965; 
 Wed, 26 Aug 2026 06:45:57 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b64c48sm8179696a91.8.2026.08.26.06.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:45:57 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH 0/6] misc: fastrpc: Add extended IOVA mapping support
Date: Wed, 26 Aug 2026 19:15:42 +0530
Message-Id: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbujmoC/02OSQ6DMBAEv4LmHEvDYjPmKxEHLxPiA0tsQEiIv
 4fAJcdqqUu1Q+IYOEGT7RB5DSmMwwn5IwP3NkPHIviTocBCIRVK8Dbz4NmL3kxTGDqhLZJFV+Z
 IHs7bFPkVtkv5bG+O/FlO83yPYE1i4ca+D3OTGapQsXJoa106xpoIc62opLJ2FZKUVkqtJfwXN
 dnVo1ALv0wicfp1J8GmMM4Yl2tdNWsF7XF8ATmbigDiAAAA
X-Change-ID: 20260826-extended-mapping-9b08b0c3108d
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787751952; l=3128;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=AQp3ZzFGQIxMGUgev5a0WH6gQsFnNiiLrjLAVfK0jbo=;
 b=kM2egXYF+WCbAy4qPAAH2BpmOef0OYYIbft1VAzscD98XzphvisNkTKE7EB3aJ4oIsxy3dGGO
 2odqsO3elrGBd6HghJdh7est9z974QicZKu7Ddtj69xeYsaSby1tmy0
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8eee17 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jGj642yAPOClK7eN77YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX6F+5L0yee0X7
 1U0r+72swQ4hdfmXFYrrlYopGHhcRgIcGOC6O9I0UltDK3gwnFjW5ElkUgKrYBKzZznnTlWjbtK
 1AvgLLi7fr5wXBtmEnODkEe3pQCtXek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExMyBTYWx0ZWRfX/AC/alIsKbZi
 NQdW9QK7IWij/Zm0IDtyukhniCaWm6rQPq/8vKa4fszQAfN2HUEIfurravtye8Yz0BrrqaYfm7R
 hMtogtNe2Eue6u3i3skFrOwbJNjsztOItGfnI8EZb2uvRV6rPUqT0s7sNmqsM+utdsziSg4Mq2S
 OGCb1GKRiHzA1UGY83kd51GRIdUhmcqBwb690mkmke7fRyWgqsAqt56bGibBNFHjagTzBvDO/2h
 YlJ5pUFWzAbaTwHd+67+SrNS23prIqb+uQqvKY2pw+Hkav9aaRL2pvSCRbdIIaSu1x6lE8/dVi4
 la4kmKko1y3ifXLxyYpGBVnSmeYX5n43axPdFyHd1vj9ikZql5uUq3pZMf0tlNcNsraoLQ0keZG
 KE2fnTYTIOfKPt48zK9oeoW2hc1Z31Cgy5ZjxtuDXSC+1nrBLpKfxFnWJr9e9mWKBHRgBog1IC+
 ZYVdVm6FIeih3SAW/Bw==
X-Proofpoint-ORIG-GUID: DPwlJPX84leaItUTrpdYSylJQ0I4psrv
X-Proofpoint-GUID: DPwlJPX84leaItUTrpdYSylJQ0I4psrv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260113
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
IOVA window. Large compute workloads such as LLM inference on the
CDSP require mapping buffers that exceed this range. Dedicated extended
context banks exist in hardware but were unused by the driver.

This series wires up end-to-end support for extended IOVA mapping:

- The DT binding gains a memory-region property for context bank nodes.
  It points to a reserved-memory node whose iommu-addresses blocks the
  lower IOVA range, pushing allocations into the extended address space.
  The driver uses the presence of this property to identify the context
  bank as an extended mapping bank. The binding also relaxes
  #address-cells and #size-cells constraints to accommodate the 64-bit
  values required by iommu-addresses.

- The driver is extended to read the correct SID from multi-cell reg
  properties, which are needed on platforms that use #address-cells = <2>
  on the fastrpc node.

- kaanapali and glymur are updated to add a fastrpc_far_region node
  blocking the lower 16 GB IOVA range and link the dedicated CDSP
  compute context bank to it via memory-region.

- Extended context banks are shared across all open sessions and carry
  a 40-bit DMA mask. They are kept in a separate cctx->ext_cb[] array
  rather than the normal session[] pool to avoid mixing exclusively-owned
  and shared resources.

- Two new UAPI flags (FASTRPC_MAP_FD_EXTENDED and
  FASTRPC_MAP_FD_DELAYED_EXTENDED) allow userspace to request extended
  mapping. When set, fastrpc_map_attach() iterates cctx->ext_cb[] and
  retries on -ENOMEM, falling over to the next extended CB if one
  exhausts its IOVA space. The SID offset is corrected per-CB so the
  IOVA forwarded to the DSP is valid.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Vinayak Katoch (6):
      dt-bindings: misc: fastrpc: Add memory-region property for context bank
      misc: fastrpc: Handle multi-cell reg in context bank probe
      arm64: dts: qcom: kaanapali: Add CDSP FastRPC extended context bank
      arm64: dts: qcom: glymur: Add CDSP FastRPC extended context bank
      misc: fastrpc: Add extended context bank support
      misc: fastrpc: Add UAPI flags for extended IOVA mapping

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |  12 ++-
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  37 ++++---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  35 ++++---
 drivers/misc/fastrpc.c                             | 114 ++++++++++++++++++---
 include/uapi/misc/fastrpc.h                        |   7 ++
 5 files changed, 159 insertions(+), 46 deletions(-)
---
base-commit: a8406e6c0b793ce0788019683837c40855b55995
change-id: 20260826-extended-mapping-9b08b0c3108d
prerequisite-change-id: 20260609-dup-sessions-ea2acaac1994:v4
prerequisite-patch-id: 15f76eb917232e683ce9271fb3f0f465a4d60abe
prerequisite-patch-id: f225961fa033cae9dce14a906752e1232b052290
prerequisite-patch-id: da0a3d55397a522ea4b77769e387df9faea8e024

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

