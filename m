Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B154606A328
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PDSh6scw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C2210E9E6;
	Tue, 20 Oct 2026 06:42:32 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D6710E9E6
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:42:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz03mZ56zwjlTP6Kt9h2OqkEXSGzd0GbtPbHj0r/uaVdesw6bDAmMVP+UtKVRhEhbl9wYFrzibNLxdHrgejyRawl4F/Mm/wbszNQlj7BLH+4dLD4Mk36yhiv2miFvUsmeh36CV1n/I05Up4DDvnv4BmjKNfA4jAaCkR/2wkfncfahMMFRcJPTdD/tpjxlTLbmwdHZ79QczVL/rvmu0FEoyZERDjHpwUt86H7+sIXmZiLPEku1G6+eFKqzvOaVKb1GyvN5XbiGMrHrHeD5csBRk5nVYRSCdsO8VXaxuzB6BEXJ/Lo2IQHH61lWFWgxjE46y60jtKCKcOHw640mHzsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxaNGXJItpPThMo+f0/DCe+lhgtTFXUhOE3CRHRj/h8=;
 b=Z6OsNI2iaMzsv/RipSkAj+L4PbeLkkUPo3tlq/4Ma1WabQhBccR5FTCThjQn9wOBUt7QfQVJ0+Wo2Zukn6WYICynN/EjJDQRKgWhKXQ6U/b6Ca1fV6DiDcAuLgQReteUR+ZBksOwDeNuOPBbVjT9QHo8JonaewfAjnlrDxwROVEko73fZKaHsZcffpdgQzdnbnLRiGLX2pLiBJMnl8SXM3/LKIAgVyZE5UJHknQu9I6Z4nQGU5F8BTRoJHYZ/viKINYl4rzvdAcMbzF8C1jkL9JnIHKYRfdU6EHr5loXthQ8moCYO62aUSVd751iLkZYAnWlKE9i+LfIJHVervBgUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxaNGXJItpPThMo+f0/DCe+lhgtTFXUhOE3CRHRj/h8=;
 b=PDSh6scwW8T2i/odKnK5G8Dxcdn77ghVMvtuEYaStVrDW2nDmpvUe8J1Mko1VSTeuvuj6fxf2ZUgnzH8TT3SfX7722+po+YXW2H3aO88PVDIY/bavJGkOrtS6/+4lWq6LkpBjDfj6wFD88Dps3oAIh3f2rLEYfXFh3Z8yZ43WJw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:42:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 06:42:23 +0000
Message-ID: <dc91d903-139d-4253-83f7-51a78dd4530b@amd.com>
Date: Tue, 20 Oct 2026 08:42:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Restore the scatterlist entry count before
 freeing
