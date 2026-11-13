Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5D606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IxX0Ywve;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IxX0Ywve
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9121125E5;
	Fri, 13 Nov 2026 14:36:30 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC1D1125E5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:36:18 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cff/Xv+wJYn1HCvRr/zpRUE3C4FkmBJPeJd2+U5v3t+qZ400cfTBXMDPiBBygTMwRLvbWEVdHAUt5ug65HXvNPwP5TSKBgMmvwcAvRAVGkBs3oIbvrsBGH+7+xGHStga/ZcdB8cG8O99q3EtoGHT6Cjj9vPA5dv9eucQx+twqhbXIHPoOVKU3dWBrbbf3MmRJSiNwQEROcr8XkXmkleNs+038gShC2vgRQmM+Ye42J/HaqnFVGKovfgtp//n0cm6pZqP2N4WPRSt+VLq6ZBEOfmmebrHl0Wgb4c/3mNhCR049CRqNIfldNdW1hNNtfywlH0g2L/4Bpsx019BKCMwig==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxlLUFt7iFJyYyNJ5e3YJlpgSb/ljSVdpbnRyRp3DJ0=;
 b=sxhWo3/vaTOzADm7R9jttUKER6HPJDhjhHw9+MK1jdFJrs0dtnRGrQyIB5+OMXemtspxTBpfOt9uS/jMWRVlZ+1dAgtTljKPGLe3BQCrVGEMho0TgR/93rjJjhmXiMikIE82kygI14MhOCIpoe5NUK3rObBuyTkZxMnIxr5sbHhMujlQPi3jOfu5T91HLCvtke/4gujKne4O7ulMsdS/vZRxib8JPJRpbVQOhFWynKjk5PEooRb165rNvXX4KGCkZVtGhiyXwxCN9QY1GYAVnuki4bhklrKzlFIIFhYTlfM2erantlf+p47vOmPjszUPtVx5sN89F9v3T+NEU9SS4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxlLUFt7iFJyYyNJ5e3YJlpgSb/ljSVdpbnRyRp3DJ0=;
 b=IxX0YwveLuAVcccQs+THa7zGzI9m56NbvyN3XK8rVC2SB7MuGJsfqMrleZvbyN81aug3+sotFLzchsUmDEGNGyoGB90piLLLFQiVRF47VBIPhGTdeyKiVI6e6S24elXQnVI67iP+K9T/s5iuZpA+dLSUbkd72GP4TmJDckaV0f4=
