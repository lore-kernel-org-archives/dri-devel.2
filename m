Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDE2CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275EA10E13E;
	Sun, 11 Oct 2026 17:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ptyUgMJ+";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ptyUgMJ+";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9959E10E135
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d6BSwauRwzpxTXROM4fbp9CCboQZqVaSt8t6B6u/obcHneJ0avNHp3D/18a4HYQ1p9exGA3aGMCZwk7/tSlgwxtb/UNsjjBm9EtbGDa5Vy54FIFBL7KihQuRnut5xZ4srqkHkXRw4wN2k+uGUncwG7XJv0o8VmoJBOdax0fYpg/YbF47eLRO/6Ndo/t5E+aunBYMCN9xLMGhC9Bg4au+TfvLFZY7Rbzjq/UjrdD7XYV7VUWAfoDN4MMEYNqxzQli5pO7RkjR/AU0M6WWSf/E6jGeXV6Mtz8fiR2NGqyoCs/O3CBcEPI34sv0ImfUN3iKTpcrL+tM5yZHg4DV7z6vbQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HYKHVSUMEPo0XoL0H3Qb6m1emtO4wDm58VDAv44m+4=;
 b=U91ONOCgUEAT4tY6L+6QHHVlzW9KxECrwuOk4MN4qrTzhd/72+cg92Sz3w3KDqmsio9Bb6vJ5ZMBCSR4nBqcW0gyJWN2+FtgLXBzR++FQhPKiXTgxQUjg5pvNdhpYoLJFRFuc4kK4WhPmabb2qAP569zc6Jd2r837E8QEI7PUu9vf84FK2VASrJznxbyqIoAVjUSjZz+KWv+Vw6uR5pudCwhXObM60pyz5k3mp4ygLa+0Xd7oyaFEWdiU2g8ezmVXa+ed/c3KYDkQnZXYb3x0revdmNnsWyfYuC7xitqbqOYqUcUdMiOfXjxgIS/f5+PpTN1jRuZkxYV5WJCvkNbzQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HYKHVSUMEPo0XoL0H3Qb6m1emtO4wDm58VDAv44m+4=;
 b=ptyUgMJ+nCeVGTdKnp+SPeBxqlABGqxY36GOV/YrXs5DJGQXHfl2tyY2p35/rrIVmiGTnzRez+SgQ/SJTkMw21AJyzksdqEynttuu5u8h5E+ewSx47swUnXrbTcEgTyCGUPSIuxwIooRHSOSxWSq3c6/wIahhoMBo2sy9t7j6eg=
