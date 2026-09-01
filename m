Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C927C624C6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB15E10E3AC;
	Tue,  1 Sep 2026 07:07:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="uLki1hZr";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFAB510E3AC
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 07:07:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXgBphJ+dpdwKi5PniswMj24zFmrPPdzoQwptG0BIkxauOuOhZeVhs5UWrise/yWyfamZvfaPiMUJ0eJUCfgPs9HXzHB7/JROVkL3Kb2+SHRB2MjuKFKBZ5Izn9XQCzcdBQDP2yutjfqvfc59FOKKdad1DYwbysryg2kFRUYJiwL8CgzMEaqf16A1DMhc5qz/5Cr4WyAHWB8pJoxf65dv7XJXGXu9r7QgcZ8tiGnwD4LlPrwPqIIAFQnpJnzMPyO4rhqUJJnoUTBEAyLuIFOgLK44iL2ahjSHOE/wNdV3aIQQBNzxDP87SQJTCmM9GAbS2+bn9wOXPhJdNMZTEMlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IhxJv3UQhVhoCs1CNN1/R5gEO/t96Kes+lr+AEPbo0=;
 b=Sa5OMtl4XsBYpXAT17uSbOXmyu+NVG92KQvdqaMwHPmIaVeAZIPfzoeUgxvfSnMQmIhZtOG0sYV/Eadn20e/AOzu/ote+cP6yh1ahfwMAVUYNSks42/PLKAtYVWJDurZj/t5a7+tmqs7ljZcLD6u607d33SNGdTfNzAZOU/KQc+e3Eu9HNpBnnCS9bLOr5EmYqW3lBWuzVyi3ovwOQ0Rxc2eV+GAT3N78anP2BIYISM7gn2XOFZSHONzwfnvTf+BuzBIVzPIh7ja3AeFYEJg+45TfARxd0BDLa20QWMRvFRlVx+7JJ6fL/RoEbd7jbFeNUPGYpL9znBXOoLeGRuzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IhxJv3UQhVhoCs1CNN1/R5gEO/t96Kes+lr+AEPbo0=;
 b=uLki1hZrhzl3U72X23b2aP/QcCtf7BGnigw27AAdSEjhMAp5SfrRXskzgg7WWw81FC8KqYo8sQitOvFtfM8peQZO04RrSXOFBchhrcX1XQxQAiwunzgsv7wxt9k+h57w2cXuUCLcP9ztK2A7fe8NaF3kQD6bqQZc3JD9KP1KnqaLyW0KRgDmtUH/45KnYH0XvGL2sOFDVekarUGby/HnGUJexCy8iZJjYMNik58MZNa4SnrfJBfN+nCA+hcfWjkh+WYlEo/5WwMxM04wcnyaQZbHkcUgnE8RCjDALXwfcRarQ8qq1FnlZCgeIDHKkRi/DXsTBGSQX+sUX/xSzkGcBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 1 Sep 2026
 07:07:46 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:07:46 +0000
Date: Tue, 1 Sep 2026 17:07:40 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 nova-gpu <nova-gpu@lists.linux.dev>, M Henning <mhenning@darkrefraction.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 01/11] gpu: nova-core: Add public driver API to
 nova-core
Message-ID: <apZ3_o8hxlMr6SoP@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-2-apopple@nvidia.com>
 <DL3EGE1IY4FL.3X49WKCS67UT@kernel.org>
 <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DL3F6EKL2F6Z.2DRXPQLYLE7FM@garyguo.net>
