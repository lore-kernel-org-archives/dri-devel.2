Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4679D1098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB6610EABB;
	Fri, 20 Mar 2026 14:36:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ScMqRvKu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FE010EABB;
 Fri, 20 Mar 2026 14:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ys6+26sB/xYhsEQjG03Ptn4P+CZVPO0p+FkcolbyqUQf4FjldvkBuxaYx/bJP2MrCtJ5Hn/1Fyv1v+QYixD3I2pHqjVYwudsh5vrYbSaxwBcFjLNOYAlhy7OIaJVpq3fafAv9S/vA4+QNp4o1Gc2JlWhh/xvjrtr1eV+wssS0gALQmaL3Nzo4JPxrQVJPVnrzTuUzpuup/i7zYnJj2vzKzgihjwUo/3zP4bgvhCH+EHMyNCayt00rgWPcaqypyLsfZvgA2VzkxNnHMqLIn8eE/VAw7yJHs45A0FCRULbZrOnZEnw9h0Z0f4OnGQdJtW/XMlDegRkFecDAKIYc2HS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kewyv9nQKbk4sSOc7fpFuiK11EVngx1xwOvzrkO+ZwE=;
 b=mpQH70EFxACbwfAH6fs43t1jMI94o9EbOKY4TUw9VUITqdqgzD/1YHO6vCZsFO7e+05zCBur3E8vFRSQGML4tmNbJBrfLv9fRztqbxrUFTLF/RsbGyCGjKOkcAvVpeXQ5PAcm1iqDSJnVqunlrIz9s7Ip2939oaR0hgmc1hQdvTGdcLoqHx12Tzd462hZ5VSGItg60DUiqsbFnPZh7uTSnVmE121vESM8qrMfk1jjdEFq8/5ECRAklBMhMahe0C+mpJqHnWfpfoP0QsLz4dl5103xRES1t7dRAQnbynhc6XyddOy0Rd4ajp0Kzc/Zd5ErNCnzPcEZ25s9uvDjP31JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kewyv9nQKbk4sSOc7fpFuiK11EVngx1xwOvzrkO+ZwE=;
 b=ScMqRvKuIXHwAsBUkYYFflx0UQaC6ukaIca78yL51nUZ6Pmvy+hylDH0EXllbVQFXUcRn5qDlOlm2Pa2iudveWwvzIxfeAnn04aIVsVJngThoimhlMDUJw3IlFTvhsO7ta2iNCdORSJiCn1BED+Lpbrw9WMePjgFEKID9k9ULUK5CVOAc6cbRxE+R45VArDRJbro5obzftUQBAwWUo7EfEYZvMKtTwLPvsnWsUmeUUrm3GrREbaWeK27iilJlzClnlsPSJyokEyiykZc2D49yy5x7IrR3qMhuRpzfwmF9MvzLS+fBWQdZgR54f4/IB/0ritsPYMdUuIpB2++AsAPUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:36:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:36:08 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:35:59 +0900
Message-Id: <DH7OO4961WUH.1MM3MW1SVWI3I@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] rust: dma: introduce dma::CoherentInit for memory
 initialization
