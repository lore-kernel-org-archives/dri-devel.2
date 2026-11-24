Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QIpCkxpL;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=QIpCkxpL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085A310F78C;
	Tue, 24 Nov 2026 16:21:41 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D6210F678
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:14 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ONlJ6S1kgsXdjK6FJGN+F40/Myt6Razua8+YWkSKXx6Zk0iaJUUUkTGHMpUZx1cGSvBmhMObwbs2Lgm3WoXpNmrNaZ0qOc5tmuhKlPOJzETeGeIr1B4mM41CKJNm2bL8WKqSVeTGCEbbnazCyOj9qmWLiDPdi1l0AgZSRuQ8HF5Mm5NyD+g0YlbRhzRYyPo9Xg4xG0AnxgnzGHOfi9G8n068g/x5QpVTeufKn6+6MctqOpPnHREKYIfASRqGis7sDpUJms3Uv9ZNtp0J5kZn8VqN8s09H35VJb4OyJ/P33Fj0rKCMjv8tdPxwJAewpHA9T3sS2zjfMINbj11KPrAtA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvdmdhEXOXe7tDLOfT77uIkdscscFWhO4ozy4SYojsQ=;
 b=wKrP9zP0UsXKcPTr+8ekhoRfWU/1bddkKGoq0WJjiFYP8Epa+0oiKyEAPStdWtd/brchY8DL7kadRHYPCjAmLR/hbfsXyHkZkCEY6wJ4i/CipVx0nTrWzEW/fLYYgKQmkDZgIaW/1ZxxEgxHLGvZlUF6mvq1l91qfOGZ9r1atbcNf6z3YuDzIgYZ+WU+1WUsBpEo9ZIANsTuwvJ/AarC9UErlDLQ1ckEtMp+oxT/9O74yx3LhRyLCIq2K9wOEApzL0lr/50HoayCh5QaMOlr1fRTrVtFRH7kA6ctClAKMVrJPiPvYm/KYDHK1pnZTxkDkqrwALe/villxcY6JlalUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvdmdhEXOXe7tDLOfT77uIkdscscFWhO4ozy4SYojsQ=;
 b=QIpCkxpL+KzDs40BBQP8LTmtY24f+7Fj9wEU6BvNYjtPKSmOiIUAu8R8fjNTREs/OMU4Te6cEPhg7rPrK83MpnrNmRuCd20Wd9unibvn9syouerlK7Ei3usQlVOKYCo9/KOH2fDSXgIWCHKSivkjr7BuquVwE1N1+a/PnvVvD2o=
