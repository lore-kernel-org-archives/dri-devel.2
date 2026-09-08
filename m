Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C55C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819CF10ECEC;
	Tue,  8 Sep 2026 16:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hoMuerzt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76CFD10ECE6;
 Tue,  8 Sep 2026 16:00:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8GLMeb+dOkJVnP7Oz9MBQ9Tt8tzWn+4+n/d3lnfvAqQTQxR4UJ5kaEUgua3AzYUK83/Gnytz0FWvZq/qk/qpevh3cABX3jh0IkiMPMAQHYRnh7yVwmTjK8hpMaLtmR3lSRsn5cQFDW8CO9wssvviQlfY7M6guBr63brNsme4xW1E0gXVNTysXZno+/CCKNOUWvLWQoXNs0nJ/knTuSc0bpiKxc7Jya1/lgLv7F7Eol+MxnWxk0UvM7NjMH9TK4EZlP7pVFhnn+Vup/VRuFSakuG3SlqEgRzkZU4+tEFt2Z3LVcYR2jGI5O9eGCU2DNeKNotXcuImF1YSUUldAM7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn9liI1r1OoRm7u4Wm/6+lrnHXJSVYn6tRhZMtknE9Q=;
 b=etMm/MdfTJp/CS7MfYdbIlvST8M2OEHliZqo9ue77br2wpS2h0WU+yMkcEzdgB/fEtTaKr1Lz3YULr0vf6cxvzkbtv6zQaWrxt2HgQ+tw5dsUhoMMo850N+FESx83gZlsSxMrfqBd0Ya7Dms26H9h5yu2VB4ysDuFuAFhbxysVwsmHaQtCykWYYwoNN1DYsQHevRntXYbqD7HSrSJb//I+YtKqKHcjN0zZ2zQHrXFUSrFP+ibnUMUoTXgmJPU/XbGnMY7C5hviqFpqYfXkLVYbtrIikKTjI+5Q4Y4cE0ShORwkXU2gfe9R3tw6MDlRmTBy/PPIZc12UckBg+HiqB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn9liI1r1OoRm7u4Wm/6+lrnHXJSVYn6tRhZMtknE9Q=;
 b=hoMuerztL92COb3EwVHX1xrBlegePl/swAlon+gZwygxAdV7QG6Js+GzU/LlX7BCKGg5UAq+3J6pPVEOWHpJuAs5TbASXiAa2YNNApEFdVHJiLj47y9VXyxSUsECp3eDFgDULtOa5p5xkhNzfY535D5wZpombAFt6ytllQYYZLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 16:00:17 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 16:00:17 +0000
