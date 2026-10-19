Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BB606A32D
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Sf+wQAuI;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=VzyJ1Zz3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CA410E689;
	Mon, 19 Oct 2026 21:38:30 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC8C10E674
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:15 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLboV71358350; Mon, 19 Oct 2026 16:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3fSASKIQazpv+NzoskmF0uKVPoauqkOn811VozDg5
 dg=; b=Sf+wQAuIeNgwKW/isdUhKiF/10KBBU5EIkU7q3aAAOrl3peI1g+nxi7MD
 uyK5pE/8bIcQvjyHuiHT+yalrIOznZQhg1o4opDdFA6YxgZKJhPhXqT4HCXADSMG
 NvDWQ/JHEebYvOBw6nBWaXawia5ujhw6gHLKVl4xnLmsiOw0lVm06IVUI/3Au3pj
 BhekfdymLYlL88tOuMzJ3kizuiZY1wD5BInfwnMxD94+xnyiWCyCQ/T3mt4gwYN8
 WvUrHxmz5C1L+HVsRiuo1sQ/JOm+a36l7m9KR9O85wZRX6azGY23PL7waYRkxIuC
 JRtDs4odxQms6FfDhe45yeJ8wnDdg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd61572-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:09 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6cMV7Bg8jIRmof08fGfgAXBFceigDqqS8BbysUwuKo5exSDY7YMTsFagP3Sq5QvqxhCFsAUqidR5ETOrbZcola6/5/c11/eOFITl2Y++8RNOJ8OvgHgB1o4+JYhnqKaotng6wccJrrt6sTCesKW1hXn8gcmuRLYjaJT8Lq99FySz+o092OPSDltvCfOTVZE/tRp0JQaCcUvVSoIUKGudPG7qgh3Qh7atk+dRF1hxcZe0mvUR3V/IXqFLI0+b8Bpp5jGylSrJOTWsBMhFpgHzsJ9AzYdPoov/b8TS+yniEx2ywezlmiBCFPBzzV+HIMK8fn4C0pckjFQ8JI2PG2Aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fSASKIQazpv+NzoskmF0uKVPoauqkOn811VozDg5dg=;
 b=kh2jIhPHjei7k5vfDcKQJ01aR3hKRv+DtBtoj8jMNlkoFndCa8FntldP3TIZGFXBQ8brX4mcQEfKHR97sRR8ommhvdmo1W4V+mn4Ac3nQI2+cjAl1mnhaZJQ6eIrIrEaGrDp8HrgFZOcRTZiVL2ceJC/eEkbCeezQ2/B8V9Z59TlSy9P0rJTRN1l2OUZ0BnTUb8Q80eAyIhsI2DePvDW/Hy+xPo6XorLHPLYGWCo7DJctzKCzK/MORcq6s6N4p1B8T8hJc60EheKYlItfZb+sICKnNAU5R3HMti7IqhDS/dMISCf9b/Nwj/yqvjUjJ+myzi4cw5H+4YiNiVeX8CA7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fSASKIQazpv+NzoskmF0uKVPoauqkOn811VozDg5dg=;
 b=VzyJ1Zz3NeNpmznHQw0RpREreprfg8z5QCpgzNPswrRxTpBrVaNv1ygOxVtdWOGcxSsOgM4TSIRBz70Zm23D0dxsm4UrA141ERZ/LwaiU3fcT7rXLLzO/Q/CvJ/yL4z9XY9RnNP88QwTZoX/2hLEk16km/7sam+GKBFd5AfPx8s=
