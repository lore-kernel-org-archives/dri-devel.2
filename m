Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800560A6F7D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HZiT/8ZC;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=HZiT/8ZC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF3010F7C3;
	Tue, 10 Nov 2026 15:41:58 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9776610E14A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 15:41:44 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Xc8cPh7QA/P7dRUK/pcbhbUGrE/0ZK5ou25Cis5hhP7IOqhWbwDDPKeQc+zeo57rxyUm96FGPZcoYgpTmlKY9QykKCAlEe83HjU652mCb8BJ8UwWm/n+KDGYiMbkKDtgTZGfVP/BuaoWmyNH22upGU52I/aghfiirCSpLLyCEZ85zIInBlk0knNy4prw6whb0JcR7dOAivsLypY7r07B6hXjN5ZousJfQrQK+SCE5oxtPwb4lyNI5eKXjMPneWya2q8U8IV/BBALJKPbvbsJSLOiYmy3nUNYYEUYHPNPW/Ax325+K2xeoc8tEBJV3ox0QwAGVs9xqr2fZX6lxrbYfg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3NburZhVmLNW2vvmoJlxBnmUTzOPGKxL7B/kMqy1eA=;
 b=bDmnKNy5xav4wHyavojSRIM6odEuKH2abHm2u1AsIYF9dSeSB9wY883IdelhwSLZ0sn2+Pkbr1N8+4CYp/sk7F2D/ffLMo+65W+3OM8taC1gCzzFG4wfYeH+5B3fja0jRayRrv6DWA6UJ0dXHTz6grwE+rfNr3hPA5dKyre5Tv5e5QpRQnBrTQgImXT+yb3Ulfal4imInuP2XnEK2ue8ILF7Lx0eAvhz2Utot4YKpjAUWrDyvJ6ogOoO9JyflR/QKF91/+oMRZxYbaiRkM/m0UrIuR8DtozwzrurpQnq26uq2RU6OZ6gk572kCFu1nl6VoKqHmA/F8v6lC/ZTQexkw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3NburZhVmLNW2vvmoJlxBnmUTzOPGKxL7B/kMqy1eA=;
 b=HZiT/8ZCSNcBReOiynB9/05AbQHmg861GxPxLFHJHfT/xlRKSuSSIdB2yNFhcebCi7jFw2mnLBrnLfkal04raOWlf0hA0H87t/Yq1V3QEeiR624nK+P+yTU3Dd+Ch42U9YATJN44Qnd8UcSKy1GwPTUgleVtnM9ZXck+Xt/eXMI=
