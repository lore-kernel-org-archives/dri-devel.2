Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E3A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A5iO1VmC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5535311275D;
	Fri, 30 Oct 2026 11:23:30 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1538611275D;
 Fri, 30 Oct 2026 11:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gO7IPcqLrFEWEOoy96XApYXMLiYFAPQwyNhaDg8j/vtOGMQvWzpdagnBcbD6V6JiJV7kjfR8Kknr8+2wOJKCE/VdPBXNGua29bgRa3/lOrU+vTX/yV3ZdAq68qFzlTXj/g2hfwMOdpns+hMKsulUt5Ln1mwUZjFJ5QncdCqu/11JQtMspXPpvd6Mnr5RYGKnuDC6/dfh8p4EmB9DxpBg60pptSPPJKA5Jduj0Ov/+lXn1kPEqpZtAvNrR+Hwt5axpnD1I7gaQcuy1Wagdr0ete/7lrXt8YKvVAi0+MQBVGdN2OOdkRJkPgWfIIRSNVTPuP9WWW6Xu28Bjxla0IvIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwRIT6tsLKZKhQ1AhrPMTEaSN+BtWR9IMuZudsiay88=;
 b=BOAIdlA1JKJTslqDVHvKmrQ12mlqxN4k+LxE12VPHdn3h6pLG4iolJdonPYe6oS3O5y1n4Twb+BAU6gu21zngU3x7R8Zms7rVXFWlH5Vhv1jEj6fZCTAIWsaBXviw9xqwN9Tas6ING+j0ds+tu4iONHPKey/RUgEieJUeB66zmua0A1NplctCYZlNxl9fkF2EdKFf2LGCeLp/Vm82S9qf6czb38Z/QqcXHgBjHONrbE+thqB7oU6CguZrXMGiwQdN1KSIg7qxvNDcnHqClBzQyh5FoimpXYoY/oILYYdCEVMn0TqrxtW33ThsUQTzc9pBh+4hNu/iLY02sufP5IDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwRIT6tsLKZKhQ1AhrPMTEaSN+BtWR9IMuZudsiay88=;
 b=A5iO1VmCjmsFujrI8+OwicKUz9cyrPHegPxNAOUt3a7IOzdtoZ3ezAK7xZ0XDNxIhhfJ9w4CE82Ch7MgbrXVtbyTj2qmq9mySQbreASNcO8WqaBvhZyzdj9DscPd+DOD3iK7jIzESZFQ1sftIR2fJip8oNmw1Pwmz68zo79D29+oqm/+8opuH5h2kjaGO7wS2/W/xDOLoO6hZ/X5rZpoSbg9VuwV+U/SQAAYaa+Tg8lSJY8TpuhXRlz8S4raHSoPwol2l24RRm2li2GoKX7E/5XGvwmi3cYVLzCp5W/4fC7zimG0srGXOJSMPWkDyhaeaT4UlqfjLJCg87HVKcRkjw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB777192.namprd12.prod.outlook.com (2603:10b6:8:411::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 11:23:18 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:23:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 20:23:13 +0900
Message-Id: <DMI4UK02HZB8.1KEPETWUOZ7E5@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: <airlied@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
In-Reply-To: <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
X-ClientProxiedBy: OSTPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:604:218::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB777192:EE_
X-MS-Office365-Filtering-Correlation-Id: ed127568-4a2b-4109-b692-08df367831ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|261026140227099003|261026121527099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: KoYIjunLq/r7nvtlwv8qPUA7ArKUIl2W+2gyYYYIg/kZsN4tqZeEEaInBeTOVKH0h+FZ24UsCz3LpSBsitwVuS6hbBDHaAGZDNQX/ZyNuIVqvgON27m5T4klrS/uSovszie7QGPdD4Iys8Jrk/e624IjqZL8Qq6a7aob14pTZO7CAJQ8D5rGNlXnlCgflAHEjrNMG+M582M5M4ouaijJb2VsJU3ZLqTSGyhUrPiIMPgs8zJQ92l5xPQBCvv0Bu7Y5xolSi/21rlyZtb41YUABfoVTdxHB0e2n5kFvB/pYKVmDyorB3GwENKr1RzbJF54LUE83eMv3AmuW+y1U7XOEOzaagox1g9GnLEotSRRMO/Q2Gq1xtIR7pthxOETlQJAXTwx8QQmjEp3LRZqYPFLrId/j+t1cuEBPVPfowMAn+0RgFeBLmQFkv8/a6PY2C3iMTo7fVIpv6tirDdfc51A+vgm5ZA10GpregUBkQlO2cTbrwxK5xiKFsq/HXFW+Z/Q+tI4HmIEinIby+iVx67LLKCyHTBssC2Gj8aqPMGo+9t/+201mNeSqRot/1/DNUNTR2D8gOUIt+tWHH19uQlHnmGd6d39ZXbq7yqS6J5BJuhB/e2ITgr0w6XCUJEVZcZTu6fV1KQjO4n9GEPnsoDDElHS5KTn6AettqY45GXfK5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUx4bE5ibk5UOGZXbG5qb1pwQjFyK1UyaVRDTmZ5ZzllY1plSUpIdDNEdUZ2?=
 =?utf-8?B?ejk0OHgyWTd6T0N1Vk9UT2JUSU93VXhoekRRVXFabnB1K1l0Q1AzdUUvdTEv?=
 =?utf-8?B?c0pDbk16N1ROeVd1UnNVTk43R3ZCZ2xJK0Z3TmtZV2hzTEdGWEcyYlM2N3gv?=
 =?utf-8?B?c2Q1VnhqSEwxM2QvQjVJTXdPS21KZGtPRXpCZHdvNFZzL01KSUVkREFBS2Qv?=
 =?utf-8?B?enpqUDJJVEhoMTZ5Njh1cGsvd2xSY3JjTGJNRzZHSGltZkVFeFNGVkd1TWlK?=
 =?utf-8?B?VlVBK3NxNzQxNE1YRGZKZkhjTkVoc1ZvaDR1TXRaSFhiR1F2U1BUVlF1TTd6?=
 =?utf-8?B?RERJakhlVFNseVNlaGpRSVB6c0kxelpDaEdrRWxDMzZ0cHBmRklQTTloNytO?=
 =?utf-8?B?cVY4eXhsakpaU05VaXN3YU4xeVZPMnJtd2V0OEEzRXUwbkJJZlUzNFhQL0tH?=
 =?utf-8?B?OWo3VFZNbmhTckh3cTY3MWdtZ1ZRdDliZ0tzZFROU242b2lTSmVneDcvUkVZ?=
 =?utf-8?B?OWFVRFkxZlJadWVPaGpoOGlxMEZOa1ZIZmdEMXVUNE11SG15M3FodjlWZEdh?=
 =?utf-8?B?S0svVEp3YjlwYlZ2ZnNFb052REl2QTZGOG5reFF4SXpoOVRjMGdPY3pidFkr?=
 =?utf-8?B?QW94RGRTOXg2VGkwaEtxQzQ2RURvNzl5RnlOd1JSWnptaUpBS0pSWkZSUFN1?=
 =?utf-8?B?U2ZZdkFjNmdVaDNvQU12SDZzR3l1cjl0RVhTUG5qeThxeGdoN1cxWTFOZ3Bh?=
 =?utf-8?B?a1cxdE5rQ0JSS2xnclhVQTJ5MjFXMG5YOFluRVQ3YTNwTXZDUFozU0dOdzRo?=
 =?utf-8?B?Skh2NjRTZ1JnUzlSd21wRldMeldHVWhUSmgydnNDQStxMk5qYWJzRVoxc0Fz?=
 =?utf-8?B?NHFoRkVmWDA3VS9rS1pXeFNBd0lrSWJMZk5BQkdOTTVjUkJGNEZMZHB6ajdL?=
 =?utf-8?B?MzRrZktQRGFNOUlqOGQ0azlkZnNHMm1hM0hYWWlrdFpPSjRiQUp4MlZOeHVq?=
 =?utf-8?B?bXFCeHpjZmZ0L1o0R1dQYWhxVVo5Y1hleUUvQVM1Q3VpRCs0eGRGOUhnMDNS?=
 =?utf-8?B?U0ppVmhIVmZnRGNUcGtwbXdJK2tlVFgwd1pUZ1FsdnlxajhvQ3gvV2hvYnVs?=
 =?utf-8?B?elNubjB5cFE1eVNwaktkcDZIU1QvazQvanFucFp6OHZMT1lYSWt6R0RMVlBp?=
 =?utf-8?B?cW9QRWJwL0l4VkVMZUZQcnhqZUlNNWxSVW94Z1ErblpZdGNQeGRIWWZNU3BN?=
 =?utf-8?B?aWJ0TmhybnM0SlBjZ25xamlFb0YvenVjZS9nSkJydEc5R2gwZ20vb0ZVSXc2?=
 =?utf-8?B?TjVjU0E5RG14NnNuZW9xYndQbUZjOWFzZXJJQm1GanhUbWVpS29hTGxvRCtD?=
 =?utf-8?B?L3ZEYjZpdW10dHdGaG5STzMrQVUvaTF6d1RvSVB6Ty8xaEx1WjBLcmdFUmh2?=
 =?utf-8?B?ZnIwUitaSUYyUXpVL01vWHNDZWVFd09jSGU2NitNSFQ2S24xK0NQc0JKMHNj?=
 =?utf-8?B?c0R1cit6OGhycVMzRlhtOEo2cXJZa25MZStzOCtTRG1kbmVDMWZxZWRVbGxE?=
 =?utf-8?B?TkVHVkVHWGtoN0FJQWhoaURrU3pyS3NYNGRxVGFyQ0RJQ1dmemRuRjVmL3hX?=
 =?utf-8?B?UnhOYVBvU2IwYUxTdTkzdFlpMTRQdEFuS3NKL2dETVQvK0dYYXlSK0U5ZjYr?=
 =?utf-8?B?Vm5XQk5CMWhGemlXc3JZVmFTNHpJQWJmS0hiM3J1Ly9LaXd5TVlKbGo0Q0NJ?=
 =?utf-8?B?eWhpbUNWY1YvUWFsYVZuVHVRSnZSUGhHRTdYcHcvRmJaTzNWcWxadnJTWE1o?=
 =?utf-8?B?SUQyTWpGWFdBeTdSR3RIN0U3RTZBK2Zad29IcWJxZ3FBUVVQR2w1QUZuTU52?=
 =?utf-8?B?ZTRpWjgxVHM2U0pMRGVmRnpQZGRYdUc5TGVJMkxOeCszcWxBOTVURlQ1cEhD?=
 =?utf-8?B?L3N3ZkU2VjFDNDFuNzdTcnpDQXZXd0l5V3hmRngyNHQ4WlB6aUYxdnJSTi9P?=
 =?utf-8?B?UkprWWdsMHpUbk9FMGRPV25iNXBTTXFYTlp4UzR5akw2UnRxcDBBbGYrenF1?=
 =?utf-8?B?QmFtM1ZBODU5VUFEWGlGOGg0T1RHeFlCODFzR0FqYlNwMmdDcnF5dUltSG5l?=
 =?utf-8?B?U1BvajBxUTkwZWcwTmk4UjBEVUdGeHN1VkRsczJZWUpYL3BxT1lFSlZqMFMr?=
 =?utf-8?B?NzZvd2N1Rzd1bmRZOHdpYlRXNVVVSzdUTWorbFR3TXg2bWtUekhTWUN1YnJj?=
 =?utf-8?B?M3pVVTJlV1VRZXlvYzVnS0tBU3FmeVAvMTVwYlJMTlA1ZEY1TGMvWTlWMWNI?=
 =?utf-8?B?Y25wbC8zbEJ2SG9KSi93NEc4SHZPWEF0L0YrS084UU1oak9GclluOFhjWEpY?=
 =?utf-8?Q?btWhFAfECVxWcCfCymsQpwwKPq06LlF3TEs8LJVYTAdUt?=
X-MS-Exchange-AntiSpam-MessageData-1: /pzSuewTtYkinw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed127568-4a2b-4109-b692-08df367831ff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:23:17.6491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWYmWCdFY9oJo+dqWV7yzPouXVeJ0E3xcLYP7+p7y3OdBjBZYX+94NlrlwNqFkjz9YiCTtVJpyLhqU4qcYGwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB777192
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 30, 2026 at 4:57 PM JST, Eliot Courtney wrote:
> On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
>> From: Dave Airlie <airlied@redhat.com>
>>
>> These aren't used on systems with no framebuffer memory.
>>
>> Signed-off-by: Dave Airlie <airlied@redhat.com>
>> ---
>>  drivers/gpu/nova-core/gpu.rs               | 15 +++++++------
>>  drivers/gpu/nova-core/mm.rs                | 34 +++++++++++++++--------=
-------
>>  drivers/gpu/nova-core/mm/bar_user.rs       | 14 ++++++------
>>  drivers/gpu/nova-core/mm/pagetable/map.rs  | 10 ++++-----
>>  drivers/gpu/nova-core/mm/pagetable/walk.rs |  2 +-
>>  5 files changed, 38 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
>> index 4e59072cab50..5d53fde2cdc1 100644
>> --- a/drivers/gpu/nova-core/gpu.rs
>> +++ b/drivers/gpu/nova-core/gpu.rs
>> @@ -564,18 +564,19 @@ pub(crate) fn new<'a>(
>> =20
>>              // Create GPU memory manager owning memory management resou=
rces.
>>              mm: {
>> -                let usable_vram =3D gsp_static_info.usable_fb_regions.f=
irst().ok_or(ENODEV)?;
>> -                let buddy_params =3D GpuBuddyParams {
>> -                    base_offset: usable_vram.start,
>> -                    size: usable_vram.end - usable_vram.start,
>> -                    chunk_size: Alignment::new::<SZ_4K>(),
>> -                };
>> +                let buddy_params =3D gsp_static_info.usable_fb_regions.=
first().map(|usable_vram| {
>> +                    GpuBuddyParams {
>> +                        base_offset: usable_vram.start,
>> +                        size: usable_vram.end - usable_vram.start,
>> +                        chunk_size: Alignment::new::<SZ_4K>(),
>> +                    }
>> +                });
>
> We should probably add a helper method on e.g. Chipset to say which
> chips we expect FB on vs not, instead of proceeding with no fb regions
> here for ones where we expect there to be one.

Typically "a helper method on Chipset" means that we want a HAL method.
It just so happens that we already have a FB HAL, and a `vidmem_size`
method on it. I don't know if a vidmem size of `0` can always be
interpreted as "no framebuffer", but if not maybe we can rework it to
add that information, or just add a new method.
