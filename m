Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFE3C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70EC10E799;
	Tue,  1 Sep 2026 05:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PtvqgzqM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9A510E6E5
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788241460; x=1819777460;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=WcGYsgM7q0bkFK+yrx3nV5pUwVEzQiNpGYfdod2xO2I=;
 b=PtvqgzqMUoznOafki7wGi2EYRP8QiiND3Ceuu8i7xPcq9IU3/pw9lErK
 D9ZzHNtEHsdrBiFLru7/qO0jHB7j4SW7fiotsDzrLb63AZiXLXxDRyVaD
 bnmrpuR8IuZpRB91koNFi/Ppj2R8/jpKruV1+BGq70s2wWy+T7KxULwyq
 4wVmT7iBQmngJ0vJv2RKLAW1qcQpDgcKR3Bjqi+GX3elAhX4fGqA7dL/I
 m9YAoIxlW8rsglJMDupY+XzsuzaWeWVIon6FFPHU0Wqt+7HhynB8lQLIw
 zikfvjK/DyUep6KUuQYLSvqn3rbGbuoWsX58JjcMo78f50w4qOoV7OHJL A==;
X-CSE-ConnectionGUID: Dl0kVtWXRke9DQLHenMMug==
X-CSE-MsgGUID: MMs+gCBARnWBXFEMaW0+xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="100011897"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="100011897"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 22:44:20 -0700
X-CSE-ConnectionGUID: 5TKI71m6R8SyIzICY9akFA==
X-CSE-MsgGUID: qph2fs0tSI+1FGud/GI1hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="298886624"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 22:44:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 22:44:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 22:44:18 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.70) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 22:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTHNxIxV5WXLUFEsiJ8awmPaUGwdC/JF7cCaqWzx0bQ+QJ/Hpm/rwab+ISZe4u7tb7n9sl7njmjegjVn3jU6GcbcyMCk/JIj6DnDKQWO+/dlKLDiIFcKgdsvQURWtaIsj1r5zOYiDC8XoBVENRE8g5MVX+vkyg4ZTTdAXJGvAa+LLgpd7vDq/SDTRJEpogqHEIcTkjRNCpllQCI7+anVLR5wu5w/1Wwei4113EuRXw7F91oO8M04UMcQGZ9d8r7o9Tlrz15LR1QkW/og8sGnDCzyyT83Fo8hODtPaA2SyBw8c96Y0CmPwDOOU1r/6zldneUiWgeEA9GAFBXA8QQSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh31o1dO4LCZTL/1E8mz4OvQh3We4Ixp2OuYRBb5laU=;
 b=QYfn6HjTFC363QTi2+SuONc1j2xfVJqmccI19bDH6X7sLRGLsuai5U14ZJ/ai5eKR5QOKmJkXRJTFEucvJ029nT6le0ME1V5XZRvd5WCbMB+IMGjVu7Q99RWOM9cRWMPL1WZ2Yql9tCRQ8Ebxnop1D9ua7Wi2U3DNq0l9p1wYqWdlrXTNlPp48OpqdJz1Un+VqjjmerNkLkyLDHFRCjRM3+XTaux+Rxed7auuNjIQcc/EOZqOupueOjVv8OVNTCJ2rBO/OWhkEfFer8PSgbVAPRk8zh2Y5BJYgYxbXKsycv9HoZKNRPH9jh25wKOOIr/VDszxbD6me2YpMGQFEpDOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 1 Sep
 2026 05:44:10 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:44:10 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Robert Mader <robert.mader@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: RE: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
Thread-Topic: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
Thread-Index: AQHdOQ5nSG/fDnCEd0CaxK5EtQ1eDba4K1QAgAB9X9A=
Date: Tue, 1 Sep 2026 05:44:10 +0000
Message-ID: <IA0PR11MB7185FC6F71E7224F96045A2DF8A82@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
 <067b0055-9b85-4434-be36-7c6dc2450b12@collabora.com>
