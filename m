Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0020FCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9F010E890;
	Mon, 19 Oct 2026 08:35:42 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D40B10E890;
 Mon, 19 Oct 2026 08:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ276DLqutFSc94TTlp+eetCnsg0dXHB5f7wsoizuiRxL6rwIgrWSJofgV78bHBN5esfnvmo287UDyQU/EhqJfq1Rrs5LWhSen6GX16pk/KKIJgPgVGqvmv8O5r6Nh0nKiJm+oszn3OJsdbxDGQ6npjytQpzBT5qrs66pq/FYmaLYljMTWYWE/HCEGcwy332unDpLOdlvCHqHlfCemEG/woyxBo8dP3Zk0gvt1quBDMc0Fw8JIM4Ti1K8ocOljCw/IwAW0MlCnUq2sXoKpPMN3Q/irGPug0rAHTH0VfyLYVSTefzCDOhx9BeYcoTcDy79uegyIT20FYyHq0Bg5K2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvYeLvvThNkTrVYlZn/edMs2YeARUsHCbWHZ1EaDRc8=;
 b=hI3F+C6A7AAGek5EdPW+XzLz6kioz3FFPWpVLqVdmwhsJ3+J1WUbbl0PYqInT0ghA2+r/DzX9iY949YvuecLDHAms/tW3a2DnEGnnGuq7UJuEE4JZa8EAYDNYjRvw1HLz1BxyQipueo5w2mUV3G+gRiou78ct8QvZRpNoKU+IMUquhq3rcrvp5J5OSPlbk1gWyfQun1FSxV19GFmhjB7hqp6Lu6N08g6p+19AoMStIRjRNn1fHBs2I+E2/cpokeLxTBhowwbV2Uta62FMbXBypu2irt7vcc5BjFZ3SLgQAAnwJf1v8DjHPW5ATGDvgEXVuVVDcJhUTILR1QViWdQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvYeLvvThNkTrVYlZn/edMs2YeARUsHCbWHZ1EaDRc8=;
 b=K0WCYA5M52ITmuzJdedeI1Egg3U4fvibTGzd8WD6mVF7KEANRy8ft1DjJyaERZCltBTe7ZlY6myHteexFjgLCAie/EoOqwo6JrO5YbuHWcs5MQXmW7gOxdTOoy7h+64aAeT/AgP0ZFXo558xEjGxlhHt5cOyIjCdgbe+t8FYaCk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 08:35:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:35:27 +0000
