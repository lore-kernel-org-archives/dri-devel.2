Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430F0C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E92310E114;
	Tue,  4 Aug 2026 21:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JRFpKZ7y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7748310E0EC;
 Tue,  4 Aug 2026 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785878973; x=1817414973;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=FRFOGBNfSdpwRkONWCP+M7z52a1K95q546he0DNIWzg=;
 b=JRFpKZ7yEYfUE7GUy411tQicNkdQXqp1M57AVaFrebbgKmfYk7Jr+ZTy
 tYkONmESrMsBHu1Oai/Mw86N4HlfwDTSRCerE0p0T4rhaEHToB5si9f0R
 EiHxM9DeRTih5oO3TpJ0pnIAWSjGGmSoDv17bIYeodiNVkjUjzOsRXrag
 WtimS43rZTj7yu2q354+5DmeuPuT/t1zgQ6j+1K8L4x+hcbKNowPXT0vh
 PozshZ3lFtxnNrOord+QLPrUS6+siHv5ljUfHb9akQ7caf677fFB9kPQv
 rUJ2W68goxlFdvbbG3huOVznq0VBH7SPGGsuf3J4NC5CRJdBRTyjU+w0e Q==;
X-CSE-ConnectionGUID: w9FRE4+xSquNT4ll9lw2dQ==
X-CSE-MsgGUID: nS65tzdRQUaOPBE2e25zkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86557453"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; d="scan'208";a="86557453"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:29:32 -0700
X-CSE-ConnectionGUID: wHd4hq3uTW6ToW1RtXBevA==
X-CSE-MsgGUID: HUYxCXczTnutqM5fZWLWmw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 14:29:33 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:29:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 4 Aug 2026 14:29:32 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 14:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaVNjli2bddmiVnoKbSwoYKM6Hi8RrA102HA8chQwIkcCD0b6nSA5rnMW3MQKa+1Vo8O1FgqFAM50UPNVl8t+QwJSc/ONZtI3BT5aTRYvlYhkYopJe+nQ5h9TvJ0YKCJonr0TsvsF/OY/HkMtiYASFPP6wMpJiBsKKHURjjnepV8ovzz+oD3LEMF0+0i4h6zs+2FhWeN+aHDsEJ7NNZQW/eiXLySxP4oHCOj9O91dhCjVp9sNrpXJWcO2l3G1bbDZjdPektkJHWm0GTpk9V24X8mM53oTeuQ+F08bfDuGJpbe8LY8Wp4YpJWtnShRU6ZtUnpM2TdRd4zJpe17TUvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxq9q+UmWkYc3nS4feNhrvlvoM3+fgDmDRtI4kHzyag=;
 b=nE68FQDTyxNXxGf/8WIT0xoAY8GGque8f8PyAPhR8HbpBsTaBJg07y+NLNV3X+rDTjaexyClP3G8JyyoEFzsvhfsnkvpMbazNN51ubKLw8uFVos62yEkWwJNvGOoBJHrcDh55AyxxMMDO0e5XOXnVK+H7FX5DZzhcR/VG10pj6VnOJAT3PZjTTutqlmbPM/JIV2tINZA22PMO4MWNX5YW8P2+DV1UymW1K5IceYDSAjhH1kMC5PnJlXNAwv/9o7kU8AtDWqXzjCKKwuyYZVXAmcZjvrVgosEZAzXhw87BFLftOxD0YVNpKzuB12qAa4hvivjJeSR8fIhnQH/LCNCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH3PR11MB8211.namprd11.prod.outlook.com (2603:10b6:610:15f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:29:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 21:29:30 +0000
Date: Tue, 4 Aug 2026 14:29:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH 0/3] drm/xe: diagnostics and workaround for GuC TLB
 invalidation ack stalls on ARL
