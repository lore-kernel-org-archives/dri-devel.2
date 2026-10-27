Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C7606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mXGJc1T7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA5010F72E;
	Tue, 27 Oct 2026 17:13:12 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB2810E3B9;
 Tue, 27 Oct 2026 17:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1LANGCBO7R9GqMAYFiyjuRv3LrC2hFREEY6irJAzGKIWj/XEGGEcuFytOiZIbrnfHT1xanl9/kTYU6/nUeHE2XtEHhzTDfPQYW1hqfXy7r9Whng3Mxkt/IfYMFX6iRAVf/DQ2oYRMF7xN9AdYOtwCJhdPmA8I/NDrfPSt8yV03mTBUj5pdJCLG6dbNrVVbS0ihbAgGi6SQIz9iF3yKlJTKEOBtxZJhKU0cAMp6HFh8dLQHBSgccPB+/ZJfTBMQm4XxUbmLmpgO7eyHbMVwZQuxSt931r7fj7fs1Pi/RM/mzfcjiFZhzAYtu9I699sv/KgMAAe9L5pIUuAZgp+wWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaNNJIVHt667UPiPfLgnrIYbE9y8io4IuGxm5lHmQVk=;
 b=wBTIdqnAsikRh4TMVzqNWk0hcVrSmf1aBsVQCycXJd44uy1uVj0U3GXtLyqfaN6jyxmJKwVkbEEK/8k37uLTAr7W6dOOTYlIKUbkZu3N5uJmXbLiHtIEIhjE4FGyl7xgGWTbiQMskd+fpYyKxY/A+haFR3JKM4VORItEKkFt88DPSnvbvVjTGEdRoq0SAWPKVmJNd2T9lSxc6qNMlbHeyibhnsR2b0GxMRgqgKyNNlvF2hgGi7A56VMWzqKxI7MBlWS2KYAOjdgDDoyzvA6f/RIoeRPpAo9pkqRyxyebP9Qbo35XuCgZCD3hXo1nqBGGBXO2ptUco1kFAKouChgA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaNNJIVHt667UPiPfLgnrIYbE9y8io4IuGxm5lHmQVk=;
 b=mXGJc1T7Irkn2cICWcRNB07/X0no6/48fHeufzGj5GakVLV+ODCGshBT2lrvQobhtAYm4F4KPirEJZZjttlOorcBUoIbgRSe8Kp46eeDsGiyD4XFbutdJOa/u2HIFyWf2dE2Z0v3a6BBGSArl8OXE0Qe1RJCis2yDdeQ76B4MO8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:13:03 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:13:03 +0000
