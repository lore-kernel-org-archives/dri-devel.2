Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF8606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Yd8bgx1d;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Yd8bgx1d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7766E112542;
	Thu, 26 Nov 2026 15:40:21 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200B510E942
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:40:08 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QlbEvi7kufhgaf/1HLgqOzXj5yLTR0m6p8r0GpVylroF4BmRBIAc5XN4lXilfosKW+xp3E/LPHIz6BGHoJbEj33g5/2tNsxpHsBzB5o5+AA2aLlA/U4/CZ01amvu0ab458BEWZs9nyxBh1ZLCb+kbRcDHYTtKjkX5wHR9hqmHGbtAV9pnM93GZLYd8SeONRi9y2g/c+J74gBe/tJWu9C3GMRAUSHp+dWPZBW6DGNuo6oLZMxsAiiGO/rd+/jL00IxlvUUrxfIAxyjJtOdb8aVHnkcPFLTv78ltO/zF89dPKCYwsZsOH+JkmQZtBprFacLU7YKLO+Mse8IFB6OOaUmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwwuE+XxCUUK/N4zke+FGgRdcxqh1KruQK0gDNsoIDo=;
 b=jZqjTc7af0p2j+lA3ADWelRrC6j3AbsPXZtSgmK4D4rrLfIsDCoFnQq09WtGxDyYOd5whVlC52oqSakkph/twC6IrvNywOga2r14a8Q/7AMBl8EmeMT/hPEMi3sFWZnWVvwb/MfJDB+hbxfP4+TEOJcjvUUY7/iFm+ofg5sMSYdpnx20Bt6kdEob59xq+Dtq5/Du68UWRav6XwCpBP9mylbtNIaHLSn5ERzdIfXhFYfGjlgR6ObEnXJ2TCceMOeHqOfq/lnl6p/i85QBhm44m4FY7hgOGjeRyGNfMDtEVcThpAumsCEg1IoPwZEF4nh1532HK02c/5UDJk98Vn+DLg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwwuE+XxCUUK/N4zke+FGgRdcxqh1KruQK0gDNsoIDo=;
 b=Yd8bgx1daDD7i6oKa/U+Ux4SqA2hx8f+Il/Kqu2N5qhEJLw53/lWYLmwmf93fn/EzM91bSFxEBL0N4u22mVucGWdpG/LAtyJx0PvKUCJ5E9gmYloWqNIWd3AJGmWlyE/9VHJ3WcUHlCasvDup2Cx0mk3Uf06PMyrPIparZ/Odq4=
