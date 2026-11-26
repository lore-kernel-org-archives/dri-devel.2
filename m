Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA710606A336
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Iz0CB//j;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Iz0CB//j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43AF610E667;
	Thu, 26 Nov 2026 16:13:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013061.outbound.protection.outlook.com
 [40.107.162.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D06D10E97E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:13:37 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=fgHutIE9hP0jH16piuar3cla/Ox1uxP5xzLB7/fHJpO+0MtimhkSQSvdKVeCE150z/C/XJi7pMW+hFvrQ03EFc6R90kOBSibWXtO/kuNkjuzH+k8iZonr5S7fhdXPzHOTApEUTCtYQqmKncro1y3O2YlvdqyJqE7xNPo4wN66NjUytLzH7NQiQ0YdqNf1D6CQ1v4EfEA/iXFLT+AYICb7H8o8r47PuziWbcyY+9KsLYMW4VPIhYx/F55x9A6/V9r6XV/ajqGIH7OsZVOXGRQUmlpdvmGrt5FIBHecik6+m0KgvkOcKFHewNB3vrofmPrVA5Oxuk6y/19TWs8CfWq8w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5TC7+9ZYCoDiyxifsXX9qp3QAvuHsRFSfibRB9KpkQ=;
 b=E1CgIrJAB0z9JsQxkJo1fb5qLSOi4JwX9xLpYx/CoLk05/2HpWR7JJhb4f+Fj62l8vE2QgboR+xM7CpOiJi/dLrjrERFH4CkYTnYulymSciJZnFPG9dfOetQJYFe22GVmKNva4Q/IlyT1RJ7MboAdaorn+yGE+lVrO7sxfrCbHcDdgPr9ED/eZ+ENTw++k3C7jJjeZgVTThEYSe40BszJO5x/63M5Nr3hZWzvC8Jz5Qhc+yEx2VxTFrzBSQiQpjFFqfoXMnNa9HIRusDX/3jtcHituW47LagrMOTAqwP/kwqbYTTUqQeDwVfDpJetTIOg3L0lwsMcV81RFYb563BmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5TC7+9ZYCoDiyxifsXX9qp3QAvuHsRFSfibRB9KpkQ=;
 b=Iz0CB//jOE0b6qRozc0CgxfnxFRthmyfj6aDteHvonrj0WMNJJXA4rMIm3RXr9lxKiJK7aYDJrCL52tujEMnfkV1hTg/MdUSXlA3DOa64q+y0PIT4Vq6e3/7GXhfDBD68QaxOHpSd/rdoZ5x2xY6S8PDOFzxKrLQj6B3TgZeJZA=
Received: from AS4P251CA0017.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::6)
 by GV1PR08MB8401.eurprd08.prod.outlook.com (2603:10a6:150:a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 16:13:26 +0000
Received: from CPH1EPF0000052C.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::88) by AS4P251CA0017.outlook.office365.com
 (2603:10a6:20b:5d3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 16:13:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000052C.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 16:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNH8lrLXlFgzqQwDk6EygEPq+BzmJCQqTymJnA1d2OOWYU54VpMO7OGPyDolynqEbxHFFVNEM7TWWa9ufahKuByzp0xaLffDQ7udogeDzTTRazHK+slkXiId7uF3fnhEoAMejpbJh8ZtvFy3WQ3QCY5ww56/TAfEAOE5i3uHbaSz2QHHk6FqsXvRPyFjicMVxi26xL/lNlC+8vy/5uUERDFaxhoZnFpAO8M2kCInLlXEFf1jX+ZOg/sS+wBpRAYQzDKskPtjMxJjZ//HkNKDxuqs9/L/SO26s5ziJmZRnDBCU7PHLRiDccIEPNfHkvzbhTq8e8UnFUOg0YWM4K3l8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5TC7+9ZYCoDiyxifsXX9qp3QAvuHsRFSfibRB9KpkQ=;
 b=jfcaJjOz4NaBFO3aCuvn3wUBtskQY2DJSfMP6LJDGAMFbyKg1bnsGGMy5Va/XXk77DrLi/EWZVAJwwT+pOvrzZPM0c954ZyrGuybYNdnwzoYcNUH9Ht+C4AWNrkBtWTn2rEW0T4EUAROocl6Zi51ETo3TVoS9dL/qnaqfBnrBuQETATICjP6puUZuwWxGMMZQIWjRFRDoE45O3WtVAJfwbcVSvpCJjpe2rrWhn4utPbXvg6kDwz1MDbont2bEx4iOGYI3KXD4yhsELZw8bc3+qvweKFA/lqlXdgzlShssiGp1WRu1SeEx27n8unZ8ecMj6027dSOhxpWAKEHP8I3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5TC7+9ZYCoDiyxifsXX9qp3QAvuHsRFSfibRB9KpkQ=;
 b=Iz0CB//jOE0b6qRozc0CgxfnxFRthmyfj6aDteHvonrj0WMNJJXA4rMIm3RXr9lxKiJK7aYDJrCL52tujEMnfkV1hTg/MdUSXlA3DOa64q+y0PIT4Vq6e3/7GXhfDBD68QaxOHpSd/rdoZ5x2xY6S8PDOFzxKrLQj6B3TgZeJZA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by VI1PR08MB5520.eurprd08.prod.outlook.com (2603:10a6:803:135::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:12:53 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:12:53 +0000
Date: Thu, 26 Nov 2026 16:12:52 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Paul Toadere <paul.toadere@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 2/3] drm/panthor: Report the CS fatal errors through
 GROUP_GET_STATE