Received: from DUZPR01CA0334.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::25) by PAVPR08MB9332.eurprd08.prod.outlook.com
 (2603:10a6:102:302::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:21:05 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:4b8:cafe::4c) by DUZPR01CA0334.outlook.office365.com
 (2603:10a6:10:4b8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 16:21:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Tue, 24 Nov 2026 16:21:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXUTJ4THzyzXqYE/ArJofayIka+GCkwhPbKruAwby/LJsue6G8oCwx7Xv5/nmCEBJQqZ7LzrcNdayEraan9MvoOlduE8ZP3iLo4FsGcSWMF9B++ty34/9fgg+66E2REBj2Gr6XYXKPsvuznilr8HpNDX7IhyMRN+dqY0m7IFmR3yYMxitCxHUb79BNzKMK5Hrr258FFm2oJSuQZ3vUQ9yoL9r4iUP2cIVmizYHV7Ve9VyU/RIcx99qP9v0NK2ii4kI2hQkMFkxs1fL5dZPs6YIRJHS6CDGh+Md7SJa8jKTxBjtqV0J55qOCLeTpouzP4fa5xx2SwckReEQhkVxAJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvdmdhEXOXe7tDLOfT77uIkdscscFWhO4ozy4SYojsQ=;
 b=Ey7rvWgVo6u//yKGiHQKGPLc7ZyE/IqnpJX3vd7EHrLK3C31AxgEqgjO+nP+M/DxiQBSFJhkiKR/0EvpIevP0RQRXgOUdx09gLVnwTlZEOQmzxD1MesB5idCHcX0GmzxBrFAvzgk8xPUBH66OZQKg3ofzVKvKVXWpcw7G7GErUWIEXTyDevqtJAxl2pEL+VaBBea2BMTXrEB6+Qd2Ir7W9z6LZj6lt1tKrYBsYSKzP5+lLsxj+cwhgwq5iJ7uEaJuBPiJEQ3mzSw9Qkw0JTvv6x9bYxp63YHhcBso/L6PmDWcA8GJ/FGBY4gLQhahCChMEIDzfqXuyS2NvCOuIMLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvdmdhEXOXe7tDLOfT77uIkdscscFWhO4ozy4SYojsQ=;
 b=QIpCkxpL+KzDs40BBQP8LTmtY24f+7Fj9wEU6BvNYjtPKSmOiIUAu8R8fjNTREs/OMU4Te6cEPhg7rPrK83MpnrNmRuCd20Wd9unibvn9syouerlK7Ei3usQlVOKYCo9/KOH2fDSXgIWCHKSivkjr7BuquVwE1N1+a/PnvVvD2o=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by PA6PR08MB10858.eurprd08.prod.outlook.com (2603:10a6:102:3d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:28 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:28 +0000
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
Subject: [PATCH v5 9/9] drm/panthor: Add Mali v15 hardware support
Date: Tue, 24 Nov 2026 16:19:47 +0000
Message-ID: <20261124161952.1053586-10-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::17) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|PA6PR08MB10858:EE_|MAD0EPF000008A8:EE_|PAVPR08MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8a6668-d0df-4ec8-b066-08df4a46ef0e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|6133799003|22082099003|3023799007|56012099006|261021121427099003|261102123227099003|11063799006|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261026140227099003|261009223027099003|261026121527099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: FCeawEr8A9Q8ufdUiKt3zvJGRELMmvZZHV5Gk3qgF2O800f+apsmH58pu/IVzG14M+Ev7YCxC5yMfrX+PYb7junACbw+JKe1faz2gHKde+4wznLN6P2XtVY6fyGCX0fr8PhAn6d2S3HqDiiu3E6yYNsFHJiyF3ogAfKosLigDfb6IjJRAGIM412qvEmnWQcCRQyLqeqk9Sul0p0Ynabtn3tG4a76MLmqDtmqljjmAE6ZkEw6NC4zxvD60lLWcgfbeTwwX1/dPW2/o0KXLRfXtQVmPD/aUxl96Rg/Joaayt3UsTaRKur3lR2l63aDGb8/EfgiKQbKHpEyXD8aMCqvrzfObig8GrdU4DAQu+bDi68+14YhS5qB+8MOzNtZcul8AYJ3oxY0AFRYDQLRL9SSwutjhoVFZ2A54v82R7ADhUYBFevholJvVLrP5N1MxlJxhtI0xaouX0kOa1VRX8bEWRlAutbaqi/9xWPHYeoi/1qRP0GhclLW4bV8JG1nyeHZQzEbGhB95bL70aVLUMKCiOZQ0o3croa808fc6/kC/CO/mp3k2QDcQeQP+jYifOXSVJ7IBGJkkhyqGOYXlFCqE/aB/7KWNQXU98S/nPixflI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(6133799003)(22082099003)(3023799007)(56012099006)(261021121427099003)(261102123227099003)(11063799006)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261026140227099003)(261009223027099003)(261026121527099003)(10067099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: ZlcD2pBBqMRAZQwXfhanraNev59LvCBudMF8ZvxZSPbRkNaKuZAMeVp6pHAHdvXJ2ZZy1b1YRLkoD+6r14ZkB0aeHh8xr0lXjjTVKlGD/gDxlBvXdf/KW/XIxPAt0ys2Ys0Q8WPDf6s0Spt7U5nRqqZvDc24qhiPjlKClEurmkztJgV+WjEBGudso033xsuVDiUR9gckiosOGggcsnYkTd1Tpix8qVberXW7ppC2EaU47JjjM9nZD7L4FvUsmqI3KSP7gPeegc255Mpab33s4x9T66yn1TFvIxmWFd33hgmQ6E5MqV+8VpjgJIA95tqLJ0M4nBgE+fEIMwDa44Q8YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10858
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f36614de-d38f-4a0b-4f4a-08df4a46da78
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|14060799003|35042699022|7416014|23010399003|36860700016|82310400026|3023799007|10067099003|261021123027099003|261009223027099003|11063799006|56012099006|261021121427099003|261022075727099003|261022113327099003|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261026140227099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: 0cTLwCOzq8OPpIum2JEsg1DFb7LpNmxf75JId75FWqcOIuf5ITkRFBIc+ZYzFfhhsyZBFfFu5YoxktuNSH6EpBuVBFf0leoJNZEONa/wF88rlPHfWBY9dT0LH1Giw+Qk0jsIquYmpTxakutCQihNnmH6uB2WeX4kbXnUUqUeb8mMh2bEszEX0oQXnEeTuVBkPFmCWM6kLiwwb/y//dG/G8mmcgMHADeycoPo6JHOWjnBR1Do8uweXWrm46WRZAwSUPtjmg2gcvFDgfk680GV/R4eSuDaybL4EF7EBcOheDBQhvIucE5d7LXgj6gAfy9R8DHrrPu+V/d1l26eMsNdOhBsu5pkp2iAV1u9nem9aD66V0+8l1K1c9+RE/DH6c8cH8KVRnE1PsDtH436ckYEjjMIp/fGQoXQAVQ2T9bpfzhZx818UntuI9m0uTDGiHOHs0Sq6M9yLde1f2dF2Dwjez8ekzZsXUlkWOsV99U39rSoIcNKWP9a1f/BfnqUmr/bwD8aSUDCn1hkWwQNDLJO7Vf42WxHM+F2TZEAkJyRkFADqMb9nB49meJ+YfXcGi5lCWzmogzqPkc88RylnuvvnQDUI1iDrT01iv19pjON7ztiJKiwVrjMw6BFSUP6slnEXsiXM17whsWH1Mzsp3h1xA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(14060799003)(35042699022)(7416014)(23010399003)(36860700016)(82310400026)(3023799007)(10067099003)(261021123027099003)(261009223027099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022113327099003)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261026140227099003)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 76xvztowk0m3KGeOOnSbf4ok37y4LfZDhwC0r8xWl3UgAL3wB7cH7jeolgTPiTtgsZ3brQduwEBwevR+dlabP4xNLAqUyqylxvkws1qffl3ZWRSl5Hx1f4+MNy6cFLyD0mQ08DdG8hr7jG/qFPjoyX3eorbRIcq07XRvEiFMyCByEiWccEQ6IwD+032GdxIRGW0JeZ/A7kJrVsetEerW1c5tDjA04zILOxjkKU2rdz5PjU5xpnqHHYwdh3lV3gGAm7iZ1R/wE7xatHpkFyOpdGR77nonKZaepqhTDbL9EFhW2s6Zeg877zywXQB58qBJ+GwzbLBGfSvnzIDhQaSVbhQ7jWuKIHnM2K8yyuuRIj4xkmsmz97GZSgrXKFc/+SgivgnaBcpbVHVRF7kchiqu5plfYWIvL2vGW9DNHEYkfYBysTOGjaopavE3gfjeIlP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:21:02.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8a6668-d0df-4ec8-b066-08df4a46ef0e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9332
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
populate the GPU information exposed by the driver and its uAPI, as well
as add compatibility string for v15 GPUs.

Mali v15 also exposes a 64-bit GPU_ID register with a different field
layout from earlier GPUs. Add the register definitions and decoding
helpers for the new format, read GPU_ID_WIDE when the compatibility
value indicates a v15 GPU, and populate both the cached GPU_ID fields
and the uAPI gpu_id_wide field.

Bump drm minor to 10.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v5:
- Picked up R-b from Boris.
v4:
- squashed 64-bit GPU_ID decoding into this patch. Resetting R-bs as
  a result.
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

64-bit GPU_ID:
v3:
- Fix the missing blank line after declarations in GPU_ID decoding.
v2:
- Picked up R-b from Liviu.
- Rename the register macro from GPU_WIDE_ID to GPU_ID_WIDE.
- Rename the uAPI field from gpu_wide_id to gpu_id_wide.
- Print the upper 32 bits of GPU_ID_WIDE as the logged 'id' for v15 and
  later GPUs. Keep the existing output for earlier GPUs. Continuation
  fix for previous sashiko comment.
- Link: https://lore.kernel.org/all/20260922205659.3C4F21F000FF@smtp.kernel.org/
v1:
- Decode selected GPU_ID format after checking compatibility value.
- Document GPU_DISCOVER and GPU_CONTROL register offset differences
  between GPUs.
- Fix mask generation in panthor_gpu_discover_regs.h

 drivers/gpu/drm/panthor/panthor_drv.c         |   9 +-
 drivers/gpu/drm/panthor/panthor_fw.c          |   1 +
 drivers/gpu/drm/panthor/panthor_gpu.c         |   3 +-
 .../drm/panthor/panthor_gpu_discover_regs.h   |  42 +++++
 drivers/gpu/drm/panthor/panthor_heap.c        |   3 +-
 drivers/gpu/drm/panthor/panthor_hw.c          | 159 ++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_hw.h          |  13 ++
 include/uapi/drm/panthor_drm.h                |  23 ++-
 8 files changed, 230 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b4d3d339b04b4..94320799d5d75 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1788,6 +1788,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - adds thread_num_active_granularity, gpu_rev_wide, l2_features_wide,
+ *          and gpu_id_wide to drm_panthor_gpu_info
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1801,7 +1803,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,
@@ -1880,10 +1882,15 @@ static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 	.asn_hash = { 0xb, 0xe, 0x0, },
 };
 
