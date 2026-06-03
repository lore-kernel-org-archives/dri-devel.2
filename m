Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE26CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 16:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A747A11207C;
	Wed,  3 Jun 2026 16:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUcBgoFl";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011061.outbound.protection.outlook.com
 [40.93.194.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D17611207C;
 Wed,  3 Jun 2026 16:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM6Jvvz+ca64wUEljrXnoA79CD8OhBzCrtAWTdr439tkw4/kQhxTw5HUVbBVEugr9vzCVpk+t9xFMDNw4iuESo/D1sWxCFWTBmoeK1FiOjeDHWIMUTav9QiK02z13xL9YiIIyKsMGa3++vBeJYUoMThU9bumnD3x1m0dsvnXExvWM5mN2NvlFIh0KBzJ+fOK5dXx6GLzOYzS72GofRGHOaiZL2EN4ojATLxfFkRFlt09bU1KdrQQQnBwpa5uz41gPpkgFerKKfTXxoqozciJe8fTmimxpo5jkFyr9d97DmGYEvD5XhnhIbYr6ABa4IN9WVf5h2kmFEc1aWEAM6Msmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jDHhWZkLNKM2HEgAzkri7BR5VH5gtYdILefelAMcHI=;
 b=egl9TznM8t/y2Gy+/vc/gpXXqt895W5T52OQ4BpiwUHjCCUaZpwahVe9kG2aVDmY/04+rA3G7QtME3oSoA/zCYfi4FAxSHbm1Jx/4sJ5pLaVgSnsXfg0jo4dXIVt9zujAt9KspWkhd7QiFpnO58+3sgrZtcgwFcYfpS/6qistBM3Fj/xwMOgcop5Y7xPsGGy+1yDa1/GzVZEWmgbjHBg7VaNl5+0yVSbuLldHSfmhZV+giHXlZ4u0+eRUcA/RE5rx2H051rM9npDaBXo0MmnikxCuOMa9XcjSsCqRdZKEJVI7K5j+U7me18XiqHSu42oNNO0yr90HB59dutd1/9Wew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jDHhWZkLNKM2HEgAzkri7BR5VH5gtYdILefelAMcHI=;
 b=FUcBgoFlWrMMeee3ekzHD5BcFKYLtJUtZCN2dLemdVRilkZmiwH6IHBGBl679ebyY3Vajd4ri0YCIBNtRoE+NoVors61hA8yCrfdIp/u8n99lf+EvYrcu25Jd2ESmrySUZDqX6WhgxfnoOrfAKv1Ww4SZfq6sff3GLg/fANc/fQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 16:16:20 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 16:16:20 +0000
Message-ID: <19398b47-c197-4404-9465-d7113dd528c2@amd.com>
Date: Wed, 3 Jun 2026 12:16:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: convert CRIU event-private allocation to
 kvcalloc()
To: William Theesfeld <william@theesfeld.net>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260601195510.639318-1-william@theesfeld.net>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260601195510.639318-1-william@theesfeld.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 90aa1548-daea-4390-9564-08dec18b72b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: tpVj5Gn2LTj960DoQCRXn2/Ke+eXqVc41RiSYQLTwhfNXySrNel6rGJyirPOQ3cWCzc/ZsVFeISYnBchEYe5POaBxo6XQA9K3oeQu/UCXcIIlU2mWOvIHBH4WS6Ng3xdQanZUGj8SGFZX75knKzorkhL+CbiXn9DSgxPdjPds5CNaDaCFwfg3tR0hAWsZMHdvm5bnDRKKrGr8kOSJMGA3qAMWT4Ro9+ZqiQ6IbbKE/4l0+b1wa7ZQ5RxP32h67DkFyMsVSCtFnKSmTWNg9bFOtDuaktBKWn0WtFyMpZcuRkiIuKJ1kjoLjcvvs28DmhfuHTJD4z5+cvexkw9rC4KcqLx/a8Hl/6lxiHe/6yJJXgh+FBnl5S7gCKyBDr+6qdPowg+rBRQW6kQw8eYjU97LtGh3aU0gmTsR6T+kUuOz+jy5f7MG1eHJ+DL8wqfRFuHRCHOTOB1jy0Y2nXb4Wz+FLZjQshV5Hs91QLuAK7DU7fEIux5ExJJ3XQV/eEjSoZjvFHUn8mP+RX33iMRnQdRkTRHKiKFHjrcc9ti6bMW6DmOtavjNuRnlqVCHtt3cxpQCbrSCwRcd4Hyy7T4+ww5SDo07miV/TnsO8fx9kMPIY7v6wJ4QyHE7qUcMuieNi5WmqVvTm0x4Tuhszc1oA1P/IzqT1pbVgeZPyltOUHJ57swxniDA4Frl4K5Y1x6/R7O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFPQ1h3ZittQkhvL1pQOHI3dG1WL1BHdUVvVFkxKzdyTUYyblJXQW5GbHVV?=
 =?utf-8?B?WEp4QmZ1eE8waUEyL1gxeVVUM0JUcm15NGVXMkQyV0hrY1hhMkQ3NFEwK2VQ?=
 =?utf-8?B?bmlORmlQODBmT1RnNHpkdVc3SkM1Ulhsd3dBMFRDQTVFLzltS3NiaW9JcHdO?=
 =?utf-8?B?QlpSWnUrK3JpUVJwNXh5d1VwSU9PdWZXSFNXeWppc3ZNY1lobXI1VGJySjVP?=
 =?utf-8?B?MmNzY3RuWDVTZjRheHFmWE1RRXhsWVFCN1RMR0ZrajY0NVhGZVc2Tmo4KzhR?=
 =?utf-8?B?M0w3cFJSSzA1aXFuVVhIWmFGR0VSeS9ReEt0ODVlbGV0am85TittTmlEdkl3?=
 =?utf-8?B?a05ud3hOdzViNmluQk9FbTRvckVIOWJ0cnAyOFJ5SmUrcEtFMUZDdDFiOE1r?=
 =?utf-8?B?TnNPbTF5dTNXeXdTRFdFL2lFSHkrME9yVlNtaVkyU1Q5Wk1vc0p5NllaMmw0?=
 =?utf-8?B?dnZMQ1lBcEQySWZKeXpPZ201QWpyUmxOclM5dzNUMUU4NzZWWWhmYmc4ek9I?=
 =?utf-8?B?VENJWldBZHZPZHBDM3ltVzQyU1ZmVlB3bTAxOERXQW5YK2N1aWlPYjBpUWJB?=
 =?utf-8?B?dm1seVphVFREUkhVQjVRR3FLTmlsU0NPY0FOcFJpU0k1cFcxa1NNaHhTTWtt?=
 =?utf-8?B?TlNHdDRWcHQrdCtsZDhHZXlwd0hyVTRMQXRHZk5lZDhYWEEveEI3L1RjNGZy?=
 =?utf-8?B?aXpqSGE2TVRtcHg0RlFxZWJaNXFQeWN5K0hlWHB2OWMrYjluUjlkZzBkd0Qw?=
 =?utf-8?B?OFF1a2dOVWg3aC91MDVJQkxGS1MvT3lGL0c3RWlqTFhkUVdaajM3MDY5cUNj?=
 =?utf-8?B?U3RWQzduam5xdUs1YVBTNHBoeERuMEJyN0ZtdzJTKzE2RVhsbjl0Vkk5SGZN?=
 =?utf-8?B?MFVxV1Zwb0dZOUFDRm9mekpXR25oT0FkVDJxaFRTdmdBcTYwZzN0SGJ3UTg1?=
 =?utf-8?B?dUxBTFlCOUhTTDI4U29pNEgxczVLQWMySXhmdzh2bWZFT3Ivc2pGRHp1aDUz?=
 =?utf-8?B?cDFSV1NCVGVoN1RYMFhnWlZ3V2JqSnMrdTVsc1l4L0trRVdyRHlsVVlNV1l0?=
 =?utf-8?B?WTNXOWdoY0oyWmZWUFBsT0dIbDJyTVFMNlpPbjlJSlJsRzZpWDZRTmhuWnJM?=
 =?utf-8?B?c0YzNEtaZGFmREtTa3k4SmxvZlQvYW5BY29wb05UckRlZm1zeU9GYnA2YjlU?=
 =?utf-8?B?TVZGQ0hybERraHhpUW5ZYXJ4ekd1Q0VKUTFxV0Z6NFYzRFNUeHd0TnluVWZp?=
 =?utf-8?B?aDB4VHpMeU14ekxtaDR1VDZWeUVhZVBsWUU2UzBCYWpFaGxIOUY2ZzJuU1RM?=
 =?utf-8?B?SGg3TVlqck1yQkt6Zmowa0M5RXoySXRTSnd5WXV4SkNGT1RkQ0dNYzk4YUpF?=
 =?utf-8?B?bTkveWNPRG8vYlJtcy9sQmkzMGdtOElvQ09Sa2I4QTJVdHlKWldIMWt5M2dn?=
 =?utf-8?B?OUZRUmtkRlU0YVdEZHdrd1daMDZ5cXE2WEZkUnIzV2w2S2JFN1VYWXRFTFVI?=
 =?utf-8?B?WGxQQlpoZSswTmxJcVJieEV4S2piK0NRT1VEb04zS0RpMGJBeWdWaElYSnpI?=
 =?utf-8?B?TGMvSGpIaWZrZjZtSnhnRXBYRmVaWWNQVVhKVjgyOTRxV3NjTzdBbnVBRDhB?=
 =?utf-8?B?ZUFBWWZkVDN6UWZzMzFpS1ZxSnBaeU95dW9haGVGcS8yZlZxL3VRZnpJQ3lN?=
 =?utf-8?B?ZVhwR2U3dmNxWTNmUWdGenV1Z1l4VlBjQ1Yrb2hmaEVvenpVcUdWUzNISGxY?=
 =?utf-8?B?MUtBWERXQ3d1dlJOZ091TGJzMlhSMFIyeW5RMHgzMG9wVmYwbHVOK09oOVNl?=
 =?utf-8?B?RTROZU50OHZGM0xKek1MemhxRG1uREFDVFg3RGQ3U05mUkdQTXJJSzhMSHAv?=
 =?utf-8?B?Nkp2bFBtSzlHT083cURPOE1NV3pzU3RBa3JweHMvclhjT0hLYVJLdlBsaytv?=
 =?utf-8?B?MnpKK09PRzBnT21HVno2ZjJXM1ZEZXZpc0Q4SmNZbi85ckQwdmttMzhaRmJC?=
 =?utf-8?B?aEZoVjBkVWh3MkhrZkRNN1o0MjZYaHZIQXFVbnNBbGRQVUV4VnU0Tld4VXhG?=
 =?utf-8?B?U1JwRG5CQ3F0ZjV5eGUxakNnV1NObzBLbjlDUGhsTDVkbGdQcmNWdEpvTUhS?=
 =?utf-8?B?ZEYrd0o0OFRBZHBOZXRCVlV0YVVUbEpLUVl3NWhqYlNHUy9qZnozOVUrWkhO?=
 =?utf-8?B?djljVUJsRFU5NFQxSFd2ZThmQjg1ejQvSWdiclhzeHp3cTBMWmlVSVhSNjlk?=
 =?utf-8?B?TzdHcnFJMlVkbm93TGZnVFY1RW52dHlaNGRkSVJHa3F5KzlVdExkNllkNUdL?=
 =?utf-8?B?NDBsNmR2c0ZuakhmSnRBYlNYb2F1bnU5d2ROdlMwNk1neFVpcUFOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aa1548-daea-4390-9564-08dec18b72b1
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:16:20.4972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4Yj1y9YwHiQj1Xk0UiS1Hn2h1Vi5iuynpHD968UBu67ra6SNxY8TpAHutx8WuaylxA8eBQjbt9y2DXYbhZsgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
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

On 2026-06-01 15:55, William Theesfeld wrote:
> [You don't often get email from william@theesfeld.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> criu_checkpoint_events() allocates the ev_privs[] array, sized by the
> runtime count returned from kfd_get_num_events(), using the open-coded
> kvzalloc(n * sizeof(*p), ...) form.  Switch to kvcalloc(), which
> carries the same zero-on-allocation semantics and adds the standard
> size_mul overflow check on the n * sizeof multiplication.
>
> No functional change.
>
> Signed-off-by: William Theesfeld <william@theesfeld.net>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index 44150a71f..9739214e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -543,7 +543,7 @@ int kfd_criu_checkpoint_events(struct kfd_process *p,
>          if (!num_events)
>                  return 0;
>
> -       ev_privs = kvzalloc(num_events * sizeof(*ev_privs), GFP_KERNEL);
> +       ev_privs = kvcalloc(num_events, sizeof(*ev_privs), GFP_KERNEL);
>          if (!ev_privs)
>                  return -ENOMEM;
>
> --
> 2.54.0
>
