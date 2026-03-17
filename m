Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D25CFF6E86
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F4F10E41B;
	Tue, 17 Mar 2026 21:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6b0sPeU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51E010E41B;
 Tue, 17 Mar 2026 21:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu/Ok+ULr90x0XZPbr5ri7Ioro6aqHM08fsUwIi+sZ3OqbKvlkacmttnvEs2wqHCQ0uk3zni0L0axqKvN72Qv+411D57O7rSsIpXPK6N6V1jx+yzVjiN8ekWJ48Erpdatdj2ZT+rCrkaBnch5GU3kDBOvQLkwLGtELn47/fhm+c9WpSnIaV0FzB3Rrb2bt2PxLO7B4VoxEB4W1Lojbr9FJWyge8tCdSPnmdMsproA8z9UDsIpotOOnnvZKiwR4o/GMIH3bZdwt4komYHyHiWMUo2LJqU/DU8iHe8MhY1wsQLBtAWYIaXRS0YXx0KpnZvDFhEboi86Ds1Cr0BmS7J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9Yd9Y9dFhbC4I9sSqaiWRyQ4obQP70f8fN7/QUBDnE=;
 b=oPldoT/lGjPUytfRmfmlu9MVKxDXxqKR1MjBxrW8Wxa81YNEDNww6PI1MjZYmTf6mtIWYYDY5g9jhz25O1bfThm9+zIqTB5hy5GXZbYir0znEZdVtwkQiAKLtjMTR+WnMpbN2gZNgoH+nRqIBVmG+Tl4aoT1hL43IMcWkuRq4VD/IHwqVmp1POmkOcDSuoeYCsZgj6/u4L5cuMOCix2e6nIfnookSuW9IFR6MPxlGn0aqwZMPHzQzUTY1t+8sq3YsGbLOIwQRfkVyWlXLK9w8vUZ/Av+ZdsESfZ8tJkyuXa5xSKUvqyh1jMtFQ5QvnW/mYuOVHKxsaqj6PvtTnSNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9Yd9Y9dFhbC4I9sSqaiWRyQ4obQP70f8fN7/QUBDnE=;
 b=O6b0sPeUoU8syrFk0Kz8PWlrGM0/h9KnOks1sfcpN3o9MajPkheAufiQVxMzN9H9bsGZei/tmQpWS6+AZETF0Ky5c461amFzFyrQyxpCbpevH/JCN8A1ibYNZ8AmlgyOSppIrVZGlPCEQfHkwNT1x2dmmgLMbSEEUFfIr9wreeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 21:25:12 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 21:25:11 +0000
Message-ID: <d84adc4c-fb8e-43ec-8ea9-7a2fd9dcfdff@amd.com>
Date: Tue, 17 Mar 2026 15:25:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_atomic: duplicate colorop states if plane color
 pipeline in use
