Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FB606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=i01iv61X;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=i01iv61X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798F810FF0F;
	Wed, 18 Nov 2026 17:55:21 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B1610FF04
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:54:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=oPQmsUe7RadA5kd7f418gilfGN0vEr094I5s6LK6rYp4vZXHU4YOkwaqFq4H845PVTkxQ5gk02LjIFZ7Doeg8gFasVR3+LVoGxXErS1Ao9Dy6MMpDTZubE+Tv1nXkdxKpctkL5TJIbvp/pGEG+cNnpTRMTMSZId3ml64RK7MZIyGPnas+mxuIU1Vr9QKHrJmixuX6xeiMrY8tGeCeVHETpOKqXkcv28CbbpajhmQ2zajTVz2KP7AieurnNB3VhAbkGZl0J9AHOEppOHIHi80QK3G7i33sbylS+9ePttMPsCigiLeUXnjKYciQDhMXz+KqFOCAfOnAwC+6BGLUws/ww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N83GoVXaYovPibIkkS5e0HZU6pqh5hMrDYSZx0GJU24=;
 b=a8QaVoQjCbqr5Hnu5bODL0YXczpd/kB9bxhlIeyACfBNeF7j2JFJ/Yk1tgcDhYbl7V77YnBk2iWwQ8RBGjNoyBdfP22wR0FRnG5DoJYF8QhqdAVtJwxz+PhKlAOt9IS4NTRX57KQx42IPaVznDZNn1nf/72fdonKQ7uwbYqy/IYG9d/X9Xra8eM6FzHME6Zhmxv+Eo1PWXXiNiPKEuDnytSs51g9k+Iyv4uY15AFC04o8GlxRZ4g4O3ei101aV0wfg/aWocigrMoW4MaSBqA/MZ0gRXzXtU8/pqHQk3Xul3cKtz2GjX7FJyYiEgFBq5+/J5W7yjaRSNP3zj1zx2dGA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N83GoVXaYovPibIkkS5e0HZU6pqh5hMrDYSZx0GJU24=;
 b=i01iv61XP4JbFoG9KdzTrHD9sfIu3CQ3L1Ro5jQvORlx1fIP/ivfoI99f7Drx494vj3U6kZmkEUgVpBjyUPPZsNPpaqYgovIpgS5BVBC01kCnqROEE1R1A2jptsndGpHWWQFU46y4X3PwkGPlBW8HiTe0bUu8TEl1RXgwe8wmaM=