Received: from PA7P264CA0310.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::7)
 by GVXPR08MB11132.eurprd08.prod.outlook.com (2603:10a6:150:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:38 +0000
Received: from MAD0EPF000008C1.eurprd05.prod.outlook.com
 (2603:10a6:102:395:cafe::9) by PA7P264CA0310.outlook.office365.com
 (2603:10a6:102:395::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:41:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 10 Nov 2026 15:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qePz8on/bz09JUH+FlZgOGpJefKzSwDwdrF/vB6mIw9q7TJsCkZGwpxV2kRonCcnOhH+L5PwGhowGl4djYTj4PVYI+VH51neOQEiwazfZbkNwDZeKfB6aplWdDsrrh42Cdys0mItqb5YADNTuifDdQMHygUVoSBlMDX6nR3SDU9NHtJ0v18fniL6J8UyKV6rbWCwxbxTm/GcSU1xrwsGno1T5SR1uUrE50D8qKJ9mO5rK+ax9KJmSQWNFwBaaescgSKrs8YYLCTQ4hzcbzb6eXWYjnkicVXq+GcCi8KU9qUlIhRGtrHRH97toQd7vOQd2OHY5IgvHsLfWP1UVO0x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3NburZhVmLNW2vvmoJlxBnmUTzOPGKxL7B/kMqy1eA=;
 b=v4OS5xVeC+RvjwB2nyZG0IlOMRKVRuZfKiDq1YrzGcpoh4QeMwV3nPyGJxWCWsLcIt0cXZ+3A8MP+iMwYbaZRxrL9QiD87Q0rsvfsPun7QkzshnbPET2R5uQtIjaoZVEABSx9v86kOcvAFTnnxDWicaU/ia+wSv+7hZ/phSqQa1EsLMUBnzmEx5ANAKeNO4x7nWyiFI4UBnSiZ69Sw4nvG0Hn7dYmD4M4Vy3fR+/QfS1b4bdhM0VLmXe3yA4VwzapnXg8ZHVoYTa87UcmvFCcjetyh8zINgKqJQVAxvqlIkb5YesoASPxjR2s99j3jp9k7O91PmB0EdN3dz8bWWA4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3NburZhVmLNW2vvmoJlxBnmUTzOPGKxL7B/kMqy1eA=;
 b=HZiT/8ZCSNcBReOiynB9/05AbQHmg861GxPxLFHJHfT/xlRKSuSSIdB2yNFhcebCi7jFw2mnLBrnLfkal04raOWlf0hA0H87t/Yq1V3QEeiR624nK+P+yTU3Dd+Ch42U9YATJN44Qnd8UcSKy1GwPTUgleVtnM9ZXck+Xt/eXMI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16) by AS8PR08MB10290.eurprd08.prod.outlook.com
 (2603:10a6:20b:63c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 15:41:04 +0000
Received: from MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2]) by MIWPR08MB568805.eurprd08.prod.outlook.com
 ([fe80::be50:76ed:509a:b9f2%4]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 15:41:04 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 18/28] drm/panthor: Route arbitration events
