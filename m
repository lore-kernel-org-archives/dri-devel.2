Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98188FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0044A10E2BF;
	Mon, 27 Apr 2026 16:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="okiP6JMp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="okiP6JMp";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE29010E2BF
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:09:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tOHs+5SILTJjxIZ5z0Pc7B4Mi1hVGFZWPW1cxj79KbolGpuPlVZzw0RHQRnivaMutSQcaMgoXCsEGG9SYn27toQSnPiLs+9vaLpAJCX+SQ1DK0coG34khrRNtpJHV5Yl+7TDHcXnsU4WT9/gJoatdWULjomUq/n7bcaAZuLtojTrfzix/+1TzLREkrl+vLXvQ7TKuJxTQ/PLgsN31Z2dtZT9Bd383BlX5T1bFr7wg3xeZzAf9a7cYcFiosuOCzfUULuIOM0sk0sZmuDkuCA3TopbNpA9I1EuXqSX8SF0ASLAmaUyHPHIj4BpCFmkrFof6WlnW0Bf0yH63iIpSW4UDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOyF+RdN6Bt2fg07HrFQDc52Be1A6gOyAwBiez0kRxA=;
 b=CiHNUxaghTT6iTJDeSjLFbO4q9Kz++Ys+3nTNKcdNelkDeKUsMl+YzO7e+VgRwAmY4GB6Tv/nvEXKrD5qSb7V4oXMqcVno/luP5H9YHS15CJ1DRdoxO4W2+VzvBL93BMqR0OZHvSkZrEtXI+OLac1aDvKRglB92gu5O8YhvZ70wgNPqQBaKpUAy5hlnV6dzecSh9j0Rzh6k5o8UsHhwaJRPmQt9crRTyLikAEOZB2EESKyBOmOmgnfP2bkvIMStfnk6JWeZC0kynV8XkOVHVTYSNJU9ieHpNT5SM6xTxPtNopqpol96QpfqtHCRcxehmX4mCJpGhjT8QRXoaoPsYgg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOyF+RdN6Bt2fg07HrFQDc52Be1A6gOyAwBiez0kRxA=;
 b=okiP6JMphcpvouUUISxh+71JMmclxEGKvKJ/cEmVovuQNyRKZBum2dv1RefQCO1+OYwS9Tc5BpY+y0RpsUZArApdFgY95JG7B9PbRVoonbFCb3NpE7D4N3YqA7kQE8AFykmcUJXvc5AR+Z8DRjMbR/v/VmsCntawNe8JPW3jAac=
