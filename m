Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97441606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=aFVZoTMK;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=aFVZoTMK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA6510F66C;
	Tue, 24 Nov 2026 16:21:19 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B477F10F785
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 16:21:02 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Pk6FPDP2fjVy/aErzDya5cuTvOdxwklcHDKMDPbVTpsJY2OMtarj1GwarBarW44iX73bYEfsFhomYbhA1pNZXJVvbGvNT2r7m6gPB2BRtt2Kg8O31EK4IvRpGc4gcfMxKpkzxPqKT3L8XN34Y1PUtGosjkRtrV/thbP8UfEVyElfYI/sL0FhxwUqk/S0wrrIM3+uWOXzgowUtAC6tvE8a++z9fLJKl0CuMY0MBWwV2IffEs7ccZJ+R9EKeq+yqClHM6eQwXcjMZQVarVEW42uYBo2SK65K08L0s+V3JTJRMjUGO3wpqdO1ZbtatKeQCBliVXlAXX8nRVr0X12A3W3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyJz/9h1+JxLmmxRL+D0yQa5XYHdWHsjafulycnwcRM=;
 b=oYZorEe5E5wRx+uSQpzzDgf4gZ1BgX8z4mqe8C/wF4yFaeul5R0lTUYehXlsva42XVUPTMK8fd41gb0R5PTIUyKxD5bNceBSCpW9yyLUAUKzhiflfPXYJ+iIFEcaeUUyx8XhX/uvhA7BsJ6NWEAifUGPEFkAFbEs6Ru4TtnnHrN9hqmcGAflczjU5yxeI4azCzuf43htWKm31+ofjszEbuRL4aoR7u153Nn6Bp52i1UTW/mBty/7gk4ZObYutRqERR7MEoJV2wITRQ8LhnCEDB5qsjmJLBg90ny+MofNZjAln8XMWfbKCWUh69j+rDZbcGRwZldFqJPh3ja1bQPPzw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyJz/9h1+JxLmmxRL+D0yQa5XYHdWHsjafulycnwcRM=;
 b=aFVZoTMKeiGY5j+s9ZSlnGbbVb/F9qqwxTqwrBDHhIVRn5Js1HLVqcyA5fnTUR8rzStTWaG1CsBfyaODi4X42cMUQqpCa960rSQdJpniESqAKa7ZRoVIGdykNO7IjPAY6La5qrFIMwTejkEz1kGiWnNyRsoGHt6a1ERkMgeYpjA=
