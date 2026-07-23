Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6D1C44524
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1142E10E515;
	Thu, 23 Jul 2026 03:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UN0pgMrU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A98D10E515
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2nNdIksidohOjq46jUUw2oT7p5JXtWbI193tT4s56MTSk0yl2CO6N3/8tk4nEty/NHql1JkiGE7e2Gt5jTnnOozyhIbdyzzttxW3RjqBY38TOgD+8Y4+8rdFnu15+UDPw/jMNHZ7anQaB+oRIz98rkdCBEEbIqxXQ7YlHByD3uWj2WbnpRK6zGLS1LcH85TfPTIBC10q91WyofeqBUdw5iNkqVWlB4AeuN7CxdjQeaLuiIncEsTE3aHnZLe3UXfVqzF5Bg7Z21pKPig9Xt+0bsraOaGeUqClV49E+edJ3+CGROUrphvDlSkMmk6yh43rAaGLNhM6bB1uukc78d0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNchadIgNdsH8zGDL6cgnsa+fN57fQz+f4P8N4re57Y=;
 b=Gp69X5MUP8lekqcHOI0MXfXOHnw1PSD9oHj3KZJVStOpklNWbBSnq0WBAEJYaVbHAEQlPkdd+0r6OkAsm5Dhg4KiBADAB8V3brbNrIhgo87xqKhiQWyIw/cTec9WgOA3WJoGGkKXQIXipPwvPjEp1UMg77jjWO6WMXV13QxfySuVF/XapYCPXwf74krJyr0O4+CSwRWVct5BGAfRAAZqssIG1j+fT4wHBp8QkiWmd0Wa8Ommh/d+d80DnQhFggPa90fx8NslzjIH0392fMFNX1FoO5Mtmm3KJwjeeATQKvmYEOa5pqhSKI04EruLakfxGzd0DfZURUrj33e0Kkyl4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNchadIgNdsH8zGDL6cgnsa+fN57fQz+f4P8N4re57Y=;
 b=UN0pgMrUpP52GpqDPMZ8tEKK+EF6HhG5+KDVbBrBQdmW7fdslVStoFhfkYE2MJ1K4erICJ8jyT0jg2MAmGRsLAkse3AowVVeDl/Qtp4Jpq4hqFLpNn9smLvFeg5KF/xM2X/qEjQPnaYXhADjqQ1zPYkZSG7Lv4pWR+RwDe9vFsvZlXXMxG4fIwTwvrVjMS5iNGtl+bT+2o/qeFpxCdqpllfPp8NZvxcDDueYoye7I5iVMJB5b7+98O0bxG7QZYlhkswZ5xS3xmgnWNXKfMlD6C8Ouovoq47yCFSXkiVcbWkDMkc3enRrwhpT4BQFScFYwKCsDN8YSBfa2mWOclCOng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 03:28:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:28:46 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 12:28:43 +0900
