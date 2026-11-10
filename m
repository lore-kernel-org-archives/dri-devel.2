Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352B606D74E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rgn5/Po0;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=rgn5/Po0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D4B10F7C9;
	Tue, 10 Nov 2026 15:42:23 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E43B10F7C4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:42:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S1RBYnGC3G+oq0tJUDex9wkxnLCGGOi791XUR+lZSWTiB15TmzFS+rTY0UTToAvDI3TD83DVTo73rZT6RnRE3k5YRr/XsI70ZwZynx64x8622SjgYTG7av6gLlSKNFo8WmMXqW+J1kQVBjNWdEvLWvlsDfd++zTEWdV/9GeGZKs+sirUbTt7Q9L5o9gbf+mBNt2smQ0OtWHdlpYOGnUoyfcZSElUgr08Kl/stx04vVTLNUTlzuEz/lItdNLuYAFfRj95/F7RZuXJY/YdqBOdVJWwiUAk8AAy5wY0qBNfrHIbCQ/Ja8ou4klTFZTmxrho3La4cC1O8xk+LAWhJHhpLg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAHhbkPkwNuRvbFjHGTx1jP6R3fjXy11R0f7zkJmAkE=;
 b=Ax0gCq0VpY++ZmGnO9u406aW1wbNuWFPU0MEtUkh4Dx0WOaTAsGTTx6ti0SEDybrnpy56KDT0EnnPjI54Tu78lkDyoCa2LVpXaCJXjaOZAGpzh9pKsVUnO3xNWzz/m9oWVcTy7TpCKuz+QYcpdxmTPFvWMshYpNO2C+CqVlXMdBpI8io2kZgRwEbf413fEpCJ/GhuGQYLR5OVsVmhONocpRE1ZOMq96I08uLdjIZ0+niIopSQz0aCwrkYt6iURlPSpLrdCLsqGRFmT6REZUNLy88QDznRuIfSJR30zbTKLMphCdnxEbEmo0mA2W6J3mxXhqfqmCngxLMdFYM4xJFZg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAHhbkPkwNuRvbFjHGTx1jP6R3fjXy11R0f7zkJmAkE=;
 b=rgn5/Po0rmApDNqwImTQk1Tdaj/9My3oYO/31W6DE1RhXfkULAT/b8pGYHNEyZbH16/4MQDLIGvoCNZnMfQiPv8mQFT0T/jg8uNDQJRyWy2e8g0ymWLCO+toyA7TbbZDm2P8vFpNoHo9/PNrAJWO8vzov6ZmfouPjR99tIF2Hrc=
