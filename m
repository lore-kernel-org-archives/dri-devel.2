Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FE606A32E
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ke+2cvUZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0956D10E065;
	Tue,  3 Nov 2026 08:18:38 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C324C10E065
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 08:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgXckiBNrh/rSUABJZkl22OcjDROF3RLtP9TvSOpAI1svmzOzcuc5ksEnXDbCaU1x+w8yGxpKfMqNMEnlA2kdOAOJOaRSXHm4mMf9scLkYcVn5XbbMmSdG5bli7fyy5XLjKrEsyeSTloekV98SooZdXJEVOB7JmRqnhNezxcFSbcq8OoPTFq+F1czXo5m26IQaYUi1EIjXCRLrq3czA7f0Sq/tALtd8JSp68GQz2QqW9nCgeuDlV42g/hh/S/QlBsJ4xweVKkE1opKzDKEcocfToRUPdwD/VJ3+RmkIIUOw/4R17+RX45DQluCBdnuMSQG2HeZZoZ/jBTaj9QoIWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x/lI9NulMOsOkA9APYNVNt8I1sryCaBQizYfOuaPko=;
 b=EJjKGjx+Q8giMhiDlP3FZ3E/j3fGLdNiGHcgD1DAQAcLFMmSXmMKny2qP7vbgH79atvJPn3QufqOcxH3qkKBBXAll1dIkaelFb0TAwof0ksvcxUo9UoDjk3whKhVGxfpmejnvjpA0tyCgDYPWRB8HLmnrGAhysIe/jjcVYkUPRgc2nprmyMGjn0yc4ztUyc8LWOGq2BmXKc7VCFqYJk31ayyQrLg+rE7OkD60FB+5loUB07WbxQ2A14tjTXaqaSFBv/zCpWnwaTPbFuGbFGjmkTRPRKXd+Ek3SuOPDjsDHGT9cyL0ljqteGwYxv90wnW4CwjIQytxl+wVns2cTbs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x/lI9NulMOsOkA9APYNVNt8I1sryCaBQizYfOuaPko=;
 b=Ke+2cvUZGaK53907gym+PcKeCFLGkayJ35am+453JrHdZNnm/KpD4twjtLILD3oDZa05Vh7CGFgG1lJjmW6ppx7qfjsI12QweFQ1w17966gE5LhNdRJhDH4UMlehukNFsAQuzWG0+qNtnyqPl2Rj8jp3gt4NIlK9YWg523GWopQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 08:18:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:18:26 +0000