In-Reply-To: <067b0055-9b85-4434-be36-7c6dc2450b12@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB6030:EE_
x-ms-office365-filtering-correlation-id: 45b2b804-8262-40b8-3447-08df07ec0bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|56012099006|11063799006|5023799004|10067099003|6133799003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: thIChNbV5LpTP3I+qa3gORarCdbmpN2maWRsPAJEK7e7XOeBftjas0crvBYq3FfSKIavySlufI3AFBJaJ0rWFMkSZ+7JiUg8m4GpGw6bGMd07ouRIzzfDz2oLID/60gk2nIl0FlvJZxt0ELGUyYMA62BwupSXAHB4+0dAwZvviv1uGfs4qGB0W7Qlelm6sd/H+C3Bp+wuzFMdJz6j5EF4DxL1nh9A1VARzGUOBky0j1XkzeLl1g5AEup5lKZO/mcJgxfnZt+pIymPTHDhyBJElMbHzKKwa7Zh4xhQrsVUIA4jSlaGHLIcKyvTUQQ9L5TWR/8Q8p/avkRC24+g1pqYbiz05jrtWxuMMrOchTKYqFF2hyUZZMbedFsCJvn5yr3izAyqnV9Piqxd9EkyNRh0f5dtSWO2decIQ7e6BRnW/+CaG+EPvJd75nRN+AJNbwQtBj3g8Q1gW37MWvrkDt3cz3LBgPBrmQ/l8Q1N8ySnL7OEHqWKYNV5Yujl7uVwnBpadsa9jv/ZckZjismt6JLXucIUARonj0JXEVneV+yi/BIl8rOJ3aXpkMMDdYB0nJ4jo/20xqaOYXVhLSS2QXo0oCPvJaZYaavG2viC5B/Nlr8anwgyJz4o2TZAcYzU6kw+jahK0sXag302sWaP1pi6a2UEKm2sDRV2ZGSctEkKbmA/cxhyeSbTfYgFrGfvy6fEcJjCHePhOpAYIclpqrBK4HlkO5DWZemuiho3ZFPWM4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AunaCgmWN6/q8l7xa+fhBZKRJdzAbRg/Bockwi+jzqvVOZ5cUmhRNbpvnR?=
 =?iso-8859-1?Q?XxMCOA1LVVKMFuNcx5ZefeqqmjDUAJTMqxN8+9r/WxQSeEV9+AsbprYMrK?=
 =?iso-8859-1?Q?uX/LHhZzFJIiy5Xi7/2NF4ECDOF5JAgrkNHy3gZMvjfjyUePYbqsZn09H+?=
 =?iso-8859-1?Q?ocvahBRkC9P3SYNHxvtAGMgvc3PoJZcJFkJitC6KtsOveEcmhKCkXQ++t4?=
 =?iso-8859-1?Q?N3zTsjsKaqadW6yYUx2zM68NygsFOIBqcgVka/IFPBy+IH9fKEnPcEiTiM?=
 =?iso-8859-1?Q?I93s3OWvKbLzxIIgi1ZI0AQGyW47SAeOfI7bWTKb1ll/HjeSWE862NUmBN?=
 =?iso-8859-1?Q?D6Vl9Ws+zD/RPEjlA12juziFRJkG1iVVIQo3scuQrKB7aTzaK3MuSQnVH3?=
 =?iso-8859-1?Q?JGlAxNDlTPegRlDUNslhxWWXFOIUN8DeVzC0A1ryxy5NsWTUrxF7PmOV29?=
 =?iso-8859-1?Q?MYPGb2VgkSCOOAouo3Gi1IeXUBOTcVl0ks6PhGKvEhwr3LUUXc4sk1pjiq?=
 =?iso-8859-1?Q?NYtsjQxMfkqNDxfDlgVMd+yTIzYdHP59uUPNHDrwoVXbXMY6rBLqY5F+26?=
 =?iso-8859-1?Q?HGTus1++hTtnjgYb3WcPfzxL+rtqb5TuiWh6jn1HIewYbWxQp/7SOv6S4v?=
 =?iso-8859-1?Q?I2yoZll/5VpxgdvVQNHu+enwmpsdicOMkl0wEFUfUfeIAFekCh/xo/rYgR?=
 =?iso-8859-1?Q?W17MociPwScM+zC5ZjU/IZh0sW/emlu5GK7M6x563FlwUZceGV4IXnY/tb?=
 =?iso-8859-1?Q?t6YVVHD3VDyr6yFl+nTZuIKb6Uut9LF39g/xYsSh/0MadP47N0DeWVhZnZ?=
 =?iso-8859-1?Q?vFfjKqQ04r3Q1uRJa5F3rpO4MQXIopLaCb1YKaAMwrqBRpBKrzscnKuL4Y?=
 =?iso-8859-1?Q?znqA4AMkNvIkdAMtwrse/sRhOqUmxD2uofWim4ABt1jpJyRRRiJ63RqTQM?=
 =?iso-8859-1?Q?hQUaa5IgB829+HepcwBS846oSs1kq0ilDrp5HOtU32nuWekV3e3xxejHKS?=
 =?iso-8859-1?Q?6Ono1015f24Bxl2Q3ZsouTDLYRHgvvrx+csQ/HqUE++4Rvpk1UgqY0zvyA?=
 =?iso-8859-1?Q?IBT4EV3AFwwIseKJDHr+DL46KT1emDPcDJb4RMXFjRxyzg3+yKu98f+390?=
 =?iso-8859-1?Q?mt7A3CHmdlL9BEb5pXtOr2d/PuiS+g23WhwUQPdbocz3C1ikSX7iL2EmjG?=
 =?iso-8859-1?Q?L/SakrjxLmT9qVfdn42q/CS2D3sS1ytL3CBk1yAw0vbXvthhreXtXKO6p3?=
 =?iso-8859-1?Q?uEh9XuEXwGFa6zolsR8HgY3pedPhEVxG9jaYxuZhtZCcFG3z8n7GqiPqXG?=
 =?iso-8859-1?Q?xz3LfzOD+I6ztrUwwI94CC4wCos3u2lAhbsOrKIQ8xwBNEB9o7v70l3xjj?=
 =?iso-8859-1?Q?/D8SvVltzFn41nYCP191p+fEMVnfrGligOUyKaLvwYWaONiw9X40vcHQDi?=
 =?iso-8859-1?Q?QrQsbAfRPpmqr9y8lhuGGxV7N5iXwEPF2JLI/nqHaHboQXXI1l4GZlm6QJ?=
 =?iso-8859-1?Q?zGUV2pubIMxx1mj+Br2gX4jwMjY27dsO9d6eKIeSu6nD6GuiKqnqKvSq9b?=
 =?iso-8859-1?Q?+BYlANa/4u3+Y1Pu8AxzsROzLvTTWeRbZzVS2sE3IgtSDVhyg6oDi+F4/6?=
 =?iso-8859-1?Q?JIH3LP4892m791lHFlsVeZO0ECtYUCJx0bLfU1iDcNzR/goHDJYkqHYxyH?=
 =?iso-8859-1?Q?eSE8PzXqCx0Pbw9c1a1qHHuLNvLzBY0DfnEXYhdtajLGu5HsYvfw9v3LL7?=
 =?iso-8859-1?Q?P5/2k+U381EY+RIaq4x11ZAEPgNsjYVh2CCalFa1XMUeAh4J8ANi1MEFSF?=
 =?iso-8859-1?Q?YdKJGDfFzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3/PyZeAkkCPAK8bEYPFF2mUk2yuwqkvpZB7JtZUEfZ/x8SfVpbQqFtNtzFhvvr+uoYhxz9bDTTdwCfg2F1lwh6cwAVkvs6grPiZ447kWzxfbecO3cY21A+2L8nyLO1MWkho0UVnPmbXD0HtUfChviMuwxWGXDpF0WtJbydMllFUe4a7xb3IFMucJKB5eOW/J8K9F/jJMABlYfKB6q6cyjkrNP368iibgi+Fdg5bn9+HNzbKEBEICke9st20N/WtB/S6+swcQj3MjCYD86GefewcJeShU0wPmrjok3px6e4e4JBKMiedG9fTXwWXZ7VqLekseRFEJCRzQXSKG32xHiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b2b804-8262-40b8-3447-08df07ec0bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:44:10.3064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pCqAfAf9iW78WeHrUXghQpcmcqamGHjk9dVVDi4EVuz3cQYUbdBn4TIW3lfEaC9GjlouIM3sKHE01QQFYfFobFxlnnJADfIcswlwZdT0Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6030
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

