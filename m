Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACD9C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F2A10E321;
	Mon,  6 Jul 2026 10:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JE58oqb9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156A410E321;
 Mon,  6 Jul 2026 10:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVUMqRrKAVpwk01IePlGs7O1jbz13XaS1J3QXe9680i+08dj6o+/DFzW9pvhnLqvFp0Jy8CkCjVYsQM+jYTNegCBFnMk7n28Dlsx5VVYQH+4SEsBMIQMrEgEt7pAc28K4pr+YGxWO5ORe+luD4FwpqQwxPBRH7lprrWr0dWxFVMzLTSeAiwqpCGL/PBUIQeNkGYBCb6yZBkb7ODSYiCV8pyHVGdB6ItlMVJwdX5hpjl9hnLhoda430QZl/qr0Nz//ptt5ENjaqDg4cawnlzp8x378kj09Wy0pAKym5eiV9h6id4o4oAUd6wKCUj+QnxBlMW3nYyO9HRB2I6omtKoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VYzGZVf4pmEcMCHGYyiM4ZCcmkPBfGc0Uv5XFIepNo=;
 b=ApRMTklJoeUfhpFq7nC0X2E68E2pxQHQLpO9k1ZEA6QR8M5/NfFtFFwg1GUTz9Ni3Cpt+o17ZQtUkSmP1cmFAVX/xci2lfj71gXZ5uiMx1vimX7iojAImpIYRuO+KZFbTGYegDnDJ1Jgf/H+3RoyGkGGyLWp1l8N6L19yAbniDlqAkbu3N4lEK9hHq6g50nQliBZJ/rHp7cdubCmmu97RKkt5eIIjTVv0Cp7dVX4yyjwoYQzHdUFwZixceZ2bWkb5JXE3zYf0REfI+dSBCLRHrNYWqSeigwPGKT48d/qbYcUM2DrRGBA/BlCfDIStWJUEalea6KTiD2T1FL9wVhQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VYzGZVf4pmEcMCHGYyiM4ZCcmkPBfGc0Uv5XFIepNo=;
 b=JE58oqb9MbS7GY57iBLgXYVxY9p5MY2R/ygUhptTWo+WjHGaU55Sx046ASJPJ88X3Mn6ER478YrECplJAlKNqUzhaSIe01hNrFvu6jvQGpC/sNOiKaHg7Tdef85qB3TEgGNvWSHrAL+vBjkSSydnlRx+FziPO+41RKTay1CvTO+0vCO1AjpsMPyZk5k8rr0zK+3D3Z3e7LKPkueJn48z9jQumW4k0YRdUO33fRAx2w6WPLQoTgiuA14T8iOPHBc9HkP70qjlUwCP/PyBTeAvxsJp5NSHjx6AlndDwKBLhvE/l7vyb/xX1XZWyEYfstFRpdm7QU4KaTQD9+OsslAcEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Mon, 6 Jul
 2026 10:00:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 10:00:10 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 19:00:06 +0900
Message-Id: <DJREFPO8SX72.396438M8Y4BJ7@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 03/13] gpu: nova-core: gsp: replace BootUnloadGuard
 with local handlers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-3-5539d8469590@nvidia.com>
 <DJMW95MDK2J2.1MWRD8I92FKW5@nvidia.com>