Message-ID: <471336a8-35eb-4830-9f75-071f5b98bae4@amd.com>
Date: Tue, 27 Oct 2026 12:13:00 -0500
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <18b5101d-c05e-45c0-a880-457bb7b9d887@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:806:120::10) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c5135d-9b71-4630-d4d6-08df344d8f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|261026121527099003|18002099003|22082099003|3023799007|56012099006|11063799006|261022105027099003|10067099003|261009223027099003|261022075727099003|261021123027099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: Jkhg4xeXx+q+vncybVRDQntTtGWYCk6sSR75C/LNsniaKp7HsI/S0m4KIvc37KS4AyNSH/tv+HfMkWq8Re8jW7+4VFEPeY0qcU4eRVs9q7rQa/K00+aA7kmIeZDnB9hW6Y4DlHr9SU4WIdddgJw0P/bvlpD0z+aUr4PgYo9BBfqBMjS20TYvPDZGL8brYVzx6QQy1VvPa0zr/V2WNbJ3PqerjhtSgzzU4apOuX1ucaUG6Kai7nz2Gy8Rx3/8fRjeuAJ00G2axieQjmfW61GFEo7kCHw1lwaBlEoE4ibcZ2XCGXQksZaH8ewrQXKMLM6Bw3irihnmxJgd7qq0VNPJSn96JDZ/RlQEn2n6FeQfaUQbutQh5qle2OY01Li5bYQQZFnITn0Vi33iSSIlV2o2K+RUw0S4t9z2qzWj/aWvg4HlM0GWkurk/tIabyZYxQdzn2UivHCjyzFwicfpofbhYxR3SzfEs+TNOVHM9E1tJO3bnkl0n2Xf7i+1s/NOwJGHTWqj8iOgDb7nllB57RySK5HfMqgGSjp1XoHNlELqQnSf72LTdowugmuDhBeIRXbqMzE7K4XduEWCGB0eKxyxIaU1vbRHujOXa8OqoaIzg92iHPAcpgY2Ir3hZ88l3t+hZOPP9sXU/60opjIBJV/9NWpH4P7kUPWMA3HgKxCGTQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(261026121527099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(261022105027099003)(10067099003)(261009223027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhZWHFFVzlsUmRYYnM4NDBnVzhTWDMxU0NuSmh0R3p3c003VEhGTTQyWGFx?=
 =?utf-8?B?Y01jMWlyTXJKVlhjRHNIUG5PZ3pJdHVlMFF1N29mWHZZY2JFMHJ5Zkg0aVph?=
 =?utf-8?B?WkR3bno0SGNIczJtSy9xN00xeUhQVGhpK1dSeXJCdG1BUEJGclVTS0tFdEVt?=
 =?utf-8?B?QWhmVTlncStFWlY5TmRmNXBpRGJWdlJka3poOUVCbzA4QUNyaGczaFBudkJr?=
 =?utf-8?B?V2czWmFJVURGd04ycFAzVU1FOHhGbGdJTkhCNDd5cForUVUvTVc4VWZ5Q1N1?=
 =?utf-8?B?aGFIaUl5N1ZLL0RNMDF4N3REOW1nNTJ0V21tRThSTlo1RjUzZzZYVGtCSlkr?=
 =?utf-8?B?L3dQZFFFMkRGL0xsVnd5TkdES3BCVXBySnpxMWI4bmpqeFk2SE1nYmRmNFE3?=
 =?utf-8?B?RTBXWEkyQ1VXTTlEZFJlck5LQ2o3cDJxYlZCSSt3a0ZwZVVMSDVNQzV6NGNC?=
 =?utf-8?B?a0VZc3duR0lPMWJwWUxOazZoTzZ6Y2Y4OXRQR2F4MTdNZkRuWGhGVUw1b0dD?=
 =?utf-8?B?c2pzWEsvTHR6VTZBUzVUSHBRRWZ0K3FnNGhpOStFbUdiWWE4S2tIYXR2Qmd4?=
 =?utf-8?B?Q3dJb1dIWlRtQ2hmVGxuTDE2dnZLcEhmUXBPWnNmdi94WmdnbVdOUWc2bnNo?=
 =?utf-8?B?L1JES01OU2pLeGFXMnFZR3V2QjZ4eGZqNDFUaWxOaEdlamRlcnNweFlySmlB?=
 =?utf-8?B?U2o3Qm8zUkpMaTlDcmcrSUNWU1IvZlYxZmdRRUJjbzNzUjBxVkFoSmpBK2E3?=
 =?utf-8?B?M21rT001VnFSd0IySlpwMklFaXMyRkc5VFIxZmNzVWNTRzlCWEhMS211Qmgx?=
 =?utf-8?B?UHY4R25xZ0RnSnlpOTB4dXIwck5CN0hqTVR1Vit5WDJUeDkzbkZHbHhad0lB?=
 =?utf-8?B?SkhWTmV5Nmw3cXVJR3ZGbWwvdktWbTJ5WXhSbHhhQlJQaWYzVUxzQnc2UUQz?=
 =?utf-8?B?K04wZGF6STN0ZzQ4RWREMEszK1NRdWthd2l2YzNOcmUyQmxEcWVaeENoMUZa?=
 =?utf-8?B?S3pUalFBVUN2eGtjL2s0L29ISHdhdktWQlBoZkRwUWloZzZzZGlPMGdMeUpz?=
 =?utf-8?B?QTR3cVhGVnFEZjRtZFBvTC9RVnFPRVRiY0dQVjFRNkpjeVVDWVFHZDVURWoz?=
 =?utf-8?B?TGxySVd3OWdUMndnekNmQVFuaFd6RDJsV005ZFlOazFQK1B2WUxBdWNsMGhW?=
 =?utf-8?B?NlNXRC9HR2NkTkJGRjBndDZBYyt1NCtNVWxPYW9Cd0JqUE1VVGcvLzYwOTVQ?=
 =?utf-8?B?RnNTcEh4YmV4MG1Oci9LVEM1bW5NRDhOb09WL3o3Vi8xQ042RVFHUWJ4dW5J?=
 =?utf-8?B?YzRoSUJLQjloSVpKZUQ0UlhMQzNnNzAxbzNGS2RRcVNRTXdNcG1wMld4eUNL?=
 =?utf-8?B?Smdia2Z6TG5GVFBtVnpGN2tLMnhDdmRlL3VqYTZZWkppTSs1b1d4L0ROWHpi?=
 =?utf-8?B?dFczRHlYdWRESTE1UXhWVHF1Q2dPMHNwZDV6VXhHcTJOOFBoMWY2S1NEOXl5?=
 =?utf-8?B?N21rZmF6b0ZaUGlTUG8zMjhaQUY4bWFmendENUtYSTJyTUg2aWxKWjlTTC90?=
 =?utf-8?B?SVpJalhpUEQ1WEJtNmhicWJCZ09lVDN3QXBadnhYTnVCRWd2Nnd0bVJSeG5Z?=
 =?utf-8?B?NmhmVTF2ZjVBR2JGTzJBR1BOZGd4MVVjUkd5Kzk0S2hRWE5DTi9LYmZMbWtN?=
 =?utf-8?B?N0Vla1Fna2FEVnQ4bnZmdkx1UE9KQlI2MGVzUUhIakx4OE9EdDFURkNmaHpm?=
 =?utf-8?B?OUE4c1plNlMvZkFOeGpCb01PRGdHK01sTUgvQlFteW9OQjdjS1U4c2ZQZXpB?=
 =?utf-8?B?YlBhdnV3RmU0RCt2cmYxYWxRbGFBRVpYM28rc0VEN0trS1lta05oRW1EWnpk?=
 =?utf-8?B?Y2hqeEZBelJWSk9uQnNYOWx1ZnhmQ0NRS3hOc1dqN1J4dnlzVlN3dEpkTzBC?=
 =?utf-8?B?Y3BKb0lrZVVUTnRiZHl1cFBwdEszOWtLaENvZnNqeDEycGFwZE1ONlZvWlEz?=
 =?utf-8?B?WnB3SE1CNklObUpFbEYvUXp5MC9YY0drS2szT0UvcGxnaXRiU1hHUlpWNUpv?=
 =?utf-8?B?a3pyS3BXdDFoUk9mTUxYRlB0TWpGT0JCb1VqTjBwWE9ZWUFOcHhmdE01WVNC?=
 =?utf-8?B?N3lKK244SktYZGFjVGlrQXREdStDaXQxVUxzNUVOa1UyZ0ErbXFNTi8zZE1w?=
 =?utf-8?B?NjIxZGt0Yzc4TWJPREg0dWkveWtaRWpMWVJINHVSeTdwL3B1M2tGMmtSMnlY?=
 =?utf-8?B?N2RLMzlQbWRiM2xmMkFJNTRmVFh4bjk0WGIrcnRNNi9rVnlqS09rSm44Snc1?=
 =?utf-8?B?STUxYVRKZlc3VWRkRHFYZG0wdGVreUpvSEhIVXR3NFo4alU5NFNMQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c5135d-9b71-4630-d4d6-08df344d8f0a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 17:13:02.9227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ALVOEl8K/Tk5B485z0tqmamVXQoc1fJQwlVG570dk2J9Kozkzca9HT3cyyj05EVdwXE5qeR40h3Ohb38j11Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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



On 10/26/26 17:48, Richard Lane wrote:
> Apple 27" 5K iMacs (2014-2019, iMac15,1 through Polaris-based iMac19,1)
> expose their internal 5120x2880 panel as a 2x1 tiled display over an eDP
> root link and a secondary DP link. At boot, the panel TCON operates in
> single-pipe mode and holds the secondary DP link's HPD line low until
> unlocked via DPCD registers.
> 
> Enable native tiled detection and link training for DCE < 12 Apple 5K
> panels:
> - Pair the two internal dc_link instances during EDID quirk matching for
>    DCE < 12 iMac15,1, iMac17,1, iMac18,3, and Polaris-based iMac19,1
>    (identifying roles via connector_signal since panel IDs can flip
>    across the two links after S3 wake). DCE >= 12 support for Vega-based
>    iMac19,1, iMacPro1,1, and iMac20,x is documented as TODO.
> - Avoid falling back to DVI and latch the secondary tile via DPCD 0x4F1
>    on the root eDP link when probing the secondary link.
> - Write the 3-byte Boot Camp source table (0x04, 0x1d, 0x03) to DPCD
>    0x310 in dpcd_set_source_specific_data() to unlock the secondary tile.
> - Prevent the secondary tile from entering DP_SET_POWER D3, which causes
>    the TCON to drop HPD and stop responding to AUX transactions.
> - Override the secondary tile's connector type to DRM_MODE_CONNECTOR_eDP
>    so userspace compositors treat both tiles as a single built-in display.
> - Unlatch both tiles (0x4F1) and clear DP_SOURCE_TABLE_REVISION (0x310)
>    and DP_EDP_CONFIGURATION_SET (0x10A) in dm_suspend() so the TCON
>    returns to single-pipe mode for the EFI boot screen across reboots.
> 
> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++++++++++++++
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 ++++
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 34 +++++++++++++++++++
>   drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++++++
>   .../drm/amd/display/dc/link/link_detection.c  | 14 +++++++-
>   .../dc/link/protocols/link_dp_capability.c    |  7 ++++
>   .../display/dc/link/protocols/link_dp_phy.c   |  8 +++++
>   7 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bdabb4bf14da..548f975c7324 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1607,6 +1607,35 @@ STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
>   }
>   EXPORT_IF_KUNIT(dm_destroy_cached_state);
>   
> +/*
> + * Unlatch Apple 5K panel tiles and reset DPCD state on suspend/shutdown.
> + * This returns the TCON to single-pipe mode so the EFI boot logo is not
> + * skewed on reboot.
> + */
> +static void amdgpu_dm_apple5k_unlatch(struct dc *dc)
> +{
> +	const u8 zeros[3] = { 0 };
> +
> +	for (int i = 0; i < dc->link_count; i++) {
> +		struct dc_link *link = dc->links[i];
> +
> +		if (dc_link_is_apple_5k_secondary(link)) {
> +			/*
> +			 * Clear Boot Camp source table (0x310), eDP config
> +			 * (0x10A), and secondary tile latch (0x4F1).
> +			 */
> +			core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION, zeros, 3);
> +			core_link_write_dpcd(link, DP_EDP_CONFIGURATION_SET, zeros, 1);
> +			core_link_write_dpcd(link, 0x4F1, zeros, 1);
> +
> +			/* Unlatch primary root tile */
> +			core_link_write_dpcd(link->tiled_peer, 0x4F1, zeros, 1);
> +
> +			break;
> +		}
> +	}
> +}
> +
>   static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -1674,6 +1703,8 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_dm_hpd_rx_irq_work_suspend(dm);
>   
> +	amdgpu_dm_apple5k_unlatch(dm->dc);
> +
>   	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
>   
>   	if (dm->dc->caps.ips_support && adev->in_s0ix)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ded8e21897f1..27de7965f366 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3460,6 +3460,12 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>   	}
>   
>   	connector_type = to_drm_connector_type(link->connector_signal, link->link_id.id);
> +	/*
> +	 * Override Apple 5K secondary tile to eDP so compositors treat it as
> +	 * built-in.
> +	 */
> +	if (dc_link_is_apple_5k_secondary(link))
> +		connector_type = DRM_MODE_CONNECTOR_eDP;
>   
>   	res = drm_connector_init_with_ddc(
>   			dm->ddev,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 9774ea33272d..db6ac803e14f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -97,6 +97,21 @@ STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
>   }
>   EXPORT_IF_KUNIT(edid_extract_panel_id);
>   
> +/*
> + * Pairs the two internal hardware links driving the Apple 5K panel,
> + * allowing the driver to synchronize both tiles as a single display.
> + */
> +static void dm_helpers_wire_tiled_peer(struct dc_link *link)
> +{
> +	u32 peer_index = link->link_index ^ 1;
> +
> +	if (link->ctx->dce_version < DCE_VERSION_12_0 &&
> +	    peer_index < link->dc->link_count) {
> +		link->tiled_peer = link->dc->links[peer_index];
> +		link->tiled_peer->tiled_peer = link;
> +	}
> +}
> +
>   STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>   			      struct dc_edid_caps *edid_caps)
>   {
> @@ -173,6 +188,25 @@ STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
>   		drm_dbg_driver(dev, "Force FreeSync min to 60 Hz on panel id %X\n", panel_id);
>   		edid_caps->panel_patch.force_freesync_min_hz = 60;
>   		break;
> +	/*
> +	 * Workaround for Apple 27" 5K iMacs which expose a 2x1 tiled internal
> +	 * panel over an eDP root link and a secondary DP link. Wire the peer
> +	 * links to latch and synchronize both tiles, using connector_signal
> +	 * for role assignment as panel IDs can flip after wake.
> +	 * IDs (Root/Tile): iMac15,1 (AE01/02), iMac17,1 (AE05/06),
> +	 * iMac18,3 (AE11/12), iMac19,1 (AE25/26); TODO (DCE >= 12): iMac19,1
> +	 * Vega (AE25/26), iMacPro1,1 (AE1D/1E), iMac20,x (AE31/32).
> +	 */
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE01):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE02):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE05):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE06):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE11):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE12):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE25):
> +	case drm_edid_encode_panel_id('A', 'P', 'P', 0xAE26):
> +		dm_helpers_wire_tiled_peer(link);
> +		break;
>   	default:
>   		return;
>   	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index f4fefa7c9ab8..498c11c0616f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2003,6 +2003,12 @@ struct dc_scratch_space {
>   	bool skip_implict_edp_power_control;
>   	bool forced_psr_active;
>   	enum backlight_control_type backlight_control_type;
> +
> +	/*
> +	 * Partner link for dual-tile Apple 5K panels, wired during EDID quirk
> +	 * matching.
> +	 */
> +	struct dc_link *tiled_peer;

This feels like it's re-inventing drm_connector's has_tile, and tile_group.

There is also a special "tile_is_single_monitor".

Can you use those instead?

>   };
>   
>   struct dc {
> @@ -3172,6 +3178,12 @@ struct dc_sink {
>   
>   void dc_sink_retain(struct dc_sink *sink);
>   void dc_sink_release(struct dc_sink *sink);
> +/* Helper to identify secondary (DP) tile of the Apple 5K panel. */
> +static inline bool dc_link_is_apple_5k_secondary(const struct dc_link *link)
> +{
> +	return link && link->tiled_peer &&
> +	       link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT;
> +}
>   
>   struct dc_sink_init_data {
>   	enum signal_type sink_signal;
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> index b4546f93af0c..25662ed3e612 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
> @@ -218,7 +218,8 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
>   			 * we assume signal is DVI; it could be corrected
>   			 * to HDMI after dongle detection
>   			 */
> -			if (!dm_helpers_is_dp_sink_present(link))
> +			if (!dc_link_is_apple_5k_secondary(link) &&
> +			    !dm_helpers_is_dp_sink_present(link))
>   				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
>   		}
>   		break;
> @@ -1625,6 +1626,17 @@ bool link_detect_connection_type(struct dc_link *link, enum dc_connection_type *
>   		}
>   	}
>   
> +	/*
> +	 * Internal tiled DP secondary reports HPD low until latched. Latch
> +	 * the secondary tile via the root eDP link's DPCD (0x4F1) and force a
> +	 * single-sink connection.
> +	 */
> +	if (*type == dc_connection_none &&
> +	    dc_link_is_apple_5k_secondary(link)) {
> +		core_link_write_dpcd(link->tiled_peer, 0x4F1, &(const uint8_t){1}, 1);
> +		*type = dc_connection_single;
> +	}
> +
>   	return true;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> index ad1a499b0d9d..15f223e48091 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
> @@ -1496,6 +1496,13 @@ void dpcd_set_source_specific_data(struct dc_link *link)
>   				link->dc->vendor_signature.data.raw,
>   				sizeof(link->dc->vendor_signature.data.raw));
>   	}
> +	/*
> +	 * Write the 3-byte Boot Camp source table (0x310) required to unlock
> +	 * the secondary tile.
> +	 */
> +	if (dc_link_is_apple_5k_secondary(link))
> +		core_link_write_dpcd(link, DP_SOURCE_TABLE_REVISION,
> +				     (const uint8_t[]){0x04, 0x1d, 0x03}, 3);
>   }
>   
>   void dpcd_write_cable_id_to_dprx(struct dc_link *link)
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> index 49521ac4b0e8..abac117d0514 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
> @@ -50,6 +50,14 @@ void dpcd_write_rx_power_ctrl(struct dc_link *link, bool on)
>   	if (link->sync_lt_in_progress)
>   		return;
>   
> +	/*
> +	 * Prevent Apple 5K secondary tile from entering D3 power-down.
> +	 * Powering it off causes the TCON to drop HPD and stop responding to
> +	 * AUX.
> +	 */
> +	if (!on && dc_link_is_apple_5k_secondary(link))
> +		return;
> +
>   	core_link_write_dpcd(link, DP_SET_POWER, &state,
>   						 sizeof(state));
>   

