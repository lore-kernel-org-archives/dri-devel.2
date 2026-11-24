Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A9606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mGHFqQPA;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=mGHFqQPA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEA810F7A3;
	Tue, 24 Nov 2026 16:21:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D274910F7B2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:20:54 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HiKxqPOb1RCwJbz9AtdI7TL00ldngs5PjAmW52LVHKAvESWy8PnTr3ZhJyziD3MmAp+8nz2MMNjUnQggcm7tBAUqMHPRXnwAb8gLdarkl36X6448NIc7/OFlkmB27TXbkgDktJH8yFMffMBevRO6SJx0BAYWcYlsBENgICIASVjOhytNCvG2nH1JlfBlAmyu4+W7vinx1NPcarDs+mVSw/6EHyHOyLOGG8QfbRtn1wiylnsl+HAHy8gGQkBloJr81XlJA02RApxSntQsJIj05DOYEFX/oHM4crF6kZ5Zd3/8SVhQCINVb9GiDIj4ientoFaS6jCISbY3LcHUEbPc9w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=E4YUZqag2MIMTeMcLdYpC5Lmhc+64tnjXfFVjd5rxJMnQn7AuufX2H5Z+TpLHz8msZNEfYEqZLqrQJ9sbxypplWOlFRZCR+EhZepI6HGLjOWnMbf1r5qPPqygnVnPUuoy0P2IB9M4fs1Xc80qVRD15/wZehVPpPb3X7X4pHDDxUINDmb37N1AzbijYOPXrW+i3F5u1XZrX7l09ahCw2B/RgKCavPikSfjAWvXaKiX9A8EmRuPaeqAHF63K+6BOhwzo4NfMCFAAt4Lp8uCMbfhZX8COK5eGNzdnwCCJvJ6fJpiDd/VOIoYp8Z5yE4mZvVRl7ZsjmiyZnw+1vrD1UQgg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=mGHFqQPAcT+/gv2dxMi+CEbICcnQxTBshq1mvAzSUD/0y5HBAEBOSgaoQmUB45Jwgpp49ajih6L/RYCnf3eXqNQnwZck8AqjhGUsnDo/CqKKI0/ZemGLc9b6fn67wPy2A3xsa/WeA9+PIKxRhZBDVFrGSUC2Ks5scpkBb759VcA=
