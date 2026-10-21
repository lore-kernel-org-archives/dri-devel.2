Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B4A606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R1iYF64K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A1E10E05D;
	Wed, 21 Oct 2026 13:44:12 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42D010E302
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:44:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCxgRbnwJcBcj2N2DkaMtEx3tjeIpywcyk3PrTuW8QPB7fXbIFPtAWrGlsA7CnPc7ljoC0WsrfHEw5yuDeBXRQSh4Zm7Qnv804Nd2S46cId0aFqrG9ZV9TW5rwtixkM7XNhAvkb9cZilAF50cq85f6yMBbgvxUp73OMVIxDrHuXlb4SJ53ZMNKjJ7N0shslI8tOgRli/OhGCJk8s+U5Iyv6vqDvTbl1/82jo3wT2jL1Px9AgCfwMptr95y7u8MhfIjiOZ+O9L7XvIC+v7etJxKUcTJN7RzbhptRV8LMh6NOhcHq1px5+pCXu92nRm+08jM7MwNN6wEAGOj1XLMaLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmcTquhVUVn4FFP29E4iYGCWwD4alnb0SGt+v2V6CjY=;
 b=t5Dw5jsTMFB0lGnGzv+GKdamJZgirh3fEdDn5OSAsyWo2cHspVlIGe9165i75ElGjBskRXTBVbJX0JD8RUu7Vm4Gpj+iDa/i/OJ+OM5qijFA4Sk4ujyMwARPmNiyN0qMC3AT7VXKp79E7ME+oRAYkWM18sjm6LTf/LwBzpcJ6vhbwehfjycRn8p4A6m/5owkNtRJVGwDF2o+Mfzy2PBAyy2MZbBwxYpIyJLSmICbwAwYvxjyJIwKYSJ3uPz9rf9XwVb4KZZSqMPrn5rQjY5ylZUcIKRgrgleRcuZtzc2NsRZ6doAm6z1CMaJjplE6GsnsUvtqj+mKdeYqz5tO/bsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmcTquhVUVn4FFP29E4iYGCWwD4alnb0SGt+v2V6CjY=;
 b=R1iYF64KoQM3t7Y9PiVsH7bZ8S7KZbsyuw2rDjg/cJzr8alUCRpDsXVhJdqEjUNbJdXPJpcXrA6dsBDtME43VC+ZBZWINA+Mt3n+sk3Pqlk4tB59+NYuPtCfBlyXWHisUwLItxfm8wTnaT4HU7pF+3LfjcZAJeX22/B800SzayQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 13:44:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 13:43:59 +0000
