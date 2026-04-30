Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42F2CD13DA
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B02A10E226;
	Thu, 30 Apr 2026 15:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="xSxd6B0F";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022103.outbound.protection.outlook.com [52.101.96.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1253A10E1EA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 15:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGWEB1erUwi7SqdUBBHkhnJdcx1PbKz8gSwzm5SpziVHaJNKM7X0pEQfeHygcKb21BUAhgn1YhST4bcRKOdSq/A20vdAwizzqvMrJ4flctw66imZ6P1bKZsfgjfrHdjYbkGYsre1PMV03HFZAKHKEYawavt6hXZA4DHdEtahdRf1zPvpDNR+m2dwvmencg6yV2u9zK3pft8szJE8oMJH+fepXLYDjQpG0p1+0QlBcAfPxSrfrvEa6IM5a8GOwO2TbHauM9/NILzp7KdctHMgPBcSkL8VEvVz4mkBavpTnSVfZ8LgdQI8vR2RymCjmPz0Czjvt6FbXh5Bvr0SktGxMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu831AOXsEVKA1DPdpxZ3HWDqiRTzKDxwKmhYNM9nZc=;
 b=Q6h4s04uy4mjdhoqdMD/fP59WpV2ViAsgYc1VS19iEVzC2AbbpgOzDJfTJvqeTKIU3kiF7uQCvH+sIE9HUr+XsyAhQH+BliD4KUXRs2oN1U2Drjz3gFq6cLH/YBwTqe7MJKnLTxjSqE0N2gEjGabgFM5e04DfBg9xtGFx47KuN9BZAqjymYqMpAv+Sllx0dFhmFGhbNMsWrDGmcpAOJsZb/HRTgSUzx/ff83X7AZ6Rxo0n49fEtsJKeUUttFIJpswCUGqsyZQcY8SfpEmmuw84JmqRDQvEQzwmZl7Kuru3rA4d1hfdGp/iyKzKGMfORSLJp+nmjnrAN5xEEi6NuVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu831AOXsEVKA1DPdpxZ3HWDqiRTzKDxwKmhYNM9nZc=;
 b=xSxd6B0FDUoG+gqhC48Cy1B4iusauqFJ//wifDEmjGnhRgfTDtg7T/dYYfP7c8CvGMrrDXccQ0uOJrjbqmzGgfa/TXEVcgWd6YTh9atMvSfMYvEkE+LI2rubuFCNTcF7sBS82cMgLF5oqPwfqEgx+ptYxpmnyYepsL/Ln+WWaEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6529.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 15:08:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 15:08:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 16:08:10 +0100
Message-Id: <DI6L13A5LMOW.DU7ZTHXZYB0K@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
In-Reply-To: <20260427221002.2143861-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc66634-954a-429c-e0bc-08dea6ca4b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|1800799024|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AQ/tmHz0/UiwvE4wGcq0SGYHRgKqFY80lO4pr/2YR/6NuJjyybx0x3Wk76k7YarouH5HrV1K9BT0mWjiDjHz1Fr27wwdNbH/DPfxLEVAGdcPlrAjxEf8/qvnKoR9LCFkPc7xLzmJtP31elBCkhMZNt74wKGl+V6dvfyulntxqHflTqi669RtlaSvlnE/BkXBavckvNwargCQDmAZFSgL/KHOsgXlLSVBBdCMoiHKbT03pznm1MlRRJAvIUn1K35QZ8slXwm6Ri6UV6lGvAXu2PNh5ayQpzazd2BLVNPwkJJZS62OwXa7bgGhPV+MzeTMhZ6MlHVj6pqeRrHagKmnljCzwTdhTxJ40294DriDCio7jwzxWuLzShCjkKZJkXTC4w5G3zAtwsD3lBxclc4jU9AdrqEuEL0blFWE0XYCa6UExiNPnC9PvCjEtbH0P0Zh+ZTztqXmcEXh2wnbfcyV0LJadt1xqVClhPmkm8HUnYLa28zeLnA1s2DKl+dSWcdXUfyY0dWYbXs/LPt4gSa7jSXa6yLIKgeVuGz37W6THrmQNYonMvBRE5w745GjMNiB9uSZ/41sQW2l8cA9vEgbGt+mlon2UCWlojKhFG9cy5OfWfH3yGXouxGN9f6XKvpYnphiaOpC3qg6t5TufLfED1xySp5tpXNxnh4hBmae0mhcGoXfPJgEaWWs4pCnPOvO6M8w4STQpYnfSlBs1S6+3MydHwnKkkeXKzqUQxVMhPHJLkppiIJs3g1nidZm9aCd/8DRBd7Dqz3H1GSeR/1mbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZwUXJTcVEvWkdGekxLMjZTVFBVZDcwM0EweEtTTHdOR2NBeDJoMit4SFZD?=
 =?utf-8?B?ekYvQkNVanNIZS9hbG00Ync1YVErdHF3OS8yY1ZzQWs0dVNIN2s2QkFBUkVh?=
 =?utf-8?B?TUJTV0FKTmFKRE9wb2ZqWlhlb2thWEZGbU5CaTlIRk8yYU9qaGxMYmIyODB5?=
 =?utf-8?B?eHFrQllwemdJZWJ6SzNBUFRVWmp2aVR4ZTZ2V3BqU041UGpNOHliTm1YRVpF?=
 =?utf-8?B?cnl5aGFWeENIemZPZVNjdzZ1cFk4UGxucUI4SWw3cHZraXlqazNOVU13cEhD?=
 =?utf-8?B?dlkyTjZNTkZBWWw0dERpcDJCamI4S1dFeTByTy90Zm5ReCtlYXRPOHUzSnY1?=
 =?utf-8?B?aEVJZ0JNdFVBYys1Vm4rVUE4RDhUelR6MmVYRjB6SGFRMVZNZmdvV2NaQXR2?=
 =?utf-8?B?eGwzcmp3ZDlDTWwvdDdtYWsxeE9OU2lBV2p3S2N5ckdzZVk2c3NoUTBGU0t2?=
 =?utf-8?B?VjJCRmt1anZXdVgxc3RrNlI2ZlNNT2o0MGU1UDhmV0Q0dFRGL1BSYlpMU3Js?=
 =?utf-8?B?UVBPUkprQzYwTStuaVlxSVhSRnhHVjhIL2thS3lEakJoeVNGTzcrc25FTEow?=
 =?utf-8?B?YUtsY3JyNnh2SkdnZVI2amlwaG5LOGFLdk9HekVkTkZmN0J6WnBMMi9GUGph?=
 =?utf-8?B?bzhlRTk4RDFIejhSSGo3UHFuaG9DQWoyanI2aGVGaEswZTlvUkFETGRRY0Ro?=
 =?utf-8?B?aGlxS2N6SXFqOU1GQjRvYnEyQlJNazlHOFpCT0kzdndkVE91S1IvT1QzUnJ0?=
 =?utf-8?B?d01EWWhoMzJvTEJURzVLcFlrQmROMzVQcWdyVUhUdmU2L09XUmp5SVVrUDlX?=
 =?utf-8?B?R1IrWFJKY2M3c2N0eXIraFdMUGZKR2JLeGVzd25jV05VVDQwVy8rcy9uSmV4?=
 =?utf-8?B?ZG8ycWc4Z3V0WS9EcVEycGVlK0tGdjJsaW0xcWMrWWdkTTZXb0lDdzNLSXFZ?=
 =?utf-8?B?cDllMXdncUNTNng3NmZsOFMwRVMxOW5CUys0UmlqL2k0Qm42MGIvNk9BWmY4?=
 =?utf-8?B?c1ppMGp1MkRPTFNXK25SZHVpelZlb3lUY0QrTC9uY3J6bithNDE3MElQK2RG?=
 =?utf-8?B?ck10Ui9aNHpUTUdMVm9ZZEhNSUNQQ25qM2R0Qi9PdzZaUjJBbXhRRlE5T0Vr?=
 =?utf-8?B?cjcwdWNqSjBkZGNsNzI1cVlRTnhrSWhjUUJyRVE0QkJqSlBXbFkwVHdHRm5X?=
 =?utf-8?B?cVZpazBKMVNMZHQyeXVQSEZVOWp3WTBRVWozSDV6ZjZvd2VSNXJkVTlHenZF?=
 =?utf-8?B?MTJQUmp4ZDdVTEhXOTVZeFUzT3dRNDlCTzZpWnhCT1YzMWp4OSsvcWZEZzlD?=
 =?utf-8?B?eHhHbFpTY253K0FWeVlqd2lVUE9BdFVEWm81UjlDMWhuUi9RbDJkTUdUSkdW?=
 =?utf-8?B?QUtxZ0VtUmRIZzVVM1ZrL09FdkZwMjdaV3FjVE45VmhGd1MxMXJUVnFGeHVi?=
 =?utf-8?B?ZUdVVDg3eWFvWTNnYVllckFuN2RTMzhDK2dEUWREN3VBOUQrU2xOTkNmRTkx?=
 =?utf-8?B?RHltd29DY2Mzd0toVEtoTGF5aGkwNllqczVudjVHRy9aazBpMnZzR0xHZ0tW?=
 =?utf-8?B?cnJYdkRDZm1lalN1cDBLdjJlejZid3J5cGxSSmZoMW84Z3MwVjNvQ2FSMGZt?=
 =?utf-8?B?SThpc01RVU9yZ2ZNcnZ5YnlndG5JMUNBUUhaMCthWi8zVU8rT0gvYUtBSVlK?=
 =?utf-8?B?bUd6VGsvcVgvc3dyenJGU0tObWhZdFJ3aFNYaXZtVE9tZklMVkQvcmp1L2Ra?=
 =?utf-8?B?ZUJhaTl1bVY1TUtJaFJPZU02QzRvbFg3TWwwYmZVTVJwaUtEQkk1ZUVzZW9R?=
 =?utf-8?B?S3BiRmd1RXEyc2Y1Vml2QmowRjU3M0pJTi8xc1pudEl0MnhCQkJUdUo0OFR4?=
 =?utf-8?B?UDR1SFdseGpIVzNXUmFkRnVCVjFhSzYwbmg1RmxHRWVSWTZKbGVhUWlETGsy?=
 =?utf-8?B?WkhjR3NtOVBiaGZYRzRlS2c3Z1ZrUFpBVk1YdnRoSWNqK3JkeGd3QkFlcStW?=
 =?utf-8?B?c2dSV0JXeTNUbGJ2SXJTN3AzcllGVWI4dlI0K1NhYUcvTmhuTWJyakRmdHVQ?=
 =?utf-8?B?RjlWenVvTG5TVWZybDF3U2tMNloxaFFJaDUzNE9SQ3RRWWdaL3BOQ3NLbEdp?=
 =?utf-8?B?czFVRTJMM0NsVHduUnF3M0k5dUVTbEZmbklaanB0TnZYekI4Q1F6aGpxamJC?=
 =?utf-8?B?Z2J4SVdTUlBLOFhpYjgycnVGdzMxYTZIL25IK1dCSG5FUHA0YkhUNEVaRGVV?=
 =?utf-8?B?VWZURFBvYlY5cWQ3d21aRlgxZ3FhRXBWUHMzR0lNSitXUXVUenRDbU9MNXU3?=
 =?utf-8?B?allpUWw5b0NxV0EyZ243UkY1KzlRV1RHckk4N2g5WFdjMHl4MzRrZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc66634-954a-429c-e0bc-08dea6ca4b3f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 15:08:11.0225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+KdilO+biA6BD+GXI6cC+bk1AK8L3q8V6wvnL5zVXxpwY5PLvZ7898XvtCQ5zpsb/kbXjPlxZEcZLTDB+9Dlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6529
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

On Mon Apr 27, 2026 at 11:09 PM BST, Danilo Krummrich wrote:
> Add a registration_data pointer to struct auxiliary_device, allowing the
> registering (parent) driver to attach private data to the device at
> registration time and retrieve it later when called back by the
> auxiliary (child) driver.
>
> By tying the data to the device's registration, Rust drivers can bind
> the lifetime of device resources to it, since the auxiliary bus
> guarantees that the parent driver remains bound while the auxiliary
> device is bound.
>
> On the Rust side, Registration<T> takes ownership of the data via
> ForeignOwnable. A TypeId is stored alongside the data for runtime type
> checking, making Device::registration_data<T>() a safe method.

I wonder if we could require auxillary drivers to specify a type, and then =
the
abstraction would check if the type matches; if it matches, it create a
`&Device<Core, T>` and `probe`, otherwise it skips over the driver complete=
ly.

This gets rid of the failure path.

>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  10 +-
>  include/linux/auxiliary_bus.h         |   4 +
>  rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
>  samples/rust/rust_driver_auxiliary.rs |  40 +++--
>  4 files changed, 180 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 84b0e1703150..8fe484d357f6 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -32,8 +32,7 @@
>  pub(crate) struct NovaCore {
>      #[pin]
>      pub(crate) gpu: Gpu,
> -    #[pin]
> -    _reg: Devres<auxiliary::Registration>,
> +    _reg: Devres<auxiliary::Registration<()>>,
>  }
> =20
>  const BAR0_SIZE: usize =3D SZ_16M;
> @@ -96,14 +95,15 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdIn=
fo) -> impl PinInit<Self, E
> =20
>              Ok(try_pin_init!(Self {
>                  gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_re=
f())?),
> -                _reg <- auxiliary::Registration::new(
> +                _reg: auxiliary::Registration::new(
>                      pdev.as_ref(),
>                      c"nova-drm",
>                      // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID allocation/recycling. For
>                      // now, use a simple atomic counter that never recyc=
les IDs.
>                      AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                    crate::MODULE_NAME
> -                ),
> +                    crate::MODULE_NAME,
> +                    (),
> +                )?,
>              }))
>          })
>      }
> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.=
h
> index bc09b55e3682..4e1ad8ccbcdd 100644
> --- a/include/linux/auxiliary_bus.h
> +++ b/include/linux/auxiliary_bus.h
> @@ -62,6 +62,9 @@
>   * @sysfs.irqs: irqs xarray contains irq indices which are used by the d=
evice,
>   * @sysfs.lock: Synchronize irq sysfs creation,
>   * @sysfs.irq_dir_exists: whether "irqs" directory exists,
> + * @registration_data_rust: private data owned by the registering (paren=
t)
> + *                          driver; valid for as long as the device is
> + *                          registered with the driver core,
>   *
>   * An auxiliary_device represents a part of its parent device's function=
ality.
>   * It is given a name that, combined with the registering drivers
> @@ -148,6 +151,7 @@ struct auxiliary_device {
>  		struct mutex lock; /* Synchronize irq sysfs creation */
>  		bool irq_dir_exists;
>  	} sysfs;
> +	void *registration_data_rust;
>  };
> =20
>  /**
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 93c0db1f6655..467befea8e44 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -19,12 +19,17 @@
>          to_result, //
>      },
>      prelude::*,
> -    types::Opaque,
> +    types::{
> +        ForeignOwnable,
> +        Opaque, //
> +    },
>      ThisModule, //
>  };
>  use core::{
> +    any::TypeId,
>      marker::PhantomData,
>      mem::offset_of,
> +    pin::Pin,
>      ptr::{
>          addr_of_mut,
>          NonNull, //
> @@ -257,6 +262,40 @@ pub fn parent(&self) -> &device::Device<device::Boun=
d> {
>          // SAFETY: A bound auxiliary device always has a bound parent de=
vice.
>          unsafe { parent.as_bound() }
>      }
> +
> +    /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
> +    ///
> +    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// [`Registration::new()`].
> +    ///
> +    /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
> +    /// registered by a C driver.
> +    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {

Any reason that this is not just `Result<&T>`?

> +        // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
> +        let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
> +        if ptr.is_null() {

I think we could treat C-registered aux devices as if their data is `()`.

So you could do

    if TypeId::of::<T>() !=3D TypeId::of::<()> {
        return Err(EINVAL);
    }
    return Ok(Pin::static_ref(&()));

here.

Best,
Gary

> +            dev_warn!(
> +                self.as_ref(),
> +                "No registration data set; parent is not a Rust driver.\=
n"
> +            );
> +            return Err(ENOENT);
> +        }
> +
> +        // SAFETY: `ptr` is non-null and was set via `into_foreign()` in=
 `Registration::new()`;
> +        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0=
, so reading a `TypeId`
> +        // at the start of the allocation is valid regardless of `T`.
> +        let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
> +        if type_id !=3D TypeId::of::<T>() {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: The `TypeId` check above confirms that the stored typ=
e is `T`; `ptr` remains
> +        // valid until `Registration::drop()` calls `from_foreign()`.
> +        let wrapper =3D unsafe { Pin::<KBox<RegistrationData<T>>>::borro=
w(ptr) };
> +
> +        // SAFETY: `data` is a structurally pinned field of `Registratio=
nData`.
> +        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
> +    }
>  }
> =20

