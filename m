Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2450BCD6E43
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 22:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3BB10F6A8;
	Thu, 28 May 2026 22:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p8cKZMnc";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A5910F6A7;
 Thu, 28 May 2026 22:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtE5+iHqpZPVYGXIrC0araQuOhB0Q+cwgOhy55S98tRNMG4JqM4ZkklagXkjP25Wa7Zq3McWfbUxkPp3i+54V2L8EnOBS6N1NOEk5j7D74X5pY3d2wD2hkgmoxv8eRZgGX5g0zO8XD8aDylDQPpVgFRkTimreyG6rhM7WCQLPgEhEzP40OR1HMrGEebOxqRR0E2n90Rs+Q/llz0ZBO2RcPcBQ6PXpF4H00TtrT6LJh+zl3eveGDEHEGn3VXJdPd2gV/q2MQxdf7b5X1TA/4/mHZvLVflHSNSc8uaqWtLMqDR9dEbX5gfe7f48Qdo+2eZAei32vpprQ2jFnYIhuyroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDd3IG5JLlbNJuEpevoJBXfV2ELCqIMUryp6O+Npyuk=;
 b=dI6EFuVuVaaSMDhAIkbQQN1UezjB0j4BA27/sH4O82DN57Fex1pYRKkl7rw7oxF5bCqITxUJTpE9AHTSdmSGseJM+YBdU1K8baaLGg2ovgIFPQHdC0NIwivRADEMA3yL0E1o08ZJBVFWqNh+hUHEUHNAoRDkJNIRzMms2/dXOMlG9WPlrMPjApFP76cZhhTyEYbKkBR9d2IFNSQ3Rxoyfj0IyR+D3HETfYGPzgE8yf4nZy1bfw2VdjG3hcp1aZpfjOclMLpx6A9sJWY9nqxqzNzgQGoGgpdcuOTW6U83ULnydJSc3uZkd+H4k4xvVoYlpMP30yQ16GejqlVAYGe4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDd3IG5JLlbNJuEpevoJBXfV2ELCqIMUryp6O+Npyuk=;
 b=p8cKZMnc311lmeX45CS+ZVPg8wWFqme5o2414g4R8P297CLXE6NlzPfGc9IuL+PyEh0IiKuf5ngVoJU04S28tf3xyk6m/LwrvQ+zk7ZmNWkwP7ktRXsAlgRag94gdBpQkY58BsNMurcrhURFTNRNBI7ZUy4CUUyDz+nClmo8t4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 22:33:25 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 22:33:23 +0000
Message-ID: <460fcf7c-3e45-4c7a-899a-ba6cfd207aba@amd.com>
Date: Thu, 28 May 2026 16:33:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: add missing CSC entries for BT.2020 for
 DCE IPs