Message-Id: <DK5MRB6JWL34.3IRXDQ8KWWAT7@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] gpu: nova-core: wait for RISC-V HALTED on FSP
 unload
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-10-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-10-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4621ccfb-a3bf-40b4-588a-08dee86a8109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a1e6yr61IAGfQo+TRwJ7eaEgxE4EFZDLxi83x5l+IvvV5SUAfvfKITiXYBkCvr/1qxpO/vl8OSPPXuOgylc77XuYRcoz/fnsXfgCE6IVY9m+oiJMO7fU3uPpEb45geXXV4Gr5rFw7ef48gdMCh+KV9eaDrL3NycDgSvkh4+z6GqOVIahaRkuQZYr7ZhrBGoXm7eZnXfnDiH5TFgIsDdGjsOKNx/WBZO+S7+hWgQw+RbV+4LNEgmua1Kw3m2w+sOzaZ925kcqKj7wxqCnIZPzake510OBFD+H8jiScrjbnTg3qNzpc41T4s6q5kSetAM5dr2SrbQbBIOa4qdyFahd9fnaTXlTAlefDKp8AaGkVJFwxkiPUOKmFVh9hRFJMNz77H6RoCOrqysIDMbSz9rJKZSRyV9g+OLLJC9FHwE2j3v+4Uk2ZqWW/nqYDev/y0+3u7fFpgia+LbDnsJUFczhxmPYMYfaJ/44cLDFG5XQaCF3QmxE2yTDgbpa5Mj2V0/IE0ezZVaApQmrBir53V45EHQKB2tu6hwMHsnDRnYb5W+A5BSrwNu77iyXM5skBYKwpytZT8H8jXVNhHU+FM8XzKIO3u02tDwoXICyOQxTvFZSLKFpgUlq4I/cHqHht+0K9XS8/piTYKUX6j+/1TUoGmxUhk3bm38q3jasvBlasVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk1uTDlKaytoRUZjWlgxVkRKV3pCa0FxbTJKV0d6aHRzNVQwSDYrQVNFbWh4?=
 =?utf-8?B?enB3dElyUXptSlZNdzVmMFBabjU0Q0M2L3dtMElIWEh6TUxkajM0M1RrYjZE?=
 =?utf-8?B?b0o5SUVlMWhJQXBVeUI2RVdwdE13WmIzSjZ1VE12V213c2dxR2RocG9rMUVt?=
 =?utf-8?B?d01aWHJDdXUyemJWMkdlVzRoZjVjNWtCUFVQdGw3by84ZENjM3BJaFo2QTEv?=
 =?utf-8?B?UHgrbE85UEFVMzJ2ck5hck1odzc4YmNEUVVjcHpMaWJtN3hCU0pNamdkMHZs?=
 =?utf-8?B?Z0ZjclJRdEo2S29NVGNuMlFFUGNTK3VkU0J1OW9TKzdSU1VtZWYwTk85aWRi?=
 =?utf-8?B?NVFzbVAzR0c3eDlhdEZObDVHVmQ5L3F5bGZ0ektPM1NFaXFpV1V6UzZ1UVRp?=
 =?utf-8?B?Y2NMTFRCdU0vcG1HMS9laXpuRmh2SjNMUzJIN1Y1UUpFczFncU9FNXk5dlp5?=
 =?utf-8?B?YkxwSVN1Rlp5UnNrajRnU0sxYTdwRWl5T2o0TU05c3c4N08zdjM1RjhMS0NV?=
 =?utf-8?B?aS95M001U2h6OUM0REo5M2hsYnE4SDl2YWQ2K2RMc3ptQngvVUo3Y3lJWTh5?=
 =?utf-8?B?M0JGOXZhclZ1Q0dRcUFKaUFHbVRKQkFtb0VGYzlLSWdpNWhkSTFuWTRxdDdW?=
 =?utf-8?B?YzVEcEdrVFE3ekxWYmZxSXhTWmE5V3crMUNvZlNlZ3VycHRsTE1VUkM3Q0px?=
 =?utf-8?B?Z3dPM0QxQ2diZS9rRzg4dVhIRDFmdVdUVGE1RVhUQ1gzVFBUSkwvOVZndjJ6?=
 =?utf-8?B?dzE4YW5qeXl5UHI2MEdnMHViQ1BtenF6a0l0RWNzV2s5MU96MVQySDVLVGdE?=
 =?utf-8?B?SENrMDk1QlRkNFoxQkFLNzM1NXNuZFUydUpid0N0REhXUER3Z2FNNEI0UHR5?=
 =?utf-8?B?bnlZdXRhUmVuQldTUGFQY01GNy9rZVlGYlZxUnVKMlFpRVNVVnV5aTRydDBR?=
 =?utf-8?B?c080WC9DVlZkUlRmZzJaWGlvQ0V3Y3M0Ujk4bnhGRnE1cTRidTdwQzMwOUV6?=
 =?utf-8?B?dEhBYVNIL1ZnRmxyR0VnYnJEckE5dVhkSkN4eXp0ZWMveG10S0kwRmUyRnZa?=
 =?utf-8?B?WWRUUG5RcFVnN2craXRDVjhjbVRYNWNsRlBtbi96LzNxOC92MG5TNTVJQkdk?=
 =?utf-8?B?c1ROUUdrcUJCMTZscysrTVdsZkpLaDJDSlVpbmVuT1JuS0d1eE5BZ0xUQVRL?=
 =?utf-8?B?YTJRTENMalFOcDRZZTZzUmxJUmZXYzlPb1ZseXNNZGpkSjZFdU12Mk9WWVVM?=
 =?utf-8?B?TmVXc2dsT05OT211RlIreFFVK3FhTFhGZXBobmZuNi9HalNObmJXTWZPYlJH?=
 =?utf-8?B?UWtiWjhib1k2SWJaNVhiV1IxanNsaFZxREgwdFAybHVPaTF3Wk5xNGxtMVEv?=
 =?utf-8?B?VHdJbmhTbFEyY1dUaFVlRmV5SkVJMVFTMmJCaStDTnNOa0NZazNOd1ZTWEV0?=
 =?utf-8?B?STV6aDl5a0FQK3kyRjB5TWZTT252b0dFWHprUGQyQW1leFM4RlFoMnRhYVhp?=
 =?utf-8?B?djY0ay90QmI2bW8wQ2sxUW1SOVA0YktJeW14eUV5aGgwYUhvZlJNQzdQL2hW?=
 =?utf-8?B?OHI3cTJsSGlrU1owZDg5T3U3S1RQZzZSbGl2VzU5c2xaV1FKcnZuQUo1SkRU?=
 =?utf-8?B?MGRoT2RLS1FubHFFdWlBcVI1SVA4d0hHSE9yZEhKdWZkRzM5eVg2ZlRaZ1NG?=
 =?utf-8?B?SGQ0SVk5VlFLYk9hbElkQjRRMTZaaFYrUjJFUS9jVVNaVUsxand1Zzh6Q29M?=
 =?utf-8?B?NFZlbTZ5NmVvbHc5eWM2K2NSUitJdUZvR3l3Ulp5MGRmOWQ3cUd4SlNyS1VW?=
 =?utf-8?B?b0ZNbUlyejJrUDVuZWhSNG5tNTN0Smg4Vm9CeEk5ZUdPQm5DSGVGS1pBa0Zj?=
 =?utf-8?B?cUszZjBFS2Z5RjNlTGtncFFUN3pVaGFWWldtUitRV1hWREJpdUpiNUFLVk9u?=
 =?utf-8?B?QjFwZXpaUUxlRWpuc2syRFUxSmtSOVlWdzRMNG1xcFFSRjBRaHROZDEvdi8w?=
 =?utf-8?B?a250QVo3MlpQdXVvenBNM05FZk5remJ1ZW1BWFlOa0hURVBUWU1zZjk3aUtM?=
 =?utf-8?B?Q2ZOMUJ1NlpvZm5IQkxOaFpnZFNwWlIvd2k4NklpQ0x2V3BCdDBpSnE2S05C?=
 =?utf-8?B?cHUzMzdtai93QkFNVUV5UU9aRHNnNzN6ZktBWjZDUTBLYnNwMWRmK3RwdjFK?=
 =?utf-8?B?YnZnWm9sVnNQOC9LVTF3UUlaWUE1bVRwY2VqazMwRVQ5WXgyUTE3M3pLakMw?=
 =?utf-8?B?WldMYklMamdrT1dqclhJSWtQU1AvOUVzb1l4K3VWbXJzOW1LMjNZKzFLaFNN?=
 =?utf-8?B?T1FoWGYvNEYrVysrRFRiejdkSi9DKytxcWkyc3VsMWVkc1BUVjBKNlp0WWZP?=
 =?utf-8?Q?4m944GPhRqqODPnEfLV82zTGW5M6mKyoEtZuTNiEWipD4?=