Message-ID: <37102f95-d316-41b9-85c2-0f56051ff0a5@amd.com>
Date: Tue, 3 Nov 2026 09:18:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Release input fences in the unwrap merge order
 test
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, phasta@kernel.org, sumit.semwal@linaro.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20261103064457.1056056-1-vulab@iscas.ac.cn>
 <20261103-spiritual-archetypal-jellyfish-2f8fdd@quoll>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261103-spiritual-archetypal-jellyfish-2f8fdd@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0358.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9c48d5-ff06-4926-c6d4-08df398308b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 88uF/k4YfScG+pEfhix2XDrMUa3UtBQAldjCYFcs3oAsLOGauWZqrkdEAjaa6k/Y2BYDW4LI4lJlkz4yuJiRkmKhd5rst26ieZX5LuWvCMfWGv6CTO2SroT2lytuOzaxPbiErLHlMgir6dmDGN8GVF1vVrSmMjetH0dnIGEWnaQ48M9Rg7r/ioZcD5poZjQ8Qip/aA94/ZyGogeBwbiXOPH2cUTis0brVyV0su1E5SMUH5ydHuVKmkmmAxfa/gNp7g+gjKuHGAwOZE9dDo924HJociqzsTb10oRs+lQzZ6btOxhc78hV52WiUm2TW8MehUOctIWWzW7k0srQBp3SBcJXoCaJZwlu35UJI8+pT4kvH+rvXsjSzX45vD14w3n/2wmEzQ8sgpM+DPDLXaYyZ9wkl1kjatz90XvRHZLpWyKpdoxVDYc1CxhyEzp5Gbv393y0g7vtui3xxWwPjkTzUkLuJUjQpTWbabTufzWptB/0IAlbcjd5yw1V/4sdpNBz2Er2YJoM4LxCHHPAoD2SPaGArJzMlIUpy8EFhzSrRXuGSVuNpYNiDS67ijdKOcimBFMq0Pu0a/A/jb6LzXQprCOxiSk+ZoCWz4HHKyGWXunyzFix4ssTtxbFnFLon3U9xDdPiiktsAoWGyYoBf5bsF27xh9WwJPgiDndEShOOsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVczNDNmaUQ5bHhMZkpDbVo1R05RdS9Ebk9Sa3lDcmdVTlJCTzBVUDlTV0hz?=
 =?utf-8?B?SGtadlFjby82WW1ndFlGMmNCcko4cjBCVm1rT01vOGpIeUJhL1RSNVhScGMy?=
 =?utf-8?B?U1dHVGxkNDhrc1NQbi9iUWlZcGNhQW11NFVvSk44NE9yanBsS1BFQytheFly?=
 =?utf-8?B?bFNERGwzbG9mOGpRZFIrU2hqN0xvVCtTS25PckdCYVZzMEQ1REF3cUZsbE9L?=
 =?utf-8?B?ekk5Wnc4S0ZQN1puc0xZQUVZZ2dZdzZmVkNtZDVHKytUNXVtb0FtbVZPVTgy?=
 =?utf-8?B?SDYzaFRveENxM0xkM1c4dmk2SXc0d0hHWTlySE55UkxDcElrWnBzeGR3S1Rx?=
 =?utf-8?B?bURkOENnSUZrRWc2cGRzVEpoNjdQSkZZNEtPRVIxa0lLTkpsbXcxWDlLVHRy?=
 =?utf-8?B?aTBhVEF6S2c5YVNKcnJuQ3U1Vm9ENVR1bnBRblZCVEhFcTBLcmpOTkVFOEVZ?=
 =?utf-8?B?Vi9SWkp1V01aMEQwazREQms3QTlBdVZkbjhTWHU0dFU1QjBaQ0RTalVUT2FL?=
 =?utf-8?B?Q1lzSThIQ2tncCtmZUlGNFFDcUtuaHRNZUN3eVl4d00zbWNJL3NCNmNCK3RQ?=
 =?utf-8?B?engzL3hxTkVQcWJSTnplRFFTVDc4YTB1cW82UGdqWXhZbjR4emJmeE1GWmgx?=
 =?utf-8?B?TjdNT2NWYmNueDltNC8zRG92Mzkxd1c5ZWU0V2RQMGFJNGJ0bXFKR3JpQURW?=
 =?utf-8?B?K2thdWFoTlVxbDA5T1NjaHFrcXN0N1A4b1ZBZzVvUXBUSlg1R0tiWFZGY0RH?=
 =?utf-8?B?bWsxcUZTWW91b0s5aHJVaEJLZU5XTnYrdklPT0lqdFF2aFYzZmplVFBpL3lR?=
 =?utf-8?B?a1dPMVllQllNeG5ENTMrYk9TZE9vWjJiSXI0TWNnZXd6RnhZWjZzciszQmFK?=
 =?utf-8?B?M0cwWG93YmNIUGlBMnRSK0NPbFQrZ1RZaHJlSkhoUzJXNTBUTG5GSG03NkNj?=
 =?utf-8?B?dkpTd1BjWFdQekNKajlaL1JXVndWejFGK0ZXOEI3MldaQXBxNVJlUlBnMGxp?=
 =?utf-8?B?c1ZiSHZWazEwZUFaRUUxcWR4ajhKZ0NKeW9uL1Uvd2NVVk1FRlV3UktITkJS?=
 =?utf-8?B?dm5vK3licEdqTGlrVWx2a0pYQ1VkN09lSU0wL0Q5SXFuTDY4Rm9xL3dEWUJt?=
 =?utf-8?B?SEU2SHYwNWRhR3hjV3Z0Sm45bnk0dHgzUXJoVU5FcXdYTVB2Tmx6Z3E1YXlF?=
 =?utf-8?B?ZEFmRm9aajk4K05WaklsTm9SWmFYM1dpM0VhVGNBQ0Evc2VjbTZQK3p6L0NW?=
 =?utf-8?B?cFJVcS9ORXhYMmtodElxZ21sUFZ2REhIZjZ2SDZjcUNrSGZod0FveHYrUXMr?=
 =?utf-8?B?QS9hUlZWVDJVcmVmV3JDUFpoYnNLMmlCNGI5dm5Tbkh3bmNFQVljQWphWG94?=
 =?utf-8?B?b3N2a1NMZHkxZkkvSFhSbmUreDNkRnBKRzQwVktvVWFjWEZoU0dFRGU0QUFk?=
 =?utf-8?B?OXpGWXhyMjFIQ0dJeUpQampld2hNMDNrQUN1ZjcwdlREOXpFazR2c05vT2Jw?=
 =?utf-8?B?S011ZmNyM2NFRnoybFVON3pvcVhtTXVyUmVvMUFUazlYaUs2c3lUQkNwc3ho?=
 =?utf-8?B?N3lpQWJBcTJKZExESDBQUVNLdTE4Tmcra0Y4bUsxYzlNOG9qN3J6T0FYWlVu?=
 =?utf-8?B?bS96N1JhOGM1RnIvNmtCWEtBZlEzSmh4M3gvNG5Na3ZDOTArem9keHJTOWdB?=
 =?utf-8?B?VmxKNGxTK1k4YzQwbXlia0hRMktITU9zeFVSakpXb1FNdW50dmpkdWF0alU3?=
 =?utf-8?B?U1k4ODMrZk91RHExZnhKUUdTamdTVnNjc2JUbm1jSEJnWUpUcitzbDZwNkcv?=
 =?utf-8?B?eDJiOGdOVmtLdERzQjJnKzRmOVpTK1luL1F4NzYxMGFjdkRMYWtJbHRHQUhz?=
 =?utf-8?B?L0VEU3RzY2w0bkZndHhRb3ZWend4SmNHMVhiSTFBRGFJcU14d3U0ZW9HcjR5?=
 =?utf-8?B?YkZISmN6bGFFWGJaK2VqclZZbGt0RW92YmZnL1h0OS9HVktGNEJ5dzkwZmpo?=
 =?utf-8?B?NzA3ZnczNm4wbjRtL2pqYjRiK2dDV0Vxb3UzOHErNUVIaFJrbWxHSkZQdnZX?=
 =?utf-8?B?Uy9kTjJtcDdLc3VvUm1kVTV6WUJRaEIxU0NzVEpxYXhxOXpDUVdxNVJSUE9i?=
 =?utf-8?B?NnZPSXM4Zi9vajdCbGVpUDkxT0VnZmpjOW9maXFsaFk4NkFxZzliTGVldXdO?=
 =?utf-8?B?b1JpRGxrSCtUMXRsSytYazh0WjdsUFJYOE9WbGNSZy9wV0RNa0dnSGloOWNY?=
 =?utf-8?B?UktoSnkyR0ViaGFtR0hYUXY1UElDK2FMcHF0TWxBaTNjL2V3QVRZSFMrcHNX?=
 =?utf-8?Q?7ihPavzuGCh2BLIqAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9c48d5-ff06-4926-c6d4-08df398308b7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 08:18:26.1000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVPUND940ovrVOkO9+EBH8HzHYAFX/nUyOF4BNWhADDDULsxeN0E+EfFCsgCgCG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 08:27, Krzysztof Kozlowski wrote:
> 
> On Tue, 03 Nov 2026 06:44:57 +0000, Wentao Liang wrote:
>> The merge order test creates an array and a chain as inputs to
>> dma_fence_unwrap_merge(). The merge takes references to the underlying
>> fences but does not consume the input containers. The success path only
>> puts the merged result, leaking both the input array and the outer chain,
>> which owns the inner chain.
>>
>> Put the outer chain after checking the merged result and fall through to
>> the existing array cleanup on success as well as failure.
>>
>> The dma-buf-fence-unwrap KUnit suite passes all 11 tests under UML.
>>

>> Fixes: b1cce631e61f ("dma-buf: add selftest for fence order after merge")
>> Cc: stable@vger.kernel.org

Completely agree to what Krzysztof wrote below, but additionally a <256 byte memory leak in a non-production unit test is not something I would consider relevant for backporting.

Unless Greg or Sasha have different opinions please don't automatically send everything with CC stable@vger.kernel.org.

Regards,
Christian.

>> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>  drivers/dma-buf/st-dma-fence-unwrap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> 
> 
> Multiple things here:
> 1. Your team ignored completely previous feedback. Multiple times.
> 
> 2. You use multiple identities with this email, thus I doubt
>    that we speak with an actual person.
> 
> 3. Your bot does not even bother running checkpatch, right?
> 
> 4. Nothing of this was reproduced nor tested.
> 
> 5. Finally, the same feedback:
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
> 
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
> 
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.
> 
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem (so a patchset grouping multiple patches with a short cover
> letter), how to document usage of LLM and what you should not do
> if this was posted in a good faith.
> 
> Best regards,
> Krzysztof
> 
> 
> 
> 

