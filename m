Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC271099B3F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE1D10E128;
	Fri, 20 Mar 2026 21:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="kGdQD6Oj";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021085.outbound.protection.outlook.com [52.101.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFBA10EB55;
 Fri, 20 Mar 2026 21:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ap+iCRuQep/AGnGR6ujndBVBBNZVJIzfRgBPTxKkBvdZE+fk0dpGA3JqgffC9PKyNNu2MKz228RF7TKQMwdxw1qiRFR1SWJmF6bgTHKYscbQhQNVzNpjFplDYxHo6GckUivSa88vqz2qQ2i3PEqpcYtMWnBxjvMJ3Jcf28ABKkbR/3mSIpyC9FtFOoGwujilYdQNIiAx+ItISG484MyUVif0TDFFcOr59X5YDNloQ9gEzVz7MRdpD9gv+AZPc3hk7oZKcMl+r+eZpd2/4+ZQY5Uiz4WIQ2+jLzxx0XLbURjQubeKbstMrhUwqqf1pawp9IDsKDpjIVW2hwD+WsydEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D2SFJWpwnnEjyZvegLxO2rA0kAuE73sv2xVkfaBstk=;
 b=XVNMGtIbyxYrxHbbBZcfl0nu6PblC2BMZ1x73IlywR0K7HFvF1lN2CE6xDgX4+ZWBavU2W+gYAha/DMi7RQPEd4Nj601qY2bFZSNCNxG5ez0EB2sCXjNoovdkN3qi8mE8wALnajl0WFMcHmZyw/EKm9DSvM7weQLjngrS+ezsBwI5gZmuQkXRRV9kreA7RRH13pQcMewE+21GyUzO1NfthazE9bu6KyUo5yM1X9GXKSORPcRtNLgYfgzdTSOEYMLPoFybx9qFH6qkX9cB2zykhnuTIqKu1ULxzIX9RTo6fdi/bL0ab+a4e9v9063HhwNft72CnaVqJOpGN9ywVuyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D2SFJWpwnnEjyZvegLxO2rA0kAuE73sv2xVkfaBstk=;
 b=kGdQD6OjEtRV7fvguInYgeSAouj6BugcEpU2h6H5/GOvLg6VxmSboAT7oqmZr/s6KUGoSwz3mb39G7lOeYmgzN3thn0gyKNss9ReVHIYVPZdKpxqnzEAkHAUOGhO8hYzF9m6rupSCWLMa41UP84RVHghdCeIR0WhDlw0oNCj6V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOYP265MB1997.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:111::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:04:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:04:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 21:04:16 +0000
Message-Id: <DH7WXEMZ1LDH.3K27ZGUA6EHY0@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] gpu: nova-core: use Coherent::init to initialize
 GspFwWprMeta