Received: from DUZPR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::14) by AS8PR08MB6343.eurprd08.prod.outlook.com
 (2603:10a6:20b:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:36:12 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::51) by DUZPR01CA0139.outlook.office365.com
 (2603:10a6:10:4bd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:36:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 14:36:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv/5ASu1i8xsuYer2lIH2JKKXhevJMWr2H0IVs+GCejWvzyW8E1fVpHdNZvm1UlPPeBbI5hc8XZJ1TngSQDso25ElJtYfP588ivpGCd84ebOgaFSFVvfMU9A9LiQZE+A20SJUEvwMSBoK6MNqz8ilX1XfodMFVwKw/Tb21rHclS2K59LG+cYQvUgwMvv55G/mN7OM7oQf8LclqhJM1WT5h+5tSVymXZnFfqX3VccyqtgzqbzRFnKXUhcUjZSmUaP3ImQ//dimGoYaTWnheHkUdCihUqSOpthe417sCZYgyvy4JUHhz+jz4RfuZvMHk7pVSwJ+V7GOnNqiYGJkTcJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxlLUFt7iFJyYyNJ5e3YJlpgSb/ljSVdpbnRyRp3DJ0=;
 b=RBV9mm+OhpuJK2lUsom9PZuVDiEb+vHwHZhbXj/4MUE9wlw+yFz0wj7mDse4Kwh1tRyOaVpwq2bdeSImgJbFt3RQVnBIscB7xSBqx6aJ5TuDv5xwLJ0b99jXQJRl5YhxCVnCVxx2zpqQOHNKZpSYDlAFRwhT2bnG8fNYlCBaY2UCmaEnRc30wHrEIF4GB1qEXJ1wB4Lt6GAYoJTcM2XoURQ1OhQZ7+cwVp3yLsKOtj6HRputAv/ODq21A5V8guiMd5rYUaA1ET4fwQybxEB4eXw7DTSnNlfttY3ipP32nJe82FivwvmKQZ6/vz7SWqF4esI5LPYaXc5trgPLtfQUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxlLUFt7iFJyYyNJ5e3YJlpgSb/ljSVdpbnRyRp3DJ0=;
 b=IxX0YwveLuAVcccQs+THa7zGzI9m56NbvyN3XK8rVC2SB7MuGJsfqMrleZvbyN81aug3+sotFLzchsUmDEGNGyoGB90piLLLFQiVRF47VBIPhGTdeyKiVI6e6S24elXQnVI67iP+K9T/s5iuZpA+dLSUbkd72GP4TmJDckaV0f4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB8932.eurprd08.prod.outlook.com
 (2603:10a6:10:467::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 14:35:34 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 14:35:34 +0000
Message-ID: <ede42635-1164-4190-b0bb-954125686108@arm.com>
Date: Fri, 13 Nov 2026 14:35:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/28] dt-bindings: gpu: panthor: Document AM system
 bindings
Content-Language: en-GB
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-12-karunika.choo@arm.com>
 <20261111-grumpy-carp-of-superiority-eddeb9@quoll>
 <d74eb465-554b-43d6-bbfa-3fb671931462@arm.com>
 <3c6fd46a-8666-408d-8866-f2bb1f293c05@kernel.org>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <auIiOVi13v0U8fIp@e142607>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB8932:EE_|DB1PEPF000509EC:EE_|AS8PR08MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8b3c56-4c39-445a-0951-08df41937683
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|6133799003|261009223027099003|3023799007|5023799004|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261022113327099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: Audgiev5RjRyBrukDx7ClCLRw/kdwyX8PSxmseedEzziQP7x0ClXOtQR3ZvDoI0/zYYcXrQvf9D5cKuLHcQkKbSaaX7tsj/GjYptYfg4q6gx550W/U3ZCCPNxiJvhIqjQhJGNuBxJTfdLPvH4XIw3riiy1x8AsRL9EuZfrSPZ5I+CsId+HSIJHpY5pGDXK95wfSIitcZJ3pBGhKNhJeR4wr7VZZ4WEBo51w3Cwh392vkcj6lGvwLC9DR6g58WijlWyJBVEbQkEaWdF8ptV02xIWCu3H4CKZCPz9CeGCrLwR8gOStsLygZgfav8d7AUAvbqt/3eDYoBm1Jt+7NdIXeoNSYM+13LuxfSVZtchHTdvCrQPOTBhIUOLSog43vPDJdNW4SF8UH7uMahX7cK9zjyMsztzA1czaE18SiA6T/t3k8q9p7QUboYUB0+EIucVRKGbLR29Nyh0feuvbAaKpCCWJT5xAehjEhqMIIpgeJ003xrPIaBMMu5ttSBwRN1p4EH1CxduNZ7klInkZ8pyaXYywF7asae+I6Gd1m1L7BoZKh19RRFQg9DZLbQDKq05XddRFlS/y3ym4ta9SdnVTdiBVKebNd73YsFWkhvDLmic=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261022113327099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 1Ki0IlLPAqhW3ZBKCwp0LwKcp/Icq/8Op7o7vDUnQ8YFDjH5j36TqWfdEZaSzLDxy89tnX/icKmwFpvyC0oPpGQQKiTxGptTCV4riNJbY6GfppGHO1tm2dJGBmBzNmQaK68FuCExgo3FcQkrAJAX8hPfD52dXh1WS6PBq7IQ8t6WvXmO/6vFsmtvks0OJZyxiIo+T0S1IUw9/n1lMh3IsNxjb9NBPRcEztHj3KiEKZRnpMn3giK6C8RKGv02pmRD1XU9f0M0GbWadFlNCKfhuaDE6BhjrAJItqh7nwQqMOxtBLgFdTx8riNw8JIlCAoiILnHChoLs3ix3QbMv1YbqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8932
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa9225d7-d755-46af-1638-08df4193604f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|35042699022|36860700016|82310400026|1800799024|14060799003|376014|7416014|18002099003|22082099003|6133799003|261009223027099003|13003099007|3023799007|5023799004|56012099006|10067099003|4143699003|261102123227099003|261022105027099003|261022113327099003|261026121527099003|261022075727099003|261021121427099003|261026140227099003|261028144727099003|11063799006;
X-Microsoft-Antispam-Message-Info: zPrjW6H49yJBpJbuTihR3jwgk2CZgcGdJz39/jtzOdHr3hgJYve0YHASJ7cnWmHLWr9/3a+q0P2210rxqHRDVnnpSNlIEZwILZRVRGor3LHsDU9/nrEJGSh2VK6auHE2e9D//Fwo2/5mEJ5LjWaXHQmU9Y+qm4GHqaHVwZ/EM+fBzklk/G2sTUciUdTkMPo/tWwv1Kc/LvC5jwHOAygh0F8OD1QbXXfkZi7UmIrECLzIztQp7c4/aXCEWzX0nr3iARsTnSpJSA7BEYhhf1yFEKKAhYnma2iXl2ZjweTb8TyWeIc6/CS05JRqqAZKrjRWX0u/2iOePN5msBi4og68BevWULB7hqEfw1jwUOmO3L5Y2EswSz4NaoUEe7G1d3VCOVOPexv6IOghO+2WHw0lA7YmuFwqD6l8PqeG/rbOoxlL4C8eCXD7pIAd8lHj8UCyjMuV2Xg9dqBPWLHtr0ggDjCZ55XFEPaWbeNjzJLPCiDtyljx7ei6pqKOYMnq+2l5gLquyw6oWlUBNicbjZiHZmHuG5ABP9IFgWimB2I0boH/Vij8HM5S2gNAyjHYVH7IaC0JmnPRmTWwAXGOavgvDFhfkBW6XRUy2NBlVYYYimqtaXjKjdAdSRYM2G7HmW1WMPzdiTS2Nzm13XhtRq/tOw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(35042699022)(36860700016)(82310400026)(1800799024)(14060799003)(376014)(7416014)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(3023799007)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261022105027099003)(261022113327099003)(261026121527099003)(261022075727099003)(261021121427099003)(261026140227099003)(261028144727099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ndHQQRMCeiUPksqdRK2AtOuqCX9M2Taz21cZfQN8blpFWbCSTQtuFfpyTZFCFu/VpDJngsod4vRRqe4caqHrnm93Cmtt7wpIFdg6ornD8443wP2rzy0K2H0VTQ9wQ4tz4/1evCGMZpd8qYlgCNtrec5cveE8ocrNTzVLowkd7CDIHkFF6OLBMo/2piCtQEBC+G0XTJfME/f3rF6K3pKv4O1ptjdylzptvC56JrU4u3I8Oed9mJVVvOVwx7FLEXZA9ikE/9YZA+ufCQmYwtDIsAUsum66T+yn6xx/2umnOIclLQZ9gCaw0WydoRETw9PSDwkld2J6TcXfuZRjOTVST5xXmC97Rp0mCfm1f0z7jzmrbp1wZq1KF0uJUs+HiBDRKKlmrZi/yAMnICRZsitGCxSgDKnkPKbAo3Hn1nt3k7OKco0gAF7okjvkwx0tDrsE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:36:09.4542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8b3c56-4c39-445a-0951-08df41937683
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6343
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 12/11/2026 08:32, Krzysztof Kozlowski wrote:
> On 11/11/2026 11:43, Karunika Choo wrote:
>> On 11/11/2026 08:29, Krzysztof Kozlowski wrote:
>>> On Tue, Nov 10, 2026 at 03:38:32PM +0000, Karunika Choo wrote:
>>>> Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control and
>>>> the AM_ASSIGN block for HW resource assignment outside the GPU
>>>> job submission register window.
>>>>
>>>> Document the system node compatible, register and interrupt resources,
>>>> GPU clock, and assignment properties for HW resource assignment.
>>>>
>>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>>> ---
>>>> v2:
>>>> - Add an optional AM_ASSIGN register range. Require this range when the
>>>>   assignments node is present.
>>>> - Describe resource-group assignments for AXI buses, partitions, slices
>>>>   and access windows on partition-capable GPUs.
>>>> - Allow gpu-arbitration child nodes and the #address-cells, #size-cells
>>>>   and ranges properties.
>>>> - Remove the panthor-system node-name restriction.
>>>> - Remove gpu-supply from the schema and example.
>>>> - Add an example with assignments for partition-capable GPU with four
>>>>   resource groups.
>>>> - Move the MAINTAINERS update to the GPU schema patch.
>>>>
>>>>  .../bindings/gpu/arm,mali-gen5-am-system.yaml | 196 ++++++++++++++++++
>>>>  1 file changed, 196 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>> new file mode 100644
>>>> index 0000000000000..9e0477b8b723a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
>>>> @@ -0,0 +1,196 @@
>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>> +# Copyright 2026 ARM Limited. All rights reserved.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: ARM Mali 5th-Gen GPU System Device
>>>> +
>>>> +maintainers:
>>>> +  - Liviu Dudau <liviu.dudau@arm.com>
>>>> +  - Boris Brezillon <boris.brezillon@collabora.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - const: arm,mali-gen5-am-system
>>>> +
>>>> +  reg:
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>
>>> Why is this flexible? There is no description in the binding which would
>>> explain oddities in choices of hardware representation.
>>
>> I will restore the description that was previously asked to be dropped.
> 
> Hm, let me open the cover letter to find lore link to previous
> discussion and check... ah wait, no cover letter!
> 
>>
>>>> +
>>>> +  reg-names:
>>>> +    minItems: 1
>>>> +    items:
>>>> +      - const: system
>>>> +      - const: assign
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  dma-coherent: true
>>>> +
>>>> +  "#address-cells": true
>>>> +
>>>> +  "#size-cells": true
>>>
>>> Both need to be const or enum.
>>>
>>>> +
>>>> +  ranges: true
>>>> +
>>>> +  assignments:
>>>
>>> Do not mix nodes with and without bus addressing. That's mess.
>>
>> Hi, I was asked to use a more generic DT such that should the
> 
> By whom?
> 
>> hardware registers change in the future we can still retain
>> some compatibility. Is it necessarily a problem?
> 
> Bindings are not generic, but specific.

Apologies, this was discussed internally with a Panthor maintainer
previously. Would the following example DT be more acceptable?

--8<-------------------------------------------
panthor_system: gpu-system@68000000 {
	compatible = "example-vendor,example-soc-mali-system", "arm,mali-gen5-am-system";
	reg = <0x68000000 0x10000>,
	      <0x68010000 0x10000>;
	reg-names = "system", "assign";
	interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
	clocks = <&mali_gpu_clk>;
	dma-coherent;
	arm,am-resource-group-bus = <0x1100>;
	arm,am-partition-resource-group = <0x3210>;
	arm,am-slice-resource-group = <0x33221100>;
	arm,am-aw-resource-group = <0x33332222 0x11110000 0x0 0x0>;

	panthor_arbitration: gpu-arbitration@68040000 {
		...
	};
};
-->8-------------------------------------------


> ...
> 
>>>> +patternProperties:
>>>> +  '^gpu-arbitration@[a-f0-9]+$':
>>>> +    $ref: arm,mali-gen5-am-arbitration.yaml#
>>>
>>> There is no such file. You did not really test it.
>>
>> Sorry, this was included from a later patch that
>> introduces this file. I will move it there in v3.
>>
>>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - interrupts
>>>> +  - clocks
>>>> +
>>>> +additionalProperties: false
>>>
>>> This goes after allOf: block.
>>>
>>>> +
>>>> +allOf:
>>>> +  - if:
>>>> +      required:
>>>> +        - assignments
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 2
>>>> +        reg-names:
>>>> +          minItems: 2
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +    gpu-system@68000000 {
>>>> +      compatible = "arm,mali-gen5-am-system";
>>>> +      reg = <0x68000000 0x10000>;
>>>> +      reg-names = "system";
>>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>>> +      clocks = <&mali_gpu_clk>;
>>>> +    };
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +
>>>> +    gpu-system@68000000 {
>>>> +      compatible = "arm,mali-gen5-am-system";
>>>> +      reg = <0x68000000 0x10000>, <0x68010000 0x10000>;
>>>> +      reg-names = "system", "assign";
>>>> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
>>>> +      clocks = <&mali_gpu_clk>;
>>>> +
>>>> +      assignments {
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <0>;
>>>> +
>>>> +        resource-group@0 {
>>>> +          reg = <0>;
>>>> +          arm,axi-bus = <0>;
>>>> +          arm,partition-mask = <0x1>;
>>>> +          arm,slice-mask = <0x3>;
>>>> +          arm,access-window-mask = <0xf>;
>>>> +        };
>>>> +
>>>> +        resource-group@1 {
>>>> +          reg = <1>;
>>>> +          arm,axi-bus = <0>;
>>>> +          arm,partition-mask = <0x2>;
>>>> +          arm,slice-mask = <0xc>;
>>>> +          arm,access-window-mask = <0xf0>;
>>>> +        };
>>>> +
>>>> +        resource-group@2 {
>>>> +          reg = <2>;
>>>> +          arm,axi-bus = <1>;
>>>> +          arm,partition-mask = <0x4>;
>>>> +          arm,slice-mask = <0x30>;
>>>> +          arm,access-window-mask = <0xf00>;
>>>> +        };
>>>> +
>>>> +        resource-group@3 {
>>>> +          reg = <3>;
>>>> +          arm,axi-bus = <1>;
>>>> +          arm,partition-mask = <0x8>;
>>>> +          arm,slice-mask = <0xc0>;
>>>> +          arm,access-window-mask = <0xf000>;
>>>> +        };
>>>
>>> Your example is incomplete.
>>
>> Could you clarify what specifically is missing?
> 
> ll the properties you added in the binding.
> 
> Best regards,
> Krzysztof
Thanks. I'll add that in v3.

Kind regards,
Karunika
