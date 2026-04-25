Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2F3FF8860
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4722310E227;
	Sat, 25 Apr 2026 14:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BTqCoP7z";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011069.outbound.protection.outlook.com [52.101.57.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BA110E227;
 Sat, 25 Apr 2026 14:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2/1iMtbsrXAfJS5fXwn8bYHoCXvrpv3E4yC9cDqok47NvgmS3IPuuxsfpZgAh15iUdyNW9M4fStXYwhFkv7hIJYvOjmeJMadFTmoMzvTNoS1uhDLhzKiIvsT/py5zJ+JRmGihWQRNW9OIqPGIfG/HF5eI5J8v/1Cyy1/WkEr7RRpq3DDWGqZhGNnv2aATwLlNJibTScYt3z25BpRMcH1PKdNH8OqJJGfhxi3TRmPu4w+fLpTPYbFTbZjtyw3ZL1mZl7gJc7nJWNB3cF6T3NPhXuPxq0ixgvVm9qZbsy5lILjSL0Km7lUlT34Zj9phIQJOfrq2SNL4rx7cqriASG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+vEX4gYTeZLZoJjxeEi/rgaAD6iNObFIdo6R/LBOjc=;
 b=ZBdpjRkSrUG4zB+zNk4u6TOnyIRuuAcXYCAX4gpHFMdHpyCxE202rRBBkNDZlUOGdYEIj74JUHQmJidGPevir9LtEh1ZNJqyHERooQYEPUEYA+mhmiTykQkMYL2PkgUx1SYSVOD8ZtNwAtvc5vfqCM45Ykm2QiSAighWI83YvOGnVChImfkmeG139IkhEs7IVeQlgux3fsUasvDSPUXJJoh5P25X2Pl0vd6280Yh3YwBKGdCpNlZLlwEE3jAHtvr3eolKEp2s2/NbSgSamvi4R02c5VpTLpClDR7ix27kFa5mC6hNLOGqfI1MLYI211FbA2pJFDcLv5Xv/8pAj2ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+vEX4gYTeZLZoJjxeEi/rgaAD6iNObFIdo6R/LBOjc=;
 b=BTqCoP7zAoTJAVJWSIOqBMJU36H1mKYgL4eC2SUclsNsA8Arg0kzyMHgNX0xUgduo7vLGSuC5zhQzja2Sdd38Y0OzjZ6B6vT7Adg0iVOF2nqn4qSSzTRevikajdiPv9vT3HxWi0zvpOLak3XBZFYAQXDtKXjicpoOnaDrAp0R+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sat, 25 Apr
 2026 14:45:32 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 14:45:32 +0000
