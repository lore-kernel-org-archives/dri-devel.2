Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8BC98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B984210EC41;
	Tue, 22 Sep 2026 11:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fydob3bt";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013027.outbound.protection.outlook.com
 [40.107.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28C510E6E7;
 Tue, 22 Sep 2026 11:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNzf/6BODwZ11GvwSaGhllTdvGdtNnahFP2Gki+pDz1PEx2hcsbqlzIet9TlVM7P+oPDrO0uByCraHmNHqlQOtp+eM8AIKIChkMtdmUzpxn9AOW9iFuwPczcDulBh4dJVQy6/eZQtqNT2oLfL2LTrUriUNdnWHSImsWHapiVkAYAdUB8jqifKoK9hbeC46IOAKKret2nTWXxPl1UiO7mLOxR0eT1+Soq0q4eurz3YBiI3+oN3ZZl+16plgCzQnX0/9aTHm9BTK9BA7eTJ73H1aOW/CUN5TLeVMFApzrNtok9pfoo6OD4CcsL34JW2WdaCiHFQ7jU5XhxvlHleUwa4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPqTKPYVtExTSLWj00dkPkvkmf3AE/euQD30dMHJtNM=;
 b=avK26R5mZtUufGTcpQvkTzYDPAYbdT5RLTFiGMrP+tGa5BlsJdkIqN0p6c+w7d+I8+OqF+N/XF6wdMyt6CxN7Bu1b3Qn9JRJTUHfdzB6Ud4D1aE6kaA6hORsfbC3X8jrVDyWAbl9r5L9zba38/3Ld9g3M6WWnvFYw13fpYVLIE2A2U4zEoXqu51oOymzmpGjuRILVCqEVzYwFsqqN1Cczq+Y1AVjF/eP3FFNK3IWzH51MbMFtLNPQCggfYmC7Usvz+iaS6H2sK7JaFb9DsW/8/S3XQ/0PEwSyK3Pq93LtiJFmSFD8Bvh45B38K5osccrYxmfRwBNJ/3JVZOR9EqZUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPqTKPYVtExTSLWj00dkPkvkmf3AE/euQD30dMHJtNM=;
 b=fydob3btf0bT5oKqX6V8TEvf61EH8LelaNTL/aOLlFVGLUM8SL+bizAEJcMqtCkvlcw8acrJgV2s9oizQDKYi02O8xKjVjTLDI27w6UMeBqwHktHDFrjZcQX+uAh4oTOhzZirJId5zmjWE3a9tIAPIHc+BDJMfItZKV1OCOTfyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB634945.namprd12.prod.outlook.com (2603:10b6:8:514::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 11:37:11 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 11:37:11 +0000
Message-ID: <15b6893f-6f9b-41d5-af19-c900d34d3890@amd.com>
Date: Tue, 22 Sep 2026 06:37:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
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
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) To
 PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB634945:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e798d9-7099-4db1-4d2a-08df189dd744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VgDkknxe7P+R2CK8Hhbr4NboF9ailC5A9VOP3N0OLEk3EkYRcYu9MAVeaO9cpRXyQyxxWczQP8GNX/dCKsSKnT7epSJXG8F6V6HvlVUj3zDgM/gYDh9+cEjRaCR8EcEBgcU6js/gafRckNH7+gXMyFpAtQb8QPeSEaRDW08eMVQ4RZ3xGWvn8LCAMNFGqttlkgDHxNQflB6tQr2x42JBymir9THUHllzvCTrucn8laBLPOdpiEwTkvDXaNR7+QZZOgjpVMJp8m9YNbk8d8zK0tc62dry9ZKAvkbhn2W1VgHhmRhpiG0tinJyi7oNs2Cv/lIP0OtlHsNMxqP9GN9UVL06dgLEUsznlSjdRrJy7doHUYSsWf+bCZZSSweqJp+cC3i8zHGGdmf3yeNBBbzz3pGkLkuCVeteSkcoUzTo0mVuVgJU9pzk0siNu8VsDmwA+qes6l9tye0f544BJp8thNAlg2aobAzDNfeqW0rc1//mF3JecuIHXAMaHWA9Fn0vCrEq2l4MRfmxod4biJoS3wSoZ/YDvk7BmUv7LqSaPSW5gHZtuB87rryGrfpW41C1/N+ETp2wAhZBTWUrcp8VaGqUsLBulZh2saCxDRsrTaJ3rlqSXTdyey3al08DjBSs1pAPVPFVvcuo/XOp0y+uMVvLN3ZaYONMqFeg5qM7RK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Y0ZG9LNFdmZGF3OThCVXhxYmIyWERJaDZOYnM5ZE5Ec0dScmE2R2lETFRU?=
 =?utf-8?B?ZkFxKzBWdGJ2RXhNenFiM1VGblpndUxBdmNnVG8yS3BkZCtWakNwOXBieHln?=
 =?utf-8?B?WHE0NkUyeTZzODVYRzJDeVpoZG1STXg3QVo2YUlEVitqZGgrc1U5ZXdTN0pV?=
 =?utf-8?B?WGU4aFpSN1pvZzQ1N29WcWxDUUZEaHJJUEVWM0JxODRKYlJsaDlGRU9oZDQ1?=
 =?utf-8?B?Z0QzL1BIRzA5dVNaUFBFR3ZMRFdPV29sOWVOdklnbklINjBrenBXQWxqRndV?=
 =?utf-8?B?VjN5UXdrK0xTckFFT1dkT01VK2RTU2hheGw3VGpqQzR4RzVJcmdyVC9hYUUz?=
 =?utf-8?B?RmdSNExFbWJQV1dacUpEdGZKS1dGamlJTlBQZVRPYlFMVlh6bllYcWoxYS8v?=
 =?utf-8?B?bXVYSVlUbG1DRmE2clVEV2gxSFBVSzdPaldGelFIVmJINzBoYmc4SGUxazZY?=
 =?utf-8?B?SXUwYStEREQ5akRzTnQrcE01M2RRQW93bktwM3VvZ3JUdGlreEFWMjd3NC82?=
 =?utf-8?B?djZNNHJOZjVBZXd6cEd6UzF0VkJPMUZOMlVrREFlQmF1T09TVW1QQ0N3Vmp0?=
 =?utf-8?B?VU8zOWFkUmU3UFVYL2U2VHQ2S2s0bkNlOHlYVUpSMElxMVVCcjRKa29jS2dJ?=
 =?utf-8?B?MzQ2bVdNdEtPV0NSVDRSdWZTOEJNTTVlNkJZWUprOE5rQzZNOFUzT1M4MDdj?=
 =?utf-8?B?d0NoSGI0QUJreE1WWjNPeG16OUV3V3g2U1E2QnFwL09zK2VHRk1YNW9YSDU5?=
 =?utf-8?B?blJXNlRwU0hQWTZtWlZhNzJidGxONDhqNlp0V3ZHcmFSYmx3b1grM2RlaG9m?=
 =?utf-8?B?YTNiUzFqUUsyempaTG9ueERvTHNyMkQ2YlJOYnBZbnhKaXo2Tjg1ZDVPT04y?=
 =?utf-8?B?NVNNNVV3Uk1ya3pZNjNBR1lnQng4dHBzT0xWS1RaMnNQdm44T05vU205RFFW?=
 =?utf-8?B?aDlDT3NNSlFHaUlXaFdrdDVLMTRQYnluT05HaFhkQXpveFpKRGFVUUJXWGlo?=
 =?utf-8?B?Q3MwYmNLNHlGYVViaHBERlJic0VaWlhDNDU2VzdvMzVnRDg0dlM1MGtnSTJR?=
 =?utf-8?B?WUIwem5ydE5ENUFXaCtxRFRsK2hlZ1AwZVlSOUdVWWE4YkJ4UHoreEN1ZSt6?=
 =?utf-8?B?ZnZXWERXVXRPWVZkdklhRXRCOU1Rc3JVVzRSL3d4dXVrQ0pId2JiTU9YcjRM?=
 =?utf-8?B?am1NZEpjd0ZBVjhqUUJJa2JkMWg0M00rVnNNZUdQcENvalo5aWE5SStUNXBr?=
 =?utf-8?B?eDB2YlU5dEVVYWJkVmtISXF0Z0k5cjBDZldpS1ByK2szaGV1eFcvTjVLOUNL?=
 =?utf-8?B?ZFNXZzFvVWpEeEozM1dVT2Fpak5odHV4SkJaT0ZUb0phbGwvZHdJYXZOQ21C?=
 =?utf-8?B?OElLaUQ5TysyR0JWRGVoN1BSeWhtVFZmSnVLVW1XSDVEUG1wKzY0K2V6aWFH?=
 =?utf-8?B?b3VnWlNJMzZHMHVNUC9oS3pyMzIvd2tmTmFzUTBseHIyclpyNzVYKy9NNFlP?=
 =?utf-8?B?TTNSakY1NzN2cHpuNXhVTlpiaUVleGI2NmZPdExhNWRUYnZjYW83dVZwTld6?=
 =?utf-8?B?U3J6ZDcyU3lNR1ArMWFrdVM4SS9mVVJIdmtuby9JWldWSmQvU1pIZ3B3S0Nn?=
 =?utf-8?B?NTV1MCtZbWlWZ3B6Ym9WZVUvT3RkVGJFTFd4eThtZnVFY1FBWlJSWHRRTzBM?=
 =?utf-8?B?cjVNOWxsSU5wTTNNSml2K2w0RHNpUnowRkhnU3RTL0UwQld4MXFlSDZLaGMr?=
 =?utf-8?B?cUhMUTVjRmRMdTNGK3BUbDlET2V6N1BPa0s4d1BLV2xCY1NFbmM4OXdaRU40?=
 =?utf-8?B?bFRJR1BtVnA4Tjd0NGlET0RnbXl0QThWZ0VyTXRnRVFXNnNUSU1aaDYrL244?=
 =?utf-8?B?RTJSSXhQcXd0bnh3R0xSRDFVaGlpbForL0Q3REtpRUhVc2RHaS9YTE9WZU9l?=
 =?utf-8?B?eFVEWW9QT3BxSyt3WHMzK2ZCZEI2UmtXYmQwN084SXFaZytGTUdMRkdiTk5B?=
 =?utf-8?B?OWhVL3NJSDhiNHRCL2EvZkdLNWNLQnY1VThjcG1rZXAyTkVuZWtOZ3Z2VEhk?=
 =?utf-8?B?K2UrN1REV1lBQVpSVnJPQ2dtQVNwMlFGU3dUdVA3UmkvN1RyWHNvY2NnR2RM?=
 =?utf-8?B?b0M2US9PVWdjZjRsODEwSjUwL0pndU1CREFEL2lrZ1JCL1NjVjdqaWkwdGpD?=
 =?utf-8?B?TXh4NzZPczUzMDgyV2FPU0xSR0pmb1Q4YXpFRXVtVmRTWCtkK0hUeHJaZTBE?=
 =?utf-8?B?ZVlwTVN0OU5LZGlvSVM2a09ORTJNRFdPdnJscDZabzFMRmhmcy9aTytTWThG?=
 =?utf-8?B?M0hVMDd2c280dElsNzFQUmRSOEZRVHd2OTM1dWxxc0EvL2dEYi9SZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e798d9-7099-4db1-4d2a-08df189dd744
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 11:37:11.2437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaOpcbD1KE9R9IsNVmAnhc/ffKu6qadqwSQjZAHCpcgza8rA4Tq33BxR1z+6uHmVBJRKr28iEBny4wzRDxrrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB634945
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


> 
> Can you really do that?  AFAIU sysfs is now a de-facto uapi for backlights.
> 
> 

(answered to Javier's reply on this one)

> 
> With the sysfs interfaces disabled, who is going to trigger this code 
> except DRM?
> 
> AFAICT when the DRM connector updates the backlight status, backlight 
> runs this notifier only to call back into DRM to read back the value. 
> But the luminance property should already store that same value.
The systemd tools that read brightness could look at it (IE 
brightnessctl).  They wouldn't be able to write brightness but they can 
look.

But yes you're right luminance property would store the same value.
