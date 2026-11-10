Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE619606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XG/NLlOG;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=XG/NLlOG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB0810F7B7;
	Tue, 10 Nov 2026 15:41:40 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013038.outbound.protection.outlook.com
 [40.107.162.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC1510F7B6
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YQNtuMISvjSs+ln1B2IKRDmkx1yRHxycB6pGaTngKjhLbVkuo7mEJZ9r3aDna7yc5XnyukUPsLAiBqvU2k2jyL58mBsfgnZxVuEahxxWz4UOTVo5lFU4r1IWnGJGpuOdd5a4mPFTwi8aGmyQp+gKy4ie9gIsqLqIt6r0q+sedsDol5LKVTofmJPefOir7HasbVT5heplwodXAuTDt5tuFGx27zztqEotuvT3RxP7BZLEh261bQb5THabt8xV0b8s6rW+CUENxMhpF3QjHqyPfZwpjqMGkYFzRKIRzS9GjIF2gV7JlfCXAbdqcqmNE6/UNjfKrarzxOqajzmJu/jSAA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvrOkwwnhC+2fEKLFV4ZES5VHp5/SdAHaXPVrdFDTis=;
 b=ksvn/rutY1nno4b2N+7DeIR3/LgHXjyV8yqxMODkapuL17wU8J32xtkteQX2S5SjbUZYyLasuD3CvYrgC9YLPcVRj4PmQ2eMJK2pzAzbjlNL89ziHmMmSHijnxKoCv5lo0Y4e5q7bDA82WVT59va6oaLJVY3e2P1ZPMSwctJPvaXuWwEMd5/ixWlvMmHlJrWGD+Plrx4/8NSJN2wxvhP2twquYona7Hssn14APXn1VYGELh+0ZlJ152DCpatYzTTDX7hFxcteyzU6norfDBr+RDzAbHUEDVTbObZUWpkWnvrXwey0v/tdr4xPpcNUij+nCjX+CUzz1iklrpz+QVQDg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvrOkwwnhC+2fEKLFV4ZES5VHp5/SdAHaXPVrdFDTis=;
 b=XG/NLlOGtn+eoFGgWf0HmdAw+ZOR5Bu4lhGaT3eHjcobulZd8Mph6EdEp4cVzwVLx+Wr6i5GucLQAGTA6E8XPIVVhi+uB4K7LSeGtAzt6Bcrf0FAajmttaj7P0Qhiq5ZSpGNuCW3MRa8RBGOKTPGhbIrNUGy23fh9QKN9xsBLUE=
Received: from DU7P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::13)
 by MIWPR08MB279469.eurprd08.prod.outlook.com (2603:10a6:290:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:41:24 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::1a) by DU7P191CA0009.outlook.office365.com
 (2603:10a6:10:54e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xX0FwXS2q6mVom5mYVogpE91VwwA3lN0l3qDkD1n33g8LgNlSE9gJIVVosB01OU6Rh++LIdv0kNNEi2zHcs/Yr1f0Pzd9aJ6zui+yLxYzTnzWH9B64xj+AU1nYS0C/c4w7Rxho5NaHVrdWHm7HZU2EaHrqVsHgCteW9h9b+llU5Hwae5tvCbFArQHoF3NG9QiAbiHZmjqvm24mmkVCkaA9RyOz5n0XvzZSWt9KtNys0go3MVaBwP/Ff/s0JXFry7tKwsqD5MtTB4npkSd17VLMxk2vs4EaYoFau9u7ni8ewyzzb6bsH1ZNeH1X+F+cntf3qwmW0h+IAxbEvRrEdidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvrOkwwnhC+2fEKLFV4ZES5VHp5/SdAHaXPVrdFDTis=;
 b=k1bxYnTWZ0q/Iq1+p90z4h/qU24gbOCJcmX0EBllloewWZFD07XeeCY/jwPiuEz5+BuSRjLmVujdM3LO0mTqHD8kDn1I63dz0ZTp1U3PnBNpXKnT/E1SCeP3JDW/OS4C32AAmEpDsuiZ5LvOF82UOAC/E6ocVT8rfIU06LJumuK+yxKYXZXarZLAd4feNgk7f75Lsu6jV4UTpuCteEfmcV5G9kyxuUKNGTBbZND4TzCloPO17fsTnzjpRK4uc88GhxS2xNS0GKwp1xA7Kld3J1F3HRA+RFeXlQb7hjMPTxbbstxYZHrvMQa+iSFogEEconUQcnE5aaUqV2nzUD62yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvrOkwwnhC+2fEKLFV4ZES5VHp5/SdAHaXPVrdFDTis=;
 b=XG/NLlOGtn+eoFGgWf0HmdAw+ZOR5Bu4lhGaT3eHjcobulZd8Mph6EdEp4cVzwVLx+Wr6i5GucLQAGTA6E8XPIVVhi+uB4K7LSeGtAzt6Bcrf0FAajmttaj7P0Qhiq5ZSpGNuCW3MRa8RBGOKTPGhbIrNUGy23fh9QKN9xsBLUE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:51 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:51 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 15/28] drm/panthor: Add AM message helpers