Message-ID: <f8d54027-ea66-44ec-bc7b-0abb69e918ed@amd.com>
Date: Tue, 8 Sep 2026 11:00:14 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 Simona Vetter <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>,
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>,
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <dd7f11d6772b9422793cbcf1011f4f1aa98bfa3d@intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dd7f11d6772b9422793cbcf1011f4f1aa98bfa3d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:20::16) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: cd915c11-8e92-417e-29cb-08df0dc246be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Z3jJlyl7uvGL08KnoACG/QuGQYrzrs2d4FVagooruval6cYzTByKIpU+PfYMxQkmCuLu7Z0Sy6tSYIVs18U/+ix5eSHWAt+nVScjvcF/a9esPsTgpxB1KpYIqx/5jLI5CCy9q8Ds34XanELoTitxT/f52LhUF+cMKa1IL4nv7MiJR5i4JcHUynWz6nchpDVNFk6n36maGfnyw0gE9gaup9BTWjGGaHwKFDVn4Wf9eGEE45AaB4yT/qrvvUB9GfV9OmTVvOcfWkuVej+fN84rHlS7EpjVNdBJVxXo+CJbzKBpCrP0W/5cPQIQjBRsO7tsgs9Mml2ZxACsdAOTwtJPYeD6Yp9RkmVm4GkBPCf4KsCp9sFdaidjw3sibYJC/TjjIvzKB7CJQv+HVDxh6xA2tX5Rv0TIisVGb02+BztBIhR7vS8GAsksTZ8UAFvfkDs8oRJSs/SxofY0Km/XlF4/hbvoh9ks7Nndf1YHHkjwa/ViqTEJ+DtG8tdfm0ss6X4gAx784aJIFlkZwmf4fmWFidRUHs+peo+3wCQxud67ycX3TSFc9ShRuCj8Ta7N1eDMMO/tNyqopXiJiH5zXbEzF30wyy0DaIvo0+G3rxt/hEwcOpKrFK9+Rtwne3/FInK9bYJbPzJKZJSh5FPlMAbhXBy9NZmaqURwICMjcvtzFdA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGdEYy90L0MwRGxtSU95UVA1STB3emFyY2YzZHZRQVFnQ1luQnJZN3dHWWxE?=
 =?utf-8?B?VmU5Yi9EOHlDYnBOR05UbXoxUDFVZGN2RVZjS25kS0puZ093N0ZkbUZ2NGph?=
 =?utf-8?B?cHVPL0tzZGdOQkJxc0RpV3hhaWwyQTZaZm1FMTJSQWxGU3J5eFdaMk5QcGNL?=
 =?utf-8?B?NVJ4REViM3VpVlNNZ0ZuRXJISHFKUVJucTNiSXVETXplMFgvSnY0S3BCSzd6?=
 =?utf-8?B?OFhqemxNQUJ1Qy9FZFlJd0sxNXUxTXdjVkswM2VPcDU2TTczTElZaVc2M1Vq?=
 =?utf-8?B?cm5RL0Q0TFFsdCtKRGk5NnhFN2l6U3ZzckpmczJMNlNFSFhpZktmOXJEN2Iw?=
 =?utf-8?B?ZU1HbUF6NGJ3QXBqdGdJYndHeC9sdmVWTURTWSsvNlVZb25waFdSYWpxYjNr?=
 =?utf-8?B?R3NoSzhLZkhlTSs5dVU5NHBvMkNrc1FaTkxNYVVrSU1QY01TTDdxemRTbnoz?=
 =?utf-8?B?eHdTVTEyTTMwZG5WQTdKZ2drSThiTEIrYm92MktEVFZWQWtaaFYrNDdIQTNn?=
 =?utf-8?B?alZJOUYzOSsraVg4bkhMS0t5SksvcWxiM0dBUnNiSjBsYmpFNGxhOTJ4Tlly?=
 =?utf-8?B?YS9FVTVTaDZDL2FwMTczcDZaNFVrZVE5eUtUWENiUW5pSUsvSllGL0hiK1BO?=
 =?utf-8?B?NEprMW1VUmxjdW1zeFozSGViaFBhdGQ2V2dwdW1LQkdid1RESVBrWGRBVTlQ?=
 =?utf-8?B?cytYQzM0aWNPbDlrNHFqaHM4VTA5Q2RsQXlrcWJnTjIrODBvUWdxeHQwdS96?=
 =?utf-8?B?UG9GR3drQ3Zwdnc2VVE3VTRMdnFXUlduV0s3aFhPcE91UjFlNW81RGtILzFC?=
 =?utf-8?B?U2dEbTM0U1VVdEFZUUVud0VqbC84NWs4Y3paWUlUUS9NNkZMcVVBZy9HMW9W?=
 =?utf-8?B?d1NQa0dXRi9EZVQ4MHcvVlNjNXI2anQzOFAxaTBBb1pFKytRM1dZUTg3bzRT?=
 =?utf-8?B?QkYzVGh1S1VMSjIyU1pBVUpUMVF1NGhMUzJUMTdpdDByUjF2S2cxbG51Ym04?=
 =?utf-8?B?aEd1TVk5UjErT1ZxQmhHUGtveHp0YmFYS1JZSlBwU3M5SkdDN0lRKzFhSkxI?=
 =?utf-8?B?a0ZXVlc2MUYvSWFQTW8vdXZqYVFpREROU2MyZldHTDB3VlhNMjA1c0FyOU4y?=
 =?utf-8?B?M1V5azNiaXZ2cVBXeG5sSVZhcnRPclNBdGhiL2FLNXlqSHZaSy81QWRwM3c5?=
 =?utf-8?B?Mm1aNzl1akZsdzk5dDRPTk9VQkdBcnp3VU0xMWhlLy9BUWdKYkFDTFhKTG02?=
 =?utf-8?B?dDk2aUZUR0prbldpMkdVaUwwVnNLdW50QTNLWWZWMmVyeXFvVy9OZ3NRM3Nh?=
 =?utf-8?B?THp1NHBkUmR2TXk3VCs2RjBpOXY2ZWVyaDFnNEFJZU0xK0RMMCtaSUtCak96?=
 =?utf-8?B?d2tpNm5YSFY4TGFoUjRWVEcraitSRlV3Q2R4NXgySytja290Y2ErYTcvdTJP?=
 =?utf-8?B?R3E1aVB0OEZVYTBuUSsySkg2eW9PeHhKTUg0c0RNK09JMjFiTHJQUjUwaGRo?=
 =?utf-8?B?V3U5clpSd2JTcXJjb0xpRk8rTURyWDFBUmllcGF5b1MzRVZzMmpRekNKem5S?=
 =?utf-8?B?VUtWTlFnVFQ1MkVFRW96eXdEamFENHU4ai93RWxNTHNHRTZEQkJNalA4eUpz?=
 =?utf-8?B?Qy81aVhRYmFUWmFxRUpVbndJWlJBcDY3R1pWNkdHNVUxS2h1OWZjbVUxdjJ6?=
 =?utf-8?B?SFJFZm52SXczRXlOeXNTNEtaV0JiRVBNMUgzWW45UFZPQkl4TjgrNXNXRmxO?=
 =?utf-8?B?Q2dPcEZDWTNyaUNVWXhRWUxKQ1lzODBLbDlrV203Y09YeHEwampiNitteFFU?=
 =?utf-8?B?NG9iMnJXd0FYY1FSdTEvQ2MvWkhIdXYvcEVvMGFSN1BmUFQzNTFrVnlUTDJ3?=
 =?utf-8?B?aE84MUdrbU1jYUJVWWFBUWt1c1JVTEIxQk5hSndNU2JJcjU4MVY1Q1JmV2RQ?=
 =?utf-8?B?eTlpdFA0ejhxMUNHNFZ1UVFPRWllT2I1ZmJHREJHMWxMOENwTGJLMWorbUhD?=
 =?utf-8?B?R3g4QXcrUXdXUlZFNnlDSEVtcE1XcmJGNDNHS1MrTjRnQTF0K2hJSk9aN0hN?=
 =?utf-8?B?MXZsbVdUNWo5VjlhcVlTMTBCdFJQWS9HNE41dkltSEh6TEwzd1dwUlZ4cTFx?=
 =?utf-8?B?NElKdWRYTmQ3SEM0SkVWbGhKQ2U0MVl3K2p2NzhOUkdzdUZFbkx0Ym9LU1NR?=
 =?utf-8?B?TGgxVmNqWHNPcmkvTWRiL1lDVDJkdnBocEtsRmI4NFZ6OHZKQWRVcjRrYnli?=
 =?utf-8?B?bXA5dWhNc3ZMc2NFZVhtYVFUWTZVQkhSL25QczFqZlVJTkQxV0pZRFk2UFNx?=
 =?utf-8?B?ZDBlbk9pRWdZZ3hEaWkzWDdMcmMzOTFwQjNSd0pTMWt0b0o5L0l1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd915c11-8e92-417e-29cb-08df0dc246be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 16:00:17.3807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFVQisLaa03QOj0JAABtCW8buBytT6eo0kYn5oLXBogQQwyXlAdLyzMJEhIiaZ2GbeR2OEu0fUiZiOArfUmuGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
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



