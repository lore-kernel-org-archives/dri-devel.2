Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F00C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC4E10EFB1;
	Wed,  8 Jul 2026 03:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3Ocbh1i";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uc0OJE0E";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1836610EFB1
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 03:58:53 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6680cIMc1197380
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 03:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Rxlhybev86/Ln0YkgAASFU
 CG3bTQ0usUH7X+nPUzF8w=; b=A3Ocbh1iQrO1/9dZMyrEXEl+zWYK3yIUOtEtv4
 mPIbldorCNXYVq+DwoLj/uAX7HVfCPjAgYUJfDBDGgyLswTraYETv/iNXQrT163E
 8IaNJfSoK15XYttvndGwAhxOBSTFPKp7dc/AF+86YXlH689S7uq+duR1ygoxBepv
 e0UwwRgGQNL+yJEu0ASqeW+HMbkySkMEbE1/1qOH5fTJeVusSbj4HI56oNbCutFL
 fDyFK0JVfxeihYb8FxB7i9gy3AJ3jdGEhsxtiUINgpZZ29zcEhmY8Kw/Li1q33P5
 Fym2QF4i6V7xvCOW7+GuaijxNVAFrfAA9J5pVkgQ/6oYOHwg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9c6a8mhq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 03:58:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so317432a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 20:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783483131; x=1784087931;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rxlhybev86/Ln0YkgAASFUCG3bTQ0usUH7X+nPUzF8w=;
 b=Uc0OJE0EwxVp1txKoLcf+RdiNyJUDt1HlIZKZeuRFfVvMzT1fosnWfBD6JV1JZguSc
 9mZewt71lJW6z3pMMeFYPqkOrKezaf6B5CTxBhs516OBswsjD2aj6S6qQaP1nn0EaF2X
 XlR4BSqguffJq4ns9ayL1lYoLoNj83f0n/xeoInvQCDGZ0T+C1PzRvmAJ22sfZkotZ1N
 LhB3YMfV4n9mKmzgAyyKa1g6JvVbepRsh0dnREtv+9pVYQUTziaW7lRJZJZM19ELGXC2
 LAYBppfPMaTXQfBOdE7nCYbHMUcuE3calRLa5RtWr/5Clx+TdmPCe1ajF4wY2b2SvyA3
 +hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783483131; x=1784087931;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rxlhybev86/Ln0YkgAASFUCG3bTQ0usUH7X+nPUzF8w=;
 b=Jxp2sphhj0cqT9z+t7LI44adiJwDK8QumFs2v+GTe1AZG6GRc02FSnYvciK2h3h+/Q
 DWYZWfGgEu7BuGvWAUQsGjM5Ta1YTUUuXTqFfLv6Gjxna1Sowhq8dcYmqbCfcBANCMva
 sAUqeKrGAY5FWAWEGINan/BVegjwzEaXDVFabqTlnGD+wDnVFliZUINj5Zx+hUOLW9LY
 b/u7IehDOg3t9kjjYtwtnaDbK6aW1wYoSnB2c2pR37Fnrxcz8aOQ3ULambUBCwMqtNbA
 vFmJzkaRnfqIj/nkEAYo+gDJ7ajuqQJxukLYfkKwFJdN1p/S/Z4jpSuEtpDv0yvozg04
 9o6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqXkFrPR/zH0r2sdb8ZHLCy45ee+Rj1agGR3JJUmr0xO9taETVT2S5lKBv9s/66Hgv+nIvN89tnBiw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRuGU2vRql0QmzGKfVM/eUZ9EyNk5716W3/vmCdjqLwroDMARs
 msVW+7SkvTRO7f7RvaCcOG/uOnWGW9nsXYcvQbGVvKZuB7KogbLee3DpHQpvcz+PFbfJB4Iy2Xc
 waI/bVU964igxNAvmV/W/q+AcGh/zXAhQDYK8ukPyeo0T99uVlKORHmH+3Kiv96g/s4cwH88=
X-Gm-Gg: AfdE7ckCgg7cHeO2KSazScj0xKawQi7kOiLKa0ihkeESPLcA5/VjwJlVnjMzjR2li4w
 9pu/hWsRvrzmCDr1c4KzqAJ7avRJ93i6Jlb2W7M/A2T/qu4BMvlnpwWQUvQ+122sWfr0X4XJALV
 aAbQrHg/S06PdRL7v9fq9R5SSl9E/q+e7Qu84f9lDEmVhUfL2GKXmiET5j8J5AWOFICEK0wr0sZ
 3pnkC79u6aro0iBTmVeHgeVHUGsqLkMKAQwx0lpNrKbCFIhjSupfJ+C/EvXWr9r/Gblk0weyFQ4
 Je/0HNRbBKRfReEpQriJwa6ahWNOLssSU3C025S4o3AaSMYakAqEn4C5PKyF56RykqYmn+fYY9h
 oChzrVbvwaf0rO9PPIo4Oe6BZuQb/RmLuN4jG+Zt9pgUE