To: Leon Romanovsky <leon@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Ankit Agrawal <ankita@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20261013-dma-buf-fixes-v1-1-0e2d9ca41f3a@nvidia.com>
 <20261019183146.GH64621@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019183146.GH64621@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: bfda978e-652c-408c-4404-08df2e754beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|260925021911599003|260925022911599003|260925021311599003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HAHP4qFsbxQAHsiC69iRw/Ppb4np9gHf1+C/fm+VQJJ+WF5HWzkk2lsnIqQj9hdzQCX4TmLuSC/UUNVZ0PWEU8XWUPaCPgCQtD+rzj3f3/9kW3HaJlaQTf9xOJhHM2BfjvPBgbpc2q30W9KonXT+//PGreuTYKwe1s1QRLv5Qx8kZk9CDD52ZTg7Z16LQkjAtUJBpH79HjDjO3/sM0aSEmKHqoZfhATZxm+/B8491zLhH+v6e4KGqspk8jCnlcz1HUGYn/EQncvkOzUqAL67eGeeAjJNt37v2X8Sd1aLFA7+3P/J8z7YYYeC1dNd1dLqmfbiWLEe4CTFBz5rq7QXS8OEKSdZTsArRa7JjRUd+wb8G7LD1A4qbwoY3qLj2lfsDOSHoMK0JlBwihU3oMSLULlaG/dfFkX9hTFw0lCuXrVRt4QfZs2KBYTdXyGQKrxOMfHFb/nAudmm8wy92w7aK88D5ZDBcsaeo0yhEDrlg3Eo2ge/lAPADbXmvBMHz9cEVqZlvWFagLMReZ9P9BmjeA5NS2CfmwVU8W0i69HVGSkX77pp1KrEXm5B1/F2UpsrC46i0Tfu6TIwApto/z4ZX7jPSOHnJUyN48JHyJqRE8V5ZCCNU2YgKHaemkirpbjbDRp+y+J6HjG/OxFIBDp4EVXh3Hh5NPXg5h2heruHHo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3BreHlyNXpWN0QvVjBJVnVyeGlVelNpOE4xL2cxVno3RlZ4SWp2OU5UWmNR?=
 =?utf-8?B?UGVVNzFiSHRkMTRJMnBXWWNJWlNoVDZOZUR2Q1VuOHlXUVk4VTR0T0V0eE4y?=
 =?utf-8?B?MlplQnJCbVBTcjFqbGNwOFFXc2FPc3JBUm5PczZXMnh6RllkaENOa3JsVWZ5?=
 =?utf-8?B?alJORE1ISC96TFVRcUxSeUkwV05mdGx2cVRlUXNRazNZTkgvVW5ZUlJQNmJS?=
 =?utf-8?B?eUl3cndaYlJ2dmpIQnVmcEN5ZFc1MnNTeVBVMUtnODBaUFNXV0NBeGxUSCtX?=
 =?utf-8?B?MVRmb2VLSk5kM2RsQUVCS3lrOTI4UzA0SGpKdFdETlZweUl5d0lOMnFaeWMx?=
 =?utf-8?B?WDB2TlRBbkl3aU5wWldtZE5HNklveGtJQWFha1FZTkJBeUwvR2VuNC8vekli?=
 =?utf-8?B?YjhzSkFlNk4xTk5uREFQR3RzWlk3NFdLM3ZoKzlKdDFvNDdqUEtIYmVhK2Vq?=
 =?utf-8?B?U1FTNWJ4V2FGam9ITlhtSUt3T3I4Z2ZZeE16VTU5eFBqNjlGcWpiWGE2Smdz?=
 =?utf-8?B?R3B3eGc0b1NjekRtUytRa1VuNkVPcklrTVk0dFpsd3M4NDh6dGE4VHRoQWhJ?=
 =?utf-8?B?NnZNYkhLbmVQQXVOTkVKRkRKNXNYRzJ5RXdRL1JhVVlWb21Zc3VQR3N1NCtQ?=
 =?utf-8?B?Y21MNUhSMnVQcXJ1Qzc3cUJDU0p1a0xLTHZmMHhneTNPODBKcWlEK1JvYm9M?=
 =?utf-8?B?QU42TWZ0Z2JLQTlIM2p2L0V5WExWNi8rODE5Wi93ZjlwbitLQmFnNmxSY09n?=
 =?utf-8?B?MkpvL2xNa1pvSWVka2FKSTZjUGFnODdWNjhVNU91TzRHUUhZSnBaajNRS05T?=
 =?utf-8?B?MmlDU0NEbHpVeldLbXRwdXdiTmExZnJWMWRCdGhGdE9rL3F1dGlkR3dFUVIv?=
 =?utf-8?B?ZFozanhtdmowWVpOVUdiWlExN2hBM3YxWk1vTzNuZzF2QTFFYlF4djRKNWtq?=
 =?utf-8?B?NkRZQzlhY1V0a3Q5Tk1qT1l3Skwvbk53UXYwU1Q3ZUpuazlIQTlTRHRQRkh5?=
 =?utf-8?B?dzE0TC9taG1rSk5iNkpsbHg3WUJtSHVPZnhjMDVHQlZ4UjlpVHVuM3FzNWZD?=
 =?utf-8?B?ek1rK041RFoxb1ZQNjExbmxUQVk0M3N6TzZ0bnl5REp5Nk1xamp2YkFwc1Y3?=
 =?utf-8?B?RGloa2NLUHlxUzlmNUJ4cVVNZ1I5ZFAyQW5XQUxqSUNONHpqcEE1TC9vNUpw?=
 =?utf-8?B?Y2l1WFEvemVBWmQ0VWFOS1dOSGxsZ3JETHU4UVRJOWVmdDdBbTQxSjAxWjAw?=
 =?utf-8?B?QThpUXc3TEVCellsSm1QTjliY3JrMTIyYzNaTkk0dTZwQ3BkdENKSncyemZz?=
 =?utf-8?B?ZTJHUEg5Q0JLTHdPZEo5UWQ4anlwN255MFJVTHJzQjZOVU1SaEdMSnBtWWdo?=
 =?utf-8?B?RE5NS3B1Y3hwZzIyOXJUeURKL0Uxd0NKZUxVajhocW8wTEoySGViQUFtNFox?=
 =?utf-8?B?NFZvZU80bDJyeHpDaFpIRUswejVZU0N4YmYvUnNmZktIRnBqVkVWWVI5RHhH?=
 =?utf-8?B?WWZSZE5aRkVuVmRYd05RVml6MDhuci95RmdqOTNINS94a0p2elNUK2pJdHZn?=
 =?utf-8?B?YVkwcThuSXI2RVl6MWhJUVhIWjl3cFBOOWxuNGJMNjFjUVh4R2RrVTZqU2hB?=
 =?utf-8?B?a3FoWWhqV2pTclZzRnNkMFlkZE4rU2lpRmNNYUZacWlib3YxRTJFTlEzRnFy?=
 =?utf-8?B?WHR0VGNwaE45aENYNVBVSHJUMjZFcmJLRVhBM05US2JnV3YrM1h2MTdRbDhk?=
 =?utf-8?B?TzJlRThVanNaQWtsRGdhVmY4dEpLZFV6SjlTT042d1ljUUlKUkp3VEdVMTZa?=
 =?utf-8?B?WGlqdUc2UVlEZ3JWRUZTZUl0ekVsYy9SbXVFTERqcldQaVFZN3J6WDNvZlBs?=
 =?utf-8?B?OHJ1N2owUjlRZlhPOXdXVklWL0RoYmJBcU1zQ0dPQ1l2ZVVoTDQ2ODk2b3RE?=
 =?utf-8?B?ZzcyUE5tSXJZSjB5VUp3VE53OHU2RmQrR0JzS3pvUkdSa3NlbllpZS9kVFdU?=
 =?utf-8?B?WjhMWmRwR1FsRlJCamJzM054cmgwNG55TmhObFc0Q1B6NXJqQUxLUTcyS1BJ?=
 =?utf-8?B?a2hBdThDTG1MVmZ6aHVaWS9COHZhNHV0ZEU1YUpHNTBCZ1hTQzFDU0hWeXJU?=
 =?utf-8?B?L05Sd2RkaFVuVE9EenlVNzdtbmFxMHZaaEdMZ3lnYUpnZjN0V1piZVMyTW9X?=
 =?utf-8?B?ejVlVVRuMVl3THNwNlA4RGZkQkVlYmNucm5XRFBXZnIrYWdab0IrNUtSSWxm?=
 =?utf-8?B?MU9IQWJvL3lhRThDclpWVkRQZkQzYVRQa0hQSHdRM0J3VS91aFVRYzV3R0JT?=
 =?utf-8?Q?t2occyHxVHuUUlnHSV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfda978e-652c-408c-4404-08df2e754beb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:42:23.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtapGk3nZuaW6LhedchaEEHuej2HZMvie1Lg8RpScOVBzHlyHKjA16XaOqSFsCV/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 20:31, Leon Romanovsky wrote:
> On Tue, Oct 13, 2026 at 02:46:24PM +0300, Leon Romanovsky wrote:
>> From: Leon Romanovsky <leonro@nvidia.com>
>>
>> dma_buf_phys_vec_to_sgt() clears orig_nents to mark the returned table
>> as DMA-only. Since sg_free_table() uses orig_nents to walk and free the
>> scatterlist, dma_buf_free_sgt() leaks the allocation on every successful
>> map/unmap cycle.
>>
>> Restore orig_nents from nents before freeing the table. The helper
>> allocates the DMA list directly, so nents retains the allocation count,
>> including for chained scatterlists.
>>
>>
>> The reported kmemleak output was:
>>
>> KMEMLEAK LEAK: 2 driver-related leak(s)
>> KMEMLEAK LEAK: unreferenced object 0xff11000125ceff00 (size 32):
>> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295031027
>> KMEMLEAK LEAK:   hex dump (first 32 bytes):
>> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> KMEMLEAK LEAK:     00 00 01 00 28 38 00 00 00 10 00 00 00 00 00 00  ....(8..........
>> KMEMLEAK LEAK:   backtrace (crc 4e8077f2):
>> KMEMLEAK LEAK:     __kmalloc_noprof+0x451/0x8b0
>> KMEMLEAK LEAK:     __sg_alloc_table+0x2a0/0x4d0
>> KMEMLEAK LEAK:     sg_alloc_table+0x24/0x170
>> KMEMLEAK LEAK:     dma_buf_phys_vec_to_sgt+0x84f/0xed0
>> KMEMLEAK LEAK:     0xffffffffa1ad21a8
>> KMEMLEAK LEAK:     dma_buf_map_attachment+0x138/0x690
>> KMEMLEAK LEAK:     ib_umem_dmabuf_map_pages+0x249/0xc90 [ib_core]
>> KMEMLEAK LEAK:     0xffffffffa138f8d2
>> KMEMLEAK LEAK:     0xffffffffa1396abe
>> KMEMLEAK LEAK:     0xffffffffa1331a5f
>> KMEMLEAK LEAK:     0xffffffffa13320dd
>> KMEMLEAK LEAK:     0xffffffffa1ad696d
>> KMEMLEAK LEAK:     0xffffffffa1acecc7
>> KMEMLEAK LEAK:     0xffffffffa1acfd17
>> KMEMLEAK LEAK:     __x64_sys_ioctl+0x72c/0x11f0
>> KMEMLEAK LEAK:     do_syscall_64+0xa1/0x4f0
>> KMEMLEAK LEAK: unreferenced object 0xff1100016dbf3a80 (size 32):
>> KMEMLEAK LEAK:   comm dtr, pid 4432, jiffies 4295034705
>> KMEMLEAK LEAK:   hex dump (first 32 bytes):
>> KMEMLEAK LEAK:     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> KMEMLEAK LEAK:     00 20 10 00 28 38 00 00 00 10 00 00 00 00 00 00  . ..(8..........
>>
>> Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>  drivers/dma-buf/dma-buf-mapping.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Reminder, thanks

I'm waiting for anybody familiar with the code to review this.

Regards,
Christian.
