Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5127DCD3423
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADC3610E29F;
	Sat,  2 May 2026 15:42:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3FyUufa";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE3810E29F
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEN84tOtGby1WB4F0ZLs47s6HILyXdaTeeHCpYxrVRXJ1RMwk1PNthE5gnVs5ec4a9/l5hI0LDop58IQ61WGzT3TIngid6DOnUkzgRjrBP9dkQ4rleBbrd9a0RHpxRg8ZyEl7mctrUPtpUl65jBxBZAx6lRHKta/Dj4ftUB1Rk1gGCnN8EVXBJNkFM/JcGmkZBgUsyH17i4sGKn8HDsWcHPOrAzIOkQCr994TBekB0iYBFvay9JtQzdKipMe4bo1opw6nHywjugOTr03nCLEhlXxVpwurcvwtDenbYkitSNYq2N+5JfJ6SNM6ZbFZfnC+FTqSp0v06J7mdLba3Xrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxEGrkzd41Hf9omxIdwoAc30plGgJyBJC7y3xF1nKpM=;
 b=WdjEBwXYFj+mxm/4057vfQVXNN32dPprx+3wh/qXXCjwLBprbd3RB+Uw3tiBvf4M9lH1CGtdj93Rf4aoG2heiy+x7bhyJaFOAvZcMKbXG6YjC81/LmwpA+yC1vpjgjb8GibK3KFzTmuhaPVVRpdKPmFV2fZX+LIs/0FstejZvrXfJMsRAlnOh/96HXyffUSt4/IkEiIkj3orYp7YIi9FyTzjVi0MMAw1ExyqiVrVY1HQqON/1tgfK+k+6CvpaQ2MerhdSJ6BMP6TPL+OHa9nIY9BLta+OSq0cMYjNU6qOREUINmbx/hAYW7dK7KyeWvJfTqENghYksWVYSZihMGe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxEGrkzd41Hf9omxIdwoAc30plGgJyBJC7y3xF1nKpM=;
 b=J3FyUufaiZFrLVIhH7kuTtulnT+Sb9DDLWLIxnSYRmk9SV6KIO0eqSQg/eNp/skdVRmwZrXwL5bfVzExF/8jNc3oZEY4/4Iw81q7s/ENrLJmltx1pEjZ56FUUhx3q4gQHucn4lmxQWC31U0E5pcpsCZp7oHPlj5QXBvxCAZWqAP3l41N6zGCqmAW9vtcH5itj9hTK6JzhgkR03I0os7kKfZMEoTmqLYL0P+RRO3AdI1ADsTJFAWxvoez3G+8RAG2KpzzZXEMpW9r4mnstWjasy8Q19B1jWtpw9Bjyu77ZK3n2RQ4qpAapZREsTlzE07SzbJRleujm2LFvJ+bja2/aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:45 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:41 +0900
