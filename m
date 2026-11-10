Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1251606AB5B
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=RNdhkX7M;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=RNdhkX7M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C8610F7BC;
	Tue, 10 Nov 2026 15:41:53 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B361110F7B8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:41 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S/vAA7KOJR6ziOkLAtwuAD7UOfYloYUzhfbC3k5zLWpNTvxFvE82Fjx1RbU5l8+Of5acUKzm+H27Vtjc+ctBpNhmR1Q7cBDDDbshUFvEQFd8pNNdk3tMKE0hXvyx+0ezcNqKxbeyklu48kG10brgvJ5jTurkNJMlyFFcyr/vGkSttzcJ3wJqOIZJjjKrZUL+A7+DwzWAYXnCZt8tXkbwzGlO5cdrDfuv5Zpwkest6AckcsfTy3Jsk9N2LUgQhQJoNUIiJP888Qn6zIzaA9TINBF4hyNhEPqw3u+V0wf8rJdfor1yUHWVytbAPTv66lf/kKCEauGucDTAwQqlY/YwEw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6pUOlOTbIgDQ/559PPChsI2tyHKAza9b2JiWLG0vyE=;
 b=Az6l510yKTFYhhCIdLIL0g7aXAoPjKMcLhaZfanxEHMw5+uu8ZyKNYU4KCiZgstMe+V7Ltr55TGPG3GSgGCJeup26QfW7B394cGVhRixsxwPsMuYY6e91o/fH4ZXPa7mmz79ylIlJ+OOgNoEFwOhwDceHTyf0qsuqYFAA1wAvslVNOZD1Z1YGiOzllDYHvcbeny2tC6nL+fEWh44MyQH3fg80gI/G9fXoILGxsGeazSg1prMkZ1VwCYmSnia2JkNbeidGR9dbwnvNr07WAFtFXVgrD+L/I64vN3cmAuCjkLhT867PyMabYSWz4ce071312wzpH0o3mNRqX43Hr2Ttg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6pUOlOTbIgDQ/559PPChsI2tyHKAza9b2JiWLG0vyE=;
 b=RNdhkX7MOAASRywzcvdZ4KtmR70fe5+ygF4OoKdn9m4PWXdS4oswjWmyM5ng2uQmpUiW/C9V2mYEUv+96C0XQHSQMdtxh6qlpPbK0+OC/4jJ9zZozA1oCenXoCGR6dGjz38gdHtTVtMZTiaTbkYpFre9jPrDtG0kB1GQza0cvHY=
