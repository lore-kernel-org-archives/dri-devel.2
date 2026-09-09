Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87555C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C7210EE58;
	Wed,  9 Sep 2026 03:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RuhVco8m";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011027.outbound.protection.outlook.com
 [40.93.194.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC4B10EE58;
 Wed,  9 Sep 2026 03:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKakYGbzAwFMcmc/JLMYcKyf0f4nEFwqtr3IqQaaX1rg9r+IxewikPnn8+QNoMGQ+5lCBqU72mELBnD/PzULRMcOSckT7qMKhDJ7L9mQtXGouSqdm3MO3+VAJlZrJti4WHp1f/Ff5BdXKtRcUuQLBEEN8EX2ORkWhFqU5aJqHINH6HfNBkZ/eahtw9FAs5h2ld8Y+KeH6dqb8dmUkMFr1OJN270yAjCP8zoDHEy6h0GEzYwawtfXQEqaAH77b/waIrOALyz6zKkoBiAv1vgAJwEaOIqNuY6Kf2NNV3VfWfX97mNXmOLkgCuoqpSgxVKb7Q+Go00/UBZgZ9UNWI+LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVLkAUHzzD6vqbj2HaEc24FStbbRCfPju8WJ9IKopNs=;
 b=czTWb0/40imvifhu80qc/EsqCUL+FOTz8X9DDoSHWLUEeaDp+KGEnB32QYm17f5ZtF0f256OewxCkfW87e+tuSf+yZNVZ1C0ywsmzSPoyAGxIp1ktQKJMDKUZuSeVbUeb878ZpRFxz1sr6bQvHC74iFNnCbrPajmqz9AGldVnoruz6+3aH048rBfYqQ6rdP9V/DsfqRY4BnXQvcV0Y7JejzM76egFDs23djEFviE6tKyxok00dpm4U8HPFluYftw5qvpDXYFneddnFU6Fgqv7sz1nSIvmahe/LgbowVN/HVvCfWqUbf+sEu8kPugirCNUe/WPXZKrUy8rWR6xh98xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVLkAUHzzD6vqbj2HaEc24FStbbRCfPju8WJ9IKopNs=;
 b=RuhVco8mbloF65IGifBblufrvS+lRE4BM6K62aCdFhkmWnGicaLYa3YPTH2M5FBgcmq/J8fEaWfID3YOF1cBqJ9VXaQoKP5qRbKAk3S0ZZqbTJdlbKFUllOO4/ITCwwisogrniyTLZRBJeZPrQUaaF3fEGSoR5XP7jfhH82Ii+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) by
 SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 03:00:39 +0000
