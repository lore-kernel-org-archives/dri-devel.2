Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33247CD6E45
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 08:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C93110EE32;
	Thu, 28 May 2026 08:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mDx9jMex";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16ACE10EE30;
 Thu, 28 May 2026 08:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOFV+V8HZusRyP8tpNStWXebNvTa+oU9qirxmD/144pzbPW8Ro3KMc6LdbuO4mfvNTaw2Byt3k4RMPlC2pP0BRNmF4ojWx9579op0fNosNiUmDNSKc9M7OWLHPStT+4sw+Mns2h+RtzCsbX9x2kOELuMcfbObaMjaPTlaSS4SRkH5HogrtF5S4lMlR10AtUA/bsXo/8uDnCDCxop9VppIaqFz5Vgt3kIjEiGtncdy3s9lE4+Rf75uKjejv9Cw+bCyiwTutTxgc1BohAjYcdi8uu5AD2x4s6nL6r5d6JDeU//IgEx8gLpZIZu96XptgVBkYDGEo7XXU6YYTwZPyyxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvKSx5vAeKfMkQdR9ii0NLh1LBSjaCKhieKAiwSPlSE=;
 b=EDyw54qvj/STlDknnwGT8cKfqVi26H8DK8Tbi2cNljYASIlCTuuj0mTSbcJXTmeOKL9YWlFacekHfJgJcJO093Zr6klTVT9NdvuU+5AaaslzmQ9NZXXdswT2PJUivY5ySvNqibx5M0/2KxKPOMxtXiLRsiw6tMnDqslF1YGIesRmN6cSFrgdbzdVpvJNNcK+cTQr/tjNnsq7KNMAexDMLIvhtloQs54KTN5/BTYj/riDOpdhgqENg8j1G0IIjxsEV3WFArTKQDRdBOr7Y0tyY0kVEIPMWQd6uNNxCaq5ODNi90Fp3Ajk0NPqD4cI2D4Mbi/MlB75AyKX1g3hIyzZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvKSx5vAeKfMkQdR9ii0NLh1LBSjaCKhieKAiwSPlSE=;
 b=mDx9jMexu9TvKqa1RY1nXuUIWnqSgb7ZTCd6OL9efGPlD9sW5xXD3fp9jj0MyKArJHHXcPFDpEIsX0CHUIKsGf8wmd0v/wfs3NQnUGUnNiTqE1uclsVq7p98Wpt4+x22Ro3fCgkhwRSWL2jl4suJDfEM4DiN62ZmwV1kE7NSJJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 28 May
 2026 08:51:40 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:51:40 +0000
