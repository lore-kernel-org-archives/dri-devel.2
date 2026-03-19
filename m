Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B7F1090240
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1619910E89B;
	Thu, 19 Mar 2026 15:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TPJFp4y8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TPJFp4y8";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011045.outbound.protection.outlook.com
 [40.107.130.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C766E10E89B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 15:35:00 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l7FwY5bSMcW8OyZu2X5RB6JQ46D8FImE6pcYqp7riYFeHgxSqr6Hi7d1XfH8p6AQQsPMFEeYbzFZuRpFqkR/60YNBHw1xjXvi4NQUW3VNerPKXLegxsQ5aEuehgPHlNLSuPMZJXFVIPFqXZtxfhnFe2yVszoPAphWKIOMA/iZeiy2jAcENyCCW6E2kt55oAsLd0iPA3wT2YB3pidWeIttDuyiFsSWRkGjJMaSB6bhcpDtX/ACWnQH9ieCktp0g4ixRwFdq43/Oll6DBJ9fookdINcH9/EhrH7XFzRAj7f6c+UbEzLt5FZ2DBVxzhoG603OMU2OueWtbPEv2jgH5Nfg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZM0byk9cL3M1tsYbB3mR1Jzcn9dkpI6GJ1m5HyFPD8=;
 b=XbdVZPLB35DDdjCTsboJ+0iOxVg8PnVOjl9O/SdwApfAD2gMaQNFV42TSKo2/7bQy+2qaTRaRM+hu7SSA4iE/JfcIYsNduvDrpBaXTQNGU+TF1b+PECd//POTMMM6n8UfpvsTltOE7NucTZTbpIryV0ccQ9Vynoh5MafaXUJLGq0y0iRjqWaEG946j4RvhGHY/9O0Yvi8Zv9c5XdyUbPXHnANj592PS6vWRUGgWNdfppd9L0LYHCPD8MnNMkUhwrHhkDesoNVGK9bORXMXxpr04GbLgTF1d/s7Uk+ck0a9YkSsVrlY4eZxty4L2wX/mhrWUfUWiCreuvAuZFoU0Q/A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZM0byk9cL3M1tsYbB3mR1Jzcn9dkpI6GJ1m5HyFPD8=;
 b=TPJFp4y8yIRn/JUKo8ydqPxghsrHg/RCiraVUEk0ruDuf90ZX0rUq2SjoGbJ3CfQqGX076Vn95Ipf6/HK1VXK1LBLScgDEgLk1QYmcnSDyFIIM/zVWi+5euPSDmkMPsSPG88vnhQA96agkw/+yt57L0z6bxiQ1oh0pNXId4YyBc=
Received: from DU2PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:10:234::14)
 by DB3PR08MB8939.eurprd08.prod.outlook.com (2603:10a6:10:42b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:34:55 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::6f) by DU2PR04CA0039.outlook.office365.com
 (2603:10a6:10:234::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Thu,
 19 Mar 2026 15:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Thu, 19 Mar 2026 15:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuxsX6Ub6PxckgU795r1/hXVc1HpEHY2FNHx1D5JhYB52+X2J1qYQxqxbSC8g9bOFURVrcdTxLknMS14vgx4H81WPCpNGuskgKpri1ZqkNWzoosHd9/5gSUz2lG7Y7cinWq5lNYZbcoAFkQYIbe30xX9egW8MEzTpDFosMSTOIK8T7yBFS9mKkoiiU7aaUUk55kWHOcFegLo1gV6HkMNJBNr8SjhxrONCTvTQ7OJmcUHoU553F3QUg4FxdYdaujwxCXzTfr1VM5IDGJWrGF4XdQWxuvMoLq8Kmbk/W/zQkYHTfdPGP02EhqgP/vWXnCkIAFPYJSJq6GpcQ83M8SaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZM0byk9cL3M1tsYbB3mR1Jzcn9dkpI6GJ1m5HyFPD8=;
 b=GHFNBqKTHuzAB1l8CmSa3+sKPVzXZQziYEncUAAeilHoJRP7pxPq2e7mCWK7OX2Ax62HzOX0msbtlYGiKD4yyYdI1TTWr4bezHe/pnKpf0V7CdacAXzIk0n6+1BsYPyz8JVVajHiiADICeu5MUDmay6gg9s+np5ZT6Ec4xV7qrVLGR1l7TLmCONyVgq6p63NoWo8ey75ph/TQ9PvrJD9OSR8P/h0RfiQyzCkrJgsMZPVSUVF2GkrlA5p0qvY2tSY1zWgXziyyZs0zal4cRGzxknWhXwH4dXnExX7gGJpKXumGLK3OeRFmyA1Co0jMqbkVtT+WQjpxZiPIivCcrziOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZM0byk9cL3M1tsYbB3mR1Jzcn9dkpI6GJ1m5HyFPD8=;
 b=TPJFp4y8yIRn/JUKo8ydqPxghsrHg/RCiraVUEk0ruDuf90ZX0rUq2SjoGbJ3CfQqGX076Vn95Ipf6/HK1VXK1LBLScgDEgLk1QYmcnSDyFIIM/zVWi+5euPSDmkMPsSPG88vnhQA96agkw/+yt57L0z6bxiQ1oh0pNXId4YyBc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by AS8PR08MB9340.eurprd08.prod.outlook.com (2603:10a6:20b:5a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 15:33:52 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 15:33:51 +0000
Date: Thu, 19 Mar 2026 16:33:48 +0100
From: Marcin =?utf-8?Q?=C5=9Alusarz?= <marcin.slusarz@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 dri-devel@lists.freedesktop.org, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH v3] drm/panthor: extend timestamp query with flags
Message-ID: <abwXXFgPheyA03P8@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607> <abvujKZxtg0zvFaz@e129842.arm.com>
 <abwTkBi5WvItsEX-@e142607>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abwTkBi5WvItsEX-@e142607>
X-ClientProxiedBy: LO4P123CA0249.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::20) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|AS8PR08MB9340:EE_|DB1PEPF000509EC:EE_|DB3PR08MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9c92b4-0ed2-435b-a3f6-08de85cd11de
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: xL2GDXtExDl2wEgUnaWcWY157ovPPbqGAaZ4d+lu+OnFVKPcmL/cu46f87AMQ7wa3ga1LcWpsmv3upXVvr2qSvLpk9zRScFZx7LU7Q0wL2jz8EgAcmEAqAFDI/Zmh6etJJnWg17NERMRFcLbhj+0v3cVhBpQBmYCd/rAz2oCj/zgtLq3JW8ETP9a4+enZhssbOZRp1UzWvTu1QUUVDbn5jYCnAojQz5h0wivEPTaq7yvxyUAdU2Cm3IZPNoLwYLLtw9O/72iAGLu/70mg3/b56wWVTSpsrj0l60xfh5WSjIyp44hOa/EpyBIgvaWxCKvk3Zac9n1O/arr2Aw/UOa3QGHdwL+8Lu7XlXJ2KNxuY707jgAMvNkjdIadEdi4kiwekJqYBEu41bpbkr9XO1z4/ZQhkyUOR7AVX4y6mCkAPDRGj15s2mzv99osDOPH4pSehrcYIiNmcHlVM+QBI+I4nUEw0ZRD3rsVOGA5P030RgZPWp5j8UTlMqLBpROyEU7UwnXq/5C4RPjnLAlyvaQtXAr5eQ+PstDO4dqtJtvuR+BJzrwDtEsNhnAh0rCGlSYVhHPsRpejxYkEkrhD32UbCPl9abpyr5kPBUw7FoeQqEgfn9VJBaDfwOUiz8HVuCBO8ek8WEhYwZD52E9w5+JUBMEdutgsL9AnbWl8r+hro8siWP+YrZVDrDgKpq5fyOBzxhlQL6Nhx0nc5RekIReVww1VOVbIpTf+8fZdP90XmQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: iSmPjh//oTzks+UoWY7H7cdFhCGnoVzo6LVZJi71QpA59DjIHcTusncYnlalnDXPPL6WKsjo9/3XirZpyZsuWaov0GA8TnVjLo8rdFFj+COtYQrQqR7hYeJB2ewy+lF0l3l6b1nI3LNtk4ColfhIwljVJW9MpUIWK8FZv9R5Fr52yYwlI91Lf+CnzOabIaE+YwuxXUlrFNq8Iy6UbgWSk/pb5maWM0Jo+rJ944qlbHwAMnO9fZ7vqGVX9JM8qjzJ0TGJs082m4CDIHsS1yARGS7D6VVYBVTvWOQbzgg651Z2xbdBLfSCoFiGoWZIde/6VeV+53S6g9tbkJfqxsHilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9340
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b8df74c7-e089-493c-8532-08de85ccec54
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|35042699022|36860700016|14060799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1Q1L/j9HDTEc1si9EuRJA9yfdkhgyen3f639UFCQK3PE9lU8C5vC7pDegYfKSN0X96jDU6Op1G17RWYT6ruSDSrhQM+pO/laNa16Xk4CSBN+QFgbtzVnkolDhTlJj32rxRKn0YECN50EvyNYv/GmL3CGlUefIIGpNv8+O91FgvAz0iH5EEnj2S6ErTMHuqYqWNG4rix+jdnUsqcZ/g4ypWE3zKHsIt2zra8xElk+1PPYwKHpKyG3rd6y11+QmxU53sINd+eaRfPjwTwR1fFOe5tBlP7fqT2Sq5hPTj3bRYPqZUH2r4QBdswg8YhD1+99UmTTLgu1tbL0QRGV+bRVN8ZGuK0FwMpbDoQukXeAG+NswENLNJwdalPWvGG2uqn1hEhZOmCckfwsUXfRc0wX4qqYe0rp5jYUHRhond3u6RujOmt8Ro9w5KGaJWulJYw2NLhQhwN/2UbOJm1P3pMudCQfMCsSnir1gcava1BRNQBq33RLfuWodklD/GcQL93xUpvHSwXSCT+59I9qQ+MsnFyiqjORJM2tOE2goI28hPAcYB4+JBKYxsxuqqPm/2zbqI4rod5wgu8vvSwfkCqSL8JJRDABdgTfA8cTzo1joM0UqGGxC+LOBodBnktzUOgrH/2BR2J83ujd+Wul35qfL5PG89L7VOzia15QmcJzA7xIXlJ9xFX4M2a43aU8/hHxX4oNLcjcIAqlp9rxRNjStHy5nrn/1C3pnB4ZDnfHIVkWYyUoNs+m2PTqhCXTRwYIYIdyWkDx49Fgv6IlPPsHag==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(35042699022)(36860700016)(14060799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zrX/QavR7mjrs2jMvpfqNKZH/92icPHVRoLh5yU+tjf3kXRh9KENw+xYV7vrmscatxBHdAA0VLiFrXoJLzNMfCmpJf+McEcXNOrdZez3ofLDybeMsFvG8KRPxMf4GoAVnQlMFDlaK2ZOSkPlvalUU9P7R2vUZqzNi7SW4hHlriVMUYniCQtjbAizuViWZwWwip0FNa/Jp5nPK98bNhg4QOKqC+e5vD3y9Yt1CePAC4+oOm7CqRSwTmh4P4c2ztNt3S5ypvISqtPp3sPjtWUQS1CEszYQMNCQZzajd68V94MFEYaZ/ZmGgjJhfzuCgqaCCeGlNNvfJX4Qgiezbk2DXRgr/3FEAAr+sQzm+r+hGRzFaTYXRn7zLrBTlQBLwrFx4lzPFo7+LN/x/hrqMx8d5aaXolyTU3E52vAeZvHcDWrfuyfl8O3Z1ic9xKhC3RbJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 15:34:54.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9c92b4-0ed2-435b-a3f6-08de85cd11de
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8939
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

On Thu, Mar 19, 2026 at 03:17:36PM +0000, Liviu Dudau wrote:
> On Thu, Mar 19, 2026 at 01:39:40PM +0100, Marcin Ślusarz wrote:
> > On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> > > Hi Marcin,
> > > 
> > > On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > > > ...
> > > > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > > > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > > > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > > > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > > > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > > > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > > > +
> > > >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> > > >  					struct drm_panthor_timestamp_info *arg)
> > > >  {
> > > >  	int ret;
> > > > +	u32 flags;
> > > > +	unsigned long irq_flags;
> > > > +	struct timespec64 cpu_ts;
> > > > +	u64 query_start_time;
> > > > +	bool minimize_interruption;
> > > > +	u32 timestamp_types = 0;
> > > > +
> > > > +	if (arg->flags != 0) {
> > > > +		flags = arg->flags;
> > > > +	} else {
> > > > +		/*
> > > > +		 * If flags are 0, then ask for the same things that we asked
> > > > +		 * for before flags were added.
> > > > +		 */
> > > > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > > > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > > > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > > > +	}
> > > > +
> > > > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > > > +	case 0:
> > 
> > Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.
> > 
> > > > +		break;
> > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > > > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > > > +		timestamp_types++;
> > > > +		break;
> > > > +	default:
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > > > +		return -EINVAL;
> > > 
> > > Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?
> > 
> > DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
> > clock type values, so we still need to validate the bit field.
> 
> The if () test eliminates the default case, and if you change the switch to:
> 
> 	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_NONE) {
> 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> 	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> 		timestamp_types++;
> 		break;
> 	}
> 
> then it should be equivalent, right?

