Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC7606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZAVfadfe;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=FArrOEAZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9001810E66B;
	Mon, 19 Oct 2026 21:38:25 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7302810E673
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:12 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLbxXD1358411; Mon, 19 Oct 2026 16:38:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=iPdQquN/MDj28p5SNgtFDVG7f9S7/2aYZY4+lRuFI
 N4=; b=ZAVfadfeVY1a3wHjaWMiRcbJFYAq9Ub1fhoVPL4bByiEhnImkEKl+i8N0
 14eaG4/S6ckQNTihCi5UO/P5xcUKa+FsMma+ywU2Vl92UcMISHsKm6V4qJIZAKSr
 mtk+v8j0R1aYutrABwtme43DdYi4AKhw5xsdknGmtsktPnBiF34MX7T2GEuYEqGl
 L151vk7shozwjbXQVnLOwEQdsH0kVT67gBzvPPiIbSegI2jNqdfQEZQZ6YOIHNG/
 zU5K7at+6GYS79R32SrNUcxI/dbsNVniffkg/ppfhhL1tyrIq+BtzPIa5Syvv4vT
 +XFLNe7LbQLgYECjiNqXxO+rhVccQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd6156y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:06 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JouwCqZ3mxysKDuN2zUA4pimY2nFNpalN+NrXb7l18g3/ZFUbIyaytL8Q+kSuL40moTTrQiy0ua4xkfMz+xIaM1Q9Jnnno7Up9bPmhRhZOvfgXRUg7H3ytOZQgib60G+r+tICov6g0ybA/oQn+Zbz09MOYKEu3XANJiq7vsIQyswcN/DsDVz7CNrAP34UCxG4r25Dn5DQdaze713g5mC2S2SabCqI3EkPmnZIFyZO4E4yLFuBO3uMy6uWk0og1ljFRpjYAw79lRay+3EuFG3+IlUao0wrLdC+Ec2l3sOjRJ8ylI5Taf480XJLAJ8MeA/iGHOE9P1gFuAZ1zzkWmU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPdQquN/MDj28p5SNgtFDVG7f9S7/2aYZY4+lRuFIN4=;
 b=FgjxasaMmVlDr8rJ2Y9z1+zu4tYLcUyyemQ7OgOiabH58shie9zH4pIrqMM82OIA+JEOTbrXfCr2JQYvtWtVsI/s+8C3uEzEjmXV1LGfywAHFNQj2XLKfNtDUo7MllLAym//AYgTGMz44GpXC+G6shl5EEWBshemptK2KUkvQoVkGXEWE8TmYFRQQ93eJKcQZDb3aUXXxOdGKrivH3VV3y8HDqLAjGpfE2yq7JeG3sbs+Z38btOWNSsmy0/j1MiYgQJXbVQYTYgFB3zViEItw+j6T9b3mO111yWKREEJqWjbCeEVhTIBKiUbImHJEKOccltZLK8375vfKgKYLB4W/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPdQquN/MDj28p5SNgtFDVG7f9S7/2aYZY4+lRuFIN4=;
 b=FArrOEAZKwVYanV+YRybVLkqGyqD9yvgCAOYtoySR2YNUv6sBj4ka6b53Pu8JSTqgpZOhe8d3Nf/PsEDP9tEYOcMAHCKxR26ZjO7+iue1Vc6DdS13qS6iV3c0Hl7nCtFfSij6lN/IgWh4G78hyICfEg9XjYDlPf4sP26QW/qT0E=
Received: from BN9P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::15)
 by DS4PPFD91C619EF.namprd10.prod.outlook.com (2603:10b6:f:fc00::d4e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:37:59 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::e) by BN9P222CA0010.outlook.office365.com
 (2603:10b6:408:10c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 21:37:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:58 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:54 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:54 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbrk1325996;
 Mon, 19 Oct 2026 16:37:53 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 14/14] arm64: dts: ti: [DO_NOT_MERGE] Add AM62L3 EVM
 overlay for GDEY042T81 e-paper display
