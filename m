Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006CECA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A35410E2B6;
	Thu,  1 Oct 2026 19:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmfsRD7M";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C2510E1CF;
 Thu,  1 Oct 2026 19:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyMe7caTqfJojSv5Pad9FTe2gaJgPOisUwvGzJfGK4+BHDiNjTfVbDPlKO1jMk1eg9dGV1iOj2LKpXg8c8YsAHZcr7ksullJFu4EiAFDeL+iH9ohWNyv6y65A7U55BGmUGfHQ4KdnqZhOqWG63jj+aie/hX1zax6VEiff5JOyv07HIS0NAgk/qxhAEh2jgi0gKlsxLy03W2CFBvXow2xjO7e4GA4Pn7dSIG3Lj3BRPt4I1rPcweIyaLWyezWGnxSQ/FtNvw4Dp6pH5HIwjPj4UIA+F00PlzbZf4jq5AHsZr9r0A2d2ogb2E289iuYYBLxbk+zyDvd4Q6avk1fnloLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rWfSkr9TveeE4fhXkpWfBwJjxxGbqu8i1qdhwoRxuA=;
 b=EfOW9Y2EtkniRJXXmJZVMvCj7Xbq7UbGEx4FajOjSFLaOBtiA8ZZSJIV3ndYIGRvOixTzxRUghLmxg3OORrWI+fNLhlIht9RjgXhNHUWU5uq/QOjfdwhs6qNf2aMPzUrW2G62Q+qClbg71TMAOKBsG73yq/mwkOQRMw7CcBGKXoRvR9GED3oPNcTYEf8QBVOJ9nj6aU8x4ZsgfC6hTW9xrAhW+F8rsSIJJVVyO/Lfq+R9QENLA0KMR7URyeHkvcts2hVzbxr6RYBuM7YO1bjDroplzZ3FzFnBhU686flHhr6kUQoJTgirWDRyFGgEtIO/2oFe2mh3GkKgSCCCgBvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rWfSkr9TveeE4fhXkpWfBwJjxxGbqu8i1qdhwoRxuA=;
 b=tmfsRD7MfhgQWcPWCpesyjQ4rYUrnQRNnre5xtyQ6Ub6fyua4jliX9F0+fQsNIqQoffWBHgFdUPufxMXs8CQOHyYv6F1S2Mk9Yuu0XVh7gJo0U1BtntzhdDyZdoCEAFr9IEonePEdf6cJC2KqJn49Q0oUvwKV37RtrIkCafEhsk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:05:22 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 19:05:21 +0000
