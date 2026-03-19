Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6638110854D2
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E3610E9EB;
	Thu, 19 Mar 2026 12:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="GOJVPvW4";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GOJVPvW4";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBA610E9EC
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:40:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UyVHouT3KgAYNvKRPYQThgrvqZT+/BFZt7CK4XGJIhL1PxIOp6Qw94HnxxvFTds3QDbk5sJYyxoHLejr+/E0M+Uq/W0xPzthLVi8BJjJHou7rUJfIOGhwfXssOmCdPxqTlzoWvc0YGGKrL2d3Pi8Ei2id6iqLefb6scckZYySpoCG3hVCPXChudaqTfDEUfcCzI1xk4lHxTeMX1V9RatApVegHD/6vG2M8EUZYrJ4HI+yj+zBOT70LluvSIRJQmiWzPiu/5TxTFTbQpklVlHV5AdrscDxERZYvv7B+Y6AK9ZyKjRBeNPJrSIIyq1llOTwahFvehXFf42LARruC/vvg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtMrKRIcnIWVNeaZ12C2UFOKDNUw6fz/uU3sjuN33iA=;
 b=eVv3tFkBfvz7xNw3BKtOZh4tLTsdJq75GG5gfxIcq0vG/89Q2Zig6+qmpbIT6xS7ol2YQiFu9P6u3H/IGs5EkcIX83yu9R0wMjUg8h0aPNCo7cR0Ths1GWHqLdi8UEkhmTAYWlMs/jI8bruNmnlhWI4F3+JRA9mEnfX8iWmQd6LncLcfiIDTslD+K9kkUuja/k38cxJUjC1TldVj4/lhqZW8pRyviVsRDQcKg4nsdBLCmTmN4roABiwr6VBes6Ph8cK8kTMa0Y+wtPid1CNcCIrmrj1tKCy6i0RtOKreBSSg6+NuNFmusHXxP0fnjEkAavmu63n1Y4XFL9jramyh8g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtMrKRIcnIWVNeaZ12C2UFOKDNUw6fz/uU3sjuN33iA=;
 b=GOJVPvW41U2+ut7sELAEJqkMzC09TDq+jLJsHVaHGcpItEi1cLWS15sF7XSLwDPLUbTC3RGteGYFqOFdG7RnMfM4Wae/hVn1pydDw1oypPz8snas9uXxYaZikV1iUX0YJV7xS1YWpc7o++KE3Q8r4sqEniWA6fchjwlbFxtTv+o=