Received: from PA7P264CA0255.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::11)
 by VE1PR08MB5776.eurprd08.prod.outlook.com (2603:10a6:800:1ac::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:35 +0000
Received: from MI3PEPF00008556.eurprd05.prod.outlook.com
 (2603:10a6:102:371:cafe::a0) by PA7P264CA0255.outlook.office365.com
 (2603:10a6:102:371::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 15:41:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008556.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeW9JsxIvgkilChv5cZblgECzvTv3jrxtBCpRY608t2Yx8pAkVHjiNHWHPv91WkhIRNOPXiihK4h5dNz2P+jIWDvF9A9cgcV/hyxExNVz/d/UOsvQFkSXE2/71CyMNB3K505FNq963E8rkaf/yOj8k78t9N05/bxmpl9o3o9EVbijkeSeom2nGnzucjTexK03ftu9NDGOSTnbLNyjZiwuQpP/XSlQMnB8G2+QJMBjjuCWSEUgkWCSnrfcqLLuEwbekSxGDKVpdVFhPYgx6mQEgxOUGAkI3AwOKdl/l5x8klMYdECJ1qi+AQCBHbNJ4bqfFrSanY5grgC1UgTckO95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6pUOlOTbIgDQ/559PPChsI2tyHKAza9b2JiWLG0vyE=;
 b=wH/op9dDZSlaUISAnBOA30nJzHW2c3bqBRuk8evUwGkGHP00HhP4ImOLJ9K0ohoDJhgcacgbNpcy9tulUBrrjpv2Nssgi9+AMvyESsweo1yCzZEH083YuSWi8CoJkjs3aZepu0m7mnQctWiudiU595uTJ+xKbxMlnfhpoSgrrEMVSqs3TO1oL6p8TBV1U1gwl80u64JNsS6iAcMTKvuoRRO+XYTaML93eSm8/75uxZfgxguQduFy2AluTSgmcwMJBLv1131C/CKvdNXE/wGCfcstvQA2REBUcgh2q+T0YcI5/uaCCy/yPQV6vpFAuXEjy/GW/1mHVq6QH+JQP567sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6pUOlOTbIgDQ/559PPChsI2tyHKAza9b2JiWLG0vyE=;
 b=RNdhkX7MOAASRywzcvdZ4KtmR70fe5+ygF4OoKdn9m4PWXdS4oswjWmyM5ng2uQmpUiW/C9V2mYEUv+96C0XQHSQMdtxh6qlpPbK0+OC/4jJ9zZozA1oCenXoCGR6dGjz38gdHtTVtMZTiaTbkYpFre9jPrDtG0kB1GQza0cvHY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:01 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:01 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 17/28] drm/panthor: Add arbitration scheduler
Date: Tue, 10 Nov 2026 15:38:38 +0000
Message-ID: <20261110153907.3241978-18-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MI3PEPF00008556:EE_|VE1PR08MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: ea293455-1ffe-4064-6258-08df3f411945
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|3023799007|261021135927099003|11063799006|261022105027099003|5023799004|261102123227099003|261026121527099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261009221227099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 2M9YGWyLhcCf2efC8ZfugA/CknY3uhT22aSUlh2zMECaS/0D0zxL+rMH5UJBoPKQU7+AiQ7OQ6L0MoBpxYhqgCcvO7MRxaPv/vmMlM8BUd1HCBQkWBLt9nM2g/hleM+JEfY/O4A3fZ39u8WL9NyC3VkJ9r9+PF3O9QXAZY5S0gRdcOp59hLuOF82UTCA3vtRwQyPHx18gygP75+5J8gWm5SKqWat6tIOp7xBUc+a8mP4LlaGRgKEvGJpGLJ23WBnEtwU+NYjo0oMrZOPrMIvee4XOj0SeenRr088aWA0TYLPYLBPybkcRcgmVbDhwQAF1UmsGzmGkETIArH/H8GjlYRRiQp0MUHalxcUPqPHmwvLR3TRqrWHTqzhaxSzPcKbyI4V+N6gk91RE8tf4rt+BF0A1GI6qwodRj1Mb9hbti+IbNzY4WymIlLhflPOVGVqBUJgUmlvhf/G7pkdCcN/XnqZlgrAe55sIBsVVYvCrcxCouXQGCk45GfvuFgGG+GxosywYhbmp06fCBZG8NSuzc0IoUzitRGxA2sUlpqskRuBghyIL/GnN0pwdkL65ki7QtTB5P2g7Fuzq1K2D8Eu2Cm1mzrWZMQSs8b0rHUw11A=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(261021135927099003)(11063799006)(261022105027099003)(5023799004)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261009221227099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: OnuaR9/qsDxknHupkfyKstDq54xjBo/HCU/MKvTC1kZk4TAq8STqDNa7AKm670MYnpz0p+esVDW2ulAfT6SbPhIch0c5ThH3X0bgalPaGdJKXHqydoV8iDFMTmwtS7beCswZHoojBUEBu1A37ULgW7gZ6Ue72WGEh0VdfpM9fOXNPKG4M5MrnlklrWBWdpaG6pzfoK40XtezdsuB814yeasnJXdcX89peVUqZPETW+rwkx2Yj0CdanPqwAcJfFVkmZfNq/As9bj+vi/6CEpPCFvjrjjS83KLQz7fPdx1JQAK6dmvHxDmaX6kKOaO/YPTSadfRcfzhCQbgeLO4wOGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5de00a9f-6d32-418e-82dd-08df3f41059e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|14060799003|376014|1800799024|35042699022|22082099003|18002099003|6133799003|10067099003|3023799007|13003099007|5023799004|11063799006|261022075727099003|261028144727099003|261102123227099003|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261022113327099003|56012099006|261022105027099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: xM2iI4M0DuL/cmprJP8BVDYHCxX/lMhbGvIVxEed8mdnoztF3ApfjkJS3YxFAJrahEeNHD0C7LViLxVJtsnY8KnuYnAleLNHbmUD0WZ7y4luMm34qEVIhh71hn/YiM1kgSfIvPArre9rvSBbvqcOrgxTUWuhx4v70rEhHHsa4OE6X9q52eX7CeOdDlldeidYiNW4vnoIe65nyLIIMdsEMMTa/9gZNYSKNVg5bx2pQnoohM/wN2ON69jXJV+IaUqCvEwHjFaoGprOUKkAODSshu2TDDxlR9LWi6myF0NV5Hn77jqBsdRNap7CsH4RZttPqsgag5m0N1B+W3lRBcKBUZjrQTM8ucbxSM0hR+zIPfdDOOEvUY+Iqcbq6ww1OcuRNl/JRcaxLedtEo3zYvBIlechTbV/O9tQZW3Innop70owTWuBdAcqJJu3UTTrm9UcFNV41sSeAIkVGXkHRqeoHBXcqY7GOEZ2ef5eUa0jxZbJaH4CUCxj4GE5FwiXxzWE19X+xlOER8j91HyPpsjGbZdCTFLPJlC3/6KQowtASIFY7xIwWSZMhB5dXqx5d8fAFypCV/IWKDWEQ9dijq+oW8UX6VJPkKNnSSYLzAzx2W+qE3+98t2tdLx0MXvls/Auz/PTAxONLSZ4B85DowsFxQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(14060799003)(376014)(1800799024)(35042699022)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(13003099007)(5023799004)(11063799006)(261022075727099003)(261028144727099003)(261102123227099003)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261022113327099003)(56012099006)(261022105027099003)(261021135927099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o2YaYzoA/A7a8IGkDhodPmOwCN7c6wk+rkWgd68TU18z6CMGsn9CDGLdGWhNY4p4t5Bd8U6QSod96L/bnzCUOKsUoEtxrlnjZqkaz2A1EvlKIIv5n/GzfIttsX/WubqoP1FbtYw471nGd4XfLj7mZt5DVVgTm5IM15GJaHd/oTKXEJgmr95mrkobqiCVSm/AyDATi9mAclcx0IBO86qVAh4BFQFe8NdI7mN9/5HzmHBCrNOryj0BoqGp6DhGU1xh2HqbTWeGDnj5WALkf7/aEBnIJRwZapbENPqbT8Xun+zm32asKvPgJIFHSMfaBxx89nPPxp7gio4NnYPhmlk3ptNkcSOJBeiNbyNKkdZhNZgYavwp2pmkf5YqcvYlNjS5svCYrX8HOmQTUT3v9TPyR2oW/O6+0uJv64N83erZLNIfj0ubEB6fA7+6dacRv1aO
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:33.7305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea293455-1ffe-4064-6258-08df3f411945
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008556.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5776
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

Add a per-partition scheduler that queues access-window GPU requests and
grants GPU access to queued windows in turn.

An uncontended access window can retain access after its timeslice
expires. The scheduler requests a yield when the timeslice has expired
and another window is waiting and force-closes the active window if it
does not yield in time.

Use hrtimers for GPU timeslices and stop/close completion deadlines.
Start stop and close timers after successful command submission.

Retry stop and close commands from workqueue context when submission
returns -EAGAIN. Use scheduler reset work to recover from other
command errors and completion timeouts.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Use sched_id instead of looking it up via the aw_id for sched to AW
  operations.
- Fix stale timer callback from running on a newer lease generation.
- Fix following issues raised by sashiko:
  - Simplify scheduler tear-down path.
  - Fix timeout value truncation.
  - Introduce retry path for commands that fail due to possibility of
    partition commands being rejected due to transient state transition.
  - Add check for allocation failure from devm_kasprintf
  - Rollback failed suspend / resume.
- Link: https://lore.kernel.org/all/20260922210022.394441F00893@smtp.kernel.org/
v1:
- Move grant, stop and close operations from workqueues into IRQ-safe
  paths. Retains work for scheduler recovery.
- Add closing phase and timer to ensure CLOSE_WINDOW completes in due
  time, otherwise enter recovery handling.
- Rename "grant_timeout_us" to "request_timeout" and "yield_timeout_us"
  to "yield_timeout". Both units are now in milliseconds.
- Add ABI documentation

 .../testing/sysfs-driver-panthor-arbitration  |  18 +
 MAINTAINERS                                   |   1 +
 drivers/gpu/drm/panthor/arbitration/Makefile  |   1 +
 .../panthor/arbitration/panthor_arbitration.h |   9 +
 .../arbitration/panthor_arbitration_drv.c     |  31 +
 .../arbitration/panthor_arbitration_sched.c   | 838 ++++++++++++++++++
 .../arbitration/panthor_arbitration_sched.h   |  38 +
 7 files changed, 936 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
 create mode 100644 drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h

diff --git a/Documentation/ABI/testing/sysfs-driver-panthor-arbitration b/Documentation/ABI/testing/sysfs-driver-panthor-arbitration
new file mode 100644
index 0000000000000..fbd21270a2412
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-panthor-arbitration
@@ -0,0 +1,18 @@
+What:		/sys/module/panthor_arbitration/parameters/request_timeout
+Date:		September 2026
+KernelVersion:	7.2.0
+Contact:	Arm Ltd.
+Description:
+		Controls how long, in milliseconds, the arbitration scheduler
+		allows an access window to keep the GPU before asking it to
+		yield when another access window is waiting.
+
+What:		/sys/module/panthor_arbitration/parameters/yield_timeout
+Date:		September 2026
+KernelVersion:	7.2.0
+Contact:	Arm Ltd.
+Description:
+		Controls how long, in milliseconds, the arbitration scheduler
+		waits for an access window to yield the GPU after a stop request.
+		If the timeout expires, the scheduler force-closes the access
+		window.
diff --git a/MAINTAINERS b/MAINTAINERS
index bdf3cc1044c3e..4be924fdf6e29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2400,6 +2400,7 @@ M:	Liviu Dudau <liviu.dudau@arm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/ABI/testing/sysfs-driver-panthor-arbitration
 F:	Documentation/devicetree/bindings/gpu/arm,mali-gen5-am*.yaml
 F:	Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
 F:	drivers/gpu/drm/ci/xfails/panthor*
diff --git a/drivers/gpu/drm/panthor/arbitration/Makefile b/drivers/gpu/drm/panthor/arbitration/Makefile
index 2d2684321d978..22ed68948fee3 100644
--- a/drivers/gpu/drm/panthor/arbitration/Makefile
+++ b/drivers/gpu/drm/panthor/arbitration/Makefile
@@ -4,6 +4,7 @@
 obj-$(CONFIG_DRM_PANTHOR_ARBITRATION) += panthor_arbitration.o
 panthor_arbitration-y := \
 	panthor_arbitration_drv.o \
+	panthor_arbitration_sched.o \
 	panthor_partition_control.o \
 	panthor_resource_group.o
 
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 9612bfc6c4417..8d4c0aab12666 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -6,8 +6,10 @@
 
 #include <linux/ioport.h>
 #include <linux/fwnode.h>
+#include <linux/types.h>
 
 struct device;
+struct panthor_arbitration_sched;
 struct panthor_partition_control;
 struct panthor_resource_group;
 
@@ -27,6 +29,13 @@ struct panthor_arbitration {
 
 	/** @rg: Pointer array to resource group data */
 	struct panthor_resource_group *rg[AM_ARB_MAX_RG_COUNT];
+
+	/** @sched: Pointer to scheduler data. 1 sched per partition */
+	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
 };
 
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id, u8 aw_id);
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id);
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index 0e8ffd3c1e6da..f26dcdcbc9198 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 
 #include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
 #include "panthor_partition_control.h"
 #include "panthor_resource_group.h"
 
