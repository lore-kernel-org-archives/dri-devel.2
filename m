Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A366082BC1
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bVyCaQHm;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bVyCaQHm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B31710E346;
	Fri,  6 Nov 2026 09:32:53 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA19410E346
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:32:41 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=LQ+kMeTwOQU301pFhKBdpeoPbu4WB/mW4h0nJVYcscuVLXyTCuKUgfV8wXETzpNl17xxEGozUspkPu5LmVwRcy169Z+4xZ5r00aseLGfiXW0LkdQexTvGpuV+bV7FCk8uFuvcDA4+RdCYIAVZFpIvnkQNTDJpqR18BNRKRJPcYiSz+BUgIdN+mYMDcCiqJbakH+a3gabC7on1O2sYp/kaZW1OGQ60keXpooFNGjRsbzv4aUAo+3jQ6KnP1TtDVWjErdb4YevwmhUSwmW3I2XnfKUSKGjwJSoUGlhOF7/LA6gOwHH9picC3JGeHj3unbEYfpMHJM1PRjMkcoMz2IUzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtREUSEWu15gOxY+7irNnpxMTjwmSr5sLdisf9viv+k=;
 b=T61DsWKMwPViwmxyGrRO1i8ioomjGYKeTu17o6eE82bWQ3xXdBluDNPLxNcm+ddVj2o7BXkI/Mlm7N+OvhbDoBnyShwMrgCOJGrWzlWdN8oG4/RG5cWlpvTBi4FK7y8ouO87yBFktcbnxeQ0ckH8RfeTEmZskYJPoSLja/GW/82lhyH/OdLP17Eq/xvFR6XDyJXA920biXT0Jhoa+JjzW/iCnd7fgBSj2YG5ike1kIDWs9F2HReVrH5jcDRYdlwZ/QpyldMAdsIZcRSJipiooOzRq5zAYTSwS8dgiiiyMRnHCeKI8CJF35pHNvd8NZC9jUyA1NOfmfJnRR3ePUnrAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtREUSEWu15gOxY+7irNnpxMTjwmSr5sLdisf9viv+k=;
 b=bVyCaQHmcors8uUZQK07ovNBG32xHguz808zCGdk1zQyONgewzRyKMk62n2CNYuSWdXZRo+ULHocCUse+QGTP7hN7Nk1Nr0dyiBj7BR35qnhF33lN+vtE7U5edtuuOxMzY5zbzvwhaGWIoLnzkAeihyfvIMWr6fb5ZiFeKi9Euc=
