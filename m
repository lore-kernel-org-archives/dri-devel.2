Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B60C79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F47C10E058;
	Tue,  8 Sep 2026 06:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ip+RUanE";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AE8410E058
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 06:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiiqRJh0VJ/GpGcJgmq/wDb89n/AXuEVMlILgNoCxw2cFSBL+QBSkEOQLXvSlZa+IuIHrN9ICNipuLGbi+MC6K/ti8bmZSn21ZSSnCpoa5slFzI71Lt8NlpWXoe/eRAb9/jze85EaejW/rYZ2UZjxGW4o5ffTQSx8t3c7k77w6zlkgzasxZ2G8lGIfEB+S+zFpmIyzVRbr9tjUkkFeLD9uyylL0v4W2bfluWTkUAv6uDaxOQqwZPx+WC15wLxtcImQCSfA79TV6HJkm3Y9m7Lk8cp9PBDLQG9kis4oszqM5MoI11fANaMdF310ykzMAa6c1v29eyt6OOI8Se+CeKeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIj59JgImeuf3nuMJLXSXYCL7eurkcuD7rDgJZrlUHM=;
 b=TRtiitBazWXVJAfAbSA/KxF7k9CfKGbd3Kpq7MB7+OjByd7EqcvhLCU2apX1Q2TnqzvcKEhcdiOQqRB0sQJKPjhL7Eq4+3u129LO49zKNuuxXVWxReOiPX5JD3AnDKihqtd8UzC/yWY7NmL/pY03rPCb7VPLwd8jBPXXczRrZMYnRlxeG9OWkHNiOVqlnMyw4BzPdJbHLczqbTGRhiTb2fj+htanLg6nCFOiyj03CysLbR+wcYywJz7DsrYQjPDTz0vkinNPeh0dstqpy9+RBSMkn3N0LOFc80z/UMc4NhZHdlgDUIiEmKabnwJcQkEmaOHrHfQ+nIDHp0SOELEnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIj59JgImeuf3nuMJLXSXYCL7eurkcuD7rDgJZrlUHM=;
 b=Ip+RUanER9tLyme/82VK/MRy21jUeeIUNOjRWTXPg56H4l2FecLDH9oov0jwhhc22rcUy+TAeTRqFnVPXyDBuqvEj1oP4GieozjKQq2x2jR7i/bi/fURnwnJ57e2mXEbD4WrLpJ6SfYeCPD+88kJCbwp/Q2jOCqWvRwXN+MQrwAb19XrdLTnt77pfetfX/U1H3NIOlGgmXpOs3efjWmtwkthEi2iLN987rBRBJRDWjg+ZsgRHI3n3BXjIvpPZwNCFiG34pcb88g9Jz89piTh+72m6QSUwLHrAFmy5l/HWdWc+6DT/uVn7kEreycKhLly6Pp19dnTThH6Bw17C6/6ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA3PR12MB138305.namprd12.prod.outlook.com (2603:10b6:806:517::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 06:47:28 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 8 Sep 2026
 06:47:27 +0000
Date: Tue, 8 Sep 2026 16:47:22 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, @nvdebian.thelocal
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <ap-mQnaspil49v-6@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <appc5-0MRW1XwsMh@nvdebian.thelocal>
 <DL6FGP49MMWG.32RPN38WO2PXU@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL6FGP49MMWG.32RPN38WO2PXU@kernel.org>
X-ClientProxiedBy: SY6PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::14) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA3PR12MB138305:EE_
X-MS-Office365-Filtering-Correlation-Id: caa097d5-f591-4ce3-7d97-08df0d750bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AGy4oEg9my8AMwiIc76xPFI2UFh3daoIfifjqPEPatHzn8sDx4wV+ONJpLwXj1io9O2w6ZmFHDCljcSpO0tmO5wKPPEY4tmlO5sA8qufgfKddKIPu2AZ3yWT4xJo0GljJEVxId7kTgqjZjoxHxjHBWXLz/jXxlLZfBsLNKJYP2uGM9rfQdw/5Wv0iIE6HAk9j/7PXAhM/dHPjUjDh0EupbYAUFi4sS6Whg3KsLKoO38DYsxZJpFYvXigJrr18P2TLBF6431nUngN6b2ssXfwUjKMqQRtvZjJhe/0imgdMxYVEb/m1Re+1lxtQWNc3l31WwzdOyjJxflga1eWL+gT9H+p05gr/lwvKrtDf7GVyRuV6OZE6DIVC0yERPqpKkI6qs5YRg91Ka1Essgctosg1bnY0BpsjP/MtyvM/mTmA41vD/xVfQqmu3r8yws/aWapoO4eb/eSzHVxmuqB3TWrfhke+Z+mxbJbzVrdVLDMcBQDGt+v8AxvrQfROmWNeXojsOr/MA4GJg/5mjTuqeyUXZF2anDk84hkwMO+Kus03+51JJ6H5b97ihlQL47Q/qRY2q/dtvTWF1ckfMQ3Bp5sGlwBJPxmqjvL7DQx4cR2e/uj0uTkOR31hRWaJDGJyMIJiD52WMnmBlSUY7PVyG7xVsGc/C/WBgvLLvX1pYM+8s4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/QTYygV0zUrSXN1l4NZBiln2kxTQXIEuNjwArfahHgM7q43PpvZMlcYUv4mc?=
 =?us-ascii?Q?6+QxRLoksqURcSxFdjZLqHjSpOrqZbwKnDajdFOdioIxE2P3Xg2VcexScsa1?=
 =?us-ascii?Q?pxGYuiTsIYp9CsDr2FSOCZ1MFStg2PgloCtSGIjZXPkrOhvkAt57KUcPwIui?=
 =?us-ascii?Q?TZ/mYoG5HQcEtOTDU+1PQVWFZVMnqn+o9uWgUhlMo+tqG1XSZK9Bfk9HpBss?=
 =?us-ascii?Q?8w0p6YmSdrDonTSeN4uxFMSRSo+239dTazwjJXp9wWf1kBR9FbCUSs49yWVH?=
 =?us-ascii?Q?U8L+cQ13RqKlRhWS2/+FuUzKX8tm0AfjJ7c7K2uWc9BE7iBeTdUEMt5+fyel?=
 =?us-ascii?Q?j8wK7RnuLEVFQ4KLPaGfZvQhLWzm6PH5uPJ/sW8P77mJzh7txMfAi9Rjs1q3?=
 =?us-ascii?Q?rUWIEf+2X2IocCNA0WGE7OOLeOBQ5bZ4CcJnSDmVmJmUVxEV3FE8r7DuE1+H?=
 =?us-ascii?Q?ILonAA68Psu99pzjFda6vHibyfPS/1h61MAN8rcWEQdCMnf1ClLbDSG/3pu3?=
 =?us-ascii?Q?su1zsqnnRP/ugzdZg7jad5kzAdD2mbJlB1D6uz08ElcUSSyBMcT8PSdEx6t0?=
 =?us-ascii?Q?u0aG1nvWjcb9KUfCWChqeKnKPl7yknbBi1oprFXkcDdfsQOX1OX6OXI6j44d?=
 =?us-ascii?Q?AW+6E7EeKLpOoodhZ/civfr1BzzNppqx/cVmuTr3tEU81bUFZPe63i0XAUj1?=
 =?us-ascii?Q?4Pvvp+f516deuBnri/7LE4J8S8zisTczEQhnh/kHsC/2FFFExBNztWbglk2W?=
 =?us-ascii?Q?idOyANpywSuOrLqIz8OYamRcJ0f8Ij3wo8hHMiXu8MYoV+v+Wjy6ih1m4ETV?=
 =?us-ascii?Q?5CFMVhUtLWQkt2lPE8ybja/97AhVSNVyCsEGje4TkPD4aDXnFE0rGuV66AQs?=
 =?us-ascii?Q?KYMv8hRmHvtyDDGaVvw6Z5QTnTCfVhdMLvXUEKn9c8iKUG8+gIorS0rjXtQf?=
 =?us-ascii?Q?GR74/HvgeHPFtDp/Ve96H/hl3O5HuMsbRmc2pCSE4GNvE23Zfal70PeJzwRh?=
 =?us-ascii?Q?r80XYQsTTqn2fgWjZyXbagokJ5orYVjx+iTXuFi4mKgCSxKRRCyYjtXN6z6x?=
 =?us-ascii?Q?/dcPXboe4Ny3dAZzgQFVDkzMITMWWpAT890WlgY1hPJ5mnF7hx7UC9cO5tcD?=
 =?us-ascii?Q?Pq1EkxShh+CEYijORxxmUAsWAPYo5wD2V3jfcLNDGoJm+30YvGYel1JOyIWJ?=
 =?us-ascii?Q?OGIzgYukwTuXllx6cwn9bXqlnf/rii1Mn79QsG9aKndkSovXvCbVajBdVrdU?=
 =?us-ascii?Q?HME/bmAd0ADGXiKMIdymkUUfjpVRTGdDLzIbM5a9XwvzMqTnKNxrTgnKWItS?=
 =?us-ascii?Q?vDrV7lL4AUFTPcbt0r0xKu5SRwm68OidI/jO4HpGHIRhyDQMpuK7O442YcFi?=
 =?us-ascii?Q?51ItCugHqWZqt8C/CBT1OLRE6ZR1k3MsnuWHCF8mQTU4e+CeYqLmqvPE6mev?=
 =?us-ascii?Q?F74Oek0tTeUt54UF7chudFmEJT48SzQ8Ht4SkhgZ5EI6zHCk23buW+ox3UU3?=
 =?us-ascii?Q?5aDtpbqIXh2rQBcjqAw80sQ6WIn0YP6C6iFa5WsD84NgQwlz5g3/Dyj12Y3+?=
 =?us-ascii?Q?PfypyW5QkigiE4q3bX2qYtyba5IlGmB5nSX8JAjuuhp8dMloO9StF72GFroi?=
 =?us-ascii?Q?bwJGpqlWTobWdZGKMml3/FG5Y8N5YYhs9Oe90rJvETgX6TPjJCHCOvT8JrQW?=
 =?us-ascii?Q?niAriqUxiBquw/ccKT0dYNXQ3UutJHN/4TH6fm9bPgz6RVg8lAKlB9LfdjLl?=
 =?us-ascii?Q?I8r0g2C0Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa097d5-f591-4ce3-7d97-08df0d750bf8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 06:47:27.6556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfUI+1cjbAflSt3uUgMQYk3jWtJdLxAHYv+l7h2iGpDZm6cYsqSw4GsaCg+QGicrWUr6k4IWGCU7tUOyNG340A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB138305
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

