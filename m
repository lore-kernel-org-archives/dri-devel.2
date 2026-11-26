Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BC606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uaqcXi8F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B65071123A3;
	Thu, 26 Nov 2026 12:00:10 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012061.outbound.protection.outlook.com
 [40.107.200.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F231123AB
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGiv0a7RzNkrMyWM3kBu8d2GTrIl0ApUcGoe2E/XF+ertv3pK39DiG1Tz7/0BV04/2jRJDHvhfMBNA7JZv74PJDfWqxxmFkdYwDoJVl8uEWsinjxP8zYXo4sLMAWlTczm1hDy+Z0EFdfu3g9g0z+fHCJVCMqWHev+zNIzmlYoZY3wJULlZq8g/u9jspcNe4JcQOHMPFaPjLqJbhzBAOC2/CtwMb8QGlhOBEJk3uwigG3gr1dloC96B025436CIsKsztuAw9bW24CYVhYLZMI03Xg4UrQ4/HsS2eP1z5dwBSJQGPPV8SEGndzYCLfvDhSehnHYfnU/FdcvNHYafK7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PwRpRFngZ6rbchkB6Pcnw/bNyR5J/yLmQNLION4u5M=;
 b=q1ocqRM1tCG0nGwMpipzwuwC4wYx3SNpk4Gi3m1Je1f1GraKJWhJrXmS4/tDZ/Ei2dzdhbQ2SDGJadMnDHmzDOidzk5R2KSsvho8ViXl6HF/CKft1tOA7+FzzBTnmnJaLoEbwdcRvaVHSgfgFQO4XfHwCGIa5LstJGl2r/8Es0olcgvPccLOmszfc5zJW7X0zlvfVU8QrSOkjImZ/3g94ospeUgsrGXrXNFCymcE3TNcUmMPo6VzdoCZfWUuJUbIt1CfmMLWFtb31WBdcBDRzXm8WrSiu5/mEEXWaBRUU/qBELM2lRX1/M/rt/IMZgl79gqkDAE7lJhk/DWB79Q0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PwRpRFngZ6rbchkB6Pcnw/bNyR5J/yLmQNLION4u5M=;
 b=uaqcXi8F3Y7261KNvdpcq8bTZnuPuyu/QTmKWhV7DkkNfz+Q1RZjC/yQK56PjBg0xvVzqVhEQajqVshJgJv6M2BtQJeqzCyjyaMf7+nN38oJkQKFhkYPDOcUk7n4uhNISynwbwQE9cv9AxmbdC0zJ7UIwvG55Pf/pzOKLBRC70w=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4369.namprd12.prod.outlook.com (2603:10b6:5:2a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 12:00:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 11:59:59 +0000
Message-ID: <366f862f-0d59-4132-a176-a6ee906d6fa2@amd.com>
Date: Thu, 26 Nov 2026 12:59:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/syncobj: Use vmemdup_array_user in
 drm_syncobj_array_find
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126111117.67342-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:d4::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d77fc46-3816-4549-1080-08df4bb4cbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261102123227099003|56012099006|11063799006|10067099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261009221227099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: X521x7L7in0fai0SrqXWfusesJ8zYwHsUM45pxA2FcfaJRo0FbGouuA7shPV8ZoVgSEMHJ1bXLPdQ33Rm7S5eNAextQOseIr7e/eq0pPGFDhYlUaYKgB7k9JmHUANS9VV0xadTf25kEoIdH8CTkDG4vqTb4srWKxghMrhqD99utd6L71RhYkz8zQyBY9S6x/E/OiAxenbdclVCS+oFRVFyb6HjijmobDxCmI/O2511JDjZAbClqM3wIzfSd8kZ3+esbG8UdLZHmVjj6l2H+XhSeMhP2pDh0H4toTXLUL7yscoxWlfrCw/oadlElY4sCwhQOjNvjxT+VBs5VXfJLXEC1nceq9dcKibbsIUy84JDDXqts3LluDxMvsbMF8AYeD9D/E0S9CnUT2JQ5O2FOkKdJgUwE7DaQWvGnGukh7ivfEzTpQK3a9h6CoEQEFbNG37Cx1dW+qjP9TjuQCgY6l0fOl1+gJUyZzZKBu04NB6AQCjrSEHoOKIxHmod3oUdc6O+IB3wpPr8HYhSSpYb5YO4nxzj44yK3UQ+sKRid0iM54FLMMx4BGT3ziRFiGtekQjL14I3TZ/3mVAiet1rXWLVPiz4Bg4xnuTCaik9ffEpNEy7k4asLzVRC1Y5cuG9AIx5fWMxq1MUDHws6ZkmYYiXA5Q9St9Wxlrue6QWYkbmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261102123227099003)(56012099006)(11063799006)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261009221227099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNuUEZrVWhyOXlxQzUwai93YjBJM2pXSGlYak1zSVd4RHJGMWRzOTI1Z0N0?=
 =?utf-8?B?NHpIcjE4RG5TWUdaOG9MdHRkQUMrcG5yR0I5OTk5YlZsbU5PMGk5OUNuUXRC?=
 =?utf-8?B?clJueFdoWVd3S2dXeVZIUE55MjZLTklIR0ZmcXRwRnNDVDRqa1lqdWRwd0JI?=
 =?utf-8?B?d2Nsbm9CYXlJVkFhcytKVVF2NHVRMzMvejRGMFdLZGxJdno2VDFKQTgvTlRI?=
 =?utf-8?B?R0Noak04TkFWZzRTMHJZNFFjR3RUYkRpNCt4elFsOXpzeEdHZGdkRFArSGxn?=
 =?utf-8?B?ellQT2xHMmU0V2QrVlgwcUdzZG8zNFNIekl0b29EVk9NbmZaVHF5YWJZUTlJ?=
 =?utf-8?B?M1RPMm1oRFJ4OC9HS2k4ZFFwSnhXemZnVXp3cWNJb2wrT05nWlJQd3pDd2N3?=
 =?utf-8?B?c3RDak12THNnYVE3OXlic09FOGpWanFMUnFSSHJuenBENWhRN1FWeFBzamVB?=
 =?utf-8?B?ZzQranpTaGRkdE9DRDZkMjVLNkEwd21Qd2RIdVdLYU1YbGF2RVRjNFJDNVM5?=
 =?utf-8?B?OEpPOE01T0FDM013NEVrTmYrVlcyYUZHU3NLSlJkT1dpZ3hNbTVOSitMaVMy?=
 =?utf-8?B?RWNrWFBQUGVGZVpnd1Fwc3NuWk14djVWRnF3N0hDWk1WalVoa1g0cHJlSEJH?=
 =?utf-8?B?VXpQMjBBT0FXTmJkVU9JNTRxdGF0TklNYmZEbnBCbzljcE1wTXNwS2xQSjlL?=
 =?utf-8?B?N1J0SkF4ekNWaVJPTEhuMWZFQVNrcWgvY2NFOVg3N0dvMDJiRjFpZWNKTUFD?=
 =?utf-8?B?NE5OR2tUbWNOUXhQMDY3VmxTNXVjTHNLWXo1VVMrL2VFWnRBVUFTNkdoSXRG?=
 =?utf-8?B?SHl5YWRkZFp5cWdFdlFrUGVOanhEMFB4Nm9qenFObVZldTZERnlQQW9PUkla?=
 =?utf-8?B?R1k4QnNFRnlxVkk4dEhrN2ZZOHpUTk42YnZrK0tmdXdETk8yWklBdFZ5UVJt?=
 =?utf-8?B?cE8zMkk0SERRRnFLS2VUM3JnTExiSERkdjZOMDh1VjE5TGVRaUdjK1BVSkF4?=
 =?utf-8?B?WjROZ2ZSR1lZbXNNUjZoeTZNMkdpeWJCZUIyb3NvM01XWnEyd1NUbzdINTVr?=
 =?utf-8?B?SlhRcHFJRGNaUThpbzhvYUlEQ2djRHd0Ujl4UlNZdWM5UzBXT0d5YUUvYWJW?=
 =?utf-8?B?elJkQ3c3T29hcE1Ocjd5cDg2NE1OZ0wyMlg3ZGhCTmR5SThPQnFBUGMwbDRv?=
 =?utf-8?B?dk9hbmc3R1ZNQUVWWGFaQ0hpeWYvbjMvdVRPK3BMREJQanhpdDQrbnJRSzlG?=
 =?utf-8?B?RDRsa3JYN3FTTnJ6bXo0WVlQTkZuOGl4NFBLRm1ZeTNjNkVXeUhmN3lhRkNu?=
 =?utf-8?B?OFZFemFJbWN1aUNlSmJvRkRJRnFTUDRKRE9PdWRybnFuOXZmTDRDSXg1WVE2?=
 =?utf-8?B?eHh3WW41MkliZDFXSnM2Z3ZieXBsYUZDamtkcnFZWXhyZFBvL1V5RmZkREdy?=
 =?utf-8?B?OE5IZkxuL1Z1TG1Mc2x2a3dKSWowRE54UWlpUitYVGFxbFZoR2VaZll1SW9y?=
 =?utf-8?B?YkY2V2ZicFA3cHFiUUFGZUxNS1kvek1BRDFjalJ3L04ySlYyc09ka2c1Zjcx?=
 =?utf-8?B?ZWVEb01ndE9sTzJONXZGeUhVTHczbXE2YzVhdnVWMHNnY2pHL3pTOXZ2bnlV?=
 =?utf-8?B?S0U4NXlURWt6WUhWZENwUXN3a294Y0JVNURyazQwMk81dkg2VGMwMzRQN09s?=
 =?utf-8?B?Um5Fb2IyWUoxNVAxMXZaN3BZeS9PMTZrZVI4U0wyaXZGYy9BeEVnRlQvZnc4?=
 =?utf-8?B?SXNlOTBESXNqR2pIcHI2SVBSa0lhRTNWc3lhZHNla3lnYkVYaFlhWGJuRlp4?=
 =?utf-8?B?cnY2dmlYTmNsa2hDSTBIQzcyRU1FVjBzUHdzMElQNGk5Q3BQL1JtNTlJa0RT?=
 =?utf-8?B?aHpJMXRUSHVBTnpHZVd2TktBUFdKbVRwMzJjN2FiMy9UYzNsREszcGlXNG02?=
 =?utf-8?B?KzB0WkxUOW1jVjl1SXh4RWtzNXNiU2x1SjJlS0NCUURYRjdYWXpzckJRVVRa?=
 =?utf-8?B?dzZ6cmxLZ1k0UWpYelBLRlBjRzZ6UndneTU0V3F5Sm80d1hjTERKUUVTZHVL?=
 =?utf-8?B?TU0xNUFJelhoOUMwK2xrRElpeitVbE85MjNMWGk3cnhkVHVza3ZMVmczL1NH?=
 =?utf-8?B?YlhUVmJmaXU2TWsvM1FzOXB6eWRObE0yZ0hHLzIrUXZjWCttckxUbjN1bnl3?=
 =?utf-8?B?NDBDUC83TW1leEJOSmFua0hTSlV5T0dSaWxOUkdaa3o1WXJnWk1YenovUHFY?=
 =?utf-8?B?NjhUSGhBTUdIWld1WGwrMzRNK2tjMUI1K2xoWFdjRGR5d29kYjFQcnRKaC95?=
 =?utf-8?Q?DCBcB7EtMOwO2AbWn2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d77fc46-3816-4549-1080-08df4bb4cbd9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 11:59:59.7967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoHDDJEspyNv/qdQlSWY4hl4RuGPIRCxPD6akLWdhMpty88pJDlDWVHqYX8xeV3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4369
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:11, Tvrtko Ursulin wrote:
> Using a helper shrinks the code and separating the user and kernel slabs
> is more secure.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/drm_syncobj.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 6cc654641183..663d6cb8dbf8 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1252,15 +1252,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>  	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
>  		return -EINVAL;
>  
> -	handles = kvmalloc_objs(*handles, count_handles);
> -	if (handles == NULL)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(handles, user_handles,
> -			   sizeof(uint32_t) * count_handles)) {
> -		ret = -EFAULT;
> -		goto err_free_handles;
> -	}
> +	handles = vmemdup_array_user(user_handles, count_handles,
> +				     sizeof(*handles));
> +	if (IS_ERR(handles))
> +		return PTR_ERR(handles);
>  
>  	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
>  	if (syncobjs == NULL) {

