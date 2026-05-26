Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC76ACD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ADA10E445;
	Tue, 26 May 2026 03:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkDMac/E";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E39910E445;
 Tue, 26 May 2026 03:09:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYnC5wYBhshEZASeO4MDjmE/BjRHQoT1IMCOeyeSvXr16CiOnIZlfAXqlaUBn5xc4GUUV+U5XkK74voaGzZysnGRX8/MrV/hRlBSJZObYVzjDZKn9KOvPE3CqCdce6S4tC/qt7eoXmKFdddElMdXrtMzpUd8F54uxr0iA+MLEF9+i0oKiNN4Wnirs2lZzI5gHDfDP5fjarmZ3sw7p4pi5qopph6/jXOa57ZYMFXXVOSQ9AWuPrgwfnXANtkjstdg+VLPzln8z5qLJGtmOHX5VasH9IbMSK+3b8JK/FsONgyBfyUr7DaggpNIc8apYu2zD2HpWR4xvMS3oYFI8X4nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rESSheZNPViO9lxk5jJ9DlqZz99RcKoydBll9V9LUaI=;
 b=TodCmZkOHif9c11dAN4OgNmXNqBeVgs5GaxGgz1BUEIk7wu3Lg8kctF/YCUkvnHq6P4ObwlUW33Fnk48BhoGha+5VPdh4Im3vA4xk5M3uzURwGJ0eZC1FB7IDGkXNG5Z9gUjcAWg9vEnyiYSqEk1g9KmF5sySLE13K3UQoLrTeIhG6VBdKQ+VoufZ1sDyOjSbOdUzKH8nRy1WahyOMnCGzLOlkuRQ7lgi7KwV2b1wnplIieCu99wpt6wupwL7RFCMSpo1HHooe2Z0/wBRXvq2uCHEGgdBDx8d1KdmDa3ggFaaIq35koNMNXzIsDCCXOtOnXUZyiGtYDW3AAjHo2LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rESSheZNPViO9lxk5jJ9DlqZz99RcKoydBll9V9LUaI=;
 b=tkDMac/EDGPA0wix96NBCywf5izyd3BfPpGQEsESXUJJsftPqur4S7IilAOK1/7goAVOMpeC8/93079Er+x4XNIJGepKj2vif5TLlEtUZT8Xb6ouKjfHYs3f7UymkhsP7Px3fICBdoh0kfzKX2r9Mh1lDaoSGae3nWMJiEuXtos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 03:09:18 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 03:09:18 +0000
