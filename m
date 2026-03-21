Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55121099B54
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 06:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24FBF10E2B7;
	Sat, 21 Mar 2026 06:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7g+kuKG";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B755110E2B7
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 06:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTbaGXC4Rkeguj9JXuArdgIImQizdZXJS36H5ZegAR4K6mQcRWzDP5ezrOw97y8ZdF8Dy0v9ik+z+xsn858Pi3fnyVtMlfH20OdUBExzp5JaKMpdAvNhxx76ZG/3h5fUaFIU5uVxoXdqtyV76c3uXC4ySNYktmAbc0ZuRcTNNORdVHiTsxFyPiUAJVwDrwuFOIVPmLLrIuWOvges/pIB80YC0DN92qh3FifOpeTxEAtpXzZ3sJX0vkEvhuemOveFmyw0jaIIlrq8B4K+pd8qYa8hM5Ld8mGbvTzWa2jIRIZ7U6m4a14qda3kf8wPgzpJicjKOj776QI3mgC6QKig0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql4jcGXiewsWaNLVelALQEiivp7DAiziEe5getBGueI=;
 b=al3fMYItAiTND1OFdenYCWrROPpMggOyKUecTHqCRhOYwdHEDex0s3k3fvEfqMJwnxP8946SPibsol/b7VZpJJ6OnIfav+dbfF1BQGvD36OdmLmD6OjD67m+aiKzGVl2ItS7jzKARfO888ymjZr39R6vdAehyjGXMfSrm6RYIWjvsVxBeDwjuhCiSYwZfdNhTL2vEwH2nAcD1ShIg1ODy3aUDFItJYpzwmLr/wT/mk5awE9k+/HBEb25fwA5v0iqOGMnJvdk3wV3g8glqeWfbb4Mnsb8tuFQ1v1sR6fgTvMLUuL7B6aV8Jk9BUtfRES6El4t3GfrBWanBmhHEzqMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql4jcGXiewsWaNLVelALQEiivp7DAiziEe5getBGueI=;
 b=W7g+kuKGItPDilOSu6f0FkIOTcViL39ziDtve07DSd8BO6TlFWAc6Y927U/dCxNkcpgGD0NvtDLb00Rk/bDneuasDj6kzw/fTONPijA0sW59WKB7SVJFGVv9bSNIGIblFUQYhEbx8bDyRhaPPJYK5nel1bzH/yQTNd7wAdDXfpMCoEOjajWIfdiqZWmkylTPpGpufPV02U4CPPg+tGLe8aDpQkAJLjBsAMyF4HEVTlO/slT23AwjAPx3JHKmzEwFnNV7vQhf9qwFIS9xe2rAMzZs7YAlj++lu038usKIy9Akx439bM4gkYG6t2+4eWm6fe29W+SowIofOCkI/0yC0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Sat, 21 Mar
 2026 06:19:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Sat, 21 Mar 2026
 06:19:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 15:19:24 +0900
Message-Id: <DH88QFZ9LDXT.3R0BJNSYSY823@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 06/10] gpu: nova-core: convert PDISP registers to
 kernel register macro
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
 <20260320-b4-nova-register-v2-6-88fcf103e8d4@nvidia.com>
 <0231b5bc-03f0-4207-b0c4-fb6daf19d135@nvidia.com>
