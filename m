Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A0CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 01:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E142410E42B;
	Tue, 26 May 2026 01:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dBA+pnkc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9743510E42B;
 Tue, 26 May 2026 01:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAJYjhRpGhxBk4xQCFy+e0Ku+PMFUmeDxrcEqaVu02gvlUP7r5TVI9O1wrXTpHe8HL6jcjAQYdDDvPjhK/EMgd5rcQFnJgkz7vWBqmuhXkl8qivskJ+Xq4bW9lkM5ItJNGZDSqJ0uC0xvI0y9+8ziFeyZHToGIdm67auZLrwJ8GC+NV9HsT/1Z8CUQiA5S3zQ3JfgPpJDINDDEvp4hIp5XWTANWyUTMB/awGSumHPyPCG0ck7AHsZapRGtlgsPxM8vvVR3uL/eyNKvkQthGQVkUAGuaUS3jVA9vozJhUHcn6ZBbk5X9avBcuU8f6mrZc0Qz24MPaGPZfN3mkABAYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F/GBqK/ImWt46g+QsqdqGg2+3qb6KE/wH7r+1DT8cM=;
 b=l832vXA5OdTNTCralShYfp+DoLDT9y6IqvAAQ5kF5g0u9D+/GlmFiswaC5EOUlJ3T1qbMqi9PF1E73CXgEBlIuWyvPIVOZesgSwsImSFwh33VrNQqrJMreoV9eK2Cdex6Lz4bDFZN9Xtn/skIlWaDzCeCX4NkeQzgfcPfJ3RKJG6A3h8SCrtZIT8ZggybH6m4jnoy5YwD24ou5B6b0nwLBzmmpKwHMTVZfpWDBdT1M8CDDFcTdekihWDgKwXaBVl+2WJagsK2qKkJdSaa4wTO1Fyh8cz7YSDRpr4H495Vt2MGx2r1SKDoXYS0n7Wux+XSRoeKvqQimGJUGQTLNWVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F/GBqK/ImWt46g+QsqdqGg2+3qb6KE/wH7r+1DT8cM=;
 b=dBA+pnkc3+itCVe9BmcGVIGd8RGfYcYFvBCfzfOKFHy+kDo+tm20MjgtaTwNK/QD8+rNLtVk3QWv4x7Ub714Tfwxmi8JdUV9kfGZ/pdGvYHpuTSGc7DymJ1pBsbCQUYZhnPAnZeYAlRdxD9gyjXOA5oJ9YCrxDAp1CPPF0X9ATqol/h5OhELr5Zm/Yk+Izti8NPuozPE4B20QVxhbd37fkHkrU0OQVA1UjnISWuZmPhEXbCpbFPmc6+ZTN3U9AQuvqvb3OGr95Dte1OphBzIJLYe33CW/NfpFAzLfmQVubKSEWhJ9oo6OhADQGfi4Q2XOfnMK+XB2jZyxd23jhfh6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 01:17:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:17:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 10:17:47 +0900