Message-ID: <6e45ae81-0319-4857-a96e-159509c1b140@amd.com>
Date: Wed, 21 Oct 2026 15:43:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: Val Packett <val@invisiblethingslab.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261021093533.1990028-1-val@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b5214d-7960-4da4-fcaa-08df2f795b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FQmNkmJmRHnLkbrdvlztfrogXjxTWkNcUi/gI8WexJVKwq+lBOvrZ8tcnkUhPV12KZBxpu4ev+b6VpWjynE8jF4XHM0zE/LPjx4/R5r93d7GeQ5aLXKQszfZCiOhhRSfHVA8Uin9SQuC3NcSUAiHZTA2b5bA5CYQJoWric7/5ognzDfqBxn+qU3/XQCdAdQEey+bsdwutbk4GOf8LeXxKx/S57xEleW+OYhQ7xtMStpXdJl2dfnr62tB6MSjGMINqD+tQy3d+KjMWnLwMw6CYUmlrplBbW/s6BwInTfc2d+qudIUe2HTCsxkYraWPDDSfO0TJ+Of5PMtTValIihyCoY+7E2AnxDVDVXoWMjZUrHYqAUXhp9nVGt4htTmFNV80wI7/R6j6PNdS1R7Ela8Du9/TWDengVd4KFonS7hf0djCm3gCQASJdkcCCf6t1SgF4QXf9zxPxYQxRZ/WY2Cef1NaS6uOiFxLmMPZTwaqRNC608NSWALBjQrmuwC83ky12ehfO1UMUgjTNnrW+WaL5GCtv/jRtje1pHlgYc3anYTDR1Z9d/W3vgbrTelA+7MWhzIu+v8owv7o2afjMIhyqve9CQsGxHpm8NVkErSoKBBalwlOT1lUcW79n6JYWNp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhFbG01L3c3RThXcE51WmVGTmUwdmM3RUU3SmwwbzBGYWpvRWp5T05qSzZt?=
 =?utf-8?B?eGpINFZaSXU0THVMcFRaRzYvcDNpZ2tzK3FDSHJ1WERKUkdvSDBRM3orVnA0?=
 =?utf-8?B?ZkNhanFxSE9EVW5tVkdlbVJnVjdGeU9nSEhKQk42eEJZdzYydmxwVTdhbzYz?=
 =?utf-8?B?UjBXd0Nqd093TjIzUXZpdlN0OXkvMGs1bjVEaWpCWU9VbGFSY2dUcGtwQ0py?=
 =?utf-8?B?dVAraVNNNHN4cXRmQ0R3ZkMwMDdGK0hEaUZvTTZHbmM0OTFsZ0FsK04wcHZT?=
 =?utf-8?B?UDhQMnExclkyU3FUc0NseFplZHZxd0JOV1BBOTFIRmJxa0NxSmk2RGk1Vkpt?=
 =?utf-8?B?RnpvUWM2NTZCY3lQS0phc0wySlFBZXVHS3BReWU5ZkFuWFJLV0xQeG1GL01T?=
 =?utf-8?B?TWJLVFBCYnBMQ3JGR3hIWUhLMXhJUFdhRitmcFdHWUZkN1RsMUkrUHpYcDln?=
 =?utf-8?B?N1dSaytucjQ0ZkFxV2NjdEUyemZhSDhVQWZxWDdHQTA4anBOL2l4akFIK29n?=
 =?utf-8?B?UERZaVJNSGpUdWVHZk9tblVJUS9kN2pWT2tYWVl5QkFEc2hBaTZTME4rZytM?=
 =?utf-8?B?TG05VzdGaUpVUU9CT0tyR1ZBYituaGpRNVlUR2YrY1JLNjRiOStLRTFFSU9m?=
 =?utf-8?B?bEg2Q3FPQnA3NkY5dTkrbkF3S1g0MDVmQUVTc3Rac1lWRmowSmNLY1RkNkho?=
 =?utf-8?B?a2xnbm1iZkhieUZiUzZxUlFiRjJoOTBldGRTOE9UVDNHcWFvNUxRREx0SjM4?=
 =?utf-8?B?WkI1dGpBTitFZnZBWXE0cG95aG1sTlpEMWlLekxRSEVNRHhsTXBNbmh6YTEy?=
 =?utf-8?B?VFU0YUQzS1JKVnowYUEyQ0Y0eE9BZ0JlRUErZDlOcU56UVR2dXU2ak5IUHBU?=
 =?utf-8?B?ZUQ1Z0c1VzZ3WnNISDhmc2ZYTjNWaGdtZVlYZmVhRkpMZGxKdzBzY2JFeS9C?=
 =?utf-8?B?cXBhQXlQNXJsQldiajRBd2huWjlOV3pFUk9xVU5pN0JWMmlBSTZFQXVaZ0lH?=
 =?utf-8?B?MHF6b3pqWEZUTDlLQlhoancwRTZWVW15eEtSUmRnVHIxRGJkTGNROFpHSzFQ?=
 =?utf-8?B?amh6b0pqT2VBSWRZbDB5V211SjBGTWZaWngyeS9FUnJBaW5mYndicndOQlk1?=
 =?utf-8?B?dzJqSG9KeW9qc1QwcFBRZ2ZZN3A3bVJodGNwNGVPMmpKVk1GelM2OU0wSW80?=
 =?utf-8?B?K2Q2QW9USk5qZ21qdmtoWnlnT3daeHJ3cGdYRCs0N1cyWlExQWZtb1VjSEtm?=
 =?utf-8?B?SEpIREM5ekVKTnNzSjJTWlp6Wmh1a24yVkovNnMxS2VaWmJaM2N4UHd6Y2Ux?=
 =?utf-8?B?L3RoRzI4UC92UFpEMG84bTdkMWNvRFBHRDdZNnNCY2I3Ymp1TGtVa3RiY0xD?=
 =?utf-8?B?TFBDYUU2b2lLL1RJWnB2eWg5VC83YjJEcU9yaW05bVBUd2hBZUcyeGlabUh4?=
 =?utf-8?B?TGt2aSsxR2huZ2d6WjdsYUVWRm1NUXdWdWNKOStXa0tlcGoxTDdHWHFFSzZB?=
 =?utf-8?B?NHVYUkZlVTFWSzhaR0E3YjNDWGU4VWl6U3FCUlY3MWpuR0hDSmRra2RnWjhv?=
 =?utf-8?B?NkJVazVFSENERFZUbHFlbkg3ZyszdXExbjVOeTNMcVhwYlhJOGx1RG9QM2c2?=
 =?utf-8?B?cy9lbVJBV2tHZW1lbGV4RTVFUSttMWlVbE8rNEZuZjVEZ3ZJUndqL2ZLTjJz?=
 =?utf-8?B?Yk1Mb3F3V01sMlQzakhLODZHUVIzWjd2Y0Z0NGgwNEp1ZTMxTzZoUFJNMGVr?=
 =?utf-8?B?VlRMWjBITVpYcVVWQk95S0MwNjM2QVl1RzZKTnpMaStFeEhqMzR3ZW9aN2NH?=
 =?utf-8?B?ZVBBa1RGUWVTYUQzU2pNeGRxUTlMcTB3Smx4SWJaZkFlMGdLZjRaUmZOTFJ6?=
 =?utf-8?B?VWgzcy9qdFhZSlIxYVo3S2NXcVNsZjh1MmozRU1GVUgwVzBTSjFFOWE2TzBG?=
 =?utf-8?B?WFFFY09HUWxrZ3Y3bWdMaGVCaEZjaFJzWEpyMGFKVUhhSUNLaVo2NVJrSHlw?=
 =?utf-8?B?VTZ3U0x3K2hsM3Y3eDlscGxjZTZGUFNoUmxQMk90dEVpWGZ3eE9QMU43cHNx?=
 =?utf-8?B?NHg1ZG5qWU5PV3JQM2xySlBzamlORkVMYU5UeVFTa3dHUi9acW8zWXVOZlc5?=
 =?utf-8?B?cjhtZlFtUnhFaS81OXE4ZGFEdGhWeUNpeHRCTnNkbkVTQXpXK2pJMXp6RGs3?=
 =?utf-8?B?WXNKdklZejM3V3M1QldMMDlVZ2ZFRmNiTmYraXNUanFoVXIxY2xWeUgydUhJ?=
 =?utf-8?B?am53VHF1T2h1MnVuZkswYlM4andObklONnJwM3U1SXh4dTF3d3ZUM1dHdDdY?=
 =?utf-8?Q?HUxy6uQoo5e5KJoO+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b5214d-7960-4da4-fcaa-08df2f795b9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:43:58.5745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bufyHFN7dPhlIzR2daK3vyVnCd8wGR3z3y8Yp+OiU+U/VF2YA6JgPiwrp9wiaAY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
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

