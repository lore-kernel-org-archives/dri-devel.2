Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24E60A381C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W1vi71yW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jjqN+h4p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF1610E052;
	Mon,  2 Nov 2026 08:31:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C3310E052
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:31:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A24w5xq1262130
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 08:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=uMYB9Ukf7PZSRlLsRb/17n
 PBPI78tPEvnCpbI25t39o=; b=W1vi71yWuacj7PkulWZKjD4qLBxdffHsFSFJKe
 hLlMwV+nqExr1gnYwwK3meM8tIPUgkDPJTIKXHjDpz89/0KfAZY3rWxkFuc3LU23
 FOUn19PgzjWU6b2rGBwnCAxQ5M8MmOcZDRgT+P8iixwTN5NwaUCwJzUMtPuzjTZ6
 MOSy+8xQOlu562EXpiCxu0hgaZ2jzF4zR/z6C/wgU3vLb8kfdPnVwsRR265oe0Pa
 Nl/LSyytuVcoHIQFZTlnGxoivegh5kvq049IwXTKZjMj6oFBpsBJvqk78FNXZi1n
 9HeZRk76BRa1Peqglwk39HLiFAXPEg5U3mHcB6V2iaEBRIOA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4gqk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:31:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-89e05d31e54so1838360b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793608279; x=1794213079;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uMYB9Ukf7PZSRlLsRb/17nPBPI78tPEvnCpbI25t39o=;
 b=jjqN+h4pnVlsicrd4nlgdjjj78M6RC4gtQkik2+ahZReUhJGwcIwwyg/sUljHt8Ez4
 KCR6y7OzOlHfGf5XNiNFWKw6RZ5DWBRehEdIKQ8ADowfnr3BvUEjiEFtl++dRSKagBxS
 /MRzmIO8zAY8JOvl5cwzw25lxBeSrV+4eiU5FGxh7LY338jlKYdD2Q9Eh+bgsRyYehsd
 dVqBPBFW58Zz6b3auKwcZp8MPD1k1ZwCoXuk6WUc6zHot2elMCrli6LTOkX7TUe1oTfc
 5OkfALWLBKQf7GGTlrbxak3EbCDNnfc8BbAmgR0dQToe1tFcFO//C7R38jaHZAnTLDkF
 iesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793608279; x=1794213079;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uMYB9Ukf7PZSRlLsRb/17nPBPI78tPEvnCpbI25t39o=;
 b=lxoI2aMBbqp+WWIIcNWDKCFunbsc99gJORBLy2SrEO/fRLmOIexmjnP/ylRkB1Cr/f
 TLX6C9mCE9cApeVVVgqhQdit6/CtF45ke24BCuTMYjrPve4UETFXkn0guzE0+sqd991q
 NzK+GesjwL6YdOmMN0EMlCmi2syfJe1ChbpGkHqlM1/iJ5N0lgxKbKSGajz7/Tj51g2c
 Prjyu53xFQJZcSs6BqrpFRTJTvv8fgYazpbUXfIvuz383GQyr5KX0ZBcBgaWgG5hs084
 pIHSOR6OBw1dXNoXNlJC76PtwMz/zdgf7sMgxMUi3ccMk0T8NzKbbOhCsGsPFAfno6L0
 EBEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe8XtuSkXfDyHxru/PEIOGvlPMSL0RwLqM06iv+zIgzb4nBf8R0lw5Od4WI8r2oYpDQMF1VGAbnKs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK61bnHm1s7Pry0wPFqDBVxFfef/qf4TlaADSXvw4UVDKA2b66v
 sgd2e4nff46XGHJ5xUPeXz+Kv7afmZAvaQ4ZYvQbgOATya7+jplTGttUVbSosEXqvOCSeDfZ6uU
 0XBy7oo9JyWZMwsXFxsaBTNe2SAcbKNYPa9PZ5fd6pxWcvgGgncy2sslpSukvaqrH83DFNrY=
X-Gm-Gg: AYBFou20b+iekqdwta4BWfFN+6WJUHGBUQQtyNt91CtYEiVi4hVAcyEb7oJcRrtogyU
 OR59UXBhAN5g4512KfhlcqjpZgKw0UqbVzGSVOBJt54JJPVPt+InhzcUx1ZTCodW28Pha+syW+o
 9a2AWnYLdCmWXsVVFm/jopiwzz7gBI2E3vsscM0Jy8oS7idktybNpnorGExdW9evCt68iUR1DoK
 KXZWsfRnfYwPsD1ptozhltcM9zE448c64CgT5UFsGlEEwI2oX6umpIpTCpQGMakALZUw7a6Qp+m
 cfmAg//tnHxpMpOvLL8Pwh4PnmFnKaSO0Y6SFWsbpr+Dl4QOd/XBP0xjZwkwjk9IzT6Rr64lRaS
 DE4Hp6eG48Pp/Pe0MFqXKoqHX7wzcA/GzbmdVsmBPacZTarsNImHftl89lHZA38nTXpt9/v8k/V
 Q5dx1yaQ==
