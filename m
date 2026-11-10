Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC760A6F6C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LkfEYA1+;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LkfEYA1+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5E710F7AB;
	Tue, 10 Nov 2026 15:41:36 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0387810F7A3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=aiOc+omLIRDL2K1ehpaNNfismoMmZ3eFZ4EzoW9HuRC6HeaNG8LS3pUb0noJ+SOwk6i2iykrQXvzIKykKa4PbjM2wZwTkIeEBbfpEvu7rEJ1PBf9hnOoOXYxWNJ6u8a41b4mU96W/OqRrlMDxKwcmGf0ghHypzPrbxYLLayQoCZugNupDhhxYR6JDCkMI8lxIQgCn6d7z3Wh3CCXMboIj1p86JP4gJUFWuCwnwmJqNl4KxaERcduD40YyUYI+E62qaNmDFSn0B0JgaWpYhaOdAsi5KM3ZUPZxMLILPG5J3yag5bb7lIwFzt0mlujCaEzq2OBdfApXKfTKadcVPnctw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BleCIwvV5IJX57LAaUmGah+ltiG86jKokdddiP1ws4I=;
 b=NAqCefEgnkyH+qp1OywTRwBVoxmb9lQ5dvrV1+HMAwFQeLwN8k7yJJ3k8dsaYvj//VrjjFoARx+9h7/A1pNczE4RkIEXlU32pHlBYH5UYbNi5wnztL3v9uWt/B5IXih+YtfR3lZgV7SB3ltdxguUed54XgkwQiuAM9X9S8HdwRjLEReh8VI5Ab4C1kr9ITQjlVCl+pTXjQFbYJQUUixVbWt7N5K2c/ka8UFtiCmKDFEtkDiUbD2HJ66sM/dhVLQLenNaCx1/P+WgvJsD4y+nO3ngSad2KUQjq5ad2k2F9aYTH/SYt9fetknBDVWUPAf6yZcEjgTWxuGK9rAw/tFUnQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BleCIwvV5IJX57LAaUmGah+ltiG86jKokdddiP1ws4I=;
 b=LkfEYA1+2l1X2SsGYRe6m4KTPjly4x14j0ImwfKHrYCpYQox6rUq811J/xqwIGuE9SLUfoUeQsSRyLjFyOXL53jnqG4+HNz3iNaNO5Mi+RG3Ft7ryKgNac2pt30HF7/tbeAftEMVi50YC+R+RktSUCCEC8+s2JCwG0iMImuyq14=
Received: from PAZP264CA0136.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::6)
 by AS8PR08MB6053.eurprd08.prod.outlook.com (2603:10a6:20b:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:18 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:102:1f8:cafe::30) by PAZP264CA0136.outlook.office365.com
 (2603:10a6:102:1f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaT1O+oV4nt+2rjcOcuVOHuKf+62s2PWlRZ1SURtVtGPBXDr3UhS7Xj3LtW40Yq294V1Lt9Dj4Af+BjqjoV7Uq48Zw2SZns4BBLxmiyzhjl2EXp9RSv2ybsHaZJs1jte2EfPwcl0VFknuTuCedprBxzXl0zOlspiCceVGIaFcCVafpB+WHHYQpVIa0K5zhwk64s843UCC76ovJXZ1oBXKFdw6wxmPxbSXcKSKq03RqB6CVq8ZfP4UNNlLE7YY51KDABim/To7UOeiROOaYUOFTWh0QBshLTAfkuCc7VudKyQt3KHDO+ZPNeLmt17jsTp+8x0Q4UMXmOjFtTf/ZmT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BleCIwvV5IJX57LAaUmGah+ltiG86jKokdddiP1ws4I=;
 b=XiXdzAJ8t+Hn6tbgecIQqLNMYCarO91qj2SsCeHNlMa+/LziXmWHnVL9tfRAKPIRIWqUNgsPbGe/V2O0Qy0t5yEz1sZz4Y+V+CFyWI9VUx4pLQFnS17yK110qojHPBzyj5Yj/zTCKokT0nZ62c4fT6/ZmGzweY40MehbUz/kE0svHvHMVh3mnFblZ6GUw0FVOxmuvtt6VS9PKDWyQXGFX4pv1re5m/dxU7cPxhWd3l1z6wuW536aLjKgC6HUp32Pk+bvgZAFNZrx4LVN1kILwewRWBHoUdIC6wY35/IOiwjczl9w/eBDAD/rmLdwfLTjxokZ7v3siqICEjT0+I6F9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BleCIwvV5IJX57LAaUmGah+ltiG86jKokdddiP1ws4I=;
 b=LkfEYA1+2l1X2SsGYRe6m4KTPjly4x14j0ImwfKHrYCpYQox6rUq811J/xqwIGuE9SLUfoUeQsSRyLjFyOXL53jnqG4+HNz3iNaNO5Mi+RG3Ft7ryKgNac2pt30HF7/tbeAftEMVi50YC+R+RktSUCCEC8+s2JCwG0iMImuyq14=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:43 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:43 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 13/28] dt-bindings: gpu: panthor: Document
 panthor-arbitration bindings
