Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3218606A330
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Q/g+TLO1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C5210E06A;
	Sat,  7 Nov 2026 13:32:25 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAEC10E06A
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:32:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh+Xd5+dkQvR9uDuvcFzcLAB7WOw2hy5MyVh9/pnfQPve6r0Ip+5/YZOnsHpl7pxS3XEtFUX8Om7cFobuMIBpWqipV6Gy3444IMCMwqBVNUEWjC56EZPul1J3dNil1R5HuB9Z3aE/v9iBAssHPPJEAjYMyxaB2sOFj6TTEjOTZUYjzDdtwxbQpVep1geYuK4JW2CCXP48Bts7mYFJlFnU16TaS2Ng8IagrGQ1rx4A+WQMDkBKS7dKyAbfYRxi/wBCyVGZPzi8qmOgP6gwKKyrDEObciGn9aRkL6NenmnIqs2mdU8+gYMecwjZMNTEfbTmmqq+bBzJMeohy6n3HNbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHpq2iH5h9fZVMTcklv9B970diZbbqkXUi/Y80XyCvU=;
 b=SH2Qp/BQlJFYAP/RpsJi1PM4Btm0ii4h6IFL9oQjRKUacHLpI6VPLksfmqMF1FxL2WZwgJ+QmfveMOuwPvPy20mMJV29LXg9FiTSYTi9YCeMYyMglkRS3cxxrpJJRllMKWTgNyBZ/2XlVJm7m04CCwsKUyAXrdLeSMXZB+y361R8ujyewdDtHZJjWPKAi7aRyW84nrIZsuCP2d/pIupha65luHK/OHLJnUHjyoPnUnxzlh+oPrDX3rK/qaFgc0e1HErSn7ikedlkO7h7C7vNyDqAyyq6F6muVMowrcB/YFGKtXMCgpgZEgQJqFVlNTrSPaXRrIuUif0jakZAZeKUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHpq2iH5h9fZVMTcklv9B970diZbbqkXUi/Y80XyCvU=;
 b=Q/g+TLO1EQMiQtzrZE2tbGOob11ouopVW90Q/XvOQ0EVBc8M+5SS6jGDEyxsT69TkVaeZf2GdqyN6vV1K2HykhUOFVZn5hpM2aTy0ya5Ws/ubgRsE7tRAqGD1IpMHh2yKYy4cjuUFvPM4PC55EL8NQPztubi3QQsaDvve35ceUG2l76HssCse1LAXFUQKN7gAL6hCLIh0iJeBraS4oOleR0tay7RXZuTvfuofWUt1KNQ4Hrd1dO7hYAAd8W7HMr9zELa7sIEiLZh/NBaLBqr3MBHoKIwyYm/PwCG7pLbSoGPxoTYZf1isGOJpsv+E4Ohevs0eQb9iJCtcKZBtYXhRA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 7 Nov
 2026 13:32:15 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 13:32:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 22:32:12 +0900
Message-Id: <DMP0LNXEI7YF.1G8UBZKO2W3U9@nvidia.com>
Cc: "Vladislav Zaharov" <vladazaharova2018@gmail.com>,
 <jhubbard@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] gpu: nova-core: move the debugfs root into the
 module data
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <20261014154554.231015-2-vladazaharova2018@gmail.com>
 <DMOS00OZYWU5.2SUZRN37DEH87@nvidia.com>
 <DMP087IP6EDP.2QB7783SVNV2T@kernel.org>
