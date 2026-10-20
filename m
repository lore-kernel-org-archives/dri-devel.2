Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00740606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Mx07XBtT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5F210F1B1;
	Tue, 20 Oct 2026 02:08:45 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010034.outbound.protection.outlook.com
 [40.93.198.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE7C10E125;
 Tue, 20 Oct 2026 02:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2EKE5apUxcin/ATbjsK3l0c5u3tNwluNw4/ybrHwZl8ErT+rV8TFnWwPN3/284zYYsfs9Pg/GKTgngbOtJ+6Stz5X2HDO8FeVSdTolIN58cmgS3kihejM+etG+0sTFs+09wgoDEpE9BPFE9lZ1IJs+KWIXHmgmAASyHq0aXvOfqkpak9DZMXvd6sGcDhlRTz7Po9LjHaB8IH8SW9aGclGsGBtJaUK/0tkDvuESNw5mwbU3ktIry9ddi0AjTS6ONEHpUJ4BeY7eVk6kQL4RI16eBTJStKn8/tKG+BYZliD3zTqUxw7UwMUPQJ26ee+bmVe8ZcdtILCc74WXvgzEL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLH263AfoM7YgZmlVKMqHIp4wTcwqrZOSngI9TtX4xg=;
 b=B5hipw8lOPG3E42OysNprg9OeFdbet14VP6x2e5e6bbyH/89gptQwm2RRP6cIFyqOTUigk306Y2NqX/0cMNbBwcDZ95Hutz/HovGW42PQmwefLAlu6QtEzaEf/g64WDsIroMVp0zL0MRkYmFWtNY+UsdAUp4fJx+MtulktZIdsMm1uQXAeSQfUsOSHRDKJgKzko5LN0kqetar/zY3kMciXeJhxkzp6La6X6xy40LxnYsxtqaTyvY3yLn1PyYRJFz5Xj2H5UZ283GzlMM3whh++THbsuy177YNRMQFB9cy30CqeMfj0nDpqobpBvCajRt4w8p+K74Bln/TKB8bq8MhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLH263AfoM7YgZmlVKMqHIp4wTcwqrZOSngI9TtX4xg=;
 b=Mx07XBtTihruhr1NhNwmoS5Go7mVM5dlaeXhGbX3GrXu16sVDg/LPLyAWNO8pg+0LOD3YdMgXe8yguCKwBh9L4CBtF4j3xAcCaALORlhAGtpjhdV5RuszSbc2OymmpBiWOqcZgeR6B50KPPiKj4LB0T4jj6LinqcxiQMfCkUzrA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 02:06:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 02:06:34 +0000
Message-ID: <daa45533-29be-47f7-bbfd-67b3045b63cb@amd.com>
Date: Mon, 19 Oct 2026 21:06:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix amdgpu detection of pci=realloc
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::7) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 121ad041-c417-4db3-3c08-08df2e4ec459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jR8qxme3fyz5CeofkFvt/EbQ9g4dT/3vR15JM74NdV0dhL1rZZu2DPyXX0s6LKTgEpmJGen7yO5Bl1TNlhnVj1UCdAIBqIlUbZWkt5q5vgXGNN9emHXHVkYuJcAZV0oRhMIpW/6znAp7st/rX8beson4lH7E8oVa3I0Q5OtBH36Y/xtGcTwxwRciV4CA1Fh9uQ6IILCSKdAPXSGMLRuPydNmA5A6x7P7mi6nykbTG/xY2+SkmAA2QA+PmZP7y+lIcdUCr3rPFcdg0UChXCT4SlOCOtwZd7Su8qlkiEF5PlNQSv99jS/Ajd0Wp3/ISuw0nFwqE30y1im6ZWw7P8dVhiUr77753ybDlEL2SEYTE5N2Ow32W/d1Py7iC36VqNcev30sAWsD31Q4mYRyF2ap6aSfhaAK6N+Q0G9rMOMmPF2dTeSqcCsuOaWMWW38psBm4hj2yGvFAMiAqRebtWQqId0alGZtVVzsVCDJRIE2gl3wLEvMC4e+Q3OJVYlHSjhv4cksXSu7GsKPzMTLjIEvwOWjh/8ytAJhZpMDYBJtffC/ecEdA6pY3kQow3zUG8DM035yILCF9p3F1tHcGMWTBH2C8r8YSrTqe2y0B9b2rNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEpqd29oWlFkUHRqVEJlbUcvZTVSWUNid3MvWGpLUWhMZUxsaFh3Y1lYclZk?=
 =?utf-8?B?RmxIMEk1U0xsUEZGdjVCN0pyYUZ6NGluMFJuNU1LMkZPS2pqSWdHNHlvL01M?=
 =?utf-8?B?WkpCek1XTGUyVVdJNTJGNTJLRkIzN2diMkFiUkR6S3p2ZjlGZjJFOU9FY2Vi?=
 =?utf-8?B?NkhTdlZEdk1kZHgyanBUdjVyNWJoaWdTWDJkOXFaTUE3RzExZzBZeFhzZG9V?=
 =?utf-8?B?VmVBdW1lOFJrbmtWRHFwNmNoalRWM2MreWJUT1ZZeXZ6SENZaVV3aHJ5UEVY?=
 =?utf-8?B?NFdDOExycmJOZm5UNFpxa1k3NTBjTjNoeTNKclgvbmtUN1NSenpuS1FJNmdK?=
 =?utf-8?B?WGZtcVNKM1drcklocjQyRkdUdE9WVFZ1Y2h6RWRvOUpNVXI3U00wZlFVbWFm?=
 =?utf-8?B?enA0d0hWeHhtcDJrelJPQmp5Ry9udmRxRW9DeTlzR29NbXpaemV4dkpkZmps?=
 =?utf-8?B?TmRsaXZXRDEzUncxTHphVFg4eUczbHAwNUEwdForRVR3N3lJWStKdjNneXha?=
 =?utf-8?B?UEdTUzh1VVBuQUZ0LzRHdWhLbmZIbFNpWWJZQlp2T00yTTd3WFlqbnFoZ2pD?=
 =?utf-8?B?bDFaL0o3ZjJVUnozR0pZVzhWNzNyQVUxK0VBU0xZV2tXU2t1a1M1K0V5VUpB?=
 =?utf-8?B?RC9lTE0yYm5nT2lIRFh3ZndnclBhemkyYlRPemlkQ0V1eDRqS0RvNm04TnFr?=
 =?utf-8?B?dmxLbkV1a0hOMWtHb1hNckFVTEljZjd5TVdEYzAxY0RNZW5BdFBIT2JHcnE4?=
 =?utf-8?B?V3JIMnJmb2M4SWUxaUk1cjMyZGtoaWhTMkpJelN1bElGeU5KQ2JkRGVQR1pS?=
 =?utf-8?B?OFR3aFlBdXBaeEVrVUplcGlzWHF0cE90U25hcmU2T0c0bWRSOU5QUjJ4MFFn?=
 =?utf-8?B?RWFYZ2hFL1pTZWxnT2ZIamRuRU8wYmpzV2dScHk0MDRIMm1HM21KT1ZwdHZ2?=
 =?utf-8?B?VGJ3SjZubWc1RzJlU1ZHb3ZnL2xJcnJtdFpSczlQZCt3OER5dDNtamJ5V2ts?=
 =?utf-8?B?QXpxcWZlN2lhTmZCK29aYTlobVRhcmFOL1AxRXM2ZEZOekh5TjA0TjcwRjRr?=
 =?utf-8?B?enpmWVBBaVJ3cEdBT25yWjhlRDVmam5NSFFPU3FQLy84S0hyZEtJc3JzSENa?=
 =?utf-8?B?aUFvdGZ2TCtnQUZVVTRIZy9ma3JiRFNLNXcxRzhRZERxa0VVTUZSamRQcGlN?=
 =?utf-8?B?bytjNUtoK09yRmZVYTNYWW9HT1BBQ3pLZFByaW1tRkV0cVYvMjlBb2pkRzZW?=
 =?utf-8?B?WXJpNmxNcklvR3VVNVgyWnFKSndQWTd4STVoOWliRlllV2VuY1FaT3p6WkRN?=
 =?utf-8?B?OENVbnZOWDRqYjBZYW9EV09oeWpnQUVqSUFwaS9HT0cyV3p4b29ETktQYml0?=
 =?utf-8?B?RmtxYTR2czhoMlFiRTd2WVh5U3ozQzBTRG9iTFI4RDREVDYxcTZCK09JUmxF?=
 =?utf-8?B?dlBaUHZmRlZ6dHFCcEdpTUx3ZDVBZHlpcUpUL0tRNlNnTFFaTHVXeUlENHgy?=
 =?utf-8?B?bUJWNXJva2hzd2NXa2FSOUZKNmNUWm53bVBjS1FxTkprbnFGRkZxN3FSMGc2?=
 =?utf-8?B?dmNnNndDdExNdkxWUEh3ZnQzU1IyV0RPQjZZK2g3RWFhRUIvOHU0bzBZeTJL?=
 =?utf-8?B?UklNMVRjSDRLYWxnYU4yZ1ppZUZpalpOZXhHb2lZbW1JWTdML1N5dkNOampr?=
 =?utf-8?B?M3N5aUR1ZDY5cDhkdXAvdHJmMXZQS0pmRFU4elpORzY1aHVVeWRmSlhSbFhr?=
 =?utf-8?B?Zy9Vd2tmZzBRaTI4dC9LZjM1aEFDanFKNXEyeTV2Wm8reFJZZ1d2OER1Y2Rs?=
 =?utf-8?B?UEkzVitiNlNZSGw2bWdkdmV6Zi9PVXRSREdIRVV3VDhvY1lRblNQeUtoZWRa?=
 =?utf-8?B?K0hkc0FhaTQxbk1uN0dwNVpYMit0WHYydWpUN2ExVTJicW9HdHdIdWcxT1JL?=
 =?utf-8?B?Y1I2YUdsYUhudDF2T1djeVN4Um1Pbk8xa1NZT0Z3ZTJEUmFwdUdwaDd1cWV2?=
 =?utf-8?B?eEFlTWk3T0Q0QnJCSDdiWjdwQ0k4dXprNGFMWUpONnpISDF2ZiswTDgxNkdt?=
 =?utf-8?B?eC95QjdTMVFCd1ZqaGhlaXNZQ3JUbTJPeHVkaG9aUEZ0ZzdDOGloeDdMVk1B?=
 =?utf-8?B?UUNPTXR6T3JxNWNDNS9aQTZTTUlFcUg1RHVtV3FUb1JvRmIvRkVmNmIxeEdx?=
 =?utf-8?B?dFhNQndia3NFTUZZSmVtanI1WGtpWmIrRnRTTmdhaE5lTDY0NE4rWE5mY3VM?=
 =?utf-8?B?VU50TzBqWXdTR2U3cjFZMDJpRDM1TVp3K2srdjlpdUJ5M0xiT0JxeGl6aHN3?=
 =?utf-8?Q?FjLcenBGqp/a5FhrZw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ad041-c417-4db3-3c08-08df2e4ec459
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 02:06:34.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zf3+5bfvF1YXpHqoI55GKUlWNQo2W6f3u+tGiL+E9HPM3gGQfVfBxRa2ltX2wKgvDDju39ouhkqQ2Cxsme8ASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/26 20:44, Mario Limonciello wrote:
> amdgpu needs to know the bus number the platform assigned a device to
> be able to match firmware images against the right device.
> 
> This was previously adjusted to be a soft filter due to
> commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with
> soft filter") where if everything but the number matched to take a device.
> 
> This however fails when there are two identical devices.  Instead save the
> initial bus number to the PCI device structure and then match that.
> 
> Link: https://lore.kernel.org/linux-pci/20261015124843.203905-1-mario.limonciello@amd.com/
> Link: https://lore.kernel.org/amd-gfx/20261019194106.2796150-1-alexander.deucher@amd.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Mario Limonciello (2):
>        PCI: Preserve the initial bus number in pci_dev
>        drm/amdgpu: Match VFCT using initial PCI bus number
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 17 +++--------------
>   drivers/pci/probe.c                      |  1 +
>   include/linux/pci.h                      |  1 +
>   3 files changed, 5 insertions(+), 14 deletions(-)
> ---
> base-commit: 87bba57a9f33e2b5e90d4ad70973675333182a2c
> change-id: 20261019-vfct-regression-2142fc52852a
> 
> Best regards,
> --
> Mario Limonciello <mario.limonciello@amd.com>

I think Sashiko is right on the feedback.  I'll iterate further on it.
