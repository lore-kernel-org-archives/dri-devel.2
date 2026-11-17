Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZEF7GIkj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E9510F722;
	Tue, 17 Nov 2026 13:24:54 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A13310F71C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:24:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oNUV9OWasjkGTmaMAScqhvBZ5WsBmKdvtuAZZkL+LXVks/jTVVyGE1uDpYZxD6Q2U/xvIQIBPnQfcS0mfo5pImv/GN9LSVh5y8snMuwEHhSMsUjDODyn+uvHIwv60EXNDmSL79WNtQDt+cpdh3H879AVzkzyaZWqihPt8/3/WoKWm4yNUllL+ekqdc5FZXmir3CzWeIOORd6XGBhvBid0GElbH3jShtBHCDvyfvG+GWm3glxQSbjw9a14Mc01q0YIqcTMFRtzykTYvxfSqQuUeozolt1MPyXg/zfpI136CyiWuyJC4FVZC0JgLqYR9tWtKG65nqg6mQAezpQYYgOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCWw3IXApzeabYekqmSjMbnP+CL4rjbx8aCwsXSOB9U=;
 b=IZmE492JkWnincJFcZwMqXT/Ayrdqgy0DL2T6PCrwJ0oHnEolOhRqE6UgULj7pJKqq8S0p65kSohEPdMGWGePtoMbnyPDU8HwTt+7zeokkibW0j4piL288+587O0BntbmJ5p77QauM6cHRgK6bRmh0FQj0fsl2I+MjCb+HpjlpWXfSoeSna1lNkNQGjECWcEEvN0tiZX/dO1xxC37Lzhit2WMU8xvMuGQt93W/W4hCTYBt/n7uiEPgKlP8jJqN+Q5Md5NfLLBa01mI5gnCaEJQqGKMVPTmce9nBKIsDcMF5C/QZKYVkJbH17JQ4KCfaA3fMeMFAw6r38MDwyfkN4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCWw3IXApzeabYekqmSjMbnP+CL4rjbx8aCwsXSOB9U=;
 b=ZEF7GIkjpt7unjzBZ2eErL//KAvyEC1zxlz8HJHk7uHUrnJogIBqjhWU6Gm99iovvnroH9AvZ7+RPeQNoUcnKoWG7YTGReRs/QxuQORhjX6W6JmoqmSJ/G6KpGUFIzhq+uS2QiFKpEdbz+BJb4ugaPfrcXZEN8mXNb0YxpT2oL8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 13:23:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:23:24 +0000
Message-ID: <58bcfc9f-bb64-47b6-8cec-e774abb4ca86@amd.com>
Date: Tue, 17 Nov 2026 14:23:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/syncobj: Use vmemdup_array_user in
 drm_syncobj_array_find
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>
References: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
 <20261117103916.9101-2-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117103916.9101-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: cc159714-4807-452d-3bd6-08df44adf525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|261009221227099003|261022075727099003|261021123027099003|261021121427099003|56012099006|11063799006|10067099003|261102123227099003|4143699003;
