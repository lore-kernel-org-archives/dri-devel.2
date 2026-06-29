Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB15EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC0F892AA;
	Mon, 29 Jun 2026 08:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="txfiaKoA";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6CBA10E03A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:05:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBJV7S+RGAyAsl4LhJa6wvXs3xpZaWn3OIfuYgyqskzZ/vdy9ZdwQ6CFyTwZ+O38JyEJMcprGFRlNVmUh38fPNQpPiiWDC3aP8qyhBnUHn2Ajs75/Slsfy6QFLos7whHfELNWHFS85ldmbVqnMhum6Qpoy1kYO/2SqnLRF6Bf1znEgbPLRu2P8tf0m9BFKYIK4twxJKoSmL0n1Mfiwx0yt66OdPTm/HBNQiwOInVXiERjeLK3ScOs1C6cGb7Xr4Vgj0f6yA1HngPfcpyKUaZlsnBz1J7JwxSCKzoJ/2gQaVPuYkhnKglr6qx9y6HAmriFlecu4bla+NT6nEfF/zyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcXduUeMpYbP4PreoFVZfyYJXgDuegIE2OO/dqR5hbg=;
 b=EX9FjKG1N+6hldWexjHQlFPlNlgmqL7zdShGfiPvhBBRb+joTsc9MNq1Tk5p1cm/QjhB7rMxH3L3nL7JDvRPnuSBN7KyNRg001uNYsZupyanR4YvZOgsaj9etDT5nZNrMBNIYXMVOg5odFN5CcqCCDcj5wpZmDLq02k8ESizYbc/6FKhh7dyQq7WJkBVMT2N0fMFZNfJz8EbgYvfYoojHZDOsn7jd230qkFmZv/dYh5TgvBEv6So/6IzfhiX8AyFMURIcxwpmZR9kB+TzWZs1NYAkGJV0HthnRgFh5ejlnMCQQ6vHU8+na6v+whPydyma3Il0m9ualzbHBHtc2sQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcXduUeMpYbP4PreoFVZfyYJXgDuegIE2OO/dqR5hbg=;
 b=txfiaKoABHhgLcu3DEHaV4ISwFCD3vTRfLBDft+p967EEAH0+aWN9zLcMnafkLYhAG1WGLuBzQ4JAKTJlAkEcUTzoYA6w8nVHqMP7999rCYRCl8CijzPKwda0xpAuPWbi3X8UWfHqHpCSkZPU9kZay9baFI1wRMzKsMrWckROL97OXVISzD5mNhQ8X6ysrsEgfSgY403pPderMUoECuWGYrS8YM6Vg7f32MrnyT5Rdz8KXThXqOrV+10RUDoVKUObBFHQzVNCrfcSg6es/ZdfIcbgZI9F6fyZTv+rCacwIXJ2LSbNrzylhP+VCqh3HfpL3N6UoS4HhX7xlX88rckJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Mon, 29 Jun 2026 08:05:44 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:05:44 +0000
Date: Mon, 29 Jun 2026 18:05:39 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: SeungJong Ha <engineer.jjhama@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>,
 David Airlie <airlied@gmail.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, 
 Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Pedro Yudi Honda <niyudi.honda@usp.br>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.de
Subject: Re: [PATCH 0/1] nova-core: Convert bindings to use zerocopy
Message-ID: <akIlXpFeexxttlV_@nvdebian.thelocal>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <DJLAUOEDW6HT.39URSU30Z0HT9@gmail.com>
 <DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com>
