Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFF1606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rRljg6Gb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D7710E687;
	Tue, 24 Nov 2026 19:04:13 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EA610E687
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgrZedBUVWQ1n1v5Vj/Sxy35t/Sr2FKsLc31zFEYN+kjO0S8q/thhp+q+4IOFBf1gB8PKoSWntUHlwI7BAiSdqLQ2AC5HiCldXSrqA+1S8RMmZkvSC9GjkvbCrC6WN/SDsXzvPZ7NvqJKA/Fuk8hMGNUN1mL+BJmKDkG85VBzlCZz1tqqG7fqudXwVChG2LOthzuznpRtzTJcVY8qablyAj0nVwMNN0ahK3+UJHnR7wzDto44cnnLcFdr43NG3poiTdo8MDXe3/cp3y+Ty0G3xwWgX+vyQuQIt9mVGFJ/YfKasAE3jAXZ8oSduU/qZby9t+10uIC5LOyfPOuQAqnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/rKhJrZeDpSh5eofSsCV6i7Y7UxU6qPoeVIMsSmB6Q=;
 b=pVyPJXmyeOvlu8LBJ1jrqbGoZubG1rrcY9dNF2scFEWQZSoqZ2Via1oJRwY9ktzoGaM8Mv5pGXZZZauAT1vfpXnAVa39yUGBRtslpKyM7ejzPuAa+FdlpOVE7Gulg7jbi0TO941Uz1WDjjRJ7YN6eUgXEhdqEAPLnsuKbFK29Pkxc1xfB8oX6g6mpKSLFiexHcrdPkG2KKEpOVsj/afZ/8qKQcxi5b+ArmorytSuADtz4FUYY1LKxHtThGT1jeWKFDfNu9+axOaar7BTHt04TACcFDcLKF3yh+aVFU4fZT5FuQ8nq/xyJzslu10Yz0/d7348pDBTGvdeXpK+LOXmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/rKhJrZeDpSh5eofSsCV6i7Y7UxU6qPoeVIMsSmB6Q=;
 b=rRljg6Gb4XLmYrnJhUZsz9nkiu9a0CPf4/yelM/uGV8buLy0KLEGBd0WSq7gFfkINQxLvsXtQu0F2qMOuq+TFgCVB8g8imY4Lj2j8NiGHMjukPsxC4fpHAfSNF57uniT4vCt4c1so4xV5bVVSf0pTz08pAV9bKvgBvSN4KC05vk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 24 Nov
 2026 19:03:58 +0000