Date: Tue, 10 Nov 2026 15:38:34 +0000
Message-ID: <20261110153907.3241978-14-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MI3PEPF00008496:EE_|AS8PR08MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6d12c0-e7c1-4845-890f-08df3f410ffe
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261022105027099003|5023799004|261102123227099003|261026121527099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: vgQTSlBXNAbSNAjVuEMWk1H530QuRttZAW5ba56hO4gjcraFyfUgaucaPnzM4Uyhqg4ioNQbq33lpsS9ISxq1Ia/W0L/6Za8USmafTfniP7K2+0kxnnl5GLDDN/JzmRp0rvN/fAoSEuLV5jXD88hKDXjggFB61ENNMRAnlBmLjyxiLeEgLAdPKlHI6Pw+L4i+WHKhaw2BXaxLxKt3XrGjVBn46zLH0feJ6g+RCbTDosC69tv7FvTJSXas9CcrmDfs2mUcM/dttOhOCua60S0dQ9YOu8ZaB0Rbq2hyc3KlACZSPXEct71WEvpVDHhLGzLh0e3ImwIBvXpNv2SBDmCg5QHZzjprZW8Zox6nRqXc27f8wbt7QIIpCjhHKx2mIZ5PLV+b6XnlSlcswNX11zE0QrMVHzP1/JXwptj5i19Gjh3OVYi2V4sAX18amX5+wHsdOdzAoN+nLMU0x10rCfva1pha/PWPyKtd5MGSLhLjaNAEih2YA3i9L7hGEbnjQDCv0itoNzR4WgWrTJfxhQtksuuwwNBp1ItiKxEEGa3uVw66deuaRpaNUWpYpiGqtZBdKmGUEH/3BYRuE4lts1thoAy+2u9PvR5eiyKSMMZ0IQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261022105027099003)(5023799004)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4oxCAgmFcGNY9D9JgE1kZSmXCOb4zJ70qQCer8DWB5GXtVyA/taXJoevu/yOn5IAcIbDdDl3+ONbFjyEf4A4CXYgteWWAQ1GQ086CSjr/k/NvT0ULOKihgGsUEIQDUJ6lBtAYxhq9SVH1NZGo2KeLIbXtxUn0S71FlyMxSKOojuYbDlIY/yPXvrMtjenYxw4tp9IaV/4NHcAac7/DELMk9TwEL3jm7DK55qZhS3kwPF0AT0b7FNlTAUXMvL+AFfwqcY2BI5BuTmmINCnAyVv5xOhTi47v2dhvg7Un4qs1lDE2YrsbNPFpi8Cw4NZvXMQ7evVFCaD2vdj/9CbbEBy0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bd4dcc88-039f-48a5-c25d-08df3f40fb19
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|35042699022|23010399003|14060799003|18002099003|22082099003|6133799003|10067099003|3023799007|13003099007|11063799006|5023799004|261026140227099003|261102123227099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261022113327099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: M/AexcG+R2MIgz5eNNINN9vgX2G9ocm1mBYYV1GzI1r3IpfZ+OXY/vrZ7kpF3SFuQ2NHAKJl7dLRKizZEpGlXrbcA2ZB3Fvjtrc6EBi7PXLccskYbNTTJdFMlVACCe0FdWiTzAOf08gM+yd8K9Oaf6EEr29yk/uPa1RNXx+RoixIE+juM+4OtuF1tjYh60HDSIDmQxlqw3sqVdpgjRibJCNxhK8dcWOxEDZEJUNEBPTQFFDTKkY72SpdBhfapkGs+lVh8xiIg0LuHXqhCarOyhoiRf5Nx1zDCrhKeDgXJC0K2FJvz/aczipAmEtglRfbH3UNoQF46Ke3k2vJrHJPY7Ns6bUIsUPOlG/LBUlECII2Z8CCKqkWfNsmlUZllSGS6ygg/NEMV87AsIh4Tb2MMgaYe4ykY8++KHK/86FYY+FkpWYCIDNYsoPAWfRIDf092e2gVdqQ1AGlqeNe2Q8/9mHmjm5++W2emzOGZGVsnay4RpyBbqorPv1z5Kp+bTf8S1XYsCal18yvevt1zWHfOfnioZHWmIpul4QotoVDSwR86fSzubXVqRPo0FWELp97jIhjLz08VxuaTm8ktSvmnpHatt694GZd48xBE3Mt9j/lB45dDSZNbUOPkJO5QUT2EInyJXVCp0x6aRx6Wx4K1A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(35042699022)(23010399003)(14060799003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(13003099007)(11063799006)(5023799004)(261026140227099003)(261102123227099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xup/krShyarn2hBEBuK/zGNHuu7CU7RpicU0OtBc69VXBSXOQoKcBDMFViEgXmAP7/+W60xw2MDyxyw2mGZ/sNRrvs32GgBQ9MCluf6F78MeyaiNO90SxaGvUosQ0UsoJuErTWa2CPeNz3WjOcqkfl6Xd0llaLk5TJxdSSvUHscnyKNQtoQ2lZbfV4Dd+gVCIQW9uJMG9rB/3WRn88VJbjIljsjLsoCF7f2RaUWneD/wqZ9gi4rwYmEOOOtgOymCdussSo23Pr1zv4q4UyuFPoM30YT/ltk+TjyX1UvlRLru6YgxUIwon+naE1eCWIB7+yDMVH2iQxohxb+Ku2ITA6dq3ZFf7Mq8ezMuvVZIp+PcSk63VXHXCxxExJzi1/AAi23iaJ72Jv0yClKJBQSW3SzqG3/pMvScVFMpUDIcJRgp/KvCkVJdPm4Js8SBv4qD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:18.1708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6d12c0-e7c1-4845-890f-08df3f410ffe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6053
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

Mali 5th-Gen AM GPUs expose partition-control and resource-group
registers outside the GPU node.

Document named register and interrupt resources in the arbitration node.
The pcN and rgN names identify the hardware blocks.

Document initial access-window and slice assignments in partition child
nodes. The reg property identifies the partition-control index.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Return to using named register and interrupt arrays instead of
  individual entries in child nodes.
- Added register and interrupt entries for partition-capable GPUs
  (rg[0-3], pc[0-3]).
- Introduce partition nodes to define default access-window and slice
  masks.
- Point child Panthor device node to new arm,mali-gen5-am.yaml
- Added partition-capable GPU example entry.

v2:
- Introduce assignment_lock to protect assignments allowing serialized
  lookup without the need for READ_ONCE or WRITE_ONCE.
- Add pending_aw_request_mask to track and replay pending requests
  arriving before AW assignments are initialized.

 .../gpu/arm,mali-gen5-am-arbitration.yaml     | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
new file mode 100644
index 0000000000000..633dd823bd3d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright 2026 ARM Limited. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-arbitration.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Mali 5th-Gen GPU Arbitration Device
+
+maintainers:
+  - Liviu Dudau <liviu.dudau@arm.com>
+  - Boris Brezillon <boris.brezillon@collabora.com>
+
+description:
+  The arbitration device manages GPU partition-control and resource-group
+  blocks. Register and interrupt names pcN and rgN identify their hardware
+  indices. Partition child nodes describe initial resource assignments,
+  with reg identifying the partition-control index. Access-window and slice
+  indices are global to the GPU, each resource may be assigned to at most one
+  partition.
+
+properties:
+  compatible:
+    const: arm,mali-gen5-am-arbitration
+
+  reg:
+    minItems: 2
+    maxItems: 8
+
+  reg-names:
+    minItems: 2
+    maxItems: 8
+    items:
+      enum: [pc0, pc1, pc2, pc3, rg0, rg1, rg2, rg3]
+
+  interrupts:
+    minItems: 2
+    maxItems: 8
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 8
+    items:
+      enum: [pc0, pc1, pc2, pc3, rg0, rg1, rg2, rg3]
+
+  "#address-cells": true
+  "#size-cells": true
+  ranges: true
+
+  partitions:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+    patternProperties:
+      "^partition@[0-3]$":
+        type: object
+        additionalProperties: false
+        description:
+          Initial partition resource assignments.
+
+        properties:
+          reg:
+            items:
+              - maximum: 3
+            description: Partition control number.
+
+          arm,access-window-mask:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 0xffff
+            default: 0
+            description:
+              Initial access window assignment mask. Bit N selects global
+              access window ID N. Masks must be disjoint across partitions.
+              If omitted on partitioning-capable GPUs, no access windows are
+              assigned by default. Non-partitioning GPUs will have all AWs
+              assigned to pc0 if value is 0 or not defined.
+
+          arm,slice-mask:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 0xff
+            default: 0
+            description:
+              Initial slice assignment mask. Bit N selects global slice ID N.
+              Masks must be disjoint across partitions. If omitted, no
+              partitions are created by default. This property is only valid for
+              partition-capable GPUs.
+
+        required:
+          - reg
+
+patternProperties:
+  "^gpu@[0-9a-f]+$":
+    $ref: arm,mali-gen5-am.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu-arbitration@50000 {
+      compatible = "arm,mali-gen5-am-arbitration";
+      reg = <0x50000 0x10000>,
+            <0xC0000 0x10000>;
+      reg-names = "pc0", "rg0";
+      interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+                    <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>;
+      interrupt-names = "pc0", "rg0";
+
+      partitions {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        partition@0 {
+            reg = <0x0>;
+            arm,access-window-mask = <0xffff>;
+        };
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu-arbitration@40000 {
+      compatible = "arm,mali-gen5-am-arbitration";
+      reg = <0x40000 0x10000>,
+            <0x50000 0x10000>,
+            <0xC0000 0x10000>;
+      reg-names = "pc0", "pc1", "rg0";
+      interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH 0>,
+                    <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH 0>,
+                    <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH 0>;
+      interrupt-names = "pc0", "pc1", "rg0";
+
+      partitions {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        partition@0 {
+            reg = <0x0>;
+            arm,access-window-mask = <0xf>;
+            arm,slice-mask = <0x3>;
+        };
+        partition@1 {
+            reg = <0x1>;
+            arm,access-window-mask = <0xf0>;
+            arm,slice-mask = <0xc>;
+        };
+      };
+    };
+
+    gpu-arbitration@60000 {
+      compatible = "arm,mali-gen5-am-arbitration";
+      reg = <0x60000 0x10000>,
+            <0x70000 0x10000>,
+            <0xD0000 0x10000>;
+      reg-names = "pc2", "pc3", "rg1";
+      interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH 0>,
+                    <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH 0>,
+                    <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
+      interrupt-names = "pc2", "pc3", "rg1";
+
+      partitions {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        partition@2 {
+            reg = <0x2>;
+            arm,access-window-mask = <0xf00>;
+            arm,slice-mask = <0x30>;
+        };
+        partition@3 {
+            reg = <0x3>;
+            arm,access-window-mask = <0xf000>;
+            arm,slice-mask = <0xc0>;
+        };
+      };
+    };
+
+...
-- 
2.43.0

