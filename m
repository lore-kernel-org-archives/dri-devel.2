Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A746606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dfLdTYej
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D2710F191;
	Mon,  9 Nov 2026 11:10:58 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013015.outbound.protection.outlook.com
 [40.93.196.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9EC510F191
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiaQ8PGyx77D2uNnMyFcUawsRebaSmiIc99YR9wF8u70HfUwtD7qBtaitPo9UhA3dKcQKF0bWItuhAV/GrLW9U7yScb+XMmoJcXtvjwvSHEZy3JlM0/893bVGobPAfSXYWfHUEsywVJFJFlz4/dH6xWNhJ6smZB0j6Z7sK8ZiiulBzIMHKQQVbaKZOwJuCO31JX/vk6lpEhzZT79MPOsbnkkCTMlYMaS+gHOFdzrHVAWA1mb80A1VZleais9EK8loXFAviGvn6LeReqRQMx0IyxLgn5WKDjZ62KTCGkTQVOgP1vkszmInGZpnRcMgY9gGTi+ojhpetYX50Ij0spFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO257lzhwGxxwfAkbYjA8t4tI4hZRQ49W7E2xlKrQrk=;
 b=aSFCcOjxjW+e37/GoyEnXnqS7N5oNdbc6FGNJQiP3Gip4YO2o1A5XKNagRgbVXmtRH6PBrNcLcnj5H+2ZAmDvdiDyGpcUcY1RxeNkl+9Sa4BBFe22vIYxVeBpQcUesNptGC3vn20B8eiQg1vv9yLVXUskMfWiaVzCeYALIh8T/YjM+N60ZRSXSQll8ys7s7N6Eefsgsxe0nWbDP9La6J+rEpQXmY8kEIOsvol2w8DT4m5/tlexXQz0po7ue7wjWjz/ZUUMy3NA5fm8p4Ws4FIShEbsE6Y4h7WfnoeKy/nv26jURUqC9LfOWBo6CHUvMJxwHUBkYk6TT4VOd1RBMq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO257lzhwGxxwfAkbYjA8t4tI4hZRQ49W7E2xlKrQrk=;
 b=dfLdTYejf5SUDhDF2rbAsYdvHjihVTn6qLW7dVmJfrrTw5OaKtPWWi3rWcC46cPltkvCWyCOP+rtb8FKJTKeiVlswr/PTIfIXlPxJNxe8PGDO95VRr4J+cypc9wff+aucJwOL953IzKTpMqIs9JCZD/X/2gG9jbbLan7Vi3TseU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 11:10:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:10:47 +0000
Message-ID: <04a02164-f69c-478e-80fc-1b8b3fcebb62@amd.com>
Date: Mon, 9 Nov 2026 12:10:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Open heap device files O_RDONLY
To: "T.J. Mercier" <tjmercier@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811204123.3198370-1-tjmercier@google.com>
 <CAO_48GEUhpyeenX8Vu1NoDnvzib5FGv3rOBYNYwQEWu1-6cjaQ@mail.gmail.com>
 <CABdmKX0uiX=QKFAYgwwBPHW-X3vh-Rm7w-cNp9EsJzQarTzDpQ@mail.gmail.com>
 <CABdmKX3Ep0cAPakwKDYWnOkrFgfhsJAv9Mh1us+OfscyNeb2tw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX3Ep0cAPakwKDYWnOkrFgfhsJAv9Mh1us+OfscyNeb2tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 062801ac-da57-4ac7-bf3d-08df3e521ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|6133799003|10067099003|4143699003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: FOcUT1sQ1453UrLNkMSDNOAG5dcdCwnzYj6IWE+6c+zQVH9AZ938E75g7+Sr3KL7zfvosOUU19uRuRX84fKUWNRZ24O6aTWvfL2C5/jO2snXNk+ZnfwqVNH3u9kQcMYxAQD6dv9wZ4ouv1bIg30Vd5bLydMGTFEvNftBiIec6RJ8cGoYXh6lYbo744K1miUmZ66vc6LOx63D6+Iopz1B/sh1L8xiI8Uj+beFgG6gXs2XxCS7y4+Obr4AK3ddmNAwQJLbvEYLBtWfjjKxrFDjcY+MxkQRnv3/09SX5blUvYpRMEfUQJym4zvfl2vBBzKvp48glHvGUeJsYpkilyfNEPZTOaW5RXbrp+jld3f5zDlIqWrij846VG5sC5+VVa2OT33WG/qWvgWabzrexNgqmlaoKzWepHt870O1dBAVPsyu2dS5sYzwYHtF9+xeohYLjyCmGAcksdQWctgU98w/XsAQQuC7OmLXtG5TD0Mvi76Hr0L+zFiT7S6GPX7YJFuylFq2pTgw23HmrePr6MOJiu/JtoSdGtrOmVqsUb0jN7hYmx1Ydicb8iphdcXGKz+NPxTcV7rYUcAYqhJKBznMvkRNnLAtiUMiHnjC7iLhytg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(4143699003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTR4KytvbHhXaGd2dzc4SkEvdWFmc1BMQ1VHa25jU0RLd1JwQloxalNMTHAv?=
 =?utf-8?B?bnpvQ0FZSlpkNHhzeGx5cjc4Q2ZXYzdOMWZ2WHdBcjE4aldzK2Y1TGFnQkpt?=
 =?utf-8?B?RHVqeTczdmd4RzltN205VFRNYWw4b0NzRDF6blMwVHh1R3hLQXZDTkpnT0ZZ?=
 =?utf-8?B?V2E2V3ZaemtxNFp2WThDMGUzdUZ6ci8rOWJ5ZThFOXlBSlJhcWJjSXpQZDZa?=
 =?utf-8?B?MEgwWkdNb1ZIdVBFRDk3VDFVQVBPc3ZDMXNxU3psWFA2RmIvMjFnaEZIcHN2?=
 =?utf-8?B?a2NUNGE2UmxPbHo5dDdQSlJEVitsZ1Z4UzV1NlRhd2NtbVJ4eGxtQnBBeHl3?=
 =?utf-8?B?eVlUZE1IQ1BVbFRDSEtzNXFHS2xsTDZPQkN3TFRiRXBsR0tzcSs3V2pTTmx1?=
 =?utf-8?B?OWZTR201REZ1MGhVWUcwUjlpNWNpejZHK1R5TGVXR2JzUDVWWW9Ic3g3MVh0?=
 =?utf-8?B?NnM3bFc1bVJ6clBoOUN2cTlDbmJVZi8vaEhaWnJ5Zk9QYXdqWk4vZjErdDJ5?=
 =?utf-8?B?ejloVFVteGFMamRCZ2JZTkZkYjNETkdtTTAxN2RlYmJhSTZZbEQ2QW9MMVpn?=
 =?utf-8?B?d2U3SUhLaytEcEZ1cEwwd3liSThvRFJJa3JJMHliRVA4NVpRS3lFYmhYWVpn?=
 =?utf-8?B?SHExa3h0Um1MZTFzOHlTeDFQNFV3MjBnSkhsUmNPdEJuRldBT0JYTWgrTEsr?=
 =?utf-8?B?RDBZRGZ3eHlvVE81TDBBTmlodXNWNjBWWGJtK0xWRWdvWEVDTVF4ZUdKSWhJ?=
 =?utf-8?B?RExObjZVWElveDNoNmVBV3Buak1vNHBPQmhZWk9OYy84dy9jb1JIRjZSREJR?=
 =?utf-8?B?STFHT1E0ek9mOS9sNEJaa2FGNmhUekdvTC9EL0I4RWhEekY1N0hIUmRWMTBn?=
 =?utf-8?B?NGYxMldYZkdCYmtCbTR3VW5vbnlpdld2UTF1akhxbTF3SEQ0aFcwMFl5VkQ5?=
 =?utf-8?B?TGJjZUNtYWZiQ0tDakduUnRtT0k3bXlCUytmVVNqWGYwR01XcFF2eGxXKzFK?=
 =?utf-8?B?WlZyN3ZqeU9mRCtFVkVubW5NV1VlU08wMFBjRzJCcWZqYkNHZDlhUXZqUWpG?=
 =?utf-8?B?OHhWOFlvTzVWeEpsRjBWTmh5b2l2RXVlTUdYRnRZS2dPOEJ1N21RZUpFY2VP?=
 =?utf-8?B?MGErazU0L2UxYjhwbXQ4Qy8wb3hXLzkvYmxPUERFOCtRd3AzSFpQbDMwMGdX?=
 =?utf-8?B?MjZrQS9oT0h1aHI5ZWpuamdpMkE1dzN0ZFZZd3dOSld6eWlNZFc1Mjl6TnZE?=
 =?utf-8?B?VWVSV2JzQ1BKQVpGano5WDZJSzVldUFJRXhYQmRPMEpGTGpxS1U0amxxclZx?=
 =?utf-8?B?dDlNMHhFZkNZdG5uRDRvQlBrVWdGV3JaTUVuYjJ0UzRTa1F0bHE3WDNmMzVP?=
 =?utf-8?B?WGxCemF4WXVCQ2FFNXdwS0xML0ZUbmRMV3V4bzR2WE1TK1ExdjZMYmdTVlh6?=
 =?utf-8?B?L2FmUXJQamt1d3Q0RnpJWW82YjJhWW4xUEordTA1SC9FazgvSEpLK2QybXRO?=
 =?utf-8?B?UzlmNFkrYkpXQ1pyN2VZeHI3K09iMFlBSTVySFpKUk5SN2pNcFhvNVBWNUNO?=
 =?utf-8?B?Tm51aEwyUVcyNS8yakpxVlprYWN2YUhCYWZjVVowV2tYQWF6SFo0d1NOWmRZ?=
 =?utf-8?B?bmJ1RE9sS3NPeStaU3pyaFdJRTdBay94L0xheEhjRWNNTHBRM3ppTEF1U2h3?=
 =?utf-8?B?RHhRZmtYMW9WN3M1QmlGUG5XMW9XWFRHMGpOUU5GUmwwSTlQMWhZQXpMTDlG?=
 =?utf-8?B?SzBjQTRRdmVYV290Qmw5RHJqa0x0cTRlNFZwZHlzalY1bVBac2hucFRSVkdn?=
 =?utf-8?B?RERZaStYalFhZVF0MDloMW84Nm1MZERON3phcWNXVUhtNjA1alJrNGIwTVBB?=
 =?utf-8?B?M1JHdkY4VXh5V0N6bXN0RnRBc3FmZXFtVXdRWTlPKzlDV0w3VVJQSk1sc0tm?=
 =?utf-8?B?b25QNWowOWVGRG1pM1VLMzVWeW5mRTBza2lRems0TXpsSG9XUlRkeWZDY3RE?=
 =?utf-8?B?NXlDUnNyNEwvQ0NKZ1lmTTdac0lvcDlXNUpINnluM2NtNHZvS3Jncnc3TUdJ?=
 =?utf-8?B?M3lISkIwS2U0dlgwV2g0eUpkN0lzd2VLK1d4bWVBbUd1UkVaQTVXaG1wVmpl?=
 =?utf-8?B?MzNsRFUrUm5ieGJoVVV5SnVvbnNSVmVQYVNjd1h3dnVxTTdqcGVNdUNlU21V?=
 =?utf-8?B?Q0UyT0lGak9BMVZhNk5zT0tUL1FNaEFTM3FENDAvNzVNVitEd0dURFBGRDNW?=
 =?utf-8?B?SE1ieXhhbFp2WWZqaytCZXo2V0ZjWnNzU2s4TTl6NEgzZDZXYjBDMy9VaG5v?=
 =?utf-8?Q?4r9W09ftdSgFaUVMbx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062801ac-da57-4ac7-bf3d-08df3e521ae0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:10:47.1193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek6ictfvM2oyVquq4Y9gchCycUXRjno3yKrLbS45nk3eItsBQUIB3sZkZEEp4MTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 19:42, T.J. Mercier wrote:
> On Wed, Aug 12, 2026 at 9:06 AM T.J. Mercier <tjmercier@google.com> wrote:
>>
>> On Wed, Aug 12, 2026 at 8:02 AM Sumit Semwal <sumit.semwal@linaro.org> wrote:
>>>
>>> Hello T J,
>>>
>>> On Wed, 12 Aug 2026 at 02:11, T.J. Mercier <tjmercier@google.com> wrote:
>>>>
>>>> Write permissions on the /dev/dma_heap/* device files are not required
>>>> to issue ioctls and allocate dmabufs. Applications should be opening
>>>> these file as O_RDONLY. The BPF dmabuf_iter selftest already does
>>>> this. [1]
>>>>
>>>> Users are pointing to these selftests as examples of how use dmabuf,
>>>> and encountering permission errors on systems where write permissions
>>>> are not available on /dev/dma_heap/*. Apply the principle of least
>>>> privilege to selftests which open dmabuf heaps by removing the write
>>>> access mode and using O_RDONLY for the open() instead.
>>>
>>> Thanks for the patch.
>>>>
>>>> The same is true for the vgem test using /dev/dri/card.
>>>>
>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c?h=v7.1#n49
>>>>
>>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>>
>> Thanks for the quick revieews John, Christian, and Sumit!
> 
> Hi, I don't think this has made it into any tree. Can this get picked up please?

Pushed to drm-misc-next.

T.J. I think it would be a good idea if you apply for commit rights to drm-misc.

The tooling used for that repo is a bit special, but considering how much Android uses DMA-buf it is probably a good idea that you are able to help pushing code upstream.

Regards,
Christian.
