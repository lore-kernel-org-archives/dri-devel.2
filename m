Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC95F483D3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F77410E0AA;
	Mon, 23 Mar 2026 16:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Pjhiiikf";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022128.outbound.protection.outlook.com [52.101.96.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044D010E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:44:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iak81LPa44+k4aciO9RLa2csT9IC+HK+h2VUUS6Dk/S+VzVVEUNXhjZYL5ySkhHRaltIN5D+fXKhQqxjiwtwJ3aY2gJ+men/DSwklv2yhGS7cTvlaCH+pDYpifIeYJ08zl8PAbCzK6s0O7KBbn1fpb9Eqs5OA9hYjH2y95HvGyRGrnuWY/KKHWBJSIk01Clj8mbsF09uZuhehxGELNhLk1QtDeu+y43qeRfrUTUPwpbrdOaYNMDA2basHnSBlELLjI5YSu8759FlnnG4hd8sKYrtoMQi+uOe4vtLt+FYMbACS8AdHdw4XZhYQestn6PNKQk+5dZsAY7tgzB/219Wsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfgO5gRJArt5ffu1IgOwqxxVqZxksoVAWaMCe8VmPmo=;
 b=RCptCnnukwrntLwpLHL/zjIzDh+4/1OVwi5r+vu34bm9D2K754kjXpfVyVNza+RdyPhK2SpikHHJW7W0RIWQe9mmgQ2gBWBxrnfzOXAN3fN3IAYRhnR5zw/iKCKtwAoNKgwm7rp4BNP6xxfDh29xicJq8Bi0yB/p2+O/IJCJGvkfmm0lLLOQ8ROuiX22X+JEAahfG2XBq7rN2opiC69bUJfGxzl1t9zbCpUc9dtYocdrg4Ps3OzpxCeLeV1+LaU1/A71XR3uZkQT+72zAjyW/TJ7Mnx7gUmBKPx/YA+nfTsTy9c40CEaeZvAorQAFvQyWW46rS8krFNvNpUQzYFs1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfgO5gRJArt5ffu1IgOwqxxVqZxksoVAWaMCe8VmPmo=;
 b=PjhiiikfoYJQLV7zg7pCXo56UTRzT4O5eI+kjL6zz7YpvRlV/uc7ErIO3h67bYb2UubUGEpzRbNqgpVOQJIpp0K/ZrfV7BNhgWButaOr1lt/CpPbYG7WxGlLoU4jBaxTjHNxV3OFjuiO36y7iuwOagsbA0U2kTPwG+yksyIPZQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7954.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:44:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:44:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 16:44:16 +0000
