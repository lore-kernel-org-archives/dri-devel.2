Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7F1C61DFD
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 03:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 452D910E364;
	Tue,  1 Sep 2026 03:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/y8vdsa";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A7B10E364
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 03:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCToXWHrK8jIIvgOCxhnLaoKkCNKmG7LHk5SJlf7BZjYbeI8O+7h2wcHmw+E30slK4H+xLFQCoAkEEpYznktxDWwazPvCOxfhQD8witj6s5iAx1cxGKhEmy3MNjdTQ/K0RP2IoY+VFXRpZrB4uRbYk8pZd8DuQcPwirJSN2i+EQjgDng5GT7CpHS39WEd3m50fcvjQkSVF2i1JjHt2c6d10294l2hCC9iysdY6Tcss2BuU9s2goHVUYswug7v+6pshXTJaHrGEfZfYGv9CcbcdmtvetYQ5hfujmLzlRZXOAc6M2JXqYms7IJ+TTik4vMIqb0L5hQg+C5fb2hy346KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=434FpSHhiWSE7amyjyfSDwE7ncZhXVK9D3zts1vg5m4=;
 b=nmWyTd325vN5n40HQRTgKnICfwVj3BQLyJKLcR/kDXFLhvGJ1qdV0UGgt/Cjt6wbjdc6Iqz/3fgttSB77bRSEv7gS9YvIp6LcKkrvmCPmGdXnQYtw10jWwWQVG9BmsAxmsXQE9wW/0JXZ0zn/nTZlhgBZNNgId4ohNdUsPCdX95opC68a2NeFnHkh1CoQJLVXAWD38aiFvaZoaWgQLIRzfXkLs5bIiQa+Egj2gCh7k1xP1mGBLtIEQclmTANV93Vd4FEQX+J4ttJ7hx56OolgdSLANmR6N97Q7zd5L8Yu0hID2DVhZou0F0OrWjwJFXyU/hnHZDbcXsF/XUatcuwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=434FpSHhiWSE7amyjyfSDwE7ncZhXVK9D3zts1vg5m4=;
 b=D/y8vdsakU0IFrit/3X9PVqqhP52oceEpe72PrUB6Je0feFRNpS7ga0Nf2UeHEMMHVnGbJ7OOC02uF+lrWOTIqSukAslagUb7DahswU9AaazQylp+tKcsZipWR52yRinGnSAkFtNaRNdR98HCUXd6VhhDhBvKN7dQuMOUcNMh+cRU+rnfWoR9bNJgQ+5IE0eTaUQmzSJzRpLZZ7sPF15ydyp9byZFB+cTFX5szVBEzJTMG95MfQv2uBThLwLvHjjzgi4uYkcj2TzDaHcZBT4/HpsD+LB7sc0jC3TgkF1Ayu8bldeF9LRU8EyhVWTXgAaVyPYJhuqb9mkPMfy+kZHRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by DS2PR12MB767817.namprd12.prod.outlook.com (2603:10b6:8:3c2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 03:10:47 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:10:46 +0000
Date: Tue, 1 Sep 2026 13:10:41 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: nova-gpu <nova-gpu@lists.linux.dev>, 
 M Henning <mhenning@darkrefraction.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 10/11] drm: nova: Report GPU short name in GPU info
Message-ID: <apZB3KrFAzzEL4gS@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-11-apopple@nvidia.com>
 <DL37HVMJQP2U.126BSJ2S51HI0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL37HVMJQP2U.126BSJ2S51HI0@kernel.org>
