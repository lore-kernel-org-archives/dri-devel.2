Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60674606A320
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h/Ss8i0w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C145E10E5C2;
	Tue, 10 Nov 2026 18:18:23 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D33B10E5C2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u631GVc1Kk6azbDbE10hZs3KfxWrnzEyBQgdUkxGy8+g10LIPS7wOVMt0RuivMdiQv5OLraSN55nhoVERt40EMy7p1jp1V2dVbdRoBvJ7Jc4WOU3AtAI4rWmhtmmlxPE21lG0caXy4TGrGfGDcVUrqrL+wIgam4g8OOW94e/iZmjagKa4vK44cvIIcs3Vhjxq8OU6kVvwr3RQQ656nDhfIcUt2df8Ehs02fclpO6wS42H4xC+a/vqs8OoYg6g1BnPaoWS0gTu62WZp7J5azCWdQhrl17xPh5PK+tnNg1+Ik6u0hxiXDCph5HuqzviwQOkOmXttWIFuIopVDicMfZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDtX+yBs0zr4mRhUjF9OhDoqAMlzOHm+DBlf/bLLV8c=;
 b=bJOH9jyea73wAO5KsIlqp5smPEFQN5ZtYgWME1vN+pbBsnDfHkJy0y9U7bZTBs6Tg5HM5jVLBoD219WWP60YWY8uOPvQljWAMCBVIBMYOAhRzoebY+DjM7NKCB63zaNWS6GK1zifjaxOfm0PpT7SCRNwW3CVttfM9KcG9F07PvRnIZ5CtVIgjFC1vEtto+dfQzqU2VQVYk6pQUmzgIwGqQewatvQVOvsoYxgdRthMOEZN4HZESZLiSwiEJQzcidYZ+rIhPMTBjEIHJytziA0nNPgXiPTqVcLtQiBk75QNoZvQ5PhaJhqV+fFXXYq7rYPJjB1BiQF3wD7WSCRzLd9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDtX+yBs0zr4mRhUjF9OhDoqAMlzOHm+DBlf/bLLV8c=;
 b=h/Ss8i0wNUBqIRgqaTo2Y4DLQ/tGbWUPynFLzZ8D1TxNAygfCak+UUt9fVay2tu7aUP9MqDW59+5Q/ap2bcj9RPmXK4hPRDjuYqIJTyrY1/ylgXFpX9+TDE9iEu/wnLmnLMd0OJVbJLLyU3uR9KLIdBiftwQzQ03grzNGpIno8Y=
