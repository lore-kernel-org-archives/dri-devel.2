Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7E2C79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B403F10E051;
	Mon,  7 Sep 2026 15:07:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lbd79j2+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012032.outbound.protection.outlook.com
 [40.107.200.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B4BB10E029
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 15:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn1DFG68YjbC/P3XbelNDy5dV+uATiG0G45oQLKH8zb4zKzxneSK47cJxZixacXdYfsA7LqEuuRwPHxBXrp5dJDjUdD5/A4VRXvBfM6L8GqaZbj/xqzqXBo8AGxw89Ne/lOiBSTbKtSPssszIrUPVv6OaNruzppaJYqaJ6BgLmAat4ui0UOcOIf9v8QSM+wHhj4Ue2HOLZsJWUiLVN7SRx9t54JiFQ19+S3mhSVwut2/zxPlNsEUfNM+H4+TMnzMoD6RBqyjR0ncxZ/fxyWfV12qvCZ9YXmkSXsG/xJvnPYIUq5LzX+u0S+oAf0v6gLthSQa7rE0bT8hO/hRdCbpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7gq0AS+Lf42T/2ZZxI6mmOhjSjVaehvWudNBlOrEvU=;
 b=DCPIw7tuT2yqkvp79pIVvhm2buPSCD0MQu1Jm9/nRt/nwI6tQcnKfc92ava09pOTd91NsrpyGL2XedhsJQ/xknfd75HQljbsarNQ37+3hnN+AZQgK/PB8WHVyleohHgISP0n+2yg3w2EcoTiCIveDmlJYbjfdwWRYTiZTS1D2LF3hDgtifgq7KiFKJDaXziJ3gBZOKJFVZmBz/MC3hyAjDBUMsxn72+kD4WQJc2eOigs4oVYRYEhmze0v3gdaEVLY8yd5QmzKnhz3dAp3XJ5G7JT1t9tL94yCShoE6mp/AomrBbquYbED3lD6f+BzpFAsBOJ05Is867/dE3EWRmfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7gq0AS+Lf42T/2ZZxI6mmOhjSjVaehvWudNBlOrEvU=;
 b=Lbd79j2+LzsbVxP1H2k/jR3RFi+miLVAy306rBsKVEVE8goJJR2CgqFKU1acaVlYsODYRxKnHmumbdrhvRx49JPlWezVGRWyztzcbyO7SPhtN7gg4xPS82a8YeMia3Ag5w4db0VNR+2e54BbzeMPki807dhlj/dHKxgIItAN9o+x/E648ajIOaZqp2Hyc2Hsasjy0j3N3+ymmKylkGmfQq7GGKmQE7cZR9IAW6E4MFZTVSQuNGV8ePQKeW0r7bWaXMuBevQwNkVCYP9XEfjMzxNJ5hvlJlEUh+AoFCNhTdOKuBY9ZdGu/ycyR/aVFhshXUobvS6LRe0N+rV3UIU6/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:07:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Mon, 7 Sep 2026
 15:07:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 00:07:45 +0900
Message-Id: <DL96FLHTRWOI.1FKOXD8RCXBUP@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/8] gpu: nova-core: add NVKV encoder
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-4-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d4b2db-a084-44f1-23c1-08df0cf1c76d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|23010399003|1800799024|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: C/0KivCkH1V/1V3BhploUxDXwti686ZcaH1yhIsQD1Oou5W/1ZSgiyUi4KK6sga+njrB4Jr9J+pBaUorv6SZ1UxTo/nnBQxIwYEv7iGv2MSpO364PYFBIJEJ/DkfDtLdwqCqrqOZhe0yASX3nWLCvVtShUiOiVt7iHdxD8guE+y6z6Vtuc66sCC+/3yKmCIuQIfIW26Kt6TWeaqUF8x1Nq06X//dJC3OpIRqumem4IRm1+2zjJYQNQGxnyzDCIU+S/K0kxRzyOtx2f7JnJ2eVUe7C5yR/f3MCI9skXp560HDn0Z/r1L4d5ffbHMl3A4QsSwVwl5SXDc3BlxH8T1yJR1M/TFyOAmWNdhj4y9ybCNgJfZ7ZTpsCc5bi0hH+Exbj/1LPEZ2mJOCY6CKv9ngai6udATW7rQ+RywEY5rAgTosDaIXuoSgU+o2bIqgsBElajVFxHMrzali6VnDRLuIZayG3GqLCw6ZYjwWIyWydGz+4zOdaWmtqJi8rQKWLrIJalPDjxUotNUfyy4eRw6Zqhyqop+RPBh4iI/B4QZvszSSeCMNyIJv7Y9uZQsXDZFVlzSo4v6/ROfMplsxLoO+8ZHhLoLoo+kQx6ClEbbmmjiYWkGitY4ZtqWhP/tzo2rz03G0XumO3JuydP+Bjub322LdaTx/xq+W1dVPXpyMUp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3R5OUd5MkVGSXBSeVVHNkx0bmVqbkpKVWFmYi9TaEF5UVZkWWFrWWpoL3Nx?=
 =?utf-8?B?ZGNrMUIvNFllMktsOCt0blljTEliWngwcng3RkpNOTNHVVhJVXRSM1hmek1p?=
 =?utf-8?B?VFlKamdQdk1nYkxKVk11UXhJdHFDMjV5OGVYeFp4UVlHWGtiYkNmNWZQUnFh?=
 =?utf-8?B?VmpEdlY2ZlYwM1Nkbms4eCtVTVJ1ZFlaemhQd3Y2aDJ0TUNGVjArWVM5VldL?=
 =?utf-8?B?QVgvK3FBYTRnUlc0SURaU2dHeC9KSmRDRHJuU0lnMVlIeW5SMUgyZzdvMXJG?=
 =?utf-8?B?YWt4RXkxbkVRaVJheWpNVmZoRjZpb1N0djFwcUR4K3U1VVlKUGJ3YThteTRp?=
 =?utf-8?B?ZlYybjNmaVhIVkdyVDBWNHRENVRKVXJpZlU3TVpSd2FKbnkyMjkvK3ZuSFRt?=
 =?utf-8?B?akl4bEdUSVVkODU1Mkk0bkUwakdKSXlwR2toTm5kWGVKT2pQbW5sY2l1anVG?=
 =?utf-8?B?cVZ2cGpORlR5ZGtSSXdyV2grTUxUN0tmcGxsQ1BZbGgzWG51VWRPNUlObkhJ?=
 =?utf-8?B?Q3NzVTZwQ1c1T1kvbVdaQmR6UEh4RlVHdlk5TURDQmJUaFRPWkc0MVp0a2FZ?=
 =?utf-8?B?N3VCU0c1STNNcndHR2JlT082c1Z1M2JjRVFDRUJYaFZIcUlBYVlrak1nSmdY?=
 =?utf-8?B?bkdQK1haSGppbnlDTFdaNTloZFVUN1NJWUxlKzJVWFRPb1lOeDd0b0dFeGEr?=
 =?utf-8?B?TnVjTlBGYkJHZW9obUVYVWRpekRUVm9ZT2pxeVdHb3FDY2hEcVFQQmdkVXRW?=
 =?utf-8?B?UGh0elJDRHQyZHBzTGVabllyb0REZzFVbmpDWVJKZGsxYW15Z2VzQmFjSmFQ?=
 =?utf-8?B?aWVlRGJPNUQybTZESVkwZnQzMmxuMHcrUnNsamdzZ21kOXMxSGpWOWJaS3Z1?=
 =?utf-8?B?YWx3bWhhOEpBZmRWYmo1bGNxRWJNbUoyc20rSzRldHVFNTZaaTBscklrcDZN?=
 =?utf-8?B?eEE3Vko3MzdETU9QcTBqVC9idXc3MzUrdDhvSW03dVZoV0h2ZnpFSzk2Wm91?=
 =?utf-8?B?WXEyT3pPQ0MySTVWbTJhSHVxNmc1VXRYRDdQVWtnUWJhRC9Md1lGNVJYd0dJ?=
 =?utf-8?B?UVpZb00yKzRJM0lJWUlNanZJVUg0cmlaQmVuckF3R3hsdkYzVFE3VEZ4U05H?=
 =?utf-8?B?WWIvSjdBWDZQd0l6cDlnVmRxbjZ4ZURIZWZ5ZWRSOXJsa3Z0akoxRzVsT09G?=
 =?utf-8?B?enZGdGdxajcvK0xPQjBPV3hiS1ZZYnVqK2V1SnNWR3BCYTRzUTV3bSs4c3hN?=
 =?utf-8?B?bHl1dmRWTWJMZWt5WmpnaWNkL2ltYUFSVjhWNGFWYW9COEpsdittVlRPYUho?=
 =?utf-8?B?dVhBaTRucTBaK2tLU1p2YWRVNGdqV0lVWEtCMjREcFdlQzNnR3pyZFgzaUU0?=
 =?utf-8?B?RGc1Qy9zYTErSGNBQ0ZvNEwwbm9nU1RrSzVwanJVUXJ4dHllVTY0dVc0RXpG?=
 =?utf-8?B?RDB5dmNtZzBrd2xBNWhKcWVkcDQrTU8ya3FHSHV0UXVWZUN0bzA5a3NwNDgv?=
 =?utf-8?B?ZkpsQjR3U2RaQ2JkM0ZkRlNDWisrcnBDMWVtVUVkUEFzb1VOT0p2NFZPZkNP?=
 =?utf-8?B?SjJETlJ1YW10R2grNkcrNEM1K2ZGcVBHR1h4ZDBZL1ZGNHdib25oV0ZORDMx?=
 =?utf-8?B?OEd2MklRb0p1eVFkSU5OdFNTTHdnUGM4NWpUVjArL0ZpS2R2MzdYcEkxS2dP?=
 =?utf-8?B?UUViUVdKbkwveFVhZGpybFpuMnVKcUZOK3I1L3lTZll4b3ZHUWczNmxhOUpj?=
 =?utf-8?B?NURRTEtoSGppSEdhQTNWZ1NPTlRDcWJsNUdwOUoveXFXMjJaaDlXeGJ1TGg2?=
 =?utf-8?B?ZWpnQURGNjBKeGIrRS81RjlGd2Fzb0RaWXU5Zk5ZY004ODhldWdkeSs2S0NG?=
 =?utf-8?B?RGtaakRzWEFuZnpLdnlPU1ZLN0xSZFQ4Wm8yWFZ0UXpPM2lrNFZjdUVNdXlo?=
 =?utf-8?B?SHBpeHlISVhVN3BGUDhKYlVyYTBpMUk3V2VNREhnZ0xYdks3ZXVWUXgyY0s3?=
 =?utf-8?B?QU9YZWVrb0JMNllaSmRMZkJUaTgyRFBPUDg1US9MRjM4NFhrY25IUDVWL2l2?=
 =?utf-8?B?dW10YnFHL08xOVJuaWJFWmRJbmNYQytPcTRLTm5FdnBIdWNteVp5eXlpaGNp?=
 =?utf-8?B?c29GZWdPS1hWOXM0aGZkT0xQVWNueFVYQ0t1NHl1elh1S3VDOSt2ZE4zTFJI?=
 =?utf-8?B?djUya29aakI2S21oOW9JNXViWnNnanVYdnVwblZoSDZzREhDbFlhLzlCZVor?=
 =?utf-8?B?M3IzU0ZQeHdKOHdNeXErSTNPaGZ3VG1OYkw0VU5yd2xkWmJzaU0zRHpjdSty?=
 =?utf-8?B?Wm5tUDlhdHgySTdEWFlLeW9telBreTFpOHJIU0ZVdXRtTzlxQWZ0eThDU09R?=
 =?utf-8?Q?CMF1xsHHV94jxQrHSkT8DsRjim+eIGTrzjft78VwneLE3?=