On 10/21/26 11:08, Val Packett wrote:
> Introduce a new ioctl that allows userspace to register an eventfd to get
> notified when a dma-buf is released.
> 
> The current use case comes from virtio-gpu device backends wishing to add
> support for guest-owned buffers with host handles (CREATE_GUEST_HANDLE):
> 
> * guest creates a guest-only blob resource on the virtgpu
> * host creates a udmabuf from the iovecs sent by the guest
> * guest attaches the resource to a cross-domain socket send operation
> * guest immediately releases the resource (no longer needed by the guest)
> * host sends the udmabuf to the compositor, but needs to delay responding
>   to the resource release request until the resource is *actually* free
>   on the host side, i.e. the compositor no longer uses it

Interesting use case you have here.

It doesn't sound to crazy, e.g. it can't deadlock the kernel or anything like that which we often see with dma-fence.

> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> ---
> 
> More background on the use case with extra links:
> https://lore.kernel.org/virtio-comment/20260903021442.423274-1-val@invisiblethingslab.com/
> 
> Funnily enough, gntdev-dmabuf (which is used on Xen hosts instead of
> udmabuf for this) offers "a way" to "poll" for these release events
> on its dmabufs (IOCTL_GNTDEV_DMABUF_EXP_WAIT_RELEASED), but it's unusable:
> 
> * it's a blocking wait!!
> * release does not happen while you still have the fd open, so:
>   * you can't just timeout and restart, you'd need the fd to restart;
>   * and the only way to even close the fd is from a different thread,
>     after some arbitrary timeout when hopefully the wait has started.

