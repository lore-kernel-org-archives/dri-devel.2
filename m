Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32550C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7596610E9F8;
	Tue, 25 Aug 2026 12:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGNJj6S4";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010068.outbound.protection.outlook.com
 [52.101.193.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E592510E9F8
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 12:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPlKxkZuLdq35RucJxOZFvcUjBC2kjtUGwhMFXPePIry71kWmv7K0Phhzy3OIb0Hoyo3kOlOsg3Ht1Bqxn05Xv0LKSpwaiiQCJIAounaHL/RqZLkuRolzvCM/i7lY1Wt6NMNOI9C75skz4em9wdQ2G32pTIENAkT5OaM6e+j23DI5j4BKQR2TS2tz5V3bNk8xADVzSurj5qAwr6ytOOuVR3a3SbFojQtmA8j/puerQx3DHEpyIejOIYy/Y8f3e4+FoPcYOZOgr4mDKjkAOJfP959fHZvClaOv+C9yQfDWzrZsox1vg+6ZHLb8cXuCqRIQiCRwwjFBW4kSEJSAUbtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uokJQ6eS/AF0qQO8Tk0Vr+Jm+3MfisJ9JRy9LsywDwk=;
 b=L1aH9Sjk+M2T/4dTnRKflCMcfI51TU871SKdQNKJVMwp2K84/HmesxurleC7NzUa3blSpBLqfmNgESThR7/zr+Cg6WegTdQqVcV0Ep8EDgOdcrgJgKsLxkdpMUWhqUja/fPQkzaGR0IRshOUIXbmPNGs8m2YYPhvbbqgOV3hdrDyzMnC7vV7gxMfOp7wQDgE6QoIAI4HHMKybwoqRWo/iSh6bKNNXjSYbiYPbR8q26fJZSUChTXZaWi4l2vcv/iq/JrZQVB3xCpaO0ZFxGSwapR2n6lPyApmR66xXcG3Lg2zGWzn/cOaU2UHyDo2KI5sjU6RJ5wIggxUtkRtInMNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uokJQ6eS/AF0qQO8Tk0Vr+Jm+3MfisJ9JRy9LsywDwk=;
 b=KGNJj6S4YVd7bts/IE9YlXUW/A+CWJ3fOSsDfYEf1CALvsRlSSulpTKDGM3mSodEe6hcoevM/1J3kpdlYykPTT7e/K1eQOTPfbRS2i+FucGh/W0KLTqbPar5GL2ryJ6DM7ixxgsfLVpYKZBlvXb00qgs728h6IWmULUfrfCslT2XHa0XDOcazDUWETU5YhBeWUgYLraKV77B58U6jcQ30GOKUNq6OmygepMAmzzRT5bGqcQDzqmLraygHtUbYrQHHTkq2Q3EqfYl4+9j7uq5++VSTpgSIgy3srl2pw08DEfre+HXhAOXm56QLNew+x1lAQilTbaTZ6l2rCmRi3Z9bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by DSVPR12MB999174.namprd12.prod.outlook.com (2603:10b6:8:389::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:03:54 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 12:03:54 +0000
Date: Tue, 25 Aug 2026 22:03:48 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: M Henning <mhenning@darkrefraction.com>, 
 nova-gpu <nova-gpu@lists.linux.dev>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Message-ID: <ao1_ngqj2a2XB3h9@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
 <ao062w9fdaQEEYHy@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ao062w9fdaQEEYHy@nvdebian.thelocal>
X-ClientProxiedBy: SY5P282CA0130.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::10) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|DSVPR12MB999174:EE_
X-MS-Office365-Filtering-Correlation-Id: f3de65a0-6e1f-408c-06cb-08df02a0ef56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 6ruQiZs5WxN4sajpQhHHXva92YIXcMXM1iPBP/PsMTepauvwcLrYTlivbe8XrBGjCGMGbhcZk1EtzLnfnfAojkadN0vMJVuJR2PSbjJhVvJC0jPhXr3U0Pl4sNvSLNMqqPSJJphc1qLvdrPQyvBnPIW4ZgbZ28H/LfV3lnRBJPlH980Bzth2xxl4MiMst2TXn6zRlDl8RMGHlo5au5BzYiqPy6sI7RALuZMw2cvx7uHNZrYzuHuCdCi102D/dzhXS2EgC52CNM3knTPLef1d+BYKUuPwR5h+ssrjDizAOdW1yEmvG0P7ciybcJgX2ZnU1og/SNtNmxe1xYLQ6X/rFIJOme5OM/N/ZgqV+Rr2XM+oRxLPRFtZHobjSBn0Pxgu4AyaKSH3W3gvlkmu+qMDcTucTKfrVDe5w22/SaG2qGfWhuofjjkfdn1kyJQ0syaTEWfK4mwuc/a+ZdXHbMXsPPuwZibsPz5T6ckl0r5yvNam9U3F/ojC6BhNIp6rCV/UOd8WK93S6zH+oscIs4c4ZYtS4RG2m7jPndpKPw0jlsw+BQiE6yYWz9VBCD/x6sEGkL+y2SagTkCrBFMom7YShOkxG2bzRkup5tf80zEXGermAJ4sfTNBrksypXlfVFxoYmEuvcEyrB/3ZQsmNfQD9WlrSh9QvyV4ydQxHe/zLc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJ4aXNmYkFyVlQ1RS8yTVFjc1ZkTUdWRXVRVDVJSHhDSDh2UWtCb1U2OEND?=
 =?utf-8?B?RTFKOFZJOWJ2dXFGRndrNHZyNWc3TVYvZS83WFBacEttR0g1a2RpN293UUM0?=
 =?utf-8?B?Sm9wWnFoQVZIUDZ1cnBlMzI3QTFpbTN3SnM3VHgwYzJWRkNZOHd6MndNTDRZ?=
 =?utf-8?B?ZTZGUTE0dURoZ0pTTTI4dWo5Mk9kbmdXdkpFRVM5WGZWUFJwcVh5V1hmL0Jh?=
 =?utf-8?B?L2s3Vm5WYVRmemdURldvbEJiN25TbDRtUWkyU3FhUzc2azc3N2xTWmkrY0Fp?=
 =?utf-8?B?VitBQUEvNWd2emVYRHdEVE53cDRlVlFpVkJJelRUR2dmK2FiVFhjUUtpcElF?=
 =?utf-8?B?U0tnRzJNV2VTWkJSWVV1di9HZWpkSGdtQVJJYkFPQThqR3JBMDF5Wms1ZkJ1?=
 =?utf-8?B?N09aRE10aERZejdPSFA0SEhQU3FLaG1IUG5yMmZkSFpzaC9YSjRzY1NEZGRE?=
 =?utf-8?B?VFdDOVdKL1EwQklMUk1waW91bDNjZEh6Z2lDVytlSFloblNieVk2K2ZlcWt6?=
 =?utf-8?B?WjVzRGQwbVJhamJmZlpBWTU1NHRiL2NIdzZrZ1dqOC95Rm5HNTJZSjdZeUNS?=
 =?utf-8?B?d3lxSExDVm1RcHlISi9GanUycDBuY2xWblRRSElWN3FXeVBHK091Q2hrcDFX?=
 =?utf-8?B?a1BYUHNDUElYMVM1c0ZZZUNrTEJSRFdDZmtxVU9aZmdJZys0NmM1b3VZQUdF?=
 =?utf-8?B?bVNSNDFsQ1Q5dFZiMzRDRUxYUk9VeWtScVdFTVNqUmhxSzFkQWdIV1pTaHpk?=
 =?utf-8?B?Qm5xeU5PNW1hRUpzZytkRGZyeXQvMjJER2k5eExkRkJMbkFaZWhFRk1MaGRi?=
 =?utf-8?B?OHY0LzFvb3hjRFpVVktucHdNZHdETVhGRWtXVHc5ek0xcGI4b0E4UzgzNEl0?=
 =?utf-8?B?R3I1NktWekV3Zy9VKzRaZXpsN1Y4alV6VTByUEw4bmpXN21adGRqMHd1MG1M?=
 =?utf-8?B?OTYzWk1ockhFcGN0VEhucE5Ja1hFc1hDa2ZoWmIycXMxaHRkK1paZXFtN3Fk?=
 =?utf-8?B?c0JXcGRRZU9BZG10Z2FPSHA2MVJTVFlMbDY5dFpsb0hrMVBia0dMdFJFZmdI?=
 =?utf-8?B?SkJ5cmoyVllLSStYWGtNOEpGUnFZb0duZFdOb1k5NGMwWlZiYTBYZ3Qrc2xj?=
 =?utf-8?B?ank4R2ozeUZENGF1M0w2Tk9wclBpZzJ2ZFgvL3N4bWN3RWNRUzRhU0FqOExo?=
 =?utf-8?B?R0I4a1ZGOGErcnRDK0gvOGNwWG9seCt2N25TeXU4MEhudDdTY1VGTStvZEV5?=
 =?utf-8?B?dmMraUcvUmF0b3NGNUE2c3ZrRjZyeTArZnltTkhwYTBOdDgwbkdLZmZpa01Q?=
 =?utf-8?B?c1hSbE1RQ252Sk1zNEt2U0E3NlJRSFNvcnppbDRuUEpaZ0FEU2N0VFlpelNt?=
 =?utf-8?B?Zy9sN29xamhNUTFJMXEvazk1UHZlcllGTzFMOTl6YytjS2J3OWoyRzA1SG10?=
 =?utf-8?B?VEZHSlpUOWY3bDNzYXlkdmIwekVlQmlEUmZ4UisrbXVpeEU1VStldnpvNm1l?=
 =?utf-8?B?enBibFloc0ltbC9NSlAwMlJwcGowYWsvU2YrRlNPWkhiWVUxSVJRRmJsbGdi?=
 =?utf-8?B?WW5uclZIQTQzclowVzhKWUduSTJjZHBBbVpNM0F4ckorOHVuWHB2cldtTm9n?=
 =?utf-8?B?cURmRzErRlU1Wk5UYXJ1ZC80cUJibWpJRk5HMC9xbWVRSzdPOXUwSnQ4T2M4?=
 =?utf-8?B?WWFxNEpKai9rSFFOTDQ1R0YveDZKSlZxdERNN294WFIvTkwreUI2c3I0a082?=
 =?utf-8?B?dmUybS9SVFd6NHhXeDdaZkFvOU1OeVNBU2ZBVGhidnRiN3NuR2RtWjJ1YzI0?=
 =?utf-8?B?Y1l2c3M2Z3lDY3FkREpsSUE0VVRCUllnL3BmQWVta1psV0htVzMrSWFRd2VR?=
 =?utf-8?B?Y0xPVXhOVWxYUFFuUWZYMWhjWGFlRlVYRW1XUzF3OUZzZzN1MHB3NVpSaGRV?=
 =?utf-8?B?NDViRVF0Y3dGQlBwdS96TXozZ0V3VWVncm94LzN6ckozcDFtQ01SWWI4QlZ0?=
 =?utf-8?B?QVhYNWN2OHBvRjhza3FTU3NlK3VId3JTbldGdWF6Yy9HbzhEWWtTeFlrWW9K?=
 =?utf-8?B?ckg5bGJtbkVUSzdlTnJIK3FSVFFibkxmbDFZTkptSVBRZk5YTThrTFhSd0xp?=
 =?utf-8?B?UHZTTFE0RnhtVndTSHlPNFQ5Q203M2xmWHZYWFZHV3hGY0ZXUWNwQmczaGRs?=
 =?utf-8?B?U3FKVUdNL2ZydGtjODVlQ2pVd1F5ZkRtc1pJWVVVWnZQNmwzQ2VhVzFVSUpl?=
 =?utf-8?B?d1pTTUlwY0RpWWdSakI3NExqNHplK2xVakxLOTk0c3k4R09xellTajhSZ1NG?=
 =?utf-8?B?RDNHZis3QXdkRXFJK1M3MENOdUFQdXM5R0lkQXdLNEdsVmsxTDVpQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3de65a0-6e1f-408c-06cb-08df02a0ef56
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:03:54.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWVLFyCpolNMQWTnAFCybfz5J3+3BUhN+RkKN55XhNt86ow+Sr878DwbffVlVeuTsmxcp3GmBPSPMLKZAN2WRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999174
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

On 2026-08-25 at 17:13 +1000, Alistair Popple <apopple@nvidia.com> wrote...
> On 2026-08-25 at 05:24 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> > On Mon Aug 24, 2026 at 4:49 PM CEST, M Henning wrote:
> > > On Tue, Aug 11, 2026 at 1:12 AM Alistair Popple <apopple@nvidia.com> wrote:
> > >> +/*
> > >> + * Opaque chipids. These may be used to determine what chip a particular GPU is
> > >> + * based on the identifier but the values themselves should not be assumed to
> > >> + * carry any particular meaning.
> > >> + */
> > >
> > > You say this is opaque, but the userspace MR you posted already treats
> > > the values as non-opaque in eg. sm_for_chipset.
> > > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?commit_id=945a8e7c51939577526974b342c8dc6bafc3372f
> > > So, I guess my question is, is is opaque or not?
> > 
> > The PR is outdated and goes back to the first version of this patch series;
> > what's written here is correct.
> 
> Right - I was holding off on updating the PR until we'd settled on the UAPI
> here.
> 
> > > I don't see much of a reason to make it opaque since the chipset has
> > > had the same structure on the hardware level for 30 years, so I don't
> > > expect it to change too often. Truly treating this as opaque would
> > > likely require a small refactor on the userspace side without much
> > > value. (I realize this has already been discussed a bit on the
> > > previous version.)
> > 
> > I don't see much value in having userspace decode this value (again) after the
> > kernel did it already and can easily provide the required information without
> > making userspace commit to some encoding in the hardware (even though I do agree
> > that it is unlikely).

Userspace has to commit to some kind of encoding about HW though. If we're going
to assume everything and anything about HW can change there's also no reason to
assume HW would continue using a chip architecture and a chip implementation as
having any meaning at all.

> > OTH, the way chip IDs are derived has changed over the years (BOOT_0 / BOOT_42
> > with different register layouts), and I'd rather not have userspace commit to
> > any particular encoding when the kernel already provides the decoded
> > information.
> > 
> > Regarding the refactor in mesa, the Nova uAPI won't follow nouveau anyway, so I
> > don't want to limit ourselfs here.

On the other hand we don't need to ignore the lessons of Nouveau either and try
and refactor everything - I agree there are plenty of UAPI choices that should
and will be different and we shouldn't limit ourselves - but if an interface has
been working well for 30 years and hasn't been causing anyone any issues then
perhaps we should just stick with it for Nova as well?

> 
> I'm not particularly wedded to either approach but I think the approach is
> either:
> 
> 1) Keep the chip_id opaque, user-space looks up arch/implementation/etc. from a
>    lookup table as required.
> 
> 2) Keep the current scheme of just exposing the chip_id and letting user-space
>    decode it assuming the register layout won't change.
> 
> In either case user-space needs to figure out arch/implementation/etc.
> 
> For (1) the kernel should not be responsible for decoding arch because if you're
> assuming the register layout can change arbitrarily then the it can't reliably
> figure out the arch anyway. For example if someone plugs a shiny new card with
> a different chip_id register layout into a machine running an older kernel they
> could get an incorrect arch which would be confusing. Users would get upset if
> for example ShinyNewCard got reported as being Turing say.

Thinking about this some more I think I conflated the architecutre and
implementation a bit. A new arch would _probably_ require other driver changes
anyway, so perhaps my example is a little contrived. The point I was trying to
make was that requiring backporting of kernel patches and forced driver upgrades
just to get a new impl (or maybe arch) decoding would be unfortunate.

We may well never get to the point of being able to have a (slightly) older
driver support a new impl, but I still think it would be best not to bake that
requirement in.

> So I think it makes sense to keep this decoding in user-space regardless of
> whether that's exposed via documented opaque chip IDs and lookup tables for
> arch/implementation or by a commitment to keep the chip ID register layout the
> same.
> 
> Either of 1 or 2 seems fine to me.
>  - Alistair
