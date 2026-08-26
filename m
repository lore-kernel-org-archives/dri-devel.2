Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0789CC61DB9
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 01:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E61410E08B;
	Wed, 26 Aug 2026 01:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Edr+vdtN";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D4610E08B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 01:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhYSQ/T+B45KOdyISVzdqZp/EaMBcCM/nfjjYEaC2gJNncycqvF6OIGJwi3Tm3SB/WlbGguSJ9ewie54xOZJ4q3cH2S96Befrs09UuV09St4gO1p2qKiFT/KeFA8GOqeiJv5E4aO0EkIjaycrgzC9lKlSS+xGshIaTYCB0OiorwqXgX1qps6WzAIIpBGARtdfxBsH//146Oq00gn8Hm+QXxdQ3H8+gkI/AOn0++Be81w0/IdJpc6Iaq9UR54uc1NZNF08ECyAjfykHM7B5EF5r/m9tQ/amN8j9Giesqfp/Ofix5VTrxQBT93D2+fqcBMshuc4MpGKn72GJsf4Fh/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka+ukJfXIt1hLjQpofIYnLMSTkbBk/whOOsvoAEX8so=;
 b=PNBUnrkiJUggE/lG+kz3WIWl7zR0hg97ODdHoNpKl7JSOMI/oOVAcb9Gd62+Iov3ZdzBvLXB8aw7NlvlGvbrpgpPaZDa+0kZY4vMzCHnRhGFDbvPTCFKZLYuv+jCAiJliR3jWbu4N0dKt1VyX/Cwp3wtHwxkQprcBSfYx8+ieG1Ms73zBmuG+HhF6Ld+ojLxQefuh4eekk+PJO51hLawqqr95L8Gs2Nxf1bGfnHsliFAofjP7z2I2/PRuBaZh7amfxkQQTMWRCk7Z2cdtxBSJbiKvIGXhic1d9wZbv35EB1Veq/Uq1ZzcBCr3OlAORbGcmNS9L29NW7FQmw8b71F0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka+ukJfXIt1hLjQpofIYnLMSTkbBk/whOOsvoAEX8so=;
 b=Edr+vdtN5ABo+Rm7i/SHy9sXXjbqNs7/g2sLvjFx37fCTDfSkpGpsxp1e1HzZMcZylTsZsD6nJ3bgElKuiEOsuzQPvdIutfIng1dQRML+eGySDeHMj4lXkEZJ6nTo78GHgnLh2Q3FrW41rPHjE0hi5ovOfC4eznTEfeyY1BGS48bXP2fd8N2zQqsNPIsZ/EStgSI27pqWAqB3YMU8fb2QbZUeW78nx7Hs9qYSZKfl6TK2Jv7MUFQU7m3zKcwF1ni07toOnDi2VqY0N18dIDf7ADTKgVhBolatOcbSeS0wBOkc7MRGG/kxgD2+mqiMi3zlZW6kfQNx458EwqjMfPnKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by MN0PR12MB5810.namprd12.prod.outlook.com (2603:10b6:208:376::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 01:49:59 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:49:59 +0000
Date: Wed, 26 Aug 2026 11:49:54 +1000
From: Alistair Popple <apopple@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 M Henning <mhenning@darkrefraction.com>, nova-gpu <nova-gpu@lists.linux.dev>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <ao5E0swaVc4etCIa@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
 <ao062w9fdaQEEYHy@nvdebian.thelocal>
 <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
 <ecb0dc71-84f6-4a0a-8bcd-d38b194630d3@nvidia.com>
 <ao48Kz_vDm8Ogg9n@nvdebian.thelocal>
 <9ff4d5cd-527e-44dc-b42f-ebadfcaa5c7f@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff4d5cd-527e-44dc-b42f-ebadfcaa5c7f@nvidia.com>
X-ClientProxiedBy: SY8P282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::27) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|MN0PR12MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ebd9d9-c95d-4b6a-9b02-08df03145629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: dVau1FGXH/ux916L0wIB3Js5dbLRTCLHlFF3Cw+PveQ7xmMr8lR58pUjWYHDzwqfFqPzFxEjDomyoI4l/meYmcc2eK8iSoSuqfVGIQDQl/aTD9AkkfwdJMLlEEoaLrVE9ADDXvOi7kyE8N56d3Zk55NQC+4BWT6aQqvQB3LXJcQNbxTrJArQrt2gV7s537AZu0KB9AY4OMorqSYjngwnG0m+CBLbzRMZIL79aMd+huMD0t+G063x3v17muvrS1P/OqShe/fPcM9ZKq1HTIirUjDAdI4gf+SABZVqT+nQRC4qeiPztjBaA33nk5c0UDIHwvPOU8cYA1gn0C5AgTmjSb6o25fvpN030zsaymzOhzOgbDzxOq4NFp11m93JZ3Sh9eTgmw8YMtN3D3l+WH2DK7u3W4knM6yZ59psxL/caz+vHMkSkkL1oOZfI/2BFPLOILIp56/ubsQHnCJ5tM0vLLwR8c4R5S4aGE38hKtlWRLH4tdObf9jf31tNMWA6vWFUqR5Cx9BUp0k3Hk64ZhmwuYIE/3r9LvOy8YwqytohUKcgrcgPbGVTFGMLBOMw799S3mUEEGFiHBUDjlFF/diUvTXm/xxlsUZYdoW2aNaaBa0N6UO9Qs9tnX6uhpJENsXY4/x/7fBaQG3fu1Tvp67DoDb2vbWvrbvgh2yf/Kg/RY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CkF59buu5e66FcYEDDhaSGXwsOPoJNRqXZk0jgIufFI1B/vp/jAH3/bV0ub?=
 =?us-ascii?Q?pkq8SQxY8zcYp717bqYDUbtzsk0TLlUUk99W7SGYBMr/sKk4PGPTrcMev/lT?=
 =?us-ascii?Q?XvaHmsB8aKraDUqRqU0znqQf1apErb3U4vWQ0svokD4NSx5yLOQjYMTJnTHQ?=
 =?us-ascii?Q?80LNILBWy+JErIxBbJ1DqSt9AkWxeeN3yPNmCxAoYYbznj/K7HPCNcNSFIDN?=
 =?us-ascii?Q?WoQaX20gYN+VUrEMqaiyKCdyqYtZUus3SrpZlehjlwZJ1ltL5mvULiFQkI+H?=
 =?us-ascii?Q?DzkJr0Tw4aak7+F2GlFXfKa+2xSzRlH6M/3TX2UJN9SXJ6lXtGAKSccU0KQO?=
 =?us-ascii?Q?QqNnQdy8Lr5eoZC9KT37Nq995T8HYbeJ2j8SI7IVLQSVd9SQAjOzvFdSxv2S?=
 =?us-ascii?Q?m6RHpuWxQATuQurlf8kNdEY/FWxMyEPFfruv5VMlwyA0Dklhg/6pAYBNaWDV?=
 =?us-ascii?Q?D4CIzRvZuBhA3UE/aWF3CI34v4BgfQvd0j7Fz9vXdBvil15z5xjB2pqmMDC0?=
 =?us-ascii?Q?cIurJ7LqUMxQutP2nkYhHicktbLS2cF6t60UBMIyP/JS6plBc9hqtOhSb2pn?=
 =?us-ascii?Q?1obldMgzy2v0nrdRXTrHQIgHHgz0nYxHcnhXFJA+Zz+7TzfHPHHxPITC+6jf?=
 =?us-ascii?Q?Vh/sKtPj5uSQkuOgbP7GRXsaNIgpavlZskomTNa8xRxG7V5XECl139+oUlMb?=
 =?us-ascii?Q?cITlrvznp/2ow+kiH3Vyf81E29LFlwcmABVZsJJJZ1Yflz4a82WgcnLA52cT?=
 =?us-ascii?Q?kk1yZsr/OCQboT0tDpcmm22sPPRME/y8VlpD4f6tifoQqiGaX2Jrsv3uwQoV?=
 =?us-ascii?Q?EdZwu4cdq31YpFQyHvdutsEfoDnEgtwZpfvq9XifyTo0u90/iJHWhhaEiYxh?=
 =?us-ascii?Q?CoEGp7Abflki6vA/3tvCdVOCHI/XvL5Rd8s5v85KfwR7zeOKLDFXJty764Ve?=
 =?us-ascii?Q?lNes25pxrdBEnkOZUjc43Tz3wMTxgxNppCauAOd4ovSx73Ej5gyDTS4SkmOw?=
 =?us-ascii?Q?weeHMvlR8TV0Y6IPP4wOMMeRkOdR9xCBwXvgqXZ5O7BDQUkJiuJSuqxw9Zqe?=
 =?us-ascii?Q?hLypnjCwVZQ6XVL0ygrYAvGzCSNfW5Rn4meRhZH/JmrsI5WErlxgoE2wNepj?=
 =?us-ascii?Q?HOqiD/AM/7QqFhNaFBZwfnkvFvrLNkXNG4OroSoGict7zhUnbL58rS9g4IPd?=
 =?us-ascii?Q?XMfJ+2oUh/pKpHlkl81SI2jf++ZQNZ1QOGl4evWiBPDAHzjVPouH0VYVe8XP?=
 =?us-ascii?Q?rrmMyPItyQ4OR2WwrQdqNrDurP276c8KenQVf3UFgsyumYFYHbzqB6RFqAyr?=
 =?us-ascii?Q?i4T+qqwjwzYBAsvrflAC4gzr4fHBzNblT/DnxeVYmSRLaiziJ7t7++QKHCIH?=
 =?us-ascii?Q?q0SKN21mqAG1OiVAZDYmfHWSA2vP4CWDdS45HofnGsHrD7lbzwucX0eXBIKP?=
 =?us-ascii?Q?o11oWuEpG8hww3N53u+ssU2fkYAyOXHEzNY9a1lP6a9q38AA+RuTBk0F4L9F?=
 =?us-ascii?Q?/qTwAufcQO/Deyig5UMxiFNfuGljDgaXbft86T/YZdIV2q2vpu3g6xaccYGZ?=
 =?us-ascii?Q?0yh986F3Z850UhM8AL3yGMxfHoCbYo5qQmmkVgGWhV4DMtSQqVg37KWz3DO5?=
 =?us-ascii?Q?wQv7vb1JjN7SmMrMPJdrk/AgzFtNRYZ9/0T+kA7U0gTv6hJrKEOF/2Uy65M2?=
 =?us-ascii?Q?wVOLC9SODjRo1PikBZooZ1YepDE1iZPJWUHog1wQMJqePXFROK/baCCPDuBB?=
 =?us-ascii?Q?TxxaCoqWIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ebd9d9-c95d-4b6a-9b02-08df03145629
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:49:59.1878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/5sdlllA7fOOmX2bbCyaJBw1OiZDNRlhswP88NmAzbtfck9IAY7tHZuARDcKpjqkR8nhOaMAv7ykLORZOAuAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5810
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

