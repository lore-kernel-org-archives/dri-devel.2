Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0416CDB46D
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 14:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51110E200;
	Sat, 20 Jun 2026 14:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBjkh1se";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0628310E200
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 14:06:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSN79arcrHSxbGpkFp999N2fp5Amh57YgvoQZRXS0KI3yY9KLX0GuEgEEsuxz2lAEMkICAGKAozfeCe8l2Pb3MX6zonrBm2pPGmpAuePztnkjA0FRJA7KjUVV5O4YXLVltoGB95nHR0tWzchKYPBA+6TlMSMBQt+U7PiSEVlA5ttByGlFdvMa+kJR1HW/FHF5jS24t1BhvFKZbqUInfV5cQ+byTtKYSPj/GBY90IMQ7sKAjUyz9GGND0Jnja2QyfpWAyNWwtuHEJslDC+WMJjMZwwfmDv9Pvzf2n49n+cpthRaPgRKBLF2XjEDrBixocRHEoSo1kVEZI5lqgKl8g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBSArwqpUVuCQaj334fzOz7WSfHgwboInF4NERyZkO0=;
 b=BNi1ViMD8yGtbuO9pGkOet9XYniRiNe6nHory3QBA8C4B/sPRUehnfOFhSjLl2F3AVk1pXKJvmrfe5R15T64TiIUaHebQZngH0o7Yg6DWvY0WX1aP7ZKz5+AZ0IPBkqSftFoMsaO08MwJYub+KkkY99cG05PKVSZcG/M57MwvCP7cz5h9iyz3BMAZ6YLI4E5Xcrp2R7NosTp8Te1IcaH3CeNkxvSkU97bRzXPz3WT5Il7GP5FWvjTVpMZYKgBFu3+4GhoFC2JDx2xjDP2jvvPdPbgiMU+3h+M7Lmr0uwVdm37xCfDXg6wzNzJQP0VvMB9bpgyuCLh154DyLSMO4rSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBSArwqpUVuCQaj334fzOz7WSfHgwboInF4NERyZkO0=;
 b=OBjkh1sevIBP5OfgbCiYIyVcS6XP6toUcg5qSPm8uQPkdqpsiVhnfHvuUCm6empiHGimF3tPtNg2BpE7VdJsLglx+ZBuMZ7a8RzjOd2QpEuLTtIyPq4dwP6gLWsRpQqL2c2BvWwVB6mCiQyqdosi8nSm1zBqkRzCJo93oFSx+TNf9+5kq0lZjHn0HvbzFPm+n1Y5+S8p2uFZj7uAAJv1/iBgkY2qvv9wCJdgxid+yWCPZ6cQEtiaCo8wMv+np1j2KOsLUED5UtT8LXZBtNLWJ7rtqgwajr6X91qOzua9vq1oyLxx/aW8UmUB3O636JysuN3/T+Z5adMeoO5uobTyPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 14:06:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Sat, 20 Jun 2026
 14:06:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 23:06:08 +0900
Message-Id: <DJDXNDGXLZZY.8IEHLBTRKCQO@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
 <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