Received: from BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::31)
 by PH3PPF46347F8D1.namprd10.prod.outlook.com (2603:10b6:518:1::79a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Mon, 19 Oct
 2026 21:37:55 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::43) by BN9P222CA0026.outlook.office365.com
 (2603:10b6:408:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:37:54 +0000
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
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:54 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:47 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:46 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbjB1325945;
 Mon, 19 Oct 2026 16:37:46 -0500
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
Subject: [PATCH v3 10/14] drm/solomon: ssd16xx: Expose session management as
 plane properties
Date: Tue, 20 Oct 2026 03:07:22 +0530
Message-ID: <20261019213726.4145532-11-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|PH3PPF46347F8D1:EE_
X-MS-Office365-Filtering-Correlation-Id: c08d92bf-d1d4-406b-3613-08df2e293c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|6133799003|22082099003|18092099006|18002099003|3023799007|10067099003|261009223027099003|921020|260925022911599003|261009221227099003|56012099006|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 27/qqYMyn/IMyzjJAAI23S/mTdpJ/G+Jt90M6mTftDzRC+jS8sJDsdkH035n20UTSXCddW4FfZtqU9y9GQzBMxc97eEM4VXVLDTIOcULODmkdNhBViPEP27fOmWcqO0oHLMZhA/MZidJasiTcDiRW80l+/tOhQ4aOJfSH+Fu9qjuiW9SbxbTBDATW666MGwDqvffoEGZ4Xiw+oeWXEdEjHQI0k/iHkUx+my8AUXwqp2aHgJSFHRY7V3O6hat1fFs52dbz3dEbxBBiwuJixZIzieFOy/nf6AUf3kaj7skVpLLxGsA/XWZ52ZyjdtBddClgD2PicHctpf1pgPtHbAQtSfpoGoM7eWzxYOzc3JAkDY6ePIK6llarBtvSm83GasC9XmB/Y+/B3N3scKYME6H97WaERcLCOvn+o/7hHRti02sR7qHZOKFP602QF6IjfTZW5vtEuwQH+AnXJKawQBiFCVBPNb0UisrMc7bIJGCqTg79BXVO/snK8jjIn72eVB0VukKTT4ZS40hqatN0TpHAEfP1bI9k6yK07BWtAbDAgY1UGke2FDOZrBMCH0SPNfo3wpmEkrOyUsvJSoNWA4SxJXxSoWaJ5ea2qeknpriFo6MI9NAsgYZF4ZDTrMLEGxGkz1X0rxw44OsIst9OoLXFY65T4EiV8VFQhGcL/UUkmAYQtUSBNudjshGqTqdh2uiNfaBlvxH6LSADBc4MbPojgKqqIh5fxBusZimnPHVyADxeqPvUJAscjrDLqTXoHBW
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(6133799003)(22082099003)(18092099006)(18002099003)(3023799007)(10067099003)(261009223027099003)(921020)(260925022911599003)(261009221227099003)(56012099006)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nesf5DgAgRyOAmzgGb0EA3XtZX+HMyzdqi0F0/dDLcfASyozByXAqGRPPVgD+Jba7BTDCYv5mJREZhGkyoA2XCML0g9ZRCTmutFbXg4pPUaYV6np4CrJrc4f9HxG++5/lZipNID5WR0gmwoCw6i432RUPwglf7Op6Mo5nc+hQefWwvDsDY1we8gzmWq0nc0DkTyRoiJkIED79toSKwRa1f1OSDQLdSKMwwOfzHSrI9zfqmyWlTZbsmytaVy66lJs+F6OFBL9tlWqGEY7J9NIjDr8K53c0apxNRtTON4vvTYkwaSVQw1IVMjZvy1BrMuxgFtivJddQwryYuiPGbHTI0M4B48QDx3QZ6RJeN8z8e4NwNOEzPClmx02kXyAaWOCxfbvIQw/oenMbAuS7Wc6ESjndu3oFMCXeAOlDySl42/zRqq71POLkRLedG38RQos
X-Exchange-RoutingPolicyChecked: S15XEzXqWS3K6Vk6r4bnnyR5ERMRb9GaBhmylZ1QYaTC4UdliAW1fluOXlBuLF8fTd7WQsZER1Xo/YfhOfylwqhzZp00Gcczf0Da6zpk/G5DsK4K4ap+ajhSw5Nd+jQ1C++4kMK0kI2eVQyVXmbwXQrE6YH8b5uZ9TuJNUTR8t1yVcC0fnBx8sl7uQleksy3SFidyiAbXqnKKiAsG7yBtfxj94qT3jWY3PUmjx+hLeUrdb+N1WDZtNB01dIttjgtS+smUtjTxDhp8dtg/wIUoKm36BGj8UB+YMig5HIoctO+shF3WRsw8dSeHlu9Yiq6GbqxYOhB3WQ2PwOU1GWY0g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:54.5981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08d92bf-d1d4-406b-3613-08df2e293c1f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF46347F8D1
X-Proofpoint-ORIG-GUID: JiL_mgIli9HzQ2CPZvPwTZW3NyncqCdJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9oAizBEUEwY/
 v5e31KHuoF6fP1Wk76jVwihNIbGihvsIaviq8DqWr2DD0CQhDe/MPkWV71MBTKOF0Vl572QQJkB
 PlVySvSXPyuEmsXBKlcnY2YUesRqdsJuTTWNLBYjj9/LhSUuuk4kaHotdyxTFGDKDOyxHYxU/Jd
 aDkWktxIWiQIl7rhz54gQHWX2h1LCXF93w/jHEYMfJkRq7ZrvS1HUZUEIEbq/BT341ENTbRLg/i
 oPNvqqz02NXYql1bi3TkrwJmLyUUA/FAB51RqPxPPYLQQLwhl9w969j6E3C4I/nbljqnZFEDcm+
 a06YXkO7O3FmEZGNejfiQxP8Vdet1tr0nkdkiT87cg0o8hVz6WUDAumEIEB34TDIz2tndvUk5vJ
 HcNpFZ4HG0mvr9l2FKwmBNqq/b9yPjaG3QMVbOApDXyU5xlM0qADJO9ZA+lW4cKqyoioHoYnw5v
 8WY7y9H8WVDBzFJHgUw==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dc2 cx=c_pps
 a=zXfEoyyUBsLHcbwyVEaNwg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=1rMNQNvZ7GBMTDAT-SIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JiL_mgIli9HzQ2CPZvPwTZW3NyncqCdJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX1P07PU69jyxD
 gE8gfjI6S76TN/g0771xs6y3JhhcBSGVfkDsKnHKuuJfr4NTrE9eg/M0B4e6ydfhPG1ReWI/i5s
 os8mo43fHN+tuMRcjQTCdZUe5ZH+eVo=
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

Add DRM plane properties for the clear_on_* and refresh_mode_init
session management flags, allowing userspace to control automatic
display clear/refresh behaviour at lifecycle transitions:

  - clear_on_init: clear display when a new DRM master opens
  - clear_on_close: clear display when the displaying client exits
  - clear_on_disable: clear display when CRTC is disabled
  - refresh_mode_init: override refresh mode for the first frame
    after a new master opens (e.g. force full refresh to clear
    ghosting before normal partial updates)

Each property is an enum with values:
  disabled / partial / full / fast

These map to the internal representation (-1 for disabled, 0/1/2 for
partial/full/fast refresh modes respectively).

Defaults are seeded from the panel configuration at probe time and
can be adjusted at runtime via standard DRM property interfaces
(e.g. modetest, drm_info, or compositor property APIs).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Add a mutex serializing the session state and the panel access between
  atomic commits and master_set()/master_drop(). master_drop() can run
  concurrently with a nonblocking commit (e.g. on DROP_MASTER) and both
  drive the SPI bus with the same transfer buffers
- Sync the session properties from the new plane state in atomic_enable as
  well, since it runs before plane_atomic_update and used the values of
  the previous commit
---
 drivers/gpu/drm/solomon/ssd16xx.c | 209 ++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 6037717635a4..13bd825bf3f1 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -205,6 +205,18 @@ enum ssd16xx_color_mode {
 	SSD16XX_COLOR_MODE_3COLOR = 1, /* 3-colour BWR; RED RAM used for red pixels */
 };
 
+/*
+ * Clear/refresh-mode-init session property values exposed to userspace.
+ * "disabled" means the action is skipped; the others select which refresh
+ * mode to use for the clear/init operation.
+ */
+enum ssd16xx_session_mode {
+	SSD16XX_SESSION_DISABLED = 0,
+	SSD16XX_SESSION_PARTIAL,
+	SSD16XX_SESSION_FULL,
+	SSD16XX_SESSION_FAST,
+};
+
 /* Border waveform enum indices (0-9); mapped to HW bytes via
  * controller_cfg->border_waveform_table[]
  */
@@ -373,6 +385,12 @@ struct ssd16xx_device {
 	bool first_clear_done;  /* clear_on_init has already fired once */
 	bool cleared_on_disable; /* Avoid redundant clear in atomic_disable */
 	bool cleared_on_close;   /* Avoid redundant clear in master_drop */
+
+	/*
+	 * Serializes panel access and the session state between atomic commits
+	 * and master_set()/master_drop(), which run outside the commit machinery.
+	 */
+	struct mutex lock;
 	bool pm_force_suspended;  /* pm_runtime_force_suspend was called in pm_suspend */
 
 	int orientation;      /* Display orientation in degrees: 0/90/180/270 */
@@ -400,6 +418,10 @@ struct ssd16xx_device {
 
 	struct drm_property *refresh_mode_property;
 	struct drm_property *color_mode_property;
+	struct drm_property *clear_on_init_property;
+	struct drm_property *clear_on_close_property;
+	struct drm_property *clear_on_disable_property;
+	struct drm_property *refresh_mode_init_property;
 };
 
 /* Plane state subclass: refresh_mode lives on the plane, not the connector,
@@ -409,6 +431,10 @@ struct ssd16xx_plane_state {
 	struct drm_shadow_plane_state base;
 	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
 	enum ssd16xx_color_mode color_mode;     /* Pending color mode */
+	int clear_on_init;    /* Session: -1=disabled, 0=partial, 1=full, 2=fast */
+	int clear_on_close;
+	int clear_on_disable;
+	int refresh_mode_init;
 };
 
 #define to_ssd16xx_plane_state(s) \
@@ -1460,6 +1486,10 @@ static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plan
 	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
 	ssd_state->refresh_mode = device->refresh_mode;
 	ssd_state->color_mode = device->color_mode;
+	ssd_state->clear_on_init = device->clear_on_init;
+	ssd_state->clear_on_close = device->clear_on_close;
+	ssd_state->clear_on_disable = device->clear_on_disable;
+	ssd_state->refresh_mode_init = device->refresh_mode_init;
 
 	return &ssd_state->base.base;
 }
