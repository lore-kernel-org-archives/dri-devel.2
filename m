Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A5EF94CB4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 433B610E232;
	Tue, 21 Apr 2026 21:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UeRxlpKX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBDD10E27F;
 Tue, 21 Apr 2026 21:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKasfVwopBVNlXCcQaqWhR2SPjR645pxFL8jRTeRtnUYyIPdJb0cLq/5LH59WaTK+KeKPrmrnVvEUzGjdklNBsJFkW6aHOKLG7FHLvz9zSHe7GgqdtxXiCZMd5jIG3MWvxKlCQwCncYdXEJ3izfgIPRP+E4FmeENa21tP0kB+oTX+ot3KNxnBwDA6CWLGw5Qbhn8hDYY6igcCxAd7feE5PfKznjqOD/gbMVpijvcMpIVkHlZbiSLkqTq9e92Jr5YqQEoPpdq0L86R6Y+D+1XySb3tCC03LtlWrKceYZJe67qTm7GCZGSOusYb/k0T+7eQiRS3tSvL8W8UGiMT5rU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzfHTjdGWxLV8ExiWtnzOD0nZQ7gUI3WabNsqMXeTCc=;
 b=ST6P4zx0VucxDRwyCX4u2NuAXfDOtuaui/m/RHWnbJgzgxVC2NfgDIKKE1cit06YOqCVhWR6zXcJpb0OCQmrSrcJqaObjiqmhmrheN5I/+H6UUsUd+z3apUu5az6+PHCdXb51d1shpCx0qPsF9f6A/8unJZ+nnlewj4Ity2yQAyWbUkMzS+JeSM12ArB9TGDZL3et5jA4Ja9qiO/vM0AYkV62xnHKOVwADeSxJupptZDxiPyizpfYUcnx75o0y4gYPF8Wwg/rBKwsGxHZZG1axD8zmwkQkHFQaDUKDvKX0sjRdt0SN+9sHYRk4Z6CpLwirfem9LidOlo7SLvPsYQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzfHTjdGWxLV8ExiWtnzOD0nZQ7gUI3WabNsqMXeTCc=;
 b=UeRxlpKXM5eesyY5ZzP0l8KaKByBv4PNl0YIiMoSW1hW8FRUHETL1FwdSUKz9hKAkEC3YDqCk+2hMhJKjArMMrcye+965RzZUN+di8o87+sVxk4DReoVgjJxMQBaIAL7odFUmYkpyRjRku6NLRzw0g6Cj4zwb+M7cGn/kT/06eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:12:42 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:12:42 +0000
