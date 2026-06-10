Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF1CCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F0D10E604;
	Wed, 10 Jun 2026 10:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vnpuV/sA";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020127.outbound.protection.outlook.com [52.101.196.127])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCCC310E604
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2XtNIVPMxkbOD/y52pzHSaqgh6bm2W8N8Mtm4MTe7J3yQmUz3IlYp3Z/84wUVVCHhy4X1ikzPXVwqUA5lLvUQmBO42+TUhCpw5EP/h7SwBGZU7AkROomQsZ0zwxXey5qV//mDar5sOwBJN0ETMixFhYOKkFR55g2ETq+ovvTH8yMXuy3wNDFI3asWVqebbyazCCUpDNOa8QIBOcZw9FzRQE3NclFJfvV693g1Mdlu7aMRcmnerc06FA11SOrL5Uy8rWgBJAfnY6cRy2H9oe06LFumdMVG19VNAyuZmytN9aK4K6Fz6aSI6G43OzO1p6KrI7JkewS01tj2mk8uotUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKL0l2zfhBrQKTpaCBWCiQSEFyBikGsoWR4z0Ve/BUM=;
 b=J/K/4rP0li6ceTbC0DzaMirrqnVv/C1KY2vqBSzvLrLsHIkuYJyxcCxJjh+8ZTY2bDp04V8m6OEXZMSl5hxE9XwhhL1SYlg2gdtPMfiqG03CwmpaKK/LXVseD8UUb+OXzZwe50fS16tuW/5YDIKJs6VJDcpXLfzNT0rm0elktDa/n0Gv8CgZmVLQ/Xq9mSGGTn26nzWBWH4hqFilHSgvITOY0aOEthep3XO7wmZvu/Dx3J30TzUZuMnHiDF4ElcmIuz+Y8qsWkpGDEqyLEhwsX/+XE3HVyvwKns5ZNE+/Mde/hJeqR47amxGjKHKxkQQBnHimZy0VS2gGcaEszSpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKL0l2zfhBrQKTpaCBWCiQSEFyBikGsoWR4z0Ve/BUM=;
 b=vnpuV/sAGZzr3XXJiWFhCJrKY5qkeNM8B8CTZAxMekUbZ7XBQX3RDfDPaQ3EJDjqTlFqvi8QC7HXePmWVowOloqpKqhuN2NpDSM8xLNDIW07wifxXr3fb+o9Q7KS/O/y9SCVNhAvdIX2DYeCnBDtl/D1T4lbqEmUhYhtFia2uCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LOYP265MB2013.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:120::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.16; Wed, 10 Jun
 2026 10:16:31 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:16:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:16:31 +0100
