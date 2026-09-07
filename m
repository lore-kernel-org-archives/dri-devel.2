Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F09C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1775210E4DA;
	Mon,  7 Sep 2026 13:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywrcvw9A";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A896010E4DA
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBTNoGuNBBRRYKR8HHQ0XLcwK40EmcbC55qF6a+97r47p/mwCCm/s/DPvnz1Jfe1UpeT5QYuE8gAuK3DJ9YQOY+VblQ81x1ze6sRYyuxJ/AzpTVIopem27B8wQwhz9QVuMv+u6BrO0Y8YXlCoRupU1i6e0bF4R4RJU7YgrKxzQxkbMGN9f8ozD/od3AOXGqKYlxUrhgPVD4om6zckvtgR2pm/XZw5hWr4dh2Am4n5TJ5zIOQDcYu7fiBUtb1SyR6Tao25sVJTZEZusJu2ckyX5G9CNO7pbEXYh5Krd9kZhluht3N4W8dwe5RzlZPwj0u//oOhyVJJ4omz7qMPf7knA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnovx7YMejF0hMnUnFvJQGSugmklUXC5W0e4B4GSRsg=;
 b=PhB0dHgjPSLUlxYpqU8Iz+IqNwABr3kTrl+yIrK7J8DfXPO+4L+FC0yR6jQBk/3jQKn5MwLol/CdiQTjk82NCVku0ctswGWBQdaFVl8OZpcx2pHwY2G2J9T+GZs4FF/9yfb7+BFtVratGLSArRLyTsb5UmPz1pjdsbjujxrIC5xgriao+weG7JsCeWctv28suXFEksiCJ6lVnfXP6GsEuOj1hvoU3EG3/47KYQmlj6fkUYOoU1ODQzizZx4ML33tmzA6wteyIJdFq4gIFqGMbxFDdZN+qsvGmg+o1AB+hFxH3Zb3kg0Cyxnof1Yfvq8BOwczRtKs/HJUY5uczAaeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnovx7YMejF0hMnUnFvJQGSugmklUXC5W0e4B4GSRsg=;
 b=ywrcvw9A9YqS4mn5yy6YtjTasGQ9a02sy51l4vLbOIcgO9xCpjJuVLYshVksWYvKuzTuxEDTdSuKh2pQonsII/dEvBDfjvZkMqRvjot+OM9/t7QOVDTLY+rQ305qHRn7EhI0rAESC6SZwH0NAJQ3HTabHz6TBJ1GIkGMnfSEcy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:59:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 12:59:58 +0000
