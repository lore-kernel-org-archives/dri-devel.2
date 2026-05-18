Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C5CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 08:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB8810E737;
	Mon, 18 May 2026 08:40:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z334LSHz";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D3A10E27E;
 Mon, 18 May 2026 08:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/EUjR5OMBQ/TCeUYYMwHS6u4nLhltpAe4b50lH4uxVcmuEsb+LqxNCSdzjGB82dJjglfvSWPFP40OEfSalLsWNR7byWrGpefSpYXAluhKKzKWmKtOHeGGsu9NDapBDRqk4R8HN2Oa86tifK/SlBtD+FvS/rII73XiKw1/XdbcbNbv2WYTRGUNOECMfbVUGojQyvT72+5kaibMVdYib/RsvcUUSjjYs6budBN73fG76lpjpq6KNlzHUt7h9X+Vj1fGjHMBHOKOO5ZhjljdyajIrhRLtkkGxaocuAax5c3zn2OlgIwuMhdosZpkzCl15lqDTIHIDm7ZL7mX038B/Mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbZHU8UlbaL3UPti2KCJVmXkjyGSUhlvH0SRbpQCybw=;
 b=EV5xQJNVtUvlHky2ILyitWhPzsu8fKS2mVzGkPBsCJOVJT3c8/QYQ1QTFWxjlZvGfdLRUE+t1slovORhKMPln41F861YGYZiS1Be+qrgb+TCk0ZGGO41V51ubduMXDwQzARyZxZHLYPEIoM9KeiXxEwrAwuXy9n9Rc3rSB4g+sz5fsxXCcomm8W5Zf/wywcf2NJuu42JSD6nxWINBKnr1Yst3xA1wgTaVKVBUt99FtkB7PG4ppbC0A2hno9bW6EPwx/DEV11TPcjgZmrv9YW7tCRL7wXtRmclw4ky30QpVV7Fpf5ocicNCJ3cWJt1o3mljn/g34MFdrLQWZo0+iYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbZHU8UlbaL3UPti2KCJVmXkjyGSUhlvH0SRbpQCybw=;
 b=Z334LSHzQ3acw4di9MAp0SdwTs9yhLJlk1ovZNuCWYcXIGwdKb5hZlc5sX5V1NQJWrv4o+H9uaxtaaqzt7Zno/0hB3CAd59CvgBPsTz1JRKVfQpBUQECNRgwV/xg821gn3zNQVRzvUwkqmIWTfmMXd6FBrlBTgP8ZyPttKGSux8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 08:40:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:40:05 +0000
Message-ID: <94187a8c-45d9-4751-9fbf-ac6ecfc990a4@amd.com>
Date: Mon, 18 May 2026 10:39:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove UML build exclusion from Kconfig
To: Alex Hung <alex.hung@amd.com>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, timur.kristof@gmail.com,
 pratap.nirujogi@amd.com, vitaly.prosyak@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260505162018.1755740-1-alex.hung@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260505162018.1755740-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: b324cf53-f6d1-4697-bd9c-08deb4b90ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003|921020|11063799003;
