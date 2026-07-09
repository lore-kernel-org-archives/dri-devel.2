Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3128FC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A6210E666;
	Thu,  9 Jul 2026 17:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XDDyDqf7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1594F10E6C5;
 Thu,  9 Jul 2026 17:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcJz9mYLpEvqI/G07xPoo13G7q8TeFOxzPLOvLj0/UI5yY0zHiET0s1wjYFT3i8IjfcGQJvt900K+15FWVWEhAIH+wIygmGJNFeuMShc5+UoBd93fPZDrD2ANUUcDFeWwftswHW2vTs9ztw8lJiUyc1rCLFZEOqh0kKbMojWlmCfmbZptuBIdy03O4y02MJWrhgKizrdx8aNoffgx6PQFOlvLzrY7LchN53hyCevcRKoS35xApIfIxTR1HRYGLz7trlQSoXISg/Nx+sooEn4GseiggOsOwhQ3fXMaGQoHPLPyPObhZPTssubnHNE3Ad7Nv6i6yU3ewDv4J0PVQ7c4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ/eePD36oZBCKlbkYOfjmTcOpRy+73D6NLOE+smo78=;
 b=WEJD9YAdmT/bfl6AJwSSRTHqeUpa/YTxPLUAycqAAovjBHVCmnkyomUsIIbgqSW3D/u+pKYL4cUpwFFOlOhDWwt8pru8R9IrSptqrlkNnhiH7KDn6luSYpfxiKuyRIIlsICKMlc8gL723h7yjzJeSv0ZllAuxIAw66EGc6IoDfUBMI1K3wucjVtiqfLVdBNlw1bcrCfavw7WBBPcJNkThlydPg1P/7fqWTCWIcNNpCXKXmhBZpr4ZmQ8U1Wbcncb8Y0YA0hWFedw4jt+P2Yk3SZRBvdXUtachxH7Crd3vzSjinePHLNcrL6h8BSpEKnCHHLpYqtvvesdMHobuDhFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ/eePD36oZBCKlbkYOfjmTcOpRy+73D6NLOE+smo78=;
 b=XDDyDqf7s56XD/upB4w+VgY/HogGUM4nAQdK0UliBVbW+pxVXd4CZMaNzA8jArW3S0/2xF/fGS5wuZXnEPgKfy2CLjorYVgOfDW6A5vurHLwnZbYm8gwWAUkuPCjlUFOjt/yOWPdxYOJ4+nXhYXyuUxBvyCdmUkMNVSx+TRhgwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6114.namprd12.prod.outlook.com (2603:10b6:208:3ea::5)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 17:30:14 +0000
