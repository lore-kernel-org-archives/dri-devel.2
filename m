Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7F606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E9HIziqF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1B810EEC1;
	Tue, 10 Nov 2026 09:00:10 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0693410EEB3;
 Tue, 10 Nov 2026 09:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMmf2+wuA6L1l8PubsT+XBKX1qjr8/qOszOj2r4dBghUXyEEM2Weobp4X7HC8Q6eYlwcklHHaUfy8z1cxjoHnDAWo1htlpCq1jDoyDlX++4g/gvTj3LDmky4YIV8ZTLJurXasNIkIbsh+2C9NZygTbwB6F2HZ4bld5GS/taKudQ3Sc+VbhNSA2YLUOHQ5OPRTR9zzRmz3zZnVbQ5UQxEIlrGrPGkjOxLocbdvLXL6yDbrPV4PBK6Zf76sB1YD3CGa9FjMjvNVgIOrwTeUuODU284skWTl33wyYhEAIAQOoXdfPTJL5c7+Zf4YGvSZPzOKlz8aNwMoOLznZ4HnnX1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EL8IrPGX97k1F29/7ODcpD1gK8EHCV9Sdq/2nEG3bs=;
 b=xtMm1Zus0IdukTQXt9vWurOY3NMc1RZevnVlzzFdSxopCflr43EMS9bPzujQXdOZONnwAcWhMa273nMv+r7fLGUrFSt0SWPc3ZH4PpwiVKrPr6JoFJvtd0+mLEOKt2oE3wTD64dNRcvRkD3CINt/mWuRHYKUL8w6xKENHJ5CG21CobtKzmSxUl/eppr+Agq7xnRswEfr77AMmZs+B7JV7fkdtAYjxTIEd6EKI2kmePtToCAc5cfgYWaDhP87lxcXcA3uDMWW0zmqk6LAH3+oWJ42KNik7syud2wjK54QLkymaDZ0DnMQUqrRmayRDk4aMXvMONdazZALYa3k5UFEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EL8IrPGX97k1F29/7ODcpD1gK8EHCV9Sdq/2nEG3bs=;
 b=E9HIziqFJqvWR4UzVIL2jUYvPMphwzmZPeEr6zMC+54njFj6JGaU92f39+n9nL8R1Lbd3J3SOU3u7m2kx8CwN9htUKrU10xABhR9uwSNm7GBO8sIYfBQbVebrtn9ajOFWQdtLCIbHSKGrnnk/mJsHAJ+DZOqZPkVbGGrwJfw8kk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18)
 by IA0PPF4D923B935.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bcd) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Tue, 10 Nov
 2026 08:59:58 +0000
Received: from CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f]) by CY8PR12MB7170.namprd12.prod.outlook.com
 ([fe80::7565:bdd3:383a:de5f%3]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:59:58 +0000
Message-ID: <9f0f7b8f-e837-4b3d-9e5c-c1366a00e734@amd.com>
Date: Tue, 10 Nov 2026 16:59:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/22] drm/amdgpu: add SVM ioctl entry and fault
 handler module
To: Aveline Noir <jm5905938@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alice Ryhl <aliceryhl@google.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 Felix Kuehling <felix.kuehling@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Jenny Liu <Jenny-Jing.Liu@amd.com>,
 Junhua Shen <Junhua.Shen@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Yiru Ma <yiru.ma@amd.com>,
 Huang Rui <ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
 <20261021025915.2433837-12-ray.huang@amd.com>
 <179424283809.193292.9522281129166256376.b4-reply@b4>
