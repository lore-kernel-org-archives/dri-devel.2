Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2D1F8FA94
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E6110E8EE;
	Tue, 21 Apr 2026 16:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="uRtVvv3A";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021118.outbound.protection.outlook.com [52.101.100.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A0D10ED10
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 16:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPjJz0OdJslV1c509DB/o9zZ8w7WBuvbLMntgCiTJ2IxOHshvC7+2jlf4XR0oxKvynBWLjDxp8ULwYPuneMvZhNvvHPVGswdDe2hLGvPVgXuit6kS1ov+G+HCxuXCG2JH/f/GRts04mNOH4VqQ/v2ioYUdCwns4W3rVo8JPkajsPkdmTFPSfC7foWMDfTd8mx507weiXAN3VDmwBNSNiRsME//Zaq2Mk72mEnJfJ6MInk6V750SpRQi/RZKv7Oy24HMCeT1X63TtiZuAM1pfvha6gve0c/406VuR6JHXFufq5giBZES9ybs17cWyzUJYeD3L18nGQ4BDeL4Wt5P4Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3AWCDZU1zP0Yj3WUGpRguwgNQAb2hbW1ivoAvPhiDA=;
 b=dpLYdUVNbTOUoxMQF6PfDG/FXEEt7ux3LI/C/0gsihotza2qobDj1041kczIsOhshqY66CrdE3Os0ZmCFooHTV8WkTfml9JvZsIc36ra2ckFCyCSZAPa4M0XoMF0U3esZuNiutEF205UHy7hETO04F3s2IffUc5sc8nvfHuhIgaigKsrywN/c184JVlfor0G70vCEugHtTdI9CKUwqwLACPUcJLssfRlkET83lIUYANN4f5URKdONB2tXYFhQLqh2NnlTjuS6UW1iLTdpBCIZvNSbC9CkU1JADb7ylyxbl64SIgwEkpmJE2f3ZTXg5H4Xns2YVZZexTk/EinxkNMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3AWCDZU1zP0Yj3WUGpRguwgNQAb2hbW1ivoAvPhiDA=;
 b=uRtVvv3A/13+KIqTBbMyf+bzG0MlZHLdlNaJL/xBOQ4mu88XHAQ7BJ7WKxAu8nLmPRLJL/MHVTX6kqajMEnNVaAQsr7AXqWJUym11z397dDQjGNjBAFeAZLsrJyFwNDi6OKh4xoVAv+TnFlKtV2EGCTp51WwlmDDrK4k4izrpl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB5979.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:14:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 16:14:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:14:54 +0100
Message-Id: <DHYYTAECTETZ.2RRY4SNC1YLEX@garyguo.net>
Subject: Re: [PATCH v2 RESEND 1/4] rust: add SRCU abstraction
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <jiangshanlai@gmail.com>, <paulmck@kernel.org>, <josh@joshtriplett.org>,
 <rostedt@goodmis.org>
X-Mailer: aerc 0.21.0
References: <20260416171728.205141-1-work@onurozkan.dev>
 <20260416174308.221235-1-work@onurozkan.dev>
In-Reply-To: <20260416174308.221235-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0581.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 129651bf-0ed5-4805-7f0d-08de9fc12049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: BVVEIj42PSIQvxD28gq94iiAQIzbLf52SIOnzH1CyldX4Q7b5VE0np7lG3ZvHhQyyXiQ5hv+Vw3uNvIgZkZFH9EACybO/2k+Fu+4+NOwEEOr+8J9CXR7kslez2HrLKQNfHbUouGIFBI7lA+uzFeJ3YXKTX80BgL1TV6Fqueq/YBKSS7IZ5S7xrfDpbjrmRCZGKR8dDYEGGbXo7HSrIsedRPY3JcelIsngSEgMSrgLjTYbXttfC4HvmvSKG0N1L327N5GjWU5rknpB2m9om2bX3oo2wN+7JGFpKbQYc6Z+s+C56Ot28nsp6J29UPM9F/IMMxtsTI4efgG0n6+8FF7UeI/myfn8SS3u3AWh1ov6/le9mBvaeId4ZO/jfJPLx8AiE88EoN8MlOXmH6e3ClCAJKEM+LcVCd13y9I4s9NCPS0hE63KibnalAvVxp8ys+8QoPc5ODVmO2FdhpG4Gm9am6kZAesM7ItAe3WQxS+qcvvtko2iWM8juaJ043lnhTHYPSEOYvhW/OvwdyEnbrErQOvuNY4t6dMxrxfguY637VXFQZ2BxTDkhF0PlCH0EZU54HN6tOVD5g/AskW+RoLtRPHErkndwIjL/Aw5SP1cUiJIU/4Lfy0VexUlnE9+QfwEF+V6ReJZIMz6rNDai+SlZDpuaniYytWbZOGQHPYpx8XcwNirSbN4J4oF/usrOAKLH02DJeVeOpTibCMy23VGQF0hczcVh04sSYLRPU2b6KiuD1Iaf95/cQxDvqLMc8jisfzmBNrX1Tf4K5cH2C2Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHNETU94RUVGS3hKT3hVNEJDTytjakRISHhUaGtOZktEWnBnTjdwY2MveHk5?=
 =?utf-8?B?azdtSTEyYWlSUTVuQnY1b0ZyemRyVXVXMVVwOHhqay9uK3FDWEZRUXNGUG9i?=
 =?utf-8?B?ZEUxaEYyTUpZZ3Z1UWQ2aDVVbVgvb2FiY0JEZ2RhbTVMZzRuZ0RhTVRlNWRs?=
 =?utf-8?B?YVRyb0FuQWRwUHJ3Qyt3YmVFWXRhQjlGMHBjZk9rMmRzdzZyMUMySHBnYjhR?=
 =?utf-8?B?anBpWDE5c2Qwb2pVWFdwYWNGVC95SEZEZlZ6OFFxZTFlVFpNN2NsNXFCYUI3?=
 =?utf-8?B?STVGVWFycmlzWUNjcmRRdDY4RTVkWS9XamVpNnNBUkloUmJ1L29PaEdYM3pa?=
 =?utf-8?B?dE1kclU2OXpHZk5Fajhxb3NaU0h2VHZCYnozVDJBaVpFN1ZROFFtMEU3U3VI?=
 =?utf-8?B?dUM5UkRtckxFTk53VUl1VWNHYzMzWkdNN1RQUHlGT0VIWmI3VWNRUXY3ZEJ2?=
 =?utf-8?B?cVFGVGUwMTM3c0RNTXFhVmhEbEcyV2ExMFZkSnlqQVIzblhObitMNHZQK2g1?=
 =?utf-8?B?RzRNVFMwWlVQa3lyRndBamI2U1VWUk5qWElXUHdKOThveFJGRUhZcjRhU0NG?=
 =?utf-8?B?OFFyZWUyNXhSdkpINy9HUElYK1JycVdsYnFoVm96QS9zWjR3WC9HSHd4YWUw?=
 =?utf-8?B?R2R1ZmRaUW9xakljWEdJTmVhVGc3QkUwaVMvWXlpbWJ6dzBkcUNYNTRkSXBN?=
 =?utf-8?B?cVJWM051bkNsS3JSSTRxUkVSaVpnRFljek1aRmttN052S2ZJVTNkSnh3anNE?=
 =?utf-8?B?WVBZZHdRc1A3QjBJTlVEc2l5cDlUN20zMnFzUnhnQmlUODFtMzNxVDM5ZERG?=
 =?utf-8?B?aXNBNVM1SnB2NVBWNFpaQVNUTkJnS09weHZyMzNubzFVYmxKNzVQMlpTK2NG?=
 =?utf-8?B?TTlUa2RDVUkxbERHRTJrYkVSQlhzRXBVSURudWlwVWlNcERSUXd5M2NpS0hN?=
 =?utf-8?B?WUhueStKVXJ0L2l3aFB4ZjAzd3UzWjYrdWZXenNoTkN0RE1XS2ZraFgwcFY1?=
 =?utf-8?B?d2FncEhGWDhaWklibi9DcmtPVEY0YTY3Q1VCWkhnVVFsMmpzaEdNN3BRdGNB?=
 =?utf-8?B?QkVQdEtOc0dqTUx2aTRhaVM3RC9QS2ZLU05mM21pWWdVTVZIZm56QWhjVlp2?=
 =?utf-8?B?b2lNN3lQdVdzUXZRWnFmSlVYaU1weDBPYjBERW40ODM3b1o0bGdzWjRrOFhw?=
 =?utf-8?B?NGpvSTFTUGhYR0pDTkloVThCWE1XSWlJTVY3SGFBdkFkbXBqWHlNR2hGL0NG?=
 =?utf-8?B?TDJyeVBuMGdHRnk0QlhmSnI3czk4aE5CLzMzWlZ2b25vV2g4TEtjTDU2ZWwy?=
 =?utf-8?B?R1VmUDFxcVp4dnJ4WHhkakVxVGxNb2t4TDVicjJJa0FSYmVpNEN1eDNUdkVY?=
 =?utf-8?B?YzBBWEduaW0vYmhzbG5BTWxqUkZRVHkzbFM2RmNlSnJKUFd5bTVXVkVvcUZT?=
 =?utf-8?B?UlNaRXVmVUFGTU05WGI0NGRqQW9jMktrZUxCVTFSWXQ2YUhBUnlXRWtvQTBI?=
 =?utf-8?B?NlBYMG1VUkR2WEltL3hLUXh1Vy92Rjg1enhsaWsvWS9NK0Jpc1RyakRVVDJU?=
 =?utf-8?B?NUltc1JKRnNJWG1vSGpNdVdOSTFWdjZmWW9mQ3JxY09DNmRzUzZET1ltZkcv?=
 =?utf-8?B?RGxUeEtsWXppeFV6b2xWbDEvNk9naVZUY2xZNE5ZczZWVXN3eXpQK3ZEN2li?=
 =?utf-8?B?cGhaYTY4cVBrMWlkRXdYWURYMXpKUGlZWUVQWTNoVHJxSVJ4ZnNBSW5HK1lS?=
 =?utf-8?B?STNQZkU3WXhYdVoxWGhZNkpKNVpDb05oVGJLWHFBbXo5OXFzbFhKQ3FiVVdK?=
 =?utf-8?B?VEZnU29Da2RMbjRzZVdrRS9XSG1tZFd2d3owNzhXczFmR3ZmOXg5Tktyc3dm?=
 =?utf-8?B?Vlp3a0N3Q2lLUENtVXdLWWIxelFmd1Y4b016T2huNnRBeXEwakVXR09NZWoz?=
 =?utf-8?B?T09WYUIzMk02WklKSVplQTA4ZnpNNEFaakhyYWVMdmttcVNTZTNyRGU3WmNv?=
 =?utf-8?B?czBWVTVTdTJNY3d3Ly9Bd0tFc2hMaTJobUptZ1ZLL3kwQVJGdUVxUG5PR3BZ?=
 =?utf-8?B?SC9tQzFvUXU0TjMrWWdqYWxPK29mVGowM3cybDlwQmR3b0dTcTdPNy9sTjRq?=
 =?utf-8?B?Y2ZiUWNsdXpsSjFyZWN5L0hUR1lPbHRrTHpuSUJQa3czdXdCdXBhVzZwQlNJ?=
 =?utf-8?B?aG1kTk9hcE0vWGVXMm1LWmhFNTFLOFNnamdDUE4rTWJQaWcxbC9SODM3YnE0?=
 =?utf-8?B?aEZ6eU5walNzcmZCaTR4ZjB6bU9nK0FEbXRwUzJNNndQWFhFR1RvY1poUUNy?=
 =?utf-8?B?RUdrY1VWU1hnQWtuNzNqZjU2YjdwU05EeVZ2Ty8rc1RxdUZPdjNEZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 129651bf-0ed5-4805-7f0d-08de9fc12049
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:14:55.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XExPYqRAQWBJGLllxcf6Mu5HUElTbVBE7e4LkS858TI4M+PcSJNVl/waQQKZ5Lr84Nnxrfx8bsOM6ADGW4Mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5979
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

On Thu Apr 16, 2026 at 6:43 PM BST, Onur =C3=96zkan wrote:
> Add a Rust abstraction for sleepable RCU (SRCU), backed by
> srcu_struct. Provide FFI helpers and a safe wrapper with a
> guard-based API for read-side critical sections.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/helpers/helpers.c   |   1 +
>  rust/helpers/srcu.c      |  18 +++++++
>  rust/kernel/sync.rs      |   2 +
>  rust/kernel/sync/srcu.rs | 109 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 130 insertions(+)
>  create mode 100644 rust/helpers/srcu.c
>  create mode 100644 rust/kernel/sync/srcu.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 875a9788ad40..052fef89d5f0 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -60,6 +60,7 @@
>  #include "signal.c"
>  #include "slab.c"
>  #include "spinlock.c"
> +#include "srcu.c"
>  #include "sync.c"
>  #include "task.c"
>  #include "time.c"
> diff --git a/rust/helpers/srcu.c b/rust/helpers/srcu.c
> new file mode 100644
> index 000000000000..b372b733eb89
> --- /dev/null
> +++ b/rust/helpers/srcu.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/srcu.h>
> +
> +__rust_helper int rust_helper_init_srcu_struct(struct srcu_struct *ssp)
> +{
> +	return init_srcu_struct(ssp);
> +}
> +
> +__rust_helper int rust_helper_srcu_read_lock(struct srcu_struct *ssp)
> +{
> +	return srcu_read_lock(ssp);
> +}
> +
> +__rust_helper void rust_helper_srcu_read_unlock(struct srcu_struct *ssp,=
 int idx)
> +{
> +	srcu_read_unlock(ssp, idx);
> +}
> \ No newline at end of file

^

> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 993dbf2caa0e..0d6a5f1300c3 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -21,6 +21,7 @@
>  pub mod rcu;
>  mod refcount;
>  mod set_once;
> +pub mod srcu;
> =20
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -31,6 +32,7 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use srcu::Srcu;
> =20
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/srcu.rs b/rust/kernel/sync/srcu.rs
> new file mode 100644
> index 000000000000..cf0c16248ea3
> --- /dev/null
> +++ b/rust/kernel/sync/srcu.rs
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Sleepable read-copy update (SRCU) abstraction.
> +//!
> +//! C header: [`include/linux/srcu.h`](srctree/include/linux/srcu.h)
> +
> +use crate::{
> +    bindings,
> +    error::to_result,
> +    prelude::*,
> +    types::{
> +        NotThreadSafe,
> +        Opaque, //
> +    },
> +};
> +
> +use pin_init::pin_data;
> +
> +/// Creates an [`Srcu`] initialiser.
> +#[macro_export]
> +macro_rules! new_srcu {
> +    () =3D> {
> +        $crate::sync::Srcu::new()
> +    };

There's no need to create macro just for the sake of creating a macro. Alth=
ough,
as Boqun already pointed out, macro will be needed for lockdep.

> +}
> +
> +/// Sleepable read-copy update primitive.
> +///
> +/// SRCU readers may sleep while holding the read-side guard.
> +#[repr(transparent)]
> +#[pin_data(PinnedDrop)]
> +pub struct Srcu {
> +    #[pin]
> +    inner: Opaque<bindings::srcu_struct>,
> +}
> +
> +impl Srcu {
> +    /// Creates a new SRCU instance.
> +    pub fn new() -> impl PinInit<Self, Error> {

Most of the methods here can be `#[inline]`

> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(|ptr: *mut bindings::srcu_stru=
ct| {
> +                // SAFETY: `ptr` points to valid uninitialised memory fo=
r a `srcu_struct`.
> +                to_result(unsafe { bindings::init_srcu_struct(ptr) })
> +            }),
> +        })
> +    }
> +
> +    /// Enters an SRCU read-side critical section.
> +    pub fn read_lock(&self) -> Guard<'_> {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid=
 initialized `srcu_struct`.