X-Microsoft-Antispam-Message-Info: Avpzvs/BxMeW5bYpZPqnvMvCZGc5RJ61Fjj3dOhfCUM3P0bMKEZgCL6qe8kqwYI3fbvRhGR/9hBci0L9uk7fI/PcjkpK/jKPJfnwnoCVhFCnk1DFJznVk6wDA+hp5moUNvOivlwDIfRybHSFzvIh/DWzoGh5P2x2UHSl8RSP66iHGvCSJNXbhUzoyWN/X5iMCQOvvS7drldSUx7mMM4SxNp7F048IvNz8XM9sVuumI9tl1re3OibOPVjbSfA3bDVaxrtBJihbuO7oIfyPc+zGLjc5PCfbmVC7n0bALFk4GGsc8Gft0fJg6iTR60swkEIw9Xa9yVZZxmu0AdqPxsGpVFA1WT779wummZkd8pUFrvZwyrafQm/ddojORzJW3tGvBP0/n/87bdHknRfHqNCqESFFkGAmllSw5WAwb42+DATpHemJzJsf6ZyikJpjB/o7lH/HwGJOHT/RIP5ydYj//awNM0q0b1mFv6xMq3sGDkYRPMaZx2D8ke1zq4OC4C9Purj1a3ITc8dlyuJGYrn2dGedMeomXhih3qeCk3dfmy6Yw3/EROqDYpKpThs/ANwrXO1psZIZtyuOwtCgCvPZcB3YxVgblvqMj+YvTDWsW3w0zn7RuFFXWDL4jKUplh+NMPjVOFLOOFpqZwncqFfhbI2MNGVs5Ak3hnmkKGuZEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(261009221227099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJKN3ZqdTNVRXZsbmthZFBaWHFvN253eGhqY2ttb01CUFRYOFRhbE5WTFJM?=
 =?utf-8?B?bUpwRWxzWFZRcWFPdzJvN29wQzJEcVBQcURySzc0WUd6UjVKM1l5dTNDRzls?=
 =?utf-8?B?dTNKTDZuNWUxc0JvbXZEMlY3a1FzbU5JMzhkZGZoaUovSnl6QUhJNVVIYng0?=
 =?utf-8?B?Z2RTVWhybGF6MlY5RFp2WnlKSDd6QnRORDFjNVpqZkZVaHpRR2I3U0M0UlFE?=
 =?utf-8?B?c0xLL1E4bnVIbHJudjJaelg5OWY2Mzh3UkRZdjZTRW05aW1OY3E4RVhhVlVF?=
 =?utf-8?B?aDVtVFdsdEtsRUdBY2piZi95dnpScWFSOE1hUUtZV0FPazJPYmNEZFBRTC9Q?=
 =?utf-8?B?bEhxaGI2Q1hQdmVGOUYrK3pGWGs0Q3Y0Ylg3b1pXQ3NLWFpTYXlZaFhmajB2?=
 =?utf-8?B?WkQvUTZndkI1b2J6VWFhU1F3M1BxeE9pM250QU9Gc1hwbXhubUxNMGdpY0N2?=
 =?utf-8?B?NnQvTmVVZ09ZSzdtMDA3NjVjK1hGQmlTdmV2SG5jaGVJWFhHWEpCSmRLNHVh?=
 =?utf-8?B?Szh5RUVXMkVhV0hCSHpoS1JWR1FiRTJKYm81RzdxcWUvZGJ0Z09VZ1pZUm9y?=
 =?utf-8?B?akFIc0VHR3oyQ0NKd2hXalp6NUw3c1lDQnNEa0p4QzVaRXFxeHdqTzhEaWI5?=
 =?utf-8?B?L21iMnBLRzdRUWNWNUZEb3VtSUZpWWJSMUVyS2lpWDZlZ0RYaDdzMXYza0tP?=
 =?utf-8?B?YWNOWk50VHJZMzEyK3AzSEthZ3lFNjdvTm1udHB2MXNBeE52NGQxTjJidVF0?=
 =?utf-8?B?TlMyQ1ZidkdpUUtsL0Iwa2toODcyOGN2QnVIZ1kybHpPbVlCbzBEZ0RFcTNl?=
 =?utf-8?B?VUlHTzN2b0psZzQ5SUhzTFNCM0VsNVgyNjgrV0VXTVN3cmhYTCtlcjBUTEtL?=
 =?utf-8?B?TDZqZEVqODdqRUF4eDQrZmI1NmdWVHdLalBlVFVURk5jTXQ5UjJramZEYWo4?=
 =?utf-8?B?UnVRditRelYwV09KQTZkRDRUeDdxcFNyL2ZMdlY4SWJETzVrMUVSeDMyd1Fq?=
 =?utf-8?B?L2twZENMUmIzNGZsSWtxTXFJNlNrazVEUUw3cGxaWDhPRzRXd2tIUFFEaXc1?=
 =?utf-8?B?dXRXL25xemhMTzJ6WThZSDhJZlhUbEREU1A0a1A4S0F2MHVUOE5VOE1oSGJ0?=
 =?utf-8?B?SGRkUnh6UkFRRzJzbkNpSWh2YVVONmgzelBSbWhzVm1pZXJYa2RUODVGMlk3?=
 =?utf-8?B?ejQ1WHp6dUZ6Z2VGOWJGTGRuV3k1dWFWMzRBYTkydDJqMFYxcTlWaW5rNC9F?=
 =?utf-8?B?WGJtNFdmUkJhanlXdS93NW80Yy9VNGd2UGs5RmROemp2S2F4RjZ3QTVsY0Rj?=
 =?utf-8?B?RzRvZzBmc0JMQlFJTlZFZ1BYZzhueDh4TDlVcE4rVzQyTnNSb3p4QStSZWsv?=
 =?utf-8?B?KzFCckdWT3Fkd2FEZGhCRDJVVHkxekZCZEpiV2diMlFZODNYRy9JL1FGdjBh?=
 =?utf-8?B?S2R6elJsZERpdjRYLzRiVUZmRDRzc2JNTnNrWHJQR1E0YkcvNTJrZXE2alJL?=
 =?utf-8?B?dU5OREYvM09pYUtCbzFxRE1lQVkvRzRxQXRkQ05RK2hIWS96MEhJelhjVmdl?=
 =?utf-8?B?cU9FcjFOZVB4a29CQkU1Q3ROcHRMSVhha2MybTZubkU2MFVHMXkvVHRGbGRl?=
 =?utf-8?B?amRNU2dLY1VIUm5FTzgxY3RPYUFJdjFPdVVUcytnMXNEQWFkNWVIS0lKWUZm?=
 =?utf-8?B?WEpBT1JuVHVIcDJYRDVrUFVjUlIxdTRURDZKUHRxbFpSaEluOXhWUElsaVhZ?=
 =?utf-8?B?Q1lzd0l4Zi81WVpDYzBPM1hYaTRyMUR0cnNzUUdkTDVDOStYMlI2ZGkzQ252?=
 =?utf-8?B?Zjh4cUJnSUE1b2dNM0hLcGRCV0paZ2ZmRDVPT1ZaT2JiSjVsd25JREo5MU5a?=
 =?utf-8?B?RWZBcVIyZ0RKbDdqS3hGOFB0Y0R5Zm1ZNDBEbm9tUVFRbmUrS2ROcTBENXdZ?=
 =?utf-8?B?Z2V5Mm1VdTlRTTZsdG9sejhic0JyaElJNURBRGZrTHVVTnJwRjNjdVZlaHdn?=
 =?utf-8?B?QjFxNWhVWGhkazRsSEdyMzA5SE92V3JndThxbm83cCtpbXMzRzMzUVhUL0Nz?=
 =?utf-8?B?WjZkUXU3TXl6Mzc5NEhrWDIxNlRNQkV0MEhqUkczYkN0UjNDcVBlVjB6MHZr?=
 =?utf-8?B?RWNhNEliMlhnNXFGaGppUjByeGVVM0tXUmJGa0NsZ3J2R1NPZVJmRnpPS1dX?=
 =?utf-8?B?TWZoVHJwVDJTY2FuRk04Q1NBNnZaMXF4cktTQnJ4Mys0NStac0NyZzYxTGNn?=
 =?utf-8?B?MldaQ1Q3TXdWNXlEM1BaZTc0TXdjTU1WSHFGQVpRNEl4Q3p2TFZGL3QrMWUv?=
 =?utf-8?Q?nyN0dQaXbIAAfFvSy1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc159714-4807-452d-3bd6-08df44adf525
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:23:24.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4/X7cZV7yRlRzOa3U49nAeBUltmaQvRB4VEDiZzda7eBXJKeBRm4jF8Edvg4BHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
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

On 11/17/26 11:39, Tvrtko Ursulin wrote:
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

