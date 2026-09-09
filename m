Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E164C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49FC10F190;
	Wed,  9 Sep 2026 13:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FXwitd1O";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E8F10F193
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx6Qa0/8ziQSQ7r1Pzm+dUUa8Wqfgl3hQMxncipg0DfKaat2Ozxklf3Iwcr1m9BDY7CCf8714kQVYjepNOhYDKdHRsH+4K0qBQ0xUsGzmRJr1zDYIAiNyPK6WWyPcR5T3yBO5pYIGCVevONs/fBAGTFnG4HSW4OXkxP+m/E15nxRCz9mLa10Rs8AVnA+09k8CMYIpOKlHXw/PuivsfQBFF3JVzV0ebkSPXcogZ8qaV8sniLsSPkodvkOhsc6nt6DWWDr7PqEfyGdUQ39x75n3wfVMvmjMav98Tk5h/IWpcRxOCpGxSceXl4xtqUqowdRu54CqYYFNjU5aHqog71gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaOrPidGiMnHWbU12t2KBcRP+YFK90S7Z0svntEO67E=;
 b=Vpkyax1U2KqNHMg5/oZFnTFUgLTwrqjwzfxkUCbWYguQsOIU195PdpQGT/21/TWGWTmUXfZBGBGmtAa1n8pgThh4/pzwsHZ+kpl+QX8aR3YTEUi1BQSlrqFupMU+qimBKeLwF5TdmidsrnQH66r93b3QbtYKXy/M2CFAg+bUNVHod7zJnPDW85CP0y5rJGLVPXJUDrebc0aGUNhdkaJ30r64v3hiQoqkdCFTCVFlOHcQuVYHFXrvonK7Whj43uLi3BriB8JJGvt5tfoBGfWebPUeQKvFQ+lqCaMtD7zXR04fiD5pmIR4PmqIFEI+NLWoEyMKqbE5dsmFZgMa+k1yWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaOrPidGiMnHWbU12t2KBcRP+YFK90S7Z0svntEO67E=;
 b=FXwitd1ODJvPUC40YeWTrdafyBTsbicKqU4mlx/yTOMF152YF7AaViPvVUyCvpvfVcQ2yOiNx3DScSglKQZIsVX945fBQKJu+5G8jxQBMM/SlyAkPFDbc64FHzlQU6OhHiXM44SChz3Py8nlEOiq5Qea/fq88E5MuCsrxv+UPFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 13:45:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 13:45:38 +0000