Content-Transfer-Encoding: quoted-printable
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-5-dakr@kernel.org>
In-Reply-To: <20260303162314.94363-5-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a6ec74-33bb-433f-5ba5-08de868e0644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KIENpn5GFe6NCN1gIaAkIZnxLOhht+KGLVoshLeD8zz4XCEbSKCLLtzTOEIVPtWiRwd0NJ464/519PU1Fq5lh6Q/xSl0ZGyH6ADFXT7Ria11JsfjGra2GmJgmGrbXkKi3sWpbNGqgxo1Gz5UtF5ad9H31NqbSHGxEd/8l2vZeS1iQvtjKEMMAR5melXwZpOYkNXWBPdJ7+UKypGPTWRINDkXaKsulCIMh5rdZdxn0a4kYz9Feq+hvalHmGM9rR2Gzz9tIYI4r7Q7ioQISKeJrxmsRpfepA6Ma6e97JeKNmlC03yDdzFbBag1v6XN+ZxXZFqo3ThmRrlvk7YrC6p+gz32M2KiHrD+tHz7dpmL4g37XWr+Aco1vJg440Mr8WEmuc8jwpgRWdgwc0IJbyKHAv+XJsc0fWLtO+cc3TATaMwn8mI/Jj2R7Adl+BYjglDVqBeu+C32IM8MjLQJrHks0GulrXa4PcvoKZg+Dv4x1uaxU4g/EuACJJkgidnUwNOZDqr3u/RCQa2IE62baxEQ8YsO3hgneUGPkm8nlNlsXbk0124t0S6FP4VI2ZkfJFUukvKssqqSZxQn5kNyIYWuPE5qWfybexp93jGsxsom19C83MsGox+sYnx4zCzgJIMUZyxn7D5ilzyg6Dd+M4qhD4zXKKBFkVg803goniVDmYQIqC4Fttre8f2TcXY7JCJrNESnsZebilKtqTD01J/t0obM6xhyg9icXYAowpGoX38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUUwSktvak1ZOGdxTGxxS3lwQVI2WUlvckpQVCttWVhOYWpFLzJvaHZUTm1Y?=
 =?utf-8?B?SFdTYkdkTHhQRlhrcldHNUZFdFRaQTZ5QXo3R0Yycmc2UGYzd0tIQ1BBTnB4?=
 =?utf-8?B?b0x6SDVkLytpRjJMc2M4M09ESEZxUTQzS2NScEJURnhPZWgrcS9IUHFTWkRY?=
 =?utf-8?B?em4rN1NwN05Ta3dYZ2w4SHVpaVc3NkY2a3B4QzErbHVIQmd6U3pvNmhDVUNV?=
 =?utf-8?B?RUYvUjBlTmF2Z05JbVhBV1ZBeHAyUmNpOFo5VTNETUZXVmM5SWhpZmwybjha?=
 =?utf-8?B?c010ZVJxcEhqY2t5ZWdaUldyOWRpSDBLY2lFdnovNW1rVEQ0UDYvdDZmTnZY?=
 =?utf-8?B?WTRHbkdmVjVwSmtRZ2dhcHlRMlo2bGRVdFl5UmRjZk9ibVN6eHE5eFdNVVBD?=
 =?utf-8?B?S1N4SEplSS9sVHVsZFdpS2JnNndMcHpaVVJSZWVSNkhNMlNBUnBqYXZ5QVp4?=
 =?utf-8?B?K3hxTDkwY0c0STZxdnZzUzRqeWVYa3hadEZYSnJYSU1Lbmx4QlcvUmljUTJi?=
 =?utf-8?B?SlFGSWtnNG5nSFVFLy84Q0dqbmQyajUrUzl5b1EwRTQxa2FkN25PdWo2bjIz?=
 =?utf-8?B?bnNSNFQzeDdFWUJlQkxsVEczVWIrY2hNelVpeU1tM05BbDRSYndjeFdBa2J4?=
 =?utf-8?B?TmlvTTZFekd5cVFLL29DL2Nyc1k4Zm1EUGdwbzVPZ1ZPTkNwODc5NUpYQndC?=
 =?utf-8?B?QWl1WXVsSXZnTGJxclF0eU5nUGJzMm02UUNMTUdOWjVlb3pXOHVhcHZhTG1x?=
 =?utf-8?B?NGsxUXRVaWdQaFFTTkkwRlE0Uy8yZjJCRmNTU29YcDd6TzAzMXRjOWk5RmFx?=
 =?utf-8?B?aksvVmc5NGUvQVJiNlRYTENZMEJkeVMyeHh6OU5WcEZQcnlZUGk3NStMZWZ6?=
 =?utf-8?B?S05ETFdLRmVkc0tpK09Ka2tXYnNyZ052VUVCd1o5K3Y2WUxoL2JYSlpSemFZ?=
 =?utf-8?B?bGlGbmZwUzFiQkFvQ1FTRkJLU1hNQUt6QjJ4TUxtTVFZMHZjS3NwNEhlTHpX?=
 =?utf-8?B?WXM0Ti9odGV6aE5vaitEb2wrOVdleUxaM0ZFVy9LeFNtc3FpczlUQ0lYNG5H?=
 =?utf-8?B?R1JWclhXU0tVeTc0ejdyRjJYNnRxUHp0d0d4d0wyUDRYVkpoR0prcU83NzN0?=
 =?utf-8?B?UEZoYnZCa2tzc3orRFpQbzFpd0lJeGg4V0ZSbS9wN3ByS2VWRE9jZnRrT2Fv?=
 =?utf-8?B?SUpFWlhsSzgvVEtkR0E4b2o3VmFYb0RBeVBnZ1RvVis4REcwemtCYk5XQ0Zw?=
 =?utf-8?B?OUY3ZVZ5T1Jac1hueGQvOHdHSndwZ0NnQkJFU2FSdFh4czl3bkc3ZlE4dnJE?=
 =?utf-8?B?d3cwZVByVW52ZnY3VStCWExOTGw3RndJOGRWRm1oSnhpY3N3VUp2TnVWQ3Bp?=
 =?utf-8?B?cGhtWkVSdmRHYjVHVHg4a1Z5UnZxWEFpMHAvakJyQXpYWnBDRVNjaFk4SGlK?=
 =?utf-8?B?QWNSV0MydDE2UmlkWmRWQVRpK29aRjBkTU5lK3FzcFdUSHEyVXcvQlVnMFZR?=
 =?utf-8?B?V01ZaEZ5WEF6QldyLzRhSmJ5ay9teXpGYlFxQStLa0RmZ3Q1QmhIRDY4YkJk?=
 =?utf-8?B?Q3lFR3F2dHBjMlJHMnlMVTZqaGphQUgvMjNraE5HRmxZVnUramxVV2dQalMv?=
 =?utf-8?B?OTdrS2JmeklyMjArK0F6dVZsZHl4eEpOd24weStwYzlzbEdQNTJ6ZzV4UXdw?=
 =?utf-8?B?VjRmZ0JONldNOTh2T3drNDdIajFYZlJtN2NmWHptSWFrTGhMbFdFdFkrUjNZ?=
 =?utf-8?B?Y2dNSmNLck9vcEpWZ0VQZWdNV3JDNWtVZ0dxTk11Qi9rUFRneTQwWGFFYUEz?=
 =?utf-8?B?TzJXOHhyYnFVazNPeVJtZjcyZm1rTURJck14NERQMlJJdHpkR1dqWWlaVGl3?=
 =?utf-8?B?NS9FT096bFppVW9JQ2JxMm1xcG1mUFhsZytNN3RXYUZHOW1lN2MwSUdDZE9M?=
 =?utf-8?B?WG1UUDB4eUJoS2xhSHgvODVJV1JPZ0RCTUJBZUFITkM0d3l6SGxVN0JxdEY3?=
 =?utf-8?B?ZHk3NXZpU3ZLaXZLRkFFa2QrazkrS1hyT2psbzZGTTVoa2pmRGZoWFhtM2J0?=
 =?utf-8?B?SWU2L1paNHpxMWo2MUtNMk95VHluaUlhUlFmLzVSTFpqUml0aTlVZmhVcEpz?=
 =?utf-8?B?akRmVENMSHJzYnpnTjJBSDRYSnJsNStDNUMvVGMrT0hFSzNkTWFZNnpTNllD?=
 =?utf-8?B?dHFsZGlmRTl5MW1FYVFKZDFoL1lpSU4rYkJzbFRTUVdSSVRJUlB1M1U3dUtu?=
 =?utf-8?B?UjkxVDVqZWpkdDA2VUI4TG5YYnBIbmh3UEp3NzJFK2VIa1VFNEhKdzB3OEdL?=
 =?utf-8?B?WjVUT2ppenZqTVh6ejBtaG9DR0x2dnhMUXRJRGdRcnVyNnlhVlE2dWVxTnNh?=
 =?utf-8?Q?m2kgiGc4x2kF4bGlse/sSzXkg4uecMC3/feJ19JgR7c1n?=