Received: from VIVP296CA0082.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:352::7)
 by AM0PR08MB5348.eurprd08.prod.outlook.com (2603:10a6:208:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 16:20:59 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:800:352:cafe::54) by VIVP296CA0082.outlook.office365.com
 (2603:10a6:800:352::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Tue, 24
 Nov 2026 16:20:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 24 Nov 2026 16:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H321glfeFRJz0WKlwyhFCUXK2VZUDkhRmRruOtXFStoD2dyz3NLhcwmsROsgAJxwXTmBiLl5/B1dXhE8+k8wcZY8IWna+CwdvGduabLHHcKAPNQOnr/NbxAKQYXK6lPz0Mpw0Gp/YelFfJOB+CTIaGy1hU3d/47blf91OkCge9G1v8nWAom1cK/68V7xxHM5hHZftSCVrl0VkF2gFFUIjL5/80n6zOB8sQ+ULympAqJqsgfer1KHBL2kn4sfhoZsTAlSEkUocnL5Q44e9dEdIdBVk1l1j6/7hlDtDdRV0bxRnPRmvcXDClPzZoSAsbfNLNbilYb5AtKXGPebmgIxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyJz/9h1+JxLmmxRL+D0yQa5XYHdWHsjafulycnwcRM=;
 b=o22tKsJQMrwGdBKluWg4kqooNaePONWNecFxV0uCnY01uUTxmEwmeHATU6mkE2c8nTblqWUV1jRiSUX2edrJx/hRT0ok+ZSo5Z7+B0Yk1UE3gGgKjN0oNF02jwIXsDV2Sv+eUfn09T03ugX5uKecLwvvSNz/JNVsMWt6akYoolra2P64aqxyk2BCtYoeK0aHKVKVPgM4M78NKrJRkwAczrnctvk0UpUgKas+KnPUZ5rGW/Mz5a7Moq3DlPdyXIwQxg9xAMMDXcIgLrmyvHti8Yu4rGxn81c+I7OwvW/1HuyNRp+YijMCmPZopXqEonGssZQ/Z8TrAChv621WRXq4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyJz/9h1+JxLmmxRL+D0yQa5XYHdWHsjafulycnwcRM=;
 b=aFVZoTMKeiGY5j+s9ZSlnGbbVb/F9qqwxTqwrBDHhIVRn5Js1HLVqcyA5fnTUR8rzStTWaG1CsBfyaODi4X42cMUQqpCa960rSQdJpniESqAKa7ZRoVIGdykNO7IjPAY6La5qrFIMwTejkEz1kGiWnNyRsoGHt6a1ERkMgeYpjA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com (2603:10a6:190:53::6)
 by PA6PR08MB10858.eurprd08.prod.outlook.com (2603:10a6:102:3d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 16:20:22 +0000
Received: from MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28]) by MMZPR08MB669593.eurprd08.prod.outlook.com
 ([fe80::f3ef:efa8:e69:8b28%7]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 16:20:22 +0000
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
Subject: [PATCH v5 7/9] drm/panthor: Skip devfreq when explicitly disabled
Date: Tue, 24 Nov 2026 16:19:45 +0000
Message-ID: <20261124161952.1053586-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124161952.1053586-1-karunika.choo@arm.com>
References: <20261124161952.1053586-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0637.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::14) To MMZPR08MB669593.eurprd08.prod.outlook.com
 (2603:10a6:190:53::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: MMZPR08MB669593:EE_|PA6PR08MB10858:EE_|MI3PEPF00008496:EE_|AM0PR08MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: 63680bc9-c4ea-4c1f-8770-08df4a46ec77
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|6133799003|22082099003|56012099006|261021121427099003|261102123227099003|11063799006|261021123027099003|261022105027099003|261026140227099003|261009223027099003|261026121527099003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info-Original: saMAvwyZQ5mR43T708HzSNxMluE+Qe88k6YCEvht1BH2pCHQsWi0xvau8TEegTqFBt/stWjCH0S3KQdlrSfHj8RL7MnZ4/p4uhWYacq017O5c+r2JfpwEq+7NfIxC43bPCUsZA+/2Tuck3dBq5KdAAqj41+8nLQIxOaPPwDNWfCYiZQf+XqslQbRPvPlBF2G3d4p3VtbSMQZYibnlcIkF9wl6wLYJdICrdMd6s+bJJPsD80M7jMIVYEUsUWgscrilaULJLbWnxJpKCQAzRCvW1yOLXBhw24kH7o8KVBMk6txqf6dWx4hXHjqFTjkYRss4T6VtMOsyQtmsz14DLvJuR7rsWf2lY4PwnPN0cRu72uQERs1yQNeKLWeAFm1HYwWrLcq0wk3V0w7FcoHF8IU9A69mC0q95nSBV9DBVlb55nH73hEzhnszbt+uNaiWphVNOrp+hKoohaozvGKcWYsl8it5KhYCUZ9C3B4lb5+r0By+4oKPelZByZT9CuHEAPWWpFK9Y7SwCrMQjccJ8AIcJXzNmSQw4Qh2B4El4IFFdbja06AosSKtiaA40/gtf/r10WY/XFWmC+0yi2uKhV/34rNPWEriM0iqYX6gFo36HpaJSvOY5GFkz29I4Fc9vltvKpDVmkWYMRwmS8UEatgl9y5RiyV6iNc1oB+SzHeJNc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:MMZPR08MB669593.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(6133799003)(22082099003)(56012099006)(261021121427099003)(261102123227099003)(11063799006)(261021123027099003)(261022105027099003)(261026140227099003)(261009223027099003)(261026121527099003)(10067099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fHgtZpAbKN43N9ES1VYjbTzWNvntt/7LolAoLoKyNQjSd2piQLNrU2IsJfgmbmWPardYlI8VuUTmhqBWx+maxeqUCe7j/I8jRAdOsmAMHbYKnwBVG3bsF6BkbVYzaMEeEexTUdr1ee/qk6ST6kPTM+wGpX7QZhd/QAQQ1sqSFICkSZPJNKrn23pxx+uvsUuU47lLJgOwRSQ1RpSL4sprWoCC7I2+xuExLZCRMg8/ZkzVEW2Pg4mK4IVEfTec2yz6/kwaiEh7TuaCr5O/bbHZkJWSyLNrauQgdkQnxiXMAiGSc4Al4gEJgwWufkf7OIZ9zBvKj0c0qVR9AWDoIXlrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10858
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 24045a0f-ffb1-4757-00d3-08df4a46d6f4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|35042699022|376014|36860700016|14060799003|23010399003|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|261028144727099003|261102123227099003|261009223027099003|261026140227099003|261022105027099003|261021123027099003|261026121527099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 2fvqoKU619nSHG+UP1whEvyGHJINuNl8HIxhdVfsF1MujCfyalU9UZYOYQ+ADyR19dwziH1/TmAgf0pi/XFAwMlGacu7lBBKPhpfbXxvG6i62aWla8++Y7r+dOnqCPfZxUaVFDKBIAzOd8Tycx7nOkGsXuPqhpuCPH/BsIeZBYJk+X4Kr2laCYnvzuzJvl/WBqsKn1xLRCrACJo3VjO96jIGl8JQ3rI+zQrCRAIgB9Qvp6kFz97qhe/xvOlz/uABS0um5QJQq4zmzvYV/K/LO2hZzSR+7HDmlBk+jNx8s+vMsNFzrc7sKxw0zYWKY2Scky6zpj4M2mpUigOox9Tj1kdl3vNyMYaQ41QGlylNPMvosYxql97OpIoJFAVLRk6yA6XiA+9iRPYC5EkFzAPSc3De48BMC9vC0E8nUfDdkdc/imJKtARdDLIVxumnrLJ2evy2haskcWQ4HO2R++nKC3ZMgSh9a9rEkNx1z084IhxR9KH0mNWzguEAOW4xuX7EDgpRnL+1j/XjAJcDDrtHlPf1xem2W2weDveJ5jlmuYd3Bm+EGwotgQzC6uWmYfribgdpeJbATNTwbqTrIy+/rbyZiJycWzmouOoIx3ObbPev0c1j9aGyb3ygnPzPjOj73hHPBwvrfOe/kzi7HlTWU37m62TcvQw8KAyqMJvFjNCSH8LageINsmfXPz+Ne/75ycj1iSNBfQdN3ZJRswZylg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(35042699022)(376014)(36860700016)(14060799003)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(261022105027099003)(261021123027099003)(261026121527099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bl8DzUESjv5Ez5lHzTW+k9dYPgdS2wRkZ148Ar/DGI4kIDUs/rD6zDJY9pTmPi935PF7UvFX2mxvMr4pPjOuiHchq/lDSVu0rnqiMupCdDriKOsTFXV+5otygbRfVX5yQkEOk+uakabh+JHMkZccEmr9j1Vju7tN+ucqK2roux6UZx+38a6pXCxR/ybsb+STMQ2ui9RNNCPE8bKfTUUOntjQ4EbICmQCJKDOXq6SVakwsUcnVKKV6AcN3VLOVJh7Y9vu/Rxj/HtcZDoLi+O1oKQItJm4EPvF99sQ+8o68Pl6ABn1+ob171cR+OGRtxbxXJPbypYOs7g7HFf47l3QAq8HtZqwZnHGCQCluhfV0A0Zg+elmC0Unjg+6L6HAL7A0FTBUJ0F8Ezh0MMm38CRAoEkXGQGVpkyGonBi85LD1F9YRIKu+5PrapFEClWm2vn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 16:20:58.3437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63680bc9-c4ea-4c1f-8770-08df4a46ec77
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5348
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

On Mali v15 AM systems, frequency scaling is handled outside panthor by
the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.

Add generic devfreq_disabled field to panthor_soc_data to allow
disabling of devfreq for other use GPUs and make panthor_devfreq_init()
return early when this flag is set. Ensure frequency can be queried
without devfreq instance and omit drm-maxfreq-panthor from fdinfo when
the maximum frequency is unknown.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v5:
- Picked up R-b from Boris.
v4:
- Use panthor_soc_data flags instead of compatible to allow earlier GPUs
  to also disable devfreq. Resetting R-bs as a result.
v3:
- Omit drm-maxfreq-panthor from fdinfo when the maximum frequency
  is unknown, as on AM systems without an OPP table.
v2:
- Directly call functions instead of storing function pointers.
- Picked up R-b from Liviu
v1:
- Only skip panthor_devfreq init when OPP lookup returns -ENODEV instead
  of direct DT-property check.
- Support frequency query without devfreq.

 drivers/gpu/drm/panthor/panthor_devfreq.c |  9 +++++++--
 drivers/gpu/drm/panthor/panthor_device.h  |  3 +++
 drivers/gpu/drm/panthor/panthor_drv.c     |  5 ++++-
 drivers/gpu/drm/panthor/panthor_hw.h      | 10 ++++++++++
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index 2249b41ca4afe..8b215e24b02c3 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -12,6 +12,7 @@
 
 #include "panthor_devfreq.h"
 #include "panthor_device.h"
+#include "panthor_hw.h"
 
 /**
  * struct panthor_devfreq - Device frequency management
@@ -154,6 +155,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	ptdev->devfreq = pdevfreq;
 
+	if (panthor_hw_is_devfreq_disabled(ptdev))
+		return 0;
+
 	/*
 	 * The power domain associated with the GPU may have already added an
 	 * OPP table, complete with OPPs, as part of the platform bus
@@ -324,9 +328,10 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
 	int ret;
 
 	if (!pdevfreq->devfreq)
-		return 0;
+		ret = panthor_devfreq_get_cur_freq(ptdev->base.dev, &freq);
+	else
+		ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 
-	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);
 	if (ret)
 		return 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index f0a96ff0f13da..31f9341b5aeda 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -45,6 +45,9 @@ struct panthor_soc_data {
 
 	/** @asn_hash: ASN_HASH values when asn_hash_enable is true. */
 	u32 asn_hash[3];
+
+	/** @devfreq_disabled: True if devfreq is handled external to Panthor */
+	bool devfreq_disabled;
 };
 
 /**
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef42..b4d3d339b04b4 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1715,7 +1715,10 @@ static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
 	if (ptdev->profile_mask & PANTHOR_DEVICE_PROFILING_CYCLES)
 		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
 
-	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+	/* Omit the maximum frequency when it is unknown */
+	if (ptdev->fast_rate)
+		drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+
 	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
 		   panthor_devfreq_get_freq(ptdev));
 }
diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
index 4cb603a3acef6..f93a6b16df2af 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.h
+++ b/drivers/gpu/drm/panthor/panthor_hw.h
@@ -95,4 +95,14 @@ static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
 		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
 }
 
+static inline bool panthor_hw_is_devfreq_disabled(struct panthor_device *ptdev)
+{
+	const struct panthor_soc_data *data = ptdev->soc_data;
+
+	if (!data)
+		return false;
+
+	return data->devfreq_disabled;
+}
+
 #endif /* __PANTHOR_HW_H__ */
-- 
2.43.0

