Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8C3FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4D110E169;
	Fri,  1 May 2026 06:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DmgBj0AU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDDD10E169
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:06:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGe6i8mf+aV4DgRNBOjIGEPwQ0jo5wkkXdxt4mbV7pPCfzGYJ9zP1+p9LHV9JZaUcQxeQvqeE1i3n20YrihkDqG8t0QlKaklH8bvtNw7Gqhk4q/kLayfH9e8ECtDWWUO+TEmybeZaqhWXj7lJg6c7zp8MCtmsZLyMXrj9n2wGlH7aHcN84Jqpki01DiE4cgrlaYgL1FDmQAhB2IvevKlN0mDtqjfEH2EHaid6BmqiftYYRy6U1CekfnTEWlNpY4gJEQfsVNOlQ4uY2BkUe8bPPzUPaYVJC+KKtF4WlQyx0aYkJv6vU52hy8pvHQuIly3C8blg/cBrwSdDPTILchgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPTNsywRmJtldvP+4kHBpNhEjCl0lZAmFE3rq2d2Csc=;
 b=ZOx66WBVidClqrq+D2IWRacFZsFqvLTrxy5gsIJ9CX/ASfJ0dFmK0DKCpfkBghKE0qBi2r34/6y8F1mplI7KqzA/WUm1UuU7AEyEt/+5934vG59rMLJu2W+0ncFzU33GGMveCjXBRF3JNjeQL8SC4jJNMYNcpD4ALMPmaWwtQvC0bu6ihhzj3murS6AYRV7rxHM4Vzx8PckgBb/H49/+Q484nCRMa3xYTxGNKCi1TNQT/CELi4Cktpq4028NRn2kzYc7tZW0TDvMfZRuukTxNrXQBWv8efv1a4L16GRIAOT5mh3CRVUMHCA5LJ7oiGUdhgkPvAF7sdDnB01qq5IuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPTNsywRmJtldvP+4kHBpNhEjCl0lZAmFE3rq2d2Csc=;
 b=DmgBj0AU5Fj82qSoctVqmsNT6kIWrtXuxY5YTadED1vv3IhcT7g/woJb6s2yiRSXKfeh9kruRKJHGAHfzSUERKAEbw7Q0/0sDfqvgTjOm/G7juofCPfTgRCHGHNuCcM91XKCnzaGVUWDzy2Wa3F3L1+2vrAvE/9HzeFUUQ8Por4sOsGniRfZ6wRmUv6lcahoZuq2/CNBkFioas81TF0JffeAUNEaYeg8E8x63gCuDirGol2pIJsy8oO0fnMU86UlopQtvck4OhrqUHFh8VihXb3qDwjXPNx7PHYrxD5hU+u1FWDyCmNztJqn8utFjKlDZb1tSNzEw+z8jt47+JHoXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Fri, 1 May
 2026 06:06:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 06:06:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 15:06:40 +0900
