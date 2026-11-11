Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB2606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PujFkBdM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E164110FA0A;
	Wed, 11 Nov 2026 09:24:13 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011002.outbound.protection.outlook.com [52.101.62.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDD410FA0A;
 Wed, 11 Nov 2026 09:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RNZ7aD3g3ydt2591+fXEXdIZHiyv7+vdZ+GiIPEUpEo7OxuEzGp/kKhIYlUJrlFHF37eL9IaQD6pInWi1EViZQZSOaVxz3gU1Kl8RhI1IIwJywlmMCcdPTnkGEq93x+gLUwbdNp6AKM1T8TyFqY9oiDaIsuaaQj6Sx0U80jrsq/pSDciTYVe6PryAAfrtD/408XsTWEfPyfStwsJYiG/Om0ifIIL2wg36ebyJOhfeNdb4m/23sIS7YlwG3VYzKmTrFJLGh58JNApXszkPMYZnrTuRNR1cIngLv/raOwTyrU5u3gnbg1ehMrkKhhIhx4a/kpBtIwP6yNmz/WYGV0JaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFcDqK2fPyB2ZLKwegqqB9h+p4SF1p9mYr4HaU0VEfE=;
 b=JK8OtFEIR0crL+oAqHdBAN1RXEHwL4NcCg1L7/YOULcHNm7Y0zrAzRzA+cGoEg1Om7OGKIK/eoxrlyJAxVcTPdsY4hlYvKdz85X4JRcKrM52DBiQRA397x+07jK7wdozWECkgV928lzE3cEBqb0z1hFgFnZgzNjipB+sanM8frynD0HbjEq+YjllIYW8XTy/ESf//X+Kbds4DhXrdus1xe8nDqhMeUUa3yRu8ojYBv81Mrxbqqbsdbn+r9vB20vYn/OwVb68BRJeiVyCK8SakY5MOOSYUJM38mRSJTqyg37TXBEDrfvt7PtcOWREDdI3a4oLEEpwxpbXQM8brWeKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFcDqK2fPyB2ZLKwegqqB9h+p4SF1p9mYr4HaU0VEfE=;
 b=PujFkBdM43RYgZT+cmXhmTpFhjLqzgOqZuNQOMuDeLWXebKwkh99DLamlEeZER7egdSz80n8cOX4VfW1F46IEmyzHheVQogWkUaeHgDAay9LTvsdS09LVBBBl4cB1/EgBNsGLebcyLQvR0hgIAElXeooeMrR1GLnykxVZ84iyyI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by LV2PR12MB5942.namprd12.prod.outlook.com
 (2603:10b6:408:171::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 09:23:03 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:23:03 +0000
Content-Type: multipart/mixed; boundary="------------fD4MADec0wLtJi3ULNwhNWB0"
Message-ID: <7099a8ba-6508-4771-a97f-c681d0a8ceae@amd.com>
Date: Wed, 11 Nov 2026 17:22:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT 0/8] drm/amd/display: Stop rounding backlight
 levels to whole percents
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com, sunpeng.li@amd.com, 
 harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Cc: simona@ffwll.ch, alex.hung@amd.com, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, lohita.mudimela@amd.com,
 bhawanpreet.lakha@amd.com, dri-devel@lists.freedesktop.org,
 roman.li@amd.com, airlied@gmail.com, christian.koenig@amd.com
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 113b94c8-e2cf-4787-5bb3-08df3fd562f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|6049299003|376014|23010399003|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|22082099003|18002099003|3023799007|4053099003;
X-Microsoft-Antispam-Message-Info: B1iJySE/fY8XSFDxHr246a/zoKrwk6FRwOAFgS5TpUhqR7Q7DH0znaq4J4AoF7ggpWWraJFPxJgx0aRHcEihsPWY8iFM0KCyJZdVxIhS3z4VWMhEj86ztrAWzfhJEMjutnZ1Vo20xRkonVLxdAU5oH5ruy8I/oVQeW6amFNRQ4ifKiJ2z2kqtNS4V+vc27whGdaZ/fvuOhiFLlhylFzcO+GlDSlhvEBp/X1KeRbINIWt1jEFiDk92wFXEIpMj0WPenZ0tj8yv560SPoYDVSvjj61Oec0akxFoIId+ewe0yq5siFocWEwTDlmBvYh93aYek892zuRpsAJXqIzQX4wB+YPNUG5/M3Z2nYU0FKjysSme+b1/nMVQNoahBciuyePbZod4MSRFwKMPk1Pd9mCOOsTajHmZX9QClqwW60jUZRYA+/XTOKeloht0Feo9paV+wXsNCWdlp5yMH927DewNqpRtiq7c68lRQRnKrB6o1/O37/sN1+L7nsYAg8pDUp+9D3r3Ubxpyv0/WkAfHcBiq6EDrs+9wBZov4C/nGUOp+E71ImCKmCZoLL/259oULs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(376014)(23010399003)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(3023799007)(4053099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzJzUmo3Y0p5SUdNMjdmRlpTeEZGaG1uRnk2MnlOaXZCYnBZYnROR25hMzFK?=
 =?utf-8?B?VnpTTnhjVHFJejNwbW1uWGo3a29LVkl1S0FDQkFFanRUZ0lpOW1wUGQ0aFNa?=
 =?utf-8?B?WEJoOVBpZmxQbkkxT3plQkpHaHBseTdXQU1IdUhDUGxzSGNSM292N2x3Vlgw?=
 =?utf-8?B?U0dHV0ZoMDFnOGxaRXJrWFRpN3pHVjAwZFIyZDF2QUQ3VWdEWVV0bFJOMWc2?=
 =?utf-8?B?cEdYbGM1dFJkN1JIeTJNWVJHbXU1WjFzVTAwVE4vZkN6eXo2ZTJjS2xaRU0w?=
 =?utf-8?B?MXRrSTdJK20yS2RWMjY5UExQQU5ZcGdKb1FqU2N1QngxV21SQ0djT0FtbWgv?=
 =?utf-8?B?RVM3Y0p6MFJXSW41R1ptdHRCaVVMdjF4cU5Sdm5MdE9oSTUyeUF3OVp1NEdL?=
 =?utf-8?B?ME4rSDVybVZ5K1k3aGdhZ1dTdXFhNXRUZ0NVNmpsNTdNeDhtWUJVUEluQnc4?=
 =?utf-8?B?bXpyT1ZnQWRRck9jRXlJQmZtSUR2ZG5xVTRMSU9LK2NiT3ZGUGZWT3lvcXFS?=
 =?utf-8?B?bTVDdVZpSVpDU1Q2S2lrVVlTRVpBUHFlWkJ6dFJyNEtvZEt1UkR2Z3luVFpk?=
 =?utf-8?B?OWFDbUFoc2hzRlkwZUNCVVNKOER4TldLNnI0MUdVUjk5QUloUHdlOUF4NlYy?=
 =?utf-8?B?Rjc2NEpIWHNIeHFRZjZJeTFEaVo3UHFCT0FxUDNCMlVobFlra3R1VGtMYlhl?=
 =?utf-8?B?ODNhVytyVGdiSjFtZmtNSUpyRFRGUU5ESlZFNnN1dkZGbHd6bzNIczRoU3dB?=
 =?utf-8?B?Z2NKT21HNG1CdTJKSEJzWU1XSTNRa1prNHFaRGIzT28xUk9WZDBIUjVvYU1Z?=
 =?utf-8?B?M0lWNjFiWXZEZVJZOFpidkJOV0x3SVpuUTB1VEYvTXljQ3gwaEU1K0hWUEY2?=
 =?utf-8?B?cE83QnU1OER3VDd6WTZ4NUxDMVY0MFpDekJQMXFHYVVid3pLM09GalpHSE9v?=
 =?utf-8?B?Mm9veEpnMmN2YllnRjVWeDZHTnlyL0Z1YVBSTVUzc0ZQS0lud2dERUJZQUxP?=
 =?utf-8?B?NWFrVWJ3M0hRTXo4NWxLUWhjTjdocDgzWGdWSkVjVVo4ejJrbnEza3ZZSWNC?=
 =?utf-8?B?WGFRZk4zRmc2WFMwQTJQQzFscTNsUWRRU04rYnV3bW5CY2hOV3lrQlNBUDZT?=
 =?utf-8?B?K0RYN0JhSGF6Z2ZWUzV0UFBrdHFMd0lQWVdIbkxQNElkMi90V1JOSjFSM2Ew?=
 =?utf-8?B?OXVlNHVuelcwd2cva29KclZuYzROaTh4SlloUEZBNUMzeXlwQ0RZM20vWWtV?=
 =?utf-8?B?QnBvcVVFbkNoanVMNnZzaGNIcHdLaDJsR2t0allMQnE1S0NKUnBORHlRaUVC?=
 =?utf-8?B?azNBMmhqWk90cWFZZHY4aDJMQTJnWTRoRVNKemIzbTRtNThqT2ZWU1RmL1lD?=
 =?utf-8?B?OWo2K2dFc2F2bExhV2ZyM3BTZkM0SFZUTUtoeDRPcE1jeUdML3kwV1Yzdnlh?=
 =?utf-8?B?WTcyYkw2UGp0cFAvZmNRZFgrZlFjend6OWZPRHNIMlpRSjdXVytiN2xGaHpL?=
 =?utf-8?B?REYvcVQ3bkk5cjhlOUZLNG0zbGxPUUNaai9GSTFYbVI4ZG1yZTUzRk5GanhQ?=
 =?utf-8?B?UzlnUHhKSXZBam5QMW0zNkRKZnV2QjNhMVZYd1pNa1FhOUwzS3d4SVVrK2dD?=
 =?utf-8?B?WnYyYndKNGlJc0UxaTZ4ZTloUmk3SEpacnRZdEZ1clUvbGVVV3AzMmlCZVdl?=
 =?utf-8?B?Qmp0QlBUYm5zcmo3c0VPMjlxOFZwcmlaR25HSjFIMy9KV2dYZzFFQk4xNnVQ?=
 =?utf-8?B?T1BRdmFSMXdWc0t3RkhMOGZ4Z1liUVQ4cmNoVlYxZjBvTEFlU1BidGFVQTFE?=
 =?utf-8?B?OWlaWUJFVVNVd0xYL3RzOXI1L1BuaXRibWhBNStHQjhma0M5VDZmNkhkZEh1?=
 =?utf-8?B?a0VjcnVmbkVqN3YvbjBOUUc1VEVrdm5YTkVjWXpUdng5d1pqYkdhUEd0cWlD?=
 =?utf-8?B?TXBqb1FTc2xmeGlsdFFWSGRjVmVEd1ZnZDRkbHYrUVBHV3RBMmU2Y1oxYWhw?=
 =?utf-8?B?a2N5M2VZRFF5ZGh0Vmk4ais1aGxpdmJWUDBZaWJpVFFia3FiM2xEUDlrcER6?=
 =?utf-8?B?MDlnVEw1T09Gbmg5cFpnbTN4b3dXY3dnSHdydUxja0dTQWFEL0MvSHRUS2tC?=
 =?utf-8?B?YVdvdldaREtOMnJVMWJoWU42N2JlVWphOENXVElBWmJkdWZaWWJGem8wQjY2?=
 =?utf-8?B?TkZxOENNTTNlSmlEaDhTS2FIUkJnNVVSYzFUbFlpMDB4WGN4cjJYNitoVU9M?=
 =?utf-8?B?dkRvYlNpVUdCNCtRakNqQTdURVZXc0lDcEZBZEttR0VON1lRaS9HempHcnZP?=
 =?utf-8?B?bVBCZ0g2azBVRzdIUGQ0ekljSnR3ZTc5dXdIVlpNQ3l0cEhkTW05dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113b94c8-e2cf-4787-5bb3-08df3fd562f0
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:23:03.1596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhZ5D3qcxN3F/nERN7UiJhEWDDJecPHyjbzfJEwvMIzNyUyeoU9ApO14oZNNetsxQCVIxkA/PE7XQUSiXUtAEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942
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

--------------fD4MADec0wLtJi3ULNwhNWB0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hugo,

Thanks for the series and for digging into this.

I have been working on a similar backlight update that takes a different 
approach: instead of fixing the conversion in amdgpu_dm, it removes it.
DM passes a linear brightness percentage for every panel type, and the 
power module does all of the conversion:
     - VESA AUX: nits, mapped linearly over the panel luminance range 
from EDID.
     - AMD AUX: nits on OLED, PWM otherwise.
     - PWM: through the power module LUT built from the ATIF curve.

With that, most of this series no longer applies, since the DM code it 
touches is gone.
Patches 2/8 and 3/8 (LUT interpolation in the power module) are still 
useful on top of it, and I have already given my Reviewed-by on those.
Could you test it on your machine?
   drm/amd/display: Use panel luminance range for AUX backlight in power 
module
   drm/amd/display: Add power module API to set brightness percent
   drm/amd/display: Pass linear brightness percent to power module
   drm/amd/display: Read PWM back linearly with the linear backlight curve

Thanks,
Ray

On 11/4/2026 5:55 PM, Hugo Sales wrote:
> Both backlight paths in amdgpu_dm_backlight.c map the 16-bit user level
> through the ATIF custom brightness curve, whose points pair an 8-bit
> signal with a whole-percent luminance. Both round the level to one of
> those signals and the luminance to a whole percent first. That hurts
> most at the dim end, where one percent is a large share of the light.
> With the curve of an ASUS ROG Flow X13 GV301QH, minimum 12 and 49
> points:
>
> - On PWM, the lowest level asks for 2% of full brightness, and the
>    first 2% of the scale steps from there to 3%, 4% and 5%. Each step is
>    50%, 33% and 25% brighter than the one before. The bottom 10% of the
>    scale has 18 different brightness values
> - On AUX, with amdgpu.backlight=1 to force the unsupported AUX path,
>    the 1..512 nits fallback range stays at 1 nit for the bottom 6.1% of
>    the scale, and the next steps go to 3, 5 and 7 nits. The bottom 10%
>    of the scale has 4 different values, and the top stops at 496 nits
>
> This series interpolates on the unrounded level and rounds once at the
> end. On PWM, the power module also interpolates between its LUT entries
> now, from millipercent to PWM and back. The bottom 10% of the scale then
> has 6018 different values on PWM instead of 18, and 33311 on AUX instead
> of 4. Level 0 still gives the panel's minimum and the top level gives
> its maximum. On AUX only levels 0 and 1 now sit at the minimum, instead
> of the bottom 6.1% of the scale
>
> - Patch 1 renames the min and max of the user range to user_min and
>    user_max, to avoid confusion with the curve's signal_max and the
>    output_max that patch 4 adds. No functional change
> - Patches 2 and 3 interpolate between the power module's LUT entries,
>    from millipercent to PWM and back
> - Patch 4 stops rounding the PWM path
> - Patches 5 and 6 test the PWM path and the LUT with the GV301QH curve
> - Patch 7 maps AUX through the same curve code as PWM, which reaches
>    max at the top, and removes convert_custom_brightness()
> - Patch 8 tests the AUX path
>
> Patch 7 changes what an AUX panel gets. Until now an AUX level asked for
> the curve's luminance percentage times the level, so the level went in
> twice. Now it asks for min plus that percentage of the range above min,
> the same luminance the PWM path asks the power module for. On the
> fallback range, half the scale goes from 159 nits to 315 nits. I found
> no reason for the old product, but I may be missing the intent. I also
> can't test it meaningfully, as I don't have a panel with an AUX
> backlight
>
> The series applies on top of "drm/amd/display: Fix the doubled AUX
> backlight minimum on the custom curve" [1]. That series fixes the
> minimum going in twice on AUX, and asks whether the ATIF curve is meant
> for AUX at all. Patch 7 keeps applying the curve on AUX, as the code
> always has. Since it changes what AUX panels get, it has no Fixes: tags
>
> One question for you: on PWM, above the last point the curve still runs
> to 100% at max_input_signal, as backlight_signal_to_luminance() did,
> while the level maps to the 0..255 signal scale over the whole user
> range. With max_input_signal below 255 the top of the PWM scale is flat
> at full brightness. AUX keeps ending the curve at 255, as it did
> before. Should PWM end at 255 too?
>
> This is also a request for testing. My laptop drives its panel over PWM,
> and the panel ignores AMD's AUX brightness, so I tested the AUX path
> only with KUnit and with the amdgpu_dm_brightness trace on a forced AUX
> path. If you have a panel with an AUX backlight and an ATIF custom
> curve, a Tested-by on patches 7 and 8 would help. The middle of the
> scale should get brighter, the bottom should no longer sit at the
> minimum and the top should reach full brightness. Patches 1 to 6 don't
> depend on them, so they can go in without the AUX half
>
> [1] https://lore.kernel.org/r/20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> Hugo Sales (8):
>        drm/amd/display: Rename the user brightness range to user_min and user_max
>        drm/amd/display: Interpolate between backlight LUT entries
>        drm/amd/display: Interpolate when reading PWM back as a percentage
>        drm/amd/display: Stop rounding PWM brightness to whole percents
>        drm/amd/display: Add KUnit tests for the custom brightness curve
>        drm/amd/display: Add KUnit tests for backlight LUT interpolation
>        drm/amd/display: Map AUX brightness through the custom curve like PWM
>        drm/amd/display: Add KUnit tests for the AUX custom brightness curve
>
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 218 ++---
>   .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   6 +-
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 923 +++++++++++++++------
>   .../gpu/drm/amd/display/modules/power/power_abm.c  |  72 +-
>   .../drm/amd/display/modules/power/power_helpers.h  |   4 +
>   5 files changed, 784 insertions(+), 439 deletions(-)
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261102-backlight-curve-rfc-1bb4b6dee24c
> prerequisite-message-id: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
> prerequisite-patch-id: 0eefd25bf4ad8f6d779c7a0b0a63f84969b67fca
> prerequisite-patch-id: 016515673f79f623de1e50dd513e5440587329b6
> prerequisite-patch-id: ba453baf376b5410d66feacb1956eea933042ae8
>
> Best regards,
> --
> Hugo Sales <hugo@hsal.es>
--------------fD4MADec0wLtJi3ULNwhNWB0
Content-Type: application/x-gzip; name="dm-bl-pm-curve-patches.tar.gz"
Content-Disposition: attachment; filename="dm-bl-pm-curve-patches.tar.gz"
Content-Transfer-Encoding: base64

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

--------------fD4MADec0wLtJi3ULNwhNWB0--
