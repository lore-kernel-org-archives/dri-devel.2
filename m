Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D87606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VIzqBc/k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7308B10EB6E;
	Tue, 17 Nov 2026 09:51:57 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A000A10EB6E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 09:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOWGi+SotPsVpJqssA+TG1RsRqYS6zFwX51Re+LU64p+EUMSGYJU/n31rHPdy2dJ17gIWpcezZ12cJG9h1L2ERdGqa5l3aLIxR/GegPDj/55zxW91DhbzZfHSBevs6oHp4HoVNQlvwze1Nhx4WTlZ3EEtkYwoA9s0PtfuL8lqMqf7wmCJFIveVPY5SAdNSqQURB+gs2SF905yuSgqzi8A8MW3cvSQbQHExILi50G3v0yruMIskK6kYFAK/J1qdgUrPamjfqTzJh6TeZdEBnf6mid9BEkamOmJ8lTKgn22ud73kwne0vrWO3rBkTm6dARp67ILOvbLPpURjkcLAIM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YatWmxCzLmAK7/g0QUUCrNjCZH5YtwoxdmfOVdakz00=;
 b=MJGZwwSKgr9Q2+wDeFIG2qAXBQmFqTc1y4vEkDWGSRS8ECeNurtzF4iHHfwl/jHv/tIw2alI+9bu1BVzg/+NijAU11CbmSe6TeAOg/iRNJ0Zg/og0YbKS6rHTEoSsdD8Ee56IptY4cA0BXhDaozNGl8fUNuLD9teOgB4p5ZEmRsb60fCZR+McghX22/0DpYFbF8DrWaeMKGZ3XUYnP6MnvpcGez3otq4sbaKSmZyJi67i/E4RUdVSqMF3OfIbpkvzz9HPg8NoJPVlJBqy34nNt0FMG7ZtXxHtSmOeT+pCfCt3+1xWvhu+VXBhtSJzIl5cR4OupSJZW0SirzjNodVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YatWmxCzLmAK7/g0QUUCrNjCZH5YtwoxdmfOVdakz00=;
 b=VIzqBc/kIYdqdf4/MasnxgE2kIbfNjjWiK/x59AcJxUIF7KQd+cegfU4VN2RXLz0q7vuREdfl1ZrWtRbgRbsLT8hEGKQvUTS5VMz70azBD5WYsFgd1tRpqYQcCRe04GwM0lm2+qJImgWvONnGzNG4q2G3/Hr+LmcZPwz5ghPdfM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 09:51:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 09:51:45 +0000