Message-Id: <DIS7NGV7P5H6.SBXIJFMNH3ZY@nvidia.com>
Subject: Re: [PATCH 1/2] gpu: drm: tyr: separate driver type from driver data
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <deborah.brouwer@collabora.com>, <gary@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-2-dakr@kernel.org>
In-Reply-To: <20260525230152.277820-2-dakr@kernel.org>
X-ClientProxiedBy: TYXPR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:403:a::31) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: d649df06-5bf3-4f80-6088-08debac49b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|56012099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KB2Lgbf43APIWrJE6osgzcMD7rOgIgpTOlCAuapxwPTM0xnSRqaaiXZXCk1o1KxqjcdbP6jEzjeZDiWkUd22hwhOtumhVLoZyic9CFgRFvuGsoiCH88LgOY+FOBOZ6Ejy9RDLfHJsXYC9zZWLh6S8I0aOEhMJB1fajqI0oC3ohhjvZmq3rQTdGXpAEcWHbZt6BSLCTJetJkAyHX/+IAeGD2oPpBjrdL73bCkaSLkXM7xEv6aCUIVIGzEX+3WWQqQbMutNX/MfDZz5hTayHa8RnDA8YX5T172oVad/WNpsTHypImecXRybz1Kb/v+XlHByxAgsYGr5iWbjWq97hwPGzvBggwtaBtOXv8jNMOlXBGpOze6LeA6WZS9h8gn1bIG2ZHY4BjZ38r040l2ulk4PoEY4g4M1K48Sl8jj+rv7EmkQTDVtVsVvTJQCcDC0Q3Nxz17OrRBd7E+DYIvXhwNMyFpKXMeiQIZAbCkq4btQjYVfimWnGHacrsuK9Xz+ayYw1wWLfTiI1SEkJejl5qHX71dr9YungNFfGlqsNW5J69h+QF55y3Ni32CMS9GrfEcMg3f1uRdsDOjlj3VrZwQ0T0/aQFgNQf+3HYCAb59Yzwgv1qKhZb4fZ0w5SI7r0i5XS0BYt75XwEqLIZmRxc9GxX+418p97YhdRigeC6Ak8MOhPX1XiWVcvJVPXt+1+RW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(56012099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhkeWFBUjQvbHkvSTlraFZDTDd6Z1U2NmQ3bkdpY0xCeDhxSDNhVnNtYWZX?=
 =?utf-8?B?QVhiajB5RkRTT2pHVFhoQ2diMVRzSzNOUTZWekFVcGE4SWJaMnJ0MDZmTHgv?=
 =?utf-8?B?Z2FDKzlvTjlEZ09SWXhvcEtuQVhKLzhQeVJyL3pNV0JGa0pqMnFWNmhIWHU3?=
 =?utf-8?B?SU5LR1psSWRQdGJ1a2cyZFN5ckI0Q1BXQVM1S3hTbFFHUkk5d3p1bUJuSTg4?=
 =?utf-8?B?VmpDK0g4cFJWZzFSaEN3Ukd2SDlvVkxqeGFHaTFoYWRwRTUrRm0wcEFpMU1V?=
 =?utf-8?B?QnlPWTBUOUZucXNIRHR1UGZvbUJNSkw3bU9odmdncE1IRms4SUlDdXFZQTJB?=
 =?utf-8?B?MkZ3TDVteW9pc0FnZmM3ZVRMdTFua1FFVkw1YWNsYkVWenFuYS9hV0owRjh4?=
 =?utf-8?B?UFlLQmhGUVlOZmpSMDQzTUQzN3gvVTBtOXNVdVpUUnFVL3VLZXF6ZDJkU1pL?=
 =?utf-8?B?eWU5T1pEcU5QUFBwSFRYSTZXTkhVMTNxZHZTbUNYOUZZdVg4eVpkZ29SaXU4?=
 =?utf-8?B?S1NqUXVDS1BuVExSdUdTTTR0VytOWFh4MTZ0QWxzRXpLSmdFU2FPY0VUeE5F?=
 =?utf-8?B?OWtnck9Xcm1FOFRKR3NwM1NTcGNhdXBMb05zRnFCV3AzbFVwd0VZVmx4OE5Q?=
 =?utf-8?B?TlVBclp6eFF4Q0FMTnNNTEtmNTFwTytyRTVNemJxRWY1aSsyd0dGRHhydStL?=
 =?utf-8?B?eGFvUGxCZXUxc1pBdUpPMktrYjVGbnIrdzNpMGN5U29QMzMzNEEyd1c1c1Vn?=
 =?utf-8?B?empBY0F5NXZNaktLV1N2azNGSjF6Rk1Jblo1TW5FWVNSM0dkV0VhZ0FaTVEx?=
 =?utf-8?B?K2poOFhzaktuMFZubDhvaWRCQTBxczJta1pKcUxLeU9MUjlyUUE4Zm5mZys1?=
 =?utf-8?B?RlBKbXovRFN0bTQ5VEpBZmMvREJySG9vU29CU1JubGhvckZMWU0rZ1dpSzNT?=
 =?utf-8?B?cGtFditTckUzbHZycW1sbTZLRWFJNHNPVGo5YW9BRHdCMDI4RFRCbTQ3WFhJ?=
 =?utf-8?B?UzN3ODR2b1hsSEw2alhYMFdGY0xtcWRXZWdWVnV3b3V3MXliMkRUSXhOQkNM?=
 =?utf-8?B?a29OZFh6Uy8xQTRuSW1NUWRQd0JIZDdTTmNEdzhJeVJsdjNCeUNtYXRPbUpy?=
 =?utf-8?B?NDVURVJBOXZMM0dsd21XbFRrZXR4UFFEbWpISElOdXJrN21jVXpld1QxT29j?=
 =?utf-8?B?cVI1OUcwQmp5MGxnWlZCSmZYc2swRVZ2MWJpQytXZHdaUUdoOGJrRWhEbHVw?=
 =?utf-8?B?R1BtNG9ZOEQvaGNoNVBiSUNrM3l4YjZVdW1RM0hSciszL05XVmpGTFcrcnEv?=
 =?utf-8?B?c1NwRTN1YUJ4N0kxRWo1MEhDN0hFUXNpVklZRDhGbEtUWCttaXNFM1pIV2ND?=
 =?utf-8?B?TkI4dzFyYVU4angrd3dNc2cyLzJGeDlBU1dSUnJ2K2hsZHpEb1dES25oQXFN?=
 =?utf-8?B?RE51SWplTDJzZlFIT0V4bjVndU1rQWZHdDFXU0wvdTJ2TUVzcHJFWXRFT1Bw?=
 =?utf-8?B?ZitKblFrN1RqVmpmL0RoWlNUWHdNNWhSRnVqOVBNalFBVVV3RmRoL3phenB4?=
 =?utf-8?B?NEo5UFRjM2k4OVdHYnlBbmk5dUF4KzN0YkNoSE1jU2RxT1l5ZTl4S1hNQUJO?=
 =?utf-8?B?aXZiRkZpdnFUZm9vZDZuc2lIMkhGM2UraWx6T3pvNU5Da1ZOeEp1RmRYcUxo?=
 =?utf-8?B?Y3FYU3Q3cE5WSmVaVVI3SW9ZVmpiZmZnWVdVV0ZWelNncU1kb1cyNkU1SnFC?=
 =?utf-8?B?OXZIQVdKdmNTUC9PcjFORVhnT3gzbmlwMzhETkxjTS9XMGhPVW85Qk50YWtX?=
 =?utf-8?B?L1N1L3NFcjNFa3g3MkVkRzFpTnZUZ3lqUU9uSkxkN1JtdFpiMUs4ZVhpYWlY?=
 =?utf-8?B?elFXdFY1aTNrTHFlZGZoR3A0SkpBcjQzZWdJbElMK0ZSUUV5MUxRWm1nMHNJ?=
 =?utf-8?B?UVZqMjN4cWhPYXQ5SVRXczArcHBTQjF0ZGgwY252VHp1WGtoM0ZOVlhWUHVE?=
 =?utf-8?B?Z29qVnhkUE1YTUZ6T3pvbUk0dGRpYlRPZjNLTWUzNjBXU3Fkak1LYlZxVWlq?=
 =?utf-8?B?SkgxUVNxbEszWHJtWHI5UXZ6U3VoVHU5YlhCOGVwenMvREJKNEVkeUVEbGlC?=
 =?utf-8?B?TUs3ek9lUHhsMHdiNjdXQ0VqdFlZVUc4QlhaeW1WL0pTU2RzNVpHZ3NlSjlP?=
 =?utf-8?B?NmVMbnhad3pDWnl4VjZwaHZFbThPUytNMFJ5WkZDUmFkcTc0c1BoU3NvS3Zh?=
 =?utf-8?B?dVVKemVHZE9xdnZmRFBJeHRvVnBLZCtKSlB6QzhFdktkUEt6T1dHVWkzR2ll?=
 =?utf-8?B?eG1IeTV0cHMrRFpRbGE3eVdwbDhaK1hHNWd4NE1MdW9hRzVZT0pFZzF4Mlpp?=
 =?utf-8?Q?IRZqpYVDuIf79g/m4mTjwoQAmaVYU8YYnCKkXkd/mN7Wi?=
X-MS-Exchange-AntiSpam-MessageData-1: LjfAsP8h/wYAPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d649df06-5bf3-4f80-6088-08debac49b2d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:17:51.4200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrvVE3oBSVJDMTis/UeMoEB7FWJ2IgYpwYN9rOD6atSUOdo61pCaLhfkSedYW6kPQe5CDZTG6A7S/0hhio0ueA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
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

On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
> Introduce TyrPlatformDriver as a unit struct for the platform::Driver
> trait implementation and keep TyrPlatformDriverData for the private
> driver data.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