Message-ID: <b0e0af19-a7c4-483c-8e40-4ec1cae01b9b@amd.com>
Date: Tue, 21 Apr 2026 15:12:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 8/9] drm/amd/display: Check actual state during
 commit_tail
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-9-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-9-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ce2bfe-1916-4258-aad2-08de9feab9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: bA3e7IGZ+Df1FfPZWBHftzgVYMEbQUx1H7ZS3/erTbVvWBzS9jEhxO8BCnbWH7aRjEdpN3MJIj1yN1K7l5asmL7goXQqeumXdEQfxiKgRrnVQukbcnAM8A5JO4FUVVIIAjYboQ3lM/jZYTocxTGKbt5MVM/4sjwwFqVLCnLxj/ESsZlf+nZK/GSyZO+jjOiyVUMMx2moC5kls9zkVeOUkxI4wKqJzAgUq16T6K4JOsT3fQyU0n+rE4inxdVODrsdRb4k7wA7ki6HQq7ikWYcSfLapgkDkRz1x7I/LA+k0f2QTtWjk8CHZaWmRpkyEnxOdu/tZg8v9iDiAu4o8Cdc2dUfsoJ6a0QNbDdso2lgt4DdHp3j/TyJ1upRysByg26F8oZDa/FtsrlqTc8WNJBrzyUpjj2xcEhXXKjFqFK4/7t0rypMgYQuF2YLRscyqCsZy/aC+cnEDvaZ6aln5Sun13/Cj2tqf2k6rLkOVYq8No/RsGuAkUUUBGN6Jar4KwLTOOIYeO3mCZEl29j9Vb+NQkDYc7E0lJ60cUtoSCFnF2SRMkqnuI35Z4+Lv9wI37R5aTTFxxrm/raz1bJAJwCtK2Nv1plCY1RP6gbE7FCW3UJZNABg5q6a0CwasiDkXIh/Bbq5h7Jpg4DyYfMTr+H5lTMq+aSC3zP8yLQvBU2P5FNKG1rWhJdbZzb+RA/5PaanTQp0qIEfC+ODwxaZdt2dDKVHsrpf0MDYc9//xG21RQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFicDdVY2xmMzV2Z0s3SkRTdTNjQk50OG13bDRKVENZRy9mKzZwTlRhczBp?=
 =?utf-8?B?K3d3dXR1NUo2ekxWbi8yZnU3VUNmdzdFSXlaK3d0Wi9LVytPb1RSdFhmKysr?=
 =?utf-8?B?LzhTaG5oTU1hZ0xIUmkyc0xNc1pWcjlObnppVlc2czZPdjBNT2ZMVnZvMnBp?=
 =?utf-8?B?NCt6K3N3ZTlzenJ3NXZIWTh6VzNzM3Jha0FFSFZMVzYzZk03SG5lTE9QSk1n?=
 =?utf-8?B?allydk8vMUUrWUVKSThhSTV5QVhzR0tzZU5CNU45VTErWHExQXVyVmNqVTU3?=
 =?utf-8?B?TEREQyt3Ky9WRHRkNGJyaGtYK2U0ZW9KS1QrSXRGVVVZMnd2NlN6THlrMGdH?=
 =?utf-8?B?Smd3Z25oZjdwTm85QmlGTDVlRDZ4bzdOc1ZJTDRDTE12NmpoVkxiZldrQmhl?=
 =?utf-8?B?czV1eGJzaGxEcDRJT0tyQWRKQW9FL1ltMm40THRzOG5QUEZiMEY1WTg5MXI0?=
 =?utf-8?B?ai9JUXVhVEdKd2FsYk9VcEdISG05dVlXSVI0OFk4NXByNGZWb2JSbjZnek5S?=
 =?utf-8?B?TTR1MlhGSU9VbWVKTXFuenNzZE05NXZGY1k5OHpHSFI4WTk2bmVWQWRBZUxI?=
 =?utf-8?B?bk9sdHQ5WFlOaE5LTGUvalR0K1drK3hDS2NZZWNtTi9CcWZFeCs0a3hzTjA4?=
 =?utf-8?B?NUZ6OC92aXZXMzVIRmhRZjBKZ3d2UEJUOVBXZ0tJWldoMC8vc2FjbU00NjVx?=
 =?utf-8?B?NzJIYmFTcUNNVXJ3NW1ta3hwdGNBL1poS3dlaTArUjA4azk3UDc3TGdTM3li?=
 =?utf-8?B?WCthbVJiSWhpb2xzcGcrWE5ZRXlGYWlYSHRtZVpCVU01TjdRaTFhNTEraTVa?=
 =?utf-8?B?bVlRazluNThNd0xtWEt3WWhNVVhpM0QwaW5CUmx0NUVtTVZSbGpYRXI2QlBz?=
 =?utf-8?B?TEVIV09CNnVMM2ZXZ2NQWUxQNEMrakd6ei9KV0VIWmNoOU9OQXdjdEgzb2JP?=
 =?utf-8?B?cWYrcnJxb1U4NjZ6K3hhS1d3dXp6TjFsb016eUpSTTBqWm1JekhGNDdtWXIw?=
 =?utf-8?B?aGZsS1FTWU8xNkdpVDQxNDVQdHdJa0psMWpwSjlFQk52Z1hWelY3UjVIZTM3?=
 =?utf-8?B?T0RaVkNqb2VJT0NMM3kwZzFhT2VrcU5Nb1U3UksyZ2FtcXBRMHhsVEI4MVEw?=
 =?utf-8?B?d0M3cy9aVUZjY2k1bjJkU2RQT3MzMzlpM0VlcEQ4MkVPdFlvbXp4cDh0RTlY?=
 =?utf-8?B?eGs3YzJ1WkRTZ0xWSGloM2JMemRmOWJFMjgzbnNTMm9ndHpvck0vUnVlTVlB?=
 =?utf-8?B?UEtsSWh4bUpMVUhzcFdnSW1pRE9hUnRNRHh4UkxQaGhJZjlDL2tYdDZQNTVh?=
 =?utf-8?B?SGZjekZqOWR2bzh2eFBDMWJndFd5bXdmWnNBVElLSHhYV2QrQkxXZ3pQc2I4?=
 =?utf-8?B?N1VjYXhYdzd3QVdNYlhHWENNck12bEZmNk4waGlJYXVKT2lkNE9YQ1pnUEda?=
 =?utf-8?B?dnBya09yQlErM3cxWWZsOUpvWE5VKzRDOFZjSUdEMENmbXdNVVZ0cHh1eTVY?=
 =?utf-8?B?eS9wZk5HQTF3QUdqVmlZMURCWEpiUUt0SURrenJwMnRlUzJxendlWkxjVTI2?=
 =?utf-8?B?TkZDUkxiQ2EyOFhJOGdkQlJiUWw0akIyYmtWNGFnV0w0R3g0WGpiZVEwTTNn?=
 =?utf-8?B?WkZlRWliY3BKVXhCQ1dDLzlJMDJoaDFJQWl5NWx4WEdOUkp6RVUxcytOWjJa?=
 =?utf-8?B?bVBwSENRVDhuNHQ3dTFLZjltTlFXcWJGM1VCYm13MTdKVG1KVTBSK2FYZ09W?=
 =?utf-8?B?MlB6SnY3enBKRDN6b09GR1J4d1NjdHNCYkx4SjNLajdZVTFKWVZzdDVNUHRz?=
 =?utf-8?B?YnhDUUF4SndzWGt6RGNaMUVUa0ZqSnZKbUZFbmt6VG9Kd1lxQ1BuakFqWDFw?=
 =?utf-8?B?TWNuZmxLMkF3ZlovQ252NzRUZnpsenlwU1hyaGlIMWY1MEF0WGV3WmFKOUNE?=
 =?utf-8?B?L1VDWDY4R2hmdnloWktiN29ZSjZxdFA3ai9kejhDRzVNM1NiZG1pNkJ1ZXF3?=
 =?utf-8?B?MzZENGJscVpCMTNNaG0zc1plVERNVVU5dFY5UlFSbVFMKzVIdHY0U0VxN2Rx?=
 =?utf-8?B?cURIb016eGpaS1NEb1JJL0Z5RWVRVFIyaFRMNHNSNFNQYTIwekJDdDB6WUtv?=
 =?utf-8?B?dEU0RVY2ZURjRER0MExOQTdkdUJndmp3SmpZT1NSSUZwUEluSC9BN0c5RU5S?=
 =?utf-8?B?a3J2Nm9qb2ZzSzZ1Njk2aTdOWlRlR2ZZeWMwd1VOMktlSnZ4bGh2c0p5TDlJ?=
 =?utf-8?B?ZU1pa3lxTEJ4NGRDVDVZcFFHSWlvalNTUTJTMmJNK3ExSU1oUjZHank1dnFW?=
 =?utf-8?B?YzVCanpiYUhJbjdPeDBjRWdKeXVMbG1hME5IVVdzSXFIMXZKUlZKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ce2bfe-1916-4258-aad2-08de9feab9af
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:12:42.1217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +93TMldRwl47ldHsrYAn/0T+zqQl4ZWMp1hlB/B+L5pB1kAXluhJAEVmn83GQZmnPomfX+2OLV+PaCR6DZiBFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804
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