Message-ID: <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
Date: Mon, 7 Sep 2026 14:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
 <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baf578b-24c7-4622-6f1f-08df0cdfebe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3ztaOm/TCPL7BVwAWwnOin1XAPlhhn7ExdTDdI6CzDjBfeg2SxqcouMZKs6eW6Iv0o+7M6DgoMw5sJHmRhrIbLogvk37k1t+5CMlAeUYiSt5bZl19qDlPhxXp1RPo5LQ2lxkjeSqRdAValSd3H7vZTd05ThakTHDkpPGJGHWN8UgNxvVsT8uV1gRg6LoAALP8wTGiSiWvJGYGIPs32BWXHlO99womGWjRdB6/cFzJosNMA61nnih2IuYr3YmbPYxL1R+oqrhNt1nTytRWczJ/ylx+9XYQArAfoBHp5YqmWud2HwB6/IEoKuIE30KfBfvpt4vsDbl/F8Z0k6PP2Tpk3w4f8NvHivkSa410ENMXKUEBxsGpD4V51ykImNccJR+QiP20oGy4wi9U4PVSQAqtRRf4PBqwIJFQ8gscn0V0foiDAR92eVlbJ0eBRYdsW1sgQogZdyqN+0ILVgeEen6L4JMTCZGOQSJLgDfUbg/1FzfVXPfATUNw0vfDuvJs3Obsw0gCs9rfzI4r/syGoM6AdZW+KowMxSlKi+U7aNKFhR/hg5oLhMvdni+1YjxNXBgpi5xPE/R4GsOIE1r8wH4+FeippA/iPe722ldTu4Gf0oSz25oyuwMb1JFEGNd5NhMikNzLnr+VsHDEFCvUdvIuKFk/mJSSsiNnNFTRCIo/VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejBQbnVRSC9maG1zYm1zUit5MW91eVpRam1nVWd3MzV2RnFvbVdTYy9qQkI3?=
 =?utf-8?B?UFc4MElTaTRFc2FBbktLLzhUc2N2Qm03aUZoMCtsVFovOTh3a3EzYkFZcElo?=
 =?utf-8?B?Um0xQnh5Yy9oZ3hiSWVzMCtMWEttRE9OR2RsdkVMNmRKRCswRGdiN0s2TjA4?=
 =?utf-8?B?ZUIwRUkycGtsTGR5c3BUSC9UaDlURFY1TGJjRDAwdWkxSDlvUWdpTC9BdFZX?=
 =?utf-8?B?MGFPWEcyY0xLNXJGMDM4RjFSOWR3anU3Y3hIcXk1aXB4QjBwbHN0Vi92cW5Y?=
 =?utf-8?B?YWUrY1A3TlErNm1yUGZHSTRYMWNqOW0yalpnRjBIaXZCN1paMERvQ3UxSW1T?=
 =?utf-8?B?eC9hMjkyaUxjZ3oxT1lEQUE3d1g4MHhYa0hBUk1lTmFpZ0NyWDk4Nis0N3ox?=
 =?utf-8?B?OFV3aW1VcTZKdlYxSGo0ZUJmRXdDV0p4NUVyK2lRTEtMTG4yaG9VcmI3Vkxn?=
 =?utf-8?B?eEYwb0VqRlJ2M05OMkpvUCszMDU0ZVpNZUNzWm1sRjFJTk9qOVAxL2ttb3Nr?=
 =?utf-8?B?UTRBL3huYVg1UkdPN2xBSE93M0o4NXNIWDc5VTUxSVRybG1Lb0RteUJDVXNr?=
 =?utf-8?B?VnIyY09pSjlZZG1telBoRHJQRjRQVlZkT2IrQVF2WWlVMjJwODVkemRvN0tG?=
 =?utf-8?B?RGVUUk83d2p0Z1drVDhnaFdzaTBWd0wzL05GN25mQklWSDc4aW1aMC9KQzY4?=
 =?utf-8?B?N1pTRzVUd2s1WEIveno5Z2xTRStja1ZKWDNwVXNIWGRHMy9kVmt4STV3dG5t?=
 =?utf-8?B?TEhCMHlGWkdxUDJDQTZMTm8vbDM2VkFlbWVBYXlQZWRQNFJWSkNsMGZWOXF3?=
 =?utf-8?B?aG43elFwMGp6UW1mYkhUUDhrWmJnZmVmdUZSSXBjK2JONlR3SWF3aHB0bWwx?=
 =?utf-8?B?cnVMTFJmc3RnOXcxUW45UG5pd1RKd2tYbUhQakYvVzkrRUMrY0I4UVA4RUp1?=
 =?utf-8?B?emdnaU1XOWN5MEVxdDV5VlEwRGVqTkIwajB0NHlEbmpzNDhlODloUlNmYUhT?=
 =?utf-8?B?alozVmhpUkpyUjhOdUhDZWJ5YWZSSFltNGVWOFI2TDkzeThFZU53R1dWMXpS?=
 =?utf-8?B?dGxuaUU0SDlnbTM4M05SanMvKzMxNjZ0SFFqZnhRRm9lT0lZS0ZDMjBsSXhk?=
 =?utf-8?B?T1p6aklPcTR1RjQrTkZTQktSOWI4OUg4WUh4dW80MFdYd2RaZXVpNXBKU21j?=
 =?utf-8?B?NVd0S2hiNUZZclgvaCtaOFlCTmIwN2NXNUZ2a1dpQS9NaFFKMGRKNlZzcHdP?=
 =?utf-8?B?M2c1bjBlSjREbktDKzNpNC9JNWgvdlNVVHBaNjlTWWN6QnBUdnFHY3dmZ0tz?=
 =?utf-8?B?UjExd2E0Q3hKNnU0RkpLWWxrNnJubzAxOVVscmhGbVVxT0pDSkpqWG5HN1lk?=
 =?utf-8?B?R2V0bDIxcUJ4bmQ2T3dTWUVFV2NXbGRVcHRTRE9haU9iYm9LbDRtOTliZUYv?=
 =?utf-8?B?NUdUaVBBUDBnSDQwNEE0N3JtU3FjYmRoMzh4eGVGRFhNbmpiMUlGYjFTdkpB?=
 =?utf-8?B?YjVzd1AvMFIyOWRMdU12eks5dkcxOWp1UEUzQ2gvV3cyL1poSjNHQW52SjY0?=
 =?utf-8?B?cmZqWHdoMUZ5SkYvRG8yTlVqME5BazdCZ2cvSDZCTU4zQXdIZjJNdXc4QXgw?=
 =?utf-8?B?NkpkdEErSU0zU2pQTEFPc0t4SktKOFVhRXZrSU1hZ1hkVS9LWWpCcUwxTTJI?=
 =?utf-8?B?QmE5bjBGb3hkSUZFS2hkUjh5Tm5jbjd1N1Y5RFlJaVJ5RGxlUE1tWXVyRW5z?=
 =?utf-8?B?MkQxQUJHNUx1TXVPYk5iY1Q0R2Z3SlZJQnd4ZnkvQ3o3TWdadWR0UGpTd3BO?=
 =?utf-8?B?dS9sTWUyNDNTcFNINFY5TlNKa2JZQjlXZUJvVDk1b2ZyWFA3TFk3N3NKYXFL?=
 =?utf-8?B?K0wwM05TRlZadVdiNmk3TzVtcW1jNWNoSmFRK2VSc2daS1pxQkxPekN3NVR2?=
 =?utf-8?B?UWF6ZGQyV3N0VzU4dXo5VnRrUzZETldBNDAxQ0NkUlZtc3ZjaGltdTZuSFQ2?=
 =?utf-8?B?ZForYlFPeE9TMFNkRE4zR1FRbG8yMGtzNFNMZml5OHR0SlJ0TmlLM1d5WDh3?=
 =?utf-8?B?amI4ZzJHSmN4aFM0bnliWFUyRFNCSzdwZThEUzY1M3ZLNENJSEVRQ1RtcytF?=
 =?utf-8?B?Wlg1WGtzZWdpV2kyM0MxeStwdlA4V0gvTitpSVIxOGdEM3RINlhHUElMMVVw?=
 =?utf-8?B?b3dBTDV3djhZQnFwbFlzWStsZlVOenNNUmRJYzhSdXNZVFVjREJsZHFEc2xM?=
 =?utf-8?B?WXZqSm1rdnVhSzBWNmJackY3YlhTZkxhd2JubEdFaDRLYW1EeFFQVk1uZXJn?=
 =?utf-8?Q?StcOhPrCPFMDBXBaPO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baf578b-24c7-4622-6f1f-08df0cdfebe9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:59:58.7252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Hy7ENH1PvM2+uEOIDOGNdYPBkvUJy6e5nBnvvdHkZZrC44DUduXIIfC6+U93KXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
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

