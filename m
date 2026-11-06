Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C970606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uh71TXN0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E790910E49A;
	Fri,  6 Nov 2026 23:17:55 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013003.outbound.protection.outlook.com
 [40.107.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F8510E49A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxGkn9QjXEzuWhSMG/23uwEmi54FqXu8nu1rZTUKsGZhlnZOYgXt5k/xcaK6TkcPPWplJ6MsTzDXbrm7ybkPBdWILmR+5NALDHXDLpWL900ih2cGle9/zTtfjjpNjJwQCUn0jQusXhwCNYNx9+/S1uqtV/Qdy2qyp5KLoK7q+86Iw0XSuzDqVki4kt+r531F8bnXYsPBQcU2BCj+/isyyTJ2ToCG2oGPAK0v24jqwf0GSJ+QuL+k/75N1y1qcx11zgQ7YphLWyo69RF4XaSn4Hhjj7pOfNJgy7rcmk5f9yKQaw9SXiNS93nx2nX0fdnENjPfJyEDTCdxOX3naZBf7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0TKrmOcnACBHLBZCrHhSTjhoR7OMTwV2zkm7Oo5/gQ=;
 b=D3Xd9SgRT3F2LcXFw3eLbQr1dr+trPnbq1e/xgjWz3n5Rzkql/9j3gyaSm365WHdtW/Whq/ns504mKfY5x5mfDSl3jaoxyKHpuY5UQ0KLY6QrY4JQmcUSQZPrWTrh/kU80REpoMUfZHO5qk3ijGt3x+awMVMpFzWNLo8ekMJ0SxWOLz1IK5AuDbOkMLI0BFduZDDT+6qXr0XtELVwwfu9f0PNs64I13goKYOYWyS4FB5IQwJzL9PM0ParlrtK3MBhT99ZRp9/lLUaCbE0rYSk8Yi2rWdMVh//CSbHH8w/Nz/iBMcOWpCeTAETUWb38nDAiwXClIJ0ayyFLJ+g4h4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0TKrmOcnACBHLBZCrHhSTjhoR7OMTwV2zkm7Oo5/gQ=;
 b=uh71TXN0aMToHqw3NhqSFwFPyZx/QYc7NvxQbhTw+08jTBuoS77gmCKMduv8I5BokGbIZyr4WxYEayD9+V7Fp04a6tgCiuXB1ESm6lh4q5hH8jiQhpNHFMsAH0vWTz3+ZHaOnGf2w4/qtMDN+CDRxzZzC9LJMErA1S0ocxm49N1fB+bOrVO43tKrMA1wwnWrQ+AWTl/nif+qhAay0YDoOviPVE0bBWw9pRRjiWMYpnWGz3pzUHpljmIEV5qOfwY6FTWG/U8wvaKH96I6Ql1FoI/4cFEfnbhNp2WuCmF02LgAAfdgqVekcW19pnxIADC2QZyiaVPslrpqGccFqk9uzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 23:17:44 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 23:17:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 08:08:35 +0900
Message-Id: <DMOI8FJN4W3U.2R8Y20U3K5N1N@nvidia.com>
Cc: "vladazaharova2018@gmail.com" <vladazaharova2018@gmail.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "gary@garyguo.net" <gary@garyguo.net>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dakr@kernel.org" <dakr@kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
In-Reply-To: <b2ff5c437c41ba4f8c1a8f354d24d7e68517fbf3.camel@nvidia.com>
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c8022d-7331-4497-745a-08df3c5c2944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|261009223027099003|56012099006|4143699003|261028144727099003|11063799006|261026140227099003|261022105027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: oAq0Y4yVgKUzGVAqmKCA61YgB8kkuUzRVJSHlrOUYQ0GwdnzLfbKSUf6oROW4EAKZJNDbZJLXQK2wxv4JmF8s+j3Jti0JW3bUeVFIu3E1nDq2ysoW6EEgOWrDLMCa9D0PhciynZDN1RsGRCQ1t054u86xwzj0cuXLaMrbmrxoP/LrOYg2JDsc+gEsxgKH6RK5C4XWAHY7Hh+rFFMlXcVMTWmqJ87IWD0vR/fUj7uL48QU9S4zw1qS2P76DlMTjsG03PecgZcZqx3lIpj1XPdJmPm2804nyXCivQDHpMYwXT4olic8tFEdoSFrtkFtejRZBr7ZljbBbBOcCCnRQZ3++cxT2LbKU2B/WS+gOkXQxpHCdVmfShztTiQHubkdr7TE012P27OEcD/pPemwEps9ju9UR6mvXPGmLNLPNUYRMSu5deKXoETPdUuVmHtVAgT/XF5AW8kMJpZru3TfEE7pLdIdmca5bCjtcSlSMeZWWgnw/2Y178EZgF3R97TAXhh78k0kz+UpJeMwiOU/utDvqCQ/lIJlFG0xGnMF+xFrkKq14MBD+lJcHWi/vEHZGqB2XpEbw70h6mvZh9iHj7VtllbbmMjQxXseNPoCi0eny9rn2OuKsYid0dRiBO1ESS/H+89cMxqUIB8n0F80sOIKjb9aKdJ5t4Ee9ES4MmPelA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(261009223027099003)(56012099006)(4143699003)(261028144727099003)(11063799006)(261026140227099003)(261022105027099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNRcVJxSW9kY1hvZzlmZ21SVDBOOFVrVWIxb0lJVlVsZHQ1QmJuTldVbGp5?=
 =?utf-8?B?MnBNazloZDJDdzJ1bS9QN3BsNThpRS8xVkcyQkN5OENFYjRlaXBpWm5aaEk3?=
 =?utf-8?B?eFlXL1BHejhvVUlUOTNMTFkzNVlmSWJTVmZoWlZTbnBlTmhydEZmZnF2YXBY?=
 =?utf-8?B?aXV1cjRjTUVuVkRKbEZtQmJMbVlEV0hKd085MGJTNHMyZXdBNlFnMDRhbldB?=
 =?utf-8?B?Zlh6TzNpWnVxM0tsWWtyTUp1aW10SjNNRXFibzUxbG5RWno1MUEzL2wwN3VF?=
 =?utf-8?B?ZVhpcGwwMHB1cnoyZ1BOakk4YXhnT3FMQnB4dDE5V3dPRzhKNVNDNTRZMThM?=
 =?utf-8?B?ZEpOd2trUVNFQVBoMzgwanJnZkRJMlhWSjJkUXhqellqWEZjeTNoUUwxVzJR?=
 =?utf-8?B?b2NjWXNEcDVPQm5LR3Vsb3hwSlJMT3JXZ1hBV3g0LzlLVjdrOXlqZTRiOFY0?=
 =?utf-8?B?RlFpdzVTZlh6YnRSb3hXekVON0NPTFBnVEVyT3gyVFBqVnNwU1ovN1JoTkRJ?=
 =?utf-8?B?czEwb1orRFlFZ0plczdRNFA4bnhJTFNmUHQxVW1MQXY5WDU0aTM1dGJiSSt5?=
 =?utf-8?B?YUoremwvTjJsb2I1cjVOMXU0ZGUzQkVvR1RmSHd0RVBTL2x0UUdjV0dSWmUw?=
 =?utf-8?B?R2orcDgrSDRkTVpFRWxEZWV1RGVieGVzbnYxSjUzVkRIL1FoQnIxbzdyK0xH?=
 =?utf-8?B?alhOa1kxRUhDclF4a2o0SnJ1MHpWT3NEaEFkczNiOExOdTR2UmZBQ1NEcWVa?=
 =?utf-8?B?Vk8ranpTKzM2Y3JzYjJ2QTJaTjd2UFVOaWttckIyVXdOYjBWSTFSV2ZJUnc0?=
 =?utf-8?B?aFd0blA3Ri9GWncyWStUVVlqUzJHVWxFbENFRXZ1R29jSTNESGpqWVNNL25W?=
 =?utf-8?B?UWlzeGNhWWpHVzdnbU1kWXYyci9yQWR5djFFbXFaQjhFWWRCZ0gzZEZEZ0x3?=
 =?utf-8?B?WVN5cFUwcUJjTXJpM21vR09mQmVZajB0T3FwaXJTdTdrMzYyVzEzeE16cGFv?=
 =?utf-8?B?NXJZY3FHUmJHUjRSdjdTN2g0aHVmeC9LcDg1OUFabnlMQUk5S0hRbVRwVE5l?=
 =?utf-8?B?MnBUeXNwNWlyRUloWXpScmpKMVYwNjFEYkluSmF1VUNWVkFUa1l0bUc0MCsy?=
 =?utf-8?B?VTNBUHZpd1hZK1gxVWdubTh4MGxxSTkxVjhscnJRTlBrbmZGLzdETUpWNmhQ?=
 =?utf-8?B?SWRycU1ySXlUSDVSOUhCRW5UakxVaE5DeVJScW1vZEtjeEF6UTlld1k1RHRp?=
 =?utf-8?B?Rm9WYzMwbnNpaUtEUTFqbTB3TnFXaVI4UFJTVWRsT0tjYXVvR2xzZWl4VVo4?=
 =?utf-8?B?WnVzSGFmcGRvOVFVUm53K3V0NHA2OXdvSFBlbkpubjV0S2N2WDJnR3pSMGR1?=
 =?utf-8?B?ZkU4Nkc5TWpDYjRIK3VSbWVmOTFlK1RoWkR4QVNnUU1BNHBCRUZaYUJQdmp3?=
 =?utf-8?B?Z2RMYzdDSmRJVG9xbnQ3ODZFRTFHNUZnNlRDdnVWUGtJOFBYNXpyQkVVUTJP?=
 =?utf-8?B?MnpNOWZqNTBCT3NISHFUN2pBOVdmdEpGS0FWdHYwRjIzdEMzUTd0SFlydWxD?=
 =?utf-8?B?UDFtKzMwUG9FRS95azc1clh5bUZSdkF3UTdiRUU2a2hidDVvNkhDZ0NuWDFy?=
 =?utf-8?B?TkM1dVJMb0Ntd2NSYVIvMSt5VHVzaTVNNyttRGtzaXUxc3dKbGpJS0hnQUhj?=
 =?utf-8?B?Rk1kdkZhUllMNkswMExqdXNLZkdOS3VkK3lmQktpTHI1eTBVOFFmZXljUFZY?=
 =?utf-8?B?dDJ3bE9rb1A5ZWFnVzRReDl2ZmlmV0Jzc1RnVVBuYWF3S2Z1QWZ5KzVSU08x?=
 =?utf-8?B?cmVXNk92blRXa2tSM2xzRzdzR2h4bzBXYnVIbzl0TEFWNC9RNWtQQXo1bXZI?=
 =?utf-8?B?KzBoK3AxZDA0cjdMOThUTG5jcnNWUnowWnhFVUlkUVRQMm9ZcFg3TXdKQjRD?=
 =?utf-8?B?RWsvcjRFYlJTcW1GNTBEUElBSy9TcUZUeXdEd1prMWNGSEVnQlYxdHNlZ1ky?=
 =?utf-8?B?amIvWEpCc2hLYU8yK2NsK2kvei9TZ09CZmk2d1lub3g4K0tLcE8xZU95WVdv?=
 =?utf-8?B?d3NzUEpoNGkvZm5DWi9JS3Eva2J5ajNZc3dKNHRhQW4wODNYaWFXdWl2V2F5?=
 =?utf-8?B?bmZwSlJJNEZXRzYvaUk5eld0NXdDdFRHRzFLczJWNXc2WVdhL2FrTmhkTkhD?=
 =?utf-8?B?czFVVnN2am02aVFOK0c3d01Ccm1CeDVjWks0Und2QUduZTE5aVhGMFk2T2p2?=
 =?utf-8?B?VmVkSXc0enhuUU01Nmd4YUtvOGRoeTlNL3ZBaUpnWlpReW1ESzRBSDRHSGFx?=
 =?utf-8?B?TUlLaGlWaWZZdktBcy81K0hpUStySzVPeFFtUVprNjNva1lyZTV1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c8022d-7331-4497-745a-08df3c5c2944
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 23:17:43.8584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNqcZmVJXAN/huTXqc+b9rklMUtfK/D4X1cQKU54R9R3vJfK+IPRn1s5vAb9ZEt8ot+BWWbggR9Bz4lEx1O53g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat Nov 7, 2026 at 5:51 AM JST, Timur Tabi wrote:
> On Wed, 2026-10-14 at 22:45 +0700, Vladislav Zaharov wrote:
>
>> Changes since v5:
>>  - keep the "put" pointer read before the barrier in the copy, rather
>>    than the one the copy reads again, which is not ordered against the
>>    rest of the data (reported by the Sashiko review bot)
>>  - rebase onto current drm-rust-next
>
> Can you rebase this onto https://github.com/Gnurou/linux/tree/r000_rebase=
_all
>
> This tree is the future of rust-drm-next, and there have been some signif=
icant changes to
> debugfs that result in a lot of merge conflicts.

This tree is also a moving target; let's not ask contributors to use
obscure bases that are weeks from reconciling with drm-rust-next.

The current v5 applies (almost) cleanly on today's drm-rust-next, so it
is fair game to review and merge if deemed ready. We can rebase our r000
code on top of it should it lands first.
