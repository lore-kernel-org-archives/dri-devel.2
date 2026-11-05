Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E95606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jq93ty8n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D7210E229;
	Thu,  5 Nov 2026 14:43:58 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEBE610E229
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJeWt05p3MnjonqYhTc/vepWKdFF3JQjEUDQ58mIsGaxYfItjYCHPoUj5isurv0f30ArU9gW+H0qUXxolCm5MYZZEXPn7C3sAPFDRbTJIFpuNYn6LziY9D0VmVIH4MXcjVMaBzhssgySaCQA68J/tb2YBtHG1qYzdenwD139kEUNO9QcZNRjtLRbniAUOHRPR7UwYCSSqWqrmzxyV6akYFCzK0wChlozVPn6qy3wGIQPzL2IH465Lk0bSDlyYy+GABECE0XwErDI7COdtRLz8UUv2dhWaypotaISbHxD4F12wigzx40PH6DsUYr5ZjUhJwW/Q6jH4igejsWW82LK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFi8ZQrci09mYcmAltXIh7RHjAlfKCB0jgbOvaMiCYY=;
 b=eg2kC3kugZ1YhPnpYZokk5XlAJRV2DfrNPDQHa+v1bE67n1CU2vn8M4ALzQwmkaWD1Jnpo60Uko0xx/k+GtSqAzjON+OuJ1ikiMbmDLNLgwyyvEIKucffh2kcPy148vUUHNyS+KKHPEEPTMb/CZGcb5nZ2T/+CypZildYKeO/Y8j+GWg36/h71mvGzgH/JepAm8/z7m22Yr3EnuNe9zFaNm3ciqdg9UGI1dPowjeq46y0vJBnhq5PtD7zOVWd7ojJj7MbbCIp3Qz6ZvnO2x1ggdHnXprc8GreD2qjNw8MzkHO6vVgbdR4jx5AivjdGNmZPtabgwty/bHJucQgJcg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFi8ZQrci09mYcmAltXIh7RHjAlfKCB0jgbOvaMiCYY=;
 b=jq93ty8n86/0ly6YKmRKNfiyQAaL4XXgW6gdmhgEFEQvjgrOw2ZPwD4aFz7bLupTVdmbDFR9I73R5waVRikgvc4e0x9cyIXTA4/OFToUKyn2r7fa0cfv3DvILuQRVDnxvBYJTN/JDBZ4mAdhpl8y6HAhdQYvd1YhvBzn640UXWFqC1MF5PJVNI15jbxhsuX6U18uzAeOatdE5xInv0btxtcDK7UNoJIqNSs9Tuqjav3jpTg9hM1tuCBRkKmpPC0PAv2H6z1OPooONJNE8mc1fwk2fU5G2VhY6YHWGs+FJJHbiQETmRJU9HPxMJg0Kb/tS4Bky2E3eTO61Ln67oM7KA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LY0PR12MB967422.namprd12.prod.outlook.com (2603:10b6:408:3bc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 14:43:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Thu, 5 Nov 2026
 14:43:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 23:43:46 +0900
Message-Id: <DMNCVDFYPL3I.3CCYXY4641F13@nvidia.com>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: add support for GPU timer block.
 (v4)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
References: <20261105-nova-timer-v4-0-45a7c121d4de@redhat.com>
 <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
In-Reply-To: <20261105-nova-timer-v4-2-45a7c121d4de@redhat.com>
X-ClientProxiedBy: TY4P286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LY0PR12MB967422:EE_
X-MS-Office365-Filtering-Correlation-Id: 27dcf141-3b84-4ef5-b01d-08df3b4b3392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|10067099003|3023799007|4143699003|11063799006|5023799004|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261022075727099003|261021135927099003|56012099006|261022105027099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: +SfFJ4Vi/S/AUOFUr5O5FlQhNyE68ZpPUsXDxR3rXAq2cM6RO6XZxI6o6vgG+06EWhgxwU5G0+oL+zadCnQzNWuTkQjEHTOTjKszmfxsxHmPrLP6LwasofAKrOPTBlvdxra95dP4w87thhnkmVwPZuNHq+swpZBrMWkOefBTjqf6ffBX7WUuX2QnyKfMRpc874X9YUkfI/2als+aQdKREEqHpKU18Me5md11OH7NChyzLO+ybwpO1fSLo8P4Kjfkb64TLzSto/Fl0mcIX8eMcHrzt9jrAvXWnxABtG4pqi9sJha0DSCon2/0eHvhIBn0Z+WlOug4oeMjzncsykGM5ApmRi2Txe7aSpJhZSwuTVQnAQ8klJL0opqnCo6f1zpcVSapNqkXbu75gqs7BJ/24kfFyQLdfY8uvg/2zwNN4OPzDJ9ZlEhRZ/l638g/wnUCjBAxIav+Do8yT7q6xpvTpkpuyRUG6PM0RHiwSuSL7XJz62lGmfQIaOnl5VZFlzzGbbXN3a3IlCdkW+Bvvg2wrgSt98qz5+p3vlPGVx54Pnrb/XMekBmD/WAPdHP/R2zL+skm1gGpLIJxXl1YkZ7mTjxJGdpfXAtKeRyVR2PKMPpOa+h4HOxAvSocXVweqeE7eZcFjD6iX983LEftI3+t/eBWWifqhKUJPymSVJXb7NU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021135927099003)(56012099006)(261022105027099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE5xZ21yYWxESDRjSmRtT1kzUGJIdzBYRnVraHVlZGJzaE9uVExITXNOS204?=
 =?utf-8?B?SkJENjlhVXpRaTFLQ3pXTEZSbEtQYmhIQ0V6MTI4YnpwYUtMaG5veHA2cUdy?=
 =?utf-8?B?ajdzWThoNk9ldXMvSzcrakdTcXlmaGF1SFFsTEdkakRXMnAvRmpyZ1lGQjdP?=
 =?utf-8?B?K0s4dUNZVmNwWit1REpYQXd5U3JvSWpjQ05tZ0d1YjZkRWxYN0NDTDZKd0hT?=
 =?utf-8?B?RmVLOEZQNFdzWTg1RjkxNFVzR1dEa2dFNDNPUjlJNGFNY2xYeG00RXBmTnU4?=
 =?utf-8?B?ZEVHazZzZktYNEVaNTYxTkx2TmNmNm5KeVhaTFJpUmZHWHlmTHhmRWRWdDZa?=
 =?utf-8?B?TXVaQWhOZ1d5bWdYVkNRREdpWUtDbGhwbVc5UnJaK1N1QmpMOGRVc3lUMUF3?=
 =?utf-8?B?WWhqMUpnaDRiN3ovN1lPSVdpTUJnb0l2UG52V2ZEb1cwdDhqNjJwT1FRTm9L?=
 =?utf-8?B?dnRBTUFHR3EyT285a3N2UVFTN2xDTkYvREhjbzJjTXV6Z0g1aWduNEtEKzVX?=
 =?utf-8?B?RjV6UCtLRjQ5SEpZbUpzWDdaWUdTUGo5ejNaTlZYMmhRRjlVYktCdmdMZnRV?=
 =?utf-8?B?OVdsQU8wNDI0NlZqWVJ6SE1wY2tRTTl4RXNGWHoxNyt2WFdJek1FRzk2RHJR?=
 =?utf-8?B?WGdxM0N1MEtvbFJCZDdFM3UwSEErbjkwRmZOK1lKZUxwY2tmcmtLNnowUU5M?=
 =?utf-8?B?aFRzWlB1b2c0Qm93c2VBN25Pb3c3T2p4V3cvZnAxYWxJcjdKcTZVUHUzUk5k?=
 =?utf-8?B?VktySG1pZ0F2ajM1UHFBQjMvZGo1NWRiZyt5cnRHbDlPdmJrK3ZOSDhHbTRo?=
 =?utf-8?B?VlVTa01LZlJ3TThxY2k5R3VpWitITW1ua2F5K3VtbUc0dy9WTmN3M1BDemQ2?=
 =?utf-8?B?eVJRM09neWthblpHOERYZitGbXhLZnhYOGlkbFV1d3V1OEcxcXRDa3pJSlVN?=
 =?utf-8?B?WllseXBORWNtNzRiN1RVMDRPQzQwSi90QlpkS1J2Snc4bUJZVllHWjlYR1ZH?=
 =?utf-8?B?RnBMQlZ1QkhVRDdYWUd2RkdsUnJUQ0NoTHhtV3V0MDBHak52aWJ3cGNUZ2l5?=
 =?utf-8?B?Szc0dmNQMEJ4VGZuVFFlL1ZrWmlRbzkwUDRKQlFjRWNNYjVaWDBEeWRwRmFl?=
 =?utf-8?B?dVg0cVJZZnZuOU93TUpKS2xrMEFyUEx1bnJPTUE0RGdmRWZhbzdJMEJKU3Vt?=
 =?utf-8?B?V3pPM0RHM1lGZ2E4K0w3V0U5dDIwTHAzUjlMQWdrb1lkR2FSYjhSd20rblFO?=
 =?utf-8?B?OFJqZTN5U3Job2FJVllZMzdzV3llM2dkMExuYzBZTFZVeS8zNnJ5cS9aNlFT?=
 =?utf-8?B?dXg3bytMd0F1UEpTVW54U21neVlLUjlRVVE5WjlLU3QvcFJQVVYxWW9lNTlw?=
 =?utf-8?B?MjdNdklvWkNKZTZjcStpc3NMUDhrdU51L2xrTUd3c2lTWHhmaTYwOTN6MWFj?=
 =?utf-8?B?VEp4ZWZtcVBlTEVOTmYwa2F3aXFYWCtqVmwyWm85cURlTFFYaDBSU1F2dmFT?=
 =?utf-8?B?Yk9lMkxWVXNXanFkY1Q4TEhmb2Q1emQxZW5oRzRsZGxTakRuaXNlVWRWYm13?=
 =?utf-8?B?WWxGKzRhdlF3WCtGK2dFZTIwZUFsRThJT29OWnY0bFYrd3JzRVlOM3JuSi8w?=
 =?utf-8?B?TGM3UG1lbWxIMjVpRDh4K3dkRWtJWVhHTUhIZ1orU3VXTmlhVW1wRFVHZHJw?=
 =?utf-8?B?bkh0S2J4TEtzQnpaTTdWSktGcGRQV3BWa3JQQ0lqTlJUL1c0anNCcTg0elZF?=
 =?utf-8?B?TWdkSlJjSVJPeXpqVjR6VzIyMnpQQlFLa0JUdmNUemQxZ0k4ZUM5MDcxS3hF?=
 =?utf-8?B?L3JvUDYvZzFQYUtnRW9PYndDMVVVMHovU25PRWMybmN0endHQ3BNamlNWXdD?=
 =?utf-8?B?TzFQNll1bkFIeWNldmpCYzZCWjJmRjhnV0cySzB3eVlVWWw3cHg1SDQyWDUz?=
 =?utf-8?B?b1VQR0orM1doK3FzdmJoMmhKM05kNnk5bWV1YkVuOXRsZVd4Q3lyQWUwakxD?=
 =?utf-8?B?Ymc2d29XWkxZQU8xdzF3YXBiVlg0TDFaU2YyelpJYm5jWWRMWmZKTW9DdEp1?=
 =?utf-8?B?UHhuc3VEWGNMTkJNMjcvN2tERHdpRVNnSm9ocllCc0RxNnU2U1dOM3k5RnVy?=
 =?utf-8?B?Vk1XQU45bmF2UU9MQ2ZRbVpLRWZMSjZZbCtFS3QvVnpBUjU3VFlBK2t0QnNp?=
 =?utf-8?B?RW9MYlNEMWFJZlBmS1BSbE0waG5XQkZTSGN4N0dQTUJTZ2dBaDhnL0NqdDYx?=
 =?utf-8?B?eTIyM0tDa0RCeHRjUWJkcXFjWTJ4RGVyQldTQ0syN1dHdEJRYk1CSTNzMlRJ?=
 =?utf-8?B?dWFaTVFMUGZCNXVWTmZiRk9DSklnTGVlSXZ4ZFNyQ2VsWC9WK01ieERkckRG?=
 =?utf-8?Q?B01QeeW0AJJUQhvx91ZDbKyEM40yYQSQ/GKjS7svZhRd5?=
X-MS-Exchange-AntiSpam-MessageData-1: dc6x6WUz7pAtsA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dcf141-3b84-4ef5-b01d-08df3b4b3392
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 14:43:48.5297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SfPy8a51IFI2L/X2yB9JfH2GzKUsaxUI+f1pavlPLOx6DMs64b4t9I8Li5tYKfI59/Sp091I0nqcDua/fgLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB967422
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

On Thu Nov 5, 2026 at 12:07 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> This is needed to calculate the system timer offset that is passed
> to GSP init.
>
> 2 HALs exist:
>
> a) tu102 is the gv100 path from open-gpu, the priv level is checked
> and the cpu time is written to the gpu timer. no offset is used.
>
> b) gh100 as two variants, gh100 and gb100.
> This is the gh100 path from open-gpu, where the secure system
> timer is read, the offset is calculated.
> On gh100 which need a work around we avoid sending it to registers
> other we write the offset to registers.
> The gb100 path just avoids the war.
> The value is also stored to send to GSP.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

