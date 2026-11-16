Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00E606A330
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=jWHFnqE/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2520110E2FC;
	Mon, 16 Nov 2026 14:28:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1CC10E2FC;
 Mon, 16 Nov 2026 14:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2ZtyXSmam4gwikw2ZLLSamiFg08UwtwqPX1gluuhPllvfsPArMVYPgZAfs8umgDkNyiT8Gju+r8PBhxtnMdeLSqjG0zfS4yCE05EMdedzmPP0PhG+P5LOrsbOZsKOdt2YLw29jlBn41azArIYXSYOxnroNKjA4PILVMJB7Y10MFiyApr9nRd6CzM0DQjAlaBnbrPoklNZXiJI/PqW/7pvfeL1lXDZdC9wavgGifzU586VNPd4L9kfPO0pTrCieFo3IVJ5V1ukw6QHgmj+ZaeUo2XYKW+wJCyqPC7c/vyUFkDISceQcskkdo+viYQwTCdF2GkOHZjsZpYIZmxJ1jdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fef76ZpjT/3HIgL/TSYhpLfV16yO3l4lmdpMMYdUwfY=;
 b=rs/BICUNX8GmFbxLY1q/o5hEGucet37IGNR7Q91qcdL4DUMN5y0UcUdlkkXinbMtv+ZqbJIoOTTdY9JenZ0WFRdQS1JzwTHCrRR039GCvajCB06mI24pifFo3Bndku3AQx6/iV3Wx4Nm3MM+XQ+Ynfgh0XVlheafERc+bkhihMMpRx4GoOzQwcXL4NjCo9/jLdb6eo4d8lDxHndDY0mm0fSJTpaCPiUBzwpIQflbpZhA2i5oxWNX9ohtA39nSo03UKl+Xn/nx4nMOomPbCfB8G5kYI+xB8UfcWsoSRx6bjQsYg5g15PHIqbnCg8vjp+OKAvqdgY+uhjSiFeakjF6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fef76ZpjT/3HIgL/TSYhpLfV16yO3l4lmdpMMYdUwfY=;
 b=jWHFnqE/Cosq73hFYwwF+y1mzxz+GOmlEz5wJ0He66bdRWVS9XyQDAzB/2eANVPapQ4gKJyqnF+sa9blmz/WXo6PH5UZvNMypDlWxnHAfv49iPkz+2gsz87jdWMqsBumjj/p8RoT+e0MS6GVh0h+zw/TSr4U45L5n5evxGZh46M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:28:09 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:28:09 +0000
Message-ID: <393a8963-ea40-4ee3-85c3-ac2de2f90d75@amd.com>
Date: Mon, 16 Nov 2026 22:28:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] drm/amd/display: Commit panel_power_savings writes
 from the kernel
