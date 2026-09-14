Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A085C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C94A10EB45;
	Mon, 14 Sep 2026 04:44:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sIg6rWSg";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4871010EB45;
 Mon, 14 Sep 2026 04:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQw6UX1MqB0JGJNctQRuWWPJgx/Kj6YhUwEkxkQ+P5To7HDwLLov+mXNjc6cwf3e7pMCD7IshkvMPKFSFksfOis7CXTbw1+OfCpD1RiSR74lIsDftEyVmQf4G2dwy2KxaQ4sJJYO3IPzCiTr7Nv6eAtnXg1Y4yndtzTMJZ2H1k4PywofxM4VWUG1iZoUM+VSG8teVd7qNQUjyUlgipAFnyyQviNO3rkLt6dfsv3IRHPhYD/9BxOYAecWar45MNqM02Ey2NDQAilu+AkeD9lHPWkem+DoDHxfhWS+FZSpKLYnxiBJ4Yq2SbpsGqHgygvoX8yMgL8+g6cdw58L4/SqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ixD2//XYftyF+hraokcJgxvzxbY2vj/NZXcqVMoHvQ=;
 b=adf+2tUeT8f5QRFpeOjA7Xxv5KGXhx3ICPiQP6uHp/LV6dNkZpi4TpNeoP9BymfnElzrVyVflhPvi8EbVgP5S14m7vTZAT3p/Zf7qNzFsDmfP8cbrZxqoSpsPnOR4lXfEQkP3DmeRTUpE9BNM3hFDbPbZPi67F2UQg5XNd3+HtHqHdLpHIZjhVWURr1BwRkWXzmTioJJPXYzetuTUmDbesIlkxHuhGrUcqoEpkBf2wbQG1BiaibIeo/J3i0aK6DnwzQC2xguQ2lKdSg/jxKRfn1Q6Y2UgZ6cr20sToJUbFcYqv4bGUBb533EwHRYY/qo6Dfn1WB6amaBWRSBu6coQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ixD2//XYftyF+hraokcJgxvzxbY2vj/NZXcqVMoHvQ=;
 b=sIg6rWSgmG62M1xx3lHRnfZmNjq2DmR/sv2jZC+RjrO3U6Gkevsn9YeBW6WueDJ4vtLN63G/j1oNLb9tOgIbOBDVeDbE2jdENkYDMrHa6gu+v3CwIsAYj4vtGsfHQFGj2E4oloHjh0WUCMDCJAUNlKcS/Zr8uvmFl6hExxijc0BGDLbmLDQmrAMtg9AhPjeAr+3HoZzS6VkXPizN0dEcyXRCtJovG0wA/5962ZLFJDYHCic2K9eoDp6u0/3QGeEzEvuRxeJzlBWAr9/ksp5pUKW45Z/2NqP0EQP4TLST6i8bTCPPBLg9OflMpMjjetGzFLy0X6U8V0JV4EWU1NEjlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 04:44:30 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:44:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 13:44:27 +0900
Message-Id: <DLERK64QOSQC.3V77YFL5NAG31@nvidia.com>
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
Subject: Re: [PATCH v2 4/8] gpu: nova-core: add NVKV encoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
 <DL96FLHTRWOI.1FKOXD8RCXBUP@nvidia.com>