Date: Tue, 10 Nov 2026 15:38:36 +0000
Message-ID: <20261110153907.3241978-16-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|DB1PEPF000509F4:EE_|MIWPR08MB279469:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf57281-4714-413e-a27f-08df3f41131d
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|261022105027099003|5023799004|261102123227099003|261026121527099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: 0qXDyWoMqWmeTHSNfk0HsaxhJtPYuuW8SVFKAGCcfe8UZZfTxDO/eHX2UAPSXmjB3Q51c6CIlvwpP1ErE0k2lViAdtcIg1aGuh+DlJ0wZWFN1UT/lmcs5evaihNcncw2BtPx6NpupFcV5YAD2YDZ781Z8zWqVII27EriVeBIm417QxqAE6mCmAo7FUzcyuzo3H1ah6UVt+xQiqPwS5c3sgN7dGEDZwvRZ1Hc9EJD+WrSva8jzGJX4kzu2nFA3BYpiLhV7WJGWZYyqA8nle6TLHWzvk3cYcgHt9W7wDybRr6zXrnOOee78PEJLshRDpSShBFzOODFLEBI/8VVTHJOYq3W6NfF5X+Ukf7n88xwFnQUD6tkDuwjAucjNvVJTv7/pP4CLQLoHQU23mFr0T/Xcq3qvIQAj4sZ28TzGUvxXqdGn8wvWoL4dLYWw3X+DQy5RxeMTlcFAgWs3GeBC/+NHOuwhT//eioB69iH5OtRJABvEgYoK/aTrUoo2At59VEU7C6ePGLH7Er5X0D/Vlu9OEjQWgUqBB1yM8CQN/UMb/HUUeLXOoeB1kr4w2WqP/C6vrPifhH7NwLRkqt0HR35z9oODeFfmfrYQ4DAIfObLvg4C+ZCNLTdZpzgJ7LEQ7trfIuJUxoxAdpaUT+NA24Ud/11dylMu54Zmy6QQX4AGXU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261022105027099003)(5023799004)(261102123227099003)(261026121527099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261022075727099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: VbBplCHG4gOpKswcke29hOYDeQQRRlDg5qko7xxujZYyPkBktGcmcvzbJV+/Y5XiXQyUum4HvoAhKitOtcRkKNPBsVbWw4Gynm+/ADZvpAe0DlSe1vyFcMBLx3qFDOcuku1wVsQZR8XPzx+LIsYIjNGDo1xT45hQ+1g5KBINpnWvvufC9hG18gzRsy/2E2tFV46px9TyWrk4G36Rkv5H4Rk0OJKFKRipcmrAiAfFTV0Wf4w1GXPGtubaGoT23e/f+zDqia48AjsljxdBz/9O78TkOZOGQXJJ876IhGxc0ZCjsAw8YNGsivZ83eiHf/00IMmuculm8R7xtAMm1j0yig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6df8c36f-e3ec-4b38-a67a-08df3f40ffc2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|14060799003|1800799024|376014|35042699022|18002099003|22082099003|3023799007|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|10067099003|261009223027099003|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: lCoeIY4sMiPzCScYpNzDANzhbAcllvXbw3yI8bhbI7IknliLhlldTI6h1F7v7/WNy0EZsbtB+3cmj2fdrC3aUaIObx5Yazh5GwsYiPggNgIBCB2mzODCWHsqoIcQIVg8/FP6DyK5ArzKCZMc9kKgfxo1jiIWYGuN+Qoawy0vNc3xvTE/bKV4F+bmSHdNxirghamP8MnhuPNwLkTVvik4l5b6rg6sw15OINRWn3gl8/rA1aIY6Eo9QMkByWwdZ7Itt6yhh3PvHHEVdvX+9hUAJUXb1MgeWQm+AX2A4kETrP/mVANJ/6pORnAbCWpiLIVnkoUYisYa0//EBuHY8vyshyLzPJOM0jj87j3sCavbjP9P1TOLzEybIcGDrXMyV1fCbgIpoCX8M+/qSAsYVavkHdsJza6DGMN3GqsquDnDFDyTfSnG5LjxfUUulX+4g2YM5rFuChz7hjHyT7UhBHNYC9RKp9eGb1Dc0udb5r3EBPVN49XPgUMpsF0Enq2Iqgbncw0iUVodxTFkg7J7XkEbG2kJPSNWcQzNizHeNC7wvfcWZmRLmk9CpoU2vEWdmQ2GMmxlv8V+L689t5Xe3tQw9hkxE7UTZF+gNmn8mV7BrjlbuZNp7VCO9UjsljPEkyQBtpqoljdvo3USo26bbvPL/DSu5EOnXTPEn1wKzcGZHMLqbOmGsX2quvImR46QDXfHhM630RA2jVzpMCDVDDE9WA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(14060799003)(1800799024)(376014)(35042699022)(18002099003)(22082099003)(3023799007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qd91FDI9eqdKaSqkUjQn20w2n775O6Ea1G0MK0QWDFarFfxHO3U2yIFUHQuBkVwq0RoWoHh++xevMV31AQ9DO+PNnRqBoGDy7eD0kldSn3pZjDuJf6vY/kxgxxbm2u5pXlnxrriNTkmAucmD/62/O1qZDDnnbiGYPKNEVDTQhIYdYdT9otdcgv2rkOpMtX1fuG7Jo3J4k2EDqmIb6LeiP+Z/eLssXPmONPWcLSolNraq8oektIBEVJDP/M5nLW4m2Lxxf8pD0n+QE/L8ZPaOp198CFV/5NYI2RjjDhJW/Eo3vnNFGg6NMcFhlYK8Y8Sw8DYQzVuUJdABSltqv+B/5wsDJbdLtvcdP7TD6Si5/NmC85mBsxVls/aW/Pw7VXVHTXD7z4rUw1aqlDC4arvQjHclNpPs8fy70O8DTPcQBGQvbkF0vWzQH9hA/VGrqCQB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:23.4794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf57281-4714-413e-a27f-08df3f41131d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB279469
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