In-Reply-To: <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
X-ClientProxiedBy: OSTPR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:604:220::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ecec389-6d37-44d2-a4ca-08deced5153c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8vv1syf/1wLOFpe3Kn7j5EFuZJWn2LnkufR20a52RA4o3BdHoACC/hDnOzaowIKY77aiWWdoEDiwCOCmgIkFfFB00YWlbIjxgAMT6m6bAlbD48iWfRsvnrKosVv34yY7657t5lD8wzaZG7vM8DU5v1LrYFHPgIG1UdKrehG4Qi5hgM2HRjASD7H0W+ayCEHUeN8qVsg2rItp8bTvSCFQcFO786h3ShOz15NM3lti8RSSO+dqKyjMNQCFZreAllaFOn0On8fb+QWTH1UUEcFIAXu3kY7HnuIz0D20aSxTuG62/KNdJTH1RupOx3qsKrMmW0bhjXdRdZP45XvLf5GT6pSNz6ZylmBiyOnbkJnkQorl6alo72xerWF8GWGSPhj9NTE5MEcLMxlx40yOkc7Apl+Pzu35c3q8qUtg6VphzrNqSOV5sNOqcr4t6sus/L5atw9jss0QIMdN27m1CxPIGfdSXXKLDN+2PwKaMzkmUuQ92Gxb6IYZMzysP+j7TBmo4oVSY9zFuKBExFhYRCB3kbV39O9MQc4nAGoQ6MFC05VFH+D3/kte+/BWOLbnFuFYADVtQ3gshRrYieDqjwzsgszdloTHpzkbIbQoReOp3/rvbq604P8L7o58/VkSuvz+myjYErvGVuiSwaHU6KbkSxw2xvSqzMJUYfviacnCECA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRZOWFBWENQY1dnaGF4elhIVXdSdHFsRUVOWURRMTg0NUQycXBWZ0NXaXQ4?=
 =?utf-8?B?T1p3MzJHZlkzbkhuYTVBN29ZU0FWTUtyWEdRZWVvSFFoVHNnYzhmdllYcnFS?=
 =?utf-8?B?YjdQYXcwNlZobDB5SU1JUXAzT0NzcUxjbm0wZXR6d3FUelZWV0x4SEhRSlgx?=
 =?utf-8?B?Ym1kRTJYbDZpTWtQK3JOUlZSKzBsNElHN2dYZmtOOUVodTRyb0xsWnM4MXVy?=
 =?utf-8?B?WmM2VS9acWEyU0RNL3RZRUs4dlBhY24wQzUxYnh0UmxWMnczQVJVb2Z4VExS?=
 =?utf-8?B?SlNaOWFSRkJZVWFBSW9qSHNNR25WTGRHRjZ1Zm90RVRKM2s2SjF3RjhLRE1n?=
 =?utf-8?B?bWxSZFV2b1FaODFScWtWRkFuRHRoVkRheFVhZS82dzJWME5pZXovWHlVdVZh?=
 =?utf-8?B?Z2NxcitIV25oWVp1ZnhYZU91WUVJSTlyRUIxTFQ3VFJsVVNlS05vcjJGY2ZB?=
 =?utf-8?B?amlnNkNtSDZYQmxoWE0zYWtidmxMbmdpWWU3N1J4TmhjYUgxQlhJSUJ1b3Y4?=
 =?utf-8?B?ckdjdGcwenMwbHFzSDhTN0NING0rMHU3ZmRtL25mZm1CZXFXeWQxajNEU1Nw?=
 =?utf-8?B?dFBZcTRkeHQvVEFQMTBBOGpIVGp3WE5Jdzc2LzgxUmd6RjN2TVZKTzBvSERz?=
 =?utf-8?B?UzhvL1gxTmVhcThWa0k4UDJiWlgxVFZodjdOSEpubEJoWDVZallZUzJreGZk?=
 =?utf-8?B?S1J1RVVTazhlNTU5TU1qTTloZWVyVk9YL0R5VjZUZnBZVkhZcUdvVE5lTWlR?=
 =?utf-8?B?RW9ZWXdCNG5XN0FxZWFrdXVDazNaNDJXc1dUSWFsU0tIQ1RhN1JtRnp6NWVW?=
 =?utf-8?B?cjl3UU04SkU3QnF5OElQZWxJU1RLTVFvdnlVNm8vaysvOG9YWk9KV1ppRVF3?=
 =?utf-8?B?b1RDZXpmb21KcWxhOUJvL1FxaE5sdW94NDhzVFJMZnJ2dWtjaTFPOEFVdmJy?=
 =?utf-8?B?Z0lsYXQzeVU2VXk3amtDV0dYeTloS0lIb3c4NlM5TXlVZ1JzUDFia2NHTWIx?=
 =?utf-8?B?WHBuY0hkK2JpVm1vZkdqUHJERlk3M3A3bjhQZUZHaHVzVnJSOTgrZEt1enNW?=
 =?utf-8?B?aVp2QVJzQ3p2ZG83N2VSczhESThOWVFZVHpBQ2JGdCsyRHNBWUduMGNFRDd3?=
 =?utf-8?B?YVFSMnJlQkUyak1QeHEwcUZETDNCY0ptYkcwWjgyQThwNnNqRXBUcWFyVnFs?=
 =?utf-8?B?T0VBc3VHRGhaRTVobjRma215RFdQT0ErUHpTUlJXUkRodUNrT00yMzhvdzh1?=
 =?utf-8?B?SFhCVTFEay9IeEFRd2h2emRDUk9YTURhYnk5NERLMXhZeFFHeTgzT3dkem9y?=
 =?utf-8?B?NFJSOVB0d09hRXRxVGVPVkdJeFpFU1BuZWpLZGZxRmpMTkxYbVdDRHFSZmg3?=
 =?utf-8?B?ekd1MDIzdTRtek9lWDFzQSswR3NxRXpOei9iUjhNZGpINytlRnZYU2VhbXRW?=
 =?utf-8?B?N2U0enNsQmhjZkFlbEZvR0xNeitGQmpwOW5YTHFTK25qV05mM3FMYVZkdjdw?=
 =?utf-8?B?NzVUdHhrNVlhY3JlMHIwaWZHcjd3MGJieFk1L1BZWGdpZysrcHJrVVRjYUNZ?=
 =?utf-8?B?ZXU1TEpGY0NRK1NYWHRqVXcrMnIvQk5vWGFpcmYzZERtS21lT24zamN0V2Ew?=
 =?utf-8?B?Y21YMWxpcEV0QkVuckk3alZCZVl6dGZNdnJHWmZaajZsai80VHF2RStueEFx?=
 =?utf-8?B?UmhNZ3BwVFVmdktSd0t4WTVHZUI0RlM2WlRDSjc3WkpyeUNSYWMxQk1lMlg0?=
 =?utf-8?B?d2xKbU1zeVdkZU9EZG1IVG9UMUhwQUdBV1BkdzM4bjcwMjBSb1hYcm1ueWpi?=
 =?utf-8?B?b0wvblhKTDhzUTJqZm5xSDZ4TUN5OU9NOXM1Mm9EZ3gwZmpmcFRaWEJGUGgr?=
 =?utf-8?B?NDA4RStyU1pKcW9rcldrWUhNMk9PVWZpL2dXcGw2TzNPS01lZ1lHV05nNDRk?=
 =?utf-8?B?cWZoN25hbkJXem0zeFlLbmNyc3UzSS9VSy9PS0Q0VmlYdElvSG5DMS8xN0FI?=
 =?utf-8?B?a0pjYzRCdExLdXpPRnl6Vkk4alZyQzlpUmxybW9kMTJmV0lrWm56c1ZQU0dQ?=
 =?utf-8?B?bm01bkRYcGpKWjExZ2twcnFhdDdISzlScTdjdXlWRzFjNG9MTzR4ZmpzZ3pG?=
 =?utf-8?B?SGNVMjhOZi9Jc3dQZHZaOW1YaWMvVVliUWYyZHN4NUJub2g3VGFlNXVwdnNV?=
 =?utf-8?B?ZkZaOGFMc1RWaWlYTUZtVlZmQnVnWFZDUkx0ZXoza0pmQk1CcUxjb01VWmM2?=
 =?utf-8?B?MHlxOSsxdTQ3SE80eG94NVpsNnJoL0tXOVRqYTJPVERPN1R5R3luWG5nWU9V?=
 =?utf-8?B?WDcvZDgyMzVxeDFEd3lFbVBHc0g5TWdMcXJZQmZSZkhiVjdDc3N4TVhjU1I2?=
 =?utf-8?Q?fDr7qgabWMRlWNZWbjdtO5HOy20ByFtuK4eCI7Y/oNLMC?=