+static const struct panthor_soc_data soc_data_gen5_am = {
+	.devfreq_disabled = true,
+};
+
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
+	{ .compatible = "arm,mali-gen5-am", .data = &soc_data_gen5_am, },
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
new file mode 100644
index 0000000000000..05e90950ec6ad
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
+#define __PANTHOR_GPU_DISCOVER_REGS_H__
+
+#include <linux/bits.h>
+
+#define GPU_ID_WIDE					0x0
+#define   GPU_WIDE_COMPAT				0xF
+#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
+#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
+#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
+#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
+#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
+#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
+#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
+
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
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
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
index 593bf6743d6df..fc81fabbe62fd 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -1,13 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 /* Copyright 2025 ARM Limited. All rights reserved. */
 
+#include <linux/bits.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/platform_device.h>
+#include <linux/wordpart.h>
 
 #include <drm/drm_print.h>
 
 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_discover_regs.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
@@ -73,6 +76,29 @@ static struct panthor_hw panthor_hw_arch_v14 = {
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
@@ -84,6 +110,11 @@ static struct panthor_hw_entry panthor_hw_match[] = {
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
@@ -151,8 +182,11 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
@@ -195,6 +229,18 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
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
@@ -218,7 +264,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
 	return 0;
 }
 
-static int panthor_gpu_info_init(struct panthor_device *ptdev)
+static void panthor_gpu_info_v10_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
@@ -259,31 +305,86 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
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
-	u32 major, minor, status;
+	u64 l2_features;
+	u32 prod_id, major, minor, status;
 	int ret;
 
 	ret = panthor_gpu_info_init(ptdev);
 	if (ret)
 		return ret;
 
+	/*
+	 * The logged 'id' contains four 4-bit architecture and product fields
+	 * in pre-v15 GPUs. In v15+ GPUs, this is now four 8-bit fields.
+	 * Preserve the pre-v15 format for compatibility. Tools decoding these
+	 * fields must handle the wider format for v15+ GPUs.
+	 */
+	if (ptdev->gpu_id.arch_major < 15)
+		prod_id = upper_16_bits(ptdev->gpu_info.gpu_id);
+	else
+		prod_id = upper_32_bits(ptdev->gpu_info.gpu_id_wide);
+
 	major = ptdev->gpu_id.ver_major;
 	minor = ptdev->gpu_id.ver_minor;
 	status = ptdev->gpu_id.ver_status;
+	l2_features = panthor_hw_get_l2_features(ptdev);
 
-	drm_info(&ptdev->base,
-		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
-		 major, minor, status);
+	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
+		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
 
 	drm_info(&ptdev->base,
-		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
-		 ptdev->gpu_info.l2_features,
+		 "Features: L2:%#llx Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
+		 l2_features,
 		 ptdev->gpu_info.tiler_features,
 		 ptdev->gpu_info.mem_features,
 		 ptdev->gpu_info.mmu_features,
@@ -323,18 +424,42 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
 	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);
 
-	if (!ptdev->gpu_info.gpu_id)
+	if (!gpu_id32)
 		return -ENXIO;
 
-	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
-	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
+		/*
+		 * GPU_DISCOVER register block always starts at offset zero,
+		 * so does the GPU_CONTROL register block on pre-v15 GPUs.
+		 */
+		void __iomem *discover = ptdev->iomem;
+		u64 gpu_id64 = gpu_read64(discover, GPU_ID_WIDE);
+
+		if (!gpu_id64)
+			return -ENXIO;
+
+		ptdev->gpu_info.gpu_id_wide = gpu_id64;
+
+		gpu_id->arch_major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
+		gpu_id->arch_minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
+		gpu_id->arch_rev = GPU_WIDE_ARCH_REV(gpu_id64);
+		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
+		gpu_id->ver_major = GPU_WIDE_VER_MAJOR(gpu_id64);
+		gpu_id->ver_minor = GPU_WIDE_VER_MINOR(gpu_id64);
+		gpu_id->ver_status = GPU_WIDE_VER_STATUS(gpu_id64);
+	} else {
+		ptdev->gpu_info.gpu_id = gpu_id32;
+
+		gpu_id->arch_major = GPU_ARCH_MAJOR(gpu_id32);
+		gpu_id->arch_minor = GPU_ARCH_MINOR(gpu_id32);
+		gpu_id->arch_rev = GPU_ARCH_REV(gpu_id32);
+		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
+		gpu_id->ver_major = GPU_VER_MAJOR(gpu_id32);
+		gpu_id->ver_minor = GPU_VER_MINOR(gpu_id32);
+		gpu_id->ver_status = GPU_VER_STATUS(gpu_id32);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index f93a6b16df2af..8d61a1099aa5e 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -105,4 +105,17 @@ static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
 	return data->devfreq_disabled;
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
index a2ff0f4ec6915..da9f8f82413cf 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -371,11 +371,30 @@ struct drm_panthor_gpu_info {
 	/** @core_features: Used to discriminate core variants when they exist. */
 	__u32 core_features;
 
-	/** @pad: MBZ. */
-	__u32 pad;
+	/** @thread_num_active_granularity: Granularity of number of active threads */
+	__u32 thread_num_active_granularity;
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
+
+	/**
+	 * @gpu_id_wide: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
+	 * this is populated.
+	 */
+	__u64 gpu_id_wide;
+#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
+#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
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