On 2026-09-04 at 19:34 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Sep 4, 2026 at 9:49 AM CEST, Alistair Popple wrote:
> > On 2026-09-03 at 20:42 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> >> I think there never was a "rather than". The point was that if userspace has
> >> conditionals based on the architecture it shouldn't have to figure it out based
> >> on the chipid, as this has been done by the kernel already.
> >
> > I see. Maybe that was a bad assumption on my behalf, because I assumed that if
> > you make a precise hardware description available (chip-id) there'd be no point
> > making an imprecise subset of that description (arch) available as it isn't
> > particularly useful if you can't use it in isolation for any generic purpose.
> 
> Except that it is used in isolation for a generic purpose e.g. in NAK.
> 
> >> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
> >> 
> >> 	fn is_turing(&self) -> bool {
> >> 	    self.sm() >= 73 && self.sm() < 80
> >> 	}
> >> 	
> >> 	fn is_ampere(&self) -> bool {
> >> 	    self.sm() >= 80 && self.sm() < 89
> >> 	}
> >> 	
> >> 	fn is_ada(&self) -> bool {
> >> 	    self.sm() == 89
> >> 	}
> >> 	
> >> 	#[allow(dead_code)]
> >> 	fn is_hopper(&self) -> bool {
> >> 	    self.sm() >= 90 && self.sm() < 100
> >> 	}
> >> 	
> >> 	fn is_blackwell_a(&self) -> bool {
> >> 	    self.sm() >= 100 && self.sm() < 110
> >> 	}
> >> 	
> >> 	fn is_blackwell_b(&self) -> bool {
> >> 	    self.sm() >= 120 && self.sm() < 130
> >> 	}
> >> 	
> >> 	fn is_blackwell(&self) -> bool {
> >> 	    self.is_blackwell_a() || self.is_blackwell_b()
> >> 	}
> >> 
> >> That's two unnecessary indirections for something the kernel already has
> >> available.
> >
> > Again though is what the kernel provides in the form of an arch actually useful
> > to user-space? Obviously the code above makes it look nice and simple like that,
> > but as I have been saying more complete implementations can't just rely on arch
> > alone and so are still going to have lookup tables both for SM and for other
> > info the kernel can't provide.
> 
> Are you saying that NAK oversimplifies things and hence gets away with per
> architecture checks in src/nouveau/compiler/nak/sm70.rs? And that a "more
> complete implementation" would be specialized to a point where it becomes
> impossible to have any common code per architecture and in general?

That is my understanding yes, AFAICT we cannot reliably derive the SM ISA from
the chip architecture alone as it's defined here.

Obviously in practice not everything must change for every ISA or the NAK
implementation above wouldn't work at all, so there must be some commonality,
but HW makes no compatibility guarantees between ISA versions so we can't really
make assumptions about the ISA based on the architecture alone.

 - Alistair