X-MS-Exchange-AntiSpam-MessageData-1: PvE3slR7rr+t9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d4b2db-a084-44f1-23c1-08df0cf1c76d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:07:48.4907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp+3h6ywkFfzypro7PkHwfKPgGH1JyvnZt05/95UQua9xUsr8H+cfb76wVZqpvWsHIC0wdmVczLzI4Z7iCF4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
<...>
> +/// An encoded NVKV byte stream.
> +///
> +/// # Invariants
> +///
> +/// The byte length is always a multiple of `size_of::<u64>()`.
> +pub(crate) struct EncodedStream(Vec<u8, StreamAllocator>);
> +
> +impl EncodedStream {
> +    /// Creates an empty stream.
> +    fn new() -> Self {
> +        // INVARIANT: An empty stream's byte length is 0, a multiple of =
`size_of::<u64>()`.
> +        Self(Vec::new())
> +    }
> +
> +    /// Appends a single `u64` to the stream.
> +    fn push_u64(&mut self, value: u64) -> Result {
> +        // INVARIANT: Appending `size_of::<u64>()` bytes keeps the byte =
length a multiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_from_slice(&value.to_ne_bytes(), GFP_KERNEL)?)
> +    }
> +
> +    /// Appends `data` as bytes to the stream, zero-padded to a `u64` bo=
undary.
> +    fn extend_with_padding<T: IntoBytes + Immutable + ?Sized>(&mut self,=
 data: &T) -> Result {
> +        let bytes =3D data.as_bytes();
> +        let padded =3D bytes.len().next_multiple_of(size_of::<u64>());
> +        // Reserve so that a failed allocation can't leave the invariant=
 violated.
> +        self.0.reserve(padded, GFP_KERNEL)?;
> +        self.0.extend_from_slice(bytes, GFP_KERNEL)?;
> +        // INVARIANT: The padding ensures the total length remains a mul=
tiple of
> +        // `size_of::<u64>()`.
> +        Ok(self.0.extend_with(padded - bytes.len(), 0u8, GFP_KERNEL)?)
> +    }
> +}
> +
> +// The Deref to &[u64] relies on this alignment guarantee.