Message-ID: <a48278ed-f56e-40c4-9324-78795e37e5f6@amd.com>
Date: Thu, 1 Oct 2026 15:05:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/14] drm/property: add a per-connector luminance flag
To: Leo Li <sunpeng.li@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-4-mario.limonciello@amd.com>
 <b436e947-198d-40f6-a14e-de26cceb56f4@suse.de>
 <8a650274-008a-4515-95a6-9cd200eb12f4@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <8a650274-008a-4515-95a6-9cd200eb12f4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0385.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::24) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc810ad-70cf-45cd-b3f6-08df1feef10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|7416014|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: leuSciWvjOuUJwLbaPhO/kW/TVAX3VjHxKy1GnB1iepcvok+ongxd/jg2OvX8UzXYeIpAJGB1E2bGFZU4sRwKp4/ssKls76VG/gBmNdV5VaSfACEWFiEARNUxPuiLSdX+pW3O/psNOai1bVLFhz14AHGgHpBBjmkmfWOw4D36DEGnOB8e/Zgizm9j+MfzjmhV8kJxEOxltv0e5O5rWE1YoREkIK/9kUngRieZ9AQRyq0ccwMzFpZvbs7U0Q7a5jxtQRxqStar82sswi2RBku3A+yUe8ympd6w6XSSyUzj4fCEAlcqrVu1tlWs40x/oq7yeM59KAln6qqWVfzu2Om6kHcJh2zoPj2+1z85Y4lixfgo+ZwH8M8s1ZChMOCW2XxuU81D3U1lypfEMcQjsETUKsxVAELf24VoW3cfWRLDr/bIxg8ajjg86voiXEYPTkfQnCcYNCRyGd01aMpEYPdopw3NB58WSKDdCrinsPoYdOu3n/OLHhUEYyKaPho/4I67qfOt7uwdriCpy1yBq7hJGC2+UEMhlsw3NUYZQmHzjJL0J3LRet/mipvrFsVyh+LtfuVDIHx6fR/oCSjZK9nC41Afb4KiDVgl5Wg3yUx+6aoEaJnYxCDLfQnvD7H1xAP6sU6Xp1sAAwY9CtFU53HfijbYP0wvbx1yN8qvLfah7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VZY0RhanliQ1JGUVB1RlYwN1FaMXd2RU1uendjMHphalBUenZnaDZTZ09o?=
 =?utf-8?B?S21FUlE2OVJvSEJVVkRIMUxXUzZsalROcUMwK3dXT1REbDdvYURKQTJLQ2s2?=
 =?utf-8?B?N095ak12bUJ6L0FmMGVUZUVTMWdHUUlVRGtBcE1rdWdTeFZ5dGdPajNBV0FL?=
 =?utf-8?B?OEUyNXVkZ2dSd2ltdFIxL3BDRVo3SGQ4ZkY4cDZubGc5TzdhZHY3VzFCSUp1?=
 =?utf-8?B?NDRSUG05NXh3MUdRU3M3clhDVVRnbmNPQWt4NlZXM1Z5dXg3dDlzZnhmUjBW?=
 =?utf-8?B?d292NEkzUTVGeUVkOFFoOTlpV3g5Y3dRMDN3OHhiQkhoQlc5VWxxNEJGK0RC?=
 =?utf-8?B?Z0c0N2VicGhYcEMvdDk4dlVPTFhUa1FONXVOejU2WHZSVDlWSnFsVksvckMz?=
 =?utf-8?B?MjkvMUQ0YUNKYUZPbVNFT0ZnZS9PaVI0OVZkU1h4a21YbG5jZzFneGJLME53?=
 =?utf-8?B?NWZpa2w2cmpZNkZ6aFZyS0R2RGJxb2ZLczdtQTBKdHE1M1MzVXIxQ3RFeEJJ?=
 =?utf-8?B?YW43b2FlTkg1UFdQVEFkTFFCUUZTeUVFTk5hb1ZXNk45ZmJ1R2NPckE2UWFM?=
 =?utf-8?B?a2xvb1dseS8weWFkRW1CZk5MaHpIeVIrbHNQQmZ3czRBME5nTTNsMU5KYTNT?=
 =?utf-8?B?ZjRBenJtNVhWVTJpK3p1blYxQmZVT0FLb0Z4VDByZFdiUXhqVlRIaWNhUUlD?=
 =?utf-8?B?M0hXNWZ1S2lyWEhsRnhoa3ZCM1M2WU8weGx2NTFBelE4aDFNQ3ZCTGc5NHBs?=
 =?utf-8?B?RVRISzQ2bkdzYm9WYUtmaitNd0hPZ1d3M0JLcGJtMElNRVZFeWNqaXFvVlN4?=
 =?utf-8?B?cjFOYnBrWlBabUlvL0xGU1RRQVlTTVZPT1k2TDgxTDcwUHVkeFd4eG9SSWtX?=
 =?utf-8?B?aVpsNjNNcEhJclgxL1J2bzV0VitMK0F6WFloNW9YRWdTblpDakc5cnk4MHF3?=
 =?utf-8?B?YlRsd3pRU3FIRnpyYWZzajNxcGthQ3Blakc2R3habjdRNEhjYUF1MTZOVXJU?=
 =?utf-8?B?b2ZpUEVyLzFqaXJlSVh0WEFYYVVVTG8vVGZxcmJVSWRHK1JaaERVMGVmd2Ir?=
 =?utf-8?B?YlluejVGOVZJR3dHQWJjZGNzZldpRjdIclFkMCtxWTNGNHNhbU1qZXdQUkg0?=
 =?utf-8?B?TENCYzVxTGl4ckQzSzA1cG9LTnY5WDdKbEVLamhOenBCSFB0aEtUK1dqbWJ5?=
 =?utf-8?B?czR0NDkwc01pZy9sL3Y0RXBYYTFoREU4eFljK1RDYlRtVjhFUWVXcHRneXI3?=
 =?utf-8?B?ZDRwVHVRSHZ1c2MvdUlMMHR5eGVDYyt5QW44dktNUVp5TUFneVhqL3BkTklX?=
 =?utf-8?B?dE9GYklsSW8yZnRMRGtHcFdrek9tYlViVUpDcjdYN0VpZHpjNFNObkhyckFS?=
 =?utf-8?B?eitESC9jOUhNL1pOUWhPd1lpTmhpMGZIVnp1RFg2c2FQU0N6YVpDTW5EQUxr?=
 =?utf-8?B?SXpsbEVPSGNpVDRJRnFtSGhDSUllU1BVcEhDSituWmNGN21Mc3hZb0wrbmtk?=
 =?utf-8?B?K3U0S0d0MGl6cVpqWlBQckRkc050Rzl5NnA4dU9adXI0ZVI2eWc0VThoSzNp?=
 =?utf-8?B?RmplU1V3akZQdERNOVZodFVWVWpzakZLdWVKYXlZY0dCYWtNME9IQkxHY2dm?=
 =?utf-8?B?R3Rxcy85OG5ER3BVdSs3Z1VleVQ0MTFRQ2RNM1VNd2lRb2JiZTVxazhnSmtE?=
 =?utf-8?B?UjUzdEZhakVGOHR6a05kbXdndXFNcGFJZnBVM25PU2dCcnJsSWZheEwzc2I2?=
 =?utf-8?B?SVRYVmVPUDkrMDdpZFE0RklmQ2hlR0g0Nit3Njg2elMwQmhGOU12TlZ4Z1cy?=
 =?utf-8?B?Sm1NTm9tNENHUXR3VHowMksrQ3grYnUwa0RuRGxndGRVdENaak9hUmZkeXR4?=
 =?utf-8?B?dUxvMHZCdUErcWtsQzlDNllmTk5mdzJGdkN4OEZrMklRQzVRaHVDYjM3N20v?=
 =?utf-8?B?MFFmQjFHcDdwTEczZDBGYUc0RHRUalNNUjJ5dkJHVTVxZjgvVVBBa3ZNZnQ1?=
 =?utf-8?B?MU51akphL2I5UVJFaWx0dW9WNTV2a2hnajF2dHVmWEVOT1NmSVdEUmg5ZmNo?=
 =?utf-8?B?Z29ZNTB0K1BzeE1WN290NHA4ZklrcWt3ZDZ0ZWtlVUxwdDN5UW9tdWc0eXhu?=
 =?utf-8?B?NnBGRDBMSFhPYXhFcE5xMmo5VFJrdndua05uSjNHU0MyNmdWQmhBRXYyNUNm?=
 =?utf-8?B?eFIzVnFPV2k5MkFBSzNRTEkva0ovdUVROW5XTE5iU3JBK2VZSWpacWVvSHFB?=
 =?utf-8?B?eVIydkZOWmRObFlFQ0szTzJoRjdEYTFNMmg5SisrbitaODZKU29ZNC9ZQmlv?=
 =?utf-8?B?SW9iVEpXRUU0cEhxYUpJNVFObUxoOENqUDN2V1ZwMFhqbFlCcUMrZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc810ad-70cf-45cd-b3f6-08df1feef10a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:05:21.8578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJeEnSAahQx4Iv7UQPo8j8BthPMNfBGMNCxArL2iuKFymA2oywlO6tBJwclqmgw+AKscrSeINKHj2ZSGB8gO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

