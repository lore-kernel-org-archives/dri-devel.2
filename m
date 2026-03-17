Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69219FF6E7D
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 20:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CED10E679;
	Tue, 17 Mar 2026 20:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JodJ0buw";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E427F10E356;
 Tue, 17 Mar 2026 20:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXNv6P7Mo3jI33Qybba1lWOjwcIKg0aW0c26izQGRp7fUaxFot30FsX16x4WQuOfao3Nbkd4/y8AzHzboG1Z2edY1ubislv56T5o6CdNvarqw2/sMIxTiH81NT/W4NfL4mp8JrX0qKyt0gj2RLD4YMWMzNB8VgrwqOCEffJx4D6LQ17hdpmcxNY64AIyr5H/g4fI9SeSZ0uSrY946xB4/YQcXbEBqgnCPdmwgfU8ihoTx25LVmD4RMGVGFXcb7+9zfozx2rclcDLsa2e4vI55vnViD4vpvfAL23YE/7kwQ91wW1y69FtFgyK5HFcWfkcCKC3rQlkNfetLc/M85W6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSHulbimBCVhl9AXN1P3mifDksbdUTzcKVK+EFijpn4=;
 b=D2e4u+BllO5lT8MwWmxjwLsL5TjXUnC9mEeF4RaNam/WYGio5UiexITr6igueFwUlDoNAY5FoHrMwOZqLmQjaMYtNC6ZBnztSsQ6rIF+VWvLq4i0MH0ghNjA49FbDpSPTdphKjqyY7Ir7lzYZIN+MxzITmu9TvYo+lbnlF81NYatGUADMHUtzQoVSPhO0ZAFqEvy4h5i2H7iTWGIJ6N80UJvfnE8BQJyeS4YGN3Z6y8fATyKj/Q9Z/DH7DXUk/6AknarsG/juye+EgaIDIKY2nyRI2Rb/UtF2B0U7rY3+QTTEECm3uJgu2K/RFCqaJ0WWt6Kus6w2ZyjLgk+xTyCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSHulbimBCVhl9AXN1P3mifDksbdUTzcKVK+EFijpn4=;
 b=JodJ0buwdwH58nwAeNxGZ5rXkVXOmDCAs6YZxmeZM/Q3zg/sbJiDKO9rbDqTrYU+vD9xWlufmuZP/NssHApVZoHvK5Zif7GcOHQ3U0HUB+mUe4iAga/fhmaX5wZTM6/ntVgy/vBvUogiY9iimGfOVoiKjDPkzQgr8Nj6iqK/b7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 20:43:26 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 20:43:26 +0000
Message-ID: <4e6dda52-1897-4602-a553-9b28009e5405@amd.com>
Date: Tue, 17 Mar 2026 16:43:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_atomic: duplicate colorop states if plane color
 pipeline in use