Message-Id: <DI8B0M0QY3XW.4641TH1BU4YF@nvidia.com>
Subject: Re: [PATCH v12 20/22] gpu: nova-core: mm: Add PRAMIN aperture
 self-tests
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-21-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-21-joelagnelf@nvidia.com>
X-ClientProxiedBy: OS0PR01CA0066.jpnprd01.prod.outlook.com
 (2603:1096:604:99::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8738cb8c-6507-4652-6bde-08dea8617493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4mD4FKtrcAalUWj94dQiQencsgDUwzblIggbBd8+irfQcbjqwbSoBBzOHm2O01FqWjoIv2uZZJvb3hU4W0hw+0ZhCK2wpEm7d11H/ta+32xPMKyNtpHBnPIshhpo+hDb4EKB2RWL9ZR71X1rRJ5e9l6bWla5Zy3hLVyZKmwj3AvFWePwHJzMzp/XaU2Xi3lWVXAyGEh+nLAb7OPP9l5qxJDTn+cMweFdaDvEWiJIzBciWmRF8yB4PKXMACMCaDN9y1qtSFjEkNw4UGQKJbAI1+XFdf8H/YD9zMnkbADMxCs3uq03ihkM5UIQPAQdJgRDdLVz7F85jNILiGUeWzrpBzYLkVb8Z+8Qd4yaOnqwwQ8N/vI21WxOKdRrutMCm2d71NxHK9lvPLlvbZsrZ2c1zJ10GeaMOdbI+6V/3VQC3NdQpd+oDoDEeiaH7xKbLT5rLYav6uvBy8bUOLrNyly2XnjtisO8YjxChLNnT7oSMaxDVjN4cVpgBhyJ0U8R8Kq1YheHTGG5m+Q94zRUL5G80OgJ5aVZlS/GvMjnMlCUB+q9K//UQBLleO+d5YveDCkPzhKcz5vEzefLOZ+leew9yPwdNcRIHZsC/rY0VCMTEsF2ktOmm+GgKKJD6kGmfVhat81i3VsSDxtNtO8USyof+EN6Jq8nHy8wf3erYrbbiykuPFvE+iQ6MAhnJYe4NK1B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHlpRG9GcVRDYmpyL3I4UldRbGJFNTdmc3M0ODUzaWFoKzdBU0pZc1ovQ3k3?=
 =?utf-8?B?Wk1jZEFoNnVlNTZ2S0ZCWUJaU0hUeGNwL2g2YXdNVGR2UWdkVnFYMTl4cTZB?=
 =?utf-8?B?OTFFSFdGSUhaZVBTdEFXRXFQQlVpOFZrSW5MdUpqcHdIdXFIQ3hKNE5acksr?=
 =?utf-8?B?VC9XU2J0YnUyMllKMlhWc3d3c0EvMWZidmNneTlieVM2TkFNUUcvWlNYZmc1?=
 =?utf-8?B?aGxzM0pLSVA5ZzFSV2hVZEdTQ3dvTW1nallVWUNpQ2M2M2N6MGcwZUltbEFX?=
 =?utf-8?B?SGpxQkdQdzFiZzFzTFQ1enpZME1NYVg1T2hNL1ppMEVFbW1tYm4yQ3ZOeGJP?=
 =?utf-8?B?UUJRa2ZvYm5CbXFiS1dMNThpWUpCbU1tdUQyWnFEQXZ4SUkrT1lDTUdEbWg3?=
 =?utf-8?B?UmFOdDl1NUlTUnAwYVZXenAzeGozSDIvRWhWMDJxZmg2Z2dlYkplY1NrTmp4?=
 =?utf-8?B?bGNNQWgwb1VBZUF3Wkx1UWsxYlNvVVRVd1ZKSStrb0pud3lYOEN3cVZiemFv?=
 =?utf-8?B?Q3BwMFBtc1FPRllTRk5BaUkwSEZDMmpOSFlGNDVlMGRWcEhGTTk3M1A1K2M5?=
 =?utf-8?B?eEJ2SVpFOTU2UVUvODVYQnFJSXJPa0VIUmFucFh3eXlkTkcvOUZENmh3RVU5?=
 =?utf-8?B?Q2hpRTBBM2swUWdpQVJ0UzJQaDR5SkJSQkVVTkVPR3FCS1F3RmZwaG1ySGQz?=
 =?utf-8?B?SzBlSFRPNFY3OEkvRHpFUXhJdXpReGFENFJ6Ym1HYzl5Wi9kcFV0emhPRGtj?=
 =?utf-8?B?czZZTFU3S2daeExsWU5kbmNhL21xMTVFWGRUdEVZZkIxeENRS0crckpCZ1ow?=
 =?utf-8?B?MzBzMEUwR1VRc0h5QkI2aTJxd2RVQWVyQUp1ejdpSTZmWnpoN0JnaUkxbzcw?=
 =?utf-8?B?Q2dKWHZoV2NNNGF1UDVkU1JMMGI2NFRnbWtwSUFhemtSalJxSzVLb3V0YWNF?=
 =?utf-8?B?M0NtTTNHQUVxbFJQSzlPM3NxRG9SS2JhSjFEYlhwN1dMOCtxdlc1b2lXdVh1?=
 =?utf-8?B?b3ZIcitpelljbkczSVZndklZQ0NoWFMxaHJxZGRFTTBqQnJzRDBlTU1XVlpH?=
 =?utf-8?B?Yzcra2h2RGhpMkJwY0ZnVXE5cXpjVSttMzhWUWdsNmg0NDFqWFNCVlBZYS9y?=
 =?utf-8?B?TCtJQ3pOb3lWbFNxTW95dm13dzNLZ2NXdC9YZjN0ditVMkR6WFU4UWxKSlEr?=
 =?utf-8?B?djV1MlZ4NE9PaGJOSVRpdnBRdjZDb2h1MDJQbGlFdFM5em9RaW1JdzJ1VTQ2?=
 =?utf-8?B?RXZ6ZHNDc0hhZk1wVVZPNTdrSkJRQ0Nlb1pocmhkZnNIY3Z1cUFBa2xqaTdC?=
 =?utf-8?B?WTl1Ymd1aGp4RklUZm1YS2kvd3doT2NYT1FORGhMT0dMZDZscjNEcEJFMTFI?=
 =?utf-8?B?NmR2TFBjM3l3dDdlSXFLekVpdUMyenRPZ1V5QjBValh5M0xoc054T0RLL1Vn?=
 =?utf-8?B?TllqQUpsMElBMnF2SnhqYVBNSUFBaGYwanBnZ2pGOXhmS3RHTXFHbUN1MEVM?=
 =?utf-8?B?VU4wVDU0R1lyMitDRWVkZGJ5SlFYNUFIQnVsaU8rRGtMM0JIZFJtRW1NL1NQ?=
 =?utf-8?B?MVNPUXFnN2NIZXNZblNBUXllNWpQakh1V1VLNksxUmttTG0vd0VPdnlyQThE?=
 =?utf-8?B?OTFkZGltaXNaeVlYbWVrY3BOc1VYVy9XblV6a1U0Ym9TdW92NmJ2MFVVMnNU?=
 =?utf-8?B?QVRJdDVqa0luSlcwWlpHWGY4eHh1WW45RERzMkozMzU5THRVV2QxcGY3cjVt?=
 =?utf-8?B?dlZmbWxneTJXMzJ3ZkhmMFNCWUhPRmVSNlRLRHZEdEpETFIzTUtROXl6ZnNH?=
 =?utf-8?B?TXVyVzUvdFFuU2FFc2hWMmVqZkdCVjRVazV6M1oxRG5TVW0rVVZ3Y1B3bTMr?=
 =?utf-8?B?UnBmVWFrQUd4U1QrRzd1UjhmRzFXWDlHK0d6bjNjeVc1MExGVytKcm4rT1BO?=
 =?utf-8?B?UUMrQzR0N2JmVWJQTHgyVlVncmhNL0EvdWRLSDk3bTRHY3psQVN4eVEzd2R1?=
 =?utf-8?B?R2NBK0xHRWJqWmdQb2VUSU5QNEQxSWI5QmJGV3ZwSnlCR1VVY3ROZ2Z6RGFV?=
 =?utf-8?B?L2QyelkzS2tqeTBycUFEVUh1L2pKTmdDUkR4a2M0anNBdG1ncDJxZXhFWHBp?=
 =?utf-8?B?YS9WSHpaUnRTTlZBOUUyN2NEbjJsODZuNFJFdktaclRYM21KUk1pdDZYbjRI?=
 =?utf-8?B?Tk0rZWlHcXd0VFB4UmJ6SlJkL3hReTBtV0o1QjcwWWE0TDNYWkY1YVRaZUE0?=
 =?utf-8?B?VXlkZTNyYWRGTEFGVjZYNzAyTmRpOStlV0c4OHYyTUJiOUcrUzBIR2djUkZ0?=
 =?utf-8?B?MDRNMkk3UEo1Q3JkUHdRTGxQY0JRVHZOUTl4UzdxQWRVcldCQVY5OEpxWXdD?=
 =?utf-8?Q?t9WQRk01EUqIE7+om1tMoKReDaWoD+R+TqEWZBf+lkK6N?=
X-MS-Exchange-AntiSpam-MessageData-1: wrz7J44Nq34GIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8738cb8c-6507-4652-6bde-08dea8617493
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:45.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+uXUNTKdhgMQN87ATV4Dk18UTkgI7rg8B51XtLvyXNYt3XDwmXyW1xyRkcNPfr5h66KWM/iMkltQmQYcNF9Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> Add self-tests for the PRAMIN aperture mechanism to verify correct
> operation during GPU probe. The tests validate various alignment
> requirements and corner cases.
>
> The tests are default disabled and behind CONFIG_NOVA_MM_SELFTESTS.
> When enabled, tests run after GSP boot during probe.

It makes sense for the PRAMIN self-test to be merged alongside PRAMIN
support (and also gives us a reason to merge PRAMIN as soon as it is
ready even if the rest of the series is still under review, as it
exercises the code).

Can you move this patch right after patch 4?
