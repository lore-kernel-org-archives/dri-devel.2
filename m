Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E10C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A9610E2C6;
	Mon, 29 Jun 2026 15:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="HTdJm4UU";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7985910E2C6;
 Mon, 29 Jun 2026 15:48:00 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKNA3000395; Mon, 29 Jun 2026 16:47:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=f18RwDvW+lLYC/yt5tChdj2
 vTuPOQbGsgrpbnm2a5AQ=; b=HTdJm4UUEiN8ASNf8IjGQE/oYizYXw0oEkmlqJh
 S3CEbcbDyrbGd5gq/Odon+xqc+ZNl+ltAIiReu01Ks6M1RgZy++SB7Gzrp+QJCbG
 fsjA1LAPZrYmZP6QjTjqJMkGMRSHJhn43IC2GnTERiIOLMj65j8pv1no3Km2HBmM
 lCspiiv5s5jFY2QsdqgTt0v5dd+ne2bkcCkzwtELoObeNLsy9ObBSfedJCx677Uv
 KfKPLdnc+3hk70UZjl9Uqby/jBig7FgSXU4rrDB9t+sc7qvtzId8ehA9J4dqGthq
 bJhscVe8x9RMs3H3C2WIfU7J1fb40OYebIM3MG8XPBnn8mA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kuj3rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 16:47:50 +0100 (BST)
Received: from [127.0.1.1] (172.25.6.219) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 29 Jun
 2026 16:47:49 +0100
From: Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: Remove Matt Coster as maintainer
Date: Mon, 29 Jun 2026 16:47:28 +0100
Message-ID: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJGTQmoC/yXMQQ5AMBCF4as0s9akJjS4ilgog7FopUWIuLti+
 SX/excE8kwBKnGBp50DOxuRJgK6qbUjSe6jARVqpbGUo3O9OUmiznQxlLlCk0GsF08DH99T3fw
 Om5mpW9853PcDbD7nS2sAAAA=
X-Change-ID: 20260629-goodbye-26468f9502b4
To: <imagination@lists.freedesktop.org>
CC: Matt Coster <opensource@mtcoster.net>, Alessio Belle
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=matt.coster@imgtec.com; 
 h=from:subject:message-id;
 bh=wvM+kSMgAW3ZdGwbxhh3uqR4mXzxG0ev3yJmwHGBHmc=; 
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWQ5TV5i/Ud2S3rRnmmzVYLffZ+0vubwngV3Ny4/7bqkk
 LtzQxGzVkcpC4MYF4OsmCLLjhWWK9T+qGlJ3PhVDDOHlQlkCAMXpwBMhI2FkWFmYLx5nqvs0YpF
 5gq7JeRk3nr5/TnE0ntR7ci0IydK1FwZ/heI2bzOvMV7sURW8uiEzO8R/X3fw873n90vxGDxVat
 3HRMA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.6.219]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4293a6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=UteWFfMXGp8A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=ZoOuzrvA5ULBp74qVeUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: dYhIBzPHjBrBE5HiyTOp4Pz9qhd_6Ni9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfXy7uAVVEhLql3
 O+Q8/hTseqCOtvnGJvrY0IEue6rOwMeGyTEqfN5mcNZc1jRbMf20OZ82IiLKOJq65znEkuOblIb
 e65iUXnp0BKEBc7V/vKpOrPX59Jb3dHFTTYc2q/veAQjAsFnBRIzXzAJMknUgi4o8B/BTPji2GM
 RRGuAjw6DDg5b93qdnroeOLuWknSKTlLn7kw2L+zow96pvB1e2io1rCNk00mxnVLbh/nwd7BG7g
 lprJcLxwfQqFZFoqAz3tDsK8RD5k4Wcce/K8eNH9kFmO/FpCrJ3XUgoi6SFejQ9oKVz3MwNiB/m
 P+jAP76WOwTqPibl6JVatHLs6s/BhPgPNJIx/TnUrJsaYVw2N84WrK8nXaY9u3Gl85GfB6KC0D4
 YSI5x7I9Jd/d0g/URoSqR3LgbA0wbTuXIhsBiBH0zopjgfhhlZTihiDJoLjkU7Tsa1XqxK+7CNl
 smGOoQJ7GuZEj48vq5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfXwvt4fZh1V+VR
 uesFB0Ps9KAViiCFKBgyEeDvSLgeYeoxONarEkbgzkR79tAcXlE90AVp1SQM32I/zYH9jkoDML7
 Hn/HP3IogNyiu8dBerKt4D+az+HdMGc=
X-Proofpoint-GUID: dYhIBzPHjBrBE5HiyTOp4Pz9qhd_6Ni9
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

I'll apply this towards the end of business tomorrow; my last day.

In case anyone reads this, I'd like to take the opportunity to thank
everyone who reviewed my patches, or sent patches for me to review. It's
been a great chapter of my life contributing to this project, and I hope
to cross paths with it again in the future.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Matt Coster (2):
      MAINTAINERS, mailmap: Update address for Matt Coster
      dt-bindings: gpu: img,powervr-*: Remove Matt Coster as maintainer

 .mailmap                                                     | 1 +
 Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
 Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 1 -
 MAINTAINERS                                                  | 1 -
 4 files changed, 1 insertion(+), 3 deletions(-)
---
base-commit: 2637cc60b0e10dbb77fbc749f5d2de10acf133f6
change-id: 20260629-goodbye-26468f9502b4

