Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE43606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=K5nwUPyO;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=K5nwUPyO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1005110F6E9;
	Tue, 27 Oct 2026 16:23:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31AEB10F723
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:22:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=JSTKC+8+yP2/1D35HBpIbhE/B/1Peap7HiDvKNlnzXs35qEOs0plNFhqblXgMW/c2qhevKyCjZJp8TybDN8S4spGZCcDOd+7EToNDsDGmZyhOeh7nNsU3nJBibWqXlVEJ0RO8E7G413ArfjpVjQzSVEQFAeIau3N43HuSuiWHWh1j+C/rJGAbMDMc7pAOPzolHk8ZazdzBhe56ksXl4XWhFlWI7kFuCCfcBkwEtk7CYgT3354e/X4WpUcHAMpFAG9ZUtuuTrmtLFdGxP52MQe14Y9tS7Lkk309MKFzH0fxZvcNze8wiEDxq9SVqBXcfiNl/KZooJzuqugc99QLk1uA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHXr4zS4rjAU69C7jHth3kxYbtTZ9bD3PP5oOO74Qqg=;
 b=DIUaweJLUUVDUoRWEdQ9qImF2o6KsaAdopsTeoIfy7zpGOe4f4Bb2+kelTMsahDzXKMc7lm2n0RdZO5Otdu8AJS858D6W5ycvg1hGXba2VMLteltsIlQW/XfQEsx0gpGNYQcm+6k3kjy23sFeLPcw8wobmQ+HXBnpg/DnMNoQXHZ8W4yghap5MBpFBfMYVU7MlyAcqBeg7LSfN1pehSJ1FwEzOX/HGc015554omUa8OYGBS7MZ/UaOE/L7u6okNtPI/TXpGNyYE1ThBSXO1dSvNPMOBBsTKKGRTnRJyz1e9+oRS7wMyuJMKlyrwuajIm66xZKbhnCnKM1aBAkG3+Qg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHXr4zS4rjAU69C7jHth3kxYbtTZ9bD3PP5oOO74Qqg=;
 b=K5nwUPyOKazqyNP8xta2ZcSTl/pzZtb2f6j9cPnpFpbR9pKKuI3AQ9+JT89kWcy/sqMScSeKntCWO4BEel4QtQSHjoDXN6WysONkLzRa8M/e7XClWTmI2oPFlNGZbW+Hv6wQ/InZrMqKC1chSGzLVwXfboWLNusJqiCkSNpwsM8=