In-Reply-To: <DJMW95MDK2J2.1MWRD8I92FKW5@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:604:24::18) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4219:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a311610-51d7-47e7-f34b-08dedb455d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|10070799003|376014|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SNsfb8DudmcVQ+j7jhdBcBaTtFBw2TY9pZOZ2UeyUxBOZF0xc7vxap3nXkEhalONuOTKI4axGDccsIqu3aKxkSRarCMK21t5WPmeAmoo52bkmtusXRqbxKDOw9uEoHQ66SUel54zIKjw0RuLxyruyO1l52SxJgTEexn0OWZLpGZlWyTX0PfjJRfADs67ElS0SsBflnLZS5dHyZByamXp1d+6T5UEbx0XppHTM5+dCMY00vXf1DERZAt4PmqcQq2MqA5i2DSfz2UVKw4KXxY9yuhr54mfLSnGJz7qnJa3lHClz14aBJHbON6UwUXjkQUcQkxs3LBzTOXEWPxhz1yjnPjT5ns/bL1fFklZ/j65BqR48CxLhA6cSVvGyACWcVWkc74P1JGaJ67N814LcTh1GhYDRht03oNCFmyi1cIDj7LHqlvgjvhqZQ3LOXJgdm4OgLnB38AKg1JqPnNollTSy6O9FcwgQCo/qX+5DeSD4qmA3QaeK3aHWmf29QkFI2kZnkLPQrpIeGUC8ZDTPTZwmDvY7HqJDnWuWj6Z+qUz6KNoVn1onu5BCdGlEZ15XuJ77ImA4eXAXYJNzdDuIGcatPBHBFGHLE/Wc24shcu3/hvOfGZWR3tXkKBV8P9cC8Os6/8xM0wKre8WcJMLpHt8wpdAczTYqPGrOSXEm5l75hM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(10070799003)(376014)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJqeGFnUC9LSVorWUZ6OGtvenVoUU1ja0RMWm9LVDhWdVJTZ1hqZmF4bUZi?=
 =?utf-8?B?bzhuZjVoMXJhYThYOHpLSk1ZSzNVRUNJZnVOZ3F3c1ZJUWl6M3hiY013WWd1?=
 =?utf-8?B?YnlwejBORGZWaWhTeDQ5QkxaSU1wSkY5QmFuVUdveFFOZU1LSUxVR0hDNFlm?=
 =?utf-8?B?K29xb2dKQUo5NndiUm0vV2xrYmZNbEZvVnNoYy9vSDhReE10RjFsUWsySWFI?=
 =?utf-8?B?RVVqcVYxZWVmaXU4eUJ3V2VsdWR3UWk3M296cjAwNUNQbWM4NlZZUHQ3OVdx?=
 =?utf-8?B?MmE2Ri9ka0xUUUcwQStwL2FJMFV3S2FOUTBEeDg2enVlc25IZkpuNXpKdmJD?=
 =?utf-8?B?QmNPTHZuRDU3Mk5QUFNQcEg3cXY1T1hoVXNZYlUwYWpBUCtXZWtQVWtjU3hr?=
 =?utf-8?B?Ry9vMktCeGhmTG92TXpHT1RBT1pNSXNKU0FJOVc2OEZOdnpDMld6bTFEa21T?=
 =?utf-8?B?Zm95d2hIOEo3dWJtay9Eem9tV0NrSHhkSEtvWWQ5enlYSnczY3RDS1kxVUtR?=
 =?utf-8?B?UEgwMGpaN0I1UUpDaWRMaVNsZUFWYVhKZDV5VWZlbkVtRGlpMnBpdWgyY0cv?=
 =?utf-8?B?d2t5ZHllUFVQaW51QU9TSjdzZ05aWWFwdWptcUM1aXFiUm9MdnBFYlkyS0R5?=
 =?utf-8?B?bVIxWEdWSW51NjY3U0xyVERSbk9QMWJFcU1waWM2ckdHc2hvYWtmbFdRRTc5?=
 =?utf-8?B?VlR1M2NaZS8wemNpN3Y5cWYzMXBuUlMxaml5UE1Ud2NRNmkwZnZWblZibDlW?=
 =?utf-8?B?VWg4WTduMmFDNHY5WVl1THM3RFV4TGluOFpEdVAxdDUxakNTaWxtMVdnb24y?=
 =?utf-8?B?bTloOW1oREVyQ2trYlhUMXp3MmZubSs0VHhqckNxNmhhZ0x4OGNRYjVQWXNH?=
 =?utf-8?B?ZElWTVVtbDNkc0crVVFmdFlPNmZEUFdnbE91WkgzZ2h4YTVFUWFKU2VYNEVt?=
 =?utf-8?B?NmtJNXI5ODl4S1JVaVdLYkhUODUrZW9qZ2VuWXBDYmpkZDFOKzdnc0lhaTBj?=
 =?utf-8?B?ajlDZml5a1B0TWUzOWZYYWRnV1VaSVdsTGJNUjlWZ1pWclF2WEl1bDZsSmNw?=
 =?utf-8?B?MWM4MEdVZWd6VE1pSWxaUDZ0L0U1Y1F4RGorejliMGQ4dkVjUk9pazdNb054?=
 =?utf-8?B?NXNlMTdtZjdYcjhoTUtXRWp6dnllZU1FcGYyTkE4bC8zY2l0M0U3UldFSFF1?=
 =?utf-8?B?Tk1MR3lTZm51Y0MrczJ3OHhUeHRVRVdzdjRZOHhKVkRYcmhvbEFxeVAySjY3?=
 =?utf-8?B?aUY5WXdhSVFyblZUZHk3dEwwT0hTYXlIK1gyWitKeG9XV3ZOT0hqUDBDS0tJ?=
 =?utf-8?B?WnFkVUZvWGRvc3JvMVBCODFHay81dEFKQXc3R0JhS3JLNnZ1ZU5WNDFFSzhC?=
 =?utf-8?B?QTlpUDNrODRldm1mUEJQYS9oa3Q2UVZTWDVLSitaV1lwTW5zVkxWdHFyd0t3?=
 =?utf-8?B?YXRHZ3pvd3prS0RzZWhSWEwxSHV1OHIzbVgwbUhRSGNPcmhvS3NidmY3VUs4?=
 =?utf-8?B?YlZpV3p0VXFMLzgyTEVaOWx6bGN4bTE5V1AvNzNqRFZta0FWVmxiTHlBQms4?=
 =?utf-8?B?OEd3K1hDQmtHWlBjQXlrSDhSajNHQ1lCWGZMaXVSUkNXRTV1Z1Nad1g3ODJS?=
 =?utf-8?B?aEhaQy85ZlNPU3hQcDBjZWF4VWtlWlJuMmUwQzJjRjEzNzRQWXd2YTFWaTAx?=
 =?utf-8?B?eHA2a3psemF6dEtNZ0ZpZmZBc2djd0d4anZIejJTNEhLSnlMYTBvKzVCN0hr?=
 =?utf-8?B?SkNmTVVhKzFKNGFKM0p5NDVuOWIwT2FmeWlLb3dMMXlhL3UzVCtvMlhmODdp?=
 =?utf-8?B?SWozZDMya3ZKdm1EMG5mY2J6Tjd4R3dYVFI2YldyYkt0MjYwQk5kUkhmNWU1?=
 =?utf-8?B?VldLdkZTd1k0OHBDTUdabTZPTHgrYmV0dUxsYStjdklSOG92UjJYdUNhbzFD?=
 =?utf-8?B?a2lGM2pETklrRURHRTNFallhdW54T3lwMFF2UHZ0TkYvZUkyenRqdUFGcUhH?=
 =?utf-8?B?M0NsVDB5VlRCSXlPd2w5VXB4UzQxaXRhQWVzWjJYL09MbHpNVXl4ODRTd0gv?=
 =?utf-8?B?VGlMeWpJS2VXWXNXOWdyTis0a0YwNkxMWTdlM210MVNtaGxEYXVEMWJnZ09Y?=
 =?utf-8?B?R2tsNWI1RlFjVmNkeWhodC9GOVFLNUNnZFNxcldXMXdFbmRQMm0yQ25pLzVS?=
 =?utf-8?B?MkNNQURsczc2QWJMeFkvZmxDejFOU1ZrRmd4cXk0WXlDRUIwOWFNdnpwRDYr?=
 =?utf-8?B?dG4wanNnMFBacnpVYnhLbHRqb2h4ajdSRWxFMHZyNVlPbU5Ec0MxWldZRnly?=
 =?utf-8?B?cEZXRXg4N3RyQXd0QzhZcGt0QWhJVEJkekpaSWNERWswclBYazk5MHRUcjFU?=
 =?utf-8?Q?J2KmzI5eAMeZuvDgEAZCr91RW+SGOqsighaY5qviz16ej?=