To: Hugo Sales <hugo@hsal.es>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <335815674.648716.1794838310991@app.mailbox.org>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <335815674.648716.1794838310991@app.mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|DM6PR12MB4217:EE_
X-MS-Office365-Filtering-Correlation-Id: 650e6665-c80a-4512-3d60-08df43edd616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xfwrJ44khjsN0/bIjlDLHlQ8OfEWr1cNH6h3VUbDqVZcSW3qmSU3rNEi5Xrikfdkh1Q4tpTklu4K5rYAh4/g7ZYIaeBXfUgDldgQpzl8qq9DVbUqdNsXGE4VJQDlE2+MapPxrEWDIocurpGMndXpMImQ/0s51DmtKqh+Qf45m5+3wExmB/1rh+trG2OYmneYwWKKqiQgdFrLcn5ISSPq9CRsi9RAjeRusOoN1BcZo0747dy3p/G+yIgIHXHKRmFuG7nNcJlWdQ1WPQWqW3EbDiO3dFkSttye1kr09biQTgaQOC3Nmyt3wCMQ1OfiZabpVnOIbQr7gvG+sCB7Sfn/7Ls8iQsqgVGTTGNzNe3lYv3EIcFE08wM4nNI8OfgCgQbEvH4UK+iaWgIdNZZZiRFlxQUAjh/M6/O99z49IS50HJgH+bVdL0Z8gwTOyLNjJHAcpZuyR6+07GEVhfPDtV/EYuALIdX2S6YR7bhbmMCNuAcRsw1zQs9cloFWZmnFjJo40oCgw2Mq/LMZS5iIBKocpBvpWwsolaMIS0BRu9VAEgadjfmtDQIC+gWUu3ng2QmEkGN2jLHEU06FA3H8HWuIhCJJuox9zrq5rqF8i93EwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExwSXlQVGw2Znl4L2JoSUNKVkY5K2xyK1E0bU1ySVpnMm5hZm9EaXhad2xl?=
 =?utf-8?B?eCtPWDNRMjg0T3UvOUpqT285QjE1NSs4YTFOemtFYStNZnlzSVNmQ0pNb1NF?=
 =?utf-8?B?eENLTXl3RlNxTVVwSlZBNzVLL2c0ZW1wTWxnUzJyYmlVUzlXZHRUU2JsSFgz?=
 =?utf-8?B?b3VvdkEzb2ZuaG5qYXQ4c2FLNWdSQTV0MXl0aDRkU2piN1V3VVg1dGhQRVJw?=
 =?utf-8?B?UUMrZnQrU205WWpDM2x5Y0JkVjN4WGljN1plZ2dxT0taYnBpb1l5WElRbjRo?=
 =?utf-8?B?enNHYllJc3JYMWdWQ0lpNGN0QmpxaW55ZythSGw0RnJpTEswcEFxd0ZrSXdQ?=
 =?utf-8?B?Z0trbi9YNXVVV3lzVU9vNHNYb2kzaGRpWm0zbTcwYnE1YVNzc21WOGZLQmhl?=
 =?utf-8?B?ekV1SnFYWDlLT1NvUEFSSVFmYlY3bzIyT25SR09zWWpnVTFmZkYxc0tLd0pt?=
 =?utf-8?B?cUx0eUpURmJUMDVjTTI1azJwb21BV2FzYU14WXpYM1Rsd05BL0ZWZzhYbGRC?=
 =?utf-8?B?U2tYZ3FKRGk1ZE0wajV4emFONzU3dHhRaXIxWk1MWUJwUjJRMENOWUg5eEtH?=
 =?utf-8?B?aEhkbEMvNjgySmlqU0w1VzNOdi9nMlIrTnBCVjZjN1VJUGpyUEc2MEJxbmxC?=
 =?utf-8?B?SmkrYk5tU0lrREhlL0thTWQ1Yk0zRVVveU5rZnVBc1haa01wTmxBL3NDTExw?=
 =?utf-8?B?TVcvKy82NjJpZURkaWwwUUYzZWZlRmFRRWJpOUlFQ3NiaFpsUVdtalpNODlV?=
 =?utf-8?B?aHpYWGM2WFJhYVU5Q1VKdzVTQlpOeXhpOEx4c1hjV1JPWXB5OGtKUTJwRWxI?=
 =?utf-8?B?aEJSNVVVaGNhSVp3S0dmNnBpRDZBek12ZG5yZ1lYai9HR1lDcmQ3MGtWNEs2?=
 =?utf-8?B?VytGZy9uWEwwbDQ3eDF4cG1wcmJWK2lZUFVkSkJPR3IwTzZyZlBxaE9XMDNt?=
 =?utf-8?B?RUYzMVV4d1M1Z3R6c2NRcitxWHNSU2s0RmY0bVk3aGR4SHpWYU9IdmYwTkRT?=
 =?utf-8?B?VUxuK0Z0WFl5cWNXTVVOc0NhbXBka2NEdkFWV3YxR1g4dVZCVXh5bEF6Qml0?=
 =?utf-8?B?eUdSWGJkWU9tOWFKR1AyeFU4emNsa2kwQ0Jhd3NjN24vZkM4dFI4MFVzM0Zh?=
 =?utf-8?B?QTdocVIxU0hMUTROQUV0Rkp1dnJra29BMzNYNktPNHFPbHl1YjA3N0d2cFVH?=
 =?utf-8?B?eEpTR3h4NmtMNzJwblBTQk1ZdGM0bEo5Y2JRWEMrTkxCTjZiY3FlV2VLM2w4?=
 =?utf-8?B?Nm9rYVJQUDBBeW9DV28rTis2cWJiVjVraWRobmRUNEhiRWZiL1dHTWVhMmJq?=
 =?utf-8?B?Uk5mYnZUVXJrcE5OWWZ1dkFRbE9HeUNZTTRnam94WHJ5enVmVmROdGx2cDE1?=
 =?utf-8?B?bU9zcmhnajlZMzJmRk1TWlhONmZENDZEaEpNYVhoeExyTzdFQjJvWllXZFZK?=
 =?utf-8?B?MGNoWElYUmJBQmVyenVDMldFNXh3S2RyNlJLOFZvSUZsYlRTa0R2YkVsMFRz?=
 =?utf-8?B?bFlpSXVMam5kejJDcVhFajV1SVo1bitpWU9XaG5DYkRsMzVaTFlQWkRWMU55?=
 =?utf-8?B?MkZESHNHc1B1Vm1CWkgyUzNoVGp2bXVpTUpCOW5KMHZhUkJveU94Z3pwQStu?=
 =?utf-8?B?NVhyLzViK3BWR3FJQlA1bG0vTVZCa2FHWHVGbTVBRGNSS0N3VVRBWnY0V2U0?=
 =?utf-8?B?RzZEb2RsQXdOK2hkMXZUQk9tbkVJeFhGTFcrS0F3VXB3Y0hjcGJXUW5yTHJx?=
 =?utf-8?B?NmtaRjRVVm5SajhBWnhtMG1nRXVsaDJZU2JEL25uTGV5K1lTNGdPWGtVZVpo?=
 =?utf-8?B?MFl1VEQ3ZERuNGRzdWNybURMRkorTkM1WHMvUGRla1NDa1pyZWlJaVRaRDRr?=
 =?utf-8?B?c0NEYlhWeWZIcXltYWNyd0RiREtWN1FOM2R2NXEvalNKVHhXbjRHaUN1YjRq?=
 =?utf-8?B?a0tvTVZIT2wrYkhjMitwZDdEaUVVQStZOVcyZ2Zwa2o2Nmo3ZGhacVFaOEJ0?=
 =?utf-8?B?WHM0TlpXYm5ob0RhbTRTcWw4NmdjN2Naa2R4c2k1VXFlVnIrczNqZ1FnNWlU?=
 =?utf-8?B?MWo5cXJmSVlLeFNNSEw3WEFFVDAvbGt3ZFFQeUdPNVFmdE1QME1Md2JkNHYr?=
 =?utf-8?B?TXIzRzJwWXRpY3hSOHVOYkpDTDk3SUNjcm9TR2NYVlc0VkdWU0NMNW9vOUt1?=
 =?utf-8?B?NzErcWliYkhZKzdqOWh3elpJby9QNyt3Q0FPdXpZLzNic1MzbFdraFdJakh5?=
 =?utf-8?B?QzdJZjRsOVhYWW1HS3RjZElhcU1rWmFicFBxZCtxMzZWMGlsUU9YRkJVNTFo?=
 =?utf-8?Q?OR4lMzcxSB0hx9zOa6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e6665-c80a-4512-3d60-08df43edd616
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:28:09.2528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwkzXSw6W0X+I0O8WOpOo4U6AJIkSDvDxR8LUHQzKV55AnlRluH+b2lAO5YH8QtCYwzZKttZIxgMhkl9E6NE4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/2026 10:11 PM, Hugo Sales wrote:
> v3 is out: https://lore.kernel.org/r/20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es
> 
> It adds a patch 2. Without the forced modeset, a commit that only
> changes the ABM level on a CRTC with VRR active carried only the primary
> plane, and DC dropped an active overlay until the next flip. Sashiko
> reported it on v2 and I reproduced it on my laptop. Patch 2 adds the
> CRTC's planes when the level changes, and the overlay stays with it
> 
> Patch 3 now credits David Weber, who sent the same change in August,
> and patch 5 says a compositor commit waits for the write instead of
> failing with -EBUSY, as Chenyu pointed out
> 
> Chenyu, if this week's promotion run hasn't started yet, could you take
> v3 instead of v2? "Leave self-refresh before an ABM level update" stays
> at v2

Yeah, no problem. We'll use v3 instead of v2.

Regards,
Chenyu

> 
> Hugo

