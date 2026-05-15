Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8371CD4F46
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 23:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498C310E44E;
	Fri, 15 May 2026 23:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIeesAWR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010016.outbound.protection.outlook.com
 [52.101.193.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B31510E444;
 Fri, 15 May 2026 23:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTCdAL9/PmydQJm2ttPncN+5HS+s0jR11ErzKorpWpdZxmKcyk4fL8edVvJX1sAl1QbiCppWfJegZMQuvrJYf/y0VjW/2EP8cxrV1m2RR4qB63KENh1Devyu6HJaAw1shCzDD7l+7bO5ftXibSdb5QB3HEakCucw2XN4vC95jEh6C3xRFW51Rm5Hyo8Dw9bylHb6fZo+uYc/sVnPneo/vgmbhV1StwB0gqozlJaA4f/9VNPypCMXgvrktqhF+jkUG+GyvBduGv0ckXnapcpweLNhDR3pyHXnLhsjl4F1SViR6dimyWFuZtF7JoVvEbttyJco1zB7xAP5sO5IPvg0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHG9CuFVoiL95bT/YH6cd3J31Y5mEV71zM4DNCY508o=;
 b=geMPKYmi7MR9YEEqRkwGBaoNskuGxcegRwqqR2enGZpAAemMKIMAUxaOOK5qk5o+ht/z0V4IjXpJ93dKAhiu3fBUFrmpMpIE0eBzwvNhoDgu8H562Wn/z1aVm6saUJiEUApnZCMTt2zpO1fZgGLpl5ExY9oH/MyjWxyuCqV1+zn1mve5Drq0V8w/OS7AydH/DGO5CdXNCtyVYMTCvTEuowYMfdMGeSh8yIxPstmR2O6vMiSKiasf+Gy70TYZKb4r4udMO6AvpaKgD+eQNJ9WdhFQfImaUgac4CAKETEVlJWcRjmG5NF3Dt6QEn0+tMvO/TNkFlGtPN8zcavVpdV3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHG9CuFVoiL95bT/YH6cd3J31Y5mEV71zM4DNCY508o=;
 b=qIeesAWRb3gnuYnv+6hJc6csFbGuRKJtqWkf6DY5KHhSqPI3FNcFTqyqsujx0ZJBqlr47rLc6lj58KxcC/2IUNd9e++avxBVUf56WZrtSruCd07XEY8zcXstJvZuGEME0P07x747rq+JwlLuNV5SzD1MR3bneHZ4f6MS/feVy30=
Received: from DS7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::25) by
 CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Fri, 15 May
 2026 23:47:09 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::cb) by DS7P222CA0022.outlook.office365.com
 (2603:10b6:8:2e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Fri,
 15 May 2026 23:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 23:47:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Fri, 15 May
 2026 18:47:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 May
 2026 18:47:09 -0500
Received: from [10.4.12.198] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 15 May 2026 18:47:08 -0500
Message-ID: <020f60b5-b2c4-494a-a16d-07a700d299f4@amd.com>
Date: Fri, 15 May 2026 19:47:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/edid: parse panel type from DisplayID 2.x Display
 Parameters block
To: Jani Nikula <jani.nikula@intel.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Limonciello Mario <Mario.Limonciello@amd.com>
References: <20260514065606.1151834-1-chen-yu.chen@amd.com>
 <20260514065606.1151834-2-chen-yu.chen@amd.com>
 <8e0c6356a570c55e3df54be6c2d7952dfcee2a06@intel.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <8e0c6356a570c55e3df54be6c2d7952dfcee2a06@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3d2ffc-4555-4840-496d-08deb2dc4786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|82310400026|36860700016|376014|3023799003|11063799003|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: uADu3N/yhlX8Zdqjm2kiI7LSJbiV/AH5+h/NVYCzRF1p7upUfQS4vM8JhkX+UpiVESaR4BNFJYB7O42g/kaw+K6VKPp1sZVWZjdYgnM5Fzj7TjCc/pUbwkcXwF03audtn5HkY1MC+O9J2supdD1B8eKZUaHDNr7usJfSf3+Et9u3JavzOTbuA9H/G2+qUu2FuyhmzqQy+FNUG4RzT8HUR0iZa8FyThCQGjPUXP/RvQy+5rhNnTTVcqaS8RSpMXFNxzA5oNZhrOvGp3S+e3D3NC8pS9Hy+9fuYs1uS3SbihKHXEz3VTqbwF6bxIEOU/k+EQ4KZYBlbyrdVLwKTCPLq9DhgeeB9wBpZ/uUqowUusInd/+9DbkgcRKs+qVkb+RZyGo90yMqYegEqzzUG6asqeYZ9hr+qtxL/NJVtNxXSWq7lmasunOHmfjj+HCQfdo1b6foFv9D82PM/3TDBbhDox4UCSJJB+6Xw/s+djc4ASvt7+5B0zPO8sbJIVA5a9L8Km9gEfo4fcYDlZ0YL1YlFmdVz03BZmkb73BL8ep0f/xFap/vcIN97kihCq38G6/WmHbHiw1NCAmtY4fqdcgrPCmEjdXXovJOAo7ufU6KgV+Qzru5HATcBKCrF1mSpX5epbHTv/LfNsP59a6Mvmdgja4MiTINNXi82tx6qRByz/bGv7o0ejNc7GDLbGNKCCPo9IbLwUwxXUAsH1mepknN/U8osh6xAtksnIcX+Kjr/ag=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(82310400026)(36860700016)(376014)(3023799003)(11063799003)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HQuppyKh1YI+9da/wClSuUqWmFHu7QSaguotYsNlGE/F7jZ9uwjgTj5pOFTPmIVbHlJoKwGK01+z7kUf0skgXJ6uiDlKtIiFpxn8PkTws5JR8vxPcL3+u+UKkVP1h/tqjPDrR9WMqaHlFWBopeM5V1IaLXyKMFhkR2VFA+t2wOtpB3M7B4+UoDSmqSweGxg0jqOxV4LhKtImDX+BmtkJy2X3KgWsgAcVfdZRkbhPBPxkEhKUCrnvIs2xJuWFdopU/8vKZ35A6WgmkP+ukYp5XHYgTxK3UUBt1wT9lFycJpU0n2nsgeLVqNpj/WXgA19vDJqa3wlIu+bKDZAF0i/9OELLjfPgLpI3DYGlZcNsEaUc9SL6pLNI9vEftnzSPFo/S2C2BSM8qYgeeI02Zbhr5Vhf/1RvAfeE/0SfpCkVTKbHOI7c8oKodCPM/haP1Oh3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 23:47:09.5270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3d2ffc-4555-4840-496d-08deb2dc4786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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



On 2026-05-15 04:23, Jani Nikula wrote:
> On Thu, 14 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
>> Parse the Display Parameters Data Block (tag 0x21) defined in
>> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
>> field from payload byte 27, bits [6:4], which indicates whether the
>> panel is LCD (001b) or OLED (010b).
>>
>> Store the result in drm_display_info.did_panel_type so that downstream
>> drivers can use it for panel-type-dependent behavior.
>>
>> Assisted-by: Copilot:Claude-Opus-4.6
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++
>>  drivers/gpu/drm/drm_edid.c               | 61 +++++++++++++++++++-----
>>  include/drm/drm_connector.h              |  6 +++
>>  include/uapi/drm/drm_mode.h              |  1 +
>>  4 files changed, 82 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
>> index 5b1b32f73516..e0f7c54d2987 100644
>> --- a/drivers/gpu/drm/drm_displayid_internal.h
>> +++ b/drivers/gpu/drm/drm_displayid_internal.h
>> @@ -142,6 +142,31 @@ struct displayid_formula_timing_block {
>>  	struct displayid_formula_timings_9 timings[];
>>  } __packed;
>>  
>> +/*
>> + * DisplayID v2.x Display Parameters Data Block (tag 0x21).
>> + *
>> + * Per VESA DisplayID v2.1a, Section 4.2.6, Table 4-14:
>> + * Offset 0x1E (payload byte 27) contains Native Color Depth and
>> + * Display Device Technology fields.
>> + *   bits [2:0] = Native Color Depth
>> + *   bit  [3]   = RESERVED
>> + *   bits [6:4] = Display Device Technology
>> + *     000b = not specified, 001b = LCD, 010b = OLED, others reserved
>> + *   bit  [7]   = Display Device Theme Preference
>> + */
>> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
>> +
>> +struct displayid_display_params_block {
>> +	struct displayid_block base;
>> +	u8 payload[27];
>> +	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
>> +	u8 reserved;
>> +} __packed;
>> +
>> +#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
>> +	(sizeof(struct displayid_display_params_block) -	\
>> +	 sizeof(struct displayid_block))
>> +
>>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>>  
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 8031f021d4d0..9b160a878df4 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>>  
>>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>> +
>> +	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>>  }
>>  
>>  static void update_displayid_info(struct drm_connector *connector,
>> @@ -6721,24 +6723,61 @@ static void update_displayid_info(struct drm_connector *connector,
>>  	struct drm_display_info *info = &connector->display_info;
>>  	const struct displayid_block *block;
>>  	struct displayid_iter iter;
>> +	const u8 *section = NULL;
>>  
>>  	displayid_iter_edid_begin(drm_edid, &iter);
>>  	displayid_iter_for_each(block, &iter) {
>> +		if (section != iter.section) {
>> +			drm_dbg_kms(connector->dev,
>> +				    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>> +				    connector->base.id, connector->name,
>> +				    displayid_version(&iter),
>> +				    displayid_primary_use(&iter));
>> +			if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>> +			    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>> +			     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>> +				info->non_desktop = true;
>> +			section = iter.section;
>> +		}
> 
> What is this even supposed to do?
> 

I think the intention is to log and process the DisplayID base section header only once instead on every
iteration. Maybe a `bool header_processed` works better?

- Leo

>> +
>>  		drm_dbg_kms(connector->dev,
>> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>> +			    "[CONNECTOR:%d:%s] DisplayID block tag 0x%02x, rev 0x%02x, size %u\n",
>>  			    connector->base.id, connector->name,
>> -			    displayid_version(&iter),
>> -			    displayid_primary_use(&iter));
>> +			    block->tag, block->rev, block->num_bytes);
>> +
>>  		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>> -			info->non_desktop = true;
>> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS) {
>> +			const struct displayid_display_params_block *params =
>> +				(const struct displayid_display_params_block *)block;
>> +			u8 tech;
>> +
>> +			if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
>> +				drm_dbg_kms(connector->dev,
>> +					    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
>> +					    connector->base.id, connector->name,
>> +					    block->num_bytes,
>> +					    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
>> +				continue;
>> +			}
>>  
>> -		/*
>> -		 * We're only interested in the base section here, no need to
>> -		 * iterate further.
>> -		 */
>> -		break;
>> +			tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
>> +					 params->device_tech_byte);
>> +
>> +			drm_dbg_kms(connector->dev,
>> +				    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
>> +				    connector->base.id, connector->name, tech);
>> +
>> +			switch (tech) {
>> +			case 1: /* LCD */
>> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
>> +				break;
>> +			case 2: /* OLED */
>> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
>> +				break;
>> +			default:
>> +				break;
>> +			}
>> +		}
> 
> Please tell copilot to not add so much crap in the iterator block. Add
> functions. Add the first function as a refactor for non_desktop, add
> more stuff on top, i.e. split this into multiple patches.
> 
> BR,
> Jani.
> 
> 
>>  	}
>>  	displayid_iter_end(&iter);
>>  }
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index c398dbc68bbc..b95aec34ddb7 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -899,6 +899,12 @@ struct drm_display_info {
>>  	 * @amd_vsdb: AMD-specific VSDB information.
>>  	 */
>>  	struct drm_amd_vsdb_info amd_vsdb;
>> +
>> +	/**
>> +	 * @did_panel_type: Panel type from DisplayID Display Parameters
>> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
>> +	 */
>> +	u8 did_panel_type;
>>  };
>>  
>>  int drm_display_info_set_bus_formats(struct drm_display_info *info,
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 3693d82b5279..d7ca1040b92e 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -169,6 +169,7 @@ extern "C" {
>>  /* Panel type property */
>>  #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
>>  #define DRM_MODE_PANEL_TYPE_OLED	1
>> +#define DRM_MODE_PANEL_TYPE_LCD		2
>>  
>>  /*
>>   * DRM_MODE_ROTATE_<degrees>
> 