Received: from DUZP191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::28)
 by VE1PR08MB5821.eurprd08.prod.outlook.com (2603:10a6:800:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:46 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::71) by DUZP191CA0017.outlook.office365.com
 (2603:10a6:10:4f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 16:22:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Tue, 27 Oct 2026 16:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpbVSTa94S2f2uC19nB9kL2YE8BeRZe1Z38BDsbfQOAS6uFVIOji8tusAjo1O93gzUnqN72uK55OLLGUYXPuWwdOM8x0YuCQPrYhPgPCMF27CzgOpWwGzVulKrcikOOK2iozy3YCM1QM+HTye3UE3jpWbYemP4yEsfElJf/zJ//B83acLAvfRDSmAqaLl37SYazRrNmaflk+xd1yHZlKFCU8fqIDBe8BA0uTIGP0CVyWkzn26PmmHOAz7QBCGwM8f5aD8gj+jdSC2f4ajIuaxWukAhLIFxofdmULSbcTvZq3GAQI0dGbYn87ukvesYwPel1XKN5xrLAJ2UlaW/MPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHXr4zS4rjAU69C7jHth3kxYbtTZ9bD3PP5oOO74Qqg=;
 b=ptWMDdJZsalwPpuraJGmEbK9JAtDoVv4mQ6sVNJIvS54somaijEoxH2GqJLqi4qRUty4dB0arsNiu62BI6AdXqaL62l42q1oCHwdgpRiU4QlPlK7zJ8BHcTAAHKcorumLzVA3/KFDUmeOQNTTCf8nzO1uzRYa/KT/wOBZHbcpwJDc2WDXbXo12YansSJfUBxkEawqKfVtd1JzTrWVU0MWLQN0aGy40Y295GEnkeO7P62K4kx11OfFzWcLJ+D7WRpGWC7QtrEUJFh72JCUnw4UoSLoteGYLERhAmNTzYg+pRwKwbEzj6N3AjjvuXrNjdzqELtw0jMILuBElzyGVv2OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHXr4zS4rjAU69C7jHth3kxYbtTZ9bD3PP5oOO74Qqg=;
 b=K5nwUPyOKazqyNP8xta2ZcSTl/pzZtb2f6j9cPnpFpbR9pKKuI3AQ9+JT89kWcy/sqMScSeKntCWO4BEel4QtQSHjoDXN6WysONkLzRa8M/e7XClWTmI2oPFlNGZbW+Hv6wQ/InZrMqKC1chSGzLVwXfboWLNusJqiCkSNpwsM8=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by ZR6PR08MB694313.eurprd08.prod.outlook.com
 (2603:10a6:910:e0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 16:22:12 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 16:22:11 +0000
From: Bence Csokas <bence.csokas@arm.com>
Subject: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Date: Tue, 27 Oct 2026 17:22:00 +0100
Message-Id: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKnP4GoC/12OzQ7CIBCEX8VwFgPU0uLJ9zAe6LJYTFoMtI2m6
 bsL7cGf48zuNzMziRgcRnLazSTg5KLzfRLFfkeg1f0NqTNJE8GEZLWQFK2hehy8DYi0kjK5WJt
 aa5KQR0Drnmvc5brpODZ3hCFn5I9GR6RN0D202ep0HDDkQ+vi4MNrHTLxHLB1KqZ+OydOGQUJB
 XAFUDFx1qE7gO9IbpzEF8rLP1QklEkjQBleHiv7QZdleQM0JmONDAEAAA==
X-Change-ID: 20260826-efd-autofree-766608e8d8aa
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Bence Csokas <bence.csokas@arm.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO6P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::13) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GV1PR08MB10455:EE_|ZR6PR08MB694313:EE_|DB1PEPF000509FE:EE_|VE1PR08MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: d3539ff9-e82d-4afb-b772-08df34468934
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|11063799006|261026121527099003|56012099006|18002099003|10067099003|261022105027099003|261009223027099003|261009221227099003|261021123027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info-Original: 85FTzqjnj5baHpw/jgYY/jJ+U56VZ/2KysLq0rLuHC9JneQVSS5ogL5JajxJAymrKc2eUngvZyQlX2qouevKX81cgDZ7mWqf+tycPNJeAmV6HGEe43lbP+61Pp+6y2OQeENZYBp3xA4spCDDuENUlGhNSNMIIeOBAnj/VCMGhPSMzQWb1PUjQLqpok3i5rRhBiqp9+a0E1iAYsdob32dvpBH5WnDrVNtkoOoB8SplGn9Qew6HPyzeIsMEWXqLhebjPDshhtxIMOPZKA1sLv0p+JIWjyiDyHMhfS1IOYiLcXocB7E0xbBZh8B6Mr8BAGGjbGiGUPFJwv49AqDAj3kAjaZdC6bjH+bbpOan+hC+uzPW/LVQfjw3VeER6KFmxmsjitR2JVLzfVtLxl06oO/LIw+GNi/Bed+LgekHhxZnyq0sn05KUvXUa4IrIq61Mo1/s0H5MTWUs2FIonnSEpz7t7lptD0vRFcH1okQIpftuQBcyT1FSBgUPrDlulJCFg5YQQCG3is7E/mCDNUy7i1ewPVRM0x796iLu669QVColW0XAbcYuyE/6IvbVujLTUPNib88vdH83gg6lrlYXAEXwzs84wtyvRxnyFUylQhrOEY5JIfQDCZctA/xhcxHLSA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV1PR08MB10455.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(11063799006)(261026121527099003)(56012099006)(18002099003)(10067099003)(261022105027099003)(261009223027099003)(261009221227099003)(261021123027099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: X8bAM4AWJZmt+3ubit1Fag814x+h+3CIHcaA2umVCiL+rsytRRgDVnosCZqwvs0f7IYrkv6ArLKyj2fEhqFKZfOF4T0J25i30AUlXgT31RlVgSfZ9HdyMFYYn1uVy2/DtwycTpwmmJejDpAl0tkVYnM3FLQqj4F99aU6EH9y3WwLHjgxqpknIqr/U4RUyctOFuPMrWxUkwP8Jl+e5Qm7CapaHshsJivTQnQxhtRhGM6ZVg4+m4z9o78WO/xnBHIcIEL5B42JuDd4p9ekT0AqGEzOF94KghvkEaUFk9MrTkaj7vjd6HZKN7mSvdx9+f9pUi2jfn9nFLWU2SjoATi7cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB694313
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 009665a2-7a3b-4b35-968e-08df34467470
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700016|35042699022|7416014|376014|23010399003|1800799024|11063799006|56012099006|261026140227099003|18002099003|10067099003|261022105027099003|261009221227099003|261021121427099003|261009223027099003|261021123027099003|261026121527099003|13003099007;
X-Microsoft-Antispam-Message-Info: hLcZ3hHURdIrDUHbCq5XmqR+cXPs/TsAdk16PENmbxQuSo/Ly99Kxc6Z3DBa2XQC8hsIP6xks4N7VZhsrIXkYxj0X5bnw301BVXREy6tP32iStSV9F78wEdLDj5eOg/MyWnynfU6AtD/7HUbgTLfTPghzGZEO4I9MiWWOHWKpjElLGHRUiW+7YeIFnfCqagOQmbeUA54aFD5BAcELJa5TmSOgbAbZvMgo72/UXgiFUKQfYDisQO86Z3l0q8cghM+yXVwfxWX50norFnR9M8kT1UJZLHuw1becZIECl/QWO+LD4yC/mIAC5kQKJFZdK5dWOzf/9s6RBO2rhCMmVRO6kNzK0Bk6JqzaJZMmIPV4sPkFZrogAt9mQUUxYtPPqdrQMccIiM0aCurK64wA7mBwsT8k4YRcidMITha9e9tsc+fPYy4a0fj+jZ5Hzllh12ANFu82qH9aTfBejqKeJchq1Qz/CT9u5I2HhVbWmm4eJPHuCG+eoBvagRcrHOvMUv1Uo5brpulMAwsXYGhMYyHhOCyhFZc9lSjn+cYi0ldQtwkpiFzkT88vUtsDNANTa2rDKk+IAQd91fLtR/qY7QCx1Q/69Jh3uapnCk95E8DPUVOtLy0Rxrdzx7JDlaVDzzKpMMjvqpk1DNP8JiEH6pysQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700016)(35042699022)(7416014)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(261026140227099003)(18002099003)(10067099003)(261022105027099003)(261009221227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261026121527099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fM73GWlPiIvU4rtf9+ec89hFeO0zoMvCw9rWorRoN+W0o4kL/qRSVqXCDD8584w2qi1E32CSsIaTKKJamvJryiVLycPaNIvva2d4YGC9HhizSfGqScVPRd6TVu2gGsp5Ja9/PTQ6Ezqlej4Kfk3wh53waKIBg++nnKchyhYjPz3T8kRVLEBpKW3sWJMzV7p9zbiw4JZuruyQwHqu7sBt5v0N0m5jMJ6kaZEkRhsz9nsqk17vkZx1V6UwgShCWlLCTEdBgKSqWACBCXnPfY+xbhFzHaxnkRZPpet37tHSF8K52VPtW0yCD0D4YHakI6zwb6R6w9aeYI5gdIP63XYE7UhpeesthrMCG+xNCcVO+H2xpn2rJPpV36NrkDZAZVA4Ng/tuHwkV+U2WOBBfO7WRDCw/8XUFbWLDz9QRLkxaK/VthrN7lM42yzQ1n7SAo4K
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 16:22:46.3199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3539ff9-e82d-4afb-b772-08df34468934
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5821
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

Add __free() support to eventfd and update drm_syncobj to use it as an
example consumer.

A minor discrepancy I encountered is whether to put a semicolon after
DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
I followed the example set in core-api/cleanup.rst, and omitted it.

Signed-off-by: Bence Csokas <bence.csokas@arm.com>
---
Changes in v3:
- IS_ERR_OR_NULL() moved into DEFINE_FREE() body
- Link to v2: https://patch.msgid.link/20260915-efd-autofree-v2-0-06d2c9d1547f@arm.com

Changes in v2:
- IS_ERR_OR_NULL() check, instead of NULLing out pointer on IS_ERR
- Link to v1: https://patch.msgid.link/20260909-efd-autofree-v1-0-c6c3c19cc702@arm.com

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org

---
Bence Csokas (2):
      eventfd: Add scope-based cleanup capability
      drm/syncobj: Use scope-based cleanup for eventfd_ctx

 drivers/gpu/drm/drm_syncobj.c | 8 +++-----
 include/linux/eventfd.h       | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20260826-efd-autofree-766608e8d8aa

Best regards,
--  
Bence Csokas <bence.csokas@arm.com>