X-MS-Exchange-AntiSpam-MessageData-1: pDEY6awOYlw9pw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a311610-51d7-47e7-f34b-08dedb455d7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 10:00:10.7943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnlBdmpsSfB0yC3HrtPJ4iKCEi7cFC/E7mK7STOE75AiSm9TTtWz3cz5uSwIo4GBqtTLzB72oeZ7QGopoXK4Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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

On Wed Jul 1, 2026 at 11:54 AM JST, Eliot Courtney wrote:
> On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
>> When adding the GSP unload capability, we introduced `BootUnloadGuard`
>> to automatically call `Gsp::unload` whenever an error occurred during
>> the boot process, in order to try to reset the GSP to a valid state.
>>
>> This approach is not well-suited to the errors that may occur in HALs:
>> by definition, an error occurring in the HAL means that the GSP is not
>> booted; yet the first thing that `Gsp::unload` does is queue a shutdown
>> message to the GSP, which will inevitably result in a timeout when done
>> from a HAL.
>>
>> Furthermore, `BootUnloadGuard` is problematic because it holds
>> additional references to the boot context, notably the `Falcon`s. These
>> extra references stand in the way of making some of the `Falcon`'s
>> methods mutable, since those methods would require exclusive access. As
>> this behavior is only needed in one place, introducing dedicated types
>> for it is distracting and unnecessary.
>>
>> Thus, remove `BootUnloadGuard` and adopt a two-level error handling
>> strategy:
>>
>> - HALs are free to handle their errors as they see fit (most likely, by
>>   running their unload bundle if it is ready by the time of the error),
>> - `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
>>   GSP should be up and running by the time `GspHal::boot` has returned.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/boot.rs      | 67 +++------------------------=
-------
>>  drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
>>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++------
>>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
>>  4 files changed, 33 insertions(+), 90 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/g=
sp/boot.rs
>> index ab0491b57944..536f2e341c01 100644
>> --- a/drivers/gpu/nova-core/gsp/boot.rs
>> +++ b/drivers/gpu/nova-core/gsp/boot.rs
>> @@ -30,66 +30,6 @@
>>      },
>>  };
>> =20
>> -/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
>> -///
>> -/// Stored as their own type to avoid repeating a long and tedious list=
 in [`BootUnloadGuard`].
>> -pub(super) struct BootUnloadArgs<'a> {
>> -    gsp: &'a super::Gsp,
>> -    dev: &'a device::Device<device::Bound>,
>> -    bar: Bar0<'a>,
>> -    gsp_falcon: &'a Falcon<'a, Gsp>,
>> -    sec2_falcon: &'a Falcon<'a, Sec2>,
>> -    unload_bundle: Option<super::UnloadBundle>,
>> -}
>> -
>> -/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
>> -/// [`UnloadBundle`](super::UnloadBundle) when dropped.
>> -///
>> -/// Used to ensure the `UnloadBundle` is run during failure paths.
>> -pub(super) struct BootUnloadGuard<'a> {
>> -    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
>> -}
>> -
>> -impl<'a> BootUnloadGuard<'a> {
>> -    /// Wraps `unload_bundle` into a guard that executes it when droppe=
d.
>> -    pub(super) fn new(
>> -        gsp: &'a super::Gsp,
>> -        dev: &'a device::Device<device::Bound>,
>> -        bar: Bar0<'a>,
>> -        gsp_falcon: &'a Falcon<'a, Gsp>,
>> -        sec2_falcon: &'a Falcon<'a, Sec2>,
>> -        unload_bundle: Option<super::UnloadBundle>,
>> -    ) -> Self {
>> -        Self {
>> -            guard: ScopeGuard::new_with_data(
>> -                BootUnloadArgs {
>> -                    gsp,
>> -                    dev,
>> -                    bar,
>> -                    gsp_falcon,
>> -                    sec2_falcon,
>> -                    unload_bundle,
>> -                },
>> -                |args| {
>> -                    let _ =3D super::Gsp::unload(
>> -                        args.gsp,
>> -                        args.dev,
>> -                        args.bar,
>> -                        args.gsp_falcon,
>> -                        args.sec2_falcon,
>> -                        args.unload_bundle,
>> -                    );
>> -                },
>> -            ),
>> -        }
>> -    }
>> -
>> -    /// Disarms the guard and returns the [`UnloadBundle`](super::Unloa=
dBundle) it contains.
>> -    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
>> -        self.guard.dismiss().unload_bundle
>> -    }
>> -}
>> -
>>  impl super::Gsp {
>>      /// Attempt to boot the GSP.
>>      ///
>> @@ -107,6 +47,7 @@ pub(crate) fn boot(
>>          let bar =3D ctx.bar;
>>          let chipset =3D ctx.chipset;
>>          let gsp_falcon =3D ctx.gsp_falcon;
>> +        let sec2_falcon =3D ctx.sec2_falcon;
>>          let dev =3D pdev.as_ref();
>>          let hal =3D super::hal::gsp_hal(chipset);
>> =20
>> @@ -118,7 +59,11 @@ pub(crate) fn boot(
>>          let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::=
new(&gsp_fw, &fb_layout))?;
>> =20
>>          // Perform the chipset-specific boot sequence, and retrieve the=
 unload bundle.
>> -        let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_met=
a)?;
>> +        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_me=
ta)?;
>> +
>> +        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |=
unload_bundle| {
>> +            let _ =3D self.unload(dev, bar, gsp_falcon, sec2_falcon, un=
load_bundle);
>> +        });
>> =20
>>          gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
>> =20
>> diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gs=
p/hal.rs
>> index d3e47ef206de..851d1f24c137 100644
>> --- a/drivers/gpu/nova-core/gsp/hal.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal.rs
>> @@ -24,7 +24,6 @@
>>          Chipset, //
>>      },
>>      gsp::{
>> -        boot::BootUnloadGuard,
>>          Gsp,
>>          GspBootContext,
>>          GspFwWprMeta, //
>> @@ -51,15 +50,15 @@ fn run(
>>  pub(super) trait GspHal: Send {
>>      /// Performs the GSP boot process, loading and running the required=
 firmwares as needed.
>>      ///
>> -    /// Upon success, returns a guard that runs the GSP unload sequence=
 if GSP boot does not
>> -    /// complete.
>> -    fn boot<'a>(
>> +    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use w=
ith [`Gsp::unload`], if one
>> +    /// could be created.
>> +    fn boot(
>>          &self,
>> -        gsp: &'a Gsp,
>> -        ctx: &GspBootContext<'a>,
>> +        gsp: &Gsp,
>> +        ctx: &GspBootContext<'_>,
>>          fb_layout: &FbLayout,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>> -    ) -> Result<BootUnloadGuard<'a>>;
>> +    ) -> Result<Option<crate::gsp::UnloadBundle>>;
>> =20
>>      /// Performs HAL-specific post-GSP boot tasks.
>>      ///
>> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-c=
ore/gsp/hal/gh100.rs
>> index 1d06405a32f6..5fe445d73599 100644
>> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
>> @@ -23,7 +23,6 @@
>>          Fsp, //
>>      },
>>      gsp::{
>> -        boot::BootUnloadGuard,
>>          hal::{
>>              GspHal,
>>              UnloadBundle, //
>> @@ -143,27 +142,22 @@ impl GspHal for Gh100 {
>>      ///
>>      /// This path uses FSP to establish a chain of trust and boot GSP-F=
MC. FSP handles
>>      /// the GSP boot internally - no manual GSP reset/boot is needed.
>> -    fn boot<'a>(
>> +    fn boot(
>>          &self,
>> -        gsp: &'a Gsp,
>> -        ctx: &GspBootContext<'a>,
>> +        gsp: &Gsp,
>> +        ctx: &GspBootContext<'_>,
>>          fb_layout: &FbLayout,
>>          wpr_meta: &Coherent<GspFwWprMeta>,
>> -    ) -> Result<BootUnloadGuard<'a>> {
>> +    ) -> Result<Option<crate::gsp::UnloadBundle>> {
>>          let dev =3D ctx.dev();
>>          let bar =3D ctx.bar;
>>          let chipset =3D ctx.chipset;
>>          let gsp_falcon =3D ctx.gsp_falcon;
>> -        let sec2_falcon =3D ctx.sec2_falcon;
>> =20
>>          let unload_bundle =3D crate::gsp::UnloadBundle(
>>              KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadB=
undle>
>>          );
>> =20
>> -        // Wrap the unload bundle into a drop guard so it is automatica=
lly run upon failure.
>> -        let unload_guard =3D
>> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon=
, Some(unload_bundle));
>> -
>>          let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
>> =20
>>          let args =3D FmcBootArgs::new(
>> @@ -174,11 +168,13 @@ fn boot<'a>(
>>              false,
>>          )?;
>> =20
>> -        fsp.boot_fmc(dev, fb_layout, &args)?;
>> +        // Keep the result as we want to wait for lockdown release even=
 in case of error, to make
>> +        // sure `args` is not accessed by the GSP anymore.
>> +        let res =3D fsp.boot_fmc(dev, fb_layout, &args);
>
> In the error case this no longer runs the unload bundle (which waits for
> GSP halt). But, we need to wait for GSP halt to ensure stuff is properly
> torn down (e.g. in [1], not needing to wait on FSP queue is predicated
> on GSP riscv actually halting, to avoid an issue on reprobe, IIUC).
>
> Separately, are you sure that GSP lockdown will release in an error
> case? I'm worried that we'll just timeout here, which while it probably
> works in that it waits long enough, is semantically a bit weird.
>
> What about using a ScopeGuard that runs the unload_bundle? That way we
> will have waited for GSP halt. Later, we could add additional HAL
> specific common code for trying to reset GSP in case it doesn't halt.
> WDYT?
>
> [1]: https://lore.kernel.org/all/DJAZIGJQ72A9.1688NC74RA4SY@nvidia.com/

The problem is that we don't know that either procedure (wait for GSP
halt vs. wait for GSP lockdown release) are correct in the error case. I
settled for GSP lockdown because GSP halt is typically triggered by the
shutdown message being received and acknowledged - but if we fail here,
the GSP is by definition unable to process that message.

I've noticed only now that `wait_for_gsp_lockdown_release` actually
returns when either the lockdown is released, OR an error has been
signaled by GSP-FMC (see `lockdown_released_or_error`). So, we can be
confident that unless something has crashed catastrophically this
should not timeout, and also give us the bound after which the
`FmcBootArgs` is not accessed anymore.

By then, we can also probably expect the GSP to halt cleanly; so we
might indeed wait for the RISC-V core to halt - not to avoid a
use-after-free of `FmcBootArgs` (it's clearly unused by then), but as a
general indicator that the GPU can be reprobed.

So I guess the answer is, we should try and do both? Something like this ma=
ybe:

    let fsp_res =3D fsp.boot_fmc(dev, fb_layout, &args);

    // Wait for GSP-FMC to release the GSP lockdown, indicating that `args`=
 is not accessed anymore.
    let lockdown_res =3D
        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma=
_handle());

    match fsp_res.and(lockdown_res) {
        Ok(()) =3D> Ok(Some(unload_bundle)),
        Err(e) =3D> {
            // Wait for the GSP RISC-V core to halt in case of error.
            let _ =3D unload_bundle.0.run(ctx);
            Err(e)
        }
    }