X-MS-Exchange-AntiSpam-MessageData-1: DdtM27u1bQaN7A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a6ec74-33bb-433f-5ba5-08de868e0644
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:36:08.3312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1JpSfEfeoJQcI+/62nUva8vt6ZwEjR9lXOPBESp9JQIbgl+qABddPH+4/h1fqN1dcpBraZY9ovxKbY/7i0olw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198
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

On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
<snip>
> @@ -352,6 +358,151 @@ fn from(direction: DataDirection) -> Self {
>      }
>  }
> =20
> +/// Initializer type for [`Coherent`].
> +///
> +/// A [`Coherent`] object can't provide access to its memory as (mutable=
) slice safely, since it
> +/// can't fulfill the requirements for creating a slice. For instance, i=
t is not valid to have a
> +/// (mutable) slice to of the memory of a [`Coherent`] while the memory =
might be accessed by a
> +/// device.
> +///
> +/// In contrast, this initializer type is able to fulfill the requiremen=
ts to safely obtain a
> +/// (mutable) slice, as it neither provides access to the DMA address of=
 the embedded [`Coherent`],
> +/// nor can it be used with the DMA projection accessors.
> +///
> +/// Once initialized, this type can be converted to a regular [`Coherent=
`] object.
> +///
> +/// # Examples
> +///
> +/// `CoherentInit<T>`:
> +///
> +/// ```
> +/// # use kernel::device::{
> +/// #     Bound,
> +/// #     Device,
> +/// # };
> +/// use kernel::dma::{attrs::*,
> +///     Coherent,
> +///     CoherentInit,
> +/// };
> +///
> +/// # fn test(dev: &Device<Bound>) -> Result {
> +/// let mut dmem: CoherentInit<u64> =3D
> +///     CoherentInit::zeroed_with_attrs(dev, GFP_KERNEL, DMA_ATTR_NO_WAR=
N)?;