In-Reply-To: <0231b5bc-03f0-4207-b0c4-fb6daf19d135@nvidia.com>
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c970985-7c29-49b3-49b0-08de8711ce1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KkIq0KWuv9mJLymKv2lardUpyPIIVpAhMqpZt5fnBT0EGwVHAE7D/k57o5CL/HGTT/taKUbEu8ejReejYHkVS6+KW+WLU+r8hV7+rrKqYhiIKx0QcfOh5V8cTjT078jrTzhxsQpZG6xDCs2cEF/rjc1P7Ft050PIj5OqfAAJQGfxf1HUlzjhPdeemF5CyV8uBuMzxP6attM5oSvjEqSdlIHtw/AMwPqvCL+2ZmCt/UKqdVdzrM4vNqlFvStnvRmg8b4MJ/4cAVwEyKAVdqHEK6HEs43OFMDnp3aXK9/OO2uvi0Pcoj3/w2OmCWgWsk4WwNrUC1yXjbMEEkpTSbybtvthF6+m8p9XT+JlOIdR1sHcambn4LgET938eQ6w+Cw8dE5ABmg43mv2RPPdI0lx46VRIIweW5qNq77qkyKE39+y74sJNcyizgYaKgtRR4IktjTIS2tzD+ukSqtraki3bO+9k1URRDT4RKrG1T2o2qMgg7Mm62g5cPUKOFkEM+xvW7dE/TC3Gz+4AfYlldRd5R7QD2aFwI32U5Lgbzdzvec1peOaLPxHQ4VA0eSNI/coauTh6Wq4e5ZWEjN3xQ6t6lAAJmHrbzj/cvEnha6TARlHoX4j3K+UR7DV/wxspRddxVTRSQ5blaHgLacvrfwl9dI7hAIBAB+fnPcGb/Xp6EzptJZ50WznBptRH8ah/0xU5LRM5ABfwBNXRW7GdYZQ55n9caVy01pJ5pNdLMkz0Xk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NURtQ2h5YWM1V1hEbGlNOFkrdFI4bGhVYldXTEk1eDVYQVV4LzlvekowVHpr?=
 =?utf-8?B?Zkx5Q0tFUFdEZk9waEtsOStBZllhUlFFYmVYY05kWHNhdEg1SzdRVjVibDhw?=
 =?utf-8?B?a29wOElvdC9GMGZYVXV6Qy9PS0d2RFFwaHYzTUc0MzNoYWlqOWdSUGF3Qjlv?=
 =?utf-8?B?R3h2eHZvbWhrT0tMUVBGTnNnQVRvOG5UZnFxSkZIM0wzQ3RxaTVrYU90eGw0?=
 =?utf-8?B?NjU2UjRJZEptNUUxSXVoM3VTUk51WWI1cnVza3YxcXUwMzJqQXRiSFpIYnln?=
 =?utf-8?B?L1hjRFR1ZU1ZNE9CTUJzVGRkU0d2L3NrSlJiTHB4Z0RqR2p3TjZHQ3RPN2hH?=
 =?utf-8?B?QVhnSVBWWDZOMUpUcC9RNFNPNzM4OEdYOFVPciszRGtmcExTQ3I1UndIb01p?=
 =?utf-8?B?dzRJdTdnV3hrMlcvN0IySUNxaVBHMXRpRU9YZ0V1OWd5WnByRWR2Z2RPaWly?=
 =?utf-8?B?MmN0M3JpNzd2VHBLUmpIWjJRWFB0SWNKUURybG1TZm1TWHNOd0YrQUJtVkM5?=
 =?utf-8?B?aDFxTXJ3ZVpEZVgwSWdvVFlFdW5wcUxqYnk4MXJWYzV1bGdFTGcreHFsSkdm?=
 =?utf-8?B?RlVZWjVROFNPdzFBR1NWV3BEZTFmY2RJbGpRWElhOTBnWDl6bWNiMWFoU1dx?=
 =?utf-8?B?SXFuWTIwL0tJcCtDNjI0cTdzUkpLMUI0Ri9DeEY4K0ZJV1Noc0daYWFYV2tq?=
 =?utf-8?B?Y0crcmVoT0hza0Zuajh4cjZ2QzRBcTlFc21yVWRVZjYrMjlSd0VyeWt0UWxt?=
 =?utf-8?B?QmVkUElWanJFS1M5ME02VVNzcTJhaTg2ZEFZcWU0UkxvQkUzdTcvTFY5SDI3?=
 =?utf-8?B?RUxZcEF6UElRWnRVcWlhQnJyY21NRWMrZnlYQ0NYajNqREhDSk01YWVpNmR4?=
 =?utf-8?B?VWxPeDg3OW9BaVZKemdHcUptVlZwTnIrNTBPeXRSZnJvQmRyZ0QxSzVKSTRJ?=
 =?utf-8?B?VHJxdERCR1I4RkI4RTg0T2x2Ukl4WjFqYnY2WjR1SXMrT3ZlWGNtaEs5aHR6?=
 =?utf-8?B?KzUrRUROR09nZE9sb1RINHAvZXVIQVBadkwzMXZoSElFbEpNWm9MbXBWK21L?=
 =?utf-8?B?YTJmYnpkemVkS0NNQXYrVzI3U2o4ZExJQ2Joc0FZWjR0ektxZ1RidDBkN3o3?=
 =?utf-8?B?WitsOTdYaEhEYnYwNys3TEx0T2lZWWU3aGdRdkhwcmlFc1dkKzlNMFlabDRN?=
 =?utf-8?B?cEwzd1V3bys2dzNRNzB3aW1yaHB2d0pjTHhZZ0cwNkxINzVmbmpLZHMwcUpH?=
 =?utf-8?B?NEtZWnR2aVd3aUhSYmhJM3lvLzZ3V29LRDVUa0lhdVBSYld2d0czU3BsN2h1?=
 =?utf-8?B?SitkdHQwaDBEVG9nTi9XNXNiL0dFUzFmL0czWUFLdHJYV3V4QVNuNWpDUDhJ?=
 =?utf-8?B?OEF5bEFVQ2pPMy83NDNCaVg5Zm8vRkhKNE1CazBzMTNhZnhOaHpjaytDL1dY?=
 =?utf-8?B?Yi9DK1NJb2huTGREZThXTVIreTZaMXlteisrSndBRGNiYnlJU0tBU0lYSDJ5?=
 =?utf-8?B?TzNDcW5PUGovSkRvSzFLa3lqbS9HcWh2aWFlRFptVUN2WFdoRG5WK1kzano4?=
 =?utf-8?B?VHJQMnBNUmlDNXA3VW9aUHVFdkRKYWFTek8xY3hPalljYklhTys4VzV6R2Vq?=
 =?utf-8?B?Z3NWOFFKc1JUT0xYYkhxOEYvVjdwK2Z6Y213WG5jdTJvMkVMVGNhMHlEeGNI?=
 =?utf-8?B?dW0rdzNVSU1od0ZLL016cFBxZGRPSHd2R3VZUmxMcHcxT0hrbjFYVlRwNGo1?=
 =?utf-8?B?azN0dEZaOEp2cEh1SEI1UlFjQko4c1gzT0ZHOVUxYTM4ZmlxcS93NnhpcTF1?=
 =?utf-8?B?MlBUOUN2QlhWcUFsMWhQUGRzczYrdnZpSkN1Zk5OM0p2dGlEQS9TOUsyNHV2?=
 =?utf-8?B?RGZGaS9BdG5XSWhOVWw2YURaTWJmODA1RTRQTTcrRlhabTM4T2wzTC9hNkFN?=
 =?utf-8?B?VG80YlhCUmdHV0tTZnpyNDhKSzlmMHZxYVNkMklCTzJEcnZJQ20zYzB2QTAx?=
 =?utf-8?B?K3BCK0o2eHR5MnRmZVF4UTNLKzR4dlBSZmk1czFjRllaSFpTSEVRSkVWZDRC?=
 =?utf-8?B?UklFb1N0V0tuM3o4QjY5Z0Fvc01XWHRERjdPWkFqS1phb3FQK2t6VEdxalZj?=
 =?utf-8?B?NFNnZ2F1VFBtV2M0UFNCNTJSNEgxYkQyMDV0Z2dWakRlQi9vUDgyNnlERkRV?=
 =?utf-8?B?SWJGME51NjdJNzc3T1R5YjhzeS9YRFNaRUJ4M0FKbkl1SGNBaGFCSDl1TTU4?=
 =?utf-8?B?bTJoQnVISlVtSVRHTHZqZGdocmw5SEUrb015WEhDSmRNUFBmWmMrbVNTdFll?=
 =?utf-8?B?UUx1RGlKS2NjZE54VWNpUUhvTzMzd2NUMWthMGdTQXJ1UkVmU2lsSWNBcEJu?=
 =?utf-8?Q?89sh2jBR+QVMJGaw+DBjYD9AubUitLremllF/H4rPeoyH?=
