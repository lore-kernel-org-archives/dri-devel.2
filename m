Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B51D606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mrtZ7xNE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4DB310EBEE;
	Tue, 20 Oct 2026 14:08:44 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4FC510EBEE;
 Tue, 20 Oct 2026 14:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERq/vJ3gC2IamX0mZcx3uGZu7vRxOxTUYkNTdgQZcsSYCbIyMZ1ZXLP2g3+EeA3NSa0qe51OHuG/MZOyEYMWjh4RqPk6gM+B5MOn8tRjs13jxfWtUJ0pLkulq5jXX3ofEpid8EKBrcPj1gSv8r6X4IzOs6bJ65OYAPdnkx+bxZ8mbbe+LSR5C0J7chInxGw2wjdQRCtsizkewjX4MK/SrkWPXw8U6jLizQOLiqfI7xN8zxB79ib2MrhfirE0OFIzg4Z10cwsXMuRlu5xnXBZ4YrVQucB5VGHNmv7EqeLvOFGAQjaQnGSxVY4HA6VVwSSDSRHK6NMx5wyEj+9kNYd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsGgXtMC/WaDG84g+ZERm0RoVskNpyz8dig5z//dKP8=;
 b=a3dsUn6Yy3GmsArw85LyjXw6WVA9YuTUgm7ApKo+YF5RpOb1O9gNtmqQclb6tXTvSQNlIfbAULgDI1elXNEDWSJduaQ00Ubip0JWpwsccVsfBv+9yxIeQIjJ1iGDUyiHOYl53upbGdJp2UCZakoJ+QBAAm6w3RPvp0QZQAlkO9gFwFtwZbrOe+Fv/k9VZ6jsyE/kFyidc5BlbnqhLVkJ02nZifLc8vEJWSj/OutqvBZB8K2+MWrhXZSUe3plma2icphIWCwJamZRXk2ynyhcgl+Ipijt3tNcPk/t2jbJ5oLyIgehmeNEuHrfpq4kd+ebv8+wJ0ZLygHr8VwQ+hJuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsGgXtMC/WaDG84g+ZERm0RoVskNpyz8dig5z//dKP8=;
 b=mrtZ7xNELRVsq4Tm/D8dqzyO3GajzMVH6Ii0oZ2DKkADLDDxTFk+XA6+B9nRcq0wfwCRsbT+n6RhrbjEU5i6Qhy8SEdCf1pHszVys9myc25ojZM55qF8T6HL/gIMyC36ep2B9AtCsfpbQBNKMJJKf/n3PbjTZiSVr2jpWKZYL/o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by SA1PR12MB7368.namprd12.prod.outlook.com
 (2603:10b6:806:2b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:08:32 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 14:08:31 +0000
Message-ID: <95d198ff-97c8-433d-81aa-290cf9e1661c@amd.com>
Date: Tue, 20 Oct 2026 10:08:28 -0400
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: Initialize missing TD-LUT programming
 inputs
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: austin.zheng@amd.com, jun.lei@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, alexander.deucher@amd.com, aurabindo.pillai@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261011074510.2495683-1-thnkslprpt@gmail.com>
Content-Language: en-US
In-Reply-To: <20261011074510.2495683-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::20) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 136bea24-07b6-434a-9a3a-08df2eb39f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|3023799007|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LNK62IBljeUbIZVT2bxLS7MRVs+OAcA4nOSQlBL4xzKlLh+9tl4KGbHbwMYvLZcfhbaBIxt3Ghr9i8012DRdsn7+8g1upSCk2k4QUvCHPxCP1M5H5Kn9b7rpvMZlgf7fOhohHpD0pN95WxcdHMIetotCFnPw7wmdBWCXGy2D8mO/I9X3t41QP3ZfDgsDsj4rLtaXqARUxYwh7DFh/EsW8vWz8/GtXZ2wYjhow2P4TQxgomtWFutQZHLNUQkTfpqi29aSU7d6mOAQRafSUhcW/l2d9wVYk8EY3EsxDilO2CTkllE2HMjmHbJ0887GFqi6K4r0mOHTKfZdab2Z/jbz8YoZaiCJSr/7lluG9trbyQc0/AtIyKHucHrdvMU9gB1O/Ig72I4Gs3Sz+f2mMaQt46jrdCnvxqrs/ZzsvBAewdRJPdNbzNJys4crhdNuJ/HFneabJjvY45DBcDH5QJV9D/TGOytP9zuIrOhBQzCDEjc5VyW6f6z9H0/I941uu5C1f9siDYdZeCCcnDupgmRuh500CoqqBla3rHiigxztAeh9mv5UQgNf6lBa8hSbvhBK9CYgifTd/i0eliQtnNzfsvkINYHJ9trTWeQTaLTBAs0Q4OHe3iHBLICro5qDwHVJK5xdrxsr052Ix89gVonj/UwrcsQ01Bh42MQFqmUwNRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJ2Tnk4SXRKa0JxUTZpK0pwWkM0SDAxczVlcDdNNXpNb0QwWjhXUU02TFh5?=
 =?utf-8?B?eWxnVVQ4aWM0Rmk1V09tT1EvOVBpdXk0QkppY3lYelBiSDB1dVRhUEJDdjNq?=
 =?utf-8?B?anliK1VWd0trN0VEbkVqWlp3c0N2SVQrcGdBcWEvbVY4c2pmM3dsT3JtY2Rq?=
 =?utf-8?B?aGdieWRMbkRsaW9HUXRkVEJ3bmpKeUZyZHJIaUZSd2FhOFdWRHdSd1MwZ1pS?=
 =?utf-8?B?TkRoaTk4Wk56bFZKTWJTZXhQdXBScTY1Nm54NDhpTVFFTlYwcnJIWjBMQXU0?=
 =?utf-8?B?elVJdEdwOVhWRVIwMUtlVVdzWkxsUFJmSlR1K3QxK2hVVkVwZG5EYjZxREFN?=
 =?utf-8?B?elc0TjhuK2hRdzRIb2NVcnFzZlFYR212NjB5ckpvTytWVXVhTTE3THRHZ01J?=
 =?utf-8?B?QkErblNDY0tuRGZPY29CWDFBMjJ3Y0l1NExnbDdUTlQ4SWN3MHN1eUFRTU8z?=
 =?utf-8?B?QnV3c09pSGFTUm9FRmhUNlc0azVOQjJJdnVkRE1PWnp4NE9iZlgya2paQnpU?=
 =?utf-8?B?Um96V000Y0kzMHdrNERkdHNHWnBJbGZORmttWnpNTDcrRGFIckxaeFJNek5B?=
 =?utf-8?B?ZmJjM0UyeDFqTU94N2NsSGhnNTJjZXZpNUZHMVRDb3lZSGRXQkhiTkdwRm1v?=
 =?utf-8?B?YUIycnV1OGNSZVBJVGNqYlBsc0ZrcnJtZXgwRFJ1UFlheGZYM2VvM1lDdG9I?=
 =?utf-8?B?QUlYRjRXNlhPRDh0NjVtaXBhMGJscWtTc3Z2SERzZ0RYaC9ua2dXZHo1djdE?=
 =?utf-8?B?UWVsOXpsZ0xaQ2J2Zm1Fa2haeGZQMjc3dVpXK25GcGhBeWp3RVdGaGJVR0p6?=
 =?utf-8?B?ZExFQ05IRjUyczl1MzNuaExYZk9PNUNWWm1VWGJjK21wdFVObWNuRDlwVE92?=
 =?utf-8?B?WGpOemZHcHJpNWN5QTlRbUtXbTdVaHB0dDIrcW1MazJrREFYUktwd0JiMDU1?=
 =?utf-8?B?S01uVDV4Smowd0F0ckNyZ081NEdQSjk5SkZ1MDRXWVFtZmwwK0hXbXBnK2NJ?=
 =?utf-8?B?NUEzUTBpcm43blAxbW9TdGdCR1BkOVZuc3BsQ0tUL0J6RHV5VjlEQ0tLZG51?=
 =?utf-8?B?NjErV1gycmdTV0QxZUFjbW1tNWx1Zjl5NGFVWmtDaytxQWZISjRBR0d5anlP?=
 =?utf-8?B?QmRlU2RPc05lRDJDcVpFdHNLZ1B3WEtNaUswUnBRUjYzMjdkU3U5a0JkWHM2?=
 =?utf-8?B?OVkxK0FSWG1vV256dG16SFYwanRFbkV1SUtlcFlmdEhTWWdyT3RXcXJhcEhp?=
 =?utf-8?B?cXpMbHNEQVlxRHQwbmU4Q1pLdzN4S2x6WDBtbnlHZEVKRFo1MDlBOFozdmNK?=
 =?utf-8?B?akxXSkJRY05XKzlVNjNCaFBCdUJpUWRmTjVINVNrbE5kN1hNVHJJQThtN1ZC?=
 =?utf-8?B?Rlhyb2JFdTJ6SGpNdW45WmFWT0N5VTMwb1FKdEJFNlBTSW92dWF0MjlxSVhM?=
 =?utf-8?B?KzJmRi9jQjNNSHlaUkEyTEhjSTNtanhoTzFCV2N6dmtZTERidVlkV00wUEc4?=
 =?utf-8?B?c05KYlU5LzRtVUlWazY4SWtnNHNCcVh6T1VFcEI5eU1MbXdzZVI2dlJ2MjZL?=
 =?utf-8?B?UHU4dExuMlBnT2dJWmJURk05VGh5bTRibnQ1aldXMEJ3TVNNek1sbTVkc0Fx?=
 =?utf-8?B?b2ZGeFVTNlVibTZRTGxHdlA5Ui9hZFFCQUFDN0VJVDE3YnA2SG9ZdEhhNEdV?=
 =?utf-8?B?YU4yYTVaeXBObThYM0NOQVhucDlWbzA4K3ZjUjV4RVUrU2VtRGNFR04zTDVR?=
 =?utf-8?B?MHBKS2Q2bFlpVFFhMWpJYXNpVXBkcTAxN2VRRGtaaUc0MklWOER5aUVHRnpO?=
 =?utf-8?B?NlozdUJyaXRoa0thMUJhb3FEK1F0Wm5COWZOSDh4N3FySEYzcGd3L011L2Ny?=
 =?utf-8?B?N1p0ZjlhcnlkWjZtK2RpZVltNXpaNHRyMVAwVFJBUFAzRDJXWkZDb21ES1Bz?=
 =?utf-8?B?blVCK0t6aWkrV0J3bWVabDNtNWJDM2x0SFJvREkwUUdXUnpiMmVGaXdRbitL?=
 =?utf-8?B?T25Ld3dOUVFpKzUyalJGdFI3Z0pYcG9YUEZvZ1MvZWJ0QVhnendWZjdEQWxS?=
 =?utf-8?B?ZlZKMENJa1dNU3lURm53U3prTkVxUEd5Z2JDVStXQ1VHR085OW5qcVNYY1Zk?=
 =?utf-8?B?TVh2MW1MeEY0Ump3L0hwb0t2NjZCdmk2dXJYOUcrUFAra1plc3ZIdzNKUk1S?=
 =?utf-8?B?emplcDdndDl5c3YwQjZraXNIWXVLUyt0dG5SZ1RXQS96T1pScmt6Y2s2U2RU?=
 =?utf-8?B?a3B1ZlRoQUx0N1NISE1RQ204TUVaWEFFVmRJSDg0bFd6NUR4SkpvQmZ2Tm40?=
 =?utf-8?B?L3VaOVNmY3NySWtNTWNSRkVYQm5OK25KKzZDRm1zcUhvNG0zRHpLQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136bea24-07b6-434a-9a3a-08df2eb39f4b
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:08:31.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfy7UnC79qRLfgwRDkyHcGh2NWWbvaB6PscmLBgJEj2VHAcKba+ZbqGmhklLb/xJi0hRB7A7xn75vVnwgez0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
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