X-Mailer: aerc 0.21.0
References: <20260320194626.36263-1-dakr@kernel.org>
 <20260320194626.36263-7-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-7-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOYP265MB1997:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b700e-7214-4299-fdfa-08de86c43f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: RXzysehoyiZZFi6rxwmWZ0wOrPQB/4FGzFkle/qGg8iD/4KXh76XA5htK4lC70HsMzsSAGZ4v3SP1BmRHA/mYVrzwZPdtJONjl2j/QHW4vfOSZ9bL7Vh8ud49ogrL5FXPO1O5NbNG/0KnU5wFqu1PFUQFvDGPIvOro0tGfzVp9XGW2jfPfMyP7M5CWEJ5rjwOH9xujulW8rxt5G3psYt2vCz24tTCu0rklTckqDMe8nIZBSs71WmMbHGMjJLC5FV3zHjVWJWFUzhrEwfgK1uM/sdeQAvOZ3gY7CeYOYjFJ4eTYs/TUFKswUomerrj/jM+97hsS+B6xlnrTqcPks1H45AA3tQqGJFdw3qoU0/aNRmJiRn0heUalWHcGAcQxvG9qlKQ1+MDnYl52Kp23RWLtmlKlQlVC4ZhttzMMsu10TDtzoAKRfww0GIikeQPGOnxZjObdlwpbPiA+RKHiuZyY1WsEGLGmw5+71YvduyJ4qnfeO094JIRayUG/oXOL/svM+ZNAPhN0rf3Lt533+PlFNe0/opOIb7dv6QgizG1kMt7INK6cAKcyvZhMRcF1r/YQf/IurpKFLgxHDr+wKeuBXTo2Ct4Cv987PZrS6zaB6ApEcFE8zLWCf0DQwYC4VPnu/+cVroKlXJMeXznAxfmr8kFf7rtOSbnZ+KnVJ94uOIFqAYcgDeRnQXe2ZF0ftY65xmBri+jjg29SDIKiDXjcZm5iDh7jbtsYPk7RSxFCbejcWEBOP1+T6fztB5iPnIxbbHSpt3hikBunbLXO+JLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xMZ1BndE05bjF2bWhBSnUweWp6NjdFS2RmYWQyU2JvOGttcGtIczZka0to?=
 =?utf-8?B?MzY5VzMxUkJqbCt6a2k4U2crTjNVc2hiWlkybTZVc29HNnI4My83NDVMcng5?=
 =?utf-8?B?R09SNGp1TmNvRW1DVXI2NkRzdzkyV0tBcG9XS09YY2plZ1QzTDExOEJCd240?=
 =?utf-8?B?ZE1JWGl2WVRIVUtSNTltNG90NjhXZmJkV3V6Vk9qSUp4WjlKeTQyUUg4c0hF?=
 =?utf-8?B?QVBWdTZsOElEQ3RZVDZNUFV1YUZrTkFnRXVqNk4xTmk3a1dwbG8zWjZPRmtW?=
 =?utf-8?B?RmVpQndycTNzblg4L2pFdVlSSE02VXc1V0JpODdsQ3dqNkdsMjhWOHE0cEhZ?=
 =?utf-8?B?RFR1RjFSSU55QzlibGVFMTZ1dCtnZzBCSTdTUG05ZGJrK2JBazMrSWZlZ1pT?=
 =?utf-8?B?bmVVQ0NQNXdDQkF3NHJLU1JiWE9ZS0lEME9WRmlkQ29rWndYS1N2YStlRENm?=
 =?utf-8?B?cjRqZzRwQ3pmVmUwM0d0dGJSalBLMjQvV0dlM05ydmFxQ2dTSG9tcGYxc0pL?=
 =?utf-8?B?c0M3QjhiNHJPZjlwWnlKWVNMeit6YWFwenZZMHY3ZktHSzlnZ3JrdGtwbml6?=
 =?utf-8?B?SXFaUXlUL0hHd1EwaTdnWTBheDJxWlpvSlVLMGNPbmhBMGRva3RFV0dLSnBZ?=
 =?utf-8?B?OCtFVUxWYWtkNXpIRUQvM052TC9rTTc5U2hHVlF4MUxDVENSSjlmdkVWanBq?=
 =?utf-8?B?K1JHM3NuNzhuVGFuVUpQUkNNWk1YSDFUQzcvQ3ZvRVhKZE5xUmdVNlV0OE9h?=
 =?utf-8?B?YlpERXg3VnRxaHgxOW9BcjFVZGJ5SDlPeEtyU2xhay84Y2RSNkRGcnBDMm8y?=
 =?utf-8?B?NFp3bkw5dnRCSGNnTU9JOXhxcjZFOGxIWk9zSEJPbEovRG8ybXB3WUxzK1dz?=
 =?utf-8?B?eEx1S0FaaWhsSmFTaHlSMUQ2cGxIS3NYVjhHUWJHU1IrOTB6NFlNVjErRU9L?=
 =?utf-8?B?YTJGdjcwaUpzUTY3RzlNOHlYdFhzK1kwUk9NVXRMZmxxcXB5VDhBWlRIQWI2?=
 =?utf-8?B?WG9XYm1la3JGTWFuMXdSaU8rcmx5TlVrT1N3WFhERXpuWGFBV1FYbENENVVo?=
 =?utf-8?B?dk5QcXZ5WFdYVGJjUGhMd040ek1nK2IzWkQ3SlFRSGVuZlZOd3gzd09nU0du?=
 =?utf-8?B?RXlPR0VwTEwrQlFhZ1YyZ0xtYlAyNnZERGh5Q1hYOW0xWHVvdU5Ic2ZETyta?=
 =?utf-8?B?MWdMUkVTQWtFaVdTaFp6c0UxVzhYdlhIYjIxZkVvUXV4enlJMndUTFFQb1V2?=
 =?utf-8?B?bFRlcjBnMzlNRVRRTTdRU2NUTFl3TmFGbEI4MEZTNGpEa2ZsbEhzRHNDYUl3?=
 =?utf-8?B?Y2dtRUU3YWRSc1k1Q0IzOVZJT0pta1FnYUFEUWlHaWdmOVVQalBNWWV0Y2dE?=
 =?utf-8?B?SU9HUXMrVUpDaTRKdXllbVkrNTZkVVhQbnl2UW1LVHU0R2R0TjVQUU5aM0ZB?=
 =?utf-8?B?cmZIcUl6ajk4dElwa1VUQjcyQzdwU0dQbkN4NzVoZGdCSWZ0NkhrL0x6NFdx?=
 =?utf-8?B?eGxhSUtLMDFwTk1CNTF1akVVNUVYSkJDRjBOMnV3b256WWFWellKcklCNSt1?=
 =?utf-8?B?NFBDOHBibDBXNXBDL1o0UHYwdlpla0hLcnpKTjJyUXJIOTBvVjJBckFncjRB?=
 =?utf-8?B?aWhCWTMvektuN1ZRUEVKQ1daZXFXaEc2NnZIT056MWdKd0xUcHd0V2pmU2dS?=
 =?utf-8?B?RXZLbEpxZDNDOTBvM0h5UGVibEU1ejdDRmhKN3hBQVBTa3IwT3luUjNueFV2?=
 =?utf-8?B?M3NIbVFrS0lHSnFKU2syU0IwRklqODM3dFhzZGNNNUJKdlhsYko4S0NhdWtj?=
 =?utf-8?B?b0cwNjZtWUxRTGs1MlFVVmJrOGxTeklXaE12Skt6MkM1L0RBdloyUUFzSmVi?=
 =?utf-8?B?SWpwL0toUnlGR3dMSERIWGl0ZmpSOWFRWmZyVzR0NTFlVUw1VytLSDcwTGxM?=
 =?utf-8?B?TjRPbkt0bDY4M0R0bEtIT2ZPdXFDVGdvSnZSbU83RFMzRE5mclZQdngxdVFR?=
 =?utf-8?B?T2VzS2FOYlN6ZHJkVkFPUnF2VFFQODM4QTVYUW9iRElhWUF3WlBpWHNacG9U?=
 =?utf-8?B?ZGovK012TUxrbkZ6L29JT0JDa2dlRW9nOTFOUmJ2WlI5WmxtalkyRzgxUFZw?=
 =?utf-8?B?eUFZR3FPSXlzSUFpR0t6WTk4MGZ5UWVBeEw1V0FSR01GenZKYmNJSWNIMTRs?=
 =?utf-8?B?ZXNTZVVBdnNqdE9XMUdiMWJBVEI3TTBwdzBLR2t1bzVGSW91NmE0RWQxNS9D?=
 =?utf-8?B?enBHeEtHdm02c3hWb0FEb1kvT3BaVmdqNEM4OFVLd0wzQ3VNNkIrUmtqWklp?=
 =?utf-8?B?dEx6QjNDWWw4RFNRRmg5MkxsQkgzMnhKYllJT29Mcm54dmRJMzVQUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b700e-7214-4299-fdfa-08de86c43f80
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:04:17.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuQm8AAYGHMX2qVLA4Clwfh/Qjf7dGOf7iiiBuQ9hA/EoH99DT2nqkM3ECyTNXpf8MSiFUixgK9tdR2Zdi1J2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1997
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

On Fri Mar 20, 2026 at 7:45 PM GMT, Danilo Krummrich wrote:
> Convert wpr_meta to use Coherent::init() and simplify the
> initialization.  It also avoids a separate initialization of
> GspFwWprMeta on the stack.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/gsp/boot.rs |  7 ++-----
>  drivers/gpu/nova-core/gsp/fw.rs   | 20 +++++++++++++++-----
>  2 files changed, 17 insertions(+), 10 deletions(-)

