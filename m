Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A31C61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E350010E111;
	Tue, 25 Aug 2026 07:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IGPyw9IV";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6036A10E111
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 07:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uF7XTzxV74kfoe0iyBos3jNolrFdJAhuuaLI/FsS3drDkq3cvTRaymKKuU/RiakBexHk1fWrbffUB4oWx2xUPD/rB8WsTnf/2Kmt0Gtm3F9QGDGvgfKBXSLF/cFcMGUFmB7o7CQgjwYbjq9zrVWdrGdnhHe2dqOrORLoAb8ccQRcAfhpfZNSzWvcI8Xj/1PCbrFBmu02Z7lOKb79QOvAxp7LMkQVICIEZA3w5Vaawru8gwQDXDs3k6xGSuLSeYis/njxJ6yuqrFV0NFngQHnvUfBU1yR00nj4r6yxvN0j+xURP3Nv9MjczR5PQo+U2SY7+7K0h0GnhI1Pe6CXAt+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+iN1TEb8WqbeLKUTCYwJlUaO0NB6wyXfv0Gpcj6RQo=;
 b=C2L1Vz4dAgZ8dDvJOjwCbSvdFqwc8jpeAu/AHJ0Y0mC/GcE7ji7mE7XxgbzY0J5Qg/qzWqSex1/sm+Wem4vHJ8fnxo0B0fJXjtimhPLZgLAhCDfZnFbJcXc+89wpwbjDeptf6TEyc4D5h6eRgsHePgQyQ0ueauaJoAAckLcZwSu3NSq2wpmvZNnnOvRhKJdKH6WceBHqJMIoMRKnH4Mf0mNQzNiuV6lQnMIiEf6Y/kiQfOmmjU6RduNOHIppuVbnbsh+ZzgtLyJR6IZI9RU3FWvmlROry/67MsVnHgBV8E4ONqh5Cie1xcGkw3d6zoZCR8bgSUHnx17wXgcAcmL3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+iN1TEb8WqbeLKUTCYwJlUaO0NB6wyXfv0Gpcj6RQo=;
 b=IGPyw9IVxKzqoAfc6YFVBFVErBiZE/h60JhFNUbGfOtKe5KcNiT8TDEFJScrLPfKiJRYD/tgg3dAIgXNNh2KJCNRSYi/QjPoYCLR/sUHVyahVCzoLn+D/aF4D2eqMHo5/4WViwQguIAi8b9CJhzkfLa+bGHShaL4vzRpyWs7gec7L1GSEBmy6oDb2LzBRUNLgtSgttleQjygyBzlZDHDjB6iBjFWfDqv+XVCEtw280ZtsSKt2NxKvdPS7a+OnNbVDu6f2UWDXIVQZRmhKtoMWIz6NCvuSHVybRB2Ia233aQIS/6bQZtB8bRXqZ420M8X3J+lBrTDV47wdjs1TBkziw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:13:15 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 07:13:14 +0000
