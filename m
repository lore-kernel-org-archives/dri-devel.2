Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0511606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPzLYFMz;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=ZPzLYFMz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092CD10F7B2;
	Tue, 24 Nov 2026 16:21:42 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAA810F78C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:11 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=otPm/XtMHYVpivBboeoGBvqaUt68bAmp7KGtMmgrq7ZDyOp4PXlYXmBKhQiiQlxXFfMx9TC+pXlB0nLNZxhetx2az3H7IevFqB71j34UZYpOlSZcsLdI9qqaIEImpmeW4gEIBs/S+D/YiPDTWhsbD7F1vK08mQpMPZ2tl5SBxSQDDH32dM+IH/d3PxkmH47AqQMxx8R5TZQxtx1rG2zaf3GwPMNRTH94ePBD3Hgh6xYHpX22Hv3rKCwdIjDn/KkpHfo8Ic32QLV3dF2FnxTLVxKmW9ypO48iawBtayzSfcPzh6w303OH8ec9yuxA400Hrq3N20RDRc9bGQX7FetRVw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIKMq3qwZn6t+ImSAT+349MSopDnZBTi/42iC8UK9VQ=;
 b=LqlvLmn/HvQUJmyMrdmrvfMmJVbU9hhcVPYqM+dUPeoNS2EJk89plN95nl418bHDjoIPgw85M3nwlqMsK40HXA/4TAln6VvaV4S1deCj7uajlItbOqdS98wbpAkpvY/J7MrNmEGSM+CbA+qm/f9b8TR3xrIpYNPqfyIOFmMGyOkTeQ7wpgRCie7aZb1S9jKzdtBRZNc/PP6bjTwdFoKwTzQA2Z0XSeCxrq+WJPNwDiv+0vL1VYBexOouGmPKzI0/T71RVqgcMbqLKnj1V3wjao/l/f4Mwb+tswqPzitab3B7n7nLKZ6b2rycfhD7Gyi0vlk67Eg+LrEo3fJ2XLcE2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIKMq3qwZn6t+ImSAT+349MSopDnZBTi/42iC8UK9VQ=;
 b=ZPzLYFMzbwqJkn/UAPiobmjiax+RiNdE++SoILji5WD33+S0CnuI6yLyAcWMqd5kPiXCbBPw8on2VASrOJgKfA02eh1X6c6AusrdJgMCtAtKz4OD1JYOGpbMwda7Txmw4jltw+3QcBCejP94tM9l/+HMBJlJpxJyiU39Ewh+AtM=
