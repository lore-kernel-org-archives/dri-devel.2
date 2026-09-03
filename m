Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0445BC624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32FBE10F4D3;
	Thu,  3 Sep 2026 10:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VCzb29xO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE9010F4D3
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:22:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scmI8CqXrE342A/WxeVVYfL8ZcFZkw54IS7cGaZYGZUGexHADkd6l03K2QFLWAn/NpeSYfrdreTlFWvLRUfj76S0k01I3XKTiLh3GhYLj4V8dtkpjmtdoxMBDP6NLkBX8g5cUyGbUntALYT8D/WeBXkgoYzKJPlnqHMc6LqSYJ7Oq/nmP6MoS9S2fQUChJFG1aHRUynHHnZggW4kK8ptXxd84dC5sj42AUKSXjEd2w0msgdlbNB0Z0/cpWm76NVR4kyDlNtusXSTjsr/6rFgGLJMxPBRnIZ7kOyyq5eIofsG43mNjqoF0OxHfonrDj/zFn8qGS3pCK7V8gCriF1ZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtLznvforkSWoIjJPY/iFzSxNryLuA8uGGueHny/xZE=;
 b=hd95Ir0rKsGHw3448IR/9ziidK+UD26zJupRYzKMcjNBZxTjYAcSsBBDBGwbrYY6Y7p+9hiL/5cDO5ZYsJv1q0xyz1YorRR74fHaHQBi8T7ZBXQzu4YCE+CYdFOn9+Z6toMNFR81A//bGixfma7CY1hZCRdVBZ3UGqy4uWtshn9BQLA7elVp/6YB8PFskOSA1Ir+8fghmpp3+vlxWOhFiNNFM7pk8PH9l+ZUSVuFODC/QphKWQMkCZI3VvEONEDZ3jCCBarr5zvQgy+vEZttbd9z1p5kuJyyL+JfPE2C0SGuD/rhWzG/M+JyFPvPyFNAMZ8KRxSvXSV/+GAX5zFuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtLznvforkSWoIjJPY/iFzSxNryLuA8uGGueHny/xZE=;
 b=VCzb29xOxr8mK5G9NYo5bpi2n1wQx7B7pJcucw0984LY7AV8OypPhQ4ZtBqZnqVvFhn1qdUayWk/fXuvwSn5j1xxccvo9cqj7NGagwwJ+91KAoBLaqbbo3wei4CEQV1RxJ7OnKuf+2JfNB/l9zG80o++7PQ1dmlKTeZGJ2XY0Kg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 10:22:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Thu, 3 Sep 2026
 10:22:20 +0000
Message-ID: <906cc917-9727-4763-b144-d1f9ac1b53f9@amd.com>
Date: Thu, 3 Sep 2026 12:22:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] drm/sched: fix use-after-free of the fence
 timeline name