Add a shared helper layer for the AM_MESSAGE registers used by v15 GPUs
to coordinate between access windows to enable virtualisation of the
GPU.

The helper defines message IDs, register accessors, version negotiation,
and FIFO-backed sending. Outgoing messages are serialized with a
spinlock, written in the required register order, and queued for later
retry when the hardware outgoing slot is busy.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Tighten protocol validation flow by separating the remote version and
  reply_version to allow local validation of protocol support.
v1:
- Raises minimum/current protocol support to v2. (v1 was for G78AE)
- Removes ARB_VM_GPU_STOP.
- Return -ENOSPC instead of -ENOMEM on full outgoing FIFO.

 drivers/gpu/drm/panthor/panthor_am_msg.h | 182 +++++++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/panthor_am_msg.h

diff --git a/drivers/gpu/drm/panthor/panthor_am_msg.h b/drivers/gpu/drm/panthor/panthor_am_msg.h
new file mode 100644
index 0000000000000..bc828e254517c
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_am_msg.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_AM_H__
+#define __PANTHOR_AM_H__
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/kfifo.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+/* Protocol versioning */
+#define ARB_VM_PROTOCOL_V1			0x1
+#define ARB_VM_PROTOCOL_V2			0x2
+
+#define AM_MSG_MIN_SUPPORTED_VERSION		ARB_VM_PROTOCOL_V2
+#define AM_MSG_CURRENT_VERSION			ARB_VM_PROTOCOL_V2
+
+#define AM_INCOMING_MESSAGE0			0x0
+#define AM_INCOMING_MESSAGE1			0x4
+#define AM_OUTGOING_MESSAGE_STATUS		0x8
+#define AM_OUTGOING_MESSAGE0			0xc
+#define AM_OUTGOING_MESSAGE1			0x10
+
+/* Arbiter to VM message IDs */
+#define ARB_VM_INIT				0x04
+
+/* VM to Arbiter message IDs */
+#define VM_ARB_INIT				0x05
+#define VM_ARB_GPU_REQUEST			0x08
+#define VM_ARB_GPU_STOPPED			0x09
+
+#define AM_MSG_ID_MASK				GENMASK(7, 0)
+#define AM_MSG_ACK_MASK				BIT(8)
+#define AM_MSG_VERSION_MASK			GENMASK(15, 9)
+
+#define AM_MSG_ID_GET(x)			FIELD_GET(AM_MSG_ID_MASK, x)
+#define AM_MSG_ACK_GET(x)			FIELD_GET(AM_MSG_ACK_MASK, x)
+#define AM_MSG_VERSION_GET(x)			FIELD_GET(AM_MSG_VERSION_MASK, x)
+
+#define AM_MSG_INIT_MAKE(_id, _ack, _version) \
+	((_id) | FIELD_PREP(AM_MSG_ACK_MASK, _ack) | FIELD_PREP(AM_MSG_VERSION_MASK, _version))
+
+#define ARB_VM_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(ARB_VM_INIT, _ack, _version)
+#define VM_ARB_INIT_MAKE(_ack, _version)	AM_MSG_INIT_MAKE(VM_ARB_INIT, _ack, _version)
+
+#define AM_MSG_DEFAULT_FIFO_SIZE		4
+
+struct panthor_am_msg {
+	/** @iomem: CPU mapping of the AM_MESSAGE registers */
+	void __iomem *iomem;
+
+	/** @lock: Lock for send_fifo and outgoing message register */
+	spinlock_t lock;
+
+	/** @send_fifo: FIFO to queue of messages to send */
+	DECLARE_KFIFO(send_fifo, u64, AM_MSG_DEFAULT_FIFO_SIZE);
+
+	/** @version: Protocol version */
+	u8 version;
+};
+
+static inline void panthor_am_msg_init(struct panthor_am_msg *msg,
+				       void __iomem *iomem)
+{
+	spin_lock_init(&msg->lock);
+	INIT_KFIFO(msg->send_fifo);
+	msg->iomem = iomem;
+	msg->version = 0;
+}
+
+static inline bool panthor_am_msg_pending(struct panthor_am_msg *msg)
+{
+	return !!gpu_read(msg->iomem, AM_OUTGOING_MESSAGE_STATUS);
+}
+
+static inline u64 panthor_am_msg_read(struct panthor_am_msg *msg)
+{
+	return gpu_read64(msg->iomem, AM_INCOMING_MESSAGE0);
+}
+
+static inline void panthor_am_msg_write(struct panthor_am_msg *msg, u64 message)
+{
+	lockdep_assert_held(&msg->lock);
+
+	/*
+	 * Registers must be written in this exact order to prevent interrupts
+	 * being raised before the complete message is written.
+	 */
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE0, lower_32_bits(message));
+	gpu_write(msg->iomem, AM_OUTGOING_MESSAGE1, upper_32_bits(message));
+}
+
+static inline int panthor_am_msg_retry(struct panthor_am_msg *msg)
+{
+	u64 message;
+
+	guard(spinlock_irqsave)(&msg->lock);
+
+	if (kfifo_is_empty(&msg->send_fifo))
+		return 0;
+
+	if (panthor_am_msg_pending(msg))
+		return -EBUSY;
+
+	/* FIFO should never be empty at this point */
+	if (!kfifo_get(&msg->send_fifo, &message))
+		return -EINVAL;
+
+	panthor_am_msg_write(msg, message);
+
+	/* There are still messages in the FIFO, notify caller to retry again */
+	if (!kfifo_is_empty(&msg->send_fifo))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static inline int panthor_am_msg_send(struct panthor_am_msg *msg, u64 message)
+{
+	guard(spinlock_irqsave)(&msg->lock);
+
+	/*
+	 * If there already is a pending message in the FIFO or the outgoing
+	 * message is still not read by the receipient, add to the FIFO.
+	 */
+	if (!kfifo_is_empty(&msg->send_fifo) || panthor_am_msg_pending(msg)) {
+		if (!kfifo_put(&msg->send_fifo, message))
+			return -ENOSPC;
+
+		/*
+		 * return -EBUSY to indicate to the caller to schedule work to
+		 * retry sending messages in the FIFO.
+		 */
+		return -EBUSY;
+	}
+
+	/* We are free to write to AM_OUTGOING_MESSAGE */
+	panthor_am_msg_write(msg, message);
+
+	return 0;
+}
+
+static inline int panthor_am_msg_version_validate(struct panthor_am_msg *msg,
+						  u8 version, bool acked,
+						  u8 *reply_version)
+{
+	guard(spinlock_irqsave)(&msg->lock);
+
+	if (reply_version == NULL)
+		return -EINVAL;
+
+	msg->version = version;
+
+	if (version < AM_MSG_MIN_SUPPORTED_VERSION) {
+		*reply_version = AM_MSG_MIN_SUPPORTED_VERSION;
+		return -EOPNOTSUPP;
+	}
+
+	if (acked && version > AM_MSG_CURRENT_VERSION) {
+		*reply_version = AM_MSG_CURRENT_VERSION;
+		return -EOPNOTSUPP;
+	}
+
+	msg->version = min(version, AM_MSG_CURRENT_VERSION);
+	*reply_version = msg->version;
+
+	return 0;
+}
+
+static inline bool panthor_am_msg_supported(struct panthor_am_msg *msg)
+{
+	guard(spinlock_irqsave)(&msg->lock);
+
+	return msg->version >= AM_MSG_MIN_SUPPORTED_VERSION &&
+	       msg->version <= AM_MSG_CURRENT_VERSION;
+}
+
+#endif
-- 
2.43.0