To: Melissa Wen <mwen@igalia.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 contact@emersion.fr, harry.wentland@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260316210055.234498-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260316210055.234498-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:303:2b::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: d716dd31-bba7-40a3-cc57-08de846babdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: v4Bxi5Xd0MUky6MR6Waqcbx7VxOzHIvLzJHEfLJplRRClcI2mBeDNqLvQBRBahTq1Q+RovC1ttoZn1YfbroiSBLVk4nNeMKHbKxFs4LLS84kiDT2RXa6z4e0uuqz1J7jzCxhhL3Vmwp8wgTdm0LhTl8ZjwnNYsT/UI64IckGeasSQeNbXpOVp7hircwPMwUX4LEC5M3QEHp5oay1p1dC0G/1XwVhwGHJZCGwfb1UE5OlIYKZ5Jqgxzv/AyqdXvJWuYEAJdlpB0ZRY2bDZmviWHCg3hFEZsSc8VfhmkrN1ZAddQN7V/oVWJHkm4ZPxGa4eFwjiUU+QSALl8xlFuzbz0mteStanNC2Bwo2yT/GnzKC7Pzemq59MZM2K2NvgN/4X8bQXKgdCUd4p8V4XT/3y9ck3U1lJQ2bWtLinB0j5339fvBxqAYtAuHtsqyambKPsM0GDDx3dWeRT3Xzv/fE2NNatZGp9t4jKoMImPsfzU/9OraAdln+uVVL3biBCGjYJptkqspL1fGBxlpyRp/qikS0Cybg1qZZqlpmyxom9QN9Ag53x1ok5puYQr0zuuDc1J3RQERDqNr6/yQTxv57vLrznCrTAWaWupMX3pMNe7Hf19BVILHh9UiYdn+P0t3xPaVO/SlrE12il/2hbijgj7DyO2UPD2L2pcrNHfxp90+ZJp0G303fGyNeXEqYArYsPyshBoYSlMNQ8NRlH7EJZSo9kR/PP7Bo/1rgfoG/xoeScba0y6wiaNbMaPq67Y5APV4W0NH9wQcNtjZTtf2VrI+gw5lqFVeJlk3ntO9mJz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(18002099003)(56012099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZPcEN2L0pxQjNlbU90OFZIRjRBZWJObTB0UllOb1l6NEFaa2VlZkpmaUZB?=
 =?utf-8?B?eTJrL2doN1FrekZxMnh2UmhnZjFFLzVNbHhjSjNCQSt0VWxNUEwxSGVDUkNQ?=
 =?utf-8?B?M3ZGUkdZNmhYcU1QdUc3dVVGb04yV3A3NGF6dzdOUUdSRmdPMldMa3Exeitx?=
 =?utf-8?B?WDlBdHk1Z0ZtajdPRHNtaDZDY05YSmYxTG1IS1VXRmVoNDQ5WGdTaFUrSXBn?=
 =?utf-8?B?cWpyM2pzY1ptelFlVUhFbXdNR0tyYWZRbGIxaWVtVDlGMFZueURKdjJVdy81?=
 =?utf-8?B?NnhycEU2MDdxeE8wZlBERWZHQXJXeE5nY1FlNWo2T3VxVHNraU5QeTZPUkEz?=
 =?utf-8?B?RnlXR2xROW9UdmNJNnZiU21nTUZQM3ZRbHNadXBhOTVOcmNRUGhYT3RMaFlI?=
 =?utf-8?B?NDdRakxvM1NrUWJGTzZWWjVCeXNrRG5iYW5wVUpvZnFnbHhpR1lVYzF1NFQ3?=
 =?utf-8?B?ZU8rRzZwcjlUdVBQSEQ2c2wzcW0xeVNYSkZ4MHN4SWlVYmd5cXdWMTFHVi9h?=
 =?utf-8?B?ODBIbjRWbW5haFFHM3EvUkZuUnAxd1VPbXB4SHpRVVEyWTBjcVNuWGE5MFpO?=
 =?utf-8?B?aWorRWREZE56T2YzZlQyUWQ3OU5Uc2xwSFVxbVNUN1BTR2hzQ0NNOGJpWkJT?=
 =?utf-8?B?bXZPVTliQ2VVQVI4b0haR1RpWDJjSHk5WUJ1N2hKMzBiNm9yWlZFV1FpNDFC?=
 =?utf-8?B?TjBFdnVhcHhjcHhSTHAzams4TlQwejc3NzZDd3p0T01iNGNjN2kwNEp2YVpK?=
 =?utf-8?B?bU9rWjJjdXNCMHdjdHplQ3V3WGhPODdrTkRpNytNdTBHTUtpRVZnR20xVkVJ?=
 =?utf-8?B?Y2xzTW8weGRLMUJ5QXExQXhNbksyKzNwNXUyd3dtblhxcEduODZNcW5uWUxt?=
 =?utf-8?B?QW91M2xJS3FXenVGL2dRZUNlR1hmbS9hR2EySUpMd1RjUEE2RDhuL2ZBQnI0?=
 =?utf-8?B?U2ZCRk9QYTk1djlDYnZCU3RwZTNaZnp0dzkvZ3huNWtTZTNqMXpERDdNdS93?=
 =?utf-8?B?d245R2JhSWRBU3hZc25RQXVvRDhYZ053aUFuOG5qN0dnUjBwYVVNbWpQUkJs?=
 =?utf-8?B?a0R6WEZSVHE5M3k0cmdGQnJ4STZjU0t6eFN5eG9qaGN0MVliQ0hIUFVhS3ht?=
 =?utf-8?B?K2xGeldzc1V5OGJ5OENXbEwzRG1aajJsYWFBSngwc1JnbVJJYVBvdlcwcG9T?=
 =?utf-8?B?MDhzN3hoakowM3g3MnpVZWtmQkRQWWZVdWk2TmNxcGZpV042dDB6cmk5aEM0?=
 =?utf-8?B?a1VlMVFHbzZQTFNVMVlRRmk5RUs0NXVpYXNIMlpRbXhYbEpQcDByMkRXYTcr?=
 =?utf-8?B?V3ROc0I5YzdLRHJzYkdLY2M0QitUQXBGZHRNWnl0NzVmVWZMd0hSUnE2UFc4?=
 =?utf-8?B?bThVNUZDODJDNHpnUnpLaVVwMGx2RE9ma3k4YTMrb3l5SHlrV09wK09yWkJI?=
 =?utf-8?B?cDdDcXNEaEtpQm9mTVd2Ylo1UTA3aE01SnFtZzdwZU5aOVhwbVdjelF5dTh3?=
 =?utf-8?B?NWxySDA1dngvMXdqbHB2MDVMSFROdkxiQjViUytCd25ZbGZsRitacnNOUjd5?=
 =?utf-8?B?TGUvbTVpNmRiQ0hvR25XeE5Idk1QVGNEcUJJVllHZDFMNkEvWU9RZ0Z2cXdZ?=
 =?utf-8?B?TUQ2MldickhGTDJPOVorNjlmYUxwWm9qT1dxSnZJUm5yZHlRTlBSV1FwWFov?=
 =?utf-8?B?SSs2QXhZa3dkWDVpa2Q4REkyQ3FjcFBxdU96RDJIVVJQNW1iNllpVkM0ZXJF?=
 =?utf-8?B?OWRnV09NeHNCY2dWOXlNeVIrR3ZVci9sb1BsZzU3bDRYVHlqUkNnRGQrWjFh?=
 =?utf-8?B?WkJsR0owa1JCZTIwRGQrZFR5ZkxRQmZiMDF2dytDVjcwcjc1WWV3QkxJdm42?=
 =?utf-8?B?cm5uVXhyQXNrQ2l2MEovc1hTTk1veHlJK0pmSWFJQlNFV0tIeUJBbGI5RGZ3?=
 =?utf-8?B?dHRpUjFwOTJFWGV2TVZSSTFqSVhadmtueFIvSFZwU1J5UERmOFZCUDVQZElX?=
 =?utf-8?B?dUY1SGd3OWJ3ZTFERWt2ckRJTHJwTEg5WThsMWRmVXYwaEhCem50ODRlVDhI?=
 =?utf-8?B?RUpPUXQ1ZUhZVlpETlpFV2J4bFZpUXg0MTB2SlEwZ0ZGcUNWcW9tK2pSb2Q3?=
 =?utf-8?B?RW1XS09mTUM4YVhEY01FOWpZSkd2Z1dFSGxyNE5CTGJRaFNvYWxKYzNYdVgv?=
 =?utf-8?B?TVZ1bHN1N2h3SWhDWXdndHRlcGlLL3NKRG8yWFVXY0hkSnRKWmtFSzZ1V24v?=
 =?utf-8?B?Mno4SVRmVDdwMThhOTR2dDU0MzdpbWtTaGl6d3hVTjBkSlEzdlBMbXBCZkx4?=
 =?utf-8?Q?a4V2IjYvDJxcf6/Gvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d716dd31-bba7-40a3-cc57-08de846babdc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 21:25:11.4783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emPh2mnaTNUKNBTQ1JlHOHq/OkUYjDsrBKOOxwf/ujtUyBEWKSToKTknsZiFHLKyDu1Emzm7ch9K0RmvqHInvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/16/26 14:52, Melissa Wen wrote:
> For suspend/resume to work correctly, do for colorop state the same we
> do for plane/crtc/connector states: duplicate the state of colorops in a
> color pipeline if it's in use by a given plane when suspending and
> restore cached colorop states when resuming.
> 
> Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
> 
> Hi,
> 
> I've been working on making gamescope use KMS plane color API, instead
> of AMD driver-specific color properties [1] and I found this issue
> during Steam Deck suspend/resume process.
> 
> Initially I thought I should also set plane color_mgmt_changed to make
> AMD driver reprogram the color state, but looks like it's not needed
> (still testing). Therefore, I think the change here is enough to fix it.
> 
> It applies on top of drm-misc-next and is inspired by commit
> 6955d6bca053 ("drm/atomic: Add affected colorops with affected planes").
> 
> [1] https://github.com/ValveSoftware/gamescope/pull/2113
> 
>   drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>   include/drm/drm_atomic.h            |  3 ++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 26953ed6b53e..683a0e207f71 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   			err = PTR_ERR(plane_state);
>   			goto free;
>   		}
> +
> +		if (plane_state->color_pipeline) {
> +			err = drm_atomic_add_affected_colorops(state, plane);
> +			if (err)
> +				goto free;
> +		}
> +
>   	}
>   
>   	drm_connector_list_iter_begin(dev, &conn_iter);
> @@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   	int i, ret;
>   	struct drm_plane *plane;
>   	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *new_conn_state;
>   	struct drm_crtc *crtc;
> @@ -3866,6 +3875,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>   	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>   		state->planes[i].old_state = plane->state;
>   
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
> +		state->colorops[i].old_state = colorop->state;
> +
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
>   		state->crtcs[i].old_state = crtc->state;
>   
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 0b1b32bcd2bd..96fd32a3e92c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   		for_each_if ((__state)->colorops[__i].ptr &&		\
>   			     ((colorop) = (__state)->colorops[__i].ptr,	\
>   			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
> -			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
> +			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
> +			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
>   
>   /**
>    * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update