Hi Robert,

> Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for
> udmabuf pages/folios
>=20
> Hi, thanks for the patch!
>=20
> On 31.08.26 08:00, Vivek Kasireddy wrote:
> > Since udmabuf allows users to pin pages in memory, which is a vital
> > resource, we need to ensure that unprivileged users cannot abuse
> > this feature to exhaust system memory. To address this, introduce
> > mlock accounting for udmabuf pages/folios. This change ensures that
> > the number of pages/folios pinned by udmabuf is tracked and limited
> > based on the user's mlock limits.
> >
> > If an unprivileged user/process exceeds their mlock limit, no pages
> > are pinned and EPERM is returned to the user. Note that, privileged
> > users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
> > allowing them to pin pages without any restriction.
> >
> > Earlier, there was a 64 MB default limit on the size of udmabuf
> > allocations, but it was removed in commit 44e9eb5a7621
> > ("dma-buf/udmabuf: Disable the size limit by default") which left
> > open the possibility that unpriviledged users could pin unbounded
> > amount of memory. This change makes the limit dynamic, by invoking
> > user_shm_lock() to check the mlock limit for unprivileged users.
>=20
> I think this description is somewhat misleading: before commit
> 44e9eb5a7621 the same was already possible - it just needed multiple
> buffers/allocations. That's why that patch was accepted in the first
> place, without first landing a patch like this one (adding mlock
> accounting). I.e. the described problem is not new and just became
> easier to trigger.
Ok, I'll update the description to say that commit 44e9eb5a7621 just
exposed an already existing problem and made it easier to trigger it.