Message-ID: <cb1ab06a-630b-4bd7-95a3-5f679b84dbe2@amd.com>
Date: Sat, 25 Apr 2026 09:45:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20260424220953.167058-1-mario.limonciello@amd.com>
 <20260424220953.167058-5-mario.limonciello@amd.com>
 <5trcw3bcadvk2ltmat5axlezuznylsgm5xr7dmo66o5ijcrpdz@fhv7yhmlklub>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5trcw3bcadvk2ltmat5axlezuznylsgm5xr7dmo66o5ijcrpdz@fhv7yhmlklub>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:806:d2::7) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|PH7PR12MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ea8980-9364-490f-78e6-08dea2d94d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0zpYpx0SUwm691YeMoAOAsDHFx6MN4svkdFyb6C2LDTdnIidBBVZW2zQ29K+oR3MVkbaQHei7h9rLqzvPboK9C6x1pEdTTROWA/bndtTpL4KP0oCO3h9q9BiAzbh33qNJmUEipLHT7Su3zvEdcSXS+UAhEvjblJ0gGY85piPEeLJaefCzx1sWPBqyw+6Tal2oth+YBkauAhb7WPWh2njcGo+1UCSe1de+qTLPGFAbyuSJxyoSYHK423pTevHcOHEe8gHwxRYfqZ6zlSMioRGPLd8cOV9W5TaSksRz0/tOqGJTWFXWB1ERiqZP+crDPSiXwC6jdKBXqJVHIoN5zkSswFFhd6yPp5WT3OZnf684SSIiuLEI6fqyUY1dRRNhBq5KPG8JJ/EIQPwtJRfQkEw5A1cusEV1qxA6JzNnRj8Dr/lT427igo8kDlEDrVqrsvVcenXYaxCAkREVF06FcMU+GOgRydE3Hz9aG52waP39Nx7dwSYAIqFGQDVXPJkr5PvFiOKFZ/xu8qgjX1x2IHBHrtskyif5f/dMobdrIG9vVOUNuDpat+WlbqBLnbd1BqNe+hUqy9I1D+4SxLmojTQCPBghKwEmtX+lOyeQMhMmoh0Ao9myoqFaJxuzYCauNf1ZfHevnfm6RlGpZX7KICuhYq6ONM4sNla8DrYUzTfefZ6B3eXk4TPb1kjBYQRxdnkvFDTQe5An79Tnl61DeyezM6Lzxyr6FaP9Ot+CKwqpAc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2xsTWV5YVFqTHhVRmoxQ0JiMnMwZ1JkdmhVbHM5dHVOSDRXSjU0NE9WRTBN?=
 =?utf-8?B?TVlhYW9KK2liYXEyOHluR1JCZnFoYVlMSTV1NnF3QVRneXRSd3U3cVpEN0Zl?=
 =?utf-8?B?ekF2VFVFTGcvU3BkdXBrMlNSZFU3eDkrRHRkTVBhNzRoT2VLOVYxVmFtdHFF?=
 =?utf-8?B?MzdPSTBkWW4zc3hwcm5yaWlZRHVuRnl5RHYrQVVUemJnV0hEV2JZZmcxRDJU?=
 =?utf-8?B?dUs0NE1HMWNjOU5maUdjeTVxNGV6YUJzS3ZxRmVVdmVwSHYrZDhMMFNGNEdu?=
 =?utf-8?B?ZjkxZFJuaWlhYzc5N2tvb0V0WkYwOUUxVUpoUnhQODZUS0RWSmhmb0NnT3lQ?=
 =?utf-8?B?M2svMVU4U29FSGIwUFNkVE9sYmFqQ0xkNzgwcXN1ZllFTlZSN0I0U1pQQWNr?=
 =?utf-8?B?OGJNcFBZWVNidHUwd1o2eUhoZlVYUW5FNGdrK1d4bHJvTmtzMGcybW8vdXBw?=
 =?utf-8?B?a0ZtV3liYXB0bW5LeWN3cXc2Q2c4UGhFQkNjNzJwYThxcjBTUkxrMVNmWitR?=
 =?utf-8?B?OHFBOGpwUkQyT0RtNVBvV2ZlYlEvWmdMaUp5MkF1TGxaY0s5VStFcWMvam85?=
 =?utf-8?B?bGVyVkZONlh1MElFOUFWcXdaYm1jakZTdU9adm43VWVNYUhyUXN3aDNyMFBu?=
 =?utf-8?B?RHZaZktCYXA4TzJKQ3JNMjhvcnMyNnlTTHN0UklJY0hOZGJ4MmJkbnUraG1a?=
 =?utf-8?B?TmJmcGV5bHBxNjZBZ1RSa2tIbzVSS1NqMUM5ZytZa2FmUERncWI1QUJISjRW?=
 =?utf-8?B?OGs1VVpveFhXM1ZaZlhBSjZhUHFXNlh6RU9IekFFMUNiSkwxbWNlbjhkdlpw?=
 =?utf-8?B?a2xiOVg5NnVWSUJwKzlXR2ZJeldnRGRSR2JETGxQV0oyZ1lNa1MraEdONU9X?=
 =?utf-8?B?S3lhbFVJMXBiRUZacTdYWHRkRjJUT21SQUJoR0RGbGJ0azcyYWFOM0s0SWhp?=
 =?utf-8?B?aHBjWm1SK0ljUVloRWdnQWd3RmlWV0tvS09zM0VmTWdodXVwY2VUQnV5bnMw?=
 =?utf-8?B?VnY4N2M1dnRKbytEQWNCLzZnMGF6R05JbFBITmp5dVh6dktzTll1Z3VPTTdk?=
 =?utf-8?B?dDAyejNOV2lhYnJVeVR2WVNaeGlTSzFjVCtXTmFqQTdIWUlFUHZWZ0JUU21T?=
 =?utf-8?B?dVEyMW4wRGh6cEJtWHFKK3BTcGJwcWpGeHRzS2NNZklhQWR6SUF2Zlp1eVRy?=
 =?utf-8?B?cXZ4MlZCNjBkZHlsSEh0MXdhcnE1SC9OME9DODNCRU53Y1hGanY2L2dCdVl2?=
 =?utf-8?B?dVRmVEN0c1hnUm9ocmc1NnJPR3FJb3RETUkrd1MzTUxma3RRSmswNXY5U0Va?=
 =?utf-8?B?OC9nc3lRdk83Ly9NemMrbGZGcUpTMkk0V3N6L1NFL3BTTHI1aThrNHZQUHM2?=
 =?utf-8?B?RzNKTFlJUnBTZUhPcGlDbzlTbHhVL2pzNG9DTWtXS05xY3VlaTNQMnVscUpy?=
 =?utf-8?B?NktGTllaTzEvdXFxK1gwNzA1RUNLZkhicnB5VlhlaGFlcUtaSll4Q2FCenVi?=
 =?utf-8?B?WkRsVmJOM0JUQzdVQ3o5OFFrbjQ3VE1GTTRDcysyenJSamhISFE1c1V4eENR?=
 =?utf-8?B?OEpNbEQ3cDFTdE5FUWsyaHJFc0pNZlRSZklBV1VRSWZ5T1FweU5DeXgzb0tN?=
 =?utf-8?B?NWtGeERMM3ZSU2p0ZElkSWZWNTJYeGpRODYvaStIaEp2NG1UTWNTR0p2d3ZI?=
 =?utf-8?B?TzdPYTN2UldwQ2srUnJTdzNXbTZWcUFFTlNrOFBrS2F1YXFFNEdQN3R4dkNv?=
 =?utf-8?B?SUdzK3R4K0xZUmU4UFNrOHZhNFR1VGFrWkZiQVNtenhGTEhydVBRSUloZnhq?=
 =?utf-8?B?QnVTQXJydTFyQ0NibFhUUVN1UUMvNGxqVFlKV0JVeHZkSnU2VVN0RE5yVEhx?=
 =?utf-8?B?UUt4TWx4WDNCd3VaeXFYaTU0bFVFd2ZPUEcxY3J3Vnlpc1FabWlmUDhrL1RK?=
 =?utf-8?B?UDU4WHU4Q1BOdkM0Zjh2Z0NjZmRZbFlJTU9xVGZEVkVZU3FLdlFuSkNkK3lY?=
 =?utf-8?B?RUxGSzhDeXlWSWw2SjZpMjZ4em0wRVM5SEJ4Y0QwNDNYR1JNVml6aFJCVE9v?=
 =?utf-8?B?ZE1ralNTUWplNEQvL09wMStUQm9sZlNMYVQyRzNHbEs1OXk2V1c0ejJaNnBl?=
 =?utf-8?B?U0NqdzVxQW5YQ2UwbjdEU1N1bW0xa1NQUzJZWmZWTnZtcVNoK1U2YUtCVHVK?=
 =?utf-8?B?Ykd0Vy8wZnNYTURDbERTeHlrNVlkdWt2MjlnVFhZWmd5TU43NnJFSUtZaUlW?=
 =?utf-8?B?VmlnNUtvbzduVU5LOFljMXk0TmlYY01abElVOTVmeWpxNFRHeHN4YmNocGZW?=
 =?utf-8?Q?t71WK7haMCO9wH1cTM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ea8980-9364-490f-78e6-08dea2d94d54
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 14:45:32.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YoyUFjKqu4+8DT2eh2y2/dKQui6LzEAfJmq0oMyXfVlK0SN9KkWUIQRElFOx78gNiVj1XNCeqbU58m8tYZuBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
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