On 2026-08-26 at 11:41 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> On 8/25/26 6:27 PM, Alistair Popple wrote:
> > On 2026-08-26 at 07:13 +1000, John Hubbard <jhubbard@nvidia.com> wrote...
> >> On 8/25/26 1:53 PM, Danilo Krummrich wrote:
> >>> On Tue Aug 25, 2026 at 9:13 AM CEST, Alistair Popple wrote:
> >> ...
> > Sure. Two questions:
> > 
> > 1) Do we also need to provide the decoded implementation value?
> 
> User space needs to:
> 
> a) Know enough about the GPU to be able to choose an SM version (and
> probably a few other things) which in turn is eventually required in
> order to run GPU programs, as shown in your merge request[1].

Right - currently that comes from either chip-id lookup table or direct decoding
of the chip-id (although [1] doesn't currently look at it). If we're not going
to allow either of those for architecture it doesn't make sense to need it for
implementation either. IOW I think kernel should provide the decoded value for
implementation too.

> b) Display GPU information to the user.
> 
> c) I'm sure to be overlooking something.
> 
> > 2) If we provide the decoded values why do we need to expose the chip-id at all?
>  OK, so maybe we don't?

Yeah, I agree. Doesn't make sense to if we're going to do the decoding in the
kernel.

 - Alistair

> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?commit_id=945a8e7c51939577526974b342c8dc6bafc3372f#3bb2fa8303917a2ad83e2239c2cae842dfaa594f
> 
> thanks,
> -- 
> John Hubbard
> 
