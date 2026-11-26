Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=OKC5/cbd;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=OKC5/cbd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDCD10E9F6;
	Thu, 26 Nov 2026 20:58:45 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F0810E9F6
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=J2HsvhFf5OsuiWo3lPfesz7FIAoyqe/9zMWkOvlvPVCsoc7CAA4zJJu4ZsLJ7gx8+Vbu0vAxp6i7M+9/1hsD2FiejUTzaLgsvctnc7lR2WoOEf3JlbdrqJgpzKASFqX05v45aoiQmOj9t9hT2AyPnVham51pZ1XtbBheEIE+KOU1yVjLGa36RbqDkqGR3vpFUu7ZfwlSz7rLfxiaI3t9lQYqwd4paM/tjuqyVD4GFCOFNqmwM6JuxRSpc8ru2ce9j209odbvmRyragq8pOlUJv4OdV0f1sF/5bU/2rm+AXtlc7oiOoeRc3BZxxt7l1bqwoRGEEnTOfq4wgQw6hX3TQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKK3Ac61chi8RA+w51sGSQ8Cs+71mK3S8+ySH09bkog=;
 b=nHWlpqGDOLhjhK0WxuCl6HH6KMQcT+wk9QiWR2rv5ZRHobitOOmnICZ/7Rrzf7iHXZ9EIP6mrmBTcYEKvAGvhhuB86FwbiqRedoFgsm7CYRCtDLy8L4Z0t5GL9BRPCzXYVMkn66VICbRrwVKaFiCDClIXR+Xpq/bYzqch84gp0l3Lvz/DIwbrSGviYhlRSzFCDN/gx+McXOEwunYs1AkDVT2C2AkiXkru9Y47+CsNqtq8UQj35ZZ5N7Q+v4s+sRg9zGzjwYQzQsQYV6m8mnR+kLfBt2wvtEk6v+cli0ObyGW1xGuzLIaApxVPxv89Hjy4bMhQ0G5h9E9QVSLz2MI+Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKK3Ac61chi8RA+w51sGSQ8Cs+71mK3S8+ySH09bkog=;
 b=OKC5/cbdu4AZ/o2ZNem2pocYfjH8FJe7jdnasriNXItIypTRFI2LKfPhTBscWUr0WpnEveJN75Oe5UYZT0I19J80wNz7oM239o4RRNpjsbvKOqw8WsrEd9Qo5I4qVkU/DUAp6iP9IUyoVfFWlQyqf57tjA55Jnl+05bJM+fpCa4=
