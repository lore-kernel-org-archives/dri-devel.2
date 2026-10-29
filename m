Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32F606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=J6YfEFy7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E681124DF;
	Thu, 29 Oct 2026 19:58:56 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CF21124DF;
 Thu, 29 Oct 2026 19:58:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxfP/666iyNNCfbxJpTf6gK/9RjL0A2oYENLEPpG8wggeQ0hjv/5Pjm/6fWOb+XBHUalyzqrNiyoCgPH7kWVmcS5hI/upIKuFY3WlTscULzlHRBx29FnTA0yZN9YSNXa+Phrq1EnnzasfwtaDGs262simGrU3HhlmEIGuhRvJhBpEptlqv8891nyaHsaiyP22ZWxLuZJxOvL1TbcUONuLi28fEBkD69B88KMxDx+8gWN7/2Ta4fpyLiqoUM7Hfqz8RY1J6Kbd2/RXDmEILBLrqlYV7MsRFHzh6Rr46KoRdvcQZDXMKqbcQRhmNbypyMsWi6cWWFP6bg+OU3tnz02Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CTWDxxqlCFvt4nIVrWfCiCGjs1+TQSilIFHJYIW3d0=;
 b=Z04LDLz+a9Gv3n16jRfNN/nz0rZhyaC4G+UfVb2ma9hbDcHOhQlcdKa1GTiBlHedlkBpf+YBTH2RtIoCJ0DgCsEb188yaSO8lI2TuwFgeEgG6lGdEbLrFlutZe9YhJG3bxN/5KspK4bb3iEeNIN39vS88eTMfIJHXRNTK4rusoJTzdnPrdJmipjWWAsKHAmWs7O71OR5W2zEPKNUFEQQrD384aPZEVPyUvrQWEsX9TvmdygORWopQYtZrfc0RgddTB4BArZzHD6cnFT5tynmStpwAcipUYRoNKEjh/4NtcYgErsWej6VpLDJmaHubvy6PV5JzkQBJdKfTJSpNgUUIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CTWDxxqlCFvt4nIVrWfCiCGjs1+TQSilIFHJYIW3d0=;
 b=J6YfEFy7MnVQT8bgmYgw6d0LKcmFqJ2CU5MhNub6ALl/zSMy+kx4696YrLFfAp+nDkGn7PivbzRvKX/dU2EZ3yld+L9zLYM0Wl2RsdgR5K7esU/Xte3bKTEv1AlkixxKnFRB5vAeDkhIVFPoQi1IatUnvSJnDCpAQQ0njh1aLOI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 19:58:47 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 19:58:47 +0000
Message-ID: <cded0c76-e418-40d6-b7eb-ae06bdd1c5fe@amd.com>
Date: Thu, 29 Oct 2026 14:58:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/display: unlock secondary tile on Apple 5K
 iMac panels
