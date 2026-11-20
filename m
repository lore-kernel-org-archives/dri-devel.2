Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BD606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=By34kMQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC991112AD1;
	Fri, 20 Nov 2026 17:19:39 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011052.outbound.protection.outlook.com
 [40.93.194.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 293CD10E237;
 Fri, 20 Nov 2026 17:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpJHrj+3ZvWYATQKG6l12wdI14bz+e4ekDaMJszRnZQX1/havVlWkxnnCSkCMog4Tp5KtV/Hw6J9N5ld5sABjxKWUf0WMAPC12izxcHhb8JFiSJc8CDFLnR6liAjv8LNA6r2cZ4XXsjeySzxwWjt8TUnWTygKT9nE5EhT+qLdeJa3V7+5H8dEfmKcOvIt/koqmqvXi/ETKD81oymvHif32ZZiRhLzd8QXRYnj6ql+ieLt1hU5L5XqHylM5oi2BNCdX+GWEZpvXHKmrDLp33Ed1I9ONcvxDDEv1doEOPWhvk6fkd8q96tTiDNwnpnpxRLLmWlIQPjxVk5mwB9f/efDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHzBAOIUyJXNV4zeVAtrpbG9sQTLWaahrmWE1B2dOgg=;
 b=QnBHXgnxPEsbCVOyStJN0lfgZ1uVdZUMS5bkewhfY36dRmOSqmZRysC/7lWplHQCLFqBuhNgaCfER1//WehT5DMNyq+unywZdjhsip84tXoEfScUkkqK060L9HpJ8TXp1RkmL4AiLcXZbhG6KZbY30V/TBaU8F7QL7qPfzh5K/WpcrT90Dfm4jRoiIDRudkAk0ZEq5h2mw7eX9U2Z/kHJys4vFQ8/ZtSUllXymi5ppENuw6W8ooxOeWa02Eokvp5PbiZt6fZ6vhgznK87uBnDZgjLgPDuHkBQpzW57Q/s/W1uam9qL18vITfG6h90lz78E/Jy2ksNwDaxln3DJ3TpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHzBAOIUyJXNV4zeVAtrpbG9sQTLWaahrmWE1B2dOgg=;
 b=By34kMQ6f9nrdZfN6B8xvgTVetH5jySZMdmSTrwLNa7A7umdvr96GduFRHa2Em/nIgkHUgnr8euI0Xaju9W9uskKVTILq6d0ThFe9Ye0e+jIIjZOiWDOulZPnx5qdGcgzWjw/3pVvFGN65vL6zhGRWZHCx6h7xVst4nRQt1wViM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 17:19:20 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 17:19:18 +0000
Message-ID: <8713bae1-9782-41d4-b09c-f14031203e88@amd.com>
Date: Fri, 20 Nov 2026 11:19:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/12] drm: add connector LUMINANCE property
Content-Language: en-US
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
 <20261119-superm1-backlight-property-v12-1-89d5217d3618@amd.com>
 <awB4Qe83u0l0XPKA@intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <awB4Qe83u0l0XPKA@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::23) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbe23bd-028b-4e52-4ce1-08df472a68ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|261022105027099003|261102123227099003|261021135927099003|261028144727099003|11063799006|56012099006|261026140227099003|261021123027099003|261021121427099003|10067099003|261009221227099003|261009223027099003|261026121527099003|6133799003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: MYn62MXeRmj7Mk9Ludwe9XXR7xeYAqv284f/T/EZgzh68TxDSDE+ZFoTdxQNBLd2MHNVlRs8nCeOo/+diZWRdg7otwav2ZPny9l7uHLBUIPaQpYKzjTt9YdV/tTL6ai/SBi7/7SulhmF6u2dRcS/14NUewMJwv93WpS9+P2MLDhG8EJHCbMAcQFxsNMpHOjwTavxP59ZVWhNuxdQlyBClqsr7UTtSNPvwzyha3CgpmhWuALpzBf7/E1/dFoKLZ2L9nDlx9bD0ROzPhjtOEFUWy70ITAx6OVXKqizYxB2VwSYSQr9CWXoz/l7NQ3ab1qXgA3u5IX/+kD8uC+KWOoudw0oW5UiU1wcpOZp7YR3DngrMiKKeQUphb+ySbvOu57iC/ZIj+F5+/RgKFYMuXnNWoS5XpHztpriIbcvvJ1SRN2lklJutwx7DzFFXzpzQVp9IWCGxTJ+n+Jqf98OIEyAkx8T0610xWE7y8CX2vQIe+TXpT7ra9dll6/YF/DgDkwI+mAAT01tBoBZi+TVCpddV08bEvjmyi2kZ08pngRczClFOAl8OpJiHBTrWy9x6MyGS1fKw8s8cmM1WYcMaQm71YTQmG9aS6pegGenpk7ECk3Cb5eUEU7hVKoOWIQejoTG1BL+p75MHr1r7Xwr1tS54eRO/WBwMZi0eN1f49JzYeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(261022105027099003)(261102123227099003)(261021135927099003)(261028144727099003)(11063799006)(56012099006)(261026140227099003)(261021123027099003)(261021121427099003)(10067099003)(261009221227099003)(261009223027099003)(261026121527099003)(6133799003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3IrYitOR2hDSUlCTmdFcHo2QzkzY2FlZnFUYndISTNTOVo1U216N3ZoaSta?=
 =?utf-8?B?bUpTZDRrY1dkWGUwZUtOME42bG5obmFFMXdzcnk0dXpCWGpxU0RLaEx6VUV3?=
 =?utf-8?B?TGtibEFyL0pKRUw2bStUMzNqRzdBRzJLV2R6d3VER1hxeEtXWjdZK3hLdU5F?=
 =?utf-8?B?VjkrN2J5azZKUWdtQmJnbTNxNE1GcTVLK2ZYb2IxM0ViM29YaEw5aWs3VVJr?=
 =?utf-8?B?RUNLQkt5UXFtR0dyYzA5LzVGSzk2a0tPNGxQdVFCQlZRSUdpdXV3eGc5ZHVQ?=
 =?utf-8?B?eE9sdGViV3hPcVFGVWpYZlREZWZFNHg5dU1aK0xBaGxNOGN3Qm1JVS90UHk5?=
 =?utf-8?B?T0hhMU82QUJWVm1wS0RxUnBHd1hFWnlCM1kzWHZ2MlMrWGJmQ2o5REhTb1M4?=
 =?utf-8?B?ZTZoWnFDUFJGRFpSbkJ4YTNtRHE3dDFSWmxxT25kdlF3K1UzTE15U3VMYkl1?=
 =?utf-8?B?bzFKazE5RU9KRHpLY1ZlVkVCTGxuVTZXR3BaMitGU01pai9uKzYxT1lYalhY?=
 =?utf-8?B?c1MwbU1LWmRxNks5TzdPYklxNjVWa2Z0SFdMS2NTcjFTWHo2Z2dNWWdYVFkz?=
 =?utf-8?B?ZEt2Qzl1NWdDL0U3TnpJNndlcDF1RUJJa3BCQkxMc214eU9wekhGeUxubklD?=
 =?utf-8?B?aUlDQjJacTlYZEdldUZzaHNqL3Q3RTFZV3o1amlLaEpkeUFjcDJNbVVzTkJJ?=
 =?utf-8?B?R1VvcC9uWVdEYjhSYnIxZTVoVDYrY09pWkVqVUEzUmc1dEd5MWIxZHIvdzIw?=
 =?utf-8?B?YXlBS1lVNC9VZ2hudWVtWEFkR3I5WFcraXl6V1pGUnBPSU1NRHpDWTZvdDNU?=
 =?utf-8?B?eXBMelNiTXBYRkNHUFJiQVg1cDIyMHNKOXZsMGJuMlZELzZPVVpxMW9JR0JP?=
 =?utf-8?B?YTVRTVEycjJ1NjhDeEpaMjdTN3lLbG9Dd1k0RER4V3h0R2poVkJRZ0hJK0ps?=
 =?utf-8?B?NitxWjM1YlE0Q0swUmhPMFIvNUhiRFBJc2tBMTQvT1VMVGtvL0I3VVhqbDJs?=
 =?utf-8?B?dnpsNTB0ZGIrTXdJZGh5dUcyS21ISkFLY3dWTUMwMHhoc3VIcEpvTzgySzY2?=
 =?utf-8?B?SEFRcUJQckFMcUpiUHlnaUFhYzNTeklHbWUrbnFoRmpwQUNldjVQb0VocTZ4?=
 =?utf-8?B?ZWNVdjFPKzMxalRVdTJPZkFoS0d2ekFuQzRmME5QUFhSeEQrdDhXbTJEdU10?=
 =?utf-8?B?SllUUGJBajdXRFh5SktKc3JYWU9tSGF5Wmx5VGVrUVNSV3E2MmRTc0s1c3Ev?=
 =?utf-8?B?R3NYSnNGVDhxNTZZVGFYcEZDZHpnSlYzWE9GTmdpM3Q2MmZnL3dOS3hVZjd3?=
 =?utf-8?B?b0NyRUdsK0tHMEJMbkxRSmRjb003ZWJYb244Qk1oa2Z6enZsQ0pFaGo2Y09i?=
 =?utf-8?B?WFhaNmVJMDN6WVdLUG5GUXovQXR6OFp2c1J2YW5lYi9VazdFait1djJtZFlG?=
 =?utf-8?B?cFRNRTlFVUxoRDNsaklsa2FqRGZGMlVEL04yUkxseXNnbmlHL28xeW1DSkpU?=
 =?utf-8?B?a0NscERGSVY2MGN6dC9ZY2RjaWEvaWwrRkFnTmExMkVYR0pFTzUzQUtCNGFx?=
 =?utf-8?B?WnZ3QU9acWE0OTBxOVdsdVVwcFd6aElKZmpuMGNvOStWQXR0aWsyMGczNS8y?=
 =?utf-8?B?S0ZKblUwT0NWVkZvV2hudjY3T2VvWHY3bS9lYmxkUHUyeVUzRjZUQzN3NEN0?=
 =?utf-8?B?Z0xhenJPS2xnc2IybGJoVFR0YjBYY0lCYWUrSktPWGdJVUpjWHVEejFJK2p3?=
 =?utf-8?B?bmVqdG5reDgzaVdrUlBLNTlUQ3N4cXVncTFQcEswR2tnRC96Ym9TUm5uOCtz?=
 =?utf-8?B?ZVUyNlI1Y3RBLy9OVUFGSGhYQk15YjVPMzZBUWtzUFM5THZqZlJEcmFEVFRr?=
 =?utf-8?B?bGYwM01ESTR1SFpNVmYxSjJDLzRGOVdOdm8xV0RWSk5hcVJ2Ym4zdFBJTFBD?=
 =?utf-8?B?MkxvTjdwVUV5SmZLYlcrVm0wWHZ1UHdwY3MvMmNrZDBKbDVCWkw4L05rZnIv?=
 =?utf-8?B?VVJTY2JnVDN3d3REZHhtT3RqQ0pYOHRyVFhxNDNlZXhVejZMcDFVRS9ObE42?=
 =?utf-8?B?Q0xvWFh1QlZEUWE0ay9lU2J1UXlJcHhBTmdXMmU1L0l5b3RsQ1VKR3pTcndM?=
 =?utf-8?B?ZWhPZ3pZd1BMN3lBWjRCUUo4Slhac0F0QU91SjQ3WVFOVFhqMlk4VVJ5R1J6?=
 =?utf-8?B?Q2tiSjJnY2VHc2I5ekxEa1h4T2JBSjJGNWQ4ZXVwVTg3ckRJTXFwbm1jZHZy?=
 =?utf-8?B?TzZ1ZHZZaHpoejhuQ2RWSTE2b2xxOWpVby93QVBqN2srSGJReGhXR3BFRW1n?=
 =?utf-8?B?YXFiUGxYOFliSWZFTDh3VFpRMkF1ZzZmakM1UURaRXptczVpeDhuQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbe23bd-028b-4e52-4ce1-08df472a68ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:19:18.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGXyt3Vte/dkoPWkjWC4IlsD3nIOKv1vOBxZn2ZN0K9xm7eI0CuvC11NWkY8w1I9Z3cn8sMIiI9k6pNbUQILNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/20/26 10:41, Ville Syrjälä wrote:
> On Thu, Nov 19, 2026 at 05:27:28PM -0600, Mario Limonciello wrote:
>> Panel brightness is a property of a display, and thus of a DRM
>> connector. Add an atomic per-connector LUMINANCE range property so
>> compositors can manage relative panel luminance together with the rest
>> of the display state.
>>
>> Keep the core backend-agnostic. Drivers create the property with their
>> hardware range and implement connector helper callbacks to set luminance
>> or disable panel emission. The atomic helpers sequence those callbacks
>> around pipeline enable and disable, including luminance-only commits.
>> The panel is left lit when the pipeline enters self refresh, and the
>> luminance is only reprogrammed when it changes or a modeset enables the
>> pipeline.
>>
>> The stored property value is independent of display power. A commit made
>> while the connector is inactive is retained and applied on the next
>> enable; disabling the pipeline does not overwrite it.
>>
>> LUMINANCE values are relative, driver-defined levels rather than
>> absolute luminance in cd/m^2. The interface supports emissive panels as
>> well as panels with a separate backlight.
>>
>> Keep the interface behind a default-off DRM_LUMINANCE option. Migrated
>> drivers retain their legacy backlight class ABI unless the new interface
>> is explicitly selected, allowing the DRM UAPI and legacy compatibility
>> policy to remain separate.
>>
>> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v11:
>>   * Don't call .disable_luminance when the CRTC enters self refresh (Sashiko)
>>   * Only call .set_luminance when the luminance changes or on a modeset
>>     that isn't a self refresh exit (Leo Li, Sashiko)
>>   * Fix the .set_luminance self refresh documentation
>> v10:
>>   * Add tag
>> ---
>>   drivers/gpu/drm/Kconfig                    | 14 +++++
>>   drivers/gpu/drm/drm_atomic_helper.c        | 98 +++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/drm_atomic_state_helper.c  |  7 +++
>>   drivers/gpu/drm/drm_atomic_uapi.c          |  5 ++
>>   drivers/gpu/drm/drm_connector.c            | 57 +++++++++++++++++
>>   drivers/gpu/drm/tests/drm_connector_test.c | 28 +++++++++
>>   include/drm/drm_atomic_helper.h            |  3 +
>>   include/drm/drm_connector.h                | 16 +++++
>>   include/drm/drm_modeset_helper_vtables.h   | 28 +++++++++
>>   9 files changed, 255 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 61111d50b1c65..1bbe2c2d7c76f 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -33,6 +33,20 @@ endmenu
>>   
>>   if DRM
>>   
>> +config DRM_LUMINANCE
>> +	bool "DRM connector luminance support"
>> +	help
>> +	  Expose relative luminance as an atomic DRM connector property. Values
>> +	  are driver-defined levels rather than absolute luminance in cd/m^2.
>> +	  Drivers provide connector helper callbacks to program their hardware;
>> +	  the DRM core does not depend on a particular backend.
>> +
>> +	  Drivers migrated to this interface will use it instead of registering
>> +	  a legacy backlight class device. Leave this disabled to preserve the
>> +	  de-facto userspace ABI in /sys/class/backlight.
> 
> I don't think this will fly if it breaks the backlight class interface.
> No one can actually enable this outside of some niche embedded use
> cases where backwards compatibility is not an issue. I think what
> you need is a generic backlight class implementation on top of this.
> 

The idea with this was:
1) to get the series landed
2) let compositors merge solutions around it.
3) Then add backwards compatibility to kernel so we can flip the Kconfig 
default.