X-MS-Exchange-AntiSpam-MessageData-1: Mztml/baMgeV6Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621ccfb-a3bf-40b4-588a-08dee86a8109
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:28:46.3948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvJ8tSskyntZDn3eeNcpOHlS+3G68r6ADQ6YYEyeglszS/5nusYoKSsL8PlxwqKhxDxkFboq/3RnydLe5Wjdew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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

On Fri Jul 3, 2026 at 3:22 AM PDT, Eliot Courtney wrote:
> Currently the code waits for "not active" but this is not the same as
> halted as there are more than two states. Match openrm here and wait for
> halted instead.
>
> Fixes: c7fea1f70944 ("gpu: nova-core: add non-sec2 unload path")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/falcon.rs           | 11 +++++++++++
>  drivers/gpu/nova-core/falcon/hal.rs       |  5 +++++
>  drivers/gpu/nova-core/falcon/hal/ga102.rs |  7 +++++++
>  drivers/gpu/nova-core/falcon/hal/tu102.rs |  4 ++++
>  drivers/gpu/nova-core/gsp/hal/gh100.rs    | 11 +++++++++--
>  5 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 78948cc8bff3..ec286017535f 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -749,11 +749,22 @@ pub(crate) fn signature_reg_fuse_version(
> =20
>      /// Check if the RISC-V core is active.
>      ///
> +    /// Note that this does not imply that the RISC-V core is halted if =
it returns `false`.

I would say "guarantee" instead of "imply" here, wdyt?

> +    ///
>      /// Returns `true` if the RISC-V core is active, `false` otherwise.
>      pub(crate) fn is_riscv_active(&self) -> bool {
>          self.hal.is_riscv_active(self)
>      }
> =20
> +    /// Checks whether the RISC-V core is halted.
> +    ///
> +    /// Note that this does not imply that the RISC-V core is active if =
it returns `false`.

Same here.

> +    ///
> +    /// Returns [`ENOTSUPP`] if the status is not available.
> +    pub(crate) fn is_riscv_halted(&self) -> Result<bool> {
> +        self.hal.is_riscv_halted(self)
> +    }
> +
>      /// Load a firmware image into Falcon memory, using the preferred me=
thod for the current
>      /// chipset.
>      pub(crate) fn load<F: FalconFirmware<Target =3D E> + FalconDmaLoadab=
le>(&self, fw: &F) -> Result {
> diff --git a/drivers/gpu/nova-core/falcon/hal.rs b/drivers/gpu/nova-core/=
falcon/hal.rs
> index ee4a017f3a4c..7e532889a1f4 100644
> --- a/drivers/gpu/nova-core/falcon/hal.rs
> +++ b/drivers/gpu/nova-core/falcon/hal.rs
> @@ -53,6 +53,11 @@ fn signature_reg_fuse_version(
>      /// Returns `true` if the RISC-V core is active, `false` otherwise.
>      fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool;
> =20
> +    /// Checks whether the RISC-V core is halted.
> +    ///
> +    /// Returns [`ENOTSUPP`] if the chipset does not expose RISC-V halt =
status.
> +    fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool>;

It's a bit unfortunate that we add a runtime error check for something
that is essentially known to never fail (the GSP's GH100 HAL being the
sole caller of this method). I cannot think of a better design at
the moment, but this hints that our HAL could be improved as I think we
already have several instances of the same pattern elsewhere.

Not a big deal anyway - if you can confirm my wording nit above, this
one should be good to merge as well.