> +        let idx =3D unsafe { bindings::srcu_read_lock(self.inner.get()) =
};
> +
> +        Guard {
> +            srcu: self,
> +            idx,
> +            _nts: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed.
> +    pub fn synchronize(&self) {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid=
 initialized `srcu_struct`.
> +        unsafe { bindings::synchronize_srcu(self.inner.get()) };
> +    }
> +
> +    /// Waits until all pre-existing SRCU readers have completed, expedi=
ted.
> +    ///
> +    /// This requests a lower-latency grace period than [`Srcu::synchron=
ize`] typically
> +    /// at the cost of higher system-wide overhead. Prefer [`Srcu::synch=
ronize`] by default
> +    /// and use this variant only when reducing reset or teardown latenc=
y is more important
> +    /// than the extra cost.
> +    pub fn synchronize_expedited(&self) {
> +        // SAFETY: By the type invariants, `self.inner.get()` is a valid=
 initialized `srcu_struct`.
> +        unsafe { bindings::synchronize_srcu_expedited(self.inner.get()) =
};
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Srcu {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: `self` is pinned and `inner` contains a valid initial=
ized `srcu_struct`.
> +        unsafe { bindings::cleanup_srcu_struct(self.as_ref().get_ref().i=
nner.get()) };
> +    }
> +}
> +
> +// SAFETY: `srcu_struct` may be shared and used across threads.
> +unsafe impl Send for Srcu {}
> +// SAFETY: `srcu_struct` may be shared and used concurrently.
> +unsafe impl Sync for Srcu {}
> +
> +/// Guard for an active SRCU read-side critical section on a particular =
[`Srcu`].
> +pub struct Guard<'a> {
> +    srcu: &'a Srcu,
> +    idx: core::ffi::c_int,
> +    _nts: NotThreadSafe,

I'd prefer this to be _not_send so it's self-documenting on why you need th=
is.

Best,
Gary

> +}
> +
> +impl Guard<'_> {
> +    /// Explicitly exits the SRCU read-side critical section.
> +    pub fn unlock(self) {}
> +}
> +
> +impl Drop for Guard<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: `Guard` is only constructible through `Srcu::read_loc=
k()`,
> +        // which returns a valid index for the SRCU instance.
> +        unsafe { bindings::srcu_read_unlock(self.srcu.inner.get(), self.=
idx) };
> +    }
> +}