Message-ID: <8a1e73be-13a6-42af-8e1c-f38fdb60cbdf@amd.com>
Date: Thu, 28 May 2026 16:51:36 +0800
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
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 656ebfa9-3100-4b93-49ea-08debc9655c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 8gkNjgVqNfczbbCLYfy5lC/9ghaDgiXX0SgdiEMHF+AqzgOUHf8S8GCbUN7lCcSZSLc+NnKAivmHyg6NCYP2RWv4GyoSV5a7IXSGHFavxEKbiN+GjPJrYpA2+mq20kdDFBiMkF75yKShXqQtzWKHW5kNH3OwSZCABeD8xxwl58qvpuE0HMeWTcCxqliZfB8N+9bAxTLQJjv/ZEGIc3l0eNs+4CFLJG+figpZGEaLuOnRMthYXtb+w0fRTz/H0h+8IKdtgQrCMcksM8JHNGh09TYA70mTxr25qmYNwzz2yYlZlgM4lYUyyDJU2Aqe6SBYNtT5t09pbXTcFlvgHygBmyLrLUC7g632NKgL6WJAW2odWjEbSbR0YYT97aAH/cXy1m8yAkUlYfAkL9/yPtumRleTp3mNTx2GsOe+XplqJrQ57RUwuZ0b+uOUZvDMC3i1grtmo1zmFQWr1XRYzd7tgXuI/rauV5XkjDZ9ahPFilxX7MfoemgO6ZdKmztJ/69QDRtYh/zKQQznDYh3hV+as0+f8Qq4CK1K1P+PsjHIikMtSl/+ETt5SWKUei/BdwzWqmJ4h1L0yQfTMIu967bLZ6LIgm2F5gKTykBsuDj8sB1EcQ0GTgT5MZqio7NF1R4oQId3itzBzbkR3JL+37Mm/7nO1JBVz+nvphQi0W+BK+noBhW5EHM8ANKQhXhf0p4D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MitWdEFzbjdkK3B4WkxHREZnRytDWGJNRzk1c2wxSjByS1oyeGZ2YjgrWFdw?=
 =?utf-8?B?UGtOUjY5cDE1Y01KTjZpbDJWSVZpTW9uWkt3eEViL09qZEVwRjAwdUhCT054?=
 =?utf-8?B?TEIvd2pKZjRjbnBPZHkrdGNWM2I1V0QzNjd3c3YzbXgxVTFRWEZtUjZhT284?=
 =?utf-8?B?NE5LZFdDVGpmemdCQXVCZ0VoeFFEV016RnlZSllBWENhUlpLeFZPUmxlWlBx?=
 =?utf-8?B?QzNnRFhxekNnMFdyQk9kczN5U3lsK2VNYnhLMCszMWUxcmNxMTZoaWJGVUE5?=
 =?utf-8?B?RTVPWjAzSllNV0UxY3FvN1FobzlLeE8rZkNHdkovLzMrS1FvOStWUUNpL21S?=
 =?utf-8?B?c3dWY2N3dmxiMUc1UUZraWtkTGYzK2pWNFF5Qk5TdVNLYVZwN2Zjc2lCb2pl?=
 =?utf-8?B?ZFJ3YmlkMmRXMVRLa1EybVJGNDdJQlJGS0JpQWVNL1ltaXRidit5a2NnUTdO?=
 =?utf-8?B?Zy9UZkRITzVXSFJkZ09Sbk5qT0ZGaEMwVHVqUHdpbzVTa3FTUWFZOWdCcXlo?=
 =?utf-8?B?aW1FWjkvbEFQSFhmSnl3bUZxZlZ4YW1NN2txS3N1dU9yTEhlUnoxcUh6cEFD?=
 =?utf-8?B?UWtpMWw3RU55UlF5dSswY1FoYlVpTjFwcnlBYUFpK0tGM1hTOXBDZHNkT3ps?=
 =?utf-8?B?WjBTYW5iYnU3M2lWQ0JOeHNGMFlQcVhHdWw3MzdKRjhNb2Rmam8wWUE4aUh2?=
 =?utf-8?B?aDBFdS9oWHZOcitCY1lMR3MxWk5LbHlhVGt5aEpUYzg2Q2JiQ1BOMmt1TDM2?=
 =?utf-8?B?bittMmJkRmF1Y3QyMmpMb2FKYk9EVEo0LzhLOW1tdzZQMUZWS2VQN01JdGZ2?=
 =?utf-8?B?ZTVpclVVdGp4Q0ZJTWw5anB5YU1HeEkzdHpnUW9lQVBJTVovRWNIMytucUND?=
 =?utf-8?B?czlmNWZ4d2FhdFprd2poVzJ4cWlVcGJ1NlVwbHlHZk9wb0FVSWcyeDgzWFhh?=
 =?utf-8?B?OGtXY2FVdDRNN0V5V3RFMEVQdHlybTFvQzdNUTR3Q213M0owcnRHalNETTdN?=
 =?utf-8?B?b1BKQ0tpV1ZtR0FlRTVDSzB0ellZWitydmhjQjRvT3ZVazZyb1dnQXdPa0RL?=
 =?utf-8?B?T0hYa0ZZOXFDdjIrcG0yQW5zaEFVZi85ZXBOQ0JXRnAvMTFKTzdVSHRMT1hs?=
 =?utf-8?B?L245ZUp5Ymp1c2dNZ2RvMXpWTUkrTXowZXRVdjNnazBqRkVaQldiYkhkbXdY?=
 =?utf-8?B?VitWVFhuUFNCR1BOYmZ2blBVeVM5TjNFUkFITGtOdXFKL0pvUG9zN3FyUTFT?=
 =?utf-8?B?RXdmdmtmbjQzeFJLV3hoeGR4RFhVYngwQVY0dkZXWDJkNG53U2dYRUZJWGQ4?=
 =?utf-8?B?R2ZONi9JZUZtWkhTZk05UnNMd0xFcUhaWU9BOU1rcDZaMDVkcjJDWWhwWEJt?=
 =?utf-8?B?WktYcjZHbmY3RU5YQjNzYUpJRFdHYmxRdzVvK2grVEdGdFhSM0Q3NEZybmk3?=
 =?utf-8?B?dUZxRS9rbkk1Wm12cDNoc25XelVLaTdHY21yeGRacmFpU2hWVFRLeG5UaHFL?=
 =?utf-8?B?a3RRNGlORkNtRld2UTdhbUZXTzh5bWNEWXdta2tnQ05sZUt5djJqanYrenNJ?=
 =?utf-8?B?c082MEhZWHltUnduSVJRN2Nqb3dGSTU5bmxkNFJ5OWZQQ0F4VnFGdURhUDVy?=
 =?utf-8?B?Z2JHbk9RSTJjMmNORTYzMFhxV1pyYkk2ODBmQWtNOHRJTUo4Y2RJV2hEQ1VB?=
 =?utf-8?B?SGpKUkt0VW05dTI5RktxK1AydDhZc1hQSENEQVJ2cFA5eXRMUjI1ZDl5clFM?=
 =?utf-8?B?b1MveFIvTCtubzdSWWNBOWFHMm9DV1libDA3QmU3bG8vYlpTbTNiaVRqN09n?=
 =?utf-8?B?WmErcVNYNlVvRVBnNG1nSmcwMWZIUVBNRU1QVklqK3ozSGswODA2c3FKaVBj?=
 =?utf-8?B?aUVUUnZGbGFOK1RpcU5sSk9OYUNOVzh4WUltbHplb0dxT3FtQ1p5Rmhjejhs?=
 =?utf-8?B?VDB3L0QvanVKWTVDTDNBOFR5Z09OK2ViQlJHTk01dS9rVTFLQjRIWTF1WW1K?=
 =?utf-8?B?b0JVSWpIU0hNUTllVjRNWlUxOWcxN0ZJWStyUlZWd0Y4Nll3OFdYUW9HUFll?=
 =?utf-8?B?ejNjek56cENiT085WXd0c0lWTkF0RGl5UE9mbWF3WXVpUHNsaENtU0toWlQv?=
 =?utf-8?B?dlk0ejhFK2xIejVSNWxUdlRMRS9PUzJCekhVdm92b0M4VkF4RFJJbTB1eld4?=
 =?utf-8?B?eEhTY2lFdWpMM0dQd3JmMnFUOURLR2FNZDJlU0cvb0ZZWCtZTElaNDZWSEhm?=
 =?utf-8?B?cHRtRS9PV0twK1k1aVEzYmx0Z3hsdHhqTnhoOE1tSkxVYmtpcHUrNGxoSmo1?=
 =?utf-8?B?NEdSeldHMkJ4OFZ3bUFJdmZvZUVlYmpzTGdjMGFQanloNzNmVndtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656ebfa9-3100-4b93-49ea-08debc9655c8
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:51:40.6718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9W+eES4fd7DM4B9j44P7hGpNWmowgXug4eA6ibjfoD3dIgPj81Eduz8Y8oX2YE3T9+1VFCIh2Dm0rYcJ5A1GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
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

Hi Jani,

I'm not sure why I didn't receive the cover letter, so I'm replying to this email.
Do you have any comments on PATCH v3, or does it look good to you?

Regards,
Chenyu


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