@@ -21,6 +22,10 @@ static int panthor_arbitration_runtime_suspend(struct device *dev)
 	struct panthor_arbitration *adev = dev_get_drvdata(dev);
 	int ret = 0;
 
+	ret = panthor_arbitration_sched_suspend(adev);
+	if (ret)
+		return ret;
+
 	ret = panthor_resource_group_suspend(adev);
 	if (ret)
 		return ret;
@@ -45,6 +50,26 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = panthor_arbitration_sched_resume(adev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Arbiter to AW events */
+int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id, u8 aw_id)
+{
+	return 0;
+}
+
+int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id)
+{
+	return 0;
+}
+
+int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id)
+{
 	return 0;
 }
 
@@ -71,6 +96,10 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_pm;
 
+	ret = panthor_arbitration_sched_init(adev);
+	if (ret)
+		goto err_term;
+
 	ret = panthor_partition_control_init(adev);
 	if (ret)
 		goto err_term;
@@ -94,6 +123,7 @@ static int panthor_arbitration_probe(struct platform_device *pdev)
 	of_platform_depopulate(dev);
 
 err_term:
+	panthor_arbitration_sched_term(adev);
 	panthor_resource_group_term(adev);
 	panthor_partition_control_term(adev);
 	pm_runtime_put_sync_suspend(dev);
