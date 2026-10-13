Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B1CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 06:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB9DE10E509;
	Tue, 13 Oct 2026 06:23:13 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F4A10E509;
 Tue, 13 Oct 2026 06:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGcsPwZv76LWGBi9iRoln5XmblNlIXEG/VVHvPyYq48sJj5753Vd1DGFdFrgQD4gT5enxTsU3FaY+H+gE3qx4M0n9BBlVV3Szhx5SXn0ICN+lyt7BMtkCt1HZ33R/fEzicM2HWS3buXsnHuGjk+AXvdI3R4JRGLpa9fzcEk8Hd+P3m5f+D22Ki18SbXvZukQlJQBM1PPGKGfj6/691TRmA+4e4ZeAw+CdSTGWRPX70A3k5kFN/c9r6x9jBXl5LICqNKWWvIdlrncicax6l/hT8Tte7e5vIj774QcsxtDht8nNI/3w6Qk4QOr1MSqlqA1mOrVPEphq7CdPI41+3F6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyA6b9wdiCQr7MCdES8SBWJ7zdyF9TjwUkD5GkXVC+Q=;
 b=wj6a8E32GG9GMzI9cyzj99JFa6UOJ7Jz7GytoZKkCOjpRhIqE7KObHoQu4GlXry7/HltViESyL8JiLXXxKUTwg4ajBddZRA1/uaohpy+bRfOwaM1coISL6S8ywOpJ08MB5TFVKUwmRRhGiIxEh/zZSk6/6KV9TJ6rg6ESGfkJjaVF6fSf4ALUCX5VISbnvMjisFxSv7n+OZYwSDcM31RK4SmRI8lS1QW2MkvGHP56GL0cPGowC44kSyt+gn4W37ssvDWSmhnlD3AV492daK8CK1bDsV9eyjxrLkZ8uooas9xs5ACOVqW0v6lW5r+5bEqb/wwt/T3mU7JAcQNlu1RSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyA6b9wdiCQr7MCdES8SBWJ7zdyF9TjwUkD5GkXVC+Q=;
 b=T0tsoi2gk2VCkEfzzzWS27JqYy8recfsMbi+FTVJl4BjrWH+GZxT8ukg3c9a8sbAOTZeAhWwEW2+Y5KpItIgMnTidxymQKbJScObRufvKK3O2AxBZuR7UUeq4i2P3nFu7ddCckrwPTr66t9v3qxvpqYNqsjuTIbFpljxwV+8ns6vHzn9fwjU2OeE94mYN+DvfrCO8Q6/jsMXaaz7wT76geeGHHrfSyYlMZQbbgv1o3famQbf5kZFUBDLZ9s3k3Y8QI+707AJcY39V6QeB0DtcLX1orSDIx7HEcEwjP7zsZVQR4Q9nSPbcL4gvkj9qNMFkgbAIGP143i3weuvxpMOLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 06:23:03 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 06:23:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 15:22:59 +0900
Message-Id: <DM3HTEQWMPZ2.6IYTH17NNAA@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/8] rust: alloc: add Vec::try_push_init
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
 <DLXISL19ZQBY.1E3J1G0HKGPZJ@nvidia.com>
