Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0938EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B46FD10E84A;
	Mon, 29 Jun 2026 12:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="WgJ1IeEz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WgJ1IeEz";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC7A10E84A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:19:10 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yT9tLFYPir7m5aY4jchMN3yFsjeY7LeBeQROJCCEdKTw2jsEZ0ZyWbWc7NUThjPT5qSsDLoSXo8eIaZ4woL/ygUsK9lDmWirPy4MgaKyjUDX1QgkBEwR3wj8K7HMdbZXc3ne4+Gp6f7E/uYN+7nCXxGkb0RCZsy7hwn4A82XUXfHoABGKKCQhB8dnPEaoDJvsnX9ZrXS5zCyWrAeMFvXm/z6NdbuOundkwqkiTeox3LN6Hr2SXWJsRjqKYrLt1IkMyB3dwRHOmOl8Y2hJLeGmIRx3LC5TJqrsRlEBJQSb4mlDRSE+2vI+Obf2cZd+fpJfYBVPpcdtDSAsRcfNtuGQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3/V9T9jftNw0WdxR5VHBKUaeAMj5XvmLjvsOuKocL8=;
 b=TwTlVlQGo5cyAlD/qiNlhK5RRG9i+96v1s0oNlxuuj6KNxbDW3hSzxFgkLKQClHjW7JEHiHlzXF+q86swuCc9c488C8gYkZUggTZywb/yiEFPVbE1ExEXq4RgjV1tTsgLrr5vLBMm1n7wt94fcTVc27mjH9qb6RNdWz+cSq6JiHoY3SzXOS1oUapZuZHRBqgrq/anOZUsG56xphNTR/9RPOAfRnFMqRX7iHGr7jxgzF7FPRQUeOkYEg9xeJeqXNXNzspP12ISKcb9lvTfqww/e1uIlZOfSrWzCLOxj10GMOwxqxfM9lOdvhcMP6kfadKDmXnMIbDT4gdLnHRdlZraQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3/V9T9jftNw0WdxR5VHBKUaeAMj5XvmLjvsOuKocL8=;
 b=WgJ1IeEzGQrBDvoKIjvjHZ1QYTuynwQAX3YskAK7+gH/qvJToc2J80BK1uBPkH2ubHUGC6H8Mc0YbXTR5Pcw42e/EDQgy+f/SFwO0jfg7Ny01Nr/hN7yEKd7ACGQDJtqIDdsGI2QDKFeNOGFlOvektFDU2pwTHkP+OHkFo2dDWo=