Message-Id: <DJ5AI4A9XVNE.1G63OSC35Y99W@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 2/4] gpu: nova-core: move GPU static information
 acquisition to a GSP method
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-2-d9382610507a@nvidia.com>
X-ClientProxiedBy: LO4P265CA0197.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::13) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LOYP265MB2013:EE_
X-MS-Office365-Filtering-Correlation-Id: 202588c5-db7c-4666-b7af-08dec6d957be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|10070799003|366016|3023799007|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VSjEyeAQeTKVCR3TCI/ey3FzHi4X2OGV3/4IdgAvMQmRp+KmqIYdAl3LC3KQycTtIf63+/uzZNAUbbRY7sxrJq4/iXnB/hJJKJxxT2FE073RoJctXbL+4gyMVqQEw8o3bH93k+z1IHC38H1jv9LuXxI29WOaSOa7QfKkeoYTH8enurVj1qBSCu6BUUW6ARiFxug07Hy0fzknZgfGipZuPHNT1R+yQ8TUN9z3CClICF7wte/vMAUOnb6bZ88w7cC3fQc09XxnY9cEzJ8hzGGicGPg6aDpKg7dzxfbuDOkQMr83bXU10QOG5yUAMU2y9AA12cRVqiUwFKYiU/+OLdyiXZ0VVCUJ1CkY91K0f0tgVsF/wA92qT3atvjZSIG6wTpc/hxGbnnHwGMaDyzmXKtJTqDhOmidw5HXBTQWSsPvVNKKRNtbXdTFUYPiIwKibh+IMf+YIi9hIkJ711YB3BBabtKFgylUaLSpAFX6jmFWcXkh4ZP7/aLN6+1Tym6zzLoROywfv4xsS5lfE1HUsYUaYVuJ3ItCOVH0uDaBNVL620Rp1pY2Kda1mZ12iWeG0oMR3SE9V6Yp65+nUjFlAzs/z+N9ZS+nfbjJNkK7PnbYE85oxzEsuE+uqHoYsqgaAXWvD3CLb3vOWbfuV9JJddaqUz+jr8dS8zxy61qBca/h9JrX6homTLNg/crB1RdQLB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(10070799003)(366016)(3023799007)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZRaWxlWFM4S3Rwb1c0TThFN1VzSUs3bHE0TGhxeUE0bXJvQkVwd0cveXpj?=
 =?utf-8?B?V3RjVGNWSmZkNkptMkU2aEorKzFlQkJ1d1lHbnVqSlRmR2drWGhYSTZTWHlr?=
 =?utf-8?B?cjUrWU1HUU92RmpOWHpkU2tld1NnWi84SzllQ3o0SHFmeEpVanJvQW9LSzFr?=
 =?utf-8?B?UWVSdDRTaXZYeURVUURlZzVKZVVSMjcxeENxeldmL1RQYWVSc1BMTm4vQ0l4?=
 =?utf-8?B?VVl5VTZkVzl2NFVSUmVWcDVNcXlrcTBzaVJyS1QzdXNtNTZPV28zVHlTdUk1?=
 =?utf-8?B?YjhrcE4wNmRsVytxS2lRQy9mdm5PejlRNjRLQU1SaDdweDNmYVkxdTVxYXZs?=
 =?utf-8?B?YVhJOE4wK3ZabTIrRUV2aDRqWkxVMHlKRmRtZHgwYlhFZTRJNjd1ZE1DTGU0?=
 =?utf-8?B?blNmSVYxM2JMYjhFb0dSZE10aUQ2Q3NHK3hzUmFyaE9DejR3U0d0ZEFPaVM4?=
 =?utf-8?B?andYeHVsemZjejM4WEI2MERLQ05PYUJmNEowNnFrQzRnRUNHS3hZTnNnNzly?=
 =?utf-8?B?czFrYmZYZHJXQityNSs5UWNJZmt3aHBXOEpmQWZBaGdXeUVwdTlrT3VyTnha?=
 =?utf-8?B?eVpuanUvNHBQaG1EVkRiM0VUQlpvR0pVcnYrM3BsSmYrbXVsZHB1bTMvSW8y?=
 =?utf-8?B?dFNRTFVPUlc5aDhYNzRCNVNKUi9XWG91U1d3dHBOdHJ3a3VvTHMwc1lXZ3I5?=
 =?utf-8?B?ZUFYc1YvTG9WUlFLREQxd1pvb3liblAwQnRON0dicUhGL2F5MGVGelVQYmNM?=
 =?utf-8?B?N2wxaDJVbm1XaUV6M3hUem9qWVBmS1A1c1ZKei94eU5FdDFNMlpVajhJTjY3?=
 =?utf-8?B?S0lwS0FRUzlYRXFCMVg3NjRXTzNuekVTQmJjdzcrSnIycmJETzltQmRrRTVw?=
 =?utf-8?B?Uk56Zm9KSW9kUkU2MTY0VGg1d3N6SHdwOGQzQkdHeVlMQ0ZnMU9tMldKVlV3?=
 =?utf-8?B?WnRrbDRCS1NSM05TMzNITk9wRk82U1VwbXZJYXBWbkZlbzhpdEYzektIbm1n?=
 =?utf-8?B?VDNjQ0s2TjZVWEVKMU5XdFFyTGVrVDVxMk8yUHNGRHhyd3FMVUdSY3h0THh0?=
 =?utf-8?B?M05sMUR5ajJLeEViWVdyeStpR21qVFMvTVk1azFDbHY4ZlExUUdCNGRZN0hR?=
 =?utf-8?B?TVlrTGtDeUsrVEFhSGJETDBsck94WUdPRlA3ckk0Nmp4WjJQQnUwaDBzL2Rr?=
 =?utf-8?B?K3A3Qzd0cm5CdUhYb3RDN0NLbEhJK3V2SnVkMzVUTTgrT3pucmZSQitWaVMx?=
 =?utf-8?B?TXNyRnMrUkRXdkczbG9EVUZNV3pwUEh5cWEyangrTERqVC9NWFM3R1hEbHYy?=
 =?utf-8?B?dlVaY3lPUURML0Y0eWtvc1h5VmRrOHpPV0gycmxsQlN5TUpjSVIxQ1NhRkJH?=
 =?utf-8?B?SVVkL0JtODZNcHFPb2QvV2F1WGVLSnBBTkhwcXB0SFNSazdTczNBbStWWmJS?=
 =?utf-8?B?NXpncGNtQ0ZaVEZTeWtmZng2MWY5N3JoaDZCK0JrZWd0S0QwL01DeWZPWFZw?=
 =?utf-8?B?THNkVzFQSmZ6b1BpOFlJSStYMjA1NEk1UEc3Nk1iWllpdGUzaXMySjFvRlB6?=
 =?utf-8?B?L1hEaWlzM3JWMVBIdXJPY2RIYm1sM29oMmJSSUVyRllKRnErS3p0amZqSFNu?=
 =?utf-8?B?b09CdkREUUxQS05HSHpNQnVES1NjeDA0ZHIxZGR1ZUpmaWNNam1VaVRhODhm?=
 =?utf-8?B?d0tGRXNacmt0QzRaNXQydGJvR0owd09sNDFQRFNyTHdtcG9GSTErTlVCa1NU?=
 =?utf-8?B?TUdKU3oxTzkzbUhiemt1WDRZanZrR2tTQjNJMzFRLzBGSDFtVE94YlUwd3E3?=
 =?utf-8?B?R1d5RktnVk1KNEI4Nnk2OTcyMFNaQ3RTM3d0VmlmWEYrMitNWWdRNWpzSmNG?=
 =?utf-8?B?REV4cjdVZGlFa0dtR3NlNURYVXo4OEl1MEsyU3d0Qk1NWnN2UUF5QUpxQTZB?=
 =?utf-8?B?akV1SWNyVitrTzEzZ3pWRmlidzg3QkJtcHhPaE44anBVcjNzam9Wb1o3YTJa?=
 =?utf-8?B?YS9vNlgxOXZ3eWVqeDBSZkJFaUc0R2VhVmxaY3F5c29uUmNsQldYVkJvNWRO?=
 =?utf-8?B?VVVGM3lINldLd3hXd0VJRlhBazFKcGRNMTYxeTVJc3RzZ3JHa21XeStrSStL?=
 =?utf-8?B?dzBONnVVbzR3a3JLbkdmTkl2cmlYaEd3R0pCS21laHo0V21HblNJZldtcHVC?=
 =?utf-8?B?TkFkZjRDeGIwV29zQ2duLzNaSmFWRjd5Z3VrZk9WdUo1SXptOFE5WC9BSW5m?=
 =?utf-8?B?SGpTMktEZ1JGa0NKcmRFSmVHazZsd0Q4bTZ1YWlheHpFSUYvb2hVMXg4Z3hQ?=
 =?utf-8?B?YkVmaG9SeDM0eFgyWUxBK0dRVkw3MnlYQ216RG9kMkJ4OUtZUGdNQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 202588c5-db7c-4666-b7af-08dec6d957be
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:16:31.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UbkF84i40HQNZyjqKE4yeakoJZaCZHn+xwYCyU6AfqcHUqvdzZ9UUK2sSphrCfCGFv/ASDK4IXljuaWjotEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2013
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

