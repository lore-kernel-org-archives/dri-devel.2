Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ByfZUj0k;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ByfZUj0k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF4310F79D;
	Tue, 10 Nov 2026 15:40:52 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DC810F799
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:38 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gxkk97iwYBRt2/6you4uYlBI9fQ6P+P9OvgBPsDKQPYy6orb98Qib1r+knmZXDUDFpaUTz0VxVHrqkcCmYnmG5svmJ0geExuFp+V0axXjf2R6eFl99vJJtOIXYNnJn8ZrODRr1IW2WvreWxK07wQ7aZPGp4HCR64GQHKo7Fg6tQhQK5eShckDGFpYiDffsqR88jLPB6GASKAkQuX4/SojIXklFLfEG350TTOTLkqz2eWrc9DKXoJYGnhfc+t9fFYqa6Ri1LawYR746A8La7NdJBOiM8cO1RsylFOpooV6tUSu4QoEQkx3O/U5zpt85j7k3tx+4fXhZWz05Il0PEkag==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=s+OrN+AeDixPgYHb/3XNffeclQAY/1XsGe5b7HOuKsnSsaNf+D3LzBl2UCTUlls21mfgKmiF1koZGl+CXN25OaGY5k2NWrJqBI5Y2elvF6NCDE95IdRqq2uE2i23Ry5L527UG03MGjRn3Pv/E9+FgnP65WQqnpKVRc6djA+YKdSVLHfEjOG/Y/u7EYagBw3+LauUBE4J+5YG+Ro/1nKjhUzFo9N6QIPAGKRxRxSFoflEJFZexH8Xe08oLrmLdzakRgCv3kEXIRMOuTKEBJxSXEVmtSfth25C3wrbLR/D+gO5fxwVANvYkHx0GvFOlMq/thq8PAq0cD6/hGno3tJ+jw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=ByfZUj0kzdUeN0py+xtkZPQVf0UF5qngiiuL6cQhXX8xWdqIYp3/w0tjsj5Ph/hpfxR4PhVNdRWfmEoZIhRgUAdt1CDLloOhGabkSko7g7ARt6lQvnJsiBDisoZ4w/KTrIdY8+Qx3svRegovhR+MrBdihn+bRArqDwHGcYxg6U4=
Received: from DU6P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::26)
 by AMBPR08MB743383.eurprd08.prod.outlook.com (2603:10a6:20b:78a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:32 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::6a) by DU6P191CA0021.outlook.office365.com
 (2603:10a6:10:540::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUZQf1g6094K0ngprFtMik3qmYnBmVQo/Vn9qNaP3UCJnQJ2EuUx0cK4jzq7jru5sD66kLtP0tRxbMfGpgOfnsG6vXwyqx1c/6hfPl2tr1j7wG1nsx9zeKqkCp4S7VrapqVWZPpheqCCJz7LklErarrkKhdJ1Y9a71s0SAcJpDQRY6bBOAmKJkqAk57O3kC+2vs/D9ZWCrQagdvb6WHbtCFUVTKkZ14+kev70SSkJBQv+D+8rI8Bo24Tm3RN7zT9/Y3M9x8fr1qXgmuTylNzqlhBqMtfXoVLJyUn9kaNH7Pn3YWmIj85oF156/1rPSH9V3i1h+tKmxKgbHci/h0GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=SHE3cWjnfY3TECDpUfkDqRLWqd7NDZZsa/BAwbj++fPoNtlC8zTxCrZMs+fViJfRc0eNERu7QbHBC5b3EmOL2kHw0kkmBvz65CYXL6jE6zgCcg3O5IPnBf5midBwdW+JwaqscrC2UTp97M+Ge4BpBdXT1ZPgbFlGlEUC4cz6a4DD/xdTzpdmqrWbXkJ6QdQMe7+H+7R4aIu37DdzSigbAvLnIpA6KdABDhFAu3abdb09NO2xda8kAHzdTyt28Pv5zjV8gmGPpLaMUlPR7IxnoZFGuyfTRlhxjRyQhgJYtIWl5Z0JDcuphYe543P0/YFQ+RFRkNTnxsaSq2EFp7R/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tg9PE6Aa3QYsEWcwPfsPHq/U5giL3/2oE8Fkz7rGI3Y=;
 b=ByfZUj0kzdUeN0py+xtkZPQVf0UF5qngiiuL6cQhXX8xWdqIYp3/w0tjsj5Ph/hpfxR4PhVNdRWfmEoZIhRgUAdt1CDLloOhGabkSko7g7ARt6lQvnJsiBDisoZ4w/KTrIdY8+Qx3svRegovhR+MrBdihn+bRArqDwHGcYxg6U4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS1PR08MB235221.eurprd08.prod.outlook.com
 (2603:10a6:20b:6d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:39:59 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:39:59 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 04/28] drm/panthor: Parse and store GPU_ID fields
Date: Tue, 10 Nov 2026 15:38:25 +0000
Message-ID: <20261110153907.3241978-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS1PR08MB235221:EE_|DU2PEPF00028D02:EE_|AMBPR08MB743383:EE_
X-MS-Office365-Filtering-Correlation-Id: d06c5e30-27c5-4d3d-985d-08df3f40f4a5
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: mDASe61EB2fokU//FkNXWXt2kpZ+FQvPQ+8NWaUiJQaM73zKjXP6Upsdx+8izlJh/nIeR7gWkukk30NW3hLGNbTPtZ8hM3KtWFQ5v4jWdi3XTpYpENn1py4o4oG/zwTM+GaN+/Kp6FAyPhRBIY5PZnuXxHCPCaAz6QklE5ed6CL0+AuDMzTQ/4F+avK+MoZjriGCYMeVUqFcpmQZmikW8C15rD69Ywtx8TkouURMLrgwCPW2K7w+e9PCPIccHodZ2dwXCeeOvyZPmr/fKywhb2OVZSdyXsvXmBmf7lx09YnD85rCdlvWtjEwBb2vxzi465ukB/+cqG3a7uxXEuL98eLxN3UgdHPLdUodrXZ1DVdLY6JmaW08ezhAqkPfHGIW6Lv/15AqpB3bQLTpXaNW9cVuWNjTNKAopxJJay0MM2UBiKKlkJDobk+2Io3EZyK44HWNB1qFQeAYUXqn0h7kUelRorEpO5aIoWl47lL5fhMDZiIS1Paroj0Cyxpc6e01tw+wRzp9BuBBBlKpZPQkNmv+smmQwqu6AE0lEO/meq+s3B00fL4LlRZiJ8OCJJrNGhnEFmu0HCQOf0LrU/eaiexBp1gZnCRuKHSVYYMncLs3LamHbPghJL3ceGSfN/+p
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JXbppjq+fCMjN/fBbp5C0QQv5qIDLjm74l+yRCQ3gZ7oOXdPs2FaOJXYtWWf1is7WSp16x+XCZDfpgC1edgZq9eILRR4I1ZNXH2OQMaP7bLFQVeuyY3H/Nb8EIKPFssu55BWuNpm5riov6Cq526CKKphQSY93x5JTr/TWURI0xr6nme7nL2yFwg7e5pT7yi7WrTrSKayhc5JcsSIHqTi5DSk8+GASqFrdNILJECQXpzd25PEs+qsH6tVL/uBJl8ckZlcSfxYdObkZ6X4G/dsndjSxZMhTth171+jVA1q9lmWaRA+0BtXdygIAikpTyotvCQ29g4JbMM2vT8jOBnDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB235221
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3983cde2-b3c0-4420-4081-08df3f40e0d3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|14060799003|35042699022|1800799024|18002099003|22082099003|6133799003|10067099003|13003099007|11063799006|261009223027099003|261022075727099003|261021123027099003|261021121427099003|56012099006|261102123227099003;
X-Microsoft-Antispam-Message-Info: cdWHUXIIMhKhcA67V6Wp4TzlC4iJycSfnPy1SwydJNlG/qIBfmLxSSTP5dSxo1YEMezW1wST61+oopxLSR04RFfLPg5wH5mQfIv25bidmJlaZkTuY7ZU/z+R/ZA4iKsX9yoU/jM2uFnvOhYG9qgNEU5C8zU4o79noI59rSkh3BLQP2yFmtN6P5v4ooDyvu6xLVVo0NWFI0tkOKE4UCMRayyxvROVmWR0/DE6TXN+hDdk+vZ6ALEY6dv+03PYmKY26qE6tjemzCIV4SXleD+2Jhz+PuKetwp3VCECYkdHZ7uMSZsgkz85j5x7cXEvgmcN4gAaGzvFw6rKXCYYlFIjo0xJ2BMhU4yY0AfqyfDm3xfqxBVSYP2UUnckH5CmPPrIbOBPAPb16ptNjowlCtY3FAxK7hRtU1Pke3zzPBh9TgoEYEvY7rNVEzApXxsPa4Oz8kBmbiBrrNTTKjDVXmJ+1P6NsBODVwaf+aJT3lvU4ZJ7kHc9MrjT4Hl5alCKrSZR7aGvJI6GUiKhZNjOiwI989tUz+xPkDz8Yy7sL/UOLPbS03n21LHvpv92yzAygRtECpBHHDsm9wc43EKf9bXev/9A+XT0fjA4A6fJ1j6+iDJHsxXx0Ey6TMxtPjYe8bngSnbnD9lA7mSYNoUyR4NSt1YESXnHPRdPP1wTKfhIp0o=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(14060799003)(35042699022)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(13003099007)(11063799006)(261009223027099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MhcGO+w4+1cGqyEsDHcBJLj5+saKLZtgDAWW0uekhRaDvOvr+Ayf4XLjsKRAx048x3DiCrFx1bOboKlrYOJKAYaUhpOe7hkimN6T11PtJpD2jfLx5kI5Chns6LNpm024Y7pLpVLCGpYHKUX4SxXMXSXwp4PgANN97UEE3LN7pIKO3zrhysvF6tVMZSMh/OTsLdQhre+qLC2zFULNm8g2IZVayZx8pIWo6degXUGM2SfKsZGSgWD2WtX0HlFz0w5eFgTl2SSAsogh0JyQMeuZwfFgEIDy+bmq697pDqT3bc91keq/xoNphH8qj6ppGg9Mkj+YNtFKNQh+etV0k86gUkY1lBVBH6h/j8eZIPcIsMV1xYGVZAs8LxnuMflf9mG7DfDrTy7Jt7L71pGEQqLwQZatWDTtGNFmHvNHmrSK3yVNZRGVEoLBtWxvE69r+dqF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:32.3766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d06c5e30-27c5-4d3d-985d-08df3f40f4a5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB743383
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
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

