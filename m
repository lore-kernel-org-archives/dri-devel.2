Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259BDC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A22710E32A;
	Wed,  8 Jul 2026 17:11:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qze5nDFV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBF810E32A;
 Wed,  8 Jul 2026 17:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1coAfxs07zmRW5DCN+qqpY/FiNo1dGTHbv6QhS9lRZFlmG5Q1zUhIfYKzdMEho7G/CoeeOUhphiddf/kYDJsd8zvJgLjDz3oVq5EHzLvazilkpJPLW5NcRCL0rEozEVzvaZD7m9qN/nDRCIC6chTg9Jzc2BKxoG9r68lxuEA1P1+Hm5d5QRtKG6aKN7uA2duTsFPKuxNCWYnpqzzBXVh9ZxYZ2SlZG2JToGCC/ALUvB/ALIgdNdQfxrmKVrEmvAOKPQ+2V4LnYz3emTvCS2kc0tHUFgMwCsxCstu0QSSrAUHOuMNSWZTR1lVjDl3TYYDmNRS3ojBt6tGbgTlmIiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7EQBJLVb1seC8GL0j8OJI4ufUlHaTav9nJAqG1dTSs=;
 b=LWApcZPIaUD9e5P4fQGCUTjZs/bsiqYfoDSLEJjzv69IkTtZuHnyNd612hDxJ1tqKtr9UWQBpz9N7JZ0NrxuO2nNH8raaPIG6hMlofDbGpDjeBv7OK7RbeMym08r1kT9ye9ldty166z3gS124a6yzsKAlDBTzR6LqqbGU8RBX9ymQZ8R6FxCaPclJubxO6mGwQFr7i9x3iC3O64FF77qqRlsh3nXpqKt6qzY5uHRBX8332UK/uDAfHwiRKneyNdfoPXCuNz6QVyTdpmExpBTIp++4+4K3C+VixDT5o6llnj9jgsoljq0qL/0GefwXiJDVaKo+j652YyttdMVZuLIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7EQBJLVb1seC8GL0j8OJI4ufUlHaTav9nJAqG1dTSs=;
 b=Qze5nDFVxclXfbgSFc59fB9tdL1ReFrKZbbAu1W4+rboKp9e3c2HecyBZqFmtei6nVXL36wn+OE1rTIlH3vW3fxwFgxenc42QCdQyXHLYtgctynUDsfQ/jWzeVKc+egIq7XZSUp6735MTlSnDIheZdk5VLrdraQ/W4iSnHUmxQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by LV8PR12MB9643.namprd12.prod.outlook.com (2603:10b6:408:297::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 17:11:29 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 17:11:29 +0000
Message-ID: <2171fd97-275b-4e2e-836e-00c811984719@amd.com>
Date: Wed, 8 Jul 2026 12:11:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: move connector state dereference after
 NULL check
Content-Language: en-US
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Ray Wu <ray.wu@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>, Maxime Ripard <mripard@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260708072751.724400-1-lgs201920130244@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260708072751.724400-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:610:119::28) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|LV8PR12MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e62a949-9ec0-48b2-c888-08dedd13f31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|366016|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ObPY3RA0vCKpD+fkroLsJYHjnpT8adQtP+JPb99dV4q5MsnVRf8JzH7D4JumrtId4vSYvtZ2P2yxRLYQ2Rg0dBqxZqzIkdBVWrvcxWoOYQFFjNajUL7hGNy8zZNGkyPgJSVIeWC+GqroiYUybNRvAQe2IMMa4pvw3+9ygD/cUlErIEyBbv9mAEPI9/Wqr/im10vS3628wk1KTZJEDau1C4J+QipgUVV5UfLqq6wfEpxk0S9yMYvzsspfEj8WaP5yz3e3sVA1gik5UQPEGcwX+utuORTciiI7CK0QiaWBV6iKZXOuPMoj84msLUzDfxh7DMUZUiK5YtyKCCKOVd2hptXCYC63n2l1hlPt/dUMHcHhfdrx8G0PnMqhHWuyWMbSw1HLlnYtCGEPuO8uWHh2Tg0BqGueabPh5m96rs6Ps9jR8oMEacA9Ezea02oLMHYF2r8DrrUVt1fAGThEGbskjdnPRv9fYVe1a+IAQb3TnDKbxVSotv3pIoZTSDFdp5l4Li7PdiUhujRmX6rFlKlcv/cgnthVy6K3eZAr63eSFrG75GVoNYFgrdJQG77FfFrR+FJ8xjEcvt2KnfDEINycswZfL0IDEw5t8dsxjfpX86aAP4YZLccUJEB3tgAdaYX4F1sNSmziBCBfEsS57x2FwAHaoFsR+Q02qv5Mi6TpBlYkDpSPz602gzdbuq///QSO+/ha8Qer+H+iI/uU0GHBOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFV0eng3OVAwRU05RksxNFdrZjFaczBJb0dkTGFNZDllRkdQVEtwWGxjTExG?=
 =?utf-8?B?dEJMU0NDR1paUDNuSmZtY1RucS9yQllIYjFQQnhSZHMvNHJYYng3Ni9JdVpa?=
 =?utf-8?B?R0dpR3VCcGZYMUZWRkw5WVRrcDg5WVh6aGxlSk5JQkt1OE5jTzZic0FoY3BE?=
 =?utf-8?B?YXVyL0FsUWVCTkt6ZXRIc1BqNU54ZnlWWWlibGk0QmxnbWZGekhFYnpNb1cv?=
 =?utf-8?B?OWZ0L0FnWDU5VW1QR0RTaWtFZUxidmpnZ0tmdFVxY1BmSmNPb0pSeUpVTEVu?=
 =?utf-8?B?UTZrUkd1Z0dRUzhLMndFVnNFRmhKU1B5NW5CeVJEL0oxeVZ3amhVeG5STmRu?=
 =?utf-8?B?ZzR3WGF4S01JOW0wL2Y1ajNJMnpVeHJ5Y3Bjc3VrVm5sQWNxYkQzbTFlZFJW?=
 =?utf-8?B?WjFXRmlxNVQ0S3JKSHJhOE92ZWplaUxtTnZuKytUbWJvcDdheTltWGdSRWZt?=
 =?utf-8?B?TmhKejUySDdTSkNzWWFSbUxrRWl1QUVKZUtHNmR5bEFkQzF6QlUwWmhwbHpq?=
 =?utf-8?B?eCtOZEFlcGE4UGNOSzBZNVdoWVN0QXlqSHlnSk5LbzFGNFo3VDQ1VnVxcDFK?=
 =?utf-8?B?WXFOaW5WeG0ycm5LdmwyeHJNdDJ3ODVWb2VPejFDQUJMenZZenR3bHltdktP?=
 =?utf-8?B?SmtaU1hSREVsZ2M2ZlRZQ1I3NC81YU9DK2tIdEMraXN1RUxEcU5MM1M5b1FI?=
 =?utf-8?B?VHQxZ1IxTGQyazBjakJLT09yQlFSQ2FxZVc0ckc4Z2JKaXVNaEdFWGRWVCt0?=
 =?utf-8?B?RVJpQXdleG9HTHhHcGFBWE5tWkczZW5POSswM2d4WDI4T2k4SnMvMFM2dnlh?=
 =?utf-8?B?ZUxaOXc0cFZkTnhHVU5DYWVFaW9XMERSb08yZWVZQVBaRUNWQ1l5aVloOGkx?=
 =?utf-8?B?T0tmbU5YcmJWc1RySWszL01Fb0tVS0czWDlRbnRhclNXUm41ZzU1UmtESUJF?=
 =?utf-8?B?amlsTWV0c0U1OU9SL1V5S3FvekVqaGhVeC9LVlBodVp1dzhyK0IvdGd6NENQ?=
 =?utf-8?B?UVQ3eURTSTRDZlE1YlcyT21DMTArSHp4cTZDbE5FVFdyZENObWhMSkpRc1Nm?=
 =?utf-8?B?WllyVFdmZDY4UG1sQ0hVbEFZWGRlRm5lUmdURTdHWE5MNHliRlNvMnVMam54?=
 =?utf-8?B?WWtPaWxwelJiYTM4VnJXYktCWWkySEdRMFVpcVlFWlhTeENVblpUODlsT2Vr?=
 =?utf-8?B?ZnpJVmhoMm1FVkhOQlYwV0ZxZElVT0lhU3RJaXAvZFIvU0VqaElXRjlYS042?=
 =?utf-8?B?YjE5YzJ0ZExYTER3M0dWZUF5Z3FKOW92MStnOWw1TGRBbHdCMjlncCtrTXh0?=
 =?utf-8?B?Vk1zRVBNZ2VYZ3EzVFJJR28raXRkdTlIdGhiQjZESlEzd3FOL1FqTmtBaXVr?=
 =?utf-8?B?clBlTE0wa1VGaGhBTWlieEFSalJ2RjBidkZHdGROY2xBRENwSjNROTdLbGxq?=
 =?utf-8?B?MERHaGFqbjhpS3ZqN3V4NXgzTFo4cGNyc1B0ZVorY3phYjBtQ0dnbTM5UUYx?=
 =?utf-8?B?NDFDTTJ3TXJmTWpmSlc1TVYwaGVhRkVPOWhHS0xpOVJlZWlzWXo1eUNoQlFj?=
 =?utf-8?B?cWNUV2FLa1VrdnYyVU5id1ZEWGVETWpCWk9hbWFXeHpGRXNFcWZCSXBQcWt2?=
 =?utf-8?B?YyswbTlMSDNCSXpoUWlOZzZMTG9GSGU5Q08wK1hhYzMyWmdlODkzSTVUeEdq?=
 =?utf-8?B?dW5ZOFp0QUh5SlloakxpL1gwTGwxbHZRYzcyaG9sV0hxclRqdlRUUjVKQ3pk?=
 =?utf-8?B?V1JrcU53dFUrT1V0TEc3d2k2ZzZ4SFF3MFpQWk9nUWdmUStEekZyTVJoTzQ3?=
 =?utf-8?B?ejdiTXVjVk5ybVp6KzJmMTduS1hVb0lFaXlMRXA5dS96b25yU2VzalRWNnFP?=
 =?utf-8?B?V1lpdG1VWURTaVNmTnNiSEVhSnBRN0ZSekpTTUpQSkRWSExodFhEVDh6dk9a?=
 =?utf-8?B?ci80QjFDb3VTdjJJSlJHZ0Q1YnJULzNneWE1dk9ZSGlLS25uOUx2QjRSUWtm?=
 =?utf-8?B?cUFNK2Q4b0R2RmR1WWsxV1RPWnIzZzdSREZNL2tPYzFrQXl5dWpRZStsUXlT?=
 =?utf-8?B?emtGSUg1aXlkdEkrSmo2YmRid05tOTNHSjljL2djRHdKUU14eXZRZk8wT1NY?=
 =?utf-8?B?dHZnTlMxY3poSlJ3NjhBdkVCWlB5L29GMUVjaWUxNTNFUmRqZDBxN0VqRWF0?=
 =?utf-8?B?eHdtVjIvNTdEUDlaZmZubjAxUE9NcFhzNkpleUNKT3J3TDRUa2FNNzlPSWhp?=
 =?utf-8?B?dWRXK01aRzU2UEtEamEya2hKRkxWOU1VQ3hlL0YxM1lWQUUycHZDZEU4U3gr?=
 =?utf-8?Q?bfTF/XuyCpLg5odAuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e62a949-9ec0-48b2-c888-08dedd13f31a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 17:11:28.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf/JatiEvThmxxizpNypxcWMqLeLF5bDBN0SQdJvUKlvueXbCyWlohw/PFte6rPcJ5LkR8wjAud9VQ0Ed5ym3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9643
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