X-ClientProxiedBy: SY5P300CA0103.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::20) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|DS2PR12MB767817:EE_
X-MS-Office365-Filtering-Correlation-Id: c7081589-a4c0-4fb3-63fe-08df07d69e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uCpYFgVwk0CxeRbu4zJsESDThO0Bs7MFX92cbnt/gCf0GsVFtMkar+rlaz5/8GfZqx1yVTUHfURMxqwwWRKJvCf5eYZPicU98zj31VYyzbC9EzaGiX1SSPWKBzZeRJFn8ao/xxdvBU8W57uIo0WqUhDol0VlYN6LJKLlGuJEZShWGorQ2sg5K6vhzu1m4HdrjU0cgG7RzRISmC62eN3rJj2MEgEGvSU4cazmcFqJDSS2agbxKMAiZKOSgVsF1oqySLYIT9MgqCljp6qgMRhtkq6gqnmpmoSNSsqBPIcvLFQH8eXxxeO8UrJwyoPv4s364Fce/Q1VO4DnxRqaRGXiYKdWLIrdkuUZCzsd1YJQ19zlzrWnMttopsgawRULANKPTAalzKMEHlB55ks4LOnqxqfDdERxwUrEdRMQH+gnhd7CqcGcoZ3JCFHSLQ36Wst0J7gq/u0n30ofsVXuTjXD6cAqT9YRx62gBiys2Fl7ylBRSupkJ1BhScLM4KpLEI9AxPvGQWUlxOyIHSeejDLEiA2z2s2vviKYszXN7GPIqPcjBOuKQRIgm/GTVOh+bN2rcdFwTu1yWa2qY9XZ4eUMi4wD9cJfs08y97IqdCkcm/1QiAg3nZmN/WrOkkrWjYKhZ7L99p8UWuTOhbsPmpLxfN4OgK3tKoPKdD6hMUh+4GA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XZI8SqceDpEZeacXLl5Eu/gbDOhBeJsKD0zNE9DcPO4TqssUq1t5k4g/lIGb?=
 =?us-ascii?Q?SAvRFIqaoHV4J14W+pW1SuqEXBEeDiMNcMWFkcqgApZd3biB6gqV8yd0UGrW?=
 =?us-ascii?Q?04uH0/XRm895aA0448lZlTTGNsC5x4C6wccHjAP2mWHIu3/eSP+SqC+amHq4?=
 =?us-ascii?Q?ezRkbsS7hGLgqrwO2Pok0XRvfUkViNZTr9oviZIw3QFPQ66vKikJw3lf9tKN?=
 =?us-ascii?Q?dlY40C4rP5VypGpw8N31E4L28ddgfosUKK4FpqmteAPnggG+hWdN27lR75DP?=
 =?us-ascii?Q?Ov2QJdUsRnmEXpoch39EsUAXvQ9StHWkd72FqH652QnAanunNLsmOZ1dymeH?=
 =?us-ascii?Q?4HMP6oT53BaU16+VCbKF+oyXfgqgUPoOqON4MmPcWNflFYig8haf1kmZtaie?=
 =?us-ascii?Q?b9rGTx9eCvzHtkuDz0+5XLWItWqTe1Zaq9o9pZCoVrISZFHF60xc9WMsS6vv?=
 =?us-ascii?Q?3iq4YVdaWJCyohbRcXeud+1b+vIUtuA7eND+vMfri3szP3SBs9bbrkkJBVxJ?=
 =?us-ascii?Q?OcEDxILteJJ1dgaQjiERGbiAM/z4JTOCkgEVWBb5WlB7FJmpjhICRhC4Fpzx?=
 =?us-ascii?Q?z8PQ7WtZWzefaQdPzs3kxyGWyrtGQTus+RP4+sNNzMxdB8KEzrxH9vBp7le2?=
 =?us-ascii?Q?CUYdqx+F1RcZZ1SlSTAv39Fov+D8tjDvpVkq5vTKMNqsHvY58dBPKu8+H2AZ?=
 =?us-ascii?Q?840aFVY+emudjY3dZsCtqTvThx/U15QNPdcFb6zxBJn0VbVI2yZluoIo/LEH?=
 =?us-ascii?Q?0fxIZEkId/S0cAVbn1pOB0qpD6ANc075VVLTnfChfvFKq7AigaQZ4pZqSdJT?=
 =?us-ascii?Q?YP1uGhZs0l5JsObmv/50DCrJwGZFMgDZRIQr3tv/23ELOVWFhc3KN7rF8ZFx?=
 =?us-ascii?Q?jznIFuYKy+VGk8n9kikwFqckO7Dm1bKPd/ECL1J8XEyDZWEi0moyknlZfTCM?=
 =?us-ascii?Q?mqKywKog725fqIH2Fsz/YKT1lqyo7kqdaqmyky0mgFqwQGmECb3j35MYJEax?=
 =?us-ascii?Q?0rurnc9GcWmMncSq92N0E/1QUSobuZyxlvtD7FPRyEOd62ar9/A8FHCchZrp?=
 =?us-ascii?Q?VsuxdjXiL8NTUXy6sB/ySBKjbNIGx8r3cYWp3mBpNDWMoowwzGu0StaJXVFY?=
 =?us-ascii?Q?N7Z80VxrfJO9FtpFe4IOZ9U+xDZ0VBzSGlk+Qf8LLAqa5UCv7ch1Uoqx6b1E?=
 =?us-ascii?Q?t+pZ1u0oFaZx7+zrEzkJxKS0o9MD8nn5pRJr9uOSdt/fbJI8gDpQ68TEFKrY?=
 =?us-ascii?Q?eebZW9EwLww6HNrm6koaAYrFo70qB2CKJL911C+q5K/IflZDlQod1zzoghe/?=
 =?us-ascii?Q?pNlnQ6hDHYIsx4bl7k2ulUj8MdqbS2hO+y0pc1m3qebUZq4ICtjFAC9B7kut?=
 =?us-ascii?Q?B/4b11WWcXE730PZKPwXdBxhZgX7Xdt9Bi1SEcij8T2mrimiSETDYYovuB/B?=
 =?us-ascii?Q?ne2m7Xuv3RrH7uUr1CGvD1WYtLes6kpfKC/tCjAmZBnL4dqc7tLtrSezriZP?=
 =?us-ascii?Q?aap/QN2pk50Y8wDyad04meaxRTixz/7wSvIt00UHIZqMWUUx3Gj5Ow6YsXE4?=
 =?us-ascii?Q?l4QqtSklwhNtg4VE/vd6Wkm5QItkjFiV1PsrGrtkMdvT7lWo2Qjp4WqbumsH?=
 =?us-ascii?Q?iy6/CJZWMeykuW2Z//TGashufrr44+QjfpRGB6vvmqAcY2qT9yPoLd3cZ5jS?=
 =?us-ascii?Q?2XlbkUD5vsy4xlETavBMwq/UGv/sw5K4z+wS+eyJclRKKwviUT9+dyLddf4E?=
 =?us-ascii?Q?iyvHIRRBuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7081589-a4c0-4fb3-63fe-08df07d69e17
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:10:46.7380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FciQxJbl/NU+xYReaO6IJ9eX1B/3vorW61abKcuksKpIWnBc4Lg+nAJT2vfoafCGumspJReTjHYoqDFvZaS6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB767817
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

On 2026-09-01 at 00:41 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> > Add the short GPU name to the GPU info structure.
> >
> > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> Same as patch 9.

Ack, will add a better accessor. I don't see an existing one, but makes sense to
enforce NULL termination at the kernel level.

 - Alistair
