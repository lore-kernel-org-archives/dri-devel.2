Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE7606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P6Hkw2DP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E6D10E06D;
	Mon, 16 Nov 2026 04:03:14 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012059.outbound.protection.outlook.com [52.101.53.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E13E10E06D
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbjH5zW1tlP5FeNsa29dIucIG8OiHgO3wVkWQzIkunOKki8CKKRiuM+nsaFiOut4qiYb7K20auNFBLcym0ehEbPpAm0y3lo9kuVgvRfagjtUMGejY8DfgjuhgQQ8KaCZ9cLfPeeT+uBoEruAGzI2tNwu6N4LYlxY9WYyPqZELRFtWabVhoOn0jUpSOYDVWKFrZJLfHy9VIPWpQO2mf4FqnOb0gJbKojLGli6E1s4n96NpQZ8VOH5WCAm+gHCzarCyFGiknXbxUMlGN+wQ9aIIN9j4JrLivwKFTV2kqMzesmuyQNGzK2MiL4VXC7d3h5LBTFiq56ncjJ4LUUWAMRB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZrQ38fdMDsUYFmexY5tQnjrAvWJEY8F9g41tFfSjtQ=;
 b=P2di5pkA1cV8ajzMg5WOHpUnq8rxMr/2WpI6ddS4xWv+3N3EPug8WKI8couZQLMTocD8xHOri9YqG00tc95i/gXcKSnEWjESU6DUNo6376Y0wAvdBzj/EyNzG8XMSqS3sKnP/FnspemxUzr2kdreTy7SzdEXhxeeRDkN7xdALbVcp/uJ0TnOuA8X2q0jReOJXsvj1sT0Ou9xvVjGoNDFHHTAsllfyf/iFvMCGf9+cCnCWSpBbskUjQZnSKWKJleMiIn1Ot7xbgc6wpJsVrezVgxYVip+ptor3tR4CgLSmplt5gaWVJAtoE5FhzLR8LVvfsKSKUa9NE/O+q2yvOJ/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZrQ38fdMDsUYFmexY5tQnjrAvWJEY8F9g41tFfSjtQ=;
 b=P6Hkw2DPoNY7CyUoBbmCHMuLepbyeEYavUdsFFnFmJmVCp2klUXbMX9BryJGAvCRraCTEQJWyU2sFVOgmM7+ji5DbEP7g74p+3/vuSJuuxbn+wihn9+Czwhy1zqewyAF+TvQ5fACKoeQmx/k4lY/BknPI+KQuqjloA7TDZPxXmIMlYUfXu+WMVk1ZLbRT+yi0vG3uzWXkP/glS2ktOKSg09UGGAtS6mT8fwq5wYXvixhQSFF54LIzGcDtdVB5i95SzphSl80k2iscQj7c+K84s9zv3XQlVBaVZGZyX9bKixChYunXCA8iZ/yfdGAuLGs3mDOhJRpqhA4/uZub08PsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20)
 by CHBPR12MB497579.namprd12.prod.outlook.com (2603:10b6:610:33d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 04:03:03 +0000
Received: from PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d]) by PH7PR12MB6858.namprd12.prod.outlook.com
 ([fe80::a550:dbcf:2fcf:463d%6]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 04:03:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 13:02:11 +0900
Message-Id: <DMWC44MU9W7N.3TBNH0HCKK065@nvidia.com>
Cc: <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: remove unnecessary firmware pin-init
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
 <20261114234324.82387-2-dakr@kernel.org>
In-Reply-To: <20261114234324.82387-2-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0226.jpnprd01.prod.outlook.com
 (2603:1096:604:25d::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6858:EE_|CHBPR12MB497579:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9b7462-8b18-4d89-b35c-08df439671bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261102123227099003|261022075727099003|261022115727099003|261021123027099003|261021121427099003|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: nYoO7563OhO9w0qUnmx1Ztj30QoUllkIyXRkmdQedDnDHuqc/684Oie1VbeHwDraVj3Ri14xpoOxH2CIT4RKJYkn+fG3YzcnDDRDWr6rRCsHkicFVJSmPqVsKC1juN9CBMF/q0jofPHz3xajtAnb2sneZh1qqdAdNzWv3zfS8AkZPkVD7AdpfLxgAo4QK/K/CBrZkxgUjpp4g3PSVm3OejQo95hKUbdlUeoi8H3YMBFFjTCw06yFNLK4+YIr9e8Awe8M79Y9ih1HKf1ox47CnvmSdeqeK+n7gCGfNT0NSu9Iom7GLvFu2uZPOzErpgemE1f3+gbEkTzL08veZgMXf1JmTJm1QLWX08GatqKJsZkliO6TaCoQ4oMk6vbn5bn31kO+RIqiCCLtgSEnPdnBSShhEjNiVev8KImCIkC+pqIO8VpDFfgVVEkEBmjDeTFnTDtSuX4QYV513K+Sgh7uFEQZHuwE5uZTb83zBhwpDqcMcx4cVWjYxekgPmly10J4oZt/wy2LrkG6s8wK8QpBRlZQOi6dM57lfm7WfroSF/jnCuTXiVliiIJNS51A8chJHimV9oyISo0AdmnoVIW7Tiolw9kO9ydBfS0XtL7DxGGmstq0aeW9+JF5DoEEvblJYmrzE59PFXzXVvFJ8tctATljLzos2Godjs2tfDlfViA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6858.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261102123227099003)(261022075727099003)(261022115727099003)(261021123027099003)(261021121427099003)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNMOFlmcXBTTWhmYkhBTUFldVZwZ2d6U1laMG0zaWJqNXQ3dWFocnNGeFZS?=
 =?utf-8?B?ZWFOd3Q1TlBrYmY2b2RzeVVUVC9uVm1RZDg4bCtUK1dWU1p1WXMvN2dQMWxT?=
 =?utf-8?B?TmQzbzQrb2pLZ2ZvSmhaVmJRbU1XRjI5dm44WjVZMjVKRUtzOXBETXZNWTVu?=
 =?utf-8?B?YlpKT2JOb0ZWRjRmS1BrTkRiWjQvcGlIRXRhOXB4cnhNZjgrQTVpSStINnk2?=
 =?utf-8?B?MFlhbUVqamw2NW9NQ214WG5MckJBVG5TMXd4M1VvWmpzdFpYYzlZYXZxZ0la?=
 =?utf-8?B?a1B5ZitXc1lDN2ZmSmhwRFZ6aStTa0lVSk5JOEZsd1pZRWF1MXpDUGJ6dzBJ?=
 =?utf-8?B?MXpiUytlZ2JrVkRlYWtMTUJISHI3a1pKdjFIN3FtYm9xckdMK3RBdEsxMUZI?=
 =?utf-8?B?S2Q3ZFE2bnFtK3dTcU81a0xTZUQxTUY2Vy9YZExIRkQ0NWV4TU5Ea3JSMDhS?=
 =?utf-8?B?cDkvcU9vTUNVWU5sNnNXWUIycGFzenlyLytUQm91WjdIWUx6NXFEUkZWR2pq?=
 =?utf-8?B?TDZmREE1SnN4Y2YrQmZLSWsvR1ZRY216K0srQ01PMkFwNXovYXFVd2w1cVF1?=
 =?utf-8?B?c0JhdVhSR21FbjVCcEt0QmVCVUM1eWhRWnJwTUdrZVk5T3J4NHFKdDE4V0F2?=
 =?utf-8?B?ZUdPeHhCNXZFTkVYRC9sczlMUGRYZGNFcHRyRS9wWmJydkRLUjE1SkV4V1E0?=
 =?utf-8?B?alphZmFKQys4cTZDeVA2UlcxaE1KR0dXTkp1QVNBSEhuRnl2THR2RW41QjMx?=
 =?utf-8?B?ZjdjUWxPQmZ3QThZYXZzU3FTT3JqY2V2ck5XaGFZR3k4VmNhMktTM2RvQlk0?=
 =?utf-8?B?SzlyRGplbzlLVUhERE0vSk1qK01CVnpOSFRzZ21IYlRlVElBU0s2Qm9YLzFQ?=
 =?utf-8?B?Q0ZIRHJKbGRrNkdVZXdvUUpXTTVrZzBhbzdDN3VZTzcwVGhyNmtORFlKZ0F5?=
 =?utf-8?B?WnpXOTBoaWZBQVhEVFI0WVRZZzRBbnRYazJWTHQvaCsycDUvTjVWTjlMdVZ3?=
 =?utf-8?B?TFVDMWllSE1hUGhtcTFKOXVYZWZxSXhzNnA4SkxQR08zdlZhZUhNeTZJKzNi?=
 =?utf-8?B?TldCc1VydDg1SW9uK1dLL3VJdHFZUSsrK0NEQ0tobXNLOWxtVnhTZU92WmlT?=
 =?utf-8?B?MWNiSG8weUNPYXRiallkMXBYRVdYRkplWXB3VGc5L0hFZlAyUlNIZlZ0d3Ey?=
 =?utf-8?B?eW1NNUkvVTIydzJWZzRCZU1VNFc2L2l6TUt0ajdTNVZhRUM0dXZDS3ljN1ZM?=
 =?utf-8?B?RythaGNUcGJIOWtyWHVuSHpZd3dGbkxVQUlvRmpvdndMbklIUEY5Mm9UdStt?=
 =?utf-8?B?dEg3bW4vekJFWmZtZnNpQ3hyUFErUndYdlpJK0hnem9iWDRQWkFOdGtHVjd3?=
 =?utf-8?B?VExJbHlCSGFza1JNUHVXR1ZhbTNFNDZEZXl2WDkwQytEMmN0Ty9sbjdQVGxp?=
 =?utf-8?B?RWEwT29Pa1dnY2VtL1Y1RDR5aEs3bExNbnY0WHp5N3lvc2ZxNXEwTU1LVzNn?=
 =?utf-8?B?NUwyZXBXWHRqRXFyYkVoRFhBSjk2cGRrM2VqRmJCdG5iNzRXcnlUL1NoZ3hI?=
 =?utf-8?B?QlpzR1hSaVdjYWtPZmYxUWFjRG43RE8wSisrQlRWaTVldVlDbDhRYy9VeUFi?=
 =?utf-8?B?L3YxUnZkV1o0SFZXNU4zRXZCcDNRSmEza3Z2MnZHSTdYVmxJQ3ZIdDVJeTkx?=
 =?utf-8?B?R0t6MGZFQk1FWE9HNU9JZGNOUm5MMG9hN0thWjdaaTZQZWVjdTZ2RHlraWVx?=
 =?utf-8?B?elJjaHBNZldIdFJjNU5HRWlwUUgrVHZjdFg4bWQwTkdZcXRmd0pVTC9qT2hZ?=
 =?utf-8?B?YVNGSjZNRlhCQW5GaTYyTGtDZUVoZFNkMXl5TUpzQ3ZHeFFwWUx3MHEwUTFn?=
 =?utf-8?B?V0dtZ2J6OFJYdUU0alhoME9sb1BCUTVNMlNBTUFQVkMyUGxvTWhwZUFDOEtK?=
 =?utf-8?B?aFhPbmZoTW1taWRsMk1DVkg5NFNGUE4xR2FaRDlOQS90Q0kwL3p2Z3VFVGx0?=
 =?utf-8?B?c0M3RlBqdHBXZHBKRk5nTUh0eVFqNzM1bTlmV3FVb2k3dzk4bUhFKzNJRTJ4?=
 =?utf-8?B?cEpYTUFscWtmRHFRVkgzNTJIZVZUT1U3WEI1V29heWVPYlVWZHdYcTRHOXZJ?=
 =?utf-8?B?NHZtcGxXcnArdGQrMGpjVStLallVd2JydS9tU0VnUWJ6VWRNVzUyQjhBM1FZ?=
 =?utf-8?B?UjBMakxDSXJJazRiaDZDYXJvakVQa1BoeE83bjRDamtROVMxRnVJMHpGQ1d0?=
 =?utf-8?B?blVxWDlpWFNoRHlLdW9lL3BrV0ZWcThkZlVOc0NabXFpTTBzb2tEMkk5djlz?=
 =?utf-8?B?UVA0ZkFmeitVK1poZDZuUzgxWGZWeHI1SjlSLzVHZ0Y5bk9BUUpNcXhjNGhm?=
 =?utf-8?Q?arjoyBlosFX/F5RQYKcBVqwKsLPwz1ISQR34ghxgiAnCz?=
X-MS-Exchange-AntiSpam-MessageData-1: DKivWvTQJdP57A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9b7462-8b18-4d89-b35c-08df439671bf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 04:03:02.9066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEhj76cTyvRhgTTERPdGvWljnUXhqfVdO0TRtBB0Pw+gqUhHCU2aDxMM6+HQkGWT6VYDvyaZCCB1HTXeOY3bFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB497579
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 15, 2026 at 8:42 AM JST, Danilo Krummrich wrote:
> Now that SGTable no longer requires pinning, remove the pin-init
> machinery from Radix3 and GspFirmware.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/firmware/gsp.rs    | 43 +++++--------
>  drivers/gpu/nova-core/firmware/radix3.rs | 82 +++++++++++-------------
>  drivers/gpu/nova-core/gsp/boot.rs        |  2 +-
>  3 files changed, 56 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-cor=
e/firmware/gsp.rs
> index 341a8b19aa38..ff92a12b2994 100644
> --- a/drivers/gpu/nova-core/firmware/gsp.rs
> +++ b/drivers/gpu/nova-core/firmware/gsp.rs
> @@ -25,10 +25,8 @@
>  };
> =20
>  /// The GSP firmware image, its signatures, and the GSP bootloader.
> -#[pin_data]
>  pub(crate) struct GspFirmware<'a> {
>      /// The firmware image and the radix3 table that maps it.
> -    #[pin]
>      radix3: Radix3<'a>,
>      /// Device-mapped GSP signatures matching the GPU's [`Chipset`].
>      pub(crate) signatures: Coherent<'a, [u8]>,
> @@ -39,34 +37,27 @@ pub(crate) struct GspFirmware<'a> {
>  impl<'a> GspFirmware<'a> {
>      /// Loads the GSP firmware binaries, map them into `dev`'s address-s=
pace, and creates the page
>      /// tables expected by the GSP bootloader to load it.
> -    pub(crate) fn new(
> -        dev: &'a device::Device<device::Bound>,
> -        chipset: Chipset,
> -    ) -> impl PinInit<Self, Error> + 'a {
> -        pin_init::pin_init_scope(move || {
> -            let firmware =3D request_tlv(dev, chipset, "gsp")?;
> -            let tlv =3D Tlv::new(firmware.data())?;
> -            dev_dbg!(dev, "loaded gsp firmware v{}\n", tlv.get_string(b"=
VERS")?);
> +    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: C=
hipset) -> Result<Self> {

`GspFirmware` is 312 bytes, that's not enormous but that's also not
small... Shall we keep returning an `impl Pininit`?

> diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-=
core/firmware/radix3.rs
> index a3e43fc8ec86..2c8787d5930d 100644
> --- a/drivers/gpu/nova-core/firmware/radix3.rs
> +++ b/drivers/gpu/nova-core/firmware/radix3.rs
> @@ -32,60 +32,54 @@
>  };
> =20
>  /// A radix3 page table and the data it maps.
> -#[pin_data]
>  pub(crate) struct Radix3<'a> {
>      /// The mapped data.
> -    data: SGTable<Owned<'a, VVec<u8>>>,
> -    /// Level 2: one entry per page of `data`.
> -    level2: SGTable<Owned<'a, VVec<u8>>>,
> -    /// Level 1: one entry per page of `level2`.
> -    level1: SGTable<Owned<'a, VVec<u8>>>,
> -    /// Level 0: one page, whose single entry is the DMA address of the =
first `level1` page.
> +    _data: SGTable<Owned<'a, VVec<u8>>>,
> +    /// Level 2: one entry per page of `_data`.
> +    _level2: SGTable<Owned<'a, VVec<u8>>>,
> +    /// Level 1: one entry per page of `_level2`.
> +    _level1: SGTable<Owned<'a, VVec<u8>>>,
> +    /// Level 0: one page, whose single entry is the DMA address of the =
first `_level1` page.
>      level0: Coherent<'a, [u64]>,
> -    /// Length of `data`, in bytes.
> +    /// Length of `_data`, in bytes.
>      size: usize,
>  }
> =20
>  impl<'a> Radix3<'a> {
>      /// Builds a radix3 page table over `data`, mapped for `dev` to read=
. May sleep.
> -    pub(crate) fn new(
> -        dev: &'a device::Device<device::Bound>,
> -        data: VVec<u8>,
> -    ) -> impl PinInit<Self, Error> + 'a {
> +    pub(crate) fn new(dev: &'a device::Device<device::Bound>, data: VVec=
<u8>) -> Result<Self> {

Similar comment as `Radix3` is 216 bytes.
