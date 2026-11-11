Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B92606A89C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=halrMwUx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120A610E90D;
	Wed, 11 Nov 2026 15:09:30 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8980710E374;
 Wed, 11 Nov 2026 15:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkO3kdwXpKddy5xJaLg3I6wi7RRrvxzPVAcl49iT0bwS/NVoVidnQAAdPsB8SnvCOMDo9tsUpauO/3NlQ5ltrTaEh8mSVPh/1VYwfa8eqO2hZ3FGlL6El7n4XzFTSQxyjxBnOvb1XXycIULY42ePX4YnrsaiMxx27EMmtsSp6idV9m5K269LQwHxn5yJpCmMXK9po4ZFJ2jndOvKEdF0WSjUI69v3LRArdQRRcJtQ3bp8AVDZXvgTX3dpsnbnoH4k+L4zUfF10A+f1Gx9gXSo9/7U+hwT5ogUt+WX2T2XuSAuO6ewyAqlk8pCoTxAWK3eVYrioxJ6Vjk4bf1xs5qAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N+Yt64fgrxou9eSzZyi9BeerEWIbfKma/snX3AYIis=;
 b=AfmYyuLK5iVb3Vh+VI/qouRVXrIUF47b0V3G+I8K4xgSC3mbeJdW+fc4VooqFIm6KW5i9XzQ+mYmGm/8K/4ETlsFl9O2Z7s2gG9PNFKOo1oKks0/Ye80ICZvWfhDVe5ApC4PFo5ty4BNjS9y0C4Dczt6AfyIZ8Y+m7ViUWMD1kQZbfD8xAlnTIP+utCuhP5GkuWfAHdpwwyhAi13SIYcdZF/hZb5PkyPkyEOw3PCVSMNG9zOQ0kCIVyS3HPDAhcifOQqBlwTqd2QkEiSbtY4yYf7/fLQoGQp3GceML+bQv+aYR5907QlEQ8P3rDUM1sWPrVfj9BfXNBxRGq8dKvh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N+Yt64fgrxou9eSzZyi9BeerEWIbfKma/snX3AYIis=;
 b=halrMwUxEoHnF/Ogo06UuRPIFTqbqnZhfbS6PIWWD1VagdStyM9qWA0uR933f6QFFInk8Q1ia8SUQvM7IN/JIdrln1gID4k2IjVUKlQ7ohlJHhJSE0wLcxnDziW/IV+MUdZqFhkbulrnlfJzDGcVT6mRBxV0UtC4NnbgAql18WA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 15:08:47 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 15:08:46 +0000
