Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9881FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7408110E97C;
	Mon, 29 Jun 2026 15:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="iuucbIyh";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0BDB10E4FE;
 Mon, 29 Jun 2026 15:48:00 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATKNB3000395; Mon, 29 Jun 2026 16:47:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=H
 11ndfnu+HlP5osipVtliJHgXnDq7yPOgDeu/zYelnA=; b=iuucbIyhwIaNZIN5X
 pljso6Q3KdwYNbpNUrJjA9Dud9HBYOKjsz6h+yPhTk4Q1iOdt8lD55iOczCn61Uz
 K3GJJrzxmp1vqyAw7MscK2kkV0eMk3myb2CkRCIEplHRwLmDBMW7IoeLju0RMYGa
 BNPSEQG/ylpkkDPHms7z3KKZ0LZd+f1wAyZuRqoBqS+180DRX4J4EhudCVeb9Guj
 RkihOXRN+sJ4m9cV6Mo9gbgJLVEf6Lw0wwlDtNVI3DU6bb5nAcUPX4YVv5olo7cr
 bEcBnNHljWJh+QJ1coux8a7KBz1Cs84IpJos0AP7dQngFsXvqW7F4ZR1jTVgzB5K
 KX2AA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kuj3rr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 16:47:58 +0100 (BST)
Received: from [127.0.1.1] (172.25.6.219) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 29 Jun
 2026 16:47:49 +0100
From: Matt Coster <matt.coster@imgtec.com>
Date: Mon, 29 Jun 2026 16:47:29 +0100
Subject: [PATCH 1/2] MAINTAINERS, mailmap: Update address for Matt Coster
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-goodbye-v1-1-3bab53a80c53@imgtec.com>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
In-Reply-To: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
To: <imagination@lists.freedesktop.org>
CC: Matt Coster <opensource@mtcoster.net>, Alessio Belle
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=RFDK1ETs1BmWS52JrlBOYalroQQm/nfKoVZJWw0vdi8=;
 b=owGbwMvMwCVWuUfy8817WRsYT6slMWQ5TV6idugr68rJdscN7moFxTulrjwoc8Xs5HuNzrgt5
 U3nPTc/6ChlYRDjYpAVU2TZscJyhdofNS2JG7+KYeawMoEMYeDiFICJsMkw/Pc/f1q2/2HziT7h
 hYxMmT8W9V7xuDxTetqSidbe8034P19n+Gf9QWVOSdnxnsWJhWVL7772ttmZ1v0hNue+wvMbEgk
 3mXgA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.6.219]
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a4293ae cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=UteWFfMXGp8A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=mDV3o1hIAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=iB0s77fEAAAA:8 a=JfrnYn6hAAAA:8
 a=Odnh0R2cAAAA:8 a=e5mUnYsNAAAA:8 a=Q0WHy3Y73_uH-jEgx5EA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22 a=pioyyrs4ZptJ924tMmac:22 a=HyUCkmmLtCL0fD60kmUx:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=lNAA6UHySJB7qmBR1x20:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: RhsFuBl-Ot-aqA5vBDbjtCs9HXyD_ebr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfX9OOGu/aRccOE
 0wOiEaZNyqg98ZAQ0V81EMOxZMuJMZKemc+UexZ4nyXFIuPOdmXGNaZLTsayTAQ3ianxWOJWUBc
 FvOI6iSYN6DCv/UPl5a53gRscRtO8CR2X02ycDG62JFFF++Va8f4EHWDwzynfQTGKqgJ/GZtQvD
 cbJI1B47HfdyMCeyFC6hM2FGyXKJHjsKRhRfYx2wRrHGXD4rvwyfIudDa7iRZmhc4OiU/70alYs
 ilYjclrdH2yppUt1LgwpfIuo27z3xA8am3Wk2EsFzzkOtLf6ApJwXUOkTDBih6ahV1c5DSiVYnn
 O9qne7vvFX+IX7uygT4cx/SwVFSt3/qS6yYuzkDiLuFSexfmS56wC+2+BGoI9tQpcQ2DbhblU9v
 iXfqem8/YNbLU4Vg3T+WnPi9txqzwyrNbbwmPgSAnqFqE+oWCB4rKYG6i5cPjeJxpfCW4dGCXKF
 DnKUY8oWv6s9fSexjDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEzMSBTYWx0ZWRfX1W+Fg28rfCcf
 V7GRPDzZn5nQ5bPM/tcLjkNFGe3g0HvB6xf7rXTeY8s6jrI4bR1UTXFJsh42hT8zaiolXJe4yjY
 1/HQO++85KSsEdrsqK2WcRYFxG1DHOM=
X-Proofpoint-GUID: RhsFuBl-Ot-aqA5vBDbjtCs9HXyD_ebr
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

I'm leaving Imagination; remove myself as a maintainer but leave
a personal forwarding address.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 99dba08041fa..ecc8e574df11 100644
--- a/.mailmap
+++ b/.mailmap
@@ -549,6 +549,7 @@ Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mu
 Mathieu Othacehe <othacehe@gnu.org> <m.othacehe@gmail.com>
 Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
 Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
+Matt Coster <opensource@mtcoster.net> <matt.coster@imgtec.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index fe02d1087ab2..8e7c2f9c8249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12567,7 +12567,6 @@ S:	Orphan
 F:	drivers/media/rc/img-ir/
 
 IMGTEC POWERVR DRM DRIVER
-M:	Matt Coster <matt.coster@imgtec.com>
 M:	Alessio Belle <alessio.belle@imgtec.com>
 M:	Luigi Santivetti <luigi.santivetti@imgtec.com>
 L:	imagination@lists.freedesktop.org

-- 
2.48.1