On 4/25/26 07:17, Dmitry Baryshkov wrote:
> On Fri, Apr 24, 2026 at 05:09:49PM -0500, Mario Limonciello wrote:
>> The legacy backlight control interface can only be disabled when both
>> the client and driver have agreed that the luminance can be set during
>> a modeset. Add capability for the client to register and for the driver
>> to indicate support.
> 
> Please describe, why do we need DRM_CLIENT_CAP_LUMINANCE.
> 
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_connector.c   |  4 ++--
>>   drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
>>   include/drm/drm_connector.h       |  5 +++++
>>   include/drm/drm_drv.h             |  7 +++++++
>>   include/drm/drm_file.h            |  8 ++++++++
>>   include/uapi/drm/drm.h            | 10 ++++++++++
>>   7 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
>> index 27cc159c1d275..b5e6d940f2816 100644
>> --- a/include/uapi/drm/drm.h
>> +++ b/include/uapi/drm/drm.h
>> @@ -921,6 +921,16 @@ struct drm_get_cap {
>>    */
>>   #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
>>   
>> +/**
>> + * DRM_CLIENT_CAP_LUMINANCE
>> + *
>> + * If set to 1, legacy sysfs interface for controlling backlight brightness will
>> + * be disabled.  The client will include luminance values as part of the modeset.
> 
> I don't think this is accurate (anymore?). The sysfs doesn't seem to be
> disabled. Rather the DRM updates it internally. Which might mean that we
> don't need an extra client cap.

I had code in my tree for doing it and decided to defer that (see cover 
letter) but forgot to drop the cap.

I suppose this is an area that would be good to discuss if it's worth 
getting some of it done in the same series or should be deferred.

The overally idea I have is:

1) Allow both sysfs and DRM master to do writes initially (allow 
transitioning and PoC)
2) Userspace changes to DRM master
3) Introduce client cap for it and block off sysfs writes when DRM 
master indicates it.
4) Move sysfs compat behind a kconfig
5) Drop Kconfig

The timescale between steps 3 and 5 is "many kernel cycles".

> 
>> +
>> + * This capability is supported starting in kernel 7.2
>> + */
>> +#define DRM_CLIENT_CAP_LUMINANCE		8
>> +
>>   /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
>>   struct drm_set_client_cap {
>>   	__u64 capability;
>> -- 
>> 2.43.0
>>
> 