Received: from IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257]) by IA1PR12MB9062.namprd12.prod.outlook.com
 ([fe80::28c6:3cbd:6e97:5257%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 19:03:58 +0000
Message-ID: <e9d1a0e7-ee30-46f5-854b-262c72062e96@amd.com>
Date: Tue, 24 Nov 2026 11:04:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Reject zero length user buffer entry
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 mario.limonciello@amd.com, karol.wachowski@linux.intel.com, max.zhen@amd.com
Cc: linux-kernel@vger.kernel.org, sonal.santan@amd.com
References: <20261124183914.1955667-1-lizhi.hou@amd.com>
Content-Language: en-US
From: "Zhang, Yidong (David)" <yidong.zhang@amd.com>
In-Reply-To: <20261124183914.1955667-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::30) To IA1PR12MB9062.namprd12.prod.outlook.com
 (2603:10b6:208:3aa::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9062:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: f3a1716d-b711-4019-5a32-08df4a5db16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026121527099003|18002099003|22082099003|56012099006|261021123027099003|11063799006|261102123227099003|10067099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: uf1Q9zHr3B662BPYzbmqg2qDVlrebnqlK3Eqyrtq0SXL/pWwbDe9zNfwLcLRi/ws8Ql1V+yOH79wMa8a+FQk4oMmu3DBf7bt6Gb5OXAgOdAqOyghBdl9O6BHJWbFXhO9KxAzSz2iFUwrqjVHGcVCnFZ861gyIUKMxq2X2HdILXN29nd+TPEOiIqIZddZJG5du0PqnVOxSukZrzBFYRLwOh5KzbNiupdzsvF8hAeolwlWxVLkylcP6+u+ViHiZIxJhg7tHstww/k2DlIh3fS+L5/3BbZYd22a5wJ5RVF8ybw4Fvgu0f8u6so/0SgLUa4Gs7RNC+sqkBU8+Z57+RlHae4DJLeRSyyBBeEjxOE0N7z38Rf4duBwTGtgzpdolVlpidN6fGaQEttbb4HKjRWRuAZCTUHjdnmI5ofEQU38af3Rj3ifFT/J101gw+jYNPyp0bo2jPvmNhsnOsI9G7242Q3D27g9AjKkq2WvXCMAxCXHJfZdHB+E8gNuXdXIXIaHaDvmnq+XVZGqaOjWfx/N2pKSb91lm/FLFVj3qnRodAA71EIM1B2FoLOvGludBwSAhKKLfKhK5ugT9PUrfrumkzDudSA47UcQTIYnZlFA4r2TfCNQ0yMlQlZI9ZQLZP8HrxDoTrCu/9GArlgGOQjD9tgJfOlu9wGiSoKE8oRiZjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB9062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026121527099003)(18002099003)(22082099003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(10067099003)(261009223027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEhVTEpmRVNLM21ERDczSXBobktFNVZpRTJnbWMwNzVnVER1aythQm90c3E4?=
 =?utf-8?B?bnZ1Q0JFcG1Gdm1DVHA3RWJRNFFOanZ4eVowdzBWZ0N1ZzhZQ1MrWngxbVVh?=
 =?utf-8?B?Y05PMHh3bVhISERGaEFMRko5b1Z2dW5Fb2xHQjgzeHZxU2hXbXdSMnpTZFFO?=
 =?utf-8?B?Ui9NU3lFZGoxSmdvVE5zZmdYazVUZ3VmK1c1ZHpwb2s2bHBvZTg4RHg3Z3lz?=
 =?utf-8?B?T0I2WnYzQS9Wa2pvVTcyMk9hU3B6MnNwNDQ4Z0tyZ29ETnBRbDYwQ3hqQXk4?=
 =?utf-8?B?RUx3M0dEKytTQm51ZUNhN21KcUpKKzRsNHhFNzNZQ1ZuejI0SFNxVG5rVC9x?=
 =?utf-8?B?SCtQUnoyZnJYSUduL0I0c1JaK3dadUpIdFM5L0JVOVEwS2podHFLeUlMRWJW?=
 =?utf-8?B?alBQUGpFdzNiL2NPMkZ3NURwV3M1WVdsQTYxemRqSVBxTHdpdm0yUnFIdTY0?=
 =?utf-8?B?TEFGNkdMN1FWOTBreVZXenlnYW5iTXpsbXMwK1BjTHNCQmw5U1UrVlhYcFhy?=
 =?utf-8?B?RGFQRnJWdXNrVXNHbFN1U0RiSFNnQXI2QzRiaVZZU1NtZUJmd1lTMSt1ZTNj?=
 =?utf-8?B?QVArTTVKRnpYZjVCbmszY2l6NTlJeUREam9rTGw3YlU5dHRsNVNoaldZajVD?=
 =?utf-8?B?UUc1bjNGcTM5MmpBL2pjbHM3WVdRL1QzZzFUbVBDTGVYS2Q5QnZQR2lPK0hz?=
 =?utf-8?B?OWc5Mlk5ZDJOeUxNOGZlN1dyelM3Y2dFYlhzV2VBOGZ6RU5oMlBacWJCY0FL?=
 =?utf-8?B?TkI1Tm51bGdvUWhpWENjZFozK1U3QkdFdlRhZ0tUeFQyNHJidmJQOHZZMk51?=
 =?utf-8?B?UVBvVXQ2YXcrY0c1OVVvSS90L2c2Q1pKODBsYXRrMmdIQW9jeHJNRmxOblhr?=
 =?utf-8?B?V3pmaWZWeHNRbm91cnoyK3NRZ2owVlh5N01hbTR5dDRFRVVNR0Z4VHFWeFdi?=
 =?utf-8?B?ZWczUFpTVjR3VUc0TlhOMUJEdzlUclF4bUNIaTU0Ujl5bXh5N0J6c0s4K2VP?=
 =?utf-8?B?TVZHSVFsc014dHU0RzlydTVDTnE5ZTlwLzZYT2QxZkJhbHdleE96cjdybjl6?=
 =?utf-8?B?WlA1aXZZcUZEa0RINjNQK2dwelRzanpod2hhbzNSRXl1UTUwUGRyb3NFaFEy?=
 =?utf-8?B?a2Uzd0habnIrcElYT0VMOUZqdlErcUlHd2k3TnEzMTFnNkpWdi9jUHJEWHFk?=
 =?utf-8?B?RHpEbnJHWlI4MlM4R0xObGordmJXM0w1YUZtVHJIcndzUFdzVlB3NmcwczV6?=
 =?utf-8?B?STY1Sy9FUkMwVTVaUEo2Tndva0VwQmxVQW13RFpCY2VOTVd2QWhRQkVXbmZY?=
 =?utf-8?B?KysvVEpvSTJTR2Q2Y1psMzE3QlJHVFQ5Y2JYSlVPRHhyYkFuVzRHMFdsaXpC?=
 =?utf-8?B?VW8xc3dHaUdiVk92SlRUQk5UNjZFR0Z2MGtKdmNTMDdOVU5pdTJweXRpWmlC?=
 =?utf-8?B?L3Vxd1gzOU9VTFVoMmpWWnhWcld4YW93N2dJZXFsaUtDNHBaeVRFSWJKQ1B6?=
 =?utf-8?B?dHNsMnlZR2xPQm85eFR3QU9yZTdMbFpMb09QMFBibk1yNE0wbFFlb3R1eEZa?=
 =?utf-8?B?U0xMQzQ4QlpmUTN6QVE0YmFpMDc3U3ZXSytPalRxcUZSSVJ0T3k4M2orVHdV?=
 =?utf-8?B?Qnlwc3hYV3JSZUhUSDF4cVpJamRrNnI0TUw0a291b05NeWI3NW5IMGR3RVpO?=
 =?utf-8?B?bjFNNVZBQmFDZDVpY0d2b2ExMGlzRFZzQkFiUUtHZTd2VEF3NEFtdUl2c3hC?=
 =?utf-8?B?Z1d6MFhRTnJOQW5PVmM2VnE5eGk4a2IxTXlqbVFCRThXb0wrNXVFWUZDYlhy?=
 =?utf-8?B?SUUxRnloQVN2Yzl1YlVHaHRGMDRseWFldmhHcjlDS1VkUlZCMFdaRkxqOVFO?=
 =?utf-8?B?T0loOGlDdWtFeHRuY3c1VzBkeFN5L0NFUERSMHVTdldsbTI3TXpvYW4zOVRk?=
 =?utf-8?B?Rnk4WjBXNkJlRjN3b0VVczFCT01IZUZJQU5wODYvYVZXc2kxUEUwZTkxdWkz?=
 =?utf-8?B?bFowbEFCaGI0YUVialhGMno4S2paeGh6TkRxSnk2SFFCak5UekdFUmJxaGRu?=
 =?utf-8?B?ZjJ5QkY1aHQyREQza1NoeWNacStPQUtCWHB5dDFYd3lURkxaN29nbGk3Q213?=
 =?utf-8?B?blNXOXNQNHNnNlREVzBTakNDU0hya3hmUDhvMUJBVmxEMk1GemZJMGY2a0hT?=
 =?utf-8?B?UnBYRG1mb3NxaFBIVGx5NVBlWERoeTFQbk1vRHlrZU1SYmdhZS8yTVJpL2gz?=
 =?utf-8?B?K1JlUXZFVGRGVTF3b0NINVdPVTBIbzczVTBZMlMvR0Y5MzFHbUczV1dRaUxs?=
 =?utf-8?B?R3hHRGZwOXdmMWduWnNrWjh5RGZRSFdGWW1nVFBFTUI0Q0hxdjZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a1716d-b711-4019-5a32-08df4a5db16e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:03:58.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91ZFOLTIhikWvZPnJ7vQUtqRCfY3iQj4D0EnfBPjJ2AccLfQu85+ZUSOAcosBKPsQ27m9cdkLhD7N9uR25twnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
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


On 11/24/2026 10:39 AM, Lizhi Hou wrote:
> DRM_IOCTL_AMDXDNA_CREATE_BO with DRM_AMDXDNA_BO_SHARE_DEV_MEM takes an
> array of user space VA entries. Each entry is validated for page
> alignment only. A zero length is page aligned, thus an entry with
> length zero is accepted. Such an entry contributes no page to the
> buffer.
>
> Reject a zero length entry in the validation loop.
>
> Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/amdxdna_ubuf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
> index 0e0cd69cd1fbf..93b2b6496a0f7 100644
> --- a/drivers/accel/amdxdna/amdxdna_ubuf.c
> +++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
> @@ -111,7 +111,8 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
>   
>   	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
>   		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
> -		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
> +		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE) ||
> +		    !va_ent[i].len) {
Reviewed-by: David Zhang <yidong.zhang@amd.com>

/David


>   			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
>   				 va_ent[i].vaddr, va_ent[i].len);
>   			ret = -EINVAL;