On 2026-09-25 12:30, Leo Li wrote:
> 
> 
> On 2026-09-22 04:32, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 08.09.26 um 06:40 schrieb Mario Limonciello:
>>> The upcoming per-connector LUMINANCE range property needs to accept the
>>> value 0 (to turn the display off on DPMS-off) even when its advertised
>>> minimum is 1. The existing check special-cased a single device-wide
>>> property object, which does not work once every connector owns its own
>>> LUMINANCE property.
>>>
>>> Add a kernel-internal is_luminance flag on struct drm_property and key
>>> the value-0 exception off it instead of a pointer comparison. The flag
>>> is not exposed to userspace.
>>
>> I don't think this is a good idea. Let userspace control display status and luminance independently.  To my understanding, both are independent devices. Just because the backlight is off doesn't mean that the display is off as well, (right ?)
>>
>> Best regards
>> Thomas
> 
> Yeah, backlight off and DPMS off are quite different. The CRTC is still active if backlight off, but that's not the case for DPMS.
> 
> I agree that we should detangle LUMINANCE from DPMS completely: Leave LUMINANCE alone when DPMS_OFF. If LUMINANCE is changed during DPMS_OFF, save the state in sw. Then on DPMS_ON, restore it to panel. Sysfs seems to have the same behavior today (I just tried it on my fw13 laptop).
> 
> It would be good to remove references to DPMS on the LUMINANCE property in patch 04/14 as well.
> 

Yeah, this property and DPMS need to be independent. They're two completely different concepts.

Harry

> Thanks,
> Leo
> 
>>
>>>
>>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>> ---
>>>   drivers/gpu/drm/drm_property.c |  6 ++++++
>>>   include/drm/drm_property.h     | 10 ++++++++++
>>>   2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
>>> index f38f2c5437e68..adccee10cfde4 100644
>>> --- a/drivers/gpu/drm/drm_property.c
>>> +++ b/drivers/gpu/drm/drm_property.c
>>> @@ -952,6 +952,12 @@ bool drm_property_change_valid_get(struct drm_property *property,
>>>       *ref = NULL;
>>>         if (drm_property_type_is(property, DRM_MODE_PROP_RANGE)) {
>>> +        /*
>>> +         * Special case for the luminance property: allow 0 to turn the
>>> +         * display off even when the normal range starts at 1.
>>> +         */
>>> +        if (property->is_luminance && value == 0 && property->values[1] > 0)
>>> +            return true;
>>>           if (value < property->values[0] || value > property->values[1])
>>>               return false;
>>>           return true;
>>> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
>>> index aa49b5a42bb56..8bb568a4cd485 100644
>>> --- a/include/drm/drm_property.h
>>> +++ b/include/drm/drm_property.h
>>> @@ -188,6 +188,16 @@ struct drm_property {
>>>        */
>>>       struct drm_device *dev;
>>>   +    /**
>>> +     * @is_luminance:
>>> +     *
>>> +     * True for the per-connector LUMINANCE range property. Such a property
>>> +     * additionally accepts the value 0 (to turn the display off) even when
>>> +     * its minimum is 1. This is a kernel-internal flag and is not exposed
>>> +     * to userspace.
>>> +     */
>>> +    bool is_luminance;
>>> +
>>>       /**
>>>        * @enum_list:
>>>        *
>>
> 