On 9/8/26 10:45, Jani Nikula wrote:
> On Mon, 07 Sep 2026, Mario Limonciello <mario.limonciello@amd.com> wrote:
>> So far backlights have only been controlled via sysfs. However, sysfs is
>> not a proper user-space API for runtime modifications, and never was
>> intended to provide such. The DRM drivers are now prepared to provide
>> such a backlight link so user-space can control backlight via DRM
>> connector properties. This allows us to employ the same access-management
>> we use for mode-setting.
>>
>> This patch adds a few kernel-internal backlight helpers so we can modify
>> backlights from within DRM, a brightness-changed notification, and a
>> per-device takeover count so that legacy sysfs writes can be inhibited
>> (-EBUSY) while a luminance-aware DRM client is in control.
>>
>> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
>>
>> V2: Marta Lofstedt <marta.lofstedt@intel.com>
>> - rebase
>> - minor edit for checkpatch warning
>>
>> Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>
>>
>> V3: Mario Limonciello (AMD) <superm1@kernel.org>
>>   - rebase
>>   - Use guard(mutex)
>>
>> V4: Mario Limonciello (AMD) <superm1@kernel.org>
>>   - Adjust return type for backlight_set_brightness() to return errors
>>   - Stop clamping in backlight_set_brightness()
>>   - Drop backlight_device_lookup()
>>
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>   drivers/video/backlight/backlight.c | 66 +++++++++++++++++++++++++++++
>>   include/linux/backlight.h           | 45 ++++++++++++++++++++
>>   2 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
>> index 4401f6294ccc8..1c700c1e77c3f 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -126,6 +126,9 @@ static void backlight_generate_event(struct backlight_device *bd,
>>   	case BACKLIGHT_UPDATE_HOTKEY:
>>   		envp[0] = "SOURCE=hotkey";
>>   		break;
>> +	case BACKLIGHT_UPDATE_DRM:
>> +		envp[0] = "SOURCE=drm";
>> +		break;
>>   	default:
>>   		envp[0] = "SOURCE=unknown";
>>   		break;
>> @@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
>>   	struct backlight_device *bd = to_backlight_device(dev);
>>   	unsigned long power, old_power;
>>   
>> +	/* A luminance-aware DRM client has taken over this backlight; the
>> +	 * legacy sysfs interface is disabled until the last such client
>> +	 * goes away.
>> +	 */
>> +	if (atomic_read(&bd->drm_takeover) > 0)
>> +		return -EBUSY;
>> +
>>   	rc = kstrtoul(buf, 0, &power);
>>   	if (rc)
>>   		return rc;
>> @@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev,
>>   	struct backlight_device *bd = to_backlight_device(dev);
>>   	unsigned long brightness;
>>   
>> +	/* A luminance-aware DRM client has taken over this backlight; the
>> +	 * legacy sysfs interface is disabled until the last such client
>> +	 * goes away.
>> +	 */
>> +	if (atomic_read(&bd->drm_takeover) > 0)
>> +		return -EBUSY;
>> +
>>   	rc = kstrtoul(buf, 0, &brightness);
>>   	if (rc)
>>   		return rc;
>> @@ -514,6 +531,41 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>>   	return *r == data;
>>   }
>>   
>> +/**
>> + * backlight_set_brightness - set brightness on a backlight device
>> + * @bd: backlight device to operate on
>> + * @value: brightness value to set on the device
>> + * @reason: backlight-change reason to use for notifications
>> + *
>> + * This is the in-kernel API equivalent of writing into the 'brightness' sysfs
>> + * file. It calls into the underlying backlight driver to change the brightness
>> + * value.
>> + * A uevent notification is sent with the reason set to @reason.
>> + * Return: 0 if successfully notified, -EINVAL for invalid values, -ENXIO if the
>> + * device has no ops (e.g. it is being unregistered)
>> + */
>> +int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
>> +			      enum backlight_update_reason reason)
>> +{
>> +	int rc = -ENXIO;
>> +
>> +	scoped_guard(mutex, &bd->ops_lock) {
>> +		if (bd->ops) {
>> +			if (value > bd->props.max_brightness)
>> +				return -EINVAL;
>> +
>> +			dev_dbg(&bd->dev, "set brightness to %u\n", value);
>> +			bd->props.brightness = value;
>> +			rc = backlight_update_status(bd);
>> +		}
>> +	}
>> +	if (rc == 0)
>> +		backlight_generate_event(bd, reason);
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(backlight_set_brightness);
>> +
>>   /**
>>    * backlight_register_notifier - get notified of backlight (un)registration
>>    * @nb: notifier block with the notifier to call on backlight (un)registration
>> @@ -548,6 +600,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
>>   }
>>   EXPORT_SYMBOL(backlight_unregister_notifier);
>>   
>> +/**
>> + * backlight_notify_brightness - notify brightness change to listeners
>> + * @bd: backlight device that changed
>> + *
>> + * Notify registered listeners that the backlight brightness has changed.
>> + * This is called automatically after successful brightness updates.
>> + */
>> +void backlight_notify_brightness(struct backlight_device *bd)
>> +{
>> +	blocking_notifier_call_chain(&backlight_notifier,
>> +				     BACKLIGHT_BRIGHTNESS_CHANGED, bd);
>> +}
>> +EXPORT_SYMBOL(backlight_notify_brightness);
>> +
>>   /**
>>    * devm_backlight_device_register - register a new backlight device
>>    * @dev: the device to register
>> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
>> index 015183d129f96..fac1acbc698a1 100644
>> --- a/include/linux/backlight.h
>> +++ b/include/linux/backlight.h
>> @@ -31,6 +31,12 @@ enum backlight_update_reason {
>>   	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
>>   	 */
>>   	BACKLIGHT_UPDATE_SYSFS,
>> +
>> +	/**
>> +	 * @BACKLIGHT_UPDATE_DRM: The backlight was updated from DRM, i.e. through
>> +	 * a connector LUMINANCE property rather than the legacy sysfs interface.
>> +	 */
>> +	BACKLIGHT_UPDATE_DRM,
>>   };
>>   
>>   /**
>> @@ -82,6 +88,11 @@ enum backlight_notification {
>>   	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
>>   	 */
>>   	BACKLIGHT_UNREGISTERED,
>> +
>> +	/**
>> +	 * @BACKLIGHT_BRIGHTNESS_CHANGED: The backlight brightness has changed.
>> +	 */
>> +	BACKLIGHT_BRIGHTNESS_CHANGED,
>>   };
>>   
>>   /** enum backlight_scale - the type of scale used for brightness values
>> @@ -310,8 +321,23 @@ struct backlight_device {
>>   	 * @use_count: The number of unblanked displays.
>>   	 */
>>   	int use_count;
>> +
>> +	/**
>> +	 * @drm_takeover: Number of luminance-aware DRM clients that have
>> +	 * taken over brightness control of this device. When non-zero,
>> +	 * writes to the legacy sysfs ``brightness`` attribute return
>> +	 * ``-EBUSY``. Managed by the DRM backlight helpers.
>> +	 */
>> +	atomic_t drm_takeover;
>>   };
>>   
>> +/* Forward declaration for backlight_update_status */
>> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
> 
> I think IS_REACHABLE() is almost always a mistake. It's a hack to avoid
> link errors when something in a module needs something that is
> built-in. It's a combo that should be handled at Kconfig level, not at
> build level.
> 
> BR,
> Jani.