X-Microsoft-Antispam-Message-Info: CclEIDSjhvcatrgWQizA/7YtO5BMmwlezfaJAv1ahn9OLF/y+Hw8Y0cLewudo73N5ahJ10YEv3awhnNL/cED+ciEkCrtsgwAEhzCf81Zp9gPtmswuMakL5W2Wyt5q2VgmWpVi1CSZt/+KaFbuNHrd+AszovSgI8Dn1vw5qaZAWnl0oRitgj4hPMlzERVmfUvfTdBW/QvDpMEdHKpu71ZpfPnbUj+7RQN7edtLXeORaU5m7z3Q3nPxIWAk/VuyU+/ZO1ntZe8wvj7woDh3SRjNrKH5RVRIGFu9plGGFTZD6Ot17Qvxev0/Xao3ybptNY2oSIyOwetCiSwOtzgrmVVo2bYVwPtdUlkKCwsv3OvBqoPw0yQdNG7btyq9/XfE5R9IMxB9EfmlQK1RBVOd1mjtMusqNA3qkjQs05Ufa4ViT4Rtggv38bw853XKFYVeXNe1osWxpiNhtjhWC09DZxuL4cSx5PA3THHZ3EBPIdel0Cg73kILR43LL6PMAW8gLFSMT4qYWvciQUXR0jKb1A3X1t3NOyvnVUkw+IedqphI3V17woLNvMwgbjmEFytH/7EOQTUqaA9FMAmQIJwAP/rDnna3W+KQys4RC+E0+vZisaW9qigRRtQhik6extmQB86aXI8M8FObU/hqkBppb40R+7SgPmqIw5f3jIs6aP5kDKxZPizGsqcsU3YrGx+haNvKknInTPKvNPXolCIV+SxzLvjrWhvU1I1yqKW8vNi0Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(921020)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3VCaHFnclQzVzUvd0xKRndWVE4rUFBUaTRDVG9XK3VOa3lQcGo5N21EdmJu?=
 =?utf-8?B?Zm8wYkJSVkY0K0dEdm5ZWWEvazM4QjcxRk9TcEVHMmxrV2hsc0NFR2Y0bWps?=
 =?utf-8?B?SUhjL1VVYlNYV3YxanIyZmtBYXFDVWZwelAraGYyVTgzQzh1RS9SWVBaZlV2?=
 =?utf-8?B?T0NFUjB5Y05ET083MVYxNy9JMzRLeithMVgzUDZBK2xsTm5HNXJDMXRMWThJ?=
 =?utf-8?B?NWhmVGhjRzJxME5ERFBCN3R4MVdRd0lRZ2t2SUpuNWdITDRaTCsraHV5czYr?=
 =?utf-8?B?ZGYrcHl0NnROMWo3QmFQVHgyV2gyR1gvd2YrbnA4YnZ3K21lQVJtN2VNNm41?=
 =?utf-8?B?eGJ5VkRRTGdsVTVnU1VhRXcwTVg5Z052aTYvUU1yOUVuck1BelNCLzRMdy9Y?=
 =?utf-8?B?NkJ1K0pNdkczU1Qra0hDV3FtQzR6dU9JRWMrRWlQWkJBWkduZnRKalFXSHM2?=
 =?utf-8?B?Ylp6bENEUENyaXFmOHF0eDNWcWNOd3AvQnJVSTZ0SGlGNE1xNG05Y3MxeG03?=
 =?utf-8?B?ellDTlpJeFAwWldjYitHU0NKbXkzNUo2WllBRkNqdmRuVmpCYXNGNytBVzdS?=
 =?utf-8?B?ZlNlaXRWL21PQmIzVGl6T21ZN25DRG4yQUczbjYwMFFMUGR0elorOVBFQXhI?=
 =?utf-8?B?bFhVQWJPV0tacjZjOUJkOHlJZ09veEZ0SXgvOFZQY3hST0tLcTRNamVoRkVL?=
 =?utf-8?B?SGtOTXBPMU5XTDhVbkxsWUxONzlHYUV6Yldkc1ZFZFVXQlZyS2cvRHRkV2VM?=
 =?utf-8?B?UmlZVG1hc2RTMkVSZTl4RVhRSnZML2htaWxnV3dDcHdkeFFiQVNoMXlyR2hj?=
 =?utf-8?B?TWhaRVVKamw0aHJ1UjV2MVI3MUt4eHJaeHVaNlBRRjBrbUJIT0ZLWGo2T3pv?=
 =?utf-8?B?S1lkbmh6cnNqcFkrWCs1S3hqTkxLZE9pZkxNSE9LNldmMmNudXBoQWFyRFBV?=
 =?utf-8?B?d25XWHg5ZjhjaXRTazUwQWltcjlsQXlWYWFrcTNoc1UzWlhkK3NPSEdUOHNR?=
 =?utf-8?B?UHRUTnJ2M2o3eFBqNSs0M1g1WUQwb3o0cmE1djhMS1Q1Y1BzQU45eEdXalBz?=
 =?utf-8?B?d0NSa2VGQnQzNUNFK3JyYUhVd1BYQU5NTHJnN2ltdCtCanVzWW1SSUdBaDJx?=
 =?utf-8?B?VExnUy8vaHBYRmxPR3U3ZE5TRkY2R3B3Z3QwemJCWEZYdmFqL3Bjb3dVZ2lP?=
 =?utf-8?B?VGhGNEFyNHFHWXY1K2E4U2YrN0RMdDVsSHRRVi9vRnBpQmdHNXRjbFZlNnNo?=
 =?utf-8?B?UEdLSHVvWnhrK21taGFGL1pubkFtdkZOZFc4dWp6bGtsUUd4cnBkUGdlbW94?=
 =?utf-8?B?MzBxYzNrekVDWk9lbDVMQy90YmZ6dldLV1VCcDlscGRPVTNEY2hJenhoL2Rr?=
 =?utf-8?B?NlVHNlhtS1JCYWZxc2toTnpBVXhLNEY4TWdqRjFIblM4UEEzUHhLU050UllZ?=
 =?utf-8?B?c0d2enZZTXhaYU0vME1GV2FLT2RqSEc2cTVXNXozWE45Vjlyb2pGZVlBT2Ns?=
 =?utf-8?B?TTFHZ2lOdFFMYWY3Qm4rcTNpQUZBWTlCU3h6aXhva2VDOXk2YjB1Q1pqUjFw?=
 =?utf-8?B?bXhxN0U1UzRyYVpDWVhHS3NZVHI4eUlGMnA2RUdsY3pKNWhiRkpHLzBrNVBm?=
 =?utf-8?B?QTA0Sk5HMms1UkE0ZDcvSDk4WWVwSlExU09kZkczVkd1UmljODVTbkZSOVZk?=
 =?utf-8?B?U09yMElDUk1wSU9mMmxPUVVNbnBlSVRTUWovU08ycjBtN1VlRUp6dHpkOHFz?=
 =?utf-8?B?NjdreWoyME9oVU1ISFNyS1BWK05MUGY1Z1NhaDdJdTdKZXkzb1ZzbHo4OGUz?=
 =?utf-8?B?eEpUM0t3VWhFWFk1M2l3bFA3Q3BORmxFWVBRUEJZY0FuMEdkSmlzcUZRNlEv?=
 =?utf-8?B?UDhrRjFPQ21GWVFFRjJHdjJXd3lFNktVOUZoYXlFY2Z0dzVveUIzTmxYUng1?=
 =?utf-8?B?MVY0eitwRmsxb2dtVWVqZUtjV3gvVG93T282MzR1L1B3ZFVabWU1bWI2ekxM?=
 =?utf-8?B?endITG9BUFErdjcxbllFVysvZ2ZSbjFCZHJDUEl6aWJUczBKNFpYL3dReGxj?=
 =?utf-8?B?a0ZGWVBOOXowanI5Mndra1h2ZlF3RTRCSVpGVXpOdjFoeTR2K0FnN2o1RytP?=
 =?utf-8?B?OGRmazJFbjAydjVqZUFxWm5QdVJBZ1c0OEF5azQ0Rk4xNzVpU0g5VWRCZVhR?=
 =?utf-8?B?N2Z3VGJ3bWgwWUx5QzRkMUJtaHQrK0JjOHEzMVVMM0JmQWRkcnU2aElhS0do?=
 =?utf-8?B?RjNmTkFLWkoxekpiSlFwdnBOb2pGZ1lwWmI4aWhqYnlKTE9BL0ttNEhuOEFE?=
 =?utf-8?Q?iljT/sp7AcgO+nGIBY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b324cf53-f6d1-4697-bd9c-08deb4b90ef5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:40:04.9257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQZFKMU0xTLGj6ATAVJ8zu1a2po5RZYib5q/B6GjxgALa3Am+owWrynaW1jq+ra+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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



