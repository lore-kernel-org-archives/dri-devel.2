Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A56EF4EA4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 07:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29BD10E1DA;
	Mon,  6 Apr 2026 07:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=vignesh.raman@collabora.com header.b="QRfZQAzM";
	dkim-atps=neutral
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Mon, 06 Apr 2026 07:01:36 UTC
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9323D10E1DA
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 07:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775457987; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QTgpR5iSPn3DYqPPOKdG14snv5bcj0/VBtAmRD8h8lzWYOnJ0n3VCa2N0+Icrxm5dvwjcwp8FAW+yVid76AJAqm0kS3e2CmsfJherhm7ZhoElgFJ84HrWp4eJyhobPk8nvR7UOXpgQ6+WcndZv3wKN+EaOBvv4Dwqf6DmgkQlhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775457987;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FhNkycVgqMimgV7KYxi7Bteo9mriPh+8EGPCFUAsORs=; 
 b=CGdXywzsIbx3CMyXspmHvuEP/Fvfu8asM4p2SwcVn9c7JoBjQfKyhfb7NFm1OkXFQ3FN71XLefAabogBBqONheSzLmxNjbjlJ3o/BqIkw5FVDH6QV6ytDSKQhFiHmYoyGcjiGMsoGB0jJl4L9t5kh6s6VjjynyH7yNkKP5uXtTI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=vignesh.raman@collabora.com;
 dmarc=pass header.from=<vignesh.raman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775457987; 
 s=zohomail; d=collabora.com; i=vignesh.raman@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=FhNkycVgqMimgV7KYxi7Bteo9mriPh+8EGPCFUAsORs=;
 b=QRfZQAzMUCoUO7WjAJ9wJKIXa/kAXrCdccjlAWP/AbLM8nNqNJ7WwPUxNBxIXXSq
 +twUBiJWj53waw+1ozt/DUrkwcH6M6XZHFa6m+ZeSyoKZmqrnrq179LEziqDVy5m5wA
 BkBlFQYvTWxJGUKRaewkRzW28wbfg51vjuEhAhD4=
Received: by mx.zohomail.com with SMTPS id 1775457983869546.1265288708523;
 Sun, 5 Apr 2026 23:46:23 -0700 (PDT)
Message-ID: <db70ec3b-736f-478c-917c-f8a56726c13e@collabora.com>
Date: Mon, 6 Apr 2026 12:16:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vignesh Raman <vignesh.raman@collabora.com>
Subject: Re: [PATCH 1/1] drm/ci: bump IGT version to v2.3
To: jim.cromie@gmail.com
Cc: linux-kernel@vger.kernel.org, helen.fornazier@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
References: <20260319161159.1149822-1-jim.cromie@gmail.com>
 <dfa88f76-02d9-46a3-8bd8-bba0f14defa6@collabora.com>
 <CAJfuBxyu2K0THVAyS9i18LoTD3sR8TB_j-3Op3cxr+G_=xsKiQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJfuBxyu2K0THVAyS9i18LoTD3sR8TB_j-3Op3cxr+G_=xsKiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

Hi Jim,

On 04/04/26 18:38, jim.cromie@gmail.com wrote:
> On Tue, Mar 31, 2026 at 11:45 PM Vignesh Raman
> <vignesh.raman@collabora.com> wrote:
>>
>> Hi Jim,
>>
>> On 19/03/26 21:41, Jim Cromie wrote:
>>> IGT_VERSION is currently pinned to a sha thats ~1100 behind HEAD
>>>
>>> Lets bump it to the latest milestone/tag at v2.3
>>> Thats now only ~630 behind.
>>> Can we haz a v2.4 ?
>>>
>>> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>>> ---
>>>    drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
>>> index 56638814bb28..d546bd123a63 100644
>>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>>> @@ -5,7 +5,7 @@ variables:
>>>      UPSTREAM_REPO: https://gitlab.freedesktop.org/drm/kernel.git
>>>      TARGET_BRANCH: drm-next
>>>
>>> -  IGT_VERSION: 129d5b10baaadea1d6cd6377341c4cb42e7ee6fd
>>> +  IGT_VERSION: v2.3
>>
>> Thanks for the patch. We also need to update the expectation files along
>> with this igt uprev. Are you planning to do it?
>>
> 
> I dont know what that means / entails,
> So, it's best I don't.
> When you do it, I'll then know how (if you cc me ;-)

When mesa or IGT version is updated in drm-ci, we need to update the 
fails/flakes files in the xfails folder, as the new uprev can introduce 
new failures or make some tests pass.

Example 
https://gitlab.freedesktop.org/drm/msm/-/merge_requests/213/diffs?commit_id=af95dfd73f307ce1bf4ba40826aabca3b60ceb84

I will pick up your patch and run some tests, and update you. Thanks.

Regards,
Vignesh

> 
> 
> 
>> Regards,
>> Vignesh
>>
>>>
>>>      DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/mesa/deqp-runner.git
>>>      DEQP_RUNNER_GIT_TAG: v0.20.0
>>