Message-Id: <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
X-Mailer: aerc 0.21.0
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
In-Reply-To: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
X-ClientProxiedBy: LO4P265CA0283.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ad2f39-aa51-4e13-8d4a-08de88fb6ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: f3cl6yG2Ymrf+czSp8Why2QTPk2XK06KuLjXDSIVcPIz6nUM5vUbY3nqsVfzp7veQfk3rZYGjTko2yic7mOdjAuv3VZsSWz+004zzWlU3zFU6RbHIdlIVgeMQutD4N7I4MsFbOG6bQ18XsOzg3MJUZ1mMc5HljLpCTte5reWy4g+mXtFggV4v+cjZAj89wgOB+HNj+h4IiV5Rmhe+pb1Xzljgkb85e77jzwVGXfEGTuN717r0KP4hM7TaRmmcsg/LORD+GwUT/01mmXGmce9MullDh2XJhFfFdM9p+Z+BV3djRDg/+pC8nHctUdWrf6OVzKO2lqk7zww9u849ezfTRZscutd8OW35F4Wh+4ryzJgDXTjFfCmJIsEQuW/extCzo31kAREg3kANX5sNC9QU+uMp9yXnbyWsXCYWVXD8vVwSqdWZfOcoiMERc0KTUx+RARAdyfKgrbZ1LFIx3Ng1U5i3jI0ZHQOR79b5IPv2BdELb+tf58j1JH58nUwaXPtkCxxSRZI4/QGr/4yy1XciF43CV3Q7uwHueyH7eOwqgZlpyJGuQaKYX63DvBUp5T60R3O/dpRtQfnbycr0F5hYxIkDbgZwbijuC4T2pDVFAFV7vWQgCWqI2PWmQy/1NwDE2oQsc5xiNu/Go0/sqAVZ+ipuy3A6XHzg3jX4kgl7awyt0OahFLJqcc3VrHgDyzX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxtTVNIMm5EMUkwaUlEbUE1KytMYXZINXRKM3lrV0llV2QvbnBST2c4RUdE?=
 =?utf-8?B?bE9Qb3VGYkhBa29RSHlvc2l3dDAra2RsLzFSVTlGUjI1a2VUV2ZCZVZrd3By?=
 =?utf-8?B?WmZlTVpRUGFSTTI3MmpxZnNtNE5BL1hLSGUyNWhhUSs1Y0xVcEdxZVIwYjM2?=
 =?utf-8?B?b2xTb0ZnWUNMSzQ1eWI3TjhBMFdEa3Y1YVhCaEVRUE5ieEpvbWNsUVlyY3pr?=
 =?utf-8?B?ZXZFc2RHZHNZdHE1VzM0bGdoOGtmSjdsWUhteWhMVkFIK0RYNUE4NjZOSmRZ?=
 =?utf-8?B?R1hZNStpV3dYZkdNY0hLaFlpLzdjZDA0NXp5MXQrUXJWRlFEblgvbmpLS05t?=
 =?utf-8?B?YVJTdDhndm83YkJDQlUxeE41QlZKdnlKU0t5ODZUZ251bWRaaktyRSs2d2hT?=
 =?utf-8?B?M011NFJ2Smd2c2FtTC8yNmRmdW5YMWE4MTIxZUVqalJwTGQvR3NkVXpDdTRh?=
 =?utf-8?B?L3JFRlI0OGl2VU1rMWxiVCtvblJwampwKzlHSTUzaTBsV3ZuM0ErR2lnZWZu?=
 =?utf-8?B?ck82UWgyQzFjcHJiWFExUlFUOWYvamNzWGpVcHIyWEM1NExLSTlzRUhWbzRX?=
 =?utf-8?B?TXpsUFlweC9rakNLbmFvWWI2dDcybHJpKzg0WnNxOGNQZ24yMEpFajlZMjNB?=
 =?utf-8?B?bFFLcy9FS2tTcHhHdittQWpWaTdGdFZPVkdXY2t6ekNMekk3bnRKQmJNOFlR?=
 =?utf-8?B?WFhUZUFLNXV3eEJ4VXA2RVI0dnFKeVlsK2t5aUdCb2JBS1BheUV6enl6K3hr?=
 =?utf-8?B?eEZlazluc0VhREkyU1BDOGlRZXdreFIxRTEwS2YrajkvR2tqV3NobHlyQmEv?=
 =?utf-8?B?MXczd2F1WmQydi9ZVXBDWmQvVGdDcllDeWJvT2lvNSs0dk1QZlJNajVlYXdo?=
 =?utf-8?B?cVhRUEtocGZENkovbVk4c2Q2K3kzdm1RWnpnMkRpTmdpMkFKMEdjQ09MdWZw?=
 =?utf-8?B?ZkkwaCtSM3BtblNtTU5na0Y5YUxMRG15KzBxeTY4dTU1d0hoLzVXOG9sWWMz?=
 =?utf-8?B?dlp4OC9oOEhWdnhtUFlQN1JScUZmelZ2eXdRVGhQR0E5NHBhNFFBNGxvdUFO?=
 =?utf-8?B?OXJxRkpuKzR2NTBLMjc2SDJObDRpNWNhMkR6RmZFMW1qREtKSFZIeEN6VmFG?=
 =?utf-8?B?QWNocTJYVnpyd0EveE9aOEVqaHRiRktyMk1MYnA0V1YzZVpJUE1ibmREc3dB?=
 =?utf-8?B?cm9JOUdLdTNqUzdKMDlTVTV3TWxCN2N1RjJUeENvUkdyRzF6OFpzT3ZDdk8w?=
 =?utf-8?B?bHUxNHlibzJuc0sxRFQyclZ5VHVrTmQ5MkZBNmVsWTFsOUxsRHY0M3lFZGJ0?=
 =?utf-8?B?RUF3em5wZy9hUDhFTnQ4VEQzTHdOZDM3L2h5OG85U0NxcFZHTThUcXVmUGNl?=
 =?utf-8?B?MEZkMkFJTWRENkF6M1VGZHpqbG1YNk5DVytkb2lRS0sveGZUVmhhcTBoRzRv?=
 =?utf-8?B?V1ByaFBqbTRaTjJ4RFloQjM2R00zT3BhN3dFMEtaQzVxTlBHWjc5Z3RiNFdC?=
 =?utf-8?B?Z0RQRktFRlphKzJlbU0yUGJFQzJidEJUTWhpempLWGNselM0b0ttbmRQNFJ0?=
 =?utf-8?B?VHdGNEprWjEyUENBd2JNb1M0ejIzSitFWjhUMFpoYWgzUlZqOVBiN2lnYXJo?=
 =?utf-8?B?VHVDK2tqbGcxbFhET1JjN095bE1rZmFXM3ZHME9ONU82ZTFnODlQbWRORkFQ?=
 =?utf-8?B?UFFQb3BnelliTmorbDJkR3RpeXVKN0pUNXBhZ2dIbThYY0YyNWpnUm5HRFhs?=
 =?utf-8?B?NDRaeHlIL2c0Q1p6eU8rU0VQNkRsUnVnMGlhbE8vb1hUWTlQK2tVUmwrdWVm?=
 =?utf-8?B?bDJqdGlJd09ETDJobnlMbU5vVjdBVnBFUHJEeCtHWGhKQm0vL0tPb05nWDk0?=
 =?utf-8?B?NUNkWmozS0RJemswRWtROGFRMFFHaE1qbTVXVmNDT0FBbjEzMi9vb0U3bnI5?=
 =?utf-8?B?aGxUcGdZcjdEalBhTG1tRnYyRW5ncGtmUmdDSkxBcjRmU0ZtOE9zSjhlbXhy?=
 =?utf-8?B?T0hQTGZkUUdTejd6UGJNZXRHOENvTURoNU5iMFVDZjF6VHlJcEJnL0hlTnhv?=
 =?utf-8?B?djUzVkVueUhWMmxpM285MzJwVGRCcXR5K1NTdU5YWHFUL3JvUThKc3RQMk0v?=
 =?utf-8?B?cE5qTlA0RitUZ25IRFRaSTlKTjFqanNvWWZQZWJKZzNzTzZpaWV5RFdyd1RB?=
 =?utf-8?B?RUduYktjYkFYcjhWWFN0WFNkK21ROFZUOXdQWmxvcS9RRmh6Z1VsWXJvK1dY?=
 =?utf-8?B?OG1kYXJKWWJkR3ZyMXQrSXA0ODVkSkd2SWhYN2R5Q2ttSmFjYjZzbDFxeU12?=
 =?utf-8?B?SG9xckdiU3dZTTA5WGU2MGh0UkNrWTR0ZDBxWTB1cHJvMmlCeng0dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ad2f39-aa51-4e13-8d4a-08de88fb6ca6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:44:17.5188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9LjetvgGCpucNla2Pr5GWpvdGHKusyNHBC1+T38yNyYc2zHW14sha1Sl81p24D9b9F+iYwNN0wycVtXRoyQ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7954
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