@@ -119,6 +149,7 @@ static void panthor_arbitration_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(adev->dev);
 
+	panthor_arbitration_sched_term(adev);
 	panthor_partition_control_term(adev);
 	panthor_resource_group_term(adev);
 
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
new file mode 100644
index 0000000000000..23768739e9ef5
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.c
@@ -0,0 +1,838 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/kfifo.h>
+#include <linux/moduleparam.h>
+#include <linux/pm_runtime.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#include "panthor_arbitration.h"
+#include "panthor_arbitration_sched.h"
+#include "panthor_resource_group.h"
+
+static u32 request_timeout = 1 * MSEC_PER_SEC;
+static u32 yield_timeout = 1 * MSEC_PER_SEC;
+
+module_param(request_timeout, uint, 0644);
+MODULE_PARM_DESC(request_timeout, "Time the GPU will be granted to the AW in milliseconds.");
+
+module_param(yield_timeout, uint, 0644);
+MODULE_PARM_DESC(yield_timeout, "Time, in milliseconds, within which the AW must yield the GPU.");
+
+enum arbitration_sched_phase {
+	ARB_SCHED_PHASE_IDLE = 0,
+	ARB_SCHED_PHASE_GRANTING,
+	ARB_SCHED_PHASE_GRANTED,
+	ARB_SCHED_PHASE_STOPPING,
+	ARB_SCHED_PHASE_CLOSING,
+	ARB_SCHED_PHASE_LOST,
+};
+
+struct panthor_arbitration_timer {
+	/** @timer: High-resolution timer */
+	struct hrtimer timer;
+
+	/** @epoch: The lease generation for which the timer was triggered */
+	u32 epoch;
+};
+
+struct panthor_arbitration_work {
+	/** @work: Work struct */
+	struct work_struct work;
+
+	/** @aw_id: Window for which the work was queued */
+	u8 aw_id;
+
+	/** @epoch: The lease generation for which the work was queued */
+	u32 epoch;
+};
+
+enum panthor_arbitration_retry_work {
+	PANTHOR_ARB_WORK_STOP = 0,
+	PANTHOR_ARB_WORK_CLOSE,
+	PANTHOR_ARB_WORK_COUNT,
+};
+
+struct panthor_arbitration_sched {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @id: Scheduler index. Sched N maps to partition control N */
+	u8 id;
+
+	/** @name: Scheduler name */
+	char *name;
+
+	/** @waitqueue: Event wait queue. Not IRQ safe */
+	wait_queue_head_t waitqueue;
+
+	/** @lock: Protects scheduler state */
+	spinlock_t lock;
+
+	/** @queue: Pending request FIFO */
+	DECLARE_KFIFO(queue, u8, 16);
+
+	/** @queued_mask: Mask of currently queued AWs */
+	DECLARE_BITMAP(queued_mask, AM_ARB_MAX_AW_COUNT);
+
+	/** @active_aw_id: Currently active AW. Can be -1 */
+	s8 active_aw_id;
+
+	/** @phase: Current scheduling phase */
+	enum arbitration_sched_phase phase;
+
+	/** @epoch: Current active lease generation */
+	u32 epoch;
+
+	/** @wq: Scheduler workqueue to dispatch events */
+	struct workqueue_struct *wq;
+
+	/** @reset_work: Work to reset the scheduler */
+	struct panthor_arbitration_work reset_work;
+
+	/** @retry_work: Work to retry an operation */
+	struct panthor_arbitration_work retry_work;
+
+	/** @pending_retry_work: Retry work that is pending */
+	DECLARE_BITMAP(pending_retry_work, PANTHOR_ARB_WORK_COUNT);
+
+	/** @grant_timer: Timer to indicate grant window has lapsed */
+	struct panthor_arbitration_timer grant_timer;
+
+	/** @stop_timer: Timer to indicate yield window has lapsed */
+	struct panthor_arbitration_timer stop_timer;
+
+	/** @close_timer: Timer to indicate close window has lapsed */
+	struct panthor_arbitration_timer close_timer;
+
+	/** @disabled: Scheduler disabled. No further scheduling can happen */
+	u32 disabled;
+
+	/**
+	 * @grant_previously_expired: Grant period previously expired but was
+	 * not asked to stop
+	 */
+	bool grant_previously_expired;
+};
+
+static int arb_sched_on_stopped_locked(struct panthor_arbitration_sched *sched, u8 aw_id);
+
+static inline struct panthor_arbitration *
+to_adev(struct panthor_arbitration_sched *sched)
+{
+	return dev_get_drvdata(sched->dev);
+}
+
+static inline struct panthor_arbitration_work *to_work(struct work_struct *w)
+{
+	return container_of(w, struct panthor_arbitration_work, work);
+}
+
+static u32 panthor_arbitration_stop_timeout(struct panthor_arbitration_sched *sched)
+{
+	u64 timeout = (u64)READ_ONCE(request_timeout) + READ_ONCE(yield_timeout);
+
+	if (timeout > (u64)INT_MAX) {
+		dev_warn_once(sched->dev, "request/yield timeout too large.");
+		return INT_MAX;
+	}
+
+	return timeout;
+}
+
+static bool arb_sched_phase_reached(struct panthor_arbitration_sched *sched,
+				    enum arbitration_sched_phase phase)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return sched->phase == phase;
+}
+
+/* This method is not IRQ safe as it sleeps. */
+static int arb_sched_wait_phase(struct panthor_arbitration_sched *sched,
+				enum arbitration_sched_phase phase,
+				u32 timeout_ms)
+{
+	if (!wait_event_timeout(
+		    sched->waitqueue, arb_sched_phase_reached(sched, phase),
+		    msecs_to_jiffies(timeout_ms))) {
+
+		if (!arb_sched_phase_reached(sched, phase))
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void arb_sched_queue_work(struct panthor_arbitration_sched *sched,
+				 struct panthor_arbitration_work *work)
+{
+	lockdep_assert_held(&sched->lock);
+
+	work->aw_id = sched->active_aw_id;
+	work->epoch = sched->epoch;
+	queue_work(sched->wq, &work->work);
+}
+
+static void arb_sched_queue_retry_work(struct panthor_arbitration_sched *sched,
+				       enum panthor_arbitration_retry_work work)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (!test_and_set_bit(work, sched->pending_retry_work))
+		arb_sched_queue_work(sched, &sched->retry_work);
+}
+
+static int __arb_sched_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_stop(to_adev(sched), sched->id);
+	if (ret == -EAGAIN) {
+		arb_sched_queue_retry_work(sched, PANTHOR_ARB_WORK_STOP);
+	} else if (ret) {
+		dev_err(sched->dev, "%s: Failed to send yield to AW%u. %d",
+			sched->name, sched->active_aw_id, ret);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+
+	return ret;
+}
+
+static void arb_sched_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = __arb_sched_stop_locked(sched);
+	if (!ret) {
+		if (sched->phase != ARB_SCHED_PHASE_STOPPING) {
+			dev_warn(sched->dev, "%s: Stop ACKED when not yielding",
+				 sched->name);
+			return;
+		}
+
+		sched->stop_timer.epoch = sched->epoch;
+		hrtimer_start(&sched->stop_timer.timer,
+			      ms_to_ktime(yield_timeout), HRTIMER_MODE_REL);
+	}
+}
+
+static void arb_sched_grant_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_grant(to_adev(sched), sched->id, sched->active_aw_id);
+	if (!ret) {
+		if (sched->phase != ARB_SCHED_PHASE_GRANTING) {
+			dev_warn(sched->dev, "%s: Grant ACKED when not granting",
+				 sched->name);
+			return;
+		}
+
+		if (sched->disabled) {
+			sched->phase = ARB_SCHED_PHASE_STOPPING;
+			arb_sched_stop_locked(sched);
+		} else {
+			sched->phase = ARB_SCHED_PHASE_GRANTED;
+
+			sched->grant_timer.epoch = sched->epoch;
+			hrtimer_start(&sched->grant_timer.timer,
+				      ms_to_ktime(request_timeout),
+				      HRTIMER_MODE_REL);
+		}
+
+		wake_up_all(&sched->waitqueue);
+	} else if (ret < 0) {
+		dev_err(sched->dev, "%s: Failed to grant access to AW%u. %d",
+			sched->name, sched->active_aw_id, ret);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+}
+
+static int __arb_sched_close_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = panthor_arbitration_on_close(to_adev(sched), sched->id);
+	if (ret == -EAGAIN) {
+		arb_sched_queue_retry_work(sched, PANTHOR_ARB_WORK_CLOSE);
+	} else if (ret < 0) {
+		dev_err(sched->dev, "%s: Failed to close AW%u. %d", sched->name,
+			sched->active_aw_id, ret);
+
+		arb_sched_queue_work(sched, &sched->reset_work);
+	}
+
+	return ret;
+}
+
+static void arb_sched_close_locked(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	lockdep_assert_held(&sched->lock);
+
+	ret = __arb_sched_close_locked(sched);
+	if (!ret) {
+		sched->close_timer.epoch = sched->epoch;
+		hrtimer_start(&sched->close_timer.timer,
+			      ms_to_ktime(yield_timeout), HRTIMER_MODE_REL);
+	}
+}
+
+static void arb_sched_request_stop_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	/*
+	 * In the event of a single requesting AW, let it continue to
+	 * lease the GPU until another request comes in.
+	 */
+	if (!sched->disabled && kfifo_is_empty(&sched->queue)) {
+		sched->grant_previously_expired = true;
+		return;
+	}
+
+	sched->phase = ARB_SCHED_PHASE_STOPPING;
+	arb_sched_stop_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static void arb_sched_request_stop(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	arb_sched_request_stop_locked(sched);
+}
+
+static void arb_sched_force_close_locked(struct panthor_arbitration_sched *sched)
+{
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE)
+		return;
+
+	if (sched->active_aw_id < 0)
+		return;
+
+	sched->phase = ARB_SCHED_PHASE_LOST;
+
+	arb_sched_close_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+}
+
+static int arb_sched_force_close(struct panthor_arbitration_sched *sched)
+{
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		arb_sched_force_close_locked(sched);
+
+	return arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
+				    panthor_arbitration_stop_timeout(sched));
+}
+
+static int arb_sched_next_locked(struct panthor_arbitration_sched *sched)
+{
+	u8 aw_id;
+
+	lockdep_assert_held(&sched->lock);
+
+	if (sched->disabled)
+		return 0;
+
+	/* already have a running aw */
+	if (sched->active_aw_id >= 0)
+		return 0;
+
+	/* nothing to schedule */
+	if (kfifo_is_empty(&sched->queue))
+		return 0;
+
+	if (!kfifo_get(&sched->queue, &aw_id)) {
+		dev_warn(sched->dev, "%s: queue unexpectedly empty",
+				sched->name);
+		return -EINVAL;
+	}
+
+	clear_bit(aw_id, sched->queued_mask);
+
+	sched->active_aw_id = aw_id;
+	sched->epoch++;
+	sched->phase = ARB_SCHED_PHASE_GRANTING;
+
+	arb_sched_grant_locked(sched);
+
+	wake_up_all(&sched->waitqueue);
+
+	return 0;
+}
+
+static int arb_sched_next(struct panthor_arbitration_sched *sched)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return arb_sched_next_locked(sched);
+}
+
+static void arb_sched_reset_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, reset_work);
+
+	guard(spinlock_irqsave)(&sched->lock);
+	if (sched->epoch != w->epoch)
+		return;
+
+	if (sched->active_aw_id != w->aw_id)
+		return;
+
+	dev_warn(sched->dev, "%s: scheduler reset. active_aw=%u",
+			sched->name, sched->active_aw_id);
+
+	arb_sched_force_close_locked(sched);
+}
+
+static void arb_sched_retry_work(struct work_struct *work)
+{
+	struct panthor_arbitration_work *w = to_work(work);
+	struct panthor_arbitration_sched *sched =
+		container_of(w, struct panthor_arbitration_sched, retry_work);
+	DECLARE_BITMAP(work_tmp, PANTHOR_ARB_WORK_COUNT);
+
+	guard(spinlock_irqsave)(&sched->lock);
+	if (bitmap_empty(sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT))
+		return;
+
+	bitmap_copy(work_tmp, sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT);
+	bitmap_zero(sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT);
+
+	if (sched->epoch != w->epoch || sched->active_aw_id != w->aw_id)
+		return;
+
+	switch (sched->phase) {
+	case ARB_SCHED_PHASE_STOPPING:
+		if (test_bit(PANTHOR_ARB_WORK_STOP, work_tmp))
+			arb_sched_stop_locked(sched);
+		break;
+	case ARB_SCHED_PHASE_CLOSING:
+	case ARB_SCHED_PHASE_LOST:
+		if (test_bit(PANTHOR_ARB_WORK_CLOSE, work_tmp))
+			arb_sched_close_locked(sched);
+		break;
+	default:
+		break;
+	}
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_stop_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, stop_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (hrtimer_is_queued(timer))
+		return HRTIMER_NORESTART;
+
+	if (sched->epoch != atmr->epoch ||
+	    sched->phase != ARB_SCHED_PHASE_STOPPING)
+		return HRTIMER_NORESTART;
+
+	dev_warn(sched->dev,
+		 "%s: AW%d failed to stop in time. Force closing...",
+		 sched->name, sched->active_aw_id);
+	arb_sched_force_close_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_grant_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, grant_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (hrtimer_is_queued(timer))
+		return HRTIMER_NORESTART;
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	arb_sched_request_stop_locked(sched);
+
+	return HRTIMER_NORESTART;
+}
+
+static enum hrtimer_restart
+panthor_arbitration_sched_on_close_timeout(struct hrtimer *timer)
+{
+	struct panthor_arbitration_timer *atmr = container_of(
+		timer, struct panthor_arbitration_timer, timer);
+	struct panthor_arbitration_sched *sched = container_of(
+		atmr, struct panthor_arbitration_sched, close_timer);
+
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (hrtimer_is_queued(timer))
+		return HRTIMER_NORESTART;
+
+	if (sched->epoch != atmr->epoch)
+		return HRTIMER_NORESTART;
+
+	if (sched->phase != ARB_SCHED_PHASE_CLOSING &&
+	    sched->phase != ARB_SCHED_PHASE_LOST)
+		return HRTIMER_NORESTART;
+
+	dev_warn(sched->dev,
+		 "%s: AW%d failed to close in time. Resetting scheduler...",
+		 sched->name, sched->active_aw_id);
+
+	arb_sched_queue_work(sched, &sched->reset_work);
+
+	return HRTIMER_NORESTART;
+}
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (test_bit(aw_id, sched->queued_mask) ||
+	    (sched->active_aw_id == aw_id &&
+	     sched->phase != ARB_SCHED_PHASE_STOPPING)) {
+		dev_warn(sched->dev, "%s: AW%u already in request queue.",
+			 sched->name, aw_id);
+		return -EEXIST;
+	}
+
+	/* Always put onto queue */
+	if (!kfifo_put(&sched->queue, aw_id)) {
+		dev_err(sched->dev, "%s: request queue unexpectedly full",
+			sched->name);
+		return -ENOSPC;
+	}
+	set_bit(aw_id, sched->queued_mask);
+
+	/* No active AW, schedule next AW */
+	if (sched->active_aw_id < 0)
+		return arb_sched_next_locked(sched);
+
+	/*
+	 * Grant timer for the current AW has previously expired, request it to
+	 * yield the GPU.
+	 */
+	if (sched->grant_previously_expired)
+		arb_sched_request_stop_locked(sched);
+
+	return 0;
+}
+
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	if (sched->phase != ARB_SCHED_PHASE_GRANTED &&
+	    sched->phase != ARB_SCHED_PHASE_STOPPING)
+		return 0;
+
+	sched->phase = ARB_SCHED_PHASE_CLOSING;
+	arb_sched_close_locked(sched);
+
+	return 0;
+}
+
+static int arb_sched_on_stopped_locked(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	if (aw_id >= AM_ARB_MAX_AW_COUNT)
+		return -EINVAL;
+
+	if (sched->phase == ARB_SCHED_PHASE_IDLE)
+		return 0;
+
+	if (sched->active_aw_id != aw_id)
+		return 0;
+
+	/* retire old lease */
+	sched->epoch++;
+
+	sched->grant_previously_expired = false;
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+	bitmap_zero(sched->pending_retry_work, PANTHOR_ARB_WORK_COUNT);
+
+	wake_up_all(&sched->waitqueue);
+
+	return arb_sched_next_locked(sched);
+}
+
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	return arb_sched_on_stopped_locked(sched, aw_id);
+}
+
+static void arbitration_sched_disable_work(struct panthor_arbitration_sched *sched)
+{
+	disable_work_sync(&sched->reset_work.work);
+	disable_work_sync(&sched->retry_work.work);
+}
+
+static void arbitration_sched_cancel(struct panthor_arbitration_sched *sched)
+{
+	panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
+	arbitration_sched_disable_work(sched);
+	hrtimer_cancel(&sched->grant_timer.timer);
+	hrtimer_cancel(&sched->stop_timer.timer);
+	hrtimer_cancel(&sched->close_timer.timer);
+}
+
+static void arbitration_sched_term(struct panthor_arbitration_sched *sched)
+{
+	panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_TERM);
+
+	if (!pm_runtime_status_suspended(sched->dev))
+		WARN_ON(panthor_arbitration_sched_stop(sched));
+
+	arbitration_sched_cancel(sched);
+}
+
+static int arbitration_sched_init(struct panthor_arbitration *adev, int i)
+{
+	struct device *dev = adev->dev;
+	struct panthor_arbitration_sched *sched;
+
+	sched = devm_kzalloc(dev, sizeof(*sched), GFP_KERNEL);
+	if (!sched)
+		return -ENOMEM;
+
+	sched->name = devm_kasprintf(dev, GFP_KERNEL, "sched%d", i);
+	if (!sched->name)
+		return -ENOMEM;
+
+	sched->id = i;
+	sched->dev = dev;
+
+	sched->wq = devm_alloc_ordered_workqueue(dev, "%s-wq", 0, sched->name);
+	if (!sched->wq)
+		return -ENOMEM;
+
+	INIT_WORK(&sched->reset_work.work, arb_sched_reset_work);
+	INIT_WORK(&sched->retry_work.work, arb_sched_retry_work);
+
+	init_waitqueue_head(&sched->waitqueue);
+
+	spin_lock_init(&sched->lock);
+	INIT_KFIFO(sched->queue);
+	sched->active_aw_id = -1;
+	sched->phase = ARB_SCHED_PHASE_IDLE;
+
+	hrtimer_setup(&sched->grant_timer.timer,
+		      panthor_arbitration_sched_on_grant_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&sched->stop_timer.timer,
+		      panthor_arbitration_sched_on_stop_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&sched->close_timer.timer,
+		      panthor_arbitration_sched_on_close_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+
+	adev->sched[i] = sched;
+
+	return 0;
+}
+
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev)
+{
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		arbitration_sched_term(sched);
+	}
+}
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev)
+{
+
+	for (int i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		int ret = arbitration_sched_init(adev, i);
+
+		if (ret == -ENODEV)
+			continue;
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
+		ret = panthor_arbitration_sched_stop(sched);
+		if (ret)
+			goto err_rollback;
+	}
+
+	return 0;
+
+err_rollback:
+	for (; i >= 0; i--) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_clear(sched, ARB_SCHED_DISABLE_PM);
+		panthor_arbitration_sched_start(sched);
+	}
+
+	return ret;
+}
+
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < AM_ARB_MAX_PC_COUNT; i++) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_clear(sched, ARB_SCHED_DISABLE_PM);
+		ret = panthor_arbitration_sched_start(sched);
+		if (ret)
+			goto err_rollback;
+	}
+
+	return 0;
+
+err_rollback:
+	for (; i >= 0; i--) {
+		struct panthor_arbitration_sched *sched = adev->sched[i];
+
+		if (!sched)
+			continue;
+
+		panthor_arbitration_sched_disable_set(sched, ARB_SCHED_DISABLE_PM);
+		panthor_arbitration_sched_stop(sched);
+	}
+
+	return ret;
+}
+
+/**
+ * panthor_arbitration_sched_stop - Stop active aw and pause scheduler
+ *
+ * @sched: Pointer to arbitration scheduler
+ *
+ * This method is not IRQ safe as it waits for on_stopped() to be called.
+ */
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched)
+{
+	int ret;
+
+	arb_sched_request_stop(sched);
+
+	/*
+	 * Provisionally waiting for up to 2x yield_timeout, but path may
+	 * include time taken for panthor_arbitration_on_grant() to complete
+	 * if sched_request_stop() is called while in the GRANTING state.
+	 *
+	 * Realistically, if granting takes more than yield_timeout, HW is in
+	 * bad state either way. Best continue and stop the scheduler.
+	 */
+	ret = arb_sched_wait_phase(sched, ARB_SCHED_PHASE_IDLE,
+				   panthor_arbitration_stop_timeout(sched));
+	if (ret) {
+		/*
+		 * TODO: handle the timeout here by escalating the error when
+		 * reset escalation is supported.
+		 */
+		ret = arb_sched_force_close(sched);
+	}
+
+	/* Should no longer have any further activity. Cancel timer. */
+	hrtimer_cancel(&sched->grant_timer.timer);
+	hrtimer_cancel(&sched->stop_timer.timer);
+	hrtimer_cancel(&sched->close_timer.timer);
+	flush_workqueue(sched->wq);
+
+	scoped_guard(spinlock_irqsave, &sched->lock)
+		if (sched->phase == ARB_SCHED_PHASE_IDLE)
+			return 0;
+
+	return ret;
+}
+
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched)
+{
+	return arb_sched_next(sched);
+}
+
+void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sched,
+					   enum panthor_arb_sched_disable_reason reason)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	sched->disabled |= BIT(reason);
+}
+
+void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
+					     enum panthor_arb_sched_disable_reason reason)
+{
+	guard(spinlock_irqsave)(&sched->lock);
+
+	sched->disabled &= ~BIT(reason);
+}
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
new file mode 100644
index 0000000000000..4d0f72838d218
--- /dev/null
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_sched.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_ARBITRATION_SCHED_H__
+#define __PANTHOR_ARBITRATION_SCHED_H__
+
+#include <linux/types.h>
+
+struct panthor_arbitration;
+struct panthor_arbitration_sched;
+
+enum panthor_arb_sched_disable_reason {
+	/** @ARB_SCHED_DISABLE_PM: scheduler disabled due to PM suspend */
+	ARB_SCHED_DISABLE_PM = 0,
+
+	/** @ARB_SCHED_DISABLE_TERM: scheduler disabled for termination */
+	ARB_SCHED_DISABLE_TERM,
+};
+
+int panthor_arbitration_sched_init(struct panthor_arbitration *adev);
+void panthor_arbitration_sched_term(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_suspend(struct panthor_arbitration *adev);
+int panthor_arbitration_sched_resume(struct panthor_arbitration *adev);
+
+int panthor_arbitration_sched_stop(struct panthor_arbitration_sched *sched);
+int panthor_arbitration_sched_start(struct panthor_arbitration_sched *sched);
+
+void panthor_arbitration_sched_disable_set(struct panthor_arbitration_sched *sched,
+					   enum panthor_arb_sched_disable_reason reason);
+void panthor_arbitration_sched_disable_clear(struct panthor_arbitration_sched *sched,
+					     enum panthor_arb_sched_disable_reason reason);
+
+int panthor_arbitration_sched_on_request(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_idle(struct panthor_arbitration_sched *sched, u8 aw_id);
+int panthor_arbitration_sched_on_stopped(struct panthor_arbitration_sched *sched, u8 aw_id);
+
+#endif
-- 
2.43.0

