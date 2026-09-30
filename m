Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD1CA5FCC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0E110F4F2;
	Wed, 30 Sep 2026 20:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j91yaOv4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40EA710E128;
 Wed, 30 Sep 2026 20:57:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DR1WMQD0+N9eJPKhqLU/hBZEvL71nzFgbLnr5dM3TunIOP3qZBXyhMOM++Qt52MIYjDtu9Zs0o6UgC4fYiML9mOzcw+ScZYHyD1RIjtA/5nitPzamibwNNYqdu/igfE5a35ryk0SqWSoFar+cpClbOoRzH5n7JP8IPV/4TrMCdXcHjZknhFzOxLUr2fq+3OQL/AELnbYY0Bbg6wfNzeIHIWqrJYzmcKlQ9DmncS+Hwq1eopDOpSaycUgFJQdfyNUUxZPUyf/g6+/WGzEIQu5vzcc4GK9QvlW+kdySq24co1nIlXG80GnjZb9JR5bw+JEDS/tLFnQbNDAO8qMv+FHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acumv7R2EFMjQOrrGHw2GO0Vgh3edBlIFdYXQsbNGW8=;
 b=LZ0kiehtGNOZyMqnGDDV0pZrEPg8UBzOMcDCdbPhB16R9p7GrLee8DtnMuY8KZNaOCNCPTOSiD/cradItrf6jPOSY2m524i3/omMTaVp8wvkgHiDIk0ItG4yB4LjhXxz4aNB560yFI2K+i4lvVjdN5IYS3bUF011zh4dboKlReozfMMJNzC65OIfVdKq5kcPoYI0NdLj9nUMFCyj/m9RrETbGuavklf2lGsuNRf1ghoQ9VrqjfE7UvOhDIkUQPXb39po3s1R1XoWaJKNj6imPuvQmHn/2ELdkJOaACfrKTXqo8DVNYDEEHH/1wNvqPFBQrFyclZPE8BlgL5L9yT/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acumv7R2EFMjQOrrGHw2GO0Vgh3edBlIFdYXQsbNGW8=;
 b=j91yaOv4EvVqJbuDcb5K/0gVt3N83rVpCoFpEKD6I+d8TkgQEmrB5TjbtUs+WlVJ9C2t9uRpqneMVTgmINi8peMVtOcWa27lr4JweJwv8oaoke+1eiUK2VWrbWktQT1sujnzjkknRDSkMualds7Wy2c3DQnMVg8tapsNIDeQ1Gc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 20:57:30 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 20:57:30 +0000