Message-ID: <anJZt4PzCE5t49Qg@gsse-cloud1.jf.intel.com>
References: <20260804021441.3054424-1-talesam@gmail.com>
 <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4GYEKniGb8jw-h=QYPi=FpbWRKwHHnfw-K5wYiy6AWfJA@mail.gmail.com>
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH3PR11MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c991bf-a696-4d30-8c9d-08def26f77ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|11063799006|56012099006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: u4CzyM/DJYLa7tEN2YeM8T1wYGlRld58HviLYQgbuA6oIA6x+vD4GHfR62V6iqAyXo5fqodggAa0QxoiIWVBfHXG2pUAZogD3YmxuaSgWH6dGFZnOQP7oWLOHgeMRmh4V16Q97SeKlMjeD+PtzTyL+Su6c3FVCuf63IDHDRp47t2CK9mAg+kfPFp8xCLQJLCEilFlOYh9ErHsiI6y/HOdY33g7JE03x9qw0V0Yo2pF11iZJPCxk7dJRovy1NF0EsZSiq2ayQExZMgJfbFWW7NM6sN1zDsGV1u6bLGENrLQVTkxxHgXK0gJP3uVkuzRA8c8M7H500jRsBGRaBJuytqQP4vFtp8XCXb8jXpc1QFAxVR3M0qRLtXPax0UxPCSp1WknPnt4ujvEtNAU59IccQK1Zjo3ZQWJIac2X1atTkGr4YMkAsWjhFg97qNMxBZtMd+u2oUEpkKUFb3qLNRiu8ChV7MVP5Tw/agj501qZ6AO4jp85lzkkUIJY6ZzcPRvll6KmbFjfxQxKzFGuqiN/MIHawyDX+zavYzWiypotw/hZiHRFKA7nL2q83LytlOB21giHqfL5Cw83dZ8tASorLGUCBq9LVHEJUVQrwP+t6Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?1xPyWAABkGHzCcYqNBvJq8ZDkxQpj5dg+3jJXj4d/BewCa/K0KuW3T7Y49?=
 =?iso-8859-1?Q?PYSxT55KdhnIGpI4/2mMRWZ7kzATa6nb08iWk72V0Uhmo+N8icBJDYNcJR?=
 =?iso-8859-1?Q?8Z9XjZh8XgpiwoKX4gVav5cXF/Q57oLRWat5PQTP/wBWZRdvodbQl5doFI?=
 =?iso-8859-1?Q?mbld77oD4caW/zavhhdO0O7VqNuF5+fG1X+tAzQW3Yq0UwCrRaMLGkKdsi?=
 =?iso-8859-1?Q?KRXgMQVHo3vLQIAsKlUzKc4HvUk6Khre3T0xk0Jz062AkPF6CqINauoiCE?=
 =?iso-8859-1?Q?BNVZfQThgaf+Eiq3GqlIn1RF0+Hx47f0zknSFDuP6uCXzeIiwywDTicULU?=
 =?iso-8859-1?Q?NbLyhU4eeqVBaQVCA2RprIOsAjZQVjL4vjp6fGKjxydkPORERkQqoZrWlG?=
 =?iso-8859-1?Q?NM4Bydsp8MyOERTrp9z6bOCKNCMskTejLlECaV7/tZ2vM/Iq9WRNTNBhnb?=
 =?iso-8859-1?Q?Fb05IjFPKtTQ/laVHOPL84qxtDAQ07bFRoJ29ReaJ+DdIslz1Dcn2C/wl7?=
 =?iso-8859-1?Q?cErkFF2eJbdVTvc6+h0J2gfI39B3kLlqWecMune+d4QdCn9pfrXZaJlJHp?=
 =?iso-8859-1?Q?5mPuCk3HAI2y85e8/ZPYv+02wi6u8DyMy+rfp3v6UxYY9WWDLpsnrOw3P6?=
 =?iso-8859-1?Q?Gm0GPXg4sKThZqeOh6eyZtIO15WSrlicFsVxLp2U0b8yJ+QDk8Lybutrkx?=
 =?iso-8859-1?Q?tApWn/rZDaKeHzBqua2zvZrqJBbrRO8WAXdO3FWsI8tlLASPAZhFbJCwLp?=
 =?iso-8859-1?Q?b7iKmU9FZhHngoHpxbDMUjXOiiFbtlAr696h9ySOXveY5V34FM+LeZ8b4+?=
 =?iso-8859-1?Q?R9/mkh6YJgyMuk7IIfvqv83BMZWpo36PLgniVNy+kBI3bP2wfCWVYivHXg?=
 =?iso-8859-1?Q?YVCS8p5tVCymRKD4xtQkLs65rBxyPq/31p3BKU7s5oGRY0fGCuaHjf3l0p?=
 =?iso-8859-1?Q?VOvpAxcsUnE2/LRE/ldZCdph3sy/skUPvP90u6nk9eh4vt4sOL4cmNMTUo?=
 =?iso-8859-1?Q?Ef8pkPZ7QR4aCUAgI57CQNuxyi2TpHSfltkaUbHM7erpj56aQk2nGOMtKj?=
 =?iso-8859-1?Q?QrhGEAOACl7YxoXYpXMDFB2y7J4uenr6RGfoSutGVPFwMqjJDYmLVr03TL?=
 =?iso-8859-1?Q?NuXiBX6IWnTaSKRFlAsi+/j5uEqaa6fFlMipDHiyfdEejgXOX46+NRjwVe?=
 =?iso-8859-1?Q?9FdmgGogV8A4qbK1G4mX7bRoC106IWVxZSb42+myXGN4neyuH8DRJsteto?=
 =?iso-8859-1?Q?XMfNoz8K9t4E+RCbIIc++o2+v5Wba0M5sZHa8CxXHKvtVTbPrW9LFQEQDH?=
 =?iso-8859-1?Q?by3pV5/zdqrWMVAVxXhHnycx/JIurvSyjnm+i+6II9nn8baWXCGp7rD989?=
 =?iso-8859-1?Q?Pa4wJbjHsyG7NfU7TTNM/XKnYifgenIIoMmdUhgVs4hOalO38oGmLvqLie?=
 =?iso-8859-1?Q?S5zb9E290d7U5Yx9kO+5M0yV/ejp32UVtM7bRkcpK2lR0BfvL45Y5cyuud?=
 =?iso-8859-1?Q?+hWbj5JIXgF4ogxlPYET638hKIiI1nPmku8ZIEdINsse9iE0PVDGOA50rt?=
 =?iso-8859-1?Q?xfnTpGqdTMq5IY01X+VDhd0mOXwVMgpsZaG5v08isPhxPFnQqhC2/g/zKV?=
 =?iso-8859-1?Q?OuxjygiZvrw9RVa0U7cTT+/eSdciW+sM8gth6eqN+HPgv8Gs4sN07mOSkq?=
 =?iso-8859-1?Q?nD/z/3sLUtlkpqbV/njkL57c2nz1N5xFp6Aa9q3G9UWuVU8tMToURNa51y?=
 =?iso-8859-1?Q?1cQuuNGA7CSOS34rEq+CRWkk2Yw9i3mOH3saOxR/qqEaf5xcnBalW8p9du?=
 =?iso-8859-1?Q?dMKbPWwp7Cv8rFM1Vgvnarl2oyGJWNM=3D?=
