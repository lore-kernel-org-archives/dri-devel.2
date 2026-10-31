Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854EC606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PZ1qCJ46
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB32112A6B;
	Sat, 31 Oct 2026 02:17:14 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E961112A2B;
 Sat, 31 Oct 2026 02:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ulqfubuabl3YUA6TpOC/fmQN9XoAdzWwpeP06xTU2gVIdO8LtDY+aTN65TqIO5eOU241XIMRRbBrtoKQeaFvBGT9xxKgE8FaHLdxqXEbdzGHe7jSiIniQeUY6DOgl7cF6TbOo9HbrAFXn4CUliM78fWCs2Yh8ZLJ7HJT4xi8mry1TW34LuHQGZKUvO6pfGluqOgcw2Ffyc7CYkIr1/vWyD9VfIwwVuMrKMSnFt0pbgXvNjkwLqAzZwLXtm8GpUr/J2KzriiTa77Z7oG9mJyatdaSJJv4F2+YaF+d9s2vf72nsVQ2PaSpthi2XhjDmIMSQj7yAwDG051ubWeVKafTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ImO1VjA+otPTSpViii2nHBRztvxR270ZPGdI6v9FU4=;
 b=nBcu91Vp8uQ71irNYtLqqMpOwokeii8NOut5Ec8+1Nlk2KeNdu/65WuyGcc3fjpSjY5V8/HJTqPC4RZ+ieRpgYyWx0KvcxpEfpWjZL5NQ/6LqMCd2bpjxvK9k6aHPSKsFm6NAgxAMZgfbyWBjQCM28HLms0zRiP+W1n3C3fqi+VVQN7od2ovGZi47ZUV3VSTruU3J7MU+YHJ+z7K0dWZUhRNlf0av+D8bsw9+uv4jSa0UStzMo8NChTdY7tE76+0pplsqYkAxzl3Uado2r98u4Nw9UmpFW/ZEBc+vzmvHindSiWz9VqsUsL6cCJitHfeFTBAapq9ufJobZPB2Id3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ImO1VjA+otPTSpViii2nHBRztvxR270ZPGdI6v9FU4=;
 b=PZ1qCJ46sLCf6KMxB1hkpZ08NlMDRNvufA7prJkEohVkxsc5Yfygl+I6AuwNLdmpCD1wi2eO9uvtTLX7XffIUiYlYPgfIZYchiYBJrztOWtYIFLugnRy6twWd+rRtQlesybT7xY6IimkzO6zaExfeOFG0Snd22R45sob930Mgpg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by CH3PR12MB647349.namprd12.prod.outlook.com
 (2603:10b6:610:365::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 02:17:05 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 02:17:05 +0000
Message-ID: <369b53b5-2380-4ca3-9f10-db7f77eeb107@amd.com>
Date: Fri, 30 Oct 2026 20:17:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/display: Fall back to the native mode, not
 the first, on eDP/LVDS
To: Hugo Sales <hugo@hsal.es>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
References: <74c73b6f-a6b3-4652-8da1-b5c46ae58809@amd.com>
 <20261024163347.2413649-1-hugo@hsal.es>
 <20261024163347.2413649-2-hugo@hsal.es>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261024163347.2413649-2-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::11) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c5f37d-d7c5-42d5-c989-08df36f50f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: okJOgNW9ujz/z7ykF6bMvBAsdWAhz2anLpcWF+L1zngS7NoJ8swPkP8OR8dGr+3aQKDT0IsE2AaHKrtWiO+0fJb8FJXRdzBCmKz5inc1MNtwenJSX9VkxAZN2WCPcrW8pin7Oc++Zev4itavkZqDquyDKNXw6jZMTEtBB5ItVuMZvBMAGRLN/L1A0IT4N2qtMEznc9Smor5Ye2Qgj+IBtYGl3z/IkZRh6E9LvXxf77D7Wp0xyKymA625wqqOweOkCgCvKMyRIMKgmVGXu/pgjs50/ZibSb3FCuokYEFy93Cbv7JOXeZyU5mRSDuvdc6s643/pvYzjp3ufMCVoAB3TMY7wtyPF32n9A06PNAsSGd7gx2tiitSKm4w+iiEuIK6xia+Kgjuk1HkMzxxn51FfzRYXW4/qS7Cw6BbnFYlaYjw/wbaWfTn/W5Unlno86KHXqP17q/wo8PrxX8acfxGLszxcWuuw4i/dCRbwLuNHrVCnkhOP7adok0Ov3Em2SwinF23kXz1zakLbkeM0RINevWmvf/cLvzcXr4mDLBFU21SDrxIFYTv6Xa+CQBJNb9dkQ8rr14Z7IY7Zw2bPdWdhVtjsVzoCC9rfVK+9P5o360=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxEeWtUKzBkS3hwVnozRU9JTnpJZXJGTGEwLzBLRkREc1B2bHdIUDlmbTUy?=
 =?utf-8?B?OXhEU2xxVWZnbnd2Ty9YYlhNTTlndkVGOE4yRSt5N25DYTlsMUtWcGE2bWps?=
 =?utf-8?B?RzE2UXBYTEcwWlhrNytuQk1WTytxTUh0YnhtaXljcldKMXpBQ2VtdTRvaWFl?=
 =?utf-8?B?Qm1ZYXYxV3dObzJkQzg1MVlnS3pyQU5uNURNTE82aW9IckFqaDZvK2NhTTVD?=
 =?utf-8?B?bVB4RVdkOW5iSmIyVXlUVWpKdGJYczZwYkZRZEwzWlBIZjZDZkk1R0h1VkFL?=
 =?utf-8?B?MExoaWdqSElxR2hrdExxSjVtOXN5ejExV0o0MHFEYUQ1TGVac0lPUUFVL1BM?=
 =?utf-8?B?M0RncS85L1o1NG9OTHBSQW1MYWkrNFBReElwU0tCVVloRTF3NGdZSk02MERt?=
 =?utf-8?B?TWMwR0Nvazl5MjQ0Z2lzZzBSa0RqRHFXV0pwYlp6SElwQkJUdk41d3grcytv?=
 =?utf-8?B?UmVMSGxiUHl0M2YxbVoyMXpnVlZidXA5SFM3ZTVqUkp6ZlZtMHM2a05idnQx?=
 =?utf-8?B?ZTNLcGFwNkY1YndMWjM2ajVVSkFBRWpyMnVXSG9ML0tZUlBkQm4ydTJlOXAx?=
 =?utf-8?B?KzgwMGFYYjdXOW9YSHBjWVFUSkJMRGVFQytnYTZCMlp3ckVRcVk2Zndna0JL?=
 =?utf-8?B?Q0E3YWl0VFp1TmJiSWNqd0hjUWVDRzJZZGJGNEh0bzgyL1pHNVZEOEVpRHlD?=
 =?utf-8?B?YlpSdi9XcWV4cjNzRzFLY2hUWGV6MEJtQU1uMEZ6WXAxZ3NwL2hiWEN4eTZ6?=
 =?utf-8?B?TWYzakFabFo2N2tPQkhqbUVMc2dqRXJjSHFwK2w4aGx3UE9wcXcyWXNhRnhC?=
 =?utf-8?B?UWVDQmJNVlhlSElqSVBQMnB5OTNGMUN3aFA3Z2VwOFF6bURuTFk4SHJoaXIx?=
 =?utf-8?B?b3JWbkRDc0srd21tOG5GZFEzNDBlUmU1cjAwRzdvRmJVSE1ZZVkwTFRBVVM2?=
 =?utf-8?B?RWVDK1FBeUtPYlpueEd3WW9WQzNPb2EwV0oxVC9MRkd3d25rWGFXSjNRTkhx?=
 =?utf-8?B?N1p0WnJGRisvTDVXeHE5WjlxY3V3V3FJU3NxN3pCVng4Rld6RjZIVUhNQ0dG?=
 =?utf-8?B?Y0VmSmN4ejEraFBlUEtQUmpHTHZuY1lnenZsMW5rRE55cGdneUVCeDRKUktr?=
 =?utf-8?B?TWc0OEJJb3doa05OR24xeUJQalhJdVlVdHJXb0JVeEdIRWtFOEVWZGkycUlT?=
 =?utf-8?B?dlNYUmx0WGVkVWNhNTB3NnpDeS9udTdMVk9nZ2kxVDFBQVZnMDhhRXZZNnZr?=
 =?utf-8?B?enRpNDltaHFobEYzSXNwdVZRTE1NWU80T1dzMWlXT1JOOWVub2p6UFB4TFQ5?=
 =?utf-8?B?Um1kaDlnVERYbVdyazhsSzVDcHN4Y1l1NmxnbG1Fejd3T29wQmRLeVFqZVk4?=
 =?utf-8?B?dUc3T1o0M2M1aU9TTkVhc1kzK09wdThsbjYrMVBZUkpidlRjVXVENzdOYm5B?=
 =?utf-8?B?UXRjNzZjTkNIMk1kN0tnUlYvT01BSXZ5REFybkh6TmdtQUZKWkFQVHdMZGw0?=
 =?utf-8?B?OUhiTFBEYlZ0YWhtM3R4Ni9tSUhqNi9IYjZrTm9EaDM4ckM4MXlFdWh1YlhE?=
 =?utf-8?B?S2Z2cVZsckRWT1lWTFQxOUxSSjFZL3pqU1p5RGpvQ2ZYR0NKbXJVSG1abHM4?=
 =?utf-8?B?UldxRmFLS0F6ZklPclRGRmtLS2QyY1JtZGZFQVZsb0doRHY2T0VTSDIzLy9k?=
 =?utf-8?B?aTA5Yy9Kbkt1VzlpV3RvS2lSZ1p5WlFxWVlLRU44QlBRNkx5eCtyZGRSbWlK?=
 =?utf-8?B?bjd2THBBM0dYZENLWHlkZ29rOXdBNVBBbndjV0NsUC83K052L3ArbEx3YkZJ?=
 =?utf-8?B?dll2cFU4VU1BalRvV0tzaHZoS3FNT3VpUzN1d0RCT1dtTmxwUVZrbGFKbWRH?=
 =?utf-8?B?cXdnWHZQYUtka0hzdEcrd0VDUVhQL3N1cG1WejJVeS9WK3JOVzQrQ05rSUJ2?=
 =?utf-8?B?MG9VSkdMNHBTeGxmU3VhYnNEYXVnMzFKdzh5amlwU1Z5SGtTYTB0NkFIaEpF?=
 =?utf-8?B?enJvMnRlVG12Q0plVmhlYWxqZ3lDWlJZSklaajFsZGUrckU3NXkvUjdMY1FW?=
 =?utf-8?B?RGpQVC9KRDJCQzRTT0lpYmVVWWNkSUhYWVdGL2tSeGlWcEdtUU5KZXcrTE9E?=
 =?utf-8?B?VnByT0J6dzdtWDNTSHVsMjZnbFFubWtzcEVWb1BDcnNDYVh2WEZuSHBpbXZW?=
 =?utf-8?B?bWF4T3htbER0dHBmSGRoUGYvWGlWQVQwK3k4cEZBYy8wWnE3Y3pucmhzZjAx?=
 =?utf-8?B?Ynppd0d5T2hBazd0ZXU0MDQwQ05KUWRyNXd4VGh1eFc0NzNyQlpzVU9YUmZJ?=
 =?utf-8?Q?GdF409w3CLs8FQvhSV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c5f37d-d7c5-42d5-c989-08df36f50f05
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 02:17:05.8025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDFm3C/nGU4vzbeEuxptW8BO/OIEj+MWdi9oC9kQBqmkl5v12WcWOqU9IwdfokBCY+XEFTDnTe56BoYDhGfNzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/24/26 10:33, Hugo Sales wrote:
> [Some people who received this message don't often get email from hugo@hsal.es. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, create_stream_for_sink() takes the native timing for a scaled
> mode from the preferred mode in connector->modes. After fbdev emulation
> probes with size limits below the native resolution, as it does when
> video= sets a smaller mode, that mode is no longer in the list
> 
> If that probe is the last one before a suspend, for example after an
> HDMI hotplug, the resume finds no preferred mode, and the panel is
> driven with the scaled mode's timing instead of its own
> 
> amdgpu_dm_get_native_mode() copies the preferred mode to the encoder on
> every probe, before the size limits apply. When connector->modes has no
> preferred mode, take a mode of the native size from the list, or that
> copy if the limits pruned them all. The list comes first because
> mode_valid may have rejected the copy's timing and kept another mode of
> the same size. Limit this to eDP and LVDS, where amdgpu turns scaling on
> by itself. On other connectors mode_valid can also leave the preferred
> mode out, and then the first valid mode is the right fallback
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5983
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   | 47 +++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index ded8e21897f1c..a13e3b641fd27 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -257,6 +257,8 @@ STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
>   EXPORT_IF_KUNIT(update_subconnector_property);
> 
>   STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
> +STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(
> +       struct drm_connector *connector);
> 
>   STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
>   {
> @@ -1545,6 +1547,51 @@ create_stream_for_sink(struct drm_connector *connector,
>                          break;
>                  }
>          }
> +
> +       /*
> +        * After a probe with size limits smaller than the preferred mode,
> +        * connector->modes no longer has that mode, and the first mode left
> +        * would become the stream timing. fbdev emulation probes with limits
> +        * that video= can set below the native size. Only eDP and LVDS panels
> +        * get a fallback here, since they take only their native size. On other
> +        * connectors mode_valid can also reject the preferred mode, and then
> +        * the first valid mode is the right one
> +        *
> +        * Take a mode of the native size from connector->modes if one is left,
> +        * since mode_valid may have rejected the preferred timing itself. The
> +        * probe sorts the list, so the first one has the highest refresh rate
> +        * left. If the limits pruned them all, use the copy of the preferred
> +        * mode that amdgpu_dm_get_native_mode() keeps in the encoder. It is
> +        * made on every probe, before the limits apply
> +        */
> +       if (!preferred_mode && aconnector && aconnector->drm_edid &&
> +           (connector->connector_type == DRM_MODE_CONNECTOR_eDP ||
> +            connector->connector_type == DRM_MODE_CONNECTOR_LVDS)) {
> +               struct drm_encoder *encoder = amdgpu_dm_connector_to_encoder(connector);
> +               const struct drm_display_mode *enc_native =
> +                       encoder ? &to_amdgpu_encoder(encoder)->native_mode : NULL;
> +
> +               if (enc_native && enc_native->clock) {
> +                       list_for_each_entry(connector_mode, &connector->modes, head) {
> +                               if (connector_mode->hdisplay == enc_native->hdisplay &&
> +                                   connector_mode->vdisplay == enc_native->vdisplay) {
> +                                       preferred_mode = connector_mode;
> +                                       break;
> +                               }
> +                       }
> +
> +                       /*
> +                        * saved_mode is only used for FreeSync video modes, and
> +                        * that path doesn't read preferred_mode
> +                        */
> +                       if (!preferred_mode) {
> +                               drm_mode_init(&saved_mode, enc_native);
> +                               drm_mode_set_crtcinfo(&saved_mode, CRTC_INTERLACE_HALVE_V);
> +                               preferred_mode = &saved_mode;
> +                       }
> +               }
> +       }
> +
>          if (!preferred_mode)
>                  preferred_mode = list_first_entry_or_null(
>                                  &connector->modes,
> --
> 2.55.0