Received: from DU2PR04CA0175.eurprd04.prod.outlook.com (2603:10a6:10:2b0::30)
 by AM9PR08MB6660.eurprd08.prod.outlook.com (2603:10a6:20b:305::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:49 +0000
Received: from MAD0EPF000008AD.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0:cafe::ad) by DU2PR04CA0175.outlook.office365.com
 (2603:10a6:10:2b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 16:20:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008AD.mail.protection.outlook.com (10.167.241.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqH96ObYasHL3kkBYjy5GR+Y0gEWRSmfgimn6CyelJjeld7NbX1zGcbmaEBj3bFdz2q9h2z3XUK6ugE9QpB8jzDJuCFrBvrHbIZKaFCqx4wjpG9foVBRDdE89uERW+pbpAeh+I5NnD3I3NuFnYGrbAEEF5L48CmGRz1DvKEf4Q1AaRVmiZyGNTXFwSULNvscDchR+TrPV/+rAudokvi3feMHhxEHmXEUKR8//oxiTYP3ipT8spuyoiXI93DbIaacpjrvFYbGCGrEDkG1+rmV6+9HLoYIJkSIecfi9uuue0YnFRLTFA0yJgAu59x9OlBeIR0nUT+nKpTnBcTfpDkHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=fZZroXwa2vBpD7kwmG6/ilUewOh8XqzCkzqJRRDc07rwesp16fc3+4IZmMHwUrvbXDVEPQ3wLQan7PjiRyKvUxO3uL6ICWD+e0f4Ok+kx4DLmRZYeAypu0+/d6L1tTr1vG6IduubwNpHhj4nJkF8VchhXpqdrVkC7Fws0McC+7UKZZMue9x2+mVbpBUFar2zm7it8ToTlBYnZwBF9Hbl3YalJa07Bzj20HoxOM6MSSoXVfLIijIYS68Msl1+d99Q02ybiCji0mj+b5tRt0phVC7FzWFwfNDra04fNRt0QgYY7E798+jUUMGTyCWRO0sGpKvcyUB6BZBWFqMRP/R0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnghYJ3rBpI+uf4posIno9PMkzvou9x5qkiDpwD1b1w=;
 b=mGHFqQPAcT+/gv2dxMi+CEbICcnQxTBshq1mvAzSUD/0y5HBAEBOSgaoQmUB45Jwgpp49ajih6L/RYCnf3eXqNQnwZck8AqjhGUsnDo/CqKKI0/ZemGLc9b6fn67wPy2A3xsa/WeA9+PIKxRhZBDVFrGSUC2Ks5scpkBb759VcA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by VI3PR08MB938182.eurprd08.prod.outlook.com (2603:10a6:800:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:14 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:14 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 4/9] drm/panthor: Parse and store GPU_ID fields
Date: Tue, 24 Nov 2026 16:19:42 +0000
Message-ID: <20261124161952.1053586-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::7) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|VI3PR08MB938182:EE_|MAD0EPF000008AD:EE_|AM9PR08MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd37404-0459-423d-71e0-08df4a46e687
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261102123227099003|261021123027099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: 4LK3wHOdys7ClJnNVUwgIztYAV2hd6zCR81tIIvDp9lr+tHjX34qlLo3EGbSZjniOY0lbsib140tjzHdKUCE1cvpw7XtTAmxJabgUxHq68hB6AQFrRFeX0HqXPNVO80689KPT1AYdoTtXaaMX3Nu+I4W2K6KvRyUsBTsMVY3SIWPVgVIpcRq/SkQlUn25YO7RW51Hy1uDUVsCn/RfxBwYvLx5KwJ4YOec9PxAooo50fvNqaKhsjJfxHTzMIsMUYi+ztkSqtqMg/aETcaSkqqe+KJEJhs0LePA7l57HfLH7QcTaOnQgeBrkgOoKVZpCwFkyLxxcpwJLL7c5i3YV6VEsPHBpH3hr+C5xXReNePgDZ/ppF9qpJCwya8l4ASsHB3ru1wHN0rU7BKR5tsBLB0CrLNlKvBzyDznt5OkiSoFntyV4cKL64rto3KYebZxM7VrJ5P7WaR5jJBYomjeME/4qs/Y7YC5Z/OFjYEqyeMyqHE2iI0QKM7A1P6wXVGwahOB+9/c28x3wivSylvN9AWAUpmbYVcPvsOPc+bE1uLgWpha8lavX/QCqZwhAi0rG2htrVJkd2Q9QK4/wroQbge9TKm19UO5pozyTTaLuz1Fb9fEQSmLF7ERMj+WMv4qGsT
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: aGTkqoMYXB0J+2H0chTX8WKP6R2Uo71f8fGTz25+L5k9KSpcwa2Ry0H5whDkRG2r2TS6DoQp+Zb5dlDhXM2KfLuAiCtaEXoJJzdit991QnWegNs5q95OpIJCUupoLQrK6wwTgeMT6QIQysUWLUaAALofzkGMgQlqQ2st740M6DzNuExNHoyG5RXwoOIaas7oOzst5H9uGpA/Ev9IAxPrJPJzM/RzRtsY5gIr9x21CYYQ3XmbnL52JkZNZeMMtEfl22WsdcQ6D1qfJpeeIQacVw7N9+6wkstNRNYgDV8UWGEdy75Ya0S2d2dU/wl8qznB6MP6f1JKlwwbmscX70pktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB938182
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7fb425b6-ffe9-405f-4d8d-08df4a46d1e9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|35042699022|36860700016|23010399003|14060799003|6133799003|261009223027099003|18002099003|22082099003|13003099007|261021121427099003|261022075727099003|261102123227099003|56012099006|261021123027099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: nIN6w8HoIcvghD0YKpeeiNfGVHFjgWcNCGR6T/cOntn/L284PthQimB/wuUA+KU8reYaPWHJDXP3FkRIyLtgTPNO/yIziOxaVEU4xIkJR+1TxuXlB1MApAg0upH/b9QOiJXXTudqudvmNKQa8nVgMH+cLJLRXny7Dp4zzY44XL3pCxs4Z2xPnLbzHGD3tF1g9N7WcYCJLR04+QEe6x6X+k38Y9gReTZWR96TD5QvQR/WwPfdP5GkvE58tf455uqUpBWbq6zkfr7qcLlq+8R4P2/gnhof/Kx+6N7GfJpIWLiX33GW/d7kR/dJ8saaf51yBdzZSdKa+tkeSSK1S3dLg7aOazN4US80ioFUZ3KStBA+kzKmQBkCYx9oEOT8hBRRzVeuW7yO7DfeCDrkoezZQHy0ZfWtK0lcwMveQOxLe8TZpUIVLgGNTUc9RjRAKBWEGpDsrysJdMiCzUqK+M+oMZdbaIq6MLVBTDnwoye4cL0DultlI5KbCt+lsuXz3RqDStQmvmQ1KZIL8pbBsBzYOtN1oNT8BlYs2sLx+pTmWyrBXLWNfU7njXQKNys/B90016PKI1eSHQ0fc8GLaUtm+I0/fquBhlO4U8SPR4U60OxyWqhInCG15MWZEzzwz2N0CJ004oxFofLkRy+1zyNcOfG32IMsDIKgMiO6XXGFVmk=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(36860700016)(23010399003)(14060799003)(6133799003)(261009223027099003)(18002099003)(22082099003)(13003099007)(261021121427099003)(261022075727099003)(261102123227099003)(56012099006)(261021123027099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5vO5hkdYnTLh4AM2tzGOuymM6lV9NSNVrsOX1gCwzvUkWncc2YqOVkjq3swhWdcKLEPU3Spxi3iqGz4rxbo61w4PlZG4hiRInfC68paiG72slY6vWZOWcbWrcEk3Dh+p3qI8Tfx6aYzetnEwKkXtTDuNO43+MZqVyfiA85BdOCnU5B2KmyXi/F2elItrGr0sIVbi8S4+rJTiLUHoIU0AnfpfjlamJLKWnTL1b/0rjuLa34Sg5kukyHp/o7ilppV7DKi+szm/Uoxx1TAWhY7pI0yqY+xuqc+NPCIdpZYMqQtGNV90fKDT72H15VCMKWlhdrcoj6g02qwJH6D1sVPxfbDDSIx3c1BQtx01vQuhgUlColiOMFDhja7trabYhscl932e8nSaQths+R9IYrBtPqzFanY/4zOHonmjUIsA7ryOfs3Zt6FSnk6GOwe94QAK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:48.3863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd37404-0459-423d-71e0-08df4a46e687
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008AD.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6660
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

Prepare for Mali v15, where GPU_ID expands to 64 bits and its field
layout changes.

Introduce a small panthor_gpu_id structure and parse the GPU_ID fields
once during hardware initialization. Convert existing users to consume
the cached fields instead of extracting them repeatedly from the raw
register value.

This centralizes GPU_ID decoding and makes it easier to support both the
existing and v15 formats.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Picked up R-b from Boris
v2:
- Picked up R-b from Liviu
- Avoid modifying the printed id field for existing GPUs.
- Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
v1:
- changed struct panthor_gpu_id into a flat structure instead of
  inconsistent groupings.

 drivers/gpu/drm/panthor/panthor_device.h | 29 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_fw.c     |  4 ++--
 drivers/gpu/drm/panthor/panthor_gpu.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_hw.c     | 24 ++++++++++++++------
 drivers/gpu/drm/panthor/panthor_hw.h     |  4 ++--
 5 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 4add31b12cfd7..f0a96ff0f13da 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -111,6 +111,32 @@ struct panthor_irq {
 	enum panthor_irq_state state;
 };
 
+/**
+ * struct panthor_gpu_id - Parsed GPU_ID fields
+ */
+struct panthor_gpu_id {
+	/** @arch_major: Architecture major revision */
+	u8 arch_major;
+
+	/** @arch_minor: Architecture minor revision */
+	u8 arch_minor;
+
+	/** @arch_rev: Architecture patch revision */
+	u8 arch_rev;
+
+	/** @prod_major: Product identifier */
+	u8 prod_major;
+
+	/** @ver_major: Major release version number */
+	u8 ver_major;
+
+	/** @ver_minor: Minor release version number */
+	u8 ver_minor;
+
+	/** @ver_status: Status of GPU release */
+	u8 ver_status;
+};
+
 /**
  * enum panthor_device_profiling_mode - Profiling state
  */
@@ -170,6 +196,9 @@ struct panthor_device {
 	/** @mmu_info: MMU info */
 	struct drm_panthor_mmu_info mmu_info;
 
+	/** @gpu_id: Parsed GPU_ID fields */
+	struct panthor_gpu_id gpu_id;
+
 	/** @hw: GPU-specific data. */
 	struct panthor_hw *hw;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13bf..13efed3a2ea72 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -809,8 +809,8 @@ static int panthor_fw_load(struct panthor_device *ptdev)
 	int ret;
 
 	snprintf(fw_path, sizeof(fw_path), "arm/mali/arch%d.%d/%s",
-		 (u32)GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id),
-		 (u32)GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id),
+		 (u32)ptdev->gpu_id.arch_major,
+		 (u32)ptdev->gpu_id.arch_minor,
 		 CSF_FW_NAME);
 
 	ret = request_firmware(&fw, fw_path, ptdev->base.dev);
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index b8df5663f04e4..c5c37f22993d6 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -74,7 +74,7 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	if (!data || !data->asn_hash_enable)
 		return;
 
-	if (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) < 11) {
+	if (ptdev->gpu_id.arch_major < 11) {
 		drm_err(&ptdev->base, "Custom ASN hash not supported by the device");
 		return;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 34dc4b9d9dc09..854874a9f322a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -119,9 +119,9 @@ void panthor_hw_power_status_unregister(void)
 
 static char *get_gpu_model_name(struct panthor_device *ptdev)
 {
-	const u32 gpu_id = ptdev->gpu_info.gpu_id;
-	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
-						GPU_PROD_MAJOR(gpu_id));
+	const struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
+	const u32 product_id = GPU_PROD_ID_MAKE(gpu_id->arch_major,
+						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
@@ -245,9 +245,9 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	if (ret)
 		return ret;
 
-	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	major = ptdev->gpu_id.ver_major;
+	minor = ptdev->gpu_id.ver_minor;
+	status = ptdev->gpu_id.ver_status;
 
 	drm_info(&ptdev->base,
 		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
@@ -273,7 +273,7 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 static int panthor_hw_bind_device(struct panthor_device *ptdev)
 {
 	struct panthor_hw *hdev = NULL;
-	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	const u32 arch_major = ptdev->gpu_id.arch_major;
 	int i = 0;
 
 	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
@@ -295,10 +295,20 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
+	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
 	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+
 	if (!ptdev->gpu_info.gpu_id)
 		return -ENXIO;
 
+	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
+	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
+	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f770dc40e6216..c4a490bc39de6 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -58,12 +58,12 @@ static inline void panthor_hw_l2_power_off(struct panthor_device *ptdev)
 
 static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 {
-	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
+	return ptdev->gpu_id.arch_major >= 14;
 }
 
 static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 {
-	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
+	return (ptdev->gpu_id.arch_major >= 14 &&
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
-- 
2.43.0

