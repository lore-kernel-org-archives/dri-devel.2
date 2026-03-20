Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14246109878D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7222710EB0B;
	Fri, 20 Mar 2026 14:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nls+9AGz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010030.outbound.protection.outlook.com [52.101.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2543410EAD9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUHt88VkCjgv9LeNfR1cL6NfO8PTBpCuu3djwW5zWNCynaXkIRKI3E8AUrmW+PIFmnBMMDLgOC/1gpk1ojrSj22FqF/jHZ2ACqJVrvCTOzYRKRNT9CVHyi+RIPTXt17SdfQxEJ5IlL6yttH9r69t3lvrym111HHqbMpwSAY6CaSfdHUEqLBg8OLIhx2JVKE90T5E6HhSxF1CmfUDAwJ28AG1pVYIwqBMFWjErcOD1s47TN+0BPcqVETTdoGHunVBcL7Po/dlf0BYq8E/nbizJXPW8+8q1nQT6E0rU9qvH4uIUbeO1Al8CJThOwbouxxffZKo3ow9rQl3Iv5em6PReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz92yKMHkkOLMjv1riPd1uaPdupugHum9Aj2vplh11o=;
 b=vXawcsAzj972kMc74+kdjJRTXzh1EHzSsaQf5iHTRYmm1KFlWI1yOU+ntLTA7Tug5FE9fs1Sx+v7nziyU3wGTzXvqmvyxfgCXToltL2PRN+HHJkLnQ3IpsalNuXP4TyPwV8q5YKegvPjJNvJelWsACtkClD5d9mhDoKvDjEUxK9FfMKWHUDOM1VF0CZpyLlQzG0Ebfa+7VkZ6Ou+tYfCEddSanR++FcuXH0SJfBpicWiJpkNbdsSd39Cs8m2VEXOBMsEyVeiZ8wiRK44dP3LyiDoPCMsvB0MUBMLMm9anlWyPVjv2cUee6I7WSATUYkN1HvL3asA4ZV/uvMx6IHkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz92yKMHkkOLMjv1riPd1uaPdupugHum9Aj2vplh11o=;
 b=Nls+9AGzEPERmLr9uO27ozmll2oBwOEWZI0XslIJZVomz5413gAeTodUIxxWhbas+eg9Nf0oaf8OcJXwJjBGQLBDKZWr8LBu5XmNrPbTQQ76NSwvfD9SLLMm4+64J4NsRvzNzOkf43KPQYwBPOJ1LxPt59o6xLZkzdzIrvyx9N7jdGCPkv/ciKaDIsZ11GQBOuroH+wJS5rNg8/Ns+wZRWxm690nTA/BorGUakdLaQ5HlDvFeC0spyr71cIIwmVxXLOUEn34pq0nsyj25k0A9WRvExsnZt50j0C5FgJqLPK8gPdrD+/9/RnVeKBSz2ltAZXUk5hqdwpmgJfkVjAfOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DSSPR12MB999237.namprd12.prod.outlook.com (2603:10b6:8:377::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 14:42:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:42:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:42:25 +0900
Message-Id: <DH7OT1GO2GBU.3SQZM9B451DZR@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: Re: [PATCH v2 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-7-9a9fa6f1c4c3@nvidia.com>
 <DH5WURVBQNI5.1ZO9K0IR3PEOQ@kernel.org>
 <DH6CTNJ492WU.2C9VVJGPTY3A3@nvidia.com>
In-Reply-To: <DH6CTNJ492WU.2C9VVJGPTY3A3@nvidia.com>
X-ClientProxiedBy: TY4P301CA0113.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DSSPR12MB999237:EE_
X-MS-Office365-Filtering-Correlation-Id: da1c94da-bcc0-4143-344d-08de868ee93a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: dxm5WLqwtFIXb8+PU5PLFUJrKkwkAjGxC/M9KjUXa69EcMKz3Y4QT41IXPUd+aZug0BVCqeiWT+7zijp1ZmaE336iBWR2fkBZlCzJXnhz1fsOqszd3LbRcZlN1g/++rJlviMI/8DR41jHRMI4LlYNcMlsS/cIsdsto/v0TUB/lKefoM9deGpFoOHgf+EICifAPNPbKUm6H1UpWreq8bYJCIPD1vkkVYp6lHXV/GdhJZ61B804MX3kx2cqOOz7fbJ5cZt/allNbhs1BVAuY6Fh8yu+cHT4HVzfCzSIHmnOW/+Qy1JnvGxXReBfsx5tbHiuJNC+dmgHMdGCJ2ot+I1BZBFcwzo2GAqOLAPmHXhe4x7QRj8rD/GphS+MDkDwwwv0FDTi6Wix/aeu9sNLh+lv1hTwZ6PZofjOX/asiKb0fqx5mQ11DM67F8EA3LVx6GqNo2FWRmrk4x8eGlUJUX434ncmIDAuGLq0PtMgujMqXV6dtDzgTSIFH0kc/kJdNv64lMYPP2KtsUbWjxlke5PlNvP12zN1ZjyjFQvSg9jPbWGP4/fTutK9FZ3NsY9bZ89RiT/aoak+/mENSbqCSWg+BCkavGihML54tNvmH7KdF4YHTY6x4kKTcQnLBC0scM/gHb+VQq2dct5Dl5JqV9UBaW1kvl3/TfUN+L050k68h3d5KEja3hpquORe+t0tdwOO56zpNgvQFL1e745Wes4eKpOWwTtP1bZaSM/xKRoXYI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJISy9rQWZsOFFERVNHeXFmSXNFT1pqMUIvb2RIMG5DYkZnbWREcVhyQkZN?=
 =?utf-8?B?QXNOV2xxYmFVRkVtWTFGVGlsU2xFcmhPeUxRSWJmbWJodDErZXc5eDFQYUJU?=
 =?utf-8?B?cTRyOEpaYU8ydkpRWisxMDc3aWZJVzJRUS9pM2lWaGhCZkthVVo3bzNIaUZy?=
 =?utf-8?B?QWhmdXlmL0QvVmtmMDV1My9qZE9ZWVltMlk2eGlUZHNsWjlKTit1ZWlOcHc3?=
 =?utf-8?B?anBoMlI5amN0ekJtVzJHVlVuSXVjTDlZb2VoYTc1RVJLTmNsb0JMRzcyalhG?=
 =?utf-8?B?ck9uaWNkNlFqcDRqUG14UkFqbEptbTZPRmN0R3lEbG9WOVMyR0l2SGJ5bUQw?=
 =?utf-8?B?MWxoa0dmR3VtcG1rWmVMcHFJRzloaDdnZE94WE1mR1A2RlE5dCt2VitwNE16?=
 =?utf-8?B?M2c5eWQzcTNqMjFiTCtlcmVNVWlNanEvS2xDdk1Bc3BRUkRhcm1OcTJIS3Ji?=
 =?utf-8?B?VGxlSkFsZnh3WENhOW5FSDRBelhJNm5HU05vejB1aTl2Skh6UEljRE02SnVD?=
 =?utf-8?B?VFhYS0RsQ052cWYzajdiZGZ3Rm1mcVRUZS9DblhTaFhseXBRenBWWkU4NVMz?=
 =?utf-8?B?R01KeFRRVXZYWjNZc010a2RFNExPSTFwNmZQVS85WEZ2TVd6TVhTbWZmRll5?=
 =?utf-8?B?dlhUV0lsbWFNUS85TVQwcnprUXpLSmI5R3Zkc0kzSGJRMVNFOVgzUjNpMUJo?=
 =?utf-8?B?c005N2hFK05sWHhTYnJib3BwMkZJcGZYY0RPdGpFL3hGTDRnU3Aya21IeUFO?=
 =?utf-8?B?TzA3K2k3QWVXV1Y5QjE4Z2FyL0pNdXJtbVRJbUlobmZ2ZEpOOG0vWno4STMr?=
 =?utf-8?B?VC9EK3YxNnMyaFkvOG1KdnRJdkdTNHBPaEptVmp2QURYaDRQelIyN1ZvRjM5?=
 =?utf-8?B?dHkwbCtqZHo3cnhhcEY5VWlYTW5zVkVsZUt3UlpmNFlJMTJBWDJlanlMNytC?=
 =?utf-8?B?NEQ5LzFMWXVQOCtwczBTNmU3OHFVU29CYUJtQnlNQjZrK295YWlWU3FjN252?=
 =?utf-8?B?ZEU3U2o2SHg5MGpxZUJHOG0yMDlpL05nbUp2bXN3SCtYUkFLU1VBcGY4cmtR?=
 =?utf-8?B?ZlNiS3BIV2RJUHR0aDloTlByc3FmWUY3N1J6eDhqVFc2TDMxZis1UnI4THM4?=
 =?utf-8?B?emZsRFcydjhtSUl5RjBBcmN0alEzb0JldzUyVDNGbTZ6akNLUERnTnZqa0tQ?=
 =?utf-8?B?eFdZTS94cEx2bVVtaHhodG9NbzdkZVcrbjYxbjRTKzVBR05Vem1VRHcycHAr?=
 =?utf-8?B?OFhDWDE5b3R1VGV1eEgwNmR5bGxqaXk0WnBNT0ozRHdOK2ZIcVZGM2ZRcWtQ?=
 =?utf-8?B?RzhEbDdDNkh5UGcyZEFWeTBPQWIzL2hWdTFqdnpxN1NKNnRiMnZtZlptVjRj?=
 =?utf-8?B?VjNXMXdBaTQwZURGeVdYbGZoV0l6eENhL0VvMU1OVkt6NHI3TTUyUjFyOUs4?=
 =?utf-8?B?QUZySExkeFBrRmVPUmtMQWMycC9hYnRwb29RQXRZWFJxaEpSYWdCSEFSVzBB?=
 =?utf-8?B?dnBwZmk0NS80bzUveFZSUkp6cEgxY25SYWtRUUVNYU9HcWRlR05raTNUaCth?=
 =?utf-8?B?eTl3bnBJUzZRMElob3p1NG5oeUhBV0pvQUhEVUhLYzNQaHFHMkVadS9RZkJT?=
 =?utf-8?B?OTJMWDh1MEF3M2xrUGRybDBXditTSWxkR2xaZGptTkpvVU9yUzkzRURhRFBT?=
 =?utf-8?B?ZTYxTW5tVXRFQlhkQ2NpeHJobE9FdE40V2tMKzMxNTlZVmtBSnYyZm5CYnZp?=
 =?utf-8?B?UVNhbGhYeUZMSjloMWN0Wlh0bVZDd1ZBOUJpL0ZycXIxdk1yYVhaZTlzTklJ?=
 =?utf-8?B?SGVqMld0N3AxVDQ4NGR6VndzSHZsSXJvL2puWHJjejRGL2J5bGVSRFNaN0g4?=
 =?utf-8?B?NXRGcjltM2J3RXVNSkYvbWk3ZFRXY09rZUhRc3JuZXFzNVc4Z0ZUcm9wZGlS?=
 =?utf-8?B?RTdRNmluaFFzUjhaeDhWR09OMWZqUHJ4dy9meEQ3aEJoMC9iSXdESGZGYkNL?=
 =?utf-8?B?d2dZZTZ3ODB0RjRKZUkvSnpqMXQrZlFvdHpYektVQ2lsZjIyNTJjVkFPSDlL?=
 =?utf-8?B?RkIzVWQ1OVFnVXBmNEpUeGM5aGd6WGdFY3dhanB0SWVIMVo3MkVCU3JPdTVv?=
 =?utf-8?B?QkpscXZDK21lTVYvN1ZhaEgrME9COVBLektjTGpwc25hUGtCQ2Y4bVI5Tlcr?=
 =?utf-8?B?Y1BlT2FId05uZFVvNXBMa0xYOElrbzhSSDh1RnF2S2ZjaE1jNGVkL0N2S2RU?=
 =?utf-8?B?TzNGS09xaGFJdEFVaGVMdXd2V3E0Y2RjTUY2Y3ozVnVOMDZyTjU0bzZ2aGZS?=
 =?utf-8?B?UmVJWFhWOFJodWdNc0Zra1llalB2NEcvNktUN2lYcVVCelZvdHJHU0oyK1RR?=
 =?utf-8?Q?TV3vU+t/FCTAJHEpMX/iPHRuJxftmzS97SUz7+j+oXD/z?=
X-MS-Exchange-AntiSpam-MessageData-1: HjZVcPaMQcFRpg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da1c94da-bcc0-4143-344d-08de868ee93a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:42:29.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qD1liE59crSrTMZBjH1E+EsgepS/KimMtSkO9n9uq6a8uP8f66fIMn/pgxiuo4GdSLSHShoh0VkWPir9hrdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999237
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

On Thu Mar 19, 2026 at 10:06 AM JST, Eliot Courtney wrote:
> On Wed Mar 18, 2026 at 9:35 PM JST, Danilo Krummrich wrote:
>>> +/// Sends an RM control command, checks the reply status, and returns =
the raw parameter bytes.
>>> +#[expect(dead_code)]
>>> +fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>) =
-> Result<KVVec<u8>> {
>>> +    let reply =3D cmdq.send_command(bar, cmd)?;
>>> +
>>> +    Result::from(reply.status)?;
>>> +
>>> +    Ok(reply.params)
>>> +}
>>
>> It still feels wrong to me for this to be a standalone function.
>>
>> It should either be a method of Cmdq, or it should be a method of RmCont=
rol,
>> that takes self by value, i.e. either Cmdq::send_rm_ctrl() or RmControl:=
:send().
>>
>> Please choose one of those options.
>
> RmControl::send() seems good to me, will do that one.

Honestly if we can just extend `Cmdq` with a RM-dedicated impl block in
`rm.rs` and make these regular `Cmdq` methods, why are we jumping
through hoops?

RM commands are one kind of command, I don't see why they need to be
sent through an associated function that takes a `Cmdq` as the first
argument anyway.