X-MS-Exchange-AntiSpam-MessageData-1: qiIr4ZgCmkUVgw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ecec389-6d37-44d2-a4ca-08deced5153c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 14:06:11.9022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGbUt5+lOS66M3ApBsh+bLpIm/SFT82Ggk4QRPJ6YLyFu7857iVfmNFr2oPljSm3DqLVPviZD4/CEr/0QCHM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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

On Sat Jun 20, 2026 at 8:30 PM JST, Danilo Krummrich wrote:
> On Wed Jun 17, 2026 at 3:24 PM CEST, Alexandre Courbot wrote:
>> @@ -377,6 +378,21 @@ pub(crate) fn new(
>>                      Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: =
{:?}\n", e),
>>                  }
>> =20
>> +                if !info.usable_fb_regions.is_empty() {
>> +                    dev_info!(pdev, "Usable FB regions:\n");
>> +                    for region in &info.usable_fb_regions {
>> +                        dev_info!(pdev, "  - {:#x?}\n", region);
>> +                    }
>> +
>> +                    dev_info!(
>> +                        pdev,
>> +                        "Total usable VRAM: {} MiB\n",
>> +                        info.usable_fb_regions.iter().fold(0u64, |res, =
region| res
>> +                            .saturating_add(region.end - region.start))
>> +                            / u64::SZ_1M
>> +                    );
>> +                }
>
> Drivers should generally remain silent when they work properly, some exce=
ptions
> are fine, but this seems too verbose. Let's use dev_dbg!() instead.

Right, it seemed useful for the time being to display some information
since that's all the driver is currently able to do, but I'll change it
to `dev_dbg!`.

>
> Also, would it make sense to (rather) warn in the else case? (I think Ope=
nRM
> treats this as error, although the check in OpenRM checks whether there a=
re no
> regions at all.)

I expect that the users of the VRAM regions (i.e. the MM subsystem) will
not be able to contruct properly if no region is detected, and that sounds
like the right place to raise an error rather than making an assumption
here that no VRAM region is an error. For instance, I am not sure what
the regions layout will be on Tegra systems, although your comment about
OpenRM seems to hint that there are regions defined for them as well.
