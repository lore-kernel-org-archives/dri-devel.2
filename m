Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22FFC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD5C10E785;
	Mon, 28 Sep 2026 05:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZ1utFvb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8F510E785;
 Mon, 28 Sep 2026 05:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbRp4md4V+HAl3rQ+cvd1xBt2BijF98kvrMhbCQB+mLYLC7XemE1Z9Ibxzdc6MRWAZKF9AZbzpUdVUtSyEk6Jv5s81RoPT2G0+ijF7mEyZRmvXuaU4dsoSVtyJoLVcgfqmSPWOnjJrrKa5D6jIfWpRVKQf/cfWU9nUFquDhf+GuAQcDtV9hXxpHk1qZ+vw22cJH+rSxC4Q5+SFPneg0/D45536CVgORheNgXYVRNQX/z9FyyZMEdJk74olpkgOj/ri3zx1/FBQs1HLo8Znb8UJBG8XXV+lrH+VEXRUwDisRgrPWT7TtMDRDCXQfWJeOk7tKVkoJPOAw9GHTV+kxkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNgis0wFkQc8nr25tD8bZ9lg2jxjbl12HKRaNzRBs9g=;
 b=nchaWzyLluy3Fg7SyqONHvVQXtCVXHrptDsepGCy+81B6T9SqXNxCYutfTS/A7sQPe8MOw2qxe2NFYmYG8IeVWt7zaKaBjswReuQU6Xs1HlwzrbFLUVLKL7BE3HfLK109AK60xC5jmUGC9Lhu08v8PIw15WTlBUGp6u4RinoEPcozl4VxYyF1mpuCeH7d+GOHSY1Z11Q2cL93ZuHJee+ZkhMJoamX6j8UhhLfVtDBdQZmrL2rda33e/HFuHCFw3ukYYdsLu7aINsTlbtKEYKaRIFajP0ldQSFPSff0+LuFFUEP5/6Ywx5b79yixmPJTAphoFIeQUwTmQNJ5g0d109w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNgis0wFkQc8nr25tD8bZ9lg2jxjbl12HKRaNzRBs9g=;
 b=VZ1utFvbLBqxZVyMvgedUIxDSt+zc9k5ygAKfLaPz6KLs6vWFJb3XRl02fL5u1+BZScMBdIeGztQqlMXp/o5wwQlVITu2f9nkcUrJYi/D+lVrfA61fxf8zFjBZBIq49F6QyFAYvkHo/LTRgp8o/iHu3MUD+e6Nt/kt0lfL0rXUrcDmkahkyyL9fW0OLhyMInlUALnEveUg3u5dbeGDrBp6pPfKtHC7763TCNYVG6TDVG/o5RG9oF5jDLN8e4UiCjB1AvMEpB/G9Su/E0BcYDpLqLthymp3wxTizGSxOGDwlF4UWBvyP+QI7bdQkIem3Rf8HcXJPv+Qc6tav+HX/m0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.23; Mon, 28 Sep 2026 05:40:16 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:40:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 14:40:13 +0900
Message-Id: <DLQPII0C8P8E.1UAQ9Q75TO16W@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] gpu: nova-core: mm: get rid of Arc<BarUser> in
 BarUserAccess
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260926124405.604707-1-dakr@kernel.org>
 <20260926124405.604707-4-dakr@kernel.org>