Message-ID: <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
Date: Tue, 17 Nov 2026 10:51:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0691.namprd03.prod.outlook.com
 (2603:10b6:408:ef::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b21791f-a8bb-4cad-0980-08df449063dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|921020|10067099003|56012099006|4143699003|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QgeW299KMZr0/nUiX/RQm9EGrReckxliuvC96K6/ndCf48iGSW154gAcZTrtPF003OXWqx2K/bEvJkctVccUhPztEaKRZWB7+sMUFBrWzfYGmHjkYG81G9Cvbh2xtlF5DS1hgBsApYRZiY0xJyFVrFv6WsrkolHr33DGejDzr0kogVUR0FkFCHmAmqe1MvhHsk51a1TMlk2+DfHm14mUgxRMN3xdxETb433/RftaTVjNKDKmM+X+eFLD4oiyexFTilx+GdZqdE+cc6Q+iFie40hyI5W/lVSEfRVDcNe+Tlh50zPN06F81VIAKhURJgXUpE1rzJ7bjqd7u+HaIzsJuf0xV7CSPln3WzNU8UwRCMAcc2oH5Z4qfAEt1E4og8TxqD4SHieEPxxpIiQLjiwJ9HqzL0YP4UtpUNN0oo9ynpCGza20O+Mw6qJ4AKJx7SSXPKJDXH6BuyvKhBcDzooUTU5Tm8m3jWz6DcIMhIoAufvt76ABeQ8QaKQE9iv/4XVyoFVYsg7HdzDU9UOwza+53RoVm6LrI0Um8OvHGBjCdoWCKdHABXcQLt7/C8gsA+RgApVZIq1Bj1J/ulJ5SicFxIQA9xajKMa1Fi4pZ1xftwgNUSffomvHBEF/nKYcENnaYN7Mg+FiUUBBE5HlLBMABUmNYQdWGHguasslzUN1MsZO3JnoBv6piz6oj+G4cwfrN62/vYVLQOIxqfYt4Xxy/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(921020)(10067099003)(56012099006)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3ppaDNXRWNzY2N0MXNDWUZPMTZxUjFTWk1vV3UvYmlzNFl6T0wvbjFHRW9h?=
 =?utf-8?B?SXF2QkdJV29PU0FkcFA5cmlqb3JOdkhzWHkwUEUyc21EcUdzbytaMUsyMnlq?=
 =?utf-8?B?Q1pWbmZjRlpWQ0V2UWozekhCOGNSRGtUMjVRcjlmTGdCOGtONnJleVNOZVhE?=
 =?utf-8?B?ZGNaYVgwdGNXNzBieEdBOVQ1VDhnUnlhZGVzQnBSWTlxNC8yb3REMUxyVXpz?=
 =?utf-8?B?bzhscC9LekY4N0RQbFR5RENCMVpZZnovS3NOVmFDRHkxYStpcEJVOHZ1eHJD?=
 =?utf-8?B?cm5MbTBaaVR6RlYvSHdoNnFGTEVvTkY0eTlQc3h3WHI5eTZvNEp0R0VlWmZM?=
 =?utf-8?B?N1pXUzViVEtqbkJ2TEcwTUhnMkxjTllybUdMdUdqOEY0TGluMzgrSUVrTktN?=
 =?utf-8?B?VURJc2dCNDVMSDlURlZES3psTmZEUit0MlloWkFwYUpyQ0ppODY2eWtuTldt?=
 =?utf-8?B?UnY5UE9nb2MvZ2JUTE1rQzVQVGo0SUdmNkZkQVlpck9vcTRTWjNBWVo1UzZi?=
 =?utf-8?B?QnJmOTY1NWtZUi9mZnJ2YnRUbGFQb1lsMkJJbHo3MHdGZzNaV3hJOUlhSWlG?=
 =?utf-8?B?Vm5HcXJnWFpRa2lIMXVtUE5Ibmh6Mnc3Tkp0SjRtNStnSDhtdjZwVzFDbTIx?=
 =?utf-8?B?YnV6b1V1RlQvZ2VXQStrdWV6alBHNWFkcGtxeEY0SjBrV1Erc084d1l2MGJ4?=
 =?utf-8?B?ZFlqRWFuMGJtUktGaHBqQ3kzY0NnWWRaelNHaTVVYjYwcjBWVUhXVkpxcDBi?=
 =?utf-8?B?YmJ1SlFwL0dHcGpWeHlOTWJ1dzlSTHYvdFQ0d1pEUVNmbkJuNUplUmdaNVVO?=
 =?utf-8?B?ejFBSE1yb1ZOT3VSYzFVMlhnTHZOVHA4SEJnQTM3WkcwNGJTRkRSWXNoQU5L?=
 =?utf-8?B?SHdSNlBpYWdDWU5uUnM1R2ZkK0ZTL1VzdUNMTndnMXNSNk1HUStBd29kR1hN?=
 =?utf-8?B?N1gzbi92UXJ3T2h5S3phSEp0bnpENVRYQ3I4ZVVjbm01bUM0ZWw4VU96WS9C?=
 =?utf-8?B?QklrNmJJV21rOUlUMXRxQmh0TW51UnRrdTU1NHRnQ2JaSWVlSE1xUEwxSkFT?=
 =?utf-8?B?TmJQT00remNiY3MxUThDVnpmRWVrSlYxQjY2NkpIakcyZjcrM1lLY0VFZE1E?=
 =?utf-8?B?KzFuMnNxYUQvSXBOS2NMc1dDR3NXbzVJYkQvMlg3bGw0bVcxS3FGRlZIazBC?=
 =?utf-8?B?NXVITEkreVRzd2lrQXU3aVg2VTJJWldFQmVZdnpHYVBRSkZhMWM3WjFSbHIw?=
 =?utf-8?B?NW0wb2htVTdxZTdMbjNSRUlNRUIrQnNzR1B1aHdPNjBQcm9kdUtnNXlNQS9X?=
 =?utf-8?B?MlB0cFFDeWpPQXdUSFFwNm9YeGJ1WlBwKzd0bXh3S1NteGR1RnZHOVlzM1Qx?=
 =?utf-8?B?MzZOWVovYTAzOHU5V1NEV09rRVZXamlLY1JiSlEzQkhjUURmUGZKVFNCWVo0?=
 =?utf-8?B?NUExV211K3d1OTNzK05nR0VwOW93T3FzVHVicWV6RUcwdEtVVXdQdW1yeEJY?=
 =?utf-8?B?cjNWVVowS3ZoM3dQRHEvWVBmbDZQZmxpMlJNNWZidUU5TU81Z3ZhaysrcGNC?=
 =?utf-8?B?S1JFZVR5WVBlU3hvQXNHc000WEdqU0RxQ0hhMVdhZnQ5QXY4cXBXaWp6OFVE?=
 =?utf-8?B?bGdKTGFLSjNOcHNEZnQvZDV6cVd5WkdqQk5TbC9zblVzSDlwbldVYjEwdml5?=
 =?utf-8?B?MDZzdVRaUC91RU1rUGZwZ1NMWGV3clNXSWkya3VKRG5HdXltdnRaWGtTblFz?=
 =?utf-8?B?V204Z2Q4ZVIxc3hZRng5Z0kzLzdRaTd6QVFWb25MSjlpQlJ5OU9DcEhaWTV6?=
 =?utf-8?B?Nmt0SUJpeVZaNmRrWGRUODlKbEgrempIbFNZbjlmMWNwWFlsQ3lGNDBSaGJm?=
 =?utf-8?B?ZHBPcm1OUjg5QnZPUUFGZU9qYnFmOGpHWlN4QjJKaXZ4eXNnaXJlSXRvQ1l2?=
 =?utf-8?B?ZkVPZ3FSTWVob0FrcFBtQ1huYVJXTW9ybXRMVzVxR1ZscmVxZjgxQzRzM1M4?=
 =?utf-8?B?ZGF1ZjZmUE93K3hOVksxZEYrM3RFd2FNV0RHeXIyM09jTXdiY202Wi9IcWpL?=
 =?utf-8?B?QUN1TnRTWFZGaG5vc09EbzY2S3RodXJpTDkyM2JlMmlXekJZeUczR0hsSm54?=
 =?utf-8?B?WURCZHJkekl5TkRIK1NNMDd4UlpGTzRZbVZEK1VwVXVTZ0F1TEFvREM5SVNl?=
 =?utf-8?B?RXFGS2VyTlUzR0VNNTF4NmZ2SGlJc3I4OFRFMFkrOFd2cnZTaThYb3lWWWFZ?=
 =?utf-8?B?dnJqVGNvQ2RWR0I4ekZTOHpicDA3a2pOSmRCeG83TVJOdkc4VklPV0NPK0Z1?=
 =?utf-8?Q?2MtPbhZH59QLWaJ5ZF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b21791f-a8bb-4cad-0980-08df449063dc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:51:45.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEht/ckkP8ppmzv3t7+s2NWAe4mb7Jan7+Byb4DUEEnIXJAwQdKPF/uFR0JuO+0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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

On 11/17/26 09:24, Philipp Stanner wrote:
> On Thu, 2026-11-12 at 11:29 +0100, Christian König wrote:
>> On 11/12/26 11:10, Philipp Stanner wrote:
>>> DriverFence::drop() contains a pr_warn!() for when the fence drops
>>> unsignaled. This warning gets into the way of canonical teardown in
>>> Rust: when you drop a lock, it unlocks itself, when you drop a KBox, it
>>> frees itself etc. Congruently, users should be able to tear down fences
>>> they don't care about anymore with ECANCELED, which is already the
>>> default error code.
>>
>> Well a dma_fence should never automatically signal when the last
>> reference drops.
>>
>> Leaving it unsignaled is the most defensive path we can go. That can
>> lead to deadlocks but it can at least not lead to memory corruption.
> 
> True, you choose between the Unholy Trinity of DRM: deadlocks, UAF and
> memory corruption :]
> 
> In this particular case, however, Rust does not allow for preventing
> the user from signaling "forgotten" fences anyways, no matter how we
> write the fence core:
> 
> struct DriverFoo {
> 	f: DriverFence<()>,
> }
> 
> impl Drop for Driver Foo {
> 	pub fn drop(&mut self) {
> 		// Signals fence implicitly & automatically.
> 		self.f.signal(ECANCELED);
> 	}
> }

Yeah, exactly that is still a bad idea :) See the HW eventually doesn't necessarily stop doing DMA if you unload the driver.

I even know about one case where a driver fully intentionally leaks memory on unload because the devs couldn't figure out which FW keeps writing into a buffer.

This was suggested as problem solving approach for AMDGPU as well, but we have been able to avoid it by clearing the DMA master flag in the PCI config dword.


The fundamental problem here is that a software object running out of scope is not an indicator that the HW stops doing something.

So just signaling all fences with ECANCELED is not enough. When the driver runs out of scope without all fences being signaling we seriously need at least some kind of warning in the system log, potentially even better call BUG() or maybe even panic().

Cheers,
Christian.

> 
> 
> So we decided to die this death because this way we get rid of the two
> of the three problems that *can* be solved in the API.
> 
> 
> But it will please you to hear that all users of drm::JobQueue do not
> have access to fences directly anyways, they can only signal them
> through JobQueue. Thus, they can also not forget them (signaled or
> unsignaled), because they would have to forget / leak the entire
> JobQueue as a whole, so effectively forgetting also their GPU ring. If
> that would happen, the driver would be broken beyond repair anyways.
> 
> Regards
> P.