X-ClientProxiedBy: SY5P300CA0018.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d480c6-822b-4a30-2c73-08ded5b5381b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: E8uoJHNCGuKN8VRSPeZ7Haw+X9qK5oDRZq9qEXc+lneyts11L2PudR64dcZJQ+y10U6d9m6fAXnSjVlxM7ty42nGGX4SWRoVfXW64wRwXxtapGB1I2v0BvK19J/tbIHHcKVLGa94jKxHUTKrWD4hsm+i8ZUqnKMI1aT4CNX7cI9B4GMKrBJ9pSIlHhN9lf4sSp0t1JZHCCvzHMmTzQTxBJOXxrLF7vMVHTerHl6fgBRdmheEw4y38nfjC2oo/AwAhBTIjMb5FobMzbWiS0+4iRLvNrUqdaJm8hmNFKW+VMjWtDSGLtTbeq4my6lGGGULpew3d4cqR8m9lT4gwTOrAd/byAh3utiPbPOiwib5VzWYa12zowPT3cSwV8IuzmV0y9qd6mmkLrZQlGFGJkP9xxEKJGcLNGR8oP5AZj1+QYeL7EeC7ef9RzP9qtyttgVpZHhaQvzH1vPnY1pKIFltLqRmvsDfc6mj67+b1lj8uhtLMtykcq0+gcuMhcWf+WkIHTecs/fRFDZZC0wbTUJETvS/isNlEzosYqmATo787qVqH/TdE68m6IRTeaKt1YYGoHdLxxIAfavKbKnwvVUKWdD5tFdJlGDDE3Tk2RzJN44/kCgi5XXlD5qurnVZ/C08CwVU5brNZpk3/R29IntOkSJ8WpEZZPlXNKn4lqEln4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NYEjQPxafBCaoL1jtvqNI8zZen1lxzxKn+ligYPDehCPRbAzEbKXL55Btj?=
 =?iso-8859-1?Q?1NI1mzWESq+BJ7iV5ladSEwzoyrXrvw9VtsHaqzNBPUtvtM2rCjUSVnPZn?=
 =?iso-8859-1?Q?y2m8bvz9L3i+XpJiHTjOTDzQD5Tbffz8OZ5709ciD4kaohUpQs5RT/utrH?=
 =?iso-8859-1?Q?Obwyp//iIeAj7N5lt2QSTE0qG4Q7UZ2cEmDb5lO+ueb99vWsZWxszJrnVY?=
 =?iso-8859-1?Q?Q7sEXmlhtNZBJWTgbxhUTjJq33JiQDsl5v0RsyQVY/qSMWxgvX4JHvMRza?=
 =?iso-8859-1?Q?kBKai9O5KEP2JO6OPMqsdum5OXwVLyEGxQMoRLByyxxfl3MMphVa4AHxfB?=
 =?iso-8859-1?Q?GE9E4Fxn2ysDNIsMcllG5WnyHyu+AEMFqnulxXt4sAOPF3f5RKsI2pKiCE?=
 =?iso-8859-1?Q?WiQ08qps7n4hE6d+/OTfKRiwFcEaK21m1JK8pyL2NaHJijoEjZZFl4KYFw?=
 =?iso-8859-1?Q?7E2bn1GHqqYZhI7Fwg+8SMEC1ybzlHYyKEkqPL8rNjGpdof/O4a1ZH6UxO?=
 =?iso-8859-1?Q?5n0sdvberQ5wMPxp5GFhNzhRdjRrOkxjgqnjscvUYaES0CIQh7psvgcS1c?=
 =?iso-8859-1?Q?957fcgouwhnDT969ZRP3lHEbaLdoqfz1lPh759Jyf5DL95OZ52siPlg4Yq?=
 =?iso-8859-1?Q?W6K1JcSG4vtl1iYsIJwrDHXsjcFFmbYSu4Relfh/qMmdRSmKMhQcEsnrgf?=
 =?iso-8859-1?Q?rlehT3GcPMk1gxmbTCRNrxCLug91BXPXf7IUQofZremjZsO3u4BPAHKxyp?=
 =?iso-8859-1?Q?OECHdkWWbOai8/ns6CehcQh6WP01CBMNPoSGissUFbs8sdcS+gwlMgKHY/?=
 =?iso-8859-1?Q?easJezvozT0uP5oMtoXpKFImeNvx2lCUbqqwn51ECsXlVxhd0xl/Rg0B6k?=
 =?iso-8859-1?Q?NztVKEjV9FZkTfsvSV0Gb+T27hNUsuQzCoqqtwbx3t/NfZ2F5v5C/7tKej?=
 =?iso-8859-1?Q?9f1nuE4aEy2zd+UTRYkh8CKFIL3rgKRtBcnQ6o/ST5XiP/YL+gxUm6YNLx?=
 =?iso-8859-1?Q?sTJP1JrT/QYRIrWPGJ01Ub0QkqnUC++EU62dAQyh3ch2WnwWkTM5AXEfBS?=
 =?iso-8859-1?Q?fmbPH79LXei6z2+NDPQyksFA2Uc/WRlmchd5s8l2kPljJnD0oCIX4uf01k?=
 =?iso-8859-1?Q?jSxFy9lwH9Sk92OgHACcH2UEed3pDiO1vMhowxTkwJ5imRCvekQSHQXoTW?=
 =?iso-8859-1?Q?YOARg2Bo4ooj9Kjn8ruspUMkq1ChWEObb4pCpB9gjgo3HNvUPgEzhquapI?=
 =?iso-8859-1?Q?5t9jWUDgFcb5j3l9KlGFiCFRR5I/mAsXGJnDKD7tyjkgy9e1F/6iRurN0E?=
 =?iso-8859-1?Q?cjka695bzuNGc1BHcjb7TPNWJrFfMpfrW5nciT9huha+jVUQtD4uCuP4E/?=
 =?iso-8859-1?Q?80eTYAyUcxOXVtnec2pz8wu4+lAAPg3oGu0ryt5G55RXwo4mDA0gbREonx?=
 =?iso-8859-1?Q?PtOGzFpoVDimuUB+D9cgZvO+SLyzHmNrTDkEyQuPBnzjGlBaq82jNrr7jd?=
 =?iso-8859-1?Q?kIGOyGnfDIk9dw3xLCocER0KjlyhpBrFdQcXojT8Ogfa0RyU0Sj5MXElp0?=
 =?iso-8859-1?Q?30p+4PIVxu6ZrrqWZWsp4foWxE8YRU4p+beFfzRzwrSbY9sUUnh8NO3Au0?=
 =?iso-8859-1?Q?axa5IEEoz34eOcQRCODatm4XYocjlFosXiQ8wCRLJAsK4XN4K/EB5esrd3?=
 =?iso-8859-1?Q?DKQLxO7276Z4mNuPTO9oYYpa0lLBjbY1/CS5nELvaqRBCIMeR615kvbxGf?=
 =?iso-8859-1?Q?olnpY3grmi+x5Jzhg8RiRp0k/2w8PALSiYuU6RyQOs+uEDT1eBDnFC339w?=
 =?iso-8859-1?Q?I53fXklr7Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d480c6-822b-4a30-2c73-08ded5b5381b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:05:44.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhnOiRte4suZMAaBEid/owmDY8omKujT6n9wG2EHlMkyeq/qew0fzlmvGDXbKpCdCNotU+FaeJA/mfP/BUAQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

