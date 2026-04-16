Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D813AF433D8
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2B810E03D;
	Thu, 16 Apr 2026 02:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VydkonFO";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31FA10E03D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 02:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUpbxkNZhqXVFiuQUNB3DY7/TzOQOOWmxFEJELzGLlTvoiMj+GnB8YpUgshhKVaBfgPqiraDtvAjGOnla20K2fsqfbq/sqCE4ficfovRP65JmNrcyrHBRo5uiKhZ4vTUScBHsMAjoRH4Zmq2rvZbUp9KgIDqsSSWI6OC2AhC4223QEQJiESGcC4iCOjBXYc4I42v0gsfNwkWDJXDB4qasQqufiGCa4p2p1Nsx9pxwD5fGnG31iGQKVWFa7sff841Nvui5N7u//BqJx3ZhWqepURT56UWLoDQ2bf0W/MTJ1xeI1++Ewux5hznbCsr9aNtR28H5Gb/1aYsmCJPlisyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcMWJHuuDTTjOXlh5DCr+wmVIXJLG97kwiVXoaxmvH4=;
 b=JWYg0Z/zutDTujHtY9CqPGcsQjvdv29fH7NbgRcZL5sbJtuI1CcbmymLdCRV3DL8SMZ5ZDSQxKqGJr9hfrAeTIrSZooEpHbzHL6xAawher8yaZ317mdxHNk8dGQVY7El1jW6cXLGzEc0wg2RoNdV7Ar9arpVUunKkyrsNfCk9A5NZIvbFCl6998PDE36Mid5pZEd0qYqklyuSpXygGQjzpzUuOPLkekJQeYX0Hz/Xi/jppjdffiarPeu/yTFkdx7HOGh7xu6h8StyKD3j3L9i3rv6ROUNjfG8L6j3GQ+dvLRFphd9/UhIIZiwghhC/Z3ketmMAbnG9pwjN4I6ihkLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcMWJHuuDTTjOXlh5DCr+wmVIXJLG97kwiVXoaxmvH4=;
 b=VydkonFOeMvhMfB/ytyCizOZvtOx+uF54Q/Z4yI8UOQcG2wCVS1CHXk1Ke49gq0ftXq6Vm2BuC2I62R16+sRH70IWIjDYA1lkPOy2+eJoQy7aO1lYxTNv7nI9SIKfDffeSDdCAEbWyVqt53Fw21uilZjKev4zhB4xYlHsJKI81SALRK6aQy1GgaP67Jrlu1jzHvn0PogKlEB/3QBSUCXf2NXweLBgIbRTRL4Qv5AV0i1ySqtts0uD+cJHgEYwhMZ1BfDr99Gv3AKbRpjAD5Wc1yCMWQYtV0FeDmbmqhcDV9C3EYYmmPBm+sHcG4YaCeZDh9lvfiNTC9ZGXpxxiw4QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 02:44:04 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 02:44:03 +0000