We need the default case to detect garbage values in the part of flags
that ands with DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK.

DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is 7 << 1,
DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC is 1 << 1,
DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW is 2 << 1,
so 3 << 1, 4 << 1, 5 << 1, 6 << 1, 7 << 1 are all invalid values that need
to be rejected.

And since DRM_PANTHOR_TIMESTAMP_CPU_NONE is 0 << 1, we need it too in
the switch to not be caught by the default case.

> > 
> > > > +
> > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > > > +		timestamp_types++;
> > > > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > > > +		timestamp_types++;
> > > > +
> > > > +	/* If user asked to obtain timestamps from more than one source,
> > > > +	 * then it very likely means they want them to be as close as possible.
> > > > +	 * If they asked for duration, then that likely means that they
> > > > +	 * want to know how long obtaining timestamp takes, without random
> > > > +	 * events, like process scheduling or interrupts.
> > > > +	 */
> > > 
> > > This comment makes me think that user can ask for both CPU_MONOTONIC and
> > > CPU_MONOTONIC_RAW timestamps, but the code is built to make them exclusive.
> > > Can we document better what sources can be requested simultaneously?
> > 
> > Somethine like this?
> > 
> > diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> > index 8a46ef040c3d..0e455d91e77d 100644
> > --- a/include/uapi/drm/panthor_drm.h
> > +++ b/include/uapi/drm/panthor_drm.h
> > @@ -466,6 +466,11 @@ struct drm_panthor_timestamp_info {
> >          *  DRM_PANTHOR_TIMESTAMP_GPU |
> >          *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> >          *  DRM_PANTHOR_TIMESTAMP_FREQ
> > +        *
> > +        * Note: these flags are exclusive to each other (only one can be used):
> > +        * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
> > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
> > +        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW
> 
> Yes, looks good to me.
> 
> Best regards,
> Liviu
> 
> >          */
> >         __u32 flags;
> >  
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