On 2026-06-29 at 17:09 +1000, Alexandre Courbot <acourbot@nvidia.com> wrote...
> On Mon Jun 29, 2026 at 2:55 PM JST, SeungJong Ha wrote:
> > On Mon Jun 29, 2026 at 2:52 AM UTC, Alistair Popple wrote:
> >> Given the inevitable conflicts that will arise from trying to merge several
> >> different series doing bits of the same thing I'm happy if someone wants to take
> >> this patch and the others and roll them into a single series. Alternatively I am
> >> happy to take that on - hopefully Alex can provide some guidance here for what
> >> would be preferred.
> >
> > Agreed it should be one series. Happy to help or fold in my part --
> > whatever Alex prefers.
> 
> Since there is no particular urgency to switch from transmute to
> zerocopy, I think it makes sense to merge things in an order that limits
> churn as much as possible.
> 
> This means the conversion should probably be done bottom-to-top,
> starting with the bindings, then the types that embed them. For the
> bindings, `#[derive(zerocopy_derive::most_traits)]` should be landing
> soon [1] and I would like us to understand first whether that is
> something we want to use with the bindings; if so, let's wait for it to
> be available (unless there is a good reason to convert quickly) as each
> change to `bindings.rs` is almost 200 LoCs.

I think it makes sense to wait, if only to avoid churn on the generated
bindings.

> Since Alistair maintains the tool generating the bindings [2], I think
> it would make sense if he takes care of that part (bindings and anything
> embedding them) as well.

Agreed.

> There are also types in nova-core that do not depend on bindings at all;
> for these I think it is fine to take the patches that have been already
> submitted if they apply cleanly and build, as these are good
> opportunities for first contributions. Nicolás was first to send
> something for vbios/firmware [3] so I'd like to consider his v2 first
> now that `-rc1` is tagged.

Yep - given the interest from other contributors I'm going to leave all the
non-binding related conversions alone. In other words anything that does not
require changes to drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs would be
good for others to look at, and thanks for the contributions!

 - Alistair

> For the rest, I'm happy to merge anything that applies - small patches
> limited to a single module should be easier to process and less likely
> to conflict.
> 
> [1] https://lore.kernel.org/all/20260625231919.692444-1-ojeda@kernel.org/
> [2] https://github.com/apopple-nvidia/nova-gsp-binding-generator/
> [3] https://lore.kernel.org/all/20260621143647.264770-1-nico.antinori.7@gmail.com/