X-Received: by 2002:a17:90b:3ecd:b0:380:925:aa25 with SMTP id
 98e67ed59e1d1-3893f97ccbfmr851402a91.5.1783483130814; 
 Tue, 07 Jul 2026 20:58:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3ecd:b0:380:925:aa25 with SMTP id
 98e67ed59e1d1-3893f97ccbfmr851373a91.5.1783483130327; 
 Tue, 07 Jul 2026 20:58:50 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm14487136eec.3.2026.07.07.20.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 20:58:49 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v2 0/2] misc: fastrpc: move ADSP duplicate session creation
 to the driver
Date: Wed, 08 Jul 2026 09:28:31 +0530
Message-Id: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOfKTWoC/3WMwQqDMBBEf0X23EgSJZCe+h/FwxrXGqjGZmtok
 fx7o/deBt4w83Zgip4YrtUOkZJnH5YC+lKBm3B5kPBDYdBSG2mkFcO2CiY+diwINTpEp6xtoVz
 WSKP/nLp7V3jy/A7xe9qTOto/oqSEEtrYpsW+tyM2t8BcvzZ8ujDPdQnocs4/8WHQuK8AAAA=
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
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783483125; l=1994;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=SbFJVCbDW7thUo9wl/zKc1WGlXsEXTKlcJaCWKyiayw=;
 b=NlQ/Wx8ghJtoXpDr4R4K/wZQviwH9phco0+9hlqjH3VcWj42wvZmZqtTKeCGVfiFlBNaey4ta
 RJ9xaiX2aNhDIW4TidCfeUr8VjsT9iD57/kakbMukZ/K/7BxmalIsrJ
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfXyOvpKNbRxyT2
 26jkSeHmwmrJbIfwLmwpwvtFPTUJOlajb10wCtAI25jqSmcjUy5N/BCyGa64eo+eOJjN7PKyd2f
 kQBAc9QuLUHNtxuq5bbFeCScV169aqV8Hv9d57Ul5WFvUeEyBPYfqN5OoAUKRvaN+LJ4PdIoSkh
 JYSN9cdbW1viQ6GjIA5h/8UgjLmELr6pSXxSOMo/+zMcXoNV3tUW1qRDj+nKqpMVvaTr4me280C
 S9/GTbVSOhrS6YmUGRcy2wAtJr5O/TAO0pkeWSd1K39oBA2dl/QMujRazqTQEQawiQ7zMYo3E53
 zAS6Ppcv7nuaKbEc41LVa6qNkOSlcxDxPwlFDBeBiiVqpBJcfxXhnZi8tyKi1sBuYLlPGZebODk
 S4qLpX9X0+fmyJ1PVk6he0j2s/9szLgnmSeIjr+cUXQr6y+6oKAj1J0ICZJxGQS/zkrOt9ObOBe
 kLllU1RaKcfq3/f3ZYQ==
X-Proofpoint-ORIG-GUID: 9wHQ3sTcNpuAewteYm6VaHfd_zNAMgfn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX/u2l+WD2v7f1
 y3ZRyZwkZ8Ep+B6TE0Hj2u1OKNOiCrJpA64UOeZD91N0hYDKiXUdvaradXjYGh58G6+b+hr1yMj
 EqPAIMVcnAhHVFBFr+m9RsbGwOBEwmw=
X-Authority-Analysis: v=2.4 cv=UehhjqSN c=1 sm=1 tr=0 ts=6a4dcafb cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xEkKumbzGPLJN7pZj7kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 9wHQ3sTcNpuAewteYm6VaHfd_zNAMgfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080035
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

To work around this, some Device Tree sources set:
  qcom,nsessions = <5>;
which duplicated sessions inline during fastrpc_cb_probe(). Upstream
feedback indicated that this policy does not belong in DT and should be
handled at the driver level instead.

This series removes the per-CB DT-driven duplication and replaces it with
a fixed driver-side post-probe step: after of_platform_populate() returns
in fastrpc_rpmsg_probe() — once all compute-CB child nodes have been
probed and the session array is fully populated — FASTRPC_DUP_SESSIONS (4)
copies of the last probed session are appended for the ADSP domain. This
keeps the per-CB probe path simple and ensures duplicates are always
derived from a stable, fully-initialised session state.

The qcom,nsessions binding is deprecated in the same series.

Patch [v1]: https://lore.kernel.org/r/20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v2:
- Added patch to deprecate the qcom,nsessions dt-binding.
- Kept the logic unchanged; only split into two patches.

---
Vinayak Katoch (2):
      dt-bindings: misc: qcom,fastrpc: deprecate qcom,nsessions
      misc: fastrpc: create duplicate sessions after all CB probing

 .../devicetree/bindings/misc/qcom,fastrpc.yaml     |  2 ++
 drivers/misc/fastrpc.c                             | 30 ++++++++++++----------
 2 files changed, 19 insertions(+), 13 deletions(-)
---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