nit: `&[u64]`.

<...>
> +/// Describes the format of the following NVKV operation.
> +#[derive(Debug, Copy, Clone, PartialEq, Eq)]
> +#[repr(u8)]
> +enum Opcode {
> +    /// A 32-bit value in the op word.
> +    Imm32 =3D 0,
> +    /// 32-bit values for consecutive keys, starting at the op word's ke=
y.
> +    Seq32 =3D 1,
> +    /// 64-bit values for consecutive keys, starting at the op word's ke=
y.
> +    Seq64 =3D 2,
> +    /// An array of bytes.
> +    Array8 =3D 3,
> +    /// An array of 32-bit elements.
> +    Array32 =3D 4,
> +    /// An array of 64-bit elements.
> +    Array64 =3D 5,
> +}
> +
> +// TODO[FPRI]: This is a temporary solution to be replaced with the corr=
esponding derive macros once
> +// they land.

Actually, can't you use the nova-core local `bounded_enum!` macro to
define `OpCode`? This would generate the implementations below automaticall=
y.

> +impl TryFrom<Bounded<u64, 4>> for Opcode {
> +    type Error =3D Error;
> +
> +    fn try_from(value: Bounded<u64, 4>) -> Result<Self> {
> +        match value.get() {
> +            0 =3D> Ok(Self::Imm32),
> +            1 =3D> Ok(Self::Seq32),
> +            2 =3D> Ok(Self::Seq64),
> +            3 =3D> Ok(Self::Array8),
> +            4 =3D> Ok(Self::Array32),
> +            5 =3D> Ok(Self::Array64),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<Opcode> for Bounded<u64, 4> {
> +    fn from(value: Opcode) -> Self {
> +        Bounded::from_expr(value as u64)
> +    }
> +}

Sashiko has a point that `from` requires `#[inline(always)]`. Ideally,
we prefer to avoid using `from_expr` when we can, which in this case we
can by doing an exhaustive enumeration. Which is exactly what the
`bounded_enum` does, so leveraging it also solves this issue. :)

> diff --git a/drivers/gpu/nova-core/gsp/nvkv/encode.rs b/drivers/gpu/nova-=
core/gsp/nvkv/encode.rs
> new file mode 100644
> index 000000000000..6c1a9cbd90e8
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gsp/nvkv/encode.rs
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFIL=
IATES. All rights reserved.
> +
> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
> +
> +use kernel::prelude::*;
> +
> +use super::{
> +    EncodedStream,
> +    Index,
> +    KeyId,
> +    Op,
> +    Opcode, //
> +};
> +
> +/// An encoder for an NVKV stream.
> +pub(crate) struct Encoder {
> +    stream: EncodedStream,
> +}
> +
> +impl Encoder {
> +    /// Creates an empty encoder.
> +    pub(crate) fn new() -> Self {
> +        Self {
> +            stream: EncodedStream::new(),
> +        }
> +    }
> +
> +    /// Returns the encoded data.
> +    #[must_use =3D "encoded stream must be consumed"]
> +    pub(crate) fn finish(self) -> EncodedStream {
> +        self.stream
> +    }
> +
> +    #[inline(always)]

Unless not inlining implies a build error (as is the case for
`Bounded::from_expr`), I think the convention is to stick to `#[inline]`
for these.

Same applies for other methods.
