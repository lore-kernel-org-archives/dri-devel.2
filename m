Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7643FCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 11:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA13D10E0B0;
	Wed,  3 Jun 2026 11:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="okj+j4eM";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020131.outbound.protection.outlook.com [52.101.196.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C685D10E0B0
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 11:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwwIFGeOGzfuOZKHkVy5qBWXxeBLsT9S7Ny9aS5RxggoI9CGk9LwsNAOxrarEc+yDzrfUvgDnfI6/bUHucMd3dVwBraiiP/RvuPTLM4+DNsKledXLOC/NCiMnxWCE1ofgylJ6MLZHwMMHT56QRhv5NFBlqX6r6OR/x1a3EaYu13PAderxwJn3FFGxsbYVFlOHZZ3OWQwvaQubf5Yh0UAl89AG/gsYqdb8BlU68rOgugSc+yjua8HLo5Vw9XVTzFbJRGBHfFU2iJ0XCxtvUTIfw8xLYy/AOSfQXnWO4zIirNXr5pdccVwUXWG29/Q1p1pZPiqxIozm9nkCAsBXu+jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZHCBzR2Fsg7W3Iwmi0mO9srUONCWib1DDUX4XXplyI=;
 b=Cy4hnlaok9v6M9Y10cTPqFnGlcoNnY3+emv+Z46x2Od8uUSrmsl9G0mz9YpBePszksjw9VpLRNUJOYq1fNKp1nfhhLztMfVwnGHsE2UY4dGFOq6d5dpWPJOgcqH4W5Ewa7sN072W8vig2SgoTDIpFL6Wyf2qWI8Jh6qj4KMGQjwylAfal1kRgoo3uabN3rZ1bKtOXsHH5PxDmSObNy927DkpgOjuzKmbkTcd2ZG+0B3gsqY7i+RctlU10VbLVdsZtCO0iycjgBj2ZgSDfhqrdOF5nBapn5YRPrkWFHuE87ClyE/YxxqRtEWU8FcREOJE/8yzLWQlrQU0NC3uP14Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZHCBzR2Fsg7W3Iwmi0mO9srUONCWib1DDUX4XXplyI=;
 b=okj+j4eMKaXjqqvOPUrnx/yr9qkU6QNwBHLzwq3Ll3+/+0cawg5dapAxONGUfjJjk5MmrkkTUK1tZxdV9FOwL8mv3EP06HiYYMeY6r92KeeO79twxzyymmadhvU1IfeF4vcGHk/ozK94uFjzPwyhyPp8WvxIpHHMb/uyC3kvTx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8832.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:51:38 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:51:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 12:51:37 +0100
Message-Id: <DIZE54GCJ9MS.DW75EP5OM604@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <ecourtney@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org>
In-Reply-To: <20260603011711.2077361-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 304450a7-71e8-44ce-d440-08dec1667813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|921020|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jzEgs25qjBkfq3iNLtOzOx53QBYJRyPluGN4ISNkTls45pW08Pm47c0OUqXU7cfx9ATjTctc+TWwxwK/74RWbbxFjgD9ugp8LULG9Lb19VLeSfCRW2021atRIVS0sODrKHU9hMMY42NTaqnLfmfAI3LAH4TgGc3IyTGScpnOxuk6sWVYeaiGr1OqXAoiawEZ4J9OtK/zaB70ByiNIYH+hz5ebjEYv+x0b3sRSgj9PpZD3J+j1KQ7tAwuMYRlNBKVypKg2zEuz80oMD++Vf4uA7J/pFh4jQxTeMLbB5uMF0uTxJrnZ77YpUpjBgp0jjRvniZgSZfyzqL7SfOYNgtHkngaWUT5SUPi38ugtm2py/3eo0duRJ1qJ7HA4eYWUyaqDjEaGuJ1FH+BzFBr2DtqWrZgUdauSxVRVaaCQfDlZC6hEhZnhzkQEzAkhFqI+xGF2LCywLY0Ike/8seBflM768QLsl2gXNwStF1f6YDw4puLSQW0ogH9nOGFVK/+ac2zt8QLHYhTq6vLWueS81DFSrsyeu2ddzRrSFpKxZh/RJFvi+0muRUoh4Vy2PjQgl4Y4hpgIXWOyuIbHTFAhiucxWD+ZwEF0oV4iT4jqEhHP6z8Zumnh9Y76QOrWpjhtXI81TDWYmChgzap44qevRLs4At1NiTI0hZdBy9ru3ke/ummDaOIeByiVeFr0GnxT+fLWhin0ke720h+h3DDloF1E5yb9WwUT8J2tWhgWFilc0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(921020)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFhBQksyb0Znb3FxTTQvcmxLUCtycnpPeXYxMmlCZ3Vlb1ZvdmxmeXBhTHFt?=
 =?utf-8?B?VW4vN210TXVmNjlWc1AvQkJXV1c1NHk4Tlk1U2ttLzBrenhoM0xXMXVhNGo4?=
 =?utf-8?B?R0QySHJKTUFJQy9KVjU4eWpoWm1GVGVxRlVic1ZLM2FsUEExM0wwa3N3TVNT?=
 =?utf-8?B?S3dnODRFZVR1Y2kzN3NweXBvNmlhQWltZVRxaWhWWFBSKzFJeEluVnMrWDBX?=
 =?utf-8?B?RVp5WXpFZ2h1YWZ2dVNxNzl4ZXZiUFp2Q3lvS2pqMkl5ME9hYlNuaENpVWpr?=
 =?utf-8?B?N25Ld0RQQm8wazFDTVN3TVJUdTRQbHZIeitLSjFMeE1rZmFhY29pWHFuRmRG?=
 =?utf-8?B?Y0pZZHRYQXlKVG5NU2NEWlE1Q051eUoraVpFZC8vcTNmY1lBYjM0YzU2KzdS?=
 =?utf-8?B?UlRjUkRQYUFoKzFRR0xYcGVobGRkbGRKMkpsNS9GNGVVNVJWdDZNYjc2OVpE?=
 =?utf-8?B?Yy9BcStrWWVWVm5CZHN0SnZOeGp0WlRGM0FRaElENmI4TEthcWxPTEZwamZZ?=
 =?utf-8?B?SG9oc252VC91QTlEMXM5S1hHbHZPMWFxS2ZYRHIwMFk4N29lVyszUG43S3ph?=
 =?utf-8?B?MjI0TVl6a1NjcFByd3AwWFlBaDNhN2VnMFpHRU5UV1hZNEQreGRmZnVNeEEr?=
 =?utf-8?B?VzY4WFRuc1BwYkcxQTBVWjNBNUVLdHJTR3hRSzlnYXNPbXdSNnNPYUNSWDNq?=
 =?utf-8?B?ekxEdXJVbmhpUFRGZXNxditIdjVvRjV6WFIyelUxRlUrNFpDb2RkL3Q2Y1lK?=
 =?utf-8?B?UmdIZFEwZlVXaEZJVUZ5TXNkRTQrdXdPZDM3ZGZzQUN4U2VWZjJxQXFXWXRD?=
 =?utf-8?B?OEgvL1VEMFp4ZFRlbzBKOUFwUkNkamV4Q0xUQkZwVk5zTWFBeXZKSHp5d3FB?=
 =?utf-8?B?U0llNTQ1WFp6K1ZlK21EbTY1WGxoeVRxZStkNVdEZ25jdDJOY3dlMUNodWZt?=
 =?utf-8?B?ZmxvbUVvRjc3a29uMUtVREZOMDhNUXdrOENxYTdHN1QxTzQ5aU02cEM3RUhl?=
 =?utf-8?B?WW85RWJXRVRwc0VEMkE1S2xnV3VvUlNyS05jZlhVMm5tRDhmOVQycXgxbFlK?=
 =?utf-8?B?eWZzZmtKV1oyZTI3cG5HWXdOcnlpSmlqNHBxcEpyMkxMSFFoVU1HVHZkZUJr?=
 =?utf-8?B?VW9VZEdsVXVERVpyNzFiS0JHd08yWkI2Z0VIVkRBei9iQWhxWXA3clE4Zkph?=
 =?utf-8?B?VXFROG8vNHpTWnNLaWFLclR6cnkyaU5XWHhsdS9yVXFucyswS3k4VG52VnF2?=
 =?utf-8?B?U3h5L2dWenM0Rzc5YmJZS2k4eXVHWWczdDNoc3llbHJQNkU0dStEYTBTVjl0?=
 =?utf-8?B?SXBXTXJ5VmJGVnkrV0drbG1qR0ZtK3BXWVpWTEhvZ3dKWVl3VnB3cWd1eHls?=
 =?utf-8?B?UWxzMWN4aXc0MitiYU5hWkFwNDZHQncyUlFybHhESmVZSDd6Wjd2NVNxeFZs?=
 =?utf-8?B?aERpU3gxNW9pcGIwQ1NiV0dCSStkcUQ0c01MajdvaEhTUmJTL0hRV0h0amRE?=
 =?utf-8?B?azgxellRMmRNUzN3SXBDdlRERGQ5U2VPV2d0ZGorNmF0ZEZESWtLYkQ4bEFB?=
 =?utf-8?B?c2hwS3FQZGI5Y1Fub3NPN25hMU1KMitpaHFobFhGdEZjTFczeFlScVJBQkhk?=
 =?utf-8?B?K3hIcllSMG8zWHAxeDZ2K2liMGk5Rm1vVWxNMERTeHc0M2E5cGRHaVk5b3g4?=
 =?utf-8?B?cEd1QmxpdnpKMytwZkV0VjRqQ2I4Kzl5NWRCSXJSdUJqMGhzU2JkUENyRUNL?=
 =?utf-8?B?RUVoODVBc3BpYmo0YVpMc2ZTZC9LY2taeWtLYnpkRkl4QTdnQjhnd2lEOFNq?=
 =?utf-8?B?MTlwMWlocDZ1WGtleks3Sjc3TkNMbzBOOC9ua0VNQjFmTmpaR0Y4NmJzMDhT?=
 =?utf-8?B?UmVDYi94Qy9uSXZndjVRR04wM3lEc3FvVkk1dTk3NFBsQkRWckZYZUVJbmV2?=
 =?utf-8?B?WTUrZUJ0RVl6c1FnQVlIUkZTMWU0MmtyaTFOYnBJS09jTTY4OTVTdlBxZkNM?=
 =?utf-8?B?S0xWUkZzQ0FLdVIyQ01QWWlTZkEvNTg4czJKeXY2SHM0Wmk2Rml2R09ja1l1?=
 =?utf-8?B?L3RhaDhOVUovNVNydW04cnRsMkliSzhza2hXYWk1Zm5rU29OR01YQmRYck9S?=
 =?utf-8?B?ekJrUVMvWEkwWkdUZXdQQXFuSURkdHVKRm95WXhneFlRTkorZWoyZ2tMcFVp?=
 =?utf-8?B?Y2Z6VTFjU1kwOFBkWFBSdVk2aGFFd1BCei9kNnZ3TlA4M2Jxbll2WkpMdmo5?=
 =?utf-8?B?YU8zZkVMWURyeU1obGFUYzFHSnMrdDBQQXZGaDJvUERIY2tRMnYxQTFmSFhB?=
 =?utf-8?B?bzA2UVZvclY3UHM2UUxHMnFsOXFmSWpheWxNZUlaUWczbG9wZDBndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 304450a7-71e8-44ce-d440-08dec1667813
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:51:37.9537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NKHPqLclMi4EyW15fWIV8mI+1/lnhI9ElEOYlNi4GI3uC/MCUozflEcQ97AbsZnU/j0zwQkqEkAJ2af1iPjgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8832
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

On Wed Jun 3, 2026 at 2:15 AM BST, Danilo Krummrich wrote:
> Add a RegistrationData associated type to drm::Driver. This is a ForLt
> type whose lifetime is tied to the parent bus device binding scope.
>
> Registration<'a, T> takes ownership of the data via Pin<KBox<_>>,
> storing it with its real lifetime. The pointer is written to drm::Device
> before drm_dev_register() to ensure it is already in place when ioctls
> arrive.
>
> UnbindGuard::registration_data_with() provides access with the lifetime
> shortened from 'static via ForLt::cast_ref_unchecked. Since
> Registration::drop() calls drm_dev_unplug(), which performs an SRCU
> barrier waiting for all drm_dev_enter() critical sections to complete,
> the data is guaranteed to remain valid for the duration of any
> UnbindGuard.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs |  16 +++--
>  drivers/gpu/drm/tyr/driver.rs  |  16 +++--
>  rust/kernel/drm/device.rs      |  49 +++++++++++++
>  rust/kernel/drm/driver.rs      | 123 ++++++++++++++++++++++++---------
>  rust/kernel/drm/mod.rs         |   1 +
>  5 files changed, 162 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index c5b0313006bd..4267e6e6dbb4 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -12,7 +12,8 @@
>          ioctl, //
>      },
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
> =20
>  use crate::file::File;
> @@ -20,9 +21,10 @@
> =20
>  pub(crate) struct NovaDriver;
> =20
> -pub(crate) struct Nova {
> +pub(crate) struct Nova<'bound> {
>      #[expect(unused)]
>      drm: ARef<drm::Device<NovaDriver>>,
> +    _reg: drm::Registration<'bound, NovaDriver>,
>  }
> =20
>  /// Convienence type alias for the DRM device type for this driver
> @@ -56,7 +58,7 @@ pub(crate) struct NovaData {
> =20
>  impl auxiliary::Driver for NovaDriver {
>      type IdInfo =3D ();
> -    type Data<'bound> =3D Nova;
> +    type Data<'bound> =3D Nova<'bound>;
>      const ID_TABLE: auxiliary::IdTable<Self::IdInfo> =3D &AUX_TABLE;
> =20
>      fn probe<'bound>(
> @@ -66,15 +68,19 @@ fn probe<'bound>(
>          let data =3D try_pin_init!(NovaData { adev: adev.into() });
> =20
>          let drm =3D drm::UnregisteredDevice::<Self>::new(adev, data)?;
> -        let drm =3D drm::Registration::new_foreign_owned(drm, adev.as_re=
f(), 0)?;
> +        let reg =3D drm::Registration::new(adev.as_ref(), drm, (), 0)?;
> =20
> -        Ok(Nova { drm: drm.into() })
> +        Ok(Nova {
> +            drm: reg.device().into(),
> +            _reg: reg,
> +        })
>      }
>  }
> =20
>  #[vtable]
>  impl drm::Driver for NovaDriver {
>      type Data =3D NovaData;
> +    type RegistrationData =3D ForLt!(());
>      type File =3D File;
>      type Object<Ctx: drm::DeviceContext> =3D gem::Object<NovaObject, Ctx=
>;
>      type ParentDevice<Ctx: DeviceContext> =3D auxiliary::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index 338c25ccc151..819f64a7573d 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -31,7 +31,8 @@
>          aref::ARef,
>          Mutex, //
>      },
> -    time, //
> +    time,
> +    types::ForLt, //
>  };
> =20
>  use crate::{
> @@ -52,8 +53,9 @@
>  pub(crate) struct TyrPlatformDriver;
> =20
>  #[pin_data(PinnedDrop)]
> -pub(crate) struct TyrPlatformDriverData {
> +pub(crate) struct TyrPlatformDriverData<'bound> {
>      _device: ARef<TyrDrmDevice>,
> +    _reg: drm::Registration<'bound, TyrDrmDriver>,
>  }
> =20
>  #[pin_data]
> @@ -98,7 +100,7 @@ fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -=
> Result {
> =20
>  impl platform::Driver for TyrPlatformDriver {
>      type IdInfo =3D ();
> -    type Data<'bound> =3D TyrPlatformDriverData;
> +    type Data<'bound> =3D TyrPlatformDriverData<'bound>;
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TA=
BLE);
> =20
>      fn probe<'bound>(
> @@ -150,10 +152,11 @@ fn probe<'bound>(
>          });
> =20
>          let tdev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, =
data)?;
> -        let tdev =3D drm::driver::Registration::new_foreign_owned(tdev, =
pdev.as_ref(), 0)?;
> +        let reg =3D drm::Registration::new(pdev.as_ref(), tdev, (), 0)?;
> =20
>          let driver =3D TyrPlatformDriverData {
> -            _device: tdev.into(),
> +            _device: reg.device().into(),
> +            _reg: reg,
>          };
> =20
>          // We need this to be dev_info!() because dev_dbg!() does not wo=
rk at
> @@ -164,7 +167,7 @@ fn probe<'bound>(
>  }
> =20
>  #[pinned_drop]
> -impl PinnedDrop for TyrPlatformDriverData {
> +impl PinnedDrop for TyrPlatformDriverData<'_> {
>      fn drop(self: Pin<&mut Self>) {}
>  }
> =20
> @@ -181,6 +184,7 @@ fn drop(self: Pin<&mut Self>) {}
>  #[vtable]
>  impl drm::Driver for TyrDrmDriver {
>      type Data =3D TyrDrmDeviceData;
> +    type RegistrationData =3D ForLt!(());
>      type File =3D TyrDrmFileData;
>      type Object<R: drm::DeviceContext> =3D drm::gem::shmem::Object<BoDat=
a, R>;
>      type ParentDevice<Ctx: DeviceContext> =3D platform::Device<Ctx>;
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 828618ae19af..9e5e069b5135 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -23,6 +23,7 @@
>          AlwaysRefCounted, //
>      },
>      types::{
> +        ForLt,
>          NotThreadSafe,
>          Opaque, //
>      },
> @@ -35,6 +36,7 @@
>  };
>  use core::{
>      alloc::Layout,
> +    cell::UnsafeCell,
>      marker::PhantomData,
>      mem,
>      ops::Deref,
> @@ -259,6 +261,9 @@ pub fn new(
>          // SAFETY: `drm_dev` is still private to this function.
>          unsafe { (*drm_dev).driver =3D const { &Self::VTABLE } };
> =20
> +        // SAFETY: `raw_drm` is valid; no concurrent access before regis=
tration.
> +        unsafe { (*raw_drm.as_ptr()).registration_data =3D UnsafeCell::n=
ew(NonNull::dangling()) };
> +
>          // SAFETY: The reference count is one, and now we take ownership=
 of that reference as a
>          // `drm::Device`.
>          // INVARIANT: We just created the device above, but have yet to =
call `drm_dev_register`.
> @@ -290,6 +295,7 @@ pub fn new(
>  pub struct Device<T: drm::Driver, C: DeviceContext =3D Registered> {
>      dev: Opaque<bindings::drm_device>,
>      data: T::Data,
> +    pub(super) registration_data: UnsafeCell<NonNull<<T::RegistrationDat=
a as ForLt>::Of<'static>>>,
>      _ctx: PhantomData<C>,
>  }
> =20
> @@ -298,6 +304,27 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_de=
vice {
>          self.dev.get()
>      }
> =20
> +    /// Returns a reference to the registration data with lifetime short=
ened from `'static`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that:
> +    ///
> +    /// - The parent bus device is bound (e.g. by holding an active `drm=
_dev_enter()` critical
> +    ///   section via [`UnbindGuard`]).
> +    /// - The returned reference is not exposed to code that can choose =
a concrete lifetime for
> +    ///   it, as that would be unsound for types that are invariant over=
 their lifetime parameter
> +    ///   (e.g. it must be passed through an HRTB-bounded closure).
> +    unsafe fn registration_data_unchecked(&self) -> &<T::RegistrationDat=
a as ForLt>::Of<'_> {
> +        // SAFETY: Caller guarantees the parent bus device is bound, hen=
ce
> +        // the pointer is valid.
> +        let static_ref =3D unsafe { (*self.registration_data.get()).as_r=
ef() };
> +
> +        // SAFETY: Caller guarantees the reference is only used behind a=
n HRTB, making the
> +        // round-trip from `'static` sound regardless of variance.
> +        unsafe { T::RegistrationData::cast_ref_unchecked(static_ref) }
> +    }
> +
>      /// # Safety
>      ///
>      /// `ptr` must be a valid pointer to a `struct device` embedded in `=
Self`.
> @@ -412,6 +439,28 @@ pub struct UnbindGuard<'a, T: drm::Driver> {
>      idx: i32,
>  }
> =20
> +impl<T: drm::Driver> UnbindGuard<'_, T> {
> +    /// Access the parent device and registration data through a closure=
, with both lifetimes
> +    /// tied to the closure scope.
> +    ///
> +    /// The data is owned by [`Registration`](drm::Registration) and is =
guaranteed to remain valid
> +    /// for the duration of this guard, since [`Registration`](drm::Regi=
stration)'s `drop` calls
> +    /// `drm_dev_unplug()` which waits for all `drm_dev_enter()` critica=
l sections to complete.
> +    pub fn registration_data_with<R, F>(&self, f: F) -> R
> +    where
> +        F: for<'a> FnOnce(
> +            &'a T::ParentDevice<device::Bound>,
> +            &'a <T::RegistrationData as ForLt>::Of<'a>,
> +        ) -> R,
> +    {
> +        // SAFETY: We hold an active `drm_dev_enter()` critical section,=
 so the parent bus
> +        // device is guaranteed to be bound. The closure's HRTB `for<'a>=
` prevents the caller
> +        // from smuggling in references with a concrete short lifetime, =
satisfying the lifetime
> +        // requirement of `registration_data_unchecked`.
> +        f(&**self, unsafe { self.dev.registration_data_unchecked() })
> +    }
> +}
> +
>  impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
>      type Target =3D T::ParentDevice<device::Bound>;
> =20
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index f68a17d8939d..6aa1cb99cc7f 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -7,11 +7,11 @@
>  use crate::{
>      bindings,
>      device,
> -    devres,
>      drm,
>      error::to_result,
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
>  use core::{
>      mem,
> @@ -110,6 +110,16 @@ pub trait Driver {
>      /// Context data associated with the DRM driver
>      type Data: Sync + Send;
> =20
> +    /// Data owned by the [`Registration`] and accessible through [`drm:=
:device::UnbindGuard`].
> +    ///
> +    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to =
the parent bus
> +    /// device binding scope.
> +    /// The data is only accessible while the parent bus device is bound=
 (i.e. within a
> +    /// `drm_dev_enter/exit` critical section), and references handed ou=
t by
> +    /// [`UnbindGuard::registration_data_with()`](drm::device::UnbindGua=
rd::registration_data_with)
> +    /// ties the lifetime to the closure scope.
> +    type RegistrationData: ForLt;
> +
>      /// The type used to manage memory for this driver.
>      type Object<Ctx: drm::DeviceContext>: AllocImpl;
> =20
> @@ -139,12 +149,57 @@ pub trait Driver {
>  /// The registration type of a `drm::Device`.
>  ///
>  /// Once the `Registration` structure is dropped, the device is unregist=
ered.
> -pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
> +pub struct Registration<'a, T: Driver> {
> +    drm: ARef<drm::Device<T>>,
> +    _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
> +}
> +
> +impl<'a, T: Driver> Registration<'a, T>
> +where
> +    for<'b> <T::RegistrationData as ForLt>::Of<'b>: Send,
> +{
> +    /// Register a new [`UnregisteredDevice`](drm::UnregisteredDevice) w=
ith userspace.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must not `mem::forget()` the returned [`Registration`=
] or otherwise prevent its
> +    /// [`Drop`] implementation from running, since the registration dat=
a may contain borrowed
> +    /// references that become invalid after `'a` ends.
> +    ///
> +    /// If the registration data is `'static`, use the safe [`Registrati=
on::new()`] instead.
> +    pub unsafe fn new_with_lt<E>(
> +        dev: &'a device::Device<device::Bound>,
> +        drm: drm::UnregisteredDevice<T>,
> +        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, E=
>,
> +        flags: usize,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        if drm.as_ref().as_raw() !=3D dev.as_raw() {
> +            return Err(EINVAL);
> +        }
> =20
> -impl<T: Driver> Registration<T> {
> -    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self=
> {
> -        // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::De=
vice`.
> -        to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flag=
s) })?;
> +        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>> =
=3D
> +            KBox::pin_init(reg_data, GFP_KERNEL)?;
> +
> +        // Store the registration data pointer in the device before regi=
stration, so that it is
> +        // visible once ioctls can be called.
> +        //
> +        // SAFETY: Lifetimes do not affect layout, so the pointer cast i=
s sound.
> +        let ptr: NonNull<<T::RegistrationData as ForLt>::Of<'static>> =
=3D
> +            unsafe { mem::transmute(NonNull::from(Pin::get_ref(reg_data.=
as_ref()))) };
> +
> +        // SAFETY: No concurrent access; the device is not yet registere=
d.
> +        unsafe { *drm.registration_data.get() =3D ptr };
> +
> +        // SAFETY: `drm` is a valid, initialized but not yet registered =
DRM device.
> +        let ret =3D unsafe { bindings::drm_dev_register(drm.as_raw(), fl=
ags) };
> +        if let Err(e) =3D to_result(ret) {
> +            // SAFETY: No concurrent access; registration failed.
> +            unsafe { *drm.registration_data.get() =3D NonNull::dangling(=
) };
> +            return Err(e);
> +        }
> =20
>          // SAFETY: We just called `drm_dev_register` above
>          let new =3D NonNull::from(unsafe { drm.assume_ctx() });
> @@ -156,48 +211,49 @@ fn new(drm: drm::UnregisteredDevice<T>, flags: usiz=
e) -> Result<Self> {
>          // one reference to the device - which we take ownership over he=
re.
>          let new =3D unsafe { ARef::from_raw(new) };
> =20
> -        Ok(Self(new))
> +        Ok(Self {
> +            drm: new,
> +            _reg_data: reg_data,
> +        })
>      }
> =20
> -    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) =
with userspace.
> -    ///
> -    /// Ownership of the [`Registration`] object is passed to [`devres::=
register`].
> -    pub fn new_foreign_owned<'a>(
> -        drm: drm::UnregisteredDevice<T>,
> +    /// Safe variant of [`Registration::new_with_lt()`] for registration=
 data that does not contain
> +    /// borrowed references.
> +    pub fn new<E>(

This is currently unsound, as leaking the unbind guard also gives out
`&Device<Bound>` in addition to the registration data.

I think we should just remove the not pass `&Device<Bound>` to ioctl callba=
cks.
Giving back registration data is sufficient; if a device driver needs
`&Device<Bound>` it can just store a reference in its registration data; mo=
re
commonly I suspect it will just store whatever device resource is needed an=
d
doesn't need `&Device<Bound>` (with the introduction of lifetime, we have m=
uch
fewer cases that we actually need `&Device<Bound>` and cannot be replaced w=
ith a
direct reference to the device resource).

Not passing this bound device allows us to make this safe, and also remove =
the
need of patch 1 and patch 5. Actually, your patch 7 is a good demonstration=
 of
the pattern that I described :)

Best,
Gary

>          dev: &'a device::Device<device::Bound>,
> +        drm: drm::UnregisteredDevice<T>,
> +        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, E=
>,
>          flags: usize,
> -    ) -> Result<&'a drm::Device<T>>
> +    ) -> Result<Self>
>      where
> -        T: 'static,
> +        <T::RegistrationData as ForLt>::Of<'a>: 'static,
> +        Error: From<E>,
>      {
> -        if drm.as_ref().as_raw() !=3D dev.as_raw() {
> -            return Err(EINVAL);
> -        }
> -
> -        let reg =3D Registration::<T>::new(drm, flags)?;
> -        let drm =3D NonNull::from(reg.device());
> -
> -        devres::register(dev, reg, GFP_KERNEL)?;
> -
> -        // SAFETY: Since `reg` was passed to devres::register(), the dev=
ice now owns the lifetime
> -        // of the DRM registration - ensuring that this references lives=
 for at least as long as 'a.
> -        Ok(unsafe { drm.as_ref() })
> +        // SAFETY: `Of<'a>: 'static` guarantees the data contains no bor=
rowed references,
> +        // so forgetting the `Registration` cannot cause use-after-free.
> +        unsafe { Self::new_with_lt(dev, drm, reg_data, flags) }
>      }
> =20
>      /// Returns a reference to the `Device` instance for this registrati=
on.
>      pub fn device(&self) -> &drm::Device<T> {
> -        &self.0
> +        &self.drm
>      }
>  }
> =20
>  // SAFETY: `Registration` doesn't offer any methods or access to fields =
when shared between
>  // threads, hence it's safe to share it.
> -unsafe impl<T: Driver> Sync for Registration<T> {}
> +unsafe impl<T: Driver> Sync for Registration<'_, T> where
> +    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
> =20
>  // SAFETY: Registration with and unregistration from the DRM subsystem c=
an happen from any thread.
> -unsafe impl<T: Driver> Send for Registration<T> {}
> +unsafe impl<T: Driver> Send for Registration<'_, T> where
> +    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
> =20
> -impl<T: Driver> Drop for Registration<T> {
> +impl<T: Driver> Drop for Registration<'_, T> {
>      fn drop(&mut self) {
>          // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensu=
re that existing
>          // `drm_dev_enter()` critical sections complete before unregistr=
ation proceeds. This
> @@ -207,6 +263,9 @@ fn drop(&mut self) {
>          //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
>          // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
> -        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
> +        unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
> +        // After drm_dev_unplug(), the SRCU barrier guarantees that all =
UnbindGuard critical
> +        // sections have completed, so no one holds a reference to reg_d=
ata anymore.
> +        // reg_data is dropped here automatically.
>      }
>  }
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index a66e7166f66b..59870bb09de2 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -12,6 +12,7 @@
>  pub use self::device::Device;
>  pub use self::device::DeviceContext;
>  pub use self::device::Registered;
> +pub use self::device::UnbindGuard;
>  pub use self::device::Uninit;
>  pub use self::device::UnregisteredDevice;
>  pub use self::driver::Driver;


