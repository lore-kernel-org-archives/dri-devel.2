Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2B3C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E3C10E7A2;
	Wed, 23 Sep 2026 08:40:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M0gkjM0M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/7mgzCs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AB510E840
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:40:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JZ2T3178013
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=u3kBMP/UdR2dUdp9OUzO+e
 ymmQDIWWDtq95FmLDd2RI=; b=M0gkjM0M2OqJfpe/gSzvZvSoFiUsKqw5D4C8t2
 cuzhs4isFDV7ylHzJi7cFash3Em0hT0Px9CU5WSkc3P7+prBTRJ34KL/Eu0+Boxl
 KqmhuV4Q0qPBCIzXrjR8PEbXJvxKo2gQVNmYuPoFI6HKKgrHe6jM+u7o4soib5Ri
 aMdUd9FJalZ1aoDePF6JyPondDXwpf238yTuzbbqv52uBdi1pRvu6DPwmox/W7ym
 eBYYrOV8sKmy535OBLRxF5NRjmQLljClVnDqLxUHk6pwzwkXqO6bbN6Z9w3fA5k/
 TNS/p5uWn03SO0dbRVt0CO7zm18/CB3DPUvFr/M+a64mliPQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux863e08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:39:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-144f706e063so484774c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790152798; x=1790757598;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u3kBMP/UdR2dUdp9OUzO+eymmQDIWWDtq95FmLDd2RI=;
 b=a/7mgzCs+SXBKkeaaMf0d81MwrEaDlrJrHW0M3ckRYtumPanhUZgCevDpRJvrBnK1k
 iDjBBNDT4qkLiM7LSefl4o06pH+FHaFFQKZApeS0+o8Ln2noxg2MhY4qONbyY6etTC5J
 7QT85TqjnaFb5KuVxazR1pC1il0m3N7WKzr3GYV59p1m6wDOQ7H3DCAyj70sJu67gw50
 aAbfK5+5+ULGCkfVzf5w+FOIr2sU4a57Zuu39SUecjL6NQpxli+YO0hXM5hmS9zdstgF
 PdT7bpY4ZJIPr3WjKRnTxtgg1+T/9uq839F1/yYK2HFIZiRoTKXMO+8e0Cf6BUwua098
 0VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790152798; x=1790757598;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u3kBMP/UdR2dUdp9OUzO+eymmQDIWWDtq95FmLDd2RI=;
 b=GRC0FK6CWrYqxTlL1gNKW9BlhT1ByvXlRgcjE0eM87S21OhFrg+sUX+hmiFWwJPXYs
 I5KDcAj4brPO20YkoJ6r69Qe+S0CryUaUr9CoVk5UYDpKe1aR2nhFTroptIxgUedqiWR
 MU9O+7AIyzCiyvVu1yK5/WuyNkv/fC6J74itfs6vMwGRxHPvOzZzjbjrRcPXza+P1ouT
 xF29BeDbcxBhU9Zo9UwBqTVPolGi8goJ7+gG0Ny+wQKvi6ZAFc47fN1BIcgcoIHdaDsB
 0Nkb9oEEN36M3j9uiERgyAsJp+ljHLJ6Sv5lxOCIdSL2P28zPDnfP0xFimbg/yKQI6nT
 ZePw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY9ccz5UC4drSq0uG+eFVi7ylidfTpxFpe4b2Jfl7Trd/BoBBDZsKGIMfPCbYZXysO95AfRkHIHYQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lbZE7W4jn6hDViFCT9KscnRy+0ulSeMUMppouHKIQUhnS+S66j
 zdI60g5QGZuCSfrGLYMDSUeTJ1Efrt7wjNh7RiIYFG79i3956dew5K6JMVFDBYbVQ8pJx4BtAhh
 OsSBwh/z5Vcb2zMnRkcPJ4Pc7igGF7uLsYd6/hLi+N0IeSaXM38s1nNLaCo4GedCcA0DdTE4=
X-Gm-Gg: AYBFou10fmKfRJ8ocQommaylcKf9Mj8sI9HEoWROsY5T/kIPCcwrfpqbTBUNwmyz7fq
 i0ZTctHVvf8ay6lKdsn/SxnTE7QWnFP3x5OuamtI1KCbJdql+ywQDSureBg0k/JePrtnx1AgAyF
 UbbwWUpYNAVICAG2nNYWoJNmUIm/zSMX1EcF6aNJpu3z0OXUnwc+FV2uliL6h1cl+2qD+pCVZBT
 tCMj46FQM6vV4tynJhgXQ3NG5Fbot62CISbpt0FpUNwQG8A9x+rQwePGl6MfuZ+78R6ZedoTQRa
 q6h3YQi2t8QeMBN60PARCIShk/aF3qD5D3E1fvgu+15/jefsOQoDinBINZrkhWsNQWgm1de0KhC
 RqDaNKqY9ccAJR68PBjhDupPrVhvZS5s5