That came from this feedback from Thomas Zimmerman (I originally had it 
as select:

https://lore.kernel.org/dri-devel/8224920a-3a10-4400-9503-f014b7059329@suse.de/

I was trying to use IS_REACHABLE to make it optional, but it sounds like 
that's not the right direction then?

> 
> 
>> +void backlight_notify_brightness(struct backlight_device *bd);
>> +#else
>> +static inline void backlight_notify_brightness(struct backlight_device *bd) {}
>> +#endif
>> +
>>   /**
>>    * backlight_update_status - force an update of the backlight device status
>>    * @bd: the backlight device
>> @@ -325,6 +351,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
>>   		ret = bd->ops->update_status(bd);
>>   	mutex_unlock(&bd->update_lock);
>>   
>> +	/* Notify DRM and other listeners that brightness changed */
>> +	if (ret == 0)
>> +		backlight_notify_brightness(bd);
>> +
>>   	return ret;
>>   }
>>   
>> @@ -431,6 +461,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
>>   { }
>>   #endif
>>   
>> +int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
>> +			      enum backlight_update_reason reason);
>> +
>> +static inline void backlight_device_ref(struct backlight_device *bd)
>> +{
>> +	if (bd)
>> +		get_device(&bd->dev);
>> +}
>> +
>> +static inline void backlight_device_unref(struct backlight_device *bd)
>> +{
>> +	if (bd)
>> +		put_device(&bd->dev);
>> +}
>> +
>>   #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
>>   
>>   /**
> 