To: Melissa Wen <mwen@igalia.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 contact@emersion.fr, alex.hung@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260316210055.234498-1-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260316210055.234498-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab7da76-9442-4482-6246-08de8465d669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|7053199007|921020;
X-Microsoft-Antispam-Message-Info: 36hsXWDVEFtn/7lH0zdjvDXTtRVEGAj+qElIUJhhn+P6Lwwn4IOvfhsZFtm3SRl4R9kj5FjbrRBkDTK20NRI5GDVydMtXnmvgiEelZaMIOugIb4VTo5U6HqT34zqJMDPN209q+0R724RRVdhfSLAlbHCtVkt+zjqocph3Y2dG/PY+DO9btVnI+vdD/Yc07bd/ttun/fRek9WW1BmiE/9F/LyOnxzzO+oxyWG/DOXus6nvZgfIv3nV6For0KRD+786lrlr/zDt5PB4UAZBz/v8qNX/TFxqLHGlcHsBZX3ZiqndckCztPzBjPwDrWG8vnx7oG4ONjnqw+bKkXI39qpCKbIiXAfCmsoeQQclk4lnBHC5LvtEL5q5XGr+Ibr3Pvm98v8lT0gTmlgfRxNXIu/ExJKvCSeucUxUsRy+dSPrInoun0ZlEWnpWS1yvI09XfqTfQ6oBBN1/H7XcjP3brRWZPM2o97iW8EWmiS8NGx1DcK/G/5DZHvIsLgLHckvEvMsrNLAJ142bxbwHwDawk0VBwgv+XxeB+H2gm/zL4ZQRFUXqTQVDp4Pgrf4C+GnZ9lIrP3YeHWodT7KF8ytrJ1Tj8v17jLznlPGglyWMfpMux3D/1kKfOLtwV+Y4mx5VkYerZxxqbA0HWa8x5gmdYnXbqKENjvHVKqZRwu9m8hUbExsKul317WJmk+LS0kNkYpCaC3QMMBBB3tiDYUFI4HlPcSuzTl/D6Mim+MVuK1vRq2tB/3fK2MTdbX4Fup5bzykYan+hA0airuH4jGdkTNQ87PX5Xb1tenYNcME/H+4es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0RydjByUFZvUlNjV3Q1QjJ1cnZpUzZ6dUY3ZUJXQTJRSVpISmdiam56d1U0?=
 =?utf-8?B?VUxzMldpbW9HQkRGLzAzekZ0VWNzeHRyNURTSFp5TWYxbkNRUElkVThLVCtt?=
 =?utf-8?B?S1ZXR1FINEE0K0E0TWJndkZLUGN1ODg0RlYrbVhOTlJoZlJJNFdKVEw4MlNy?=
 =?utf-8?B?SDBzbUE3bTdkdEdHMk1jMkxiYXRMUW9BeFYwbUdzalpZUkFEckhCM2doZnF1?=
 =?utf-8?B?RGV3eC9hUkJSVXFDSzhVTTkxaVFaU1FtOWcwRklzRk1OZTZTUmJKN0RMczBL?=
 =?utf-8?B?T2tmcFNKeGpKbGplOFYwN255SmpzMFZHc0JzVzBxMGRvK0pFMUlodmtaRTho?=
 =?utf-8?B?WkZwVnNwZllpeExPS0hSVDdMK21HZ1lRRTJQblE2UDJ1VWxhWlpkcHZmUm5v?=
 =?utf-8?B?dVR6K3dXcEluMlAvakh1K2N0SWxMQ2NOYmVnZUVWTUh5eE1JZU92Z2tCdHhY?=
 =?utf-8?B?cWlYNVVwMldkVlJqZStVQ2lJOUtZYm9tQTNSdGY1NTBtbVg3N2VCZDhhWGRj?=
 =?utf-8?B?T2dqcVBCckNzU2FnSTdadHRTcjhkYTFyZ0t4SDhTelRuclZJeWVqN1pxVm5L?=
 =?utf-8?B?Q0JuTVl3M3RiSHBmY253ODJFZTBuY0F1aHdxNU9yTzRVQllTZ2VuY3RDT21M?=
 =?utf-8?B?dEpHR0VYbkZkYkh3bDEzdDlXaXBIQnZwcGIwY1l6c1EvYWc5eEV1aTZXcWZN?=
 =?utf-8?B?NHN1VzFFckVyc3dUUEc1WWhuRGNNNXRWYkVhTWQ3aUJzVWdpbzVWTEhmK0pm?=
 =?utf-8?B?amtLYlZ1dzlUay9PZmtUR0tMNVp6b0ZHWEQrVjJNUk11aFpHY2phM05zVGZ0?=
 =?utf-8?B?akNsalQzWTVXb3lmWnpKUjg0dkJSa3laVUxXajd6VE8zRVZ6dHlIRmViKytT?=
 =?utf-8?B?QjEyMG05Rm80L2d1WndRQnlvN1NzTFRLNFdyYzhMMmQzT3hNcDk5L2Z4d05Y?=
 =?utf-8?B?YVVzSEdkRktUZDNzcFlpb2w5R0xPWEg3N05IZlFyUzZ2WFVTMlNQQ1I5bGxi?=
 =?utf-8?B?ZHZkZzJ2a0dkTm1SWmhqcENyWVlVVjVLc21IdzJNaUgvZHRNSVl2VEhYYjho?=
 =?utf-8?B?MnY2YlFPNUxLSEFTd0Z1bnlITjRGQnZtY1FaMmNCZ21seWFudVNveEw0OVJL?=
 =?utf-8?B?QTkwanhPZ2dUQnZCc1FJRi83bCtMeVcwSjZJSThRSUt1ZU1XZmpiZ2FOa2h6?=
 =?utf-8?B?b1UyanY1a2JiV1c1RGs1UGdtVmxWYlFOT3hhcUtkeDZzL0RZNi9PeGpVRmJF?=
 =?utf-8?B?S1B4cW5ZbmhCbE9RdEIrOVRaaFJtQ3ZBN2pENFFPZldJNzBUdUJrMWRTMi90?=
 =?utf-8?B?dVFTblJlYytpVmVDT29UY0JhQWMwSjBhSHpIclZvV3BOYkErSUxMNkhzZHBC?=
 =?utf-8?B?cEFFazVOZ2xpMi9ZOG9qSXZUZmhHdm1lN0xieXIvQlZhNlZJb3lReDhHek5P?=
 =?utf-8?B?QTY0aFpNYUVYV0crSDQxOXRUWkVPdVpEaG1HdlhjenIwcncxdGJnRElqRFhM?=
 =?utf-8?B?bDNsT3FTcytva2FqSm84c3FzbzZlejJ0WG9sMUVSZVN4ME05Z0FaNnhVSDlh?=
 =?utf-8?B?VmZ0QTk0S1ZCc0toWndjSnh5Lzc2d3E2cWxTZ29BL3ZPRDZ2SVVxVzRBMXpK?=
 =?utf-8?B?cUUwYjlBZjlBc09MV0UrcG0xckxTYXAxNVpENXJLTTBMcnNjKy9Vdjd2aGZM?=
 =?utf-8?B?UEZtS0NGb2pidlVaN3F3Smh2My9hZXErTTd2TUJJd2NoeUhiY2IxOUR4c1kx?=
 =?utf-8?B?WUtrM1Rld0dLd2VGTzRVcWw4bFYrSXRQSnlzOGd6a1NzSEN1aWs1UnRYdVgy?=
 =?utf-8?B?T1RhcGZ2NUQwbXRYZlFoZGprbEh6aXEybmc4L3FyWCthMzVGa1BNazkwZmJ5?=
 =?utf-8?B?OUx0RTVUN0lhd2tIUmNOSm91dS9WbGxhRWNmUVNmd1dxNi91T1U4dnFVVVRM?=
 =?utf-8?B?TzdwTkJVZThFdytUQ0xQWFBIV0M2R0lCZURnZFY1eFhrK2hXSU1lV3hPK204?=
 =?utf-8?B?bEk5UFdwT1VxSVJ2NE1mT3RCUUF2RVA4TnhSdFltTGVuYStBbk5tcFJTckJX?=
 =?utf-8?B?Q1NyZFRsVkRYbmhKR1ZFZ0JuODU4RjF2WURQWlBRYmd1REdUclVIVkFOSTZW?=
 =?utf-8?B?V01KWW41TmdkUDNtYUdLcHgxY2lKMnhZMHRnbHkwM21PV3IvUS9COXQyeVp1?=
 =?utf-8?B?SWxrOUFSZkxFS1lKYnN5ZXJYRTltTEJ2QllLOFBVbWcveU5LOFM2RlYzMGd1?=
 =?utf-8?B?VXRsb0huQ2pWRVlVdVU0SUxCVkZaRGM5VFdqWEJ1V3NIdnpPWmhXU3BmblpI?=
 =?utf-8?B?RFRNTDJFS0c2bWlOT3hNaVlVbVBDYW1YQXdBbFVmRXRUSHliVEZZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab7da76-9442-4482-6246-08de8465d669
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:43:25.7799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4/O/JdmmptFNZ39JqeMdwUgU4D6v1eDmPz///igsRh9b8c1GoZ1CPxH1rw1AqyI/fzx1Zrgs8vJK5vRPGed1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