X-Exchange-RoutingPolicyChecked: aY914ZuUaDdiogiswJpfH+dDwHngfOWIUov+cjGCL1yR2yAhKb5lIeeQtoaKVCKOUEHL3twgCXoVgJBUY+b4dSrLfAHwaW/WJ8Ck6Sr3nrd7b9f9VIb8sqfbuGb74xLy/hYvfEsCSgYXmjpGLRHfrPdIm6X2Kdnz+xTYRTYwwzWVjUA/wt6+YqlAuVx9HAATANp3OzOHu/02bpWj+yE8LMytL5U/5O17veO1bKFNuXYdmXENwM4UCyWHwnikOA5GRB3VT1fdVTjW2dQRhBwXuXV9Dr2Dqpmxz4FQO59T97oBgD7gJi6x9uKqjQvl2EXTSw6iJd5kthGOxu88My0Zqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c991bf-a696-4d30-8c9d-08def26f77ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:29:29.9409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0OKMLWqDFSSNNZmvC1XiHjQvz6zVjhDb7u0SSIyWEBNUJX5/9Qsqu8uqdE+udy5a905t5aiWhpXPGWQyy2OCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8211
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

On Tue, Aug 04, 2026 at 01:34:19PM -0300, Tales A. Mendonça wrote:
> Patchwork reports my address is not on the CI allowlist, so CI was not
> triggered for this series:
> 
>     Series author address 'talesam@gmail.com' is not on the allowlist,
> which prevents CI from being automatically triggered.
> 
>   Could one of the project owners click 'retest' on the series (and/or
> add me to the allowlist)? Series URL:
> 
>     https://patchwork.freedesktop.org/series/171539/
> 