There are a couple of Clippy issues with this patch, please make sure
to build with `CLIPPY=3D1`. `make rustfmt` also reformatted a few lines.

<...>
> diff --git a/drivers/gpu/nova-core/fsp/regs.rs b/drivers/gpu/nova-core/fs=
p/regs.rs
> new file mode 100644
> index 000000000000..d4b8482a6854
> --- /dev/null
> +++ b/drivers/gpu/nova-core/fsp/regs.rs
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +pub(crate) mod gh100 {

FSP only makes sense for GH100 and more recent, so I guess we can do
without this sub-module?

> +    use kernel::io::register;
> +
> +    use crate::{
> +        driver::NovaRegisters,
> +    };
> +
> +    // FSP PRI space; the timer is its only consumer so far.

I guess we don't need to mention who the consumer is here; especially
since the list might increase in the future.

> +    register! {
> +        base: NovaRegisters;
> +
> +        /// FSP ucode version, encoded as `major.minor` in bits 11:8 and=
 7:0, written by the FSP
> +        /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` in =
the hardware headers.)
> +        pub(crate) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {

We are trying to keep registers (at least those defined within
sub-modules) local to their owning module, so ideally the visibility
should be `pub(super)`. And instead of accessing the register directly
in `timer`, a `Fsp::is_bug3957833_affected()` method would expose the
functionality we need.

> +            11:0 full;
> +        }
> +    }
> +
> +    impl NV_GFW_FSP_UCODE_VERSION {
> +        /// Check if the hopper only workaround is required
> +        pub(crate) fn is_bug3957833_affected(self) -> bool {

So as mentioned above, this method would be moved to a method of `Fsp`
that `timer` would call, keeping registers local to their module.

We will need to store the hal and `Chipset` into the `Fsp` struct for
that, but that's standard practice.

> +            /// FSP ucode version from which on the fix for bug 3957833 =
is included.
> +            const FSP_BUG_3957833_FIX_VERSION: u32 =3D 0x44c;
> +
> +            self.full().get() < FSP_BUG_3957833_FIX_VERSION

You can omit the `.get()` here, there are comparison operators
implementations between `Bounded` and regular integer types.

<...>
> diff --git a/drivers/gpu/nova-core/timer.rs b/drivers/gpu/nova-core/timer=
.rs
> new file mode 100644
> index 000000000000..e7ad37806e5b
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer.rs
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +mod hal;
> +mod regs;
> +
> +use kernel::{
> +    prelude::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    gpu::Chipset, //
> +};
> +
> +pub(crate) struct Timer;
> +
> +// struct that just holds the sys timer offset
> +// after initialising the GPU timer block.

Can this be a regular Rust doccomment? If possible describing its
purpose, not its contents.

> +pub(crate) struct TimerState {
> +    /// This value is to be passed to GspInit SYS_TIMER_OFFSET_NS
> +    /// It is considered an opaque value, passed from timer hal to GSP.
> +    #[allow(dead_code)]
> +    sys_timer_offset_ns: u64,

I assume a future patch will need to read this value, so we can
preemptively make it `pub(crate)`.

> +}
> +
> +impl Timer {
> +    /// Initialize the GPU timer.
> +    pub(crate) fn init(bar: Bar0<'_>, chipset: Chipset) -> Result<TimerS=
tate> {
> +        Ok(TimerState {
> +            sys_timer_offset_ns: hal::timer_hal(chipset).init(bar)?,
> +        })
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/t=
imer/hal.rs
> new file mode 100644
> index 000000000000..b78066bf9a0d
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal.rs
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::prelude::*;
> +
> +use crate::{
> +    driver::Bar0,
> +    gpu::{
> +        Architecture,
> +        Chipset, //
> +    },
> +};
> +
> +mod gh100;
> +mod tu102;
> +
> +pub(super) trait TimerHal {
> +    /// return system timer offset ns

nit: capitalization.

Maybe also explain that this can program some timer-related registers,
otherwise the name `init` isn't justified for someone who believes that
this just returns the time without any side-effect.

> +    fn init(&self, bar: Bar0<'_>) -> Result<u64>;
> +}
> +
> +pub(super) fn timer_hal(chipset: Chipset) -> &'static dyn TimerHal {
> +    match chipset.arch() {
> +        Architecture::Turing | Architecture::Ampere | Architecture::Ada =
=3D> tu102::TU102_HAL,
> +        Architecture::Hopper =3D> gh100::GH100_HAL,
> +        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x =3D>=
 gh100::GB100_HAL,
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 000000000000..0486df588964
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    fsp::regs as fspregs,
> +    timer::regs, //
> +};
> +
> +/// Timer HAL for Hopper and Blackwell.
> +struct Gh100 {
> +    /// `true` on Hopper, FSP ucode on newer GPUs always has the fix.

This comment doesn't parse for me - can we simplify it?

> +    fsp_bug3957833_war: bool,
> +}
> +
> +impl Gh100 {
> +    /// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode p=
redates the fix for

If we name OpenRM methods, let's state that they come from OpenRM as that
name might be confusing to an unfamiliar reader.

> +    /// bug 3957833 and hence the sys timer offset must not be programme=
d. Can only be true
> +    /// on GH100 with older FSP.
> +    fn requires_bug3957833_war(&self, bar: Bar0<'_>) -> bool {
> +        self.fsp_bug3957833_war
> +            && bar.read(fspregs::gh100::NV_GFW_FSP_UCODE_VERSION).is_bug=
3957833_affected()

With the change suggested above we would call something like
`Fsp::is_bug3957833_affected()`.

> +    }
> +
> +    fn timer_time(&self, bar: Bar0<'_>, time_ns: u64) -> Result<u64> {
> +        let mut sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_=
SEC_TIMER_TIME_1));
> +        let sec_timer_ns: u64;
> +        loop {
> +            let sec_lo =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_0));
> +            let sec_hi =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_1));
> +            if sec_hi =3D=3D sec_hi2 {
> +                sec_timer_ns =3D u64::from(sec_hi) << 32 | u64::from(sec=
_lo);
> +                break;
> +            }
> +            sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_=
TIMER_TIME_1));
> +        }

Looks like this mirrors the `timer_read` function of `tu102`, can we
move it into its own method for symmetry?

Note that you don't need to wrap everything in `u32::from` - register
values can be compared directly. You'll just need to access `.nsec()`
when building `sec_timer_ns`, and shift `sec_lo.nsec()` by `5` (or
better, `NV_PGC6_SCI_SEC_TIMER_TIME_0::NSEC_SHIFT`) to get
the actual value. Usually when we have a value that needs to be shifted
we add a convenience method to the register type directly, that probably
applies here as well.

Then if you bulk-import `regs::gh100::*`, you can also shorten every
line that accesses a register.

> +
> +        // The system and the GPU timer are both free-running with unrel=
ated epochs, so the
> +        // difference can be negative. Both operands are < 2^62, hence t=
his cannot overflow.

This comment doesn't look right, both operands are `u64` and IIUC this
*will* underflow if `sec_timer_ns > time_ns`.

I'd ignore Sashiko's suggestion as it looks like it is trying to
reconcile the code against the comment instead of the other way around.

> +        let sys_timer_offset_ns =3D time_ns.checked_sub(sec_timer_ns).ok=
_or(EINVAL)?;
> +
> +        if !self.requires_bug3957833_war(bar) {
> +            bar.write_reg(
> +                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::try_from_ns=
ec(sys_timer_offset_ns)?
> +            );
> +            bar.write_reg(
> +                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::try_from_ns=
ec(sys_timer_offset_ns)?
> +                    .with_update(true),
> +            );
> +        }
> +        Ok(sys_timer_offset_ns)

Once we have moved the timer read loop into its own method, I guess the
remainder can be nicely folded into `init` directly, and we don't need
`timer_time` anymore?

> +    }
> +}
> +
> +impl TimerHal for Gh100 {
> +    fn init(&self, bar: Bar0<'_>) -> Result<u64> {
> +        // The open drivers uses wall clock time here not monotonic
> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        self.timer_time(bar, sys_time_ns as u64)
> +    }
> +}
> +
> +const GH100: Gh100 =3D Gh100 {
> +    fsp_bug3957833_war: true,
> +};
> +const GB100: Gh100 =3D Gh100 {
> +    fsp_bug3957833_war: false,
> +};
> +
> +pub(super) const GH100_HAL: &dyn TimerHal =3D &GH100;
> +pub(super) const GB100_HAL: &dyn TimerHal =3D &GB100;

We prefer to keep each HAL in a module bearing the same name, so `GB100`
should be in `gb100.rs`.

But if we move `is_bug3957833_affected` into Fsp, then both the
`fsp_bug3957833_war` flag and `GB100` HAL can go away. `Timer::init`
will just need to be passed an `Option<&Fsp>`, which it passes down to
the HAL method so it can query it (similarly to what `VgpuManager::new`
does - only with `as_ref()` instead of `as_mut()`).

> diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-=
core/timer/hal/tu102.rs
> new file mode 100644
> index 000000000000..c0777b777362
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    timer::regs, //
> +};
> +struct Tu102;
> +
> +// this code will be used in the gb10b hal eventually
> +#[expect(dead_code)]
> +fn timer_read(bar: Bar0<'_>) -> u64 {
> +    let mut hi2: u32 =3D u32::from(bar.read(regs::NV_PTIMER_TIME_1));
> +    loop {
> +        let lo =3D u32::from(bar.read(regs::NV_PTIMER_TIME_0));
> +        let hi =3D u32::from(bar.read(regs::NV_PTIMER_TIME_1));
> +        if hi =3D=3D hi2 {
> +            return u64::from(hi) << 32 | u64::from(lo);
> +        }
> +        hi2 =3D u32::from(bar.read(regs::NV_PTIMER_TIME_1));
> +    }
> +}

Here as well you can remove the `u32::from` easily.

> +
> +fn timer_time(bar: Bar0<'_>, time_ns: u64) -> Result {
> +    if bar.read(regs::NV_PTIMER_TIME_PRIV_LEVEL_MASK).level0() {
> +        bar.write_reg(regs::NV_PTIMER_TIME_1::try_from_nsec(time_ns)?);
> +        bar.write_reg(regs::NV_PTIMER_TIME_0::try_from_nsec(time_ns)?);
> +        Ok(())
> +    } else {
> +        Err(EINVAL)
> +    }
> +}
> +
> +impl TimerHal for Tu102 {
> +    fn init(&self, bar: Bar0<'_>) -> Result<u64> {
> +        // The RM uses wall clock time here (osGetSystemTime -> ktime_ge=
t_real), so the GPU time
> +        // matches the host's real time, e.g. for timestamp correlation =
in userspace.
> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        timer_time(bar, sys_time_ns as u64)?;
> +        Ok(0_u64)
> +    }
> +}
> +
> +const TU102: Tu102 =3D Tu102;
> +pub(super) const TU102_HAL: &dyn TimerHal =3D &TU102;
> diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/=
timer/regs.rs
> new file mode 100644
> index 000000000000..3de7174f20db
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/regs.rs
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::io::register;
> +use kernel::prelude::*;
> +
> +use crate::{
> +    driver::NovaRegisters,
> +};
> +use pin_init::Zeroable;
> +
> +// PTIMER
> +
> +register! {
> +    base: NovaRegisters;
> +
> +    pub(crate) NV_PTIMER_TIME_PRIV_LEVEL_MASK(u32) @ 0x00009430 {

All the definitions of this module can be `pub(super)`

> +        4:4 level0 =3D> bool;
> +    }
> +
> +    pub(crate) NV_PTIMER_TIME_0(u32) @ 0x00009400 {
> +        31:5 nsec;
> +    }
> +
> +    pub(crate) NV_PTIMER_TIME_1(u32) @ 0x00009410 {
> +        28:0 nsec;
> +    }
> +}
> +
> +impl NV_PTIMER_TIME_0 {
> +    pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
> +        Ok(Self::zeroed().try_with_nsec(((nsec >> 5) & 0x7FF_FFFF) as u3=
2)?)
> +    }

Clippy pointed out that you can get rid of the `Ok()` because
`try_with_nsec` already returns the expected type.

There are 2 operations that silently truncate the passed value - the
right shift (which we cannot avoid), and the mask. We should document
these, or maybe take a `u32` to leave that responsibility to the caller
so we only need to mention the truncated 5 LSBs.

With that this method can actually become infallible, because `nsec`
covers the full u32 range. We just need to construct the expected
`Bounded` value, which looks something like this:

    pub(super) fn from_nsec(nsec: u32) -> Self {
        let nsec =3D Bounded::<u32, 32>::from(nsec).shr::<{ Self::NSEC_SHIF=
T }, _>();

        Self::zeroed().with_nsec(nsec)
    }

The `shr` method on `Bounded` reduces its number of valid bits, turning
it into exactly the type expected for `nsec`, so we don't need to use
the fallible `try_with_nsec` method. Also note that I have used the
constant shift that is automatically defined for each bitfield instead
of the immediate value `5`.

It's a bit of a mouthful but it is demonstrably correct and doesn't rely
on any truncating operation (notably `as` that we try to avoid whenever
possible).

> +}
> +
> +impl NV_PTIMER_TIME_1 {
> +    pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {

Here as well we should document that this works with only the 32 MSBs
(or, again, take a `u32` and leave that to the caller).

> +        Ok(Self::zeroed().try_with_nsec(((nsec >> 32) & 0x1FFF_FFFF) as =
u32)?)

You can just do

    Self::zeroed().try_with_nsec(nsec >> 32)

`try_with_nsec` is happy to take a u64, and here I expect that we want
to fail if the value is larger than what the registers pair can
represent? Otherwise this method should also be infallible, as the call
to `try_with_nsec` cannot technically fail with the mask you applied
anyway.

> +    }
> +}
> +
> +pub(crate) mod gh100 {
> +    use kernel::io::register;
> +    use kernel::prelude::*;
> +
> +    use crate::driver::NovaRegisters;
> +    use pin_init::Zeroable;
> +
> +    // PGC6/TIMER
> +    register! {
> +        base: NovaRegisters;
> +
> +        pub(crate) NV_PGC6_SCI_SEC_TIMER_TIME_0(u32) @ 0x00118f54 {

Since we are two modules down, instead of `pub(super)` this will need to
be `pub(in crate::timer)`.

> +            31:5 nsec;
> +        }
> +
> +        pub(crate) NV_PGC6_SCI_SEC_TIMER_TIME_1(u32) @ 0x00118f58 {
> +            28:0 nsec;
> +        }
> +
> +        pub(crate) NV_PGC6_SCI_SYS_TIMER_OFFSET_0(u32) @ 0x00118df4 {
> +            0:0 update;
> +            31:5 nsec;
> +        }
> +
> +        pub(crate) NV_PGC6_SCI_SYS_TIMER_OFFSET_1(u32) @ 0x00118df8 {
> +            28:0 nsec;
> +        }
> +
> +    }
> +
> +    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_0 {
> +        pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {

As for `NV_PTIMER_TIME_0` this method can be infallible. Actually it's
an exact mirror...

> +            Ok(Self::zeroed().try_with_nsec(((nsec >> 5) & 0x7FF_FFFF) a=
s u32)?)

... so we can leverage its sibling like this:

    Self::zeroed().with_nsec(NV_PTIMER_TIME_0::from_nsec(nsec).nsec())

(this just leverages the NV_PTIMER_TIME_0 method to build a value,
extract the field, and write it as-is.)

> +        }
> +    }
> +
> +    impl NV_PGC6_SCI_SYS_TIMER_OFFSET_1 {
> +        pub(crate) fn try_from_nsec(nsec: u64) -> Result<Self> {
> +            Ok(Self::zeroed().try_with_nsec(((nsec >> 32) & 0x1FFF_FFFF)=
 as u32)?)

and here as well:

    NV_PTIMER_TIME_1::try_from_nsec(nsec).map(|v| Self::zeroed().with_nsec(=
v.nsec()))