@@ -1490,6 +1520,24 @@ static void ssd16xx_plane_atomic_destroy_state(struct drm_plane *plane,
 	kfree(ssd_state);
 }
 
+/*
+ * Convert internal clear_on / refresh_mode_init value (-1=disabled, 0/1/2=mode)
+ * to the userspace-facing enum (0=disabled, 1=partial, 2=full, 3=fast).
+ */
+static inline unsigned int ssd16xx_internal_to_session_prop(int internal_val)
+{
+	if (internal_val < 0)
+		return SSD16XX_SESSION_DISABLED;
+	return (unsigned int)internal_val + 1;
+}
+
+static inline int ssd16xx_session_prop_to_internal(uint64_t prop_val)
+{
+	if (prop_val == SSD16XX_SESSION_DISABLED)
+		return -1;
+	return (int)prop_val - 1;
+}
+
 static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 					     const struct drm_plane_state *state,
 					     struct drm_property *property,
@@ -1506,6 +1554,22 @@ static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 		*val = ssd_state->color_mode;
 		return 0;
 	}
+	if (property == device->clear_on_init_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_init);
+		return 0;
+	}
+	if (property == device->clear_on_close_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_close);
+		return 0;
+	}
+	if (property == device->clear_on_disable_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->clear_on_disable);
+		return 0;
+	}
+	if (property == device->refresh_mode_init_property) {
+		*val = ssd16xx_internal_to_session_prop(ssd_state->refresh_mode_init);
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1535,6 +1599,30 @@ static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
 		ssd_state->color_mode = val;
 		return 0;
 	}