Received: from DB9PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:10:1da::19)
 by FRZPR08MB11137.eurprd08.prod.outlook.com (2603:10a6:d10:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:51 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:10:1da:cafe::74) by DB9PR05CA0014.outlook.office365.com
 (2603:10a6:10:1da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 16:20:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:20:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/ekY4mcmbUjnxrg9kRtMl5/gFO06wl5Q2P/tesoCgkbF/p793e4stAXaJytHzcaJa/uaBHrXoQPCflpRTLLFAgEx8Obnz5EV/iZjwXTIJ5ClUUoCY1U+38yeiMIII1sM2wm4MloTSmomlmdGKy3TyrFI34cQQbNATk3Uy0JDuTkPpwAPsEeqWGilKRl508AUyIPpUgqEXZL36m5YggilRwVbZdnHGCIvPaVP/mBfpZY2/MwDmLGC2oe+Lc4TVnEwd4XfMkInaKat5VmZJhjoKvXkK6R/sjEco+JJRB6WgcuqczILqTjepxtIh/Bhy4vuAaDslTAtP3Y1QlaZU5HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIKMq3qwZn6t+ImSAT+349MSopDnZBTi/42iC8UK9VQ=;
 b=JxHDSjzFH9mgu061h4D/3jo5SO0k5voRh3Q8nVuK3TgFekXnPG/Na05JZTgf7X6gQ/UYG1hpilgyl1923LoJy4WxCakuCqm9IKiYTqzwLgDPblxZnRnDOwIXj2K8e5LqcqCniZHAg2dQLrSE1jXKOBpmDW+uO+hummoSOzpKRxhLU++nXWnDZBakKwpmPl0d0UcPAIRzVSjjISiIWixekFGDyYFALRKa3EQKZi4lZqfMN7+pdNEd1IGhuTydNt56CotY0kAbJfZANSOViMrR/93O/c+0Iy6p6/8AyRJAq8CVropU8vCdQH6SfbsDuEg99FG/C3ZrC8Q3Sn5qJRnGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIKMq3qwZn6t+ImSAT+349MSopDnZBTi/42iC8UK9VQ=;
 b=ZPzLYFMzbwqJkn/UAPiobmjiax+RiNdE++SoILji5WD33+S0CnuI6yLyAcWMqd5kPiXCbBPw8on2VASrOJgKfA02eh1X6c6AusrdJgMCtAtKz4OD1JYOGpbMwda7Txmw4jltw+3QcBCejP94tM9l/+HMBJlJpxJyiU39Ewh+AtM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by VI3PR08MB938182.eurprd08.prod.outlook.com (2603:10a6:800:374::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:08 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:07 +0000
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
Subject: [PATCH v5 2/9] drm/panthor: Rename neural accelerator feature macro
 to NX
Date: Tue, 24 Nov 2026 16:19:40 +0000
Message-ID: <20261124161952.1053586-3-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|VI3PR08MB938182:EE_|MAD0EPF000008A9:EE_|FRZPR08MB11137:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e6f5c2-302a-4e11-cd7a-08df4a46e62c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|22082099003|11063799006|56012099006|261021121427099003|261102123227099003|261021123027099003|261022075727099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: mRPEeni9+ZpOhx7bM1KXQyiI6iXqNNViT+PzxvXfcUDhbEp1OnbhFPm1K6cfoaFxzMLUl5gjZqV59Di8TBU0l/rf8oteA2BmZHgQFDZMyZbzEVkQqtn4xX/fS8hIaD7U8GPnhQ7hCf3uJiC3Dfj1mFUNetKmg4q4LPAPexgaBoyLs523Ppdoo6bX+Ia486y4CAGAQ7VeVyL5rOQJBZU9ElIfzj49ECp0+dFoilCW7EPgMZgcjcQtlQuWdsLIhCDOGX6dESNO0e8foZApsgGTKONyAjO50B8SpabE9QSW5yUBaU3M2PxsZ90KpM7XFtzhe516xZp2dS9rtx1RCbJD+oNa7l924V2CtUIjqKSQQ+TU84/b8AFduDM2Abyg5TCnTDdqI0bf33xtbqu3/F0voIy+2JZiQ9Tb5H4VCS64M/PWRbn0Lr3+W5iNI8bkn8s+wRa0B7Gody3aj0/ilvurmPtRZkFmjMQPPWEN7Ce2nAcwOFdXtXXOQa9M8cDOy/I4lo0DVS/EZMDlGlgQ9tN2nRjMHjvL0puEfhNo4PLLQwSENwTWJ7f/JGbl46iDSZ5Doc35/MxEKnHEFH/vOUgypWiSdNHR+uTbUYZbAHphbRGlnMyLXQ1FnqxCqJoWdbx0lQkiDIh9zZ8Hm1lzMEkIreq6G8jF/SN0s35SlCMlJuU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261021123027099003)(261022075727099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oBO7GzWB/q7dF5UzKiCWuPDNQY5eTYIMoUIBXWffVJBJkdrw3F+G1dcM6NYsPNo6ngxuTXlrJ3oBfxm2pej+NCuEAiPFeFsjSimT0A3h5mKCkDufyeEtg8zfGSlF/TmvFEYn+CY6NeqkDDaMiw4RJQ945FBn3QPfZb/FiVN0mJMV/zr3icJ+kPafPZkwAa1GaXfKohl7kpVsxSCjQEXl5/G4asvcHqzhnSCmacfPCiU6Dni0cgM1de9HiIH1sQhgLvPEyJENvSC27ZBgsn3BPm1nmADR15+ARUk52LjuHS4mK2u+3c+pixs4Xxkjcf+VJGn5Zwv1+37fr1ybYD73EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB938182
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 98e219c4-2e2b-428a-9cdb-08df4a46ce37
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|36860700016|82310400026|1800799024|376014|35042699022|18002099003|261009223027099003|22082099003|261102123227099003|11063799006|56012099006|10067099003|261022075727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: pH6defu9XoD6xugtvklBn+eEIsg6coAD5bVCHSGNQqNGu4WkYl4gkc7JJUGlBuHnJ5UnhyBsDW5ix8MT6YWF/ONHaJFExoEbIAzvQKmk/uqJDQZTpXrFPtX36fUA6ZSxFidnya3PPskWY+j5MMqDoFy1tObWGxGKKy7EbLJX08IN8dJrmSnel5XpGeUNSivcinz91xWoCawu6QGZuyFRRQMfh/o4CGCPb4ziEcB/PNL9A9ifcHF6pLRYqMIf5C/1YG+g7tCpCXvtsCZokN6Uqa8HVAjXOc9HM57dPGDdazxOoZsMZInPi0eqdmKdQve6PTPz22lez2kOPpIILEQqfF/nUpKwzmqok/pYftrJK5uMtATCwOUN7jDgHc/COU2GbAh7+wQVrLyYHEsATDEhFVXTColjaZ+PBJ7DicYWAv76XAwgcearOBAxGElvR7pww6Nf8bQfu71lYsziocHVIZzKO59HzpP010+2pOlYmWmxfd708DFy7KnrUdg2/yIhHQq6JWG6bCigY/iXwfT9A0yjQ0vnfcUVU4pajTui0cPNnubWYEu8O5i7UBIxqWJf/c2ObO2gKwl5nbwiVqwDhj2m+nWyWN6eUx7jLB+zthrCzD6tTSq5qkuOc9yTAg/wzL5hA2hPb90HsveuX7UhXD+y51OovtExZ0wcSgttq6QRluRs7iPJAIVrr+mL5wCderohxp9a1J3bNtSGnVgn4Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(35042699022)(18002099003)(261009223027099003)(22082099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261022075727099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPbWBb6ZRkKiW1GvnOek2X/G7ClCTK4VVQKniOqPSF49qujmywa0mCQpek99xSf0s+ypbBNhWKGH7ahPKfWlfkZLHh7tC+nm8Td0GC/kVWYvMqcuCSgu1SbdiEovw5/RkjPISAvxYEaD7tfTB0M1zM17r/stmu6LOMA4FxwP5MhIrXPsVrQIMn7ftmx8q96X4fcVLgzx0BXTq5aAOqHo5Vm1qxm5PWSsw2jrsm6oCPuad90s/C6uMm6aUCSk3V7/jgnx6wZYYyljuXj/xNyMPbQoUfmSPN00HWeYNaZo8/Fv+npWVR5tF8pNQHwtdnAYSf3UitgOTn8R2lRz8yaVldhWai07mPrBV4nIzY8ZpmSpW5KOOFVtTTcFwar2TZbO6qjtp7G3auh/kGjQ5Fnt8LgkKtPljAKMqpi9Ho3QCrj9ZCaURRtXltI/drdhrJZG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:47.7925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e6f5c2-302a-4e11-cd7a-08df4a46e62c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11137
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

Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
Update the panthor_hw helper to use the new name.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v4:
- Collect R-bs from Liviu and Boris

 drivers/gpu/drm/panthor/panthor_gpu_regs.h | 2 +-
 drivers/gpu/drm/panthor/panthor_hw.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 5340966caef37..c7581b6d4c5be 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -67,7 +67,7 @@
 
 #define GPU_FEATURES					0x60
 #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
-#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
+#define   GPU_FEATURES_NX				BIT(4)
 #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
 
 #define GPU_TIMESTAMP_OFFSET				0x88
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index eeca936f44bae..f770dc40e6216 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -64,7 +64,7 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
 static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 {
 	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
-		ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
+		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