To: Alex Deucher <alexdeucher@gmail.com>, Leorize <leorize+oss@disroot.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528070016.14843-1-leorize+oss@disroot.org>
 <CADnq5_OBaVum+jV3HBL3mqXfvrhqVOu+gcU9Y2QHdRryQDw8SA@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_OBaVum+jV3HBL3mqXfvrhqVOu+gcU9Y2QHdRryQDw8SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:303:b6::13) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: e538a1d0-70c4-4e08-8509-08debd09207c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099006|22082099003|18002099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: mkHDEyZbnlk4MwWVqXol6XqiYSXpWS45IMGi3jDziel8aZdcSK3XyNhN24IHTBhi9gFI4kZK0dDHQJz7FatPCcshUFDNBwboV1z2l5Qnn1lZI8cfXkfjoeB8Oxcr4u5BX1EoMSIMm2Ue6ccItO1X9lp82OuzafzmkDKnom5pVKalVO7mJOQkTcaFpsW7ATmnI1ChWmqlwWq0+rLlogW3V+S/fCWP1ogi9PRP9o9kyqD9ZUJtOkir2o6EDfylYa70Gj3f6LqH5iKCM5DEODwF50/CWeAZlvsDVnsL9L6YfRrwvTjGrKCoU0TxQPmCDDUrSqC2o7h+jy720R/fnkezeBFR/Hj+2z3B+ZikU/bESuu9t3CPTxdC3loSNjzi1OmTuQiXHlmlblOdgaEHb+BR21GvRnYpnoTw0QGwr8G1h6btVH8FhAKHiujmMIsKD6kGAOXyjJMS2PcmvIf+HEv7mVIv4178BsH9MI4UuTGofkoYXO/8lA4P1qQgiHMazKrv1gUAAidnEalZacNNEyL0nVW/33eWyswZJtZpH9ADVihqcgHbuZf9yye5JwaP1x8/PA7V8Z3gERpPibamq49mNrsKnHDOpRdzfVARlTZzZI5kgwMHUto84Fn9ElDPBrIvBG6Uk0AVPwQJOQ6dymp7Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1ZMMEwrZXgwdmdTTUlmMVIwUk5hVGRUTFNQM2x0T0lPT0crY0dOd1dRRXRX?=
 =?utf-8?B?WUNwZmVlbTFMbzQ0czhMVjByUnppZUEvQ01XMmVTZmU5RUNsdFZSQlEwK3o4?=
 =?utf-8?B?TUsyRVpLaFZ3TEtjdHpFWllxblZmdUpld05sZkVYT2ltRGtNTDU2QVk4R0VS?=
 =?utf-8?B?bm90bjB5NXdSWkFiSndTWUsyWG9jRjN0YXF0RGhiS2pFNmdOOWN6VkcySjhh?=
 =?utf-8?B?KzA4WXZqSlZnWFFRMHlUVlcwWjJaUUFoQXRtWHE1MVcxT252b25PcGt2Y0ox?=
 =?utf-8?B?aEM0NXNMaXozY3lxdHUwU2RwRTJ6aWNGalBOKzF6QUIwb25ZU2ROZ2lnalNr?=
 =?utf-8?B?S0ErT3pTdmVxWnduVThobFlKS1ZqTDVqMXdmclcwb0M4dE02YzZtSktkUzJF?=
 =?utf-8?B?WGlUZ2RYRmdQaU0wRVVPcjZZRGlLSE9SemZQN2IzWW9YTzlYeGNCaHMxcW1T?=
 =?utf-8?B?dDFQOUdSaVJBOGhjRWZrb3BZSllmZnFSOGhVcmh4TXVFRUV2emdWRGV3aDJM?=
 =?utf-8?B?bU54QXNGZVQvYnIzclgxZ3l1WXBXTFhUcm9iYVJ1dVNSUXBpWW5oakJJS1U2?=
 =?utf-8?B?Mm9YZG1kTXBJbkl2c2NGNTZmSitIViszOWk5R0Z3SDUwRTJxcEMxcVRBbXA4?=
 =?utf-8?B?WUNmMmw0TmtRdWh4eC9OUzZyak1GRmd6Ui9DUHVKRUgvQXVSOFc2aVd6MWhS?=
 =?utf-8?B?MldoNFhNbzlNVVRJQnprNmNiTS9hVGxaajJQemRpTTJWN21RUU5idWdsdlo0?=
 =?utf-8?B?YTZiM0s4bktqWVpuMjZOSXplNzlFdC9aa0t5aEtRZ1VISkdaelMzbGZWc2dE?=
 =?utf-8?B?VFJZZnlaRkFjZ0o0ZmtPNnBubFBNSVRiczk4ZC9VRWYvRVdxQ2U3SERlb2Ja?=
 =?utf-8?B?aW9qdTZVWHh6TVd5cDVhWlk5UWUxbVBlT3lzdXFSYlllRkpLL2tBZFhmYWVB?=
 =?utf-8?B?akxnRUV2YmVaTHlPUWRuTVhab3hycWFndVlNQTNyNkhGMXFlbWxiMjlyRU9M?=
 =?utf-8?B?dDZiVDVEMndlNy9tSkhCYzhJTThIQ1JYalhoWUk2bndZWlBxNVNYdkFBZFJN?=
 =?utf-8?B?VDJWMS9PY1BvMWZmTzN0N3UxQVUxSElpRi8vWGpScVJuQnJFcTRBcitZVHZa?=
 =?utf-8?B?NkZlRTNtbDV3bStWYXVsR1dWc3UrUS9qQ3BnOS9KajlaZ0NnMDh2eEREWjg5?=
 =?utf-8?B?RHNPNkhSWmFiZjNGbEJFRmRUcUlvcVg4TDRrRi8zL2lsdnBNZEIvUTN2WG80?=
 =?utf-8?B?enV4dzUxYVFkYXpIb3ArbnMwYzl1emNqNWZZcE41cDV2a0phWXpqS0o3cnk0?=
 =?utf-8?B?UjBnWmVydGIzSUwwY2RnbDNleTQ0SHNzZTUvYUxQSjJJc1NNa0sxbXFLK0ox?=
 =?utf-8?B?eVU0Um9ISkpEdWxpbHNwSjM4MDNoMGRxcUpsV014b1cvQ1hTaDdUdU54VXBJ?=
 =?utf-8?B?NVpKakFQZkQyRklLMjJQNGdNblJySlVGS1B2KzQ5WXhYZkV3ckltTThIV1Zl?=
 =?utf-8?B?Z1psM256S0J0OUhNQVI2MXJNRE1SM1RMSDl2UWRTMy8ycEtzSDlTQ0RJbGdq?=
 =?utf-8?B?MGNuN0o3bERVcVVhNURtRVNmNlZGejQ1bDREbmp0ekc2M21pb25WWFZSTlpt?=
 =?utf-8?B?QVFOdXpvQWYyUkJ5b2FGYktFYzdEeW0xTjkvdkdXQXB3VU9UbWNSc25sckJn?=
 =?utf-8?B?Nmt0UjkxbDRVb2M2WHVTYjJwelJWL1N4SXFpUXBRdTcxZ2FUcmZDeW1jUlgx?=
 =?utf-8?B?VGFyNy9qakFBeWpacGVremYwWFV0QXFZdFd6TlhFOURjVyt5WWFsODJsZHVw?=
 =?utf-8?B?SXBkeGVLenlLSFRZT09ZZ1lTNlpCZlVtZzY1QVc5WGVxQlRwRWxEcXpJY0xW?=
 =?utf-8?B?VXNGdnd0ak1zSkgxYUtqL1NnSjlrWTAweXNNd2pjNGJtVTl3VlJWMVZkbTli?=
 =?utf-8?B?QWVuTTg3dUJETHBSUm5SZG9ZNzJnYXd2TDR4a2c5cSsvdHZMaUw3bEhrUzFI?=
 =?utf-8?B?cm5ZR25rZk5oaU5qRWdoREk4RUNibmZ3QkhHNUlDUklEdVFVVzRFdy9DOHJY?=
 =?utf-8?B?UmJsSjY0bk1BZG1RL1lacWFzTzdBbmwwb1NKQWlXbzJQRUxKS3Rab3B1ZzRI?=
 =?utf-8?B?M0t0NnRWQTBzMUdGczVFYkt1L00zcmhsdEV2dmV0MzdYS00yUUE4YkNIOFU4?=
 =?utf-8?B?eTZ4QkNOeEYzUzl0dWZUL3RPNFVBbWljQjRLa0prejI0dElhd2JSUEltSHpk?=
 =?utf-8?B?NHJxVUhrZ3VqeEhsWXFCaG9IMFFuRmRDcERWMG1FbXhoZGRCOU8rMVBQQ1VF?=
 =?utf-8?B?Q1NEcVBCcUY0bG1VbHhPRlVoblROeVlkSzJ6b2xqZHgvQUhNRVFXQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e538a1d0-70c4-4e08-8509-08debd09207c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:33:23.4062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rS48M24YKMJZauPW9oJHVw6T3kpFhHfn6AXfa412vyVb+gZ6MdQai8181BWchQIj4aJ9WDbCTIDGkN3sMxOXdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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