Content-Language: en-US
From: "Huang, Honglei" <honghuan@amd.com>
In-Reply-To: <179424283809.193292.9522281129166256376.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To CY8PR12MB7170.namprd12.prod.outlook.com
 (2603:10b6:930:5a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7170:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 995d9bca-ac4a-4555-151b-08df3f08fec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|5023799004|4143699003|56012099006|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NVhW2n56D/q4V9eRa6AfMQUcFnJt/7EWzyyvg0p7AEs5cKSu+qx5uWlDVwiVBJ9NIciDff0MhCNeYD0Z7qn4OoLDqh41RuK1bFCClywmce6LyqqWKx0+UF0RLQmJS9uaIarmeaEXyo/kXb+KhNihzA0BuOlh160kPZGYOGECMH13stCOJncwPQJT5VKGNJTFfJPvwr/BrkXzz+HZvHbcuoplIMYPtj5s23vtNcmTgBCpl0bSi06s9cGopC3ihGUVAVvU1EOHq+d6vQPgvdenmFxK2e99sdLQ2LQdIAKv/qOf9Bu1P2c/CGDkxpgz1bMtN2OTU0DM4So2UKejofWcQb3bVHvxNLreygHqz46rHdksvQWQ+VqAkW+33YdMsIgT6Ml6Wdo1MVCrrPLVVbU/E51nvhhzbdi6uE/7YSIM/MJBXmbjhZHBuv3pGtBJZyNSosTXBV5KN6dmtQ6ZXkj2RCWZ89c49UEWJWWvgKrDWkztNpD9X6ZGt4vR6NxOa95+CQQQjWDyUXaa7kCxQRQg00qcT5A8dnBnaCFy6H95ZSzKfQXjqpMjo+yyMaf+S85v+tFSfMn2jOH+B9/apBElqROSn2uZU3in3VsheZC+bGj2ntgAt/7W1vzWYRSJdXrzygUev3jskdd4vBBGpwMUY/zf9X42JGoorrmwsENqbOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(5023799004)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdYakZvcEp2a0g5NzM0SG95T3A1TnRKV1pYY1lwNGNmYTYzcy9LcHppK0ZL?=
 =?utf-8?B?SW1DT1YyWFpaTDlZODBsUWJ5cHlid0p3SFp3ZTZUNDJUemhMNHhnbm92RFpU?=
 =?utf-8?B?V20vc2IyYVh1UnlYeXVNSVlYbVJaMStDTHF3Sjk1d25WWFpPZUhjZmw2WFpn?=
 =?utf-8?B?NUlCM0Y3dW93TmswWUJ2eUxrWStnVEZWaThUSm04ejRJRFJWWWs3S3JidEh6?=
 =?utf-8?B?TXhLWW44UlpjQ2docTEyeThFWjFUOUoraXlDb1pNNk1HQktrQzFwN1c4N2dF?=
 =?utf-8?B?QTFZakFQRTJPdHJrdnYyTk9MTEdhRVFJY1BwOStvYlNaVjFJWWdXV0VBVGxV?=
 =?utf-8?B?bW9nMVJ0Z3B0ZndIRnFydnF0ekZKOUxNYk9BREZ0eDIwSVZLdnlKcUVWd1Iv?=
 =?utf-8?B?emx1SVFrMkZYb05SVzZuVE5VVTY5VXlVQ3pneFhOdzl1OWRmdVRGMmY5cFFm?=
 =?utf-8?B?bGx6a1JvUUh1TjEyMGNyRXZzSzNhclZ2a1V4bXIwZDZlTVUwS3BFNElSY0xq?=
 =?utf-8?B?WXpkS3JKQkxFeDgxVmxnaHNYbWRZbG5QZjBtd0I2NlIzYnZpbHB3R25mVzFV?=
 =?utf-8?B?SHRNNlBKekpVVlNXZit5dkRxcWp4eUtTTVkrcUVZMzZ3SitXdHY1YTA2dEM3?=
 =?utf-8?B?V0VBUHJOZWx6aVJJb2tOL3h5MHo5bXc5WldYREN0bnVtNGY2QXh1ZzdoVEYy?=
 =?utf-8?B?TlZjQ0pmQWxuVy95UlozendYZlBDYndweGhiL1dsQy9OT3oxbFF3ZkRqNGtY?=
 =?utf-8?B?V0F1bTV2alpUZmRiSTM2ZjdtTW5tMHZhbS9jL3VwZmF6VEkyYk5UNmlFelJZ?=
 =?utf-8?B?ZGJhYm9peHg3alRSUmtzamYvaE1MODRUTVQ2R002UG9ieGZVa1pOeG11OTlk?=
 =?utf-8?B?V2E1R0d6SVhZcjJhOGwvUmhJRFZvejdPRWVjTDZVb2dzS3RyMHllWE0xcFZ5?=
 =?utf-8?B?ajVGdmJHTkYxemlsWkNFQ2xpVTh2SGRmZnVIOEdyMHl4RFN6K2szbTRvZzdo?=
 =?utf-8?B?eE5kY0M5N1RMdmgyY1lqNkl2SEVBVGlOcUd1QWl5M0kyOTc5NURNZjloZ1N5?=
 =?utf-8?B?SlRCMkRuamh4VGQxL3djbi9yUm9peUxycDFIMzNKN05PQTNHLzR5MXl5NDFu?=
 =?utf-8?B?NlhVcUp3WUFha0MvN00yQUloWlNBay9UZVBKRE9QMW1vdkljZlFCZ2htNkgx?=
 =?utf-8?B?MVduY1lSR0hYTFdadHNlYkRqR1lSaVdEb1UwNTF2SnJaY2dHdkNTQklrRlFJ?=
 =?utf-8?B?SSt6UmFTc09MZjF4RC8rNWlua3QrbVUwNjdBZCsyeGcvVUx6bzFzVWRadGNp?=
 =?utf-8?B?TW5ZeWd5TTErM0lYQmk4Vyt5SFlMVURCZlVoM3B5VGRWVS85dldlMHBsQjU5?=
 =?utf-8?B?VE51RGZFQjBmWTJIYXBiYVFUWnEra3JhVDZwTmpWWGZsV2VXdUtXWWhYbThP?=
 =?utf-8?B?emZxSkNlOTRDcE04WHp5eThCZ0dsL2pGM0NES2podUtEQmh3Zi9EeEt4dTFs?=
 =?utf-8?B?dW52THQ4WFA2djh2QVhucVNscnRJOVBaYVhaOGl4aklJUnhiVHRKR0N5Zkk4?=
 =?utf-8?B?QXg0cEdyUWdQNDY1eldNMEJwNTV3YlJDMnVQbXFJN0drblZNSU1LZExtNEZ3?=
 =?utf-8?B?Y29FdW9jbG1JcmwwM05wVGdvdGZVcmJVR0tlenQ1TktBY1FzeEVxeHV3MGJC?=
 =?utf-8?B?bnJGclB2UW9IRHIwemRNUFpSbWtJRzdlNmw5RlpFa3hQVWRET2ZwdlJpN2lQ?=
 =?utf-8?B?a2UycW1mRjIzMUgrTXR5QlJYUm5EMFpZQjl5QXg0RVhUQkxiRUR2VU02QUty?=
 =?utf-8?B?THhMN09xdHdpdXZqbWxYV1JqVDh5TnRBQ3NLNXNGKysxVUpuZmh5Z0JhLzhZ?=
 =?utf-8?B?RXNJM3RJcSttNk8ycmpYeDkveGVxSzVTWHdEdjRaOS9Ta1dIalBOSnpmcDdy?=
 =?utf-8?B?K3lFL3BsL3Y3ZCttV3YrTENTYU1PLzA5UVZteWNBWU5HaFlkMjdJZFdMVUFQ?=
 =?utf-8?B?QXpuS0hoYlVmbTR2Wk1mcFhXbkRUc0RpS3ViWjZaUkExSVhyWmU0OFVQTk0v?=
 =?utf-8?B?aXRqaDhubk9iSm1lQTdDa29VQ2xvaXdjdnJrbnh6cW50UkhKMGVkdHQ2cExN?=
 =?utf-8?B?bzlEaXVjMDdJcUhDUTRtN2NVSkxpRmdlcW5tSFpkeDVTaXBHa29qaTVzcDgz?=
 =?utf-8?B?V3VTNko3VzNyU0hXb3lGZ3FHUGxUQmhpeTluSU1tU25YUXRUbTVRY0RnTjFj?=
 =?utf-8?B?d2ZaRlBLMkFJN2s0NFFWb0c4d2pESm9vejhEU0pyR3JQNmp1Sm5aQW1mWlhW?=
 =?utf-8?Q?dA52NTz673HkW4hlR5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995d9bca-ac4a-4555-151b-08df3f08fec8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:59:57.9786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxdQhrqb4An4mLY2YIhbSwxq8CvjH3OScbgEu/mdf2K6GnXG2afizPE/vHUg3A40smLeYhQftF6yuZ67ZWVl+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/2026 12:47 AM, Aveline Noir wrote:
> Hi Ray,
> 
> On Wed, 21 Oct 2026 10:58:50 +0800 Huang Rui wrote:
> 
>> +	ret = fault_check_allowed(svm, fault_addr, write_fault);
>> +	if (ret)
>> +		return ret;
> 
> This checks the VMA permissions but not attrs->access, so I think
> INACCESSIBLE isn't really enforced. SET_ATTR invalidates the existing
> GPU mapping, but the next retry fault just maps the range again.
> 
> IN_PLACE has a similar problem. With preferred_loc=LOCAL, the
> migration added by 22/22 can still move migratable system-memory pages
> into VRAM on a pagemap-capable GPU. Both seem to go against the access
> definitions in 01/22, and the prefetch path doesn't check access
> either.
> 
> Could the fault and prefetch paths check access before mapping or
> migrating?

Will add access check in fault_check_allowed, IN_PLACE access, prefetch 
access path.

Really thanks for the review!

Regards,
Honglei

> 
> Thanks,
> Aveline Noir