Received: from AS9PR06CA0585.eurprd06.prod.outlook.com (2603:10a6:20b:486::16)
 by MRWPR08MB11682.eurprd08.prod.outlook.com (2603:10a6:501:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 09:32:35 +0000
Received: from AM2PEPF00070CF4.eurprd02.prod.outlook.com
 (2603:10a6:20b:486:cafe::11) by AS9PR06CA0585.outlook.office365.com
 (2603:10a6:20b:486::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 09:32:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF4.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:32:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS3y87sSNkDCwx06mBmsW+E0wLMjaI61CrHX322gYJuzPKOqzCENzbEBuRxSryJJDnJawdRqvgAjv2HxxR+tD786Z6JW4N7Xp5z01hqrtBbwxToDOPGFgLauQpDFVFxCSdm43bSSvrwbTt6e+wv4bE5d4da6BdfRCubyMcU1d0hPggVthY4BuyI0ENCmBakpNUCdjgL8okHoKAS8jJ52dmeUpW5HOQqFy0M9d5i/dJjhyK0kc7CoqP+jP42mLiYSOu2yrd4AEBDWW5hBQ4I2rldUvrLSl9RcC6gEiBewVANGvvHt0PzRaeep3Fapu26StYLHXA5QZ464BFxnkQq6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtREUSEWu15gOxY+7irNnpxMTjwmSr5sLdisf9viv+k=;
 b=VoC7elpa/QEWXXXe6A5OA2tg3RrcMelUPtBqdBJmv2yvV2OVphU5gykAuMMTa50g4gFyOpzogoOCdFOl3GImYTNkRco04MgF32VSvw7dze6g1ylpm+pErmXZiUS42sJpQtF9Qe6Js1ffO4V18EcGd5ENPSKgLHgjDB53xAX9C6BhcWVbJcSaPleEn6GwuM8O6vy6pS7JQocov+KI6JFME+vB1Zj5klKi/GAyrWjs+mCdOjBbEhMXad2hZLdlSmBKAQGUq+nOdMPv6NjPo5Nc5J2U6zG2EF0oMTFiYA552r5xdaJxiMNkBpQqD1nbCoASBIo+NgerlzUDCvRI2Y3/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtREUSEWu15gOxY+7irNnpxMTjwmSr5sLdisf9viv+k=;
 b=bVyCaQHmcors8uUZQK07ovNBG32xHguz808zCGdk1zQyONgewzRyKMk62n2CNYuSWdXZRo+ULHocCUse+QGTP7hN7Nk1Nr0dyiBj7BR35qnhF33lN+vtE7U5edtuuOxMzY5zbzvwhaGWIoLnzkAeihyfvIMWr6fb5ZiFeKi9Euc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15) by DU0PR08MB7461.eurprd08.prod.outlook.com
 (2603:10a6:10:354::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Fri, 6 Nov 2026
 09:32:01 +0000
Received: from AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c]) by AS8PR08MB10291.eurprd08.prod.outlook.com
 ([fe80::9f01:508:17aa:279c%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:32:01 +0000
Message-ID: <bba04255-5dee-4dd2-a877-5e169edceadc@arm.com>
Date: Fri, 6 Nov 2026 10:31:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
 <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
In-Reply-To: <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0016.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::21) To AS8PR08MB10291.eurprd08.prod.outlook.com
 (2603:10a6:20b:629::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR08MB10291:EE_|DU0PR08MB7461:EE_|AM2PEPF00070CF4:EE_|MRWPR08MB11682:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8c90b5-0be7-466e-93c6-08df3be8e409
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|3023799007|22082099003|6133799003|18002099003|56012099006|4143699003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|11063799006|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info-Original: BIaMfpUSyWgU3Nm7I27XJHUyr/xbkLDJxIorV5NY9s6Ffvfy2I5dp7toyEJJtnN2rS3/7U364nKTdNRPvYAoIyQpQGUyuO891Ov4bkhh9EDsWBNzBhOxHxt9GL/43tRN/jjcIPb2SrwKcW5RUlnXQ9AKv6CrnxQyl2JQg0N0hMw2b7K6QhQW5v9xMME8lTLnCtXzt58XtcqyZ5oqN5P2lfePXl/T+Qro47qlzikGKdlteO5mfB+0CAkK6p8eCLSclKPAjVf2uSi+sZlNHUXES+mxDKA3f9Ia6N5Ew6E1mp//r2tkO66n6WTjI3OIGCu3RcccRdm8tva13YK+n5iur8q5d+k6kv25UXxOvGZZpgiPcthuMsKifbJo166zJKdMcSHkLdgBR6W50mYolcpSKpEkZy65D3DoKib1+5zu89VMtngotS8n2crllY87VxpIiRsBENulx2uAwFT1klYeZi1sx+bcc2rkRc18rovb+i5A0qSNyY5h+Wy6bRmDgYdXTYV/6Cw7JAHpZEbOwN0y0uJ0d/j+PXoaOWYjSNmPAbfxDxQjn97FttIKG2kiRP0NJJ65B3SXMRQ61qTDJg5A1pCiXVkLn+gmq7Hd9no/W+TyAQUmVCOIzxMJ0kDLHMqQVMReiO4CvyMpRFcFDdfwUdMYjoQ67IVeEdC6Bl/GDl8=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR08MB10291.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(3023799007)(22082099003)(6133799003)(18002099003)(56012099006)(4143699003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(11063799006)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: sE8YfMprxdTVN4UqVKIAwQWSbNhp7SvMsBkmN2LWZzskTVBJjFqyPN/Q4+ntfyXBVwyK3EiIGv9K9mfZBW3j1hWIgLjLIoQ84v70J5brBBAtrtYbqBVrHZxjVuRUBAeHySsw3bSK++mOtzUsvo6CGUtl4zujWKKrwliE5d0D10ApU5e6xZj6zhyYd5Z7aTJtS3DwQoIxjcQXxoxDssNzIaArRs1HFjgmYQhJ5EaQNn/YCqtj8oYVynoFUJE9FH38PR8OTG3CwEU0iFm+L6PyaN5VMtIQX1Q9yY+o38ScgWpzH4JOsB2qYnaDTD5Yis+yTENcclUyPBkuwW5nKFIeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7461
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3d2cd236-6143-445f-9dec-08df3be8cf71
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|35042699022|14060799003|376014|7416014|36860700016|82310400026|261026121527099003|261022105027099003|261102123227099003|261022075727099003|11063799006|4143699003|56012099006|261026140227099003|261021121427099003|261028144727099003|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: JSV8iYo8CS1YkZ91gQAUo7xOpX+BjxoT6Vx416RSJyXWIQFCj3oLS78JMpXzT4LmmV0fEUb7qqI8AEZB6wxxijLHD5dZbK7x6TUYPT5neXMtUlWEL1p0ao0ZClQWhhvb8p98fapYOG1Y+SPzLukgXqbq65jBPH+MZMXwaW0rHWPulCUoRLxhjZYgQddw2xfZ1BtSFIQSQaAxzsUBmQ8WSp2ccAwQ1fu2fkeCniHiaoLfJczE48+lZzf8CMRE37D0ai1i9Abs0zJxUYIidWzQ/07KmdNCMftOhCsMAhnuJwJkJfspCxWRIXSMUSrKwm5DPdS7bPtTdElCcRAke2vm2Z1bHHfNQkWEQXc+Yy5SdQk2yFZc3+HlnOtnfAk9p5duhDWAIp1lfOrzhfAFRsfEFbvi9PpFyDDtTYyGnbtoeAGt6dbnXUOzOXDMjWyclvjiq0oBOy9UBNYivJDc13J02hr20W893JjEl2LPDOaNPiRvSLqbuYy5HQwd0YPNpKDcDxiQdwgh6A8iv2H/BnTHs6/Xo6WcdiOdmtX/SNtffBBioEIvSFEnbQMUS1VAVYprTwAWIeqPi4v6jUyg1MLrZtHx7BY7O5leVruUHGh0Sqb4dDB+xySwEwQqeLG/eCPT4x5yZGws5OaYg8Krhrzz0xVRodPbw3bXo6IwZqSL6knWruw3OG327hxszSQ4DKR5qReSFYkWLHamxnKvorDWug==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(35042699022)(14060799003)(376014)(7416014)(36860700016)(82310400026)(261026121527099003)(261022105027099003)(261102123227099003)(261022075727099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261021121427099003)(261028144727099003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3HVf911bQmO5VteAMWeE5ndQjd9QfoQi33oyfwFSO4oBCc6d8+jPF1gU7XRZkIeLmR1I33X5n4l9t3EVaTD5fVr99/J/GrBoXnoHAm2WhKegT0nJdK3pzH5hyIHyYEETwPoQDBFDS8mvZx4dwf1kC0x+nFZm/934x+gUOpCvo+9G1VisrAF9nbuVInLM7X26XKpzB3FPdKEdZN1US98sbujDS2YDPrpMkXAKM28K80X1ZUTn8HEV4mC0rSFdk33IW7vIqSZhKVXsvSyskG3j+32mnBQmeJYa6Ep2IjrUVsStisPtmZcx4L61zk2+phehDYl34MXNXJTsUsyhye03/Swu8Q0gv1CLfPODb8P3eZNQMsl9R35ZxmwTwuuSAuXjF4oFKSm7uNhEPdKOJyFL44g82Bvf0af/Xao/VeRfUj61Zfh7+Lxhw52Ry4jFoe/C
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:32:35.3300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8c90b5-0be7-466e-93c6-08df3be8e409
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11682
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026. 11. 06. 10:05, Christian Brauner wrote:
> On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
>> Add __free() support to eventfd and update drm_syncobj to use it as an
>> example consumer.
>>
>> A minor discrepancy I encountered is whether to put a semicolon after
>> DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
>> I followed the example set in core-api/cleanup.rst, and omitted it.
>>
>> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
>> ---
> 
> I'm really having trouble seeing how this improves anything
> significantly. Probably others have the same impression which is why
> this doesn't get a lot of review.

The goal of the __free() API is to reduce the number of goto-based error 
paths. Normally, you'd have to keep the state of every local in your 
head for every early return. (Has it been initialized? Has it been 
consumed? Or does it need to be freed?) Then you need to arrange your 
"goto tree" (error labels) in a way that frees everything, and then for 
every early exit, jump to the correct one. This can be quite complex for 
some functions. Look at KVM or HyperV eventfd code, for example.

By contrast, you just mark the local var with _free() and an appropriate 
destructor snippet, and the consumption point (the point after which we 
don't need to free it on a return) with no_free_ptr(), and the compiler 
instruments every early return accordingly.

Bence
