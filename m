Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD0606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=wyzYWjbK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC3410E9E2;
	Wed, 11 Nov 2026 11:30:46 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021102.outbound.protection.outlook.com [52.101.100.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965DF10E9E2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=winJGb523W/SD9EK5ZZbdgV5J0bGWmUTXMJipzemYXQnARS3w8KJdTIJ/yoBWIb+mHmlRM5yqqZWxK9ln/yc4pQPabpDRamvzAyJAQoyVW6c2xwa/AtenteRLMQuV0GdirhSEgtMWTr6RvaCLGCg7QGbMkUYNkuRqX8uW/mIcfFN3LAILUFbBpqAJO8WyCWFGXuxAScKUYhCzOlyWsL3lsc6RknJfp9shJqrf6PzMZcg6+4T857w9Lc0VIMQXUJsEioGGQhbYBKGAqgCgyxWOdcQ8DDcEHwOrii3V00h3+aIq+zA7L++QgV0gjXEeOyK1CgKwHaJWCWozBkcaNHGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GITQUz5rm9u31VXH/1wD9hahAvpvRI8gOQ8K1ReLT7c=;
 b=KxposD8d62aJdLFT+a++wXyLTKJG5JKiCGZWKGWY0dWZZ3tvf8g+N1bRFbXexQE7j6HtudQHlz+PWY8l8Rg4/hHa+wjxu84iEFPVknQtsixcyq4e7gkFjw7nZcXv4GwnuCH+v9Jggr6qkIB98LiJlxlc/1HufLPeFnFlmU+zgzsyZnvngvQzuz4QmlfdibRBG09KyvCrQ/65ZP6AtPvJZUdcdVi97os2h79dyZ09AoNkKBME6eE8zfjtokQXZQcR2rc0/wmTujURiUYagjHqPd1fgWBLdXlkd/M4mQQzHq7BuPHjRlo6EyhU8XbHqUBAACoP85M6gxsVU+dFJwHu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GITQUz5rm9u31VXH/1wD9hahAvpvRI8gOQ8K1ReLT7c=;
 b=wyzYWjbKqwNvzeYtwJd28WvagUAz6rze14a5KymHHWIAn1L1Fc7L7zhsePTqV8n5py0bN87Ao/2bX0DiTGMhWccZQvJIdrZ7fBAL99I4feBGTbEDNRAeLpw/AXkzoRLKdLO+SLIBVPSmY0vLyfFUqOc49y5CsOKEQZOP5DNpShY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB7334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:322::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 11:30:36 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 11:30:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 11:30:34 +0000
Message-Id: <DMSCIQ1NOV15.383LSC2I0TMON@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261110152746.140351-1-dakr@kernel.org>
In-Reply-To: <20261110152746.140351-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::18) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: d2af1a9d-334c-4fec-a9a0-08df3fe73428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|22082099003|18002099003|6133799003|261009223027099003|56012099006|261028144727099003|261102123227099003|261021123027099003|261026140227099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: rCKigi3r5RFXFXUtSRmmUIiT/+Mo36qIcVme3Z0lFvbsMuh5vA1VQiYLPm6NFrszTVs534SgRmyHcAPnPeCRdwehE3rkDns1MMp/8kHieSsJiz/Oulj3TF6WkKnBz7xP9nGi64MFE3hKaKuaU/D/yJammBHZkKXPXACH/tRSaw/SpHS0Mph+43Y6enJM6x/cCabXovO1oDaKb+QI+5wjD0leD6pT1vlYeEu49kJcdB6joK8a+M1RKx7D3OhIKAPCe4igAZ9UJ+VajkmU8d5osUFYQc/S4/J1kr2yzGr/0PMwWHtJafMiHb5zxgqQa359LpgD7qPM4Tt7x3eClauEsgtAkmMhMcXz3dQCJXFAIaI5PQOqx9C71TokhnRi6p7WFietnmyeuqLPhZBbE8qjLJ0CJUMbgWZk/HBR7FYjcJKLQkLuviaRvJk1InrkHGUsmkT26HP9vaMJ5BOSL6jORSFsVf+BAENfm98Vos8qlEM1LhbCoVmoBPZdSPqQx6yC5vfvZW5NVKxP4dq8FAqgK9xQAmN+LsiYqQWkgdL4XvgN0gq1FP+Ea6w7OoDovCFLI6Nx5D4xkBmp8mIGQAjnMMAlYSuXgCbBu7BVgskmrwsgUqryN8xuiBNy5ubPefm2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261026140227099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlkNHpNWVVJQ2ExY3VjM0d5Um1DVjJkV1hkcW5sWWQ5N0o2cWF0Y04wSnZF?=
 =?utf-8?B?bjdVblZtZGVEYnhWUHVTTThvazBMUnJkR200dzJOS3JwLzZ1eldvb2lENjYy?=
 =?utf-8?B?c3ZKWmJ3Tkp0UWlJY2s0TytNWmQxRXNVaXV4MjZ1dFRFK2RiL3c2NUswbGlJ?=
 =?utf-8?B?S0EyS0I0amJUeFdrV1FFRXY4N3Z2U1RRc0V2WkUwUTl5U081d3ViWDJmQTdn?=
 =?utf-8?B?NDUvdEhhTCtuWVlJcWxzMlRmMFlET215TnNEcXJVenJaSXBLMjFqLzNyUFhk?=
 =?utf-8?B?dEtVLytQcnBqSVZvT0c0V2F4cVh6OG02NjBJYm1hd29sVWxXWVYrTVI4MnJU?=
 =?utf-8?B?NHZ2Sk15VFVYT09EcjRkdGZtazB2YURzM0lBMmdobXl1WWpWVGZUSFdqNHMx?=
 =?utf-8?B?ZmVDbDBzVUhLV3NjSFk2Yk1pUUFxNWd1SGttbk9OVGZseHVFRXV6Tm5uV3lZ?=
 =?utf-8?B?M0I0dE12aUszZXJ6YlB5WFg4ZTZUbzFaUkRKaXA5aVd6ZVZsMHZYYmt0QlBC?=
 =?utf-8?B?dkthZnhVVklvUnJJYjJTZXN2Nk9BL1U5NzFyUElMK0J3VjRXdGREVzNzc0RW?=
 =?utf-8?B?eVB6cy9RNFYvMVA3M0lVczlKV2E1Tk9uMVVlWnpGZUsrOWZGK3RNWHpKVkJK?=
 =?utf-8?B?dmpESkJxSU42YXZmN3gyYjR1YVB4RDNrenI4bEh4aVM2WHhKZlNGK1RsYVhV?=
 =?utf-8?B?QzZ1UlNoSWlTYVU5OFQrRys4ZlhwV3l1L043WVdFMzBtUXFlQlg0eHRxSVVS?=
 =?utf-8?B?L25TTkhtSS9XMTVua3ovbE1hZGIzWEhYNFdmVWlRWkJ2UmpkMUs2RkxiR1R6?=
 =?utf-8?B?UGhyL0Z4Y0lQTEZvNlRiVGowakVISnowSFJxb25KRHA2QlRwcEtocmx1U2dh?=
 =?utf-8?B?VEJvOFBkSUMvQ3VrdkM1K0VMUEZtK1RONEwrZnlKdDFUSnNhdURkUHArYzdJ?=
 =?utf-8?B?VXZSTWVnNHhVRFlHMkNlMldVNld0UDFqQWFWWHppVE1YQW5VV0hkSkdSY1Rr?=
 =?utf-8?B?V2xLUUlrVllTaitNMy8yOVU2VEFPNXk5Zm5WdHNpS3RUNWZvQ0lyQVJHVFZw?=
 =?utf-8?B?NFM2bVJnWGdyVUd1aVU3bmJKTWRLWXVoTDlGdDR3N2NqTVhKZ3dKbnRzK0VR?=
 =?utf-8?B?QUZMdC84ZE0zVERwT3RBbDF5VWVIUW5uMG9zTjF2dUc3dEt0SXM4MTVhZnpC?=
 =?utf-8?B?NWhJaEVaRWVrMEdlUVp3M3NYM1llWkhWVkFNRnQ0OGtWVmFyRzN6Y1RUOWdZ?=
 =?utf-8?B?RVMveVBJdUtsVlM0QzN3cXFVMnljbmVJQVA3OUlFSFpET09DME11TDR2L09w?=
 =?utf-8?B?SUl1K0lOQUdMWnV6Y1kvUFpOV2V0RU4veHZ6bzdRSlEwdmYrTmRwNzE5S28w?=
 =?utf-8?B?SHBZYjNqZFZNdXhhVmlxZUs2WTJLMll1ZUZxc1BFQjUvTGZOd1VpOHVWNi9z?=
 =?utf-8?B?Qld5ZlAvN000WGJ1L2g1WUs4TERUcEszaFdvUEJLNC9nTE5rcDNrc0ZuZWJo?=
 =?utf-8?B?ZGFaUDJMb3FIeDUwSmhPRnlLVVVkbUZhaUxSL0RhZDA4YXVEMVM4c0ZVWGNE?=
 =?utf-8?B?SmJENUdiN0RFQ2RlYmc5VGNRZjFkay83UGlFa3lyODJUSHRVQU1EU2JhWlk2?=
 =?utf-8?B?VWFhSUVEZVdRVlhnUFZ2TmlkSitPeDJSdTJtYi9VNlAwRUhEb0FVMkZXbzJH?=
 =?utf-8?B?b1NyQTUweTNFRkdIOXJWeDl1TFlWSmkzZ0VhS3JWMDh3ZkM4TTZKRm1zdk5M?=
 =?utf-8?B?OE5wQUV4Q1FMOGFUTnZYU3JLREk1TFB6RGVoak9HQXFCVk81SVNJMDAwamFo?=
 =?utf-8?B?KzdvYVVTSEM5K3R2bllpeHoxQi9nQnZqazZQQ3BFQTFpeVd5MWE3V1dUeWRJ?=
 =?utf-8?B?c1Q3TGVmbVhQUFhYVm5LeGZSa0dRbWdDUGVzbFYrYnc0b29oR04vNlR0YXdG?=
 =?utf-8?B?VEgyd09GT2FwSWJweTFDWW1haEY5UDN4WGhGeTRUR2p4S25UZFpYRkg2UWdH?=
 =?utf-8?B?S1VodzBZc2VjMFlSaUVMeXYyT21QOFhhMlh1cGd0UUpVamZpUmpHRzhBdDNY?=
 =?utf-8?B?akZmV2FCTnJsTUMzVlkybFhKNEdHTWZqRXR0S0NzUlppNm5PM2Y4aGpIS2Ey?=
 =?utf-8?B?OTRiT1VWaVlQbnRVQWJPcGlGVFJ5ZDBsTE53MUY1UXBCNXdWV3JmZGQ4MlJj?=
 =?utf-8?B?SHo4UjFXMUtRdGFhbk9iaWIzajdidUp2YmwzUDVwUmYwbUJEdTN5NXcxRkQ2?=
 =?utf-8?B?KzhCdmlKRHBJSjAwb0xIb1lWM1Fua2h4RHA4YzEyU1pxNXFUcE1wV2F0WWpX?=
 =?utf-8?B?SVFNRmlvYWRPdGNNQ21tMFRTVDQ5SnpSQjN3NkdrVmFmYmVQYmtjZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d2af1a9d-334c-4fec-a9a0-08df3fe73428
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 11:30:35.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OlR7kwkLomHnGJlcBaSS6sZDUEGJM090PtFNZ/fciBx7FZiKp00iWcdHfSpamnVio204F8AftGWshldUaevDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7334
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 10, 2026 at 3:27 PM GMT, Danilo Krummrich wrote:
> Express all self-referential borrows through pin-init's self-referential
> support [1], replacing unsafely derived references.
>
> Cc: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5@=
garyguo.net/ [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/api.rs     | 24 ++++++++++++---
>  drivers/gpu/nova-core/driver.rs  | 53 +++++++++++---------------------
>  drivers/gpu/nova-core/gpu.rs     | 32 ++++++++-----------
>  drivers/gpu/nova-core/irq/gsp.rs | 17 +++++-----
>  4 files changed, 59 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index d185e927233f..cbd720a4d11f 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -342,15 +342,15 @@ struct GspResources<'gpu> {
>  /// The two drop as a unit, the handler first, on the drop of [`Gpu`] an=
d on the error path of
>  /// its constructor alike, so that the subtree is disabled only after th=
e handler is freed.
>  #[pin_data]
> -struct GspSubtree<'a> {
> +struct GspSubtree<'a, 'gpu> {
>      #[pin]
> -    irq: GspIrq<'a>,
> +    irq: GspIrq<'a, 'gpu>,
>      /// Must be kept declared *after* `irq`. A handler still in flight e=
nables the subtree again
>      /// through its rearm.
>      _top: TopEnableGuard<'a>,
>  }
> =20
> -impl<'a> GspSubtree<'a> {
> +impl<'a, 'gpu: 'a> GspSubtree<'a, 'gpu> {
>      /// Returns an initializer that registers the GSP event handler and =
then enables its subtree at
>      /// `TOP`.
>      ///
> @@ -362,7 +362,7 @@ unsafe fn new(
>          pdev: &'a pci::Device<device::Bound>,
>          tree: &'a Tree<'a>,
>          falcon: &'a Falcon<'a, GspFalcon>,
> -        cmdq: &'a Cmdq<'a>,
> +        cmdq: &'a Cmdq<'gpu>,

From the changes made related to GspSubtree and other types I think I'm mor=
e
inclined to just make `Cmdq` lifetime covariant using existential lifetimes=
.

Best,
Gary

>      ) -> impl PinInit<Self, Error> + 'a {
>          try_pin_init!(Self {
>              // SAFETY: this function's caller must not leak the `GspSubt=
ree` that owns this
> @@ -383,7 +383,8 @@ pub(crate) struct Gpu<'gpu> {
>      /// any in-flight run of it has finished, before the command queue t=
hat it drains and the
>      /// falcon that it reads are freed, and before the GSP is unloaded.
>      #[pin]
> -    _gsp_subtree: GspSubtree<'gpu>,
> +    #[uses('tree)]
> +    _gsp_subtree: GspSubtree<'gsp_resources, 'gpu>,
>      /// Static GPU information as provided by the GSP.
>      pub(crate) gsp_static_info: GetGspStaticInfoReply,
>      /// GPU memory manager owning memory management resources.
> @@ -403,9 +404,6 @@ pub(crate) struct Gpu<'gpu> {
>      /// Must be kept declared *after* `gsp_resources`, as the latter's `=
PinnedDrop` implementation
>      /// requires the sysmem flush page to be in place.
>      sysmem_flush: SysmemFlush<'gpu>,
> -    /// Borrow of `tree` that `_gsp_subtree` holds. A field that borrows=
 a sibling field is
> -    /// self-referential, which `pin_init` cannot express, so the borrow=
 is taken by hand.
> -    tree_ref: &'gpu Tree<'gpu>,
>      /// The GIN CPU interrupt tree and the PCI vectors that deliver it.
>      ///
>      /// Must be kept declared *after* `_gsp_subtree`, which holds a borr=
ow of it.