Message-ID: <d08a26ed-ded7-4447-bf7b-88597ee7df0e@amd.com>
Date: Mon, 19 Oct 2026 10:35:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/26] dma-buf: Add dma_buf_mapping_attach()
To: Karl Mehltretter <kmehltretter@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, Dongwon Kim
 <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Leon Romanovsky <leonro@nvidia.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <3-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <20261016202653.97339-1-kmehltretter@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261016202653.97339-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd02e52-3976-42a1-6967-08df2dbbed32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: AF28d2DQF31WjdsbsN35R7VOyv4lywinfuKy1LkxopKK3wCJ5GHN/+QqHRB0KfsEUtt9Bd6i2JCCNcPsB5yjv3LRs0FN3PwxPXssJU2zFUQdLzjNRfMr0jXaqkU01fWHn7DU3NNL7OiZyYCieMZWrR5B3TsAsq/ALmP9jnfSWVE7nlHGlCABssXPb31s59osAlKph9/twRu17Q81GPG8r5Yy+um9n7r7wlR8ocaZaEquJzS+BplqqxN+h99nWgOs00NQpMYB4tKIksCcS7ehIvJXX31k5aeyATKYBwMadH7Gvum8pJYHJ7OgJcs3HZF9LdVPKcWkXEFx03q/xaTeEl+Otd6MjOSMXR8h/9Ooy5f1eSP21l472epVwNGDPddGkit+f7eJkEhX10GUpRnxJ35P59pPzRTGb+Ni2CkQLFJ4IiEv2BJWNKg1wvFH7j3KmQv452QSk5OKMZhf2OtcfNO26Bae/c5OGFL7hMH42BzCFrsHtcXUHje1lsltc6H/J69yeyoJCLkxljNsT+71ZV7aikrle/jZ5MmS1C1jkqM57xGa+fQwOSieJne5CZYrogrOCQjf2PLl97o8ueXdYG6YDsPIl8N0EGXCgtGeii41elijGbRGxKYryMmCK6yuxJhtDPtukiiv+Eox/VStx/bP/Rdvcd4vcA6a7fIITKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBuQ3Y1VTF2YnhxVUVLZSt6amZTOXdDS0NGeWoxd0Q1OUNWNXdEcDM0clVE?=
 =?utf-8?B?djZLa2R3ZFJiTCtKK2ZRRVpWNVdXcW1aTnY1MmdUWnRReUl6Wmp0K01QME1K?=
 =?utf-8?B?Skp6OFdna25NQ1pTTml1MFNrbnRsQTgrVVZad0R5aDByYWUyRzdFSlFpSlBT?=
 =?utf-8?B?L0lXczJIaWN0U2R1T2hxcGdROTBranVuaktpckN0WlhYWjgvSnpyU0wxNTdD?=
 =?utf-8?B?aUNIcERsc1lwK21jTi9Lem9XSzhqbms3bW1jeUUyWjZ1TVk2Ukloblk5ZExP?=
 =?utf-8?B?Ui9Ndi9Gd25zUW5MTTdGdTVtTE5XQ0hvOTgvOHptakVEY1Fsb29VajFUZEt3?=
 =?utf-8?B?eTZSV0tMcmYrdHhLcGQxKzk3RzF1VUVQL1BSbU1rdGhxVDNtc2hPc0M3dmxt?=
 =?utf-8?B?eWhKRDlXZGxRRERkeHFMbWd3N2xZYVhMbll2SXlaR0xwOEFlaktxZDd6bVRN?=
 =?utf-8?B?VHljcjdCT0h6Q1h1NXZ3ZXdOZWVOdEFFK3I0cFNVTHNBTUlVRmxjR0FWMFgx?=
 =?utf-8?B?emsxWTU4RThyM29DUFUwRDZXSVgrT3VpSmR5T3pTK0U4MkZQeWJObUQwc2xz?=
 =?utf-8?B?aVgwdFJOTnpMUXZpekVteXQ0K0pldlZ3TnAwa2NGS1VBcGlxVnBaVWJGVWk2?=
 =?utf-8?B?azV6Ym5OSnNDN29pQlEycmVDRkl0VTFyVzBOTEk4ek9OVDBtUkJOcW4rMkp3?=
 =?utf-8?B?bmxhYWw2OStjZFhxL0tkLzVkb3JPRGEzVnpWWnhTaXdFT21HZS9pRTErWUNy?=
 =?utf-8?B?Q2o0UHdURFdtRG4ySHFBSHZGam4rZVdMZFhhYkhBQzM0WmJtNU5uTW5tRjVF?=
 =?utf-8?B?OHhReHFHNk5zSFF4enNibHZLejI2bVgwdXNxZmtuanp1ZXEwQkxVNGFHL2lJ?=
 =?utf-8?B?OEd0SUpHcjNRK3Fac01tWWI5NnM4UUFDdFh6V0srQndaN1hGUzQ2dHBMMEF3?=
 =?utf-8?B?Qzc4RnduN3Jtc1VBVFlMNm1YbStJS3VmU3VXdnhtbzBnM1RBQ29JT0FYZmh2?=
 =?utf-8?B?NTEwMm8wZElQTmRVaGJ4UGVLSzRERnFBalhJUk9OSEZqbW82bnRDTTdGMzNQ?=
 =?utf-8?B?dS9abWJ6YjlhRWFxSTZpZVQ5Y2N5amhQam5KWVc0dkJ1RGEzbWExaUg1QmJT?=
 =?utf-8?B?ekNmOFp1Rkpvb29tTGJPZVBVNUR1akFTRlVlaTNTZEdwTEw0R2hkcU13cE9r?=
 =?utf-8?B?VkRtWmF6djdMenVNQXBsdnk0L2pPVGpJQWhDTGppVnYwTUZBajIyMGtQaG1O?=
 =?utf-8?B?Rk0rQ0NNZ2FqWERzTSthNXgwZXB1amhIK1dtdjBkVGdXK3RqN1U4cGRhU3hw?=
 =?utf-8?B?aHg1OGVUdzZ6L1F2dU9vQkRBSkVoYkdBaWt6MVI1cEpLY3pIdTJ3Y1B2aG9j?=
 =?utf-8?B?US9CYW5SWmlieEkzL1NySFBVQ2JzWmFWMEFqckRRYVVvMDlNZkI1T2xVVnVs?=
 =?utf-8?B?b1lhOWIyQUR1SitBZ2k1Zjh4OFdBbUFsRno0bThHTVZIWUVISk5ROEdMMXQ0?=
 =?utf-8?B?dTBPSVV0OFFKdlhRTzFQM3h2S1hQVENHam1UVGRPZ0JCSXBQTWtqUjI3V0p2?=
 =?utf-8?B?c1ZOWCtSMitiYjRnZk1UUXR6SG1aNjQ2YjEvWGZoVy9XL3FvWGpsU0E4Qlg2?=
 =?utf-8?B?K0RLNVJaeC9JUnFib0xKK3YzalM4N05jMUZxZjhveG5rR3FrN2JRbGRlSXRs?=
 =?utf-8?B?enJHcThYc3VXMjFpTUJrY1g2ejFjVWpKN0pDaDBkZ0FyVzBqNGkvMGlqTExB?=
 =?utf-8?B?ZkFRaUdkdHl3L21pR0I0akg4UGZxdFRxWWZ3dENGL3AxWFZCRUx6c241b044?=
 =?utf-8?B?Q0IvejU4WEhISCtyNlA1cGVZeHlzazVIQ25ZYU1ZcDRnVStBQVNpa1VPS2ZP?=
 =?utf-8?B?aFhmNDQ0SmNmai95QTJPU1ZOMWZxbWlMSFRBa0NCaUNhSEh3RG1qU1JnWXVL?=
 =?utf-8?B?RHBEbS9FYlp0bGtTRUladS8zQlVDZFZLZGpMMHMxQVFwZlh1TEtmbU51Q3lh?=
 =?utf-8?B?NHpQTHl0NGlMczFneDhCVHVyQ2VjaTg5Qm82N2trWXpVUSt0S3Ara0xDS1Ux?=
 =?utf-8?B?Nks0dGRWejd3SzlhN1gwbjk4TU5EUEZoS0dRUEw1YlNQa1JmdW5GQ3dWb0NV?=
 =?utf-8?B?Zm0vUnAxeHREd204Zm5XOUhHVHFiOEIxMkYyL21XUE5JOFN4cTkyZDk5aTQx?=
 =?utf-8?B?QXg1ZXZPSnRoZzRaR2dzQ3ZtRFZmNThxUHlQVnpDN05RMHhLb1JRdU5DdGVZ?=
 =?utf-8?B?aTB0dFlLYWFCOUtGbyt1MlBQN09xaHpOSU9ieHJrRGZIRXZsTHdJZThNRXVF?=
 =?utf-8?Q?fo71wjf7WLk0DuT9FK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd02e52-3976-42a1-6967-08df2dbbed32
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:35:27.3569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XeSSBXd10eIzM8UfDY7YaJE4R6yiYzkeftH8hy3fhSEtsybaD8/bQUzxT1uAHM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

On 10/16/26 22:26, Karl Mehltretter wrote:
> On Tue, Feb 17, 2026 at 08:11:34PM -0400, Jason Gunthorpe wrote:
>> +	match_args.attach = attach;
>> +	if (dmabuf->ops->match_mapping) {
>> +		ret = dmabuf->ops->match_mapping(&match_args);
>> +	}
>> +
>>  	attach->dmabuf = dmabuf;
>>  	attach->importer_ops = importer_ops;
>>  	attach->importer_priv = importer_priv;
> 
> I may misunderstand the intended contract. match_mapping() runs while the
> attachment is still zeroed and without dmabuf->resv held.
> 
> Patch 11's amdgpu callback needs importer_ops and importer_priv, so its XGMI
> match cannot work here. Patch 12's VFIO callback asserts dmabuf->resv and
> reads priv->vdev, which cleanup changes under that lock.
> 
> Should the core initialize the attachment and hold dmabuf->resv for
> match_mapping(), or should callbacks avoid attachment and lock-protected
> state?

Right. This completely misplaced.

The matching can't be done at attachment time, but rather needs to be done before creating a mapping while holding the resv lock so that the matching decision can't change.

Regards,
Christian.

> 
> Thanks,
> Karl