Date: Tue, 25 Aug 2026 17:13:09 +1000
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
Message-ID: <ao062w9fdaQEEYHy@nvdebian.thelocal>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKXF49DF656E.XB24SXGL3RLE@kernel.org>
X-ClientProxiedBy: SY5P282CA0128.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::8) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ca6a8e-59c0-4345-017e-08df02785447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q+oh5PQQcW+OxXrQe6kUy8JueXoA3orX2e1oJfE+H6Lpiju0amlGryqCrkUdGF3PLUAxlYh00aKOIosPivt1VtIop7a2a1RgvUHAmn9e9x9trQIP1UrxUeYXXHVqV6wcAl8HjKwCu6T5M/A0LJbSnyqJDM5r5xnnaZlhVpxdu/FtP63GMBXWfVVWAtnvy0H7x+Z8So5xY/AYAy/2faphThXlkCcxm5lUc3xt07TCslwN0YR1Ws4qCWqgveyVsM/4Nmo/LhvEAX9PNaQev2SkkhRwgLdjidJmYACky+rRHNMy0six7tH1IA/V7ehe5dSMIQRy1xKopcPUUTMpEwJUN2WXTMcoAaU/mf8xjCwAebjrV5mrjzrexXy0165YqQH8PtaU3FYBD6bbqa6i/DIdhZWft3GqMSoLiv3Dz7TXXtuYJbV/YiO7vlZa9tRQHv0J6iGsUXUqPnjmDRbCZuH7rcoEa5kuZ3Lr/5etUAb3TDQq/NvaivPEe/PpE3VEpaKG5eVvONyklRrBK7fW9+INoIG/r4Tg9/oEbDxrCbW7NsmKisHc0XammLa0NwygS+/YpBJE2AFzX39b1gN0jhy2gqT8rd21H79ucA8O0hah7iUhg+fqtjDLVIxY207GHMzHWLaLz6BGGxF8p2gVsRmJb22YhrUqY+ixsx1ZOcoLSks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmpRNUw3cEYxYTlOeGcxQkpKNW9pNDNrb3pNWHZrQkZUb0V0elVXdi92WUVM?=
 =?utf-8?B?YWVPSmVvVnovSFJkNDg5eTUvZmpXYzUvQkJUZWNqODRjcHBxeXVuWGo4M0hY?=
 =?utf-8?B?T2FXVVUvenNCNUdRaFdFWURvWVY1UWgzNDBqdElmeHJSY3J0WWFvc1F4UVZr?=
 =?utf-8?B?U0dHSEdLTSsvUm5TaG92Nk8xSXphOTU4N213eCtSd2Y4Nk45cld4S3YvRE9E?=
 =?utf-8?B?YjVMbWV5VG5kZFZCemNtYkpDWCsvaDFicFpDdTJISng5Ui8zcVpiNkJJTWY4?=
 =?utf-8?B?eVA5V2p4TS9ZOCt2TlJML2M5MlBFSStTNmk0WFJ5eGhSSENOdDNjOUN1ZGJk?=
 =?utf-8?B?L2RQeVU0a2Y5OW0zMFU2ZkJOc3Q2bUs1S2VzVTNqaklKTmkxZVpYc3ZoZVNk?=
 =?utf-8?B?eloyRTZCbzNqckRXZHg5Y0dYVGJ4YnczTUt2QVVyL0tYWjFzRUF3SFhDTXFF?=
 =?utf-8?B?TzZYSGZxRmNCSTl0TENzS3k2Ly9lVDdrQWJvNlZjMW9hbmVXK3hBZG1Eello?=
 =?utf-8?B?VklyeFNjQTJxSFJoRXRLRjNIQ2IycUJtTEZDVHZHV3pXbXdhdEFWM05zNHE4?=
 =?utf-8?B?NmVGTTllSGEySHZMNkFhTEVETkN5R3R0b2o0SkhBVGU1K1pZQUp5SXFCaUE0?=
 =?utf-8?B?TDZNNDRoNy9CMHRyYTYzZllnS2tBL3hCOEcrajJlN0cyT2MvckI4d1c2Mytt?=
 =?utf-8?B?VzFnZXlpN0dxV0NEVTQyK2ZoeEJlL2tMSzVWd1JqL0tCY245ZDlyZWcvb0Iz?=
 =?utf-8?B?YTF1Z1FLOW80eHlLZFhFM21Oc0hSRkJ1c0d1K29WTEVud2dnbmJJWU1XeCtJ?=
 =?utf-8?B?VVFJYUlZOVJHTnVDdnRxeVhSdEk3VDlyL0tjV0E1UVdYNzFveWFUSTh5UDFw?=
 =?utf-8?B?SWdybVBKcVduc1NMREplQ2EwV01vQTN3TjMzM0dpYWVaVm5hZXQ3ZGRGcUNr?=
 =?utf-8?B?MXhHV1RFVENVT1hrZ2R6aXdNalVwcUM3ckplRHpLd2NqZk9ucCtacVBSOHFr?=
 =?utf-8?B?UFRaRXdiS3BSRnlkTkpVajR1cXROVTVYayt2ZjFPS1lRUUsvanJsV29pVzI1?=
 =?utf-8?B?TGdpTUEycXhCSElFb0FNRXJFbEJYT1RNVURRYU14SS9hSTl1TkM5aVFzdldW?=
 =?utf-8?B?R2NRSEFYZlhSRnZDZ0Qvem5lRVUwSEdyZS9iOHFmMU1RZzYxNUoxNk5DWUxZ?=
 =?utf-8?B?M1dJd3ZMYnVqL1N6ZysxYyt4UjJJNzRIbWYrZDNDVlBZS0xKUGQrbTE0WFI5?=
 =?utf-8?B?YlMraERUTnROcHhHNjNlM0R4cFRpN1BkRURMSEs3M2lzUWxKREdWUmpDdWZG?=
 =?utf-8?B?Z0xPVmNRVEpOVXQrZEQ1MUljU2JxdnFSV0NxV3A5dHloNXdnbmJ1VXN6RVJx?=
 =?utf-8?B?N2Zmc0R1TXdTU0JyaTU5N0VGS29XOWlLTUFmclRxVXRJVGNkZ0lnYVJ0NlNT?=
 =?utf-8?B?bjFiSSs4a2hqSDY4Qno1azA5SHloamxoeHYzRXFydk5wSmZKWHRrR2hHZE9P?=
 =?utf-8?B?VklJb2lkMFBPNFRXVGZWTEJPTldUeTM4clFmUDJTOVFlemlRR0oxWUVJUE8y?=
 =?utf-8?B?OGNXNlNwNWxVVHdUQUFpWVg4M3NRTlBwblZzRkNCMmhXa2IzZURtUEZaK1c2?=
 =?utf-8?B?cGRRQ01VcmF5aCt6akl3UG5LYzM5MlFUdUlhRFRvTTF5cVhROFVmd0ZDRDZa?=
 =?utf-8?B?QkIrbld1SW1OTDQ1ZjBzVTk5cERwYmFSa2pBYjNxeWZ0WE5ReENBNUFQNkJm?=
 =?utf-8?B?Z2FZUU11aW1xTFJTMlF5VVd1cnF6bGZ1dUg2SkJCem1relVJQnJ1Zm1nSHMr?=
 =?utf-8?B?VlpHdVIwaUN0a00xV3Z6UWdGZ3o2RlRvb00xWmRCcXdaSUxEcUpNTERHTGpr?=
 =?utf-8?B?QjYvb25rTGJyQWVSWHk2VnZKVzFvZ2FSWFZrUDV3TWpjd0lJa3I4QktnSmQ2?=
 =?utf-8?B?RkVOS3MzZTB4ekhHOG1ybWhBNlVmeTZjN0gzTjlUZTl4cTA1TEJWVUVYeDdP?=
 =?utf-8?B?bmlWS2didVJPSmlVZEFzTndvZ2RFUXRqQmZWN2lzdUZWTTExb0pSYTQ2QXMz?=
 =?utf-8?B?dzNEbHdwOTNaUlRveUZERGxCdHptMlZ3UTl3ck9ORjRWUnovKzJQNVJCVlkw?=
 =?utf-8?B?T1lINDJpZzQ2cE1uRXcyOWZ1QnFMZk9SZjQyd2dvYjFpR2RhUzlSSmhTVHhY?=
 =?utf-8?B?ZzBLZzZMUS90OEhrVVhMNndTamppeFYwbk4zSlNLL1l3SWpPZkc0M3dob2pi?=
 =?utf-8?B?UDJoaGdRVkQzaHhwNWl2QmlsNThXYlc5OUdKeXdabFBFY2tjbVZZVkU4bHF1?=
 =?utf-8?B?R1BpZUJDZE1CSGpYTHJWd1pmMWs5YkRmOGdsVFJNdUpmTFJ5YmpSUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca6a8e-59c0-4345-017e-08df02785447
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:13:14.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC5UBmAJjCsfWxcYVQqSh8JeXDZjpeCW5qH8CK2A9d/7YKHCuNRg1lxFmurfrG7WhjAVefGahj3tqD0flDc3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
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