Received: from PR1P264CA0132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::7)
 by DU5PR08MB10735.eurprd08.prod.outlook.com (2603:10a6:10:525::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:40:17 +0000
Received: from MI3PEPF0000849B.eurprd03.prod.outlook.com
 (2603:10a6:102:2ce:cafe::90) by PR1P264CA0132.outlook.office365.com
 (2603:10a6:102:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun,
 11 Oct 2026 17:40:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000849B.mail.protection.outlook.com (10.167.240.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCgzS7taFiTj29ssOqfOImyOYu2y8h5d3TYb5BCqtUP35I05Oh+fXHTXPBn8tCRWY5eJ2EWYY5usEefpehHYMu9FSOZqBXkoBHtOP+kor3/XB9lNDrst9akeGhP1V41XhuIoD9utLPntVASwEmDewGVY71tocBgv43QOrf8TTELuO6rIcpb/WoWMmHGjtChfM7gq4Q+xJz5cVHMbtsHTo261HlMDo7Ifm+QlK9k50QJSWQvg9zI5mhsH1cA2vkXIiYHTwCRV0vHYQ6M2tHGb6fuozE2IXy7icrtZQuTOx0I69Vj4YfCWS61+IdpT0sv89KhSzp29KIO4zTOebujswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HYKHVSUMEPo0XoL0H3Qb6m1emtO4wDm58VDAv44m+4=;
 b=e0ylnWPi2CFXR0qTpX8ksRr6IV0XkInX5bmGedDYE4xmkdxMzsXdButcmMdPfYFe8LAj8j8G9nHnaHsbznd7qxc0ivDbO/M791AeFY7vFiWodUsIcIFV89n+JsM7m1HuOhiIICrCuWpw+5C6l/lnv0uXPaL1DrfJ8GqJp+TYbIVT3XQiHOOE1ae8KxNBeQ1aplCho2zjpTEIGzqNoy6lPYY/vdEo2bncBbVV8gVr2iWS0so8SPatCY2BxS6NkNYeNToPiHtU6bTLNGkJdZZJ7sTCqySIJ0oo33jLscbqscWXXnQR9BRXhrTF5WiEZ48fM3JU7FUhFT5uatdc5mUMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HYKHVSUMEPo0XoL0H3Qb6m1emtO4wDm58VDAv44m+4=;
 b=ptyUgMJ+nCeVGTdKnp+SPeBxqlABGqxY36GOV/YrXs5DJGQXHfl2tyY2p35/rrIVmiGTnzRez+SgQ/SJTkMw21AJyzksdqEynttuu5u8h5E+ewSx47swUnXrbTcEgTyCGUPSIuxwIooRHSOSxWSq3c6/wIahhoMBo2sy9t7j6eg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:45 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:45 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:52 +0100
Subject: [PATCH v7 5/8] drm/panthor: Introduce sampling sessions to handle
 userspace clients
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-5-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: PR3P193CA0032.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::7) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|MI3PEPF0000849B:EE_|DU5PR08MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a711304-fc14-4a41-7997-08df27beb6d7
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|921020|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info-Original: rceF3ceNZIxwHjXo+1VHO+QLFsnOh3h1eSW+IMbpjag6Xskj43nbksWmJng1M3kK2KGcEg7U8VCjb+61TZzTAYY0OMYU1RXSHn/3Z0ofk5sjOnyfg4GNmbvo8wiQNTyNANt8YCFPQoYs7z+hOeu1oQDCkqb8CR1+JQj1VpH/9CHsmCXrl+7ruTg7nD4EwZhF2RhAndGqxqsn+Lt48W7RJYlDzcyJ+2f5ymgAW62byvW0MELvt6M+/y0pE3mEErm5fx/b/BXIGgBt7wn8ITwLJ+6ny6ONUptX0O4k3hS7crXpF+JnIU5astphsYswW4SdDHffv+yQlk5tb1Qi3KGx8lZMabuyuOmDylRGo1cRdbD2rEaRFth43mERYnf9IJlXphVime83/ZZS+KEVvS4OnNyXlQV0vQYXFGQA94FN5DSE2Bomseg+ON6KLy8XFMNS5okAGsUEWby+XoFUcVvibsPASjz3CEv1ex1GZSX3qnV9KBFrTuWAnbciGSzqp4RtJO4fac1na+k5VBUDydV/E7bl311/C6G2y1xvPUofAxgLi38lXupyBHICNlhHV9NGTN7OM3CpHa9/9FJfWMnhKj4AZqUR+CU8Zoj2aXbYSRy44v/D79AKckt4UgvEvAEPP+cu129T3Nf8MbzdCuajql/SF8gy9EkgcM9gfCLkw9QLlagAqHwFntipSEe3jQo9SaOB7OXen0VeTP6Mk6QQAg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: euNdV5uLqpWqTU4pxzxR9p7XELDQ3QSklzbSW6/yrPWD495P3MOhqRP35cDC0zgVQwO3t9cbizzExU97Qv2FCWznJpheYX2HoM3zsOaI661wSMR4PoBcGCUlYCE2cZtOwB8C4hGKnWZ7beWzMgB4Nm2ddAaudCdPPjouDMUqQJ2artw6u+hqlEBx4oTzKa5k63lvr4WxrBFXnrorSuZstzlJVUQj2XtxcSr+qpH8kS8lUdW7h6+pfHV8hvgQsmKg9uwnMo2Q6neiJdVLzxBQewAOHowQN16sRK9y4KIWxjDah4+6i4GjAqg6gXkp/fQzbmDFNtzBjmSB4kLX+cy4rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2cd962fa-bf92-4010-7b07-08df27bea39b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|7416014|82310400026|36860700016|1800799024|14060799003|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|921020|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 81gvI9B6IlqnB2fLuBWewywuyuqhnUI5qwxI8Dh48fvzXkW9sBt4EJOSGq6Mi83BbZuXWgO6GubSRMhWM0BwhKg5N8JOQj98/MV/hIMOLQ0VmjUwfYotZMvv7jxjnCrufavqs/VBbINutTGOevNgkhteXW/kpqsCHAQeXyVQWrFPPtZ68W6uZzQHQfSrxUVKPAmoDoT/tJgU5c9ZXDamIidqZvf9HwO+BX7wVUAbqx7JFez6uRjJxnH05VgsHiN7H6mQnjfiopqEzzGBdR6AThziFi8QYt1DCezQJ1uEcd9CP6/2l911HMOwbyfXKs3ZytTeCDY/A+DNEExsC5zgb0fzzj7Dy56tHvF9HjlVh9lv6sDtcowRFBMr5CVQ8/Q98gPZJaFduvGEUwdvBlHhzflWcj2uVu1tzpOmkyIZaF4em1Sf8vwrlZxGqVBevPUzqAQ/dshXaEEG1+fr88oG9tzsX8QXB/pq7/i8X823AB9sJ3NdDqx4gvRYVUJXjCA8UwyEx1S60PI/RSgtq4JPV90yXgzA83xxjM6AJMLWvGDKpE4ILXdq007G6SA3HHPhgE0VEKYyyYIvZVbAljBHpU3Ssi35rdQdy08DorF5f0Zr/wd9V8I5XLq71nQ+LNzU0V1JsgDIOQZiRbmq2O+ngRpNPETn2IgGWkRr8Z3bjkdp0d4/w644zc9ATiNkEvkk+ze31X0NfrTCstSfFjiI9adb7upFJ7Cg5QQhv9URRDZop/4lTNTLFXUMNZANHqI+
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(7416014)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(921020)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AC99J1Hhpt5FtEFSCV7pEbNy0hSZy+nhFok0c+HDzbt09+lR1QMo2cafoKIwCSf9Wp5rGBKcl9o0o3aDvOyBDxUxXAhUNmP0fLuTHaHh/ga2isgLlgUOJoTHMpc0T0Z+TKj+8Cqf0szCjuAa3USvkuFaxCdL7uRPwzPq3FKJDQ/ycc/9MUynKYaaYnFzctoVYi0jVgLxmwyZvOE7OJFBUS3bmzAGakZC2eB6q1R68sj8o99eMKus6qNBsTjF/VSaxylT88QKy/CTF+qMh2UfYRdwgmZ1z8DkLE5eLGao+TEvu+fMTrr8qd+CgBc6UUT2LCU9utlMJ+Qo6XwZFicgtJz3wdW06fiylc8RPQDVnusl0KRJFpUOIr16yiqkGAUnEzIdkTNZl0mpaPmxiLPDHjfI+dEb0H9wjQvmc3MbW3vsO89xRfsEtV3LP3q7t3Nr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:17.2819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a711304-fc14-4a41-7997-08df27beb6d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000849B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10735
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

To allow for combining the requests from multiple userspace clients,
an intermediary layer between the HW/FW interfaces and userspace is
created, containing the information for the counter requests and
tracking of insert and extract indices. Each session starts inactive
and must be explicitly activated via PERF_SESSION_START and
explicitly stopped via PERF_SESSION_STOP. Userspace identifies a
single client with its session ID and the panthor file it is
associated with.

The SAMPLE and STOP commands both produce a single sample when called,
and these samples can be disambiguated via the opaque user data field
passed in the PERF_SESSION uAPI. If this functionality is not desired,
these fields can be kept as zero, as the kernel copies this value into
the corresponding sample without attempting to interpret it.

Currently, only manual sampling sessions are supported, providing
samples when userspace calls PERF_CONTROL_SAMPLE, and only a single
session is allowed at a time. Multiple sessions and periodic sampling
will be enabled in following patches.

No protection is provided against the 32-bit hardware counter
overflows, so for the moment it is up to userspace to ensure that
the counters are sampled at a reasonable frequency.

Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 drivers/gpu/drm/panthor/panthor_perf.c | 657 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_perf.h |  11 +
 2 files changed, 664 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
index ba466e22c50d..76c346981150 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.c
+++ b/drivers/gpu/drm/panthor/panthor_perf.c
@@ -2,10 +2,12 @@
 /* Copyright 2023 Collabora Ltd */
 /* Copyright 2025 Arm ltd. */
 
-#include <linux/bitops.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
 #include <drm/panthor_drm.h>
 #include <drm/drm_print.h>
+#include <linux/bitops.h>
 
 #include "panthor_device.h"
 #include "panthor_fw.h"
@@ -27,14 +29,130 @@
 
 #define MAX_SESSIONS_PER_FILE 1
 
+/**
+ * PANTHOR_PERF_EM_BITS - Number of bits in a user-facing enable mask. This must correspond
+ *                        to the maximum number of counters available for selection on the newest
+ *                        Mali GPUs (128 as of the Mali-Gx15).
+ */
+#define PANTHOR_PERF_EM_BITS (BITS_PER_TYPE(u64) * 2)
+
+enum panthor_perf_session_state {
+	/** @PANTHOR_PERF_SESSION_STOPPED: The session cannot sample. It starts out stopped. */
+	PANTHOR_PERF_SESSION_STOPPED = 0,
+
+	/** @PANTHOR_PERF_SESSION_STARTING: The session has not yet been started and is in the
+	 *				    process of handling the clearing sample.
+	 */
+	PANTHOR_PERF_SESSION_STARTING,
+
+	/** @PANTHOR_PERF_SESSION_ACTIVE: The session is active and can be used for sampling. */
+	PANTHOR_PERF_SESSION_ACTIVE,
+
+	/** @PANTHOR_PERF_SESSION_STOPPING: The session is currently stopping. After emitting the
+	 *				    next sample, it will transition to inactive.
+	 */
+	PANTHOR_PERF_SESSION_STOPPING,
+};
+
+struct panthor_perf_enable_masks {
+	/**
+	 * @mask: Array of bitmasks indicating the counters userspace requested, where
+	 *        one bit represents a single counter. Used to build the firmware configuration
+	 *        and ensure that userspace clients obtain only the counters they requested.
+	 */
+	unsigned long mask[DRM_PANTHOR_PERF_BLOCK_MAX][BITS_TO_LONGS(PANTHOR_PERF_EM_BITS)];
+};
+
 struct panthor_perf_counter_block {
 	struct drm_panthor_perf_block_header header;
 	u64 counters[];
 };
 
+struct panthor_perf_bo {
+	struct drm_gem_object *obj;
+	void *vaddr;
+};
+
+struct panthor_perf_session {
+	/** @state_lock: Used to protect session state information and overflow bit. */
+	struct mutex state_lock;
+
+	/** @state: The current state of the session. */
+	enum panthor_perf_session_state state;
+
+	/** @overflow: The session is affected by a FW ring buffer overflow. */
+	bool overflow;
+
+	/**  @insert_idx: The insert index in the user-visible buffer for the current session. */
+	u64 insert_idx;
+
+	/**
+	 * @accum_idx: Insert index of the populated slot. When this matches @insert_idx,
+	 *             accumulate into that slot; otherwise populate a new slot.
+	 */
+	u64 accum_idx;
+
+	/** @sample_start_ns: Sample request time, obtained from a monotonic raw clock. */
+	u64 sample_start_ns;
+
+	/**
+	 * @user_data: Opaque handle passed in when starting a session, requesting a sample (for
+	 *             manual sampling sessions only) and when stopping a session. This handle
+	 *             allows the disambiguation of a sample in the ringbuffer.
+	 */
+	u64 user_data;
+
+	/**
+	 * @eventfd: Event file descriptor context used to signal userspace of a new sample
+	 *           being emitted.
+	 */
+	struct eventfd_ctx *eventfd;
+
+	/**
+	 * @enabled_counters: This session's requested counters. Note that these cannot change
+	 *                    for the lifetime of the session.
+	 */
+	struct panthor_perf_enable_masks *enabled_counters;
+
+	/** @ringbuf_slots: Slots in the user-facing ringbuffer. */
+	size_t ringbuf_slots;
+
+	/** @ring_buf: BO and mapping for the userspace ringbuffer. */
+	struct panthor_perf_bo ring_buf;
+
+	/**
+	 * @control_buf: BO and mapping for the insert and extract indices.
+	 */
+	struct panthor_perf_bo control_buf;
+
+	/** @control: The mapped insert and extract indices. */
+	struct drm_panthor_perf_ringbuf_control *control;
+
+	/** @samples: The mapping of the @ring_buf into the kernel's VA space. */
+	u8 *samples;
+
+	/**
+	 * @sessions: The list node tracking all registered sessions.
+	 */
+	struct list_head sessions;
+
+	/**
+	 * @ref: Session reference count. The sample delivery to userspace is asynchronous, meaning
+	 *       the lifetime of the session must extend at least until the sample is exposed to
+	 *       userspace.
+	 */
+	struct kref ref;
+};
+
 struct panthor_perf {
 	/** @info: Pointer to the previously initialized perf info. */
 	struct drm_panthor_perf_info *info;
+
+	/**
+	 * @op_lock: Serializes session operations. Acquire before looking up session
+	 *           handles and before a session's state_lock.
+	 */
+	struct mutex op_lock;
 };
 
 struct panthor_perf_pool {
@@ -43,6 +161,9 @@ struct panthor_perf_pool {
 
 	/** @xa: Xarray used to manage session handles. */
 	struct xarray xa;
+
+	/** @next: Next handle to allocate. */
+	u32 next;
 };
 
 static size_t get_annotated_block_size(size_t counters_per_block)
@@ -87,6 +208,163 @@ static void panthor_perf_info_init(struct panthor_device *const ptdev)
 	perf_info->sample_size = session_get_sample_size(perf_info);
 }
 
+static struct panthor_perf_enable_masks *
+panthor_perf_create_em(struct drm_panthor_perf_session_create *const create_args)
+{
+	struct panthor_perf_enable_masks *const em = kmalloc(sizeof(*em), GFP_KERNEL);
+
+	if (IS_ERR_OR_NULL(em))
+		return em;
+
+	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_FW],
+			  create_args->fw_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_CSHW],
+			  create_args->cshw_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_TILER],
+			  create_args->tiler_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_MEMSYS],
+			  create_args->memsys_enable_mask, PANTHOR_PERF_EM_BITS);
+	bitmap_from_arr64(em->mask[DRM_PANTHOR_PERF_BLOCK_SHADER],
+			  create_args->shader_enable_mask, PANTHOR_PERF_EM_BITS);
+
+	return em;
+}
+
+static struct panthor_perf_session *
+session_get(struct panthor_perf_session *session)
+{
+	if (session)
+		kref_get(&session->ref);
+
+	return session;
+}
+
+static int
+panthor_perf_bo_get(struct drm_file *file, u32 handle, size_t expected_size,
+		    struct panthor_perf_bo *bo)
+{
+	struct drm_device *ddev = file->minor->dev;
+	struct drm_gem_object *obj;
+	struct iosys_map map;
+	int ret;
+
+	if (WARN_ON_ONCE(!bo))
+		return -EINVAL;
+
+	obj = drm_gem_object_lookup(file, handle);
+	if (!obj) {
+		drm_err(ddev, "Could not find handle %d!\n", handle);
+		return -EINVAL;
+	}
+
+	if (expected_size && obj->size != PFN_ALIGN(expected_size)) {
+		drm_err(ddev,
+			"Incorrect BO size from userspace: user %zu vs kernel %lu\n",
+			obj->size, PFN_ALIGN(expected_size));
+		ret = -ENOMEM;
+		goto err_put;
+	}
+
+	ret = drm_gem_vmap(obj, &map);
+	if (ret)
+		goto err_put;
+
+	bo->obj = obj;
+	bo->vaddr = map.vaddr;
+
+	return 0;
+
+err_put:
+	drm_gem_object_put(obj);
+	return ret;
+}
+
+static void panthor_perf_bo_put(struct panthor_perf_bo *bo)
+{
+	if (!bo->obj)
+		return;
+
+	if (bo->vaddr) {
+		struct iosys_map map = IOSYS_MAP_INIT_VADDR(bo->vaddr);
+
+		drm_gem_vunmap(bo->obj, &map);
+	}
+
+	drm_gem_object_put(bo->obj);
+
+	memset(bo, 0, sizeof(*bo));
+}
+
+static void session_free(struct kref *ref)
+{
+	struct panthor_perf_session *session = container_of(ref, typeof(*session), ref);
+
+	panthor_perf_bo_put(&session->ring_buf);
+	panthor_perf_bo_put(&session->control_buf);
+
+	kfree(session->enabled_counters);
+
+	eventfd_ctx_put(session->eventfd);
+
+	kfree(session);
+}
+
+static void session_put(struct panthor_perf_session *session)
+{
+	kref_put(&session->ref, session_free);
+}
+
+/**
+ * session_from_handle - Find a session associated with the pool and session_handle.
+ *
+ * @pool: Per-file pool.
+ * @handle: Session handle.
+ *
+ * The reference count of a valid session is increased to ensure it does not disappear
+ * in the window between the XA lock being dropped and the internal session functions
+ * being called.
+ *
+ * Return: valid session pointer or NULL.
+ */
+static struct panthor_perf_session *
+session_from_handle(struct panthor_perf_pool *pool, unsigned long handle)
+{
+	struct panthor_perf_session *session;
+
+	xa_lock(&pool->xa);
+	session = session_get(xa_load(&pool->xa, handle));
+	xa_unlock(&pool->xa);
+
+	return session;
+}
+
+#define DEFINE_SESSION_STATE_CHECK(name, _state)			     \
+	static bool session_is_## name(struct panthor_perf_session *session) \
+	{								     \
+		lockdep_assert_held(&session->state_lock);		     \
+									     \
+		return session->state == (_state);			    \
+	}
+
+DEFINE_SESSION_STATE_CHECK(active, PANTHOR_PERF_SESSION_ACTIVE);
+DEFINE_SESSION_STATE_CHECK(starting, PANTHOR_PERF_SESSION_STARTING);
+DEFINE_SESSION_STATE_CHECK(stopping, PANTHOR_PERF_SESSION_STOPPING);
+
+static bool session_has_overflow(struct panthor_perf_session *session)
+{
+	lockdep_assert_held(&session->state_lock);
+
+	return session->overflow;
+}
+
+static void session_set_state(struct panthor_perf_session *session,
+			      enum panthor_perf_session_state state)
+{
+	lockdep_assert_held(&session->state_lock);
+
+	session->state = state;
+}
+
 /**
  * panthor_perf_init - Initialize the performance counter subsystem.
  * @ptdev: Panthor device
@@ -110,6 +388,10 @@ int panthor_perf_init(struct panthor_device *ptdev)
 	if (!perf)
 		return -ENOMEM;
 
+	ret = drmm_mutex_init(&ptdev->base, &perf->op_lock);
+	if (ret)
+		return ret;
+
 	drm_info(&ptdev->base, "Performance counter subsystem initialized");
 
 	perf->info = &ptdev->perf_info;
@@ -118,6 +400,371 @@ int panthor_perf_init(struct panthor_device *ptdev)
 	return ret;
 }
 
+/**
+ * panthor_perf_session_create - Create a user-visible session.
+ *
+ * @file: DRM file associated with the request.
+ * @create_args: Creation arguments passed in via ioctl.
+ * @sid: Session identifier output.
+ *
+ * Creates a new session associated with the session ID returned. When initialized, the
+ * session must explicitly request sampling to start with a successive call to PERF_SESSION_START.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_create(struct drm_file *file,
+				struct drm_panthor_perf_session_create *create_args,
+				unsigned long *sid)
+{
+	struct panthor_file *pfile = file->driver_priv;
+	struct panthor_device *ptdev = pfile->ptdev;
+	struct panthor_perf_bo ringbuffer = {}, control = {};
+	const size_t slots = create_args->sample_slots;
+	struct panthor_perf_pool *pool = pfile->sessions;
+	struct panthor_perf_session *session;
+	struct panthor_perf_enable_masks *em;
+	size_t user_sample_size;
+	u32 session_id;
+	int ret;
+
+	if (!ptdev->perf)
+		return -EOPNOTSUPP;
+
+	if (!pool)
+		return -EINVAL;
+
+	if (!perfmon_capable())
+		return -EACCES;
+
+	session = kzalloc_obj(*session);
+	if (ZERO_OR_NULL_PTR(session))
+		return -ENOMEM;
+
+	if (!is_power_of_2(slots)) {
+		drm_err(&ptdev->base,
+			"Number of slots is not power-of-2 aligned\n");
+		ret = -EINVAL;
+		goto cleanup_session;
+	}
+
+	user_sample_size = ptdev->perf_info.sample_size * slots;
+
+	ret = panthor_perf_bo_get(file, create_args->ringbuf_handle,
+				  user_sample_size, &ringbuffer);
+	if (ret)
+		goto cleanup_session;
+
+	ret = panthor_perf_bo_get(file, create_args->control_handle, 0, &control);
+	if (ret)
+		goto cleanup_ringbuf;
+
+	session->eventfd = eventfd_ctx_fdget(create_args->fd);
+	if (IS_ERR(session->eventfd)) {
+		drm_err(&ptdev->base, "Invalid eventfd %d!\n", create_args->fd);
+		ret = PTR_ERR_OR_ZERO(session->eventfd) ?: -EINVAL;
+		goto cleanup_control;
+	}
+
+	em = panthor_perf_create_em(create_args);
+	if (IS_ERR_OR_NULL(em)) {
+		ret = -ENOMEM;
+		goto cleanup_eventfd;
+	}
+
+	kref_init(&session->ref);
+	INIT_LIST_HEAD(&session->sessions);
+	mutex_init(&session->state_lock);
+	session->control = control.vaddr;
+	*session->control = (struct drm_panthor_perf_ringbuf_control) { 0 };
+	session->samples = ringbuffer.vaddr;
+	session->enabled_counters = em;
+	session->ring_buf = ringbuffer;
+	session->ringbuf_slots = slots;
+	session->control_buf = control;
+	session->accum_idx = U32_MAX;
+
+	ret = xa_alloc_cyclic(&pfile->sessions->xa, &session_id, session,
+			      pfile->sessions->session_range,
+			      &pfile->sessions->next, GFP_KERNEL);
+	if (ret < 0) {
+		drm_err(&ptdev->base, "File session limit exceeded.\n");
+		ret = -EBUSY;
+		goto cleanup_obj;
+	}
+
+	*sid = session_id;
+	return 0;
+
+cleanup_obj:
+	session_put(session);
+	return ret;
+
+cleanup_eventfd:
+	eventfd_ctx_put(session->eventfd);
+
+cleanup_control:
+	panthor_perf_bo_put(&control);
+
+cleanup_ringbuf:
+	panthor_perf_bo_put(&ringbuffer);
+
+cleanup_session:
+	kfree(session);
+
+	return ret;
+}
+
+static int session_try_stop(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(mutex)(&session->state_lock);
+
+	if (!session_is_active(session))
+		return 0;
+
+	if (session_is_starting(session))
+		return -EBUSY;
+
+	if (session_is_stopping(session))
+		return 1;
+
+	session_set_state(session, PANTHOR_PERF_SESSION_STOPPING);
+	session->user_data = user_data;
+
+	return 1;
+}
+
+static int session_stop(struct panthor_perf *perf, struct panthor_perf_session *session,
+			u64 user_data)
+{
+	int ret;
+
+	ret = session_try_stop(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+static int session_try_start(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(mutex)(&session->state_lock);
+
+	if (session_is_active(session))
+		return 0;
+
+	if (session_is_stopping(session))
+		return -EBUSY;
+
+	if (session_is_active(session) || session_is_starting(session))
+		return 0;
+
+	session_set_state(session, PANTHOR_PERF_SESSION_STARTING);
+	session->user_data = user_data;
+
+	return 1;
+}
+
+static int session_start(struct panthor_perf *perf, struct panthor_perf_session *session,
+			 u64 user_data)
+{
+	int ret;
+
+	ret = session_try_start(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+static int session_try_sample(struct panthor_perf_session *session, u64 user_data)
+{
+	guard(mutex)(&session->state_lock);
+
+	if (!session_is_active(session))
+		return -EINVAL;
+
+	if (session_is_stopping(session))
+		return -EBUSY;
+
+	if (session_has_overflow(session))
+		return -EACCES;
+
+	session->user_data = user_data;
+
+	return 1;
+}
+
+static int session_sample(struct panthor_perf *perf, struct panthor_perf_session *session,
+			  u64 user_data)
+{
+
+	int ret;
+
+	ret = session_try_sample(session, user_data);
+	if (ret <= 0)
+		return ret;
+
+	/* TODO Calls to the FW interface will go here in later patches. */
+	return 0;
+}
+
+static int session_try_destroy(struct panthor_perf_session *session)
+{
+	guard(mutex)(&session->state_lock);
+
+	if (session_is_active(session))
+		return -EINVAL;
+
+	if (session_is_starting(session) || session_is_stopping(session))
+		return -EBUSY;
+
+	return 0;
+}
+
+/**
+ * panthor_perf_session_destroy - Destroy the session associated with @handle.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier.
+ *
+ * Only stopped sessions can be destroyed. Other session states return an error.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_destroy(struct panthor_file *pfile, u32 handle)
+{
+	struct panthor_perf_session *session;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+	int ret;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	scoped_guard(mutex, &perf->op_lock) {
+		session = xa_load(&pfile->sessions->xa, handle);
+		if (!session)
+			return -EINVAL;
+
+		ret = session_try_destroy(session);
+		if (ret)
+			return ret;
+
+		xa_erase(&pfile->sessions->xa, handle);
+	}
+
+	session_put(session);
+
+	return ret;
+}
+
+/**
+ * panthor_perf_session_start - Start sampling on a stopped session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: Opaque value passed in from userspace.
+ *
+ * A session counts as stopped when it is created or when it is explicitly stopped after being
+ * started. Starting an active session is treated as a no-op.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data)
+{
+	struct panthor_perf_session *session;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+	int err;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&perf->op_lock);
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	err = session_start(perf, session, user_data);
+
+	session_put(session);
+
+	return err;
+}
+
+/**
+ * panthor_perf_session_stop - Stop sampling on an active session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: An opaque value passed in from userspace.
+ *
+ * A session counts as active when it has been explicitly started via the PERF_SESSION_START
+ * ioctl. Stopping a stopped session is treated as a no-op.
+ *
+ * To ensure data is not lost when sampling is stopping, there must always be at least one slot
+ * available for the final automatic sample, and the stop command will be rejected if there is not.
+ *
+ * The @user_data will always be associated with the final sample.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int handle, u64 user_data)
+{
+	struct panthor_perf_session *session;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+	int err;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&perf->op_lock);
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	err = session_stop(perf, session, user_data);
+
+	session_put(session);
+
+	return err;
+}
+
+/**
+ * panthor_perf_session_sample - Request a sample on a manual sampling session.
+ * @pfile: Open panthor file.
+ * @handle: Session identifier for the desired session.
+ * @user_data: An opaque value passed in from userspace.
+ *
+ * Only an active manual sampler is permitted to request samples directly. Failing to meet either
+ * of these conditions will cause the sampling request to be rejected. Requesting a manual sample
+ * with a full ringbuffer will see the request being rejected.
+ *
+ * The @user_data will always be unambiguously associated one-to-one with the resultant sample.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int panthor_perf_session_sample(struct panthor_file *pfile, u32 handle, u64 user_data)
+{
+	struct panthor_perf_session *session;
+	struct panthor_perf *perf = pfile->ptdev->perf;
+	int err;
+
+	if (!perf)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&perf->op_lock);
+
+	session = session_from_handle(pfile->sessions, handle);
+	if (IS_ERR_OR_NULL(session))
+		return IS_ERR(session) ? PTR_ERR(session) : -EINVAL;
+
+	err = session_sample(perf, session, user_data);
+
+	session_put(session);
+
+	return err;
+}
+
 /**
  * panthor_perf_unplug - Terminate the performance counter subsystem.
  * @ptdev: Panthor device.
@@ -156,13 +803,15 @@ int panthor_perf_pool_create(struct panthor_file *pfile)
 void panthor_perf_pool_destroy(struct panthor_file *pfile)
 {
 	struct panthor_perf_pool *pool = pfile->sessions;
+	unsigned long handle;
+	struct panthor_perf_session *session;
 
 	if (IS_ERR_OR_NULL(pool))
 		return;
 
-	if (!xa_empty(&pool->xa)) {
-		drm_err(&pfile->ptdev->base,
-			"Performance counter sessions active when unplugging the driver!");
+	xa_for_each(&pool->xa, handle, session) {
+		xa_erase(&pool->xa, handle);
+		session_put(session);
 	}
 
 	xa_destroy(&pool->xa);
diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
index ad01fc88f18f..641a88edd75a 100644
--- a/drivers/gpu/drm/panthor/panthor_perf.h
+++ b/drivers/gpu/drm/panthor/panthor_perf.h
@@ -7,8 +7,11 @@
 
 #include <linux/types.h>
 
+struct drm_file;
+struct drm_panthor_perf_session_create;
 struct panthor_device;
 struct panthor_file;
+struct panthor_perf;
 struct panthor_perf_pool;
 
 int panthor_perf_pool_create(struct panthor_file *pfile);
@@ -17,5 +20,13 @@ void panthor_perf_pool_destroy(struct panthor_file *pfile);
 int panthor_perf_init(struct panthor_device *ptdev);
 void panthor_perf_unplug(struct panthor_device *ptdev);
 
+int panthor_perf_session_create(struct drm_file *file,
+				struct drm_panthor_perf_session_create *setup_args,
+				unsigned long *sid);
+int panthor_perf_session_destroy(struct panthor_file *pfile, unsigned int handle);
+int panthor_perf_session_start(struct panthor_file *pfile, u32 handle, u64 user_data);
+int panthor_perf_session_stop(struct panthor_file *pfile, unsigned int sid, u64 user_data);
+int panthor_perf_session_sample(struct panthor_file *pfile, unsigned int handle, u64 user_data);
+
 #endif /* __PANTHOR_PERF_H__ */
 

-- 
2.43.0