Message-ID: <227ed8e6-b99e-454a-b5a3-ff92e21ce543@amd.com>
Date: Wed, 30 Sep 2026 16:57:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] drm/amd/display: allow individual colorop changes
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-11-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-11-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 869981ce-b47b-455e-3c3b-08df1f3570d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: a4Vk0mkVQ+ZW0I9IYArIENsscjcIbgRsQO1MkGdWdnpy2afISCu0dIOstxRvI/XtDybhsE8zo0fuQ3nWy3LE4hvefywDj2lnDSYwActdwLRo1mXsmQhbli6uhM3x4DttGODKFP1+xe139AC0lFDk67VTVkyAHp4Cr474a1hyTN7u+nkJ0qCD36/J9wBauRAtWBNrMx4mEr90efxka2uaJtavrZPmZapiFuPWNXpyL63ps9aptsy6R1G4fZS7qjhSvtJweRVthYZ3N8pTnBHMEP6mLiYzpW5+NxUBwIxDKOEs36jW5VAdPf7rA/DYbuvy6kI/e//TyB0gbQe6gG2OpK4L/oFXai6ERhJY6PzgSPcAV+JNwvykufEcpO2+mzQmFsy66zmz9DsdcFZmJuuz9mEoGN7V4XX2FydHQB4UH1zpiYTslkCY21SbpWB+s8upj33qR0wIIauNAvDeyexol/9cOHDQz2EqJkkyd6jObLBXSM64n7AF2HEn5RPGK+C7arPz6nBycBlRWWg5S6t0PiGU2u2rRZS7SiDoLJ4gwnvI5tUXUTuWN3/7/IO4Wfrr2Up2/rpJN7oupPxASW/qt0ObNfACFnspAgmCy+OFhwLlzHWlPHdr/OCCw/I0ONTtnJ1NgQ5fWhWylpQVdQqL4pQD+7ePN5WrVtd3MWpkgil69eMsmuMoI9PRGQLBDGdl6igabyhRzEn1iNEBqbsdzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJnNlV1anJkaGEvU3ZrcnovbjQweTBTdEZ2eGQwOXEyY0JKTUZxZVdRUFZ5?=
 =?utf-8?B?MlZCQzFlSE9VemkvdHFLK1hGUHJwRFZad2RQNEVIbGk2Q3lqR0k1VlNIeThL?=
 =?utf-8?B?WWY3REhFVXJJQ013ZmR5alVCRHhaRW9ibXVFQTZWcWNQV3pHZjRTMnpCRXZq?=
 =?utf-8?B?M2tMTEdlMUV1UDFkZlR6MWc3ZFVnem1RTU1hcXpTZHVDRXJUaG1GMW1lak1l?=
 =?utf-8?B?bmNhK0M0WFgrR0pQeno3cjlzK1VqenJBTGgwYkVhV0EyaklRZXFpbjhSR1dn?=
 =?utf-8?B?Z0Zid2hCTElDd2dEbnArNFg3UzYzbXFxV1pGM0dNMlQrUU5jTVBsNW5pMFZW?=
 =?utf-8?B?T2hBclhBbXUyUjN3SFlsWUUvcXd6ODN1Mk1GSmlQdUtwV3ZveTQwdHRqa0wx?=
 =?utf-8?B?R0Vrem1wVlpaamVvblNoZlRjbllvTXpLRWVuMHE2Yk54c2hOVFhTWXB1V2pn?=
 =?utf-8?B?dXowTWZTTWVwYXJvUUhya1Y4aWtPL0x3cjJ3Q0RpcHliMlQzOXpTcnhIbGts?=
 =?utf-8?B?aWJiQ2FaUzlaVXJYUkFHckt1NUs1c3FnYS84VWx1L0RQektjc3J4UW9iY3Bt?=
 =?utf-8?B?YzZVbm4rV01hYXJaQjhBZzczU1hvcmJiZjZxTm84OGd2NEE4MzYrMkU1THV4?=
 =?utf-8?B?OWp2ei9tQWkrcVhxek5mZkwxTW10MTNnN3czZDBhVUt0QlBYc0djbFFCSjJn?=
 =?utf-8?B?Zm04ZmNUQjRWS1lLLzhHY0F0dDZURHE5b2VoZ25jOFAxLzJLYTJCTUF3ZUd2?=
 =?utf-8?B?UFR1OW0vMGNYb3RoKytnSUNSakVzZmhXaTlMN1lOdElka2F3Y083SlY1ZjJJ?=
 =?utf-8?B?ZVU2RllLamNXbUZZL1VKL084OUNoY2NQaCsvcDRaOE05WitseFhYRTJNS2pl?=
 =?utf-8?B?c3I2Z2lZdy9wODMvZWZqbWVOWHc3dmxtWVBTWjVkZlpRV1Z0WXA1UzVteTVs?=
 =?utf-8?B?citvcjdUNUsvQTF4WVVNSDJKNkhoQjJzWWY0UnZmTk4ySjhJdGJaRm1QRzl2?=
 =?utf-8?B?WVA0ZEpzS2s1UUtXOGxSdFE2eU50QjRlZldjZU9jWCtiaHlFNTZlcGwxZHNn?=
 =?utf-8?B?WEdyRzYwRWZpN2J0WUxNM3ZLa0VBb3YxY0tiamFUVnBJeERjdDhtY0RHM1N0?=
 =?utf-8?B?S0ZFd0lwK203cng5czMxbTlPUFAzMmwvd3puZ3VsZkpIMTZmZWJKR0E5Visz?=
 =?utf-8?B?Y1VxeWY5Sm90ZlY3V1A0MGg3alY3bm1pNk9wYi9VRklrSnVMNVcxTW54ckJ1?=
 =?utf-8?B?RTNuRmY5VERVUkE5SmFQR0ltenBaMi9jWmFEK0htcVNYOUo3c3M2RkhlWi85?=
 =?utf-8?B?R3FNRmFad3hDaThVVmRXOVlvYjZKTE9tenlLQVRZVUNQQ3lIcDgxOG1PQUx6?=
 =?utf-8?B?c1dvYlltM0pnV05mRGxXYkgrRFVZM3JQb3ZTOFF2SHMzZ2h6R3dpdXM2K1JP?=
 =?utf-8?B?Y1Y1dVpncVZmOWVsaktvbHZoZEpLWjUvM05iSWFpZXlIMGhKRUhXQzBnWEJs?=
 =?utf-8?B?YlpsODlzcU1sUEZEcTl6OEVoa0JaWit0VXhsamNNMmtpdU9qVmc0WU5yRlBa?=
 =?utf-8?B?aTN2WWNUeWoza3BqVXpXQm5NNnZvYXJvTWUzOXZ4UDhsS1UxSTNDKzFwZzVw?=
 =?utf-8?B?Yzk2WktiMjFHVDNZbFVkRHNwbG1MMEFmNTFhSCtjVlhtQ2lnbDNUTGhQMXBu?=
 =?utf-8?B?eTNMVDFVck96UlFUa1p2RjgzT1kzN1NISGlDeHZkbDZxVEppcVV3S2ZrNlB2?=
 =?utf-8?B?Nml6bmpuYjNhVjJLWjFPQUJXdkJrb1c5cHlJOEZGU0thS2haWC9RVHpkY0tF?=
 =?utf-8?B?M1pCeEw2S3VBdFlzY2NqaGkvRk5NZTRYUDZob3Fhc3FJeW5qbm9CZzcvUTNp?=
 =?utf-8?B?YUNqa2d6aDZRQ0I4SUdBdVhlSTQxTzVpSk03TldaV3FDV1IxTEEwQVZYa2s4?=
 =?utf-8?B?bTIrUERYYmJXcFlCM1FSaURGbmg3b2RyWFdxUVRZZml2RmhQYXA4bjU3V2Fk?=
 =?utf-8?B?VkpCY1piUzB3dXFnUkFFU1I5alh1TGJ1aVEwak4rdWx0N3FWR1lLWGZmb0Fx?=
 =?utf-8?B?ZWpMVFhTaGhwUUo5S1k5OUpMTm1lWVQ1SXdieHlYRU5NY2Jnelo0QnFwZlpC?=
 =?utf-8?B?b0Q0Q3AzN1pVOFJMRVVNQWZoRWgyUTBpRUxLdzZFZnNlOGdVR3hMYmsrK3pB?=
 =?utf-8?B?dHJyU3Q3KytGQXd2MHhxODNKNkdXRWlnK3RwVTkwSmdZbDNDbm53a3dlZ0lh?=
 =?utf-8?B?a2prbjlLZ1ZZa20yMm5uNzY2Tkkva3N5akxXYWN6TGZnd2p1eFdxMUpjYkRV?=
 =?utf-8?B?dXZvckZ4WENETkJPbEpwQ1A2WmJSek1BT1lUMnF3WkE0ZVdHRUpBZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869981ce-b47b-455e-3c3b-08df1f3570d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:57:29.9119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq7svOUI6MIZfcelnThj0ealGKGcQ1cPaBkAlCvSLDppUPg0oa54KxY7mtwRYV0JHnZ4Eu5KAtcLDe1S2rlhfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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