On 2026-03-16 16:52, Melissa Wen wrote:
> For suspend/resume to work correctly, do for colorop state the same we
> do for plane/crtc/connector states: duplicate the state of colorops in a
> color pipeline if it's in use by a given plane when suspending and
> restore cached colorop states when resuming.
> 
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Of course. Thanks for fixing this.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

> ---
> 
> Hi,
> 
> I've been working on making gamescope use KMS plane color API, instead
> of AMD driver-specific color properties [1] and I found this issue
> during Steam Deck suspend/resume process.
> 

Great to hear.

Harry

> Initially I thought I should also set plane color_mgmt_changed to make
> AMD driver reprogram the color state, but looks like it's not needed
> (still testing). Therefore, I think the change here is enough to fix it.
> 
> It applies on top of drm-misc-next and is inspired by commit
> 6955d6bca053 ("drm/atomic: Add affected colorops with affected planes").
> 
> [1] https://github.com/ValveSoftware/gamescope/pull/2113
> 
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>  include/drm/drm_atomic.h            |  3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e..683a0e207f71 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>  			err = PTR_ERR(plane_state);
>  			goto free;
>  		}
> +
> +		if (plane_state->color_pipeline) {
> +			err = drm_atomic_add_affected_colorops(state, plane);
> +			if (err)
> +				goto free;
> +		}
> +
>  	}
>  
>  	drm_connector_list_iter_begin(dev, &conn_iter);
> @@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>  	int i, ret;
>  	struct drm_plane *plane;
>  	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>  	struct drm_connector *connector;
>  	struct drm_connector_state *new_conn_state;
>  	struct drm_crtc *crtc;
> @@ -3866,6 +3875,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>  	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>  		state->planes[i].old_state = plane->state;
>  
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
> +		state->colorops[i].old_state = colorop->state;
> +
>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
>  		state->crtcs[i].old_state = crtc->state;
>  
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 0b1b32bcd2bd..96fd32a3e92c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  		for_each_if ((__state)->colorops[__i].ptr &&		\
>  			     ((colorop) = (__state)->colorops[__i].ptr,	\
>  			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
> -			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
> +			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
> +			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update

