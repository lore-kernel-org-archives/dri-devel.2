Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C0C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F47110E1B0;
	Mon, 10 Aug 2026 06:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rs6NR5aR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A4110E1B0;
 Mon, 10 Aug 2026 06:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBdppuEmliU0d5EzB7WmyKgoQQcrXX4S+NzIigwduVelnZw3b1kcKzXQnQK7eJkwruJvPOkulgSbE0zIK7kbQ2K4A5OLADmMQ9LI5u9LNn+wImztofI2njmNvGW7e6RDRyccpMJyEKlhlgS0YaLyv714MmbGaLLWTJefijDtb+awaPOvQqOdmCgKk0APtSU+yzZGI4UW2XK9inxkbIPifR4yTw4L4fWhrsP6ks5ZMa3i5cbEcM0akhHbBfZxkmFtKki7tT5Ui9cmZj6kIagbI40Zbtj8JOMTitd5FG8UwZfNILESrHW6jZ6ATL7MZ62otZIIOhPh9miimsZ6b2CWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79XUjPTYJf3TDuof6wymT16WUoT6V4csuyE3pjqN6rs=;
 b=C/BGxT6rmkRQSrNs+oQxdWSXzw5o9f3ah7da63HC6KIqJ1XASdOMTqkfuZw2rCrp6fBsY1iGy5cxVcG2VBXn/O0Z3y3gPqRb30l6bGMrRFknKiSUtirCK3rk6nB+UDRN8Ek08O8ZAXaXSGnSLczIrxuGsDbDMEYjqE1kaSvHYC0RumlzCgyw75Z5aofRWM6DSALtsyCfOEe7bggFZNmDhna1pIWIuBGuprSLyaY2LBhNMt3FYAopenFlsoNEGb6ceJsfzf+HULAYPGw5nYI/ZLEZ7RlWbDdm/su+4gJuzA7JP8DUg6MHPgc20YiD5M3A5v+nGQ2TPRAywa2vkaCVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79XUjPTYJf3TDuof6wymT16WUoT6V4csuyE3pjqN6rs=;
 b=Rs6NR5aRuinXQo/rV3za9OL6TXsMcq2BRh+LvCttwHPXfGFs/N8hkNXn0Hva58ql2G7+7h10zexGkm31oi9R2aD6HjweKLb3Z7tEDJIdrM7b3QKMPv7SIuBL94Sl9d7gt6HnojR5JH1m1xEH+ZMvruI0u4g6brYahww1cBDiEqLfRr5wiwY7/UlN108ShkV8J49VF8hg6k1LD/tcnPQL4segCVU0g0qNxtPMMa9E7bo9Yxmo5zxuiQPeZ9Bt4zoYxrysoMImn3WsbC9aZ7+PmlqNSyZf8FduEtafTnCH+C7BH4hUic6A0x2vGZTJpWGXww2wGO8hKUWZL5WKBU1rZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 06:32:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 06:32:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 15:32:13 +0900
Message-Id: <DKL1XM6HGRMS.272K41SKJJB2Z@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 01/12] rust: io: add Region::try_subregion
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
 <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
