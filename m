Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05117606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yDdXj6ZR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3534E10E03D;
	Mon, 26 Oct 2026 09:17:08 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B47B910ECEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd4M0upXbkBlT9LqMb/U/jte9GElMj3Zy+coe+zzxDrfK13q6QAEYv46C2d202riS0j0ckQuLj1mdKOrZB39jtjvGY1n3k0rVFm90QKyqwRIRgL6Qz8Ee3Hy/IzXBZXO7i34jv1Shl/SY2nWOY4Pug1Z1YG18WRXr8VKNtB1ccROMPx06fi9DBFvaiZ3sgKOemEyNS6TM38BqqaTMC/nVweC7lH2qlLe8H5zA9DDkz36lbImlbD7lnxjSRIEnEScaVTzgL3yx0Vacebr332skeZGyrhHTRebQWGg8ZhIsmv/DgXoL5wxOAQI1ZYSTdmZjyJ703l6wDHsG1kJTKg1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkkT4hOOdOXSTPZp5qqoBCqrwk72h6p7FWIDAlx3ot4=;
 b=pTJT7i1cxP3dIK4lIBNCoqkBLhDX8P/vdL4LNO9msUVKXXW1VYxavlmBLS3rnSTGcgckERVnCW+zoDF4wA9JyRMa4THFM8iX/ZItg4BpnPsGUv69TBzUgp3IHnZUY+Xnifd1t91/6r8P52ye76woDFpvq15wFdCAjR8mL/rIHOPFcPe+RD4XH6WhX24bMx6FiZMFA1DtlImxoiKeJIiLA7MczU+iYr9g7HRD5RwTHV7XaBvV3nzD5JTwtf6gfmSmHPUieuc+nNGNukj8Nwaduyl+FJA/LR/hOxSGQ4DQi7o/8I3Hl0DgD1ThhlzMKekSoZRKARPJZfJqZCdTIEJQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkkT4hOOdOXSTPZp5qqoBCqrwk72h6p7FWIDAlx3ot4=;
 b=yDdXj6ZRr33xNdmSwoSTe/upNG/icAzxAfp7425k2TfIioxG3G21RncaaZZvSkUXgFCBSzukaJVxm6nGqudN8ux7c0krDQ37NoNOvcMiL5M4yMjszVxZkmpu+Cpz2Dy2goeItTv9/9+Cm20NSq4+ObvuS9xUtGrX8DoemJSCNVA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 09:16:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 09:16:58 +0000
