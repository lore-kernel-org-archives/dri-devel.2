Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51F360A383F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T3LjWx4c;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=T3LjWx4c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C8810F7A8;
	Tue, 10 Nov 2026 15:41:05 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AD310F79B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:50 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vs0OYMY1qvTOcUwAQEyq7sTuq7k5wJTWI+AU5dZSwOi7n1irDgFxeEKANqupW7XziLmidtb3TllPTrIE7UiQs8yZqRPhE0NuW4Qv4lhw0pvVuxvbfRG1pPb5tPPn8ZIS28YVLfXbZQgyZx1TZxa6/nP8oHeMgxW2L27fOAF2YfViWvPW69B5NdJdvyNxpBqupctSO8AAknUajKuS+GcG9F8BdaQjTdJnVinLDLL/VFzDU4FeK/0E+pNm7rTeiQjf9IM8q1s4CSL0NIddePzmD+MI22D8ItuMlQsprN0BQwvqs+ZipZ3CkvPdJyNS0A7SrSsUy3BJNOfF2EGrxoN4dQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZC08odkXau4gmXVlrkXSJgw/wSjbEcp/ZSLLUP/j/A=;
 b=NOYoXHVgiZSOi5IBxeNUe0MBJMnLmN+xgSK1mXGRVcJL+Cb6am7Xhl1VWmgFIMiYPGv8+CwSi/py1MFgxeSfYOeMNYtIXYem61KhPRPM0+tyQTTZxYZnU29+7ERj3vJiJ5B2jr1uD8+wVx+q340lNDp1ZYtG3cAcHpOy8rWhjzl5GiZamw32FKFOQ5SvDMGPH6irbNzM6XVstoV3O7wYgZ9cgi50UkvMOA1/Qp2T6xHv8xqK0tjHsCXIcIaWnzAjQREydtwbedIxED1wu0HQOJ4RaNmxIkd0vy20YSWnw16czXtNSx6vUgo5WpT8YEL5rwlwF/e3w6ueaT4gw9vlZQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZC08odkXau4gmXVlrkXSJgw/wSjbEcp/ZSLLUP/j/A=;
 b=T3LjWx4cEQgpHe+CnOSIV0egGb+AFPMKiVILpT1Sc9leAFZ6fJrzwLQ46VFybpm+PcajazEkVPvXP6MxYb/40GI59+iy6wy5ECaWKa6OEKVBZmKl6Od/g2uAuMlGlVGG3jKYWI3cZy4+k/bHT0S+uyMkDD+trLpBmGwQjr4QOyc=
