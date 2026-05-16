Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7ACCD4F48
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76410E6DF;
	Mon, 18 May 2026 07:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="ZrEe2af6";
	dkim-atps=neutral
X-Greylist: delayed 46328 seconds by postgrey-1.36 at gabe;
 Sat, 16 May 2026 23:13:58 UTC
Received: from outbound.mr.icloud.com (mr-2002k-snip4-5.eps.apple.com
 [57.103.68.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F5010E168
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 23:13:58 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPS id
 1EE231800133; Sat, 16 May 2026 23:13:54 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhKBUMDRQBBCFYBWANLVxQEG1sIUhhXE1gTVl8OXQIwUBtfAkIPHBNWFRMLU1ZRGFwdQAhUClkVC0EFXXcCURxWDVdDVARfUEsbDlwES1oVVRcOAkIfUB9MFldDWhkcGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQCwoAFlpAClRVRgJEDEkeWQNYBF1YTldfGlJTFAAaCw4FXQZAXDhaDlsERxQXG1wACUtGCUkdDgRUB10FXQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1778973238; x=1781565238; bh=2B8kh88BmMcREPsTrqppXb4O6KSA0MQb13JMTQ3AyrA=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
 b=ZrEe2af6nbuQLUs+52pG0Ub0MTF8KtiuYVacoOn6dz74pLF+6/Pl4gQ/MhNLkWHOL10lbfP5CRrbRLsR2qJp6nu9drE+xzNdYKEA4omdExVP7gHB6FJB2XU0gGIOdvKGERWr592TYXSJ9SATX/SJvvBE8fsKEz0KlcpPyfPzSOCNL3pkV3pJBbDy+SLb9qgv5YYrH7SWZLLPRntrGad2Kd1VrJ3f8g6UgF98Xz3Vjm8gkluC1b9DSh1YA3/IZnApksUo+PEBkMqNDz3Ypu7BkjT9PrKIEowCFRp3/2pdUe9C5UC/Xn6s6GR2zLvJ5mS5zrL29HrzXRYeDAhP/WYkbA==
Received: from [192.168.1.34] (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-5 (Postfix) with ESMTPSA id
 B13AC1800134; Sat, 16 May 2026 23:13:51 +0000 (UTC)
Message-ID: <a2fc899b-0451-4436-a6d2-9ad9b8c2640e@icloud.com>
Date: Sun, 17 May 2026 08:13:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix typo in mpo-overview.rst
To: Jonathan Corbet <corbet@lwn.net>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260516100406.21070-1-cheesecake2960@icloud.com>
 <87se7rmont.fsf@trenco.lwn.net>
Content-Language: en-US
From: Cheesecake <cheesecake2960@icloud.com>
In-Reply-To: <87se7rmont.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDIzNyBTYWx0ZWRfX9afkiO/+L68K
 3sxyBWtZdDUI1yDvHkh0b4UTlPgwsu3RwLa8Mo3ujYiTphvnV/uUmoBYx1JP3i46lv0BV0UHJHF
 OLxJeYT3im3fTXJzdbZNyKzNv6D0tFSpdJUYqZysp3xOX4Wfb+wh02QbDzaE7TEPBX6OkkwAXKS
 fzVl02OvH/xfwgCQ7DJdhq8BCZmJgPh+DhGBaIrHoZnDVXERXTjI3RWbc9FvKFnyv0DJEJtYqAZ
 nGhVlDYV0DwdjhFJ6stHN5JDZz6vrXufPbhatQnBBl9r6PT8S0RoDOLqh4RomCamLMWx6wUiyPA
 t0KpAcfFhJ4BaypM5VZktEloHnBOHMvYP3xs3jAAuaXVic5FwnyfBj2S4TVMvQ=
X-Authority-Info-Out: v=2.4 cv=BquQAIX5 c=1 sm=1 tr=0 ts=6a08fa34
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=sIGCgqHK338A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=v3ZZPjhaAAAA:8 a=U4lEO9gh2w5_OOAwJnoA:9 a=QEXdDO2ut3YA:10 a=UzISIztuOb4A:10
 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: FockY6_NoY58eSZNn8CMSw7qhlzHuBrL
X-Proofpoint-ORIG-GUID: FockY6_NoY58eSZNn8CMSw7qhlzHuBrL
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

On 2026/05/16 23:09, Jonathan Corbet wrote:

> Cheesecake <cheesecake2960@icloud.com> writes:
>
>> Replace "transparant" with "transparent"
>>
>> Signed-off-by: Cheesecake <cheesecake2960@icloud.com>
> Patches need a proper signoff with a real name, please.
>
> Thanks,
>
> jo


Thanks for pointing that out.

I accidentally sent this patch using an anonymous address/name.
I'll resend it properly later.

Thank you for your time.