On Tue Jun 9, 2026 at 9:04 AM BST, Alexandre Courbot wrote:
> The GSP static information is useful during regular driver runtime;
> however it is currently obtained from `Gsp::boot`, with no elegant way
> to pass it back to the caller.
>
> Solve this by moving the code acquiring it to a dedicated method of
> `Gsp` that can be called as soon as the `Gsp` is booted. This allows us
> to obtain and display the static information from the `Gpu` constructor,
> and to store the static information for later use.
>
> Its location at the end of `Gsp::boot` was a bit out-of-place anyway:
> technically, the GSP is considered booted after we have received the
> `GspInitDone` message, so anything that happens afterwards is not part
> of the boot sequence anymore.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs      | 16 ++++++++++++++++
>  drivers/gpu/nova-core/gsp.rs      | 15 +++++++++++----
>  drivers/gpu/nova-core/gsp/boot.rs |  7 -------
>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 6b3e02c71dee..a0cb36cdeeea 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -23,6 +23,7 @@
>      fb::SysmemFlush,
>      gsp::{
>          self,
> +        commands::GetGspStaticInfoReply,
>          Gsp, //
>      },
>      regs,
> @@ -290,6 +291,8 @@ pub(crate) struct Gpu<'gpu> {
>      /// GSP and its resources.
>      #[pin]
>      gsp_resources: GspResources<'gpu>,
> +    /// Static GPU information as provided by the GSP.
> +    gsp_static_info: GetGspStaticInfoReply,
>  }
> =20
>  #[pinned_drop]
> @@ -354,6 +357,19 @@ pub(crate) fn new(
>                  // is properly run in case of failure.
>                  unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_fal=
con, sec2_falcon)?,
>              }),
> +
> +            gsp_static_info: {
> +                let gsp =3D &gsp_resources.as_ref().get_ref().gsp;

What's this `as_ref().get_ref()` for? This could just be referenced as
`&gsp_resoruces.gsp`? Or am I missing something?

Best,
Gary

> +
> +                // Obtain and display basic GPU information.
> +                let info =3D gsp.get_static_info(bar)?;
> +                match info.gpu_name() {
> +                    Ok(name) =3D> dev_info!(pdev, "GPU name: {}\n", name=
),
> +                    Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {=
:?}\n", e),
> +                }
> +
> +                info
> +            }
>          })
>      }
>  }

