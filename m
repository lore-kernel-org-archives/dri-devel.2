Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1D1C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD39010F484;
	Fri, 17 Jul 2026 07:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="QxOUUq/Z";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80D810F484
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784274504; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WmbB+wn6+iq1PAlGVaE1TjF8Y2M6bTEqe8Q0k5VIYZmyYtkblDGUujbXiTEhTOE0vee8X/x1mD3vqt5SP7pI0vfzUfMYAZmGbr6jj+B6/cxnlpzEJMWEoi3yNamo4d4I8A/WkXlpgTIK1XvnbhsowYlnIvONLOIreZiCJmKdphw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784274504;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=cZCinZD4wEZnLA8yVTrAOn3wo/J/ilaJSO/LGmu+AmA=; 
 b=hlPJJ0WgfqoXBMBkIkAinFz44eErkEdwJNeKuRBlOfc4eOwXPsOwZ/TCHKeraCXdFMLqVkawpMLxmA+/HQq32UuXsmMJi3wmNYAXq5+ZfRlRivOTTv+nnyWXFomZ3uHAlif1YlNAk2dkzc16zY0JIIRxjR9x8LpdU+60mr7qzWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784274503; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=cZCinZD4wEZnLA8yVTrAOn3wo/J/ilaJSO/LGmu+AmA=;
 b=QxOUUq/ZMULytVCdHl89yiWRIYvY8SShFPgmFZHekATyCE/Z94h7psUpSLW/3FL4
 9zAxFE2FYHrMta9kBzHE5FoW+KOJRDDKGIEA1ARNiYY5x8fldMaNv+u+h5e2/vdm7YE
 TKjL+v8ILD4D6z2gv6Cli8N1J3TMAr3JThd6631A=
Received: by mx.zohomail.com with SMTPS id 1784274501092396.79758539637373;
 Fri, 17 Jul 2026 00:48:21 -0700 (PDT)
Message-ID: <4324bbb1-3ab0-4a7d-b1f9-b9edf481a8cb@collabora.com>
Date: Fri, 17 Jul 2026 09:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20260627105725.9083-1-robert.mader@collabora.com>
 <CABXGCsPHdi3=Tpg2uZhZMuLNmg8r9Bg=OgD39eyMc=pv8gc_TQ@mail.gmail.com>
 <bc41095d-8956-4c3e-8f99-f4bda41f81e7@collabora.com>
 <CABXGCsNYEhkprpTh9Pd8Y46520fwNJngS_Bg_QJCQPCf3_qv0g@mail.gmail.com>
 <0a444d8c-6107-4577-bed3-0039333a5244@collabora.com>
 <9fa5e38c-0200-4724-b5db-739ea67c1181@collabora.com>
 <IA0PR11MB71853CC1CC0D0C778DAC154BF8F02@IA0PR11MB7185.namprd11.prod.outlook.com>
 <c5d207ea-6995-4cac-9286-b02e067384a0@collabora.com>
 <IA0PR11MB7185115DA785B3B51C521275F8F92@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <IA0PR11MB7185115DA785B3B51C521275F8F92@IA0PR11MB7185.namprd11.prod.outlook.com>
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

Hi Vivek,

On 14.07.26 08:33, Kasireddy, Vivek wrote:
>> Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache
>> synchronisation in begin_cpu_udmabuf()
>>
>> Hi,
>>
>> On 07.07.26 08:16, Kasireddy, Vivek wrote:
>>>> Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache
>>>> synchronisation in begin_cpu_udmabuf()
>>>>
>>>> Hi, sorry for the noise - adding more udmabuf maintainers in case
>> Vivek
>>>> doesn't have time to look into it atm, just to ensure people are
>> aware.
>>>> Gerd, Sumit, Christian: this is a simple fix for a minor regression in
>>>> the upcoming 7.2 release - it would therefor be great if anyone could
>>>> pick it to the fixes branch :)
>>> Hi Robert,
>>>
>>> Your patch LGTM. If no one else picks it up soon, I'll push it to drm-
>> misc-fixes in the
>>> next few days.
>> gentle ping ;) Would be great if this could go into this weeks fixes push.
> Hi Robert,
>
> I pushed your patch to drm-misc-fixes last week, so it should be able to make
> it to this week's fixes.
oh, I totally missed that, sorry. And I see it's now queued for upstream 
- thanks!
>
> Thanks,
> Vivek
>
>> Thanks and best regards,
>>
>> Robert
>>
>>> Thanks,
>>> Vivek
>>>
>>>> Thanks and best regards,
>>>>
>>>> Robert
>>>>
>>>> On 29.06.26 13:58, Robert Mader wrote:
>>>>> On 29.06.26 13:48, Mikhail Gavrilov wrote:
>>>>>> On Mon, Jun 29, 2026 at 3:57 PM Robert Mader
>>>>>> <robert.mader@collabora.com> wrote:
>>>>>>> Hi Mikhail,
>>>>>>>
>>>>>>> thanks for the quick review! And no worries, I was very happy
>> about
>>>>>>> your
>>>>>>> patch, which is why I looked deeper into it in the first place.
>>>>>>>
>>>>>>> Given the patch fixes a newly introduced regression (and is very
>>>>>>> simple), do you think there's a chance to still get it into 7.1 - or
>>>>>>> would it need to go via the usual 7.2/7.3 release schedule +
>>>> backport?
>>>>>> Hi Robert,
>>>>>>
>>>>>> The timing depends on Vivek and the drm-misc maintainers, not
>> me,
>>>>>> but here's the situation as I understand it:
>>>>>>
>>>>>> The original commit 504e2b4ab97a only landed in 7.2 (it went into
>>>>>> drm-misc-next, not drm-misc-fixes). So 7.1 was never affected by
>>>>>> the regression -- there's nothing to fix there.
>>>>>>
>>>>>> For 7.2: since your patch fixes a regression introduced in the same
>>>>>> cycle, it would ideally go through drm-misc-fixes to land in 7.2
>>>>>> before release, avoiding a broken commit in the final tree. That's
>>>>>> the cleanest outcome.
>>>>>>
>>>>>> Adding Vivek -- he pushed the original patch and would know
>>>> whether
>>>>>> drm-misc-fixes is the right route at this point in the cycle.
>>>>> Hi Mikhail, I of course meant 7.2, not 7.1, sorry! And agreed, that
>>>>> would be ideal / perfect.
>>>>>
>>>> --
>>>> Robert Mader
>>>> Consultant Software Developer
>>>>
>>>> Collabora Ltd.
>>>> Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
>>>> Registered in England & Wales, no. 5513718

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

