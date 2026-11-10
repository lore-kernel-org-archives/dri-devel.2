Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CF606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qiUVaD9X;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=qiUVaD9X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7EB10F542;
	Tue, 10 Nov 2026 15:41:09 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011055.outbound.protection.outlook.com
 [40.107.130.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B6410F7A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:57 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jTeulrsLsPbOQ3iNVyprqniXT2Hj7fMqXQLuOveK/SNaSqBBH9KIi54ieImyZ+iIFiXaOcsyzJKF7mr9phcICjsnE3jGTJ5J0ZeWBG1YGncB7i6SesL8cBboted5BUHQNjqs2/PbWDdVIT2ancns/OYtBr2VK86CPGfpqbUpvu9WIz1O8wOd9R7XSGOFy/dnzgP6bXPwHP61ENOUKOm72yikSYf0ujzymG+7PdHErD/KQRGMAchkvCT3ZE18wSWlUpaPOxBifn1DlWCivO/91xr2b+dXQoP6bKNoJxiJ2LBKrI6vt/kb88O1oxXYVqyJexkG9I9N7HL7vjhaxKuS4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQOATG7w6sA9sQ9XiUO1LjvaRiP42bk1J7ztLygjgI0=;
 b=nXlYhV9IWkvMiXZVotcKHk0eezdmpYTCBTDe8WtL/J5Ix+c5JTMsVOP7hZBBFrCrfv1JaDJnXKVaenwyHoFY0wL6phphmxTTlBwRXYCIyz8RiPbgPwjRmjetBOuItFvSQXAzQUVQmM085icj4b6ZEnhUPlBkLcAVirGN66khz6VvgQ0m2URsUh1tDu0GPlCvZyU7ZUXxMWsBM5QshdeueIoShBxxjEGTf9ph9rcNWANs1i4xFq1yC0yh5hyFO6uLO5PKPsIvOj1IHMHj8xtzg05Zs1Rlz8PZoTuBLctdSF8BaqnPoWvYX6BOAAa0vTCF5nGMyKJR0/4UHCG5wLqbOg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQOATG7w6sA9sQ9XiUO1LjvaRiP42bk1J7ztLygjgI0=;
 b=qiUVaD9XbJjMm3dij8h3T6fsYSdV5CCVQYNJ1DaZL3TyiSdoqg7acCUio5e3Ynuv3A4y7PC3sROy8TFwWBQ12U0r7vrwI7mqtkLAwJ5Syw/Ti/0D5/CQ8F5VIL76G3ReBcd0WFttPm65CrYwTcx+2mour7KEqsHSJSRYP8n7NIA=
Received: from PA7P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::7)
 by DB9PR08MB7423.eurprd08.prod.outlook.com (2603:10a6:10:370::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:48 +0000
Received: from MI3PEPF00008484.eurprd02.prod.outlook.com
 (2603:10a6:102:36f:cafe::66) by PA7P264CA0170.outlook.office365.com
 (2603:10a6:102:36f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008484.mail.protection.outlook.com (10.167.240.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HttZucerUO9Su0qjyKWQeHwzNRwI7xVwcveSCTspYzLEGRnszp30gTOP1+W1fnSUAEjllVAZ4TTs80Zn+D6L/lL7XxGbzmoFXFKbeNaX0dpBEIe6jLvNdy5/mJ7Zm1c/TyN/vPyKDE1l2WILTbhQn4vUtGE/nIqc9YquihnRGRC84yWdNSlpBPQqFDP2OJ9wujE5p0YBa/rjwNKEb8zRKHszAdFfh8UY3MwTh67DzWj08p8TgFEc7iD2hiSbX8y0/ngcObE4LvA9M4ZJ5pFsklNYmHNOWCpNpXOvd+pZUYpYaKbvyRB8tNcGkzMmYBZ9wbZFMXI8uPxPu0AS5dXR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQOATG7w6sA9sQ9XiUO1LjvaRiP42bk1J7ztLygjgI0=;
 b=fWRTPCPc4preysXaE9hC4ja8rNmSHWznu6qTqBhRsp41xv6W3417Oeipu+0p6dLwwoKtiZ2mLI8zA9BH6QRz37GpKx1EIOcBtxutI0Dr/WRFDzU7HyC3aO2J4ylem7bGDSb3Yt8/3xq2ZhDO9lqEvkgDF9GEyzP9WfGRexHyb5tKnI2Eyx4GKgqVe+GhlWkm+C8clbzwSK2y82OjRcsThzyNK1mLgDKeaUgNr3twURzMGw7jwm/76YR8SbO92BTFws3xAmNAVFZaiNTC1dw15afNZp6fNMNxSVnvo/gYF2CWZjbCM2yYLEGHLohrklBwInEW/BF3JQQtbAYr2wv7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQOATG7w6sA9sQ9XiUO1LjvaRiP42bk1J7ztLygjgI0=;
 b=qiUVaD9XbJjMm3dij8h3T6fsYSdV5CCVQYNJ1DaZL3TyiSdoqg7acCUio5e3Ynuv3A4y7PC3sROy8TFwWBQ12U0r7vrwI7mqtkLAwJ5Syw/Ti/0D5/CQ8F5VIL76G3ReBcd0WFttPm65CrYwTcx+2mour7KEqsHSJSRYP8n7NIA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DB9PR08MB7844.eurprd08.prod.outlook.com
 (2603:10a6:10:39f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 10 Nov
 2026 15:40:14 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:14 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 07/28] drm/panthor: Derive MMU AS register addresses from
 base and stride
Date: Tue, 10 Nov 2026 15:38:28 +0000
Message-ID: <20261110153907.3241978-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0073.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::18) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DB9PR08MB7844:EE_|MI3PEPF00008484:EE_|DB9PR08MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab48ee1-a0db-4cec-e453-08df3f40fd80
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|261022075727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|56012099006|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: tIKZaeKa5nOn6cKaOlFifGC6zclPvVBK8kFWtXXqMg9a2gLoTpOczZmUFcx5mb7OL67VJY/FW3fziXvXYUI0iB+ojIKi9/KVr0JyhUjtbCA76NIiIOM9R0s0lJeqe9efrez/IXh7Eo4s3bR6xc3+4a4vZVMdqubreO5I/kUqXEleqEqtKG8wF06Wq5v5+Z/7P31VTnBwbKoHg2Wy01NEGakRsErqbWRppMy4hePfgfmIuvw/GmlZExUDM2eLwjU1d4/5BRtsOMIJ4y58lYAMNP6+aWv8I36x/615UAQw9o4QpMGjj1rWMY4eFRBxDNdVWahlwi+3tZxYW1fiWZKMPVhXUBgsj52TGneCovyB3YSzi/x24gzV+0DwLxBy91Qeac//VkwBtBL3/4GLYjnvYhGecY3wGEZCMN+Zt2V4Goptl3iH0H0YQr7ldo8rP3K2WEpOGwRI3CjRxejFvYyCYzO/GQ2AIBzWfdYUm/H2vV96SYoXm+fWUwZg0YVaVW00dvTDggIC2y/lRzSJoGUYhQgsSKk6BZmalezbX5XoDwB0K0Rcl5ItnSTNpzehvvt7bpJP0WvOnh6Q9lpcIuMrW0PII7hkQQzT17GcPiUm7OhsTWPh3OeCSwUIY98X5xWg
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(261022075727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(56012099006)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: iAwbEvQI9ZmxYqiazYb0V749Ka6q+3qxQwwW3cJjadZLEuSNkwi7ClRK2T4F9215tCQMt+Vpfa7BuQNe50Atym0eYajOL5NJEq/ZhBjof84mnshT1EB8kAed57RQ10M9aDU6ByVtu2pTDrY9VLqt/y0WXXj55SRccRntDId5Y8A5T52p/WNLkjpgmaYp+wvijqJfy59GfdmuPtxu0TPsabL3KYB2Trth0qfD01I+T8YoV0eTy0YKzJIqhDGiekkmlredga0rEwlWZEHMCkrP3/8vsZVMxvEWyOs2TkrIM5IJDo80uWsSkXrfvr7nO1Fr6gp81b/FJmmCOKUyrdM2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7844
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: aab56e46-7950-4bf8-0bed-08df3f40e9bb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|35042699022|14060799003|1800799024|82310400026|36860700016|261102123227099003|11063799006|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261026140227099003|261009223027099003|56012099006|261026121527099003|261028144727099003|22082099003|18002099003|10067099003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info: o5vYR6BPix6UrzhrizplOsfUUPW7+bDBRedTpTM7jw5tOvMxDcWhW7uC+ajX+PgmxpQs1YsroIKRwJ0VNPtt/8OwavBMDRsy8GH6rsho8bgLhmKrfj+v/SP3G/4ZSiE6wvL5zVv6MJbxEWbHjcYL3Cy1cSpLVqXvgTShhri2IQYTeb11id+aAeXaq+bCiFBSKZdg7AAQVnY3fK4SDdBEBps6DuVbddeW7auVLOhn1rPjsdWV6Vy5UHyv9PWmiWK42wPQvP/5AfmMQejQSvluuatCJyStlxSf8gb+i3E1HQ0uZlF/XQ0wrw9sOk5MJaecSnDw/3celki72bmzuEGtzvMsr0dQKCag+LqFVFrBE/KT0kz5jE3P9bE+NVKomRC7sfB81Krxza/Pt6DVJqwr2ewLA9GhqWdYE8p05HU/okWHluEfOedltEHG+vkfmpu7x8vqpF7LdDsaGD2k7v2DBaCS6FpMtZ0HXkbgsN2w80Z8Not9bMoAKvQPOPhGkH1HL18wiqhJVAztXau5jL3KT340RSwE6o1pXvVNqwy1AqaUlbWq9ofX5TCEHGWe4hK5EYRQzRGSRa9wCLqYLapssMc0ERgLIdXItLkVew92eG9ZYpk741wwZx35VqNQa886a1MAo/gSb067hWtVxNsLoy58wFV/QGjpm+Los8MMQQY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(35042699022)(14060799003)(1800799024)(82310400026)(36860700016)(261102123227099003)(11063799006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261009223027099003)(56012099006)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(10067099003)(3023799007)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: olGT+j+FqOaIzDToBtrVDp+Sth481zz+oV606MTESGuzlKu0Xh/s4x4G7N2T+yVo8aUwHXPNaMHcTGARrZCKHTgIfwbqrQcui960r7AVXmghwpj9u+LEH3y4PTIxaQ/VA7JQhx0LMAvsl8JQ0DLT55I24Yxp4c+tLRdVibxficX8urmVRIBk+D/xOVG83csTkY/nmAJDU+9qQroQ7ilm3mfH6AmRXjnWdr7JgrqK4I+8RyAiNxsLgKlUNmf+5HzPmY0GnRPKPXSalt++dzpl9LZ3poWgajbMq+6EEAKhWnyfe31y1Fa7+dfffCSP7g7upFhTq2d6bEGZNqE1G0ryqjXlwI9qU5icCiYlhFxT8Bwcsm7JKj5Dh68DHFhLwg9cF8xXutJPA4pKCTKuSntkNPwHiBv8P62qcPjcNRTfWpLNg+EK8XVHuqI/zpW2YfDw
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:47.1338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab48ee1-a0db-4cec-e453-08df3f40fd80
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008484.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7423
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

Move the MMU address-space register layout into the hardware description
by storing the MMU_AS base offset and per-AS stride in the Panthor HW
map.

Use those values to compute the iomem pointer for each AS slot and make
the MMU AS register definitions relative to the per-slot register window
instead of hard-coding the slot offset in every register macro.

This prepares the MMU code for GPUs where the MMU AS register region is
not at a fixed offset while keeping the existing register accesses
scoped to a single AS window.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
- Avoid enabling all AS IRQs on init and replace with explicit IRQ clear
  to preserve init behaviour. AS IRQs are enabled as part of
  panthor_mmu_as_enable(). This also prevents accessing NULL iomem
  pointers for initialized AS during init per sashiko's comment.
- Link: https://lore.kernel.org/all/20260922210016.0C0961F000FF@smtp.kernel.org/
v1:
- align with updated panthor_hw_regbank structure.
- moved AS iomem tracking into panthor_as_slot and introduced as_iomem()
  to retrieve it.

 drivers/gpu/drm/panthor/panthor_hw.c       |  8 ++++
 drivers/gpu/drm/panthor/panthor_hw.h       |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      | 47 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h | 23 +++++------
 4 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 9a7d0a2edb870..3a344fa292168 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -45,6 +45,10 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.mcu_control = {
 			.offset = 0x700,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
@@ -64,6 +68,10 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.pwr_control = {
 			.offset = 0x800,
 		},
+		.mmu_as_control = {
+			.offset = 0x2400,
+			.stride = 0x40,
+		},
 	},
 };
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 0a82152d772ad..4cb603a3acef6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -49,6 +49,9 @@ struct panthor_hw_regs_layout {
 
 	/** @mcu_control: MCU_CONTROL register bank layout */
 	struct panthor_hw_regbank mcu_control;
+
+	/** @mmu_as_control: MMU_AS_CONTROL register bank layout */
+	struct panthor_hw_regbank mmu_as_control;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d1c29eec46f21..718160c0779ae 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -35,6 +35,7 @@
 #include "panthor_gpu.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_mmu_regs.h"
 #include "panthor_sched.h"
@@ -49,15 +50,15 @@ struct panthor_vm;
 struct panthor_as_slot {
 	/** @vm: VM bound to this slot. NULL is no VM is bound. */
 	struct panthor_vm *vm;
+
+	/** @iomem: CPU mapping for MMU_AS_CONTROL iomem region */
+	void __iomem *iomem;
 };
 
 /**
  * struct panthor_mmu - MMU related data
  */
 struct panthor_mmu {
-	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
-	void __iomem *iomem;
-
 	/** @irq: The MMU irq. */
 	struct panthor_irq irq;
 
@@ -533,6 +534,11 @@ static void free_pt(void *cookie, void *data, size_t size)
 	kmem_cache_free(pt_cache, data);
 }
 
+static void __iomem *as_iomem(struct panthor_mmu *mmu, u32 as_nr)
+{
+	return mmu->as.slots[as_nr].iomem;
+}
+
 static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
@@ -542,7 +548,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
+	ret = gpu_read_relaxed_poll_timeout_atomic(as_iomem(mmu, as_nr), AS_STATUS, val,
 						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
@@ -560,7 +566,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
+		gpu_write(as_iomem(ptdev->mmu, as_nr), AS_COMMAND, cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -603,9 +609,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 
 	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, transtab);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, memattr);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -627,9 +633,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 			return ret;
 	}
 
-	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
-	gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSTAB, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_MEMATTR, 0);
+	gpu_write64(as_iomem(mmu, as_nr), AS_TRANSCFG, AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	ret = as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 	if (ret)
@@ -1799,7 +1805,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
+		gpu_write64(as_iomem(ptdev->mmu, vm->as.id), AS_LOCKADDR,
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1861,8 +1867,8 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
-		addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(as_iomem(mmu, as), AS_FAULTSTATUS);
+		addr = gpu_read64(as_iomem(mmu, as), AS_FAULTADDRESS);
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -3429,8 +3435,11 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 int panthor_mmu_init(struct panthor_device *ptdev)
 {
 	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(ptdev->gpu_info.mmu_features);
+	unsigned long as_present_mask = ptdev->gpu_info.as_present;
+	struct panthor_hw_regbank *regbank = &ptdev->hw->regs.mmu_as_control;
 	struct panthor_mmu *mmu;
 	int ret, irq;
+	u32 as_id;
 
 	panthor_mmu_info_init(ptdev);
 
@@ -3449,7 +3458,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	mmu->iomem = ptdev->iomem + MMU_AS_BASE;
+	for_each_set_bit(as_id, &as_present_mask, MAX_AS_SLOTS) {
+		u64 offset = regbank->offset + (regbank->stride * as_id);
+
+		guard(mutex)(&mmu->as.slots_lock);
+		mmu->as.slots[as_id].iomem = ptdev->iomem + offset;
+	}
+
 	ptdev->mmu = mmu;
 
 	irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
@@ -3479,7 +3494,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	panthor_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
+	gpu_write(mmu->irq.iomem, INT_CLEAR, panthor_mmu_fault_mask(ptdev, ~0));
 	panthor_irq_resume(&mmu->irq);
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 1ec7f5ef2b196..82661283b46ab 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -11,13 +11,8 @@
 
 /* AS_COMMAND register commands */
 
-#define MMU_AS_BASE					0x2400
-
-#define MMU_AS_SHIFT					6
-#define MMU_AS(as)					((as) << MMU_AS_SHIFT)
-
-#define AS_TRANSTAB(as)					(MMU_AS(as) + 0x0)
-#define AS_MEMATTR(as)					(MMU_AS(as) + 0x8)
+#define AS_TRANSTAB					0x0
+#define AS_MEMATTR					0x8
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_IMPL		(2 << 2)
 #define   AS_MEMATTR_AARCH64_INNER_ALLOC_EXPL(w, r)	((3 << 2) | \
 							 ((w) ? BIT(0) : 0) | \
@@ -29,8 +24,8 @@
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_NC		(1 << 6)
 #define   AS_MEMATTR_AARCH64_INNER_OUTER_WB		(2 << 6)
 #define   AS_MEMATTR_AARCH64_FAULT			(3 << 6)
-#define AS_LOCKADDR(as)					(MMU_AS(as) + 0x10)
-#define AS_COMMAND(as)					(MMU_AS(as) + 0x18)
+#define AS_LOCKADDR					0x10
+#define AS_COMMAND					0x18
 #define   AS_COMMAND_NOP				0
 #define   AS_COMMAND_UPDATE				1
 #define   AS_COMMAND_LOCK				2
@@ -38,16 +33,16 @@
 #define   AS_COMMAND_FLUSH_PT				4
 #define   AS_COMMAND_FLUSH_MEM				5
 #define   AS_LOCK_REGION_MIN_SIZE			(1ULL << 15)
-#define AS_FAULTSTATUS(as)				(MMU_AS(as) + 0x1C)
+#define AS_FAULTSTATUS					0x1C
 #define  AS_FAULTSTATUS_ACCESS_TYPE_MASK		(0x3 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_ATOMIC		(0x0 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_EX			(0x1 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_READ		(0x2 << 8)
 #define  AS_FAULTSTATUS_ACCESS_TYPE_WRITE		(0x3 << 8)
-#define AS_FAULTADDRESS(as)				(MMU_AS(as) + 0x20)
-#define AS_STATUS(as)					(MMU_AS(as) + 0x28)
+#define AS_FAULTADDRESS					0x20
+#define AS_STATUS					0x28
 #define   AS_STATUS_AS_ACTIVE				BIT(0)
-#define AS_TRANSCFG(as)					(MMU_AS(as) + 0x30)
+#define AS_TRANSCFG					0x30
 #define   AS_TRANSCFG_ADRMODE_UNMAPPED			(1 << 0)
 #define   AS_TRANSCFG_ADRMODE_IDENTITY			(2 << 0)
 #define   AS_TRANSCFG_ADRMODE_AARCH64_4K		(6 << 0)
@@ -65,6 +60,6 @@
 #define   AS_TRANSCFG_DISABLE_AF_FAULT			BIT(34)
 #define   AS_TRANSCFG_WXN				BIT(35)
 #define   AS_TRANSCFG_XREADABLE				BIT(36)
-#define AS_FAULTEXTRA(as)				(MMU_AS(as) + 0x38)
+#define AS_FAULTEXTRA					0x38
 
 #endif /* __PANTHOR_MMU_REGS_H__ */
-- 
2.43.0

