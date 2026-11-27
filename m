Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBC606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qw0l3nFp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F4A10E353;
	Fri, 27 Nov 2026 06:49:37 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D660B10E353
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 06:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwv1TcxlveIXkOhc9H0dr3oEznwerVoj3tVe8goesQx6zeP9nJ/91PToJNlGG6gWqs+89RUBwiUlrTGJBmgGh8rvpEsH2dSy5JydrO1rCLtABlBfokgPf+1Tg0qEFUhphwHrHteb3vRkxcK2TRKO2RH1FAw4IBgCd1gTPcXBaZZq0i8DN+oa3Y0dxD7QW6BO1lsFmWcPYmX5PzY9JQ70q0rncOotfeSdLN1Bd2YdBaDTZ9Nb0A0XtJcGGBKDZ3oNJldDndXpEpvCh0UyBT4/WmSI/sg831oWknMtwHZpvaICqjN+GYMc+DmzTQB83Ken/wcmhokkvZpmFOAEJiG8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUh/G4+K01ZSvLjSdE4gIEoFRX9BS/YGGqbDPj1g0OU=;
 b=UMjPwaqtLktrjn8v3JkYz9lb1h13vEOCZTbJBCnE1TlrUdlvCdjDKpwP73okUr3KKk66Rl6/KriKrvZrk13JZy17sfOwWRX405SnDkXy2G7x2P8+2FvC+DRur8WLJrbjObHDconZbXlsGNlogGpzN28Nw8D4bNR3RJ25lcftvsTWgsHINfBXbs9QDXWX4O4nAIWfIK/ymh7t+p1iFPsdhZNCvDmU11Kg99huvdTPVZ5+QnCW0i2JnrCGtxPJrEpkpv8bxof9FQHhsVUEkJO09glaA6inchFaA5rzl7628MRZhS+LVuj/RXZcXSEEuTKYBM66IxPNnRhBS2K1P7oA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUh/G4+K01ZSvLjSdE4gIEoFRX9BS/YGGqbDPj1g0OU=;
 b=Qw0l3nFpYLdz4tJWLUZrc3qxhZ7X3GPIkPFH5+pSjWf3XwQj6uLHjSaajMhLfN44NmgVNpf9nHCnbjY9VuIARaMTI4KQI3Y+2ONCn3o1BYo/Kym+hUNhBTimqTjAJSHXTRlAHocCLjKKcjnbmWmE73xXDv0d4wokw+YUnJsNDly33oBQ07ZN/JuCPX2lMaA3aLPGTE5aHJ8YTPD70kLWPnTBB6TKX90zCbcp0/ZMRgms4Ng/zqT+XUbKLSsusY1AypNgOJ3ECnRarla051P87RXULwrN+KJ7mJh5oQSY9tKvPcvQrmf05DhNDeTUyspodboGtaw1Ws1dMo6D2f+XfA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 06:49:26 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 06:49:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 15:49:22 +0900
Message-Id: <DN5SK4W2GLHQ.507PW8U3EG0C@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] gpu: nova-core: falcon: separate staging data for
 DMA from its location
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261126-boot-rework2-v1-0-99a1dc6c7cc4@nvidia.com>
 <20261126-boot-rework2-v1-4-99a1dc6c7cc4@nvidia.com>
