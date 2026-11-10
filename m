Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB1606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/OSHo9J;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=r/OSHo9J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FB910F7B5;
	Tue, 10 Nov 2026 15:41:27 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013068.outbound.protection.outlook.com
 [52.101.83.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28E110F7AB
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GE04S9wttpCpa/rHytE6kXWHGr3UYtSPJ+0dZuT8Vv6TyeyFWleoIpFBkSnVMDKUlBHtN6sl/KLe48XgM95A4VjL9nvnD7s6hkT5hof9ZqsQCe0LmoxWN4VU+kB2TBcy1qoN+Ozb0kxPlB6WHqG2Dbh+42e4I1RwOvQvqj3JYE68DU+XllPGW2PuCJwdeyMPVP/IrAxXZZvY4ExTTzarmhP8UFf3e9Bi9m+kN1l7WHtYQW0e91YLiw1Lh1/ZRe+wGJv/MYto5zfSIR/QfWdFLqpuoOZvFGBigcfqfyGgnAvPV4TcMFkYBVuLhfFa13Q20vCh2Lmsi039leDfye0BTg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLY5DZ9SVKVGfNuuicEqpqb9Y/MdyueQE14vr/oWBPk=;
 b=BsaNxlk9bYpJsNM/59V1b0qR04fpvYx4ADRK6WhAHhwXnqnKSEtXW3Xh1z8mvzT4hmjXIGokBO8u4q1cJbNgP2JM344qOdUnQYati5rpA8hCpDNspi9SC/OgHGnum608l8npgUUxtUT/PLuKgDtlvZz2qjhrblbw6rwQhQKsnE50xQQDEXNxPtFagxQHaR3oiXo5Cfu/s/hquLsj9cKl+c739bgmDFWTtF4GirR1OrkLqk2oEL7fjtbKmTnNY5eJg6uS7cGBPbEW5jSEEEqwB/lF8TtjST4aq9/wD8bVXMkDzAu3ARaKf+bBLJDrLQHvzKmQt1p2N42VHMZomKVbIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLY5DZ9SVKVGfNuuicEqpqb9Y/MdyueQE14vr/oWBPk=;
 b=r/OSHo9J0W1BbRqNuOwaRCxHPHAZsM0nW2tyt13uJ8JE2TNYMyXEE7xqI8FyXpS10YeH1t+1ixMVNjpa2z/zLUrrAcWbITAIHF1E53mCsgmrX0WNQShwgwSyL1ZUao/0uWx4aiwfrSMYZE+go6W4lTpncTDZyCvkhMldSfKSk/4=
Received: from CPBP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::17) by
 MA9PR08MB399289.eurprd08.prod.outlook.com (2603:10a6:250:107::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:10 +0000
Received: from CPH1EPF00000522.eurprd05.prod.outlook.com
 (2603:10a6:380:1:cafe::1d) by CPBP307CA0008.outlook.office365.com
 (2603:10a6:380:1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF00000522.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4bBq5VNln/NaLlwuQjAAX2ApCYdDKxn1PW8diJAa9fyZ+Y7gSa/HocibGnx3Rja81qqhABkx3IiszzJJx03KGPb+6Afs8E6VdujoOuILcUxZSnlzK0Tr2y09xdizyklPSsdv207KnP9+P2mo5XG/6Aee7nP+bBXEYd963K394EpmMk/FhlD9qoWlJBS9wewEOGIJ0GbkJiZfRyyHaAir0ZtYq74a9i9FeFNxmiHHR41fGECrPIbWrPlbS2iSLlSu7BNTtO9m7QZkBYLaw6AsM8CDzU6DPrmRJBnz2sRtg5DopMqs1pmw6FDbNBjWlVVztZJnjQSKFBKQv1BIxpVPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLY5DZ9SVKVGfNuuicEqpqb9Y/MdyueQE14vr/oWBPk=;
 b=Y+P7CzFGYczs+wmtWLmMOMKnXu5vZSTKqacdqA3+0BfySa9VmHAQERj2dIRlvAyaDV3O8UuxWq0681RP/+9r/KCqBYnurgmkN6+rQv9v8HQVp3MYOcrc2KPaWQ4bChv2rJEzXuwebsFldw5LhQhs96Cil8nimBtH2RotlvGVmZs2iGC8RrxNp+It+6Hc1SN7ZF5cff7fiRPPRzBz41SpQDmk4R6z3odDvyRClkXSzyNuJ9yIOTSJB8f7Cd97SnNU3QSzCzV8h/iLSUc0/3PqxgQYiUYGNJkW2yTLY8yHNtxc8cCqmAc68cDhmX9+DOL6rdr6PDuMAvgAJNrn9KbT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLY5DZ9SVKVGfNuuicEqpqb9Y/MdyueQE14vr/oWBPk=;
 b=r/OSHo9J0W1BbRqNuOwaRCxHPHAZsM0nW2tyt13uJ8JE2TNYMyXEE7xqI8FyXpS10YeH1t+1ixMVNjpa2z/zLUrrAcWbITAIHF1E53mCsgmrX0WNQShwgwSyL1ZUao/0uWx4aiwfrSMYZE+go6W4lTpncTDZyCvkhMldSfKSk/4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:40:36 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:40:36 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 12/28] drm/panthor: Add AM_SYSTEM platform driver
Date: Tue, 10 Nov 2026 15:38:33 +0000
Message-ID: <20261110153907.3241978-13-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::6) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|CPH1EPF00000522:EE_|MA9PR08MB399289:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5e7d8b-46c4-4dfb-5993-08df3f410b15
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|22082099003|6133799003|10067099003|11063799006|261022105027099003|261102123227099003|261026121527099003|261009220027099003|261022113327099003|56012099006|261026140227099003|261021121427099003|261009221227099003|261022075727099003|261009223027099003|261009223327099003|261009221727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: z3e0wOfKJI9c/4yPDFDci+mIyzLYnnjapnU+pd6/6NMMMiyYOD7sHp5cS4tUeiltn1qqLzVDfBuDZ033BuZ8DdfGHjCUBd7fc8BSa3KRPfJcyNIVR8ncx0gSc0YDVLI8qxNxcoa1RfniXhDpEeCjBBq2JAcSMiEmhsVLIFcGAyRyioSs6bKNNrSMhXXLKVVo9oCnGS95ASO65i7DvRrOr2NJelGigKOG+fveSwl8wIxeB9sVi0hiw7TwU+U1qM5owdRPKU7pIIWW7BSYtAqNupq6TmC6cm0z6JiMKjf3TwLv/TGhfu+4d0hFqva7F1C0sKYQyGduUeTmrc3ZlVELewY8OK2+apYTHfdmjKOo06lzxYzuKNar9L4EQ9O0tAltpq3s36LvBx1nLh6j1vU1N/HW403/Gzl07prqlCxlfqbV09wvbWlFrKbeOoAnszzuMmKNBJarnuUnZbAoLF8dwUv8eFchkp2B28CNzC0J8Sx0tr/TSquzXLPCllfrNKH9djMjSjmmV3g2SgLzgzKWDFbSa0nf1xB8EbZJl1hozAvBR+X+iCIsFA5RyWCGeE2d6C42dbUX7QXB52uVBVyMyk9BbEdI6L7H2dlVgflE+eGs+xOA0bpwsq2zPH/20UED
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(261009220027099003)(261022113327099003)(56012099006)(261026140227099003)(261021121427099003)(261009221227099003)(261022075727099003)(261009223027099003)(261009223327099003)(261009221727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: k9ZfkBw+ZLSd04xGfQhzdQIRo0O88qFQWzj8fhe5kTjCfiMhVKnObkCRbTDZED6w8HZXOsoRBkmtWHbpZNYsk2WNqyT3q6XBIhM57uc+g8XxzzdRyjz6GtSqUASHAmt6wX7Ok+wFwOIj0hw35u1VKGDFwiyj4tENLdgdQsuyLOwBtRb4u1BxyWrpZBVnFfca2w+5bfAgxRiTKjM91ltGZV54qPiCBgyhR1g8Pyd0k1s5LlSEG0LOM5zBkY2DzzZBtcElMS9ICplkumVavzRzYRKHGuVVjDIsDSCtkdLMI0doj16jAjSDpcpWuwB8SS7Ij4IW9Js5mpbHT+hMDsiiSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 04671ce0-9ec1-4257-4db0-08df3f40f6ff
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|35042699022|7416014|376014|82310400026|36860700016|23010399003|261102123227099003|11063799006|261009220027099003|261009221727099003|261021121427099003|261022075727099003|261009221227099003|261022113327099003|261009223327099003|261022105027099003|261026140227099003|261009223027099003|56012099006|261026121527099003|261028144727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 47EBlmp0EltvvPSY3V/RFrPETwb1GmdiNVpC0eENcUhAA90ReF+HHZrzG18cFzei+OK8q81kzK8myvtIUECo0Jkv/OK0XTiV6OhyYGxQFMEM3T3ltmTczMHSZaPSAw3qKyzHXyWx9PxUbObEhJgoBabUHEn7XqyB18vgO6pmQ46yPHqvT86EBXZB8fe5PupCD2QBYqaJX1YZPGRq5nBxg8qZG12biraLcTIwDOEvGelz715xTBjIWE55Pr2NIoZCrk+CI9psgZixvAx7XaWzHFFtjI7dGtN2oPN1lvwbXO4zFUyZe7sWdnsXjSrPMnvyhrmLKd+Vvim0yJNbXUAK5qD6IBMT2FtDfUZYxhP0BzK4cLa5ddGBDOEl13XceO5btxDV32kKZ2SfrqsfJLzXhwXP1B8j0EzuRa/Hs3FFktEFfhgdMikQM7FS+lftGFn7xubdMPvSOrvfeexE01gSqcDXbDuhysdFnx+3Xu1T/AyOeUrNkvf+hxA/FWWXv0xyOFcy2Q2eTxO4Z5PQjM5KuY/S6/siLRImTRgIF5OD9Z8Zm2/TORddDX1HgPIHaof2qJpRtPCP+pBm46BPqTAowjPLEIrda1vSPfVnP6tAQMXeBdfX5OcqpEJG4dWnKEHDSIszMgMjLAxcIPU3hvScHTbvctfYDkqxO4iiHIgZR2g=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(35042699022)(7416014)(376014)(82310400026)(36860700016)(23010399003)(261102123227099003)(11063799006)(261009220027099003)(261009221727099003)(261021121427099003)(261022075727099003)(261009221227099003)(261022113327099003)(261009223327099003)(261022105027099003)(261026140227099003)(261009223027099003)(56012099006)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AsGFtCu4ABGVzLS75LDm25ldSVAwVkDTnFmfm6FeuvPRPmXWeZDGuVD11yzAOuyTuO0Kc3GdLdVLWdZzDQ3fijAA0lz6T0x/vNfS6+1yDkmrGKremiYxbtUDvXEehTxPOM1oHgBnroEcteTmY5ekxxvK7WGeowyhsjEab74u8aVksB6diDtfFj2vknfJoDfYoL4Kdt4x+pRYTP1Cy3SO2l+2sSA0JiOkcRMz+RNfTayXofuBjFVlSTP94O8vPxQsFpvoLiO/Gm8tL+JKZZmKuFmy8YX9uZmjFItLPGp0jPvaXqS7TN5NnQOpjLog9Jrz0CDcn/XMAGOSbieNUGSZJ3kweOuUdKFm5Gt6Ra83cVPvkdLZc2y/8p2MPcbX9GGcZ7J+xcMsHuVE3NFDzG1a92uP66++GZKyy0MczOHYk6Ha259ebZZwjlsdnF5GfZvG
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:09.9701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5e7d8b-46c4-4dfb-5993-08df3f410b15
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000522.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB399289
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

Mali v15 AM systems expose an AM_SYSTEM block for GPU-wide control.

Add a small AM_SYSTEM platform driver, wire it into Kconfig and the
panthor build, and use it to manage the GPU clock and regulator
resources. The driver also performs the initial GPU reset sequence
during probe.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Fix driver suspension during init unwind and termination paths.
- Handle cases where CONFIG_PM=n
- Fixes following issues raised by sashiko:
  - Add rollback handling for failed regulator suspend.
  - Use runtime pm ops macro
  - Add module device table
- Link: https://lore.kernel.org/all/20260922205909.5648C1F000FF@smtp.kernel.org/
- Register size comments are unsubstantiated.
v1:
- Renames panthor_system.c to panthor_system_drv.c to facilitate adding
  another source file for v15-AE support.
- Explicitly obtain named "system" IOMEM resource.
- Explicitly use "gpu-supply" regulator instead of inferring it from the
  "clock-names" DT property.
- Populate/depopulate child devices.
- Clear stale RESET_COMPLETED interrupts before reset.

 drivers/gpu/drm/panthor/Kconfig               |  10 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/system/Makefile       |  13 +
 .../drm/panthor/system/panthor_system_drv.c   | 344 ++++++++++++++++++
 4 files changed, 368 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/system/Makefile
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system_drv.c

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 911e7f4810c39..e17c93035e8b7 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -20,3 +20,13 @@ config DRM_PANTHOR
 
 	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
 	  be supported with the panfrost driver as they are not CSF GPUs.
+
+config DRM_PANTHOR_SYSTEM
+	tristate "GPU-wide configuration for Arm Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  Enable support for the AM_SYSTEM block found on Arm Mali 5th Gen
+	  AM GPUs. This block provides GPU-wide control outside the main GPU
+	  register window, including reset handling and management of shared
+	  clock and regulator resources.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index dd15d52a88bac..488a5e03efbc4 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -14,5 +14,6 @@ panthor-y := \
 	panthor_sched.o
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/system/Makefile b/drivers/gpu/drm/panthor/system/Makefile
new file mode 100644
index 0000000000000..018b569655b67
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+# Copyright 2026 ARM Limited. All rights reserved.
+
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += panthor_system.o
+
+panthor_system-y := \
+	panthor_system_drv.o
+
+INCLUDES = \
+	-I$(src)/..
+
+ccflags-y += $(INCLUDES)
+subdir-ccflags-y += $(INCLUDES)
diff --git a/drivers/gpu/drm/panthor/system/panthor_system_drv.c b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
new file mode 100644
index 0000000000000..e70dba4058f38
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+#define AM_SYS_IRQ_RAWSTAT			0x40
+#define AM_SYS_IRQ_CLEAR			0x4C
+#define AM_SYS_IRQ_MASK				0x58
+#define AM_SYS_IRQ_STATUS			0x70
+#define   AM_SYS_IRQ_RESET_COMPLETED		BIT(1)
+#define   AM_SYS_IRQ_INVALID_COMMAND		BIT(2)
+#define   AM_SYS_IRQ_INVALID_ACCESS_MASK	GENMASK(31, 16)
+#define   AM_SYS_IRQ_INVALID_ACCESS(x)		FIELD_GET(AM_SYS_IRQ_INVALID_ACCESS_MASK, x)
+
+#define AM_SYS_STATUS				0xC0
+#define AM_SYS_COMMAND				0xC4
+#define   AM_SYS_CMD_INDEX(x)			FIELD_PREP(GENMASK(11, 8), x)
+#define   AM_SYS_CMD_SOFT_RESET			0x10
+#define   AM_SYS_CMD_HARD_RESET			0x11
+#define   AM_SYS_CMD_AW_RESET			0x12
+
+#define AM_SYS_RESET_SLEEP_US			10
+#define AM_RESET_TIMEOUT_US			(20 * USEC_PER_MSEC)
+
+/**
+ * struct panthor_system - System device
+ */
+struct panthor_system {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @iomem: CPU mapping of the AM_SYSTEM IOMEM region */
+	void __iomem *iomem;
+
+	/** @regulator: Pointer to device regulator */
+	struct regulator *regulator;
+
+	/** @clk: Pointer to device clk */
+	struct clk *clk;
+};
+
+static int panthor_system_regulator_init(struct panthor_system *sdev)
+{
+	struct regulator *regulator = NULL;
+	int ret;
+
+	regulator = devm_regulator_get_optional(sdev->dev, "gpu");
+	if (IS_ERR(regulator)) {
+		ret = PTR_ERR(regulator);
+
+		/* Regulator not found. Exit */
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(sdev->dev, ret, "Failed to get gpu-supply");
+	}
+
+	sdev->regulator = regulator;
+
+	return 0;
+}
+
+static int panthor_system_regulator_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_enable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_regulator_suspend(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_disable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to disable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_clk_init(struct panthor_system *sdev)
+{
+	struct clk *clk = NULL;
+
+	clk = devm_clk_get(sdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(sdev->dev, PTR_ERR(clk),
+				     "Failed to get clk");
+
+	sdev->clk = clk;
+
+	return 0;
+}
+
+static int panthor_system_clk_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sdev->clk);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable clk: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void panthor_system_clk_suspend(struct panthor_system *sdev)
+{
+	clk_disable_unprepare(sdev->clk);
+}
+
+static int __panthor_system_reset(struct panthor_system *sdev, u32 cmd)
+{
+	u64 val;
+
+	/* Clear stale RESET_COMPLETED IRQs before issuing reset */
+	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);
+
+	gpu_write(sdev->iomem, AM_SYS_COMMAND, cmd);
+
+	return read_poll_timeout(gpu_read64, val,
+				 (val & AM_SYS_IRQ_RESET_COMPLETED),
+				 AM_SYS_RESET_SLEEP_US, AM_RESET_TIMEOUT_US, false,
+				 sdev->iomem, AM_SYS_IRQ_RAWSTAT);
+}
+
+static int panthor_system_reset(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = __panthor_system_reset(sdev, AM_SYS_CMD_SOFT_RESET);
+	if (ret) {
+		dev_err(sdev->dev, "SOFT_RESET failed, attempting HARD_RESET");
+
+		ret = __panthor_system_reset(sdev, AM_SYS_CMD_HARD_RESET);
+		if (ret) {
+			dev_err(sdev->dev, "HARD_RESET failed");
+			return -EIO;
+		}
+	}
+
+	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);
+
+	return 0;
+}
+
+static int panthor_system_suspend(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+	int ret, clk_ret;
+
+	panthor_system_clk_suspend(sdev);
+
+	ret = panthor_system_regulator_suspend(sdev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	clk_ret = panthor_system_clk_resume(sdev);
+	if (clk_ret)
+		return clk_ret;
+
+	return ret;
+}
+
+static int panthor_system_resume(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = panthor_system_regulator_resume(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_resume(sdev);
+	if (ret)
+		goto err_regulator_suspend;
+
+	return 0;
+
+err_regulator_suspend:
+	panthor_system_regulator_suspend(sdev);
+
+	return ret;
+}
+
+static void panthor_system_fini(struct device *dev)
+{
+	int ret;
+
+	pm_runtime_disable(dev);
+
+	if (!pm_runtime_status_suspended(dev)) {
+		ret = panthor_system_suspend(dev);
+		if (ret) {
+			dev_warn(dev, "Failed to power off during teardown: %d\n", ret);
+			return;
+		}
+	}
+
+	pm_runtime_set_suspended(dev);
+}
+
+static int panthor_system_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct panthor_system *sdev;
+	void __iomem *iomem;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	iomem = devm_platform_ioremap_resource_byname(pdev, "system");
+	if (IS_ERR(iomem)) {
+		return dev_err_probe(dev, PTR_ERR(iomem), "Failed to ioremap \"system\"");
+	}
+
+	sdev->dev = dev;
+	sdev->iomem = iomem;
+
+	ret = panthor_system_regulator_init(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_init(sdev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, sdev);
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to resume device");
+		goto err_rpm_disable;
+	}
+
+	if (!IS_ENABLED(CONFIG_PM)) {
+		ret = panthor_system_resume(dev);
+		if (ret) {
+			dev_err_probe(dev, ret, "Failed to resume device");
+			goto err_rpm_disable;
+		}
+	}
+
+	ret = panthor_system_reset(sdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset GPU");
+		goto err_rpm_put;
+	}
+
+	/* Probe any child devices */
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_depopulate;
+
+	pm_runtime_put_sync_suspend(dev);
+	return 0;
+
+err_depopulate:
+	of_platform_depopulate(dev);
+err_rpm_put:
+	panthor_system_fini(dev);
+	pm_runtime_put_noidle(dev);
+	return ret;
+
+err_rpm_disable:
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static void panthor_system_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_warn(dev, "failed to resume during remove: %d", ret);
+
+	of_platform_depopulate(dev);
+	panthor_system_fini(dev);
+
+	if (ret >= 0)
+		pm_runtime_put_noidle(dev);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(panthor_system_pm_ops,
+				 panthor_system_suspend,
+				 panthor_system_resume,
+				 NULL);
+
+static const struct of_device_id panthor_system_dt_match[] = {
+	{ .compatible = "arm,mali-gen5-am-system" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, panthor_system_dt_match);
+
+static struct platform_driver panthor_system_driver = {
+	.probe = panthor_system_probe,
+	.remove = panthor_system_remove,
+	.driver = {
+		.name = "panthor_system",
+		.pm = pm_ptr(&panthor_system_pm_ops),
+		.of_match_table = panthor_system_dt_match,
+	},
+};
+
+module_platform_driver(panthor_system_driver);
+
+MODULE_AUTHOR("ARM Ltd.");
+MODULE_DESCRIPTION("GPU system driver for AM GPUs");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