On 2026-08-25 at 05:24 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> On Mon Aug 24, 2026 at 4:49 PM CEST, M Henning wrote:
> > On Tue, Aug 11, 2026 at 1:12 AM Alistair Popple <apopple@nvidia.com> wrote:
> >> +/*
> >> + * Opaque chipids. These may be used to determine what chip a particular GPU is
> >> + * based on the identifier but the values themselves should not be assumed to
> >> + * carry any particular meaning.
> >> + */
> >
> > You say this is opaque, but the userspace MR you posted already treats
> > the values as non-opaque in eg. sm_for_chipset.
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43352/diffs?commit_id=945a8e7c51939577526974b342c8dc6bafc3372f
> > So, I guess my question is, is is opaque or not?
> 
> The PR is outdated and goes back to the first version of this patch series;
> what's written here is correct.

Right - I was holding off on updating the PR until we'd settled on the UAPI
here.

> > I don't see much of a reason to make it opaque since the chipset has
> > had the same structure on the hardware level for 30 years, so I don't
> > expect it to change too often. Truly treating this as opaque would
> > likely require a small refactor on the userspace side without much
> > value. (I realize this has already been discussed a bit on the
> > previous version.)
> 
> I don't see much value in having userspace decode this value (again) after the
> kernel did it already and can easily provide the required information without
> making userspace commit to some encoding in the hardware (even though I do agree
> that it is unlikely).
> 
> OTH, the way chip IDs are derived has changed over the years (BOOT_0 / BOOT_42
> with different register layouts), and I'd rather not have userspace commit to
> any particular encoding when the kernel already provides the decoded
> information.
> 
> Regarding the refactor in mesa, the Nova uAPI won't follow nouveau anyway, so I
> don't want to limit ourselfs here.

I'm not particularly wedded to either approach but I think the approach is
either:

1) Keep the chip_id opaque, user-space looks up arch/implementation/etc. from a
   lookup table as required.

2) Keep the current scheme of just exposing the chip_id and letting user-space
   decode it assuming the register layout won't change.

In either case user-space needs to figure out arch/implementation/etc.

For (1) the kernel should not be responsible for decoding arch because if you're
assuming the register layout can change arbitrarily then the it can't reliably
figure out the arch anyway. For example if someone plugs a shiny new card with
a different chip_id register layout into a machine running an older kernel they
could get an incorrect arch which would be confusing. Users would get upset if
for example ShinyNewCard got reported as being Turing say.

So I think it makes sense to keep this decoding in user-space regardless of
whether that's exposed via documented opaque chip IDs and lookup tables for
arch/implementation or by a commitment to keep the chip ID register layout the
same.

Either of 1 or 2 seems fine to me.

 - Alistair