To: phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
 <20260902144204.1843670-2-malhyuk97@gmail.com>
 <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <611c2624e60ea422229e666480da3e504d126682.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: fee80342-0929-4149-a586-08df09a53ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6i651hg7SAKk7IVLrbviI7oBl7xsIpQbDDEEtqTESWrzhIW/x1P8XVnxStZOGY25sZ7nVW+SfPO79+S75evGmupTX3C2hBfDDjX+ttOfj+A4ekTO2LE7PdH/7P7lLPSELjSX4ymKp7UrekNszIV/+zJWfxOnQsM7zS+YoNg7/Gj8XW74AEp9v6MDYGmGPNJajmeIw8MpwNEm4g2/WupnjEnK0FQzRjOjxoAxd3Q2oTy6c9Wb2Wc2JGUqbCYnKKAUDbpWjyC2r/NTS/gvpswu3dinBbrCGl14gxM8eOJW7ZS2BXwhyNOYu8Di9aHZDWnwd8zhPFUAKM54jMoGKq3Q1zgLir8W4vC9JKZYCZGrvxmnN3ebyr6TNmreEc35jQRmAoL0ZE0Mzjl3SOrm2uNf1LX+4ggUbBnOkrjTXNSFXpZXdMo/4KL57LqyxzYKUF5qzvwixFLZCsJp0/ZMz0Ei7QmjhVXAElGdz/UWSe9Sb6wU2GfPfLSNu8e8HLRCQ+6VSAA8b9A4CW8rl3cR1KQzxthHtqVDxnz7xmc1fesS9GGNPxvJEjU7hLeRYXRVBJsMdEmxc8Nsf6HSv0iVaik8ZPEtUIfs5RRyjtT72I29ETNnHkmutm+smRoqKvqGZHPSK/Jwry5Gwk464vxP99zo4x6wSLRkht53JZ8LIjBev/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmQ4TDVETDhMUzVHSEZ2NHltNDhQODB0citUYkR5Z0twYlh5RTVBdTNGc0dw?=
 =?utf-8?B?RHNhVlFHK255WVc2U0djVW5sWkFTM2tsa0JJajRER1dvWFA4ZVZiSkdUUUZH?=
 =?utf-8?B?ekpKMitSa2xuVXBrZTUwN0xCV25lMk5JSjVJd0RlbEp0V3RZNDhYNzBDdTlN?=
 =?utf-8?B?QWZYYWp1MEZaSkhiMlNmN2RlODR6ZFNHb2x0M0JyN3JDQVE1b0JoQit3VEov?=
 =?utf-8?B?dDNWV3lkWlpnbVovWFB3L2ZTcENmdjVTZXlielVIY0M0ZWJPMGU2d2p6Vjdr?=
 =?utf-8?B?clFKUTZBVVBjZUszWXlyL3E1c2E2aFUyR0NJRnN3OXQwamVtTEZZOStteloz?=
 =?utf-8?B?TEFtS05rcTQ4dEVRRHU0eWRId2ZGd0hhejhDSGhHRnduRUxrL00rbWpmVjEw?=
 =?utf-8?B?MmZtckpwMS9nbHMzR3lxZHJZWS96bzZmUStSVU5rcHNxYWUrdVphV1cyT3pV?=
 =?utf-8?B?ZVdkdXVBUzE0bVEvTURjdHJRT3RBcGZWQ3hUNTUzTGF6cG94eXlBajZVZll4?=
 =?utf-8?B?U1d4OTd1aUJicFlNY0U4bUFwbHc2S0Z1RFI3VEJzblM4Sjcxb2pQNlU4R0lD?=
 =?utf-8?B?YVZhckRpVVNzQTVycTN4V1JpZE9haWRWWWNzZmN0a0U2RGIyeGJmNzRYTm5Z?=
 =?utf-8?B?S1VuVzBwZ003Tmovb3I2Q2lrS3hybzFWYkI1eWZDRjhmQTl1cG5mVHk0aHM1?=
 =?utf-8?B?TDZBMVRqVlJRanFpYTMyM05Mc3JUc29XSTdZTW9uNjBsTldHWGxWNDBQM1Bs?=
 =?utf-8?B?alBmeVJlVHc5VDE5N3ZFajhkVzZESnFST3czMmlEN2I5VjErb0dXMTUyVlNK?=
 =?utf-8?B?MFVuSFN2TVVCamNBTFUrSm9PZm1HMVhOcmk1M0xWZ29JUEtHMy9WNW8rbHBB?=
 =?utf-8?B?ZDZ3TElNV2IwWGMyZHloY1U4dFE5VElDekdHalhKL1N1d3RDVEk4TEIxM01j?=
 =?utf-8?B?Q2V0WU5tK2g4eHlCZmJ2NkUrMVJPRjVGVU5UWEF2em0wWEZsU1RvaXgwd0Fl?=
 =?utf-8?B?RUlCY3lMei9PelkyeTZ0bWIrVVNwbmtGa2VDMlIrNUFrUGpBT2MwYTYzVmFy?=
 =?utf-8?B?VWwvNnJTTEdmdnlESndtanNhbUhGSEdOanhLcStpZUtML2xyNG1nYmhqSzF2?=
 =?utf-8?B?b05aQk5FanlkMHhHa24ycjF0NmVrNmMvazRKeHBFYWNVNHcyYzV2TlY5RUxM?=
 =?utf-8?B?aktRQzRyYnpURUR5YVNabDFKZ04xTmgvYUdHZG9XR0FwbnpsM3NoMVdldWlS?=
 =?utf-8?B?WHdmbGYvbHVidk4vRC9tdzQ1bW9QVDhGYnlkSUhlVHZ2WUwvaldldjRTdS9Y?=
 =?utf-8?B?K2dWTWgvOGNYZG1sZ2k2MnNidzVqUitWbWk5NmRhVGpkRklYdDA0ZGloU2tN?=
 =?utf-8?B?aGFrNkFXSU1wUTVzOTZwT09YTnlEN3lZRVFJU0J4Rms5WS9vNERPT1B0aUla?=
 =?utf-8?B?OEF5RFkwbkpKalUwZE1lZHZlS0lGcC9aY1NzeXVoRUdMSlUzelo4OCtyTGNr?=
 =?utf-8?B?bzE2ZkZvVjRJdXpqcjdYQzdUM01sQms0K3BVcmlqR1B2VmE1RURKcTJ0bE1H?=
 =?utf-8?B?dlN3MitsWEhBY3ppdGxJbHYwVm1QaXVZOThKYUVzTHp4U0dTb3lvZlpaMUNX?=
 =?utf-8?B?U3g1RVBQTlBJUWYzaDFSMUcyczAzY3hhb2o5b0xvMWJ5ZmUvZ3VBR0dsNG4r?=
 =?utf-8?B?SWFvTWhNZS84V3l3bjFqUytYOENuZUsvenlReFFzL1VPWDIwaVh0KzIyT01p?=
 =?utf-8?B?MkdsZms5VERJR013SmN5WXBreENiN0krZk5lRmdJaGVOWFU2RTJEa0xJVk96?=
 =?utf-8?B?RHdvZzhOemRVTjJHQXNCY2IySUk1UkhuTXRBOG5sM0RjUEJnNW9CRGhvUElM?=
 =?utf-8?B?V0o1Z1orQWNlNGsvNUMwUjRGZmE5c0dic2xKa3FFblpSdjJsQUNsTi9kY1FV?=
 =?utf-8?B?S0tSaGllTUJDWktJSmYxeThMb2RoVmNmSWJlNCtQSUsyOExsM296UEpNNVBt?=
 =?utf-8?B?em5lNk1BZ3RHeURadVFqZkN3enRreDJsWmRvSTVvQjA1MmVqTzB3SXVkOFZV?=
 =?utf-8?B?ZlVuM0hDem1MZjVLbENYcFBhNktJcEg1ZUpnTVp2UHBzaWNuSmRZSGVkN0tY?=
 =?utf-8?B?bHQ4TThrZUMveGg0dE8rL3lsMVF1cjBZcGh6bExTWnFwK0hkSTUwWUNFc1V3?=
 =?utf-8?B?dTVWYVhBTlN6YlptSHlNZWtoMlFwRVpEU3k2QkFva2EvZDc4TGRDMnNWTXdD?=
 =?utf-8?B?WkI1cW9HZDBERE90ekw4Sm9MdDk1RjlWdEh5TGtXY3VPRnpoZGE5SkxzdTBH?=
 =?utf-8?Q?jzbYFwazrwlSs/AgWv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee80342-0929-4149-a586-08df09a53ce3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 10:22:20.7875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxOF9Oao9ZLlvpyCf7iNvhVRyVI4VSxNXWTKA/o3hokwU4YmImA4OO0eDsSCiHRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018
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

On 9/3/26 10:46, Philipp Stanner wrote:
> On Wed, 2026-09-02 at 23:42 +0900, Jonghyuk Kim(MalHyuk) wrote:
...
>> -}
>> -
>> -/**
>> - * drm_sched_fence_release_finished - drop extra reference
>> - *
>> - * @f: fence
>> - *
>> - * Drop the extra reference from the scheduled fence to the base fence.
>> - */
>> -static void drm_sched_fence_release_finished(struct dma_fence *f)
>> -{
>> -	struct drm_sched_fence *fence = to_drm_sched_fence(f);
>> -
>> -	dma_fence_put(&fence->scheduled);
>> +	/*
>> +	 * Drop the reference the scheduled fence holds on the finished fence.
>> +	 * The finished fence is released last and frees the shared allocation
>> +	 * from its dma_fence_free() (see drm_sched_fence_init()).
>> +	 */
>> +	dma_fence_put(&fence->finished);

That doesn't looks correct to me. The reference *must* be from the finished to the scheduled fence and not the other way around.

Background is that there are a lot of use cases which needs to convert from finished to scheduled and only a handful which does the other way around and in those cases we also hold a reference to the finished fence.

That here would completely break this.

Regards,
Christian.