+	if (property == device->clear_on_init_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_init = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->clear_on_close_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_close = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->clear_on_disable_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->clear_on_disable = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
+	if (property == device->refresh_mode_init_property) {
+		if (val > SSD16XX_SESSION_FAST)
+			return -EINVAL;
+		ssd_state->refresh_mode_init = ssd16xx_session_prop_to_internal(val);
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1576,6 +1664,24 @@ static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
 						   false, false);
 }
 
+/*
+ * Copy the session properties of a plane state into the device.  Called from
+ * both crtc_atomic_enable() and plane_atomic_update(): the former runs first
+ * in a commit, so it must not rely on values only synced by the latter.
+ */
+static void ssd16xx_sync_session_props(struct ssd16xx_device *device,
+				       const struct ssd16xx_plane_state *ssd_state)
+{
+	lockdep_assert_held(&device->lock);
+
+	device->refresh_mode = ssd_state->refresh_mode;
+	device->color_mode = ssd_state->color_mode;
+	device->clear_on_init = ssd_state->clear_on_init;
+	device->clear_on_close = ssd_state->clear_on_close;
+	device->clear_on_disable = ssd_state->clear_on_disable;
+	device->refresh_mode_init = ssd_state->refresh_mode_init;
+}
+
 static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 					struct drm_atomic_commit *state)
 {
@@ -1619,6 +1725,8 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=(%d,%d)-(%d,%d)\n",
 		rect.x1, rect.y1, rect.x2, rect.y2);
 