Thanks,
Vivek

>=20
> Best regards
>=20
> Robert
>=20
> >
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> > Cc: Robert Mader <robert.mader@collabora.com>
> > Cc: Xaver Hugl <xaver.hugl@kde.org>
> > Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
> default")
> > ---
> >   drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
> >   1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index 7c4339130eff..e78947f01656 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -203,9 +203,10 @@ static __always_inline int
> init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
> >   	return 0;
> >   }
> >
> > -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
> > +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf,
> pgoff_t pgcnt)
> >   {
> >   	unpin_all_folios(ubuf);
> > +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
> >   	kvfree(ubuf->pages);
> >   }
> >
> > @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf
> *buf)
> >   	if (ubuf->sg)
> >   		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
> >
> > -	deinit_udmabuf(ubuf);
> > +	deinit_udmabuf(ubuf, ubuf->pagecount);
> >   	kfree(ubuf);
> >   }
> >
> > @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice
> *device,
> >   	if (!pgcnt)
> >   		goto err_noinit;
> >
> > +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
> > +		pr_warn_once("%s: User not permitted to pin more than
> %lu KB "
> > +			     "of memory, either increase ulimits -l, or "
> > +			     "obtain CAP_IPC_LOCK capability\n", current-
> >comm,
> > +			     rlimit(RLIMIT_MEMLOCK) >> 10);
> > +		ret =3D -EPERM;
> > +		goto err_noinit;
> > +	}
> > +
> >   	ret =3D init_udmabuf(ubuf, pgcnt);
> >   	if (ret)
> >   		goto err;
> > @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice
> *device,
> >   	return ret;
> >
> >   err:
> > -	deinit_udmabuf(ubuf);
> > +	deinit_udmabuf(ubuf, pgcnt);
> >   err_noinit:
> >   	kfree(ubuf);
> >   	kvfree(folios);
