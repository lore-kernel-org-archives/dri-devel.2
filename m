Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EACCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E247110E7C9;
	Mon, 18 May 2026 11:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N0dMmEAe";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013061.outbound.protection.outlook.com
 [40.107.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C45C10E7CE
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmxmza0rQp6o7A5nVToAp2soaQUHo+lLofgj7VslnG5XuuPpAsdaKSGnDe+IZSP9yhc10TazMkhRpgYgfk9dT6Eb0XPUizl1OKctnOlKK8ptXYKdjsuCUpgIn/IfM3BsAXk4ulEl3VB+Lp3ElfgFufqcAGkWZCDD5Lq/wqRtazisBMYVkCQcTbhk6zDzhf5IHf4rIUJ6rnAdMIAYyD7aXGAHVKG5eiy++PCPmW5LCXOE+/4g9deCrBh+vj+5g5mfDCyRxsDIyuelZcmnEPiEUqu0uak0xInmgh55AViOkgco7wwTHvIMlLKuqeiLN0+24HMaYpay7f1X/4uDiKJ/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JujPs5Axe1X/x5PWvhbmclW3rCRoDhYl7FhOhq2CFPo=;
 b=OcDYeZ9EB/t0MKI0nGHoZ5QD6bVBki59I3i//D0CveNSgAZtaMel42opQkkKpTMFv14YtWMgg7OaZLOKMizPNJ/BEyH8nMW1+HxwLgqigep1LWGszzSqZv1E1mqq28BMHlfaYmFL7w0CrbfIbBhKef7iziouc0Bozow7wQFY+EbQLkDCTX+XZQqoMyT1oLtQ3yc/jO/qseJHmIlUT4fgB6WniQKyni1cuCap5jB53gorGnuxAOVTwG40geDoXojBuzcboWPKY0LMEyiH62AM4bd3ZtNvKP79RtTxOD8Dk7NEeRHDwX3gnq1rjeD8lI4imTWdnotTOyy9BVZ1pK6VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JujPs5Axe1X/x5PWvhbmclW3rCRoDhYl7FhOhq2CFPo=;
 b=N0dMmEAe3Fj5HVzjLylaON/AXWlIokYI6d/+j9qsWvyq1Il29GSHz8pCRRnwBNndOD5keqys28ToGsTNjmh6N5nXIVv3ve993F/wjooJ7lp9TitK9wlEdu93QbKQ5I5HkA1uz3x3/XOmU1+7tJ9sollhy4/J8DOEtZ/iV4sLEcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 11:30:09 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 11:30:09 +0000
Message-ID: <b202b9f4-9ef6-422a-be39-8050217590ad@amd.com>
Date: Mon, 18 May 2026 13:30:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-fence: Clarify external lock use case in
 dma_fence_init() docs
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kernel-dev@igalia.com
References: <20260419134943.54833-2-mcanal@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260419134943.54833-2-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: e02ce674-b251-4a2b-d299-08deb4d0d12e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: QrhZnVKRmIYb9zcgFsLRRr0oILbqfT+c4EC/7QKEuu/B1eMCH6e7ac+fzsZKYAL3N5pEzjwcf8sLvYrgOTUuX/ZJD5GW9MyBiRtRH5dicRIlqvZ/gFUd9EpY4Aa6meKi4JbVg7Qu07GHGZjBu1/T3TrLcidr7PEZCy370pCUQixK/AzluG1MetqrBx/9w7N5AODsBvpY1Fbtxh2Vt/ZVogRSDhSE0U1+gvtgshstMHZ4/CRqVxSDnBq5lKzwrw22ByoTF03pFZBaiaVvYGuwFuPe38tTmYXlz3yskm+SagcDG4fIV/SYnmLeUGkh+/CvIOHYnMG9YmCvBkcTB5vjgP59VkbsN+0JKoNl5ac8fvIAc4YHxw85nl+Dj/QNep/1tHx0fM/NN2Ib4YtKg1/FG0A1e6QQnlc/mpaqHipXw8BF09gBkwWfd+Xi/JhCeiSFxBISxgtz0n4pT4ouU9YlgjknCLkvL4wJwvBzbA0SmqJFNj9OH7IVBPhSxcbH9KSN7OpFBov3BCbp82MQvWrbilUn80f9EbDe66rRPFeaaasCqB52439E6uxdX64srWoJ+5VviHkhE6RYofM0Cagn2ujkEfFP9WGsqDZvLq9gw78+KSiaJ6/hHdqJERkHsfK+oKvsmU+Q0+6GMkqI75a6C5h8+ZCo5mRWJTh2eA97TuULLYcQdQYHcqa2P3408IZYnEnlRft4U9bcjoGWF1TDig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmFJdVlPNG1wTzlSZmZJOEpCVE9EL093UGtjd081d3VOSkFWR0pvajZmYjc4?=
 =?utf-8?B?NXdiWHErb0s1cGd2TVFXMkpLd3hIcHpFWUt2NzlReDZnT1JLVmN4ck5ZVzN5?=
 =?utf-8?B?bUtyTlprelJUOTQ0bnFac043ZDhmaHJndU5nYWRTeHJqSWtlWkhHQUh4Ui9N?=
 =?utf-8?B?SCtHd2xRdFJVYjN5cWp4NnhkM1d2M1dEVUhsbDdMbXJGakR1cEVjYVlxb1ZC?=
 =?utf-8?B?d1A4NGlXREV2b21YRmNCRmJnUFFFVFY3dFZ5SGdXK2ZkdkgxS3BKVkh1SHZz?=
 =?utf-8?B?VzZxNTdzRk5keHIrZUdvRk5vanlBSTBqUHlZckdMYzhWNXRqQlU4QVRPKzAr?=
 =?utf-8?B?TGpsMGdIMHZGcjBmM3VQbXQ4dUpNUG8xT3VHbkhubDZ4VWF6UVM4Ykszayty?=
 =?utf-8?B?Vlk0RmdXSC80aUw2VDZPb1pWUTZROG1oQVp2MyswejllRVQ1YlVDdXl2dGNo?=
 =?utf-8?B?cWhXVU5sNlUwenprN3pBWWt6L3ZtczVZMmdhTFhKMG4rSE5tSmRLelQ2ZUc5?=
 =?utf-8?B?Z1VYU2VIeWpwbW1CU2hXU3Q3MGVKVTVJbVVlK3N3RTY3dm1iUlZudnBYbFpV?=
 =?utf-8?B?REpsenFmVlVQZ3lkUHhvK0xlYmpHRnNqS2FKeklEZ3hTN01kc28vZ2VOc0dC?=
 =?utf-8?B?eDRGRExkQlVHUmVzTGlFTWpTalZMc1VVMWZlTDNKaURTUGo2NEw2VitzQ0pN?=
 =?utf-8?B?bzFtNDFOdDEzZldZZ3JaNWlEQWNzaFJHc2VnVWpJQUF4QW9TdHFEYThEaXY1?=
 =?utf-8?B?RnVrVXhySHpMZXhvcEl2cW5HMlhYb2s1SEZXUFpDNC9qQUd1YzNDL0VqTHh6?=
 =?utf-8?B?bDl6ZzNQdlFTOHlERElaclIvaHFRcU12YXVUQ0tBNEFhMmptb2FxNjhqRUNz?=
 =?utf-8?B?WXZOQmVWTll4SGJvUi9xWXVycFk3NlRiM1UvaDRsbVFuVTZueXJHbGtobFJL?=
 =?utf-8?B?NEh2RHVKN1RZZUhlR0VZRithNVp4c21mV1dyeEc4ZWFVRHJjdVVySU9lMmtk?=
 =?utf-8?B?UWdHaXZKNG1LZk90RWhwVXltU0Y4QmVvVkRZS0E4bnh6WkZRckw5Z3pwRXVj?=
 =?utf-8?B?akpCKzN0VVdvSGs2RlRUbjR6QXdDVThoK0M3eE9meWhZSm40NUx1WWMrdVRl?=
 =?utf-8?B?WGtMS1M2MEJCNE03T2N0cDdGeTdoZ0tmblR1MWRUWEQzU1E2TGllNkRUSmhZ?=
 =?utf-8?B?MEZ5VmJMSkthanZpRWNsRVduNDBXSXdwdTZkbG9vODU1cEJrTW85UEZ0NXVv?=
 =?utf-8?B?bTJJMjJkNHZlNFlLMnRhdFlXTUlHMkFWcXlTNjJteFJNZUJiM3RuYXpOdjhV?=
 =?utf-8?B?UWR6YXRzUko5SU84T1JNcHYxalIwbndaM241U1Y0cDkxNDlJMlN6UXRxWGNG?=
 =?utf-8?B?dXU0ZHYwTjhJM3hibGtJZ1p5VzlNN2R3SzVrTHpYVlFRelYxYmhCbU05cGlH?=
 =?utf-8?B?ZUpyaG92TGN0Y2NnRUFZdk9mczQzU2VCeHVMT3Y2dG9nZEpjMUZXcWx5aUFY?=
 =?utf-8?B?THdZeUdPWnhHTFF5M09za3VackwvRVgrT1hsUVZuTGV1V0xvcWpCNW5pbnJn?=
 =?utf-8?B?eVJ2bHRLdGlrVEQ0V2J6WnBvc2hoRWdwa0xKR0U4SHZwcjN0MW8yaWdaTm5L?=
 =?utf-8?B?bU9qZFRJS0pIV3l5djVNSEVpMmJpRHFmZ080dkNoQ2JpK0d4MUF1RXVQaDJK?=
 =?utf-8?B?NGRuV3pOLzJ1SzV0QUJ4NDhyMXpPTmJhQ3RGSHVyekJMWGtPTG0wRnI5ZXhH?=
 =?utf-8?B?Q1ZiNENTUTNJN0xVU2NqdG1XdDE2Z3NWclZWbit6UWVsU1NnU1FaTWw0WWhl?=
 =?utf-8?B?TDJYZ0NrdjJlc3paaklaSDRtOHdBTDB1WmZFQjg0RWFDZkFtRXB0Rm1JNVZJ?=
 =?utf-8?B?b09hQndZVUtwM2Z5VXA5TENXa2xiYitRL3BLQ3FiK3FHbHgyc0EwL3RqMTdE?=
 =?utf-8?B?ZkdJYk1PcEdxaVZycE9qdTF2ZUd1Ny90blBHV05ROGNlU3o5eEJjNStNQWFS?=
 =?utf-8?B?K2ExcnhwU1F0K012c09uMnZYNTljQVN3NTVPYjNybEIyUktQaFZNVXI1Zmdn?=
 =?utf-8?B?MFM3Zi90OHhOL3lHQ282UXRHellrcjRzYWZ5MVQ5U1d6NUtCMFN6QkJvR2Fm?=
 =?utf-8?B?ZzZrMWxWaWppWU9Mb0gvNXlvL2x2dEVLZVF0aHFDMmVmbGgrTHh5VlloekZx?=
 =?utf-8?B?TlVRejU3endOZUVqMDBWU1oweElUeHY0cnhhVEZ6LzZacmZnanB5eGR4U0Fr?=
 =?utf-8?B?b09zWS9xNS9QYmVlK3VmWHM4QXlhdmpqcTZCT3lsTXdxVWtkWUFDYWZVT2x6?=
 =?utf-8?Q?2CqkcWzHCKLaW/fQbK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02ce674-b251-4a2b-d299-08deb4d0d12e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 11:30:09.0790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOJb1GFvFQ7DPYZ3sIhCF9o7es72jAjDXehTByf3fFJ3ioIf0ihmwIIorhxpDuG4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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

On 4/19/26 15:48, Maíra Canal wrote:
> The kerneldoc comment on dma_fence_init() and dma_fence_init64() describe
> the legacy reason to pass an external lock as a need to prevent multiple
> fences "from signaling out of order". However, this wording is a bit
> misleading: a shared spinlock does not (and cannot) prevent the signaler
> from signaling out of order. Signaling order is the driver's responsibility
> regardless of whether the lock is shared or per-fence.
> 
> What a shared lock actually provides is serialization of signaling and
> observation across fences in a given context, so that observers never
> see a later fence signaled while an earlier one is not.
> 
> Reword both comments to describe this more accurately.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> 
> ---
> 
> v1 -> v2: https://lore.kernel.org/dri-devel/20260411185756.1887119-4-mcanal@igalia.com/
> 
> - Be more explicit about not allowing new users to use an external lock.
> - De-duplicate the explanation in dma_fence_init64() by pointing to the
>   dma_fence_init() documentation.
> ---
>  drivers/dma-buf/dma-fence.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index 1c1eaecaf1b0..63b349ba9a34 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -1102,9 +1102,11 @@ __dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
>   * context and seqno are used for easy comparison between fences, allowing
>   * to check which fence is later by simply using dma_fence_later().
>   *
> - * It is strongly discouraged to provide an external lock because this couples
> - * lock and fence life time. This is only allowed for legacy use cases when
> - * multiple fences need to be prevented from signaling out of order.
> + * External locks are a relic from legacy use cases that needed a shared lock
> + * to serialize signaling and observation of fences within a context, so that
> + * observers never see a later fence signaled while an earlier one isn't. New
> + * users MUST NOT use external locks, as they force the issuer to outlive all
> + * fences that reference the lock.

No that's not correct. The use of the external lock was indeed to prevent signaling out of order.

It is perfectly possible to observe the fence as signaled even without taking the lock because of the unlocked test_bit() operation we use, so the new wording is clearly misleading and not explaining properly what is going on here.

Regards,
Christian.


>   */
>  void
>  dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops *ops,
> @@ -1129,9 +1131,8 @@ EXPORT_SYMBOL(dma_fence_init);
>   * Context and seqno are used for easy comparison between fences, allowing
>   * to check which fence is later by simply using dma_fence_later().
>   *
> - * It is strongly discouraged to provide an external lock because this couples
> - * lock and fence life time. This is only allowed for legacy use cases when
> - * multiple fences need to be prevented from signaling out of order.
> + * New users MUST NOT use external locks. Check the documentation in
> + * dma_fence_init() to understand the motives behind the legacy use cases.
>   */
>  void
>  dma_fence_init64(struct dma_fence *fence, const struct dma_fence_ops *ops,