+	mutex_lock(&device->lock);
+
 	/* Diff refresh_mode against the plane's own previous state to see
 	 * whether fast LUT preload is needed.
 	 */
@@ -1635,8 +1743,7 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 			device->fast_lut_pending = false;
 	}
 
-	device->refresh_mode = new_ssd->refresh_mode;
-	device->color_mode = new_ssd->color_mode;
+	ssd16xx_sync_session_props(device, new_ssd);
 
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
@@ -1693,6 +1800,8 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 		device->border_waveform_pending = true;
 	}
 
+	mutex_unlock(&device->lock);
+
 	pm_runtime_mark_last_busy(device->drm.dev);
 	pm_runtime_put_autosuspend(device->drm.dev);
 
@@ -1754,6 +1863,8 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (!drm_dev_enter(&device->drm, &idx))
 		return;
 
+	mutex_lock(&device->lock);
+
 	if (device->clear_on_disable < 0 || device->cleared_on_disable)
 		goto out;
 
@@ -1775,6 +1886,7 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 	device->cleared_on_disable = true;
 	pm_runtime_put_sync_suspend(device->drm.dev);
 out:
+	mutex_unlock(&device->lock);
 	drm_dev_exit(idx);
 }
 
@@ -1782,6 +1894,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_atomic_commit *state)
 {
 	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, &device->primary_plane);
 	int ret, idx;
 
 	if (!drm_dev_enter(&device->drm, &idx))
@@ -1797,16 +1911,28 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	drm_dbg(&device->drm, "atomic_enable: %dx%d orientation=%u°\n",
 		device->width, device->height, device->orientation);
 
+	/* Serialise hw_init and session-prop setup against master_drop(). */
+	mutex_lock(&device->lock);
+
 	if (!device->initialized) {
 		ret = ssd16xx_hw_init(device);
 		if (ret) {
 			drm_err(&device->drm, "atomic_enable: hw_init failed: %d\n", ret);
+			mutex_unlock(&device->lock);
 			pm_runtime_put_autosuspend(device->drm.dev);
 			drm_dev_exit(idx);
 			return;
 		}
 		device->initialized = true;
 	}
+
+	/*
+	 * atomic_enable runs before plane_atomic_update, so pick up the session
+	 * properties of this very commit instead of the previous one's.
+	 */
+	if (new_plane_state)
+		ssd16xx_sync_session_props(device, to_ssd16xx_plane_state(new_plane_state));
+
 	device->cleared_on_disable = false;
 
 	/* Clear display on first app launch if configured */
@@ -1826,6 +1952,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 		device->init_refresh_pending = true;
 	}
 