On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read or write access, respectively.
>
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them is undefined behavior.
>
> Fix this by replacing the slice logic with pointer arithmetic and
> creating slices to valid regions only. It adds unsafe code, but should
> be mostly replaced by `IoView` and `IoSlice` once they land.
>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org=
/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> I didn't apply Eliot's Reviewed-by because the code has changed
> drastically. The logic should remain identical though.
> ---
> Changes in v2:
> - Use `u32_as_usize` consistently.
> - Reduce the number of `unsafe` blocks by computing the end offset of
>   the returned slices and creating them at the end, in one step.
> - Take advantage of the fact that both slices have the same start index
>   regardless of the branch chosen.
> - Improve safety comments.
> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f=
3ce3@nvidia.com

Here's the diff that fixes the issue using I/O projection
https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@kernel=
.org/

Best,
Gary

-- >8 --
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/=
cmdq.rs
index 191b648e2ede..c759a81b28df 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -306,24 +306,25 @@ fn driver_write_area_size(&self) -> usize {
         let tx =3D self.gsp_write_ptr() as usize;
         let rx =3D self.cpu_read_ptr() as usize;
=20
-        // SAFETY:
-        // - We will only access the driver-owned part of the shared memor=
y.
-        // - Per the safety statement of the function, no concurrent acces=
s will be performed.
-        let gsp_mem =3D unsafe { &*self.0.as_ptr() };
-        let data =3D &gsp_mem.gspq.msgq.data;
+        let data =3D io_project!(self.0, .gspq.msgq.data);
=20
         // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_NU=
M_PAGES, inclusive,
         // belongs to the driver for reading.
         // PANIC:
         // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
         // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
-        if rx <=3D tx {
+        let (first, second) =3D if rx <=3D tx {
             // The area is contiguous.
-            (&data[rx..tx], &[])
+            (io_project!(data, [rx..tx]), io_project!(data, [..0]))
         } else {
             // The area is discontiguous.
-            (&data[rx..], &data[..tx])
-        }
+            (io_project!(data, [rx..]), io_project!(data, [..tx]))
+        };
+
+        // SAFETY:
+        // - We will only access the driver-owned part of the shared memor=
y.
+        // - Per the safety statement of the function, no concurrent acces=
s will be performed.
+        (unsafe { first.as_ref() }, unsafe { second.as_ref() })
     }
=20
     /// Allocates a region on the command queue that is large enough to se=
nd a command of `size`