Message-Id: <DI74517Q4OTW.TJ4440T9I5EE@nvidia.com>
Subject: Re: [PATCH v2 2/3] rust: bitfield: Add KUNIT tests for bitfield
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-2-23ac400071cb@nvidia.com> <aeBM8fTW46H9RNg7@yury>
In-Reply-To: <aeBM8fTW46H9RNg7@yury>
X-ClientProxiedBy: TYCPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:3::25) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d59f451-6a22-44d3-d206-08dea747d1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ttM2ir3sFMHn0vNNg17Fwxt/Gsqkk8rpp5J2YIlwIrA4n3/4U36QcKjf+X8LtWC0fYNg+1VVaVTYJOg1d8JYGknUkDhDpJfIo9nVy2ql73vNaapbKP5PakNjV/tF1sUVM9bYrlosL1PGpBIDbOF0uzSoXZmPyI1Sp7miFRIA0jTlIac/DmTx/EaXJC+eHlXb3uGwUu1MJbIL6Pq8Hn2q/cXCLZHcprAvJGPDfxZAAgTy9q9OiL/QQwIEfHa1CzysLBvl1wXFz1jWU1iZdwwOV3SMytNg1m32QJn8k4Yzr8rp+yppFzKYqoQeVpzoXJS+qlciq+41scROckFKLrBUbUZx1nr2w4fkhTBSh+h2Erv0kcUW8cO4GGuqQ02GHbzmLR8YzSrwAS8GlKPPGrrAwS04cBnvYf6KKWYjT8+kEL+p8GSJN/v3eJYoYfi4piz/C7zu6/Upv14TB5LiE9sHaQbSTYoOmFbBuYkFUaq8cGh68tGzcPn7ptifx648IT/ZEYE9nKs9R9GphV4/L/XWrTeyW+NLNSq9V09mRD5s1SgTnWWKNnewzsujpVYepMGTqYRuV9L65Ps+b6zow5iiPVn+qIAcNdyNizJfXR17KZPt6f6Rg0vh39zevdOwhP3lLTnJ2BzEq7sTIylLPDhhexT3aYigiDEkol6PrDM43iEmYfEj4uEE5hE1Aoaiv0Hy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NOdHRxMzlkWk45SzR0UWVYZUhDL01CcUx0QXBwNlAwSkgxdi93Qm5sOHNt?=
 =?utf-8?B?OE5tZXNNQXFHbXFJMGt0L0dYZXFFdzcxUE51MGNrMUVBOGZRcmVqeU9MU3pF?=
 =?utf-8?B?YWNXS3JFZFZ0QjB4anFyOW5rY0ZQMHhPcHR5SVFjempXOWMrSVo4cUwwU2hq?=
 =?utf-8?B?QjFFN2lLL3dEM0ROakd6YjlVMllJa01KaDkxTmZZZ3FxbjBuY2J4V29xdHBy?=
 =?utf-8?B?VTRIQVE4dzhtb1BpVXQ0d0t4azdabG5PU0hCRjBlRVFCLytCVFExTE1pU2lw?=
 =?utf-8?B?bGNJTG5DZ3RyN3RsWXgvL3JxNUNQWnlJVHc4aDhka09Hb2ZJdllrT0RybWpR?=
 =?utf-8?B?T2tPazBkekw5TzlMZ2JBUU1DZUg1VGRjeW9KcURXSVNqbnlsVnRLWm0zTml2?=
 =?utf-8?B?WmE2b2wvQ2JrM2Q5RFl6WGhqa1laek94WWk0VU0rK201QkVoSVQ2blVKZ1Nj?=
 =?utf-8?B?cHlSVm5MUVM1V0ZydWluZTFCSm5SWEtHVWlUL3ZxdTl4cjhVYjQ1aEE0RkRJ?=
 =?utf-8?B?VjE5R05NZS9LWmI5NEJhcmRjZ3ZQNTF2VjFyaENpMHNQV3l6S0V6WFcxM0R1?=
 =?utf-8?B?ZXo0ZXN3REdyUGl5ZUdwczdNTG5NMG9oS3RqRjVjVzdTU0lHVit0cWs3c1Nt?=
 =?utf-8?B?OGtZUHFZeWs2a2VzM2dReVpTV0REUlhBWVkzZWVOQ0F4R1MxdTJCTGZLS1F2?=
 =?utf-8?B?NE5GU3JWc2hkb1J4elZnR0tkcHNIUVR2YkNaTkMwWVFRWk16VVNSRW1GRjZZ?=
 =?utf-8?B?T3d0aE1Qb3Rlek9lMGJjMzFMUXRZdkM1NVZYNVRZR05yVk9XTWlLZDB2RDNF?=
 =?utf-8?B?cFdvRjNLbS94V2lzZEs5VWZtS21NY2tXM3NnclR1ZEpqWnprTXpyNm1XaVhZ?=
 =?utf-8?B?VW5Ob25rcjJUaHl0RVVBb3A0VnR1R0ZlckFsUmJTTjkwREY3bjA5aEhTVDhG?=
 =?utf-8?B?Vlh6Uko3VHdmdWRKSERCNFFVL2FrTUNRUC9ISXRweXh6ZnBFc2JQZ3d0bEpC?=
 =?utf-8?B?WnJNUzdzZlk4N0pUbWR3eEpnUmtmTHh6Y1puVktRLzh6WXFCM2R0SmU4Vkda?=
 =?utf-8?B?b1BFTkx1dUxLcFBwOWJHczNZbmRIUjN0SHNuV1ZYMStRMGFoV2lUSWFQNkth?=
 =?utf-8?B?Vnh6YVlWL3YrbHNSQ2VhaDVnZmpRQVBhRmp4b2Zha3pPNDRZSzhNQUJ0Q1JF?=
 =?utf-8?B?bFlseEwyWkJDdGxwV01wbzR0cFR4Kzhvb1JXa0dvaVlRZmFFb1lKbWNxb1VF?=
 =?utf-8?B?blNpU0dyd1JoVmUveVhmQVM1azI2OUU0WlNYWHZTN0NyYWhBa3BKbkowZWxC?=
 =?utf-8?B?OGF6YVZ0endLQXd0UGFwMFlSVXNNcHRRdzRXOUNRcFBuQ3ZEVDA3R2RpYmJU?=
 =?utf-8?B?Qnd2aDh3bXkwOGpGZmdxNDF1Mjg4VHZWREVnUWpkT2xLTThLWnR1WnQ5d2x5?=
 =?utf-8?B?WVZSTFZpQktWMjRrR2N1N21JT3p3czZ3RTRuVCs1aW9kY1pFU2FsN0lzdkJi?=
 =?utf-8?B?M3grbytGcWVnQWFWVlgxSWo0R3NMMkNBMWdRVE9ybHY2L21PdG0rVGtoU3pu?=
 =?utf-8?B?Y2JjWElITmVPRG90RVhEVTJxRS82djVDK0wzZjQ0NzkrU3k1ek1mZ29sM1pT?=
 =?utf-8?B?OXMzMEdpUXVEODFKYmFmblhUeDBLSEZVMmpSU0UydHo3ZURiZXg1d3V4YktR?=
 =?utf-8?B?UERPUzhqb1VsbG44d2JtbGVZYmVVVmxqak9zVXV0bGliTm1wRUNkaHh4TDFE?=
 =?utf-8?B?UytQMkhJeWNGaXNmQlRrQld5VGpubHV2dG1hYldldFJyWXp1N1VNMVpBejAv?=
 =?utf-8?B?UDB4YzZRRE0rNHhVVXh5aU1aMHU4WXhsLzhnWndFVmpiNktNQ09BcnBRUGpV?=
 =?utf-8?B?anhNalVUNktDajl1OXdRNEcrZllJVTFBUCtUem5kdGIzdzhCMy8zTGVnTGVR?=
 =?utf-8?B?cjY2VVMxZlowUjZEb0ROdEg1UU05aHlEbVEvWEFuRm0wUE9uLzZocUNMQ3l2?=
 =?utf-8?B?eDA3YnBPOE9zbnUvZmo1bU1iSUl2My95SlliWUk0UGJHeVgwSlVlWmpaVDBl?=
 =?utf-8?B?emF1NVkwQkhxczJ2MVRaS3d1ZzE4bGQzM2FWNHFOUlZKaXlmdHI2MUc1RGRo?=
 =?utf-8?B?aHh4ZC9GUUJjTUhpQzdLTFluSW53ZVVrVnJxWHVzaWptWWM3cEc5SzhPWGgw?=
 =?utf-8?B?dGtFbllqUTk5SUo3ZFJwdVdTeE0rQnBqb3BQekhBajFjeFBsSnFrZ0xJTEJr?=
 =?utf-8?B?a2V3T081Rlc5NUpRQ1VNbEtPYjdvd1YxOFhzOFZzNE9XQTVDUzBGNzE0UG9j?=
 =?utf-8?B?UFZOaUtsWGlkN0dlTGY3ODdhYlhTWkpBc2Uya0g2cXg1WFgxdnRYMTdaTWJB?=
 =?utf-8?Q?Zsw+sXuP7+bRQagAldA8RF5Gdy9XX34PinJWFPiIu4zdi?=