Received: from DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27]) by DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 03:00:39 +0000
Message-ID: <a7ad31f9-262a-4d85-b4d0-051b722147a8@amd.com>
Date: Wed, 9 Sep 2026 08:30:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] drm: Add drm_work_fence helper
To: Matthew Brost <matthew.brost@intel.com>, sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-2-srinivasan.shanmugam@amd.com>
 <20260908085840.57CFB1F00A3D@smtp.kernel.org>
 <aqBtFDnjT4HwM+12@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <aqBtFDnjT4HwM+12@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0148.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::18) To DS0PR12MB8199.namprd12.prod.outlook.com
 (2603:10b6:8:de::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8199:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: eed1fbfb-1fdb-48b2-9f45-08df0e1e86f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rVm6So90ZlLeEmeNqHwzMgEnH1wVMLaHJysgLBThSsSs0Q9ZP0PJ63yPLgN8qRRvmIjTluSMScDsxICh3TJf/UtsL1DKWDIO0mdez5v/IRJqIb7YsblOCfY9YpgiizgccTwvG26UnlukeU6xDz5sDbFhq2XDQNqREdHIjonolYwwrr1k4KC2Z3Ac2NWrn5lRJ91DRB1rmDSO4NFBidodev5d9DZRlEmYHFPnJaC2sU+1nlRH5MGTrOo7fJN8BaO97RNgWlbAhnVJfKAWjP8AgKmAXj/8iCB+9PKRbV/hI2MK39vBSd26MqL0Ue5rrc6jYlUG+Y2gE4Eel1GN3vQKPCqRqVMLiTBfaYiWimcGZxzoFNxWzfNyDYtn29hyoJm8ZC+UjTjH9Jen+FGgbP+ewspWmOC+YiOXGRTtpQv21ug9T+0/LqCbc/MxzW9YfKrL6RU0n+KwS3i4lC10OEFfzpS9PBYvqX3bKxw1UeGNpw1poFTOv722noyZvhg5oJhW50AXXjOKZl+Y+1WiLbx1E8PyobY1I9eSWLg0Mv4ssED2y9ISIcYwGPt4Z5qSK52sWkTIYIZrpNLxaa8VAt2GZUsv1cwl8AldpzhzBUNypgGl85g9P8qZx4VqLvgEbmVx2FRDBMVgb6W/2y+S3GeLYx/ZDrmvbGk6f6ZWkBCLxLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1DVGphTCtFcHBoQkRlUCt6c2pDb3VTYXFkTWcxQWxQNk8reGp4eDQzRHd2?=
 =?utf-8?B?bit4R2hGNG9DL1pkcXNJTGFXV3lMZjJ3WUFFbys5T1FPODdoQmg4N244R21z?=
 =?utf-8?B?ODV6NHFDb2ZLOGtiRjFvTU5ENmVIV21BN2NhTmduTFQ1d0hhWkJmM3dQQit4?=
 =?utf-8?B?bi9JUDlkTE1hWkpQdzhIVEMrUW9MQlllS0NxRCtSVjE3dWdGRjMrL3dnRjJk?=
 =?utf-8?B?ODBnRjRuYUFuREp1MEVNRUxZaWNLcytuVmhoZ1R3WTM3SE1sVTU5a3NDekJu?=
 =?utf-8?B?VVgvSEozaXNTZ2RyLzljUkRZQkV5eGNUTW1ZWVg2MU5tSjFPajlnZkdmL0xt?=
 =?utf-8?B?b2dXbnhSMXVnU0VaQzFFOURLUVVXK2lSNFgrUytOWXZZVTJ1Z2ZIcjV5MTRT?=
 =?utf-8?B?cDhhVVQwa2JkY054YWFCWnc2TFNvUG1uU0Znc3ZJUWYzMHgveEUwWktMZmJw?=
 =?utf-8?B?RjRFNUVBNnJaUnNuVVU4cGJzTUxMZHdRNitOa1E2UVAwd2RxZXFnVkJTQ01V?=
 =?utf-8?B?eXhOUnI0dTh1d1gyZmNXbjBnTHRiQURtb2pLNnRxdkFzOVFLVFhhbXRlL3FL?=
 =?utf-8?B?TmF1aEdsa3MzODVKdnpVQlFySWNoUzdmVzZJT2Z1bVJ3TUlYczRpTVdkUVVv?=
 =?utf-8?B?Zjl2MS9Ka3hQTmM2c3ExNmV4anpTNWYrTXB3eHh4WWtQeks4R2lnd1p2QzBq?=
 =?utf-8?B?Zm43YVBpdHBYZ3puN2F2YUlxZG10a0pxNDBpdkJDNitKNFl2TEozSTFNYUZK?=
 =?utf-8?B?bi9KQ3VueTVUVEExbVQzUXRtN0QzOXFnMk9FcDB5NVhWRmhKaURPSmZGYS8v?=
 =?utf-8?B?ZzhvN0p3aWhnS3JlZ1JCSnZWcWQxY0c2a0JuR1VRcFB4N0htcmtXMkNtWEEw?=
 =?utf-8?B?V05MZnFFNnpUQTM3eDA3K1E4WkFNaGk0TWdKMVlFWXhsN2xjZFlDWk9OcjFN?=
 =?utf-8?B?Tk5sTnUyM3AxS0ZNRGpjNGFhYk1aU0tvWkFzM0QyTW00c2NQV3Iva0hyZTQv?=
 =?utf-8?B?MWdOTUFlTVpodVJ5ekYvcmRraFpIN1QzaTJQY3R3a3FmbXlQZUZpcy9Lc1Fx?=
 =?utf-8?B?RDlGVHFKRDRVdkVUVEZzVVl6S1dWS0NmNlk5eDcyVGx2Zk9COHVvRUVwYXJQ?=
 =?utf-8?B?K2h2Z1dFT2FOcGtGdkJPUWUzSExRUjRjZFRuSWlEdUNJT0pLOVpiMlozeG01?=
 =?utf-8?B?VkRZUHV4KzJkTjJlWFprejZMYTVWNG1yZXZ1cExISmg5dG0xK1BEeTIxYXNk?=
 =?utf-8?B?eTNrNldleGdMcGxGMDJTV3ZPMFNyOFpRZGpaR1V4ZnZFb05ucUVpcnUrK2w5?=
 =?utf-8?B?OWdPbWlhQ3EvSUpQZ2h3WDMxRVdhdmZ6Z3Z4SzJYdVFsNWlnNXFJSjNaQ3Yw?=
 =?utf-8?B?bnZMWU1KSTViZ002Rll5amsza2V2NmVMLzVCT0ZzajdiVldnaEM0UVJhdith?=
 =?utf-8?B?WmFnMUpPQXdVZ0M0KytQdUNGdUZHdGtQRzIyUzdqTUR0MlV3WXVUenFuYjFS?=
 =?utf-8?B?Um50NzVZY1NEZWNoVURBR0JyV2xZdjhEVW04aXNabWxMclJCeHppUVJVdDhk?=
 =?utf-8?B?Z0Vid0tJZGJ6RndlTzVDaEdTbll0RGUxeFFwWG5UNUFMbzFJL0JLb1VxdXBv?=
 =?utf-8?B?S3F5QUhoV2RsYzZCMU1jMVk1UWY0SjV4TmJWMkk0Qkl5cVA0aFROSFJ1MzlW?=
 =?utf-8?B?WW0yNkYrMWJlZFVxQm90WTRGRlpaaEIxTExXTFdHMHVSY1lrMEkwNnJCL2dK?=
 =?utf-8?B?REFRaWtGYks2c0hnM0NiaG9ONFVyNmNlNTF2ckk2WHBPWDBuS3MyNG10dHp2?=
 =?utf-8?B?dTNPT1ZIOVV2WVlCZDJIVkxERDZjUFZ5RlV3OXg5NlhSODBGaUx3MExjWUVU?=
 =?utf-8?B?WUZmcC9rdWhzZUFPczBuYkVKWHkwcHR0L3AvbWpnVE9mc3c5SGQyOEpYdFdB?=
 =?utf-8?B?c1djT2k4Sm1YTHRkRTNkU1BIdjhVcTRhMmJDVjZQWE4vd0dEc0hRTnVZRnJa?=
 =?utf-8?B?emlzRmJzdjd1Rlkwa0ZXejliOFRBZWhkYWtycWU3a1FCYUdZSGRhZnE3cS9J?=
 =?utf-8?B?c01jelZmb0N1UVdWVVBnOENmT3RjaXh4MkRwaTZScnBWN1Fkc2JtcS81Qi9s?=
 =?utf-8?B?UHZRMVFOYzRoRHVTTmdFMmZtaXdPQjBXQTduL2hxM3d5alhwQnlSL0pLRTBQ?=
 =?utf-8?B?TXJNVUp2dHEraEJadWVBWVMyU2xlSzVEbmhVZXhoQ25jZFhpdVNid3BXd0ZU?=
 =?utf-8?B?Uzd5UXBlckVxR1RsYytvQ0ZCek8yMHZ3enVzN0c1anJhYTJmT3pRSmVQL2Jj?=
 =?utf-8?Q?cwtkgRiTDN1C9sRY2m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed1fbfb-1fdb-48b2-9f45-08df0e1e86f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:00:39.1377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5G7Pv+pXhu6DFruFuLVKnpxPkogV5Au6A5T+kCvvq45oC15gmJFR4QWWSMW03Go4Mbmci0NvTrQeG+6iZNW4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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


On 9/9/2026 1:46 AM, Matthew Brost wrote:
> On Tue, Sep 08, 2026 at 08:58:39AM +0000, sashiko-bot@kernel.org wrote:
>
> All of this looks right. So I believe the solution is:
>
> - s/cancel_work_/disable_work_
> - In drm_work_fence_queue if queue_work returns false, call drm_work_fence_put()
>
> Matt

Agreed — the race is real. Will fix in Patch 1

    as you suggested:
    - In drm_work_fence_queue: drop ref if queue_work returns false

    - In drm_work_fence_cancel_sync: switch to disable_work_sync()

Srini



