Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7385CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 20:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95C510E032;
	Fri, 22 May 2026 20:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i0n86bgj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD1F10E032;
 Fri, 22 May 2026 20:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779482662; x=1811018662;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=TSTcX8cekkPnOwE9ObhI4cOVAvaI1zyVezSm+7Md6cc=;
 b=i0n86bgj9DFwrJWCMlxiVVvJDtK0FItzPOz+S2zFD6kR02MnzdmJOML5
 5tvvE35mSpCStJD8Pb9LBquVGVrqQvr6oXI6QRMdr380odf0c1+SGMVTm
 Y8LxEDi4ciX0e6nRJcagRuSjGzK2ahvKr68iHhN4yXoKn/bwTnWosoIgH
 etX1SMibm/cBqcWSSOeJ+ybs5MQjYlk4LL/WpbfvWw8Aca+JgKl0mzHDM
 a21FXVjIYIpKiiDuvQqkvRkFNLSHNR0220jHMfPjreDNq6R74tovnJdaY
 NAVYeGW/7fJ0xQcMUCllME4QwSiDOqXDMcDDzFHlVUNfE5TPLivnhuQNy w==;
X-CSE-ConnectionGUID: a/7rzCSeQLCeZety5AqNzA==
X-CSE-MsgGUID: AnvRARcbRKmLBmzwwRzhiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="84301931"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="84301931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 13:44:19 -0700
X-CSE-ConnectionGUID: D2Ukmh/1Seys9l6C39/Z3g==
X-CSE-MsgGUID: qiGNgflbT0OU4GkHIqyL3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="245048533"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 13:44:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 13:44:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 13:44:15 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 13:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIAgajDs1E+rKgSQq0GYGcl6SiiQF9Jl0spy3JwFv9JaGSyvyTdSZFdM2GjDvkSutdf9m/NhKrPPXq6MLSWQXJo3DZYhJ2tco51ML4GWl7OS/n/2fvP/q44v2xX96BdOoA/tAmuOjIFX4xwJOws1o/NxNZGRIk1blYIjY4fnAC0aM03Ryt461MgRP0voqfB3Y6T0S9dtlkTDzEc+h/Y+RSfFEf1rUvWrkSB68f9bDAyjt2B8wuUWU2v4pXyKzyXD3vDlNeitNCi0z5AgBE6Ya/ExylOCUq3U70hcXLaN9UtO1BRq/nTBxTXHon3I7e0mghjRKg7NW+w0fB1hSJkOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWO3kJJKOFM49ADThxN8Wjop5vJw0EdS8nEaAJeASro=;
 b=FHOkpfUPfUHcjthWFWCycI1EY/6DLC6pvlUqAMoXTzFA55xRkrkd6lbfHbLKst9c3M48kCnLKxrwDOPIfLZPS2EbIEr5w71uGkg0K1hAKJuYIZsub9+6X1zVtIKww1b08d7ivtIzObe0n9qmR6rLiyzEUijACYwuizmw1zC2Lc5l8BhEPBgUb0Z3pO5UeHL2W6iEkxU+8P1FdwsYa5vw4cfR5Nq6iP5vJHNR9LHEIwTnVrIRfpo55m/qpZsZembFu3RZNfDuJDNpWicf5Hx3+q5f1SbK+mDtdrdRZ7+P1JPRwmDuYayJV446oi4pqxHi7594KLXIotamwCladWN46g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by DM4PR11MB6478.namprd11.prod.outlook.com (2603:10b6:8:89::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 20:44:07 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 20:44:06 +0000
Date: Fri, 22 May 2026 16:44:02 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Maarten Lankhorst <dev@lankhorst.se>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <intel-xe@lists.freedesktop.org>, dri-devel
 <dri-devel@lists.freedesktop.org>
Subject: Re: drm: xe: Kernel-submitted job timed out
Message-ID: <ahDAErDSE-SFA0oM@intel.com>
References: <CAHk-=whiv=b+dAvjaZDsZkfUEzjZMSSLExDOWVcbJ0exsCj6_Q@mail.gmail.com>
 <6874536d-ab1a-4dd7-a23f-2a071bda145e@lankhorst.se>
 <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5aE1yVMb8RM2AuNUHSMnQDaGT+Vy+At5ds1vxBA+Kng@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|DM4PR11MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a92f03-b337-4231-1313-08deb842ddf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: pBJISTwa/Ww3/wOg6oYvgSjYat4urn2NLBqukdaFpCm7MuLcIHC7mtx6/HMSp0Q+sIyIoX2sOd9kwM2HDDTCjskABtqM6xJLuAupnpMu4t1tT1Z/t4Lj/4rlYRCOrn3yR40BCROEMhUaf0nC9AJYyNqwcsrriQsXyFzI4BzqZNwRFSvpYRGpx6K3l5u9Eht58b6aIgveO94iPLP203oBrz0gIQtVPqg0F5eY6OBl3Pq06JlKc0xzlT4gMeqlIz06g5fFD9GN4wk5fsQJOtLTxAg8Pd0J77qKcgDRMPJ1juXGVq/n/B1h1YLyHb06KMKCklZZiYWd76jp11Ngp+f7s5E9RGIRIUR7Q5cizUMqdP2TW8c3DiYaYNIy3t7W+LnmEJSkxUXybAQRvYxebIXvcKpWuFRkDNhYNGSwaD/ngml5Kjv0IRX5Ox+9SkXkUNBJA/AqEq7xNc7CUdPYihY6E3Ylhe5OXMTywPZYmHastm1hVc5hlvu85Wg8TQpI/9+GvTJUI4RlY0XsdAayrIqNoXyMBjDaFScZhM8ekvIHHJhImsjZx/l8Bi7NGQvdOygC1z3iwdJSYN31xiq5R2YiBt+S5ofzL6gP0DMkAwjCsgiv3lwnsRO0fsS3oDo65dkoVgLBwoY0n69cGkKj7qJ5BZ0Hf7zWZOli1RKB0+UUKhHvmfaPsODH+bPMvS3lA1Yx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hhIlYJ0X8nM70beI7YsZbDGhuQVEp1L9eWvzjnmHnx7Fx6cma/80992DEr5O?=
 =?us-ascii?Q?liUGnqnNxu5cr9nzPz/Ptj1RhlXSMxuFFM8aFFa6sfxDHCcOcwLdHAqtEFU1?=
 =?us-ascii?Q?FAf5kesWZGNKM3FbaP7aaHsximIkuosb0ZBpSGmqHTlI2NxkCojlxZQDDADg?=
 =?us-ascii?Q?I5dd8EJW6IX0UMNSwvYqDpvoA8PQSJwCu7sRNHOMduX/AOI5tbYq5wsXNmFZ?=
 =?us-ascii?Q?lA1IQO2bLQd+zranIMEnaiDsKr9UwiiQgSnyO4MsLerLaM9YxTWb0P3gAWEo?=
 =?us-ascii?Q?hk6otRcnTjIHGoqyQppq2BRPtpFvMQdxhM5GMiHVvuGXqqEbiy79RMmvskAg?=
 =?us-ascii?Q?TyHTcsfzG/BQ860VG5vhC6eLpJ74FmFWNE2HzkoAR4ZQMZ5A7Xzv/e2E0UHg?=
 =?us-ascii?Q?Vj23YWNeUiDYyjnF0jzOy+YwVG9H4J9xeLVP+5U+BTYXmp6leWvmqQ1T0I+Z?=
 =?us-ascii?Q?meKgfgSNC8rFPLdsFZ79X2mXk83bluWZP5sLrk/ME6TGbrr2bMEuvBttXpnw?=
 =?us-ascii?Q?xq119DyIcyT/gFzGzpivzXxtbAvzCbMG+wBx5rH2ufpTVch/VfipOXfZ08Bq?=
 =?us-ascii?Q?poZ1Xz3AsXgquOq5FxDVQBt3ij4yDfH/FDwapGsmNlivNzgoKOuCoVFci8ex?=
 =?us-ascii?Q?7975YMZ8q9w8kSwzokqWoOz7BijO7ImbqWLI1cqNUpJMlWWR0Nz80aEam4fy?=
 =?us-ascii?Q?b9QafdAWejREY6bHcSZbUGebz2VwyOcaQ9mV29fR1r7yzsOYu0o1npP/DanL?=
 =?us-ascii?Q?UixziFfjeRbOt7FtwVrd/Ft6s20EUVP7VzaBLnex25HI/BtG5rTTfv9fRoNN?=
 =?us-ascii?Q?d3LbM40F1cvZt9IZoCg54YFPT7VxXl0xD1fzcdihCHtH211BiEvtKCDKPHAe?=
 =?us-ascii?Q?whY6q6ddb9eCkbdc5tyh2bSQYYQZk6CTpJ6EDVJpqVTRQ8XG8NDERM9xBOSJ?=
 =?us-ascii?Q?ks9lUd+FgdzX8cMm1PxheRkZ8iwdDpjaJJWEyIHIocU1rwf8l/XfO482MtZ+?=
 =?us-ascii?Q?EH6cwcyhTffYNn10/BUy176d5taie0sLWiJZeJqfN9mdnqC+NA2PsUf3PkIt?=
 =?us-ascii?Q?G/Nt0TBLeZTfNfG7F7BK4yF1aTCwa3MhWTes5scXpz8gDCMF3K2GzRAGzgPC?=
 =?us-ascii?Q?O1gPhamMP9vPKE8SqT0PjRXWpth5fVm44jacfxd01OD3Sl+ARHbi2kn7WEyJ?=
 =?us-ascii?Q?uatzgk5O09zra/N8VeZYjmtQN6QBnC1T/I7hxUNa5NQYGxsoqAWEy6ZVxigk?=
 =?us-ascii?Q?f9++lBDojC1HmmdabuuFOHSE9Xw7k5a/C6AYF250CodVfawr9EX3BfZEJUip?=
 =?us-ascii?Q?uzaTAhJHukUu20e1lpXxvAuJ8aMuZ+NFRNI7eqxRUWhB3tintzffnozJdME+?=
 =?us-ascii?Q?zhptbxiJ+jb8HI6mfCrqUZE3K7pB4I5RoyP+3zicApIjlALV7+fr+w1TDdg7?=
 =?us-ascii?Q?P+KE8nY45jaFmktdkYPwu0RixOPgxcQ60e29ApLNdzGWYtnlUn15t8eR1mWt?=
 =?us-ascii?Q?+8lPAy0AqnJPrAPDGMQzxl79eIOfhisahIILixYpSvu8OeXI5fVZdaCTxVg5?=
 =?us-ascii?Q?DTvI/avgtyNZ4/4YaA9e05iSMTV05s5loKSqZgtE5zEn/WiW7/xinPK35F1I?=
 =?us-ascii?Q?Gz2g/P03XcHeyRA3K4HqYFKs0G39fUrAJfnI7TNH2t7IHpwfdcxY27NvYIip?=
 =?us-ascii?Q?CSeo3KllEsmAvIfOZYR0Ozss9VtpZw+gTOZg1iJ7xkuTpQU9AbdQOSlyjeij?=
 =?us-ascii?Q?BMfidLzLuQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: RJ9JkWQFcoWu2kKgDdZD/jDb72AcBAY90XTvUBcGFJeCrVEWMFjEqq6h9wgMQdmblvueBNrPM+E7kh8c0I12Csgush27OEK/CqevehkEmJKH7Gd+Ec+A3Bu1fsrGbNWLQtXPnKNbqNlqXUoSXarQM+lPoFA8831Syrb1GBXIv0ECJ8/j5OUHGqllRj/I8X6+xW+WgHJVSX8CCzHgjfh/kX1XxJKeHWYWLgeXY12yq4X+fPeCSiCZYuYJ01/wxxL0qf8a/u86rHSeBoA3R1mIv6XjP0eflTSRAFmtx00JMCvGKEjgypLLsTiB1oLJsiCGTrOQ98sWwEtqyp+HAtghyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a92f03-b337-4231-1313-08deb842ddf8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 20:44:06.6666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4YxCSEBAZPgzRW1n79Ju4Iz4PmUMWZKyUp5W3uwKZhd8XAxDDjRpK5ajS/Gg7KwhFp3Uy3b1CknCQ/72baEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6478
X-OriginatorOrg: intel.com
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

On Fri, May 22, 2026 at 12:05:35PM -0700, Linus Torvalds wrote:
> On Fri, 22 May 2026 at 11:55, Maarten Lankhorst <dev@lankhorst.se> wrote:
> >
> > There's a
> > May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Tile0: GT0: Timedout job: seqno=4485322, lrc_seqno=4485322, guc_id=0, flags=0x73 in no process [-1]
> > May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Xe device coredump has been created
> > May 22 11:09:19 3970x kernel: xe 0000:4b:00.0: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
> >
> > Do you have this coredump too?
> 
> Nope. I was assuming it didn't survive the reboot.

It doesn't. In this kind of setup the best way to deal with devcoredump
is to create a udev rule that copies the data file to a persistent place.

> 
> (This machine doesn't allow any remote logins - very much on purpose -
> so when the GPU hangs, it's toast).

Any journal saving the kernel buf log of previous boots? Preferably with
some drm.debug flags enabled 0xf likely

Also:

Any bisect possible in this setup? I imagine it might be painful though...

What was the last drm-fixes pull you got in this 7.1.0-rc3-00073-ga6920214ba75 ?

I believe the quickest path might be to simply drop the xe fixes you might
have recently gotten there while we don't identify the culprit.

Thanks,
Rodrigo.

> 
>                Linus
