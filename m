Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50B606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tFX1Ez7T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A571123CD;
	Thu, 29 Oct 2026 15:28:05 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AF91123CB;
 Thu, 29 Oct 2026 15:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB7OUaYoylFOemoq9KcS/sX3VozjYIH96yoN3Mg3qZSp5jVuncCKnrhE2H0KeormKCEKY6WEsL4U63t795/OObGiOt/3ISqsFNodd0kqSVolYlyzAJmKs6nF3z2DU2+wGxqrzkprYDR20jaJ16M9anUiM7Sg4EZkJZfsQ5x2ECx2RSke6XilviW/yTM74rdIKkqO3EFa6jUsJPyGRG/S7E8MM56EtOdBzlY+62VoFzqkFxINhDbO/ibkAXgOpmPHt/Q+Zr/m/0XDyQg2P66oTbD59rb5OTT7kzIqHCyzEmHYd3YWgoSICl9uyjdEObxeTtZXzH1KONoUL/dm9eUopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDCZICIo9b5vofW88rzyu+LUCuQkDYOq7hnZ70g4eeo=;
 b=J7wAsKKMRMuSEAKuXBF62SBzKYQaFStp6trCfsOM4JjEVNjWDlZqfVO9AhXJhste49UAdomFXkLdusOCa+7D0U5Gf1sPjfVukB/2ILYrEpoK3r7KJdrG47U6/xnDY0oMlw1/lgI7GDKDMu1svKGFa0Rv07FvvvxSfp6GRLrWJzm9QSrzfYG1DtZ0tEsl7+XVpUtuekJJy1Qk3huWMZqlKA5grLm1hyU0YSMkxZPJiq6XA2BPc0KBCDXt+4lxF8OjDoy6A4rnzX0rPmPtgPZNXyLMiX1P4Mh72qt6HABpWVH3QL3R00gyNAPpBhzHvP/h3Jsq3XrTyBiYuVbXM32xUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDCZICIo9b5vofW88rzyu+LUCuQkDYOq7hnZ70g4eeo=;
 b=tFX1Ez7T16tY3Cygn58+H1AHqoyo1jl/rvM9IXfGd32Z68Dp8y4DopQOdRk/ti1/okz/TjD5m8DM9SUTd8VDLcnyFh4F94/Py6XA6fHAk0/UDUF3bOMF7GiE9mm7g7xRnEOUhNkR+UMt/WyxrH5q3KtSA0opbE98k/BOmjSCmPM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by IA3PR12MB570242.namprd12.prod.outlook.com
 (2603:10b6:208:715::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 15:27:57 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 15:27:56 +0000
Message-ID: <58ed0221-cbaf-4b87-b5a1-8306e45e601e@amd.com>
Date: Thu, 29 Oct 2026 11:27:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm: Support HDMI 2.2 FRL rates from the sink
To: Fangzhi Zuo <jerry.zuo@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261029004457.40545-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20261029004457.40545-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::26) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|IA3PR12MB570242:EE_
X-MS-Office365-Filtering-Correlation-Id: e3994fe8-c580-4161-1be6-08df35d13540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|261009223327099003|261009221727099003|261009221227099003|261009223027099003|261009220027099003|261026140227099003|261028144727099003|10067099003|261022105027099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nb+tA+ZHooZj4c1ZleemwXkwCo6oPds6I2BaSLyL2+9B/nurI5jLgYXK4rm3fs4JbVOjYj0oZrBWHS9UzdlihqhNws+xak3mr7JQ3XK96LjYu5m/cJ/Lma3pZWap6Zb09/WuymiovO+WZB6KwE24LTFrf2UlVGPaaMoXRd/7n28PlZ2TpwfKXtMCcets80yy3I5SLIfUcN2YjKPTit6eKVJ6T7YKOgSiy+ZYRASmAjGRJwOEhvz2Mgyj2k6H6jvpVpEVzyZSjL47f9gMuOJ952hYLk0Y5mJ29+i8/RkUyEg7pWCQUMsL3Iy19o/o1FkgeCxtamH8gYffI/NpB5e+DkoXTPfsRRvhZMz/tFsva8zurFXe+kyIRplvwL77TvHfDx86bE8+iaH1mL88tc3mZ+ll0M6DshCitkl+qNRKYTKPeFthOYbwM6AAFDXzmCMMSH5jiXQSZOGJv/npEv/8p87h3iW+axyVRPwlaDi+uTYqnvI5lRj1EY3AJ197aLJIYzECg9dN6eo1rzO5AcMrQ+Ina5WHUWNskxu/+XvW8txFXTao6O97Pzu8Y7yuqLyZLG5u1bhrYM/zVBRrSRy6HtY8fqirt81Oi66jEpFUIfzUZ6J75jG0xojjUNrDo6YUAbw1WtgV7WmT+9xvXUa983kFIlJzwj2JxWbGSOD2qi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(261009223327099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009220027099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citzbXd4TDQvdlhpbmR5OS9sTHkzbDV1djdzT2c5NFlOdENCeVkzYm9nV0lD?=
 =?utf-8?B?cyt2N053emk0NEdydUhCQjhLQ0RHOWFYa3V1VG13U0I4dFZYRmRRSEkwL2Nw?=
 =?utf-8?B?SWNRVzduWlUrOUlFTWdXRFRya3JFMGM1UHdHbzI4U1JVV0VPQWZjdEpoaVRr?=
 =?utf-8?B?bUR1bVR5c1RBdTM2djNaaU14Z3c3OXhnWmt4MnEzQVh1Q0wwTCtvM2I0RzZU?=
 =?utf-8?B?NVpEcEE1S1VSK0p3aWtTLy9MOXVCTVRjbEx5U0hhTjhHMWJLbzUxY2FvbTQx?=
 =?utf-8?B?MlI3ZU9FWVprR2YrQUZsSVR1SGVZbXlNcXIwd0szTi9JZTAzb0d5VkZuNTdY?=
 =?utf-8?B?ZUwrNTdYS1UwQlVGYjU5cGV1QkpHL09OWmljUkFRZWNwVDA0eHNsa3FYZFVC?=
 =?utf-8?B?NE9zWjAzYzVSZTBmTjlaNkNINy94WWR5NGpVWm5sWHhyenliYWdYQVpoaCs3?=
 =?utf-8?B?L3FpMUsxbmJ5VTZQeWhIckZQSnZxUzIya3RxdCswOVNmN2ZOVUFnbXhEdnY0?=
 =?utf-8?B?cTg0TlhMS0pHSTh0TFNZc1B5eGxlRVVOQUJGOFR1dkk2WWNvak9CRjFqaUps?=
 =?utf-8?B?OEhlSk9CUUV1Q3h2T2dCT3QzWEVQWFAyRTI1Nng1OE1LeFJFeExoZDV6QUNk?=
 =?utf-8?B?ZGliM3VIWFViVUs4QWtVWjB6QjIxS080S1BreFFZMDZWZ2wxWjdEakM3V2Yw?=
 =?utf-8?B?N1o0SExER0Z4cGJkQlRPN2ZDRFVBQzJRdDZFWnFqZHhVWHVDNDBmZzN4a1FW?=
 =?utf-8?B?T01GdDlhcDQ5TjBvOHA0aGdDTnhTazRQbHdFR2RObHBSelFlc0M0bkdHMCtk?=
 =?utf-8?B?SEg5Zy8vdGZ3UWtTaGVwY21oODd5aDAzNG9xaDFzRkpZdVZxNHFuQTZabG9n?=
 =?utf-8?B?OWNTL054anRKTEVpOFhkcm5GM1YzanY0UGRVR20wUFptWXNXRXV2RkxIZXAx?=
 =?utf-8?B?V0NmTE1VL3RMbVhOWkt5UVAyTlhNelM1dWdKeEcyWVovU292WjZYTTY0ejZZ?=
 =?utf-8?B?ZXFFSGVnZjc4M1lyZ2xyc0FQQkRYUUJUYmJLQVlqdTN5a3BvNFBoWFZDZ3pH?=
 =?utf-8?B?d2JVVkpDNm9Zb0RwRTRoTEhMZXE2T0VYZjFIaTV3V1ZrSlZoYXdld1VxWnZS?=
 =?utf-8?B?UDhiOEw3TGxZNkZyRzhJK2cwWU9JYXFkS3VuUHFpRk0rRWhneVpPWEdpWW85?=
 =?utf-8?B?TXdnaFpDTDNROEhKdnI3cEdSanpyaHFLMHFkc3o4ZURKK0xZTmw1eVZmbVEv?=
 =?utf-8?B?SlJ0RjRnclIzSHFSLzFQVjZxZFVXZDlxdkthWW1GQlJiN0dBTTVkaXN0NkFP?=
 =?utf-8?B?VXJhZ003VmpQNzNzODd6TFlxd0t5U2ZHWkxvR041cnpqMjByMWZOWVI3MjlZ?=
 =?utf-8?B?ZFpsaDRLQXpCaGZ2TG5yNUdQYUljTzE5QUxRR3BrcWhxQ2hOS2JWRWlTY0tO?=
 =?utf-8?B?N3RlanpVVGdaMjNaT3RPUXF3ZzVUS0tyNFpBMkVnd1BpaGZmMVgyb3VJRE5T?=
 =?utf-8?B?ekpiZk94Sk1mTmh1UjRwS0ZIODl5ZXQ5ZTE0Wm5zRm95R1pRVzl5YnNpUFF3?=
 =?utf-8?B?aThMcDczeVpONkkyZ3RvYUZLVnk3ZFZLRlNxNGV5Tm1UajZBWC9vcWlrcDlx?=
 =?utf-8?B?aVdaTzdqeGZ6NUh4eHQxOFpSa2tGNzZzRXIxeHpndk05YzQ0SmtneTBkNk5u?=
 =?utf-8?B?bHBBcjUvZ0lJdU1VM0hiQjJBeHovN2ZjVng4UlBXakMwRi9xZ1d6VjF1clpB?=
 =?utf-8?B?TW9TQStCUmJKNW9qcUVSVXdtZ3NXNVlZTEJ3ZXhnaVpISUpVWlJpbk05QjBD?=
 =?utf-8?B?YkxBSytwMWhWTDJoR1pDajQ0Z3pYdWtKS1hSRkw5ZlpxSTRQdG5CQVN4UkZE?=
 =?utf-8?B?Q1luc1M5aHBoelFLeXpOWWpwcHU3VU9DZTJGOWt5NVh5RVhmN0VvRkltd2Jw?=
 =?utf-8?B?NldJcDhlREtMT0gzV0h6MGRZN1VYVnlsWEN1ZWY1dC83VjRBMVIwaWdLVHYw?=
 =?utf-8?B?YzZiUm9scEYxemVxV2JnVkdjMUVscGRJQmsyY0RMbEtORUtIRG1BY0dxWjlt?=
 =?utf-8?B?dEROOHFBOWIrS1d1RjVDYmVMSFIxV1ZIN1MyaW8xQ3h0ZmlTb1JLVzVjQ0h3?=
 =?utf-8?B?Snp4bFIyeVNiMDhiYnJNWmdlbGx6STZoTVUvMkJ1RFRoMm85OW1xaWc4UmVa?=
 =?utf-8?B?REs4VUE3MnlSMEs4S2dmVzkrWTA1ZFZKMFZQcEtrRkJLRjRPM1RJSUlBVVdB?=
 =?utf-8?B?L0xWSStuUEkycGdXT2NGdzZIT0Q5SEJxVkhWbkljck1QTXhnMXFwc3lzcFdC?=
 =?utf-8?B?Qmt5eHhsRnZ5VVFCYWIxbmlTd3VhRnBTb0lkWnZyejdpQlpDTTV1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3994fe8-c580-4161-1be6-08df35d13540
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 15:27:56.8854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF37hf44IEoXZfhq6HJqFOb+24GKxuR0GDhzCMrP92P3E19GLivSnHDT6Iv1LYS2qPMb6Z/ekmwTv2L13b63yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB570242
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



On 2026-10-28 20:44, Fangzhi Zuo wrote:
> The HDMI 2.2 spec defines three new FRL rates - 16, 20 and 24 Gbps per
> lane over 4 lanes (Max_FRL_Rate values 7, 8 and 9 in the HF-SCDB). The
> current code stops at the HDMI 2.1 ceiling of 12 Gbps per lane, so a
> sink that advertises an HDMI 2.2 rate is treated as having no FRL
> support at all and the link ends up trained far below what the sink
> actually supports.
> 
> Patch 1 teaches the DRM EDID parser to decode the three new rates.
> Patch 2 maps them back to the FRL rate index used by DC in amdgpu_dm
> and extends the KUnit coverage.
> 

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Fangzhi Zuo (2):
>   drm/edid: Parse HDMI 2.2 FRL rates from the SCDS
>   drm/amd/display: Accept HDMI 2.2 FRL rates from the sink EDID
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++++
>  .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 30 +++++++++++++++++++
>  drivers/gpu/drm/drm_edid.c                    | 12 ++++++++
>  3 files changed, 48 insertions(+)
> 