Message-ID: <ntuhvyil3asuqou24m7ocj4riji5inrcn3jy47j4vohkrtpecj@e3vd2npna7cm>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-panthor-fault-info-v2-v2-2-673b31f3840c@igalia.com>
X-ClientProxiedBy: LO4P265CA0110.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::14) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|VI1PR08MB5520:EE_|CPH1EPF0000052C:EE_|GV1PR08MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a2ca1b-90b4-4357-7c31-08df4bd833ad
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|261021121427099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|261021123027099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: C6jhYo2NwKugIcsBSrr2cTDJltz3uFkHAh+oXuJRpm3zjysQ4iY/Br3N5WZNPR1plzYc9c39LfepUSyLcKgm7juULG2gZyeYXQbL0Y5Gf4MBjc5Fr2EFWB7rOc9vB3IHWNUJye4hgAZJmc/kaXc5gLMyj/Tk5C581qYDziFEmQVgLbQzsk01k/LK/ZwJJzA0a9lOl5nPvyB2LiPxmkX7rXW9BJIsEQmtRmtLOB9tG6AA/uki35n8PTZAg4emMOVWy2H1yqtOPHDOOscrJ/5/PxJrrZLchFjbpk+1s2X1hoBHak+n5+zg9yk5V5ToaD5VblhD9rwkCHGMEJzYNtOSfKQLiPTkEqo/V1T0Dhq3sh6b/JGZE/d8MzrzjpAOK/r8IaXiP1I16ySUz96vWsk2PQUtnYIz5qdeZHKHSVN+a3ldqz1cWgBrVzMl/xPQtG2tQHZbxLLcKUkkc8Vv13Qvm28u3fnikCBOxPp8hUTGWy/Wbt8NPNS8ECkgGI8C1B0lO+FviHSKC5X6Pyi6AYd9eQshNX9hnssXOgZDErIhgMGTsmmGRx/uOM3kElf1U3yoyS4VdPh9UDl2rs94VrWCtN6bd9eEdox8IUL/0xG0iPU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261021123027099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QGlEb4BhSEnbO8fbqPfB9gmEZbEut5Ss3518MKtOsB57m1th0IBuX1Ti7hOKiQrJvuY1VDh8I6SpyIpyzGiU/MuUow1IPyYGerjs2cyoBjYIhXJR5YuPQpIeKKcRt0qv5zi5xCkUFRUhvjpF1FA+A8JO9gyNOEd4a2EHvtOBz8vnNuzffOiMnyltAJl4PWnfAQAKKn0AT2rRmVjsomuQQ2rNs2RNmROFe+43NUL0QMhH6ty1971kutngVoTQt0zp5LNz1EiWpKg7c8GAE+L6qAyHLUatDkrOkD6AbvoVJcxPxgU/nyrPA1tn48jku1tUvPN1ADueJSiKySFji4j3sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5520
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000052C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ad446c9a-9f0c-4748-c5a3-08df4bd8200b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|14060799003|35042699022|1800799024|23010399003|82310400026|261021121427099003|10067099003|56012099006|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: bGR1ER+MQ0wRDVhW3ihsCc5+uzq31wF+y9+MYcYk4ZtVA42NOmcHdyTztNpCzt2zUfUacA1OsraNJqCSyoAggA0XR0V/O5SxVjkZBbm42XwAwR2lw9CVTClYhi5stsiRfYZBkf4ySX29c0hqdty3eZbOePZv2PwsUJRsgGEutfd8HkNlVHydh8alH2gMQdzbo+tUqrg+RoeeO3vHKhvt1gUp99LXXmjvNRfVMLURwSfKnMIi9d889wJl35ykbGgkHi6+Pu31sWOnHoi9hBAkRqrJ57LJ1XBiGzuLPdmp07j7HqNNBbDdYNjCu8W0xRku8L09a/AgsZ4iLhyOmOlUPLSUapGcKF2VmPIQsv4LBhv3CPBR7YypxY6PWyEdjOeo3pjt5MhUtn8+DCM7f4CCdhKGHUvSY1PzXbteLwOtGJ9lizWPhbQ17oaX/a/PlLKW7NFeLQd1KzofGErXY6clMoHlgYEXSKuBF+MJeSrpBwOmyH37lgZ0ga8Gt1dGbUhBxYGguW0Rs7PQrbHyYjXXqaCwPfxHc1vbFvyJLNc/cQPmKmL/CB6NnJsyu/3hIGgfwEPdm94NShoBKsKm0AMZpnPUTYo4P1PnsybBGmGTn8Fxu/IXEE7bcPlNedJfdpMP5zyGMbQuJKkAbXCkYAnocw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(14060799003)(35042699022)(1800799024)(23010399003)(82310400026)(261021121427099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lUKzl2fvD07y79nUwyiIQAp3805Ux9u/Fj0wfWuSMBRGV9UCPk5MoOd+Q6Wmxy9/g+igq9Jq6MGFwUwnj4e+n+vxxf/f9XcX7BmLLYg8eFexq8naqZIecp3vqgcrekcLzHzEUJrEapj8nby37RPOH4OCo9KBIFdqyShTkQXTavqQ6OVLfrPVmiVbgFHnroreVkqjsbDkB7dmz38oZpBsbxyjm1bCOHLLdbQ8BQBGuJP0Ia+ivvEyWPn0MbgIwVeLdVa7mLE2+T97mZEHqOIZNIRSQq2tWlYxu+wjJ6ibRdXGHFti7uR2yu8mPHqHNN4Fmuq9ZmYTgjrdeHJkHDvQF/fGDOg9aULY9/4bFqVh7bEGoj657Q7TZIGY/AydBD01J4RUXoRw6y9yL2eJToMCohWxdMGCEBJvoij9q+TnXDSFppQbC2+KjWoO1b4Z1/1b
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:13:26.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a2ca1b-90b4-4357-7c31-08df4bd833ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000052C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8401
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:52:40AM +0100, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> Keep the raw CS_FATAL and CS_FATAL_INFO in the queue that hit them and
> return them through GROUP_GET_STATE in an array indexed by queue.
> Userspace decodes the values. No memory is allocated in the fatal path.
>
> A queue stops at its first fatal error, so one slot per queue is
> enough. The slot is a struct drm_panthor_queue_fatal, which is the uAPI
> struct, so the ioctl can copy it with one assignment. The CS_FATAL
> event handler writes the slot under events_lock. The ioctl reads it
> under the same lock. The slot is never cleared, so the values can be
> read again after the call.
>
> The ioctl copies the slots of all queues to a stack array while the
> locks are held and copies them to userspace after the locks are
> dropped. It fills at most one entry per queue of the group and leaves
> the rest of the user array untouched.
>
> A queue can be flagged in fatal_queues without a CS_FATAL, for example
> when the group was killed by a VM fault. Its entry then has a zero
> exception. The VM fault itself is available through VM_GET_STATE.

From the caller's perspective, how do they discover that there is a VM
fault and call VM_GET_STATE? Would they have to go through all of the
fatal fault structs and check none of them have been populated with
fault information?

I wonder if it would make sense to add a new flag (something like
DRM_PANTHOR_GROUP_VM_FAULT) to indicate that the group was killed by
a VM fault instead, since for that case, DRM_PANTHOR_GROUP_STATE_FATAL_FAULT
doesn't sound fully correct.

>
> Old userspace that passes the shorter struct still works, the DRM core
> zero-fills the missing tail. A zero count skips the array.
>
> Link: https://lore.kernel.org/r/20251215115457.2137485-3-lukas.zapolskas@arm.com
> Link: https://lore.kernel.org/r/20251215115457.2137485-6-lukas.zapolskas@arm.com
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   | 20 ++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.h |  5 ++++-
>  include/uapi/drm/panthor_drm.h          | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 7572cd7d6423..fb5fdf848dec 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -181,7 +181,8 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_vm_bind_op, syncs), \
> -		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size))
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_bo_sync_op, size), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_fatal, exception_info))
>
>  /**
>   * PANTHOR_UOBJ_SET() - Copy a kernel object to a user object.
> @@ -1254,10 +1255,25 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  static int panthor_ioctl_group_get_state(struct drm_device *ddev, void *data,
>  					 struct drm_file *file)
>  {
> +	struct drm_panthor_queue_fatal fatals[MAX_CS_PER_CSG];
>  	struct panthor_file *pfile = file->driver_priv;
>  	struct drm_panthor_group_get_state *args = data;
> +	u64 usr_ptr = args->queue_fatals.array;
> +	u32 stride = args->queue_fatals.stride;
> +	u32 count;
> +	int ret;
>
> -	return panthor_group_get_state(pfile, args);
> +	ret = panthor_group_get_state(pfile, args, fatals, &count);
> +	if (ret)
> +		return ret;
> +
> +	for (u32 i = 0; i < count; i++) {
> +		ret = PANTHOR_UOBJ_SET(usr_ptr + (u64)i * stride, stride, fatals[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>
>  static int panthor_ioctl_tiler_heap_create(struct drm_device *ddev, void *data,
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a343c5180e01..40400b2e4551 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -485,6 +485,15 @@ struct panthor_queue {
>  		/** @profiling.seqno: Index of the next available profiling information slot. */
>  		u32 seqno;
>  	} profiling;
> +
> +	/**
> +	 * @fatal: Last CS_FATAL reported on this queue.
> +	 *
> +	 * Never cleared, a later CS_FATAL overwrites it. A zero exception
> +	 * means no CS_FATAL was reported. Protected by
> +	 * panthor_scheduler::events_lock.
> +	 */
> +	struct drm_panthor_queue_fatal fatal;
>  };
>
>  /**
> @@ -1412,10 +1421,20 @@ cs_slot_process_fatal_event_locked(struct panthor_device *ptdev,
>  	info = cs_iface->output->fatal_info;
>
>  	if (group) {
> +		struct panthor_queue *queue = cs_id < group->queue_count ?
> +					      group->queues[cs_id] : NULL;
> +
>  		drm_warn(&ptdev->base, "CS_FATAL: pid=%d, comm=%s\n",
>  			 group->task_info.pid, group->task_info.comm);
>
>  		atomic_or(BIT(cs_id), &group->fatal_queues);
> +
> +		if (queue) {
> +			queue->fatal = (struct drm_panthor_queue_fatal){
> +				.exception = fatal,
> +				.exception_info = info,
> +			};
> +		}
>  	}
>
>  	if (CS_EXCEPTION_TYPE(fatal) == DRM_PANTHOR_EXCEPTION_CS_UNRECOVERABLE) {
> @@ -3818,8 +3837,11 @@ static struct panthor_group *group_from_handle(struct panthor_group_pool *pool,
>  }
>
>  int panthor_group_get_state(struct panthor_file *pfile,
> -			    struct drm_panthor_group_get_state *get_state)
> +			    struct drm_panthor_group_get_state *get_state,
> +			    struct drm_panthor_queue_fatal *fatals,
> +			    u32 *fatal_count)
>  {
> +	struct drm_panthor_obj_array queue_fatals = get_state->queue_fatals;
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> @@ -3833,6 +3855,9 @@ int panthor_group_get_state(struct panthor_file *pfile,
>  		return -EINVAL;
>
>  	memset(get_state, 0, sizeof(*get_state));
> +	get_state->queue_fatals = queue_fatals;
> +
> +	*fatal_count = min(queue_fatals.count, group->queue_count);
>
>  	mutex_lock(&sched->lock);
>  	if (atomic_read(&group->timedout))
> @@ -3844,6 +3869,11 @@ int panthor_group_get_state(struct panthor_file *pfile,
>
>  	if (group->innocent)
>  		get_state->state |= DRM_PANTHOR_GROUP_STATE_INNOCENT;
> +
> +	scoped_guard(spinlock, &sched->events_lock) {
> +		for (u32 i = 0; i < *fatal_count; i++)
> +			fatals[i] = group->queues[i]->fatal;
> +	}
>  	mutex_unlock(&sched->lock);
>
>  	group_put(group);
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
> index d87cbdba4d40..dd3d31c06cf1 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.h
> +++ b/drivers/gpu/drm/panthor/panthor_sched.h
> @@ -14,6 +14,7 @@ struct drm_minor;
>  struct drm_panthor_group_create;
>  struct drm_panthor_queue_create;
>  struct drm_panthor_group_get_state;
> +struct drm_panthor_queue_fatal;
>  struct drm_panthor_queue_submit;
>  struct panthor_device;
>  struct panthor_file;
> @@ -26,7 +27,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  			 u64 drm_client_id);
>  int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle);
>  int panthor_group_get_state(struct panthor_file *pfile,
> -			    struct drm_panthor_group_get_state *get_state);
> +			    struct drm_panthor_group_get_state *get_state,
> +			    struct drm_panthor_queue_fatal *fatals,
> +			    u32 *fatal_count);
>
>  struct drm_sched_job *
>  panthor_job_create(struct panthor_file *pfile,
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 85e197d7a528..c9a681762b96 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -1072,6 +1072,27 @@ enum drm_panthor_group_state_flags {
>  	DRM_PANTHOR_GROUP_STATE_INNOCENT = 1 << 2,
>  };
>
> +/**
> + * struct drm_panthor_queue_fatal - Fatal error of a single queue.
> + */
> +struct drm_panthor_queue_fatal {
> +	/**
> +	 * @exception: Raw CS_FATAL value.
> +	 *
> +	 * Zero if no CS_FATAL was reported on this queue. A queue can be
> +	 * flagged in drm_panthor_group_get_state::fatal_queues without a
> +	 * CS_FATAL, for instance when the group was killed by a VM fault.
> +	 * A later CS_FATAL overwrites the previous one.
> +	 */
> +	__u32 exception;
> +
> +	/** @pad: Will be zero on return. */
> +	__u32 pad;
> +
> +	/** @exception_info: Raw CS_FATAL_INFO value, valid if @exception is non-zero. */
> +	__u64 exception_info;
> +};
> +
>  /**
>   * struct drm_panthor_group_get_state - Arguments passed to DRM_IOCTL_PANTHOR_GROUP_GET_STATE
>   *
> @@ -1093,6 +1114,15 @@ struct drm_panthor_group_get_state {
>
>  	/** @pad: MBZ */
>  	__u32 pad;
> +
> +	/**
> +	 * @queue_fatals: Array of struct drm_panthor_queue_fatal, indexed by queue.
> +	 *
> +	 * Entry N describes the queue at index N of the group creation array.
> +	 * The driver fills at most as many entries as the group has queues and
> +	 * leaves the rest untouched. A zero count skips the array.
> +	 */
> +	struct drm_panthor_obj_array queue_fatals;
>  };
>
>  /**
>
> --
> 2.56.0
>