Date: Tue, 20 Oct 2026 03:07:26 +0530
Message-ID: <20261019213726.4145532-15-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b1f91b-a861-4dac-1adb-08df2e293e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|7416014|18002099003|22082099003|10067099003|3023799007|13003099007|261009223327099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: lFTFV4MSl0Zljryggk/AuX9si+FuBFkTkp7OIEiBoXkhQ7yPStW7hNUWB0pPLxvwQewx0D44kfpv5q3zwDXAKQ1N27wdwrHPoHrGy73/ysQ/xUGt+UdtWldgGK8vCuMgDp2nBgGM4gGA+7ZwAz+LBVA8yvycs1X3Cz9QqZVC1/T43mfVilLVmMtxzjCYqj88hndELXythdZENKGSI57F6+2Uo3GAVrW3qEODIcNd2ibcHeO8HNiQqeiCgbp4QDmZoY8xtoNL+e6sxoKodu5JQjehZzHxqNhZMWj6ccxVp1I9Np6QvGR+MtSJ087oC/Gea1HaRLGDDjHJch68UB0PiegJBEPL5oB2tEnsBxAAJHQknaS9CEAOhs8GvT8efzerAVaIRLRnMYEkr+Ngwqi4bsNPvh6f5Wo03wBs1cJ20Z/mOmixyYnNAAz6igzIhH9RSccYHacdCxwOvhHLafgTJ6X3U5QZz7afNw7vHS1OXYTkQ3FbOf+xdFhlFuFcWKum/S5dpAyAf5lxNwnl0619FEoCmJ9HqAiwsM2rg0n+Kro4WiMTSaPVDCiv7ZcUSHIzHfmUoY+EPWqh7c2UWkSkUkTQbZt9VwOrV/xM8DIYDrtgKBvgWhk/urdJ0bShQ36s0o7kj4dHWZUMNqlI8524GvbHt6Nj+9fabbhnsiP4plq2rzPwVx6sxvC8t7+QH4ws
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(7416014)(18002099003)(22082099003)(10067099003)(3023799007)(13003099007)(261009223327099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(921020)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IwFZ/CFYq0q/AfoFOF7fH/JZO16eFntD6kaUUI4+Qv6bEBFbFkSVLtcvQGhve5RfYcSW7/o1fKmSkWPtrO2dKZ6bYRARuJPerMPLKoZEWLumM0q4GtXWLzbaYB3JkV1WaA0TKUDKZSDkqebLUJyHegHD+GAlWHn3N/3D+gbPOTzpbFmfl5PgA5Ldigr7QjfgAN9S9gCAY+oe5t055gwy6WcX017Vd5Z7ZRpwxk8xUpaZo+C3tq6kJxL7npXYu4PnSts6Uhj1Tfy7Vyvd/soCqzQI4VD0aXOClmwqAM7GqhHbRBX+7R5OL9eCEYy9cIu3Zd9YLBOrTz2c3lGs3SO5CCa3mPjxJOGOwkQ8eBlHy3mHwEpvIbfrKcLwrL62KPFrHj43ktpNNxbxmw6x3dBqk7NVr7rNhW29PzPUrR3p2OO83frNm7PbAIAMNQx9Wqym
X-Exchange-RoutingPolicyChecked: al6JhiFNdEv1/HCLaOZUsIs9DfWPhu9ZQQyb4rQ4cFBimJv85l/DeDk0cnMaaNa4Lv1l4izUktJzWVw2aDaJMiV1pGL/Vs1kWztyPHUcv4BcyWPYznWTMPELT/j3AIYtg7TiPfokM+/oNopA7uzAHbhiq8gjIcuWJ57lTlH/q5qkiJWp8xLFUbNR5NcBKD9UEMLwDs9ZDkGOcyIrSshSXKNwHxrcx0+og+jHrxcceGrZSVQ7Q/sTW5XFkJ803ekfFYc+FFKnNM5waHqZwYfI2uwQrAooKjFjIEaOR3DDwXqIRtdsfvjev5wiKUYompMdQwa1I78T0kB6VFJzSSFq0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:58.7789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b1f91b-a861-4dac-1adb-08df2e293e9d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-ORIG-GUID: YrxJf0wqDa6Aun8Uye9DIzwiqCITciAN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX5T6lbfyJMt7n
 lwGRsFD1Sf2WNgIdpGg6NZ/nM4QNd6epX2bUfqJwFeKGZT75YzoEdCEqgvRvs4MBJfffmw7A6oE
 YKlc67UHruGgCoMUmFkW1DzUBgNF7TQsUsuxDo0WkXvZhVp1WEj05GlSOQzg45QI2qPcYXA9Kbb
 iW37Rde9tPvUamuQIu2ntnsyRCGBm6PufGgzHXf5ylgVUqs1u3HUWoDEZrylfk66uMyqaZSFCtI
 QWiRTrxygI/wEWtCaFTDR8w2VdMc27Koawl6XZp0dr2MMOP7qCrEDjkAbTggXoDfpml8I4cBPdx
 p1a+BQm4ZQTg6+d9PnyxrsJEUz42fftRYdOrk/90KUhoNCFIBQ7ED1w7Heya8U7EjrV/eePh5tv
 sGQ1Zx7k9mq1CBRYBPbwtJXaoMGj7+0RpzM5bz8jNnP1Zz3KFTnpG69ocsSK6Fi1OBlFz51wDwq
 5GSFJNcbqx3KiVoQdgw==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dbe cx=c_pps
 a=1mmXF8F6+aLADKsbn3w/2Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=zmbZ_4TfkIE7zwaIlw4A:9
X-Proofpoint-GUID: YrxJf0wqDa6Aun8Uye9DIzwiqCITciAN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX0tJsTkV7h7tw
 No2MvX1Ka+2qo1dkaZut+IeIg+CMMo9q1huIRqaPptk3nv15guHYBtq1eOmu8GnApc3cW600vfj
 135UhbCeFPJKkkTXzjCynFgpr7fXj60=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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

Add device tree overlay for the Good Display GDEY042T81 4.2" e-paper
panel connected to the AM62L3 EVM via SPI.

The overlay configures SPI1 with the SSD1683-based GDEY042T81 panel
at 2MHz, with reset, busy, and DC GPIOs connected to Main GPIO0 (&gpio0).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  6 ++
 .../ti/k3-am62l3-evm-epaper-gdey042t81.dtso   | 96 +++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 795978e962ee..90e7a687ca86 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -82,6 +82,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62d2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62l3-beaglebadge.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62l3-evm.dtb
 
+# Overlays for AM62Lx EVM
+dtb-$(CONFIG_ARCH_K3) += k3-am62l3-evm-epaper-gdey042t81.dtbo
+
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-var-som-symphony.dtb
@@ -319,6 +322,8 @@ k3-am62a7-sk-csi2-ov5640-dtbs := k3-am62a7-sk.dtb \
 k3-am62a7-sk-csi2-tevi-ov5640-dtbs := k3-am62a7-sk.dtb \
 	k3-am62x-sk-csi2-tevi-ov5640.dtbo
 k3-am62a7-sk-hdmi-audio-dtbs := k3-am62a7-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
+k3-am62l3-evm-epaper-gdey042t81-dtbs := k3-am62l3-evm.dtb \
+	k3-am62l3-evm-epaper-gdey042t81.dtbo
 k3-am62p5-sk-csi2-imx219-dtbs := k3-am62p5-sk.dtb \
 	k3-am62x-sk-csi2-imx219.dtbo
 k3-am62p5-sk-csi2-ov5640-dtbs := k3-am62p5-sk.dtb \
@@ -458,6 +463,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62a7-sk-csi2-imx219.dtb \
 	k3-am62a7-sk-csi2-ov5640.dtb \
 	k3-am62a7-sk-hdmi-audio.dtb \
+	k3-am62l3-evm-epaper-gdey042t81.dtb \
 	k3-am62p5-sk-csi2-imx219.dtb \
 	k3-am62p5-sk-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso b/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
new file mode 100644
index 000000000000..1ff43fb54df3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DT Overlay for GoodDisplay GDEY042T81 4.2" E-Paper Display on AM62L3 EVM
+ *
+ * The GDEY042T81 is a 400x300 black-and-white e-paper panel driven by a
+ * Solomon SSD1683 controller, connected via SPI1 on the AM62L3 EVM
+ * expansion header.
+ *
+ * Pin mapping (AM62L3 EVM expansion header):
+ * P5  --> BUSY  (GPMC0_CLK.GPIO0_31)
+ * P26 --> RST   (GPMC0_AD1.GPIO0_16)
+ * P27 --> CLK   (GPMC0_AD5.SPI1_CLK)
+ * P28 --> DC    (GPMC0_AD2.GPIO0_17)
+ * P29 --> DAT   (GPMC0_AD3.SPI1_D1 / MOSI)
+ * P30 --> CS    (GPMC0_AD4.SPI1_CS0)
+ *
+ * The GPMC0_AD[0:5] pins are multiplexed for SPI1 and GPIO use; GPMC0 is
+ * already disabled by default in the SoC DTSI.
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-pinctrl.h"
+
+&pmx0 {
+	dc_pins_default: epaper-dc-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x0080, PIN_OUTPUT, 7) /* (K22) GPMC0_AD2.GPIO0_17 */
+		>;
+	};
+
+	rst_pins_default: epaper-rst-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x007c, PIN_OUTPUT, 7) /* (L23) GPMC0_AD1.GPIO0_16 */
+		>;
+	};
+
+	busy_pins_default: epaper-busy-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x00b8, PIN_INPUT, 7) /* (L21) GPMC0_CLK.GPIO0_31 */
+		>;
+	};
+
+	main_spi1_pins_default: main-spi1-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x008c, PIN_OUTPUT, 4) /* (H22) GPMC0_AD5.SPI1_CLK */
+			AM62LX_IOPAD(0x0088, PIN_OUTPUT, 4) /* (K23) GPMC0_AD4.SPI1_CS0 */
+			AM62LX_IOPAD(0x0084, PIN_OUTPUT, 4) /* (J23) GPMC0_AD3.SPI1_D1  */
+		>;
+	};
+
+	fet_sel_pins_default: epaper-fet-sel-default-pins {
+		pinctrl-single,pins = <
+			AM62LX_IOPAD(0x01a8, PIN_OUTPUT, 7) /* (E13) SPI0_CLK.GPIO0_89 */
+		>;
+	};
+};
+
+/* Drive GPIO0_89 high to select the SPI1 path on the VOUT0 FET switch */
+&gpio0 {
+	fet-sel-hog {
+		gpio-hog;
+		gpios = <89 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "GPIO_EXP_CONN_FET_SEL";
+	};
+};
+
+&gpmc0 {
+	status = "disabled";
+};
+
+&spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_spi1_pins_default>, <&fet_sel_pins_default>;
+	status = "okay";
+
+	gdey042t81: display@0 {
+		compatible = "gooddisplay,gdey042t81", "solomon,ssd1683";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dc_pins_default>,
+			    <&rst_pins_default>,
+			    <&busy_pins_default>;
+		spi-max-frequency = <2000000>;
+		reset-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
+		dc-gpios    = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+		busy-gpios  = <&gpio0 31 GPIO_ACTIVE_HIGH>;
+	};
+};
-- 
2.39.1