On 5/28/26 13:03, Alex Deucher wrote:
> On Thu, May 28, 2026 at 3:39 AM Leorize <leorize+oss@disroot.org> wrote:
>>
>> DCE-based hardware does not have the CSC matrices for BT.2020, which
>> causes the driver to fallback to the GPU built-in matrices. This does
>> not appear to cause any issues for RGB sinks, but causes major color
>> artifacts for YCbCr ones (e.g. black becomes green).
>>
>> This commit adds the missing CSC matrices (taken from DC common) to DCE
>> CSC tables, resolving the issue.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3358
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5333
>> Assisted-by: oh-my-pi:GPT-5.5
>> Signed-off-by: Leorize <leorize+oss@disroot.org>
> 
> This looks reasonable to me.  @Wentland, Harry, @Leo (Sunpeng) Li any concerns?
> 
> Alex

Reviewed-by: Alex Hung <alex.hung@amd.com>

> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/dce/dce_transform.c     | 10 +++++++++-
>>   .../gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c   | 10 +++++++++-
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> index b3640682fa60..12c85c3afd6a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> @@ -110,7 +110,15 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
>>   { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
>>          0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
>>   { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
>> -       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
>> +       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
>> +{ COLOR_SPACE_2020_RGB_FULLRANGE,
>> +       { 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
>> +{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
>> +       { 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
>> +{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
>> +       0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
>> +{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
>> +       0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
>>   };
>>
>>   static bool setup_scaling_configuration(
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
>> index cf63fac82832..1ed018aaa4bb 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_csc_v.c
>> @@ -88,7 +88,15 @@ static const struct out_csc_color_matrix global_color_matrix[] = {
>>   { COLOR_SPACE_YCBCR601_LIMITED, { 0xE00, 0xF447, 0xFDB9, 0x1000, 0x991,
>>          0x12C9, 0x3A6, 0x200, 0xFB47, 0xF6B9, 0xE00, 0x1000} },
>>   { COLOR_SPACE_YCBCR709_LIMITED, { 0xE00, 0xF349, 0xFEB7, 0x1000, 0x6CE, 0x16E3,
>> -       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} }
>> +       0x24F, 0x200, 0xFCCB, 0xF535, 0xE00, 0x1000} },
>> +{ COLOR_SPACE_2020_RGB_FULLRANGE,
>> +       { 0x2000, 0, 0, 0, 0, 0x2000, 0, 0, 0, 0, 0x2000, 0} },
>> +{ COLOR_SPACE_2020_RGB_LIMITEDRANGE,
>> +       { 0x1B67, 0, 0, 0x201, 0, 0x1B67, 0, 0x201, 0, 0, 0x1B67, 0x201} },
>> +{ COLOR_SPACE_2020_YCBCR_LIMITED, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868,
>> +       0x15B2, 0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} },
>> +{ COLOR_SPACE_2020_YCBCR_FULL, { 0x1000, 0xF149, 0xFEB7, 0x1004, 0x0868, 0x15B2,
>> +       0x01E6, 0x201, 0xFB88, 0xF478, 0x1000, 0x1004} }
>>   };
>>
>>   enum csc_color_mode {
>> --
>> 2.54.0
>>