Received: from CY8PR22CA0011.namprd22.prod.outlook.com (2603:10b6:930:45::19)
 by DS6PR12MB884699.namprd12.prod.outlook.com (2603:10b6:8:4c7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 18:16:14 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:930:45:cafe::27) by CY8PR22CA0011.outlook.office365.com
 (2603:10b6:930:45::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 18:16:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 18:16:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 12:16:13 -0600
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 12:16:12 -0600
Message-ID: <d835e953-a92d-1635-8210-913c4c4681c1@amd.com>
Date: Tue, 10 Nov 2026 10:16:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and
 retry helpers
Content-Language: en-US
To: Matthew Brost <matthew.brost@intel.com>
CC: "Huang, Honglei1" <Honglei1.Huang@amd.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Santan, Sonal" <sonal.santan@amd.com>,
 "ogabbay@kernel.org" <ogabbay@kernel.org>, "quic_jhugo@quicinc.com"
 <quic_jhugo@quicinc.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "karol.wachowski@linux.intel.com"
 <karol.wachowski@linux.intel.com>, "Zhen, Max" <Max.Zhen@amd.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "himal.prasad.ghimiray@intel.com" <himal.prasad.ghimiray@intel.com>
References: <20261106184217.2720718-1-lizhi.hou@amd.com>
 <CY8PR12MB71707223ED3F56E5894FF353D9732@CY8PR12MB7170.namprd12.prod.outlook.com>
 <283f184b-eefd-2402-3ed7-a08a96dce382@amd.com>
 <avJKouF5RYo8PlwF@gsse-cloud1.jf.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <avJKouF5RYo8PlwF@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS6PR12MB884699:EE_
X-MS-Office365-Filtering-Correlation-Id: 978aec73-c309-45b5-9fde-08df3f56b4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|4143699003|56012099006|22082099003|18002099003|11063799006|10067099003|261009223027099003|261009221227099003|261026140227099003|261026121527099003|261102130727099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: Guy8syNOa7czx9yrJIAxml2rqKX4GynF7MOIFuvW6AjBgOmqxUa4FBOgALMVaeB2jCCkZG0FZTedd1CwKHSR+pM7708B7f0RgwR3Qo08lyaPeJD7Hm8VDEugmbEgt1N6BLucEtIiBdnJKwl1qxW2gLXVwFdsipNduNOB3D81g4wVrtUQ5rooMU3TZF4oKOS1mjlW4l/X1sl0L0nUwACZtxsy2daw3JOFP0V68cJjcnRuU98UU5u//n7DaLmtSx1s0VgCGJl470cwCyJX3Qhx8MyBJd8yOH8zbMBrLUSE0yBax+2cTeGpIRzLg1KTuvJpxogzUqDDCxHa9MADSHe8q96eUK5opfR9xUPUMv8gPYCIOODsg7gdKm+jX3DnFH3wqY9879eRrUzZp0R581ENVYK3v8lIFFwCmNLkJsqGzu0stc5kpxjAjn3egNDjN7wzqp4WC0YWAlTzHHNaUFYQLs0ZPApt3G3cFvfsGV0Prc9XKCSsaCKXNdUx/ddMN7hHnkFIZwyCCMR5rxRhoRtOSrzIqkojZuwJK8IjDXB7SyElAdk0ESO56PLYQBTxpiOb8pCrpV7QQ8sLoqnPVH0En7KCAq2MMo9Lc376iWZDGpzWD5jLSjVx4nxy6+cDIlgkbhYF2n6ygObMcgup/qahn4BvcMlLK8eJ/14V0WBtGPLGNQrZjK0hUKoku5hzJbDnWTWGT3OawIFGS+qOzSEnRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(10067099003)(261009223027099003)(261009221227099003)(261026140227099003)(261026121527099003)(261102130727099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GTjb1mu1eWkeA2qT8rnhGGcthaRbhUUbO34Sm+OIqbrNvCy49C5YBPsVbyvvM0e722GSrauaQcX1tsPTNKgNAQmeTCcbb9Y6jTGTskmg3L7s2LhUfkIz0NDT4YmEDanIrt9uh5ZckqWoeQinJPFRHhrwLoRa2l2VriAFJSzVm1S3g3ZkChrgkDRO5k4Xq3FFFHXFhfWX0FvExVW91nfoEFiw5AEK6dJI2CxzRL/z03B4cUj//TFOjWCQZdinfSVhxbHWL8PYEKSS5jWG0SRXxdV5vE88Kqiff69BjYB4amcokCOVZLheWp1sWJjBaZlAQgugb/oE2IJNBeCBUBPvYyTSqB6Ll3oCOU8eU6jYUlTD8euVMnDce6SZlOjhvpxI9ozv+k3SugmUag3vu9/3b5x4AeUwbJcgm6W5xAiQSmtwUXCmvsLci6BV9G96U+wf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 18:16:13.9870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978aec73-c309-45b5-9fde-08df3f56b4ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB884699
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
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/9/26 14:35, Matthew Brost wrote:
> On Mon, Nov 09, 2026 at 11:53:37AM -0800, Lizhi Hou wrote:
>> Hi Matthew,
>>
>>
>> How do we converge on this?  Both 2 patches are reviewed, is it good to
>> merge them to drm-misc-next?
>>
> I also gave an RB, feel free to merge or if you need help merging, let
> me know and I can merge them.

Thanks a lot. The patch is applied to drm-misc-next.

Lizhi

>
> Matt
>
>> Honglei, Thanks a lot for reviewing the code.
>>
>>
>> Lizhi
>>
>> On 11/9/26 00:56, Huang, Honglei1 wrote:
>>> AMD General
>>>
>>> Reviewed-by: Honglei Huang <honghuan@amd.com>
>>>
>>> -----Original Message-----
>>> From: Lizhi Hou <lizhi.hou@amd.com>
>>> Sent: Saturday, November 7, 2026 2:42 AM
>>> To: ogabbay@kernel.org; quic_jhugo@quicinc.com; dri-devel@lists.freedesktop.org; Limonciello, Mario <Mario.Limonciello@amd.com>; karol.wachowski@linux.intel.com; Zhen, Max <Max.Zhen@amd.com>; thomas.hellstrom@linux.intel.com; himal.prasad.ghimiray@intel.com; Huang, Honglei1 <Honglei1.Huang@amd.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>; linux-kernel@vger.kernel.org; Santan, Sonal <sonal.santan@amd.com>; Hou, Lizhi <lizhi.hou@amd.com>
>>> Subject: [PATCH V1 1/2] drm/gpusvm: add drm_gpusvm_pages unmapped and retry helpers
>>>
>>> From: Matthew Brost <matthew.brost@intel.com>
>>>
>>> Drivers which only use the drm_gpusvm_pages API (no drm_gpusvm_range) have no way to mark pages unmapped from their MMU notifier, as
>>> drm_gpusvm_range_set_unmapped() requires a range. They also have to open code the mmu_interval_read_retry() check on the recorded notifier_seq to commit pages faulted with &drm_gpusvm_ctx.no_dma_map.
>>>
>>> Split the pages part of drm_gpusvm_range_set_unmapped() into drm_gpusvm_pages_set_unmapped(), and add drm_gpusvm_pages_read_retry() which performs the commit side check with a lockdep assert on the notifier lock.
>>>
>>> Assisted-by: LLM
>>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>>> ---
>>>    drivers/gpu/drm/drm_gpusvm.c | 49 +++++++++++++++++++++++++-----------
>>>    include/drm/drm_gpusvm.h     | 29 +++++++++++++++++++++
>>>    2 files changed, 64 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c index 03dbe304e4b8f..63a26919f59db 100644
>>> --- a/drivers/gpu/drm/drm_gpusvm.c
>>> +++ b/drivers/gpu/drm/drm_gpusvm.c
>>> @@ -1761,9 +1761,8 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
>>>     *
>>>     * With &drm_gpusvm_ctx.no_dma_map no mapping state is recorded, so
>>>     * drm_gpusvm_pages_valid() never returns true and success is only a snapshot:
>>> - * the caller must recheck mmu_interval_read_retry() against the recorded
>>> - * &drm_gpusvm_pages.notifier_seq under the notifier lock, and hold it until
>>> - * its work is visible to invalidation.
>>> + * the caller must recheck drm_gpusvm_pages_read_retry() under the
>>> + notifier
>>> + * lock, and hold it until its work is visible to invalidation.
>>>     *
>>>     * Return: 0 on success, negative error code on failure.
>>>     */
>>> @@ -2021,6 +2020,38 @@ bool drm_gpusvm_has_mapping(struct drm_gpusvm *gpusvm, unsigned long start,  }  EXPORT_SYMBOL_GPL(drm_gpusvm_has_mapping);
>>>
>>> +/**
>>> + * drm_gpusvm_pages_set_unmapped() - Mark GPU SVM pages as unmapped
>>> + * @gpusvm: Pointer to the GPU SVM structure.
>>> + * @pages: Pointer to the GPU SVM pages structure(s).
>>> + * @pages_count: Number of GPU SVM pages structure(s) passed in.
>>> + *
>>> + * Mark @pages as unmapped, after which drm_gpusvm_get_pages() fails
>>> +with
>>> + * -EFAULT for them. Intended to be called from the driver's MMU
>>> +notifier on
>>> + * MMU_NOTIFY_UNMAP, and usable without a &drm_gpusvm_range by drivers
>>> +that
>>> + * only use the drm_gpusvm_pages API. The caller must hold the notifier
>>> +lock
>>> + * in write mode.
>>> + */
>>> +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
>>> +                                  struct drm_gpusvm_pages *pages,
>>> +                                  unsigned int pages_count)
>>> +{
>>> +       unsigned int i;
>>> +
>>> +       lockdep_assert_held_write(&gpusvm->notifier_lock);
>>> +
>>> +       for (i = 0; i < pages_count; ++i) {
>>> +               struct drm_gpusvm_pages_flags flags = {
>>> +                       .__flags = pages[i].flags.__flags,
>>> +               };
>>> +
>>> +               flags.unmapped = true;
>>> +               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>>> +               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
>>> +       }
>>> +}
>>> +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_set_unmapped);
>>> +
>>>    /**
>>>     * drm_gpusvm_range_set_unmapped() - Mark a GPU SVM range as unmapped
>>>     * @range: Pointer to the GPU SVM range structure.
>>> @@ -2039,20 +2070,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>>>           struct drm_gpusvm_range_flags range_flags = {
>>>                   .__flags = range->flags.__flags,
>>>           };
>>> -       unsigned int i;
>>>
>>> -       lockdep_assert_held_write(&range->gpusvm->notifier_lock);
>>> +       drm_gpusvm_pages_set_unmapped(range->gpusvm, pages, pages_count);
>>>
>>>           range_flags.unmapped = true;
>>> -       for (i = 0; i < pages_count; ++i) {
>>> -               struct drm_gpusvm_pages_flags flags = {
>>> -                       .__flags = pages[i].flags.__flags,
>>> -               };
>>> -
>>> -               flags.unmapped = true;
>>> -               /* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
>>> -               WRITE_ONCE(pages[i].flags.__flags, flags.__flags);
>>> -       }
>>>           if (drm_gpusvm_range_start(range) < mmu_range->start ||
>>>               drm_gpusvm_range_end(range) > mmu_range->end)
>>>                   range_flags.partial_unmap = true;
>>> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h index 4d31c6bba7455..b43432af56377 100644
>>> --- a/include/drm/drm_gpusvm.h
>>> +++ b/include/drm/drm_gpusvm.h
>>> @@ -349,6 +349,10 @@ void drm_gpusvm_range_set_unmapped(struct drm_gpusvm_range *range,
>>>                                      unsigned int pages_count,
>>>                                      const struct mmu_notifier_range *mmu_range);
>>>
>>> +void drm_gpusvm_pages_set_unmapped(struct drm_gpusvm *gpusvm,
>>> +                                  struct drm_gpusvm_pages *pages,
>>> +                                  unsigned int pages_count);
>>> +
>>>    int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
>>>                            struct drm_gpusvm_pages *svm_pages,
>>>                            unsigned int num_pages,
>>> @@ -383,6 +387,31 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
>>>           svm_pages->notifier_seq = LONG_MAX;
>>>    }
>>>
>>> +/**
>>> + * drm_gpusvm_pages_read_retry() - Check whether GPU SVM pages went
>>> +stale
>>> + * @gpusvm: Pointer to the GPU SVM structure.
>>> + * @svm_pages: Pointer to the drm_gpusvm_pages.
>>> + * @notifier: The notifier passed to drm_gpusvm_get_pages() for @svm_pages.
>>> + *
>>> + * Check whether @notifier was invalidated since the last successful
>>> + * drm_gpusvm_get_pages() for @svm_pages. This is the commit side check
>>> +for
>>> + * pages faulted with &drm_gpusvm_ctx.no_dma_map, where no mapping
>>> +state is
>>> + * tracked. Pages that were never faulted always report as stale. The
>>> +caller
>>> + * must hold the notifier lock and keep holding it until its use of the
>>> +pages
>>> + * is visible to the invalidation path.
>>> + *
>>> + * Return: True if the pages must be faulted again, false otherwise.
>>> + */
>>> +static inline bool
>>> +drm_gpusvm_pages_read_retry(struct drm_gpusvm *gpusvm,
>>> +                           struct drm_gpusvm_pages *svm_pages,
>>> +                           struct mmu_interval_notifier *notifier) {
>>> +       lockdep_assert_held(&gpusvm->notifier_lock);
>>> +
>>> +       return mmu_interval_read_retry(notifier, svm_pages->notifier_seq); }
>>> +
>>>    /**
>>>     * drm_gpusvm_pages_first_dma() - Resolve the device address array
>>>     * @svm_pages: Pointer to the drm_gpusvm_pages.
>>>
>>> base-commit: d2a8cee91bfa8616f713c7c8f539a81e8e3554ea
>>> --
>>> 2.34.1
>>>