Received: from IA1PR12MB6114.namprd12.prod.outlook.com
 ([fe80::1273:26cf:eeaa:e2b3]) by IA1PR12MB6114.namprd12.prod.outlook.com
 ([fe80::1273:26cf:eeaa:e2b3%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:30:14 +0000
Message-ID: <0a341678-062e-46d4-affc-d56cb7c95ba0@amd.com>
Date: Thu, 9 Jul 2026 13:30:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/display: unify HDMI/DVI/DP SST HPD debounce
 delay
To: Nick Haghiri <nick@haghiri.net>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Xaver Hugl <xaver.hugl@kde.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
 <20260709-hpd-debounce-unify-v3-1-d7584920a242@haghiri.net>
Content-Language: en-US
From: Ivan Lipski <ivlipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260709-hpd-debounce-unify-v3-1-d7584920a242@haghiri.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To IA1PR12MB6114.namprd12.prod.outlook.com
 (2603:10b6:208:3ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6114:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 63026cbf-8a8f-413a-2363-08dedddfbbb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 3UhRSHS5Pkmd2iBvdAAtjzhdCHdYc+S1UNkDucvNTj91q4bHHI3Od/eQ4xkIt6ox23CDcfip7OZRX+9hbdW3SL2BuaeQFnMMbNjf8YrFlmjRTKAYcrRd2IDHac/NZXzjF4GwNk8jWij98U06KMZxS6LGseG6eilU/ho6gLOwpw6fOMoyv+pysUwHn0F5FmSWNA6NQTRcrJOg4fPcEekPl7XAzYST3tWnoXEY6OeDX6VDq1ny+RwikITXTwtls7pWTYGkfPbET0L1urQ1P2uUjkRl4pVri31o962UrMyPy3EQX/VuZul7BpKTBzHRa3AyKoW3iGlLPhOlsIQ/ElhC2LMf52SbaRwgXtKA5IwfxVWI60fAmEPffbtsJfW7pjxc0int9pVERyN/x1LYTOkJiim2Fe+dUG2GlpA0vB8j9575/H8wReQ7+xP0ryeP0CWlef68bdKKoGEYNy/w1IDqRCgcYyxRRmbkDCJTBYzHwX1Wb/v25HwX4WGK3Wx/vXspmBqWMJxu0IgnAs9RmA9kgZMnsII79DqfvIg9H/LYTBDXdOryp0jas2wde41gwHI6b5fhK/NmR428fzFzokSrXx9tSGmc97+V13JfBwB9JVieZrnPNdpYsn85AqGSSayz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6114.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L25vMTRPbkk5bkc1VWI2RzFlOUlGWnJ5TFZaU2tTZWQ5R1hCSUJFYXM1UE5w?=
 =?utf-8?B?R2ZoVVlHTnZ1M0xwWXhkU1IxMEdjdzdJUzJPWkl4Q3FnUHJNNHFQOG9qQ0pm?=
 =?utf-8?B?QndxdnFpM2lVT2czdzhXQy9Nd3Q1NS9PcEVMTXlpQStWemNHOE1GMFVxdTc3?=
 =?utf-8?B?VTZmVWVHOTdBOVdQeVh2Y0ZGSHE2RTcyMitsUzBHR0FhYUUyV2ZCRGJXWEtn?=
 =?utf-8?B?Q2twc2Vseml0N2tqUzFvZHJTeiswb0c4Rm5mWWlyOGZ1NEJNS1Q1S1N2OXNG?=
 =?utf-8?B?blBlYmtRN0JQd3VMR3FDaDg5ZVNvZ0Z5OFJHMDdFek10NFFRa2tDbkJtUzBJ?=
 =?utf-8?B?TGYrTXFSbmVtTmw5Sm1zYzczcUJnYVMvdXZaaGk5WWlua1hYUzBzWG5DeVFG?=
 =?utf-8?B?SVBPWllQZ1dramY5QTJHU2pNWUZwUjhnRUVVdDBRNFVVcE5pM1BwaG5wdE1h?=
 =?utf-8?B?dk0xVHlyVit4UWZ4b0RLMDFDVUNMdXVSNW81cHlNcHBoVitzQ2xJMDRCNi95?=
 =?utf-8?B?aTlKSmVRb3NuK2p4WE1EeDQ1SUtnRU96aDd4eldJUys1ckx1ZFFQZWNNMnVI?=
 =?utf-8?B?YTVML3A2NGp0bElnRm5GYjczUDRyL2dydUcreGxjemRGZ3VCeHEwVlBSUHBr?=
 =?utf-8?B?TzJ0M2xNNEZXeDNoZVhZVUoxNlBiVEIzTmNoeTBDNlZveWFFaHRrMDBEWEdx?=
 =?utf-8?B?YzAzbEVjSEJMSFhCMktJU2doNi84WTZidEtvcTMrNWtCZ0VGbGsvVldwMSth?=
 =?utf-8?B?dDFadGs1OUYwUy9BeTRzZnpVY1c2T1d3eno5aGhiNUluVFlRTDJrWTlKS00y?=
 =?utf-8?B?RGVtU0dDTHZ2eWlXZk9mNFEzM0tKQ3VBOHVvTU9tYlFaMURLMlFRNVBrU09C?=
 =?utf-8?B?WVV5L2tRNHYrMzZoS29oem14eU9wQ2s0cE90WWZJQ0F4bDFRNmtPK29jc3VS?=
 =?utf-8?B?VEwxcGRMQlh5TWNSUFNoYTNQT0M5cGdyZTd4bEo2ekxqckUxYkQ3a2s0blcv?=
 =?utf-8?B?Lzg0b1J4YWoxZXFhVHF4azZMYXRoNXFBcjJBZzJOclhYQ0IyWXZLZDVrRG9n?=
 =?utf-8?B?THJnMzN6aTdQZy90dVBZeDBxSU0vQ0psK2ptZW5FRGZWeXgyL2ZWQkNXdDk3?=
 =?utf-8?B?OWlvek9RMTh6UWxuVEcrUEJTRnNiUTU2VUFzZE9aWXBGMmlXcThoMk15VGRJ?=
 =?utf-8?B?K1ZBQmFCdHhGTWs0ZUR6T0RyZ1VCZFlwUklJK2pJZjFYYThmNDRuZjlweUtQ?=
 =?utf-8?B?YzRBcm1NcUdCSDlHMHlhRlVLQS9pM0lxV1JLWmxRTzlnTkdZekQ0UjU4b0s5?=
 =?utf-8?B?L2xkQXBjVTVzNzgrWEdpWk1ibjE3ekVreVpYekU5a0h3U2hwYit6dzVpZEsz?=
 =?utf-8?B?cjRWNUtTRXU4NEltTzlacGlLV0tETGdBd09zUDBubDBjeG5OWXNYRXh2dEJN?=
 =?utf-8?B?VzNReDdndFNveEVweG1jRjV6aFcyTTE2NTZrQVNzMzFJN1ZZMFJuSVFjTnVm?=
 =?utf-8?B?Q1ROelJ2d1FSYWI0QzkxYTBoV0F5MU9hTGkrWjlyU2pvRDZiRFZzSkd3VFVz?=
 =?utf-8?B?NnlKRVozalltSDVwR3I2UXQ5ek5lK0tzQ0ZueURuR01DaG1vT1hrc2FRZHZO?=
 =?utf-8?B?a0U3UjVORmdGYXk3eitzSVllWk9CNVQ2dE5CUFJLbWFTQmVyRTZjY0VOWUJI?=
 =?utf-8?B?TlRtMUw3azUrb3R1dEhoUk5aOVBsbnhLT0JjbDd4WjZiRXpNcFowMW1Ga3Br?=
 =?utf-8?B?UEpNaHVDNUtBdE1BNk8ybzNiSmFmd2ZNZDducTBMUExBRmxiL2VMNnlLYWdO?=
 =?utf-8?B?VU5pcWpSWHpnL0tubWM1Q29rakNETDR1YWtsb0tEaWM1aVZJckUyY0VucU5S?=
 =?utf-8?B?Y2pnVW1vNHpUWjdwWkxEcUp0UjNDZkFNY2F0aGdGU0thMDV5VitUbFZnVCt3?=
 =?utf-8?B?VFZtMHFmR0hXSWllc1FHa2VWaWFxUHhXZTE2b3EzclNEUFA5M2Z5c0tiNGFq?=
 =?utf-8?B?L3hwc1BRZEdsR2x3VVNobUJneCtSMFV5bjBpaTNRdWx1K2ZEMkpVQlpyRjY5?=
 =?utf-8?B?Wi83MUZJTFVscmFQWnRSWFBiMmtnQ0dCRzR1a2NVZnJJRkZRSkNNSnNBdjQx?=
 =?utf-8?B?QlRDZ1V1LzJZM0tpTlhVS2JCVHlRVkF0ZXNjWVQxN2ZtK1REQzQvMVRWdWpU?=
 =?utf-8?B?RUExRlhFUlp4YnNPNml5ZW9HbFRya0NsK3JWeVZ2MjZNbFlPalJqbHB5RTNR?=
 =?utf-8?B?Yk11MEo5SkI5VHF5L0pXeTlyVnphWjUzdkN3SzlSb2ZiWDJqSEdjQkowemI5?=
 =?utf-8?B?S1hWU2tZY1hXMG45cDRjbFF5d3diT29Td3g5TmZ4NUZOeXRZWmtKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63026cbf-8a8f-413a-2363-08dedddfbbb2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6114.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:30:13.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klukngkKof7x8rYUs23YY+4XyzXkw9wrGZrvDOBsxvmlCjRsmlrS48nRC7uR6sC67mJUfOkuZ5KYU+jZrJpmcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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


On 7/9/26 10:15, Nick Haghiri wrote:
> Per review feedback on the DP SST debounce extension, fold
> hdmi_hpd_debounce_delay_ms and dp_hpd_debounce_delay_ms into a single
> hpd_debounce_delay_ms module parameter (eDP and MST still excluded),
> and rename the shared connector fields, work, and cached sink from
> hdmi_* to generic hpd_*. Also extend eligibility to DVI, which shares
> the same HPD toggle behavior and has no MST/eDP variants to exclude.
>
> Also add an apply_edid_quirks() case for the MSI MPG 274U
> (drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0)) that enables a
> 1500ms default debounce delay for that panel, overridable by the
> module parameter.
>
> Signed-off-by: Nick Haghiri <nick@haghiri.net>
> ---
> Ivan, generalized to a single hpd_debounce_delay_ms for both HDMI and
> DP SST as suggested, and added the apply_edid_quirks() case for the
> MSI MPG 274U (1500ms default, module param still overrides it).
>
> Went with replacing hdmi_hpd_debounce_delay_ms rather than keeping a
> back-compat alias, since it's only a couple cycles old. Shout if you'd
> rather I keep the alias.
>
> Alex, done. debounce_eligible now also checks dc_is_dvi_signal(),
> reusing the same hpd_debounce_delay_ms param. Updated text and
> comments to reflect scope now being HDMI, DVI, and DP.
> ---
> Changes in v3:
> - Extend HPD debounce eligibility to DVI (dc_is_dvi_signal()), per Alex
> - Update comments/docs to reflect HDMI/DVI/DP SST scope
> - Link to v2: https://patch.msgid.link/20260708-hpd-debounce-unify-v2-1-d214832551b3@haghiri.net

Hey Nick,

Thank you very much for this patch.

My only concern is that a monitor that requires HPD debounce delay on 
HDMI may not need it when connected via DP, a vice-versa, so I think we 
should differentiate them.

I think a proper approach for this would be adding two new integer 
fields to the dc_panel_patch struct for DP and HDMI each, so a delay in 
ms could be explicitly set for a specific monitor and specific connector 
type.

So in the apply_edid_quirks, we could have something like this in 
apply_edid_quirk

/* Workaround for monitors that toggle HPD on entering deep sleep */
	case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
		if (!aconnector->hpd_debounce_delay_ms) {
			drm_dbg_driver(dev, "Enabling HPD debounce on panel id %X\n", panel_id);
			edid_caps.panel_patch.dp_hpd_debounce_delay_ms =
				min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
		}
		break;

That would also require changing logic of determining the 
`debounce_eligible` as we'd need to check for initialized 
dp_hpd_debounce_delay_ms && SIGNAL_TYPE_DISPLAY_PORT or 
(hdmi_hpd_debounce_delay_ms && (HDMI || DVI)).

sunpeng.li@amd.com, alexander.deucher@amd.com, what do you think?

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 26 ++-------
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 18 ++----
>   .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 29 +++-------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  8 +++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 65 +++++++++++-----------
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  2 +-
>   7 files changed, 64 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c085a6cc1..af1748984 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -270,8 +270,7 @@ extern int amdgpu_wbrf;
>   extern int amdgpu_user_queue;
>   extern int amdgpu_ptl;
>   
> -extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
> -extern uint amdgpu_dp_hpd_debounce_delay_ms;
> +extern uint amdgpu_hpd_debounce_delay_ms;
>   
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 78df53b8c..a82d807f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -245,8 +245,7 @@ int amdgpu_damage_clips = -1; /* auto */
>   int amdgpu_umsch_mm_fwlog;
>   int amdgpu_rebar = -1; /* auto */
>   int amdgpu_user_queue = -1;
> -uint amdgpu_hdmi_hpd_debounce_delay_ms;
> -uint amdgpu_dp_hpd_debounce_delay_ms;
> +uint amdgpu_hpd_debounce_delay_ms;
>   int amdgpu_ptl = -1; /* auto */
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
> @@ -1105,25 +1104,12 @@ MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disab
>   module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>   
>   /*
> - * DOC: hdmi_hpd_debounce_delay_ms (uint)
> - * HDMI HPD disconnect debounce delay in milliseconds.
> - *
> - * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
> - * generate while entering/leaving power save. Set to 0 to disable by default.
> - */
> -MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
> -module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
> -
> -/*
> - * DOC: dp_hpd_debounce_delay_ms (uint)
> - * DisplayPort SST HPD disconnect debounce delay in milliseconds.
> - *
> - * Used to filter short disconnect->reconnect HPD toggles some DisplayPort SST
> - * sinks generate while entering/leaving power save. Set to 0 to disable by
> - * default. eDP and MST are not affected.
> + * DOC: hpd_debounce_delay_ms (uint)
> + * HDMI/DVI/DP SST HPD disconnect debounce delay in milliseconds. eDP and MST
> + * are not affected. Overrides any per-panel default set via EDID quirks.
>    */
> -MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
> -module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_delay_ms, uint, 0644);
> +MODULE_PARM_DESC(hpd_debounce_delay_ms, "HDMI/DVI/DP SST HPD disconnect debounce delay in milliseconds (0 to disable (by default) or use the EDID quirk default, 1500 is common)");
> +module_param_named(hpd_debounce_delay_ms, amdgpu_hpd_debounce_delay_ms, uint, 0644);
>   
>   /**
>    * DOC: ptl (int)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index abc17f547..5235a5ef6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -61,14 +61,9 @@ enum amd_vsdb_panel_type {
>   #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
>   
>   /*
> - * Maximum HDMI HPD debounce delay in milliseconds
> + * Maximum HDMI/DVI/DP SST HPD debounce delay in milliseconds
>    */
> -#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
> -
> -/*
> - * Maximum DisplayPort SST HPD debounce delay in milliseconds
> - */
> -#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
> +#define AMDGPU_DM_MAX_HPD_DEBOUNCE_MS 5000
>   /*
>   #include "include/amdgpu_dal_power_if.h"
>   #include "amdgpu_dm_irq.h"
> @@ -878,11 +873,10 @@ struct amdgpu_dm_connector {
>   	enum adaptive_sync_type as_type;
>   	struct amdgpu_hdmi_vsdb_info vsdb_info;
>   
> -	/* HDMI HPD debounce support */
> -	unsigned int hdmi_hpd_debounce_delay_ms;
> -	unsigned int dp_hpd_debounce_delay_ms;
> -	struct delayed_work hdmi_hpd_debounce_work;
> -	struct dc_sink *hdmi_prev_sink;
> +	/* HDMI/DVI/DP SST HPD debounce support */
> +	unsigned int hpd_debounce_delay_ms;
> +	struct delayed_work hpd_debounce_work;
> +	struct dc_sink *hpd_prev_sink;
>   
>   	/* HDMI compliance automation */
>   	bool hdmi_comp_auto;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index c79a8ada8..798825ec1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1748,12 +1748,10 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
>   		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
>   
>   	/* Cancel and flush any pending HPD debounce work */
> -	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
> -		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
> -		if (aconnector->hdmi_prev_sink) {
> -			dc_sink_release(aconnector->hdmi_prev_sink);
> -			aconnector->hdmi_prev_sink = NULL;
> -		}
> +	cancel_delayed_work_sync(&aconnector->hpd_debounce_work);
> +	if (aconnector->hpd_prev_sink) {
> +		dc_sink_release(aconnector->hpd_prev_sink);
> +		aconnector->hpd_prev_sink = NULL;
>   	}
>   
>   	if (aconnector->bl_idx != -1) {
> @@ -2828,20 +2826,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>   	mutex_init(&aconnector->hpd_lock);
>   	mutex_init(&aconnector->handle_mst_msg_ready);
>   
> -	/*
> -	 * If an HPD debounce delay is set, clamp each signal's delay to its
> -	 * maximum. The debounce work and cached sink are shared by both the
> -	 * HDMI and DisplayPort SST paths.
> -	 */
> -	aconnector->hdmi_hpd_debounce_delay_ms = amdgpu_hdmi_hpd_debounce_delay_ms ?
> -		min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS) : 0;
> -	aconnector->dp_hpd_debounce_delay_ms = amdgpu_dp_hpd_debounce_delay_ms ?
> -		min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS) : 0;
> -
> -	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
> -		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
> -		aconnector->hdmi_prev_sink = NULL;
> -	}
> +	/* May be overridden later by an EDID quirk in apply_edid_quirks() */
> +	aconnector->hpd_debounce_delay_ms = amdgpu_hpd_debounce_delay_ms ?
> +		min(amdgpu_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS) : 0;
> +	aconnector->hpd_prev_sink = NULL;
> +	INIT_DELAYED_WORK(&aconnector->hpd_debounce_work, amdgpu_dm_hpd_debounce_work);
>   
>   	dm->hdmi_frl_status_polling_delay_ms = 200;
>   	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 9c4e0a4e2..71c897416 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -137,6 +137,14 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>   		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
>   		link->wa_flags.skip_phy_ssc_reduction = true;
>   		break;
> +	/* Workaround for monitors that toggle HPD on entering deep sleep */
> +	case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
> +		if (!aconnector->hpd_debounce_delay_ms) {
> +			drm_dbg_driver(dev, "Enabling HPD debounce on panel id %X\n", panel_id);
> +			aconnector->hpd_debounce_delay_ms =
> +				min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
> +		}
> +		break;
>   	default:
>   		return;
>   	}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index 2a732d19b..151db9893 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1217,13 +1217,13 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>   
>   
>   /**
> - * DOC: amdgpu_dm_hdmi_hpd_debounce_work
> + * DOC: amdgpu_dm_hpd_debounce_work
>    *
> - * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
> + * HDMI/DVI/DP SST HPD debounce delay in milliseconds. When a display toggles HPD
>    * (such as during power save transitions), this delay determines how long to
>    * wait before processing the HPD event. This allows distinguishing between a
> - * physical unplug (>hdmi_hpd_debounce_delay)
> - * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
> + * physical unplug (>hpd_debounce_delay)
> + * and a spontaneous RX HPD toggle (<hpd_debounce_delay).
>    *
>    * If the toggle is less than this delay, the driver compares sink capabilities
>    * and permits a hotplug event if they changed.
> @@ -1231,11 +1231,11 @@ EXPORT_IF_KUNIT(are_sinks_equal);
>    * The default value of 1500ms was chosen based on experimental testing with
>    * various monitors that exhibit spontaneous HPD toggling behavior.
>    */
> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work)
>   {
>   	struct amdgpu_dm_connector *aconnector =
>   		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
> -			     hdmi_hpd_debounce_work);
> +			     hpd_debounce_work);
>   	struct drm_connector *connector = &aconnector->base;
>   	struct drm_device *dev = connector->dev;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
> @@ -1259,11 +1259,12 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
>   		/* Apply workaround delay for certain panels */
>   		amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
>   		/* Compare sinks to determine if this was a spontaneous HPD toggle */
> -		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
> +		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hpd_prev_sink)) {
>   			/*
> -			 * Sinks match - this was a spontaneous HDMI HPD toggle.
> +			 * Sinks match - this was a spontaneous HPD toggle.
>   			 */
> -			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
> +			drm_dbg_kms(dev,
> +				    "HPD: Sink unchanged after debounce, internal re-enable\n");
>   			fake_reconnect = true;
>   		}
>   
> @@ -1280,9 +1281,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
>   	}
>   
>   	/* Release the cached sink reference */
> -	if (aconnector->hdmi_prev_sink) {
> -		dc_sink_release(aconnector->hdmi_prev_sink);
> -		aconnector->hdmi_prev_sink = NULL;
> +	if (aconnector->hpd_prev_sink) {
> +		dc_sink_release(aconnector->hpd_prev_sink);
> +		aconnector->hpd_prev_sink = NULL;
>   	}
>   
>   	scoped_guard(mutex, &adev->dm.dc_lock) {
> @@ -1302,7 +1303,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>   	struct dc *dc = aconnector->dc_link->ctx->dc;
>   	bool ret = false;
>   	bool debounce_required = false;
> -	unsigned int debounce_delay_ms = 0;
> +	bool debounce_eligible;
>   
>   	if (adev->dm.disable_hpd_irq)
>   		return;
> @@ -1326,16 +1327,16 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>   		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
>   
>   	/*
> -	 * Check for an HDMI or DisplayPort SST disconnect with debounce
> -	 * enabled. eDP and MST are intentionally excluded.
> +	 * Check for an HDMI, DVI, or DisplayPort SST disconnect with
> +	 * debounce enabled. eDP and MST are intentionally excluded.
>   	 */
> -	if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
> -		debounce_delay_ms = aconnector->hdmi_hpd_debounce_delay_ms;
> -	else if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> -		 aconnector->dc_link->type != dc_connection_mst_branch)
> -		debounce_delay_ms = aconnector->dp_hpd_debounce_delay_ms;
> +	debounce_eligible = dc_is_hdmi_signal(aconnector->dc_link->connector_signal) ||
> +			     dc_is_dvi_signal(aconnector->dc_link->connector_signal) ||
> +			     (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
> +			      aconnector->dc_link->type != dc_connection_mst_branch);
>   
> -	debounce_required = (debounce_delay_ms > 0 &&
> +	debounce_required = (debounce_eligible &&
> +			      aconnector->hpd_debounce_delay_ms > 0 &&
>   			      new_connection_type == dc_connection_none &&
>   			      aconnector->dc_link->local_sink != NULL);
>   
> @@ -1353,28 +1354,28 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
>   		/*
>   		 * Disconnect detected - schedule delayed work instead of
>   		 * processing immediately. This allows us to coalesce spurious
> -		 * HDMI/DP HPD signals from physical unplugs.
> +		 * HDMI/DVI/DP HPD signals from physical unplugs.
>   		 */
>   		drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
> -			    debounce_delay_ms);
> +			    aconnector->hpd_debounce_delay_ms);
>   
>   		/* Cache the current sink for later comparison */
> -		if (aconnector->hdmi_prev_sink)
> -			dc_sink_release(aconnector->hdmi_prev_sink);
> -		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
> -		if (aconnector->hdmi_prev_sink)
> -			dc_sink_retain(aconnector->hdmi_prev_sink);
> +		if (aconnector->hpd_prev_sink)
> +			dc_sink_release(aconnector->hpd_prev_sink);
> +		aconnector->hpd_prev_sink = aconnector->dc_link->local_sink;
> +		if (aconnector->hpd_prev_sink)
> +			dc_sink_retain(aconnector->hpd_prev_sink);
>   
>   		/* Schedule delayed detection. */
>   		if (mod_delayed_work(system_percpu_wq,
> -				 &aconnector->hdmi_hpd_debounce_work,
> -				 msecs_to_jiffies(debounce_delay_ms)))
> +				 &aconnector->hpd_debounce_work,
> +				 msecs_to_jiffies(aconnector->hpd_debounce_delay_ms)))
>   			drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
>   
>   	} else {
>   
> -		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
> -		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
> +		/* If the aconnector->hpd_debounce_work is scheduled, exit early */
> +		if (delayed_work_pending(&aconnector->hpd_debounce_work))
>   			return;
>   
>   		scoped_guard(mutex, &adev->dm.dc_lock) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> index bccb5d354..66fb82961 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
> @@ -113,7 +113,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
>   struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev);
>   void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
>   int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
> -void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
> +void amdgpu_dm_hpd_debounce_work(struct work_struct *work);
>   
>   /* IRQ handlers */
>   struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
>
> ---
> base-commit: c92b5b607c1c8ab786fccf03d62352b82f6539ae
> change-id: 20260708-hpd-debounce-unify-896ad367bf02
>
> Best regards,
> --
> Nick Haghiri <nick@haghiri.net>
>
-- 
Thanks,
Ivan Lipski