Received: from DUZP191CA0058.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::18)
 by DB4PR08MB9863.eurprd08.prod.outlook.com (2603:10a6:10:3f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Thu, 19 Mar
 2026 12:40:47 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::a1) by DUZP191CA0058.outlook.office365.com
 (2603:10a6:10:4fa::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 12:40:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Thu, 19 Mar 2026 12:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ2Pp4LXPX7DYrZY2F4cVwv7jLpFJQeLrGILTp4PtlFIkoSvVIIXJlyy1kIwR7adqXDobSJMa2FSbHf2yyzp7lOngr+eG6zH5kNLGWaoK4CT3ayDZPcShNpZ1/CXrnv0YGeEGxTPg++Q9UIrWxYDDHAWGNlCqDcPoqCxH5RyKtKRWy1Ruwo+feQR86cg7BCEkaziSzp1oFhnur/8UrSZzkfapMSZU3BX+sqrMe0mfuJyFSZCwpo2Dgl37XFBBXS2NH/ImipoNrQr0+oqOmcXMH/8+obOLwLELsJ4lhe1XDsM5xs8OSbCClhXRI1qnpzO0g/bJyvFwrtAcCDRQQ79SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtMrKRIcnIWVNeaZ12C2UFOKDNUw6fz/uU3sjuN33iA=;
 b=JC/+t8cNqj8/xIdIuUaZ2k5V2sbgL/9Cl8YJXQqLcKa+T4pw6nxNIO0VTUuba8GMoO58e6BgeHT70efJ5qIEGO+xphN4LnzIQHcEGtJNzfn8rh5nA1icz7RQf6ncHVk6QxObR2RV9/fLTl9qrtAnopTcqWU7Vn/1X5IhYvnOQx/b8il7lhhEEvAqGWnbrOX6O6FCh7Bs07iBentPOGC1xDjJQJHV1kwxX4aCTE6/xhL4dyX2KbYuR8lQolBIEzIr8bux53+6H9Y4Ar9EHAHVr3LhyJOpOY23jiKtShAER2Jnj+SR1gY5hh8TSEanP23S9jDtPq+hzl//t1F+KKCGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtMrKRIcnIWVNeaZ12C2UFOKDNUw6fz/uU3sjuN33iA=;
 b=GOJVPvW41U2+ut7sELAEJqkMzC09TDq+jLJsHVaHGcpItEi1cLWS15sF7XSLwDPLUbTC3RGteGYFqOFdG7RnMfM4Wae/hVn1pydDw1oypPz8snas9uXxYaZikV1iUX0YJV7xS1YWpc7o++KE3Q8r4sqEniWA6fchjwlbFxtTv+o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11)
 by GVXPR08MB11610.eurprd08.prod.outlook.com (2603:10a6:150:326::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 12:39:44 +0000
Received: from PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f]) by PAWPR08MB9996.eurprd08.prod.outlook.com
 ([fe80::5856:8db5:9ee6:414f%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 12:39:44 +0000
Date: Thu, 19 Mar 2026 13:39:40 +0100
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
Message-ID: <abvujKZxtg0zvFaz@e129842.arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260319110053.909152-1-marcin.slusarz@arm.com>
 <abvhcedS46eLEYVB@e142607>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abvhcedS46eLEYVB@e142607>
X-ClientProxiedBy: LO4P123CA0509.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::13) To PAWPR08MB9996.eurprd08.prod.outlook.com
 (2603:10a6:102:35a::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAWPR08MB9996:EE_|GVXPR08MB11610:EE_|DU2PEPF00028CFC:EE_|DB4PR08MB9863:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc749d1-94d5-42bc-bfa2-08de85b4beee
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info-Original: xNQ7YruVvhdpZuqhGsSN3gVvAvszzwYciFbzwa9YGn0QlWaiznbiT51SY/Oli/fFlkcOBmDZwjf8Gf9HX6zet4sWilVJ7hj6kc2UEcUjsLDToeNmrKi5PmmgZr80gnzc+vMj1j+IKiEfBIcMyBLp18IvMn5TkchnZBoYAmADv4Td0cXo22qve5S70G5CeDjvNJrxiTeVGJI7hD5u2xMaRpTi5sisnb4sfBkm/h+9ySiVqGptdUTyaP269wJJQ0JtB/EgFsQ5U/HdryIgSLS5kapOcOOqopPvUqgWpN5njdZQ+wUThjqbAjrVHOsbmBfgwcBjGv/yvyzDicRPiXSsVFd7JF+7H+iXTqK07L8nmMkKHgK8SOax+h34dc3tEo9R45ehIJKoYDuFhzVdRL+Q2dGA1XGTcKYyQYAaLmcdWiLFj/DjYHMVl4/0ATIvG0FNB6a9JcFdHDmfIN2q9ddseAQcVntCa6wZ6+bicgHR/twHBVQolNHLzAQjDrIc4Xa5YkwqFZ8TivqfRHWf+JyNca3Ux5s9NCvE7WnjWcNbrbXc0fVCXZD0An6ZAVDb/di/LW1SVu1Zy/wsunvptOvbj0IzpTJ/6K0NytClSxSvBKJF+z+zVDGCjlem97c8XUK0qpZJIkICDI9jBIjWj75DDeAJcnKzEvAtlq0ElxKsR1v2OLfUWES8iyo3HnafoeOmHxNV9gXjP4UMrGWJH/07PoV2dav2NC7X+e4Y7NupfKE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAWPR08MB9996.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: otunULjvHMhc53KKn1fqFiLxLf8eSpMmbtqwKsXuCTVoa/BlVLotWedutGfcCHxHL/1W9pJ6Qs2gaCs5gouWB/Kmc2BgDpO8wKIUkopBA8aiD5iXuHs/J11oQWWqm1z3lJlDPXlxJGoNNorsy9UHnrKnACrjlaLf6sljmgWR1URR4NjXpE0zHajR6WH59wXI8gT2gEj4eOLZeGsDhGPGIDzU7jEy1Pn8wgFIcLd8nNM9JB1NbjppcZTjP6DCtm04O5xOPsHRpu9LkBm5G+m0w2+YCO210ENj4Upeafax7R6WC8Cv+kAz5z0/L1iFOkz9hrKEnC/8XttzwH/sarlVKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11610
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ba540d31-63dd-4272-4107-08de85b498e4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|35042699022|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pMr7ecKYZJlVhYrT1sgB4Yrzm6jYDHtGNE8Vhn6uymykqXY3dA5jJ4ydAr+x6A/yK1Q38c+Ua8vorjGGrxU/90sLlqJyUvesV7zwoK2BW0TIIT3B47nF4Fc4pGpJHPvtF+GID5ukc/c/7M4XCMiCM/VnuQR/POM6LMW1ZTaTuIGUnSzrN4Gr9+rXNaDv9+bcWPAGJJicMT/U1tXOEIiQMdu9z0IO4xyfbmsUVRT8wNmii0LARD/uhx2OOwU+BLSAZ3M02N0o88pGbITXQJFfk6j62SZRwVLbjj1iUjKbnnaQua1HkquuZUcwSGXQnx2tCAW1+qARenvn6S8czCpByios28IAXIJueREu8S2Y9Bc5QYCouwXogXnAXMXDaN+SKvm3wkCffa0hDk8Nv9IHmBkM0Z0l7uMa6lQjddonoJiojQEkHKZ2CGmdPKN2bLt4Est1Aoa8pd1lIdoO3sqH8d3YdK9Yp4kg6aUOq0i8zLR+CC6Zq61ssGMbMbDHKn4uzVKEk9g1pB+TiJ3E0WvW9jLU1mgQa/lMJIkpAida+IrXTrjY2W21QELPYv7WkD9EFBSQ3XyrKX2uZR4C5szZ9Pg2KsqNvf01LQK7SSlY5POs+nOdng4f67gGfS9hjRCO9T718KG63TeGXUpd60pM+4VnvfPfBzMY5Bcg66s9ZKrXEnKdvuXyoCzHTguVD2IoQcdEyXCLwhB1AEVJKPrS8ei5ghBIieqsWrEF4dsH0Z1Dnrq7dEdXpCG9HzjQ4Rojw/w03exF9n0mdCyZln8pvA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(35042699022)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dvlURGldbGBCUpNK9m4Stba5zr3+SNyUU6YRURbKW5xdWmF13QHfNofTV+BCt0soAllI5xefgCSOyyIYAbRpXYXFLljl7y8LtOPQ7DwNHQCa7IzFN1D7NxnP/btMdAdMBs/sfaxXVgc4mhsZ8yeChrMZjI/9hJSQVyYiuKnHutpop/Gsm+N0xFRtcEhh/53K7tIXSGOQ5J5CO66qLxOI9kG+yvv69wAISJFO6SWSglAoDiukDLFbSmD9zZfOQXFdf4jbQoBJjfCo0HEJsmSpQSu0/gYIAb80zkihtGX1wCrO0CJLkm62kNY1DQ59vb1ewG7owpdo2thQSuwHc+6C3In1iPO65VwWTe8ZcRhc9La+8Dxhg2y7m8Z8JsPZkY3Wk4MsFFgIkZVChXdet4rdno+BCXDAU2tLxfKld3lxG8wIlZ6PZrDZJgh97ttSbF7V
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:40:47.5779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc749d1-94d5-42bc-bfa2-08de85b4beee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9863
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

On Thu, Mar 19, 2026 at 11:43:45AM +0000, Liviu Dudau wrote:
> Hi Marcin,
> 
> On Thu, Mar 19, 2026 at 12:00:53PM +0100, Marcin Slusarz wrote:
> > ...
> > +#define VALID_TIMESTAMP_QUERY_FLAGS \
> > +		(DRM_PANTHOR_TIMESTAMP_GPU | \
> > +		 DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK | \
> > +		 DRM_PANTHOR_TIMESTAMP_GPU_OFFSET | \
> > +		 DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT | \
> > +		 DRM_PANTHOR_TIMESTAMP_FREQ | \
> > +		 DRM_PANTHOR_TIMESTAMP_DURATION)
> > +
> >  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> >  					struct drm_panthor_timestamp_info *arg)
> >  {
> >  	int ret;
> > +	u32 flags;
> > +	unsigned long irq_flags;
> > +	struct timespec64 cpu_ts;
> > +	u64 query_start_time;
> > +	bool minimize_interruption;
> > +	u32 timestamp_types = 0;
> > +
> > +	if (arg->flags != 0) {
> > +		flags = arg->flags;
> > +	} else {
> > +		/*
> > +		 * If flags are 0, then ask for the same things that we asked
> > +		 * for before flags were added.
> > +		 */
> > +		flags = DRM_PANTHOR_TIMESTAMP_GPU |
> > +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> > +			DRM_PANTHOR_TIMESTAMP_FREQ;
> > +	}
> > +
> > +	switch (flags & DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK) {
> > +	case 0:

Umm, this should be DRM_PANTHOR_TIMESTAMP_CPU_NONE.

> > +		break;
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC:
> > +	case DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW:
> > +		timestamp_types++;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (flags & ~VALID_TIMESTAMP_QUERY_FLAGS)
> > +		return -EINVAL;
> 
> Can we move this check before the switch and simplify the switch itself to only do the timestamp_types increment?

DRM_PANTHOR_TIMESTAMP_CPU_TYPE_MASK is bit field that holds individual
clock type values, so we still need to validate the bit field.

> > +
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
> > +		timestamp_types++;
> > +	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
> > +		timestamp_types++;
> > +
> > +	/* If user asked to obtain timestamps from more than one source,
> > +	 * then it very likely means they want them to be as close as possible.
> > +	 * If they asked for duration, then that likely means that they
> > +	 * want to know how long obtaining timestamp takes, without random
> > +	 * events, like process scheduling or interrupts.
> > +	 */
> 
> This comment makes me think that user can ask for both CPU_MONOTONIC and
> CPU_MONOTONIC_RAW timestamps, but the code is built to make them exclusive.
> Can we document better what sources can be requested simultaneously?

Somethine like this?

diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 8a46ef040c3d..0e455d91e77d 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -466,6 +466,11 @@ struct drm_panthor_timestamp_info {
         *  DRM_PANTHOR_TIMESTAMP_GPU |
         *  DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
         *  DRM_PANTHOR_TIMESTAMP_FREQ
+        *
+        * Note: these flags are exclusive to each other (only one can be used):
+        * - DRM_PANTHOR_TIMESTAMP_CPU_NONE
+        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC
+        * - DRM_PANTHOR_TIMESTAMP_CPU_MONOTONIC_RAW
         */
        __u32 flags;
 