On 9/7/26 13:15, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 12:06 +0100, Tvrtko Ursulin wrote:
>> On 07/09/2026 11:47, Philipp Stanner wrote:
> 
> […]
> 
>>>
>>> So I maintain the position that we only get it right by having the
>>> signaled-bit be the decoupling point.
>>>
>>> Or am I missing something?
>>
>> The driver fixes you asked about and I listed work(ed) in the context of 
>> 506aa8b02a8d ("dma-fence: Add safe access helpers and document the 
>> rules"). In that "world" it would have been safe. Did 035219a760ed 
>> ("dma-buf: dma-fence: Fix potential NULL pointer dereference") break 
>> those fixes a bit?
> 
> I think we all agree that 035219a760ed should not have been implemented
> in that way because it does not work for drivers that provide a ops-
>> release / ops->wait.
> 
> So I think the only thing we can do right now is add the signaled-check
> back (like Christian suggested) and ensure correct memory ordering –
> since we also cannot use the spinlock consistently, as that can still
> be extern…

I think the memory ordering isn't really a problem.

See if the ops pointer or the signaled bit is loaded first doesn't matter if you check both.

You only need to make sure that the ops pointer is loaded once cause that one is used multiple times, but that is already the case by using rcu_dereference().

Or what exactly is your concern?

Thanks,
Christian.

> 
> 
> P.