+	mutex_unlock(&device->lock);
+
 	pm_runtime_mark_last_busy(device->drm.dev);
 	pm_runtime_put_autosuspend(device->drm.dev);
 	drm_dev_exit(idx);
@@ -1889,6 +2017,13 @@ static const struct drm_prop_enum_list ssd16xx_color_mode_enum[] = {
 	{ SSD16XX_COLOR_MODE_3COLOR, "3-color"     },
 };
 
+static const struct drm_prop_enum_list ssd16xx_session_mode_enum[] = {
+	{ SSD16XX_SESSION_DISABLED, "disabled" },
+	{ SSD16XX_SESSION_PARTIAL,  "partial"  },
+	{ SSD16XX_SESSION_FULL,     "full"     },
+	{ SSD16XX_SESSION_FAST,     "fast"     },
+};
+
 static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 {
 	struct drm_device *drm = &device->drm;
@@ -1908,18 +2043,58 @@ static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 	 * Color mode: only meaningful on panels with a physical red plane.
 	 * BW-only panels get no property at all rather than a one-value knob.
 	 */
-	if (!device->device_cfg->red_supported)
-		return 0;
+	if (device->device_cfg->red_supported) {
+		device->color_mode_property =
+			drm_property_create_enum(drm, 0, "color_mode",
+						 ssd16xx_color_mode_enum,
+						 ARRAY_SIZE(ssd16xx_color_mode_enum));
+		if (!device->color_mode_property)
+			return -ENOMEM;
+		drm_object_attach_property(plane_obj,
+					   device->color_mode_property,
+					   device->color_mode);
+	}
 
-	device->color_mode_property =
-		drm_property_create_enum(drm, 0, "color_mode",
-					 ssd16xx_color_mode_enum,
-					 ARRAY_SIZE(ssd16xx_color_mode_enum));
-	if (!device->color_mode_property)
+	device->clear_on_init_property =
+		drm_property_create_enum(drm, 0, "clear_on_init",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_init_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_init_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_init));
+
+	device->clear_on_close_property =
+		drm_property_create_enum(drm, 0, "clear_on_close",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_close_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_close_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_close));
+
+	device->clear_on_disable_property =
+		drm_property_create_enum(drm, 0, "clear_on_disable",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->clear_on_disable_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->clear_on_disable_property,
+				   ssd16xx_internal_to_session_prop(device->clear_on_disable));
+
+	device->refresh_mode_init_property =
+		drm_property_create_enum(drm, 0, "refresh_mode_init",
+					 ssd16xx_session_mode_enum,
+					 ARRAY_SIZE(ssd16xx_session_mode_enum));
+	if (!device->refresh_mode_init_property)
 		return -ENOMEM;
 	drm_object_attach_property(plane_obj,
-				   device->color_mode_property,
-				   device->color_mode);
+				   device->refresh_mode_init_property,
+				   ssd16xx_internal_to_session_prop(device->refresh_mode_init));
+
 	return 0;
 }
 
@@ -1946,6 +2121,8 @@ static void ssd16xx_drm_master_set(struct drm_device *drm,
 {
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
 
+	guard(mutex)(&device->lock);
+
 	device->cleared_on_close = false;
 	device->first_clear_done = false;
 
@@ -1963,6 +2140,12 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 	struct ssd16xx_device *device = to_ssd16xx_device(drm);
 	int ret, idx;
 
+	/*
+	 * Not serialized against nonblocking commits by the DRM core (e.g. on
+	 * DROP_MASTER), so hold the lock across the panel clear too.
+	 */
+	guard(mutex)(&device->lock);
+
 	device->init_refresh_pending = false;
 	device->first_clear_done = false;
 
@@ -2074,6 +2257,10 @@ static int ssd16xx_probe(struct spi_device *spi)
 		return PTR_ERR(device);
 
 	drm = &device->drm;
+	ret = drmm_mutex_init(drm, &device->lock);
+	if (ret)
+		return ret;
+
 	device->spi = spi;
 	device->model = model;
 	spi_set_drvdata(spi, device);
-- 
2.39.1