In-Reply-To: <DL96FLHTRWOI.1FKOXD8RCXBUP@nvidia.com>
X-ClientProxiedBy: TYWP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: be0a5746-d34a-4093-b324-08df121add47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8o4uo/99/QOJ0dSsmZ2F8+rYJtGQT9s5cqwWBXqJxndG592Yz71QN5uTysGyYxviCZLBkYwyjFQrD8S4YCPnMva32PvgRtX/Yi5QBF5h3MCBBpXXfDFg/siQI9UPiZod3s5rUobYcQDT5ZDqtipqmNzkkP15ePxxXdeqGfJjLKUh6ahCb72GAoctZB4t6Ch02hBQY+PtpOGvoQat4oOeNGyoZzVZPHU7s8XKhirkq9VF3sAnU2Au0fV65p8my7riTmC37288VKpCOq4tGeLKcKtIFczrLg4JwijE0qag13lIW1u7PdNTe/gjei5Dw72jFUAAFA5tf22d6MHxR9NzHsi4TRWhD4r39raFMAA6QriWAnJJczH7GY59/oJlN1rDdlSKhp2WMEyyBhVtIKwWTsDXl8RDIdsRQiJQ8GJT8PjpYQZC8VPMwk5IqCZvGTYVoMdF3ea9D0UXGTM7Tqp/xvuQ3FCPY1+5s4AIzfvRNw0f8c6f+X2p5thn3m69GPtIRwxqfc68qZMspZsaede9UMSEiEH2iVwWeWkOYrFpOp9IxfTg1iCY19oVn28y2Ng7LRSjXvCxtynQnoUK5I/8WkHQKm4RqKuuVLe/oxIqHjNzDhTSby8KBuwtAmO7jx5M4OI9DgwHhzS39bjvSat95xMQ2nhGx274Rx0aMbKHuu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGgzODQ3dUREQjJtMmt1MmNxRUo2ZW1pUmNUU2JRSld6MEc4YlNRZkw3MExw?=
 =?utf-8?B?elo1R1ZBNGkxZGhka0tQN3A3MDU5NWFmcSt1MVRHVHJ0ZUZmK2ZGaHpHa0pU?=
 =?utf-8?B?eTcyRTBrd1dScS9wSVUvNGZQaUdiSmVYeDRRYUxGOWxKejllRCsrU2JXRHBV?=
 =?utf-8?B?WGtBcm1Ud04xMnErZ3Y5Q2tad3p4aVpkbm5RcFRqNWhQZWRZZUpVemYxZnp1?=
 =?utf-8?B?UHlkeGx3RENkZTA3UE9yWERHVGVkZkM3US8vVHZJbWNKNXJ3Y3ZqRXNId2hn?=
 =?utf-8?B?Q0ZLdjJYQWxVRmNvdFJIdHVGRjkxdVFrbXN0b0kzVUN6Tmx3Wk9LekZGalpB?=
 =?utf-8?B?elZLY05VQnMva3l1T09ZZHM0KzZYeHlPMXpwamgvOXRydjRQTVhaREFPVnpJ?=
 =?utf-8?B?blZ4TjRQQjliaDVkKzJ2cTYyWjQyWDQ0ZXQ4TFNFQkRKQXpnZGM0cXFPVlJM?=
 =?utf-8?B?L2xaL2FINitMV05qQnMrLzgvbndYbFpxTmNwbmlsa1ZPUU1EYVVQQzY0NCtF?=
 =?utf-8?B?VU9iME1POGdFaEQxSW51dit1QVhSUXUyZE42YzNjVy85RnVEcUFLalZiS2NM?=
 =?utf-8?B?MUxVYVVrSHFWbkhkUHYxZjI5ajlPS1ZZb1llM285aStRdUlEa0lleUVRS01m?=
 =?utf-8?B?ajdjdWZKemJsc3pkZWp5YnBSYVoveW1zZnVRY1VIelJTN1Z4UWRtTTN1WjFi?=
 =?utf-8?B?N052L1p3aC80R24rR0ltSUpwTXFVK2x0T3dlU29FRkdJbUdINzFFQXFqUE81?=
 =?utf-8?B?NkhoRlRTUldqdHJpZVNkT254ZjdEYTY5VFdaN3VVeXIwSDF6cDUyRXZLbExu?=
 =?utf-8?B?c3Exc3VSdGIzZjVEK2l2cktLamRjdG9nU2QvYTJ6Wnk2S1R5SFNmZWtReTJX?=
 =?utf-8?B?a1ZneTlhandrVEFUcDhXcHpZRVl5ZGU5a3o4djFjL0g1b2FZd3Q2bkx3b2dY?=
 =?utf-8?B?d2dMb1pqVFQraUVsTGVyQ1U4S0JOMkk1d2pYa01MaVg0QjRSVFdWV3p0Sjla?=
 =?utf-8?B?YkN4WFZNV1BhaTVJS2hpU2ppV0t5NklNa1JpRVlFWVNyKzlQeS91K0tWbGlI?=
 =?utf-8?B?VnR1L1psdkdFZFRCS1d0SDdBRUNhWVpQQUhWb0F4Qk9jdVFNa2lzbjRxNC9y?=
 =?utf-8?B?Qjc3elFxbnY2SU8yYkZFZG1Sak5vNUJocnFFUU1jQy9SdWtkMzUxTi83YlVL?=
 =?utf-8?B?Vmxadlh3NFVMaWQxRWxFOGhsUnNOOWVCOFVuVDdzRkEweXJFTDVycjI1YzBM?=
 =?utf-8?B?dzVxLzRZem1XeHVieTVxN1RRQ1pDbG96dEViQlhEbWpPSjF3MjFYTm9Za1Za?=
 =?utf-8?B?VThOKzFCWUZPQVFSK1JoQlU1b0NJWFpkOW50a0gzQmYvdzFINzVOQ0xGc2NL?=
 =?utf-8?B?djhPbUpjWVZJQTJWbHJMYzJvejVQZWN1eEY1WUVQNUY0SG16UlJWUUIwVS9C?=
 =?utf-8?B?WTY4OUFQMDVmczNKVXozTG5iaWd6NDg1Skh0ck52d3R2a1hiY2ZNc1ljV1lG?=
 =?utf-8?B?ZFBoRlRLbnc2RU9kTW1naldqZlZ5MldiOFNaWjVMUkVic25FOUF4cXVaZVRO?=
 =?utf-8?B?bTBVR04wVWszRHdOcFFUUDVVdGpZaklUWHAvUUQ1NzV3N1hBQ2VlQVcwSFYx?=
 =?utf-8?B?ZGZYakFDd0Nzb3NmdE0yZ3dhdXpZbkhPcGs5UGNQQzVaM2dRMkVZMTYrRHNa?=
 =?utf-8?B?VUJEWTNQUmVxc0xiMERwaDdiTjhqR2p5R1ROWjNNQ3FmQ3FWV2FxT2NOaUh2?=
 =?utf-8?B?RmVXbi9qOGI5cWI4Snc2eWNxZyt5bFdJaWhKMTZub2RQZ2RlQ0tYWmFqRlVZ?=
 =?utf-8?B?d0pEcEhHeUZ1WnlZaXlrOEVqK1Ezd1FsUkMxeXhvMDIwNk53OEdhMzNFTll5?=
 =?utf-8?B?Uy9HTmlwa05YWk8xcFk2QUE2M1VXS3N5TVAvMkNUSGp6amxRTkliN0V3R3lx?=
 =?utf-8?B?aTNPYThOYWNYK0ZKbXFiYzJYNVZkVWUrdDZodUovank1ejhYUzA0Sms3S0lM?=
 =?utf-8?B?VWdTN2RGV3NncVpvcXdaYW8xcndtMXVYZE9tMmhMS1hHNHF6ZFpjQ3lxUmt0?=
 =?utf-8?B?NmdYT2o3dm5zT3VRZW1xamtmVy9TaDkxUmFKWEdCVzAzQ0E3aXBXZUE1QWJ6?=
 =?utf-8?B?clRwWW9oclc4anM1Y295M1phY01wVW12RG1EZHNXR0s2S25WL005cWV3QVZL?=
 =?utf-8?B?MzZqUmc0YU1rZEVOUlRiTjRxWVJyUFJ4OHRJRmE3ZXRtdHp3bG9TbllQT25H?=
 =?utf-8?B?MFhTYmxqZkFJb0hGWjNKczJobWhDUDR4MWVnMEtQbE1oQWpkNWNmUXRrWmNC?=
 =?utf-8?B?ZEkzMCs1ZEFack5YVEROUXdGb3dhN052emd5Y2xWSnFXZE15eHVWbkJpUUY3?=
 =?utf-8?Q?ahGzquH3HdQ04qa8358RK+zu1d7G8KZPgjmcAsPCewlqe?=