Received: from PAYP264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::12)
 by MMZPR08MB225740.eurprd08.prod.outlook.com (2603:10a6:190:43::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 15:41:56 +0000
Received: from MI3PEPF00008493.eurprd03.prod.outlook.com
 (2603:10a6:102:11f:cafe::55) by PAYP264CA0025.outlook.office365.com
 (2603:10a6:102:11f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008493.mail.protection.outlook.com (10.167.240.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWVwbRywNTeEy/1fnPwRRh9I5+Lqk4wSc1OFUXZZGEoAw0Se0g6if9vpsVXcw6Jykm9p53K+t8zYmPLvMBuCUW9skZ0W2Gjyu5pOI3EteSDfKekQReclPQiEuyuT2fRmrNUKT/RMePRzUYfiEGolSGSnzbowcqjwxJy/GlcxR4yAmLxCxLUblUZSOPXicHHddLT6f8uy5k9NyfORHSMUcla4b3gHu3ITUU6MVZNJO0Py5tclu9y51vLyGowv4jdDC2A93rjHMVesJl5/Bzpd5k5Rd5otM3qUtOYdmvRZ4OSlGBBGd58hi+q5FThLJ29GVZ/ClUWBGYPESaHBfdqiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAHhbkPkwNuRvbFjHGTx1jP6R3fjXy11R0f7zkJmAkE=;
 b=H+gokAGkzL0vaYcf6tSatMQ6vko0wWFfGWMzDnLDzHb4+RMIOhERRwsEEQHmHV/0GNdGhYGNOqbDN+oJi6lGSbgd4rZm7kTtR/IanBDAZKB612902jLjELYXHHljv0vZpVbuvcfvPCoOqqzcQyhwzgIn7Y5SI/UQ9pmz2KHmyE8dk2rkL+YCtW3ZktKWLbpjbiloO9o4C1AZcttP4n/OuISPTXT0LF2LaF/9jQZ5dkEpPItUk3MeXUJrIrUWUny4mrogHWkrTL4iqNFvqePi08k8USJkmiVnWnY7X4UY3s++95jAWEY5P1wrH8NPGNbcK9KJ4Q7oM8gSJxYy9XWp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAHhbkPkwNuRvbFjHGTx1jP6R3fjXy11R0f7zkJmAkE=;
 b=rgn5/Po0rmApDNqwImTQk1Tdaj/9My3oYO/31W6DE1RhXfkULAT/b8pGYHNEyZbH16/4MQDLIGvoCNZnMfQiPv8mQFT0T/jg8uNDQJRyWy2e8g0ymWLCO+toyA7TbbZDm2P8vFpNoHo9/PNrAJWO8vzov6ZmfouPjR99tIF2Hrc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by VI0PR08MB11064.eurprd08.prod.outlook.com
 (2603:10a6:800:252::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:22 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:22 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 23/28] drm/panthor: Synchronize HW component PM transitions
Date: Tue, 10 Nov 2026 15:38:44 +0000
Message-ID: <20261110153907.3241978-24-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::12) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|VI0PR08MB11064:EE_|MI3PEPF00008493:EE_|MMZPR08MB225740:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f0cf23-b0d6-4b74-7972-08df3f412631
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 3epAdV4/T/jdwOx8x65KU/xwaBuCZSbbG5SwzNrPbThgv9GqMP8grHL6bVJ1QJO8+FipSWB9tRQLQlcHlFJpBu+ebzMlrMEMIR1mvWQzmWfK9dn6TVO7d4/XlCtaTfy8+kvdyoC0S4uwkCTa58ZNTF4wV3U0+//b4bDc0+epmCtfPzZaZ9HNqWRx59U6LZD4pmue3ImbWrphx0mA30cltpe+M0xY1ysdWGtNEoL3MTcbjV5jW4pxzqtUPdP6Aqf7+4rlDQUjlvJBPFlSx126sn7fJBdGYl4A++VQ0cv7wxCruqe0Y35/rW75KDrAh1JLOfrEzq6mXnr0clV1vTLJRzSTWN1eGBBQOak4etujVs4WZrRArKoNJte6Cg6odd01eHyHYjSuzcNaaMHPF/BoCO36Q775v9fB6CKpX+KMYNh9w5DLUXMKb6nU4EeOkbPCiw8YH0+GsXolLESkjceNI6gg2sQEwL3/rBOF3KYYPQ+muqLNX6Z5j1j82tZOSCkdYX/bT9tK7LLzbWpLZMJFlj0UYKIbjbuHSmbA6BuwLiPcNnDz7a9Ff7/vv1O7U7WCUMef9JqUZyU3Uw8m9Ypvj6zvL48GxuJxFu+Oz4KM7I3yuAoNJ6AjXbf48jNzOEIUXEzugaTEkS5NBJagyoW5ibWvyh7nJWfWF8bEgF3dDOw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: RXS3yj7EBqKtWSATFfGk20iPQsjsaCk1ZXpXbahWrw6jlczv+0A3EM5jZ2egg+yYppfddQIgm6xl0zWBpXxet6YVEXtZWAv46KbmluSGYFbQTQJS2nBGi2ULeqdFi/9bIr5GsmqAuqQNIze98UwGrr28UC3v8ZBrHstL2hf0/P9B9rsCWIupyeEkAjCB/KNixUv5nntKeCbmgMgJf/rTNv1XOdlo/te+l1MimUhJPK67qEZ82IBr24xqV27qzIgcmUAmFfPIXe5ghbTpnuCXbtlMlAK9ZCAAnOY3xPnUkuoLmZpG3cl5tDIBMLK6jSVDs5zGvNYc0sk1IcWm52NrJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11064
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ccbd7ba9-cd04-4cf2-7bb9-08df3f4112a4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|14060799003|35042699022|1800799024|36860700016|82310400026|261021123027099003|56012099006|261026140227099003|261022105027099003|261009223027099003|261026121527099003|261102123227099003|11063799006|261021121427099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: C7cRvO53UoNhXnS62BwGTn5vjoyaaL8+kDEU8XxisypzO61xyUx4QsEyoczPS+5Uk3J38xR6RWROaRZcn8F9HWeM4xrIKVO7T1nSLms5etLdVn6Tf/DpQnfdZUh6ZrRdc3r8yXYND3Qp3C4/6hCsGXjKceaJih4OR4oX0+BWpPo8VKzkVXT5jPLYKe4rxpXOyP+JsIvZHuaW3/A73VAr7xIVe0BDkBIQAsh+ajvVkkE0WeNeFxkMLPbAOn7ZrjvdxAUvW5b197WhwLqOhLYKi7FFW+5HvaE4uyPoKceGjNrOZ4RJX4G6UrmRQoU7/rE3I5N7QNVEWpMKqDVPheid8rgDRPcx3CnPZqTaYC3yds2DPHjzJptPF8IlYA1XXEI2tDabCRnV/oQBe136sTx+utPe+PjQmNgzKwAAnRxUVyoLBE2K+Lpw1ONXk5iLJq9Xc31xgWoQc/HzLOfwBrBx3Wk89wiwRcQvzDFi/xbPew3PfbSF2awvdPJRCke9o8zSHshDTUGk2SffsuKaRTykgZwZ/YbbfS/EcCqCb/armM9MPSBBmKi8kq3eNtKOtr5RSJTvrpnCTK5UWwQIgJueI+iGw47E8olZzv5M3yHLr6/Pmndix51YmAS3PhtC6+VPK3OM3mJ7kOlrQMkc0ewybew5nzLMo0x7BhHkfpCHjsRNRwkl5rR47XvMvEEei48E1f58WFmf7Qd7vcFPXF5+JA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(14060799003)(35042699022)(1800799024)(36860700016)(82310400026)(261021123027099003)(56012099006)(261026140227099003)(261022105027099003)(261009223027099003)(261026121527099003)(261102123227099003)(11063799006)(261021121427099003)(261028144727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9dV9uuZSD4+UJ8B7HXEj4NdqM6WH+b1NbmNaqsM1iEBaU8xjgIso/3pd8/q1bS9zOKsG2G+97xeCdCLqkLVhVFj/sJjFfSoO1yqKXkQaBdO8jfY4LNrrf3ejFcDg9RHqbwBpjcrpW6zWJzbfZ6g5N1UsxvbS9EsjTiUF7NtPOskwPXkHknN+eDNxhY+bvkEPMccXO2V4DX0XgYCj8qObRyStc1DIBapDdsGDyG1q/ZlIAFE9tlbXJqrmYnK+SBL4ah3tFyCFyW+kjiu9UPMtTZZDKHHs3/VGqawXjMzv74iqLBog7UHOflnkOW5gcyOzVJVKXSCr4PFbpoZ6k3bvXnrRbki7dL2YVFjISnHEhFIrDY+oqYu6LF425fOTQ5wcrz8gdHltwtekTxjnOFe+PDZI9wOLE5z2K60lI9/ynLcYblZ1j7a0PtmKqkFNaIOH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:55.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f0cf23-b0d6-4b74-7972-08df3f412631
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008493.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB225740
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

Split hardware component suspend/resume from the top-level device PM
path and protect those transitions with a dedicated mutex and state
flag.

This lets access-window arbitration suspend or resume GPU components
while runtime PM state remains controlled by the outer PM path.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 50 +++++++++++++++++++++---
 drivers/gpu/drm/panthor/panthor_device.h |  9 +++++
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 98c0dd3ce7bcb..2ccd8ad6318d1 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -179,6 +179,10 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
+	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.hw_component_lock);
+	if (ret)
+		return ret;
+
 	ret = drmm_mutex_init(&ptdev->base, &ptdev->pm.mmio_lock);
 	if (ret)
 		return ret;
@@ -293,6 +297,9 @@ int panthor_device_init(struct panthor_device *ptdev)
 	if (ret)
 		goto err_unplug_mmu;
 
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_ACTIVE);
+
 	ret = panthor_sched_init(ptdev);
 	if (ret)
 		goto err_unplug_fw;
@@ -484,21 +491,55 @@ int panthor_device_mmap_io(struct panthor_device *ptdev, struct vm_area_struct *
 	return 0;
 }
 
-static int panthor_device_resume_hw_components(struct panthor_device *ptdev)
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev)
+{
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_SUSPENDED)
+		return 0;
+
+	if (!pm_runtime_suspended(ptdev->base.dev)) {
+		panthor_fw_suspend(ptdev);
+		panthor_mmu_suspend(ptdev);
+		panthor_gpu_suspend(ptdev);
+		panthor_pwr_suspend(ptdev);
+	}
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
+	return 0;
+}
+
+int panthor_device_resume_hw_components(struct panthor_device *ptdev)
 {
 	int ret;
 
+	guard(mutex)(&ptdev->pm.hw_component_lock);
+
+	if (atomic_read(&ptdev->pm.hw_component_state) ==
+	    PANTHOR_DEVICE_PM_STATE_ACTIVE)
+		return 0;
+
 	panthor_pwr_resume(ptdev);
 	panthor_gpu_resume(ptdev);
 	panthor_mmu_resume(ptdev);
 
 	ret = panthor_fw_resume(ptdev);
-	if (!ret)
+	if (!ret) {
+		atomic_set(&ptdev->pm.hw_component_state,
+			   PANTHOR_DEVICE_PM_STATE_ACTIVE);
 		return 0;
+	}
 
 	panthor_mmu_suspend(ptdev);
 	panthor_gpu_suspend(ptdev);
 	panthor_pwr_suspend(ptdev);
+
+	atomic_set(&ptdev->pm.hw_component_state,
+		   PANTHOR_DEVICE_PM_STATE_SUSPENDED);
+
 	return ret;
 }
 