Content-Language: en-US
To: Richard Lane <richardlanedev@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <18b5101d-c05e-45c0-a880-457bb7b9d887@gmail.com>
 <471336a8-35eb-4830-9f75-071f5b98bae4@amd.com>
 <9a6529e2-997a-48eb-9e65-c26d9070108b@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9a6529e2-997a-48eb-9e65-c26d9070108b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:610:4c::11) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fcfd2c-b8dc-4edf-f9e8-08df35f70aff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|261021121427099003|56012099006|4143699003|11063799006|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: GGyXeS1LMb71lq2Gpl4/ZWewKso1tqHe1c47eD+6T+alks0c7XkFeprf3Chg4Pr/TAEnaXd8VazZMDe1yPjqPjDRsTPXaRcb/OcsZHSvWgVmI0hUmckbHpyBqNqlIqsUz6YhoANsYPgJQIBHPqo1xUhfFdEW7wUlnQ4SMtwyiw+oHgDnZiLiId1mTNFMokuVwTWuTvlDCLYIDk9ZZNBJhC17qql4xbit59gpVHulTuJn0eaoOy3eiJmk+vwN5nn0XicF5iZji/eG4ToEj/0mSAKgxX5ZlVo2Psi2uVBKwdLP/4n8Z1+v1a7TcuvOsRpsF0dX18BzJUBv2blx0J/Jxszb9u1pd8y3NvdgmybVxdHfxSdKunft6L6tpu55awkselqZt7QINFk6Gegav4cSh24ZIks1GmFY6GcST+Iu8mbY6edP4/Veuk52qiwHNLENyibfBpG6cgD76ZCa3fk1V6CEYaJPSoVbRyif7f8QMwe8zTD22E+SszO8oheYB6krQm7mVBZxK4iDK1AuC5D+J/7Z0CGmzTwsqpigHmsOzpp3UieVX0KlL6509JqSLCvg4irnM2EokbWeOJKq2PNtWHBHFn6OvIfOUYz3AVjPapV+QAFTd1qLEDbJx4Zo28Fye+LNNWJkysSllIF9IhxYiVf1IJD/xLmBULbFVi07URM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(261021121427099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk0zcW1hL0s2VDdqZWk5TUlrY0Jwd1VLdVpFTFl4N25ieUgzYXp0RHJ3Q0Nk?=
 =?utf-8?B?NEp3STZEMTRmMlNqMlVUdGFrQ3hjdTlyY3ZlV0lwOVpqaGJ6MGJiQU1KWE5J?=
 =?utf-8?B?Y0ZwNHJFSDhVUG9CdEM3c3J5am93R09uS3RnZTVxMmtPUDlxTk9tcWdFNm9p?=
 =?utf-8?B?bnE2OU80ZFc4dVhwRDZpMXVTUDUzZjBTcFlpSC9LdjBnVUs0L1h4c3FYTU94?=
 =?utf-8?B?SnRwSDc4a1ZEbVpRQXB1dG9sdU5CV3RvS3A4ZlVIVlVxdTN1RDNUUjVTOGs4?=
 =?utf-8?B?K3lwRVprSlVWMU10aDJXSFBUZ2ozeUROenlNeHIzbkZrSVh0M2RuQUl6M2Jm?=
 =?utf-8?B?NUVDaXBVWGQ4em1CeDZERHF4alJENmh5WTZTUUxJNWl5d1dGM3Q5MjlLRGUw?=
 =?utf-8?B?U2RnakVCUS8rV3dGUnFNbk51MllwQ2pFb1g2dGFwTUpNbUNJWkRTOVp2eXFH?=
 =?utf-8?B?Ym04V1ovazJtbmtxeTdYVWcrRUdBTzRLZDdqT0hmbWpGaUpOK2poQ2txaEZJ?=
 =?utf-8?B?QVpwZERjSWNGVEF2L3hyK3lxSDluMjZLSmVGZzJoNXJDTmU4aXFMS0xVWUt2?=
 =?utf-8?B?L2N5Rm1RVWhRMFpqNjVRaUJNYkw1R0gzV0srd1ZhS2Y5RGo4R3UrODVvK1R3?=
 =?utf-8?B?c3FHUHh0UllqakMyTUNHb1IxbG16ekExTXgzRTRvT1p4QmY4MjNBQ0tLZnli?=
 =?utf-8?B?ZHRSRGRFMnRtL1FSbmhyRyt6QXNwc3V1WUltU3NtaXNrcnZsU3BhckZtSlBx?=
 =?utf-8?B?dDF1UlQwSW1OVnVrNDU3N0x1K3ZseVpTMWhVSFN1TVJDSnNyR3JKN2ZsT2Yx?=
 =?utf-8?B?YW1YRUpuaWdvSmYvMmNyTXZnV28xSFl4UW9uT1ZMN0c2ekpncUtxYnpQWVFM?=
 =?utf-8?B?RkFnWEpIOC9RdnpEcndRMk94RUQ5WDkwN04zem03UStHU3gvSUJFMGxJdUli?=
 =?utf-8?B?Q090S3VXekVlV2cyRXY4Rk5aWmxBV0I3Q2RzWWhldFF5Tk53VHBBaFRZY0JH?=
 =?utf-8?B?SWwvcEJ1MTI0SkpQS2RDWDNXVFl3dU12ZEpvbWFWRktHazRlUTNmZmJqV0RG?=
 =?utf-8?B?TFF0TkxsZ0I4UFVmcWNELytkdThYVFd2VVZlYThBZ01CaUp0bWhLeW8rTjVY?=
 =?utf-8?B?MmFSTjl6SHNqVmlkWC9JelQ3NEc5a05QaEJXUnlZRVZXdmtEV09wMUxIWWEx?=
 =?utf-8?B?STdVMExCK2t6VUwwQjZUTFVvMUw5R0UxbUFqbGNGaVlMQlNtRHJlK2p6aDRv?=
 =?utf-8?B?WEpZWjlwMVB2aE1UMktJMWl3OXVwMWVYRDQ1Q0NncWVIUTNtUWdoMk0rdTBn?=
 =?utf-8?B?RDVtQXdhK3JRSGFSNjBVRnhNL01JdC84SlFFbnpWZzU1dHA2K016Z3dVUU9n?=
 =?utf-8?B?NE03WXRGR3phRjBsZFZCNEczVGpkL05wODRIdVlKUDB4bktnbkh6RFdEQXFm?=
 =?utf-8?B?KzFSeGJnRTFaeEVsZlpDNnFXclQ3b2NmeFZoUzNJSG9zalBqNHo1VDVzb2pG?=
 =?utf-8?B?V205Z3hEcVBoZ2htalRrMUJjVzYxSTljSmJlY1pjdnNqZnRHRVR1UVQ4YXBE?=
 =?utf-8?B?clBjSjYwUVVaaEhZZWwvai9YekVxZy8zblhrWm9IWFF4TDFkTnVnclI4V3I0?=
 =?utf-8?B?bm04SDhsQnQ1S2JqZE05eTBKWEpwbTJIcEdkamRuOUxCOUEzcDl6clVJK2pP?=
 =?utf-8?B?UGQyWXprb1VYNUE3QnB6dW5FY3owdVh0TUV5eUMzSHd1VzFNb1E2b25OZEVz?=
 =?utf-8?B?RVdCNnVRWTRXdGhPb3JiSmRNMFowbFB1SWZlekltM2VpK0J5RExjeFFvSG5M?=
 =?utf-8?B?NzMrc0g5bmo2SDd3SGErUU9XV2tYajZxU0s1VjdtWEV6aW02L3MrTnd3cEwr?=
 =?utf-8?B?MDFDWXJ6akNFRjFrZFNMMWw3bWtRK2dNTmIyYUJSMmxzY2pSandZQ08wNVcz?=
 =?utf-8?B?R0JsYldEb2NKMXNMN1pZRVU5MkJ2MTFWVlc5eS9qVEh0RlhjUXQrRzZpdHdy?=
 =?utf-8?B?Q3BtbEVrRWVhWU4veHB2ZFl3cHFyekNPK3FHMjRhZlJXQnczR3NOb0lMcFM1?=
 =?utf-8?B?RzhmaGs4SUcvcGJoZVUzR21VekJuK09ud2pqUHFTNGVWOCtNdTVqd1J5Y285?=
 =?utf-8?B?ZHNOSVFsU2N2aXdPb09qbG1uV0czSWFxY3ZmOW1QbE1DeHV5ck9SVis0SXZQ?=
 =?utf-8?B?b0FvRW01UnpqdW5LdHlMOUxYa3FrV2lLUk4xZk1LR0dBWTFvZzUwc016aXpJ?=
 =?utf-8?B?ZXh2RHpzR0tqdVMvd2F5WlJONitFc25MR2cvcFlTczQ3NG5SeWp3Y3FSaThQ?=
 =?utf-8?B?Z0FIa01UOVR5cFc0VTkwMFlTejlUb1VxcWg2UXJoWTJ6QjMzdXRkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fcfd2c-b8dc-4edf-f9e8-08df35f70aff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 19:58:47.0627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72zoll291yQVM3w3x+aqiXImTpVoI+ZACBnPfNJcbbaq2D2lZRBkYfGvHo0ka9gdIL9A3Ef/7V42WVsK1d5hDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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



On 10/28/26 19:19, Richard Lane wrote:
> On 27/10/2026 17:13, Mario Limonciello wrote:
>>
>>
>> On 10/26/26 17:48, Richard Lane wrote:
>>> Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
>>> expose their internal 5120x2880 panel as a 2x1 tiled display over an eDP
>>> root link and a secondary DP link. At boot, the panel TCON operates in
>>> single-pipe mode and holds the secondary DP link's HPD line low until
>>> unlocked via DPCD registers.
>>>
>>> Enable native tiled detection and link training for DCE < 12 Apple 5K
>>> panels:
>>> - Pair the two internal dc_link instances during EDID quirk matching for
>>>     DCE < 12 iMac15,1, iMac17,1, iMac18,3, and Polaris-based iMac19,1
>>>     (identifying roles via connector_signal since panel IDs can flip
>>>     across the two links after S3 wake). DCE >= 12 support for Vega-based
>>>     iMac19,1, iMacPro1,1, and iMac20,x is documented as TODO.
>>> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
>>>     on the root eDP link when probing the secondary link.
>>> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
>>>     0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
>>> - Prevent the secondary tile from entering DP_SET_POWER D3, which causes
>>>     the TCON to drop HPD and stop responding to AUX transactions.
>>> - Override the secondary tile's connector type to DRM_MODE_CONNECTOR_eDP
>>>     so userspace compositors treat both tiles as a single built-in display.
>>> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
>>>     and DP_EDP_CONFIGURATION_SET (0x10A) in dm_suspend() so the TCON
>>>     returns to single-pipe mode for the EFI boot screen across reboots.
>>>
>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>> ---
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++
>>>    .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 ++++
>>>    .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
>>>    drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++++
>>>    .../drm/amd/display/dc/link/link_detection.c  | 14 +++++++-
>>>    .../dc/link/protocols/link_dp_capability.c    |  7 ++++
>>>    .../display/dc/link/protocols/link_dp_phy.c   |  8 +++++
>>>    7 files changed, 111 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index bdabb4bf14da..548f975c7324 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -1607,6 +1607,35 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
>>>    }
>>>    EXPORT_IF_KUNIT(dm_destroy_cached_state);
>>>    +/*
>>> + * Unlatch Apple 5K panel tiles and reset DPCD state on suspend/shutdown.
>>> + * This returns the TCON to single-pipe mode so the EFI boot logo is not
>>> + * skewed on reboot.
>>> + */
>>> +static void amdgpu_dm_apple5k_unlatch(struct dc *dc)
>>> +{
>>> +    const u8 zeros[3] = { 0 };
>>> +
>>> +    for (int i = 0; i < dc->link_count; i++) {
>>> +        struct dc_link *link = dc->links[i];
>>> +
>>> +        if (dc_link_is_apple_5k_secondary(link)) {
>>> +            /*
>>> +             * Clear Boot Camp source table (0x310), eDP config
>>> +             * (0x10A), and secondary tile latch (0x4F1).
>>> +             */
>>> +            core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
>>> +            core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
>>> +            core_link_write_dpcd(link, 0x4F1, zeros, 1);
>>> +
>>> +            /* Unlatch primary root tile */
>>> +            core_link_write_dpcd(link->tiled_peer, 0x4F1, zeros, 1);
>>> +
>>> +            break;
>>> +        }
>>> +    }
>>> +}
>>> +
>>>    static int dm_suspend(struct amdgpu_ip_block *ip_block)
>>>    {
>>>        struct amdgpu_device *adev = ip_block->adev;
>>> @@ -1674,6 +1703,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>>>          amdgpu_dm_hpd_rx_irq_work_suspend(dm);
>>>    +    amdgpu_dm_apple5k_unlatch(dm->dc);
>>> +
>>>        dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>>>          if (dm->dc->caps.ips_support && adev->in_s0ix)
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> index ded8e21897f1..27de7965f366 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> @@ -3460,6 +3460,12 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>>>        }
>>>          connector_type = to_drm_connector_type(link->connector_signal, link->link_id.id);
>>> +    /*
>>> +     * Override Apple 5K secondary tile to eDP so compositors treat it as
>>> +     * built-in.
>>> +     */
>>> +    if (dc_link_is_apple_5k_secondary(link))
>>> +        connector_type = DRM_MODE_CONNECTOR_eDP;
>>>          res = drm_connector_init_with_ddc(
>>>                dm->ddev,
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> index 9774ea33272d..db6ac803e14f 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>>> @@ -97,6 +97,21 @@ STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
>>>    }
>>>    EXPORT_IF_KUNIT(edid_extract_panel_id);
>>>    +/*
>>> + * Pairs the two internal hardware links driving the Apple 5K panel,
>>> + * allowing the driver to synchronize both tiles as a single display.
>>> + */
>>> +static void dm_helpers_wire_tiled_peer(struct dc_link *link)
>>> +{
>>> +    u32 peer_index = link->link_index ^ 1;
>>> +
>>> +    if (link->ctx->dce_version < DCE_VERSION_12_0 &&
>>> +        peer_index < link->dc->link_count) {
>>> +        link->tiled_peer = link->dc->links[peer_index];
>>> +        link->tiled_peer->tiled_peer = link;
>>> +    }
>>> +}
>>> +
>>>    STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>>>                      struct dc_edid_caps *edid_caps)
>>>    {
>>> @@ -173,6 +188,25 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>>>            drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
>>>            edid_caps->panel_patch.force_freesync_min_hz = 60;
>>>            break;
>>> +    /*
>>> +     * Workaround for Apple 27" 5K iMacs which expose a 2x1 tiled internal
>>> +     * panel over an eDP root link and a secondary DP link. Wire the peer
>>> +     * links to latch and synchronize both tiles, using connector_signal
>>> +     * for role assignment as panel IDs can flip after wake.
>>> +     * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
>>> +     * iMac18,3 (AE11/12), iMac19,1 (AE25/26); TODO (DCE >= 12): iMac19,1
>>> +     * Vega (AE25/26), iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32).
>>> +     */
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
>>> +    case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
>>> +        dm_helpers_wire_tiled_peer(link);
>>> +        break;
>>>        default:
>>>            return;
>>>        }
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>>> index f4fefa7c9ab8..498c11c0616f 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>>> @@ -2003,6 +2003,12 @@ struct dc_scratch_space {
>>>        bool skip_implict_edp_power_control;
>>>        bool forced_psr_active;
>>>        enum backlight_control_type backlight_control_type;
>>> +
>>> +    /*
>>> +     * Partner link for dual-tile Apple 5K panels, wired during EDID quirk
>>> +     * matching.
>>> +     */
>>> +    struct dc_link *tiled_peer;
>>
>> This feels like it's re-inventing drm_connector's has_tile, and tile_group.
>>
>> There is also a special "tile_is_single_monitor".
>>
>> Can you use those instead?
> 
> I tested dropping the DRM_MODE_CONNECTOR_eDP override in
> amdgpu_dm_connector.c and confirmed that once the secondary link's EDID
> is read, DRM's DisplayID parser populates has_tile, tile_group, and
> tile_is_single_monitor on both connectors, which Mutter handles
> correctly. So I will drop the addition to amdgpu_dm_connector.c in v2.

OK great.

> 
> However, drm_connector's has_tile and tile_group cannot be used for the
> initial DPCD bringup in DC because those properties are only populated
> after the secondary link's EDID has been read. At boot, the panel TCON
> operates in single-pipe mode and holds the secondary DP link's HPD line
> low. Until DC writes 0x01 to DPCD 0x4F1 on the primary eDP link (when
> probing the secondary link in link_detect_connection_type()), bypasses
> the low HPD state, and writes the 3-byte sequence to DPCD 0x310 on the
> secondary link, the secondary link cannot be detected or read its EDID.
> 
> Therefore, link->tiled_peer is still needed in dc_link to reference the
> partner link for the pre-EDID DPCD 0x4F1/0x310 TCON latch/unlatch and D3
> sequences.
> 

How about if this monitor is seen that you schedule a second scan pass?

Then you should be able to get the tile properties from both halves I think.

> Richard
> 
>>
>>>    };
>>>      struct dc {
>>> @@ -3172,6 +3178,12 @@ struct dc_sink {
>>>      void dc_sink_retain(struct dc_sink *sink);
>>>    void dc_sink_release(struct dc_sink *sink);
>>> +/* Helper to identify secondary (DP) tile of the Apple 5K panel. */
>>> +static inline bool dc_link_is_apple_5k_secondary(const struct dc_link *link)
>>> +{
>>> +    return link && link->tiled_peer &&
>>> +           link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT;
>>> +}
>>>      struct dc_sink_init_data {
>>>        enum signal_type sink_signal;
>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>> index b4546f93af0c..25662ed3e612 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>> @@ -218,7 +218,8 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
>>>                 * we assume signal is DVI; it could be corrected
>>>                 * to HDMI after dongle detection
>>>                 */
>>> -            if (!dm_helpers_is_dp_sink_present(link))
>>> +            if (!dc_link_is_apple_5k_secondary(link) &&
>>> +                !dm_helpers_is_dp_sink_present(link))
>>>                    result = SIGNAL_TYPE_DVI_SINGLE_LINK;
>>>            }
>>>            break;
>>> @@ -1625,6 +1626,17 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>>>            }
>>>        }
>>>    +    /*
>>> +     * Internal tiled DP secondary reports HPD low until latched. Latch
>>> +     * the secondary tile via the root eDP link's DPCD (0x4F1) and force a
>>> +     * single-sink connection.
>>> +     */
>>> +    if (*type == dc_connection_none &&
>>> +        dc_link_is_apple_5k_secondary(link)) {
>>> +        core_link_write_dpcd(link->tiled_peer, 0x4F1, &(const uint8_t){1}, 1);
>>> +        *type = dc_connection_single;
>>> +    }
>>> +
>>>        return true;
>>>    }
>>>    diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>>> index ad1a499b0d9d..15f223e48091 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
>>> @@ -1496,6 +1496,13 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>>>                    link->dc->vendor_signature.data.raw,
>>>                    sizeof(link->dc->vendor_signature.data.raw));
>>>        }
>>> +    /*
>>> +     * Write the 3-byte Boot Camp source table (0x310) required to unlock
>>> +     * the secondary tile.
>>> +     */
>>> +    if (dc_link_is_apple_5k_secondary(link))
>>> +        core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
>>> +                     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
>>>    }
>>>      void dpcd_write_cable_id_to_dprx(struct dc_link *link)
>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>>> index 49521ac4b0e8..abac117d0514 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
>>> @@ -50,6 +50,14 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
>>>        if (link->sync_lt_in_progress)
>>>            return;
>>>    +    /*
>>> +     * Prevent Apple 5K secondary tile from entering D3 power-down.
>>> +     * Powering it off causes the TCON to drop HPD and stop responding to
>>> +     * AUX.
>>> +     */
>>> +    if (!on && dc_link_is_apple_5k_secondary(link))
>>> +        return;
>>> +
>>>        core_link_write_dpcd(link, DP_SET_POWER, &state,
>>>                             sizeof(state));
>>>    
>>
> 

