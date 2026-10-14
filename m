Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB8CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C274C11216B;
	Thu, 15 Oct 2026 07:56:55 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020100.outbound.protection.outlook.com [52.101.69.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CCB10E327
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:15:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQi9DYqaKicKSx8l/yhbvO/Ugy8aI19GWD0KQ5oXZ9tB7d+7SVW6affLt7/iSqfFPjPpAX9ZPmLo6nvHa+NhgOPP3/0GXQ3ddvkG58LlKZ6QO5IM8fKQCWt2B2BMLiyna+3L5aWieJAdHRLyGQ0/px1ZFIiwSRk/n/q9iBKqdhi13hzlQAvSrQXQ9wr+Itc08M0xJoX/8wsnrNsYo3NBPbzgcMZJ2xdJeooS2YvRwVYpJ7Bgflu77TXjlugwVktCBIohmyABZmplNnqGmwAeb4/5K8RudpRRhRbn3vcBWoO+kDZOx4CDBjmz9RH8gN9+THON9y/oMTNCXEwrNyf8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MwilO3ptPoghCNspXfhkYCu4LizynKKr/YLWXGEepg=;
 b=t6wtFNqJE5tUA5QVAFiXdNaPny7dVLGU9UwrFRcvZMLF3bIzR21voYyOSa0yHe0eEdqyff7IJs5/tP/fVcTpVLpxpJKCKNerLIlMXIwXG/8v2SO/IbaXdJVTAREdn+hIrhYBQ/mEk8ZBt3xVUTtpQWd4EGwlRdefNyo2kRO4+k7YmDTvwFnHMHNUsTHYQxD6waH5hZVcGzEIwEprajpw9Ke/PrgkpuI5JSiy3SiS25sU0UULDb5ptgjRbNI4HRV/sMiB+z3VMDubPLd3ufcPX1qPb3q1a8am8iDwapjnJD7IBmu0hiIhxQuXmB13U/4Kmy7IyFpR0NHnV0IT9ehIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MwilO3ptPoghCNspXfhkYCu4LizynKKr/YLWXGEepg=;
 b=KkYf5o354TQQdj81hDqFTOMgkTmW1jfJyPOSVoTdP5AC9cWARQkODMsWRNTf9vvp2byH6bkv6YVsC2q3Vi/l/gL0Nq7GPnKUcnu4SFImAtsZtFxPNoj1yp6cgeQwvEwGXKN0NpMcYIgm3maXNrkWk5Pa4o7kaIS8fucNk7dzbT5ZiG8X09N14a5oWCvok21nvAFJaZWgqA38uPnyhZSOqyx78UOQsS4OpmGSnaQY0PvDX4sGnN5YamVYJtJDrLVw8H6Z5PjC1CdwwsSVGAr6Dt10qy2u35OLbam5zfX6nMKUdtCf2AY97dS2uqg1HwBOol1+bQSdpyhhBy+rjW3Q6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by ZR6PR08MB999901.eurprd08.prod.outlook.com
 (2603:10a6:910:d2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Wed, 14 Oct
 2026 13:15:20 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 13:15:19 +0000
Message-ID: <a63c77db-4b1c-440e-b9d2-cc4d7507e096@virtuozzo.com>
Date: Wed, 14 Oct 2026 15:15:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
 <sashiko-outbox-171250@kernel.org>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <sashiko-outbox-171250@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::16) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|ZR6PR08MB999901:EE_
X-MS-Office365-Filtering-Correlation-Id: a7930007-fbf2-4b65-2a60-08df29f53249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|4143699003|261009223027099003|260925021911599003|10067099003|260925022911599003|18002099003|22082099003|260925021311599003;
X-Microsoft-Antispam-Message-Info: BIz6Yiv2F2qHgFbjZZMFLW6K+DxbXsRDmb1+M1w8tMkBd50ZX9IH21ecaEMXquNGuyIwjbWUmQuMxyUXiIIIlWv6E2WN//caCnu7VpAxzzBBAT/ga3nk5z4x47GhWqbxlKBbWaLWiAF+2hLwNlHKbf0ISXRexFlxvaQPas4sOE1CXP8naPj1yUyWdF3mHJwW9CZruv9HYSESsWyM+RmvJPvNDuVs5cchurbgPxomY0ClfV6a/QWGUjCoz8D+OiOZzdAX03Ii0z+NqSeN2CvY6AzSnlQsIC6fikVf4SQObSJGwcGxIxbjE76LR/ohw+LRpcE2Llu6ARrkwxx1CfeiM+UiI2TV1l4Nsc22TsUXqGY6+aDw8Jgl54QWn5hOJr+DznTd5dax1cauYSxXVMwPRFrkE9nx4QZoCciNjW1+eLA9Qzzettbccr51O2whQwcj/zvBP9+VqfHWtqZMs3mzpIDBHGAZ+q9IJIBUMOwTJSUEdkNswH5xqqz1xRvZQ00/cYQLSX3zqsN1TfSgHAlml6WIOHANRjp4q3R1B93LCjaMjpzd4wUrXmOOi85UROWT5nBzbg9DFXJ5/hx/+F26FdW1MMF4IyL+9feSDGz7xws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA6PR08MB10708.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(4143699003)(261009223027099003)(260925021911599003)(10067099003)(260925022911599003)(18002099003)(22082099003)(260925021311599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdGYlpxNWJMbGtOeDhTb3RqN3liOTVtVFJ2VkNqbDBWeURaeE40UjlIbHVu?=
 =?utf-8?B?cEljMk42bzZmQW5ENkh2TDgvREp2a1p2VXNjN1F0SkFwYi9QVytjcGhaSW9U?=
 =?utf-8?B?SnJEdGRYc01MMDNWRWpxM0RMNmFtMU01VXZzU2wwUFB4eWl5U3dIbldnNmZl?=
 =?utf-8?B?akhrUG9sNUJac1crUTFtdklyTllzTGZld0h4eEdoYVl6YTgzWDJtS0lnWDNm?=
 =?utf-8?B?cVdlOTJ4WllRZGRpalNGUFJNazJtek9pcGhWZkM4cCthZWVPTDRvckhGaWpi?=
 =?utf-8?B?a0Z5WnB0bTJ2TkppM0lMNlE3L2U1djM2QzZjb2tsbnlIYjM0WUpXNHZmRzl5?=
 =?utf-8?B?RFF0VzgvQ0UwandsQVVselVLOWtON0JKWDhJSEd1T091MEtsaWZiL3pPTVlr?=
 =?utf-8?B?UG5XRGNqUWZGRVVZamVoRDZ4MlhkRU1iWlVMSW50NTJGb3NyZGFWMk1jRU0v?=
 =?utf-8?B?c3hpRHU1TkF2d2ZQRDV0d0xqVlhNYW93L1ZRdCszUy96YU5HMWF4Q2pmdWZt?=
 =?utf-8?B?ajZ1MHZDNkUwekMwOVhaN0h6M3ZaQUVubmJsYXRZeWErak43RWJzTS8wcXVN?=
 =?utf-8?B?cGlMYjJiQXl2YWhDM0J3eUUvakU0VnhSeVVnSHJHa0JBMFJOZ0xETFNmTXkw?=
 =?utf-8?B?L0dzZTkxVitWNXU3b2lkdi9XeHlFZEJFZHdLQTU3UUdSNHNUTzZuK2pRR2NV?=
 =?utf-8?B?YmRxUXFMaG5USS9vaUJFZGRJTUhNL1cvb0tIM3JUREQyd2hDVGpwTnhMRk9l?=
 =?utf-8?B?UTRQcUFzRXNsUGNiZlFxcHhkeEd2OGRPMGY3c1hibkxyNGY3WGdwd3Y0UGFj?=
 =?utf-8?B?cXd1cUtFbDVOTGdwc09OMzFqL0pGeHl6enFwWnlaa2VnaGlsQi8zSUwrcXk3?=
 =?utf-8?B?d2kvbkY2Um55eG9NQi9EYzV5cGJhWnVCdXhEM1ZDTUpRRHI2S05iYzU5WkFp?=
 =?utf-8?B?bWNxY3lzbUJUS3NBemo5YXRJZ1lIV2xlZnhyTlcwZW9oKy9ScTV6K090WTlG?=
 =?utf-8?B?cG5CdU5HSjhYTUdhYjY4WVVsb3A3V0QvZUtmTkg0dGVILzVFZHJaREFYUE5Z?=
 =?utf-8?B?M2RoUFV4TFE5Si9EOE9xTWMyMHo0ZUxLbWJ2TXNCRVlDd3dGTXpNQXNSazVQ?=
 =?utf-8?B?TlNyRVp1eDBlckUyZUo0YzBHODRDVHVESDYvS01JTy8rTWNLQysxeUFYRFJz?=
 =?utf-8?B?UUthZ2dVUXFhMG9xdFViRnBFaFJZT0dCcExYSXQ3SjBTdjVqUzYvUWREZFli?=
 =?utf-8?B?TmRRdENiUVZXRUY4OGZrSlM1ZHpiWnp4T093d2Q5RUZJdXhiYmVMUWlnOGlq?=
 =?utf-8?B?STA3Tzk0WDJpOXIycUxGODgxUnc2VFU5bHN1ak9mcmZVZ2pXZGR1cTY2Q2V0?=
 =?utf-8?B?WkxpSGFHRUQzaVB0M1FMVmxkTHZoak1GYnBNdTNhbFd5dS9uY25LUGZZNXNR?=
 =?utf-8?B?N3hzeUpOZXdDaWJ5REhhakFOS0dZZHN0azJXVWVCK21EZ0FSSitJajlvVm5W?=
 =?utf-8?B?c1pLMDdVR3h3amdzZ05TMDVER1pGYk5zZmhBTWMwMEhrcU1aTmx3cE5RZ2Vp?=
 =?utf-8?B?ZGVVOWdQcW9EYWpPc0J4eVRYVC9yTXV2a0NYSzVFMmpFYXltRG5EWE9yRm5W?=
 =?utf-8?B?aGI5UHQ2Z1RJWi9EUk1TUDVoRytjOVY0OG5MSC91SmhCK2lqeDgxYzZ0emNI?=
 =?utf-8?B?SEdCaS9IWllvQTBYUFZNTkNsTjkzZGMvNVlrc1I0WXRIOUtkWW5HRUxJRFA2?=
 =?utf-8?B?a0xtZGV0aXRLUXVOSk1xeFJpcEtSdWlpN2VDeFpOenZnOVp4RjBYbUtlUmpo?=
 =?utf-8?B?a09mZ1lBamtOQUd1UXY4TDVWZDhrTGZER2o2Ky9TZEhyUXRQWTM0L0c3OTM2?=
 =?utf-8?B?T1pjNURVQ0lNUUx6bDlMNGpyMDVWQmRudXdMRXZnaXMremRjc2NHSUYxOUtx?=
 =?utf-8?B?Rkx4OE9OZWpLN3A5S2NaanlIOWFXMEhKQ3RINXgwdnl2OTdmUlV2em56OXc2?=
 =?utf-8?B?Nzl0b0dMbld3QXV5ZHVMbGovZWNQdzJqbEZRZGJRZnlXSlRGbks1aUhoV2Mx?=
 =?utf-8?B?NWFoQzE2Mlh3dDRmRCtITTZyUFAxSFRKeHVRS0Y4STlvYUVjcmpPZ3h5UTEx?=
 =?utf-8?B?akJRRnFGcG93eFV0SzI3RzVWSStqbTFwNjhaY3BxQ2wvbTNvSG5vTEJrejNI?=
 =?utf-8?B?NXA4NmF3Y1NVNjY2a3VjS3dlSldiVEVnQUY0dHVsZURLN2VOTkU1bFcySDd3?=
 =?utf-8?B?ZmdUcFh1NHpXeWd4OXhrM2oxblNhUi9rNnZzaHp6ZmREZmlHNnNhbEFaQ3RX?=
 =?utf-8?B?cWY1UHo0dzQ3VUtjektIcU5XYnNUbHI3U2ZrVnJFM1ZTN2x1TkxQQT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7930007-fbf2-4b65-2a60-08df29f53249
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 13:15:19.8622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruxztXe2ApOQTOabwuyKaYOcJuB0hNT9faiDQJR2JMWebAym9cbmeTKHpYP9upTUJfAEzI/x2F6VUKDIg1YUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR08MB999901
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

On 10/14/26 14:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm: NULL pointer dereference in zap_huge_pmd() for special PMDs on PowerPC
> --
> 
> commit 5100f57130de5473973d1370273238b4778fae24
> Author: Konstantin Khorenko <khorenko@virtuozzo.com>
> 
> mm/huge_memory: recheck a special PMD under the lock in copy_huge_pmd()
> 
> copy_huge_pmd() reads the source PMD without the page table lock and,
> for a special PMD, installs that value in the child without reading it
> again under the lock. This commit reads the PMD again under the lock to
> ensure it wasn't cleared concurrently by unmap_mapping_range().
> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 1e5d68acf62a5..fcea98f0d8865 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>  		src_ptl = pmd_lockptr(src_mm, src_pmd);
>>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>>  		/*
>> -		 * No need to recheck the pmd, it can't change with write
>> -		 * mmap lock held here.
>> -		 *
>> -		 * Meanwhile, making sure it's not a CoW VMA with writable
>> -		 * mapping, otherwise it means either the anon page wrongly
>> -		 * applied special bit, or we made the PRIVATE mapping be
>> -		 * able to wrongly write to the backend MMIO.
>> +		 * The mmap and VMA write locks of the source keep faults
>> +		 * out, but unmap_mapping_range() does not take the mmap
>> +		 * lock and may have cleared the pmd since the lockless
>> +		 * read. Let copy_pmd_range() skip it then.
>> +		 */
>> +		pmd = pmdp_get(src_pmd);
>> +		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
>> +			spin_unlock(src_ptl);
>> +			spin_unlock(dst_ptl);
>> +			return -EAGAIN;
>> +		}
>> +		/*
>> +		 * Make sure it's not a CoW VMA with writable mapping,
>> +		 * otherwise it means either the anon page wrongly applied
>> +		 * special bit, or we made the PRIVATE mapping be able to
>> +		 * wrongly write to the backend MMIO.
>>  		 */
>>  		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
>>  		goto set_pmd;
> [Severity: High]
> Does this code cause a NULL pointer dereference on PowerPC when a special
> PMD is unmapped by the child?
> 
> Because the jump to set_pmd bypasses pgtable allocation and deposition
> for the child process's new special PMD, no pgtable is deposited.
> Later, when the child unmaps the VMA or exits, zap_pmd_range() calls
> zap_huge_pmd().
> 
> On architectures like PowerPC (hash mode) where
> arch_needs_pgtable_deposit() is true, this leads to:
> 
> mm/huge_memory.c:zap_huge_pmd() {
>     ...
>     if (has_deposit)
>         zap_deposited_table(mm, pmd);
>     ...
> }
> 
> This will unconditionally assume a deposited table exists and try to
> withdraw it. Then in zap_deposited_table():
> 
> mm/huge_memory.c:zap_deposited_table() {
>     ...
>     pgtable = pgtable_trans_huge_withdraw(mm, pmd);
>     pte_free(mm, pgtable);
>     ...
> }
> 
> Since no page table was ever deposited, pgtable_trans_huge_withdraw()
> returns NULL, and passing NULL to pte_free() leads to a kernel crash.

Thanks, that is a real bug, but it is not introduced by this patch: the
special PMD branch of copy_huge_pmd() has never deposited a page table
for the child, since commit bc02afbd4d73 ("mm/fork: accept huge pfnmap
entries"). This patch only rereads the PMD under the lock in that
branch and does not change what it installs.

It is also worse than the zap: on ppc64 in hash mode the child's first
hash fault on that PMD already dereferences the missing table, in
__hash_page_thp() through get_hpte_slot_array(), and the zap then hits
the memset() in hash__pgtable_trans_huge_withdraw() before pte_free().

I will send a v2 with a separate patch on top of this one that
allocates and deposits the table when arch_needs_pgtable_deposit() is
true, as insert_pmd() does.

--
Best regards,

Konstantin Khorenko,
Virtuozzo Linux Kernel Team

> 
> -- Sashiko AI review · https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> 