X-ClientProxiedBy: SY5P282CA0130.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::10) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: c64aabcf-faea-4e11-74a6-08df07f7b99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bM2LeWlJBB9k1bdV+Co59vLZDrl5dG528d96SEg+a3KPIFw3UlzpkocW2+pmack1ABKv60kb4RPT62Wy0XFIgcCSZnsSKY89LnWXcyLYRDjC5Zc6z+NcDp8SWQhd4UCUEtI9BJxfGjHKgwHsLK1TKlgRbEzu5eH6pPvqzYvyRdS2ekiDdr3CblqlzaLEUORRuBu6QsIyIrMhRj22jhvk4EtLv9b/RXJL9xpUZyBeI/k78oCjaSUq0KPujK72nkKsBjs1+sP6b0esaSfwJhauf6pGXkYpM8MEBUOk3q/gZUr539PZnZtP+sNhmq2xS9Y/vYC10FL4HdrvTlT2ELo9YKIAFh2/+GmHWQetcuJWemNeTJacCrTKTGyV46H7B4Kl2KD7yynIp582SCJGeZc2ItV+WGBjOUQsDDvvjfoO1cvnn0mKenT1h+64QiY7PUDgeTuicl8/MzhdJg9bEggZs/cUsMcBt4/PeTKKjr6ifZaIVgCHa7fWBghj2O+bYTvIJOasXW8qOliBS37QJuFSakZWfyPII930106OCeh9E2OBESyPfWz6xMKToAKcz4fi7BuuUkeTspFISb9VpSZPS4rD7kOWvJCNc1kskOC4PwZUZLvDudURqImUtqqGF6WKgEIIJim7zZlCoY9W5kJhuJHuvMm6dQCJWCkTt6rRAWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVk1sA8GibnNBGct7Qb5zGdjLpTEeg+rIt2kpovZk2J8TGd3XqM7M+vlmVCL?=
 =?us-ascii?Q?r1lZWJ8IaqXBwtvFlCk3GC4y4PWuBXIhs1sE76IB9g+5TzLMQP3ixKEhYn52?=
 =?us-ascii?Q?T7kt3J1syN/kf0K8T6gtGqnYqRGG7Bds+96vfJzohDcjxYM7hCDxl3es1Ikp?=
 =?us-ascii?Q?h3AxPU3QeBnefBzCvbaCVANz37+tT7rCIsuH1jCnRCXfiOC4SVgVpKgUSLtT?=
 =?us-ascii?Q?jHIs1Wl1QRF+AKftXrlwiD7MS/B+gno+6qOqgVWv7mBiO3RVzmPSWNYvcMGU?=
 =?us-ascii?Q?uKiu0Ja5pDREYctwbC5gGBp54oRLut+EIM0MJZK3v1SAKgr7cV6wHzG/lfQ6?=
 =?us-ascii?Q?E27Rm/lTKVoLaVjVTZG/fUmOLJJUBn/BxSSi/kxYkDNLl7e+in+PwkPzQmna?=
 =?us-ascii?Q?eL82zqe/POv3wL9ZJFcAwKp8gtw8pnisrcVSaEDukskK5nct3QHtxxxBUo1O?=
 =?us-ascii?Q?A3Pc+4tDD0sY2fD+glVERG6Zr5rAsK0XUyJBsKMFrHjrD1GL/JCzSFxvi5SF?=
 =?us-ascii?Q?IwgLUSY5Q2Wmhloy0lfRHxgA9WUH3EJx+5Puf9NsEiAjcDLS33RPIaRkkFcE?=
 =?us-ascii?Q?xbPEx7vA+bH9B3WMGbyUxUHE+L7mzTt9pwatv8dS109r+UW7M9YNnaMXFEMx?=
 =?us-ascii?Q?8+x1B27gWh0QrrKBErxGrqx2BxGsT+4/rkaZ1ujuk1W6I+dMJi21Bav5p7EY?=
 =?us-ascii?Q?U3FLLSRiGYjEttKa1fKq2/gm4LZMoy7nTHG8B3GMVHr1EjGuRMVz7ZA9U4Bg?=
 =?us-ascii?Q?EcA9e4dQDXS+16EE1Ckkbx1qjnkEW2ArInAoMQ7gt3J4Ds/vOc3RavaS8b7A?=
 =?us-ascii?Q?lnmS5dXuh9s8GChN45F3+BdXid3y1IJi4nxQmFWi4WfoD2U+28MwPGzEma4U?=
 =?us-ascii?Q?zsO+l5nHCnWPldowPl3Ez3cY9ghZFe6ZZ7n1H/UuIhQUaEE5PrYmWcbEXACe?=
 =?us-ascii?Q?M/Eys89Xzd7UvXjFWoneeZNQy/PPloW339KdzDxnUn7kwoLi32D8i3neeg2O?=
 =?us-ascii?Q?5OnTDwkD/s9TqNBo8VZwuMR6knHgw87d14+pU/dyj+hCjK6SKXlbvjLerkeC?=
 =?us-ascii?Q?G0Y+PWVmM/6U0rAd6hjfmnxF7sv/pUGHE2N2sph4YAe+h1eW1DeauD0Sn6mg?=
 =?us-ascii?Q?1JseTn98DZMSaLE1a3ZDkCueyv4T0UmTNo6NLpPnoIR3wIIXwNhOTMXZ54O8?=
 =?us-ascii?Q?Wut4NPz2HHFFevMw2WB0UKo2VAelHpN9y6i76a0BjDfg/YyxfYsl2qOfN+HR?=
 =?us-ascii?Q?4ZA6Imd1pfYmycLvldFVT2+qVYBwHExOu6YLcTkmeTbgd+zOzp8gz2l9AFk1?=
 =?us-ascii?Q?Wm0nCVnAUObPe2i3jsjmVS3Df7KQbemboy1uRXCv1KdYOSIkYJ6x21zmlycb?=
 =?us-ascii?Q?oZunTgPf54wzTL6ttHDvGS4Lr23pH+4JlYrYfjZfWtbMKEfpEdBVt9XT7ksL?=
 =?us-ascii?Q?b4ImUc2c8bhqdIDs7NLdKxe4uAN202+DEdv2dE1H+kn4Nysz3DVBXRrrkMFR?=
 =?us-ascii?Q?pDwQRTXNcrXZr2Jl53thwKAcwj6zGdPxhX3nv8V3Glc/hQbMFA2HD0KjHLwp?=
 =?us-ascii?Q?iTkffGDXFLhmwmjHvx9WGatqRiQr3cdQkZVWGZ9a2HLycRwajjy1VIDe2aAd?=
 =?us-ascii?Q?qxESabAv19VkmdMgDlnR2/6Ovc09TvUwROpzhbOfDihgc0/AEpxVXLJf75lu?=
 =?us-ascii?Q?1NdSfiWItSZFAo0Uu0ke7hPe1zpvq4CpJsbWRv0szZ9Vk1hbf3gD4x582MLk?=
 =?us-ascii?Q?kT3RyeM69g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c64aabcf-faea-4e11-74a6-08df07f7b99a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:07:46.3597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+1Se3Jx+0ax9wfcGee655QSSjpJZKblrfh4oAtnUuYOI90UBxWcv5grZtMKf5+5f8AfeqpxENwdrM7IUFTYuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
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

On 2026-09-01 at 06:42 +1000, Gary Guo <gary@garyguo.net> wrote...
> On Mon Aug 31, 2026 at 9:08 PM BST, Danilo Krummrich wrote:
> > On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> >> +/// API handle for the auxiliary bus child drivers to interact with nova-core.
> >> +pub struct NovaCoreApi<'bound> {
> >> +    #[expect(unused)]
> >> +    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> >> +}
> >> +
> >> +impl NovaCoreApi<'_> {
> >> +    /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
> >> +    /// by nova-core.
> >> +    pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
> >> +        adev.registration_data::<CovariantForLt!(NovaCoreApi<'_>)>()
> >> +    }
> >> +}
> >
> > CovariantForLt does not hold anymore on latest drm-rust-next, as Cmdq has a
> > Mutex. So, this needs ForLt now and therefore the approach that I shared in [1]
> > a while ago. I applied the changes in [2] to fix it up.

I can see why the mutex means covariance no longer holds, but I would kind
of also expect it to not compile given it surely can't be safe here to treat
an invariant type as covariant. Is this just a limitation of the current
CovariantForLt implementation not being able to prove covariance or am I missing
something else? Thanks.

 - Alistair