X-MS-Exchange-AntiSpam-MessageData-1: NH/W6hiMJzYyzg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c970985-7c29-49b3-49b0-08de8711ce1a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 06:19:28.1321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab3BYik470bPjhOa8z/o+TKqz37iPSN+Ztbj46x73Ju+wHPwrjoMzmuOtZv7hqONVQWWqUi8Hu6pn1Vws4zUXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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

On Sat Mar 21, 2026 at 2:33 AM JST, Joel Fernandes wrote:
>
>
> On 3/20/2026 8:19 AM, Alexandre Courbot wrote:
>> Convert all PDISP registers to use the kernel's register macro and
>> update the code accordingly.
>>=20
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/fb.rs   |  6 +++++-
>>  drivers/gpu/nova-core/regs.rs | 12 ++++++++----
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
>> index 6536d0035cb1..62fc90fa6a84 100644
>> --- a/drivers/gpu/nova-core/fb.rs
>> +++ b/drivers/gpu/nova-core/fb.rs
>> @@ -8,6 +8,7 @@
>>  use kernel::{
>>      device,
>>      fmt,
>> +    io::Io,
>>      prelude::*,
>>      ptr::{
>>          Alignable,
>> @@ -189,7 +190,10 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp=
_fw: &GspFirmware) -> Result<
>>                  let base =3D fb.end - NV_PRAMIN_SIZE;
>> =20
>>                  if hal.supports_display(bar) {
>> -                    match regs::NV_PDISP_VGA_WORKSPACE_BASE::read(bar).=
vga_workspace_addr() {
>> +                    match bar
>> +                        .read(regs::NV_PDISP_VGA_WORKSPACE_BASE)
>> +                        .vga_workspace_addr()
>> +                    {
>>                          Some(addr) =3D> {
>>                              if addr < base {
>>                                  const VBIOS_WORKSPACE_SIZE: u64 =3D usi=
ze_as_u64(SZ_128K);
>> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.=
rs
>> index 61a8dba22d88..b051d5568cd8 100644
>> --- a/drivers/gpu/nova-core/regs.rs
>> +++ b/drivers/gpu/nova-core/regs.rs
>> @@ -250,10 +250,14 @@ pub(crate) fn usable_fb_size(self) -> u64 {
>> =20
>>  // PDISP
>> =20
>> -register!(NV_PDISP_VGA_WORKSPACE_BASE @ 0x00625f04 {
>> -    3:3     status_valid as bool, "Set if the `addr` field is valid";
>> -    31:8    addr as u32, "VGA workspace base address divided by 0x10000=
";
>> -});
>> +io::register! {
>> +    pub(crate) NV_PDISP_VGA_WORKSPACE_BASE(u32) @ 0x00625f04 {
>> +        /// VGA workspace base address divided by 0x10000.
>> +        31:8    addr;
>> +        /// Set if the `addr` field is valid.
>> +        3:3     status_valid =3D> bool;
>> +    }
>> +}
>
> Shouldn't this re-ordering of bit ranges be a separate patch? Also, what =
did we
> conclude on the ordering issue? I remember this was discussed, but I am n=
ot sure
> what the conclusion was.

The conclusion was descending order for both bitfields and the bits
themselves. This is part of the contract for using the `register!`
macro, so I don't think it is out of place in this series (and
re-shuffling things again won't make this diff smaller or more readable,
so I don't think there is a benefit).