Oh that made my day :D

> The buffer lifecycle coordination we need this for applies to KVM as well
> and it generally doesn't make sense to have this as a provider-specific
> thing since it's not related to the provider in any way, it's just
> something we want from dmabufs in general.

I wouldn't put that on the DMA-buf file descriptor where basically anybody can mess with it. That is just an recipe for trouble.

The better approach seems to be putting it into the udmabuf_ioctl(), so that from the very beginning you add the eventfd which signals when the udmabuf is released.

If we need that for more implementations than just udmabuf, we can potentially add it to dma_buf_export_info so that exporters can provide the eventfd file descriptor directly on creation.

Regards,
Christian.

> 
> Thanks,
> ~val
> 
> ---
>  drivers/dma-buf/dma-buf.c    | 24 ++++++++++++++++++++++++
>  include/linux/dma-buf.h      |  3 +++
>  include/uapi/linux/dma-buf.h |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 36cdc342627e..1321fee73656 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -17,6 +17,7 @@
>  #include <linux/dma-fence.h>
>  #include <linux/dma-fence-unwrap.h>
>  #include <linux/anon_inodes.h>
> +#include <linux/eventfd.h>
>  #include <linux/export.h>
>  #include <linux/debugfs.h>
>  #include <linux/list.h>
> @@ -185,6 +186,11 @@ static void dma_buf_release(struct dentry *dentry)
>  	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
>  		dma_resv_fini(dmabuf->resv);
>  
> +	if (dmabuf->release_eventfd) {
> +		eventfd_signal(dmabuf->release_eventfd);
> +		eventfd_ctx_put(dmabuf->release_eventfd);
> +	}
> +
>  	WARN_ON(!list_empty(&dmabuf->attachments));
>  	module_put(dmabuf->owner);
>  	kfree(dmabuf->name);
> @@ -537,6 +543,21 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
>  }
>  #endif
>  
> +static long dma_buf_set_release_eventfd(struct dma_buf *dmabuf,
> +					u32 fd)
> +{
> +	struct eventfd_ctx *ev_fd_ctx = eventfd_ctx_fdget(fd);
> +
> +	if (IS_ERR(ev_fd_ctx))
> +		return PTR_ERR(ev_fd_ctx);
> +
> +	if (dmabuf->release_eventfd)
> +		eventfd_ctx_put(dmabuf->release_eventfd);
> +
> +	dmabuf->release_eventfd = ev_fd_ctx;
> +	return 0;
> +}
> +
>  static long dma_buf_ioctl(struct file *file,
>  			  unsigned int cmd, unsigned long arg)
>  {
> @@ -587,6 +608,9 @@ static long dma_buf_ioctl(struct file *file,
>  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
>  #endif
>  
> +	case DMA_BUF_IOCTL_SET_RELEASE_EVENTFD:
> +		return dma_buf_set_release_eventfd(dmabuf, (u32)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d15b2b31d3c9..07b4a589a793 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -429,6 +429,9 @@ struct dma_buf {
>  
>  		__poll_t active;
>  	} cb_in, cb_out;
> +
> +	/** @release_eventfd: for userspace release notification */
> +	struct eventfd_ctx *release_eventfd;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index e827c9d20c5d..566dea778ad0 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -179,5 +179,6 @@ struct dma_buf_import_sync_file {
>  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
> +#define DMA_BUF_IOCTL_SET_RELEASE_EVENTFD	_IOW(DMA_BUF_BASE, 4, __u32)
>  
>  #endif