X-Received: by 2002:a05:6a21:828c:b0:3e2:200b:dc24 with SMTP id
 adf61e73a8af0-3e928b1a148mr6877469637.90.1793608279266; 
 Mon, 02 Nov 2026 00:31:19 -0800 (PST)
X-Received: by 2002:a05:6a21:828c:b0:3e2:200b:dc24 with SMTP id
 adf61e73a8af0-3e928b1a148mr6877443637.90.1793608278752; 
 Mon, 02 Nov 2026 00:31:18 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aad9d03be0sm1674680b3a.27.2026.11.02.00.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:31:18 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v7 0/3] misc: fastrpc: fix ADSP duplicate session creation
Date: Mon, 02 Nov 2026 14:01:01 +0530
Message-Id: <20261102-dup-sessions-v7-0-03f06c014e78@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVK6GoC/3XMTW7DIBAF4KtErEsEw48hq94j6mKAoUFq4tQkV
 qvIdy/Ooq6sehYjvaeZ78EqDYUqO+webKCx1NJfWuhediye8PJOvKSWGQiwwgrP0/3KK9X5rnJ
 CwIgYpfeatZfrQLl8PbnjW8unUm/98P3URzm3G9AoueRgvdIYgs+oXvta9593/Ij9+bxvi83eC
 IvRCbcygAueUIvso3cIYcNQi+FArwzVDB2E9ImyJrFl6L+GXRm6Gcq0SRAyJb1hmMXwoFaGaQZ
 5o6RSKB10G4b9NaQAuTJsM0znMBgIaG38x5im6Qf/rFDPAwIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793608273; l=3324;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=G5NPjxUkQvJJP+CDo3Xybd8QTltubPZ+eNMbx/UPZDA=;
 b=HZJhg9wSGdENOnWDyj+uqK8+1TjvNtFK6AlbEJkorfTODKGPHr6t3xi3NJdFiZR697dZXNTrO
 aiK/AGrwAqsCYwr1OnZ/B6sEMuuRtR1VUBXoZR+d1gb5v5oD/iPtX1l
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-ORIG-GUID: bCfDVkzyJaDj_c4A62gPOfTkRk_GFFZg
X-Proofpoint-GUID: bCfDVkzyJaDj_c4A62gPOfTkRk_GFFZg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfXxE7uRqbQkBRM
 Laa66uNFtzg4l0DB/PWQGp1J2+Ri4pXkbbpT2nhyfdNeKKi2nn7kUcD5WvSCK01lDA7dFyP+8Rn
 MbaW0erVm5XyQ6DbECllGJjVNLYRa3g=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae84a58 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rtvGdRlZkeXjFHPAfbIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzMyBTYWx0ZWRfX2VdfWNnBbgHK
 EM+x3MTl2xA4l1kQKW5r/hZ61aFezAyiujjk8EzwnYXfZctRtQWOyAf3wSqDSb/qmEYkcSBiHCp
 5rrY0noT65hb/zTAKLEYS8nBH0R1Xi75hW52ROT0Ku28V+NEV35LrPs7377n9vKvvASyP5xboM0
 X1BOCDXOqtFupwucqUKoE0quntp51E4euQyS6ZM8NBgRR6Op2N6y5sSocQAHvHy5gYNMPNZZ4Lm
 VrMMTxhdI3MNSaw3OH6FBbP7GkVia5l3S10Tke5RGGVMp8ufGwuGUIn6IHhFkAnetUYmFD3oRsT
 NSwalomQnjAAuS0+RxoT/vyL2yWBztuZ8pGvuZ0u9dXX5UudC15H3cng/oX44s8opqSzVjI0aBh
 UyY2i2B91b7MTpP5lLsdwXNvJVZ3VMT4FWDA+3zH5tn5TxwPS15EP7PTQBMAB0CcKgLVqtRXofc
 53XGZE2OZonf25aGrhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020033
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
replacing of_platform_populate() and of_platform_depopulate(), and
configures DMA/IOMMU for each CB itself since no driver binds to them
any more. It also moves the ADSP session duplication to the driver.
The qcom,nsessions binding is deprecated in the same series.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v7:
- Call of_dma_configure() for each CB device, as no driver binds to
  them any more
- Skip and destroy a CB whose DMA/IOMMU setup fails; defer on
  -EPROBE_DEFER
- Drop extra of_node_put() in fastrpc_cb_devices_create()
- Link to v6: https://lore.kernel.org/r/20261021-dup-sessions-v6-0-578ab52ba66c@oss.qualcomm.com

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
 drivers/misc/fastrpc.c                             | 153 ++++++++++++---------
 2 files changed, 89 insertions(+), 66 deletions(-)
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
change-id: 20260609-dup-sessions-ea2acaac1994

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