In-Reply-To: <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 0122d29e-d148-47a1-c775-08def6a91f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|18002099003|22082099003|5023799004|56012099006|11063799006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: bV/eWcUrVxs4OZv9yhcGutfaun2y6JN7ckmF7Ozzp4Zwd5vB8Jp6GoCWkb3YLb99QxP35UnM97Q59JIA5NdMqqEDmH3KqeltunZkeJOr5/pknjwrlhlxKNZfTXxH0qUZRPh4IRB3WtgbMF2HatL8xTCqCTDIHDfbut2wEhkmUTQgi9WZv6tZ3LshLJnGgeybxdC0v6x9RfA/9v5rcYdTuaXfrYD0IC+b4K8eKrVmkd/NHHci3wXRP2nsJ8dJMvPZK4Hlo5RBLYh7DYDZ0E98zHbFm2Gc7IfZnKVf8KvfIiRQFNlBO/ucyjv0OX30F8zLQLX8T8W/0P4Vu1317wVWE2MdtCA6QbjZi/b5hZ659JjNTInfy+D4aHfZI590pepriuqp/+pHzmiTpoOqRsRu+UDIo4p900o7jNpan2l3yUdIwh88TWpoU9cGHwKil18zg7uhq2La8t/WdD+Bc605fgvjPR+bg8DvjD4RloBOAaEWHxKRAZt7MyYQfl8hbZ3Xw46ZB1MG8BfSAADz1W6cDqCiTSEghVnnlFgzKyjrunPUrbJXbNMyISDYYIq0echbFPHbG2qzHhiSKFjPM1VtOwj6ZACZZ/yQgfVL/o8jKqMF8v2Emq+9+YeX3dJ5zsowe35ShS9DoNbC2VbTljf8Mt5r6HZB2wO9kCq/MRSl2k3GxMIWxkvUbvN+oFSKXHwq6lYS2gFkZLSidyqja5QHcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlIOWUyRTBrdXJXQndwb3JHeTJ1UVQ4OHEwVWRSZys4TklLb2JQNllYTEtl?=
 =?utf-8?B?aFlyRDZsUTFQMm1jVmVxNndRRWlXeTJlWWNONHJwR2tkNUd4NFJycG4yQ3dY?=
 =?utf-8?B?L3VSUDdEZXZJVTh5a0lSYUZFL0EwM3VsVXQ1S0Rid3UzVjZnbmRIbWlKeTIw?=
 =?utf-8?B?ejVQdjVraDYyL0owYktDSDNxcFFHRGtlUEl1YWozRlNGSWRxU0h0SUhGZHh4?=
 =?utf-8?B?Nk1pVlBOM0MyaVE4ZGVaMlNGTkJpNHU5czJyU2JJZ2VwRXlYK1UrVEl0VmtC?=
 =?utf-8?B?a2pxWUFYTk5CazlkbnRMYitNK0VHeUtGdExsYndTQkJJalZ0N3l6VDhHenlx?=
 =?utf-8?B?a3YxK3FuWmN4N1ljclRUaERCbndnZUVZWEFzNVdZUlhyR2liRlhuR0lZN1JY?=
 =?utf-8?B?M2tNUHEwQzhqQ0F5N2RIdm81QzBXWXVuMVdRdDYzSFFHOWdzY2phdDY0MVFN?=
 =?utf-8?B?QkZnR0xLY2R0U3gzR3AyRU10ZEF5OGVsdzYyK3JMNU9MN3B2cEpycW9uL2d2?=
 =?utf-8?B?cVF5djc1MDNsbm1LVlBXcFhMSkFuTVdaOGJFUWd4eXJ0b0F3bkdJMlJYMGt5?=
 =?utf-8?B?WDJYMGVpS2kyRS9KOTB5VFJCMGIzb3NVR1hnUU4zbDBJVEpiTEVjaDc4UTBt?=
 =?utf-8?B?TXZtWUk3Rm9SWE9mMHlvTlc4MWRia1QySUtmSDhpdWZPZUxHTitNb0t6dWcz?=
 =?utf-8?B?Y3UrdXo2bFRGUzMxR3NaVzY1NWJqM1lJL2Rzc043TG5vaUJLVDUwRHFVamdu?=
 =?utf-8?B?RWNSdkdXN3ZZOUN0Y0hpbGxNT250YkRDSDZqQk42dFRUTDlxbmdyaGdhQWRX?=
 =?utf-8?B?VTBheTNUM0JFNDdKajFVM2hoTTNzMi9DT1YxVjRkZUNhNFlaR2tMMHkrcVNz?=
 =?utf-8?B?aFRTSStDUVBWL0JhaWJDajB1N3dCWkNDVGZsUngzcFdpd1R0UTNCTGRHYUhL?=
 =?utf-8?B?RExmOWFmallVMGpYZVAxR0owakZRV1J1QXkzTGo1K2VFRXRNd0wxb2NBdEJO?=
 =?utf-8?B?TThNeWFpVzBuWmQ2eUc0M0puQlQwRkxVNDhrUGkrdER4YnQ3VWN2Y3pDcENq?=
 =?utf-8?B?Rmgxc3ZaekRGNW56ZC9TRWdOSVB6RDNHa0syT3ZKOW1PdHA1UW95eUxhMGRo?=
 =?utf-8?B?b1dDTkxGekl1YjVDV01WZUQxczR4WVhVREhLOSttZlFMVFRTVTRYazdldldk?=
 =?utf-8?B?NkVkWFllcXV4R095Y2F3WENLa2pyN0t0dERrY2pvZlNHQ2FnVXdidUJ2R1NZ?=
 =?utf-8?B?ZDNSREgzVWczcC9wMjV2TlJ4NXh3NkE5OGozdFY5SVdTdUlMMVMrSUZlOTVw?=
 =?utf-8?B?bldUWDh6dzBsdzJ2OVJ0cHJSeHNoOC9oSjBxbG5tVnJEKzNRcGs5L0JuRWJC?=
 =?utf-8?B?T2JHd0J0ODJneEYyZm8zVlJLSlNkRCt4QStRRnBhY3c1eWM4STNFVjlNczNZ?=
 =?utf-8?B?ZTRMR0k4dmZJLzFmalIwb2Rwb1JacEtqOFNyRmY2Z05UV290ellPelNRWllG?=
 =?utf-8?B?RHFMUGwxNlR6bWxBRExqMG1MY1BWWE5MdFJkTUFab3VadHQ4dEhWZHdPQVpU?=
 =?utf-8?B?dkNldlFPZmVuaHNBN2JXcVIrNjRMakpqaUtlUUxRcUhQVDZ3cjIrOXdzOFdm?=
 =?utf-8?B?R1ZySHFyK2pseGJxVVpvVjVoY0FLNmRtZlRXdkpsb3dLbmE3a2xnUWZZdmp1?=
 =?utf-8?B?SGVpblFxYjhaNDZvNFBpcDF1V3RDZ0FGMkRoYmExQms0WWFVZzhQUnEwcTlY?=
 =?utf-8?B?OXV1NW9BZHliUmNJakZuYjdiMVhzQkJLcElFS0lRYkQ3VjdNeFR3NGRrc3Zy?=
 =?utf-8?B?eEJrWk1mTlVpd3o0dkFNZE1jbGdGRmhYL3lreHFtYy81SjRJdllqWS9hNVdt?=
 =?utf-8?B?Ty9ORVpKY1ZwNFZ4eDN0d3ovb2hKUnVtbHlibG5GdXFyYjdyKzRUOGhSYjN0?=
 =?utf-8?B?aDBRRWR6Nlgxc2hpMXFwZ0JyOVdqTjMwTTNtWWRsOHdyNDk1QWs5cGJRZms5?=
 =?utf-8?B?RlN5alBtN1N0OWorMmFuMGJSNEx1Kytxb3V6aFpCQnlYajFVMndieGdaTnI4?=
 =?utf-8?B?cjd4SUZkaDQrWGZQdy9QQVMvaXVUaklrOSt6U1daL0pOSFJkV3dxWVc3MERF?=
 =?utf-8?B?T0lwejMwSnIzODR6UmlzTjBOc0lLMHFNZFRQVEtZNDFza1R5WTFrNVVZdGFL?=
 =?utf-8?B?U1VrYWNaLzN3OVBlSVR2VDJGR0x2Zk1Edm5xajJvYXZ0VEdaWVgxeUtxYnZ6?=
 =?utf-8?B?aTBPLzRhaVVPMTdYT3ZoQ0gxcjNWUExoOXl6SHQ0MmZFYjJmY0RRajg0ZVNI?=
 =?utf-8?B?MkVKRGIra1gvbFdvVUlJS0QveEVCRUloRUl4RXk3Y3dJWHZwNHI2OWdsMGFM?=
 =?utf-8?Q?leKwZOaxdzLDuHktj5jrwtGIKuKzHim/DgIYgKI7PCZXS?=
X-MS-Exchange-AntiSpam-MessageData-1: SRiIzr11jpIUqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0122d29e-d148-47a1-c775-08def6a91f1f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 06:32:16.7376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mhDRY2/zp2nB1OvN+OckUSB4UjOJiRQBBWEjGQNxQeOQ9h3mny7dRC4a2/l7uAr7MBtJC1LIme+c+NtjR4b3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

On Wed Aug 5, 2026 at 7:43 PM JST, Gary Guo wrote:
> On Wed Aug 5, 2026 at 6:44 AM BST, Eliot Courtney wrote:
>> Add a helper to get a subregion of an IO view fallibly.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> Looks like the case where you need this don't actually require a `Region`
> (dynamically sized type) but rather a fixed size window?
>
> In that case the next version of
> https://lore.kernel.org/rust-for-linux/20260721-typed_register-v1-0-452d7=
2b60262@garyguo.net/
> will contain what you need.
>
> Best,
> Gary

Thanks! I updated the code to use your v2 of that. To support the
runtime offset I ended up having to use OffsetLoc which you have as
#[doc(hidden)]. I will send the respin shortly.
