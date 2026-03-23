Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A9F46126
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEE910E122;
	Mon, 23 Mar 2026 14:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgEPe4Ww";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A57E10E122;
 Mon, 23 Mar 2026 14:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObfvR1CuYqqoS4yS/rSCqSbc7+ANTo2uQW5aZILV56KmzGKZQYB6sFE5c9zwkuLi0JJNQHpDtVttl82qGiJbQEnCoaoXcBZgMTpe7DX2kzlNNR/KXBTVk3IrVhU4u3TztA6gepvIFrXbp5evM7+4b2rRBNOn67h81b7ciBY/jPls5ivCft/9wJciJxnp043Ifs7BZkR2zc2NxaQUvMfJcA8Phvzn3ybIeaX8kMe5BUujQma4x5ggGWXRCogKFENi00VwOOZZcYlkTUuyhgWWPHINdT5s7Xu9qo/p8ZRmk2sBM9l3KJNBID5agb4P9EYm96HlMaG48QhhWDJTOYevzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FUHeKRWsr8s23Yq3gXQRgssT251r1QX4mSCxUF4v70=;
 b=L9lPZD1f6qsd+laucLS51r7BdKe5NNkTCD7s4wtEU1hVHLK48xUdMeYw9F68mwCYJekJqg6OBoSQ8PrGVhJJtEsVvUaTJsCZsnDnSz2NziwiZNTWVcsSvkCrL2yiBxsJeQJpDomDe5OYazLLSLA6Hh/GK2UHjiwBt7mBVfdDWkKEjH6Yjwm4obBHA7NSym5WLeGdKeP9+pR5jzn7ZXf7+vf+yQ7djCtIeaswjc3CECzChdjpDVYDA/2AbWkuhQA2ct++c4ff+T2TXZ21MO6ioO7X+bUdB/AQEzunBRa3HAoEJTMXSfOFRFPrIyNSakWWHBTuglfScwxHlvxTx4zaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FUHeKRWsr8s23Yq3gXQRgssT251r1QX4mSCxUF4v70=;
 b=lgEPe4WwI/oyzgYJKHt8HkYBTPOcJJUL9TG0eN2srkDlwC1J+SFChjnAg63hWEYNkzcDa8X/iXexv1T/Trd52p0vfZy5VQOmflSiKp6m4+HV2eMOhJrIFUSw9EvFYNeTvQEtF6pqyZHgy2engaNxaZaC4DPBbZY5yYIm0uSrxZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999158.namprd12.prod.outlook.com (2603:10b6:303:2c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 14:12:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:12:03 +0000
Message-ID: <5d2171ca-aa9b-4b8f-9ea3-eabb823ef2d6@amd.com>
Date: Mon, 23 Mar 2026 15:11:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Update 'none' recovery method for DRM wedged event
To: Raag Jadav <raag.jadav@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, simona@ffwll.ch, mripard@kernel.org,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, riana.tauro@intel.com,
 andrealmeid@igalia.com
References: <20260305130720.3685754-1-raag.jadav@intel.com>
 <aa_OxUm6vthhaorE@black.igk.intel.com> <acFJuRlHeJ8OyLi6@black.igk.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <acFJuRlHeJ8OyLi6@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999158:EE_
X-MS-Office365-Filtering-Correlation-Id: c4de2989-f6ac-439c-94e4-08de88e6286b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vUMkTdU+O26NHCp6iMzmuXSJF5E7tRMwy1/8SoVnEpC2TLNhxFwB9YSW9bxUToKd4Zxmtw7OS5R+FuAz35q1zjAbGGiMwg6C5BwKYUS5t/H5zWbrmY33weeI7EJ60RXeu05m58gv9ri+p7OZN8NSllc9yFsgvmcooE7D8PBlJZIMQrI6ZmAg/mHSQHJrev4GtbvN6ae2fHv15B9eDR0gzbKdW1TWuRUck3YzbWILBgiiCdNnUc2gToVGftagp/lZtzZiGpfSWQlFyRwXtXINC7efitofEW+z4zB9e/uVjPQEzTI312qPngLtX/FZvscnSrm3gedbyakYXy+em0+exoeq6cPWGuHH0J21vIXn7qmV+L8S6hMaC/kiNdsEaqLdbNrXezHsXTRl8m3GokLzwssOfY7vXaPasU1WyVZlkZiAuAMt6Y4OTYLf2LmtHEdQy3Tgx9zHT6uyvvueNMJCpf0jtSpjU4F9ID93fC51uyZuUleLXcVUM7VFWW9GyCQZ7BI/wLhmdfo0tvv4IYZGMC14HaAEPOKFJ2gxUDwnhEnp+5E4YXI/SHFgWann5PkpRblxRW4KB5HpC4+L65dcZjZ3Wj3Dk3GnwebFRFoTuBYFtrnHEZvHpPDGIQMGU5VhcgiUxKeDjDk1gQ+9wEVlPrK87pnLfK07iuhZYg62w2LcbcMaGEY6mh1RwRHWiok6hQ9fPfLb8LdRUgAcHAmIlYbr1QWDY5RnLCIMzvIho08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlU2cnlWS3B4M3NDeFJDMFMxZVhRK1lrUHBJMytSUCtMSXJSYWw0d2h0L3Nt?=
 =?utf-8?B?c0FBb3lqNnpUQzh2NEp4cWJEdlNXanVvMG04S3k5dVljc0g0UDhQdU1ha0RS?=
 =?utf-8?B?YmhmeTE0NlVyL2RIdlFzQ05kdU5mWjZYem5NOGM2Y2Q0dXNPb2RmNWg4VGZa?=
 =?utf-8?B?M2Q2cHg2eFJYMTlaWVgrZWlmMHFpZmtONHhrRlVZUGhWekJqUUhsZTdLNHRs?=
 =?utf-8?B?M2NWRnMzcEZpUGlxRlo2Tm9uNWRnM3dlMGYvYjQwczdMaG1ONTNPNHNhUi9D?=
 =?utf-8?B?YkZlOG11UjVtYWpzWnZwTEU3QXN2bDd6d1dFUUticnNGYW1NZWFSNEVSV2V4?=
 =?utf-8?B?aTVZOXNyNmtsUlpaZWtCYzZIa3J5bWlnQStUNVlQMDA5WEtrRTZBemttdzlp?=
 =?utf-8?B?Y00wUUROc0tCVE95SjRkNGxwRUdOYjlvM1BNTy8rMG9mWnJvcUk0cm5ER0N6?=
 =?utf-8?B?RUwyekZhb2NnY0M1dS9LWWJndjY1cFpLazZDeFdFWnIzVFlnNmV1MVJWM3pq?=
 =?utf-8?B?Szkyem9aYVZBQjQyWXh4Z2RzYWJTOVR4a0w2WFNidXJ3RkFSVTRNeFhFa0ZC?=
 =?utf-8?B?MjFYUDlDa1dHUFVkMGJqb1NkZmVVdVkxdUh5UWJBL0FmZDdXQ3gvWFFaaG5N?=
 =?utf-8?B?QUI3a20yK2tOMHZXMkpob1EzQXI0VFNjMnBOWlFySVVqVjIxbGZJVklNNllt?=
 =?utf-8?B?RXdGYkpFLzE1cFRBazBzV1VhbE5MMCtUZkZFV2lwRkJ4a3RZcHJJa2txME9t?=
 =?utf-8?B?REtoYytyMGZnVEcyWDI5OUZPRTVsa3R6TUg0SGFaL3Z5dnZRTi9CaGRGZlFH?=
 =?utf-8?B?dGFYcDNGRndVQXJxVjJSZTM0cWUwRlg1ODNjeUxqUUFZNlJCOG9MVWFVQW95?=
 =?utf-8?B?UzVrNWNnRURmQ2FmenlHdThxallia0NzVW1BeW52dFBZUFhQUFRaVUhEeXYw?=
 =?utf-8?B?V2FpSk9LQTRJRVBNeTRNYUcxejFHS2lBZlFuL1NPTUl4aWFqWjlRQzZjQ2Qz?=
 =?utf-8?B?Ti9oVzNJNStUWHhleFdhdUE3NldKYkpQSXRUc1ZGbURTMm5sVFZLYWxGQ2sv?=
 =?utf-8?B?bUVkb3lnZUtGVXAwYmdTMkI0aDNQdURTSm9RNUJDVmk0VGdCalp5a3FPZ3JM?=
 =?utf-8?B?NDY1TkJ1M0ZJZ1Z1SFJSaW1PVy9mR3Vid1JnRHJBWFh4aHdKaXVFdnIrYVNR?=
 =?utf-8?B?cnZnQjJmK0VjaEZHTCtINGdraGpVd09OclRMR2ExaHNtMUFLZHdZUXFXOTVp?=
 =?utf-8?B?WHVrQXl3U2hyTVFYUjJYSmxnREdSVko5T0hFdG0rZkdTcWhWTloxN1B6L2VI?=
 =?utf-8?B?NWRvMXRJYTFkbFBPalAra2IvTXNjMmhxTkYxWXFlTkc5U3NKcUhnOGY3NjB1?=
 =?utf-8?B?QVJuS0NUVEFIdTBBckp6UWZlSFd0TVBWb0JmR08yaGpvL2p6Y0JjeDRVeDha?=
 =?utf-8?B?U2J3ZWNuNEtTK2ZhNDVJcVN3MVBxNzR6UlZQbnRKRG8xMHJpQlVpMHNoSDhW?=
 =?utf-8?B?MkNGekpNV3c0VWY2K2FiTFBXU09Zb2JTRzRSdCt4ZVVKMm9tZzc2NmN0Ry96?=
 =?utf-8?B?ZklzRHEvbG8xQVl2WHNQMVFBaDRudm9wN3RiYkZ4bUt4cFhUd0MvTXltd3Qy?=
 =?utf-8?B?Rm5oR3lUSXJBeS84ejcxVGRTNWxrZVNPNVRsZTZxSnlOdXhxTkZ3bjR2TjlQ?=
 =?utf-8?B?YXkwRjc3SERidFRuSk8xVEt6WS8yb3Z2RmNiWk94WTN2NGtTN080bFNLV01l?=
 =?utf-8?B?L2NBckJlaksrVkVURHFOVlgzbmpXNVhydWVVWDU3aG9Nc0puYzdMSGUxSE5T?=
 =?utf-8?B?bU1NSktZU1hwVXVxdmFCdEQ4TlB6U2lFQkpreVF1aVpSaTdiWnJUN1JSWmNn?=
 =?utf-8?B?MDZLdXV0ZVdJNExWaHN5dHN6bUkzS3Z4MDlncXh2dzlGYk5nSGszakw2OTRl?=
 =?utf-8?B?VFMraEMxa0tRNFRXSC9GcEF2VXkvdXBVTlZKbERDc0U1YUpMY3Q1UGhzWVdG?=
 =?utf-8?B?VjF1YjQwa01FVDF2SFlLTnVqbTZidHN5V3NZcWN6VlpQT1grTGN0SDFjdmFJ?=
 =?utf-8?B?SXhUSGx5bnhyVENMUmtIWkhjNGtlZEY4SmtKbWwyK3BkZ3ZiRzg1M0phQ3hF?=
 =?utf-8?B?L2NSb2RzSDRvZXVpL1BRTndiWUFYS1pZcFZNNTAvZHRkTE1DR2JicDJmTVBq?=
 =?utf-8?B?NnJjR1N1Nk1pU1lLTXhsZ0NwM2RpR0dqdjl1U0grejJmOXVUdWpTQWt0Ti9E?=
 =?utf-8?B?VVE5cjFxMzNKOXVGNVBsd2UzVmhWNzhYVjBxQVVMbG8rUkFoUDdVSWxnbmFm?=
 =?utf-8?Q?iBBilWjzqXhd+ozo+y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4de2989-f6ac-439c-94e4-08de88e6286b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 14:12:03.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK6PCV5Ss+aoi5wN9N37ZXGiW6+zNIb5v7GS9OpT6fPCAh37Babmk/PngrDfZMBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999158
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

On 3/23/26 15:10, Raag Jadav wrote:
> On Tue, Mar 10, 2026 at 08:56:58AM +0100, Raag Jadav wrote:
>> On Thu, Mar 05, 2026 at 06:36:46PM +0530, Raag Jadav wrote:
>>> Currently 'none' recovery method for wedged event expects no explicit
>>> recovery from userspace consumer but it expects driver to have reset
>>> the device, which may not always be the case. Update documentation and
>>> log to reflect this expectation.
>>
>> Anything I can do to move this forward?

Invent some tech to clone certain people so that we have more reviewers.

> Ping.

I will take a look now.

Christian.

> 
> Raag
> 
>>> v2: Rephrase documentation (Rodrigo)
>>>
>>> Raag Jadav (3):
>>>   drm/doc: Update documentation for 'none' recovery method
>>>   drm: Update log for 'none' recovery method
>>>   drm/xe: Send 'none' recovery method for
>>>     XE_WEDGED_MODE_UPON_ANY_HANG_NO_RESET
>>>
>>>  Documentation/gpu/drm-uapi.rst | 14 +++++++-------
>>>  drivers/gpu/drm/drm_drv.c      |  2 +-
>>>  drivers/gpu/drm/xe/xe_device.c |  9 ++++++++-
>>>  3 files changed, 16 insertions(+), 9 deletions(-)
>>>
>>> -- 
>>> 2.43.0
>>>

