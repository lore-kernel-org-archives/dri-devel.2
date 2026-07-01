Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DFBC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F2210EFF0;
	Wed,  1 Jul 2026 20:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EXBCJmcb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B7C10EFF0
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:09:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A4004011B;
 Wed,  1 Jul 2026 20:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC83F1F000E9;
 Wed,  1 Jul 2026 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782936541;
 bh=96jvHTeDCxR7+XirD0BwNbewxZDFsoQe83dAJZ5Y+5s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=EXBCJmcbAvYPFqFcBHQO2r6ZqZwgwUddvkI9gPT7NLVOsImpXL3HDd6PrstGD6Lq6
 cfeIDkj7dEFVZZULAW1dTbFQgzx4rZ6/4XVBr2FGMh/+FXIJJK5eGDawPCpu9s4Igq
 xs/iIq1X3Kr0xmjXsu0VyJTzyoMYM82kK8fG3PEZY+u5s9depmm8O3qbqysSt+ocJJ
 TTqq456rc5j7FcKAE/rky5u4fYHgdJxR8KfO0YiJFiqoOufCKaqvfwNyku7A9KJyVu
 /JxdFoi85x2DKjjGOO4Az4XTjjI36aglvg+YymUKsPxDtSMaNdhSvAByUIAGf+fRON
 Gu9WbdAhClKXA==
Message-ID: <a176e929-9e2b-4123-ad86-0aec712c3cb1@kernel.org>
Date: Wed, 1 Jul 2026 21:08:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
 <c1984f80-f8a8-4ee2-a087-c49ad3ad1e39@oss.qualcomm.com>
 <CAMuQ4bXSG5piN9nwLoTcAOCRoZppmJegcPwghikdbQWGuGS+sg@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <CAMuQ4bXSG5piN9nwLoTcAOCRoZppmJegcPwghikdbQWGuGS+sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/25/26 10:07 AM, Yousef Alhouseen wrote:
> Hi Konrad,
> 
> You're right. These touch related FastRPC lifetime and bounds paths,
> and several of them depend on the same state cleanup. I grouped the
> follow-up fixes I still think are valid into a small series, and I'll
> keep any further FastRPC changes batched instead of sending more
> standalone threads.

I also like to understand how are these patches tested?

--srini
> 
> Thanks,
> Yousef
> 
> On Thu, 25 Jun 2026 09:40:53 +0200, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 6/24/26 9:27 PM, Yousef Alhouseen wrote:
>>> fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
>>> is removed, but it does not release the send references taken before each
>>> request was submitted. Those references normally disappear only when a DSP
>>> reply arrives, which cannot be relied on after endpoint removal.
>>>
>>> Walk the channel IDR during removal, mark in-flight contexts completed,
>>> and schedule the send-reference put while waking waiters with -EPIPE. This
>>> prevents disconnected channels from pinning invoke contexts indefinitely.
>>>
>>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>>> ---
>>
>> You sent ~10 patches to fastrpc as separate threads, do they have
>> any sort of co-dependence? Can they be applied in random order?
>>
>> Generally if your changes are even vaguely related, it's best to
>> send them in a single series, if only to reduce the possibility of
>> a merge conflict
>>
>> Konrad