Message-ID: <8bb2f7a6-f7de-4805-9b6f-fe2f500d1be5@amd.com>
Date: Mon, 26 Oct 2026 10:16:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: Val Packett <val@invisiblethingslab.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
 <6e45ae81-0319-4857-a96e-159509c1b140@amd.com>
 <a1057af1-2390-41c0-ac57-4ab9ef0fe31d@invisiblethingslab.com>
 <bcb4f2fd-dec9-4d2f-869e-a1578843ab84@amd.com>
 <3d654cee-81a5-4f0c-bf15-a24e31db60d0@invisiblethingslab.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3d654cee-81a5-4f0c-bf15-a24e31db60d0@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: 115ccdcb-9b75-4786-1407-08df3341e2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|11063799006|56012099006|261022113327099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PigpMqR1L8xb5jWM2WGGdq3bkvqRH/6ShgTcblcAZkjxgyLXwYAa6Pa/XnDkXyrpKUV7A27UVxxrkOIb3vfouNB5rer5UMnN9HaDvzBy4beWgYHTvF9fsN8ir3ngI5u5SueY9U5+rBinC116VPjPaFcOrHcwmdjoiEwSMJpg87sGQOu18YrD001q5n+J1Dci4Zti4Se7ZAdfe43IgYKkQvNzrvoH51LNycYC8tUwKc0jp7xCkp0F8P3cBZXLk4dSHXvq7/Q9Rjg+i1nApDxxeb8NbipWdpiY1QTj54Xq35Hf9TZyEe/a6fQLcxLNGetQdazkrEfEnoBueVXV75k0TfJ8CUhAK9OrGXGB0YTGgHqd7YDiz4RWepBsJhV3qHRI9RTTnSI1NffMDshR1/eByop4j0D51/9o1h18wX3iwwCy6cgciM4JeD8bxd9oBXOYl3tBWEAeWJf7QWPcHHL2Wa0Rv2GP6Ktdo49dySROxqSsU1UVygmgOLFJpToc/1b+/9PP4CAI4NIEWcx/r2agQw8k3fHdJ8zeGOm1vmjffX7dxdsh5dofZl6wUT8egHNKPoavzptVEczeQ0SL6i1QWytKAV4Vret4t9z5mepf26AGZsaQgutyCj+vCUZnuEJNX7RbE/0jWhfpLk/DZ3byppNPE/MmArcmWzXdgjRn7F8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lIVlpRWlNmS3ZsVEkwZHBaWTU3VnlLRzFrUGpnczYyTzJhR1crSUtYU25r?=
 =?utf-8?B?eGs2dXdUZk9ob3JPcnF0SHpJTDZmMUJPaUQzT0dNSlU1eXYzRldOL05qaWEv?=
 =?utf-8?B?MG9DdkJIcWxreEZ3U3FXa0dDOGM1SE9YcFIyMko5bGtDTEoyTGNOVm5LdUVw?=
 =?utf-8?B?ckIwWVZqc1c1U0hQdVZ0OWtRL0U0QndSeW9qcWpvaFE1WlVVTDYybzV2UktT?=
 =?utf-8?B?RFBzdGVsZlNaWW9HYzV5Nk5RRlo1SExFeVdZdWJmbnI2SzJ2Y1ZCbngrTXdt?=
 =?utf-8?B?SlIwN0lEMjFXRWxGaGptVUVjRUhJN1NhUndLRDZTNWc4b0d0R2Z6b1Z4QkpG?=
 =?utf-8?B?OFNsd1JxMVZzU2MrY2phRzY2S0xFUmxxNGhOQ203RU9abnNhK1MyT1lpdC9n?=
 =?utf-8?B?ZTRiaXo2MWVsSWhwM1I5eXF4eC9ieUIwQ0pVWW1tUjd0aDNmOU9XZFQxUm5Z?=
 =?utf-8?B?SU5vVDRiWmVMNFg5Y09rN2JKcFZuNkFnY1Rpa3BvOC9LVVM5akRDdFQ0KzVq?=
 =?utf-8?B?cnEwVEN6aUkrOEwzdEY0bG5wcW5mcEFVcGptZDFqZ1BLU3ZLUkRzNUE3UmtQ?=
 =?utf-8?B?UDlXMWl5cm1HMm9yaW9JYkFpeDBXYnFIaWdjVmhRYWhEbjRnNmtUTWZSWE5p?=
 =?utf-8?B?L0hxcExRTzJPcGNPSWlHN1RtQ0dlZkRvNTdsWVpmNWhXNVhYN2pUbVo2TXl2?=
 =?utf-8?B?Ni9aZHlKczNGU1VCQlZjbHhYbXZNRVpGWmhOQ3NQVGRZR1R1dG9WQTR5MGUy?=
 =?utf-8?B?NHpvM081b0p1WE5aMmpWeFd4YlkzcTR4WTdKR2thR1Q0ZDZXWW9kRktNeXJS?=
 =?utf-8?B?MFJwV2ZnVFNXMWN0bjZjZExFazB5ZXVkR3h5M081ajU4UC9zV29VQmQxY0hL?=
 =?utf-8?B?TDdFUHRBMkpXSTkzd2dNbmVLemZ2UnE5ZTd3NXdnbVVEWlUxL3IxbC9mNGlN?=
 =?utf-8?B?V1RvbHdhWWpPcnN5QWFxZUc2alhKY3Y3cm5FU1U1OFVuQ3JiNWtSeWVvd1Ur?=
 =?utf-8?B?U2lsY000MC9mM2FuRFROUzd4dXF6SWp5dFFZWUtOd0RqaGNkeDlEQlQ1TVdN?=
 =?utf-8?B?dUpRaEFHRWd3OEovTVBFTyt0L00xTkhhclpZaXIyc05SOVhmNytHRkxpd2g5?=
 =?utf-8?B?S1JmYW5PcmZyQ05ndVdMem55aWZHNDg5VndKMWtEZGZuYWhveGpKQ3RSZlI5?=
 =?utf-8?B?YjdUS0QwSE1Idi9rc0cvcjZzVzRRQ093cytOUGJ0ZGpjd04zSUF2b1VBU25R?=
 =?utf-8?B?bHBHT2o4N2pscXduNStnaXJoZTZwU0xheGxGK1hZSXdhclBHUlR5VUE2MURV?=
 =?utf-8?B?cWVRbTEybFNhUFNHTGtaZ0UxVDVRRjBodFdsTkJzRGgrY2JWL1RWeDloODVP?=
 =?utf-8?B?NWo5aWpoM21pSEFiOFVUc1pDOXptOElYN20ydENuOVltMkk1N2hSUnE2ZmFK?=
 =?utf-8?B?YjdnRXkyck8zd1d1YjFmRklXMkVQd1JxTFhyVDNVUk81TkQ5Z2pTdzdxZU94?=
 =?utf-8?B?eFpTeTBlSjUwK0lxYWJHVFRJcnowOUdodW1IZERRTEROS3BRWlZpVUhEUThU?=
 =?utf-8?B?Y2FsVWNYMWJ5dGlrK0hIYk54QnJ0N0tKQVU4TWJzSnVQS01nT1AzSGZNd0Fr?=
 =?utf-8?B?OFRDMFNFVDdFY29uNTBRdUtObnEyZ0VYSG5LbVRoRkp1ZzRpZkEyS25qUWIv?=
 =?utf-8?B?dzJxMXBnbzF6TWx2S1A4VG5vUXdGK3ErU05idXFkeHd6bzluaGJ3ZlYxd1lr?=
 =?utf-8?B?VGxLU21BVzFzZWMzWS94RVZNZmlobVJuUEpCb3dVeEsxVmp0VnEraHJtR2FU?=
 =?utf-8?B?eDdyRVZkRGNIZEhjT1hZYkNnYWQ3Y2I3bGF0SGVEejVSbFJtUzlVc25LNVNv?=
 =?utf-8?B?dUppZmV3bEtESkxUL1paQmtITXZMUHI5c2JqV1QrL1BZVk5PQVZxdHI0QmJn?=
 =?utf-8?B?N0FEQm5GQkt5T2dkYmQxamg5MWlVbmZ4d1BpdUNuVmtlMURlQUF3cFkyNVFU?=
 =?utf-8?B?UG9oQ1lrRHdseHdXcmNTeEludGxiNndkTUcxRXJSSUxlRWZZOGRHbnZLUTZN?=
 =?utf-8?B?RUcyUDU5UEVORHRobXZuUjU2K0JuenR4RHVNM0ltR3ZLbXZUeWMyZ3VpbkVM?=
 =?utf-8?B?bXZmZEFwTFZubURWTmFXTFgrOWZkcHBaNE9YcmUyS3RXZ1BySzVkL29jYW9M?=
 =?utf-8?B?Yy91OWVNa0dPTy9JMmkzWGg3Um9haDZCVEduR3ExYjNBTzdJNHJRZ0xsL29C?=
 =?utf-8?B?SUlZRWZWbVFmM0dIcmV5MnZORFNhU21QZmloSktWNGFJSlFGNE5IbWZqanE2?=
 =?utf-8?Q?dRng0dsXRmxwZivEks?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115ccdcb-9b75-4786-1407-08df3341e2a4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:16:58.0251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfDCtkO6uwDFLAAM+o/9H7ejlEoJ+Gkw8v8Mg58Ze6gQj0WtU6HFcOYe5WKVA2US
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 02:36, Val Packett wrote:
> On 10/22/26 9:26 AM, Christian König wrote:
>> On 10/21/26 22:16, Val Packett wrote:
>>> On 10/21/26 10:43 AM, Christian König wrote:
>>>> [..]
>>>>> The buffer lifecycle coordination we need this for applies to KVM as well
>>>>> and it generally doesn't make sense to have this as a provider-specific
>>>>> thing since it's not related to the provider in any way, it's just
>>>>> something we want from dmabufs in general.
>>>> I wouldn't put that on the DMA-buf file descriptor where basically anybody can mess with it. That is just an recipe for trouble.
>>>>
>>>> The better approach seems to be putting it into the udmabuf_ioctl(), so that from the very beginning you add the eventfd which signals when the udmabuf is released.
>>>>
>>>> If we need that for more implementations than just udmabuf, we can potentially add it to dma_buf_export_info so that exporters can provide the eventfd file descriptor directly on creation.
>>> Well, we already need it with both udmabuf and gntdev-dmabuf..
>>>
>>> Involving the exporter sounds really annoying when it's not something exporter dependent really.. What if the policy is just "only one eventfd ever" i.e. the first call of the ioctl succeeds but later calls on the same dmabuf return an error?
>> No, exactly that is what I'm trying to avoid.
>>
>> Nobody except the original creater should be able to insert an eventfd here.
> 
> If there's no replacement allowed anymore, what could possibly be harmful/undesirable about "someone else" being able to do this?
>
> With a "first caller only" policy, the original creator already can be 100% sure that no one else is able to insert an eventfd:

Ok that sounds like you my argumentation wasn't fully clear: That approach is exactly what I try to avoid!

> If the original creator calls this API before sending the fd to anyone else, well, the original creator *is* the first caller, that's it.
> 
> Otherwise, i.e. if the original creator is not interested in this API.. it's unlikely a different process would use it, but if one does for some reason, I don't see any negative consequences from that?

First of all if this gets added as common DMA-buf API the functionality suddenly becomes available to every exporter, not just the ones who explicitly implement it.

That in turn would be rather questionable because lifetime is something only the exporter of a buffer can fully deal with.

For example it is very common that the exporter delegates cleanup from the ->release callback to a work item and your whole approach with the eventfd on the DMA-buf then doesn't work any more.


Then second when the add this as common DMA-buf functionality then it should be usable by everybody and not just the first one who asks. Otherwise you can run into all kind mess with that when you give a DMA-buf where the eventfd slot is already used up to some other process which expects to use that functionality.


For now that functionality only seems to make sense for the original creator and a limited amount of exporters where it actually works. So my suggestion is to either add some functionality to the exporter(s) or add some common functionality to dma_buf_export_info to aid exporters with their implementation.

Apart from that the approach with the eventfd looks perfectly fine to me.

Regards,
Christian.

> 
> 
> 
> Thanks,
> ~val