Received: from DU7P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::33)
 by WA4PR08MB031368.eurprd08.prod.outlook.com (2603:10a6:1d0:107::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 15:40:43 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::58) by DU7P191CA0019.outlook.office365.com
 (2603:10a6:10:54e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk13yriyDI0ri8TaAHysoj/q50sZQDWdy2A/t/H0RQIE0XFzuoJwGxffQ9MXT/bTS2j0FmlPLsr9w6iEnLpLOUkGW8FgwzN15vMhhzw8N4fqv5uC/k9rDxPWesO6RTO3duiRoAORzvUg9oPsYqlRbXBS7fSuquaA60uawUuyKWnBx9mBpD7KdcgExJ04qesuYD+V30WSeZP9HAzSMrC24cHX4RjO/6mBJXp48vzy1z3V6r7oufj2T3QSu8odUSh/Qb8FhiA/SFBi/W4AIynbyO55j5bLU5RzIylYMlddwQN4sL6KBkY2M2uzIxXBNGcNQ0q7C0HF+0Nzg4rsqQsMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZC08odkXau4gmXVlrkXSJgw/wSjbEcp/ZSLLUP/j/A=;
 b=u+K4ssNhlJTCheZ1FlW8R+tTA4A7efMEqMK/fe6g8DiiR52C/pGlT9ficX94lCwspdNKEqK8DxBUhgygVt1K+j5ohL1a5Nx2pzAQQFISHENKQc0AMDdUtf1kHmQaGHAyvp6N72FTmT7UXocmmW4PorIx65TZeDLbAQp0KM4aWRIR2leCAC/QhM9bI6LrGcVZS6i0ZdkR3EjAEv5FsX9R9tDDYLb52gkoZ6ezJr9TwDBh7SwFsYZ3z4Up9ryyfS502wwjG3XExlP6ZV7ZzEjz0T+0YOrcobqNG4kWdcsnDf5pX3K6zEDiQJ3o3IsazDITETlUyhNqFhlvTPr+6Po28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZC08odkXau4gmXVlrkXSJgw/wSjbEcp/ZSLLUP/j/A=;
 b=T3LjWx4cEQgpHe+CnOSIV0egGb+AFPMKiVILpT1Sc9leAFZ6fJrzwLQ46VFybpm+PcajazEkVPvXP6MxYb/40GI59+iy6wy5ECaWKa6OEKVBZmKl6Od/g2uAuMlGlVGG3jKYWI3cZy4+k/bHT0S+uyMkDD+trLpBmGwQjr4QOyc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by MI9PR08MB570361.eurprd08.prod.outlook.com
 (2603:10a6:290:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:09 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:09 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 06/28] drm/panthor: Move register base offsets to the HW
 description
Date: Tue, 10 Nov 2026 15:38:27 +0000
Message-ID: <20261110153907.3241978-7-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0040.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::19) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|MI9PR08MB570361:EE_|DB1PEPF000509EA:EE_|WA4PR08MB031368:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5f02f3-5e15-4129-77d7-08df3f40fa85
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|6133799003|10067099003|11063799006|261021123027099003|56012099006|261102123227099003|261028144727099003|261009223027099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info-Original: on6eEwt0ROiYfIPMxyWBZ0KiAD7w83C2kEWq5HfxNROhgNrD44YJ18DA0PY0pMqXDKDHlyCcPi6KXlwYV9F1cCriKrmcjHiba5EZ1urArQH6vTBopuWfVc5oVczXuH0Mb15Dvy0g+RvNKjGca6zxQ0OJolpVHPB8uwTO8QV9mdLGRdw2ysZYDmgy1H+gKtjvVxcoLKIm/O0ZfPu/GZ7WAhBzRoO9Cl0euWo3Egja/dxqEOgvaovirJW1N9jEuPYuT3q7BOGIR9Lnth7qR72vdu7UpP6t5CZcJV6kXFfYyWCmxCQCTzslR9bHmkoua9IbQ5JPbieokpIDDjebMpJFd3TmJpr93LFsUsa0ZefnFDjLqWfCivcEbRlYGXGfXZedK6tVExi6IbHUD+vXkfbUDjtnmkxAnxsYOcMJrDWgEuv5ir6ESQxkYAOsaW/sJaWg6ls+me86Qyd5ceFDSz1ywD1PKqykmRPhYtkhMYnCKUcZruDzythuew3eXMaDwyx0tfyZUZpCu6l8iXql7yK+heWvkD3cqlu7ThKMz48vSZ7lhVTqBeb4AsDwWKSvj0y4uYvUdi4KqpxBHsWbULO8NwNPTVSu6wSB8vImQV9SBNHHYvR/x/AIXFeuqMEbnHSX3GdPHzlRbORC7xfxMkKjA6YLTpYZofbqnCjp9PFvNE4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261102123227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(260925021911599003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: UO3+9GOSRxVZac2Jmylu5ncZibWKq6FUHg+TlsJ9GQmtkmzJgr81acjHmpDJc97gJi6/PG5W/yOkSbjLMTD03z8FSWRNAwPDi37ND3WMXdLgdglmifyIwQEEZdpv3BwIwBgY9q8Zgi6layIrMagQjtKiCOGiGhH17POdEwJzq04kkCod6ED62Oj0jjni/OOHzRc/YTTaVtk53JPQhkI3Xd8ZFnVv6M51cSwZQWTzUNAT58QokLBbGkfcmbXFWDi/c1GbAUKqsN6BzAFsJJ/RwDIX2aej6fEi5u4AZz6YKg6PLVbbh+Da7BRzB3pOMtMqpguM3os5fCPSr2SoQ/xGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB570361
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9e5c191c-85a7-416e-64e2-08df3f40e702
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|14060799003|35042699022|56012099006|11063799006|260925021911599003|260925022911599003|260925021311599003|261009223027099003|261028144727099003|261102123227099003|261022075727099003|261021121427099003|261026140227099003|261022105027099003|261021123027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: OLUmZ2Wvx5rrDHENK8QIu/FerzhbkSVFUtqtrPyPjGIie1654ywCciHdpqPKWV3cAe10fZiL0bQXjRBte39XtsAxLIcMObDCG3t/Os6DhLo3i3rpI2fFGmmaXrZ+0c17u+D/5GHH8SeL2ZkKiTXaxToGTD3zJHDVywsZDOCJawKHBufaYsxn9Q0LBNbmaZoAdZumTNjfP45PQvbMDQIehvx7MXSfqR2GdOB1RXrnCoRoeAMIc8UTwG/DOCPUDoW5V7AEd5ZE7aEhhfLGcDiFInTUgMoY+4zVPQMuP+mFGUyaOkV4DYk4dA7sjwVrZL47RV8HDj9/n5Ef+9FxaDOWST5+Q7/EaJp6brcB9QuW8bKPCn9OR7nnyT1K+YAThswVDYj+wUUUJRUkTiytuqGuQ0ENS76GnwgqKWQFseeO9HarGCAx57wz5Aye6Ad+8cvy2OPMf8v5skdP+SNGJe4eB/cWnZEKa8X9Vsl2DlSTjWlQRQ2xKc0/pwR7eij+viYNB/RjafN/C4BYhLlLSfdAPu0EtjkIi36BMHh0JeCu531gPuYL3CeIoO9kK+An+LC21RC3gx/c4ZcmWfdqyHUQ3YC7ea4TjcBqdZjDhTGmyW/AeKFr4z2M7uc2BaaJlYe5kPs4LVCcJ1jSuD0B7CHUEEfrrSppLHwc2m6lsIOGUiP8ztZogkzoYjNV9/yv89j04uTPULM2DrQdJiZ1empglQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(14060799003)(35042699022)(56012099006)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021121427099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oz95eJSOQbba0JCRCEdMbUCNUTSF8+VAVqOro8qZc6xU9DSY8qovh2hm5H/uH3ZuNqplpBfnMLy6LZEDvTwZP45ixcIGlh56J6yzlwTtvMhW/YZ+GiYQfVYdO3MqB4vhvaoLR+Mfnx7iCqPUwuk6aJoGor7wxaaTWk3PY98x8OaP2vESVB8D26g8KUtzKHqJ8nrWGMsMn+TJ6OrNxkmzGDEsRw6Mx5wGb+eYaPlumByLTcU+Zmdh51QLI5OI6qlJso+VbEjPmKbHTQN4nHdZ/D8h5p7xtfp+pzh3Qze3Koef77gqgz0wp7YS3aYgSDnrIA447UomxZE6tv6YIjXxsoxXG7wcKwqGJFyoIk/Pdwc9rJMxrgL206+Q1UW3JT1Ymp6fBEwDBqDkFozT3wJ4iXMxdH11ahR4eQjVRKvT/wUhqWhwmh/Ryv7D4OXHa1Tl
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:42.2301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5f02f3-5e15-4129-77d7-08df3f40fa85
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR08MB031368
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

Mali v15 reorders several register regions, including GPU_CONTROL,
MCU_CONTROL and PWR_CONTROL, so the driver can no longer assume a single
fixed base layout across all supported GPUs.

Add per-GPU register base offsets to the panthor hardware description
and switch the GPU, FW and PWR local iomem setup to use those stored
values. With the base addresses now owned by the hardware description,
drop the corresponding fixed base-offset definitions from the register
headers.

This prepares the driver for GPUs with different register layouts
without changing the existing behaviour on currently supported parts.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Picked up R-b from Liviu
v1:
- rebased on drm-misc-next
- use a generic panthor_hw_regbank structure for all register offsets.

 drivers/gpu/drm/panthor/panthor_fw.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 --
 drivers/gpu/drm/panthor/panthor_gpu.c      |  4 +--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  2 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 23 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h       | 29 ++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_pwr.c      |  2 +-
 drivers/gpu/drm/panthor/panthor_pwr_regs.h |  2 --
 8 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 13efed3a2ea72..679ea1d233d53 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1500,7 +1500,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
-	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
+	fw->iomem = ptdev->iomem + ptdev->hw->regs.mcu_control.offset;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index b2e59cfc22b00..a3492f7f913f9 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL_BASE				0x700
-
 #define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index c5c37f22993d6..ab54119314da0 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -159,7 +159,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
-	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	gpu->iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -176,7 +176,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 		return irq;
 
 	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
-				  ptdev->iomem + GPU_INT_BASE, "gpu",
+				  gpu->iomem + GPU_INT_BASE, "gpu",
 				  panthor_gpu_irq_threaded_handler);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index c7581b6d4c5be..60819c4ace428 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
