Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF035606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PG9bddMN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bNXQ2TkB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566E210FCEC;
	Wed, 21 Oct 2026 09:26:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AC310F9A3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5j6iX793364
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uSuitGcPNAp6kDNTkufpaC
 9Ibk/iwsakxpW63Y9HaYg=; b=PG9bddMNbfwdNRNZcxRiCjIpHPEo/YxS4lJGou
 QEPVRmelHHTCme7Q2rXbEWszwab0GPsntV6umf+3G5wVQLdP1qjjt+NV6YTttFH9
 lGWoojt0ML3ujWkizVmmKiRrlYUGPMrU8cfuITIBYfKojpBAAdU06oHEkncUXJS+
 EVWAk8BiW7TytSefN4iBTDK0BSkhyWXWxvaFRBLeEK9mSlVig+1VouRIiPUw5nCK
 Dp59hIgbW/4IfwPne6wKlKUetwXy/KYyeLQRQA5Ws4NTDx4pIhLjwGqknvrm7a0g
 OgeoKCdUHFM+HKwPEw1Ym9TOWU9LpxuTKIiLZ2YfiynIQmJQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabk8nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 09:26:01 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so916575eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792574761; x=1793179561;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uSuitGcPNAp6kDNTkufpaC9Ibk/iwsakxpW63Y9HaYg=;
 b=bNXQ2TkBOYGAdblFODe6xU3J5pke18DUHm4hRgraKK2ZgUPEHRxl97EzA8e1e+h3t1
 2m7NDAsx026UlJfhnqtxbSvN1u8kYAOFgBGvU4WIZ12IY8dqsEWBgiDScgjbVWdhzhiq
 iGHOxjyC7WuWHdGdXJkAKYQQ0mT5x1549/eK01yDAqcLxU1v6wNUYhh1eQKNcs7LGieA
 qSOl1vszSuV1rBDJiQCVB7qDyhOI+rgXW22HA82o8tdmDG+Fs2xWP4o/RFrl97RfliAG
 SPY2U6J95Ydqyh38UvhjKCJkZYzz8tjXQhjvxU0FPEdfdTrYkr7GzcLhIOdKwSYxKtey
 gbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792574761; x=1793179561;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uSuitGcPNAp6kDNTkufpaC9Ibk/iwsakxpW63Y9HaYg=;
 b=QEZVW1xjakB/R5dU9sd1qqT54YL19Uh9jH+fh1w/TXu2MyFQjdjx73V34ny1qriIJg
 A+E60AjPPWAOs8Ut9iWQFzEqVnPj2ejRb85jriAvBRTt8VmRqUj+DgtHJsFLwHStf3MK
 n0aVeGr/dwy4dMOYDKknf1YgqYcRXLmI2Fio4PYYRR4vwHX+A0WfJf57BWwUA/Xlwjyu
 qJ8PjTnQiknzXNEVo2NoTZusKUivJAliOkniZi1C9+v3jyUgEuZLGESQ7rJymgS63LZt
 B3DTebc7kiz56IjxKyOupDtNd5nt6P+KByy9ZXoyPupmLMbq4td2uPQbwX3VvZ04ItRu
 +nnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwerYnNlaCB7PzCoFthwwuPtU7i6jYYb9BHbKQBw6bJm3ts5F0NITwo65S/fiwl2qlMrGxdzZmiSwg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLXcYZzzc2iV07PReFWK5PigRWEMPKwa3rybkd0i0RDBu4jtNK6
 NuKlZ35nDLnSyKfnJmODccZGqA8ddm6Hb9fTc6IUarLnY150Mss+QzoS+zkCR5e68uEuPPOOax9
 EQgStlpQCjCikoz+WelOQiiRNBVVzW4J3KYHk35r3ZQfm7+t0CfpmtcwSQpins+Na2pDDG7o=
X-Gm-Gg: AYBFou1YFtnryHj64F1lGgZsUNIVyfXsUA782Ob+gJSeBWHnTCNrTh7TzLnwdrtEwsU
 tIgOljv96X/4OkRk0eblPmCNi1wBLgITuuqyffDoKoHg8Ua3WRWrV51O9wMWn2jHc49WXG35E8h
 jtZBkkhgzo6OJmufOlJ/4WOWqMerSR1oQJsJZAruPdpRuIwq6bBxltvJSwl1A1GhSMuJDLVvLRK
 qdkF6Yr6WA0XrmkTbzrytCVqQegQRBS1fKgAmTJkA8HhP392gK98a7Of9ZUg4hFKnvKoBGaZxHi
 yImRNBrwgRijjJxrmVC+l2ISyv3Sl6VQh6QmHTdpnfQJmZKNlJGeBJoz+rugagRwlXNXn4MW5qc
 sq4CVHm+UWiW5tHXAHFHGFfQgXyYC1a0v