On 7/8/26 02:27, Guangshuo Li wrote:
> amdgpu_dm_connector_atomic_check() checks whether the old or new
> connector state returned by the atomic helpers is NULL before using
> those pointers.
> 
> However, new_con_state is already dereferenced while initializing crtc,
> before the NULL check is reached. If
> drm_atomic_get_new_connector_state() returns NULL, the function can
> dereference the NULL pointer before the WARN_ON() check can handle it.
> 
> Declare crtc first and initialize it only after the NULL check has
> succeeded.
> 
> Fixes: 1e5e8d672fec ("drm/amd/display: Avoid a NULL pointer dereference")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Good finding.  I'll get this applied.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d3a8d681227a..7b040fd7e3fb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8640,13 +8640,14 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
>   		drm_atomic_get_new_connector_state(state, conn);
>   	struct drm_connector_state *old_con_state =
>   		drm_atomic_get_old_connector_state(state, conn);
> -	struct drm_crtc *crtc = new_con_state->crtc;
> +	struct drm_crtc *crtc;
>   	struct drm_crtc_state *new_crtc_state;
>   	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
>   	int ret;
>   
>   	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
>   		return -EINVAL;
> +	crtc = new_con_state->crtc;
>   
>   	trace_amdgpu_dm_connector_atomic_check(new_con_state);
>   