In-Reply-To: <DMP087IP6EDP.2QB7783SVNV2T@kernel.org>
X-ClientProxiedBy: TY6P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH2PR12MB4135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be42ea3-916d-4c62-1070-08df3cd38929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|1800799024|376014|261028144727099003|261022075727099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|11063799006|10067099003|6133799003|5023799004|4143699003|261102123227099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: pbbmTBhkqCgTUz3BYS7LddE+8zrObZov7nfUNe1oUrxsZ6xLBz8/0cnIk5LbL78HbKzv3L7JsvfVRzYmF7/F8LflJhN3Pjyj7LujxamKqCOfbVbEB9kBtsIvxmUVnwEY+i5U31GZdIrqMmFwEAybhhNZI2B2ZGQb7ZLCFjg3kjh1LQpq93ifaZPQ4HgNPxQXxOBieLlhLTqwagdjNG2AYP0TC62XTV6zpQXp9J9odJZbAg9WqEbWJy3BkWeVlP/vEYRZEuW7B10LdVtZvaH3jxq4m+g5YLUAtBpbNLr7vW5Gv7RJagb5+5nDpGgDxrss9+tcFlie4mQIUVjf8IpXxjb5f4+tFBd6sgFUvYl08Rte9gs4Qn5HbrYu52gH44aViQpkQxaYT9QxCAl7BvqWicg8V95Y/jzvxnqL9H7SnWBVjrvHHQ8G6ZrH1eA+u+PgPqnTowr/6sAB2pg3g+oxE9OqOFtcjbLS4QVIbbUgADthfJjc8ugrPwmtKoJ2TdBtglDX97Oq3eMoTtd7uLT4VGeLw7GAGKS71TABb9cpE8MLnpIV5pLQ5OnrobbGjaAwlqzxuJQ1Ojbn22jqPu8pJCaKRx5bjvujkUP3On3FGr/XGW3jwdZnK7gN3tiX/oFXMpvh5k+t3uuM1gRKJWQHE6RK/e4MhaIAD5HLKT70elg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(376014)(261028144727099003)(261022075727099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(11063799006)(10067099003)(6133799003)(5023799004)(4143699003)(261102123227099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1ZmVXJzTmNUVlRObHF3NFR5N0h6MG0vZFFWTHNFTUlYcHdRSlZJVnZrb1dk?=
 =?utf-8?B?OVdLRkhwMmZQajhFdHdiRmhiV2kzTVlocVpkdG9vR3hhQXNUbW5ibWdFbUY4?=
 =?utf-8?B?UVJ0WWdKYnF0ZUlTQWxYYkdzQXFRUktIMklSQklKUzVUSmRkK0VuemxhcXl3?=
 =?utf-8?B?VUFadlE2QXVRbHNPNXVDL01qalBTaksxL3lFSHh1cWlndHcvS1o3cG9paTlP?=
 =?utf-8?B?UTBBSFp6NzVsU3o4Y2JCZFo3UnpuOUVFRmp3V0xsdzJLZ01SdDBPMHRLY2dp?=
 =?utf-8?B?ZmV0Ykg5RXA1R1kwVitYMXE3MHQ2ZHdqUTMzckpyc3lwcG5mUHF4Ungzb0FS?=
 =?utf-8?B?Y1kxM3ZOckVJSERJTXk3amhYekVhekV1c0lTWXpmTEpxc0YveFpVMnFYYzhT?=
 =?utf-8?B?TmVBQU1CaDI0ZU5PV0wrUjRNcjB1bHFrVVJDN1VSZjRQRDZ3WkNCdkUrMU1o?=
 =?utf-8?B?OERwM0p3VEpYc3BFRkR4dFVyZEpFcEtOL0FGbDRTdVJtcjJFQmh0Vm5WWDJT?=
 =?utf-8?B?b2F5Q2JYeHZjV0pHU3BueWRrTU50Slh1V1A0YTFVZFBBL29IMEhXSHpJSTE0?=
 =?utf-8?B?OUZYN3c3aGVwRFlFMUNCb3FndmdrZkUzS1lVbDBmV3dCcFU1amVlUXlJWDAy?=
 =?utf-8?B?Nk94UVV4ZzJBR283dDJieWJLZ1FkVENvRGV0eVBqWURiUVFaR0cwa2VtQ3RL?=
 =?utf-8?B?TzNBOUdvdUU1VW5zTVFraHdPVHRPK0ZBMkt1QWNuditxUUtleThDa1BwNXU0?=
 =?utf-8?B?NUdsdU9qYUFrMTRRdUJLOTZKaHdjbzgxd2VlbWFzWUUrMEZDMFl1RVVsclhi?=
 =?utf-8?B?OWFkVTZuQk9ZR0hHVUNWQVlzaWZlVUZwK2JIOC9pSis5WlJIK1YveXVnblRz?=
 =?utf-8?B?N2dqbHJWT0pmbi9TeGw3S3AxRk9FczJndEJmWXIyNHd3c0F2aS9LWDBYOVho?=
 =?utf-8?B?eE0wYThOelZ2bkplOVpPdWllaTVIeFJmdFpCWHVZZDc5TFhWUk84QnRzN2dv?=
 =?utf-8?B?OXd1ZTM5M1ZVRi9GSE9IYThlQUxUWnBkY0w5dTZ0bmdGV1QvLzFNTExZbkxG?=
 =?utf-8?B?WHZXU2VRM0hudDVxaVgzN1hid2Y4SW14MUxnQzJVN1hVcys0dThvbWJIYnRZ?=
 =?utf-8?B?Y0hSQTJGZEs5cjBZOUUwVWRPc2RSUnJSbFNFalJuZDZGZVNpV3RJdnYzdUsz?=
 =?utf-8?B?TXNYS0pkOVB6d0pQT3NBaUJsZFoyczJwczNLV3lSc0NmRGt6d2RXTk5YVEpW?=
 =?utf-8?B?TW02ZUJQODJ2V2N0ZjBBcktTK3BnMGVHdXVIdUdnZm12WEdSUkxZcmJDYXBk?=
 =?utf-8?B?VTl6NjEwTngvRlhOQ2d6RDFrRzZ6b3dVbkthazJHa0Z4ZnBaUGgzVm9MRTVr?=
 =?utf-8?B?clFmRXJJRnMxZmxoRzIzTUxUMTVUdEp6ZGZiSlE1VCtTVDJJdzhnWEhja2VU?=
 =?utf-8?B?aEw3RjcvaXVlSlJrdUppK1cyWHlaeUtsVWk5b1FzVjI4M2ZVYzU2VmM1Nzha?=
 =?utf-8?B?SzljcFhUVGhkZnlQUXRWQ21ldzVGTFlRUzhhbzhyTXEwK1RwSTJBWnNXOTE1?=
 =?utf-8?B?M280aFFGcHFhMy8yM21tREVJV0Y0d1Axck9RL0VGbkRPTWdCMVBvajFyQm50?=
 =?utf-8?B?WmpDV2N5elBXUWVyK3hXdVVJa0d3WnJGd2RnWUZ5emZqYTBzZU9NZ09iYldU?=
 =?utf-8?B?aFByYTUzQWQ5UkZiVGkzVjdrZjFQTjVBYkx2ZE04YnZLU3BaVnc1WEtBVUdh?=
 =?utf-8?B?RmlOaFRaeDFmOGtFV1l2MFEzcUpBcGQ0QjRrWjF6NmhhazJTY1RGOUZkZjRl?=
 =?utf-8?B?M1JJUk1OVjlXSjllWVlUcS95Mm5xaGJ5bTJaa3JnTTg5dVR1S3ZrMFhOazZO?=
 =?utf-8?B?bXVnMjVTZTRvTFRvek9yMFRvbjJYempoMzAvTnJzaU9LVWRIeDJMSzhjUnVl?=
 =?utf-8?B?YjNnN0EwZkN2TVRiZHdXS2psVmZOMitLWEQxUWlyZmIwZHdtUG9yQVhHdUVw?=
 =?utf-8?B?VCtSZmVVc3IzR3NxKzlPTmtNSjcyU0tIeUZPSjRZcGVwLzEzQ0pIQmFtTEtq?=
 =?utf-8?B?VVhmR3NseFhLVHVlTCtsbUxnbUZyRmwrbFZ6TXJVL0hnM3RmVmtQVGtCNENP?=
 =?utf-8?B?VGNyYktwbFdoYStRSkRPOEV5MEk2RWEvR21yVTlFbi9UV3QxeW9Sak1tWk5R?=
 =?utf-8?B?dWt3RGFzc0dZVTJwK0FQM2FpK3luU2VGcE9lWWN5UWsyQTM0Y2hrUWkrajBw?=
 =?utf-8?B?c0EyZEFVRC93VUlKQlBUUWl4ZkJTTVZ0dGFyOE82bUdROHFQbjc1S2plRzB3?=
 =?utf-8?B?b1M5VlU1MWpHcGRkRjZwRnBISzEyL1lLRUJHYVQvd0R4Yk9rM2pJbld2R3Ey?=
 =?utf-8?Q?GAvKWXDxkzOSPTVPfxcQK/fN70MOt09He9xYjMPi/BPpd?=
X-MS-Exchange-AntiSpam-MessageData-1: s8z+7m6R0Sc+6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be42ea3-916d-4c62-1070-08df3cd38929
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 13:32:14.8649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ax1q7HhNq7UjRouRNmppLaCuM9xIictldmPn0YbWbU+rQetQgrQcfBobCImHJNQKLkv7Q5aBuZZoxioBwbKCvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 10:14 PM JST, Danilo Krummrich wrote:
> On Sat Nov 7, 2026 at 7:47 AM CET, Alexandre Courbot wrote:
>> On Thu Oct 15, 2026 at 12:45 AM JST, Vladislav Zaharov wrote:
>> Another thing: since this is declaring now a proper interface, can you
>> move `DebugfsData`, `debugfs_data` and `DEBUGFS_DATA` into a sub-module,
>> say `debugfs.rs`?
>
> I think that makes sense.
>
>>>  impl InPlaceModule for NovaCoreModule {
>>>      fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self,=
 Error> {
>>> -        let dir =3D debugfs::Dir::new(c"nova-core");
>>> -
>>> -        // SAFETY: We are the only driver code running during init, so=
 there
>>> -        // cannot be any concurrent access to `DEBUGFS_ROOT`.
>>> -        unsafe { DEBUGFS_ROOT =3D Some(dir) };
>>> -
>>>          try_pin_init!(Self {
>>> +            _debugfs <- DebugfsData::new(),
>>> +            _: {
>>> +                // SAFETY: Nothing reads `DEBUGFS_DATA` before a devic=
e is bound, which cannot
>>> +                // happen until the driver is registered below. What i=
t points at is dropped only
>>> +                // once the driver is unregistered, so it is valid for=
 as long as any device is
>>> +                // bound, and nothing reads it outside of that.
>>> +                unsafe { DEBUGFS_DATA =3D &*_debugfs };
>>> +            },
>>
>> Let's move this initialization into `DebugfsData::new`, using
>> `pin_chain`:
>>
>>     /// Returns an initializer that creates the shared debugfs data.
>>     ///
>>     /// # Safety
>>     ///
>>     /// The returned initializer must be run exactly once before the dri=
ver is registered. The
>>     /// initialized [`DebugfsData`] must outlive the driver registration=
.
>>     pub(super) unsafe fn new() -> impl PinInit<Self> {
>>         pin_init!(Self {
>>             root: debugfs::Dir::new(c"nova-core"),
>>         })
>>         .pin_chain(|debugfs| {
>>             // SAFETY: Per the method's safety block, the driver is not =
registered yet, meaning that
>>             // no device can be probed and thus nothing can access `DEBU=
GFS_DATA` concurrently.
>>             //
>>             // INVARIANT: Per the method's safety block, `DEBUGFS_DATA` =
is written before the driver
>>             // is registered and points to a valid instance of `DebugfsD=
ata`, which is pinned
>>             // and dropped after the driver is unregistered.
>>             unsafe { DEBUGFS_DATA =3D &*debugfs };
>>             Ok(())
>>         })
>>     }
>>
>> That way, the burden of enforcing the invariants for `DEBUGFS_DATA`
>> relies exclusively on `new` (and we made it unsafe to force the caller
>> to do that).
>
> Actually, I would leave that part as is.
>
> Eventually we'll have registration data for driver registrations to share=
 module
> data. Once we have that, we'd need to change DebugfsData::new() again and=
 move
> that part bnack into NovaCoreModule::init().
>
> Besides that, DebugfsData has nothing to do with the current limitation o=
f
> publishing module data to driver registrations; the module code seems lik=
e the
> correct place to deal with this.

Makes sense, let's reduce the churn indeed. In this case I guess
`DEBUGFS_DATA` will need to be made `pub(super)` so this module can
initialize it.