Date: Wed, 15 Apr 2026 22:44:01 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/3] rust: bitfield: Add KUNIT tests for bitfield
Message-ID: <aeBM8fTW46H9RNg7@yury>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-2-23ac400071cb@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-bitfield-v2-2-23ac400071cb@nvidia.com>
X-ClientProxiedBy: BN1PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:408:e0::22) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ab470e-e81a-434b-075f-08de9b620589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MNaqZ78FgC3sNsWj1sI+8z26Ag+2TamhdXZLctoC4ffZjTWkUnZVumf/ksp7WdKnE8DlUo5R1M7BHoLrIwhCTviIoM/8oMAkrk5Ve9b0iiSNd2MOP3w+HP13PKqqXYPa8/6PfRSGXoIGbrjW5J9RkHEVK9riudHfVmoobxikuCjFw5/Rvu5U9i+HES4/l1YSRyVR4mA6mSQ1fvuGQdgLxS0amgk7wFvNj9Y7mojgM9SpLIuwa+0w+Zk1zAVkoRilJ2bfjCCwgTUJ7x9PvkD0ks7qITYF9/BcpjF8/k7O0Awe3RSpQIRKBU1/dSWH094b4wJs8jJ8qSADnY9YEXnmFV5DwIx/3+E38E6n9Ozys4pgYS30DXaBXPwIN2siEDrFk9OXYXPtSHaPrgGQWrOHfjIHA/i4FjHhZKIkpy8U4hc8aMLHTvTxUxId5d4O5hjMw2U0l8mpTlh6sXszOgnmkpwTIu1o9FPIyz2VCJ0d8Tapz6iQ7y7kjcuInhLsOUG72uc+DDcfCkYeV+/q/gzoCPE3XghVobamJe/ChyDkdg5w1UAOjUaJSqdoWge50HX5Qu2Qbo8tDsNypvwM69OahR1yZPU+3TCg7tKVD8wVnj2Z5vrRvoVCLdl2Vb6znOirPdKuq1Eqz3KSIKHl0i17SeqEV3HJc65BbWDUi6N0CYFcwtrdHIkGrGrZWvm1vxBmF+UdJuV/phOY4TWDvgY8Q0S9bWfHAQvDhUVH4VW0M08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8300.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNbba9yko21DaAJcyRNFWKUb5q5e2CJJb3QdVo3IH/UmBV7D9fWA11RoVnpm?=
 =?us-ascii?Q?jI0adZbPBmyFbgjWcCE6in79seKi4JNKpg/hPAbFuCPPMaHE40SIzeP+LDrE?=
 =?us-ascii?Q?XzYkW7QDkhUvDclWtajQF45qPrWii9bu46u4RVK72LRDl9ymmY1w7MrNZS6x?=
 =?us-ascii?Q?dbtrTHZh+uasy85dqQOhwNpVBDImrTHWeG38jOmOJBFi5RzYbpXu+Rfls0OV?=
 =?us-ascii?Q?dj64b+RO+DYK3zS9sqwRbNVOvo7v/bWaXFTTNKNHZqhFAY7WIX/DTerP9M5Z?=
 =?us-ascii?Q?43x39+h98udEa/od21rn6GMRbT35Gy3ohVjC1XLNhWN8SxPg7enWjjavxh5h?=
 =?us-ascii?Q?esn+xskMR9cMfpaKFImLBdDV24mZYc2IIHOvox74vjtI5tTRP/giWzIRnYBF?=
 =?us-ascii?Q?K/v7Tpz0VgFjGgDGPuxLUB2iqoM4Qk+wfG0UTAoJc8t0/vYPepycDe0wPP/c?=
 =?us-ascii?Q?oh9+acTx/tzuIzB8gSR154F+gjm51/EuWSMZlRgAaK18gKqvhqqRVRFO+gHX?=
 =?us-ascii?Q?hMF2NyH/0FREb1DwWvKzpCob3ns7iJsuZHh1050V3N+5uSzpfLPTFleQRbMU?=
 =?us-ascii?Q?m0i7XmJZtNF1DyvF12Tmb4K2KEZwAHjdslOqJuteZxeM+ere0YftamFU6KYy?=
 =?us-ascii?Q?/5OL1ssjpRfKPVGcSl2lmiZTIcv4uzNX2amJ3d1a/86xRcSOKeJ6y6YIhwjA?=
 =?us-ascii?Q?0O1Mza4n680HH7DICx2LlKb/Qi5WxCIs6f3jIj5Jch6Hs0MW0N/69TC/d5l4?=
 =?us-ascii?Q?zpT1bPVMsoUt9pXcGL+QF/jwnmWoMdTBQD4mzaQxO2PoQXjIGWgDg0/cjkUk?=
 =?us-ascii?Q?vM63DuKLTDUXHOhvo2qLk48QcU40Qhx4YdTheXOC7VtDh5UauXg2llMxs/Tf?=
 =?us-ascii?Q?SvZ2VFe1dIKrZZKOYurqNc9XYODhZooE7a2brDfOUt4InZPCKTAl3fS0rfKQ?=
 =?us-ascii?Q?qiEACpDupapUlZbUl+BY5H7bFYU9yUaqdoJjp9qxzSlfZi7YBF4ASzBuHH7X?=
 =?us-ascii?Q?ttye5omrNNTOXUQPu+ncjA4/xxgh9pKIBJfvq35cDk+PN+PgRMXX6jIwSGsc?=
 =?us-ascii?Q?6zux0IhSo5SksWLSo1U4SyM1IBNdkvi45kfkUSEV1L1mi4YkbvyMXtBj8n4B?=
 =?us-ascii?Q?Cc/9ljbdSkiggqCevB830COWdLzBdxQa+xpWicLV4JGEyB9aa2HQ/w+YPR/A?=
 =?us-ascii?Q?GNTWpr7jE9lTzXxoqDcr3eYtcCXtT4d8T6GH45fJYeHnKm4L2f8xfwJcDweV?=
 =?us-ascii?Q?ZvARRyEmTnl+M37B2KNvKECN0Fo+D+COh+nDR2VX5XyIiSGMFM7I/HlITWe3?=
 =?us-ascii?Q?IoZazC34n+mYZPzMH5vwzQBDeChlcxAzGf609XgmO04aruOoLVZLOaCS6b+G?=
 =?us-ascii?Q?FaTbiSLetnuE/7uVWCoM9m3cbXeKpdq3t32oCdndnZbu62fxNDf3m8wUdunH?=
 =?us-ascii?Q?Qowfz3tGgijkrqANl/EN7o56/a9Use746HB9Z1F7HuJrzk7hsqWUdy6NzPzn?=
 =?us-ascii?Q?sE77CGwDiJ5v0CGFRchA09QXv+hunOWX4QJH5QnxFoMY57I20ckIevB6sBPO?=
 =?us-ascii?Q?MeHb4ABrOVE1KyzonpCbQ6RAlnhuV8OTmq7GjKY64rctgWCHsyE4/5Je1cg9?=
 =?us-ascii?Q?L5kUt6xnY0gWgmAppmrG/W3EBfN0HQxO+EYXGbS4dPOrW9vgD7ZSLf6wKL+z?=
 =?us-ascii?Q?c8zEYDo3Fp9e9gk0obLSqC55+PhJnGv8Zw6qDW0krIPSToLJHADL4gQGg1xX?=
 =?us-ascii?Q?2flMNC838QToPWxO2Y6gYv1BYEZjBYDoKETT112PRvc00R3tOI8X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ab470e-e81a-434b-075f-08de9b620589
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 02:44:03.7965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07Ay2tjilveTn66hq5E6kFRO7tzWjgAMJb1DezgeE8IEWXi9OiIxEIcqNlLZmE8F8CqStUg1tq3eLEfrt0HZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