In-Reply-To: <DLXISL19ZQBY.1E3J1G0HKGPZJ@nvidia.com>
X-ClientProxiedBy: TY4P286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::19) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 022fdd45-2aba-4c7a-299e-08df28f26f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1kZJofTxR498GIpac99Gmy6vLfwy7Pf/dmlE7/e2GdothEjBnFECUUbibbXmjkx/ytrNziWipGy1Y0UcQ1I0MsmBABbMtLwPq93MkE/0dqyPEgBtbwfbIRYwYJW5cK2TqvlbvTJtWGFfh5nz37ln6QBIe1Bd6mBeFVBsYyLw9J7Jsjbt/9/NQHJPn9p5O11CU95twXzbiMg5trm1WUCBJbi9n4fUs4TBayu4GKBEpKdsJGqimy4P/+lJRMCf73fMc9lXSLs9pRlHDS0g4rEWnOj6BpHVxaXoPUUbzOaUX65qzSM8dadfsig5dTE9dOVemmYaWjNzuq7T0/DJY8Q08Tde5Kgg9hHehKLz1jkxrx0b2T0J8aVzAbR6AqOC5O1gIRkp1ApyrjluAn/z8ELtZYZ/B2qEr4k2E846zEL7vXjCHEnqTop5fbhVpFJ2h0qtq96+fWZ+5efoBV4aPQxG3wDpuoVzOue0qR+Ri++udayWX/qadbEWZ+eGSDuiknG9ODr6qcEgib8Fmw7TmP+uC3B9f5hkua7/aCB/IkDYkaHF0X2lBdBn8AUaIlkPJZEVu7qwBxet1u1OyY6mK71e3CVwOw8dnfiuuqIIm9KywxaWHzUrHYdoL5pzZ0JpXPPiS5oc4WwrQaIpegjxK0i1RuRpQJCnf6oMpDUyROI2fAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WS9wa0JQUkJVV0c3cksrMmg1dEpaT0d5N2FGV3FMOVlLdlNxVExYQmZMN3Jz?=
 =?utf-8?B?UHl6V2w3YmFsbmhJeHBCOHdzRXV0MW14NzJaU1pBdkJ1MVp3bVlyNFV6M2M1?=
 =?utf-8?B?V1NnR3FVZnFSS1ZDbUFqc254TzZiMlBYRWgxRnNsSXZ0RGpVSDlNblovTFJp?=
 =?utf-8?B?Nk9mSEErZ0krL2RYRWl1NUFlNVozdkpTT3RaaGsvZTZndGt2cFU1WjZDakpY?=
 =?utf-8?B?eG1heVF2NUFpcG4xd0Z5c2xIODFmNndtQ1ZvY1dESW1hSURXNzVuaTBrc2h1?=
 =?utf-8?B?bmkrU2dYTWhuZ25WSXdicmEvWUtvWWdyOEtqdEsvWElFTlNlemJpTXN6bFNN?=
 =?utf-8?B?VDdUWFVRa3BSVUlQRnp5Yk9GSWZQRm1idnJ5OHRDRkhoOS9scHNTc3J0MU5I?=
 =?utf-8?B?bXYwWjFUVGh6RWRJeEQyUXM2bithTWlYRGwyRUY5SmJTbmhoRmluYk9GbHVm?=
 =?utf-8?B?eW4wL1NqaXpuNXVmRit2RUp1a2dHZHE4K2tPRUhoeGxlWFNBRVZLUk5lWXhG?=
 =?utf-8?B?QWFZNDlpZjVxTVREYVg5TjVnUWQyM2xDd0VLK1E2dy8rK0psNGM5TVNQdXFZ?=
 =?utf-8?B?L3I1Yk15b2tZeE9BWlQvVVdVOGJTMTFCb3hpZTFOc2VrSlh5TERjZDAreW5E?=
 =?utf-8?B?MFQ2WVBhaWFFMGlvUlIwdGFqY1E1aVh0WEVxU3pMU0N0WUtyZHV4a010NUtl?=
 =?utf-8?B?NFJWYmhmRC9RT3ducFROc3Fad3R6R2paWWcrMTRGMCt0MGtOUFhoclpEc09J?=
 =?utf-8?B?YnlOdFRCZXU0dHNBZnNMRFZzSFlTT3QzOC8rZDVNdGlFK3o4KzN3YjhWdDNX?=
 =?utf-8?B?eEpNakpmSGFtUFlicDJEWGlPK2JzcnVjTkk5L2NwMnRGVzVpOFlzUDhIbk1t?=
 =?utf-8?B?UVJ3WFRVS2FrUW1kbzcraG1aaCtwczJYanNFbzQ1Y0d1RGwyMmIwcmFPQThj?=
 =?utf-8?B?ZXcwV1g1aHVoTjJ0L3M0VWs1RXJPSkFyNGdHWDkwcHJuakJ5SnMwOCtnbUJu?=
 =?utf-8?B?bTQ4emR3Njkwa2RZdXl1VzkxN2pqVlBEYkFkeUlGZzZTU2NVbVcvcWkrNDNO?=
 =?utf-8?B?SEhLL3lIWDZqWTNjMXp5WDQ5Q0JiRm4zWmhsWmVXSDNUZVFEbWtCOU9XT1c0?=
 =?utf-8?B?cVlYTWZSaWNsQUlDUWU4ZEhaSFh2OTAyVTkzdjdRd3g1Nmo0SXorNWo1bmxL?=
 =?utf-8?B?ajc4RW5TUDd5ck1KVUpQZUhPUVhKVDI2bGpRNjdGVW5EMXFPWExDN1hXcFNU?=
 =?utf-8?B?UWxlZnZVZnhWZ3QxL213RXd6ZTRsYXg4ZVpEQ3FCaDQ5c2Yzd2pFUEdCVEI4?=
 =?utf-8?B?NDEyUXRjZkFNSjFJTGhKQWpPR0pHT3ZMelJERy85SjFQWXJzVzZQWG82aVd3?=
 =?utf-8?B?Qy9XZXRLQVNiY1RaNVpSSm8rK3l2cGdEZUM4Mlh6eERDa2hmSmdLbjBDOWVB?=
 =?utf-8?B?OXd0WWZQMTRSWWlEUVVLQy9IZHlFSlZCOXFqVFpzU3BNT1VBVUhsNGdhakxa?=
 =?utf-8?B?YVNDZkM2Wi9CckNyUGxKY2FUMmNvMGZ0aGJkOTVwL0g3Y0tzc2k4T3JQWDVh?=
 =?utf-8?B?UUkvaG5NTmtCNXhQZ0hPZHdtd3I0VHY3ZGJ0dXN2K1pVWmcrNW5OYkJJQ1FB?=
 =?utf-8?B?QlZiaThKOE1lRzluQlY5SjdjajJBMk9Hck1uWWVJeU5NZVhZRG9vWG5nY2pQ?=
 =?utf-8?B?K2ZNck0xd29zMmtyd2NWQlg0TnpSUWd2Q2I3V3lOdWliYnZIZ3p0MVFHQ1BN?=
 =?utf-8?B?RmtJUldwR2I0RU13dDYrS2VzNGFITEFyOW16WmlZczVleGY3WHdRVGxlYmFR?=
 =?utf-8?B?dW1OUVVIaXdaQjdaV2R1aGFlZlRKcVBoR3d0YjBjdG1meCtTZFlQZ3dxMXp0?=
 =?utf-8?B?ai82ZVJvM0c4cElwSlVPWVF3dk43RUtmUHpOcnUzNEkwbmpsMkV0NXdEb3A4?=
 =?utf-8?B?c2pmUUdPcFUwRDkwREtYaGNlZXBGZ3NEaGJmalJQZmVJSmw3WWlxZzlRL21x?=
 =?utf-8?B?WGpRVXBicW5aa2dhT2x1V25BU3NGVS9oU0MxbDUyV1VQZWx5NGo1Q1FZTlJV?=
 =?utf-8?B?d05HM01UTUp3YncyWVdCbndGejloai9EbGYwWDJkNllMYWU3VTlvam5ML2hr?=
 =?utf-8?B?OWlxY2tpQ05La3NMK0RQanFDL2laSWxJSllDdUhIQ28ydUVMdCtWM1BqZFRi?=
 =?utf-8?B?L05iQnJIUTQyNUVQeGJEOEprNEpmcWFLRUN3Z1R0VERmOTVJQ0diR2J3M0tF?=
 =?utf-8?B?cHZ6WExsbGhqZ0ZkbkZ4TzlHaUswV1dpTjdPSklEdStWNlNXQi9IZUE5bmVp?=
 =?utf-8?B?TkQ3b3RkWFd5YWpMN3c5b0I1aDd3MGduc3FyVDJkVDRzY25YanJ2R3ZONEZy?=
 =?utf-8?Q?ZseYbrEH3jaTnPfsTc82Ny6xGrgpFAK52BbV56lhCP/C0?=