On 2026-08-11 12:45, Melissa Wen wrote:
> Every AMD colorop helper requires new colorop state to update a single
> active colorop, i.e. if the userspace modifies a single property of a
> colorop, but doesn't resubmit the whole color pipeline, the driver
> silently falls back to the legacy color path, instead of just restore
> colorop settings from committed state. Change all colorop helpers to get
> the committed state if there's no new state for a given colorop. It
> keeps walking in the active color pipeline and update a color block if
> the related colorop changed.
> 

This probably needs an update for __set_dm_plane_colorop_fixed_matrix as 
well.

> Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
> Acked-by: Harry Wentland <harry.wentland@amd.com> #v3
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 183 +++++++-----------
>   1 file changed, 66 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index c528daefac5e..f6a2af5d2e96 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1550,24 +1550,13 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
>   			       struct dc_plane_state *dc_plane_state,
>   			       struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_colorop_state *colorop_state;
>   	struct drm_atomic_commit *state = plane_state->state;
> -	int i = 0;
> -
> -	old_colorop = colorop;
>   
>   	/* 1st op: 1d curve - degamma */
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_degam_tfs)) {
> -			colorop_state = new_colorop_state;
> -			break;
> -		}
> -	}
> -
> +	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
>   	if (!colorop_state)
> -		return -EINVAL;
> +		colorop_state = colorop->state;
>   
>   	return __set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state);
>   }
> @@ -1577,43 +1566,37 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
>   				  struct dc_plane_state *dc_plane_state,
>   				  struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_colorop_state *colorop_state;
>   	struct drm_atomic_commit *state = plane_state->state;
>   	const struct drm_device *dev = colorop->dev;
>   	const struct drm_property_blob *blob;
>   	struct drm_color_ctm_3x4 *ctm = NULL;
> -	int i = 0;
>   
>   	/* 3x4 matrix */
> -	old_colorop = colorop;
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    new_colorop_state->colorop->type == DRM_COLOROP_CTM_3X4) {
> -			colorop_state = new_colorop_state;
> -			break;
> -		}
> +	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!colorop_state)
> +		colorop_state = colorop->state;
> +
> +	if (colorop_state->colorop->type != DRM_COLOROP_CTM_3X4)
> +		return -EINVAL;
> +
> +	if (colorop_state->bypass) {
> +		dc_plane_state->gamut_remap_matrix.enable_remap = false;
> +		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> +		return 0;
>   	}
>   
> -	if (colorop_state && colorop->type == DRM_COLOROP_CTM_3X4) {
> -		if (colorop_state->bypass) {
> -			dc_plane_state->gamut_remap_matrix.enable_remap = false;
> -			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> -			return 0;
> -		}
> -
> -		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
> -		blob = colorop_state->data;
> -		if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
> -			ctm = (struct drm_color_ctm_3x4 *) blob->data;
> -			__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
> -			dc_plane_state->gamut_remap_matrix.enable_remap = true;
> -			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> -		} else {
> -			drm_warn(dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
> -				 blob->length, sizeof(struct drm_color_ctm_3x4));
> -			return -EINVAL;
> -		}
> +	drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
> +	blob = colorop_state->data;
> +	if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
> +		ctm = (struct drm_color_ctm_3x4 *) blob->data;
> +		__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
> +		dc_plane_state->gamut_remap_matrix.enable_remap = true;
> +		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> +	} else {
> +		drm_warn(dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
> +			 blob->length, sizeof(struct drm_color_ctm_3x4));
> +		return -EINVAL;
>   	}
>   
>   	return 0;
> @@ -1624,29 +1607,23 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
>   				  struct dc_plane_state *dc_plane_state,
>   				  struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_colorop_state *colorop_state;
>   	struct drm_atomic_commit *state = plane_state->state;
>   	const struct drm_device *dev = colorop->dev;
> -	int i = 0;
>   
>   	/* Multiplier */
> -	old_colorop = colorop;
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    new_colorop_state->colorop->type == DRM_COLOROP_MULTIPLIER) {
> -			colorop_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!colorop_state)
> +		colorop_state = colorop->state;
>   
> -	if (colorop_state && colorop->type == DRM_COLOROP_MULTIPLIER) {
> -		if (colorop_state->bypass) {
> -			dc_plane_state->hdr_mult = dc_fixpt_one;
> -		} else {
> -			drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
> -			dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
> -		}
> +	if (colorop_state->colorop->type != DRM_COLOROP_MULTIPLIER)
> +		return -EINVAL;

dm_test_colorop_multiplier_no_match needs to be updated to now expect
-EINVAL.

> +
> +	if (colorop_state->bypass) {
> +		dc_plane_state->hdr_mult = dc_fixpt_one;
> +	} else {
> +		drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
> +		dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
>   	}
>   
>   	return 0;
> @@ -1657,8 +1634,6 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   			      struct dc_plane_state *dc_plane_state,
>   			      struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *new_colorop_state;
>   	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
>   	struct drm_atomic_commit *state = plane_state->state;
>   	struct drm_colorop *lut_colorop;
> @@ -1667,38 +1642,29 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   	const struct drm_color_lut32 *shaper_lut;
>   	struct drm_device *dev = colorop->dev;
>   	u32 shaper_size;
> -	int i = 0, ret = 0;
> +	int ret = 0;
>   
>   	tf->type = TF_TYPE_BYPASS;
>   	dc_plane_state->cm.flags.bits.shaper_enable = 0;
>   
>   	/* 1D Curve - SHAPER TF: find state */
> -	old_colorop = colorop;
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_shaper_tfs)) {
> -			tf_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!tf_state)
> +		tf_state = colorop->state;
>   
>   	/* 1D LUT - SHAPER LUT: find state */
> -	lut_colorop = old_colorop->next;
> +	lut_colorop = colorop->next;
>   	if (!lut_colorop) {
>   		drm_dbg(dev, "no Shaper LUT colorop found\n");
>   		return -EINVAL;
>   	}
>   
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == lut_colorop &&
> -		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {

We control the pipeline creation, so this should never not be 
DRM_COLOROP_1D_LUT but it might make sense to still check that for 
sanity, in case someone goes and messes with pipeline creation.

Same for the blend LUT below.

> -			lut_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	lut_state = drm_atomic_get_new_colorop_state(state, lut_colorop);
> +	if (!lut_state)
> +		lut_state = lut_colorop->state;
>   
> -	if (tf_state && !tf_state->bypass) {
> -		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", old_colorop->base.id);
> +	if (!tf_state->bypass) {
> +		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", colorop->base.id);
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
>   		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
> @@ -1708,7 +1674,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
>   		dc_plane_state->cm.flags.bits.shaper_enable = 1;
>   	}
>   
> -	if (lut_state && !lut_state->bypass) {
> +	if (!lut_state->bypass) {
>   		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", lut_colorop->base.id);
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf;
> @@ -1765,8 +1731,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
>   			     struct dc_plane_state *dc_plane_state,
>   			     struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_colorop_state *colorop_state;
>   	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
>   	struct drm_atomic_commit *state = plane_state->state;
>   	const struct amdgpu_device *adev = drm_to_adev(colorop->dev);
> @@ -1774,19 +1739,14 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
>   	const struct drm_device *dev = colorop->dev;
>   	const struct drm_color_lut32 *lut3d;
>   	uint32_t lut3d_size;
> -	int i = 0, ret = 0;
> +	int ret = 0;
>   
>   	/* 3D LUT */
> -	old_colorop = colorop;
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    new_colorop_state->colorop->type == DRM_COLOROP_3D_LUT) {
> -			colorop_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!colorop_state)
> +		colorop_state = colorop->state;
>   
> -	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {
> +	if (!colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {

An issue that existed before is that we silently treated a colorop in 
this position that wasn't DRM_COLOROP_3D_LUT as valid and simply set 
lut3d_enable = 0 below. It would be better if we explicitly check for 
the type here as well and return -EINVAL if it's not a DRM_COLOROP_3D_LUT.

Harry

>   		if (!has_3dlut) {
>   			drm_dbg(dev, "3D LUT is not supported by hardware\n");
>   			return -EINVAL;
> @@ -1825,8 +1785,6 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   			     struct dc_plane_state *dc_plane_state,
>   			     struct drm_colorop *colorop)
>   {
> -	struct drm_colorop *old_colorop;
> -	struct drm_colorop_state *new_colorop_state;
>   	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
>   	struct drm_atomic_commit *state = plane_state->state;
>   	struct drm_colorop *lut_colorop;
> @@ -1835,38 +1793,29 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   	const struct drm_color_lut32 *blend_lut = NULL;
>   	struct drm_device *dev = colorop->dev;
>   	uint32_t blend_size = 0;
> -	int i = 0, ret;
> +	int ret;
>   
>   	tf->type = TF_TYPE_BYPASS;
>   	dc_plane_state->cm.flags.bits.blend_enable = 0;
>   
>   	/* 1D Curve - BLND TF: find state */
> -	old_colorop = colorop;
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == old_colorop &&
> -		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
> -			tf_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
> +	if (!tf_state)
> +		tf_state = colorop->state;
>   
>   	/* 1D LUT - BLND LUT: find state */
> -	lut_colorop = old_colorop->next;
> +	lut_colorop = colorop->next;
>   	if (!lut_colorop) {
>   		drm_dbg(dev, "no Blend LUT colorop found\n");
>   		return -EINVAL;
>   	}
>   
> -	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> -		if (new_colorop_state->colorop == lut_colorop &&
> -		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {
> -			lut_state = new_colorop_state;
> -			break;
> -		}
> -	}
> +	lut_state = drm_atomic_get_new_colorop_state(state, lut_colorop);
> +	if (!lut_state)
> +		lut_state = lut_colorop->state;
>   
> -	if (tf_state && !tf_state->bypass) {
> -		drm_dbg(dev, "Blend TF colorop with ID: %d\n", old_colorop->base.id);
> +	if (!tf_state->bypass) {
> +		drm_dbg(dev, "Blend TF colorop with ID: %d\n", colorop->base.id);
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
>   		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
> @@ -1876,7 +1825,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   		dc_plane_state->cm.flags.bits.blend_enable = 1;
>   	}
>   
> -	if (lut_state && !lut_state->bypass) {
> +	if (!lut_state->bypass) {
>   		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", lut_colorop->base.id);
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf;