On 5/5/26 18:20, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> The depends on !UML was added in commit dffe68131707 ("amdgpu: Avoid
> building on UML") to work around build failures with allyesconfig on
> UML. The original errors were:
> 
>  - smu7_hwmgr.c: incompatible pointer type 'struct cpuinfo_um *' vs
>    'struct cpuinfo_x86 *' in intel_core_rkl_chk()
>  - kfd_topology.c: 'struct cpuinfo_um' has no member named 'apicid'
> 
> Both issues have since been resolved independently:
>  - intel_core_rkl_chk() has been removed entirely.
>  - kfd_topology.c now uses a proper #ifdef CONFIG_X86_64 guard.
>  - All other cpuinfo_x86/cpu_data() references in the driver are
>    guarded by #if IS_ENABLED(CONFIG_X86) or #ifdef CONFIG_X86_64.
> 
> Removing this exclusion allows CONFIG_DRM_AMDGPU to be selected on UML,
> which in turn enables running KUnit tests (such as amdgpu_dm_crc_test)
> under UML without needing a full hardware-capable kernel build.

Looks like a good idea but there are 5 automated reports from kernel test robots that the patch causes issues.

It could be that the robots apply the patch to the wrong tree, but please double check.

With that done the patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> 
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 0d4ce2ef9da6..49a7360f45ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -3,7 +3,6 @@
>  config DRM_AMDGPU
>  	tristate "AMD GPU"
>  	depends on DRM && PCI
> -	depends on !UML
>  	select FW_LOADER
>  	select DRM_CLIENT
>  	select DRM_CLIENT_SELECTION
> --
> 2.43.0
> 