Received: from AS8PR07CA0034.eurprd07.prod.outlook.com (2603:10a6:20b:459::19)
 by GV1PR08MB7876.eurprd08.prod.outlook.com (2603:10a6:150:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:54:47 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:459:cafe::8) by AS8PR07CA0034.outlook.office365.com
 (2603:10a6:20b:459::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.7 via Frontend Transport; Wed, 18
 Nov 2026 17:54:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Wed, 18 Nov 2026 17:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcZapNX7E5gWM5JNtzGutSemzsovnRtRxh4suikYI0lA4XYNnfGzJZdgPW6NxOuBoslptV2Q6mt+bxz6GFeBEEwPla2BcUoJ9jidqsVzcWzBwB4QYb2v8UnO/woXpjkIq+RXVufX59FX4AwFroJ2y+ylczIYaVu2hdndLkDriD8eNM4gseXRQrfg82AuIhElhgM5EzyFYZ2F3SeViysoUG5RoeV1IWrnjUZMmndkDuNCP2mM4S1ICtCV/9eJlQLKLTdyDXNhzkTIAL/BNNNrbjfdwvAOihlm/L7zwBxrMiYV9CPWD3Sy5y1cQRuacOLivsA2CY71Zw5tuThpxEl+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N83GoVXaYovPibIkkS5e0HZU6pqh5hMrDYSZx0GJU24=;
 b=GXn8WEafidNKnNnFaIWiP9Hn7D0pnAtZVBa2hyfM1XG1jsomU4RJEzzUCeTcV4Laol8Yvuf9hobYgWawlarqvhhrCdBQIac1nTlOhhM2Z5TtTxpmBncCYYIWxjTt4jfz+yjx7lYEp/L+H9b2p+Z7TuR85HhANo3j4nUAoLjwx0uV+nnlJZDsk26Z8Mwj0TKv3eKSSlm0dPdfBs9Sgg2KFGTCykY+vyAZgA80fC/6/xrJYkrfmt8nZEcKruqwaQ/Zpm2FHugwGoxD5VkijWAwExVj/NbWTVjfS5G9NS573pRdjVuMAqo391K55kc41lSU9HlByfzt2aGAPvosBt0YhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N83GoVXaYovPibIkkS5e0HZU6pqh5hMrDYSZx0GJU24=;
 b=i01iv61XP4JbFoG9KdzTrHD9sfIu3CQ3L1Ro5jQvORlx1fIP/ivfoI99f7Drx494vj3U6kZmkEUgVpBjyUPPZsNPpaqYgovIpgS5BVBC01kCnqROEE1R1A2jptsndGpHWWQFU46y4X3PwkGPlBW8HiTe0bUu8TEl1RXgwe8wmaM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by DU0PR08MB7739.eurprd08.prod.outlook.com
 (2603:10a6:10:3bd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 17:54:13 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:54:13 +0000
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
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: [PATCH v3 09/10] drm/panthor: Add Mali v15 hardware support
Date: Wed, 18 Nov 2026 17:53:25 +0000
Message-ID: <20261118175332.519657-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118175332.519657-1-karunika.choo@arm.com>
References: <20261118175332.519657-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|DU0PR08MB7739:EE_|AMS1EPF0000009C:EE_|GV1PR08MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 127a99e6-e0c8-49c8-ee9d-08df459d0882
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|261022105027099003|261022075727099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: 3vwRphnVtOsFVGrDhVXmGrQQwAi8n+3L+fqZEIJprN4ZYi5zcXjIQ9/M1o5gt3gyXxKFrrSVGTxQqrVi8iXsEyL/y4G/bISRvSFbxGekuZZq4pZ/3+48fB8FjiChMzgXpz8d/k/mWQIKSUV1KmMuyZjYChZTMrIN3f2xZoG2qoPbt3rlHBzz1pgpf0/PZQZDiFY5YxIP5guV3pD5Y8ZdfCYbOZowEOyo9UFEAD7RivSKzEIJZqWidSUlOD08/y192rAg525F4gdJJgZfWcfMykDtW+Icv3XpgW0jP/kPyXnEtitkNNYT2U4rrya1XtwTYR+SykTlcqeIWM5nx77MJAU/389Elfv3cihj4QEv7f4M67VU8EVF9IJgKQOJJUG/hP1mG1Tp2sD2u1exSlOWvdfnVQdCjcGS7VIfOxOCDhKy5w+2zXmfhbXS9m8kxEmk8GS7dxW5j5pM0GwPiLYD1KLMC3O0Br62M4H/tEjy3KclCmQeWVddiFMIIeHd9ShbEdXDcFCC1bLl6T8WgP+wTnCvGV8d1qZYhj9x7B3za8WfYAwFmpikPixwRgvbKu5CbzMpXMEJg2XKrcnkr3VMO/kWVN2++JDVryOsXKKu0YHAz89f4hFhVGsHV9a6/YG1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261022105027099003)(261022075727099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UzsDrZFi1qKon+BHVPPVkE2DHu9KLT5DXog2N/EaYjHJejD+r+tJDCQReZPzXM9OJfmoAhgfqfEC5VPkBpk2ianMaGw5LKmwXF1u+bXl7qMgfUX/WeayI2sUo0FV3JZqyJ+4laQxbqZW/t79svdXOzpZIOnC2b7LHwt7J8y/0YyiSVsE5ERgcr1FAuXrPty9EbbncOdYQkqkU9sIJj9IM68MDdpEyEeh/etS7+J7pRhDjUz/NidsujkRjqlAso3E5gmgUknnUrwDkQ4iDdHVAEQScnveCP5+4u4Z2wQNBvmmK6NE94OBmlSAIBCAVke7qc9owQd7trIAHI1MZtxtAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7739
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 89b3b712-5f31-4b43-c4b1-08df459cf494
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|36860700016|82310400026|23010399003|7416014|376014|35042699022|6133799003|22082099003|261009223027099003|18002099003|3023799007|13003099007|11063799006|56012099006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261022113327099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: N+Q/GfoB/tkuxAyzwxiKM/iAQoMHfDpmycW9Gp47gtUcQYoqC1AtMM+cDdLLCc2Gl49fhZR3oZOJpIUMuie+uI0Wltc7IMHiLyUywnuPOxcVzKGGmpElfZaO3JUhg2wVlqqNaA/LBuQLkSsvgQs7u33ODtlrGzhN2LrM/R0yWUkptlHf8igYTMn4pX87mjBdq9A7tM4+iv+gvqHUNjSd9e9p6M4HuYSantFOM+ufPWJODLTJnkYAHCthGWIrugwJjv3iSb8uYPnqikUqmA1JTOqEmdJOFe11WKh8qO4PvuPC8jAXxgdU/7ipVqFBo0U+nAlhhg7VAWwlbwILJn/S+YNI2bwdChTJ2k9Owf8GGI8wxKFhZ6C3HkrrnzIMeDzlWA5p5/TVc+ki2LyWVnzvD2CMCxFs56yVTil2Z5Vzw1U7hStBqpwPEf7dMJa/9Q6f5vxPk+HpZ6vuDuVaQ68OfbBoTNIGfJ5ootpxYvVDTOfSTjNgKVTbeeI21S8sF6A3fmPJi3jNmBF/GDprYC/E1YNCCyNcmqqlyXgUsSvB3bbleBVz83vJBInS2LLinDcMMv5R4KhoA6w5qwWGDtRHsFEc/Nd7TZKfon1NnUvVCxW+h73jKnkI19+MpezDLTBMB+0weYsaZ9+99jsPCigmmg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(35042699022)(6133799003)(22082099003)(261009223027099003)(18002099003)(3023799007)(13003099007)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022113327099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h9hqrthO+3AFlNfL4snrIfI10+mhRU8uhgAz0vUhGCZSQ6+a2xSxCvzQ99+X4UbJWnqwXTMqQUatDV3Mq8Eml0IydTlospX0ZZ/esrPbrynDJsFzVmCzCJ1HQXJ2UZ83vOhP3A9pBnLxWP17eLOyyb+9LoYntPT+P432N5swhcDY4CQ+D/knYShPgvYIIsKlCE0ogzs+5corkRCYbnxobjHMwKzdICgqwDs/ZWyni+Ierp35vTNYjckcRqstd8GTcVWPj5YbrDZt1oTnlcEUb1qFJyBMgZT+rvry0oJ69MJgE1ecTLaHsEDFBAD/KRZ3y0recODK6Lr88U1/IWh0AUUUOdtQv/p/wfL4/imozk2NIayWF1j9YGPa6xEzwWLNtMFdfpMbQjWDkmJeyhI08XPi8KKI89MZUgMf9E2+PkI5EbJsJ8VkANa9CorG5aAd
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:54:46.3911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127a99e6-e0c8-49c8-ee9d-08df459d0882
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7876
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

Add the panthor hardware description for Mali v15 GPUs and hook it into
device matching.

This includes the v15 register map and product identification needed to
populate the GPU information exposed by the driver and its uAPI.

Add compatibility string for v15 GPUs and bump drm minor to 10.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- check as_count is non-zero before generating as_present mask per
  sashiko's comment.
- Link: https://lore.kernel.org/all/20260922205812.C473B1F000FF@smtp.kernel.org/
- clean up l2_features value assignment.
- removed duplicated GPU_FEATURES macro definitions
- Picked up R-b from Liviu
v1:
- make COHERENCY_FEATURES register read use cached gpu_info values.
- Added Mali-G2 name variants and NX aware model identification.
- fix premature reading of l2_features gpu_info field during
  panthor_hw_info_init().
- build as_present using GENMASK.

 drivers/gpu/drm/panthor/panthor_drv.c         |  5 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         |  3 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   | 23 +++++
 drivers/gpu/drm/panthor/panthor_heap.c        |  3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 96 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_hw.h          | 13 +++
 include/uapi/drm/panthor_drm.h                | 10 +-
 8 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef42..e9b71ff5ee53f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1785,6 +1785,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
+ *          and gpu_id_wide to drm_panthor_gpu_info
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1798,7 +1800,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
@@ -1881,6 +1883,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 679ea1d233d53..1449d9a66302e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1563,3 +1563,4 @@ MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
 MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
+MODULE_FIRMWARE("arm/mali/arch15.8/mali_csffw.bin");
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index ab54119314da0..2e1b00e86cdea 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -503,8 +503,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+	if ((ptdev->gpu_info.coherency_features & GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
 	}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
index 6896c263f76b6..05e90950ec6ad 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -16,4 +16,27 @@
 #define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
 #define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
 
+#define DISCOVER_REVIDR					0x8
+#define DISCOVER_GPU_FEATURES				0x20
+#define   GPU_FEATURES_VARIABLE_RATE_SHADING		BIT(0)
+#define   GPU_FEATURES_SIMD_STATE			BIT(1)
+#define   GPU_FEATURES_CROSS_STREAM_SYNC		BIT(3)
+#define   GPU_FEATURES_LD_LEA_TENSOR_INSTRUCTIONS	BIT(6)
+#define DISCOVER_MCU_FEATURES				0x40
+#define DISCOVER_PRFCNT_FEATURES			0x50
+#define   PRFCNT_FEATURES_COUNTER_BLOCK_SIZE(x)		(((x) & GENMASK(7, 0)) << 8)
+#define DISCOVER_DOORBELL_FEATURES			0x60
+#define DISCOVER_MEM_FEATURES				0x100
+#define DISCOVER_MMU_FEATURES				0x108
+#define   MMU_FEATURES_AS_COUNT(x)			(((x) & GENMASK(23, 16)) >> 16)
+#define DISCOVER_AMBA_FEATURES				0x120
+
+#define DISCOVER_L2_FEATURES				0x128
+#define DISCOVER_TILER_FEATURES				0x200
+#define DISCOVER_CORE_FEATURES				0x300
+#define DISCOVER_THREAD_FEATURES			0x320
+#define DISCOVER_THREAD_MAX_THREADS			0x330
+#define DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY		0x334
+#define DISCOVER_TEXTURE_FEATURES			0x360
+
 #endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e91..afb7d68abc874 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -11,6 +11,7 @@
 #include "panthor_gem.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
+#include "panthor_hw.h"
 #include "panthor_mmu.h"
 
 /*
@@ -105,7 +106,7 @@ struct panthor_heap_pool {
 
 static int panthor_heap_ctx_stride(struct panthor_device *ptdev)
 {
-	u32 l2_features = ptdev->gpu_info.l2_features;
+	u64 l2_features = panthor_hw_get_l2_features(ptdev);
 	u32 gpu_cache_line_size = GPU_L2_FEATURES_LINE_SIZE(l2_features);
 
 	return ALIGN(HEAP_CONTEXT_SIZE, gpu_cache_line_size);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 6a8645bda1e7d..fc81fabbe62fd 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
 #include <linux/wordpart.h>
@@ -75,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 	},
 };
 
+static struct panthor_hw panthor_hw_arch_v15 = {
+	.ops = {
+		.soft_reset = panthor_pwr_reset_soft,
+		.l2_power_off = panthor_pwr_l2_power_off,
+		.l2_power_on = panthor_pwr_l2_power_on,
+	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x3000,
+		},
+		.mcu_control = {
+			.offset = 0x3100,
+		},
+		.pwr_control = {
+			.offset = 0x3800,
+		},
+		.mmu_as_control = {
+			.offset = 0x2800,
+			.stride = 0x80,
+		},
+	},
+};
+
 static struct panthor_hw_entry panthor_hw_match[] = {
 	{
 		.arch_min = 10,
@@ -86,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
 		.arch_max = 14,
 		.hwdev = &panthor_hw_arch_v14,
 	},
+	{
+		.arch_min = 15,
+		.arch_max = 15,
+		.hwdev = &panthor_hw_arch_v15,
+	}
 };
 
 static int panthor_hw_set_power_tracing(struct device *dev, void *data)
@@ -153,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 						gpu_id->prod_major);
 	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
 					 GPU_FEATURES_RAY_INTERSECTION);
+	const bool neural_present = !!(ptdev->gpu_info.gpu_features &
+				       GPU_FEATURES_NX);
 	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
 
+
 	switch (product_id) {
 	case GPU_PROD_ID_MAKE(10, 2):
 		return "Mali-G710";
@@ -197,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 		return "Mali-G1-Premium";
 	case GPU_PROD_ID_MAKE(14, 3):
 		return "Mali-G1-Pro";
+	case GPU_PROD_ID_MAKE(15, 0):
+		return "Mali-G2-Ultra-NX";
+	case GPU_PROD_ID_MAKE(15, 1):
+		if (neural_present)
+			return "Mali-G2-Premium-NX";
+
+		return "Mali-G2-Premium";
+	case GPU_PROD_ID_MAKE(15, 3):
+		if (neural_present)
+			return "Mali-G2-Pro-NX";
+
+		return "Mali-G2-Pro";
 	}
 
 	return "(Unknown Mali GPU)";
@@ -220,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -261,12 +305,57 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
 		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
+}
+
+static void panthor_gpu_info_v15_init(struct panthor_device *ptdev)
+{
+	void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
+	u64 texture_features;
+	u32 as_count;
+
+	ptdev->gpu_info.gpu_rev_wide = gpu_read64(ptdev->iomem, DISCOVER_REVIDR);
+	ptdev->gpu_info.l2_features_wide = gpu_read64(ptdev->iomem, DISCOVER_L2_FEATURES);
+
+	texture_features = gpu_read64(ptdev->iomem, DISCOVER_TEXTURE_FEATURES);
+	ptdev->gpu_info.texture_features[0] = lower_32_bits(texture_features);
+	ptdev->gpu_info.texture_features[1] = upper_32_bits(texture_features);
+
+	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, DISCOVER_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, DISCOVER_THREAD_MAX_THREADS);
+	ptdev->gpu_info.thread_num_active_granularity =
+		gpu_read(ptdev->iomem, DISCOVER_THREAD_NUM_ACTIVE_GRANULARITY);
+
+	/* The upper 32-bits of following registers do not contain any information (yet) */
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, DISCOVER_GPU_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, DISCOVER_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, DISCOVER_MMU_FEATURES);
+	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, DISCOVER_AMBA_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, DISCOVER_TILER_FEATURES);
+	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, DISCOVER_CORE_FEATURES);
+
+	/* AS_PRESENT register removed on v15+ create virtual mask from MMU_FEATURES.AS_COUNT */
+	as_count = MMU_FEATURES_AS_COUNT(ptdev->gpu_info.mmu_features);
+	if (as_count)
+		ptdev->gpu_info.as_present = GENMASK(as_count - 1, 0);
+
+	ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
+	ptdev->gpu_info.tiler_present = gpu_read64(pwr_iomem, PWR_TILER_PRESENT);
+	ptdev->gpu_info.shader_present = gpu_read64(pwr_iomem, PWR_SHADER_PRESENT);
+}
+
+static int panthor_gpu_info_init(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		panthor_gpu_info_v15_init(ptdev);
+	else
+		panthor_gpu_info_v10_init(ptdev);
 
 	return overload_shader_present(ptdev);
 }
 
 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