X-MS-Exchange-AntiSpam-MessageData-1: C/RUhdm92v9fXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a5746-d34a-4093-b324-08df121add47
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:44:30.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oeuz2ErohivkiOg9H6bLxN3EpEJI9yxSIGtOo61MibBvFoX/vSibY+aBj6IH18zHe7UE8GZyb2HPnjtBW+dw9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

On Tue Sep 8, 2026 at 12:07 AM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
> <...>
>> +/// An encoded NVKV byte stream.
>> +///
>> +/// # Invariants
>> +///
>> +/// The byte length is always a multiple of `size_of::<u64>()`.
>> +pub(crate) struct EncodedStream(Vec<u8, StreamAllocator>);
>> +
>> +impl EncodedStream {
>> +    /// Creates an empty stream.
>> +    fn new() -> Self {
>> +        // INVARIANT: An empty stream's byte length is 0, a multiple of=
 `size_of::<u64>()`.
>> +        Self(Vec::new())
>> +    }
>> +
>> +    /// Appends a single `u64` to the stream.
>> +    fn push_u64(&mut self, value: u64) -> Result {
>> +        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte=
 length a multiple of
>> +        // `size_of::<u64>()`.
>> +        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
>> +    }
>> +
>> +    /// Appends `data` as bytes to the stream, zero-padded to a `u64` b=
oundary.
>> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self=
, data: &T) -> Result {
>> +        let bytes =3D data.as_bytes();
>> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
>> +        // Reserve so that a failed allocation can't leave the invarian=
t violated.
>> +        self.0.reserve(padded, GFP_KERNEL)?;
>> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
>> +        // INVARIANT: The padding ensures the total length remains a mu=
ltiple of
>> +        // `size_of::<u64>()`.
>> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
>> +    }
>> +}
>> +
>> +// The Deref to &[u64] relies on this alignment guarantee.
>
> nit: `&[u64]`.
>
> <...>
>> +/// Describes the format of the following NVKV operation.
>> +#[derive(Debug, Copy, Clone, PartialEq, Eq)]
>> +#[repr(u8)]
>> +enum Opcode {
>> +    /// A 32-bit value in the op word.
>> +    Imm32 =3D 0,
>> +    /// 32-bit values for consecutive keys, starting at the op word's k=
ey.
>> +    Seq32 =3D 1,
>> +    /// 64-bit values for consecutive keys, starting at the op word's k=
ey.
>> +    Seq64 =3D 2,
>> +    /// An array of bytes.
>> +    Array8 =3D 3,
>> +    /// An array of 32-bit elements.
>> +    Array32 =3D 4,
>> +    /// An array of 64-bit elements.
>> +    Array64 =3D 5,
>> +}
>> +
>> +// TODO[FPRI]: This is a temporary solution to be replaced with the cor=
responding derive macros once
>> +// they land.
>
> Actually, can't you use the nova-core local `bounded_enum!` macro to
> define `OpCode`? This would generate the implementations below automatica=
lly.
>
>> +impl TryFrom<Bounded<u64, 4>> for Opcode {
>> +    type Error =3D Error;
>> +
>> +    fn try_from(value: Bounded<u64, 4>) -> Result<Self> {
>> +        match value.get() {
>> +            0 =3D> Ok(Self::Imm32),
>> +            1 =3D> Ok(Self::Seq32),
>> +            2 =3D> Ok(Self::Seq64),
>> +            3 =3D> Ok(Self::Array8),
>> +            4 =3D> Ok(Self::Array32),
>> +            5 =3D> Ok(Self::Array64),
>> +            _ =3D> Err(EINVAL),
>> +        }
>> +    }
>> +}
>> +
>> +impl From<Opcode> for Bounded<u64, 4> {
>> +    fn from(value: Opcode) -> Self {
>> +        Bounded::from_expr(value as u64)
>> +    }
>> +}
>
> Sashiko has a point that `from` requires `#[inline(always)]`. Ideally,
> we prefer to avoid using `from_expr` when we can, which in this case we
> can by doing an exhaustive enumeration. Which is exactly what the
> `bounded_enum` does, so leveraging it also solves this issue. :)
>
>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova=
-core/gsp/nvkv/encode.rs
>> new file mode 100644
>> index 000000000000..6c1a9cbd90e8
>> --- /dev/null
>> +++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
>> @@ -0,0 +1,210 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFI=
LIATES. All rights reserved.
>> +
>> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>> +
>> +use kernel::prelude::*;
>> +
>> +use super::{
>> +    EncodedStream,
>> +    Index,
>> +    KeyId,
>> +    Op,
>> +    Opcode, //
>> +};
>> +
>> +/// An encoder for an NVKV stream.
>> +pub(crate) struct Encoder {
>> +    stream: EncodedStream,
>> +}
>> +
>> +impl Encoder {
>> +    /// Creates an empty encoder.
>> +    pub(crate) fn new() -> Self {
>> +        Self {
>> +            stream: EncodedStream::new(),
>> +        }
>> +    }
>> +
>> +    /// Returns the encoded data.
>> +    #[must_use =3D "encoded stream must be consumed"]
>> +    pub(crate) fn finish(self) -> EncodedStream {
>> +        self.stream
>> +    }
>> +
>> +    #[inline(always)]
>
> Unless not inlining implies a build error (as is the case for
> `Bounded::from_expr`), I think the convention is to stick to `#[inline]`
> for these.
>
> Same applies for other methods.

Thanks, particularly on noticing the bounded_enum!