-#define GPU_CONTROL_BASE				0x0
-
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 30f5dfe500fb0..9a7d0a2edb870 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -38,6 +38,14 @@ static struct panthor_hw panthor_hw_arch_v10 = {
 		.power_changed_off = panthor_gpu_power_changed_off,
 		.power_changed_on = panthor_gpu_power_changed_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+	},
 };
 
 static struct panthor_hw panthor_hw_arch_v14 = {
@@ -46,6 +54,17 @@ static struct panthor_hw panthor_hw_arch_v14 = {
 		.l2_power_off = panthor_pwr_l2_power_off,
 		.l2_power_on = panthor_pwr_l2_power_on,
 	},
+	.regs = {
+		.gpu_control = {
+			.offset = 0x0,
+		},
+		.mcu_control = {
+			.offset = 0x700,
+		},
+		.pwr_control = {
+			.offset = 0x800,
+		},
+	},
 };
 
 static struct panthor_hw_entry panthor_hw_match[] = {
@@ -197,7 +216,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+	void __iomem *gpu_iomem = ptdev->iomem + ptdev->hw->regs.gpu_control.offset;
 
 	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
 	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
@@ -223,7 +242,7 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
-		void __iomem *pwr_iomem = gpu_iomem + PWR_CONTROL_BASE;
+		void __iomem *pwr_iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 
 		/* Introduced in arch 14.x */
 		ptdev->gpu_info.l2_present = gpu_read64(pwr_iomem, PWR_L2_PRESENT);
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index c4a490bc39de6..0a82152d772ad 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -27,14 +27,39 @@ struct panthor_hw_ops {
 	void (*power_changed_off)(struct panthor_device *ptdev);
 };
 
+/** struct panthor_hw_regbank - Register offset and instance stride information */
+struct panthor_hw_regbank {
+	/** @offset: Register offset relative to &struct panthor_device.iomem */
+	u32 offset;
+
+	/**
+	 * @stride: Register offset between instances, or 0 for non-instanced
+	 * registers
+	 */
+	u32 stride;
+};
+
+/** struct panthor_hw_regs_layout - Hardware register bank layout */
+struct panthor_hw_regs_layout {
+	/** @gpu_control: GPU_CONTROL register bank layout */
+	struct panthor_hw_regbank gpu_control;
+
+	/** @pwr_control: PWR_CONTROL register bank layout */
+	struct panthor_hw_regbank pwr_control;
+
+	/** @mcu_control: MCU_CONTROL register bank layout */
+	struct panthor_hw_regbank mcu_control;
+};
+
 /**
  * struct panthor_hw - GPU specific register mapping and functions
  */
 struct panthor_hw {
-	/** @features: Bitmap containing panthor_hw_feature */
-
 	/** @ops: Panthor HW specific operations */
 	struct panthor_hw_ops ops;
+
+	/** @regs: Hardware register bank layout */
+	struct panthor_hw_regs_layout regs;
 };
 
 int panthor_hw_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index b1000001325ea..1cfd4b658c81b 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -502,7 +502,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (!pwr)
 		return -ENOMEM;
 
-	pwr->iomem = ptdev->iomem + PWR_CONTROL_BASE;
+	pwr->iomem = ptdev->iomem + ptdev->hw->regs.pwr_control.offset;
 	spin_lock_init(&pwr->reqs_lock);
 	init_waitqueue_head(&pwr->reqs_acked);
 	ptdev->pwr = pwr;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
index 80d8e1e522298..e1f3153285bd7 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
@@ -4,8 +4,6 @@
 #ifndef __PANTHOR_PWR_REGS_H__
 #define __PANTHOR_PWR_REGS_H__
 
-#define PWR_CONTROL_BASE				0x800
-
 #define PWR_INT_BASE					0x0
 #define   PWR_IRQ_POWER_CHANGED_SINGLE			BIT(0)
 #define   PWR_IRQ_POWER_CHANGED_ALL			BIT(1)
-- 
2.43.0