+	u64 l2_features;
 	u32 prod_id, major, minor, status;
 	int ret;
 
@@ -288,13 +377,14 @@ static int panthor_hw_info_init(struct panthor_device *ptdev)
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;
+	l2_features = panthor_hw_get_l2_features(ptdev);
 
 	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
 		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 4cb603a3acef6..fe31c1088af5a 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -95,4 +95,17 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
+static inline bool panthor_hw_has_gpu_discover(struct panthor_device *ptdev)
+{
+	return ptdev->gpu_id.arch_major >= 15;
+}
+
+static inline u64 panthor_hw_get_l2_features(struct panthor_device *ptdev)
+{
+	if (panthor_hw_has_gpu_discover(ptdev))
+		return ptdev->gpu_info.l2_features_wide;
+
+	return ptdev->gpu_info.l2_features;
+}
+
 #endif /* __PANTHOR_HW_H__ */
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 09b7f7931e4f4..da9f8f82413cf 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -371,8 +371,8 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
@@ -389,6 +389,12 @@ struct drm_panthor_gpu_info {
 #define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
 #define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
+
+	/** @gpu_rev_wide: 64-bit GPU revision for v15 onwards */
+	__u64 gpu_rev_wide;
+
+	/** @l2_features_wide: 64-bit L2_FEATURES for v15 onwards */
+	__u64 l2_features_wide;
 };
 
 /**
-- 
2.43.0