Message-ID: <d4b22785-2718-45d4-9292-10bf8f8bff03@amd.com>
Date: Tue, 26 May 2026 11:09:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/edid: extract base section header processing
 into helper
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
 <20260526030254.1460480-2-chen-yu.chen@amd.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20260526030254.1460480-2-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9641af-28e8-4a7c-13e7-08debad42c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: VpCE8xUZWtbmwVJbFbmvqaAFOFbC/dWU90NoaBaTDcqDcSN00ZvUINFwFmD54ElQUvjFR+ZTxha8u8fG/pubQ4vugKDXxTYy622m2u3G2XA8GP4sO/DWItANEXiGBTjDquoZqEeobExP2VLk+nCGF1AyI0KXFAB6ngrUfZFlshZm64q46Nddh2hVRke76pfRtU/GtRNRgGmjF5SJ6kaIlecGJfueArHJaqqlSHmKpQAeYzLFreZtYOmGFutlnBQzv1VlQFl97Ky2SQ8VTeLd4RSUo3Rlyji+kiWHquTYPM23vAkFJ9DaiVbDHAAI4pdNnI+Wgz1SUd3FmDO+oTkJO2IIoGFRLXXFl4WGWSVkQkH3iKkaWJhqeKW3AzwXR0hFt/E3vnsq5KY3YlZL3bPLwX6Hgu+tRVn3QfDehcw4RUmEiuwQnuxZGR19S96l8j78YFBS4vGw1V8p5NcV3FOAfQxkBOB5eVCNbA9HBsiNHvFyPLZyoWzDJQV/89O2gZ7L5bztgPO58BEamTxgrl1zYNSnLrQfsGjjWUjgjzx5PnDottf5yNg0cKwbMPzhwhVIQlFabupL4hc6KvDf1zMRewXhFumgd2Xi2wdtqGZD6n3dP6qFOkq3pUPwua52Cth+kUbHRzZRsgsaVErEUMvozRWE3Vo+YTJrNDi0EvzVY9SB+UNri4ZUunaGELWsBLTl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5ZNDEvcU40eVZIbUVmZUtBR0dMUWp1amxwU1BqMUc5Yk51Q3kzNmFLQkZK?=
 =?utf-8?B?R2JNbnZKMXpnSWRZTkYxR3QwaTcva1gzamN6OFRkY3crY05LdFYwYTdBMmEx?=
 =?utf-8?B?bEFjWnhxRmsvdk5tMk1wNzRaYVdLZ1RZeldyUjZtUDM0bzZLYkR2WEtpS011?=
 =?utf-8?B?d2hrdFRmZFF1Q29IcU9FNDJlQnlxaTBFTnIxM0FCL0RHWVU0bTNrc1V1Q3Zo?=
 =?utf-8?B?RUdwMUtiVk5IbHhiU1BnQk9QR0FQajNoK3MzRDlCT1FoYzBlcS9ZZ3J3UW8w?=
 =?utf-8?B?WXpObFcrNkYxZzlCK2xNdmJ3eXppSngvM2VqY3hnUHZpRWZtNWZzTE5zVVVU?=
 =?utf-8?B?M0g0RTFCZlQxSDVTMTBYNlFhMmE5RVpHUlFNK3NzL296aSt6cFFmRzJZNU9C?=
 =?utf-8?B?M3BsY2I4NEdiTVlSazZ4ZTIrUVBuVkpJbWhhT003YkhaNFBnUTF2YUN3RUJh?=
 =?utf-8?B?TmlsbGV3UnBoeHc2WlJlZkdXRmRWZGh3emYydlVaTXFmeENETm1VZFZWVlMw?=
 =?utf-8?B?dHd3VWhQZWIwNnZoNE0wN3dXaDBMQmN2RjVycmFBa3RJUmdOdlpPNVpNR25y?=
 =?utf-8?B?Wmc3cmt1MC92NHJob2tCcnFveGl2MXM2U3VpdkUzTTJHdmt2VkNYL0pxWFFz?=
 =?utf-8?B?UEVCOFFRRVVaVEY2Ulk4YnUzKzFMQWhMcVpqSGgrYlVJYVh0SGxUTHdjQTRI?=
 =?utf-8?B?RnRzTTlJZjhwZUMzVXJMYjZuMGZjWDBMbmF3T2Y3SDZYellYdDVjSlkvdU0r?=
 =?utf-8?B?OGp4Q3BoMmthRWJPTm9XaTBGUmNKMHE3dnc5L0dCenZ5cFpEcGpXYk0wVDdW?=
 =?utf-8?B?L3d2M3ZyNXdONlZTY21MTVE5V1FhNC9RUW9LRk5kUUUzZVJ3VEVreGU5SEcv?=
 =?utf-8?B?WmxURzBHbkREM0xRZ1JBNkYwalRhaHZMWXBuVUw3eTdscFlCYXFBQjMyWlVp?=
 =?utf-8?B?UENQQiszSFpqdCs5VnEzQklpaCtDMEdNVCtkMkF6Q3UyQTdZZ0FTZENITUJ2?=
 =?utf-8?B?MWsrVzBDbVpJRXNpUWkxdHIvenZuQVBNMzhtYWVQNkRUU0syRFRzM1FtRHlD?=
 =?utf-8?B?eS9EVWRhZjVPRjh3S1BQcXhOVkQ5YWlvVmVnb1FDWlBqQWowNE5qVitDUWxp?=
 =?utf-8?B?Yld2K1lnT3VOeWZsMmhpZyt4ZGpOaERPZG10ZlRieUo5ejdVU0tyV1NGOG41?=
 =?utf-8?B?NjNQdUxGUi96a3Y2QjIzbWoxSURHalFaNzRRYW9OUFhwdDhwY3JzRFRtM29D?=
 =?utf-8?B?R05aTGI3YUY0elFVU1dlczd0WFhpV05OQ3RWd05uZHJ0ajlFRkZDNTRGR0ZQ?=
 =?utf-8?B?VFJBZUkyODI5MmRyRWEzTkhsaGQ2ZHFZYmszYmZkcW1zVHV3d2UzVDZCeXRH?=
 =?utf-8?B?cXJhdFhTVGFHdFVsUis5VVIvakNLU2ZTcEhrWXdiK3NUT1Nyd3hZLzg0RlRX?=
 =?utf-8?B?ckRuYlRTQk1xc3BaTmRtQkdtWWJxamFHYUphcGR4ZVl5RzBKUnJyL1VSeEc3?=
 =?utf-8?B?cVRPV0RESjlVVDZsbXB2ait4SWlUUXYxa2FTQnFLVWhnSXdxelN6YUNGY3gz?=
 =?utf-8?B?SGxITGltQVU2VE8wZm5UanQ5UVp1RTJTVCtXU1JEUDNmd2hhUHJPOU5mWDRm?=
 =?utf-8?B?a0x0bFQ0cTgxK1E0cXRGaWVxVDloYm43SzlCRjNJWno2MUt2Y1l6QVBkamh1?=
 =?utf-8?B?djI5MW9GaFp1TDdCK0R0WENUL3RDS1pvUDYzL2FwSUsrL2FYb0RrUm9pWUJF?=
 =?utf-8?B?UmM3a2xhZjMxeTZnOUtsOE1tWi96aVhiMHdNNnpJWUJiUWVOYlJ5RnlPd0sv?=
 =?utf-8?B?eXB0NnJzZy9HSmF4OEF0bUFIcXhPcWhGZkUvWSs3QzJoVjRTM2FlNjFYeEJZ?=
 =?utf-8?B?MVlaN3NIZUd5REp4dEVwbmdZSUlTdVRodnEwNVVVWGZlT0VCTlpwYTlDRWdh?=
 =?utf-8?B?MHdwRWZxK2E4dzE0TlRtdEs4N3o1UStBMHNiV3RJRTU2ZGxaa29BNnpJTXV0?=
 =?utf-8?B?b282MU1tNkl2WndHUWVXMVBMNVhkTXV0eHdjVmJ5UExYNUF2YXgxN2VKcGl4?=
 =?utf-8?B?aW96YlFCb20vT0FjVlczYUV6bno2bzFWcW1RU1Zzb1M1ekZSNXI1bnlueWZC?=
 =?utf-8?B?VUR5eVphUXhYMnMxOVkzTklBT21OcUVHckI4b0NNK0lFcWNlc293REZ2RGF4?=
 =?utf-8?B?eHExUEgxdDIzdUFQYU05SjN0ZGJoU3RDR2dtVFlDT3cvR2NaYlk1cEM4ckxl?=
 =?utf-8?B?QnpPYkMzcDhYay9ReUU2eHd0cXErRWZ6V2dSRGtNT3kyYXE2Uk5MMVEvcDhO?=
 =?utf-8?Q?lkJZcwDy+DUi+sYSFd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9641af-28e8-4a7c-13e7-08debad42c90
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:09:17.9954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNYxhAB7Gm/Fqi8s+vR5NPwXwy/e1yduCwY0xICv8xtkCuQT2KxhbjGfE/+IpseaFhgMWC/uXC3L5XTAlpmPMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

