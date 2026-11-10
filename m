Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7219606A333
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YsK3KHFe;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=YsK3KHFe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281DF10F799;
	Tue, 10 Nov 2026 15:41:01 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013064.outbound.protection.outlook.com
 [52.101.83.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033DB10F799
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:40:49 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=n8E2L5KLukCb5B6nN9aigDjGck0zhcc+6XtdItIQuHHoajRS+SfVe/zp9ZMNsOg4+JT7Xf4yGwFnd2FdgWfTbX7T3E8RB8hXxMxOB6NOp81mzxdbMP+26iVaRmjHdbhcbUe/5UsnGdYHH3Pac2ZcKHqY5Kugob5D54WW1LS4KGZqQW1oTKtK/UZwXrv4g9wZ4fzCqwaMQPoP3ZUPHo7k5MP6fFCDFbM4xAryslqGlTPgnlsaXfDG1ab4UytYr4pCT12oeMzLVSaHh6tc0Lbhgt6d/y1jDWbjccRMKeTKiva89mIbmLzytY3kr1ScXBOUeZNy/3GnJuI5PUGWKi3/WA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcuPGAEOkQUt3riA01fEKj4eiLush5ZA51/BstSwJSQ=;
 b=qt8XldrAG4+UjY3LEx2IKPZiOt185OjNG0bHiXa9tRNbg4sPrJnSvi5zPhOawkFgcRSbTI38O/Z+mLY4OUskkDttV62Fj0QAIMyS1ZmnN4PnhD+xlDIhjKqiwIbCP0g49maD2jvE1N7R9fZoeGoVZWW81s0uz1MOcwvdrMOgxKR7pqPTM0xvE9CwGTaFAe9NuG9iU0I1gzVcRMt5c9AAJ5UpLVNx7SYI64gARQpWkMINP6Og0V9OwP+Ywa7PCZPpRpw/5TR+1D25WKfYe8tjZWzExpk7QUtnokLbxBk/0S0Fln3bCQDpkKbZcA7ZLD8hPILyFwSk9Vkl34+ubGh8TQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcuPGAEOkQUt3riA01fEKj4eiLush5ZA51/BstSwJSQ=;
 b=YsK3KHFeyHFZ+JHSMDCS85bEcnZCpOifoc9ECOQ6YphqPgMVUqA8fPTo4BlAx+9iDqmJrcosXGC5EYvWE+egUe7v8qBe3YCsH+z0zgVlHKLfap0txe4ezUK9VOnV9/W7D2+mBdYYPJgwnOtTBToV544O4V1fUxQuontd+2DCppM=
Received: from VI1PR06CA0147.eurprd06.prod.outlook.com (2603:10a6:803:a0::40)
 by AS1PR08MB7586.eurprd08.prod.outlook.com (2603:10a6:20b:472::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 15:40:40 +0000
Received: from MI3PEPF00008491.eurprd03.prod.outlook.com
 (2603:10a6:803:a0:cafe::81) by VI1PR06CA0147.outlook.office365.com
 (2603:10a6:803:a0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:40:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008491.mail.protection.outlook.com (10.167.240.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnUqFBI8/VYM1OSCgVhLl3lk/1WlAU3yj3EAJody6/Cv26jzcVla67743ek57ycXga3M5DeJBU+cHtKccvY4bVkOanHxthV50TOIVH4eJXkjHiOHYDzQkQCVPzuktPyzuP7hit28gy6md+Q7vSmxn7AJ2yBZvqSVZMSgLlxICWnL9BzdVWKq48b9YWZovbb0FMT/2anW3jxc4IKE2Kg8rk4vfGiJFd0o/SiDCtX6geWd7FUyEY15nd2zWvQlafvXaNtgtzUzwK5Ie1y947k5l9LsmARkXIuzYJFnAV94wnm2in9Mx+W8gurrVPUbQ9hObg3EyLBZqflLyNtpp6MSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcuPGAEOkQUt3riA01fEKj4eiLush5ZA51/BstSwJSQ=;
 b=u/mC9PMsquDx4D/TpH24/DtP7wrKUi89UMPC9f0OEABmYw94uma/M8a8xwsvBmHZWdz/l2pmaPtvAVje997wquNhvRr59U4vlimpEvCKPu2PyIm17dKL49IQ90f5X65sfVbva+ou5tIu4R3+f4tg10AETVozbBKikJ1lE057SBSrl8Y4D86LuDfbw4TCxZk2slB/Hdb9oGXz+91JQBf/Pae8dGIfjOCHzQx3CVgibZbu9dCml6fpYzFGnZxJK/cH8DmO/HKikEbu5/lvfnH/TOKL2Qh93qyQmaDXKkYZYBrVKf6RQ6ersj9PbIfObaeMlcBz2zFqvwl7hzrVG2WAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcuPGAEOkQUt3riA01fEKj4eiLush5ZA51/BstSwJSQ=;
 b=YsK3KHFeyHFZ+JHSMDCS85bEcnZCpOifoc9ECOQ6YphqPgMVUqA8fPTo4BlAx+9iDqmJrcosXGC5EYvWE+egUe7v8qBe3YCsH+z0zgVlHKLfap0txe4ezUK9VOnV9/W7D2+mBdYYPJgwnOtTBToV544O4V1fUxQuontd+2DCppM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by MI9PR08MB570361.eurprd08.prod.outlook.com
 (2603:10a6:290:83::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:03 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:03 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 05/28] drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
Date: Tue, 10 Nov 2026 15:38:26 +0000
Message-ID: <20261110153907.3241978-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::13) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|MI9PR08MB570361:EE_|MI3PEPF00008491:EE_|AS1PR08MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 335977ad-cc81-4d37-df04-08df3f40f941
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|3023799007|11063799006|261021123027099003|56012099006|261102123227099003|261028144727099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261022113327099003;
X-Microsoft-Antispam-Message-Info-Original: 0AS+bk9qwyrlWyv//jHFNWGhEwMVKrY2dp56KvBZHFHCidEib9h4A4bXhepmjPO8JKt8zQpZvp+G+hMGO0eujzmPpyy5IsYjXLDdVvgh7RlX2Bmb2vA6XsJ9f5Up8NPqXmLk7ditvaYAHsq8u0RC5JGwz2KtRK0VjM+PkBgofcqweAD1zvtgcnoHKgLR58pMUNCegU96GZtfKcfVef4/dBHCxBVdai1S6n1lsRWi9ppqLcSvVuDdlUIn7EVpWz81mGJpAUi9qh28ZMVQ2NLyzdOzhMgUM515kBxsAfeBmgEfz84XnlWIqs6Yfg7Ym6dXqH/UHnZzcZ6aVrDWEH0bvSfv0EWncjasXHToTthQ4CdeIzf2NLurxf2Hk02POZNOXREtdYYvOHm9/P0Dgsv+NZFgrKzbPaxxOm/uf898OJFzf0WR/nimDyz77xUcjloLI8r31SMm9SKWFfgBHQbGs2WE/pZYf3eHyPqdiGSho9iioGSNjBhtclo1S5IXTL+Js2Om3dfwM7ExSAAiVu3f+X9gPga+uGBnfRw9S3sr1d6r2I65kITQN31mPZUcYzIJx8+Yxjg720+47VUIVXyS/UXed+E9f6bwlEHNVEuT3/o=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(11063799006)(261021123027099003)(56012099006)(261102123227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022113327099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Enm6mfxsso09cQe6IJE0Z4E8UQ0O/qkA3DomAhKPVMLtlwNKTXqM9KEPXrntcoM5qcU+Rz8VNQl3en0lNsdALYkBBwB9ZC9QbV/m8x2S25kXCTWvVO/+qzeyYstiMwkoi5dRKYNyKXVxQnWB4TfY027Nz+Wa6AdpvwCeh7nVMxqG1OqTajihwL/GAkLqTLNs4Hsxe6sAVXrEcQWYeht4w+mMgG3/Zv10udtYYJAj3W4fEcMcHn6miTsVzl3yqVSryDc8ECBYchOaetxQ4CwlkzaYEoIB4GEG9wQyJkL16EjBbvwQhnW+Jts3iYh7loS0Onu/CWaLQWkKyHPv3jA+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR08MB570361
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 775561af-4668-41a9-49c1-08df3f40e34d
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700016|82310400026|7416014|23010399003|35042699022|1800799024|376014|18002099003|22082099003|6133799003|10067099003|3023799007|13003099007|11063799006|261022105027099003|261028144727099003|261009223027099003|261102123227099003|261026121527099003|261022113327099003|261021121427099003|261021123027099003|261022075727099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5v01HmvP/nMqZm4Y4B7/xUwprABn0WI1EJ6zegpeS76Zv8DiRim8MblOvUDhyWS5Yw3IrwzsvKxB+S+9zdelyP/GFh5PmCbPJzOp2tuDZxtTTR70V3IyMQyn3cWJNodjQeQ/gZd16366QTNzGGyZN4Hvmt9O9543lw5mHGQG5pDuPaQj8WXQ8N25ByQKmEE7egnPfyyUB+me46Xbl8sZMCSGqQAXk36yf4jDvV5lkXtio8OSigrILDvqfHsHmpatq5b1OVO59vJEKB+ZQEecuPYIQSWBI8/xHwX82Oe3kzfgVwRvwaR0rMKCZ3IqcBeB9FOdOL1ds0l6Ml0JBm8RPM+pnp7x21xEykSeAT1qWDOYXRZJhF2JtzcZMxZekHOhoynNZ9gybpadUNT5RWPwbu/UbSIqHLh+fWvIGWdhhckOszlh/ypCX6e5Ia98SuRGYuh14otpzKa5KWwRHtsNoZqN0AnXg23rmGIRM7RuBQ5hff+GRQERA9Y2D8IS98Baeu63pZsQV/gmlBqIpcsNaY3Qv3jU9GHi34WzzXHfjGVxfPuDwWwEzr/JD/BMoyKWdO1dhrhILEx4Q9Ef+3ktkxD0XPpRTvPfpVJEwt3LZGvv3aSZ9sVCnmlHmatU9iVyi5c2jhYVWDBX5NSODRfRJA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700016)(82310400026)(7416014)(23010399003)(35042699022)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(13003099007)(11063799006)(261022105027099003)(261028144727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261022113327099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6Hx1rbd2FyTB4yF7TS0g9WE26Jq2vzK+8BUIFhVdyb5NsGNamNWSSBAYpEXF1CDMgP5hToCzf/pUf69E2pRULIz2kvaXNhNNpwYAx//v+FtefVYPcvAy9LhD81/9dAblZvP1dPZkVS+Tx1hwLiUGWbjU9s35u8CP6lPY5qehMzUhC3PMFMayHgxRpNWmwVG1LBSVIpDWcz4mahAf2RUlSzumKM7HygxOYFvXsJ50EKFK499j9j1IPedY/aiSDjOO8oczw97FcYCgehCr+X0RZW6uNFyaubshpDud67MVSq0zlWyg4q/9RPStwpSS5Nk7+BTd6q8K5d7Y6WSzsEQUCvt2QNmKok2zlrx4BawNywGTEd+GROxJfvZDmPy6p34riZCuRI6q7h6XvCm9aJUssG3FTm3mAt+pZB/jbHXnoJnj5ABsBX9S9C4+Kc8HZyX0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:40:40.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335977ad-cc81-4d37-df04-08df3f40f941
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008491.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7586
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

Mali v15 exposes a 64-bit GPU_ID register with a different field layout
from earlier GPUs.

Add the register definitions and decoding helpers for the new format,
read GPU_ID_WIDE when the compatibility value indicates a v15 GPU, and
populate both the cached GPU_ID fields and the uAPI gpu_id_wide field.

This allows userspace and the driver to identify v15 GPUs correctly.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
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

 .../drm/panthor/panthor_gpu_discover_regs.h   | 19 ++++++
 drivers/gpu/drm/panthor/panthor_hw.c          | 62 ++++++++++++++-----
 include/uapi/drm/panthor_drm.h                | 13 ++++
 3 files changed, 80 insertions(+), 14 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
new file mode 100644
index 0000000000000..6896c263f76b6
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,19 @@
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
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 854874a9f322a..30f5dfe500fb0 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -3,11 +3,13 @@
 
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
@@ -238,21 +240,30 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 
 static int panthor_hw_info_init(struct panthor_device *ptdev)
 {
-	u32 major, minor, status;
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
 
-	drm_info(&ptdev->base,
-		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
-		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
-		 major, minor, status);
+	drm_info(&ptdev->base, "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
+		 get_gpu_model_name(ptdev), prod_id, major, minor, status);
 
 	drm_info(&ptdev->base,
 		 "Features: L2:%#x Tiler:%#x Mem:%#x MMU:%#x AS:%#x",
@@ -296,18 +307,41 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
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
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..09b7f7931e4f4 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -376,6 +376,19 @@ struct drm_panthor_gpu_info {
 
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
 };
 
 /**
-- 
2.43.0