X-Received: by 2002:a05:7022:319:b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-144ef1b350dmr3164909c88.17.1790152797575; 
 Wed, 23 Sep 2026 01:39:57 -0700 (PDT)
X-Received: by 2002:a05:7022:319:b0:143:1bb1:3300 with SMTP id
 a92af1059eb24-144ef1b350dmr3164879c88.17.1790152796975; 
 Wed, 23 Sep 2026 01:39:56 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33e96d497e1sm4701275eec.25.2026.09.23.01.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 01:39:56 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v5 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Wed, 23 Sep 2026 14:09:32 +0530
Message-Id: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESQs2oC/3XMwW7CMAwG4FdBOS8ocUzXcOI90A5O4oxIg0IN1
 SbUd1/KBVRRHyz9v+zvroT7wqK2q7vqeShSulMNm4+Vigc6fbMuqWYFBhrTGK/T7ayFZboTzQQ
 UiaL1HlV9Ofecy++D23/VfChy7fq/hz7YqV2ABquthsY7pBB8JrfrRNaXG/3E7nhc16Umb4Cn8
 WnamQHa6ERoso++JQgLhnsaLeDMcNXAYKxPnJHNkoGvRjMzsBpuUydByJzwjTGO4z+wDVHLewE
 AAA==
X-Change-ID: 20260609-dup-sessions-ea2acaac1994
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org,
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790152791; l=2562;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=DegeByME95Q9SDYw+KAnIugvQBMRM2x0wwMhFx9DWu4=;
 b=P4zKL5Rl5YRdolktnRnJyAC4IEz/ZyF7zxqLrbnn88Xi2IbGk5Xw1xPWnltQY0eanTNkLqd8F
 ZN0S9WaFfjQBXWAe2mBGiT6jNDy6lHTOCL2JpxSgLhZlyPuhCvGnj/a
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-GUID: PQnsoqlj2-oplvOQu0E5Zcygn_Pg5559
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX52F6IqLC6quA
 J9A8f6LfHGCP8vAJAjAByPY/wCpXmjsBWcR6jPGHmVke4MoLcROtddb19BpBpiLRdE8SKt07uEQ
 M0l8S1mw9WpdFp+z+1i6ojS6dfhwo+A=
X-Proofpoint-ORIG-GUID: PQnsoqlj2-oplvOQu0E5Zcygn_Pg5559
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3905e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YTpWxnxjnte_hGW78hkA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNCBTYWx0ZWRfX+IA2TgHa0dCw
 NPoYziohoXg+d700iuJ9qbT/15fQ7LEcqKkLhUAlI2wCycwUcRn7sqMiNnsPZf9CCXfVjLoTTFt
 eBUPmizJE3nrnfMlCezFVoD041oLZm2ByvnTCXLebCCdhstwu+V3f5lNpv8g+U44YmSGp0wO4Vv
 El87gGHIlaQkUMxAAks/aBxwW9ne/nV5WPlbXucZepN5R1ra9gTiXB5eHGRU/5p65vMo2uTceov
 ai8MKsiUSIphU2JeIFpE4/0WKIOCjesLHIAt55p3cp2uVWB1Q8u1oEIkGYx1LjVcfp2VFnM0JbL
 +qL3nlASQW/ZMzJ11BsCirbBk5BJ/qRMAjvxZPAkd3fBqUSc9DokTMivwyKfms604G2nDuObuGj
 K7/CztD0JtS9itmwggI93iwd3emLQpvYBh3b7bkL0IFsKeQ4nkKROjBgo8+aRooMEDY6DhQMs2J
 VGzq0x04wEbZBiYPn8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230034
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
replacing of_platform_populate() and of_platform_depopulate(), and moves
the ADSP session duplication to the driver. The qcom,nsessions binding
is deprecated in the same series.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v5:
- Introduce fastrpc_cb_devices_create() and fastrpc_cb_devices_destroy()
  for symmetric CB device lifecycle management in probe and remove.
- Replace module_init/exit pair with module_rpmsg_driver().
- Link to v4: https://lore.kernel.org/r/20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com

Changes in v4:
- Rebased on latest linux-next (a8406e6c0b79, 2026-08-25)
- Link to v3: https://lore.kernel.org/r/20260824-dup-sessions-v3-0-4b019def4e0b@oss.qualcomm.com

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
 drivers/misc/fastrpc.c                             | 133 +++++++++++----------
 2 files changed, 71 insertions(+), 64 deletions(-)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