On 3/30/26 09:34, Harry Wentland wrote:
> Previously we checked the plane_state->state's plane_color_pipeline
> client config when determining whether fill_plane_color_attributes
> should run, i.e., whether we had a plane color pipeline and should
> use that code for handling CSC properties, or whether we should
> look at legacy plane encoding and range.
> 
> The problem is that we also call this during commit_tail, during
> which plane_state doesn't have the state backpointer. This meant
> that during commit_tail we'd look at the legacy plane COLOR_RANGE
> and COLOR_ENCODING values and overwrite what we pulled from the
> CSC colorop in atomic_check previously.

A nitpick - should this patch be squashed into earlier patch to address 
the problem earlier?

But that's not a real problem since the entire patchset will be merged 
together.

Reviewed-by: Alex Hung <alex.hung@amd.com>

> 
> Instead pass the drm_atomic_state in explicitly and check that.
> 
> Co-developed by Claude Sonnet 4.5.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index a0d4ab4590e1..c3c6211d15cd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6006,7 +6006,8 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
>   };
>   
>   static int
> -fill_plane_color_attributes(const struct drm_plane_state *plane_state,
> +fill_plane_color_attributes(struct drm_atomic_state *state,
> +			    const struct drm_plane_state *plane_state,
>   			    const enum surface_pixel_format format,
>   			    enum dc_color_space *color_space)
>   {
> @@ -6015,7 +6016,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>   	*color_space = COLOR_SPACE_SRGB;
>   
>   	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
> -	if (plane_state->state && plane_state->state->plane_color_pipeline)
> +	if (state && state->plane_color_pipeline)
>   		return 0;
>   
>   	/* DRM color properties only affect non-RGB formats. */
> @@ -6055,6 +6056,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>   
>   static int
>   fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
> +			    struct drm_atomic_state *state,
>   			    const struct drm_plane_state *plane_state,
>   			    const u64 tiling_flags,
>   			    struct dc_plane_info *plane_info,
> @@ -6148,7 +6150,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   
>   	plane_info->layer_index = plane_state->normalized_zpos;
>   
> -	ret = fill_plane_color_attributes(plane_state, plane_info->format,
> +	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
>   					  &plane_info->color_space);
>   	if (ret)
>   		return ret;
> @@ -6189,7 +6191,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	dc_plane_state->clip_rect = scaling_info.clip_rect;
>   	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
>   
> -	ret = fill_dc_plane_info_and_addr(adev, plane_state,
> +	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
>   					  afb->tiling_flags,
>   					  &plane_info,
>   					  &dc_plane_state->address,
> @@ -9984,7 +9986,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   		}
>   
>   		fill_dc_plane_info_and_addr(
> -			dm->adev, new_plane_state,
> +			dm->adev, state, new_plane_state,
>   			afb->tiling_flags,
>   			&bundle->plane_infos[planes_count],
>   			&bundle->flip_addrs[planes_count].address,