Message-ID: <33c9db65-fa30-4d34-9026-98144ce1ed95@amd.com>
Date: Wed, 9 Sep 2026 15:45:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Li Wang <liwang@kylinos.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
 <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
 <2026090924-corsage-shout-833d@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2026090924-corsage-shout-833d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4021f10d-94c6-4149-2de7-08df0e78a1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|1800799024|366016|4143699003|5023799004|11063799006|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7Ltx1vP7cwLXLOfgJ1DZcEffo3twrk36mB4t3r6tlryl50xKKzLxazxrvfTwGu/xpETCCaYqBo36jHDECPbY07s0sNbP0GkvRTBlM6PklZnXWUwTu0qFd4lDeZ/45+xt3tF/ZGIp8f8Rv1TjIiYZ57UcRC41AZnQTOL+KXuXUpwZ+8MDna3f9AcApyHQQ0qzA9PH74Ddk0YGzE+E/+S0uh6cNIEVV5LXrFt5wptZiUQTzuj/4kaYZLkskrb8FqykqvMAZ05p9DpIDJCYfrskbXmWtCHWQi5SZp3BrJ+uzjhrMii8jrlUpdgpnlCPSffOqmHx1JylUQNrFFGVJMg+b10Bc99/hhNF2VSngRYZedW6Q52sbD5Hu1fBDjzTFk8hDUf7GclIVcGjuUrdh8yYE+P3iLCXK8/EdJ3k53ZiOpN0/AvpExXojn0+EZ9mhmY3CpERv4zU0WYm+pEGTNlGIcyRp45PFoTxdJy5JWjvvS8NAzYYoOFugUSq07eO73zsXS4QfxUVTeIpwfvoPu43H/rrhzYWCN14DU74zLhw3acQIKB+P7OptXqs6ZIiLiWHgdrCmcCwU0dvcRohAKP7ss8esurk6CcN/P1XiYUGLo8pEuospeOhr4b443cfJIXmcV0fBYMUgUfaZcKRo1z8S/0rSKOjuoIjy78zDchLB+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVGYUtVdkprUDlmQjBpR2lySk8wSG10UnErb1VSaDFhZThHTUF4MmxaOVNH?=
 =?utf-8?B?VnZxSVhvUm9SM0xKNDh4elFYY3J5VllnejZYcHM2MmFyNDhFOGlOYktrU2Rk?=
 =?utf-8?B?RWZLSU9vM3o2SmtXWVR1WjM5bHY1ZE05U0NEOUJDSVlGMDI1VVordTZVK29p?=
 =?utf-8?B?RVM3R0FrVVFTd095S3IwdXdlaEovTVk0YmZOV0hYMG1LdU0zd0xrRFp3WWdh?=
 =?utf-8?B?bnkyL2JYSWZOS29wc3dPdUdZenVVWE1lRUJhVi8wUEQyVFM1MmlaSGNsaG9H?=
 =?utf-8?B?dWpKb3ZyY2JITUNvRHJJR1FPak5ScWxsK0dhL0lySEN6Y01VZlN1bURIaysx?=
 =?utf-8?B?RnQxeW16QmNmRnE0U0pGL1NkeCtnZGVuSVBhVFRQcEgyTEJNbDh0b2VxaDZr?=
 =?utf-8?B?R1ROSEI3SkpiaDVDMUpBUDdZNE80WHZ4ak83QnZIbGZ2dGtLaUt4a0lOSHdK?=
 =?utf-8?B?VzFOYjB6YnBkZ3BkaHVDT2tSZ0lhNjFOSUZtTC9SRGZFT3NmZUJmbHo1dHJ5?=
 =?utf-8?B?dnpzOWNocDhyVDNocjZTREZWWHlObVo2Si9iRmpWMkozcW85TWtaUzZOOGgv?=
 =?utf-8?B?SFladnBJakhZM25SZHNDdWE1RVU1QzNuaExuMWJNTHVUYW9qcDdwTzhvVDIw?=
 =?utf-8?B?VmtMUllZOUpERjNLSE1Wamt4VndWa3d0d0MzamtBVjcybThuUDdmVWpmaEk5?=
 =?utf-8?B?aVVSTFNSNGdacjhUOVpUU2tIa3ZiSlJzWkJNZ1J1T1VDWEJjZDBOejdlYlBP?=
 =?utf-8?B?VE8xd3RBVkdQbjd2UWs4UDRkNm5iU2VEVDNCaFN3M3hQckExZ01RUjVPNkxk?=
 =?utf-8?B?em1yNnZjZTZYMk1TT0h0RVIxQXdpenFHOGNIUUVwQUZDOWRnSXBydmVtcjlh?=
 =?utf-8?B?bi95UWpGcGZyVVdha012QUVkQWhUam8xblMrTU9JZ2pKRFgxbjRwc2wydkI0?=
 =?utf-8?B?Q0t6OUxGK2RpcGhMZjhLR2Y3emNaMnByeTJTdURxbXlRb0pld0JEbEkreWV5?=
 =?utf-8?B?K3ZPM00rT3BTb1VJN1lkUUpPL0w4SU1reHNtT0RaVGp2Y1hvc2ZtTkl1UUIw?=
 =?utf-8?B?ZUFEUitTTC81R2tReG44ZjdJeGRiblVnQXcveVFneER5TEZhV0tYaFFoeitP?=
 =?utf-8?B?aldNV1o3Vjc2bW5WRkZmazZzM3ljeWZreWl6UndLQUxpYm0wK2dnVHFzaFJE?=
 =?utf-8?B?TlZBYkNuU3JDUkhPeDN1c2s0eE40ei9EempxQU9qVVpaMUhtOUxqV1AzK3Jx?=
 =?utf-8?B?U09jZW5BRFcxZ25pcm9UYTRvOGM2bHI4WGl3cHo1M2M3aFNpbjlyMjFtVmw0?=
 =?utf-8?B?WFViUHRmTURXblBIaldZZys1R25vQ0YwcjFFRHdPS0Fjc3ZhRmt6bXBOb0Ry?=
 =?utf-8?B?SlR6ZzVhWS85dUF1RUIzODMrUExZa2ZHQi8zU0ZnSUpIZmFFNUppb2RSUmE1?=
 =?utf-8?B?ZnY2bVFGZC9md0JQM29NMVB6b1E2bkNTMUNGSXNnOElxdWNKRlMwYy9EREtK?=
 =?utf-8?B?aUtwSERGT2QwejYvSUtHZFRhenBOTVFLbkd6VmYrUmN3N21mcm54VDdTclhO?=
 =?utf-8?B?eEdEaFlCb3gvVHQ0dVJlMzlnNHBGeEVhUmVhazlvNmZSWlhGRCtBeUdkRzJi?=
 =?utf-8?B?N1cyZU92V3dLOE0rUlpNRGIxeTZXZ2JIR1NNc2FIQVRIazBTL2hZYmc5Skhr?=
 =?utf-8?B?b0h3UVUxVWNDMzlkUVF3QkFleG1HT2E2UzI3QS9JamJMa2tEMW5LVU9OcEZI?=
 =?utf-8?B?MzJTVlYvVmJwaWZjeEV0NFh2NGU2eXdEUnB3TisrVlIxSGFmTyszN3NZdjhW?=
 =?utf-8?B?QlJjQlRJWUx2WGlWemFyNHFvWCtXTWhRaWFaNkpiRzZJM1c5ZVkzT3NVWWx3?=
 =?utf-8?B?dnFtb1I1NzBYdTZWYVFrZmF4SHZsbUlFL3QwZGpFdnVMVFRxUFQwQXJ4cVFC?=
 =?utf-8?B?VXNiZHdnTHVuUE5nVkdpWVRBRVJhQVNtRTRYQVQybW50enU0MnNiUlc1YmVt?=
 =?utf-8?B?ejdkeWRmKzZrT2F4Qk9yLysyR3gxUml2d1QwVHk5dzUxVzg0L282dk1ra3Q3?=
 =?utf-8?B?djlNdWdwWEJUQXhYLzJMbzBsU1NUclJYZGdOcXd2R0dIL0ZQU1BPSkZjQWVZ?=
 =?utf-8?B?dndlNGpPU2xyS1dmN3YreXcwNXh2OFRjVG1XSFFxbkUvQzNFeE1Tb3dpcmEr?=
 =?utf-8?B?eHdRRnRqT01jSXg0NVVqdExJNjNvTVllMWJyanFxdFNJcXFML3IxS003dk9w?=
 =?utf-8?B?ZzN5MllNcFdkMkxxUnF5QWZDeDZPY2kxVWlSZ1NTNXB2U2pFcWlNRTZwYWpO?=
 =?utf-8?Q?RbRCjxNjhf4ySdZpu4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4021f10d-94c6-4149-2de7-08df0e78a1c8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 13:45:38.4695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9pXt8npDjfPCPeP6YyrveEQIB5alJzq3VN+j2Xq9Mu1yu9bbt9K/+zEKYHkPmUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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