X-MS-Exchange-AntiSpam-MessageData-1: 0SbbAV2wPAjoNg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d59f451-6a22-44d3-d206-08dea747d1d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 06:06:44.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYjr62XJnfx+0zqO2QB7Jgn8sQ2J+qpaa6BIJGRya7iydiySSnKl3B1ajDe2ySBWMgWvOtVEPbM7ouvvZBQEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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

On Thu Apr 16, 2026 at 11:44 AM JST, Yury Norov wrote:
> On Thu, Apr 09, 2026 at 11:58:48PM +0900, Alexandre Courbot wrote:
>> From: Joel Fernandes <joelagnelf@nvidia.com>
>>=20
>> Add KUNIT tests to make sure the macro is working correctly.
>>=20
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
>> [acourbot: update code to latest bitfield! macro.]
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  rust/kernel/bitfield.rs | 318 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 318 insertions(+)
>>=20
>> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
>> index f5948eec8a76..9ab8dafff36c 100644
>> --- a/rust/kernel/bitfield.rs
>> +++ b/rust/kernel/bitfield.rs
>> @@ -489,3 +489,321 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>=
) -> ::kernel::fmt::Result {
>>          }
>>      };
>>  }
>> +
>> +#[::kernel::macros::kunit_tests(kernel_bitfield)]
>
> Reading the Documentation/rust/testing.rst, and can't understand how
> should one configure it to _not_ build the tests? This should be the
> default behavior.
>
> There's half a dozen already existing unit tests, and I didn't find
> a mechanism to individually control them.