Received: from PR3P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::25)
 by DB9PR08MB8338.eurprd08.prod.outlook.com (2603:10a6:10:3dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 20:58:21 +0000
Received: from ZR1PEPF0000E45E.eurprd04.prod.outlook.com
 (2603:10a6:102:52:cafe::a8) by PR3P189CA0020.outlook.office365.com
 (2603:10a6:102:52::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 20:58:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E45E.mail.protection.outlook.com (10.167.241.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 20:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHimPtkuFb14e50fQYlMdylNTBR+ABffvBWa1DORhWcV1R3ZQDTFMeceImUguVRbRcNmAxqKrX0shLJBVquRT0+o62NkA4ooje6F4+xwG5JA8KoYvAftfgFI+w3ITEWa5TK02PMZ/BKp/ByFi779jaIHHrtbDSHDY9kkJqXLMxUMPFYCSarXVzpNHT7OH1+MdD2uDQItkhR/F+UwcAXZGwpbPQI9ftq2TMrodqLtlWA7Eh64tDl64sykYewJ8+jMZQsw8t7jMwulnKYsDph3+jfzTq5Rv7P/1GIJFIq3XaU55rad4jflLLVTnK6A4wvD6YirRKRcI5uzL3neD6fT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKK3Ac61chi8RA+w51sGSQ8Cs+71mK3S8+ySH09bkog=;
 b=cfjBpSp7sE6It0ciFu9EiUqQMCkiC7XHdja0+GNiGAYwtKlc4svTcLezNpr/LHWCg0bVnSCPcYPGPDXlXXbB7WrynWqbvrV06GrUFE3rSaRv4BWjHk6ABP639SlB3LJp/nCYIitwUuRG66lLBrMpHizSdR2YJYuTt94RIVQvRCr+Ot7QZa6CZ+7GcmxsPzpu/1AirwesP/p6sUthDuzyPYZDZE/Ob1TllOBFcNBH01eGo11H1+XK7QXSr0asFJrWEQLwn2lGx0+0nJN3C52WeYrXcROFh/TUS+b+9GlKpsDagf/NYEjijn/rtjc3ImduMEjRVbEaCqBGDeKXk0rGiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKK3Ac61chi8RA+w51sGSQ8Cs+71mK3S8+ySH09bkog=;
 b=OKC5/cbdu4AZ/o2ZNem2pocYfjH8FJe7jdnasriNXItIypTRFI2LKfPhTBscWUr0WpnEveJN75Oe5UYZT0I19J80wNz7oM239o4RRNpjsbvKOqw8WsrEd9Qo5I4qVkU/DUAp6iP9IUyoVfFWlQyqf57tjA55Jnl+05bJM+fpCa4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AM0PR08MB5346.eurprd08.prod.outlook.com (2603:10a6:208:18b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 20:57:46 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 20:57:46 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Thu, 26 Nov 2026 20:57:39 +0000
Subject: [PATCH v8 3/3] drm/panthor: Expose performance counter queries and
 ioctls
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-panthor-performance-counters-v8-3-6e7db0ec33f5@arm.com>
References: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
In-Reply-To: <20261126-panthor-performance-counters-v8-0-6e7db0ec33f5@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Akash Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Chris Diamand <chris.diamand@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, rust-for-linux@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PA7P264CA0172.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::8) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AM0PR08MB5346:EE_|ZR1PEPF0000E45E:EE_|DB9PR08MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: e17898eb-f076-4358-df78-08df4c0000c5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|921020|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info-Original: zNPiiEah+T/WEb981JF/Jx5aWnliZ5wVw3x2LI6zFLqBPUTwoRJFTtaJGmuFAlMDU+Ay66y9VQYQuyM2mEnyCSj3a85hGKWI7pdn3mUME8xr/+85hsEej8MVMNlAt9DG/YbjM6KAPvTFSuUtn5TVDg1D86TtYr2x7cR5yWnUul68iJIWsSJpXBa5hY2dJ/2tJa1Mkt9jvmFFDCuf2BZBGPK1E3aLqjsxbeReJKSkuNuEugO+g3wW6Qt6cyEMa+kF2JMM5hfphnhPQjLZkN5wHYsILRKx3LBgV8Fu0q7RaHSBU9ZEBU7Y4AM6mzuJlCJ1BQJs/DRIQAtb0dSnX0SmVGyBdxNVVbNL8jJb25ncbcJH/3pzW2cBfwCKnPQsB/v2qaYrvbFHPLZ1qMOQ3wlFhoQwoWj3cizkWqKSfjp259CU+qfm13EfwU46lmROS8yna7RMr8nTyk9cr7ve57SmrFRhMQuiXFVOzw8J+9brlcGNHHZtkSU6oukVq+nohNpYAKDCY0DX+F20B3Q2CmRYMgjArbHYJU3qtdOekfrRo0lUMtHi5jM2OHDJx6chPWQbIH/8IxpWd0rpqzUEw9H9IZHzXyi8hrY8mvCY6yhyif8OvOGhHoVLaGOtLfb24lNOYeaz993+Rorr6oqfs8AVqvJ+bcYyAHkLhSIJmObTDLtOH/Rx1IxFjw40oVjG5sDMFbAeDwprqqLh3MsI6aKhoQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ds9tgTyBaew4UYo5TTLvtAsGvE/2ylCNK0i/Qriw348dyPtPKQ8lvY22T+KH5/5XlLItmuwQ0IbttEPxB8WPLoM47an8ScTHXu1tsr4gMh5N5r9jTOOMKl9ir74i2qjCkUOa0+WMBEPlxwkDbt92EMbkKagAUN3s1AZlVx7tNP3ShG1u5AE8RvdCgYSV9MQLEt4aG+jMD7UCbIIhSXot5JiuMxBuixhV/wj59vVsw7jNBsoWYU99c++fwy5UHjMk0EJedpCoCXVh5FYDhLibTwOqBuLof3YhPM/wmHbWShqdLJU2D6dItk2kIIb4nzvMGEbjgV3hpn6oThFB0Ywz5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5346
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c7304321-441d-48f1-de30-08df4bffec50
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700016|23010399003|14060799003|1800799024|82310400026|376014|7416014|921020|10067099003|56012099006|261102123227099003|11063799006|261026140227099003|261026121527099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZkS1tNDQbhuTnWahy/IOpXSApg3mT5+SVCTLDlc5KWptMIwa0ipYD7x1ZhZUn5mHPu2xD/NG6aZ6w0IxvB2kjrQONR5kbqm3aIYbTeuX4uDWyTixlWu/3GaH4tNgGHm89qIBETEk+koAnMyrKA+aEqAx/HXIPRNP+wNlR0hMlOCzEspmIybA867nPzsB8t6MiRiJLjGWkewQOOVhTxgAW+/28GQuMJakbbEBWMYVuXRr93K8mR1PkXci1k3d9PMKfJIvVJ3QpcSm/liDpFNIzqCbY9Ui7lWJmFho8egMgOdi6V2isUaO9R6801758P1jb35o584+T1ITI8GJOZ70kL9yGPIeEcMugbi+o4ibxynuZquwUajr22jkJ5qWWvCSjT6sLWYP21vwtLTUDiAixVQT6d98Twjj33fqF9MlPuduAhLshP62YqvUoBrypMu6JPibowLq+zW2JK5+h++pX7L29MFsXryofz5ZjtKLHwnUhMIRKLD9CJ3hQR4f+bQGqBA5JrfzDYEapu0S3I1hQFK4En9bMnsnaVaFizmOmDV6Eqy3bVRbCMh7V3F0JysyA9P95IXpUx9CIo8VIRmP6TXf/440CPpYuh4hGJKSK7NR9LFqoXJg2aO2a7/zYQk1enAa4o8sDk1jp+zxW5eWN8Y674HRxqUTp345nDkSzlQb4WXRevwVQhBqIaaE3IFCjQ5dDI0KBn/P13Rzuwk+HqqZEpma2rTGpE+mu/BrWF9ftnhfq8zFu/zGYBvNce3g
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700016)(23010399003)(14060799003)(1800799024)(82310400026)(376014)(7416014)(921020)(10067099003)(56012099006)(261102123227099003)(11063799006)(261026140227099003)(261026121527099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4WuCP/IcRwGofFCMFNDERQBZpoAs0Gusbfq3v19cbhIAKgYQnXhSeMgvBLCXJ/eLA5Wwsf5Fb9GG+xUYMLrdV3leW1IUZ8/lE738vRrTHwyXeX5/dAZOCmngqO7+GiJBx0Tb2PSthamVF8gQlMkS81Fw4fJ12K34QCglkHXryCx6E2mMiKJb9ry0XUekoxnlcHLY2ROU2FEZznFPVqbwHjNbn/XwQNUOD38rbz92EaMJYwcJIBItih/A1gkK98FS5oiDjF+2192SGR6R+RRBapBlAyqd63I14iHAOBX8YyE4LDHKknA1GrsgIgie4zw4y6ke1iwh3YgMQQM4t7laeLIiyHLaloSmYdCMYFUXDSXxwvIlknMloxR2DxZ42q9Fkk7VBrYnAzaNrs54LG7oeMaxkncYZ4/dW1xfU093nil9R8H007UoeewyQ80dAON/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 20:58:20.4813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e17898eb-f076-4358-df78-08df4c0000c5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8338
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

Expose DEV_QUERY.PERF_INFO and the five performance counter session
ioctls with documentation. Introduce a small scope-based wrapper around
drm_dev_enter() and drm_dev_exit() to ensure proper cleanup.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 128 ++++++++++++++++-
 include/uapi/drm/panthor_drm.h        | 254 +++++++++++++++++++++++++++++++---
 2 files changed, 361 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 09cc3f699154..e6e708d9e18f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -7,6 +7,7 @@
 #include <asm/arch_timer.h>
 #endif
 
+#include <linux/cleanup.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -182,7 +183,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
 		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
-		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
+		 PANTHOR_UOBJ_DECL(struct drm_panthor_perf_info, shader_blocks))
 
 /**
  * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
@@ -959,6 +961,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 			args->size = sizeof(ptdev->mmu_info);
 			return 0;
 
+		case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+			args->size = sizeof(ptdev->perf_info);
+			return 0;
+
 		default:
 			return -EINVAL;
 		}
@@ -992,6 +998,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
 	case DRM_PANTHOR_DEV_QUERY_MMU_INFO:
 		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->mmu_info);
 
+	case DRM_PANTHOR_DEV_QUERY_PERF_INFO:
+		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->perf_info);
+
 	default:
 		return -EINVAL;
 	}
@@ -1590,6 +1599,110 @@ static int panthor_ioctl_bo_query_info(struct drm_device *ddev, void *data,
 	return 0;
 }
 
+static int panthor_drm_dev_enter(struct drm_device *ddev)
+{
+	int cookie;
+
+	if (!drm_dev_enter(ddev, &cookie))
+		return -ENODEV;
+
+	return cookie;
+}
+
+static void panthor_drm_dev_exit(int cookie)
+{
+	if (cookie >= 0)
+		drm_dev_exit(cookie);
+}
+
+DEFINE_CLASS(panthor_drm_dev, int, panthor_drm_dev_exit(_T),
+	     panthor_drm_dev_enter(ddev), struct drm_device *ddev)
+
+static int panthor_ioctl_perf_session_create(struct drm_device *ddev, void *data,
+					     struct drm_file *file)
+{
+	int ret;
+	unsigned long sid = 0;
+	struct drm_panthor_perf_session_create *args = data;
+
+	CLASS(panthor_drm_dev, cookie)(ddev);
+	if (cookie < 0)
+		return cookie;
+
+	if (args->pad)
+		return -EINVAL;
+
+	ret = panthor_perf_session_create(file, args, &sid);
+	if (ret)
+		return ret;
+
+	return sid;
+}
+
+static int panthor_ioctl_perf_session_start(struct drm_device *ddev, void *data,
+					    struct drm_file *file)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_start *args = data;
+
+	CLASS(panthor_drm_dev, cookie)(ddev);
+	if (cookie < 0)
+		return cookie;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	return panthor_perf_session_start(pfile, args->handle, args->user_data);
+}
+
+static int panthor_ioctl_perf_session_sample(struct drm_device *ddev, void *data,
+					     struct drm_file *file)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_sample *args = data;
+
+	CLASS(panthor_drm_dev, cookie)(ddev);
+	if (cookie < 0)
+		return cookie;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	return panthor_perf_session_sample(pfile, args->handle, args->user_data);
+}
+
+static int panthor_ioctl_perf_session_stop(struct drm_device *ddev, void *data,
+					   struct drm_file *file)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_stop *args = data;
+
+	CLASS(panthor_drm_dev, cookie)(ddev);
+	if (cookie < 0)
+		return cookie;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	return panthor_perf_session_stop(pfile, args->handle, args->user_data);
+}
+
+static int panthor_ioctl_perf_session_destroy(struct drm_device *ddev, void *data,
+					      struct drm_file *file)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct drm_panthor_perf_session_destroy *args = data;
+
+	CLASS(panthor_drm_dev, cookie)(ddev);
+	if (cookie < 0)
+		return cookie;
+
+	if (args->pad0)
+		return -EINVAL;
+
+	return panthor_perf_session_destroy(pfile, args->handle);
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1674,6 +1787,11 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(SET_USER_MMIO_OFFSET, set_user_mmio_offset, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_SYNC, bo_sync, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(BO_QUERY_INFO, bo_query_info, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_CREATE, perf_session_create, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_START, perf_session_start, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_SAMPLE, perf_session_sample, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_STOP, perf_session_stop, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(PERF_SESSION_DESTROY, perf_session_destroy, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -1794,6 +1912,12 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - add DRM_PANTHOR_DEV_QUERY_PERF_INFO query
+ *        - adds PERF_SESSION_CREATE ioctl
+ *        - adds PERF_SESSION_START ioctl
+ *        - adds PERF_SESSION_SAMPLE ioctl
+ *        - adds PERF_SESSION_STOP ioctl
+ *        - adds PERF_SESSION_DESTROY ioctl
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1807,7 +1931,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index dfa852aa3690..2a6018ff17df 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -154,6 +154,23 @@ enum drm_panthor_ioctl_id {
 	 * This is useful for imported BOs.
 	 */
 	DRM_PANTHOR_BO_QUERY_INFO,
+
+	/** @DRM_PANTHOR_PERF_SESSION_CREATE: Create a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_CREATE,
+
+	/** @DRM_PANTHOR_PERF_SESSION_START: Start a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_START,
+
+	/** @DRM_PANTHOR_PERF_SESSION_SAMPLE: Request a manual sample on a performance counter
+	 * session.
+	 */
+	DRM_PANTHOR_PERF_SESSION_SAMPLE,
+
+	/** @DRM_PANTHOR_PERF_SESSION_STOP: Stop a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_STOP,
+
+	/** @DRM_PANTHOR_PERF_SESSION_DESTROY: Destroy a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_DESTROY,
 };
 
 /**
@@ -256,6 +273,9 @@ enum drm_panthor_dev_query_type {
 
 	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
 	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_PERF_INFO: Query performance counter interface information. */
+	DRM_PANTHOR_DEV_QUERY_PERF_INFO,
 };
 
 /**
@@ -1357,6 +1377,67 @@ struct drm_panthor_bo_query_info {
 	__u32 pad;
 };
 
+/**
+ * DOC: Performance counters
+ *
+ * The PERF_SESSION ioctls enable sampling from device-wide counters.
+ *
+ * Using the interface
+ * -------------------
+ *
+ * 1. Call DRM_IOCTL_PANTHOR_DEV_QUERY with DRM_PANTHOR_DEV_QUERY_PERF_INFO
+ *    to obtain &struct drm_panthor_perf_info, including sample and header sizes.
+ * 2. Use DRM_IOCTL_PANTHOR_BO_CREATE with DRM_PANTHOR_BO_WB_MMAP to create two
+ *    BOs: a ring buffer of at least ``sample_slots * sample_size`` bytes and a
+ *    control buffer for &struct drm_panthor_perf_ringbuf_control. Both start at
+ *    BO offset zero. Obtain their offsets with DRM_IOCTL_PANTHOR_BO_MMAP_OFFSET
+ *    and mmap() them with MAP_SHARED.
+ * 3. Pass an eventfd, the BO handles, counter set, enable masks and
+ *    slot count to DRM_IOCTL_PANTHOR_PERF_SESSION_CREATE. The ioctl returns a
+ *    nonnegative session handle. The session starts stopped, with
+ *    both control indices initialized to zero.
+ * 4. Call DRM_IOCTL_PANTHOR_PERF_SESSION_START. It waits for and discards a
+ *    clearing sample to exclude counter data from before the start command. Then
+ *    use DRM_IOCTL_PANTHOR_PERF_SESSION_SAMPLE to request samples asynchronously.
+ *    Only one SAMPLE request may be pending. Wait on and read the eventfd, or
+ *    poll insert_idx, then consume samples as below.
+ * 5. Once done sampling, call DRM_IOCTL_PANTHOR_PERF_SESSION_STOP. It waits for
+ *    a final sample to be published. Once the final sample is published, and the
+ *    session is stopped, either call DRM_IOCTL_PANTHOR_PERF_SESSION_DESTROY
+ *    before releasing the BOs and eventfd, or restart sampling with
+ *    DRM_IOCTL_PANTHOR_PERF_SESSION_START.
+ *
+ * Reading samples
+ * ---------------
+ *
+ * The indices count samples modulo 2^64. ``insert_idx - extract_idx`` gives the
+ * number of samples available to userspace, with sample i at byte offset
+ * ``(i % sample_slots) * sample_size`` in the ring buffer BO. For example::
+ *
+ *             extract_idx % sample_slots  insert_idx % sample_slots
+ *                    |                            |
+ *                    v                            v
+ *     +--------------+----------------------------+--------------+
+ *     |              | published, unread samples  |              |
+ *     +--------------+----------------------------+--------------+
+ *
+ * See &struct drm_panthor_perf_ringbuf_control for the memory ordering requirements.
+ *
+ * Each sample has the following layout::
+ *
+ *     +--------+--------+------------------+--------+------------------+-----+
+ *     | Sample | Block  | Block of         | Block  | Block of         | ... |
+ *     | header | header | 64-bit counters  | header | 64-bit counters  |     |
+ *     +--------+--------+------------------+--------+------------------+-----+
+ *
+ * Each sample starts with a &struct drm_panthor_perf_sample_header containing
+ * timestamps, sample flags and the command's user data.
+ *
+ * Each block starts with a &struct drm_panthor_perf_block_header identifying its
+ * type and index, followed by counters_per_block 64-bit counters, as reported by
+ * &struct drm_panthor_perf_info.
+ */
+
 /**
  * struct drm_panthor_perf_block_header - Header present before every block in the
  * sample ringbuffer.
@@ -1380,6 +1461,9 @@ enum drm_panthor_perf_sample_flags {
 	/**
 	 * @DRM_PANTHOR_PERF_SAMPLE_OVERFLOW: This sample contains overflows due to the duration
 	 * of the sampling period.
+	 *
+	 * Counter collection has lost data. Further SAMPLE requests fail with -EACCES
+	 * until the session is stopped and restarted.
 	 */
 	DRM_PANTHOR_PERF_SAMPLE_OVERFLOW = 1 << 0,
 };