Received: from AM0PR02CA0182.eurprd02.prod.outlook.com (2603:10a6:20b:28e::19)
 by BESPR08MB999897.eurprd08.prod.outlook.com (2603:10a6:b10:105::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:40:03 +0000
Received: from AMS0EPF0000056B.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e:cafe::96) by AM0PR02CA0182.outlook.office365.com
 (2603:10a6:20b:28e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 15:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000056B.mail.protection.outlook.com (10.167.242.121) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Thu, 26 Nov 2026 15:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFvnJHIPLcFIv7ABfP6PBTxKHd3mtBVZ/hcxTKZdCIKpcZv8cbf6VCReZoSmk3STuXGYg0r7oJx92uTNT4McXvWxOa+UJWT+DVEk4PfJ3+RKCsTPtAQsES9u3scgb7ukqXljPuvcs+bl3ugmscmbYnaM/PYOgcjehPy6gKbYNtEwjr99bF8IDIzoFIeAwCXug0dJWiRnk6kuViUjvISbfm5FvrV7rsvbtoDti1H4peEcuy8rCh4CXK72jivQ1NQ/ZZ4BwKgR+2zOFG30uBeAqzN5LByXanHMVUU88bMnWtS2WmEnsIQXTjmhkvJDKyY4GXjxeYAaG7wTJUWlcjbyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwwuE+XxCUUK/N4zke+FGgRdcxqh1KruQK0gDNsoIDo=;
 b=uJ3lEWqo72BRwoO10ogoaZaQHSc8BqcA0lgZWtuKGbyc/qF9c9HkplgxBJmSRFLZBp8ciesVGk3aT9wYwIk3lPV0XLgoHpfQPEErnKMKiFIUVeogdD1WSrpkhOoQVNfjLOAqEtb+tnTTMDL/rbQiG3EFS2lqY0aXE2WCzfDyH9MFpR3TjLNuva39yL9TmayifHyZSqndDwJy/tQoDmo76m140gmnq48lvXkQ7Ig6m1AOwvJpkviyHfXSg+/BnEnVnE63TcALQJmcvCjQHYqjJOEVHQV3ylhUyzuqRU7VeGxjOpxdHxHO9p1SYbCNZ9VsGDlfdBcCxukNBD7Bf3TYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwwuE+XxCUUK/N4zke+FGgRdcxqh1KruQK0gDNsoIDo=;
 b=Yd8bgx1daDD7i6oKa/U+Ux4SqA2hx8f+Il/Kqu2N5qhEJLw53/lWYLmwmf93fn/EzM91bSFxEBL0N4u22mVucGWdpG/LAtyJx0PvKUCJ5E9gmYloWqNIWd3AJGmWlyE/9VHJ3WcUHlCasvDup2Cx0mk3Uf06PMyrPIparZ/Odq4=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS4PR08MB8022.eurprd08.prod.outlook.com (2603:10a6:20b:585::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 15:39:28 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:39:28 +0000
Date: Thu, 26 Nov 2026 15:39:27 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nd@arm.com, 
 Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH v7 1/8] drm/panthor: Add performance counter uAPI
Message-ID: <u4hptoykb6wsmwtleuoylhtcyv4s6qknzzi4uhi244ngqo7l5y@v6kdoogz6hcy>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
 <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
 <9906d872-8e9c-46cf-b365-9f2d6ff0d61d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9906d872-8e9c-46cf-b365-9f2d6ff0d61d@arm.com>
X-ClientProxiedBy: LO4P123CA0284.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::19) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS4PR08MB8022:EE_|AMS0EPF0000056B:EE_|BESPR08MB999897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4b0957-7c3a-4e31-c993-08df4bd38911
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|10067099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: MOzq5RsX9QXu9kML7JATNwfAqtpy2sDgMV3DOKJu5CogFwUoj9UPz+n1VHIMzmR3FTlurS4XBGmfTPCmsU7aAYCq4PN2iLzF9N+6Yys78UewmK/xGsqnOYZ3D5EyEMlw9ThW5RImq7uo1F11yYV/8EWP1GBPcim/qKbl35VnoGnnPXO2GkR5Yf+LWCATIRjAFLmyoyq81fg7dzNjQt/np4wSE8lGypOR68++WnWVDqClovcaO/q7uWt7xGPK6+b1Qe3bhaFSRw+3wmPJUt63+IQK4rUWNcqJur4G0EMWAy0BA7KYw8OpPoj0gWmOVHbFBmbRQ8Drb/fQYOrHyKkMhKEmhOErIrnpJoKWqnCrsF89LqgK+3Sg8hQb21IaP1RCqQLb9m1TXCQ8XsqFTASyxXtIafda8bpTOqlOWitUoM53fwxGNub959tCOT6hnQkN6AZ0CD3j+jTNnyerR8Uj1Fld0CCn0Ep5SrAYj0hdrXbrpqrEwjZ8rgJszeYhNOrLTlJgRjhmGZJ3yZGfC9Kt5zcUmtEPz5ExB/AghiGqn+bvb03gVhVTIlClnKRfIztMeEeVZ8Bg9s21FQU8C2TTJVKau1bj2Klxy/gilvcCLYjkUOgHbbbQdYJyCZhLUXWv
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(10067099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Uasy4LlSZ1GSWS9HtWCBpjQ0jCmi1c/BhIW2KcnrPyrIptsQk+I6xXeAXnMTOITJGMD/R9Ox0oLaBLWNaBeKNjZgqOikGpFswsUS5hsGY36sL4FmHCGbWcVdJ6W+3HNeUkYAxEEKF90bx4wyAUUcMNZ2n0uQE/HHYm80gANCCfCH7R2JKjQHKjC6gJaFeSwIoyWr+aSUjip4J4dx8xUxGJLdo+sfNJW4UymAvlzxf0yi6dIJP9jNemyEwUWwQsXveWcvLN+OnWtWeLG7NaeJ8Hvr9GDdvavegpjF0O0tuk3c33J5r9nNqgxNO2ulr6b/8yAaGK6/x6Txz5nJNMYcvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8022
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000056B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 460b6aea-757f-452f-e395-08df4bd374dc
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|376014|35042699022|36860700016|14060799003|1800799024|4143699003|261009223027099003|22082099003|18002099003|6133799003|13003099007|10067099003|11063799006|56012099006|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: bQ2koVbZhjl8WiLvx0XInXDRAJj84t1yEczRFf8tiKKqJL5E7+E+FXiuDOVT6TFhF+AzU2V9YMfGaRbHB0PWgP4QcmweqYfUa7rjx1WMZ9pmQPVVzuPPXIjg592OP/cxDs7eXi6A6Qr9qKSNKpXwLy201YdEjONu+OsSQj/2jg0mVlqlS/1CJTdFYSv6aKDLdkE5xC3jFbhQ7Tgm+eNduVlpU0f/GcT02nFiuhrCaZcPQ/FJhdhqNiB2NV+wrEJsPnfq0woebAeJGVyq9G5lSI16ZMlJQsmNvDJ0wSRI1UqniNLWtQKui8xPIWHB4ud+VaYC+YB78Md6RMs20XE5ahNhrwFQ7yXTnQsYoFsnWsoulOdImV/jp9OE9LYqtLvfNLwTvfe1mQxVEdVlJuH0t1n2HpGY3Z/aI0uC+s6h4/8Cbief+nZVCV9bJm5WRSEd4vK7uArY/fWMf1ucRRHKeXTtj3InGn5YtmJWItrij9IwZuoUDuXGjCEBPFGG/pGpfqBLB/EGcJG3O1Qb6MsvV2qPUkRGGri52SJbW6LqYpqDIzDEenCIXDbOtCT0zCcxmkjplxVjC1aoBktTwIxG15puUnT3Lx1S5Grjc/2vHZT+d55rJ482Zcjqgisw1UgV8UmGfMFhvffuuMFYAX9axKpPZdPEAmnsUcqmf102XDY=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(35042699022)(36860700016)(14060799003)(1800799024)(4143699003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007)(10067099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oVfigwzhSlXtOE+vtAR73Eyh8mRu7muXcmWt2ONslnVTNF/hMGIZihGzue79pyWiqLUYsYqOKIFTIlXQMEGtzZ7Nc0YMB9MajbOE+fAk58ouj/8GSWf58jSF41+HoWlvmNuqBs7OoakfY2JohI5tSEaAXjFI8C5QaYzuLfzIGZevEDs2M3vqd1JTV7M72S8mbDEGlVQnb4huphI0706pFjHdA4S889By8ztzDxnsHN0InUowRCKtyFWipJlXqEpzauH4BuerjH7bhx+9bvmQo2MoQFnvYJqPT43bY7kqIqXQiBqVIxPMbIhbNwgjNamgLCyAsVrcaV0hh1QNwZRXg9GB33QjWHfFUWglmec6V7OAYtk4mo842V5EUzopYOkcD/LT3wtSPzfrHhN+7SYBlEbUgsA29JBh4H8vSjfgem4Tik1JRbENa5+TipqkLtqB
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:40:01.8778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4b0957-7c3a-4e31-c993-08df4bd38911
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000056B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR08MB999897
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

Hello,

Thank you for taking a look!

On Mon, Nov 23, 2026 at 02:30:51PM +0000, Steven Price wrote:
> On 11/10/2026 18:36, Lukas Zapolskas wrote:
> > This patch extends the DEV_QUERY ioctl to return information about the
> > performance counter setup for userspace, and introduces the new
> > DRM_PANTHOR_PERF_SESSION ioctls in order to allow for the sampling of
> > performance counters.
> >
> > The new design is inspired by the perf aux ringbuffer [0], with the
> > insert and extract indices being mapped to userspace, allowing
> > multiple samples to be exposed at any given time. The buffer is
> > annotated to include sample metadata and block metadata inline with
> > the elements they describe.
> >
> > Userspace is responsible for passing in resources for samples to be
> > exposed, including the event file descriptor for notification of new
> > sample availability, the ringbuffer BO to store samples, and the
> > control BO.
> >
> > [0]: https://docs.kernel.org/userspace-api/perf_ring_buffer.html
> >
> > Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
>
> I think we need a little more documentation on how these new ioctls
> work. Ideally you shouldn't need to dig through the code to figure this out.
>
> E.g. DRM_PANTHOR_PERF_SESSION_CREATE apparently returns a session handle
> - but that's not mentioned anywhere here. There's also no information on
> the range that session handles can take. Again digging through the code
> it appears that <0 is an error but >=0 is valid. Although digging harder
> it seems like in the current implementation only 0 is actually returned?
>
> You also have a shared "control BO" but there's no information about
> memory barriers. It would be good to document what user space is
> required to do between reading the insert_idx, reading the samples and
> writing extract_idx.

I'll add documentation about how to use the interface and the
memory barriers for the next patch series.

>
> One more minor point below...
>
> > ---
> >  include/uapi/drm/panthor_drm.h | 370 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 370 insertions(+)
> >
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index a2ff0f4ec691..e45f75b76245 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
>
> [...]
>
> > +/**
> > + * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANTHOR_PERF_SESSION_CREATE.
> > + */
> > +struct drm_panthor_perf_session_create {
> > +	/**
> > +	 * @block_set: Set of performance counter blocks, member of
> > +	 *             enum drm_panthor_perf_counter_set.
> > +	 *
> > +	 * This is a global configuration and only one set can be active at a time. If
> > +	 * another client has already requested a counter set, any further requests
> > +	 * for a different counter set will fail and return an -EBUSY.
> > +	 *
> > +	 * If the requested set does not exist, the request will fail and return an -EINVAL.
> > +	 *
> > +	 * Some sets have additional requirements to be enabled, and the setup request will
> > +	 * fail with an -EACCES if these requirements are not satisfied.
> > +	 */
> > +	__u8 block_set;
> > +
> > +	/** @pad: MBZ. */
> > +	__u8 pad[7];
> > +
> > +	/** @fd: eventfd for signalling the availability of a new sample. */
> > +	__u32 fd;
> > +
> > +	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
> > +	__u32 ringbuf_handle;
> > +
> > +	/**
> > +	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
> > +	 * insert and extract indices for the ringbuffer.
> > +	 */
> > +	__u32 control_handle;
> > +
> > +	/**
> > +	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
> > +	 * a power of 2.
> > +	 *
> > +	 * If sample_slots * sample_size does not match the BO size, the setup request will fail.
>
> Actually the BO size must be PFN_ALIGN(sample_slots * sample_size) -
> i.e. rounded up to the nearest page size. I also wonder if this will
> come back to bite us if we ever have to deal with multiple page sizes.
> Is there a reason to enforce exact sizing rather than just 'big enough'?

I don't think there's a good reason to exforce exact sizing, no. Will
relax the check in the next series.

>
> Thanks,
> Steve
>

Kind regards,
Lukas