On 10/11/26 03:45, Avi Weiss wrote:
> dml_core_mode_programming() memsets (clears) its scratch structure
> before calculating TD-LUT settings, but does not initialize
> tdlut_mpc_width_flag or is_gfx11.
>
> Both inputs therefore remain false regardless of the plane
> configuration which can result in incorrect calculations.
>
> Initialize both fields using the same sources as the mode
> support path (now both paths are aligned).
>
> Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

The issue sashiko found is also a real problem but somewhat
unrelated.

Harry

> ---
>  .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> index 72acf12e9251..0ee385e8ba5f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
> @@ -11074,6 +11074,8 @@ static bool dml_core_mode_programming(struct dml2_core_calcs_mode_programming_ex
>  		calculate_tdlut_setting_params->cursor_buffer_size = mode_lib->ip.cursor_buffer_size;
>  		calculate_tdlut_setting_params->gpuvm_enable = display_cfg->gpuvm_enable;
>  		calculate_tdlut_setting_params->gpuvm_page_size_kbytes = display_cfg->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
> +		calculate_tdlut_setting_params->tdlut_mpc_width_flag = display_cfg->plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
> +		calculate_tdlut_setting_params->is_gfx11 = dml_get_gfx_version(display_cfg->plane_descriptors[k].surface.tiling);
>  
>  		// output
>  		calculate_tdlut_setting_params->tdlut_pte_bytes_per_frame = &s->tdlut_pte_bytes_per_frame[k];