Date: Tue, 10 Nov 2026 15:38:39 +0000
Message-ID: <20261110153907.3241978-19-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110153907.3241978-1-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To MIWPR08MB568805.eurprd08.prod.outlook.com
 (2603:10a6:290:e9::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MIWPR08MB568805:EE_|AS8PR08MB10290:EE_|MAD0EPF000008C1:EE_|GVXPR08MB11132:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a7ffea-02d4-49db-3f0a-08df3f411b51
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|10067099003|11063799006|261102123227099003|261026121527099003|56012099006|261021121427099003|261021123027099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: gwA0HU2Wdu5ZAhhLW1KONfeKzArklR0KeZQIMBHqQd2aZDAa4yv47cN/10fSML0YOY6fBbAyvvXXBx1vh+ppucTtK+5kvadbVb8EaIfR9bcu/VTKFqeWI8+CVjBS9jYuByM+oMo2mnVFOoHLuQ3iZEU1G4TfnNTxZE/hScGkw0rDSQRqYkBtfXxjwuHZ781R7aYrLctN7gax2E4IiAyBmA2Y4mPTfnKFABtzrBLzuHjDkrEmvqYYhDkqjiFMLuFifmmCe672tx2NIIQdbKisGDA6StSyTMNNREYftpiigcInarYtt/S9dmDrfn8c0HDiaPMykkAUg3PaU+6+gAhOu1UlXamvf0Nhe8T08A/OtpfwSDCKdt53FhK0ADanWFXzgco1oGA7dFFwySY6In3PGEws7o+l3geHxenBZhVaLwDCgYJJ9rTAq+tOH0pNb0+GfWDiv/7j86EYUznlm3gx5VIP+qa6Pu8iQWL/FbIUXxOP3wIawo6TYNkJUyFjwQFRXW2zGOOo5oN32c07gWJXJJVIL9N/X7IXYPKMlGgWICKxdhH3d5nS4V1ZFZMXZe+yV0I06cMUKzoj4QVoWHkH5+aSttbYpod8eprVuChr8aiWFtL5LmMVYmTkHHmO0Vi51f0H1RFHYywmRmJ47wH+nrdIBYFroDeHC1gev29GeME=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MIWPR08MB568805.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261026121527099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: v8yE7dFliSRhxJwlONwJvO5soiNtzdfbAdIU5OaWiqztOLxbNYZT6TVgKHuoOO36iHFAyjxGig3WJi12UzYC0f1CirH3UByscPcdka3nJKQjDmvwFBhifaLr07smlc2uJp95wSXJWLO0Q4lK0G0PmCn5xlmSxJSamggGCO/53g3Ne0ABuR5kNjoC66pohDpbHIs11DBj71UPkG7fA76p2l5MYpZWampJVeE0YeNrkRhnKFr83Q5MD97ud71Xp7WnNYIiY7hCFf9/PCbcxgEzq+EX69GFCwlfONA0Kl0Mh79G2cOrEoO+M9Hj6WD6pvTD7qNP+KfPh8rKgOt4FKIlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10290
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b07b6bb-b93a-4924-8eb3-08df3f4107db
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|35042699022|14060799003|18002099003|22082099003|6133799003|10067099003|11063799006|261026121527099003|261022075727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: VRKpPl9I7XBHyEmqT6SB7uV+yF/u0aqQe1lrqcUBcreqpXB8bjdFWtvCbPyuPvXdnPUMYPnmYY1T2fG2qqCCCPdbv3AYfkLX7BSAH0GYT9QDsvnl9mmov9dHbzgVJwyqTbCNsETr9BmE/o7cZzLx6JkCWFEyKWtVrg82lxq0qiYtfQx5ArNBxE0IZjdSfSVNZwjOxTyFzprj6ULVOm2pWnwJ5BPwXtIyWywdHBCnredSoVEJN7GiQdMQ7/O0GyWYoGEzL/5nkcpL9Cl0wIAbwjbnmBefbr1woJ7E3zRKD96XAvOckGbaYp6DUzbKpESyW/IbF6TymRdfyHrsi6yFPNSulk81Gt96T9Q2ocbzqzVZIObh8KjHOrnu/qYmAxY8PnNVFifdQ/iz6//7yDb6p1vjwLcDLypRL3laa14Q8T3Qjs0MGCM5fRskmQTaneVIaCHpc0EOjoJkmITxRg+1XCzRluiUIrdkeEfvGFgmfcUAxRtgwkqQ2Z6vYjHKJua0Q6+bXtFadllMx9owvfFfB69DczyjECzr/gndwvN+EJGvPe0IgBZh7nAwvUkgtyx4eS762yN62aC/mF7hSS6RvGRbPtZEPD/Ex+6LnZZEOJJbLDIkiKlXfI60AysyHVK+8l6cr/1nGIUEwcbs/yznWgORMr4R1ls+3b1tjadq9PslkOQG1QDarpOLNtI4z0M5HVeXs7nyh9BiWebDXphFPQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(35042699022)(14060799003)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tZ+vZ/IkMM9cczfiUl7PK/UGUMJuOmJYI1n6yV5zavuzR7RImL5271AMj89XbMGsDagYfQwxFTFts6ioGAN+5uquz0wjNX3QyOkiOUsA8vAc+kNIIjNRay9uFSfU6Gkmvn+nma7Htp7Uouxzyy+e/ejyK3Y7zvGkBFfUzg+EnSzrd/XVoIreCyuzpBjVVg6EyMa3Cg6YeH1fi0qNEeYg6Zqya3Ptjpt8QNhq8fCurx793a9WrS7F+xCNsj7pOAiFl+sNJCNbbipVmLjZe+i0GXekEb65LS7+x4QUHCASfJFdSK7UUrbWQavwag8y1CWB2ff6NGE458Jts9NvmzalHwac+vtETHpgperCq+0yv6wySN6/B+8OfKptiMS4EM08wMy+oUfge+Ou4RjRl4TyJo2a1aDumOk+lcy1022WUl7uq92ir0mCBrFE8h7OKOVP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:41:37.1816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a7ffea-02d4-49db-3f0a-08df3f411b51
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11132
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

Connect resource-group message handling, the arbitration scheduler and
partition control.

Forward GPU request and idle messages to the scheduler. When a partition
reset completes after firmware yields GPU access or a CLOSE_WINDOW
command, report the active access window as stopped.

Add callbacks that let the scheduler grant GPU access, request a yield
and close access windows.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v2:
- Align with sched to AW interface changes.
v1:
- Notify arbitration scheduler when RESET_DONE completes due to
  close_window, as well as due to yield by Panthor FW.

 .../panthor/arbitration/panthor_arbitration.h |  6 ++++
 .../arbitration/panthor_arbitration_drv.c     | 28 +++++++++++++++++--
 .../arbitration/panthor_partition_control.c   |  9 ++++++
 .../arbitration/panthor_resource_group.c      |  4 +--
 4 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
index 8d4c0aab12666..1350a5982a93b 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration.h
@@ -34,6 +34,12 @@ struct panthor_arbitration {
 	struct panthor_arbitration_sched *sched[AM_ARB_MAX_PC_COUNT];
 };
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id);
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id);
+
+/* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id, u8 aw_id);
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id);
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id);
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
index f26dcdcbc9198..48016d0d88557 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_arbitration_drv.c
@@ -57,20 +57,42 @@ static int panthor_arbitration_runtime_resume(struct device *dev)
 	return 0;
 }
 
+/* AW to Arbiter events */
+int panthor_arbitration_on_request(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_request(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_idle(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_idle(adev->sched[0], aw_id);
+}
+
+int panthor_arbitration_on_stopped(struct panthor_arbitration *adev, u8 aw_id)
+{
+	/* TODO: AW to PC assignment */
+	return panthor_arbitration_sched_on_stopped(adev->sched[0], aw_id);
+}
+
 /* Arbiter to AW events */
 int panthor_arbitration_on_grant(struct panthor_arbitration *adev, u8 sched_id, u8 aw_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_open_window(adev->pc[0], aw_id);
 }
 
 int panthor_arbitration_on_stop(struct panthor_arbitration *adev, u8 sched_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_yield_now(adev->pc[0]);
 }
 
 int panthor_arbitration_on_close(struct panthor_arbitration *adev, u8 sched_id)
 {
-	return 0;
+	/* TODO: AW to PC assignment */
+	return panthor_partition_control_close_window(adev->pc[0]);
 }
 
 static int panthor_arbitration_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
index 330d0bf5fd375..d8fdafbf31864 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
@@ -198,13 +198,22 @@ static int window_open(struct panthor_partition_control *pc, u8 aw_id)
 
 static void partition_handle_reset_done(struct panthor_partition_control *pc)
 {
+	bool notify_stopped = false;
+	int aw_id;
+
 	scoped_guard(spinlock_irqsave, &pc->lock) {
+		aw_id = pc->current_aw;
 		pc->current_aw = AW_UNASSIGNED;
 
 		/* RESET_DONE from CLOSE_WINDOW */
 		if (pc->closing)
 			pc->closing = false;
+		if (aw_id >= 0)
+			notify_stopped = true;
 	}
+
+	if (notify_stopped)
+		panthor_arbitration_on_stopped(dev_get_drvdata(pc->dev), aw_id);
 }
 
 static irqreturn_t partition_irq_raw_handler(int irq, void *data)
diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
index e413cfd9e6d25..26b22461f6d39 100644
--- a/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
+++ b/drivers/gpu/drm/panthor/arbitration/panthor_resource_group.c
@@ -163,10 +163,10 @@ static void rg_handle_message(struct panthor_resource_group *rg, u8 aw_id,
 
 	switch (msg_id) {
 	case VM_ARB_GPU_REQUEST:
-		/* TODO: on_request */
+		panthor_arbitration_on_request(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	case VM_ARB_GPU_STOPPED:
-		/* TODO: on_idle */
+		panthor_arbitration_on_idle(dev_get_drvdata(rg->dev), aw_id);
 		break;
 	default:
 		dev_warn(rg->dev, "Invalid message (0x%llx)", message);
-- 
2.43.0