In-Reply-To: <20261126-boot-rework2-v1-4-99a1dc6c7cc4@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5f3a9b-fcf4-4b68-696a-08df4c5293b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|4143699003|18002099003|22082099003|11063799006|10067099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info: NKs7wFsf3TlUzDlHBgnvy0WWlrER50u3yjmY1e6M1rp2r0Ak53BnBGcC6HLPmQP81dCB1/N977fjdznfL2aksHKl+E9Ukrnq+ikjjlV3o42x7X8aS2aTrCFB5srkMXmxcFfwJG3GoW0onEREYEQQ0s6leQfDr4dpArqNA73EggahdHAoC9FmyJwK4Eg3XZdddZAl0nDf0sep0WvkfPrjIPjWscGvaLwsWsb2YxdpyMJtHdxVNDqeEQx26AM7KYIkERF8bxmBwYnIaEngSOwRpyOib9HVlJxeBXdNps2Zzz5vukVPLQrDJ3Ro4D0biJEEYGSIgU3VNrl3qBXvXcoagKAi948uwSzyb9tQO/Tl2MOXfpyGRbnlX9F1SNs5fTFckwQyMjUGRLS2YWwblk5g1D5vvxsZxJl5JaydGP/AdJYNQjUPYS2BWQoqEfrp3Al4PZ42YuMxLJoixkGnsFOF3cCa29UeIvcBTYpiMdzIc1xh2iDhKhuEKZ9R64BbOBaaO+cSAqOvAOMWlCPE8o9nQL3UCvq+cG3keTViUx4WvZXX76c/IFkfVsH2IOl0mJa7bgMV84Foniri6ZLOHlvwAifVSXhqwLWdu1ab+52YTssCyA+TOh3PO/cLB9U27k+QJJ6m5I1z42DK3bqBy+CyLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(4143699003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnVPZ0dPNWNua3Q2dUw0d2NwYmpXMUpVcjM1dlZVR2lTV0NCcnBQWEd0ZSt0?=
 =?utf-8?B?NmtoVEk0MmNrMkFVNk9LSXRwa2xpYkJ0SGlEVlVFRzFvRllrZUcrVFZURkZx?=
 =?utf-8?B?UWsybzBvOTAzeG5hcDVYMFpLUXVYTEJUUkYwNDFTREhYNVdhOGdyclErOHYr?=
 =?utf-8?B?dzk4dkhXM2ZRYmtXdDFFdzFMUnNyUFdTNGpXclRUTUdVQ0tLRmswZ2NIQVJF?=
 =?utf-8?B?OTl1dFFQQnRGUlJOSHp2TXJXV3RUK25icjF1Rm4yZGtSQU5yZFBSOE1yYlJx?=
 =?utf-8?B?MGsxVVljYU9zSTg2L01uNDZmSEVyVHVSSU11cGhMWS8vYXVrQTBCbllqa0tm?=
 =?utf-8?B?di85cnNOdFRFTkowUjJyWjNwK1h0ZDVad1JjU29NY3ZOZGs3RCtoQi96bTR3?=
 =?utf-8?B?Z1JsRGduUDNQWHJLTXM4Z3M1YTNFZWtTQTRsMW1IeDRFSzFxS3Q3ZXc5RU4v?=
 =?utf-8?B?RGNlbzJ1S29iS2pRbjVHSisrckxPM0k4czJMQXdiYmo3SWxTTXRnRW5JOTZR?=
 =?utf-8?B?VGRqd2VKblVydnN3alcwTS9tSzlOY3NIbWw4NWhLc0NyU1NBaXczMWxQejJn?=
 =?utf-8?B?ZDArbnp4TDFGWk1wc3lLblBERHBERFhyUjZOY0d1YWQ1Q1lrMlQ1Rk9hTnpU?=
 =?utf-8?B?UnNYY0hibHVEWE42ZSthSzlpNC82alNGOG1hYjdlWUhiTnlYNDhxQVZucHBQ?=
 =?utf-8?B?dVpCZTZHZ1o4N2FNVm45QjV5TlpMeno0MjRQZFN5RWoyeUR2TkEyVklUdC9G?=
 =?utf-8?B?dm1aQXJhb0VKcng5SURqYzY4VXIxaVQzSThpeWZVTXJnQlNDN3pyRWQwV05o?=
 =?utf-8?B?YTVDSFlhdFc0ZG40WlNVd2oxdUp5R2U2NDFvbTBPMmJRWjJ0eFhEM2tLeE9K?=
 =?utf-8?B?OHVEdjQrTk1HWHNVRTA1NisydEl4cUVNN1RwdndsVEpId0JBcm1wWlFYWU9P?=
 =?utf-8?B?Nmg0NlZ2UkJNVWx1a01TcmtDVEdBTjNqektIQVVtay91QlpBc3pqd3FhbmVK?=
 =?utf-8?B?Zk4wU0pwd2hLSjlQSTZBc1FSalBWSUFyVHI4WjhKc28vMWQwZTZyOG43S0I3?=
 =?utf-8?B?cVQ4MWJFdUJpcnlDbTZZcjlCd3dXZ0VENFVmZjl3aG9UbXV6RklFSk9jMk93?=
 =?utf-8?B?UXQ0YitrSGFRdEY3QzFnbGdHRTdnM1d1QWlOWUlhTEdLeUtSbVh3b0JyRFNt?=
 =?utf-8?B?RzFrNHM3dC9BU1JlN3ljV05USXhNbEg5eFFMVDR2cnJMTVhldFdMWXRWeVNF?=
 =?utf-8?B?K05JK0Q2SktLWFZzMDlzL2k3OHUrZkJudUdCM2xOL3lOdDR3SGpPZkl3R0tr?=
 =?utf-8?B?eTZ2ZDlJVGx4aGZNY0JEZTVFb0o4VUxpOVAyeFJTb1FjN0dkdUNQZ0tPdUd3?=
 =?utf-8?B?Rlk3SG02enNVTDdQSkxhTVV3VHBCOE5HQWZOQlBtb0tDV3QwYTI1M01BMFdS?=
 =?utf-8?B?NzE4eFhRSHBHQzdHK1FMNTVnYzBPTlg5eUk0SnpxczdSazZ6L3M2aVkvcUdz?=
 =?utf-8?B?NUw4UVpPWE50a2MyeXBjMTBWU08vdS9maGZKVWF3eWNINStiZjJ6RFFzRVVx?=
 =?utf-8?B?RVIrUXU5WlNJbHh6eC9GMURpcmFpTHBvZUI2OXNrTlpHdjFDa1U2akM0V2g1?=
 =?utf-8?B?UjY5c2dFeFVKeDZUMmtGSFVtb2JHeHNLaUdJbjFpdUtJVGFTVWFCOGJSUUwx?=
 =?utf-8?B?WDVIaURVN2lUZm5ubzZsZzhMMk1rS0UwZlpnMnB4ak1lTk9pTWw3QjJxRkxW?=
 =?utf-8?B?MnFaR2xMMTR4eko0ekpqTERCTzgrOWd5Q2oyMit2SExJZEd0ZlJaZlE5VGRy?=
 =?utf-8?B?SStIdU1vV1pTY0p6L1k0VElYMzhLUnEvMzVIb0JnWXc5eDRINW41K09wa0Za?=
 =?utf-8?B?MXBGaHFFT0dlcFNLTjZkVExKcVQ1ZVhVVUVRNEFiTGU1d2FySjdldkUrMk1u?=
 =?utf-8?B?L2NYUjh6RkJoODR4N3J5clllYWxOZkQyWGYyUkVZY1FsSk1xL0ZQNHA5Vmg4?=
 =?utf-8?B?UUprTXJtODB3M21ZM3JtTEdXZEIxUnQxbUp5ZWZkbzZ4WmUvNFJYcklEN2tO?=
 =?utf-8?B?NG1NZkdSQnN2SEo0KzU2Y1BlQnluRGFQcUlWNDV0Wk5vMkN4V0h1OGl1OWs0?=
 =?utf-8?B?ODltL0tsWHpZWTZveTYzSm9ORXRMU3dXUW54WE9Ed29DcUloeUlacUpEM1dl?=
 =?utf-8?B?TXhCY3g3NTBMRmVKS2p1ZGJKcmZTaWorZFZQcVd6Z0NCMGpOS3A4UGFkeHMr?=
 =?utf-8?B?WmtjZ2FDd3ViRnBMUWxIcUJrVDdQZlVOYkVjbUhvcnk0c3dFRXBrdmhHQlR0?=
 =?utf-8?B?QnNZWkZhTjdEZktlaW4zKytBakdOQnp3MysvY0huRGRTVEwzTFUzY0NuNHRQ?=
 =?utf-8?Q?HWQOzWGh16nx7WtVKiYno+vNAIh4W7oLNPfhlqp07dwzA?=
X-MS-Exchange-AntiSpam-MessageData-1: CTGh0TNE/5OElQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5f3a9b-fcf4-4b68-696a-08df4c5293b6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 06:49:26.2578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7L4L6DSAD+iM2rES1wCL8CKLNO6CK3Z/yvBPgIJ5N+OxdWRzgLcrlHo7MPf/j9KQBZtxfFBCvXYGM0Q6CwgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 5:20 PM JST, Eliot Courtney wrote:
<...>
> @@ -634,38 +652,44 @@ fn dma_wr(
>          Ok(())
>      }
> =20
> +    /// Returns a DMA object with `data` at `offset`, padded with zeros =
up to
> +    /// the next multiple of `MEM_BLOCK_ALIGNMENT`.

nit: doclink to `MEM_BLOCK_ALIGNMENT`.