Adding a KConfig option as suggested by Alice.

>
>> +mod tests {
>> +    use core::convert::TryFrom;
>> +
>> +    use pin_init::Zeroable;
>> +
>> +    use kernel::num::Bounded;
>> +
>> +    // Enum types for testing =3D> and ?=3D> conversions
>> +    #[derive(Debug, Clone, Copy, PartialEq)]
>> +    enum MemoryType {
>> +        Unmapped =3D 0,
>> +        Normal =3D 1,
>> +        Device =3D 2,
>> +        Reserved =3D 3,
>> +    }
>> +
>> +    impl TryFrom<Bounded<u64, 4>> for MemoryType {
>> +        type Error =3D u64;
>> +        fn try_from(value: Bounded<u64, 4>) -> Result<Self, Self::Error=
> {
>> +            match value.get() {
>> +                0 =3D> Ok(MemoryType::Unmapped),
>> +                1 =3D> Ok(MemoryType::Normal),
>> +                2 =3D> Ok(MemoryType::Device),
>> +                3 =3D> Ok(MemoryType::Reserved),
>> +                _ =3D> Err(value.get()),
>> +            }
>> +        }
>> +    }
>> +
>> +    impl From<MemoryType> for Bounded<u64, 4> {
>> +        fn from(mt: MemoryType) -> Bounded<u64, 4> {
>> +            Bounded::from_expr(mt as u64)
>> +        }
>> +    }
>> +
>> +    #[derive(Debug, Clone, Copy, PartialEq)]
>> +    enum Priority {
>> +        Low =3D 0,
>> +        Medium =3D 1,
>> +        High =3D 2,
>> +        Critical =3D 3,
>> +    }
>> +
>> +    impl From<Bounded<u16, 2>> for Priority {
>> +        fn from(value: Bounded<u16, 2>) -> Self {
>> +            match value & 0x3 {
>> +                0 =3D> Priority::Low,
>> +                1 =3D> Priority::Medium,
>> +                2 =3D> Priority::High,
>> +                _ =3D> Priority::Critical,
>> +            }
>> +        }
>> +    }
>> +
>> +    impl From<Priority> for Bounded<u16, 2> {
>> +        fn from(p: Priority) -> Bounded<u16, 2> {
>> +            Bounded::from_expr(p as u16)
>> +        }
>> +    }
>> +
>> +    bitfield! {
>> +        struct TestPageTableEntry(u64) {
>> +            0:0       present;
>> +            1:1       writable;
>> +            11:9      available;
>> +            15:12     mem_type ?=3D> MemoryType;
>> +            51:16     pfn;
>> +            61:52     available2;
>
> Nit:
>
> In the first patch you keep the high-to-low order, can you do the same
> here:
>
>             61:52     available2;
>             51:16     pfn;
>             15:12     mem_type ?=3D> MemoryType;
>             ...

Indeed - done.

>
>> +        }
>> +    }
>> +
>> +    bitfield! {
>> +        struct TestControlRegister(u16) {
>> +            0:0       enable;
>> +            3:1       mode;
>> +            5:4       priority =3D> Priority;
>> +            7:4       priority_nibble;
>> +            15:8      channel;
>> +        }
>> +    }
>> +
>> +    bitfield! {
>> +        struct TestStatusRegister(u8) {
>> +            0:0       ready;
>> +            1:1       error;
>> +            3:2       state;
>> +            7:4       reserved;
>> +            7:0       full_byte;  // For entire register
>> +        }
>> +    }
>> +
>> +    #[test]
>> +    fn test_single_bits() {
>> +        let mut pte =3D TestPageTableEntry::zeroed();
>> +
>> +        assert!(!pte.present().into_bool());
>> +        assert!(!pte.writable().into_bool());
>> +        assert_eq!(u64::from(pte), 0x0);
>> +
>> +        pte =3D pte.with_present(true);
>> +        assert!(pte.present().into_bool());
>> +        assert_eq!(u64::from(pte), 0x1);
>> +
>> +        pte =3D pte.with_writable(true);
>> +        assert!(pte.writable().into_bool());
>> +        assert_eq!(u64::from(pte), 0x3);
>> +
>> +        pte =3D pte.with_writable(false);
>> +        assert!(!pte.writable().into_bool());
>> +        assert_eq!(u64::from(pte), 0x1);
>> +
>> +        assert_eq!(pte.available(), 0);
>> +        pte =3D pte.with_const_available::<0x5>();
>> +        assert_eq!(pte.available(), 0x5);
>> +        assert_eq!(u64::from(pte), 0xA01);
>> +    }
>> +
>> +    #[test]
>> +    fn test_range_fields() {
>> +        let mut pte =3D TestPageTableEntry::zeroed();
>> +        assert_eq!(u64::from(pte), 0x0);
>> +
>> +        pte =3D pte.with_const_pfn::<0x123456>();
>> +        assert_eq!(pte.pfn(), 0x123456);
>> +        assert_eq!(u64::from(pte), 0x1234560000);
>> +
>> +        pte =3D pte.with_const_available::<0x7>();
>> +        assert_eq!(pte.available(), 0x7);
>> +        assert_eq!(u64::from(pte), 0x1234560E00);
>> +
>> +        pte =3D pte.with_const_available2::<0x3FF>();
>> +        assert_eq!(pte.available2(), 0x3FF);
>> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_0E00u64);
>> +
>> +        // Test TryFrom with ?=3D> for MemoryType
>> +        pte =3D pte.with_mem_type(MemoryType::Device);
>> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Device));
>> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_2E00u64);
>> +
>> +        pte =3D pte.with_mem_type(MemoryType::Normal);
>> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Normal));
>> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_1E00u64);
>> +
>> +        // Test all valid values for mem_type
>> +        pte =3D pte.with_mem_type(MemoryType::Reserved);
>> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
>> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_3E00u64);
>> +
>> +        // Test failure case using mem_type field which has 4 bits (0-1=
5)
>> +        // MemoryType only handles 0-3, so values 4-15 should return Er=
r
>> +        let mut raw =3D pte.into_raw();
>> +        // Set bits 15:12 to 7 (invalid for MemoryType)
>> +        raw =3D (raw & !::kernel::bits::genmask_u64(12..=3D15)) | (0x7 =
<< 12);
>> +        let invalid_pte =3D TestPageTableEntry::from_raw(raw);
>> +        // Should return Err with the invalid value
>> +        assert_eq!(invalid_pte.mem_type(), Err(0x7));
>> +
>> +        // Test a valid value after testing invalid to ensure both case=
s work
>> +        // Set bits 15:12 to 2 (valid: Device)
>> +        raw =3D (raw & !::kernel::bits::genmask_u64(12..=3D15)) | (0x2 =
<< 12);
>> +        let valid_pte =3D TestPageTableEntry::from_raw(raw);
>> +        assert_eq!(valid_pte.mem_type(), Ok(MemoryType::Device));
>> +
>> +        const MAX_PFN: u64 =3D ::kernel::bits::genmask_u64(0..=3D35);
>> +        pte =3D pte.with_const_pfn::<{ MAX_PFN }>();
>> +        assert_eq!(pte.pfn(), MAX_PFN);
>> +    }
>> +
>> +    #[test]
>> +    fn test_builder_pattern() {
>> +        let pte =3D TestPageTableEntry::zeroed()
>> +            .with_present(true)
>> +            .with_writable(true)
>> +            .with_const_available::<0x7>()
>> +            .with_const_pfn::<0xABCDEF>()
>> +            .with_mem_type(MemoryType::Reserved)
>> +            .with_const_available2::<0x3FF>();
>> +
>> +        assert!(pte.present().into_bool());
>> +        assert!(pte.writable().into_bool());
>> +        assert_eq!(pte.available(), 0x7);
>> +        assert_eq!(pte.pfn(), 0xABCDEF);
>> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
>> +        assert_eq!(pte.available2(), 0x3FF);
>> +    }
>> +
>> +    #[test]
>> +    fn test_raw_operations() {
>> +        let raw_value =3D 0x3FF0000031233E03u64;
>> +
>> +        let pte =3D TestPageTableEntry::from_raw(raw_value);
>> +        assert_eq!(u64::from(pte), raw_value);
>> +
>> +        assert!(pte.present().into_bool());
>> +        assert!(pte.writable().into_bool());
>> +        assert_eq!(pte.available(), 0x7);
>> +        assert_eq!(pte.pfn(), 0x3123);
>> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
>> +        assert_eq!(pte.available2(), 0x3FF);
>> +
>> +        // Test using direct constructor syntax TestStruct(value)
>> +        let pte2 =3D TestPageTableEntry::from_raw(raw_value);
>> +        assert_eq!(u64::from(pte2), raw_value);
>
> So what about bits not belonging to any field, like 8:2 in this case?
> Are they RAZ, undef or not touched by any method except the raw
> setters?
>
> Can you discuss and add a test for it?

Added a paragraph with a test in the doccomment.

>
>> +    }
>> +
>> +    #[test]
>> +    fn test_u16_bitfield() {
>> +        let mut ctrl =3D TestControlRegister::zeroed();
>> +
>> +        assert!(!ctrl.enable().into_bool());
>> +        assert_eq!(ctrl.mode(), 0);
>> +        assert_eq!(ctrl.priority(), Priority::Low);
>> +        assert_eq!(ctrl.priority_nibble(), 0);
>> +        assert_eq!(ctrl.channel(), 0);
>> +
>> +        ctrl =3D ctrl.with_enable(true);
>> +        assert!(ctrl.enable().into_bool());
>> +
>> +        ctrl =3D ctrl.with_const_mode::<0x5>();
>> +        assert_eq!(ctrl.mode(), 0x5);
>> +
>> +        // Test From conversion with =3D>
>> +        ctrl =3D ctrl.with_priority(Priority::High);
>> +        assert_eq!(ctrl.priority(), Priority::High);
>> +        assert_eq!(ctrl.priority_nibble(), 0x2); // High =3D 2 in bits =
5:4
>> +
>> +        ctrl =3D ctrl.with_channel(0xAB);
>> +        assert_eq!(ctrl.channel(), 0xAB);
>> +
>> +        // Test overlapping fields
>> +        ctrl =3D ctrl.with_const_priority_nibble::<0xF>();
>> +        assert_eq!(ctrl.priority_nibble(), 0xF);
>> +        assert_eq!(ctrl.priority(), Priority::Critical); // bits 5:4 =
=3D 0x3
>> +
>> +        let ctrl2 =3D TestControlRegister::zeroed()
>> +            .with_enable(true)
>> +            .with_const_mode::<0x3>()
>> +            .with_priority(Priority::Medium)
>> +            .with_channel(0x42);
>> +
>> +        assert!(ctrl2.enable().into_bool());
>> +        assert_eq!(ctrl2.mode(), 0x3);
>> +        assert_eq!(ctrl2.priority(), Priority::Medium);
>> +        assert_eq!(ctrl2.channel(), 0x42);
>> +
>> +        let raw_value: u16 =3D 0x4217;
>> +        let ctrl3 =3D TestControlRegister::from_raw(raw_value);
>> +        assert_eq!(u16::from(ctrl3), raw_value);
>> +        assert!(ctrl3.enable().into_bool());
>> +        assert_eq!(ctrl3.priority(), Priority::Medium);
>> +        assert_eq!(ctrl3.priority_nibble(), 0x1);
>> +        assert_eq!(ctrl3.channel(), 0x42);
>> +    }
>> +
>> +    #[test]
>> +    fn test_u8_bitfield() {
>> +        let mut status =3D TestStatusRegister::zeroed();
>> +
>> +        assert!(!status.ready().into_bool());
>> +        assert!(!status.error().into_bool());
>> +        assert_eq!(status.state(), 0);
>> +        assert_eq!(status.reserved(), 0);
>> +        assert_eq!(status.full_byte(), 0);
>> +
>> +        status =3D status.with_ready(true);
>> +        assert!(status.ready().into_bool());
>> +        assert_eq!(status.full_byte(), 0x01);
>> +
>> +        status =3D status.with_error(true);
>> +        assert!(status.error().into_bool());
>> +        assert_eq!(status.full_byte(), 0x03);
>> +
>> +        status =3D status.with_const_state::<0x3>();
>> +        assert_eq!(status.state(), 0x3);
>> +        assert_eq!(status.full_byte(), 0x0F);
>> +
>> +        status =3D status.with_const_reserved::<0xA>();
>> +        assert_eq!(status.reserved(), 0xA);
>> +        assert_eq!(status.full_byte(), 0xAF);
>> +
>> +        // Test overlapping field
>> +        status =3D status.with_full_byte(0x55);
>> +        assert_eq!(status.full_byte(), 0x55);
>> +        assert!(status.ready().into_bool());
>> +        assert!(!status.error().into_bool());
>> +        assert_eq!(status.state(), 0x1);
>> +        assert_eq!(status.reserved(), 0x5);
>> +
>> +        let status2 =3D TestStatusRegister::zeroed()
>> +            .with_ready(true)
>> +            .with_const_state::<0x2>()
>> +            .with_const_reserved::<0x5>();
>> +
>> +        assert!(status2.ready().into_bool());
>> +        assert!(!status2.error().into_bool());
>> +        assert_eq!(status2.state(), 0x2);
>> +        assert_eq!(status2.reserved(), 0x5);
>> +        assert_eq!(status2.full_byte(), 0x59);
>> +
>> +        let raw_value: u8 =3D 0x59;
>> +        let status3 =3D TestStatusRegister::from_raw(raw_value);
>> +        assert_eq!(u8::from(status3), raw_value);
>> +        assert!(status3.ready().into_bool());
>> +        assert!(!status3.error().into_bool());
>> +        assert_eq!(status3.state(), 0x2);
>> +        assert_eq!(status3.reserved(), 0x5);
>> +        assert_eq!(status3.full_byte(), 0x59);
>> +
>> +        let status4 =3D TestStatusRegister::from_raw(0xFF);
>> +        assert!(status4.ready().into_bool());
>> +        assert!(status4.error().into_bool());
>> +        assert_eq!(status4.state(), 0x3);
>> +        assert_eq!(status4.reserved(), 0xF);
>> +        assert_eq!(status4.full_byte(), 0xFF);
>
> Does it support signed fields? I recall there was a discussion about it.
> If yes, can you add a test? The underlying Bounded does, so I think the
> bitfield should do so. Can I save -EFAULT in a 16-bit IMM field? This is
> what EX_TYPE_EFAULT_REG does in arch/x86/include/asm/extable_fixup_types.=
h.

Signed fields would be tricky to support properly. For now it is better
to assume that storage types and fields are all unsigned, and fields
being signed would require explicit handling, through e.g. the `=3D>`
conversion operator.