I forgot to include Mario's Reviewed-by in the commit message:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

On 5/26/2026 10:59 AM, Chenyu Chen wrote:
> Extract the DisplayID base section header logging and non_desktop
> detection from update_displayid_info() into a dedicated helper,
> drm_displayid_process_base_section_header(). Remove the break so the
> iterator walks through all data blocks, preparing for future patches
> that will parse additional block types within the loop.
> 
> The helper is called only once for the base section via a
> base_section_header_processed flag. Since version and primary_use are
> only captured from the base section, and extension sections carry a
> primary use of zero per spec, the non_desktop logic is unaffected.
> 
> No functional change.
> 
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 8031f021d4d0..7ad3f939dbe6 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>  }
>  
> +static void drm_displayid_process_base_section_header(struct drm_connector *connector,
> +						      const struct displayid_iter *iter)
> +{
> +	struct drm_display_info *info = &connector->display_info;
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> +		    connector->base.id, connector->name,
> +		    displayid_version(iter),
> +		    displayid_primary_use(iter));
> +	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +	    (displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> +	     displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> +		info->non_desktop = true;
> +}
> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> -	struct drm_display_info *info = &connector->display_info;
>  	const struct displayid_block *block;
>  	struct displayid_iter iter;
> +	bool base_section_header_processed = false;
>  
>  	displayid_iter_edid_begin(drm_edid, &iter);
>  	displayid_iter_for_each(block, &iter) {
> -		drm_dbg_kms(connector->dev,
> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
> -			    connector->base.id, connector->name,
> -			    displayid_version(&iter),
> -			    displayid_primary_use(&iter));
> -		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
> -			info->non_desktop = true;
> -
> -		/*
> -		 * We're only interested in the base section here, no need to
> -		 * iterate further.
> -		 */
> -		break;
> +		if (!base_section_header_processed) {
> +			drm_displayid_process_base_section_header(connector, &iter);
> +			base_section_header_processed = true;
> +		}
>  	}
>  	displayid_iter_end(&iter);
>  }