@@ -1415,11 +1499,7 @@ struct drm_panthor_perf_sample_header {
 /**
  * enum drm_panthor_perf_counter_set - The counter set to be requested from the hardware.
  *
- * The hardware supports a single performance counter set at a time, so requesting any set other
- * than the primary may fail if another process is sampling at the same time.
- *
- * If in doubt, the primary counter set has the most commonly used counters and requires no
- * additional permissions to open.
+ * If in doubt, the primary counter set has the most commonly used counters.
  */
 enum drm_panthor_perf_counter_set {
 	/**
@@ -1437,52 +1517,79 @@ enum drm_panthor_perf_counter_set {
 };
 
 /**
- * struct drm_panthor_perf_ringbuf_control - Struct used to map in the ring buffer control indices
- *                                           into memory shared between user and kernel.
+ * struct drm_panthor_perf_ringbuf_control - Shared ring buffer control indices.
  *
+ * After CREATE initializes both indices, userspace owns extract_idx and the
+ * kernel owns insert_idx, with the expected memory barrier semantics outlined below::
+ *
+ *     Kernel                                Userspace
+ *
+ *     Write sample counters and headers
+ *     store_release(insert_idx)
+ *     wmb()
+ *     eventfd_signal()                      Wait/read eventfd
+ *                                           load_acquire(insert_idx)
+ *                                           Read/copy published samples
+ *     load_acquire(extract_idx)             store_release(extract_idx)
+ *     Reuse consumed slots
+ *
+ * The kernel writes the sample, then store-releases the insert_idx to publish it.
+ * The following wmb() orders this publication before the eventfd notification.
+ * Userspace must load-acquire the insert_idx before reading samples to ensure
+ * the published sample writes are visible.
+ *
+ * To release slots, userspace store-releases the new extract_idx. The kernel load-acquires
+ * the extract_idx before reusing those slots. This prevents the kernel from overwriting data
+ * userspace is still reading.
  */
 struct drm_panthor_perf_ringbuf_control {
 	/**
 	 * @extract_idx: Number of samples consumed or discarded by userspace. Only
 	 *               modifiable by userspace.
+	 *
+	 * Userspace updates this after it has consumed or to discard samples from the ring buffer.
 	 */
 	__u64 extract_idx;
 
 	/**
 	 * @insert_idx: Number of samples emitted by the kernel. Only modifiable by
 	 *              the kernel.
+	 *
+	 * Userspace must read this before reading samples from the ring buffer.
 	 */
 	__u64 insert_idx;
 };
 
 /**
  * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANTHOR_PERF_SESSION_CREATE.
+ *
+ * The ioctl may return:
+ * - Nonnegative session handle on success.
+ * - -EACCES if neither CAP_PERFMON nor CAP_SYS_ADMIN is held.
+ * - -EINVAL for an invalid set, or @sample_slots below two or not a power of two.
+ * - -EBUSY when the device-wide limit of sessions has been reached, or when there is already
+ *    a conflicting block set configured.
+ * - -EOPNOTSUPP if performance counters are unavailable.
+ * - Other error codes are possible.
  */
 struct drm_panthor_perf_session_create {
 	/**
 	 * @block_set: Set of performance counter blocks, member of
 	 *             enum drm_panthor_perf_counter_set.
 	 *
-	 * This is a global configuration and only one set can be active at a time. If
-	 * another client has already requested a counter set, any further requests
-	 * for a different counter set will fail and return an -EBUSY.
-	 *
-	 * If the requested set does not exist, the request will fail and return an -EINVAL.
-	 *
-	 * Some sets have additional requirements to be enabled, and the setup request will
-	 * fail with an -EACCES if these requirements are not satisfied.
+	 * If the requested set is unavailable, the request will fail and return an -EINVAL.
 	 */
 	__u32 block_set;
 
 	/** @fd: eventfd for signalling the availability of a new sample. */
 	__u32 fd;
 
-	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
+	/** @ringbuf_handle: Handle to the BO containing samples, starting at offset zero. */
 	__u32 ringbuf_handle;
 
 	/**
-	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
-	 * insert and extract indices for the ringbuffer.
+	 * @control_handle: Handle to a separate BO containing
+	 * &struct drm_panthor_perf_ringbuf_control at offset zero.
 	 */
 	__u32 control_handle;
 
@@ -1490,7 +1597,7 @@ struct drm_panthor_perf_session_create {
 	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
 	 * a power of 2 and at least 2, to leave space for a sample and the final STOP sample.
 	 *
-	 * If sample_slots * sample_size is smaller than the ringbuf BO, the setup will fail.
+	 * If sample_slots * sample_size is larger than the ringbuf BO, the setup will fail.
 	 */
 	__u32 sample_slots;
 
@@ -1533,6 +1640,105 @@ struct drm_panthor_perf_session_create {
 	__u64 shader_enable_mask[2];
 };
 
+/**
+ * struct drm_panthor_perf_session_start - Arguments passed to DRM_PANTHOR_PERF_SESSION_START.
+ *
+ * Starts a stopped session and waits for a clearing sample, which is discarded.
+ * An already active session is unchanged. Ring indices and unread samples are
+ * preserved.
+ *
+ * The ioctl may return:
+ * - 0 on success.
+ * - -EINVAL for an invalid @handle or nonzero padding.
+ * - -ENOSPC if fewer than two ring buffer slots are free.
+ * - -EBUSY if the session is stopping.
+ * - -ETIMEDOUT if starting has not completed. The transition is not cancelled
+ *   and may complete later, so resuming the operation by calling the ioctl again is possible.
+ * - Other error codes are possible.
+ */
+struct drm_panthor_perf_session_start {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/** @user_data: User provided data for automatic samples. */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_sample - Arguments passed to DRM_PANTHOR_PERF_SESSION_SAMPLE.
+ *
+ * Requests a sample from an active session. Sample availability is signaled via the
+ * eventfd passed during session setup.
+ *
+ * The ioctl may return:
+ * - 0 when the request is accepted.
+ * - -EINVAL for an invalid @handle, nonzero padding, or a session that is not active.
+ * - -EBUSY if a sample request is already pending.
+ * - -ENOSPC if fewer than two ring buffer slots are free.
+ * - -EACCES after overflow; stop and restart the session to resume sampling.
+ * - Other error codes are possible.
+ */
+struct drm_panthor_perf_session_sample {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/** @user_data: User provided data that will be attached to the sample.*/
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_stop - Arguments passed to DRM_PANTHOR_PERF_SESSION_STOP.
+ *
+ * Stops an active session and waits for a final sample to be published. A stop request
+ * on an already stopped session is ignored and produces no sample.
+ *
+ * The ioctl may return:
+ * - 0 on success.
+ * - -EINVAL for an invalid @handle or nonzero padding.
+ * - -EBUSY if the session is starting, a sample request is pending, or no ring
+ *   buffer slot is free.
+ * - -ETIMEDOUT if stopping has not completed. The transition is not cancelled
+ *   and may complete later.
+ * - Other error codes are possible.
+ */
+struct drm_panthor_perf_session_stop {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/**
+	 * @user_data: User provided data attached to the final STOP sample.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_destroy - Arguments passed to DRM_PANTHOR_PERF_SESSION_DESTROY.
+ *
+ * Destroys a stopped session. The handle is no longer valid after this call.
+ *
+ * The ioctl may return:
+ * - 0 on success.
+ * - -EINVAL for an invalid @handle, nonzero padding, or an active session.
+ * - -EBUSY if the session is starting or stopping.
+ * - Other error codes are possible.
+ */
+struct drm_panthor_perf_session_destroy {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+};
+
 /**
  * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
  * @__access: Access type. Must be R, W or RW.
@@ -1583,6 +1789,16 @@ enum {
 		DRM_IOCTL_PANTHOR(WR, BO_SYNC, bo_sync),
 	DRM_IOCTL_PANTHOR_BO_QUERY_INFO =
 		DRM_IOCTL_PANTHOR(WR, BO_QUERY_INFO, bo_query_info),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_CREATE =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_CREATE, perf_session_create),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_START =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_START, perf_session_start),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_SAMPLE =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_SAMPLE, perf_session_sample),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_STOP =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_STOP, perf_session_stop),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_DESTROY =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_DESTROY, perf_session_destroy),
 };
 
 #if defined(__cplusplus)

-- 
2.43.0