X-Received: by 2002:a05:7300:6a9e:b0:35b:c271:df19 with SMTP id
 5a478bee46e88-3674ec2eac8mr2651362eec.32.1792574760826; 
 Wed, 21 Oct 2026 02:26:00 -0700 (PDT)
X-Received: by 2002:a05:7300:6a9e:b0:35b:c271:df19 with SMTP id
 5a478bee46e88-3674ec2eac8mr2651315eec.32.1792574760195; 
 Wed, 21 Oct 2026 02:26:00 -0700 (PDT)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36740cc8439sm6155671eec.11.2026.10.21.02.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:25:59 -0700 (PDT)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v6 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Wed, 21 Oct 2026 14:55:46 +0530
Message-Id: <20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABqF2GoC/3XMwW7CMAwG4FdBOS8ocdJQ78R7IA5O4oxIg7IGK
 hDquy/l0qlafbD0/7K/lyjcZy7ic/MSPQ+55O5Sg/vYiHCiyxfLHGsWoMApp1DG+1UWLtNdkUx
 AgShoRCvqy7XnlB9v7nCs+ZTLreufb33QU7sCDVpqCQ6NJe8xkdl3pWx/7vQduvN5W5eYvAFmY
 6fahQFSyUhWJQzYEvgVw8xGC3ZhmGpYrzRGTpbVmmH/Gm5h2GqYpk4EnzjaFaOZDQSzMJpqMDZ
 GG0O6hd0/xjiOv9PJ6RK/AQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792574754; l=2894;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=Znw6rBmsrPLmZf1Xm4uaqF5JIwWwc/6CAx2/Oc7scWg=;
 b=xghwgq5+GYh7ydwRMy0+qeIwLDWK5mN9QP//SG9fG+vHyBfoekIfEE3Z+y1A9En8xk8nlljSp
 I06rkL2HJYoA40vi3w6fx+Nrw5d1iVbtFWuwz5aVF4Scqe/HcrZ4aG/
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX4OTzUDuR+FkJ
 yTb6HD+yFNIgISbQ5WBKqwvCJNy1z1OKTnutxoDPWlki+UTikbIcVAzDcGOoU2baDXjb267lBhb
 ZXIfHeglJEdBa6DFDCTJ2IimzaxVvc8=
X-Proofpoint-ORIG-GUID: tziPieDPnvOkhgRPPT4me9V_OGj26yEG
X-Proofpoint-GUID: tziPieDPnvOkhgRPPT4me9V_OGj26yEG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNyBTYWx0ZWRfX/Qj0yWzqkDXX
 vCihJeeKCEYK+LdkBoCpSqKd2U4xCHPZTlNv4YbLbTFPedBCOXz3tr1cBAYbfUx4BPCsjSyUQgk
 v2OCJ2uOYpaXNdCkRYLrNWsEP+PeYieycoBXJesfitFwS/fSWgjE5vkLdg8AUF+5c+UBH8QCR7Z
 2k73UAqHJoNN2Wq7bMPf3NEsT8+zzNnJkVpYRJ6FB25CSi+Son2pNfsHm2S9VVmBD05f+iYVzrC
 w/V2HLT7lDWweQQ5rv772C/gllqDXQtd4qZMv1T3Vbm77GCF2Ik1ZIArIG81VANx2A7WfxZHQVC
 CnYwSD1a2NGRQ7UympzUVlJOouBeI6tLn0jW1FljeE23zpzAC1EUpeIEi+Jx3+YxOkbkzxDP5EU
 90QVQDAmSTuUE8Vpv9zcK1PeUK1HjlWpG5s962ACvbhMAElACTTJSCnBJHfqFIMWXvGEnQcQdWF
 +r1Nl8xpDEoovsb5ncA==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad88529 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YTpWxnxjnte_hGW78hkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210037
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v6:
- Drop unused dev_set_drvdata() from fastrpc_cb_init()
- Use device_for_each_child_reverse() to destroy CB devices
- Return -ENODEV when of_platform_device_create() fails
- Add a comment for FASTRPC_DUP_SESSIONS
- Link to v5: https://lore.kernel.org/r/20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com

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
 drivers/misc/fastrpc.c                             | 128 ++++++++++-----------
 2 files changed, 64 insertions(+), 66 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