X-MS-Exchange-AntiSpam-MessageData-1: vmxZ+pOaLcyEjQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022fdd45-2aba-4c7a-299e-08df28f26f0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:23:02.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmm0X0835HYd094qnk5RKaHThr9D6ZVowv6l/v+hf807UCPlAqldkZQoWi9PMp7uHoMakH0nXLieKEWWYhoQDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
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

On Tue Oct 6, 2026 at 2:52 PM JST, Alexandre Courbot wrote:
> On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
>> Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
>> and a new sum error type `PushInitError<I, E>` that it returns. If
>> allocation fails, it hands back the original initializer. A From impl
>
> nit: missing `` around "From".
>
>> for `Error` lets callers decay the `PushInitError<I, E>` to a regular
>> Error if they want.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/alloc/kvec.rs        | 55 +++++++++++++++++++++++++++++++++=
+++++--
>>  rust/kernel/alloc/kvec/errors.rs | 30 ++++++++++++++++++++++
>>  2 files changed, 83 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
>> index c7546b9da4fa..a2b72a7779d9 100644
>> --- a/rust/kernel/alloc/kvec.rs
>> +++ b/rust/kernel/alloc/kvec.rs
>> @@ -52,10 +52,18 @@
>>      }, //
>>  };
>> =20
>> -use pin_init::Zeroable;
>> +use pin_init::{
>> +    Init,
>> +    Zeroable, //
>> +};
>> =20
>>  mod errors;
>> -pub use self::errors::{InsertError, PushError, RemoveError};
>> +pub use self::errors::{
>> +    InsertError,
>> +    PushError,
>> +    PushInitError,
>> +    RemoveError, //
>> +};
>> =20
>>  /// Create a [`KVec`] containing the arguments.
>>  ///
>> @@ -359,6 +367,49 @@ pub fn push(&mut self, v: T, flags: Flags) -> Resul=
t<(), AllocError> {
>>          Ok(())
>>      }
>> =20
>> +    /// Appends an element to the back of the [`Vec`] instance by initi=
alizing it in place.
>> +    ///
>> +    /// Unlike [`Vec::push`], the initializer may be fallible. If the a=
llocation fails, the
>> +    /// original initializer `init` is handed back in [`PushInitError::=
AllocError`]. If the
>> +    /// initializer itself fails, its error is returned in [`PushInitEr=
ror::InitError`].
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// struct Element {
>> +    ///     buf: KVec<u8>,
>
> It becomes a tad confusing when the element of a `KVec` is itself a
> `KVec`... Can we just use primitive types inside `Element`?

SGTM, added the failure case in the example as well.

>
>> +    /// }
>> +    ///
>> +    /// impl Element {
>> +    ///     fn new() -> impl Init<Self, Error> {
>> +    ///         try_init!(Element {
>> +    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
>> +    ///         }? Error)
>> +    ///     }
>> +    /// }
>> +    ///
>> +    /// let mut v: KVec<Element> =3D KVec::new();
>> +    /// v.try_push_init(Element::new(), GFP_KERNEL)?;
>> +    /// assert!(v[0].buf.is_empty());
>> +    /// # Ok::<(), Error>(())
>> +    /// ```
>> +    pub fn try_push_init<I, E>(&mut self, init: I, flags: Flags) -> Res=
ult<(), PushInitError<I, E>>
>> +    where
>> +        I: Init<T, E>,
>> +    {
>> +        if self.reserve(1, flags).is_err() {
>> +            return Err(PushInitError::AllocError(init));
>> +        }
>> +        // SAFETY: The call to `reserve` was successful, so there is at=
 least one spare slot.
>> +        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cas=
t::<T>()) }
>
> I guess it comes down to the same but I'd feel safer if we could
> explicitly index the first element using `get_unchecked_mut(0)`:
>
>     unsafe { init.__init(self.spare_capacity_mut().get_unchecked_mut(0).a=
s_mut_ptr()) }
>
> (removing a cast is also nice I guess)

The file appears split on the convention here (get_unchecked_mut vs
get_mut_ptr + arithmetic + cast), but absolutely do not mind changing
this one here.