Message-ID: <13f307d8-7228-403b-98eb-9caf9cced4c9@amd.com>
Date: Wed, 11 Nov 2026 23:08:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/22] drm/amdgpu: AMDGPU SVM support based on DRM
 (Phase 1: single GPU, XNACK on)
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Huang Rui <ray.huang@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0036.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::8)
 To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c0822d-e271-4e8c-b19b-08df4005aeaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|261022075727099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QXsS6W5g/dNt6YwVVq5xPwYrJUF1ag44VMI+WeQ+mBm7Mn5feYVGJMArmKowovFEQKU1mv37kxE4sjcVMgPC8S9L90LDVlYaEwTtVBUte9GrHmODgw84ZWeVO8ZlHm0odxp4T4pjbkR3KEVIQuOOvRrpCDcXsioX8ZJvoJe1f+jDP8fy5vUOVgXIU4RQ9xGVns2EkmwEjjACsshc1/97Qw2aItItcV1RVh0dbhNEn5DVoqbSYoPSNjmS6DI12RR5+e+5clvyC67b0tOPkKiafYvvi1w5IbZK9GdW+j2hP84cmmpgOod+0c/5S5F/XniiuHpBWhjkA3ipyHVvHx1r7wxkJZAzb2A+g+6Xks0gRmAfkqVO3U2gZ1SYrkhH2ckVfYvZZi+Dlvmo43ZZS2rxwbWRjIGAyMdlMxvfKpnsmfBfSmkmdU4mrWObugExzb1IhIbmAeZSNktvR/IvPdX0Fs52OcQoOsnWwXHXm9JNSlxosFXH0RjK5KqOXjvE8KtcIPUZkO4PinYHuotmkC0SpEuDE5O9iSbpqHkxh6FyTBg1I3jQQUVPfO7wyEphLOLujiFsbnyZtyuC/fYk7wFI6wj9kLxwXFGkFAi2SFR/v2/WrqJP+rRK4oK/lcK2FYQd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(261022075727099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXNVd01VZ2NXMVNDQzRCTXFlR1lqcyswSitkTE9Wb1BLVyt5amZHNEJsa0gw?=
 =?utf-8?B?SG5wR0J2YWFLREozeGxqeHBsdVNEMWhDTXdEbVhoeVAxM29DbEd0aVVEbitW?=
 =?utf-8?B?UlZBL25uNkdmTCtzd3dkRFZWeWRlVWprTFNLVjJMNUNnM3ZKMTZvbmZ3eElm?=
 =?utf-8?B?Q1RJcXFFa3JBQXBTZHVVN2pLcDk0TFJzWlU5WExMcWpZR3NnTUczSnE3MUZV?=
 =?utf-8?B?aytNZ1VYck1XdzFkdzI5MGoxVUNib005UkVhUlZEd1Fvdys3YWhCNGFVVWlz?=
 =?utf-8?B?dWd0blcrd3lEV1IzZTRPYmhjR3p6YlgxWEpjU3duS2x5QWFXbGM4TU1CclJL?=
 =?utf-8?B?MkxGRTZoWmVYWmErdnlOeUF4dlJJWlV5aFk3WUNQZTZRd3FLQ25Jd3dmb3Vo?=
 =?utf-8?B?bzBmM3FNd0lINm5FVTNEWEk5djNHWE9PazFWMGIwZE1CaXpnTmhTOEpMcFNs?=
 =?utf-8?B?NlFVWWp5NWVEL1prUnEwK29OUFBQWEp2dEQ2d0VJcDVHY0JWWXo3UDdteGtP?=
 =?utf-8?B?TmxxOUorWEp1RVR2N2h4ZUtGMDJGWVFRbDNuSW9ydWZnQnZPam42b2F1djE4?=
 =?utf-8?B?dkprVlVGSktIRmYwd3JDYnc1aUVXL29oTG5iZ1diTFZGS1hBQ2FmSElrNmQ0?=
 =?utf-8?B?VUNMZVR1YUFKSGVlMW5LMlJ5ZnhkSU9LTXZHK1FjZ01MMWZycEN1YlZFcldV?=
 =?utf-8?B?NktMb1Q1UngzaUMrTDFjT3VaQi8xeXVjTFR2cU5UeTVLVGVzSGVyOHEvb2p0?=
 =?utf-8?B?aE1uRmhtZktPb0d5ME5lVXBSWXF3Wk9UUy9oUFR0dFR0OG04UFRQcERSNjZM?=
 =?utf-8?B?THJkaTZ1eDk0WFcrOU1RKzF1WXQ4YURYOFdZOUhQL1BReHhFT3B0S21HMVVC?=
 =?utf-8?B?ZHZaOGUxV0lPNjFjN2NBVEtjYXlYRmZHSnZ3UWZqOG9zZXNUSTltbUJrYVRw?=
 =?utf-8?B?OTVIenhGMUhrSmZVL0o1YTNLMWpxSFpsMFFLZHpyYm5RZUY5SG5WM2pRNUJa?=
 =?utf-8?B?bzd5ejFoZHJpdW12QlBtc1JvaVBqK0hLcEVVTGNacFN5czN6dUkvdzNybFlU?=
 =?utf-8?B?QmdUTXdFbUQzaGVzT3VjSS9LTHVOU3hDN0wrazFFSThRNEx6R1pRaU8wdkpL?=
 =?utf-8?B?T0tJaysxWlZ1ZEprYm9rWGpleDNOZHJvSmFrZVF4NnIyYWlweGtObGRwcGE5?=
 =?utf-8?B?ZFNBMHBSYWRlbWJEaVhzZi9HRkZHK0NFSnZmaTZuZk9CcWFMYVVBUTVkY2V0?=
 =?utf-8?B?em9HZXdhZkRaNGx4WGZEME5iKzQ1c2xMZU4xbEJTUmVuV1dqVUo2SDRDenZq?=
 =?utf-8?B?K0xzdU8xS2dkVWZqQkUzOUlBTVVrRUFjU1BvcFovWjRMLzBDS0hTYW8rczhI?=
 =?utf-8?B?a1R4UVRZd0o4UklzWFNlUi9ac254WXdaa21hcEozNkk4ZjZiQ0hKSEgwSG90?=
 =?utf-8?B?ZHpBZlJma2Z5Qm1XRGM3NnJ3aWN2Q3ZVd1VWZTRCaVpuTEQwcDdxT3JMMW9S?=
 =?utf-8?B?UFFpVjUyc2ZkcEg4ZkEybzNnenBwVkJXYmh1aEplbE9BM25zTlZON3h3bkYx?=
 =?utf-8?B?WGpwN3FRYW0zdzJmeDIxcUZBTDB6OE15a2J0dXd1UlRFQUFXV0FqRmRSQUc3?=
 =?utf-8?B?WWNUM0JZZWczZ1UyS3hzeFRiM3RmdFNSVEsxeENLRk5pMlZMYWpPY21ET1J0?=
 =?utf-8?B?NkJpY2d2Uk1TR2wxSlF6UUNnQWhZVkpjRklXb0lqWHhiT2xkdm5NL0E2c3pZ?=
 =?utf-8?B?SU9NUEVmdFZpQUpBZkYyNG5IYlRCWmdIY3dqSEpwOGlIckpNaHlwRGc0WE5K?=
 =?utf-8?B?S0xJZ0JzTDU3WkFzSWFkTWpibFVOTGlFRStTdFk0cGVEYmgwQTZDd1lNN2VV?=
 =?utf-8?B?SVRaemhYVWV5TzI5Q3lYZFJVQ3VjaWtYS2hsaHpuZEJzS0ZzQS9CZGJmM0RL?=
 =?utf-8?B?UHZwVnhzdUlpZTRmdkY0c1hmZ3JtK1Q1RW1GZ0tiTG90ZjF6T1gxV0hhMGZr?=
 =?utf-8?B?MlAyUFZoeWN6U3VCbUkxL2wxOFAvUWU3YzdqUWVjY01OMVE5d2xMUTN2NDRO?=
 =?utf-8?B?QmpPSjNvd2xIeEZETDJuQ3pSanZGTkwvRERNUU5RQjB0bHVWY2UrRzRVZHdp?=
 =?utf-8?B?RjluMlVRQXY3RURIRnQ5WTMxR2J1NFc2NU01UjNmQzVvOERzWHo4NElWV1Jq?=
 =?utf-8?B?Y2pyVk1JV1dsaWNON1RwTkVjU3VWODVxZ2lWR0JIeGNOKyt4UGxTTnV2V05t?=
 =?utf-8?B?bC9GU1RCRGlTd01HTUw1OVptL3ExSHdmdVNNNkdZWGw1eFVnT09YaGxuNElM?=
 =?utf-8?B?RThoU2k2Ny96eXVvL1dKUUx4dFFuVFpLSXlvNzl5N0x0L0dzcURQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c0822d-e271-4e8c-b19b-08df4005aeaf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:08:46.4463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ4FeQkSTXPZWHZ68FsHgDzBYLpsoY8q2ORHaX6oTFnzHfcBt1e5mnVbRTwZA/up9lcDWR4QASDnJUB0tGC0EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834
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


Hi Matt and Thomas,

We are working on amdgpu SVM based on drm svm.
Christian has a very full schedule at the moment. He mentioned your 
expertise in GPU mm and SVM, and suggested that us reach out to you for 
a review of our AMDGPU SVM work:

the v10 is in:
https://lore.kernel.org/amd-gfx/20261021025915.2433837-1-ray.huang@amd.com/

If you have some time, we would appreciate your review of the series.
Your feedback would be very valuable in helping us move this work forward.
Thank you for your time.

Regards,
Honglei
