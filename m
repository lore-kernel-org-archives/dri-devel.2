Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8089C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4AA10F44B;
	Thu,  3 Sep 2026 07:38:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OYPIO3xl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAB210F44B;
 Thu,  3 Sep 2026 07:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=FWKX/XZq+HjuvoZD0UWfiZNTUwqp4s9qGgr8xQ9J15E=; b=OYPIO3xlfIt1e+9ArGycX86jQx
 ce2w/V8mCOignsFK5YYabY36QVHMlp2WYNBahZALq5fYavFgU1vR2fzu68OtKuGumIgHe2gBfRkqC
 9ohQJCBMFEoO4+eIwfPyLr8O93oTOimr8RgzA7C0dSt7UCGd5h8YMvXQQxTp8c6DQprAfU9gchdO5
 XZu5Oczr6gLAM/IJJQNjrIPUTv74JPgf8Dp1s6kMejHbCyxku0bf9fdBwTAzWaiCDhIGDfPDA2Jod
 UH1nrC7n3GKrLXnAHx/THkCgb7BxM1LLWqpGVda5RxQfR2wNtCFieykGCa6vXK6jCAO6T2j85eJBi
 o6/J4lCw==;
Received: from [31.4.135.164] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x221Y-00EERW-U1; Thu, 03 Sep 2026 09:38:17 +0200
Message-ID: <f1e57af9-9ea7-41b1-aa25-4562865f3b39@igalia.com>
Date: Thu, 3 Sep 2026 09:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH i-g-t] Revert "lib/igt_kms: Do not treat writeback and
 virtual connectors as connected"
To: Mark Yacoub <markyacoub@google.com>, Jani Nikula <jani.nikula@intel.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.comm, simona@ffwll.ch,
 melissa.srw@gmail.com, robin.clark@oss.qualcomm.com,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 "S, Sowmiya" <sowmiya.s@intel.com>, kernel-dev@igalia.com
References: <20260828-vkms_virtual_output_fix-v1-1-789718f4cb00@igalia.com>
 <5443fa9f99309b0ec0afdd98319619a63d5467a3@intel.com>
 <CAC0gqY650NvYr5_NwKXM3sFNYQ=G7T9kx_=8GZWE7faveSZwRg@mail.gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <CAC0gqY650NvYr5_NwKXM3sFNYQ=G7T9kx_=8GZWE7faveSZwRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 31/08/2026 16:01, Mark Yacoub wrote:
> On Mon, Aug 31, 2026 at 4:51 AM Jani Nikula <jani.nikula@intel.com> wrote:
>> On Fri, 28 Aug 2026, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>>> This reverts commit 321448df7fc9af29b4c6697dc74e6c5e2100af6c.
>>>
>>> It has broken vkms testing, which has only Virtual connectors.
>>>
>>> Cc: Mark Yacoub <markyacoub@google.com>
>>> Cc: Jani Nikula <jani.nikula@intel.com>
>>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> FWIW,
>>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Mark Yacoub <markyacoub@google.com>

Applied to master.

Melissa

>> But you should solicit feedback from the author, reviewer, and committer
>> of 321448df7fc9 ("lib/igt_kms: Do not treat writeback and virtual
>> connectors as connected").
>>
>>
>>> ---
>>>   lib/igt_kms.h | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/lib/igt_kms.h b/lib/igt_kms.h
>>> index 695f666bacb9..27f8877a9f6a 100644
>>> --- a/lib/igt_kms.h
>>> +++ b/lib/igt_kms.h
>>> @@ -669,10 +669,6 @@ static inline bool igt_output_is_connected(igt_output_t *output)
>>>            !output->config.connector->count_modes)
>>>                return false;
>>>
>>> -     if (output->config.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK ||
>>> -         output->config.connector->connector_type == DRM_MODE_CONNECTOR_VIRTUAL)
>>> -             return false;
>>> -
>>>        if (output->config.connector->connection == DRM_MODE_CONNECTED)
>>>                return true;
>>>
>>>
>>> ---
>>> base-commit: c0c86b23b316bec7d22bbb95e433a8dc25884a1c
>>> change-id: 20260828-vkms_virtual_output_fix-c82298792438
>>>
>>> Best regards,
>>> --
>>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>>>
>> --
>> Jani Nikula, Intel