Received: from AS4P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::12)
 by AM0PR08MB5394.eurprd08.prod.outlook.com (2603:10a6:208:183::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:09:22 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5df:cafe::ed) by AS4P250CA0004.outlook.office365.com
 (2603:10a6:20b:5df::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNp/uZmNGLyIVCCvaGD5gCh7zBQMsFFRAdJtwVgKo+DHd/SXf709LhfNCOBUTOU8RbIr15ANDju1J45qkk2ClwlRn0+jOa9OuTo9IsG/mstSre49+JmpQfbTVemvta+v6313PSD0TlOq3QU+/Z79bym/J0AL5zblzLk6bqLLJCw/Bgubt93coT1hcs8e7r1+bcc8LaZD5nQLYO5eZFDSmc95eB/5hFMubhA5W0ZOT5aynX+uPpuuyxYEO2nEb5OWMFStQLmhvdJmGp7vqJc6PkxnVHOE2y3Ycsw3P7hkNZ50pMvMfpstrj/orJBcdXbQvSOV/g1l7NprO+1mwqtiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOyF+RdN6Bt2fg07HrFQDc52Be1A6gOyAwBiez0kRxA=;
 b=cNZbdwh3RrCGYLq61i19+Obi8RvGHIDAsrbrUAfjBUabXlD+cNk2qqK3ELU/wMX226qi5wNLbNdWtAe6hIM3leEiR89h3lQYnL6o7dvXlTdhJFddSDYC0PDh5Vw9ymxXe2hHf0Y4pX2xI9zhkdv4wSNrJczLeSth0GVBweLCI49uyX29z+eqtgDCcy+rTYbWL+1UlWNWPNo6HqpO3Wvd5ZC++nJmV/wBUpNyLQTqiGnvEGs19KiLB9LPLN16ME8pfF8Dicdvo1VQgDpOofcZhs4hdcGhlb+0xhjB1r8cjIOz5o33BDdmy0tboHTFeIwAZKSbbqLIOfIPSWehOqgVNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOyF+RdN6Bt2fg07HrFQDc52Be1A6gOyAwBiez0kRxA=;
 b=okiP6JMphcpvouUUISxh+71JMmclxEGKvKJ/cEmVovuQNyRKZBum2dv1RefQCO1+OYwS9Tc5BpY+y0RpsUZArApdFgY95JG7B9PbRVoonbFCb3NpE7D4N3YqA7kQE8AFykmcUJXvc5AR+Z8DRjMbR/v/VmsCntawNe8JPW3jAac=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DU0PR08MB7544.eurprd08.prod.outlook.com
 (2603:10a6:10:316::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:08:18 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 16:08:17 +0000
Message-ID: <fc33f7ad-42b0-4509-b9ab-0c66adeece4a@arm.com>
Date: Mon, 27 Apr 2026 17:08:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] drm/panthor: Store IRQ register base iomem pointer
 in panthor_irq
Content-Language: en-GB
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260412142951.2309135-1-karunika.choo@arm.com>
 <20260412142951.2309135-5-karunika.choo@arm.com>
 <53a66bbd-7ed5-41d9-a15e-af17f292dea1@arm.com>
 <b6c97926-57aa-41dd-99f8-c5f0397e002c@arm.com>
 <05bc8e72-a914-4bee-b635-fe1e9c623900@arm.com>
 <20260424130302.4fb86551@fedora>
 <5087bbe4-4898-4fe1-9ea2-17e967bfeec0@arm.com>
 <20260424140903.26b03ea2@fedora>
From: Karunika Choo <karunika.choo@arm.com>
In-Reply-To: <20260424140903.26b03ea2@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DU0PR08MB7544:EE_|AM3PEPF00009B9C:EE_|AM0PR08MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5fe715-6ef4-448a-0196-08dea47757ff
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|18096099003;
X-Microsoft-Antispam-Message-Info-Original: omoM1WdnU67Tqe5CVxGyQkt87GGILXJeOCK+GpqvUEoQC/w3WR+RLVw0+rDKtt9Grpj3y+UbIvMHMkAIY8GCpwXoUvSNEyB9quCJ1fhO0Rf3GH/yi/qobv2eBfcj8qxqx2fVoGEag2ExmjKnYNK21z5+8kgrSuF1G+Tz7L+6EpGTPBz4PC2TERF1D0BetADGx2XBABOoziEzuh1sbjZZVxzGmUlwCoVWHD1h33EmyHHmnCwMefJZNmQj2TCPJuWxsJ1xnxAEwHMj5YLKqk9SRmw7sox4TWBdczPCcpnbvJzPNaqS7k8fHnp/ghM8+iEPQo2u6WnWYNn2NBZPZLm22wrW5ZNeosFoHbgJd7Nnxh6OPkbcdRggRsTTQkP9lk0D7U5UKFXIBGhXSjv+h48+wSp31tuzDyCt2WrMWwJB3Bp/7TsU6gSMeMo8DCPjihjyHMRJ42wUrEVMXzoPdDFUOv13AY1Vyzdwvg9TfkYx+atrUjJ1XDrUMlXFfLUp0fk/wGUOkv5jGl2NerGdyWlX5DqyCFaeLRlASEevyUlbBKQDf2lenANt1d+eVaZ9PAT2qKQTWZ3ltUC8G1Rm1utmrOxa0w67jnGqH5BbDNoJb46vz+0liusNgvUz1W19KBMDVV55ZHJ/zVhwNPb5FqJbgUterMa+9A2gbxADza939MbVaskTMzW/MSz3nZj/b/4AFZjEckVIGDhxt5Tve3wesmfCvXnCiUZZ2yzR2vN5GTmVvFJxzA3ZpnIiDkPp4k6E
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: HQgagYkplS7RzetcakcjkbYYvwK4U3yeAxYwv7ahDK4pmd3OYhGZUFTbS83XxiGjIUKHaBheT3ozlSVV7aiQdviMViU8s+VChSWeR4TF18BulB2CE9RP32DSOKsw8nBjtr5u8T0roJgVVy9ga84Wp9hWpz8CP+6BnEINLAIWHhPyHd6vZue6pHFIe6rGTJcZOC7DL2VM2x/UbLW8UpJERSBm1VeRRb1+Ei99gsYDflYK8kD/o394OlYI1/Easo+bpqC/aazvAGVpM1wNjKwm86R6611DZA+t+/9i/ADnZ6YhIGnfrS4rE/rFHJ9H+WqqpqE7Gn+RqSksX1qBOzDLjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7544
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b94522d8-3227-4a77-0139-08dea47731bb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|36860700016|376014|1800799024|82310400026|18096099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yI9viTMp3Ubg6/BDC/5jMDjSROJkP4Lg5RC15y7b28KUb7ybH7tL1NoTwu0wOTSi9M0Ow1pc29QX31wSg8gke7wVVtctobXKZEBKtmvY6AlAVjC/XigtdUaUWW7tcS8xIuMJ8riJ1jYpC8ou1tPoGh+8tTBMWQjR+ddrJx1/XcbodtH6cpYKblCvzrX8np9bUGz8g2zbqlUZ8cxeBQhOu+LOHIyYh16Cd+us0ezV7QbIFj8yGAGt+tWasF5IxQn4zK1tm07zv0UugcGxTB2jsZQ6KQs7/XKo6hMRPud9ff2jZbmXONHtELmW7K2p4ubIhQ43lDYmYbylZidkVb7fxlDFIFSDgIyVocMNLONlkNmF/uvJHonyD+AaZTiDUOiZpta1FAN20rI3HlAx/fn7wZVA/YJKXrIPxPrAKm18at00XItHuzE1LJkJjbomX/wNL6RSMBPLWXrTxAklbqS8LSqNOB0DEgbP55uPXEJ4j1yv9kBvUHSjnh7YGK4N74UFl1XSMXFMDT8RsY3YC6wfKZ2pN1T8iK4PduWxMI1sTEu4oKWtn8YhGgl6VSphaHZ61XlNV0+WwID4pnvDItdcAdEAAXA+SwQ7wvVAN1jz1lZ/NuERaZmwIwlBr4RE3vORCzVIV+o5YgLGS+F1NsIqf0c8z3siYpWY/kNX85M17oRmWQks5ORxNKuSFXJGnhYA5eVvjQuBOF45p+6KHaz0BCVWXUFvPVoeAum3Cvn4KZKkm2aVP5Kmw0dMv5xGLLrKzy9tb/4IDOWreodcb6X/P/nENjiaTiVYy84VuYGjFmI=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(36860700016)(376014)(1800799024)(82310400026)(18096099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xkbfEeMswdkCBfDLOzBGlunlpBQsGNmyAOt0rnYUdDmQ/YmveLOFqCGf2OD+HzWFkssw2Mb8Gok9YshVFn1OlzPDHMKj5Ffcrvj3EPiZ1a1U1LxOX5yzadZSQSGNhojKshqzEJc3G5HsLTM4ysOgyoSGXLn9HLYfgoApYf8lSHNmcEgoV/qASpklpKp83inhGJGCgXnBXhmLpVDHdUIItZr7NxNZM2gdk1zZhZycLNUsWhApcBoqHjI020TKfx07OQcVLsdxzclCnbDT+3QOJhU1vb8psgkKbUUyrI7eIGFXomqwaOnL0JmMCn5r7AdMXu6o5xSpTgRqEikwy6eNHsDeUPYKyetXmStd6OhpWYmDDzb/TDgyj0+stEMVEQE+O8K/lpSUu81eL/o0UupaCFM9IBQH0gdh0VbIq0gny/iUG9qz7SfoGSklDLZkPwRy
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:09:21.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5fe715-6ef4-448a-0196-08dea47757ff
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5394
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

On 24/04/2026 13:09, Boris Brezillon wrote:
> On Fri, 24 Apr 2026 12:20:07 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 24/04/2026 12:03, Boris Brezillon wrote:
>>> On Fri, 24 Apr 2026 11:38:24 +0100
>>> Steven Price <steven.price@arm.com> wrote:
>>>   
>>>> On 22/04/2026 17:08, Karunika Choo wrote:  
>>>>> On 22/04/2026 10:34, Steven Price wrote:    
>>>>>> On 12/04/2026 15:29, Karunika Choo wrote:    
>>>>>>> Update common IRQ handling code to work from an IRQ-local iomem base
>>>>>>> instead of referencing block-specific interrupt register offsets.
>>>>>>>
>>>>>>> Store the interrupt base address iomem pointer in struct panthor_irq and
>>>>>>> switch the shared IRQ helpers to use generic INT_* offsets from that
>>>>>>> local base. This removes the need for each caller to expose absolute IRQ
>>>>>>> register addresses while keeping the common IRQ flow unchanged.
>>>>>>>
>>>>>>> No functional change intended.
>>>>>>>
>>>>>>> v2:
>>>>>>> - Change IRQ request function to accept an iomem pointer instead of
>>>>>>>   computing it from an offset argument.
>>>>>>>
>>>>>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>    
>>>>>>
>>>>>> One minor comment below...
>>>>>>    
>>>>>>> ---
>>>>>>>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>>>>>>>  drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
>>>>>>>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>>>>>>>  drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
>>>>>>>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
>>>>>>>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>>>>>>>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>>>>>>>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>>>>>>>  8 files changed, 42 insertions(+), 20 deletions(-)
>>>>>>>    
>>>>>> [...]    
>>>>>>> @@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>>>>>>>  	if (irq <= 0)
>>>>>>>  		return -ENODEV;
>>>>>>>  
>>>>>>> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
>>>>>>> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
>>>>>>> +				      ptdev->iomem + JOB_INT_BASE);
>>>>>>>  	if (ret) {
>>>>>>>  		drm_err(&ptdev->base, "failed to request job irq");
>>>>>>>  		return ret;    
>>>>>> [..]    
>>>>>>> @@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>>>>>>>  	if (irq < 0)
>>>>>>>  		return irq;
>>>>>>>  
>>>>>>> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
>>>>>>> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
>>>>>>> +				      GPU_INTERRUPTS_MASK,
>>>>>>> +				      ptdev->iomem + GPU_INT_BASE);
>>>>>>>  	if (ret)
>>>>>>>  		return ret;
>>>>>>>      
>>>>>> [...]    
>>>>>>> @@ -3229,7 +3229,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>>>>>>>  		return -ENODEV;
>>>>>>>  
>>>>>>>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
>>>>>>> -				      panthor_mmu_fault_mask(ptdev, ~0));
>>>>>>> +				      panthor_mmu_fault_mask(ptdev, ~0),
>>>>>>> +				      ptdev->iomem + MMU_INT_BASE);
>>>>>>>  	if (ret)
>>>>>>>  		return ret;
>>>>>>>      
>>>>>> [...]    
>>>>>>> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>>>> index aafb0c5c7d23..11c43de1ddd5 100644
>>>>>>> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>>>> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
>>>>>>> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>>>>>>>  	}
>>>>>>>  	spin_unlock(&ptdev->pwr->reqs_lock);
>>>>>>>  }
>>>>>>> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
>>>>>>> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>>>>>>>  
>>>>>>>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>>>>>>>  {
>>>>>>> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>>>>>>>  	if (irq < 0)
>>>>>>>  		return irq;
>>>>>>>  
>>>>>>> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
>>>>>>> +	err = panthor_request_pwr_irq(
>>>>>>> +		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
>>>>>>> +		ptdev->iomem + GPU_CONTROL_BASE + PWR_CONTROL_BASE);    
>>>>>>
>>>>>> This one is the odd one out because it adds GPU_CONTROL_BASE put the
>>>>>> other panthor_request_xxx_irq() calls don't. Sashiko also points out
>>>>>> that there's an argument these should all be using ptdev->gpu->iomem in
>>>>>> the final refactor.
>>>>>>    
>>>>>
>>>>> I understand that it is slightly different, it is only there to
>>>>> illustrate the fact that it is a child of the GPU_CONTROL register page.
>>>>> w.r.t using ptdev->gpu->iomem, that would mean that we need reach into
>>>>> the panthor_gpu component to access the memory, hence why we used a
>>>>> separate iomem for this one.    
>>>>
>>>> Why do you not add GPU_CONTROL_BASE on when accessing JOB_INT_BASE,
>>>> GPU_INT_BASE and MMU_INT_BASE though?
>>>>
>>>> The obvious answer for JOB/MMU is because they're not architecturally in
>>>> GPU_CONTROL. But then why don't we have
>>>> JOB_CONTROL_BASE/MMU_CONTROL_BASE (my guess is because there isn't
>>>> really anything other than INT registers in those blocks).
>>>>
>>>> So it looks like for JOB_INT_BASE/GPU_INT_BASE/MMU_INT_BASE these are
>>>> offsets from the beginning of the GPU registers iomem. But then for some
>>>> reason PWR_INT_BASE (introduced in patch 6) is treated as if it's a
>>>> relative offset within GPU_CONTROL_BASE. Which is just weirdly inconsistent.
>>>>
>>>> I'm happy to disagree with Sashiko on the use of ptdev->gpu->iomem - I
>>>> think interrupts are special enough that we can use the top-level iomem.
>>>> But that only holds as a justification if all interrupts are treated in
>>>> the same way.  
>>>
>>> I don't really mind if some intermediate patches use ugly tricks to get
>>> there,  
>>
>> Sorry, I should have been clearer on that - the intermediate patches can
>> be a big ugly if necessary (it's clearly better to split things up
>> rather than change everything in one go). I picked this patch to comment
>> on because it's the one changing the IRQ handling.
>>
>>> but in the final state, I'd actually prefer if each block was>  
>> initializing its own iomem, and then the interrupt iomem was calculated
>>> off this block-iomem region.
>>>
>>> So, in patch, I'd like to see PWR_INT_BASE changed from 0x800 to 0 and
>>>
>>> 	panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
>>> 				PWR_INTERRUPTS_MASK,
>>> 				ptdev->pwr->iomem + PWR_INT_BASE);  
>>
>> Yes, using the relevant iomem pointer for each IRQ request also makes
>> sense. What I disagreed with Sashiko on was picking on just the GPU
>> instance ;)
> 
> No worries. That was more a comment addressed to Karunika actually,
> since I see:
> 
>  	err = panthor_request_pwr_irq(
>  		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> 		ptdev->iomem + GPU_CONTROL_BASE + PWR_INT_BASE);
> 
> in patch 6, which is not what I'd expect there.

Hello, thanks for the suggestions. I have tried addressing these in v3.

https://lore.kernel.org/all/20260427155934.416502-1-karunika.choo@arm.com/

Kind regards,
Karunika