On 9/9/26 15:35, Greg Kroah-Hartman wrote:
> On Wed, Sep 09, 2026 at 06:42:03PM +0800, Li Wang wrote:
>> Hi Greg,
>>   Thanks for the review!
>>
>>>
>>> That's not really needed in a changelog text, it could be in the 0/X
>>> patch :)
>>>
>> Sorry for the clutter. I will move most of them into the 0/X patch in v2.
>>
>>> Anyway, you didn't cc: the io_uring list, why?
>>>
>> `scripts/get_maintainer.pl` didn't output the io_uring mailing list, likely 
>> because this patch doesn't directly touch the io_uring codebase itself. It only 
>> enables remapping GPU memory buffers to CPU virtual addresses, which can then be 
>> consumed via standard io_uring APIs.
>>
>> I've added io-uring@vger.kernel.org to CC for this reply and will keep it in v2.
> 
> Great, as you are using that as the api, there might be some parts that
> will need to be reviewed by them.
> 
>>> Nor why "fgds" is the name, that's going to be hard to remember, does it
>>> stand for something?
>>>
>> "FGDS" stands for Fast GPUDirect Storage. GPUDirect Storage (GDS) is NVIDIA's 
>> technology enabling direct I/O between GPU memory and files on NVMe, 
>> widely used in LLM workloads to bypass CPU overhead.
> 
> That's nvidia's specific solution, but this works on other devices,
> right?  Or just for that one platform?

That was nvidia's specific and very hacky out of tree solution which as far as I know is pretty much abandoned everywhere.

AMD came up with something similar, but all those approaches are so fundamentally broken that we didn't even considered upstreaming it.
> And you are using this as a "bypass" for the normal accel subsystem,
> shouldn't this be part of that subsystem instead of a custom user/kernel
> api like you are creating here?

As far as I know there is a patch set under review and even already partially merged which enables exactly that functionality as general feature for DMA-buf which is vendor independent and should at least in theory work with all drivers.

I'm really surprised that somebody is still working on the vendor specific stuff.

Regards,
Christian.

> 
> thanks,
> 
> greg k-h