Received: from AM8P191CA0030.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::35)
 by DU0PR08MB8018.eurprd08.prod.outlook.com (2603:10a6:10:3e5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:19:04 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::69) by AM8P191CA0030.outlook.office365.com
 (2603:10a6:20b:21a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 12:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 12:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoX/7tyQJetv3hqO/xhoXFe6bZjTXVwrg3lEmCyWO/TsaWEAphe/z9cYSJs4Vtmy6afCSRyyVlFOKadzinrz6bcUE8bUofZoyRq9QjeVJxMH+TP+mVTXmLZ/zPc92OqDHbyCFBF8QkBPZ41TcAWoUh7CfPR5ZjQ6jpKsqxvbW9i8gqRk4baDBfvGvQjnYQdQ8JJ1aujsyqHhRPnhu8ZKETrkEyW80bo3ZJxNRBARJ2Q9IAZ644Aryc8WnXT/uzVn+Xca7nYK/3Te7VS0UZgeWQz3MJ9Pi49Zy8BsBXPmIPLCcEtFuIktP4p3Fyv7PoLw1/6/Ig5ALTjy7gsFgk4mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3/V9T9jftNw0WdxR5VHBKUaeAMj5XvmLjvsOuKocL8=;
 b=ssWRLiEUDzuOoYpLGrzOfdVrvocV3UBvdzFsd5xKCsxkgz0HMvJNq9MVrDvI7BtxsKAI19FvviGPVkPGc4X/7tmz/VMIBalDPojLCux/uHCymsbdksMHRON/bIjRXVhXWbJWvHgsCBK6ljcddsKrBeuhuA9A2rYG1a7LXTp62UY/zSahCArHfeTmpLS2UzEvktowsm/U4bDIGXQcx7oviuAxJCwYFnJ5JUbplFAwrlGiqnLIJVzmauvt5v72oM6FNaUT6Rf7KVx3f80zOUTHwXkFksCdI1RC/1X0twhSp8WJwHgT4ThiA1jipXuFHGvtu7AqQ4kKJhdTdQUJ2hfQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3/V9T9jftNw0WdxR5VHBKUaeAMj5XvmLjvsOuKocL8=;
 b=WgJ1IeEzGQrBDvoKIjvjHZ1QYTuynwQAX3YskAK7+gH/qvJToc2J80BK1uBPkH2ubHUGC6H8Mc0YbXTR5Pcw42e/EDQgy+f/SFwO0jfg7Ny01Nr/hN7yEKd7ACGQDJtqIDdsGI2QDKFeNOGFlOvektFDU2pwTHkP+OHkFo2dDWo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AM8PR08MB5729.eurprd08.prod.outlook.com
 (2603:10a6:20b:1de::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:17:58 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:17:58 +0000
Message-ID: <f4aaf9bb-639d-4383-86e0-1cf5784fcd58@arm.com>
Date: Mon, 29 Jun 2026 13:17:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/panthor: Keep interrupts masked until they are
 needed
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shashiko <sashiko-bot@kernel.org>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
 <20260625-panthor-misc-fixes-v1-11-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-11-b67ed973fea6@collabora.com>
From: Karunika Choo <karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0280.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::17) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AM8PR08MB5729:EE_|AMS0EPF000001A4:EE_|DU0PR08MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 07751013-808f-4f30-dd6d-08ded5d89af1
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: wzMaDtmqx2Bwoef1Yih/vblOcoKFK68u0ECFkFrnsJu8H1ayen3IqBMhMl8/H8ESWcgOPM6HruKFWebNbCOYxdw4GxTsnzxJsDeZm3Ye94DVE6P+WgsP5v3me9MhQhg9ufSP7TnwfFho/15K8zMaHM0ILAIQwa/0W6nY0mtfjuuV5VgTEOJXxqSQUlzeM8CcnW1XinWgKP68lTZC7xyOSLxj1MxnLG2U5GTlSTIvYEoI52M5s6epLobVbeVbnzCggTAhHmAjjYQEyOasZp+5Mya0KxqT6DQWZwvi9eAR79/CX6N1QEQksxneqNN+8n6z8aM+n1fc/z4p5uXDPdDxgN622w1hQwi/k2ibHhgmmrCylGJpnttaEa0r3O4YW2NKhAk/1iK9XMicatZyw82xupWQWPq1qWb6u9kCP48OdDtspO9at1NVPHAAPEWMYySj2OrxSDZCKZaUTd+3Phff/lmx9OgeStnEaOvBRFHcHFaxWCKZRQWTgAAGcSBwxOu0UBZgPpDUjBOwXzGClegT3zEE7Zz7suJjTuKNq2KXA7CWHS4ueS3Qm7DMPcZIh+vgNyFseq6BQeQQelrTvkNo8aLwsmKT1gxjE01z/bWKAuo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: QDg0vqn7fKEYd9+ub1XWlP8/oUYSxpb20X0rmkPUh1/RSnH1GwYqr+L7Tw2vnAc9JkJ/sH3X7VnThRzIKARpwqlWsKe5qTZDvWGZA/OjXmMZo2wns+PVRAJtkJqXyzZvt47YYbdm9vC7K+N4kEVgm6aPi6Lh2pPK5r821DGRJFFQ0EJ6XV5UXrqWpGRb/+GmRZ7elHtee1mt4yBJen6It9e3MaR17LcZy+XUsrdSaXWug0MKYJojg4+/EpxYq5zQ/c7bTu9XTxK0bWbeTv39AHMdQm717nAARb1D8s02uD3t52VWHahTPcbAqSVoL51QB2JTYdsa4dp+RYRZ9k+wCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5729
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6defbf0e-2acb-41e6-6712-08ded5d87484
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|82310400026|36860700016|35042699022|376014|23010399003|7416014|13003099007|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4NCR8OUmufKGMnbAyUZgcW1l7Ctr4HCnGloLauwOI3rD50bFfI5uhQyuqWPuDnvDoYuYJaXJxJdCDnS6VDlVb+/nOf2P+CCFOPMeMCPsGDIlQY41/AvAkaYiNyFh2kDJv6ro3kMTMNcQ7ZxAZBxYeMQ3u+5AAHU3QKI5uN7eobywX5tkiACGPFXVm+DY6dkjzQGw6rfSZ1KjXatoaBLv2Kk+hUM8ZalkRtpMJBYAqk7Qmr91RbuuTQ0K+xWVoIGJciqfnVmHvEtICmCi3/Yk/pydUqrJxsfUmDMsXSl7Z5SgsBTlSk3sbqwUCx1CgkEUV1XbO0gmLMKQN3GTXidRV0g/21ttVAtCSqgA63Qs8rIwO2qxI308jW1iR9EJ8KnY5qEgCjrPxAzlasvhVYXwx+CSW2YapiNOtNE31u+BcrmWFHxRC+49YYqeyO9EYQkQ6RwOzCDXixxYIv3AtBYse5pCuxKvllFELENyo7ZOKd9j/qnUfNGdE1KE19Zsx4bmazsaZSokkQRYGwYifLFWFNhIvIZLlC2S6yJA1Fac7mTCnmWVG8KYXc9qL7ZC5zW8XPzNpBiJ+doSTQHYlWVA0DLfVnkre/wwdQD7bi17GXAg8QNyIvR17D4vlWQbcq4SBXWjnF/IMAtmd2hOak+Vbg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(82310400026)(36860700016)(35042699022)(376014)(23010399003)(7416014)(13003099007)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: INeg3qDtnjTYic1HdEz7uWGc40cQPkwEjQUJR3y+d//wltQB0ma+3qS+qWO/0S/yzhnmaHmbpCFJGJk4X3eVbPqxNxKwXe2EFpog0r6VUj1Vnb+Kk0W7e0ladSY0ghNl2ji4MpcVt9TKfXDoGfxii5h8RsA93E/awV7ph6HzHcryPQWnWY/aVcxrg9VwOdx35PNK6QqFNZq0qn87530iTnnsYTItIsWRX6hO9tmdm0XGhQiRwB8zg8si2Y29tcqx7YOMc2PC4HD5DtGZLQpBRxbV+HdrdKAx6Zea/i2WeCgs7ZQuynv9Z7x1Jw8kDYDJ7XY7EJWoOpAAMH64eT2SviPZ9Usrmd/JRhASKIaFFkr45wSfXZ7syFhof9AhgTGTd5f0//LtEoSCTxWKzk0lbDIibirWQdqZKA5LoFSX5gFyKjutMHbtIukBiZPehUqQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:19:02.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07751013-808f-4f30-dd6d-08ded5d89af1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8018
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 25/06/2026 13:40, Boris Brezillon wrote:
> The autogenerated panthor_request_xx_irq() helpers unmask Mali
> interrupts before we're sure we'll have a handler registered. For
> non-shared IRQ lines, that's fine, but for shared ones, it might cause
> an interrupt flood if the HW block raises an interrupt for any reason.
> 
> We could reworking the calls in panthor_request_xx_irq(), but it's just
> simpler to let the caller decide when they are ready to handle interrupts
> and call panthor_pwr_irq_resume() themselves. While at it, rework the
> prototype to let users call panthor_pwr_irq_enable_events() explicitly
> instead of passing an initial mask to panthor_request_pwr_irq().
> 
> Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
> Reported-by: Shashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com?part=3
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 7 ++++---
>  drivers/gpu/drm/panthor/panthor_fw.c     | 2 +-
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 3 ++-
>  drivers/gpu/drm/panthor/panthor_mmu.c    | 9 +++++++--
>  drivers/gpu/drm/panthor/panthor_pwr.c    | 7 ++++---
>  5 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index a39386bd6382..0fda64fbe5f2 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -588,14 +588,15 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
>  												\
>  static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
>  					      struct panthor_irq *pirq,				\
> -					      int irq, u32 mask, void __iomem *iomem)		\
> +					      int irq, void __iomem *iomem)			\
>  {												\
>  	pirq->ptdev = ptdev;									\
>  	pirq->irq = irq;									\
> -	pirq->mask = mask;									\
> +	pirq->mask = 0;										\
>  	pirq->iomem = iomem;									\
>  	spin_lock_init(&pirq->mask_lock);							\
> -	panthor_ ## __name ## _irq_resume(pirq);						\
> +	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
> +	gpu_write(pirq->iomem, INT_MASK, 0);							\
>  												\
>  	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
>  					 panthor_ ## __name ## _irq_raw_handler,		\
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4fbddb9e18c8..de8e6689a869 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1474,7 +1474,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq,
>  				      ptdev->iomem + JOB_INT_BASE);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index e52c5675981f..c013d6bf9a59 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -170,11 +170,12 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  		return irq;
>  
>  	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> -				      GPU_INTERRUPTS_MASK,
>  				      ptdev->iomem + GPU_INT_BASE);
>  	if (ret)
>  		return ret;
>  
> +	panthor_gpu_irq_enable_events(&ptdev->gpu->irq, GPU_INTERRUPTS_MASK);
> +	panthor_gpu_irq_resume(&ptdev->gpu->irq);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..1fef3c5c1b50 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3406,7 +3406,6 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		return -ENODEV;
>  
>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> -				      panthor_mmu_fault_mask(ptdev, ~0),
>  				      ptdev->iomem + MMU_INT_BASE);
>  	if (ret)
>  		return ret;
> @@ -3424,7 +3423,13 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.mmu_features |= BITS_PER_LONG;
>  	}
>  
> -	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);
> +	ret = drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);
> +	if (ret)
> +		return ret;
> +
> +	panthor_mmu_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
> +	panthor_mmu_irq_resume(&mmu->irq);
> +	return 0;
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 090362bd700b..f2c2c3000590 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -484,12 +484,13 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = panthor_request_pwr_irq(
> -		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> -		pwr->iomem + PWR_INT_BASE);
> +	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
> +				      pwr->iomem + PWR_INT_BASE);
>  	if (err)
>  		return err;
>  
> +	panthor_pwr_irq_enable_events(&pwr->irq, PWR_INTERRUPTS_MASK);
> +	panthor_pwr_irq_resume(&pwr->irq);
>  	return 0;
>  }
>  
> 

Reviewed-by: Karunika Choo <karunika.choo@arm.com>

Kind regards,
Karunika