In-Reply-To: <20260926124405.604707-4-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: c41c134a-f250-4e53-4136-08df1d22f9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|23010399003|376014|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gEwh3Wek7xbkS5nLy4d+hAMAPbDeOvhJJqc2UmDZvF8p/QOQJ4ZyQxTT5JzbnR/eFXA2VRvE7aZ6R+MXrL5W++2up07iaSEdd7yfzuOcbteYCmAk/CxL0eTYfLUAnlw0UlhLW62uUAWiRyiQ/s5bd8ZlOyjzTQfN6sKlYF0hiK3P0Vv3ocK3dSb0zUEaKHsmlyv/jCL8JznvMJ9EScxbl9tz36TUEgJJeNGJbHMSx4O7mEhJ3eaMxwoBASEhgWOy0h1akD3BJxDSdoGbOIZ+2ZRbw/AlW7HbKIYaCOlfAjmkuw2pFirR3W1NQt9ZQ71qKCWsLGQ4DfQ+UOvv5nW6hBFUfC+MfE56RlduF7Yj9kXYwQkq0hLvQ6a5JDMZITIk1yvMEivI7mjGaCfv3yK8UFH9bBeuAYczIlSJoHIxHteMh+7gY17vngUxH7Ujk0Fs03nvXz3MBPByyb9MVTnDB+KxmM2s6IktDYepjrY5iIFgY70A0nL8S6sJ3s+cdUb5/v25mdEOt8xTOhL6LTj1s9mzFRosyFjCTZ4iY63Mnu/BubN5q+mTbmG9xmdVOU9AEG2s+6PvyionPw1nSCuBdtuDWzpOQ74WG4y21m1pqSTf34RkjJ34mJk9xt6QqFsT5DFrL7NrPLnrq2/Jz/eYnFo4nhJy4Z9OcbT2cEIro6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJUN1ZpcnpKR0tsS0pqZTVoZVQ2RDd5Vlo3R0NOSERiUjBTVHNoZUdUZHpl?=
 =?utf-8?B?ZmE4TVpST3ZSN3JOTGFXZ3BZY0preGdlOWlDWEZidU02a1oyUHN6c1pESnF2?=
 =?utf-8?B?UjNQRWU3QkZISDdsVklUUlF3VnJhdGNXWDBmd0YrdG5PRE5PMGNaTlN1QW1x?=
 =?utf-8?B?eVYvRVA3eEd6WU1rY1BGVDVyTmxiNW9qS29NKzZPb0JkK2ZVTUxNWTlHNHFk?=
 =?utf-8?B?ODUrenpzRWE5VDJPRWdUdVBCLzF2Tk00eENFZnpYMjVuT2l3NUxTSC8vdE9s?=
 =?utf-8?B?YnU2OTZCWGlUSFJsNGxmcFVQYzlEbkU2L1NjMHFPS3BoZUVBMGQrR0xlY0Qy?=
 =?utf-8?B?VStpaFdvL1dQNURFMjAwTW0rVWtETk03bHNhbEY4WUp4anB5ZmFhWmdmZGdx?=
 =?utf-8?B?aWJBaWtDYWJ3dmRGRzJ3QUVwak9yTkxVK0VTSmdXMmRnZWxUaWRvUjR0M0N5?=
 =?utf-8?B?OVROY3ZCeWhYRkR5SkxpWEFUV3JwNlJHbWpQeFdLQVM5Q0hCYTNydkNMd3RS?=
 =?utf-8?B?dWxnVDc2TFFVWkhaL3hQb0J6Z3VibUcwWlE2QmkrTEJyRjQ3WXNrRTFKQzk0?=
 =?utf-8?B?eTR6dEpBc1lJUHhHamY3c1dDaUN2WVFoaGR4YkV6N0lWbjhoYi9ldUdNaG5J?=
 =?utf-8?B?VmIrbDVYQlBXeDMzajVmdnNBeEg1M1ZoRmtvS3UxNWl6ajZlMWp1MWMvWjJn?=
 =?utf-8?B?ZGtNb3c2MDdJOGtEdmEycnJPLy83RWFBWUVyZ2FVTGZSc1Rod3NCalN6YzBv?=
 =?utf-8?B?Mzl6NDR5bFFLdXJmeVdYL1JhbENWb3pNUldzUTd2SE9ZU3NWcTBvcHFuei8x?=
 =?utf-8?B?TGdrUEtLVFhxS1h2SjQ0c2dFNmQwSjBzS1BZYk0xSjZRcXV4OFNNays4QUFI?=
 =?utf-8?B?c2dEZFJHYW9tdGlWcDRJVVNqZWVpTWl0T0RnQ0ptUGpUMGpQSUYxUDBZTkw3?=
 =?utf-8?B?TWZRNnlLTnF5RVZDZkRtZ1ZXck4yQnFBcXpwVjd4eGFsZzFzRThRdTBVa0E4?=
 =?utf-8?B?RVFIcWlDYzJLdUxPbm5jRmJOQmNaRHFzc2ZPZ2lSRVNMWFZhTnhuL0UwUVRh?=
 =?utf-8?B?VTQvUU1zamh1SFlLQlJmc0MyRVQra3diYTBIOVRpbmM1K2J3T2hWL0x3VGo2?=
 =?utf-8?B?UTA0Z3dKbEJLSitYZkNLZ0gva2J5cHhMOGluUHBoY21zOTJVT0wwdS9jazUv?=
 =?utf-8?B?ZytjMGlEY2U3NTRLekRjTjArRGtnUWliMG82dnZCOUkxV0xyQS81ckl1VzIr?=
 =?utf-8?B?dFp4VXRheXUrWU16MkZLUFRPQ1VlTFE4RzUyNnA5NEF6L01Xa1lnVEdaS2J2?=
 =?utf-8?B?Z2JnWUZFbFFCcllKQXczSktBVjNZTnFxMFFqRGtZc3dwN2c0blJPdExJclha?=
 =?utf-8?B?YTBvbGhQUEc4RURUbDdPaFRnNFNnZ3YrSEo2TmdRcllrWVpXRXJPVG1aaU95?=
 =?utf-8?B?TGFROEpES0g4MnlzYXl2RWNEZGVVZlFadGNDelUvMXJ2SkZyRXpZdy9rTHNk?=
 =?utf-8?B?elZYeGUxcm5CZFJXT2FNOUFFQ3p1ZWJFLzVMY0lWcGZNMTJFNHRIKysvQUor?=
 =?utf-8?B?R2QzV0NEK0FQcHk5NFNudmdyVFZpSGVKSXd2YnFQaG92dERkVVJqekRjSkpS?=
 =?utf-8?B?ekZDQUZQZGg4OUMvaVArL1ZVN1lScmpTZDR0TWFLYWxUeCtQWDY2VXpyb3ht?=
 =?utf-8?B?RVZRU2ZvMFFUb3VDRWtNeXBpZm5xZjkvdHlpRjh0NVRDMUhsM3RaTHlrb1dj?=
 =?utf-8?B?eTZXRGJlZCtockpyZFFrZlJ1NUJqQjNxd3FIVkgyT1lNbjZyYzNhWFNaNXJW?=
 =?utf-8?B?aWhnRE96aDlTM1k2bFpqMFMxbW0vRExDUDI4UkY4TVFXOGhKRm0yKzhhSGZC?=
 =?utf-8?B?WnU1V01tVWoyYUdiYWVqT2FZNGFvVzV0RXdFYnF3YzZGQ0M2ZTNsZ2NVOUpS?=
 =?utf-8?B?Qy9qanNDV25JOXpXVE9xb1VnbnJKLzNlM0tCWFdodzFUQXllRXc3NFcrODk2?=
 =?utf-8?B?eGVheXBYdnRKN2Y4bXFYbEpWSWU1eTZYNDZIZWg3dTc4alkxbC9qbUQrcDMr?=
 =?utf-8?B?aFIvQzU5T3ZabFJkTndIbHpFenV1cWN6aUE4ODJ4S3Rhc2tiVTRrUmU2RnJu?=
 =?utf-8?B?Y2w1enl2WG9HTk9mL2UrYTBib2pMV1ptUVkrRnJhRVgrMHhlNDkxRWd4UVpN?=
 =?utf-8?B?NWw1clpTd0FZWHBEdVIxQkllQVhLN1U3Vlk0NUNzVHBYSWwwR2NqMWlycUV4?=
 =?utf-8?B?SDFjVW54dk82L1pXdktibGVPTE14eS9NUVpPSVNpQUdlS1lSd0RJNTU5NEdG?=
 =?utf-8?B?dHFjdkpvWnlHTEJiUzRwb21lSG03cTZzZUlucTJWMWxvQ3Vlc1FuWW9Yc3NH?=
 =?utf-8?Q?XYwWYWWBoNJrAs3Ers3uOMFtEenziSyL4iTHNLnQZa3/P?=
X-MS-Exchange-AntiSpam-MessageData-1: T4mnMNcby82mcA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41c134a-f250-4e53-4136-08df1d22f9a1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:40:16.5381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1ej4nYbGw1o0N3w7MJK2JaeHs3TFsSJBUc+2NQovVuzxxP17GmKbT1fT4jnFhPn+vwuoy4+gDY/M4ankqLX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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
> There is no need for a reference count here. BarUserAccess can just
> borrow from BarUser.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