On Thu, Apr 09, 2026 at 11:58:48PM +0900, Alexandre Courbot wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Add KUNIT tests to make sure the macro is working correctly.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> [acourbot: update code to latest bitfield! macro.]
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/bitfield.rs | 318 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 318 insertions(+)
> 
> diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> index f5948eec8a76..9ab8dafff36c 100644
> --- a/rust/kernel/bitfield.rs
> +++ b/rust/kernel/bitfield.rs
> @@ -489,3 +489,321 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
>          }
>      };
>  }
> +
> +#[::kernel::macros::kunit_tests(kernel_bitfield)]

Reading the Documentation/rust/testing.rst, and can't understand how
should one configure it to _not_ build the tests? This should be the
default behavior.

There's half a dozen already existing unit tests, and I didn't find
a mechanism to individually control them.

> +mod tests {
> +    use core::convert::TryFrom;
> +
> +    use pin_init::Zeroable;
> +
> +    use kernel::num::Bounded;
> +
> +    // Enum types for testing => and ?=> conversions
> +    #[derive(Debug, Clone, Copy, PartialEq)]
> +    enum MemoryType {
> +        Unmapped = 0,
> +        Normal = 1,
> +        Device = 2,
> +        Reserved = 3,
> +    }
> +
> +    impl TryFrom<Bounded<u64, 4>> for MemoryType {
> +        type Error = u64;
> +        fn try_from(value: Bounded<u64, 4>) -> Result<Self, Self::Error> {
> +            match value.get() {
> +                0 => Ok(MemoryType::Unmapped),
> +                1 => Ok(MemoryType::Normal),
> +                2 => Ok(MemoryType::Device),
> +                3 => Ok(MemoryType::Reserved),
> +                _ => Err(value.get()),
> +            }
> +        }
> +    }
> +
> +    impl From<MemoryType> for Bounded<u64, 4> {
> +        fn from(mt: MemoryType) -> Bounded<u64, 4> {
> +            Bounded::from_expr(mt as u64)
> +        }
> +    }
> +
> +    #[derive(Debug, Clone, Copy, PartialEq)]
> +    enum Priority {
> +        Low = 0,
> +        Medium = 1,
> +        High = 2,
> +        Critical = 3,
> +    }
> +
> +    impl From<Bounded<u16, 2>> for Priority {
> +        fn from(value: Bounded<u16, 2>) -> Self {
> +            match value & 0x3 {
> +                0 => Priority::Low,
> +                1 => Priority::Medium,
> +                2 => Priority::High,
> +                _ => Priority::Critical,
> +            }
> +        }
> +    }
> +
> +    impl From<Priority> for Bounded<u16, 2> {
> +        fn from(p: Priority) -> Bounded<u16, 2> {
> +            Bounded::from_expr(p as u16)
> +        }
> +    }
> +
> +    bitfield! {
> +        struct TestPageTableEntry(u64) {
> +            0:0       present;
> +            1:1       writable;
> +            11:9      available;
> +            15:12     mem_type ?=> MemoryType;
> +            51:16     pfn;
> +            61:52     available2;

Nit:

In the first patch you keep the high-to-low order, can you do the same
here:

            61:52     available2;
            51:16     pfn;
            15:12     mem_type ?=> MemoryType;
            ...

> +        }
> +    }
> +
> +    bitfield! {
> +        struct TestControlRegister(u16) {
> +            0:0       enable;
> +            3:1       mode;
> +            5:4       priority => Priority;
> +            7:4       priority_nibble;
> +            15:8      channel;
> +        }
> +    }
> +
> +    bitfield! {
> +        struct TestStatusRegister(u8) {
> +            0:0       ready;
> +            1:1       error;
> +            3:2       state;
> +            7:4       reserved;
> +            7:0       full_byte;  // For entire register
> +        }
> +    }
> +
> +    #[test]
> +    fn test_single_bits() {
> +        let mut pte = TestPageTableEntry::zeroed();
> +
> +        assert!(!pte.present().into_bool());
> +        assert!(!pte.writable().into_bool());
> +        assert_eq!(u64::from(pte), 0x0);
> +
> +        pte = pte.with_present(true);
> +        assert!(pte.present().into_bool());
> +        assert_eq!(u64::from(pte), 0x1);
> +
> +        pte = pte.with_writable(true);
> +        assert!(pte.writable().into_bool());
> +        assert_eq!(u64::from(pte), 0x3);
> +
> +        pte = pte.with_writable(false);
> +        assert!(!pte.writable().into_bool());
> +        assert_eq!(u64::from(pte), 0x1);
> +
> +        assert_eq!(pte.available(), 0);
> +        pte = pte.with_const_available::<0x5>();
> +        assert_eq!(pte.available(), 0x5);
> +        assert_eq!(u64::from(pte), 0xA01);
> +    }
> +
> +    #[test]
> +    fn test_range_fields() {
> +        let mut pte = TestPageTableEntry::zeroed();
> +        assert_eq!(u64::from(pte), 0x0);
> +
> +        pte = pte.with_const_pfn::<0x123456>();
> +        assert_eq!(pte.pfn(), 0x123456);
> +        assert_eq!(u64::from(pte), 0x1234560000);
> +
> +        pte = pte.with_const_available::<0x7>();
> +        assert_eq!(pte.available(), 0x7);
> +        assert_eq!(u64::from(pte), 0x1234560E00);
> +
> +        pte = pte.with_const_available2::<0x3FF>();
> +        assert_eq!(pte.available2(), 0x3FF);
> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_0E00u64);
> +
> +        // Test TryFrom with ?=> for MemoryType
> +        pte = pte.with_mem_type(MemoryType::Device);
> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Device));
> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_2E00u64);
> +
> +        pte = pte.with_mem_type(MemoryType::Normal);
> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Normal));
> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_1E00u64);
> +
> +        // Test all valid values for mem_type
> +        pte = pte.with_mem_type(MemoryType::Reserved);
> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
> +        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_3E00u64);
> +
> +        // Test failure case using mem_type field which has 4 bits (0-15)
> +        // MemoryType only handles 0-3, so values 4-15 should return Err
> +        let mut raw = pte.into_raw();
> +        // Set bits 15:12 to 7 (invalid for MemoryType)
> +        raw = (raw & !::kernel::bits::genmask_u64(12..=15)) | (0x7 << 12);
> +        let invalid_pte = TestPageTableEntry::from_raw(raw);
> +        // Should return Err with the invalid value
> +        assert_eq!(invalid_pte.mem_type(), Err(0x7));
> +
> +        // Test a valid value after testing invalid to ensure both cases work
> +        // Set bits 15:12 to 2 (valid: Device)
> +        raw = (raw & !::kernel::bits::genmask_u64(12..=15)) | (0x2 << 12);
> +        let valid_pte = TestPageTableEntry::from_raw(raw);
> +        assert_eq!(valid_pte.mem_type(), Ok(MemoryType::Device));
> +
> +        const MAX_PFN: u64 = ::kernel::bits::genmask_u64(0..=35);
> +        pte = pte.with_const_pfn::<{ MAX_PFN }>();
> +        assert_eq!(pte.pfn(), MAX_PFN);
> +    }
> +
> +    #[test]
> +    fn test_builder_pattern() {
> +        let pte = TestPageTableEntry::zeroed()
> +            .with_present(true)
> +            .with_writable(true)
> +            .with_const_available::<0x7>()
> +            .with_const_pfn::<0xABCDEF>()
> +            .with_mem_type(MemoryType::Reserved)
> +            .with_const_available2::<0x3FF>();
> +
> +        assert!(pte.present().into_bool());
> +        assert!(pte.writable().into_bool());
> +        assert_eq!(pte.available(), 0x7);
> +        assert_eq!(pte.pfn(), 0xABCDEF);
> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
> +        assert_eq!(pte.available2(), 0x3FF);
> +    }
> +
> +    #[test]
> +    fn test_raw_operations() {
> +        let raw_value = 0x3FF0000031233E03u64;
> +
> +        let pte = TestPageTableEntry::from_raw(raw_value);
> +        assert_eq!(u64::from(pte), raw_value);
> +
> +        assert!(pte.present().into_bool());
> +        assert!(pte.writable().into_bool());
> +        assert_eq!(pte.available(), 0x7);
> +        assert_eq!(pte.pfn(), 0x3123);
> +        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
> +        assert_eq!(pte.available2(), 0x3FF);
> +
> +        // Test using direct constructor syntax TestStruct(value)
> +        let pte2 = TestPageTableEntry::from_raw(raw_value);
> +        assert_eq!(u64::from(pte2), raw_value);

So what about bits not belonging to any field, like 8:2 in this case?
Are they RAZ, undef or not touched by any method except the raw
setters?

Can you discuss and add a test for it?

> +    }
> +
> +    #[test]
> +    fn test_u16_bitfield() {
> +        let mut ctrl = TestControlRegister::zeroed();
> +
> +        assert!(!ctrl.enable().into_bool());
> +        assert_eq!(ctrl.mode(), 0);
> +        assert_eq!(ctrl.priority(), Priority::Low);
> +        assert_eq!(ctrl.priority_nibble(), 0);
> +        assert_eq!(ctrl.channel(), 0);
> +
> +        ctrl = ctrl.with_enable(true);
> +        assert!(ctrl.enable().into_bool());
> +
> +        ctrl = ctrl.with_const_mode::<0x5>();
> +        assert_eq!(ctrl.mode(), 0x5);
> +
> +        // Test From conversion with =>
> +        ctrl = ctrl.with_priority(Priority::High);
> +        assert_eq!(ctrl.priority(), Priority::High);
> +        assert_eq!(ctrl.priority_nibble(), 0x2); // High = 2 in bits 5:4
> +
> +        ctrl = ctrl.with_channel(0xAB);
> +        assert_eq!(ctrl.channel(), 0xAB);
> +
> +        // Test overlapping fields
> +        ctrl = ctrl.with_const_priority_nibble::<0xF>();
> +        assert_eq!(ctrl.priority_nibble(), 0xF);
> +        assert_eq!(ctrl.priority(), Priority::Critical); // bits 5:4 = 0x3
> +
> +        let ctrl2 = TestControlRegister::zeroed()
> +            .with_enable(true)
> +            .with_const_mode::<0x3>()
> +            .with_priority(Priority::Medium)
> +            .with_channel(0x42);
> +
> +        assert!(ctrl2.enable().into_bool());
> +        assert_eq!(ctrl2.mode(), 0x3);
> +        assert_eq!(ctrl2.priority(), Priority::Medium);
> +        assert_eq!(ctrl2.channel(), 0x42);
> +
> +        let raw_value: u16 = 0x4217;
> +        let ctrl3 = TestControlRegister::from_raw(raw_value);
> +        assert_eq!(u16::from(ctrl3), raw_value);
> +        assert!(ctrl3.enable().into_bool());
> +        assert_eq!(ctrl3.priority(), Priority::Medium);
> +        assert_eq!(ctrl3.priority_nibble(), 0x1);
> +        assert_eq!(ctrl3.channel(), 0x42);
> +    }
> +
> +    #[test]
> +    fn test_u8_bitfield() {
> +        let mut status = TestStatusRegister::zeroed();
> +
> +        assert!(!status.ready().into_bool());
> +        assert!(!status.error().into_bool());
> +        assert_eq!(status.state(), 0);
> +        assert_eq!(status.reserved(), 0);
> +        assert_eq!(status.full_byte(), 0);
> +
> +        status = status.with_ready(true);
> +        assert!(status.ready().into_bool());
> +        assert_eq!(status.full_byte(), 0x01);
> +
> +        status = status.with_error(true);
> +        assert!(status.error().into_bool());
> +        assert_eq!(status.full_byte(), 0x03);
> +
> +        status = status.with_const_state::<0x3>();
> +        assert_eq!(status.state(), 0x3);
> +        assert_eq!(status.full_byte(), 0x0F);
> +
> +        status = status.with_const_reserved::<0xA>();
> +        assert_eq!(status.reserved(), 0xA);
> +        assert_eq!(status.full_byte(), 0xAF);
> +
> +        // Test overlapping field
> +        status = status.with_full_byte(0x55);
> +        assert_eq!(status.full_byte(), 0x55);
> +        assert!(status.ready().into_bool());
> +        assert!(!status.error().into_bool());
> +        assert_eq!(status.state(), 0x1);
> +        assert_eq!(status.reserved(), 0x5);
> +
> +        let status2 = TestStatusRegister::zeroed()
> +            .with_ready(true)
> +            .with_const_state::<0x2>()
> +            .with_const_reserved::<0x5>();
> +
> +        assert!(status2.ready().into_bool());
> +        assert!(!status2.error().into_bool());
> +        assert_eq!(status2.state(), 0x2);
> +        assert_eq!(status2.reserved(), 0x5);
> +        assert_eq!(status2.full_byte(), 0x59);
> +
> +        let raw_value: u8 = 0x59;
> +        let status3 = TestStatusRegister::from_raw(raw_value);
> +        assert_eq!(u8::from(status3), raw_value);
> +        assert!(status3.ready().into_bool());
> +        assert!(!status3.error().into_bool());
> +        assert_eq!(status3.state(), 0x2);
> +        assert_eq!(status3.reserved(), 0x5);
> +        assert_eq!(status3.full_byte(), 0x59);
> +
> +        let status4 = TestStatusRegister::from_raw(0xFF);
> +        assert!(status4.ready().into_bool());
> +        assert!(status4.error().into_bool());
> +        assert_eq!(status4.state(), 0x3);
> +        assert_eq!(status4.reserved(), 0xF);
> +        assert_eq!(status4.full_byte(), 0xFF);

Does it support signed fields? I recall there was a discussion about it.
If yes, can you add a test? The underlying Bounded does, so I think the
bitfield should do so. Can I save -EFAULT in a 16-bit IMM field? This is
what EX_TYPE_EFAULT_REG does in arch/x86/include/asm/extable_fixup_types.h.

Thanks,
Yury

> +    }
> +}
> 
> -- 
> 2.53.0