Since this is an example, shall we use the simpler
`CoherentInit::zeroed`?

> +/// *dmem =3D 42;
> +/// let dmem: Coherent<u64> =3D dmem.into();
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +///
> +/// `CoherentInit<[T]>`:
> +///
> +///
> +/// ```
> +/// # use kernel::device::{
> +/// #     Bound,
> +/// #     Device,
> +/// # };
> +/// use kernel::dma::{attrs::*,
> +///     Coherent,
> +///     CoherentInit,
> +/// };
> +///
> +/// # fn test(dev: &Device<Bound>) -> Result {
> +/// let mut dmem: CoherentInit<[u64]> =3D
> +///     CoherentInit::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, DMA_AT=
TR_NO_WARN)?;

Same here.

> +/// dmem.fill(42);
> +/// let dmem: Coherent<[u64]> =3D dmem.into();
> +/// # Ok::<(), Error>(()) }
> +/// ```
> +pub struct CoherentInit<T: AsBytes + FromBytes + KnownSize + ?Sized>(Coh=
erent<T>);
> +
> +impl<T: AsBytes + FromBytes> CoherentInit<[T]> {
> +    /// Initializer variant of [`Coherent::zeroed_slice_with_attrs`].
> +    pub fn zeroed_slice_with_attrs(
> +        dev: &device::Device<Bound>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +        dma_attrs: Attrs,
> +    ) -> Result<Self> {
> +        Coherent::zeroed_slice_with_attrs(dev, count, gfp_flags, dma_att=
rs).map(Self)
> +    }
> +
> +    /// Same as [CoherentInit::zeroed_slice_with_attrs], but with `dma::=
Attrs(0)`.
> +    pub fn zeroed_slice(
> +        dev: &device::Device<Bound>,
> +        count: usize,
> +        gfp_flags: kernel::alloc::Flags,
> +    ) -> Result<Self> {
> +        Self::zeroed_slice_with_attrs(dev, count, gfp_flags, Attrs(0))
> +    }
> +
> +    /// Initializes the element at `i` using the given initializer.
> +    ///
> +    /// Returns `EINVAL` if `i` is out of bounds.
> +    pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Res=
ult

Should this method be introduced in the next patch, or even in its own
patch? It feels a bit out of place at this stage since the non-array
`CoherentInit` doesn't have an equivalent.

I was also wondering whether we could have an `init` method that
initializes all the elements without having to zero the whole array
first, but I guess it might be a bit difficult to implement in a
flexible enough way.