@@ -609,10 +650,7 @@ int panthor_device_suspend(struct device *dev)
 		 * The end of the reset will happen in the resume path though.
 		 */
 		panthor_sched_suspend(ptdev);
-		panthor_fw_suspend(ptdev);
-		panthor_mmu_suspend(ptdev);
-		panthor_gpu_suspend(ptdev);
-		panthor_pwr_suspend(ptdev);
+		panthor_device_suspend_hw_components(ptdev);
 		drm_dev_exit(cookie);
 	}
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index ede630ddce3e1..025efb91c1a38 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -353,6 +353,12 @@ struct panthor_device {
 
 		/** @recovery_needed: True when a resume attempt failed. */
 		atomic_t recovery_needed;
+
+		/** @hw_component_lock: Lock protects HW component PM state transitions */
+		struct mutex hw_component_lock;
+
+		/** @hw_component_state: HW component PM state */
+		atomic_t hw_component_state;
 	} pm;
 
 	/** @profile_mask: User-set profiling flags for job accounting. */
@@ -442,6 +448,9 @@ int panthor_device_mmap_io(struct panthor_device *ptdev,
 int panthor_device_resume(struct device *dev);
 int panthor_device_suspend(struct device *dev);
 
+int panthor_device_suspend_hw_components(struct panthor_device *ptdev);
+int panthor_device_resume_hw_components(struct panthor_device *ptdev);
+
 static inline int panthor_device_resume_and_get(struct panthor_device *ptdev)
 {
 	int ret = pm_runtime_resume_and_get(ptdev->base.dev);
-- 
2.43.0

