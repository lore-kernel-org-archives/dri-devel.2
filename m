Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7425EC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A29210E049;
	Sat, 26 Sep 2026 15:34:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DfBjs4LT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CFC210E049
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9G3rht9By9Ienenq14MwYVQb+me/htPHoDeymR5BktZKAprq4WL7plrCIQCULR05MpdD1pF3x7PpWr/TQKvipy8pl5+gq2GTXq66ZeV6Of/bu54fVmuCyM5E/8Ekc+n1FvqaYjaVUPtT+f/CpKFr6oQwRul9HTx2tM+rQLdR8tyxiowHUF6J/kVvw0SFcKMOwaSlfKkZCPCpJJQAwAFrBQe/3u/+DqGS7oxKA+ccbHn7eo0EGNTCd/vmIxq4YnduQejQCnAjmZ/rb1AcWAQ+PnIk5EwQT+Femwdu+NR5EHOANJlYCEGCc14Z9z+8bA8wnu77iQtMRR6oPDny5A0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqP2Lk4uW83yrNzZ6RibMgF19It1/vGLOkq/IQWQE/c=;
 b=qti1fMUNSgxkzjmyMlfj2J9TReCDUwkTyckrLAn2r4q4Xejh3JQFYikUDHFVgeHTYWLjJLyXrGLGQzzR6YImMdOd0Y7A9hGXDLeYoquBBhqzMDHYEqtwUiB9//A87QsLvmRFIE30V3k+RIVtLXy45q9qDxG+DoIBLCBOC/kpi39D3/K7WaJ2OtGztFGIqmp4Bh6USYuiQ5E80DUb+UXDir2y2c3pXjnx5t4+05QnSJIMSXQagipWizG7eUl1EbrtSTCQsLab8hNYdLYECFTv1aH+h3G7OoKzAEFHGSWVlnIKJuENueBUeZCXPAiJ3LXt+IUFZWnfHs/+VTznE/5bhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqP2Lk4uW83yrNzZ6RibMgF19It1/vGLOkq/IQWQE/c=;
 b=DfBjs4LTbaFcWmRj4VWs2C6pHTwZesKwRQpICL7X93tWwPO829Ife33tc11YtWYFmSzEVnrvVewr7cSx1YDob2WqGL44Sx/VvtlsrplK9UhlgHBzQa/6xi6nFrbfL522ExwfwwMxLwX9uqu5SFQglODC70+9eX9b+8xaRKyWTtHGcBDx7WqTBZnSYkZHrKXKRFjhYfPz8MFDYjXy5J2QvOM6AXsnIkUuw3liS3QUM6HINNxaORZ6tW7Gy3/x+a3eFvLlKYTvsKINnXsk0XutWOwx9/1DYmYb1kfc77ZZAiDsNDZCZNqj8r2ULIp8JASeJQ0NAAL8st4LJygj45uEQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB600424.namprd12.prod.outlook.com (2603:10b6:8:499::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sat, 26 Sep
 2026 15:34:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 15:34:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 00:34:45 +0900
Message-Id: <DLPCWMGBSMY2.2AYCBL9WM5OGU@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/4] nova-core: align Bar0/Bar1 and remvove unnecessary Arc
References: <20260926124405.604707-1-dakr@kernel.org>
In-Reply-To: <20260926124405.604707-1-dakr@kernel.org>
X-ClientProxiedBy: TY6P301CA0001.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB600424:EE_
X-MS-Office365-Filtering-Correlation-Id: 75852f98-5855-4593-e790-08df1be3b2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qg+NeoN/GqSfHn1yJ1lOKZPPq3Z21bTPRZ41soaSYRx7bRV/VFLLJn+h4nBOQLjcardFZ8KORXskSGJdXpDhSILRNHpho8UaC/aIa4tC3FUm41ucIQ9fQciBpW5RW5evS35lIB5Tz0Ji2rGTaFWCdQWfG/YEXJvrXDtY7+LPFlq2THbPhH0SPAYcO03joy5O7c6dTbWWaE2GdxqcuZMkwTRp8IQob2SUnm719MS9QNw5PyTo6KRIgjgTnm56fe4gcw2a4hKyx83o6c9Q8OwKQL/h8sirgrfsxO6fLdUaF3fuJFVfjapVHwDsKigzRCE7nFQK5/jxWWatQ/yobFVZ9QCwkvK3iOF1jxJrV/Jf8/sOqjT0YbQ+GNHTfTyViXyKzOFIlAIkaukpwXIWQtH8DCcYW3yDFspNsMGOba4I3VUJAVsHv+ypKP4hY8CMKsTjSqZfS54WcOuGZJqUcjEWberNbg+t6roNBjs/UgQhO1Y3XnVhzDS/oHfJjo/AuL1+KttN9TfuRNVDJpwvuZDIJs0QOjOtN/gWa/1dxICaUm5K1eOAYbM3VLV15+pQj5uSkxpOwo6x6sOq3QIhgH2KTTS1tFPkqZSC/j16u75lIuYyRXTUBa9idNVXg31AOxnTn6SJymUiLJkD2eG0tzn/+kcWl4GZFQZa6yvHc3JyHeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFSVGhxQWlJNWVyUVcwdUNMOFdoSTkrWHVoWXc3Q0tkd01mcUtnaU9UTXlB?=
 =?utf-8?B?Wnk1aVBVUkpDdjhsOFJiQXVQRzEvTnZHLzRxWlZPT29LMG0wWlB1bGJLQko4?=
 =?utf-8?B?ZFFPNjRFTzdrTVZ3K0V3RFRqRWVDL1hVSXFPZE9aSEFlNjN0S2svdmFHMUpL?=
 =?utf-8?B?Smtsamt4azVzc3dJblFKd0FLSUtmSERyZVd2amVIcmVOeUtTbHBESnRYMXZh?=
 =?utf-8?B?akV1Nk9zck1aYXF6aG15NUx3S3Q0RW9QVjhvQmw0bll0VUN3R3pMY0FqT2pm?=
 =?utf-8?B?WEw5N0lwbHMwNDVmSWh3WStRV0RyY2lic0tMa2Joei9QZjNQWjQwdFpRbUV4?=
 =?utf-8?B?aGMybHYwNVNTRCtTTWdPQVZ1MjNIOG50ekRveHgwa1I1SkFCdmpHejJrR1Vl?=
 =?utf-8?B?VnlvR3FGMXlBaEVWd29pYnBZL0ptbTV2eVBLRlArc1lkQTEzZlhzWmVyMXR5?=
 =?utf-8?B?bXNVeVNqSlBUSzc3Ky81RFpLS1IvU2V6dFFmMEE0WnVkZ0tvamc4TmZTUCsx?=
 =?utf-8?B?WXlKTWdzZUloLzY5YzMzb082aWk3U2hZcC9OTjVNVldTd3JDZm9VWHh4aUlk?=
 =?utf-8?B?Tkt0bTRLaURPSGN4R0kzYzdkeHc4dGo0Y3lCbGRFcHhlcG1BYjc5dFpWNTJQ?=
 =?utf-8?B?VlhUcGxKeG1DbE5iNG1CUFBueStqWWxNcjQrWFg5NnZuNyszUzRCQW92cTZE?=
 =?utf-8?B?ZUM5TUlXODZ1YSs3aW4rRU9qTHd2UUdGS3VSM3ZDNWprakVuTURicnN1VitB?=
 =?utf-8?B?WTJ6alU2dkpMRmV3Q0NrMC9wZ2NHUUVtbVU1ZCs1ZUxqNE5PUUV0NzlTM2p6?=
 =?utf-8?B?YkVHOGF6Rk1xV2h6RXcrNk1BUVF5NFp0bmE1STNIMW5tR3BYRzJtbGlET3NO?=
 =?utf-8?B?ZTJFNXc0dk83T3YrYkdLcGNDdnRuTTV4a1ovTERFVy9KU0NTRnVZTjI1QlNW?=
 =?utf-8?B?aVAzcjZSYWlhR0hCNXUxaGZDMk54WkJSTnNUd21DaTI3V0M5dWVkbVZrWjh5?=
 =?utf-8?B?bjdRR0RxejdSTjlhNDREREgrVzdUUWxVYWxPa3Q2RGNteS93TTM5cGNyN29M?=
 =?utf-8?B?ZXhqT013L21HcmlsQXA5bE9rU1RLY2hhUlRaQ0Jlcm5zM2hRMjVwT25naXdh?=
 =?utf-8?B?KzJkV1FhNHN3QmhXdFg0MG5PWjh0U2NRWEtLS2hjYUJYbFV6WE9mRUFqMVN4?=
 =?utf-8?B?aFgyYXVSME9CQU5mZUI0V1JQb0FScXl0Lyt2VUFBb2RINzhUUjU0dDIwa0hV?=
 =?utf-8?B?NmhBMURJd0V6OFNNU2YwSS8xTUoya3ZsYm5BSEFmbHprRUVlcUpxVytPUXZL?=
 =?utf-8?B?ZWFqcytxSTJhVnJ5ZWxDRVR4U0ErRlRVSW1uMDNZS0JIbk5mUENtMmZlRitV?=
 =?utf-8?B?bzQ0SW1MOWN3dTZQeTZRWXZPck9pRElZMWlOVzlVeXhWVTN3RkY4Tmd6NHVZ?=
 =?utf-8?B?djd0NDZ2cHd6R0pKTlNUSzRZczVmRWxUOWNjR2NOMDROTUFZVkc0aUpabTA2?=
 =?utf-8?B?UFJYRW0waUdzMTY5cEJVYm1ZUHVKNXlEZlZrWUNic1hiU3NkOHgwZUcyZWdH?=
 =?utf-8?B?Sm1uclVJb0pOd3ZsOHloazdKWWRiTW85U05jWnBoVlFwRHhUTjVOSlRQZmt4?=
 =?utf-8?B?eXQ5ZlNUQ1ZUbnk5U2ZBcU5QS3NVd3dpQU80NzNBSE11Z2dvZ3Vmd2dSSHMv?=
 =?utf-8?B?ajA3Z0oveFlyeERXbkhWZlhpNCtwZk0vOVpGZmVXcWpRRWFiT3Y4ZDVwWmMv?=
 =?utf-8?B?MmZ0cG02YWN6REJmMEhQbTQvUFNST0tQREkrT1BpL3hoNk1VcGFHcnFSazBH?=
 =?utf-8?B?bmNETmxlS21JMlE2eTd0YU9FOVVPTHFjVmlDK1YwNDZFZFFMd1FXcEFZYjB5?=
 =?utf-8?B?RjFGS0JNdE0yeU9rQjFqQUtjVkRWdTVTVFRaTzZtaGR3d2FUaXJzeEhBcHFL?=
 =?utf-8?B?UEtQK3cxSy9Vc1hEVno3bVRBWjdjNHNoSkg1bWhyaG00UmZxZ1d4NXpLZDJ2?=
 =?utf-8?B?cDZDSllJVXlIYlhGczBjVG5FTTlvd3ZzL0UwcmlZQlg2WXkzZS9paVFUbTlo?=
 =?utf-8?B?MGJQNzg5dTMvQTQyUnJkeGhOU0lWOGdkQjdSN0RLQkN6SFNuSmF5bEVua3p6?=
 =?utf-8?B?bUFBdHB6UHB6OGdDTFcvVDd2dmd1S2J2WllVb05TUlF1OC92K1ZNUDVQSVNG?=
 =?utf-8?B?YkZrVkUxQjd2NjBSMHF1U01GS3Y3dGt1Vmg4ZlVSS0ZSdFFsZVQwNi8vQ0U3?=
 =?utf-8?B?R056K2owcHMrQzhWcElEOU90b2l5VDZqOEpZQW93cHVxcDBOclhDN0x6OXZ0?=
 =?utf-8?B?bEpxM1VUMGlYWlJEVVhpVHZoRHo4TU5kK3MyRnAyYk9PajBrZWtHV2ZwQWN3?=
 =?utf-8?Q?RKHNd01ghO53IVju6fVkiQSM/YsfKaXp4h20/9euQo1Oe?=
X-MS-Exchange-AntiSpam-MessageData-1: LDbNxWfuo1XZDQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75852f98-5855-4593-e790-08df1be3b2ae
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 15:34:48.1706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C1ggsYdrkudFwiN00RDTbiZ/5qsdAOyMvCEP4rU2rZVbx5Rh1vbI5IFtUO8LpjOE6j/WC6On90xYr7ZuT+Ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB600424
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

On Sat Sep 26, 2026 at 9:43 PM JST, Danilo Krummrich wrote:
> Get rid of the Bar0/Bar1 type alias inconsistency and the unnecessary ref=
erence
> count of BarUser.
>
> There's much more to improve, but this just crossed my way.
>
> Danilo Krummrich (4):
>   gpu: nova-core: align Bar1 alias with Bar0
>   gpu: nova-core: remove unnecessary Arc around BarUser
>   gpu: nova-core: mm: get rid of Arc<BarUser> in BarUserAccess
>   gpu: nova-core: mm: fix lifetime name in BarUser

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