We'd have to resend this ourselves. I can do this, but I've requested
for you to be on our allow list as well. I'll ping here once that goes
through.

Matt 

>   Thanks!
>   Tales
> 
> 
> Em seg., 3 de ago. de 2026 às 23:14, Tales A. Mendonça
> <talesam@gmail.com> escreveu:
> >
> > Hi,
> >
> > This series is a follow-up to the TLB invalidation ack stall I have
> > been debugging on ARL, tracked in:
> >
> >   https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> >
> > Summary of the issue: with GuC 70.53.0 on ARL (reproduced on 7d51 and
> > 7dd1 machines here, plus an independent Arc Pro 130T report on the
> > issue above), TLB invalidation acks intermittently stall for ~2.3s.
> > The H2G request is consumed from the CTB immediately and the G2H CTB
> > is empty the whole time - the firmware simply does not send the ack
> > until much later. The fence timeout fires at 2.25s and the ack lands
> > tens of ms after it. Userspace blocked on the invalidation (compositor
> > buffer unmaps etc.) hitches for the full window.
> >
> > Patch 1 adds xe_devcoredump_gt() so this kind of hang - which has no
> > exec queue or job to blame - leaves a devcoredump with the GuC log and
> > CT state behind (Matt suggested capturing devcoredumps when we
> > discussed the issue; devcoredumps from both machines are attached to
> > the issue above).
> >
> > Patch 2 logs when the ack for a timed out invalidation finally
> > arrives. This is what established that the acks are late rather than
> > lost.
> >
> > Patch 3 is the RFC part: a delayed work that pokes the GuC (status
> > register read, CT flush, doorbell ring) every 250ms while an ack is
> > overdue. On my machines this converts the guaranteed 2.3s stall into a
> > sub-500ms hiccup for the majority of occurrences; a minority of severe
> > episodes ignore 8-9 consecutive doorbells, which points at the GuC
> > firmware being internally blocked for the whole window. Full data on
> > the issue. I am happy to rework the approach (different delay,
> > tying it to the G2H handler, dropping the status read, etc.) - mainly
> > I would like the firmware side investigated, since no host-side poke
> > can fix the severe cases.
> >
> > Based on drm-tip. Tested for several days on both ARL machines under
> > desktop and VM-heavy workloads.
> >
> > Thanks,
> > Tales
> >
> > Tales A. Mendonça (3):
> >   drm/xe: Capture devcoredump on TLB invalidation timeout
> >   drm/xe: Log when a timed out TLB invalidation ack finally arrives
> >   drm/xe: Kick GuC while TLB invalidation acks are overdue
> >
> >  drivers/gpu/drm/xe/xe_devcoredump.c     |  68 ++++++++++++
> >  drivers/gpu/drm/xe/xe_devcoredump.h     |   6 ++
> >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 131 +++++++++++++++++++++++-
> >  drivers/gpu/drm/xe/xe_tlb_inval_types.h |  42 ++++++++
> >  4 files changed, 243 insertions(+), 4 deletions(-)
> >
> > --
> > 2.55.0
> >
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
